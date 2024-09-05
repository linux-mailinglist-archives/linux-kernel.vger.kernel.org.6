Return-Path: <linux-kernel+bounces-317054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8AD96D8A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F8928859F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EA719B587;
	Thu,  5 Sep 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl6UVS4A"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089119B5BB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539643; cv=none; b=FfMCzkNoaaG2gjbGW8uQ8TieMyJlUUE32jOLVHesV5Fb3bungTWB3AbWGi8ZDzqgWyhBn6oeq8e/D4WhIv+GyrxVfVK8FwiLfG/qh/suif6W8JX+FvzFuuLsQwYMf6zXglL1GvW/KuDbGZIhhFv1yQ7kS9jDhoIwjbCYsVBTuL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539643; c=relaxed/simple;
	bh=v6x0JHgOl6fSZmz9JX9d6MC0QzZRjjgGkuon2uBGpb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIyi6req93+dbAfs7HoEe/wtajCQyrkiHxNGoaIHgHa2E+kWyhLMVF6EtCM6/B2HI9stjCvYpFHd05yHXEp13eQH2JYPVR5qNJAWZKnXotzVb3EDximZu32QRWM2MVUWwvqZ+AhWoCBz/lJtXfmxiYlFyYneXahb6RhsqqbIyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kl6UVS4A; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bb81e795bso5702215e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725539640; x=1726144440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTbgPD3l12Z9VuKFK6+lpCr+cMTPkwFsxbL3IbxJpoM=;
        b=kl6UVS4ASU0A1B93KVEjkAAAuovcDNrBsM8LLAvmRdbfi2RCCQ1VXBIIA0AXduUA0z
         nhrZURuViMepBPUFcl5d0e+yPqK+vIbcuUz89a0ELvrDuMFg0o7MRwoEAamkSwFKQY2X
         hUZCBBmUc+TMjE4t5vGec+GIuz+SyPnHP6mCdtUqDUTnuQQ+8YEr5iRsB79dgDN53AiE
         iGYrOtiwB3V6Ex7I7uP9fO3dnxU9IJWKoOaeNVRJUDtkmrM5xDr8L4Zk50hpN8L27mqD
         MEbbV5J42kiEfxyiUAowX1bsAl1FEQjPaAzbgkSAziuGxd+LRR5Uw8KWdrRq5jh2avYX
         ttkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539640; x=1726144440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTbgPD3l12Z9VuKFK6+lpCr+cMTPkwFsxbL3IbxJpoM=;
        b=q0DaxQ7y2FgMwszAe/UDuAI/ERA8MZRXuLyHNes3bYM42jU1fusEsZnrqdhNdEIjWY
         hdar4pzu5Q/aqpSaWVipPpHc7F7ChfQ/TjqLx5nMypzgydGD/+yk/oP3o0P/40FjD49U
         LqDwNm75ytrn7+Q21l6XLU3j3mMnOsJv8d/kRc6WuwbBNppCsfucN0rD8tNDUGxZQ0zf
         kSP/S4nY5amZXxVLIBiuMVzizDTOrNXxQAF6ntB7ZzIRCuk7yHkdbtx6lX9PTJHKlI/y
         59d/XcV+ncLg3yCPyw++/1C6u3l2QVgyEB3AhZUBBeYxDuUPK57D4gJWXntlzhjkd26y
         8MMg==
X-Forwarded-Encrypted: i=1; AJvYcCXUNZ3eD5kIxy+p2StKV+ZNvcB5K53K99PtkBn8Dc7vOH27quShg0V8D+SXTfaTWNX1yaWNctRKorndAwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykoahYLEXvIA6HmaG0DZw6EpsGs8YfQJBzaE3eEXT7X+OebP+F
	CD7c8JsLZe9Z0LRFNrr596iXBuSzXSqYwlE41XAcIjVoFDeNGXCa
