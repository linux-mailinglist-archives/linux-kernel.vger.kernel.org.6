Return-Path: <linux-kernel+bounces-518283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683C6A38CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE1169DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE822B8BC;
	Mon, 17 Feb 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9YGrElv"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD9232378
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822251; cv=none; b=gjBvIJKdHlrdhGvVsj8FozJfoDzwdAFJ2oNxjcUJ30IU651v1BroD2bdgtoKe3B4L95ZEz5LevPr+P8+HV/ANg+hbCzEbPs+27tecWANmbn8azkQZhjrZhGiG2M+cpdUGLZ+GwHNcJkHOtuAxJ0glQPrqXVc3eDnmuPwkCXJwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822251; c=relaxed/simple;
	bh=uxosyCl70LpiSt1WhJu3o8EZgk1aMrkeBZvPkx2TuyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJyDcIV+8qCwuru+FS710RHPEbhkOcWd4zoyPaAGzlm2vHbbvCkiSTCzJk0QdZ94NvlOhPgkT5tY8AhNA3/p6+Wkj7sOgXPVEBJ57LgxzBG5MVbkoi8KhQv3GwES2PFzXv/AtN47t4lxY2aNWBp7DXAV+fVrOLI8TshEhR989FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h9YGrElv; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30761be8fcfso46014051fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739822248; x=1740427048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMGI211LrxE7ViIhzCm1kjlvh1GVYdKtuIIj0ObyhHo=;
        b=h9YGrElv3RhlZn7j45I/L2TfFtufsmqzf8Gknr7PRjUCjpUDn+fYcXWZB/iWbz8fHf
         Q/qZHDelwu5PJ3I2jwSaPQ+IhEhPi9BT1JXZsZB/X0O1TcxdEJyUE2eofMVAwx/BZ/6j
         fNBCkzlM9FbMAiAcDtZTS05g1FU58Q6ZM293r4Fu933mEoQvvmILgfGwGRDWqA96SBMU
         SEkuuuYGwfFScs035tHbGBrVjS5eFFu/gnK7MmJXi6mHmdLtdnSVUEdS2P2DEmz62I3/
         VB99XHQJhN923r/hqr6R4Ib2PC437/M5sttKuEVUmHZt8XZnI3IF1mVEcaStCTP7EiJp
         eHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739822248; x=1740427048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMGI211LrxE7ViIhzCm1kjlvh1GVYdKtuIIj0ObyhHo=;
        b=r4Gtbmrcp/tdCiLlx0AJ5aerF9e4Z4PTT9MpOyt2LUt4tvBwIv+E9rmgrTQ3chBWUS
         KUYqGEN7y0bKRforXHAoYGpd655xrNcyWhnbgJ7NXPcLhoH6egota0+3faxBA+E2RNxY
         6SvWYhpF1VRhnkPjybqJ1I0yfsobjPzR9YxcQVUtSgAGHxNTvyhj4ykRYHpVATrKzi1G
         0DJmw/4ZTuXb1noQ6oH+IB2gLz/sgrTTSt5CetGabJc1fQUUrEgaBLQImkGQTkm7jn7E
         zaTs3y1INhvMiY78Ldt4YL6+HWHPhzVxN9P56kh6Km2q0hoMf1QzmCEmIUnzX/rvTkVA
         txnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz7/Hm175BzXaa8QoTKvxnk7yR/BwkIogDNOR0qkxSbVnBiIyYnWnYhz+pmvKX83t0e5ULdFxGwuyIsgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0puw8JLNFuX4140oGpfVciHd6ivna3P8t1BLe8qL5GDFZND71
	o5fYJ/IJv48cs5KzSC+v9vsv+FwFhFubhH4ayXoSb9umtk9Nvso6ZKu2IsqgO4w=
