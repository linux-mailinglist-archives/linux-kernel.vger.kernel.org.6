Return-Path: <linux-kernel+bounces-391335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C49B8551
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73591F219C5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148821CEE92;
	Thu, 31 Oct 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCPWomfm"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F341BB6B5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410166; cv=none; b=QoQm6qxNh5X6ePBnRVx1YV6atLLC/+X8wEyJb/DZ+ZBc7Jq7dN8hjP7upbVSFyR/ConQzqa0f7jIHucYqkWsasy4VHiaPWjUQ+RQwTOiJjdhZtotaPRQPodJ62rJlK61z9E9kgM4gyucx2Emp12UvkcgGyuCrpEPW30W1BH+kUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410166; c=relaxed/simple;
	bh=cic8EZjp0h4SGVLg71GYeonoCVfxQqLHbU/PNKJKOHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7BCtLfZfJdCkISlu7UMc1BtiH0oAv/IZIe0qXIy9KCjlLC5ynXLRY8MQ+rrDTUcN1QOJXN4LBKTN7OaTPgTrk75NKa1kPhiUswnlZXZy0YPFXieqqRzHg9JUEI+9uv+U7NbBNmc4vVSalVA0sGjJl6S57FYEfdPsemRGzZF4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NCPWomfm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53a007743e7so1586023e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730410158; x=1731014958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1l+3xHgYCCQq5nw49XrfIzxDUYa4w0dQBbc1QfIfgMQ=;
        b=NCPWomfmsohFfOKaOGsXHEZlmM+fEz//YPS6TdgWTqIcdaj9IzDAsZ7UdNMDk3lgvO
         H9r0WTAzAXr9ZMfcuGwfSJUl5xkwQvN0lKpN7C+w1p3wnVZhVD4xSV/zsaNoIusYagAH
         hotLZzBQedjHDSet79g7m0/9lQVy1fGxYvt8+Wx0lx/Yzw2/or/Bm496az+h2H3fQ1t1
         WJp1cXvKK9L2tUQYAsyMnHdzQCaS8nxlZOIeBVa+y07J4qoUsTzk57B6CMWaQlIKF17M
         fBSggkj4UmtLHCfX2ag5NSPdSsd/rkpSfVV83Qdo/DuW2+FGlnFzDvUa1gqLVK5a/TG1
         gsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730410158; x=1731014958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l+3xHgYCCQq5nw49XrfIzxDUYa4w0dQBbc1QfIfgMQ=;
        b=HpnDNrRzQkJINP+sOX5Cxb+t2f68xfPnLt1Nm52o6fTWwBM5A3vFvTNpWNnHFsi/fl
         cWgEJKzggM5LqoEZ52ZZNOzmI4jfjKNcZHiwq6z74jYGnFtyOnkwICIo5GR9Nbb8mHjq
         kL6raQF4Vrgs7GVZToC793cNs2bIr29WcepECpJyItdyzrX7MCyJatPMb1c+BKQmC8oS
         ePwTdSYtxZcAIRiGUDLWc5H2xHdArI8HXkuW+/+9H2lc9yQnL6IRhAEQ+E0rjih1bxY4
         JVvMvNZluX8KnyE3gtnUjap2O8YfFaII8maWBDeZLIr9GDPOnuy+hcJJzkLW8N/H9ILQ
         OyAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU16ApZsLxXwcKhCcbI267nt+FcXYoFtvTb7KVNIF1HUez1v63c9mozbejDzimvddmSKuCHVbXKVB0pMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQ/W4B96q7Jp83yIbREbfNLV7HNGWF3d4LhMQEKKB2pTLShZS
	Byroz0HyJYO0ifkW03ApSy7sI/yscBprAtCvKmGexeXW45hLtYndV6U+TWy2U/g=
