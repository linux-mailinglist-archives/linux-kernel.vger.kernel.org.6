Return-Path: <linux-kernel+bounces-396248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D949BCA0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6DD1C2158F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B21C1D1E92;
	Tue,  5 Nov 2024 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UxcGYJ85"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181418F2F7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801343; cv=none; b=DXt09eg/GtGV4QSyjXpB9tiHsMWR6L8lcRncXhtyj0G20KzT2elJVus98BKLvTcfuzSPccXsb2oeg/TBSemeRMb5dcuuN1yT7zbl/B2iCQ8qE2M5CKD4AqwxvYbahRtqR4V6OGYoUWYgqu4wnX0cCYkRtcNWm+PovDdYvJbBMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801343; c=relaxed/simple;
	bh=1xUUHvR9H5EN15X9bQ6LTU6fxM0cj/Pgw8eEIh08kGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnxOlGBbi9fX8bi8tLmaPWt6wkZKboYCoZ02TNlXXdABEcfpi8fN+Xbpydzu0uk9h8CADQru5lzyF66QLceu+9+dSWgL0P4sQ0moVZa8aB5Zv7puvcf02ajbtKyhP9iTyVdv4UhLVnL4PKMprQSd2FVzA7ymkTRrDvsORV1nz4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UxcGYJ85; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77DAAFF80A;
	Tue,  5 Nov 2024 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730801339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gVn/cMh8Wl18NRROTmyst1TqgNv8+GFVY44Ew2mfRTg=;
	b=UxcGYJ85V/2iYxN9EQi3a6vZsZfVF1VeMfDdq2UwnBlckOSHFMBaXZwoxfH0XADxeJI8Is
	IJ/tG43teVSZAe9WuD35yNsVg28FGOFf7MIZmq6I4ltVdMc+MjfKGrMPD6T/1uEDDq47z5
	08/eMHt3D0/8KZoR3GkLZbSBpu+LF2WutbCfpbbgd0hbPRhsKv9bNYmk6Kd3mHVUCRub5o
	u9XgXMnZXgNqSZ/Zw0qMOWCTpn4xnoeXUsJkse6ZUNbswbPfc3XjRRZ9Df3SShUmR0IUY4
	GJzKcsYpiHAKn5s5YXCYBY0FNE5hsGNcllq6ajUgwPedkpls7OwZB1GPBOeY6A==
Date: Tue, 5 Nov 2024 11:08:57 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Remove usage of legacy drm_crtc members
Message-ID: <ZynuubVyb7rOwy-r@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, thomas.petazzoni@bootlin.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241003-remove-legacy-v1-1-0b7db1f1a1a6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-remove-legacy-v1-1-0b7db1f1a1a6@bootlin.com>
X-GND-Sasl: louis.chauvet@bootlin.com

On 03/10/24 - 17:41, Louis Chauvet wrote:
> Some members of the drm_crtc structure have been deprecated in favor of
> equivalent members in the drm_crtc_state structure. As reported by Ville
> Syrjala [1], the VKMS driver was still using these deprecated fields. This
> commit updates the VKMS driver to use the new drm_crtc_state fields
> instead.
> 
> Additionally, this commit removes the call to
> `drm_calc_timestamping_constants` in `vkms_enable_vblank` as it is
> redundant. This calculation is already performed in
> `vkms_atomic_commit_tail` by calling
> `drm_atomic_helper_commit_modeset_disables`.
> 
> [1]:https://lore.kernel.org/all/20241002182200.15363-1-ville.syrjala@linux.intel.com/
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Applied on drm-misc-next:
https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/aafc45d5f88843a4645e1a53328a0601601d0c12

> ---
>  drivers/gpu/drm/vkms/vkms_composer.c  | 4 ++--
>  drivers/gpu/drm/vkms/vkms_crtc.c      | 2 --
>  drivers/gpu/drm/vkms/vkms_writeback.c | 4 ++--
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 57a5769fc994..3f0977d746be 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -187,7 +187,7 @@ static void blend(struct vkms_writeback_job *wb,
>  
>  	const struct pixel_argb_u16 background_color = { .a = 0xffff };
>  
> -	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
> +	size_t crtc_y_limit = crtc_state->base.mode.vdisplay;
>  
>  	/*
>  	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
> @@ -270,7 +270,7 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
>  	if (WARN_ON(check_format_funcs(crtc_state, active_wb)))
>  		return -EINVAL;
>  
> -	line_width = crtc_state->base.crtc->mode.hdisplay;
> +	line_width = crtc_state->base.mode.hdisplay;
>  	stage_buffer.n_pixels = line_width;
>  	output_buffer.n_pixels = line_width;
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index a40295c18b48..bbf080d32d2c 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -64,8 +64,6 @@ static int vkms_enable_vblank(struct drm_crtc *crtc)
>  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
>  
> -	drm_calc_timestamping_constants(crtc, &crtc->mode);
> -
>  	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	out->vblank_hrtimer.function = &vkms_vblank_simulate;
>  	out->period_ns = ktime_set(0, vblank->framedur_ns);
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index bc724cbd5e3a..999d5c01ea81 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -131,8 +131,8 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>  	struct drm_connector_state *conn_state = wb_conn->base.state;
>  	struct vkms_crtc_state *crtc_state = output->composer_state;
>  	struct drm_framebuffer *fb = connector_state->writeback_job->fb;
> -	u16 crtc_height = crtc_state->base.crtc->mode.vdisplay;
> -	u16 crtc_width = crtc_state->base.crtc->mode.hdisplay;
> +	u16 crtc_height = crtc_state->base.mode.vdisplay;
> +	u16 crtc_width = crtc_state->base.mode.hdisplay;
>  	struct vkms_writeback_job *active_wb;
>  	struct vkms_frame_info *wb_frame_info;
>  	u32 wb_format = fb->format->format;
> 
> ---
> base-commit: cbc1e8696fbea0010a73bf93534c712f9ad177db
> change-id: 20241003-remove-legacy-a2683a7bbcd5
> 
> Best regards,
> -- 
> Louis Chauvet <louis.chauvet@bootlin.com>
> 

