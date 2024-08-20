Return-Path: <linux-kernel+bounces-293589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F799581AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D24FB2133D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C351891A4;
	Tue, 20 Aug 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBCDTqYU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB218A948
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145018; cv=none; b=dAXB1CsR/FNgxR1lrqS+4HXt9Kc0cJ2ApD4Re8KvazOr8gkl+nYJ/SRRY75gJjNR5iRuafUaIkT1HF4Bo3z1pYL8MAGA1Dw040qBWtH5fjQQJFTFKAkhRszCH3qsmPQoX+dYDTOaIJ6yKP03HIjGI4aqnd7I3WES6HkOl4S2fNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145018; c=relaxed/simple;
	bh=MeAFzOudED/dB6xJk9oAfNPO9VFmDtdycOOtf0e39Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF/jx1kqtiWjdth26l+ifnOmH9tbjE69D7zQy9s7RGJeBpBrssorA6Ajek2zrzxrpx/PP0cfX2jeiC871LcYjJJJwcfb4xmjSqvkOFMWUqAIE1+sUbT3+sdXzDTfdsrpwPOzAAsr+KiKT2ZOAhFVDyN5xBxYn3hanww5vxFfp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBCDTqYU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42ab99fb45dso3254905e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724145014; x=1724749814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/kP+Pn/ve3Xzcvi7IGxpbzFoLLoU6eeHP8e/HCwF1A=;
        b=VBCDTqYURE1rnhCrK1rj7zgKfx40CWEQZNnnQf/gq4Hel6ltzRgGWYBqwNov+tSRti
         LlCwGefrH8Z3+FHj2KggxyzVMmX9jq70FdHKLxL4a8EI7hSpD55PBQTfBD4bZ58N5vLe
         TQP42cPDD+Dqr3Wie3w+TvRSAAcwOnGFqFpCYgcVJvnLBHR5T8NzbeXn29fbE6qwdX5e
         qFiZaJkbn88SRK69xz3EXvGVNKOPka5TGOMEaz2XROiEmuXuadDliFLzfL1twrsT/ZyF
         BefFNMeW4tGuF2wfW34AYu8APZkmmrhKVr1bt3HdQwYS/DVVeKuzn5SeYZc+A9lPeg1X
         DNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145014; x=1724749814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/kP+Pn/ve3Xzcvi7IGxpbzFoLLoU6eeHP8e/HCwF1A=;
        b=DyPatSu6WJyBWI5GjBXWTKM2zagCFMh0sbxNGl8VVZOVE7Zjexk0Guzo24DzQihceC
         yUXNk+6VKC9damm4cCm1eicjDKaXw3MHudHn5V32e25mejeKc3KEjDOEdnBl43ccbtzq
         gnViXTHeWiswwtJgtK8Uy74jU94NlbibUtjZm6+HGYRDghC6glBX03VRPCbX77uRpYEY
         nOrO4J1TsR3Nn9rSh8evgjiOS78uj0ruj7EFWZKnow0WRgzRsXKqT+2TAZIGVvQg3Ok3
         lDCsgqsMcBeJNGbskXYq5d29tZfs6L5FxmbW+Hzsq7f9DApqKIBZlDgtgNr15ndCm/yV
         Hxfw==
X-Forwarded-Encrypted: i=1; AJvYcCWpPaAvQNtmDLU9GNLf4EAm26hg+9pXbxslp56Sp5Tjx4y2wSScNLpbRzQ3vHytk/fjjxZZS5hv78UGt5aRKMsEPDkbs5rik3J0CXak
X-Gm-Message-State: AOJu0YxpQmJ0W+SsErH54Bo1GAP77JGhXX5coyFM9dQPB0IFYqDZMCa0
	r6+HVLrASG3OSBpyfpduvistzqlunZgA8F+9XEXC/oGIkUPQLHyA
X-Google-Smtp-Source: AGHT+IGFcscPMmejyRM+y4ZQO1fHfMnAliSy42Tib1wvSX0sX9Z9EOly9qbkcR8wQGBSegThW9UlDg==
X-Received: by 2002:a05:600c:208:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-429ed7d6481mr110885585e9.26.1724145014355;
        Tue, 20 Aug 2024 02:10:14 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849a9asm12510676f8f.45.2024.08.20.02.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:10:14 -0700 (PDT)
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
Subject: [PATCH RFC 4/4] drm/vkms: Rename all vkms_crtc instance to be
Date: Tue, 20 Aug 2024 11:10:09 +0200
Message-ID: <20240820091010.2902-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-vkms-managed-v1-4-7ab8b8921103@bootlin.com>
References: <20240814-google-vkms-managed-v1-4-7ab8b8921103@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I love how you made this an extra patch. I should have done the same thing in my
configfs series to reduce the diff :)