X-Google-Smtp-Source: AGHT+IGpv6ppMeT9Im8LWxqb/D03OQxodp9BRRepLf/IM+4jvPsQKd80qXzkkdEoHhs7i1sjnsTOdw==
X-Received: by 2002:ac2:4e14:0:b0:539:d9e2:9d15 with SMTP id 2adb3069b0e04-53c79e4b459mr2526803e87.29.1730410157377;
        Thu, 31 Oct 2024 14:29:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bccd6b3sm329876e87.147.2024.10.31.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:29:15 -0700 (PDT)
Date: Thu, 31 Oct 2024 23:29:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v3 03/23] drm/msm/dpu: get rid of struct
 dpu_rm_requirements
Message-ID: <rc4v6jzq2qtjpt5ehvjqhnh24v5ny4fm4lavlkgt6qcv4g44qm@bqt7h4b2szrt>
References: <20241016-concurrent-wb-v3-0-a33cf9b93835@quicinc.com>
 <20241016-concurrent-wb-v3-3-a33cf9b93835@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-concurrent-wb-v3-3-a33cf9b93835@quicinc.com>

On Wed, Oct 16, 2024 at 06:21:09PM -0700, Jessica Zhang wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> The struct dpu_rm_requirements was used to wrap display topology and
> hw resources, which meant INTF indices. As of commit ef58e0ad3436
> ("drm/msm/dpu: get INTF blocks directly rather than through RM") the hw
> resources struct was removed, leaving struct dpu_rm_requirements
> containing a single field (topology). Remove the useless wrapper.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 71 ++++++++++-------------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h      |  2 +-
>  3 files changed, 25 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 3b171bf227d16f301545eefeac1e2bf61085b218..6293e716a1c3ae8ba07c0ee76f61766fdaab0710 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -691,7 +691,7 @@ static int dpu_encoder_virt_atomic_check(
>  
>  		if (!crtc_state->active_changed || crtc_state->enable)
>  			ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
> -					drm_enc, crtc_state, topology);
> +					drm_enc, crtc_state, &topology);
>  	}
>  
>  	trace_dpu_enc_atomic_check_flags(DRMID(drm_enc), adj_mode->flags);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index 44938ba7a2b7e618735447e0af51e91f9fa3242a..8193c3d579dfc86b0fb8395ba60b7b1f5137413f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
> +#include "msm_drv.h"

pr_fmt should be defined before all the includes. And anyway, we should
probably move msm_display_topology to the DPU-specific header.

