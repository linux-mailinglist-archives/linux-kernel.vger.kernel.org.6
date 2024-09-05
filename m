Return-Path: <linux-kernel+bounces-317057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A3D96D8AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4E0282335
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F1119C574;
	Thu,  5 Sep 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq68R3m+"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4722819D06A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539664; cv=none; b=bWO95Dm2wAipXqgPjJ71ScF6LcunmcNdudk6Vpt3N1JXvwdkXASb+hZW/lHy4AZUBS0v++ZEZ3bk/c1Spc+WwqJHnGA8p89biSbUQIYtVYHw07ggkFUQqn3JYnqoGZg9Bq41clMnJKe+10po0/yWwpt1eqMOolP42L11lfnPvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539664; c=relaxed/simple;
	bh=bzWldE0nE1eV4OY0jZtkpm7303rYklisLF1BNXGo4CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLwHorDWjzh3gQzsl87BVrN3XiaidK5oqR67K24yZuFVnWIo1mhNQy1yKazbxuanMK6mBDmWZ+Tmc9wIKfYVotxKD+G8bXa5tlZe76p5Z7AOOFE0YJ5Y1RefxVuW5c/lXOmxBaOpMl/MA6FaaUw6v1FVabcBO487i8XGqikvo4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq68R3m+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c6187b6eso476544f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725539660; x=1726144460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8WsCigj/cB5z79KDg6UMenJBs0sH3Bhud/v9yMqgZs=;
        b=Yq68R3m+E/nLchxqe+7gei24Uj+FTFdmJPbBlK9wC3Llp4p2Sb7Q96czpExBGae50S
         No7ZvooWCO3tBtr2qdGDly/q/qF6Dhv6TeOjxhqg9r8IgMOi6vtl4x+5/WlNZrNg10hJ
         Wvv1Tp8sWrg3obSsP2kXbb68QNZ1oudT/PRHWTNczmSGiHGW7PPolR/NHerbGo4WMn6x
         8aq+AL8nH+YwJ6TzvsYLg4kXmIXjsQkAv5tCXjM7+9+SPAvjobjDCUQUmGDQRxPEvm7R
         tqlOxR4ZESCvpPlXGjs2F9hS4KvWkx5dBnIJK/PwlVT8uzOECUMC0ek3x8UWYt58BgOg
         2GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539660; x=1726144460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8WsCigj/cB5z79KDg6UMenJBs0sH3Bhud/v9yMqgZs=;
        b=ICqc39FDCnz1z9xyFzB1JuOJs5oJOxLOGcxqYcI0mEhsUOjYkXudqhpfRPjS2gmQXD
         GefiDsTo8UXKO0PUxyFq3c0iPRmjSC0v5T1QNW+zgXU2DcTrB3QnHbLILzUwavzfMR20
         CzU/U6N+qkU4SKfl9kkpM3d7e8GWT7+nmEiA1C+01rRDYL1lIQpr+yQxs9JExo2yzzeP
         NCo99ogAoJgri3bc0eL+2mldCY9kcClHX/mNPOuaqFZ1lRtlFr3gojLRadP4AeCg6GSi
         /pWT9NCWlWs+13yHAWhTKtjCsWAWjMh5aT/shBu20t1ZBouGsH9XbXjmqjCJNgmZj1Wk
         9GbA==
X-Forwarded-Encrypted: i=1; AJvYcCUcxW6baXjmow2SZmXmyCb+I3uRIEtFPgWwaWaFTq3mpZCNODaYzgWsJkNszRYqgBvP3vQdjBDL7jFeqPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8EUf4ArBakwKaS+RqLcsHWrR8LcKyEQSO8P20a4hZMV3+fEqS
	S+ryzWhnD+ypaoQJstuQI23yaEbFA0Wv3ihbQhp1MmIvpra6BDVh