X-Google-Smtp-Source: AGHT+IFZY5Rc0HT97/mzQ3/0D98YXA6uJ6VMkDnkgNH/tMnOoKgT5VAlgZl/TifE3DbD//l3bkkQ7w==
X-Received: by 2002:a05:600c:5006:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-42bbb0a909dmr150660515e9.0.1725539639558;
        Thu, 05 Sep 2024 05:33:59 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c99b5c66fsm23937585e9.31.2024.09.05.05.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:33:59 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	arthurgrillo@riseup.net,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	jeremie.dautheribes@bootlin.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	melissa.srw@gmail.com,
	miquel.raynal@bootlin.com,
	mripard@kernel.org,
	nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com,
	seanpaul@google.com,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
Subject: [PATCH RFC 06/15] drm/vkms: Introduce plane configuration
Date: Thu,  5 Sep 2024 14:33:58 +0200
Message-ID: <20240905123358.3094-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-6-6e179abf9fd4@bootlin.com>
References: <20240814-google-remove-crtc-index-from-parameter-v1-6-6e179abf9fd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The current vkms driver only allows the usage of one primary, eight
> overlays and one cursor plane. This new configuration structure aims to
> make the configuration more flexible.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 90 ++++++++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/vkms/vkms_config.h | 44 +++++++++++++++++--
>  drivers/gpu/drm/vkms/vkms_drv.c    | 33 +++++---------
>  drivers/gpu/drm/vkms/vkms_plane.c  |  4 +-
>  drivers/gpu/drm/vkms/vkms_plane.h  |  3 +-
>  5 files changed, 141 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 27b49a2ad9c8..b1c6160d350f 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -13,32 +13,111 @@ struct vkms_config *vkms_config_create(void)
>  	if (!config)
>  		return ERR_PTR(-ENOMEM);
>  
> +	INIT_LIST_HEAD(&config->planes);
> +
>  	return config;
>  }
>  
>  struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable_overlay,
>  					      bool enable_cursor)
>  {
> +	struct vkms_config_plane *plane;
>  	struct vkms_config *vkms_config = vkms_config_create();
>  
>  	if (IS_ERR(vkms_config))
>  		return vkms_config;
>  
>  	vkms_config->writeback = enable_writeback;
> -	vkms_config->overlay = enable_overlay;
> -	vkms_config->cursor = enable_cursor;
> +
> +	plane = vkms_config_create_plane(vkms_config);
> +	if (!plane)
> +		goto err_alloc;
> +
> +	plane->type = DRM_PLANE_TYPE_PRIMARY;

Since all planes need to have a type, I think it'd make sense
to make "type" a param of vkms_config_create_plane().

> +
> +	if (enable_overlay) {
> +		for (int i = 0; i < NUM_OVERLAY_PLANES; i++) {
> +			plane = vkms_config_create_plane(vkms_config);
> +			if (!plane)
> +				goto err_alloc;
> +			plane->type = DRM_PLANE_TYPE_OVERLAY;
> +		}
> +	}
> +	if (enable_cursor) {
> +		plane = vkms_config_create_plane(vkms_config);
> +		if (!plane)
> +			goto err_alloc;
> +		plane->type = DRM_PLANE_TYPE_CURSOR;
> +	}
>  
>  	return vkms_config;
> +err_alloc:
> +	vkms_config_destroy(vkms_config);
> +	return ERR_PTR(-ENOMEM);
>  }
>  
> +struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *vkms_config)
> +{
> +	if (!vkms_config)
> +		return NULL;
> +
> +	struct vkms_config_plane *vkms_config_overlay = kzalloc(sizeof(*vkms_config_overlay),
> +								GFP_KERNEL);

Nit: I guess the variable is named "vkms_config_overlay" due to a rebase.
As "struct vkms_config_plane" is used to configure any plane, it'd be
great to rename the variable to reflect it.

> +
> +	if (!vkms_config_overlay)
> +		return NULL;
> +
> +	vkms_config_overlay->type = DRM_PLANE_TYPE_OVERLAY;
> +
> +	list_add(&vkms_config_overlay->link, &vkms_config->planes);
> +
> +	return vkms_config_overlay;
> +}
> +
> +void vkms_config_delete_plane(struct vkms_config_plane *vkms_config_overlay)
> +{
> +	if (!vkms_config_overlay)
> +		return;
> +	list_del(&vkms_config_overlay->link);
> +	kfree(vkms_config_overlay);
> +}
>  
>  void vkms_config_destroy(struct vkms_config *config)
>  {
> +	struct vkms_config_plane *vkms_config_plane, *tmp_plane;
> +
> +	list_for_each_entry_safe(vkms_config_plane, tmp_plane, &config->planes, link) {
> +		vkms_config_delete_plane(vkms_config_plane);
> +	}

You can drop the extra curly brackets here.

> +
>  	kfree(config);
>  }
>  
>  bool vkms_config_is_valid(struct vkms_config *config)
>  {
> +	struct vkms_config_plane *config_plane;
> +
> +	bool has_cursor = false;
> +	bool has_primary = false;
> +
> +	list_for_each_entry(config_plane, &config->planes, link) {
> +		if (config_plane->type == DRM_PLANE_TYPE_PRIMARY) {
> +			// Multiple primary planes for only one CRTC
> +			if (has_primary)
> +				return false;
> +			has_primary = true;
> +		}
> +		if (config_plane->type == DRM_PLANE_TYPE_CURSOR) {
> +			// Multiple cursor planes for only one CRTC
> +			if (has_cursor)
> +				return false;
> +			has_cursor = true;
> +		}
> +	}
> +
> +	if (!has_primary)
> +		return false;
> +
>  	return true;
>  }
>  
> @@ -47,10 +126,13 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  	struct drm_debugfs_entry *entry = m->private;
>  	struct drm_device *dev = entry->dev;
>  	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
> +	struct vkms_config_plane *config_plane;
>  
>  	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
> -	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
> -	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
> +	list_for_each_entry(config_plane, &vkmsdev->config->planes, link) {
> +		seq_puts(m, "plane:\n");
> +		seq_printf(m, "\ttype: %d\n", config_plane->type);
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 50c3b021a66b..77c1c3934189 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -10,15 +10,34 @@
>   * struct vkms_config - General configuration for VKMS driver
>   *
>   * @writeback: If true, a writeback buffer can be attached to the CRTC
> - * @cursor: If true, a cursor plane is created in the VKMS device
> - * @overlay: If true, NUM_OVERLAY_PLANES will be created for the VKMS device
> + * @planes: List of planes configured for this device. They are created by the function
> + *          vkms_config_create_plane().
>   * @dev: Used to store the current vkms device. Only set when the device is instancied.
>   */
>  struct vkms_config {
>  	bool writeback;
> -	bool cursor;
> -	bool overlay;
>  	struct vkms_device *dev;
> +
> +	struct list_head planes;
> +};
> +
> +/**
> + * struct vkms_config_plane
> + *
> + * @link: Link to the others planes
> + * @type: Type of the plane. The creator of configuration needs to ensures that at least one
> + *        plane is primary.
> + * @plane: Internal usage. This pointer should never be considered as valid. It can be used to
> + *         store a temporary reference to a vkms plane during device creation. This pointer is
> + *         not managed by the configuration and must be managed by other means.
> + */
> +struct vkms_config_plane {
> +	struct list_head link;
> +
> +	enum drm_plane_type type;
> +
> +	/* Internal usage */
> +	struct vkms_plane *plane;
>  };
>  
>  /**
> @@ -42,6 +61,23 @@ void vkms_config_destroy(struct vkms_config *config);
>   */
>  bool vkms_config_is_valid(struct vkms_config *vkms_config);
>  
> +/**
> + * vkms_config_create_plane() - Create a plane configuration
> + *
> + * This will allocate and add a new plane to @vkms_config. This plane will have by default the
> + * maximum supported values.
> + * @vkms_config: Configuration where to insert new plane
> + */
> +struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *vkms_config);
> +
> +/**
> + * vkms_config_delete_plane() - Remove a plane configuration and frees its memory
> + *
> + * This will delete a plane configuration from the parent configuration. This will NOT
> + * cleanup and frees the vkms_plane that can be stored in @vkms_config_plane.
> + * @vkms_config_plane: Plane configuration to cleanup
> + */
> +void vkms_config_delete_plane(struct vkms_config_plane *vkms_config_plane);
>  
>  /**
>   * vkms_config_alloc_default() - Allocate the configuration for the default device
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index af237daa3c5c..403006a0bb61 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -153,38 +153,27 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
>  
>  static int vkms_output_init(struct vkms_device *vkmsdev)
>  {
> +	struct vkms_config_plane *config_plane;
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct drm_connector *connector;
>  	struct drm_encoder *encoder;
>  	struct vkms_crtc *crtc;
>  	struct drm_plane *plane;
> -	struct vkms_plane *primary, *cursor, *overlay = NULL;
> +	struct vkms_plane *primary, *cursor = NULL;
>  	int ret;
>  	int writeback;
> -	unsigned int n;
>  
> -	/*
> -	 * Initialize used plane. One primary plane is required to perform the composition.
> -	 *
> -	 * The overlay and cursor planes are not mandatory, but can be used to perform complex
> -	 * composition.
> -	 */
> -	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
> -	if (IS_ERR(primary))
> -		return PTR_ERR(primary);
> -
> -	if (vkmsdev->config->overlay) {
> -		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
> -			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY);
> -			if (IS_ERR(overlay))
> -				return PTR_ERR(overlay);
> +	list_for_each_entry(config_plane, &vkmsdev->config->planes, link) {
> +		config_plane->plane = vkms_plane_init(vkmsdev, config_plane);
> +		if (IS_ERR(config_plane->plane)) {
> +			ret = PTR_ERR(config_plane->plane);
> +			return ret;
>  		}
> -	}
>  
> -	if (vkmsdev->config->cursor) {
> -		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
> -		if (IS_ERR(cursor))
> -			return PTR_ERR(cursor);
> +		if (config_plane->type == DRM_PLANE_TYPE_PRIMARY)
> +			primary = config_plane->plane;
> +		else if (config_plane->type == DRM_PLANE_TYPE_CURSOR)
> +			cursor = config_plane->plane;
>  	}
>  
>  	/* [1]: Initialize the crtc component */
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index b5740c27180b..dc9bccf60071 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -223,7 +223,7 @@ static const struct drm_plane_helper_funcs vkms_plane_helper_funcs = {
>  };
>  
>  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				   enum drm_plane_type type)
> +				   struct vkms_config_plane *config)
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct vkms_plane *plane;
> @@ -231,7 +231,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
>  					   &vkms_plane_funcs,
>  					   vkms_formats, ARRAY_SIZE(vkms_formats),
> -					   NULL, type, NULL);
> +					   NULL, config->type, NULL);
>  	if (IS_ERR(plane))
>  		return plane;
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.h b/drivers/gpu/drm/vkms/vkms_plane.h
> index 95b2428331b8..82049966ee7e 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.h
> +++ b/drivers/gpu/drm/vkms/vkms_plane.h
> @@ -9,6 +9,7 @@
>  #include <linux/iosys-map.h>
>  
>  #include "vkms_formats.h"
> +#include "vkms_config.h"
>  
>  struct vkms_plane {
>  	struct drm_plane base;
> @@ -54,7 +55,7 @@ struct vkms_frame_info {
>   * @type: type of plane to initialize
>   */
>  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				   enum drm_plane_type type);
> +				   struct vkms_config_plane *config);
>  
>  #define drm_plane_state_to_vkms_plane_state(target) \
>  	container_of(target, struct vkms_plane_state, base.base)
> 

