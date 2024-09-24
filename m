Return-Path: <linux-kernel+bounces-337032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF2D98446A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF54B26D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8691A4F20;
	Tue, 24 Sep 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QwxpHtL8"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234619B3F3
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176873; cv=none; b=CUTsjJ6vYrReOIm/dCA7FkjOwHNEKkzcTM7nm3S7bRmyME72sWqBEd8mtRi2tMUea7MKtgIzpLWqDyewPsL4snxqWEyLCo9jLp21LXUK4D4VRNkdDAdAEmjTDaCC1XJrJP5sGB898t06nnwY+NOwWPnl1z26W66mgVziz7VOv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176873; c=relaxed/simple;
	bh=x3nzE69kooUvru/SVRffVta3usJvojT0d9lA+v0KX1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNBWcms63t2RWuyh+sSDSeSitchn0OpJtVJb25cqbsxwP0CsCpOReqB08c/9uqIpE8Rh9yOzjZmxLpt6XSlVu4lbCsILezGMVbiFWL5MWiOZIOSlvYsK4u6CQoyMV5J4SQv+bLiP42AXpjy0IUqN3dBy6+agaDjfuHdX1750y3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=QwxpHtL8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso7039761a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1727176870; x=1727781670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYQ/IDmT9gcN7gYfq5hChxVJK5hUzJ0xEOoEvIgK6x0=;
        b=QwxpHtL811lD/byP31JUvE8NX5L8iK5hHodqWMETaHnUvCdUNpagfCnzYUI0YuLmsH
         sARNiacptXn+oucPXGGyH4Lx1X3SBsne4MDfC+gE/X+9jenkswNqYYloM/c3IQg7wXrn
         oWnRiDEYbQiiuP9mpmh8IoWqov+wtoi/QGCus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176870; x=1727781670;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYQ/IDmT9gcN7gYfq5hChxVJK5hUzJ0xEOoEvIgK6x0=;
        b=L1Ji4w3JsUp/LE0R2HOMi5X1RXtLySv61bzKvACKr6LaxqOTqJ7KAC/LTAJwA6eoTg
         bABy91YzhZ/jkcLUPZSQpxbP7cWI6PeQAwWe2w/BzPPU9QwiEFORCjE671j/1dyhVzU1
         qY1X9RTeRIJLxWO/pBDIb1vazs3wO6TipUmKkMFIbxyF7Ru4HxP2Z4gAAiOlvu11xBij
         pY6Jlh4FSY2qPkLuqZwEPPDMQKav/aRga0nohZfghuuDBpB4mD6wjkeGDt+HWFTZXOEu
         E08F+rpzserZJIYrSC2TYI0dIVD1aX8ihGHTvPXqJoJfJO/fRhUKTeLTaa9ODOxGQhOW
         SDvg==
X-Forwarded-Encrypted: i=1; AJvYcCWbq1S6H+OE75ZtmSOsYu5q/LI/zwZl4R+NOF/WngoLdb4f0B4TGVJ6zUPgEGShUtbyNhewUHnkGtq4ZFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb55MyKNge3xbLMbOBxRpnw3ibgMpiLtLcoCZGihsXVHHJ4jeF
	Tk4w3ssQBHgIKyQFinfkqEmfR4qjI7qxukx6wvZuvtEDtVU49V8cZ7VMvFyZ7Yo=
X-Google-Smtp-Source: AGHT+IG+0CZhC8lhSSWIeyvYwrLQI4O0OQvh1Pjvq9SkGlKqyG/ISsZIxeuv8w2ijkNznz0YfWr6pw==
X-Received: by 2002:a17:906:794c:b0:a86:7199:af37 with SMTP id a640c23a62f3a-a90d51601d9mr1727612666b.58.1727176869474;
        Tue, 24 Sep 2024 04:21:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f7b90sm72287366b.175.2024.09.24.04.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 04:21:09 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:21:07 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: linux@treblig.org
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	hdegoede@redhat.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: Remove notifier
Message-ID: <ZvKgo8RUImafDRPE@phenom.ffwll.local>
Mail-Followup-To: linux@treblig.org, lee@kernel.org,
	daniel.thompson@linaro.org, jingoohan1@gmail.com,
	hdegoede@redhat.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919232758.639925-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919232758.639925-1-linux@treblig.org>
X-Operating-System: Linux phenom 6.10.6-amd64 