X-Google-Smtp-Source: AGHT+IHigy7QntQnsYJ+PK5oQKAjSIu3p67NvbgZJC7QXJx+LdxRhIe8zMFtxlortAHrKZmi2xG4Gg==
X-Received: by 2002:adf:dd86:0:b0:374:c1c5:859e with SMTP id ffacd0b85a97d-374c1c5883fmr10573873f8f.42.1725539660267;
        Thu, 05 Sep 2024 05:34:20 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b6f7ef8esm16272041f8f.8.2024.09.05.05.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:34:19 -0700 (PDT)
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
Subject: [PATCH RFC 12/15] drm/vkms: Add configuration for CRTCs and encoders
Date: Thu,  5 Sep 2024 14:34:18 +0200
Message-ID: <20240905123418.3139-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-12-6e179abf9fd4@bootlin.com>
References: <20240814-google-remove-crtc-index-from-parameter-v1-12-6e179abf9fd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The current VKMS driver can only uses one CRTC and one encoder. This patch
> introduce in the same time CRTC and encoders as they are tighly linked.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 266 +++++++++++++++++++++++++++++++++----
>  drivers/gpu/drm/vkms/vkms_config.h | 102 +++++++++++++-
>  drivers/gpu/drm/vkms/vkms_crtc.c   |  20 ++-
>  drivers/gpu/drm/vkms/vkms_crtc.h   |   3 +-
>  drivers/gpu/drm/vkms/vkms_drv.c    |  87 ++++++------
>  5 files changed, 405 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index e9e30974523a..fcd4a128c21b 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -14,6 +14,8 @@ struct vkms_config *vkms_config_create(void)
>  		return ERR_PTR(-ENOMEM);
>  
>  	INIT_LIST_HEAD(&config->planes);
> +	INIT_LIST_HEAD(&config->crtcs);
> +	INIT_LIST_HEAD(&config->encoders);
>  
>  	return config;
>  }
> @@ -22,12 +24,24 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
>  					      bool enable_cursor)
>  {
>  	struct vkms_config_plane *plane;
> +	struct vkms_config_encoder *encoder;
> +	struct vkms_config_crtc *crtc;
>  	struct vkms_config *vkms_config = vkms_config_create();
>  
>  	if (IS_ERR(vkms_config))
>  		return vkms_config;
>  
> -	vkms_config->writeback = enable_writeback;
> +	crtc = vkms_config_create_crtc(vkms_config);
> +	if (!crtc)
> +		goto err_alloc;
> +	crtc->writeback = enable_writeback;
> +
> +	encoder = vkms_config_create_encoder(vkms_config);
> +	if (!encoder)
> +		goto err_alloc;
> +
> +	if (vkms_config_encoder_attach_crtc(encoder, crtc))
> +		goto err_alloc;
>  
>  	plane = vkms_config_create_plane(vkms_config);
>  	if (!plane)
> @@ -39,6 +53,9 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
>  		goto err_alloc;
>  	sprintf(plane->name, "primary");
>  
> +	if (vkms_config_plane_attach_crtc(plane, crtc))
> +		goto err_alloc;
> +
>  	if (enable_overlay) {
>  		for (int i = 0; i < NUM_OVERLAY_PLANES; i++) {
>  			plane = vkms_config_create_plane(vkms_config);
> @@ -49,6 +66,9 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
>  			if (!plane->name)
>  				goto err_alloc;
>  			snprintf(plane->name, 10, "plane-%d", i);
> +
> +			if (vkms_config_plane_attach_crtc(plane, crtc))
> +				goto err_alloc;
>  		}
>  	}
>  	if (enable_cursor) {
> @@ -60,6 +80,9 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
>  		if (!plane->name)
>  			goto err_alloc;
>  		sprintf(plane->name, "cursor");
> +
> +		if (vkms_config_plane_attach_crtc(plane, crtc))
> +			goto err_alloc;
>  	}
>  
>  	return vkms_config;
> @@ -89,38 +112,196 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *vkms_conf
>  	vkms_config_overlay->supported_color_range = BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
>  						     BIT(DRM_COLOR_YCBCR_FULL_RANGE);
>  	vkms_config_overlay->default_color_range = DRM_COLOR_YCBCR_FULL_RANGE;
> +	xa_init_flags(&vkms_config_overlay->possible_crtcs, XA_FLAGS_ALLOC);
>  
>  	list_add(&vkms_config_overlay->link, &vkms_config->planes);
>  
>  	return vkms_config_overlay;
>  }
>  
> -void vkms_config_delete_plane(struct vkms_config_plane *vkms_config_overlay)
> +struct vkms_config_crtc *vkms_config_create_crtc(struct vkms_config *vkms_config)
>  {
> -	if (!vkms_config_overlay)
> +	if (!vkms_config)
> +		return NULL;
> +
> +	struct vkms_config_crtc *vkms_config_crtc = kzalloc(sizeof(*vkms_config_crtc),
> +							    GFP_KERNEL);
> +
> +	if (!vkms_config_crtc)
> +		return NULL;
> +
> +	list_add(&vkms_config_crtc->link, &vkms_config->crtcs);
> +	xa_init_flags(&vkms_config_crtc->possible_planes, XA_FLAGS_ALLOC);
> +	xa_init_flags(&vkms_config_crtc->possible_encoders, XA_FLAGS_ALLOC);
> +
> +	return vkms_config_crtc;
> +}
> +
> +struct vkms_config_encoder *vkms_config_create_encoder(struct vkms_config *vkms_config)
> +{
> +	if (!vkms_config)
> +		return NULL;
> +
> +	struct vkms_config_encoder *vkms_config_encoder = kzalloc(sizeof(*vkms_config_encoder),
> +								  GFP_KERNEL);
> +
> +	if (!vkms_config_encoder)
> +		return NULL;
> +
> +	list_add(&vkms_config_encoder->link, &vkms_config->encoders);
> +	xa_init_flags(&vkms_config_encoder->possible_crtcs, XA_FLAGS_ALLOC);
> +
> +	return vkms_config_encoder;
> +}
> +
> +void vkms_config_delete_plane(struct vkms_config_plane *vkms_config_plane,
> +			      struct vkms_config *vkms_config)
> +{
> +	struct vkms_config_crtc *crtc_config;
> +	struct vkms_config_plane *plane;
> +
> +	if (!vkms_config_plane)
> +		return;
> +	list_del(&vkms_config_plane->link);
> +	xa_destroy(&vkms_config_plane->possible_crtcs);
> +
> +	list_for_each_entry(crtc_config, &vkms_config->crtcs, link) {
> +		unsigned long idx = 0;
> +
> +		xa_for_each(&crtc_config->possible_planes, idx, plane) {
> +			if (plane == vkms_config_plane)
> +				xa_erase(&crtc_config->possible_planes, idx);
> +		}
> +	}
> +
> +	kfree(vkms_config_plane->name);
> +	kfree(vkms_config_plane);
> +}
> +
> +void vkms_config_delete_crtc(struct vkms_config_crtc *vkms_config_crtc,
> +			     struct vkms_config *vkms_config)
> +{
> +	struct vkms_config_crtc *crtc_config;
> +	struct vkms_config_plane *plane_config;
> +	struct vkms_config_encoder *encoder_config;
> +
> +	if (!vkms_config_crtc)
> +		return;
> +	list_del(&vkms_config_crtc->link);
> +	xa_destroy(&vkms_config_crtc->possible_planes);
> +	xa_destroy(&vkms_config_crtc->possible_encoders);
> +
> +	list_for_each_entry(plane_config, &vkms_config->planes, link) {
> +		unsigned long idx = 0;
> +
> +		xa_for_each(&plane_config->possible_crtcs, idx, crtc_config) {
> +			if (crtc_config == vkms_config_crtc)
> +				xa_erase(&plane_config->possible_crtcs, idx);
> +		}
> +	}
> +
> +	list_for_each_entry(encoder_config, &vkms_config->encoders, link) {
> +		unsigned long idx = 0;
> +
> +		xa_for_each(&encoder_config->possible_crtcs, idx, crtc_config) {
> +			if (crtc_config == vkms_config_crtc)
> +				xa_erase(&encoder_config->possible_crtcs, idx);
> +		}
> +	}
> +
> +	kfree(vkms_config_crtc);
> +}
> +
> +void vkms_config_delete_encoder(struct vkms_config_encoder *vkms_config_encoder,
> +				struct vkms_config *vkms_config)
> +{
> +	if (!vkms_config_encoder)
>  		return;
> -	list_del(&vkms_config_overlay->link);
> -	kfree(vkms_config_overlay->name);
> -	kfree(vkms_config_overlay);
> +	list_del(&vkms_config_encoder->link);
> +	xa_destroy(&vkms_config_encoder->possible_crtcs);
> +
> +	struct vkms_config_crtc *crtc_config;
> +	struct vkms_config_encoder *encoder;
> +
> +	list_for_each_entry(crtc_config, &vkms_config->crtcs, link) {
> +		unsigned long idx = 0;
> +
> +		xa_for_each(&crtc_config->possible_encoders, idx, encoder) {
> +			if (encoder == vkms_config_encoder)
> +				xa_erase(&crtc_config->possible_encoders, idx);
> +		}
> +	}
> +
> +	kfree(vkms_config_encoder);
>  }
>  
>  void vkms_config_destroy(struct vkms_config *config)
>  {
>  	struct vkms_config_plane *vkms_config_plane, *tmp_plane;
> +	struct vkms_config_encoder *vkms_config_encoder, *tmp_encoder;
> +	struct vkms_config_crtc *vkms_config_crtc, *tmp_crtc;
> +
>  
>  	list_for_each_entry_safe(vkms_config_plane, tmp_plane, &config->planes, link) {
> -		vkms_config_delete_plane(vkms_config_plane);
> +		vkms_config_delete_plane(vkms_config_plane, config);
> +	}
> +	list_for_each_entry_safe(vkms_config_encoder, tmp_encoder, &config->encoders, link) {
> +		vkms_config_delete_encoder(vkms_config_encoder, config);
> +	}
> +	list_for_each_entry_safe(vkms_config_crtc, tmp_crtc, &config->crtcs, link) {
> +		vkms_config_delete_crtc(vkms_config_crtc, config);
>  	}
>  
>  	kfree(config);
>  }
>  
> +int __must_check vkms_config_plane_attach_crtc(struct vkms_config_plane *vkms_config_plane,
> +					       struct vkms_config_crtc *vkms_config_crtc)
> +{
> +	u32 crtc_idx, encoder_idx;
> +	int ret;
> +
> +	ret = xa_alloc(&vkms_config_plane->possible_crtcs, &crtc_idx, vkms_config_crtc,
> +		       xa_limit_32b, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	ret = xa_alloc(&vkms_config_crtc->possible_planes, &encoder_idx, vkms_config_plane,
> +		       xa_limit_32b, GFP_KERNEL);
> +	if (ret) {
> +		xa_erase(&vkms_config_plane->possible_crtcs, crtc_idx);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +int __must_check vkms_config_encoder_attach_crtc(struct vkms_config_encoder *vkms_config_encoder,
> +						 struct vkms_config_crtc *vkms_config_crtc)
> +{
> +	u32 crtc_idx, encoder_idx;
> +	int ret;
> +
> +	ret = xa_alloc(&vkms_config_encoder->possible_crtcs, &crtc_idx, vkms_config_crtc,
> +		       xa_limit_32b, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	ret = xa_alloc(&vkms_config_crtc->possible_encoders, &encoder_idx, vkms_config_encoder,
> +		       xa_limit_32b, GFP_KERNEL);
> +	if (ret) {
> +		xa_erase(&vkms_config_encoder->possible_crtcs, crtc_idx);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
>  bool vkms_config_is_valid(struct vkms_config *config)

I still need to look into the xa_* code in more detail, but I think
that it is a great solution for the problem I had handling possible_crtcs
and possible_encoders.

About the validation, If I undertood the docs correctly:

  "All drivers should provide one primary plane per CRTC"
  https://www.kernel.org/doc/html/v4.17/gpu/drm-kms.html#plane-abstraction

We'd need to check that the number of primary planes is equal to the number
of CRTCs and that a configuration to assing one primary plane to each CRTC
is available.

To illustrate it with an example, this is a valid config:

  CRTC 0
  CRTC 1
  Primary Plane 0: possible_crtcs -> CRTC 0 and CRTC 1
  Primary Plane 1: possible_crtcs -> CRTC 0

But this is not a valid config because there are no compatible planes with
CRTC 1:

  CRTC 0
  CRTC 1
  Primary Plane 0: possible_crtcs -> CRTC 0
  Primary Plane 1: possible_crtcs -> CRTC 0

I think that your code would fail in the first example because of:

  // Multiple primary planes for only one CRTC
  if (has_primary)
    return false;

Also, we'd need to check that the number of CRTCs and encoders is <= 32.

>  {
>  	struct vkms_config_plane *config_plane;
> -
> -	bool has_cursor = false;
> -	bool has_primary = false;
> +	struct vkms_config_crtc *config_crtc;
> +	struct vkms_config_encoder *config_encoder;
>  
>  	list_for_each_entry(config_plane, &config->planes, link) {
>  		// Default rotation not in supported rotations
> @@ -141,22 +322,47 @@ bool vkms_config_is_valid(struct vkms_config *config)
>  		    BIT(config_plane->default_color_range))
>  			return false;
>  
> -		if (config_plane->type == DRM_PLANE_TYPE_PRIMARY) {
> -			// Multiple primary planes for only one CRTC
> -			if (has_primary)
> -				return false;
> -			has_primary = true;
> -		}
> -		if (config_plane->type == DRM_PLANE_TYPE_CURSOR) {
> -			// Multiple cursor planes for only one CRTC
> -			if (has_cursor)
> -				return false;
> -			has_cursor = true;
> -		}
> +		// No CRTC linked to this plane
> +		if (xa_empty(&config_plane->possible_crtcs))
> +			return false;
> +	}
> +
> +	list_for_each_entry(config_encoder, &config->encoders, link) {
> +		// No CRTC linked to this encoder
> +		if (xa_empty(&config_encoder->possible_crtcs))
> +			return false;
>  	}
>  
> -	if (!has_primary)
> -		return false;
> +	list_for_each_entry(config_crtc, &config->crtcs, link) {
> +		bool has_primary = false;
> +		bool has_cursor = false;
> +		unsigned long idx = 0;
> +
> +		// No encoder attached to this CRTC
> +		if (xa_empty(&config_crtc->possible_encoders))
> +			return false;
> +
> +		xa_for_each(&config_crtc->possible_planes, idx, config_plane) {
> +			if (config_plane->type == DRM_PLANE_TYPE_PRIMARY) {
> +				// Multiple primary planes for only one CRTC
> +				if (has_primary)
> +					return false;
> +
> +				has_primary = true;
> +			}
> +			if (config_plane->type == DRM_PLANE_TYPE_CURSOR) {
> +				// Multiple cursor planes for only one CRTC
> +				if (has_cursor)
> +					return false;
> +
> +				has_cursor = true;
> +			}
> +		}
> +
> +		// No primary plane for this CRTC
> +		if (!has_primary)
> +			return false;
> +	}
>  
>  	return true;
>  }
> @@ -167,8 +373,9 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  	struct drm_device *dev = entry->dev;
>  	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
>  	struct vkms_config_plane *config_plane;
> +	struct vkms_config_crtc *config_crtc;
> +	struct vkms_config_encoder *config_encoder;
>  
> -	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
>  	list_for_each_entry(config_plane, &vkmsdev->config->planes, link) {
>  		seq_puts(m, "plane:\n");
>  		seq_printf(m, "\tname: %s\n", config_plane->name);
> @@ -185,6 +392,15 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  			   config_plane->default_color_range);
>  	}
>  
> +	list_for_each_entry(config_encoder, &vkmsdev->config->encoders, link) {
> +		seq_puts(m, "encoder:\n");
> +	}
> +
> +	list_for_each_entry(config_crtc, &vkmsdev->config->crtcs, link) {
> +		seq_puts(m, "crtc:\n");
> +		seq_printf(m, "\twriteback: %d\n", config_crtc->writeback);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index d668aeab9d26..8f247fc09373 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -9,16 +9,59 @@
>  /**
>   * struct vkms_config - General configuration for VKMS driver
>   *
> - * @writeback: If true, a writeback buffer can be attached to the CRTC
>   * @planes: List of planes configured for this device. They are created by the function
>   *          vkms_config_create_plane().
> + * @crtcs: List of crtcs configured for this device. They are created by the function
> + *         vkms_config_create_crtc().
> + * @encoders: List of encoders configured for this device. They are created by the function
> + *            vkms_config_create_encoder().
>   * @dev: Used to store the current vkms device. Only set when the device is instancied.
>   */
>  struct vkms_config {
> -	bool writeback;
>  	struct vkms_device *dev;
>  
>  	struct list_head planes;
> +	struct list_head crtcs;
> +	struct list_head encoders;
> +};
> +
> +/**
> + * struct vkms_config_crtc
> + *
> + * @link: Link to the others CRTCs
> + * @possible_planes: List of planes that can be used with this CRTC
> + * @possible_encoders: List of encoders that can be used with this CRTC
> + * @crtc: Internal usage. This pointer should never be considered as valid. It can be used to
> + *         store a temporary reference to a vkms crtc during device creation. This pointer is
> + *         not managed by the configuration and must be managed by other means.
> + */
> +struct vkms_config_crtc {
> +	struct list_head link;
> +
> +	bool writeback;
> +	struct xarray possible_planes;
> +	struct xarray possible_encoders;
> +
> +	/* Internal usage */
> +	struct vkms_crtc *crtc;
> +};
> +
> +/**
> + * struct vkms_config_encoder
> + *
> + * @link: Link to the others encoders
> + * @possible_crtcs: List of CRTC that can be used with this encoder
> + * @encoder: Internal usage. This pointer should never be considered as valid. It can be used to
> + *         store a temporary reference to a vkms encoder during device creation. This pointer is
> + *         not managed by the configuration and must be managed by other means.
> + */
> +struct vkms_config_encoder {
> +	struct list_head link;
> +
> +	struct xarray possible_crtcs;
> +
> +	/* Internal usage */
> +	struct drm_encoder *encoder;
>  };
>  
>  /**
> @@ -34,6 +77,7 @@ struct vkms_config {
>   * @supported_color_encoding: Color encoding that this plane will support
>   * @default_color_range: Default color range that should be used by this plane
>   * @supported_color_range: Color range that this plane will support
> + * @possible_crtcs: List of CRTC that can be used with this plane.
>   * @plane: Internal usage. This pointer should never be considered as valid. It can be used to
>   *         store a temporary reference to a vkms plane during device creation. This pointer is
>   *         not managed by the configuration and must be managed by other means.
> @@ -50,6 +94,7 @@ struct vkms_config_plane {
>  	enum drm_color_range default_color_range;
>  	unsigned int supported_color_range;
>  
> +	struct xarray possible_crtcs;
>  	/* Internal usage */
>  	struct vkms_plane *plane;
>  };
> @@ -84,14 +129,63 @@ bool vkms_config_is_valid(struct vkms_config *vkms_config);
>   */
>  struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *vkms_config);
>  
> +/**
> + * vkms_config_create_crtc() - Create a crtc configuration
> + *
> + * This will allocate and add a new crtc configuration to @vkms_config.
> + * @vkms_config: Configuration where to insert new crtc configuration
> + */
> +struct vkms_config_crtc *vkms_config_create_crtc(struct vkms_config *vkms_config);
> +
> +/**
> + * vkms_config_create_encoder() - Create an encoder configuration
> + *
> + * This will allocate and add a new encoder configuration to @vkms_config.
> + * @vkms_config: Configuration where to insert new encoder configuration
> + */
> +struct vkms_config_encoder *vkms_config_create_encoder(struct vkms_config *vkms_config);
> +
> +int __must_check vkms_config_plane_attach_crtc(struct vkms_config_plane *vkms_config_plane,
> +					       struct vkms_config_crtc *vkms_config_crtc);
> +int __must_check vkms_config_encoder_attach_crtc(struct vkms_config_encoder *vkms_config_encoder,
> +						 struct vkms_config_crtc *vkms_config_crtc);
> +
>  /**
>   * vkms_config_delete_plane() - Remove a plane configuration and frees its memory
>   *
>   * This will delete a plane configuration from the parent configuration. This will NOT
> - * cleanup and frees the vkms_plane that can be stored in @vkms_config_plane.
> + * cleanup and frees the vkms_plane that can be stored in @vkms_config_plane. It will also remove
> + * any reference to this plane in @vkms_config.
> + *
>   * @vkms_config_plane: Plane configuration to cleanup
> + * @vkms_config: Parent configuration
> + */
> +void vkms_config_delete_plane(struct vkms_config_plane *vkms_config_plane,
> +			      struct vkms_config *vkms_config);
> +/**
> + * vkms_config_delete_crtc() - Remove a CRTC configuration and frees its memory
> + *
> + * This will delete a CRTC configuration from the parent configuration. This will NOT
> + * cleanup and frees the vkms_crtc that can be stored in @vkms_config_crtc. It will also remove
> + * any reference to this CRTC in @vkms_config.
> + *
> + * @vkms_config_crtc: Plane configuration to cleanup
> + * @vkms_config: Parent configuration
> + */
> +void vkms_config_delete_crtc(struct vkms_config_crtc *vkms_config_crtc,
> +			     struct vkms_config *vkms_config);
> +/**
> + * vkms_config_delete_encoder() - Remove an encoder configuration and frees its memory
> + *
> + * This will delete an encoder configuration from the parent configuration. This will NOT
> + * cleanup and frees the vkms_encoder that can be stored in @vkms_config_encoder. It will also
> + * remove any reference to this CRTC in @vkms_config.
> + *
> + * @vkms_config_encoder: Plane configuration to cleanup
> + * @vkms_config: Parent configuration
>   */
> -void vkms_config_delete_plane(struct vkms_config_plane *vkms_config_plane);
> +void vkms_config_delete_encoder(struct vkms_config_encoder *vkms_config_encoder,
> +				struct vkms_config *vkms_config);
>  
>  /**
>   * vkms_config_alloc_default() - Allocate the configuration for the default device
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 6f6d3118b2f2..654238dbba7f 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -281,9 +281,17 @@ static void vkms_crtc_destroy_workqueue(struct drm_device *dev, void *raw_vkms_c
>  	destroy_workqueue(vkms_crtc->composer_workq);
>  }
>  
> +static void vkms_crtc_cleanup_writeback_connector(struct drm_device *dev, void *data)
> +{
> +	struct vkms_crtc *vkms_crtc = data;
> +
> +	drm_writeback_connector_cleanup(&vkms_crtc->wb_connector);
> +}
> +
>  struct vkms_crtc *vkms_crtc_init(struct vkms_device *vkmsdev,
>  				 struct drm_plane *primary,
> -				 struct drm_plane *cursor)
> +				 struct drm_plane *cursor,
> +				 struct vkms_config_crtc *config)
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct vkms_crtc *vkms_crtc;
> @@ -317,5 +325,15 @@ struct vkms_crtc *vkms_crtc_init(struct vkms_device *vkmsdev,
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> +	if (config->writeback) {
> +		ret = vkms_enable_writeback_connector(vkmsdev, vkms_crtc);
> +		if (ret)
> +			return ERR_PTR(ret);
> +		ret = drmm_add_action_or_reset(&vkmsdev->drm, vkms_crtc_cleanup_writeback_connector,
> +					       vkms_crtc);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
>  	return vkms_crtc;
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.h b/drivers/gpu/drm/vkms/vkms_crtc.h
> index dde28884a0a5..a271e95f1cfe 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.h
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.h
> @@ -86,5 +86,6 @@ struct vkms_crtc {
>   */
>  struct vkms_crtc *vkms_crtc_init(struct vkms_device *vkmsdev,
>  				 struct drm_plane *primary,
> -				 struct drm_plane *cursor);
> +				 struct drm_plane *cursor,
> +				 struct vkms_config_crtc *config);
>  #endif //_VKMS_CRTC_H
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 403006a0bb61..6deff5099322 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -153,13 +153,12 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
>  
>  static int vkms_output_init(struct vkms_device *vkmsdev)
>  {
> -	struct vkms_config_plane *config_plane;
> +	struct vkms_config_encoder *config_encoder;
>  	struct drm_device *dev = &vkmsdev->drm;
> +	struct vkms_config_plane *config_plane;
> +	struct vkms_config_crtc *config_crtc;
>  	struct drm_connector *connector;
> -	struct drm_encoder *encoder;
> -	struct vkms_crtc *crtc;
> -	struct drm_plane *plane;
> -	struct vkms_plane *primary, *cursor = NULL;
> +	unsigned long idx;
>  	int ret;
>  	int writeback;
>  
> @@ -169,22 +168,30 @@ static int vkms_output_init(struct vkms_device *vkmsdev)
>  			ret = PTR_ERR(config_plane->plane);
>  			return ret;
>  		}
> -
> -		if (config_plane->type == DRM_PLANE_TYPE_PRIMARY)
> -			primary = config_plane->plane;
> -		else if (config_plane->type == DRM_PLANE_TYPE_CURSOR)
> -			cursor = config_plane->plane;
>  	}
>  
> -	/* [1]: Initialize the crtc component */
> -	crtc = vkms_crtc_init(vkmsdev, &primary->base,
> -			      cursor ? &cursor->base : NULL);
> -	if (IS_ERR(crtc))
> -		return PTR_ERR(crtc);
> +	list_for_each_entry(config_crtc, &vkmsdev->config->crtcs, link) {
> +		struct drm_plane *primary = NULL, *cursor = NULL;
> +
> +		xa_for_each(&config_crtc->possible_planes, idx, config_plane) {
> +			if (config_plane->type == DRM_PLANE_TYPE_PRIMARY)
> +				primary = &config_plane->plane->base;
> +			else if (config_plane->type == DRM_PLANE_TYPE_CURSOR)
> +				cursor = &config_plane->plane->base;
> +		}
> +
> +		config_crtc->crtc = vkms_crtc_init(vkmsdev, primary, cursor, config_crtc);
>  
> -	/* Enable the output's CRTC for all the planes */
> -	drm_for_each_plane(plane, &vkmsdev->drm) {
> -		plane->possible_crtcs |= drm_crtc_mask(&crtc->base);
> +		if (IS_ERR(config_crtc->crtc)) {
> +			ret = PTR_ERR(config_crtc->crtc);
> +			return ret;
> +		}
> +	}
> +
> +	list_for_each_entry(config_crtc, &vkmsdev->config->crtcs, link) {
> +		xa_for_each(&config_crtc->possible_planes, idx, config_plane) {
> +			config_plane->plane->base.possible_crtcs |= drm_crtc_mask(&config_crtc->crtc->base);
> +		}
>  	}
>  
>  	/* Initialize the connector component */
> @@ -201,32 +208,28 @@ static int vkms_output_init(struct vkms_device *vkmsdev)
>  
>  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
>  
> -	/* Initialize the encoder component */
> -	encoder = drmm_kzalloc(&vkmsdev->drm, sizeof(*encoder), GFP_KERNEL);
> -	if (!encoder)
> -		return -ENOMEM;
> -
> -	ret = drmm_encoder_init(dev, encoder, &vkms_encoder_funcs,
> -				DRM_MODE_ENCODER_VIRTUAL, NULL);
> -	if (ret) {
> -		DRM_ERROR("Failed to init encoder\n");
> -		return ret;
> -	}
> -
> -	encoder->possible_crtcs = drm_crtc_mask(&crtc->base);
>  
> -	/* Attach the encoder and the connector */
> -	ret = drm_connector_attach_encoder(connector, encoder);
> -	if (ret) {
> -		DRM_ERROR("Failed to attach connector to encoder\n");
> -		return ret;
> -	}
> +	list_for_each_entry(config_encoder, &vkmsdev->config->encoders, link) {
> +		config_encoder->encoder = drmm_kzalloc(&vkmsdev->drm,
> +						       sizeof(*config_encoder->encoder),
> +						       GFP_KERNEL);
> +		if (!config_encoder->encoder)
> +			return -ENOMEM;
> +		ret = drmm_encoder_init(dev, config_encoder->encoder, &vkms_encoder_funcs,
> +					DRM_MODE_ENCODER_VIRTUAL, NULL);
> +		if (ret) {
> +			DRM_ERROR("Failed to init encoder\n");
> +			return ret;
> +		}
>  
> -	/* Initialize the writeback component */
> -	if (vkmsdev->config->writeback) {
> -		writeback = vkms_enable_writeback_connector(vkmsdev, crtc);
> -		if (writeback)
> -			DRM_ERROR("Failed to init writeback connector\n");
> +		xa_for_each(&config_encoder->possible_crtcs, idx, config_crtc) {
> +			config_encoder->encoder->possible_crtcs |= drm_crtc_mask(&config_crtc->crtc->base);
> +		}
> +		if (IS_ERR(config_encoder->encoder))
> +			return PTR_ERR(config_encoder->encoder);
> +		ret = drm_connector_attach_encoder(connector, config_encoder->encoder);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	drm_mode_config_reset(dev);
> 

