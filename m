Return-Path: <linux-kernel+bounces-293586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2C19581A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE621F23A56
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5FE18A958;
	Tue, 20 Aug 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwTWI3el"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195716C68F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144962; cv=none; b=SoxBhUIsT3arF1YNra9GisEQvYV6JbRt3IDmP+KV9TaQ0zxEwWWaCPWfSAo/KFfgnuhXl/Go3FNf5S927pp+Q3DH1hMd+mP2KbvIrEo6eIuCQaDsKqLsz1zW7S6mWRUxYNXcKKBKgn+xB862T/p5XCJiJQG6AaToDOOP8amsPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144962; c=relaxed/simple;
	bh=0SjUeS+Q8YiK0s6AO9nW2eTTgUfTdXx1XE+Gb4kGsiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcadcEqH8SN6iIOm6qh5625FuHxwB9XtIK4pCbMntWz/yL0XqVryxSkcHBckoOTNDlOuYQyVNO2nneNhkEN1OSey0QQOUz7FPe1JmnGVL9lXKtIKhycvKAf25oh5XUibZdRJ6wsaBXaeBMdR+iGewrcU0DAFyvZGmZ6LKayDAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwTWI3el; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42816ca797fso42978665e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724144959; x=1724749759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39nNL2+o4oHw4rNBNcBPdzYRJpF6VA3Ac0WKvhXecWg=;
        b=CwTWI3elyzYpnCwC64z1QacwIQihvhNcDKhDf1+FHnwFvYkkl1fVSVxA/an+xwxPaA
         Q4+p8JL8cfzA5VVsdMVwNpP666bpQQrSvZn5tgFUz7cX+dfHEZHIWKTp+2rbduIo9Hw5
         zwAAbX/UXFkjZscDWzEkJWbOAjqRo0xqQODRQ2Gl+qsJ6CIk/3kZK+wDvavklTbuWIhC
         gPivpJfFvU+MWnBDJjRGpz777gga2r2I0kzDMu7QDjuspjnYfXDlddn0TlyLpGZFyogH
         hD37IPcrfuRf8zxjbnwxUwou1GZ+nm03oozlq5GL+YgmBwKZA5F3py4eT+wIIibao0zu
         5mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724144959; x=1724749759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39nNL2+o4oHw4rNBNcBPdzYRJpF6VA3Ac0WKvhXecWg=;
        b=tiuFiOJmWto576kj13SsW1BY6a2JyNhPgRHZkgytO0yikB5mfSnx7Tv/ZIjoFetKyq
         GZSolL+sTAK7fD4jKbLrtSBnO0t4MJu48RvB2zr98tDBgezG+mv00TV+dVCr0gsg19fN
         Szc+y2kIjDsKFXyjoVrKXFxD0ghVAuQ1ClGIoupo5c7ytr46hpUn+qOZHx1jG0Z4nSxb
         MXgb+AAc0tKWKfYJc6PuUIX5rg8sgG5OwxQD+XEIfbpJTSHJw4bZMtT3TVRb6uHhlY4/
         tgyL3ZMeMFN7+h2YU9dsVTyTnYSB5H3Z+ZF+XiBs1hqIrbmmySnQmck2AiKMgAsapRG1
         tTuw==
X-Forwarded-Encrypted: i=1; AJvYcCVDDsIftTe/Y/HLSQgsGXDDgemAmIXfzepC5o44D5teLCbVNslUZtAPOGs6wkKzWl+55VSHs+N3tL57rG5ev3XvdnG+3jjoT/Vpp14K
X-Gm-Message-State: AOJu0Yy3JIHYLtkhvogSttFxWkwMyKy6eE1h8Q6Gzx0FEYH01eTd4jRj
	vGqizxSQ1lp3W8JG/0RZPsCJxZjvEguQtR1d632CzzDQxc9x2Y32