>  #define pr_fmt(fmt)	"[drm:%s] " fmt, __func__
>  #include "dpu_kms.h"
>  #include "dpu_hw_lm.h"
> @@ -26,14 +27,6 @@ static inline bool reserved_by_other(uint32_t *res_map, int idx,
>  	return res_map[idx] && res_map[idx] != enc_id;
>  }
>  
> -/**
> - * struct dpu_rm_requirements - Reservation requirements parameter bundle
> - * @topology:  selected topology for the display
> - */
> -struct dpu_rm_requirements {
> -	struct msm_display_topology topology;
> -};
> -
>  int dpu_rm_init(struct drm_device *dev,
>  		struct dpu_rm *rm,
>  		const struct dpu_mdss_cfg *cat,
> @@ -231,14 +224,13 @@ static int _dpu_rm_get_lm_peer(struct dpu_rm *rm, int primary_idx)
>   *      mixer in rm->pingpong_blks[].
>   * @dspp_idx: output parameter, index of dspp block attached to the layer
>   *      mixer in rm->dspp_blks[].
> - * @reqs: input parameter, rm requirements for HW blocks needed in the
> - *      datapath.
> + * @topology:  selected topology for the display
>   * Return: true if lm matches all requirements, false otherwise
>   */
>  static bool _dpu_rm_check_lm_and_get_connected_blks(struct dpu_rm *rm,
>  		struct dpu_global_state *global_state,
>  		uint32_t enc_id, int lm_idx, int *pp_idx, int *dspp_idx,
> -		struct dpu_rm_requirements *reqs)
> +		struct msm_display_topology *topology)
>  {
>  	const struct dpu_lm_cfg *lm_cfg;
>  	int idx;
> @@ -263,7 +255,7 @@ static bool _dpu_rm_check_lm_and_get_connected_blks(struct dpu_rm *rm,
>  	}
>  	*pp_idx = idx;
>  
> -	if (!reqs->topology.num_dspp)
> +	if (!topology->num_dspp)
>  		return true;
>  
>  	idx = lm_cfg->dspp - DSPP_0;
> @@ -285,7 +277,7 @@ static bool _dpu_rm_check_lm_and_get_connected_blks(struct dpu_rm *rm,
>  static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
>  			       struct dpu_global_state *global_state,
>  			       uint32_t enc_id,
> -			       struct dpu_rm_requirements *reqs)
> +			       struct msm_display_topology *topology)
>  
>  {
>  	int lm_idx[MAX_BLOCKS];
> @@ -293,14 +285,14 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
>  	int dspp_idx[MAX_BLOCKS] = {0};
>  	int i, lm_count = 0;
>  
> -	if (!reqs->topology.num_lm) {
> -		DPU_ERROR("invalid number of lm: %d\n", reqs->topology.num_lm);
> +	if (!topology->num_lm) {
> +		DPU_ERROR("invalid number of lm: %d\n", topology->num_lm);
>  		return -EINVAL;
>  	}
>  
>  	/* Find a primary mixer */
>  	for (i = 0; i < ARRAY_SIZE(rm->mixer_blks) &&
> -			lm_count < reqs->topology.num_lm; i++) {
> +			lm_count < topology->num_lm; i++) {
>  		if (!rm->mixer_blks[i])
>  			continue;
>  
> @@ -309,14 +301,14 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
>  
>  		if (!_dpu_rm_check_lm_and_get_connected_blks(rm, global_state,
>  				enc_id, i, &pp_idx[lm_count],
> -				&dspp_idx[lm_count], reqs)) {
> +				&dspp_idx[lm_count], topology)) {
>  			continue;
>  		}
>  
>  		++lm_count;
>  
>  		/* Valid primary mixer found, find matching peers */
> -		if (lm_count < reqs->topology.num_lm) {
> +		if (lm_count < topology->num_lm) {
>  			int j = _dpu_rm_get_lm_peer(rm, i);
>  
>  			/* ignore the peer if there is an error or if the peer was already processed */
> @@ -329,7 +321,7 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
>  			if (!_dpu_rm_check_lm_and_get_connected_blks(rm,
>  					global_state, enc_id, j,
>  					&pp_idx[lm_count], &dspp_idx[lm_count],
> -					reqs)) {
> +					topology)) {
>  				continue;
>  			}
>  
> @@ -338,7 +330,7 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
>  		}
>  	}
>  
> -	if (lm_count != reqs->topology.num_lm) {
> +	if (lm_count != topology->num_lm) {
>  		DPU_DEBUG("unable to find appropriate mixers\n");
>  		return -ENAVAIL;
>  	}
> @@ -347,7 +339,7 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
>  		global_state->mixer_to_enc_id[lm_idx[i]] = enc_id;
>  		global_state->pingpong_to_enc_id[pp_idx[i]] = enc_id;
>  		global_state->dspp_to_enc_id[dspp_idx[i]] =
> -			reqs->topology.num_dspp ? enc_id : 0;
> +			topology->num_dspp ? enc_id : 0;
>  
>  		trace_dpu_rm_reserve_lms(lm_idx[i] + LM_0, enc_id,
>  					 pp_idx[i] + PINGPONG_0);
> @@ -584,28 +576,28 @@ static int _dpu_rm_make_reservation(
>  		struct dpu_rm *rm,
>  		struct dpu_global_state *global_state,
>  		struct drm_encoder *enc,
> -		struct dpu_rm_requirements *reqs)
> +		struct msm_display_topology *topology)
>  {
>  	int ret;
>  
> -	ret = _dpu_rm_reserve_lms(rm, global_state, enc->base.id, reqs);
> +	ret = _dpu_rm_reserve_lms(rm, global_state, enc->base.id, topology);
>  	if (ret) {
>  		DPU_ERROR("unable to find appropriate mixers\n");
>  		return ret;
>  	}
>  
>  	ret = _dpu_rm_reserve_ctls(rm, global_state, enc->base.id,
> -				&reqs->topology);
> +			topology);
>  	if (ret) {
>  		DPU_ERROR("unable to find appropriate CTL\n");
>  		return ret;
>  	}
>  
> -	ret  = _dpu_rm_reserve_dsc(rm, global_state, enc, &reqs->topology);
> +	ret  = _dpu_rm_reserve_dsc(rm, global_state, enc, topology);
>  	if (ret)
>  		return ret;
>  
> -	if (reqs->topology.needs_cdm) {
> +	if (topology->needs_cdm) {
>  		ret = _dpu_rm_reserve_cdm(rm, global_state, enc);
>  		if (ret) {
>  			DPU_ERROR("unable to find CDM blk\n");
> @@ -616,20 +608,6 @@ static int _dpu_rm_make_reservation(
>  	return ret;
>  }
>  
> -static int _dpu_rm_populate_requirements(
> -		struct drm_encoder *enc,
> -		struct dpu_rm_requirements *reqs,
> -		struct msm_display_topology req_topology)
> -{
> -	reqs->topology = req_topology;
> -
> -	DRM_DEBUG_KMS("num_lm: %d num_dsc: %d num_intf: %d cdm: %d\n",
> -		      reqs->topology.num_lm, reqs->topology.num_dsc,
> -		      reqs->topology.num_intf, reqs->topology.needs_cdm);
> -
> -	return 0;
> -}
> -
>  static void _dpu_rm_clear_mapping(uint32_t *res_mapping, int cnt,
>  				  uint32_t enc_id)
>  {
> @@ -662,9 +640,8 @@ int dpu_rm_reserve(
>  		struct dpu_global_state *global_state,
>  		struct drm_encoder *enc,
>  		struct drm_crtc_state *crtc_state,
> -		struct msm_display_topology topology)
> +		struct msm_display_topology *topology)
>  {
> -	struct dpu_rm_requirements reqs;
>  	int ret;
>  
>  	/* Check if this is just a page-flip */
> @@ -679,13 +656,11 @@ int dpu_rm_reserve(
>  	DRM_DEBUG_KMS("reserving hw for enc %d crtc %d\n",
>  		      enc->base.id, crtc_state->crtc->base.id);
>  
> -	ret = _dpu_rm_populate_requirements(enc, &reqs, topology);
> -	if (ret) {
> -		DPU_ERROR("failed to populate hw requirements\n");
> -		return ret;
> -	}
> +	DRM_DEBUG_KMS("num_lm: %d num_dsc: %d num_intf: %d\n",
> +		      topology->num_lm, topology->num_dsc,
> +		      topology->num_intf);
>  
> -	ret = _dpu_rm_make_reservation(rm, global_state, enc, &reqs);
> +	ret = _dpu_rm_make_reservation(rm, global_state, enc, topology);
>  	if (ret)
>  		DPU_ERROR("failed to reserve hw resources: %d\n", ret);
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> index e63db8ace6b940c48e081c9e11926788f6e333a3..62cc2edd2ee03f4acdba99c65ac94c8ac7b7fbf7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> @@ -70,7 +70,7 @@ int dpu_rm_reserve(struct dpu_rm *rm,
>  		struct dpu_global_state *global_state,
>  		struct drm_encoder *drm_enc,
>  		struct drm_crtc_state *crtc_state,
> -		struct msm_display_topology topology);
> +		struct msm_display_topology *topology);
>  
>  /**
>   * dpu_rm_reserve - Given the encoder for the display chain, release any
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

