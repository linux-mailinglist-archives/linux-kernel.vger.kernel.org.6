Return-Path: <linux-kernel+bounces-359093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAACB998754
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D01F1F21F71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BEA1C460A;
	Thu, 10 Oct 2024 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJn7f9b4"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ECF1DFCB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566125; cv=none; b=hsoHamrHOoVRuonBglSIH+yOn2xz21uqwxHhVRyNw+aPgDtHsjMsbLGxPPtVb9CXvPEoqlIGq1kW41/5hB1ZqgoefYbuQXiHqZzfzKZxkfMy8ilzLW/kqaxtJ0CF0vSV3TJc2qVV5oGyTCqoY2idhvyRUVsMtaJ2Oa6aUKokEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566125; c=relaxed/simple;
	bh=piG7spDyI4SMwG425xbizqqdIg+64jbDc/2NxOiLfaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0lPbEyCna7v7FoW2KzdoTGFTVc/1bT9h2ycd0ZBbSGH3fyrV64xJl05pKfn+nj+KpR4GIHiKVM+ZiZ1HVljoa/ikmNl1MyqJdGAo5XckwFfMBNhHPtSy2NLXR2jFUnZMuzzldFdmo+Nxn3l1DC45LvbTykfe1m8jOmVSYkqicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJn7f9b4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso13287341fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728566122; x=1729170922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HtB9kAVv9ewzwyyxT2HgaIAbvdU2B8U0xWvscjF8+ew=;
        b=aJn7f9b4gbjOHQxvjS+Ve63R3PLePG13ArDTBUctr2lVa+gt2Q8aYFIZQVme1LfHzF
         x6oOcQsOL4Og3rf2jwtTDSAp4p+/U9bd3Qg8wYHOmqIa4ePKmorSoAVz4mzrnY+VJyG2
         dO74CJlS8yNsj6O/h4CehcYOv74B1dOViUfAtzsIGV86M5iOwQJbD3XwFo6Plf/LiecU
         6HnglD72Rj+Zvfz1biMWUtNFB2mNTMcKR0jSmJfOoolD1NZAue9KX1Ri3u9t5J4M+TBF
         Rs8kUSLgkaOuGP7SOCXbeGxI27yZOelWJ1aFDdaUvZn+f3t01FNNEGZY44B31vtB8v7V
         BBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566122; x=1729170922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtB9kAVv9ewzwyyxT2HgaIAbvdU2B8U0xWvscjF8+ew=;
        b=toGJe8updt3XcHjPQxCV9tNtyBfeE+wL2/XcW2Nzz0sdXVWSdy/Od00qIIKXQtNJ0d
         U6XVA/vIxYI5ENkJhuY4xIay6c4hGOV7N7OIXV1E3ZwVdf72en4mCrmT+vBOxK9kdTmL
         ZDSFk6V2t2vuiSFieeNtVdK2Z5Sgsu+g1OCGHjAk+qKz8kff9bYVM7SajVTrBzVXmr2z
         67YUtwR2KsRel1rkQLE9rd1ibsMvsEDr6hXZmeLulaYuEQAA20FbDDjvgsk0wQc4e2ZO
         JXYMR/BaSS3Lbr37vxDqBDfE4oZKybybhsV3lAZIQJRagqyKysO7XIWR4c1hfNKo1Qu3
         qZMA==
X-Forwarded-Encrypted: i=1; AJvYcCUvyUVCCp+MzGcpD8em8v7y2VUM3K1Pl6nU2tuZv+Zq0rVUImd8NVNQYkeFoJskWSOxFuaMVJFqRd3pDEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbOu6pRqqZE+TbckZwgsIvpDQknIf2AvINq321lMT9E+KQeiH
	rePHfzdzzGgQkRjR7TqO2hG2xRFgWFNo+2pg5o91cykSygF13zXd/iL52j0o/08=
X-Google-Smtp-Source: AGHT+IH87YK8uHv2ZWN1NNC54PbY4gQ2AIlsgM9SMaLpPP1t+mq+ARbZWeCTLYn1opz9zUFkkR2P9A==
X-Received: by 2002:a2e:be23:0:b0:2ef:1b1b:7f42 with SMTP id 38308e7fff4ca-2fb187e7de2mr59795661fa.36.1728566121685;
        Thu, 10 Oct 2024 06:15:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb2aeec78esm156381fa.96.2024.10.10.06.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:15:20 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:15:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/14] drm/msm/dpu: blend pipes per mixer pairs config
