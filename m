Return-Path: <linux-kernel+bounces-285295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE8950BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572C31F270F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030DF1A3BA6;
	Tue, 13 Aug 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ccMIbM99"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9537E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571948; cv=none; b=pwdIFZuXSmCSRG2Pf3kUVhRHpcJoB61S+vYoq0HKXulP2GOIneXNHTWq7c4ZjgOuxe4Ti2OgaH46oIN+1/MJ5KdiugHYsFVh8KYr54hlmHGIPAX/TH8WrDLzwU1RbbD/QefC0SZpBi5zQ7BsKwAj509ViXuA7tkCavAglsVAvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571948; c=relaxed/simple;
	bh=dRli8AYo7b+WelitbyZq8W4EGkDR6f+5kHHC51w9+U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+o/2pWzeVj2pjnAoBnyfuHYR2vnIh+TqKFQ6ISMgqZV77GdHUlf4v7PbG6UhkY1wKujmuoGCKS9wJtV3iOjwbRjz/s3xuchs/TyLeKjuvuDKmkgZ50oouXVerz/DfP/eqW+KjuQsN8u9TI28hethF3g/OX/kQ7CyUv0N9gysD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ccMIbM99; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D824FF804;
	Tue, 13 Aug 2024 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723571943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mc+jxQ95A2HtQfBlm7npzABiXn/B3pHmSD9CDEThevM=;
	b=ccMIbM99E4EPEuIl8V+zl5RqDHbpJ0ZJ2Pmeepjf+xRTaee9588hOY+OplFxdko4oy3SFs
	x5kumNZ9eLaE2Gb1M6bKkP8U8c5ae/0BDAoIXc39Xqjy3JWlBt25MymvcvP8rjyTtZaP35
	ZUWrBEa745Oycokqgk98uN+uRZFZ1uRUaBkL5gSKj2SZte9gnu2GT9vvXJZp4mma5hP1NL
	7/anql/HL6loYHg9Ul0A+T6b6F6q6Ig015nWB9iLC8QgncS47JuYb8uL08h5ydo899Tci7
	fmRMckr822k8svMH507sntdUH6LvlktkhB11foGeQJQCaxKwc+DRZ0UC+L1d5A==
Date: Tue, 13 Aug 2024 19:58:55 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/17] drm/vkms: Set device name from vkms_config
Message-ID: <Zrue381iv_jpPhnz@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
 <20240813105134.17439-4-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813105134.17439-4-jose.exposito89@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 13/08/24 - 12:44, José Expósito a écrit :
> In order to be able to create multiple devices, the device name needs to
> be unique.
> 
> Allow to set it in the VKMS configuration.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 7 +++++--
>  drivers/gpu/drm/vkms/vkms_config.h | 3 ++-
>  drivers/gpu/drm/vkms/vkms_drv.c    | 2 +-
>  drivers/gpu/drm/vkms/vkms_drv.h    | 2 ++
>  4 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 4c7cda16dfd8..6ab8091bf72f 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -8,7 +8,7 @@
>  #include "vkms_config.h"
>  #include "vkms_drv.h"
>  
> -struct vkms_config *vkms_config_create(void)
> +struct vkms_config *vkms_config_create(char *dev_name)
>  {
>  	struct vkms_config *config;
>  
> @@ -16,6 +16,8 @@ struct vkms_config *vkms_config_create(void)
>  	if (!config)
>  		return ERR_PTR(-ENOMEM);
>  
> +	config->dev_name = dev_name;
> +
>  	return config;
>  }

I think it can make sense to copy the device name here. If I look at your 
ConfigFS implementation, this pointer is managed by configfs, not vkms. 

I think it could be nice to avoid mixing different lifetime and let vkms 
fully manage its own objects.
  
> @@ -25,7 +27,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
>  {
>  	struct vkms_config *config;
>  
> -	config = vkms_config_create();
> +	config = vkms_config_create(DEFAULT_DEVICE_NAME);
>  	if (IS_ERR(config))
>  		return config;
>  
> @@ -47,6 +49,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  	struct drm_device *dev = entry->dev;
>  	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
>  
> +	seq_printf(m, "dev_name=%s\n", vkmsdev->config->dev_name);
>  	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
>  	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
>  	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 83181760b02b..ba06aad32799 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -8,6 +8,7 @@
>  struct vkms_device;
>  
>  struct vkms_config {
> +	char *dev_name;
>  	bool writeback;
>  	bool cursor;
>  	bool overlay;
> @@ -16,7 +17,7 @@ struct vkms_config {
>  };
>  
>  /* VKMS Config */
> -struct vkms_config *vkms_config_create(void);
> +struct vkms_config *vkms_config_create(char *dev_name);
>  struct vkms_config *vkms_config_default_create(bool enable_cursor,
>  					       bool enable_writeback,
>  					       bool enable_overlay);
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 4e36989589f9..2f9d1db0cfae 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -160,7 +160,7 @@ static int vkms_create(struct vkms_config *config)
>  	struct platform_device *pdev;
>  	struct vkms_device *vkms_device;
>  
> -	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
> +	pdev = platform_device_register_simple(config->dev_name, -1, NULL, 0);
>  	if (IS_ERR(pdev))
>  		return PTR_ERR(pdev);
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 5c523ca27f22..87e44b51a03f 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -12,6 +12,8 @@
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_writeback.h>
>  
> +#define DEFAULT_DEVICE_NAME "vkms"
> +
>  #define XRES_MIN    10
>  #define YRES_MIN    10
>  
> -- 
> 2.46.0
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

