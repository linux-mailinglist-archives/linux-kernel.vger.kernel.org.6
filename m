Return-Path: <linux-kernel+bounces-317055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA1596D8A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32991F20219
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9329B19AA72;
	Thu,  5 Sep 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8kVMKbG"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4FF19B3D7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539657; cv=none; b=EQdNNTlIpk+PPiAU/u5ZT8sp/iYtOmjFWRSkABIBxezbCyxmQdzhjLPRyK4Yp2Xwm54n+6puHr3ThvS8vITFWwbVAHbRj4N0ySOHhWAdvVOBBNiIsOXpSZyu7LPLETe+THLhhxjdg2+i2gVT8GHBVBnbCMKcjdw2dCH0ARCR9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539657; c=relaxed/simple;
	bh=bBef9i4gbKuqn3ZghYGEZv5kIpXRLBG0kuHN38GB6WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMNX3j8jBDsKY6mXWB3PqiHzZzgmYSZQD5QxXxU0oO3LWZACluqE/lSMehbjlw4TNjWFbCyr+tLnnqH1e1NTIBX72X7ibPBDgIW1zgmqomizew3U9RYk0syjt0AbNadRGMka+od2fLHTIRkBYuR0h2OQ4khutUMyLyyjH9Vxqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8kVMKbG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42c828c8863so5938965e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725539654; x=1726144454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIKjSMnoIEZ+JdjBN7NIEbFh4V1B/fbiD4x6A1IuZlA=;
        b=F8kVMKbGWp9y+Xtf77W5bwued/mDiCWhpc5G5yn0AbLKA9+u1PMYQwZMX6BHdbHA2q
         n0JJJZW1bQj9fzB47RUHQL3CHIvIRlO7jVD4KLs83rfLEd9DbzIwA9ydaA0CTA/1TBh5
         xKUpwPzDEzE4T5RzvzwVnwbqNSHful1E4Qz+jT66u2/YY/4w4zAitrUJkCCVPrYEg1FN
         vYY80WaPcZkqq5ZMmByVAeV6yDOZEzNjM17HRgXDtJI9ldD8jX1TYV+SsoXqrsBOh3Bt
         /YdQh+ol/j4PHcKB50b8EFK+H9LBS4h4kTtQumHRG/Rv9L6tPkxZkQFZO4SSRgTe8lLc
         s2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539654; x=1726144454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIKjSMnoIEZ+JdjBN7NIEbFh4V1B/fbiD4x6A1IuZlA=;
        b=pDWlFCqacq93nqJmxCPR/kgQis/BjclpJvMAi+gm+l0pZaNrXItWMbY4DJvZHCxdqb
         +XQlpGC964J9D8WtLT+gkPugdoN8qYY3Gp7gtgPtLGI2V1WduJe3PqqjYD5aXSVGeoiD
         vKn7JcjYKAhCzeGnVwxlQSoJgY0Aj8aeFQtlERcj2MlNLmXADzfhr46RwrRupfhtkEOo
         kr9un1dAgzgKHTtWj3uPDFhjBYscu54hQ3oXSUxvPf1GYYqU6BzieyofKFzNgzjCSBJW
         dx7ZFiYLTyG1og9FUL9isWUPsDtyU8Z2Kt143C/HzrCuppwHYbTy0FNV0tcB+BWjsy9R
         GB6w==
X-Forwarded-Encrypted: i=1; AJvYcCVT6cgXHb+RdsoOl4VrxVvy5ExBSjD09/8jfGKimLqUlkJbLPnQQjX9bDcDa6518BFkhDZBgCM3IOViQDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuAXoYZNycUDWbgdujIylDPXbxlOgEyFPBb+OQ6suWXZjrb2RT
	yYfwxAku0ielL1GcXs83Aw3Fz0mSR+9YO3+vIx2WBHJjRumRaAcB
