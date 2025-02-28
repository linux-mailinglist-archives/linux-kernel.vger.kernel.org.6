Return-Path: <linux-kernel+bounces-537771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1273AA4906E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059FB16F094
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451FE1A9B5D;
	Fri, 28 Feb 2025 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYGnsNzI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B1819
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740717393; cv=none; b=GneGvgT2hmkc76LVY8KAoBIxea/H0CbF74PhbztYGcEgI3m5leGVw/3AY6F3HFiYmbjSuvpl0PS+NeoynroMRTYRQMkhK+wVA3rcLo4nH33wMCHjOxKw4FP0es/yvSZbtkElHf2W5nlR+JGRBxMQGZ0N0jUbYIH8j1q9Kj4ck0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740717393; c=relaxed/simple;
	bh=JNNNAXVJUB1dUrWe5/CzrO8g7HtIc9lV+IcdN6AiXIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3ecZYC/rqq6nx0+f97hia2pyCt0jy7rhTtMkl0M3L3dSdNpc/1QPJrX/JGg/BIrHW+IDSIUYnpH1MgjIsqa7VexSdcZTdw3mR1nLHyJfDugeuV4tmUQBVwgdVHj/dPV9kNl7vKCjsPGqhcvzimhsSZS8uncnDjWVJc9rotgmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GYGnsNzI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-545316f80beso1636318e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740717390; x=1741322190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIRTgNdswGDhbNbRHETd6FrKEXOOj6YkPcm/rw/JxR8=;
        b=GYGnsNzI0x+RL+N/SS53OaMfHg7jTgV2UjHNGcVLcpGQb8xexAjMRxXe+3wqHwKKsh
         uht+Puin7KkCFwyrmyIDlcbfm7O71eyuntT62AShW5AUdw+2cfczclCy7Dn9uI8j/iQg
         M2/I8zX1DJ7XKl9f8tjN6WOy/HwHtLvjS6N83LbyefAxkXU3QCfRXC4Pmuouq/1bhbad
         /DSMM/IzZ2I9R6yyPlqqSrPI8dPMsfVnvEy1i7UYDkhP0RQu91evgeIXArROwRbP9Zua
         qCBQA9Zjpr4sNoafgqdUK30eb/FXW5HkhwDWYLDvTtfdpD5ymCxc7FJ8U7glEg+Vi1kp
         c/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740717390; x=1741322190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIRTgNdswGDhbNbRHETd6FrKEXOOj6YkPcm/rw/JxR8=;
        b=mbeoBYB2RQVcOgz2XHYPPVWP4XPBtepbozikIAHKhpUh1BaLJr9tBMaVJwUcKmjo7T
         HNB7Wn7n9bR/V/bIzhYSMULLNvHAIwHMSdB+Fc2DNvhh+0cbz86zhNtt0secb7mzf4Vk
         0XgICnsz9tnz/2Zeib4CKodsjRUl55FvT3t586yAT2qCWypA1GQAquyOohp5cd1WzV+H
         SK/sHa95oIG6kk5AJ3yS4LVnc/dARTQKCks9c2Eqzy+VeGu+FVMjfvD2PmwfA0tgarxx
         MYnGDtV/CQ8BSV5TaDzF4bqiYs7s3R36YklVHjccbqSZLS4q5E0U5zprDOMLCcyG7nj1
         vg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUro80NeIB++Hd2ly7D2TFNEYDtHS7cNCU5KWSi4voKRghsSCnhdj+ehbcO4RacveXgVrVbCJsaT/9ZeiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+YrB/lprpWjYCUx3YI4Zgf58T6v4BWA1Ao93TqfAKuEQo3j0
	Ap3dMHySX19Mvy+4jJOft33vlO/VnE328O4Erb2t8iJKJ5Uo+40bhRc+lmrR0ig=
