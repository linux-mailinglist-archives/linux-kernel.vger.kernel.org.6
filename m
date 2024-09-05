Return-Path: <linux-kernel+bounces-317051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F096D8A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBBE283012
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6770219B3F3;
	Thu,  5 Sep 2024 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCA9RARM"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E019AD9B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539613; cv=none; b=nWk0FeK6gS5SCJmftJ3dxzyZl/hvF1KyQzUroPyFybqE+/9I7/9Byr2/27daK4trL2wHFuzCRb/rbVDQ/tXWlqk9jy/XqTYkhYkerUg6qxecQ9AlB47lHX/pS3kwAJE/efXa2oRrLYaJQ7XDV6opRhTMDPPseY6UiiJR/3wHt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539613; c=relaxed/simple;
	bh=/U3bGDew/wUH8rEkiQsU0cIgm4Iip2Pb2a7mmrEmV00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwsrNRkPKuwoD4BnOeTl2/JEoNHxJm/mFy7U/zd8/c662dUcAcgbUI/yP4/0UbUvFXpcH81xed+48140BWlwShLCSujG+LT0mvjltW2JmRTXucbyne0cq4ez/SK75Wvoyo3VZLJeoEGR2cTmox2PRCO2fue2LOlowYjsclpFyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCA9RARM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374b9761eecso444594f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725539609; x=1726144409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfvHzjH+Eqg9aQgCo3Cz3Zipw1g+SvWwFvncM0vKisg=;
        b=YCA9RARMOUY1yxcCZHndNEGG4es5USmIDKqnU2DkuSNcugXk8ap8HDEmHwte2KGt8F
         Aijuz1DjU0IbQSgwHdCl7trkvgDkW6gN82ldk37JOy4ymwuAvL6VibIBGmIYyXoiCuVP
         B6xvQSt6vAmozFFO6P+MqRfSqYMutghlgKaXdsLwpQjzWZUCmE9HJ7DuFLjoYMo9weUL
         MHO/MWe0H0lkyi0aeIIdANKctGXlsi/tQe2oJWjp6HEbYKS+IOtAASF/YWjX80R+42rh
         IJ6KezyB//GJp86kSRTHoXqoHxM16pZ9aSjvzft4oMzv7AcMgXIbk5UJesn+WpnF3ecK
         j3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539609; x=1726144409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfvHzjH+Eqg9aQgCo3Cz3Zipw1g+SvWwFvncM0vKisg=;
        b=ZQHHhlzS9RI48PKs5MNC/7WtR0/DxQri1Y40ckEW3/0LT/eSibM+bTcaCo4a/zizcO
         iaaQzF7DBCMuhnBawyKRTdiUSU54INhSwNh7ZYwjAixaBIxNG+pMnIVKoRZnL9boxlXB
         beOluaPEo4QovQl8lCn6SdOvTLKXCQmgGuN+Ai1ScwHR5oiiltzBqlz/micYopLBJXjO
         TfPWSQnICqcxUqb7DHq/IBvPYSMPOer/vuumfL/L7mafMEJ/KBEIfZoU08d6wHMiNLZL
         zpxEAnxMQdxxYJ7ClcDYymc65Z/GNL1fu5NAqqSzmBP4s3SJZ6ATjctDGMxPKTqt5U1a
         hUWA==
X-Forwarded-Encrypted: i=1; AJvYcCWcfVY/0XWIuJRGb1MN60X87lo78CAMCVH4/HbeBAr1tb/n00iKxIWuTKjZ9kRlR0CNn/DiNfJiZBlRwfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyffVzTQfMBFFd4NIps7KQIrKH5YJ4wZW0fL8FsZ5vqqoNB76
	FUC4yy1833fzSYARHh0tk4hsFD/UKDOVY/2mRXPN/kQNPXPCmtkY
