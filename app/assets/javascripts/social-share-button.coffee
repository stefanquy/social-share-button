window.SocialShareButton =
  openUrl : (url,popup, w, h) ->
    left = screen.width / 2 - (w / 2)
    top = screen.height / 2 - (h / 2)
    if popup == "true"
      window.open(url,'popup','height='+h+',width='+w+', top='+top+', left='+left)
    else
      window.open(url)
      false

  share : (el) ->
    site = $(el).data('site')
    appkey = $(el).data('appkey') || ''
    $parent = $(el).parent()
    title = encodeURIComponent($(el).data(site + '-title') || $parent.data('title') || '')
    img = encodeURIComponent($parent.data("img") || '')
    url = encodeURIComponent($parent.data("url") || '')
    via = encodeURIComponent($parent.data("via") || '')
    desc = encodeURIComponent($parent.data("desc") || ' ')
    popup = encodeURIComponent($parent.data("popup") || 'false')
    width = encodeURIComponent($parent.data("width") || '500')
    height = encodeURIComponent($parent.data("height") || '400')

    if url.length == 0
      url = encodeURIComponent(location.href)
    switch site
      when "email"
        location.href = "mailto:?to=&subject=#{title}&body=#{url}"
      when "weibo"
        SocialShareButton.openUrl("http://service.weibo.com/share/share.php?url=#{url}&type=3&pic=#{img}&title=#{title}&appkey=#{appkey}",popup, width, height)
      when "twitter"
        via_str = ''
        via_str = "&via=#{via}" if via.length > 0
        SocialShareButton.openUrl("https://twitter.com/intent/tweet?url=#{url}&text=#{title}#{via_str}",popup, width, height)
      when "douban"
        SocialShareButton.openUrl("http://shuo.douban.com/!service/share?href=#{url}&name=#{title}&image=#{img}&sel=#{desc}",popup, width, height)
      when "facebook"
        SocialShareButton.openUrl("http://www.facebook.com/sharer.php?u=#{url}",popup, width, height)
      when "qq"
        SocialShareButton.openUrl("http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=#{url}&title=#{title}&pics=#{img}&summary=#{desc}&site=#{appkey}", popup, width, height)
      when "tqq"
        SocialShareButton.openUrl("http://share.v.t.qq.com/index.php?c=share&a=index&url=#{url}&title=#{title}&pic=#{img}&appkey=#{appkey}", popup, width, height)
      when "baidu"
        SocialShareButton.openUrl("http://hi.baidu.com/pub/show/share?url=#{url}&title=#{title}&content=#{desc}", popup, width, height)
      when "kaixin001"
        SocialShareButton.openUrl("http://www.kaixin001.com/rest/records.php?url=#{url}&content=#{title}&style=11&pic=#{img}&aid=#{appkey}", popup, width, height)
      when "renren"
        SocialShareButton.openUrl("http://widget.renren.com/dialog/share?resourceUrl=#{url}&srcUrl=#{url}&title=#{title}&pic=#{img}&description=#{desc}", popup, width, height)
      when "google_plus"
        SocialShareButton.openUrl("https://plus.google.com/share?url=#{url}", popup, width, height)
      when "google_bookmark"
        SocialShareButton.openUrl("https://www.google.com/bookmarks/mark?op=edit&output=popup&bkmk=#{url}&title=#{title}", popup, width, height)
      when "delicious"
        SocialShareButton.openUrl("http://www.delicious.com/save?url=#{url}&title=#{title}&jump=yes&pic=#{img}", popup, width, height)
      when "plurk"
        SocialShareButton.openUrl("http://www.plurk.com/?status=#{title}: #{url}&qualifier=shares", popup, width, height)
      when "pinterest"
        SocialShareButton.openUrl("http://www.pinterest.com/pin/create/button/?url=#{url}&media=#{img}&description=#{title}", popup, width, height)
      when "tumblr"
        get_tumblr_extra = (param) ->
          cutom_data = $(el).attr("data-#{param}")
          encodeURIComponent(cutom_data) if cutom_data

        tumblr_params = ->
          path = get_tumblr_extra('type') || 'link'

          params = switch path
            when 'text'
              title = get_tumblr_extra('title') || title
              "title=#{title}"
            when 'photo'
              title = get_tumblr_extra('caption') || title
              source = get_tumblr_extra('source') || img
              "caption=#{title}&source=#{source}"
            when 'quote'
              quote = get_tumblr_extra('quote') || title
              source = get_tumblr_extra('source') || ''
              "quote=#{quote}&source=#{source}"
            else # actually, it's a link clause
              title = get_tumblr_extra('title') || title
              url = get_tumblr_extra('url') || url
              "name=#{title}&url=#{url}"


          "/#{path}?#{params}"

        SocialShareButton.openUrl("http://www.tumblr.com/share#{tumblr_params()}", popup, width, height)
    false