X-Gm-Gg: ASbGnctLsIeVrW97VooI+/2IKi8Hg1qOBy8StGAHiVUL1+P/yD+qUxetUQaInBm+e7w
	jqdB0LmQZ2YBNtYKszR4UGBoP5fyAnhh9Xo47wneRUfF5DYFSNtuh532BA0AZ2hOKJoTcilvQqi
	SAukwAz2xeZJ/+wm6VSJsHTO6Kaaqqm87fUP4X4ZqHDRPMdeFOjCkomOkdVP3rmWm/BtDh2l2vk
	yPy9/DNBA7J9EwX89xomXOcyjPMTFCKK7Rd1ztsMe2QG3B2hpcssCbVdXDrSwv9cZJxzh7JyGWd
	FxqKlp41DVfamSu4w/f4uSkiJja8CX52TUtZGtOvZMtR8nF93xO3gLSrVx3ccUNN8Y/qQ/wdIPt
	jX965bw==
X-Google-Smtp-Source: AGHT+IGHdROVsAiv4I0ViQ1CiojRZcJgPBqIJ5QDNvWA3K8bpxYgEX8MrL0nwpc0aa81lDswmCSX0A==
X-Received: by 2002:a05:6512:281d:b0:545:2950:5361 with SMTP id 2adb3069b0e04-5494c129f93mr754571e87.5.1740717389644;
        Thu, 27 Feb 2025 20:36:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54951f50e37sm29273e87.38.2025.02.27.20.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:36:28 -0800 (PST)
Date: Fri, 28 Feb 2025 06:36:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/15] drm/msm/dpu: blend pipes per mixer pairs config
Message-ID: <56fcpdrg6lonf7trasxurwpoausfv4lahtlggab7vcsxmxrnwz@jseugb2oidwt>
References: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org>
 <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-12-8d5f5f426eb2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-12-8d5f5f426eb2@linaro.org>

On Wed, Feb 26, 2025 at 08:31:01PM +0800, Jun Nie wrote:
> Currently, only 2 pipes are used at most for a plane. A stage structure
> describes the configuration for a mixer pair. So only one stage is needed
> for current usage cases. The quad-pipe case will be added in future and 2
> stages are used in the case. So extend the stage to an array with array
> size STAGES_PER_PLANE and blend pipes per mixer pair with configuration
> in the stage structure.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 45 +++++++++++++++++++----------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  3 +-
>  2 files changed, 31 insertions(+), 17 deletions(-)
> 
> @@ -463,15 +463,24 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>  		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
>  			bg_alpha_enable = true;
>  
> -		for (i = 0; i < PIPES_PER_PLANE; i++) {
> -			if (!pstate->pipe[i].sspp)
> -				continue;
> -			set_bit(pstate->pipe[i].sspp->idx, fetch_active);
> -			_dpu_crtc_blend_setup_pipe(crtc, plane,
> -						   mixer, cstate->num_mixers,
> -						   pstate->stage,
> -						   format, fb ? fb->modifier : 0,
> -						   &pstate->pipe[i], i, stage_cfg);
> +		/* loop pipe per mixer pair with config in stage structure */
> +		for (stage = 0; stage < STAGES_PER_PLANE; stage++) {
> +			head_pipe_in_stage = stage * PIPES_PER_STAGE;
> +			for (i = 0; i < PIPES_PER_STAGE; i++) {
> +				pipe_idx = i + head_pipe_in_stage;
> +				if (!pstate->pipe[pipe_idx].sspp)
> +					continue;

empty line

> +				lms_in_pair = min(cstate->num_mixers - (stage * PIPES_PER_STAGE),
> +						  PIPES_PER_STAGE);
> +				set_bit(pstate->pipe[pipe_idx].sspp->idx, fetch_active);
> +				_dpu_crtc_blend_setup_pipe(crtc, plane,
> +							   &mixer[head_pipe_in_stage],
> +							   lms_in_pair,
> +							   pstate->stage,
> +							   format, fb ? fb->modifier : 0,
> +							   &pstate->pipe[pipe_idx], i,
> +							   &stage_cfg[stage]);
> +			}
>  		}
>  
>  		/* blend config update */

[...]

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 5f010d36672cc6440c69779908b315aab285eaf0..74bf3ab9d6cfb8152b32d89a6c66e4d92d5cee1d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -34,8 +34,9 @@
>  #define DPU_MAX_PLANES			4
>  #endif
>  
> -#define PIPES_PER_PLANE			2
> +#define STAGES_PER_PLANE		1
>  #define PIPES_PER_STAGE			2
> +#define PIPES_PER_PLANE			(PIPES_PER_STAGE * STAGES_PER_PLANE)

PLease move this to the previous patch.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

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