X-Google-Smtp-Source: AGHT+IG/8WTsUW/MtfWTYrIUmNChxLVEzL1QgtDa+4f6zEa5cMKnDhe03yUYc+34XbJ8WGyYLk8wKw==
X-Received: by 2002:a5d:6192:0:b0:374:ba2c:3028 with SMTP id ffacd0b85a97d-374bcfb8071mr11456610f8f.36.1725539654300;
        Thu, 05 Sep 2024 05:34:14 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bacaac810sm252388875e9.33.2024.09.05.05.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:34:13 -0700 (PDT)
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
Subject: [PATCH RFC 07/15] drm/vkms: Introduce plane name configuration
Date: Thu,  5 Sep 2024 14:34:13 +0200
Message-ID: <20240905123413.3127-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-7-6e179abf9fd4@bootlin.com>
References: <20240814-google-remove-crtc-index-from-parameter-v1-7-6e179abf9fd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> As a plane will be a folder in ConfigFS, add name configuration for plane
> so it will reflect the folder name.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 14 ++++++++++++++
>  drivers/gpu/drm/vkms/vkms_config.h |  2 ++
>  drivers/gpu/drm/vkms/vkms_plane.c  |  2 +-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index b1c6160d350f..b8e235a22e90 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -34,6 +34,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
>  		goto err_alloc;
>  
>  	plane->type = DRM_PLANE_TYPE_PRIMARY;
> +	plane->name = kzalloc(sizeof("primary"), GFP_KERNEL);
> +	if (!plane->name)
> +		goto err_alloc;
> +	sprintf(plane->name, "primary");

I think that, since all planes will have a name, you could make the
name a function param and kmemdup() it in vkms_config_create_plane().

The same could apply for CRTCs and encoders in patches 13 and 14.
>  
>  	if (enable_overlay) {
>  		for (int i = 0; i < NUM_OVERLAY_PLANES; i++) {
> @@ -41,6 +45,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
>  			if (!plane)
>  				goto err_alloc;
>  			plane->type = DRM_PLANE_TYPE_OVERLAY;
> +			plane->name = kzalloc(10, GFP_KERNEL);
> +			if (!plane->name)
> +				goto err_alloc;
> +			snprintf(plane->name, 10, "plane-%d", i);
>  		}
>  	}
>  	if (enable_cursor) {
> @@ -48,6 +56,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
>  		if (!plane)
>  			goto err_alloc;
>  		plane->type = DRM_PLANE_TYPE_CURSOR;
> +		plane->name = kzalloc(sizeof("cursor"), GFP_KERNEL);
> +		if (!plane->name)
> +			goto err_alloc;
> +		sprintf(plane->name, "cursor");
>  	}
>  
>  	return vkms_config;
> @@ -79,6 +91,7 @@ void vkms_config_delete_plane(struct vkms_config_plane *vkms_config_overlay)
>  	if (!vkms_config_overlay)
>  		return;
>  	list_del(&vkms_config_overlay->link);
> +	kfree(vkms_config_overlay->name);
>  	kfree(vkms_config_overlay);
>  }
>  
> @@ -131,6 +144,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
>  	list_for_each_entry(config_plane, &vkmsdev->config->planes, link) {
>  		seq_puts(m, "plane:\n");
> +		seq_printf(m, "\tname: %s\n", config_plane->name);
>  		seq_printf(m, "\ttype: %d\n", config_plane->type);
>  	}
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 77c1c3934189..792c5e904aa1 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -25,6 +25,7 @@ struct vkms_config {
>   * struct vkms_config_plane
>   *
>   * @link: Link to the others planes
> + * @name: Name of the plane
>   * @type: Type of the plane. The creator of configuration needs to ensures that at least one
>   *        plane is primary.
>   * @plane: Internal usage. This pointer should never be considered as valid. It can be used to
> @@ -34,6 +35,7 @@ struct vkms_config {
>  struct vkms_config_plane {
>  	struct list_head link;
>  
> +	char *name;
>  	enum drm_plane_type type;
>  
>  	/* Internal usage */
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index dc9bccf60071..d2b1b524499f 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -231,7 +231,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
>  					   &vkms_plane_funcs,
>  					   vkms_formats, ARRAY_SIZE(vkms_formats),
> -					   NULL, config->type, NULL);
> +					   NULL, config->type, config->name);
>  	if (IS_ERR(plane))
>  		return plane;
>  
> 

