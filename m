Return-Path: <linux-kernel+bounces-292254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A84956D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65E61C21EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE716D9B0;
	Mon, 19 Aug 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dSQS94ec"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381F16C844
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077396; cv=none; b=UrxPwLvQLIl1oJR7XzTvf/O8AarqaiDueFCnxgsiRybtEPFUNLwOPVZBSvPChtkPQFbekMm8JHT0rmZ2JKzJC2tM5R2ZGyBbdxXBTGNHnQdrO1Rv5sLmhu6hHB4IqxqUPNA9+/Z9AGP39vL5pddinmU/I3qDVobRrBkPFgt48KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077396; c=relaxed/simple;
	bh=1EgPlnWtYOrjtjYWHqFuxy5URcg14N1+9iLqbPZhBeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAFf1newc+Z0Jxy+MoeO9tdB4ZLuennyQHmFVCt/Xi8AeZ8FH+tT2z5cDn9ekpyXTcTe6U6oeolUOmntCzbylqhz0Y8QazTPGBu1oXel17hTSp/BToFaKzDi6VLw2tJHZpfMqzF/dDxbQ4lPeywvdrs6d8oB2r5Mi478Hmx+1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=dSQS94ec; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280ac10b7cso1493355e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1724077393; x=1724682193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu1Dv77/v+aGNumYuKz9BtkcW9O4WIITisX7d70NEY8=;
        b=dSQS94ecDlpUYKkVA+aU2tyEpvKFHWJ3b37L7sVBjImQy4HwxXSNdRij2zVefubuzv
         GS5d7VJF1fMKX4DK/Sbplhcjz+1yof8OHP1hGxIH0bESMZoIUHm5CqFLCBb19fw9tRAs
         y0xZPNb2QpcU93ZDljKpQcT/9d1Z8nHzeqVn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724077393; x=1724682193;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mu1Dv77/v+aGNumYuKz9BtkcW9O4WIITisX7d70NEY8=;
        b=nAjP3KlQjAEIbij2Qvx55MheKhHQEMMJkwTEvqWsTn2zXzMY/9ltg0BO5fbt36mfzs
         KQ+tTA5+59bFPKvToG4k2IsfsSFGCMiOPmZcLmRH3HrUsIZ5Rl5DcUa8YP771xiPpNGt
         1wZ17oWqF5zJEKqT+VvMHazsy4Ex/RYjnLl1bQLHXuC7rdPnoj3+MsggEhnoJfu2Wuik
         3pC8xvwQ1MW5IDsV0TE5lyFopVG3Xv4EmyuQoOCL9liSGzrndv0RHTLCRIVWdWJsUe3o
         jz7ottCoKKEQ0tfR7EIZ+crVHcTJQTigv8oB1ZsadjiQ+sV20ddIbmyrt4F/yUJNZ2Z4
         FN2w==
X-Forwarded-Encrypted: i=1; AJvYcCWydx5ZnVskPGFz0yxRhFF9GV5qf4j9AK7cpJ16WY0ytS8ZkZDW6ttcvIkmClhg+7EW8nusySflQho/luU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMYQTNibeXnm1W0tvB3SxbEZNNdX30cRGvhYtbn847Rxxa57ft
	OFMecCur2TzXBbI7Tx42OHku0c+Rw8rn+FwF4lF//p0mbqHDRGKR+85URWTzGrQ=
X-Google-Smtp-Source: AGHT+IGOTBdNpg06e70Ewc3V/FepRlszCw1O4wXZJQ5pRmXl45gvZm7p5LblQvwGecCiIwcwO+f79Q==
X-Received: by 2002:a05:600c:3b0f:b0:426:6cd1:d104 with SMTP id 5b1f17b1804b1-429ed7f72ccmr47380995e9.4.1724077392871;
        Mon, 19 Aug 2024 07:23:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6507c4sm114012625e9.15.2024.08.19.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:23:12 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:23:10 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	arthurgrillo@riseup.net, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	nicolejadeyee@google.com
Subject: Re: [PATCH RFC 01/15] drm/vkms: Remove useles devres group
Message-ID: <ZsNVTtigz4F4-npb@phenom.ffwll.local>
Mail-Followup-To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	arthurgrillo@riseup.net, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	nicolejadeyee@google.com
References: <20240814-google-remove-crtc-index-from-parameter-v1-0-6e179abf9fd4@bootlin.com>
 <20240814-google-remove-crtc-index-from-parameter-v1-1-6e179abf9fd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-1-6e179abf9fd4@bootlin.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Wed, Aug 14, 2024 at 04:36:23PM +0200, Louis Chauvet wrote:
> As the driver now uses drm managed allocation, the devres group is not
> needed anymore, so remove it.

drmm isn't devres, and you still have a devres managed resource here,
namely devm_drm_dev_alloc. The reason I suggest in the review on google's
series for configfs to nuke this is that they switched over to making vkms
a proper platform driver, in which case you get a devres group
automatically for your driver binding.

But neither the explicit one or the driver binding is one devres too few
:-)

Cheers, Sima
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index e79832e10f3c..7ac3ab7e16e5 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -297,16 +297,11 @@ static int vkms_create(struct vkms_config *config)
>  	if (IS_ERR(pdev))
>  		return PTR_ERR(pdev);
>  
> -	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
> -		ret = -ENOMEM;
> -		goto out_unregister;
> -	}
> -
>  	vkms_device = devm_drm_dev_alloc(&pdev->dev, &vkms_driver,
>  					 struct vkms_device, drm);
>  	if (IS_ERR(vkms_device)) {
>  		ret = PTR_ERR(vkms_device);
> -		goto out_devres;
> +		goto out_unregister;
>  	}
>  	vkms_device->platform = pdev;
>  	vkms_device->config = config;
> @@ -317,32 +312,30 @@ static int vkms_create(struct vkms_config *config)
>  
>  	if (ret) {
>  		DRM_ERROR("Could not initialize DMA support\n");
> -		goto out_devres;
> +		goto out_unregister;
>  	}
>  
>  	ret = drm_vblank_init(&vkms_device->drm, 1);
>  	if (ret) {
>  		DRM_ERROR("Failed to vblank\n");
> -		goto out_devres;
> +		goto out_unregister;
>  	}
>  
>  	ret = vkms_modeset_init(vkms_device);
>  	if (ret)
> -		goto out_devres;
> +		goto out_unregister;
>  
>  	drm_debugfs_add_files(&vkms_device->drm, vkms_config_debugfs_list,
>  			      ARRAY_SIZE(vkms_config_debugfs_list));
>  
>  	ret = drm_dev_register(&vkms_device->drm, 0);
>  	if (ret)
> -		goto out_devres;
> +		goto out_unregister;
>  
>  	drm_fbdev_shmem_setup(&vkms_device->drm, 0);
>  
>  	return 0;
>  
> -out_devres:
> -	devres_release_group(&pdev->dev, NULL);
>  out_unregister:
>  	platform_device_unregister(pdev);
>  	return ret;
> @@ -383,7 +376,6 @@ static void vkms_destroy(struct vkms_config *config)
>  
>  	drm_dev_unregister(&config->dev->drm);
>  	drm_atomic_helper_shutdown(&config->dev->drm);
> -	devres_release_group(&pdev->dev, NULL);
>  	platform_device_unregister(pdev);
>  
>  	config->dev = NULL;
> 
> -- 
> 2.44.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

