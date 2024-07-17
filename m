Return-Path: <linux-kernel+bounces-255329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D443933F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761F2B2391C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2631E181CFE;
	Wed, 17 Jul 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UA8DGrlt"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8876181B90
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228663; cv=none; b=ZlTtzneNHIOtALWNKnf0pNg07EPTogoPM5EQaKHzj5ZF4KrP1NwwKKhWGAvrLWFBy0TxnwMC28vYihjb7Fc133rvGomHPc5GHAG3v5XJsZEf3EsyXVMhXD7ErYercQ8lvU0bu6AWI/OS0UG+GiVZyC3du53LLZDBrb5/7bYTLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228663; c=relaxed/simple;
	bh=cEVK6GIdWYaMZGA/hOHwHVgRjYyYadpMzyQcAdayBwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEhq7zEjO9kY9dS4TxgwiwdgjQoMwCUfXOHEFPrDBaO2rFDoVosdLYAErN64f9IyAgMg9T8snEbOLEM5obeo042wjmhMYei/4ULgler+RPeBQ6yOsaIFNViGuDwHKx7yNQj2y2+XAwMhXryNr+eU9RTnS66jTZwIbO8sEcTu2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=UA8DGrlt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42673554402so7768825e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721228659; x=1721833459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5pjr/7PlGU0bno59J3w/W6V2Jp6tDpULmroTCCRYAE=;
        b=UA8DGrlt4trcsuvR5a2AbRTmQiIbtgLVuqyHK0SRfN4/F4N41CYRLv8Jpyu8SZZ3yw
         mj9vTPL1KmpnzKHNTkeRTBMRSQxBMz4rZsDGPfCgP5kUopfworoXIku4P6lQVfUnS9tx
         8ZSLmmPHaLh7ERlBsK6NuloqkQch7ZjC5OE6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228659; x=1721833459;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5pjr/7PlGU0bno59J3w/W6V2Jp6tDpULmroTCCRYAE=;
        b=YlOXtBRtmq+iboaDPcE9xX4d2OPtty3vQLBUx1o3D+vTShk3nXsGoSkBw2rKxsIM6O
         KtRC7i/Jxo22XBKbxY5bT/6xAIfKWnYDvvCPbS1S+T8ua/hhW5ZDqx/vcr8ru0BSiGoB
         TlwtsjKu75D7MAIofd5hPpxKl+754MRBLGumsbdDgnkg68px2NQ7ZcA4fZv+1R3MiZ+S
         OflJ8/zSI0Lk7g6uf9IjZeLumnwboRATywZktmkJ0QrF6M9we6Be1xSrXFueEbxqHxhG
         ka5fzKuZ39WsLL+H8CUoD0/fqub5ZL+xR/ziYGdtJYnOt7VJIgtkAlBziyvs5GbkrUYJ
         7obQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJEHjWgFqQpntI76be4wn+COhWM+oVwAcRmTIJlKWauV/+BUbe5vuii0yTzajrDi54h8lY8wKuA00OSnqwb/2NU5uCtiCxOL7QIWvB
X-Gm-Message-State: AOJu0Yz2GNRCCgkToWL1tZSDaDen4Y4bA/Tys01PktGBM/szPfJSdvhE
	ODXX498JWwVSK34Klox25kvyAKmkJxGfAavF7wDI2pqJqyBZ8Kn3jgu+nxHdefU=
X-Google-Smtp-Source: AGHT+IGnQq5qn3XFcUVytJqVgSB3xoYK5wfjBzWyxNvSmCk4IGCgYkb1mLjSP+9pJg5W/Sm0P9gk8w==
X-Received: by 2002:a05:600c:1c86:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-427c2d0c8eemr8946465e9.3.1721228659021;
        Wed, 17 Jul 2024 08:04:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c78076f7sm1074075e9.37.2024.07.17.08.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:04:18 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:04:16 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/3] fbcon: Add an option to disable fbcon in panic.
Message-ID: <ZpfdcC2Es9rweHW_@phenom.ffwll.local>
Mail-Followup-To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-3-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717090102.968152-3-jfalempe@redhat.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 17, 2024 at 10:48:40AM +0200, Jocelyn Falempe wrote:
> This is required to avoid conflict between DRM_PANIC, and fbcon. If
> a drm device already handle panic with drm_panic, it should set
> the skip_panic field in fb_info, so that fbcon will stay quiet, and
> not overwrite the panic_screen.
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/drm_fb_helper.c  | 2 ++
>  drivers/video/fbdev/core/fbcon.c | 7 ++++++-
>  include/linux/fb.h               | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index e2e19f49342e..3662d664d8f9 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -40,6 +40,7 @@
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_panic.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_vblank.h>
>  
> @@ -524,6 +525,7 @@ struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
>  	fb_helper->info = info;
>  	info->skip_vt_switch = true;
>  
> +	info->skip_panic = drm_panic_is_enabled(fb_helper->dev);
>  	return info;
>  
>  err_release:

Bit a bikeshed, but I'd split this patch out since it's for drm's fbdev
emulation, not the fbcon core code. With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 3f7333dca508..498d9c07df80 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -270,12 +270,17 @@ static int fbcon_get_rotate(struct fb_info *info)
>  	return (ops) ? ops->rotate : 0;
>  }
>  
> +static bool fbcon_skip_panic(struct fb_info *info)
> +{
> +	return (info->skip_panic && unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID));
> +}
> +
>  static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
>  {
>  	struct fbcon_ops *ops = info->fbcon_par;
>  
>  	return (info->state != FBINFO_STATE_RUNNING ||
> -		vc->vc_mode != KD_TEXT || ops->graphics);
> +		vc->vc_mode != KD_TEXT || ops->graphics || fbcon_skip_panic(info));
>  }
>  
>  static int get_color(struct vc_data *vc, struct fb_info *info,
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index db7d97b10964..865dad03e73e 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -510,6 +510,7 @@ struct fb_info {
>  	void *par;
>  
>  	bool skip_vt_switch; /* no VT switch on suspend/resume required */
> +	bool skip_panic; /* Do not write to the fb after a panic */
>  };
>  
>  /* This will go away
> -- 
> 2.45.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

