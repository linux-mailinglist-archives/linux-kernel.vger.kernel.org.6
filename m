Return-Path: <linux-kernel+bounces-429743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41A29E225C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55E528185F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04961F755B;
	Tue,  3 Dec 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn9dP7oe"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1722D7BF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239394; cv=none; b=Luz/Nar4MRmyxro+kGZuCAE1uIGASYz8QsynE4/0zbAh6ll1XEBzw6u+bE6ZoQ7+8geXU1WjuUvDmfJlk87zfm6Vdv39jkxC0CnPLk1pMXrrx4ApJhUXsgSgOVHM9qMW0FZkAtt8ZkryNNBRE2Hj5SJszcdekAQPX9SHNbwGtMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239394; c=relaxed/simple;
	bh=brepOeS7n5X+UWWcbVubxKFFGZ0LiN2Cr5JnlKHLeq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJGqhjO26pxE0n8I5N1USwKHGYQmmCxkoSo7N67NYMicTLdz31BzPyPx7M2r0I9KzJ26C55KF/HlLYZHPykO8dayrJISE6Ha1s88lCOLNTwECnPEA/s7f38PfU/Gr6270bkwM4JtcHF7rm5nhqRIc1kbfhb41DEu3mfD1RFkajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn9dP7oe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349fb56260so49618975e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733239390; x=1733844190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tH9mD1nqqP2Ca+mLMpBrk6uGXtWUB0Ty3khrHJQfmQ=;
        b=Mn9dP7oep5K05CytJny9wXHKLzkpB1XOCsT4FooP9BVyut+SKY7ovMKMSy2LlRmL+N
         KV2IvxckSniq1h9jsLxCnJXfFEvE83f1fkDtTheqwf2a1fdsr3xHZ2oSO24WHvNmPMoV
         jWqxBj/NsWoonlWBErIX+pzpfRk6GZDYZiebctWcXJG83Udg73K+7iNZdTHzN+1lL6h4
         CO9Uxh21y9DvRnJ49g5qk0TXYCFhUnlisYSOmweKsCH5HoYniKQ35mc6HDnJH5bx/0VN
         wGjRMFNwzq+0KH9cv2ZIzZR4H7a6GbEo15FTUylPCBSBft3GN3N4v+ZdXABxqopG8op3
         PrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239390; x=1733844190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tH9mD1nqqP2Ca+mLMpBrk6uGXtWUB0Ty3khrHJQfmQ=;
        b=XURQYhie/obXnjqkI+tpQr5wOBfn/BJihwzsx+F8ikipI/pI7dmFT6NF24P3iRkBN8
         KQWqiPCAGeIPi9ibcL19d/yytqhu6OIoyBHBNqTkwoboORJwRrEOYUG/o+33BRogGTq7
         +MkdfRbayR7NUnNWptfFL/nqL6cZHP2b7B9iwxnuGhPtDXgQBR+BCKmpSZbukBQTPhJw
         WCMsyHcjp4laulm21MbU3XsvIwTUAfWvSAoVOCL4D0mgjhIueIU+efBfoGWb9ZC66nLR
         C9Uxn294jZ3xSUkGp0J3wGb43zBH3NpUFiDj/NJy8FDmvbX2H6TbZafniO8m3OirdgYM
         ZYTA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Hi/0wzhSmnzundN3CV4a+YVuX2Cju9u4liBkzzrgS0ZkYQqrYR/3IqI+5m0LkOkt66mnMgjVizGVFK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9YEF6Yxev2oOxOkQMCe+P0Z55z3RhEqHkY3jheWfkUxEKVVV
	12NngMt00pXvQRWnZLZswqRmT0qwgAiw3HnB7JJ0Z+PdB21UBc1APbrW2tLD
X-Gm-Gg: ASbGncvxGwGhHN1jinc+HEuabw4+giPeh7hFsnHTLhfeGRYKiaMpCoflWp7nOno7n36
	5BFvk/KxmvXB50oknQTkV1Xch2XXyt2VfSca1LPig1S6BSrgU7KvcETYICz7tNXU4vykBb8QQPi
	GSm0kPlDiMDuREITVmRLCR68GuhJQVl5Ryw8ltx7nK7zOchRB8iGHwzTUHI4Ykm/ocBBiZ4gW1n
	Q/kCys2XyiSwOvzbJMPlzS44F/1MuyU/u/JeOVXhkOtdl64Y94=
X-Google-Smtp-Source: AGHT+IEqZ54qZ4pc8Wj9oHk5qi/L7jSC2q/MmK6rQsOqzNDfLgxnJWBQYuQ8BXOPyJXb5Ki9ZPGMUA==
X-Received: by 2002:a05:600c:3546:b0:434:9fb5:fddd with SMTP id 5b1f17b1804b1-434d0a07350mr21493555e9.23.1733239390032;
        Tue, 03 Dec 2024 07:23:10 -0800 (PST)