Message-ID: <zig5zuf6hjcrkwmsdiahtzz3t3mxrmwxj65l43xij3zhfcyidn@fuisasnavvo3>
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-9-76d4f5d413bf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-9-76d4f5d413bf@linaro.org>

On Wed, Oct 09, 2024 at 04:50:22PM GMT, Jun Nie wrote:
> Blend pipes by set of mixer pair config. The first 2 pipes are for left
> half screen with the first set of mixer pair config. And the later 2 pipes
> are for right in quad pipe case.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 38 ++++++++++++++++++-----------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
>  2 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 43d9817cd858f..66f745399a602 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -442,7 +442,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>  	const struct msm_format *format;
>  	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
>  
> -	uint32_t lm_idx, i;
> +	uint32_t lm_idx, lm_pair, i, pipe_idx;
>  	bool bg_alpha_enable = false;
>  	DECLARE_BITMAP(fetch_active, SSPP_MAX);
>  
> @@ -463,15 +463,20 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>  		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
>  			bg_alpha_enable = true;
>  
> -		for (i = 0; i < PIPES_PER_LM_PAIR; i++) {
> -			if (!pstate->pipe[i].sspp)
> -				continue;
> -			set_bit(pstate->pipe[i].sspp->idx, fetch_active);
> -			_dpu_crtc_blend_setup_pipe(crtc, plane,
> -						   mixer, cstate->num_mixers,
> -						   pstate->stage,
> -						   format, fb ? fb->modifier : 0,
> -						   &pstate->pipe[i], i, stage_cfg);
> +		/* loop pipe per mixer pair */
> +		for (lm_pair = 0; lm_pair < PIPES_PER_PLANE / 2; lm_pair++) {
> +			for (i = 0; i < PIPES_PER_LM_PAIR; i++) {
> +				pipe_idx = i + lm_pair * PIPES_PER_LM_PAIR;
> +				if (!pstate->pipe[pipe_idx].sspp)
> +					continue;
> +				set_bit(pstate->pipe[pipe_idx].sspp->idx, fetch_active);
> +				_dpu_crtc_blend_setup_pipe(crtc, plane,
> +							   mixer, cstate->num_mixers,
> +							   pstate->stage,
> +							   format, fb ? fb->modifier : 0,
> +							   &pstate->pipe[pipe_idx], i,
> +							   &stage_cfg[lm_pair]);
> +			}
>  		}
>  
>  		/* blend config update */
> @@ -503,7 +508,7 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
>  	struct dpu_crtc_mixer *mixer = cstate->mixers;
>  	struct dpu_hw_ctl *ctl;
>  	struct dpu_hw_mixer *lm;
> -	struct dpu_hw_stage_cfg stage_cfg;
> +	struct dpu_hw_stage_cfg stage_cfg[LM_PAIRS_PER_PLANE];

After seeing this code, can we define STAGES_PER_PLANE (and
also keep PLANES_PER_STAGE defined to 2)?

>  	int i;
>  
>  	DRM_DEBUG_ATOMIC("%s\n", dpu_crtc->name);
> @@ -516,9 +521,9 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
>  	}
>  
>  	/* initialize stage cfg */
> -	memset(&stage_cfg, 0, sizeof(struct dpu_hw_stage_cfg));
> +	memset(&stage_cfg, 0, sizeof(stage_cfg));
>  
> -	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, &stage_cfg);
> +	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, &stage_cfg[0]);
>  
>  	for (i = 0; i < cstate->num_mixers; i++) {
>  		ctl = mixer[i].lm_ctl;
> @@ -535,8 +540,13 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
>  			mixer[i].mixer_op_mode,
>  			ctl->idx - CTL_0);
>  
> +		/*
> +		 * call dpu_hw_ctl_setup_blendstage() to blend layers per stage cfg.
> +		 * There is 4 mixers at most. The first 2 are for the left half, and
> +		 * the later 2 are for the right half.
> +		 */
>  		ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
> -			&stage_cfg);
> +			&stage_cfg[i / 2]);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 3277debe11689..d8f5cffa60ea6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -34,6 +34,7 @@
>  
>  #define PIPES_PER_PLANE			2
>  #define PIPES_PER_LM_PAIR		2
> +#define LM_PAIRS_PER_PLANE		2
>  #ifndef DPU_MAX_DE_CURVES
>  #define DPU_MAX_DE_CURVES		3
>  #endif
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