X-Google-Smtp-Source: AGHT+IESSlGS/R12Dy0bo/M5WH+m6NeXa45/mLfj0RMkSqzA9SSFkWXBhmym40DC1+pINyonhRv6Iw==
X-Received: by 2002:adf:9bc3:0:b0:367:35d7:bf11 with SMTP id ffacd0b85a97d-37194455af1mr8074427f8f.25.1724144958748;
        Tue, 20 Aug 2024 02:09:18 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a311sm12650575f8f.23.2024.08.20.02.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:09:18 -0700 (PDT)
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
	tzimmermann@suse.de,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RFC 1/4] drm/vkms: Switch to managed for connector
Date: Tue, 20 Aug 2024 11:09:11 +0200
Message-ID: <20240820090912.2854-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-vkms-managed-v1-1-7ab8b8921103@bootlin.com>
References: <20240814-google-vkms-managed-v1-1-7ab8b8921103@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Louis,

Thanks for these patches. Easy review as my configfs series included similar
patches :) I think that this series could be easily rebased on drm-misc-next,
but I don't know if that'd add a lot of work rebasing other series. I'd be nice
to get these 4 merged.

> The current VKMS driver uses non-managed function to create connectors. It
> is not an issue yet, but in order to support multiple devices easily,
> convert this code to use drm and device managed helpers.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_drv.h    |  1 -
>  drivers/gpu/drm/vkms/vkms_output.c | 22 ++++++++++------------
>  2 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index f74a5c2045f9..cea7b2640c5d 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -43,7 +43,6 @@
>  struct vkms_output {
>  	struct drm_crtc crtc;
>  	struct drm_encoder encoder;
> -	struct drm_connector connector;
>  	struct drm_writeback_connector wb_connector;
>  	struct hrtimer vblank_hrtimer;
>  	ktime_t period_ns;
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 20073a00b200..4767838c3a73 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -3,6 +3,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_managed.h>

Nit: Keep includes sorted alphabetically if possible

>  
>  #include "vkms_writeback.h"
>  #include "vkms_plane.h"
> @@ -10,7 +11,6 @@
>  
>  static const struct drm_connector_funcs vkms_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.destroy = drm_connector_cleanup,
>  	.reset = drm_atomic_helper_connector_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> @@ -54,7 +54,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
>  {
>  	struct vkms_output *output = &vkmsdev->output;
>  	struct drm_device *dev = &vkmsdev->drm;
> -	struct drm_connector *connector = &output->connector;
> +	struct drm_connector *connector;
>  	struct drm_encoder *encoder = &output->encoder;
>  	struct drm_crtc *crtc = &output->crtc;
>  	struct vkms_plane *primary, *cursor = NULL;
> @@ -90,11 +90,15 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
>  	if (ret)
>  		return ret;
>  
> -	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
> -				 DRM_MODE_CONNECTOR_VIRTUAL);
> +	connector = drmm_kzalloc(&vkmsdev->drm, sizeof(*connector), GFP_KERNEL);

"&vkmsdev->drm" can be replaced with "dev".

> +	if (!connector)

For consistency with the init function, it'd be nice to log this error as well:

		DRM_ERROR("Failed to allocate connector\n");

> +		return -ENOMEM;
> +
> +	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
> +				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
>  	if (ret) {
>  		DRM_ERROR("Failed to init connector\n");
> -		goto err_connector;
> +		return ret;
>  	}
>  
>  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> @@ -103,7 +107,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
>  			       DRM_MODE_ENCODER_VIRTUAL, NULL);
>  	if (ret) {
>  		DRM_ERROR("Failed to init encoder\n");
> -		goto err_encoder;
> +		return ret;
>  	}
>  	/*
>  	 * This is an hardcoded value to select crtc for the encoder.
> @@ -130,11 +134,5 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
>  err_attach:
>  	drm_encoder_cleanup(encoder);
>  
> -err_encoder:
> -	drm_connector_cleanup(connector);
> -
> -err_connector:
> -	drm_crtc_cleanup(crtc);
> -

I think that, technically, err_encoder should call drm_crtc_cleanup() in this
patch. However, since a future patch will remove this code I don't find it that
relevant.

>  	return ret;
>  }