Received: from fedora.. ([213.94.26.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2e1bdsm16235462f8f.9.2024.12.03.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:23:09 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	melissa.srw@gmail.com,
	mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com,
	simona.vetter@ffwll.ch,
	simona@ffwll.ch,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 3/4] drm/vkms: Switch to dynamic allocation for CRTC
Date: Tue,  3 Dec 2024 16:23:05 +0100
Message-ID: <20241203152306.3018-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241122-b4-vkms-allocated-v2-3-ff7bddbf0bfb@bootlin.com>
References: <20241122-b4-vkms-allocated-v2-3-ff7bddbf0bfb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Louis,

Patches 1 and 2:

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

I noticed a bug in this patch:

> A specific allocation for the CRTC is not strictly necessary at this point,
> but in order to implement dynamic configuration of VKMS (configFS), it
> will be easier to have one allocation per CRTC.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c      | 32 +++++++++++++++++---------------
>  drivers/gpu/drm/vkms/vkms_drv.h       |  9 +++++----
>  drivers/gpu/drm/vkms/vkms_output.c    | 26 +++++++++++++++-----------
>  drivers/gpu/drm/vkms/vkms_writeback.c | 17 +++++++++--------
>  4 files changed, 46 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index ace8d293f7da611110c1e117b6cf2f3c9e9b4381..d014dec117e7d4ec7e9e38037a4a4cb4bc6be4ca 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -84,9 +84,7 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
>  				      int *max_error, ktime_t *vblank_time,
>  				      bool in_vblank_irq)
>  {
> -	struct drm_device *dev = crtc->dev;
> -	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
> -	struct vkms_output *output = &vkmsdev->output;
> +	struct vkms_output *output = drm_crtc_to_vkms_output(crtc);
>  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>  
>  	if (!READ_ONCE(vblank->enabled)) {
> @@ -279,25 +277,29 @@ static void vkms_crtc_destroy_workqueue(struct drm_device *dev,
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
>  	ret = drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
>  	if (ret) {
>  		DRM_ERROR("Failed to set gamma size\n");
> -		return ret;
> +		return ERR_PTR(ret);
>  	}
>  
>  	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_LUT_SIZE);
> @@ -307,12 +309,12 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
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
> index 19fd99b8e506c4454d7878b67f692a0441c22665..fbe7de67fb9c6a6a6964d71b452b9a3ce573e0f8 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -214,7 +214,6 @@ struct vkms_config {
>  struct vkms_device {
>  	struct drm_device drm;
>  	struct platform_device *platform;
> -	struct vkms_output output;
>  	const struct vkms_config *config;
>  };
>  
> @@ -241,8 +240,9 @@ struct vkms_device {
>   * @primary: primary plane to attach to the CRTC
>   * @cursor: plane to attach to the CRTC
>   */
> -int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> -		   struct drm_plane *primary, struct drm_plane *cursor);
> +struct vkms_output *vkms_crtc_init(struct drm_device *dev,
> +				   struct drm_plane *primary,
> +				   struct drm_plane *cursor);
>  
>  /**
>   * vkms_output_init() - Initialize all sub-components needed for a VKMS device.
> @@ -273,6 +273,7 @@ void vkms_set_composer(struct vkms_output *out, bool enabled);
>  void vkms_writeback_row(struct vkms_writeback_job *wb, const struct line_buffer *src_buffer, int y);
>  
>  /* Writeback */
> -int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
> +int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
> +				    struct vkms_output *vkms_out);
>  
>  #endif /* _VKMS_DRV_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 102b6ad466cb4f7c6704f30cea669e5d7f81540a..6a5cf6e7714938f23b4276a96991d05431bcd76e 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -30,11 +30,10 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
>  
>  int vkms_output_init(struct vkms_device *vkmsdev)
>  {
> -	struct vkms_output *output = &vkmsdev->output;
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct drm_connector *connector;
>  	struct drm_encoder *encoder;
> -	struct drm_crtc *crtc = &output->crtc;
> +	struct vkms_output *output;
>  	struct vkms_plane *primary, *overlay, *cursor = NULL;
>  	int ret;
>  	int writeback;
> @@ -56,9 +55,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
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
> @@ -67,7 +69,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  				DRM_DEV_ERROR(dev->dev, "Failed to init vkms plane\n");
>  				return PTR_ERR(overlay);
>  			}
> -			overlay->base.possible_crtcs = drm_crtc_mask(crtc);
> +			overlay->base.possible_crtcs = drm_crtc_mask(&output->crtc);
>  		}
>  	}
>  
> @@ -97,23 +99,25 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  		DRM_ERROR("Failed to init encoder\n");
>  		return ret;
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

In case of error "if (writeback)", you are returning "ret", which must
be 0 at this point.

I'm not sure if it is a bug using the wrong variable or you want to keep
the previous behaviour. If that's the case, the code used the call
drm_mode_config_reset() before this change.

> +		}
>  	}
>  
>  	drm_mode_config_reset(dev);
>  
>  	return 0;
> -
> -	return ret;
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index f12417b2d24803a33e4ff56108cc89704a500faf..c9b6e161fa8698491f20082dfe0b713f27bcb918 100644
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
> @@ -162,9 +162,10 @@ static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
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