X-Gm-Gg: ASbGncsjUBH+XDmBKya+909+Nku72efoZPT2J8NCQqT8oEbTO+q1AWB+qpN9hKRmfb7
	s4z7SBILUvFxM8C4nrnnN6w4u+I86CFdo4IC98jJJikqglhhO/CR4wpLehVWFV8/vGrsuo3VYK2
	aLO+qYHXDkVBV5W9glf3C3T4tw2qpY9Mkf5kZIli9ZBn27hGpaK7rGvKn6QcoyKP/j+3/Vz/Mu8
	eJjL5ePKoqxPw831xXbB4NEomBMnvZc0n7vln7Wb72WFzW2nwBbxchawQswCdUuQnByG484mtdv
	j3fQvJfgtZQhVWTSGpCqd5r1y4vCFMvoHztG5U+Q/R7oFvpGq0ux651LoE95GMPk0dE9rQ4=
X-Google-Smtp-Source: AGHT+IHWktoREaaIkncp+ihbbZRuJV4rft7CykmfmlbEHdRBo5ws85YTHgTILXgtZzP9D8cAmBMh+Q==
X-Received: by 2002:a05:6512:108a:b0:545:d72:95f0 with SMTP id 2adb3069b0e04-5452fe5bd70mr4139939e87.24.1739822247806;
        Mon, 17 Feb 2025 11:57:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54530993e36sm1035359e87.3.2025.02.17.11.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:57:26 -0800 (PST)
Date: Mon, 17 Feb 2025 21:57:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/15] drm/msm/dpu: blend pipes per mixer pairs config
Message-ID: <qrwo5jtdj64vu27jn3v2wwyuxu25bjqrybj5jjfc5ifiotgzit@6vx2km46j7b3>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-12-c11402574367@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-12-c11402574367@linaro.org>

On Mon, Feb 17, 2025 at 10:16:01PM +0800, Jun Nie wrote:
> Currently, only 2 pipes are used at most for a plane. A stage structure
> describes the configuration for a mixer pair. So only one stage is needed
> for current usage cases. The quad-pipe case will be added in future and 2
> stages are used in the case. So extend the stage to an array with array size
> STAGES_PER_PLANE and blend pipes per mixer pair with configuration in the
> stage structure.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 45 +++++++++++++++++++----------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
>  2 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 81474823e6799132db71c9712046d359e3535d90..50acaf25a3ffcc94354faaa816fe74566784844c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -401,7 +401,7 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
>  				       struct dpu_hw_stage_cfg *stage_cfg
>  				      )
>  {
> -	uint32_t lm_idx;
> +	uint32_t lm_idx, lm_in_pair;
>  	enum dpu_sspp sspp_idx;
>  	struct drm_plane_state *state;
>  
> @@ -426,7 +426,8 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
>  	stage_cfg->multirect_index[stage][stage_idx] = pipe->multirect_index;
>  
>  	/* blend config update */
> -	for (lm_idx = 0; lm_idx < num_mixers; lm_idx++)
> +	lm_in_pair = num_mixers > 1 ? 2 : 1;
> +	for (lm_idx = 0; lm_idx < lm_in_pair; lm_idx++)
>  		mixer[lm_idx].lm_ctl->ops.update_pending_flush_sspp(mixer[lm_idx].lm_ctl, sspp_idx);

I almost missed this. Why is this necessary?

>  }
>  

[...]

> @@ -535,8 +543,13 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
>  			mixer[i].mixer_op_mode,
>  			ctl->idx - CTL_0);
>  
> +		/*
> +		 * call dpu_hw_ctl_setup_blendstage() to blend layers per stage cfg.
> +		 * There are 4 mixers at most. The first 2 are for the left half, and
> +		 * the later 2 are for the right half.
> +		 */

The comment is invalid until you introduce quad pipe, currently there
are 2 mixers at most. However you can just say something like 'stage
data is shared between PIPES_PER_STAGE pipes'.

>  		ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
> -			&stage_cfg);
> +			&stage_cfg[i / PIPES_PER_STAGE]);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 5f010d36672cc6440c69779908b315aab285eaf0..64e220987be5682f26d02074505c5474a547a814 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -34,6 +34,7 @@
>  #define DPU_MAX_PLANES			4
>  #endif
>  
> +#define STAGES_PER_PLANE		2
>  #define PIPES_PER_PLANE			2
>  #define PIPES_PER_STAGE			2
>  #ifndef DPU_MAX_DE_CURVES
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

