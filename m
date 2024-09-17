Return-Path: <linux-kernel+bounces-331889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA597B27E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418A31C216AB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A9176AC2;
	Tue, 17 Sep 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iml4v0Ye"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD4535DC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588926; cv=none; b=MR4iTqJRlOrij+Uq5NApj378XkrDHiEUEyhKAyD3+ew5KitBMsT2N3Vk6u4UK/IpW6QlljuXaKgHjk+esmWpB9S2AFVPvXS6jsl16PTLmKzMibz7h5fvo575ymcbGnei0tVHGCHY+VBmBQFDmK9qJLVcwx37uStiDIrM0DwAONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588926; c=relaxed/simple;
	bh=/Jec9/iWuRZ2ax6CNr4zJaNvk7xYQ5SbbWkgHhU7LBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLB+TnGJ8rC4nSYiG4LTpDEmtKwta2SBCtrI/P0LPBDnNdpoTOQ4EkiipefGVQPddEe1/HQJodIy7iGeO1J/AphT9to9EOkPbY9CGMYjIE8sBAM3snjzzL5QJFG4Rs4csBP3VFPhyX52+axj9GvoZO7n2f0DTV1xhgB4wVcP3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iml4v0Ye; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so57484845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726588923; x=1727193723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5KQ1kLnN8DMSlG9w5BfJJLpfIAjSTIsA7znasV0gTg=;
        b=Iml4v0YeGOeq+vSQ9gDA7bn5LmwBdvyIHoPGlIIZxnQexdjuqfEWrx4VIzKQcu/ENq
         93PPBqkpLPQjnRXzT2vr/yFSB1ux+X85g07uTQV/9PYyjz3agFuYlSxsfijkFHO6PLCj
         yuh/yAk1cSUDouAz3+MfeJsNqveubBjKhTADgUmVWu1Py9iPvhIMhVWX74RsgSW5t4H7
         YzlkM7L6NLYSSm4qGlk1bWrG9tdKCALAuTLKmIV1zjeqLhgMvjW9Dle5nG+XIdjcDQsE
         x90AJPw/4ZjbMQhQ4QT03ugV9z7jUoSi9A+92S9iMhGSWUR7XTP5HLYnWvVdoZirL0Zl
         vIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726588923; x=1727193723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5KQ1kLnN8DMSlG9w5BfJJLpfIAjSTIsA7znasV0gTg=;
        b=YVRx958aOkemoxojrSOBd4yj3mo8HYIBqmmGlLLLkuc6Iw+ENgh7ZIO/DSZkgEh3p2
         cMZktYW0osKRctiT6w2ZOUFsfbsqFLW7p7EShmMSHh/TnvEtv390Vy4663ac8y38cipH
         trPtI5x+R/WYAHQEIlOtxk7jN1OrIxpevexwOsZEu7bt/q50Xe+guSv2WNylOUWhqSBf
         FVziHiRwgUgcC71qjsdS+46NDYAnW7jUrt7vu2PuBl9lXOFUj+V99agTxC88zxMzt8DF
         zzG02abarj/QiwxARNcif2bGfraOA2yWzgb7Q4tNnw4sDY8SwXajuH702vMOrqISmi3T
         4vPA==
X-Forwarded-Encrypted: i=1; AJvYcCXVPGuV1cdFuZg6kk1cvc4fYUf4sXD7/3wOfXVFM1sM3I14F53c6QT/X+WTRVu1R5XB7VPPP6PxLAsMr5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvM8WgiEO5qx5l8836oketAunrsw3olugYEjeGBZlTljoO21/
	5bYxZmt/oDuduaQtmuEXm8iGAgURnlTzh8oHFYveKh9cH534PrAY
X-Google-Smtp-Source: AGHT+IFEFYqkN8FhiJkkKF9AnGNvNEYelsyf87w6eG31+Zh8MeE18OaiUzbDO3QzrD4Fj7t9ZH1nFw==
X-Received: by 2002:a05:600c:2e48:b0:42c:de6f:6ab3 with SMTP id 5b1f17b1804b1-42cde6f6b81mr150925295e9.6.1726588922489;
        Tue, 17 Sep 2024 09:02:02 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78044easm9902317f8f.91.2024.09.17.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:02:01 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	melissa.srw@gmail.com,
	mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
Subject: [PATCH 3/3] drm/vkms: Switch to dynamic allocation for CRTC
Date: Tue, 17 Sep 2024 18:02:00 +0200
Message-ID: <20240917160200.2888-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912-b4-vkms-allocated-v1-3-29abbaa14af9@bootlin.com>
References: <20240912-b4-vkms-allocated-v1-3-29abbaa14af9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Louis,

Thanks for this series!

The first 2 patches look good to me. It could make sense to move the
alloc + init pair of calls to a function (vkms_connector_init() and
vkms_encoder_init() for example), but we can always move it in the
furure:

This one looks good, but I added couple of comments:

> specific allocation for the CRTC is not strictly necessary at this point,
> but in order to implement dynamic configuration of VKMS (configFS), it
> will be easier to have one allocation per CRTC.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c      | 28 ++++++++++++++-----------
>  drivers/gpu/drm/vkms/vkms_drv.h       |  9 ++++----
>  drivers/gpu/drm/vkms/vkms_output.c    | 39 ++++++++++++++++++-----------------
>  drivers/gpu/drm/vkms/vkms_writeback.c | 17 ++++++++-------
>  4 files changed, 50 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 821b9ac746083630116e05c1cf8e3dc2424ac66a..1169eb5a5e521fb42b1af85082425cd71aa2be4d 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -88,7 +88,7 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
>  {
>  	struct drm_device *dev = crtc->dev;
>  	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);

vkmsdev is unused.

> -	struct vkms_output *output = &vkmsdev->output;
> +	struct vkms_output *output = drm_crtc_to_vkms_output(crtc);
>  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>  
>  	if (!READ_ONCE(vblank->enabled)) {
> @@ -281,19 +281,23 @@ static void vkms_crtc_destroy_workqueue(struct drm_device *dev,
>  	destroy_workqueue(vkms_out->composer_workq);
>  }
>  
> -int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> -		   struct drm_plane *primary, struct drm_plane *cursor)
> +struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *primary,
> +				   struct drm_plane *cursor)
>  {
> -	struct vkms_output *vkms_out = drm_crtc_to_vkms_output(crtc);
> +	struct vkms_output *vkms_out;
> +	struct drm_crtc *crtc;
>  	int ret;
>  
> -	ret = drmm_crtc_init_with_planes(dev, crtc, primary, cursor,
> -					 &vkms_crtc_funcs, NULL);
> -	if (ret) {
> -		DRM_ERROR("Failed to init CRTC\n");
> -		return ret;
> +	vkms_out = drmm_crtc_alloc_with_planes(dev, struct vkms_output, crtc,
> +					       primary, cursor,
> +					       &vkms_crtc_funcs, NULL);
> +	if (IS_ERR(vkms_out)) {
> +		DRM_DEV_ERROR(dev->dev, "Failed to init CRTC\n");
> +		return vkms_out;
>  	}
>  
> +	crtc = &vkms_out->crtc;
> +
>  	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
>  
>  	drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
> @@ -304,12 +308,12 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
>  
>  	vkms_out->composer_workq = alloc_ordered_workqueue("vkms_composer", 0);
>  	if (!vkms_out->composer_workq)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	ret = drmm_add_action_or_reset(dev, vkms_crtc_destroy_workqueue,
>  				       vkms_out);
>  	if (ret)
> -		return ret;
> +		return ERR_PTR(ret);
>  
> -	return ret;
> +	return vkms_out;
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 972aee6853f2b29909291e33652f68740fdc9dbc..a97164c0c2d62c4b6bb5641d09b3607a742cf585 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -126,7 +126,6 @@ struct vkms_config {
>  struct vkms_device {
>  	struct drm_device drm;
>  	struct platform_device *platform;
> -	struct vkms_output output;
>  	const struct vkms_config *config;
>  };
>  
> @@ -143,8 +142,9 @@ struct vkms_device {
>  	container_of(target, struct vkms_plane_state, base.base)
>  
>  /* CRTC */
> -int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> -		   struct drm_plane *primary, struct drm_plane *cursor);
> +struct vkms_output *vkms_crtc_init(struct drm_device *dev,
> +				   struct drm_plane *primary,
> +				   struct drm_plane *cursor);

Do you think that it could make sense to rename vkms_output to vkms_crtc
in a follow up patch?

I find a bit confusing that vkms_crtc_init returns a different type.
Renaming it would make drm_crtc_to_vkms_output() consistent with the
other container_of macros.

>  
>  int vkms_output_init(struct vkms_device *vkmsdev);
>  
> @@ -165,6 +165,7 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
>  void vkms_writeback_row(struct vkms_writeback_job *wb, const struct line_buffer *src_buffer, int y);
>  
>  /* Writeback */
> -int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
> +int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
> +				    struct vkms_output *vkms_out);
>  
>  #endif /* _VKMS_DRV_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 60d5365f8d41b8f20da489cfb9dbc85eb9df4916..a57a0cfa21964577f98e564acf87711b2e85fa67 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -29,11 +29,11 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
>  
>  int vkms_output_init(struct vkms_device *vkmsdev)
>  {
> -	struct vkms_output *output = &vkmsdev->output;
> +

Extra blank line.

>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct drm_connector *connector;
>  	struct drm_encoder *encoder;
> -	struct drm_crtc *crtc = &output->crtc;
> +	struct vkms_output *output;
>  	struct vkms_plane *primary, *overlay, *cursor = NULL;
>  	int ret;
>  	int writeback;
> @@ -49,31 +49,33 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  			return PTR_ERR(cursor);
>  	}
>  
> -	ret = vkms_crtc_init(dev, crtc, &primary->base, &cursor->base);
> -	if (ret)
> -		return ret;
> +	output = vkms_crtc_init(dev, &primary->base,
> +				cursor ? &cursor->base : NULL);
> +	if (IS_ERR(output)) {
> +		DRM_ERROR("Failed to allocate CRTC\n");
> +		return PTR_ERR(output);
> +	}
>  
>  	if (vkmsdev->config->overlay) {
>  		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
>  			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY);
>  			if (IS_ERR(overlay))
>  				return PTR_ERR(overlay);
> -			overlay->base.possible_crtcs = drm_crtc_mask(crtc);
> +			overlay->base.possible_crtcs = drm_crtc_mask(&output->crtc);
>  		}
>  	}
>  
>  	connector = drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
>  	if (!connector) {
>  		DRM_ERROR("Failed to allocate connector\n");
> -		ret = -ENOMEM;
> -		goto err_connector;
> +		return -ENOMEM;
>  	}
>  
>  	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
>  				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
>  	if (ret) {
>  		DRM_ERROR("Failed to init connector\n");
> -		goto err_connector;
> +		return ret;
>  	}
>  
>  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> @@ -81,34 +83,33 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  	encoder = drmm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
>  	if (!encoder) {
>  		DRM_ERROR("Failed to allocate encoder\n");
> -		ret = -ENOMEM;
> -		goto err_connector;
> +		return -ENOMEM;
>  	}
>  	ret = drmm_encoder_init(dev, encoder, NULL,
>  				DRM_MODE_ENCODER_VIRTUAL, NULL);
>  	if (ret) {
>  		DRM_ERROR("Failed to init encoder\n");
> -		goto err_connector;
> +		return ret;
>  	}
> -	encoder->possible_crtcs = drm_crtc_mask(crtc);
> +	encoder->possible_crtcs = drm_crtc_mask(&output->crtc);
>  
> +	/* Attach the encoder and the connector */
>  	ret = drm_connector_attach_encoder(connector, encoder);
>  	if (ret) {
>  		DRM_ERROR("Failed to attach connector to encoder\n");
>  		return ret;
>  	}
>  
> +	/* Initialize the writeback component */
>  	if (vkmsdev->config->writeback) {
> -		writeback = vkms_enable_writeback_connector(vkmsdev);
> -		if (writeback)
> +		writeback = vkms_enable_writeback_connector(vkmsdev, output);
> +		if (writeback) {
>  			DRM_ERROR("Failed to init writeback connector\n");
> +			return ret;
> +		}
>  	}
>  
>  	drm_mode_config_reset(dev);
>  
>  	return 0;
> -
> -err_connector:
> -	drm_crtc_cleanup(crtc);
> -	return ret;
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index a948f4598764efef971f76e1016fc1a963fbbba7..f91c6418480f71ab3ec9989ea85814460e10d231 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -105,7 +105,9 @@ static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
>  				struct drm_writeback_job *job)
>  {
>  	struct vkms_writeback_job *vkmsjob = job->priv;
> -	struct vkms_device *vkmsdev;
> +	struct vkms_output *vkms_output = container_of(connector,
> +						       struct vkms_output,
> +						       wb_connector);
>  
>  	if (!job->fb)
>  		return;
> @@ -114,8 +116,7 @@ static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
>  
>  	drm_framebuffer_put(vkmsjob->wb_frame_info.fb);
>  
> -	vkmsdev = drm_device_to_vkms_device(job->fb->dev);
> -	vkms_set_composer(&vkmsdev->output, false);
> +	vkms_set_composer(vkms_output, false);
>  	kfree(vkmsjob);
>  }
>  
> @@ -124,8 +125,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>  {
>  	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
>  											 conn);
> -	struct vkms_device *vkmsdev = drm_device_to_vkms_device(conn->dev);
> -	struct vkms_output *output = &vkmsdev->output;
> +	struct vkms_output *output = drm_crtc_to_vkms_output(connector_state->crtc);
>  	struct drm_writeback_connector *wb_conn = &output->wb_connector;
>  	struct drm_connector_state *conn_state = wb_conn->base.state;
>  	struct vkms_crtc_state *crtc_state = output->composer_state;
> @@ -139,7 +139,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>  	if (!conn_state)
>  		return;
>  
> -	vkms_set_composer(&vkmsdev->output, true);
> +	vkms_set_composer(output, true);
>  
>  	active_wb = conn_state->writeback_job->priv;
>  	wb_frame_info = &active_wb->wb_frame_info;
> @@ -167,9 +167,10 @@ static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
>  	.atomic_check = vkms_wb_atomic_check,
>  };
>  
> -int vkms_enable_writeback_connector(struct vkms_device *vkmsdev)
> +int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
> +				    struct vkms_output *vkms_output)
>  {
> -	struct drm_writeback_connector *wb = &vkmsdev->output.wb_connector;
> +	struct drm_writeback_connector *wb = &vkms_output->wb_connector;
>  
>  	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
>  
> 

