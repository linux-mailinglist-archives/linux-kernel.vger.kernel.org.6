Return-Path: <linux-kernel+bounces-224726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16299912650
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C56B5B27EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721F515357A;
	Fri, 21 Jun 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iY6UoLCU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EB1534E8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974623; cv=none; b=oUW9WnDis8qAw90hCdQpm6H6GPj2nktPaCrQvz8pLoGROxPTvXaIUWCJNFcvkOL3ODpmfmfPgNlxELOxJu3F62IeMWzsdZXOxAXk+cxBb4PssOjmGqFQ9hH4lpz3LrJZEyDcRw6sX/eQDI15NC0vay96UUWnRdoRSxSGjxafGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974623; c=relaxed/simple;
	bh=w3HgwLqKD5JrCFCdvS+8QJCmSSn43HNUy3SCdoQM5jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/55OjoLvz44cZs2UyCRwXS3kgUp5fN8QvDlPzi3o0BXGHrxQzGLe70nKm26TgJY+LGZJE4Y7cd7NmGdaDSK6JjuZeWcLe3TSDK/eBNZQWtbX+DDpxlZjPA5uOIF+zshxb9CkkVjycf/fQfcUPW2SjFabCax70ZelPJ9kDK8gIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iY6UoLCU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718974620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8C5E3X6BacOMr3XOYKy8vIdVHxUEl+gW886qtND8CI8=;
	b=iY6UoLCU8xG52n2vP9vPciBFBDHDlKwJ8E2g3MoLUoLEHWPGdTgYKJyAimwRjCgHT27ggg
	tzk6w1mmVbeN9TwMhy+KvlshfC53mAkzSxoi68uLzcvPhmGm2Ix8BRRXv7F8cRwxxdURiz
	6fodSEyAmxvffOzZehsp+vX+5mBz/DA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-SO29TTcYMnCqmUxXrp2cdw-1; Fri, 21 Jun 2024 08:56:59 -0400
X-MC-Unique: SO29TTcYMnCqmUxXrp2cdw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52cd9f93fd8so368027e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718974618; x=1719579418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8C5E3X6BacOMr3XOYKy8vIdVHxUEl+gW886qtND8CI8=;
        b=t8GhNbA+XVtA8RSIGCqJUe66ih2QyVESJAejURNEzZvZ3HtWB+7tXPycaiXIaDgxUR
         rCWlx7L10Jk+GTtA0/4+swLmxbVbLnwt5AWiyajEUyvPipjLQgTuuF/ZGQf3J+rTp1+L
         HuHjHucLZaelmf/vtuPeYfaiQOFlr9NsoWMqmkyfhTrKhkEK2NH+6FAxLsb38yw7VSYJ
         WZeENsT5iiN/5VBmtXkcPS/Io2tf46bSPKllKbRiM4v4wLmc4mEYIdr8/7raBXSu6SUD
         slC847Xx8lJAkHyZGRu7m80nRdUUNzf9+Pt1a0m9Nh3PUiqy+Q8eW7nFtfp3XFExtJRR
         D6pw==
X-Forwarded-Encrypted: i=1; AJvYcCUAqoq70wYw5m1DgDXmmio2mzb2soSY9XiwruD3inLp4YU7C2MWQ5hWHaQeUPnpizsknEQ/xzU4e8Few/JYGDvngVN5EBPPIHqxzCU5
X-Gm-Message-State: AOJu0Ywnhk73+Vsk238EmP4A4lOipqFpQBk6bK+QZNJpFFsGXFCCuhOW
	HvOR6WoZl7XHFgByWNeAStrJLsS5R2HvOdiuPaZn9868dRqKlDaEp6OKSyov4Mgj31Wl6An0ZeR
	wev1RwB4bm51HNqcVkpn+/tlnNqonTgKDl8l2zDUDvNhMMti47Vpo/aOwTKKg5w==
X-Received: by 2002:ac2:5551:0:b0:52c:84a2:d848 with SMTP id 2adb3069b0e04-52ccaa5a162mr5085233e87.65.1718974617682;
        Fri, 21 Jun 2024 05:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaZZ5m4XfildOiandGjXNyWriLDWS+4f34iak4wkF6iHNKIis11n6ToJUSnX9tMq68jaNWDQ==
X-Received: by 2002:ac2:5551:0:b0:52c:84a2:d848 with SMTP id 2adb3069b0e04-52ccaa5a162mr5085220e87.65.1718974617260;
        Fri, 21 Jun 2024 05:56:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f672fsm1702871f8f.7.2024.06.21.05.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 05:56:56 -0700 (PDT)
Message-ID: <24205cdf-a3c6-475e-ba8a-a52d039a402d@redhat.com>
Date: Fri, 21 Jun 2024 14:56:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ssd130x: Add drm_panic support
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
References: <20240620222222.155933-1-javierm@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240620222222.155933-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/06/2024 00:22, Javier Martinez Canillas wrote:
> Add support for the drm_panic infrastructure, which allows to display
> a user friendly message on the screen when a Linux kernel panic occurs.
> 
> The display controller doesn't scanout the framebuffer, but instead the
> pixels are sent to the device using a transport bus. For this reason, a
> .panic_flush handler is needed to flush the panic image to the display.

Thanks for this patch, that's really cool that drm_panic can work on 
this device too.

> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>   drivers/gpu/drm/solomon/ssd130x.c | 64 +++++++++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> index 6f51bcf774e2..0bac97bd39b9 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -32,6 +32,7 @@
>   #include <drm/drm_managed.h>
>   #include <drm/drm_modes.h>
>   #include <drm/drm_rect.h>
> +#include <drm/drm_panic.h>
>   #include <drm/drm_probe_helper.h>
>   
>   #include "ssd130x.h"
> @@ -1386,6 +1387,63 @@ static void ssd133x_primary_plane_atomic_disable(struct drm_plane *plane,
>   	drm_dev_exit(idx);
>   }
>   
> +static int ssd130x_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
> +							   struct drm_scanout_buffer *sb)
> +{
> +	struct drm_plane_state *plane_state = plane->state;
> +	struct drm_shadow_plane_state *shadow_plane_state;
> +
> +	if (!plane_state || !plane_state->fb || !plane_state->crtc)
> +		return -EINVAL;
> +
> +	shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> +
> +	sb->format = plane->state->fb->format;
> +	sb->width = plane->state->fb->width;
> +	sb->height = plane->state->fb->height;
> +	sb->pitch[0] = plane->state->fb->pitches[0];
> +	sb->map[0] = shadow_plane_state->data[0];
> +
> +	return 0;
> +}
> +
> +static void ssd130x_primary_plane_helper_panic_flush(struct drm_plane *plane)
> +{
> +	struct drm_plane_state *plane_state = plane->state;
> +	struct ssd130x_plane_state *ssd130x_plane_state = to_ssd130x_plane_state(plane_state);
> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> +	struct drm_crtc *crtc = plane_state->crtc;
> +	struct ssd130x_crtc_state *ssd130x_crtc_state = to_ssd130x_crtc_state(crtc->state);
> +
> +	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst,
> +			     ssd130x_plane_state->buffer, ssd130x_crtc_state->data_array,
> +			     &shadow_plane_state->fmtcnv_state);

ssd130x_fb_blit_rect() will call regmap->write(), which involve mutex 
and might sleep. And if the mutex is taken when the panic occurs, it 
might deadlock the panic handling.
One solution would be to configure the regmap with config->fast_io and 
config->use_raw_spinlock, and check that the lock is available with 
try_lock(map->raw_spin_lock)
But that means it will waste cpu cycle with busy waiting for normal 
operation, which is not good.

So for this particular device, I think it's ok, because it's unlikely 
you'll run kdump or other kernel panic handlers.
But I would like to know what others think about it, and if it's 
acceptable or not.

-- 

Jocelyn



> +}
> +
> +static void ssd132x_primary_plane_helper_panic_flush(struct drm_plane *plane)
> +{
> +	struct drm_plane_state *plane_state = plane->state;
> +	struct ssd130x_plane_state *ssd130x_plane_state = to_ssd130x_plane_state(plane_state);
> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> +	struct drm_crtc *crtc = plane_state->crtc;
> +	struct ssd130x_crtc_state *ssd130x_crtc_state = to_ssd130x_crtc_state(crtc->state);
> +
> +	ssd132x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst,
> +			     ssd130x_plane_state->buffer, ssd130x_crtc_state->data_array,
> +			     &shadow_plane_state->fmtcnv_state);
> +}
> +
> +static void ssd133x_primary_plane_helper_panic_flush(struct drm_plane *plane)
> +{
> +	struct drm_plane_state *plane_state = plane->state;
> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> +	struct drm_crtc *crtc = plane_state->crtc;
> +	struct ssd130x_crtc_state *ssd130x_crtc_state = to_ssd130x_crtc_state(crtc->state);
> +
> +	ssd133x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst,
> +			     ssd130x_crtc_state->data_array, &shadow_plane_state->fmtcnv_state);
> +}
> +
>   /* Called during init to allocate the plane's atomic state. */
>   static void ssd130x_primary_plane_reset(struct drm_plane *plane)
>   {
> @@ -1442,18 +1500,24 @@ static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs[]
>   		.atomic_check = ssd130x_primary_plane_atomic_check,
>   		.atomic_update = ssd130x_primary_plane_atomic_update,
>   		.atomic_disable = ssd130x_primary_plane_atomic_disable,
> +		.get_scanout_buffer = ssd130x_primary_plane_helper_get_scanout_buffer,
> +		.panic_flush = ssd130x_primary_plane_helper_panic_flush,
>   	},
>   	[SSD132X_FAMILY] = {
>   		DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
>   		.atomic_check = ssd132x_primary_plane_atomic_check,
>   		.atomic_update = ssd132x_primary_plane_atomic_update,
>   		.atomic_disable = ssd132x_primary_plane_atomic_disable,
> +		.get_scanout_buffer = ssd130x_primary_plane_helper_get_scanout_buffer,
> +		.panic_flush = ssd132x_primary_plane_helper_panic_flush,
>   	},
>   	[SSD133X_FAMILY] = {
>   		DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
>   		.atomic_check = ssd133x_primary_plane_atomic_check,
>   		.atomic_update = ssd133x_primary_plane_atomic_update,
>   		.atomic_disable = ssd133x_primary_plane_atomic_disable,
> +		.get_scanout_buffer = ssd130x_primary_plane_helper_get_scanout_buffer,
> +		.panic_flush = ssd133x_primary_plane_helper_panic_flush,
>   	}
>   };
>   