> To avoid inconsistency in the VKMS code, rename all struct vkms_crtc
> instances to vkms_crtc. This should not change the behavior of the driver.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_composer.c  | 30 ++++++++++----------
>  drivers/gpu/drm/vkms/vkms_composer.h  |  2 +-
>  drivers/gpu/drm/vkms/vkms_crtc.c      | 52 +++++++++++++++++------------------
>  drivers/gpu/drm/vkms/vkms_writeback.c | 12 ++++----
>  4 files changed, 48 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 9b2f578c2eb1..4376900b4986 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -515,13 +515,13 @@ void vkms_composer_worker(struct work_struct *work)
>  							  composer_work);
>  	struct drm_crtc *crtc = crtc_state->base.crtc;
>  	struct vkms_writeback_job *active_wb = crtc_state->active_writeback;
> -	struct vkms_crtc *out = drm_crtc_to_vkms_crtc(crtc);
> +	struct vkms_crtc *vkms_crtc = drm_crtc_to_vkms_crtc(crtc);
>  	bool crc_pending, wb_pending;
>  	u64 frame_start, frame_end;
>  	u32 crc32 = 0;
>  	int ret;
>  
> -	spin_lock_irq(&out->composer_lock);
> +	spin_lock_irq(&vkms_crtc->composer_lock);
>  	frame_start = crtc_state->frame_start;
>  	frame_end = crtc_state->frame_end;
>  	crc_pending = crtc_state->crc_pending;
> @@ -545,7 +545,7 @@ void vkms_composer_worker(struct work_struct *work)
>  		crtc_state->gamma_lut.base = NULL;
>  	}
>  
> -	spin_unlock_irq(&out->composer_lock);
> +	spin_unlock_irq(&vkms_crtc->composer_lock);
>  
>  	/*
>  	 * We raced with the vblank hrtimer and previous work already computed
> @@ -563,10 +563,10 @@ void vkms_composer_worker(struct work_struct *work)
>  		return;
>  
>  	if (wb_pending) {
> -		drm_writeback_signal_completion(&out->wb_connector, 0);
> -		spin_lock_irq(&out->composer_lock);
> +		drm_writeback_signal_completion(&vkms_crtc->wb_connector, 0);
> +		spin_lock_irq(&vkms_crtc->composer_lock);
>  		crtc_state->wb_pending = false;
> -		spin_unlock_irq(&out->composer_lock);
> +		spin_unlock_irq(&vkms_crtc->composer_lock);
>  	}
>  
>  	/*
> @@ -616,31 +616,31 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
>  	return 0;
>  }
>  
> -void vkms_set_composer(struct vkms_crtc *out, bool enabled)
> +void vkms_set_composer(struct vkms_crtc *vkms_crtc, bool enabled)
>  {
>  	bool old_enabled;
>  
>  	if (enabled)
> -		drm_crtc_vblank_get(&out->base);
> +		drm_crtc_vblank_get(&vkms_crtc->base);
>  
> -	spin_lock_irq(&out->lock);
> -	old_enabled = out->composer_enabled;
> -	out->composer_enabled = enabled;
> -	spin_unlock_irq(&out->lock);
> +	spin_lock_irq(&vkms_crtc->lock);
> +	old_enabled = vkms_crtc->composer_enabled;
> +	vkms_crtc->composer_enabled = enabled;
> +	spin_unlock_irq(&vkms_crtc->lock);
>  
>  	if (old_enabled)
> -		drm_crtc_vblank_put(&out->base);
> +		drm_crtc_vblank_put(&vkms_crtc->base);
>  }
>  
>  int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
>  {
> -	struct vkms_crtc *out = drm_crtc_to_vkms_crtc(crtc);
> +	struct vkms_crtc *vkms_crtc = drm_crtc_to_vkms_crtc(crtc);
>  	bool enabled = false;
>  	int ret = 0;
>  
>  	ret = vkms_crc_parse_source(src_name, &enabled);
>  
> -	vkms_set_composer(out, enabled);
> +	vkms_set_composer(vkms_crtc, enabled);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.h b/drivers/gpu/drm/vkms/vkms_composer.h
> index 77efd2e3a63a..5a676b9960aa 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.h
> +++ b/drivers/gpu/drm/vkms/vkms_composer.h
> @@ -7,7 +7,7 @@
>  #include "vkms_crtc.h"
>  
>  void vkms_composer_worker(struct work_struct *work);
> -void vkms_set_composer(struct vkms_crtc *out, bool enabled);
> +void vkms_set_composer(struct vkms_crtc *vkms_crtc, bool enabled);
>  
>  /* CRC Support */
>  const char *const *vkms_get_crc_sources(struct drm_crtc *crtc, size_t *count);
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 47e62fb3e404..6f6d3118b2f2 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -16,34 +16,34 @@
>  
>  static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
>  {
> -	struct vkms_crtc *output = hrtimer_to_vkms_crtc(timer);
> -	struct drm_crtc *crtc = &output->base;
> +	struct vkms_crtc *vkms_crtc = hrtimer_to_vkms_crtc(timer);
> +	struct drm_crtc *crtc = &vkms_crtc->base;
>  	struct vkms_crtc_state *state;
>  	u64 ret_overrun;
>  	bool ret, fence_cookie;
>  
>  	fence_cookie = dma_fence_begin_signalling();
>  
> -	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
> -					  output->period_ns);
> +	ret_overrun = hrtimer_forward_now(&vkms_crtc->vblank_hrtimer,
> +					  vkms_crtc->period_ns);
>  	if (ret_overrun != 1)
>  		pr_warn("%s: vblank timer overrun\n", __func__);
>  
> -	spin_lock(&output->lock);
> +	spin_lock(&vkms_crtc->lock);
>  	ret = drm_crtc_handle_vblank(crtc);
>  	if (!ret)
>  		DRM_ERROR("vkms failure on handling vblank");
>  
> -	state = output->composer_state;
> -	spin_unlock(&output->lock);
> +	state = vkms_crtc->composer_state;
> +	spin_unlock(&vkms_crtc->lock);
>  
> -	if (state && output->composer_enabled) {
> +	if (state && vkms_crtc->composer_enabled) {
>  		u64 frame = drm_crtc_accurate_vblank_count(crtc);
>  
>  		/* update frame_start only if a queued vkms_composer_worker()
>  		 * has read the data
>  		 */
> -		spin_lock(&output->composer_lock);
> +		spin_lock(&vkms_crtc->composer_lock);
>  		if (!state->crc_pending)
>  			state->frame_start = frame;
>  		else
> @@ -51,9 +51,9 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
>  					 state->frame_start, frame);
>  		state->frame_end = frame;
>  		state->crc_pending = true;
> -		spin_unlock(&output->composer_lock);
> +		spin_unlock(&vkms_crtc->composer_lock);
>  
> -		ret = queue_work(output->composer_workq, &state->composer_work);
> +		ret = queue_work(vkms_crtc->composer_workq, &state->composer_work);
>  		if (!ret)
>  			DRM_DEBUG_DRIVER("Composer worker already queued\n");
>  	}
> @@ -67,23 +67,23 @@ static int vkms_enable_vblank(struct drm_crtc *crtc)
>  {
>  	struct drm_device *dev = crtc->dev;
>  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
> -	struct vkms_crtc *out = drm_crtc_to_vkms_crtc(crtc);
> +	struct vkms_crtc *vkms_crtc = drm_crtc_to_vkms_crtc(crtc);
>  
>  	drm_calc_timestamping_constants(crtc, &crtc->mode);
>  
> -	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -	out->vblank_hrtimer.function = &vkms_vblank_simulate;
> -	out->period_ns = ktime_set(0, vblank->framedur_ns);
> -	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
> +	hrtimer_init(&vkms_crtc->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	vkms_crtc->vblank_hrtimer.function = &vkms_vblank_simulate;
> +	vkms_crtc->period_ns = ktime_set(0, vblank->framedur_ns);
> +	hrtimer_start(&vkms_crtc->vblank_hrtimer, vkms_crtc->period_ns, HRTIMER_MODE_REL);
>  
>  	return 0;
>  }
>  
>  static void vkms_disable_vblank(struct drm_crtc *crtc)
>  {
> -	struct vkms_crtc *out = drm_crtc_to_vkms_crtc(crtc);
> +	struct vkms_crtc *vkms_crtc = drm_crtc_to_vkms_crtc(crtc);
>  
> -	hrtimer_cancel(&out->vblank_hrtimer);
> +	hrtimer_cancel(&vkms_crtc->vblank_hrtimer);
>  }
>  
>  static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
> @@ -91,7 +91,7 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
>  				      bool in_vblank_irq)
>  {
>  	struct drm_device *dev = crtc->dev;
> -	struct vkms_crtc *output = drm_crtc_to_vkms_crtc(crtc);
> +	struct vkms_crtc *vkms_crtc = drm_crtc_to_vkms_crtc(crtc);
>  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>  
>  	if (!READ_ONCE(vblank->enabled)) {
> @@ -99,7 +99,7 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
>  		return true;
>  	}
>  
> -	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
> +	*vblank_time = READ_ONCE(vkms_crtc->vblank_hrtimer.node.expires);
>  
>  	if (WARN_ON(*vblank_time == vblank->time))
>  		return true;
> @@ -111,7 +111,7 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
>  	 * the vblank core expects. Therefore we need to always correct the
>  	 * timestampe by one frame.
>  	 */
> -	*vblank_time -= output->period_ns;
> +	*vblank_time -= vkms_crtc->period_ns;
>  
>  	return true;
>  }
> @@ -235,18 +235,18 @@ static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
>  static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
>  				   struct drm_atomic_state *state)
>  {
> -	struct vkms_crtc *vkms_output = drm_crtc_to_vkms_crtc(crtc);
> +	struct vkms_crtc *vkms_crtc = drm_crtc_to_vkms_crtc(crtc);
>  
>  	/* This lock is held across the atomic commit to block vblank timer
>  	 * from scheduling vkms_composer_worker until the composer is updated
>  	 */
> -	spin_lock_irq(&vkms_output->lock);
> +	spin_lock_irq(&vkms_crtc->lock);
>  }
>  
>  static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
>  				   struct drm_atomic_state *state)
>  {
> -	struct vkms_crtc *vkms_output = drm_crtc_to_vkms_crtc(crtc);
> +	struct vkms_crtc *vkms_crtc = drm_crtc_to_vkms_crtc(crtc);
>  
>  	if (crtc->state->event) {
>  		spin_lock(&crtc->dev->event_lock);
> @@ -261,9 +261,9 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
>  		crtc->state->event = NULL;
>  	}
>  
> -	vkms_output->composer_state = drm_crtc_state_to_vkms_crtc_state(crtc->state);
> +	vkms_crtc->composer_state = drm_crtc_state_to_vkms_crtc_state(crtc->state);
>  
> -	spin_unlock_irq(&vkms_output->lock);
> +	spin_unlock_irq(&vkms_crtc->lock);
>  }
>  
>  static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 322e247979b2..69c710f21e57 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -128,9 +128,9 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>  {
>  	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
>  											 conn);
> -	struct vkms_crtc *output = drm_crtc_to_vkms_crtc(connector_state->crtc);
> -	struct drm_writeback_connector *wb_conn = &output->wb_connector;
> -	struct vkms_crtc_state *crtc_state = output->composer_state;
> +	struct vkms_crtc *vkms_crtc = drm_crtc_to_vkms_crtc(connector_state->crtc);
> +	struct drm_writeback_connector *wb_conn = &vkms_crtc->wb_connector;
> +	struct vkms_crtc_state *crtc_state = vkms_crtc->composer_state;
>  	struct drm_framebuffer *fb = connector_state->writeback_job->fb;
>  	u16 crtc_height = crtc_state->base.crtc->mode.vdisplay;
>  	u16 crtc_width = crtc_state->base.crtc->mode.hdisplay;
> @@ -141,15 +141,15 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>  	if (!connector_state)
>  		return;
>  
> -	vkms_set_composer(output, true);
> +	vkms_set_composer(vkms_crtc, true);
>  
>  	active_wb = connector_state->writeback_job->priv;
>  	wb_frame_info = &active_wb->wb_frame_info;
>  
> -	spin_lock_irq(&output->composer_lock);
> +	spin_lock_irq(&vkms_crtc->composer_lock);
>  	crtc_state->active_writeback = active_wb;
>  	crtc_state->wb_pending = true;
> -	spin_unlock_irq(&output->composer_lock);
> +	spin_unlock_irq(&vkms_crtc->composer_lock);
>  	drm_writeback_queue_job(wb_conn, connector_state);
>  	active_wb->pixel_write = get_pixel_write_line_function(wb_format);
>  	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);