On Fri, Sep 20, 2024 at 12:27:58AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> backlight_register_notifier and backlight_unregister_notifier have
> been unused since
>   commit 6cb634d0dc85 ("ACPI: video: Remove code to unregister acpi_video
> backlight when a native backlight registers")
> 
> With those not being called, it means that the backlight_notifier
> list is always empty.
> 
> Remove the functions, the list itself and the enum used in the
> notifications.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

I think Lee Jones or Daniel Thompson will pick this up.
-Sima

> ---
>  drivers/video/backlight/backlight.c | 42 -----------------------------
>  include/linux/backlight.h           | 20 --------------
>  2 files changed, 62 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index a82934694d05..f699e5827ccb 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -65,7 +65,6 @@
>  
>  static struct list_head backlight_dev_list;
>  static struct mutex backlight_dev_list_mutex;
> -static struct blocking_notifier_head backlight_notifier;
>  
>  static const char *const backlight_types[] = {
>  	[BACKLIGHT_RAW] = "raw",
> @@ -467,9 +466,6 @@ struct backlight_device *backlight_device_register(const char *name,
>  	list_add(&new_bd->entry, &backlight_dev_list);
>  	mutex_unlock(&backlight_dev_list_mutex);
>  
> -	blocking_notifier_call_chain(&backlight_notifier,
> -				     BACKLIGHT_REGISTERED, new_bd);
> -
>  	return new_bd;
>  }
>  EXPORT_SYMBOL(backlight_device_register);
> @@ -539,9 +535,6 @@ void backlight_device_unregister(struct backlight_device *bd)
>  	mutex_unlock(&pmac_backlight_mutex);
>  #endif
>  
> -	blocking_notifier_call_chain(&backlight_notifier,
> -				     BACKLIGHT_UNREGISTERED, bd);
> -
>  	mutex_lock(&bd->ops_lock);
>  	bd->ops = NULL;
>  	mutex_unlock(&bd->ops_lock);
> @@ -566,40 +559,6 @@ static int devm_backlight_device_match(struct device *dev, void *res,
>  	return *r == data;
>  }
>  
> -/**
> - * backlight_register_notifier - get notified of backlight (un)registration
> - * @nb: notifier block with the notifier to call on backlight (un)registration
> - *
> - * Register a notifier to get notified when backlight devices get registered
> - * or unregistered.
> - *
> - * RETURNS:
> - *
> - * 0 on success, otherwise a negative error code
> - */
> -int backlight_register_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_register(&backlight_notifier, nb);
> -}
> -EXPORT_SYMBOL(backlight_register_notifier);
> -
> -/**
> - * backlight_unregister_notifier - unregister a backlight notifier
> - * @nb: notifier block to unregister
> - *
> - * Register a notifier to get notified when backlight devices get registered
> - * or unregistered.
> - *
> - * RETURNS:
> - *
> - * 0 on success, otherwise a negative error code
> - */
> -int backlight_unregister_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_unregister(&backlight_notifier, nb);
> -}
> -EXPORT_SYMBOL(backlight_unregister_notifier);
> -
>  /**
>   * devm_backlight_device_register - register a new backlight device
>   * @dev: the device to register
> @@ -767,7 +726,6 @@ static int __init backlight_class_init(void)
>  
>  	INIT_LIST_HEAD(&backlight_dev_list);
>  	mutex_init(&backlight_dev_list_mutex);
> -	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
>  
>  	return 0;
>  }
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index ea9c1bc8148e..f5652e5a9060 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -66,24 +66,6 @@ enum backlight_type {
>  	BACKLIGHT_TYPE_MAX,
>  };
>  
> -/**
> - * enum backlight_notification - the type of notification
> - *
> - * The notifications that is used for notification sent to the receiver
> - * that registered notifications using backlight_register_notifier().
> - */
> -enum backlight_notification {
> -	/**
> -	 * @BACKLIGHT_REGISTERED: The backlight device is registered.
> -	 */
> -	BACKLIGHT_REGISTERED,
> -
> -	/**
> -	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
> -	 */
> -	BACKLIGHT_UNREGISTERED,
> -};
> -
>  /** enum backlight_scale - the type of scale used for brightness values
>   *
>   * The type of scale used for brightness values.
> @@ -421,8 +403,6 @@ void devm_backlight_device_unregister(struct device *dev,
>  				      struct backlight_device *bd);
>  void backlight_force_update(struct backlight_device *bd,
>  			    enum backlight_update_reason reason);
> -int backlight_register_notifier(struct notifier_block *nb);
> -int backlight_unregister_notifier(struct notifier_block *nb);
>  struct backlight_device *backlight_device_get_by_name(const char *name);
>  struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
>  int backlight_device_set_brightness(struct backlight_device *bd,
> -- 
> 2.46.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

