Return-Path: <linux-kernel+bounces-255331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C5B933F44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F621F22340
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816BC181B90;
	Wed, 17 Jul 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K+tZme9C"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7D20B0F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228941; cv=none; b=cTNybGZ9aO1mE2+mJ89SLx0rfCrPvsWwom8cyOJvRLEEcCNFnbY7k4PDyuOCXxPBiNYbXLo62YhY2fLgVljAUx8qi1VqJcR9pQPVC3MhPalWOOHCy6iJr6qIv47ML1fVlmw696SSke8ewDgjJ6zZOEveff5kNntvNSSZLqgWlBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228941; c=relaxed/simple;
	bh=r46AnO6z5V7ywCMqp7Rmp0vQNfGHGsHx6bjdydhM20U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/H7il1ZfBoTOuHfjrpSQ1ZNzteHHuU6Gm/VzhfMSWTCDh+4BsKRAIkC3aq8jV+jo8pbQufvmMp0So2OetQMq+Egokl63l+K4fvXq7a5FGVcOpl/uW2Qa0lRmiYiiQwgJrFG48NckAsq2C6+QgZ0OD6p8sCi/sK7VyYIfa8T/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=K+tZme9C; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427bc3877d0so2004745e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721228938; x=1721833738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s77sxARyPcLu/24QtoN8ND9W5Zo8PTRc1Nw51x3CKtQ=;
        b=K+tZme9CTDUNALaJHh70qlr8DqdbojMp//PZzYbu5RQH7BBN+Q5gQTT75stOF8xwpd
         g0xb/CJl2Mb0JQnZN4uegjkYcROgu0eEpCEwJLDfVoSg3m/MuCQj5/GT3QCsH970RA5R
         ykLWPQDSikKL6HWUKMwuTeXz/1FTbNyjzRHvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228938; x=1721833738;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s77sxARyPcLu/24QtoN8ND9W5Zo8PTRc1Nw51x3CKtQ=;
        b=Qub0z3BLVjhtb12gKxBG7caLbZy6jt43Yx6X/q5NE57FbiFgF40QoxEXnRz3/hy/i3
         5SwMM5XtID8JMogZIYj/m74LCG9OqqEGhB2Z+vMR1zyJbwYt2hg5yApFVyDm/75EVQiA
         cDIyXymZPbJZxC7O4hmaXnl2eMgsa6CbKFkQAdqBOJFBNA15db5vAcjlo+0S96MDBd9g
         GfL0gw0PoUr/os1JLNdMH1WgLlZ2P5b/+DieRtKxp06VbKu+gODl/SnXxcampYBfPYPv
         dgFGmvKzE8R+IM2696yqbmoSY/bapqbQBZjUpjA9k8h8T5wly3BWM6uLnaOHXqpAxsbN
         Wehw==
X-Forwarded-Encrypted: i=1; AJvYcCXpEv7Z2Ydvh/VHK+X90wSgBQV2gtC1Bl/BXYSmnnAMGk2eJz9kv59B78/oPu/YR40oQxP70LtIn+168WWeyjF657zof5j8N8t95INN
X-Gm-Message-State: AOJu0YyDRLCO0llaiLl18Om/Viy+rgAGNMwfc9aee+WUN0Qm8dUEzopO
	s4zugTk8VSYanhlJzv/IGA/0szhF14uDvxBmSv+OFvQCJ3LQvMycJm0HT6lSZt0=
X-Google-Smtp-Source: AGHT+IH1i/w84Z4TRUoKj/BGXwmxibTxvjiniJriyPObqoZKHx+24ILVUcBSnoq6KRs8SxxUKsqewA==
X-Received: by 2002:a05:600c:3501:b0:426:6a0d:1ae5 with SMTP id 5b1f17b1804b1-427c2c0ef1bmr9093365e9.0.1721228938505;
        Wed, 17 Jul 2024 08:08:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77b05aesm1309505e9.14.2024.07.17.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:08:58 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:08:56 +0200
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
Subject: Re: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
Message-ID: <ZpfeiMj48JQTQcOE@phenom.ffwll.local>
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
 <20240717090102.968152-2-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717090102.968152-2-jfalempe@redhat.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 17, 2024 at 10:48:39AM +0200, Jocelyn Falempe wrote:
> It allows to check if the drm device supports drm_panic.
> Prepare the work to have better integration with fbcon and vtconsole.
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
>  include/drm/drm_panic.h     |  2 ++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 948aed00595e..d9a25c2d0a65 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -703,6 +703,26 @@ static void debugfs_register_plane(struct drm_plane *plane, int index)
>  static void debugfs_register_plane(struct drm_plane *plane, int index) {}
>  #endif /* CONFIG_DRM_PANIC_DEBUG */
>  
> +/**
> + * drm_panic_is_enabled
> + * @dev: the drm device that may supports drm_panic
> + *
> + * returns true if the drm device supports drm_panic
> + */
> +bool drm_panic_is_enabled(struct drm_device *dev)
> +{
> +	struct drm_plane *plane;
> +
> +	if (!dev->mode_config.num_total_plane)
> +		return false;
> +
> +	drm_for_each_plane(plane, dev)
> +		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
> +			return true;
> +	return false;
> +}
> +EXPORT_SYMBOL(drm_panic_is_enabled);

This feels like overkill since you currently only have one user in the
fbdev emulation code, but maybe useful in some other places ...

> +
>  /**
>   * drm_panic_register() - Initialize DRM panic for a device
>   * @dev: the drm device on which the panic screen will be displayed.
> diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
> index 73bb3f3d9ed9..c3a358dc3e27 100644
> --- a/include/drm/drm_panic.h
> +++ b/include/drm/drm_panic.h
> @@ -148,11 +148,13 @@ struct drm_scanout_buffer {
>  
>  #ifdef CONFIG_DRM_PANIC
>  
> +bool drm_panic_is_enabled(struct drm_device *dev);

Since it's internal only, this should be in
drivers/gpu/drm/drm_crtc_internal.h and not int he include for drivers.
With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  void drm_panic_register(struct drm_device *dev);
>  void drm_panic_unregister(struct drm_device *dev);

These two are only used in drm.ko. Can you please move them to
drm_crtc_internal.h too and drop the EXPORT_SYMBOL in a follow-up patch?
We're trying to limit the exported interface and official headers to
really only the pieces drivers actually need.

Thanks, Sima

>  
>  #else
>  
> +bool drm_panic_is_enabled(struct drm_device *dev) {return false; }
>  static inline void drm_panic_register(struct drm_device *dev) {}
>  static inline void drm_panic_unregister(struct drm_device *dev) {}
>  
> -- 
> 2.45.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

