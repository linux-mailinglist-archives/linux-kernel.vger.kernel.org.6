Return-Path: <linux-kernel+bounces-526221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF416A3FBB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA397A52C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E3215050;
	Fri, 21 Feb 2025 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENeSBtOi"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855721504E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155782; cv=none; b=T0uQYDxs79SdSl0VVdhTzFw9FFUPzsFXNyWZp1sVIQsPzAyBKU0wvQg4pPrwcHwzBHO1Hw8niYvtdK5JO6hGHTagDy0bg0eoNzvpzRliD6p2IX27L/ds7GJ6UHwZ3g9Ydio8xEGiZ9/+awEihQxVK59p+A4Ivl2v/0MXeUdJCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155782; c=relaxed/simple;
	bh=PNSjA21YyMY5b4mfcA7P0wgvMvVvhz9wuyfsaZhxbP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/jOfc2h3jgWYdzxzbCtBJGNwfUhW4CPeMhftg34xjaPgVP5oXg3/RMxyLaxylhxpyd3hTppsZHssAMzinmNHAkAAaU3rTrTuazuzKyjo5SOJ5HOM1mFpFWIU0WpsTzKydd9hYcgPdjs3yxBncV7uo1+a+jYjE4+1rjbZ3AU1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ENeSBtOi; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-545fed4642aso2290176e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740155778; x=1740760578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPds9oAtueHibvIS0BHa1Q9Tu3GfdsskW31+FCbd/E0=;
        b=ENeSBtOiaSYf8PniUEfCWiRJvvf4oP6xLt2v/An5pbvFKJpX4joDZYUE949Aa28c7A
         IxiGAZeLdvvLRU8+YtnIpoa3t5uqTWcM1qekLP4bG7G5e1rItyKsRietG5Z5rdjfqI2b
         XDwkO7yMlGvUO5dV4gPRFQxChIXXN8aOkUk2oIFauSSrb2yAXpsMvRW9f9Voqp1faKHa
         6A+H0GRZiAZS1NtP877axIVvKlsfDHnCPO4DJz/diml4ekIAxiRVeCQIw+njMHrWmUIr
         BsGiEGGSYjTY+nUgpm8qZmhwuvKcNdessIXRUO5mIh9HoUuxdvuV0QnvSm71lm/XQbzb
         rkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155778; x=1740760578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPds9oAtueHibvIS0BHa1Q9Tu3GfdsskW31+FCbd/E0=;
        b=kcY2HoYLQ3FNfM99hWncnbWDwK7ARdxEeg84Knp3g6KD6rGwV47Fdle/x1jreYbYTF
         QWDHPaUuH63a9jDQZtS4UvfmGXEiV0+nrAINPe4/LghUFZwyJEbkUguaQmcYLZGK+kOa
         F0I6uc7JAkRpHhXQYh2CRycckVYh9QU3IZyr0qf4mG+YmOr3HcykcCcippMnjXxkvQ+f
         EGBPYLzIMJ1f09N3VpKRMbgYebyc268r0+J7iZPfHwUAUG8JRDMZIXiyCWYMQBzyC2Zu
         ChUOU8T1p1wcDBayWZOldyUm9vHXnPp2yWkudirGBSceixtIGjYqCi11umB3swSpIyPw
         2DSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1PqmA0ZYON3Po5q8tfA0+KT/zSGDu92y9ej4zy9dMLaiU/C8NvJw0LdF9fmfcutKDavj8O3ypNt4epq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsfUNG9O5+JT/u8pgXgto1ejgATUmtKcDMm7gftTps8angVxy
	V57GFwKhiem8PIWqcGje2gJs5dh51A0fUntk3wnha1PYgmaN+bjTcGY2wHE5vVI=