X-Google-Smtp-Source: AGHT+IGqrk9RY9ZJQQELiCa/NbcnoDGQ9qLtISyCVkOLNXfV5KOJMUSOzjSblaz8VUnoVwNemlMXzw==
X-Received: by 2002:a5d:4c82:0:b0:374:b31e:3b3b with SMTP id ffacd0b85a97d-374bce97b23mr10572502f8f.1.1725539608840;
        Thu, 05 Sep 2024 05:33:28 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c9c3944cesm15467855e9.30.2024.09.05.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:33:28 -0700 (PDT)
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
Subject: [PATCH RFC 02/15] drm/vkms: remove possible crtc from parameters
Date: Thu,  5 Sep 2024 14:33:27 +0200
Message-ID: <20240905123327.3049-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-2-6e179abf9fd4@bootlin.com>
References: <20240814-google-remove-crtc-index-from-parameter-v1-2-6e179abf9fd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> As the crtc mask is dynamic, avoid hardcoding it. It is already computed
> once all the planes are created, so it should be a no-op
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c   | 10 +++++-----
>  drivers/gpu/drm/vkms/vkms_plane.c |  5 +++--
>  drivers/gpu/drm/vkms/vkms_plane.h |  4 +---
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 7ac3ab7e16e5..e71b45fcb9b8 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -166,7 +166,7 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
>  	.get_modes = vkms_conn_get_modes,
>  };
>  
> -static int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc)
> +static int vkms_output_init(struct vkms_device *vkmsdev)
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct drm_connector *connector;
> @@ -184,20 +184,20 @@ static int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc)
>  	 * The overlay and cursor planes are not mandatory, but can be used to perform complex
>  	 * composition.
>  	 */
> -	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, possible_crtc);
> +	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
>  	if (IS_ERR(primary))
>  		return PTR_ERR(primary);
>  
>  	if (vkmsdev->config->overlay) {
>  		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
> -			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, possible_crtc);
> +			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY);
>  			if (IS_ERR(overlay))
>  				return PTR_ERR(overlay);
>  		}
>  	}
>  
>  	if (vkmsdev->config->cursor) {
> -		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, possible_crtc);
> +		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
>  		if (IS_ERR(cursor))
>  			return PTR_ERR(cursor);
>  	}
> @@ -284,7 +284,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
>  	dev->mode_config.preferred_depth = 0;
>  	dev->mode_config.helper_private = &vkms_mode_config_helpers;
>  
> -	return vkms_output_init(vkmsdev, 0);
> +	return vkms_output_init(vkmsdev);
>  }
>  
>  static int vkms_create(struct vkms_config *config)
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index e549c9523a34..b5740c27180b 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -5,6 +5,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_blend.h>
> +#include <drm/drm_plane.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_gem_atomic_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> @@ -222,12 +223,12 @@ static const struct drm_plane_helper_funcs vkms_plane_helper_funcs = {
>  };
>  
>  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				   enum drm_plane_type type, int possible_crtc_index)
> +				   enum drm_plane_type type)
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct vkms_plane *plane;
>  
> -	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << possible_crtc_index,
> +	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,

Shouldn't the index be BIT(0)? I see in the commit message that
possible_crtcs is computed once all planes are added, but I
couldn't find where. It'd be nice if you could point to the
function that sets the correct CRTC mask in the commit message.

>  					   &vkms_plane_funcs,
>  					   vkms_formats, ARRAY_SIZE(vkms_formats),
>  					   NULL, type, NULL);
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.h b/drivers/gpu/drm/vkms/vkms_plane.h
> index 90554c9fe250..95b2428331b8 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.h
> +++ b/drivers/gpu/drm/vkms/vkms_plane.h
> @@ -52,11 +52,9 @@ struct vkms_frame_info {
>   *
>   * @vkmsdev: vkms device containing the plane
>   * @type: type of plane to initialize
> - * @possible_crtc_index: Crtc which can be attached to the plane. The caller must ensure that
> - * possible_crtc_index is positive and less or equals to 31.
>   */
>  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				   enum drm_plane_type type, int possible_crtc_index);
> +				   enum drm_plane_type type);
>  
>  #define drm_plane_state_to_vkms_plane_state(target) \
>  	container_of(target, struct vkms_plane_state, base.base)
> 