X-Gm-Gg: ASbGncvDnhr/3wNA/fuJT/5P+iFMYAPN/E+/TKJ0ZXtoUVeNcmiwBUYdMjNKHyEq43+
	zT8ovgRBsQ7lJcDJhWF86vRHAQW1dQthebeymgzT1v/O6u+PiCWvwasSb0hQK17213Ycla/sA1+
	SwqdDdZfeym/F+CJ9mGuOu1KsmU+l4CZwtMOLM7g2Rv+InlcuY3XRnmgI2kw79XHd8HnQFNN2ik
	IMyFrgpbDp8EgRP/ZvgY+Mhk+F3B2jeT2crv9tFnwm4rvqkimnSEBdniYSA6jBuMy/1auFUi6uz
	lzgLDrvHpAKhyFTi7zeafsU9Y16/qxrOsTb4HfxkX9Hz5+KOhvDWSoH4DubG76DxxygCaLZz7ET
	a//Mc1A==
X-Google-Smtp-Source: AGHT+IG5OE0xMdR23O2TUN2vTwu+eGSplv/MmFU+Pt5AentUHO2eMzUBhfbNGyJXT3btW78Y1ZdZVw==
X-Received: by 2002:a05:6512:104e:b0:545:2e5d:f3f3 with SMTP id 2adb3069b0e04-54838f5b0bcmr1640970e87.46.1740155777708;
        Fri, 21 Feb 2025 08:36:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545637f0e14sm1961903e87.86.2025.02.21.08.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:36:16 -0800 (PST)
Date: Fri, 21 Feb 2025 18:36:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/15] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
Message-ID: <khmeegjx5jmu4c32un3gqu7sumkbtdkg6cawwwmwtmkp5gkrag@sklf5tr7qbwv>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-13-c11402574367@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-13-c11402574367@linaro.org>

On Mon, Feb 17, 2025 at 10:16:02PM +0800, Jun Nie wrote:
> Currently, SSPPs are assigned to a maximum of two pipes. However,
> quad-pipe usage scenarios require four pipes and involve configuring
> two stages. In quad-pipe case, the first two pipes share a set of
> mixer configurations and enable multi-rect mode when certain
> conditions are met. The same applies to the subsequent two pipes.
> 
> Assign SSPPs to the pipes in each stage using a unified method and
> to loop the stages accordingly.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 63 +++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 24 deletions(-)
> 
> +	for (stage_id = 0; stage_id < num_stages; stage_id++) {
> +		for (i = stage_id * PIPES_PER_STAGE; i < (stage_id + 1) * PIPES_PER_STAGE; i++) {
> +			pipe = &pstate->pipe[i];
> +			pipe_cfg = &pstate->pipe_cfg[i];
> +
> +			if (drm_rect_width(&pipe_cfg->src_rect) == 0)
> +				break;
> +
> +			pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
> +			if (!pipe->sspp)
> +				return -ENODEV;
> +
> +			r_pipe = &pstate->pipe[i + 1];
> +			r_pipe_cfg = &pstate->pipe_cfg[i + 1];
> +
> +			/*
> +			 * If current pipe is the first pipe in pipe pair, check
> +			 * multi-rect opportunity for the 2nd pipe in the pair.
> +			 * SSPP multi-rect mode cross mixer pairs is not supported.
> +			 */
> +			if ((i % PIPES_PER_STAGE == 0) &&

Please move r_pipe / r_pipe_cfg definition and assignment here. With
that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> +			    drm_rect_width(&r_pipe_cfg->src_rect) != 0 &&
> +			    dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
> +							      pipe->sspp,
> +							      msm_framebuffer_format(plane_state->fb),
> +							      dpu_kms->catalog->caps->max_linewidth)) {
> +				i++;
> +			} else {
> +				/* multirect is not possible, use two SSPP blocks */
> +				pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> +				pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> +				DPU_DEBUG_PLANE(pdpu, "allocating sspp_%d for pipe %d.\n",
> +						pipe->sspp->idx - SSPP_NONE, i);
> +			}
> +		}
>  	}
>  
>  	return dpu_plane_atomic_check_sspp(plane, state, crtc_state);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

