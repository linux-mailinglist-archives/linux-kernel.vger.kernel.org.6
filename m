Return-Path: <linux-kernel+bounces-359146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C799880A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA161C20E60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6D71C4625;
	Thu, 10 Oct 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBF9MHn1"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BFB1BDA90
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567699; cv=none; b=IVALtffOXLpjlKYCNfMw1s6wzDwIpVCuib+6RQnjA1nYfdW9HdOJ9NIMyyDREkZIqz2amXg4E8ZPpfUXQZm98ngBOR/6rIEPOztIoJNX+v+3+f8NqUk2qNifiR6yVZVcqOrszhmDdFOfcIHqgASX6tVQ7+HWPdWypD8HbRL++vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567699; c=relaxed/simple;
	bh=mX4YEpdk97a565LfAoh2XXBDHFu0mGLZctOpLVluh4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW9/xbAkO8eYgGEzElxRyxZ09o6LHdpOqBDHr+oG3mCsiqfuD0Y4ZZeWZj/Bwf50NgP4+vZN8ZkXrvBCuZF3CyLhgFRXmEW3UUZ0y3f2MbOoEsUFW/rjI6dcrY5WitvS9cgHxZEmK5YjTW4MYEb5cupEHkuEckR+Fy65cg7oxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bBF9MHn1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53993564cb1so1141529e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728567696; x=1729172496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywYGTQW3NjCWiXrm4ZDzjoz+vHmj6gfKaQuf2Wn/6QY=;
        b=bBF9MHn1377tyjq6B39Schszt3z/0p2FLcXShXJAQATCucJm4BWG7UnJmRNsJQmLJi
         ZbijWlurcnQBDjV3kkTEkK9MazZDUwpVFLJvkQP4d0CzThTZYxHJ4fZ4O2UZ6HzuEp0M
         D40gHxwpXwbctnlBa63zOaRaqFLtd4Mk7w36efXtY7B9poO/f6EEk2IP79nDDt0cdZjf
         J2uFRhGVcMSYPwf86z1gsOVkmmrjccyaRd+mkeClu/kJm745FjKhs6xr7P0lB/HqqWIY
         4fQceH/ZiYRCXvXX46qe5ZwOewyaOKJ9uYGrm8l2d1ag9SdP2BGb9jE4RXZ9Rga51h07
         vk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567696; x=1729172496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywYGTQW3NjCWiXrm4ZDzjoz+vHmj6gfKaQuf2Wn/6QY=;
        b=MuxYmEEUARfCncmSOgOoq9IR1O0swnaKiQS/LBb8V0FMXhYp/r4NKpASBnlmRGpdUz
         1s7jtusUTti27MloQP8mDLSzzXzMNJxwvtVvOx19X5OwcQrCgEaYevmKcO2IM+2c56Rv
         c8QfrwbWdbc5C3BgaNqintxogKWxqT0sHTBT+/+SdP/cTpVHpDooIXbmJ00eHF3f9x6g
         kJiZWCCqjXJ/n7liejDGJSWGBBUWFmnZEnQmD0rj1APgz8LSdvrBtx8WI3c2iUxY2Fz/
         EOxL3DyG3mxS66GM1RgTHRuYFc6TWreTHNzYXm+n9RDY2ncHpSpmvk0oHOmC1NY4THz/
         /MNg==
X-Forwarded-Encrypted: i=1; AJvYcCWRCuEm9ZHyDKi2JQ6TfHvkBc9FG4lYORpf8z54LTo6Qe4UZYuGJnVSwxUQt8d22BlJVuiQ1xlt3jGqBDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKhrZGjdgUQtROgbHOuPF4DeTvWuQnaT/o/RwdwbwpkSwLm1V
	bLBq4dV4C3kbGu5kFqmuZqlNUe2l2PuNlvtSCYDgXUBIt5qcsH2ipGEBufOnA9c=
X-Google-Smtp-Source: AGHT+IFfei1GdkuUWi73PJLzby9uAzHdB32SnRk5Ie0SqTarwvAkXDR1pqSVsk4h1t+o0mMJTf+gaw==
X-Received: by 2002:a05:6512:2582:b0:539:d22c:37b6 with SMTP id 2adb3069b0e04-539d22c3953mr84671e87.17.1728567695648;
        Thu, 10 Oct 2024 06:41:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c13aasm256358e87.32.2024.10.10.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:41:34 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:41:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/14] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
Message-ID: <7hgahbiow3zrt3a52nwrupbuu3eotytauf2k55xikgqg23dfge@luwcongx6bj4>
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-13-76d4f5d413bf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-13-76d4f5d413bf@linaro.org>

On Wed, Oct 09, 2024 at 04:50:26PM GMT, Jun Nie wrote:
> Support SSPP assignment for quad-pipe case with unified method.
> The first 2 pipes can share a set of mixer config and enable
> multi-rect mode if condition is met. It is also the case for
> the later 2 pipes.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 85 +++++++++++++++----------------
>  1 file changed, 42 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 480a1b46aba72..23de2ca6fabb0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -999,7 +999,7 @@ static int dpu_plane_atomic_check_pipes(struct drm_plane *plane,
>  		pipe = &pstate->pipe[i];
>  		pipe_cfg = &pstate->pipe_cfg[i];
>  		if (!pipe_cfg->valid || !pipe->sspp)
> -			break;
> +			continue;
>  		DPU_DEBUG_PLANE(pdpu, "pipe %d is in use, validate it\n", i);
>  		ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg,
>  						  &crtc_state->adjusted_mode,
> @@ -1154,13 +1154,10 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>  	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
>  	struct dpu_rm_sspp_requirements reqs;
>  	struct dpu_plane_state *pstate;
> -	struct dpu_sw_pipe *pipe;
> -	struct dpu_sw_pipe *r_pipe;
> -	struct dpu_sw_pipe_cfg *pipe_cfg;
> -	struct dpu_sw_pipe_cfg *r_pipe_cfg;
> +	struct dpu_plane *pdpu = to_dpu_plane(plane);
>  	const struct msm_format *fmt;
>  	uint32_t max_linewidth;
> -	int i;
> +	int i, lm_num, lmcfg_id, lmcfg_num;
>  
>  	if (plane_state->crtc)
>  		crtc_state = drm_atomic_get_new_crtc_state(state,
> @@ -1168,12 +1165,6 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>  
>  	pstate = to_dpu_plane_state(plane_state);
>  
> -	/* loop below code for another pair later */
> -	pipe = &pstate->pipe[0];
> -	r_pipe = &pstate->pipe[1];
> -	pipe_cfg = &pstate->pipe_cfg[0];
> -	r_pipe_cfg = &pstate->pipe_cfg[1];
> -
>  	for (i = 0; i < PIPES_PER_PLANE; i++)
>  		pstate->pipe[i].sspp = NULL;
>  
> @@ -1189,41 +1180,49 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>  
>  	max_linewidth = dpu_kms->catalog->caps->max_linewidth;
>  
> -	pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
> -	if (!pipe->sspp)
> -		return -ENODEV;
> -
> -	if (drm_rect_width(&r_pipe_cfg->src_rect) == 0) {
> -		pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -		pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> -
> -		r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -		r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> -
> -		r_pipe->sspp = NULL;
> -	} else {
> -		if (dpu_plane_is_multirect_parallel_capable(pipe, pipe_cfg, fmt, max_linewidth) &&
> -		    dpu_plane_is_multirect_parallel_capable(r_pipe, r_pipe_cfg, fmt, max_linewidth) &&
> -		    (test_bit(DPU_SSPP_SMART_DMA_V1, &pipe->sspp->cap->features) ||
> -		     test_bit(DPU_SSPP_SMART_DMA_V2, &pipe->sspp->cap->features))) {
> -			r_pipe->sspp = pipe->sspp;
> +	lm_num = dpu_crtc_get_lm_num(crtc_state);
> +	lmcfg_num = (lm_num + 1) / 2;
> +	for (lmcfg_id = 0; lmcfg_id < lmcfg_num; lmcfg_id++) {
> +		for (i = lmcfg_id * PIPES_PER_LM_PAIR; i < (lmcfg_id + 1) * PIPES_PER_LM_PAIR; i++) {
> +			struct dpu_sw_pipe *pipe = &pstate->pipe[i];
> +			struct dpu_sw_pipe *r_pipe = &pstate->pipe[i + 1];
> +			struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg[i];
> +			struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->pipe_cfg[i + 1];
>  
> -			pipe->multirect_index = DPU_SSPP_RECT_0;
> -			pipe->multirect_mode = DPU_SSPP_MULTIRECT_PARALLEL;
> +			if (!pipe_cfg->valid)
> +				break;
>  
> -			r_pipe->multirect_index = DPU_SSPP_RECT_1;
> -			r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_PARALLEL;
> -		} else {
> -			/* multirect is not possible, use two SSPP blocks */
> -			r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
> -			if (!r_pipe->sspp)
> +			pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
> +			if (!pipe->sspp)
>  				return -ENODEV;
>  
> -			pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -			pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> -
> -			r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -			r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> +			/*
> +			 * If current pipe is the first pipe in pipe pair, check
> +			 * multi-rect opportunity for the 2nd pipe in the pair.
> +			 * SSPP multi-rect mode cross mixer pairs is not supported.
> +			 */
> +			if (!(i % 2) &&

if ((i % PIPES_PER_LM_PAIR == 0) &&

> +			    r_pipe_cfg->valid &&
> +			    drm_rect_width(&r_pipe_cfg->src_rect) != 0 &&
> +			    dpu_plane_is_multirect_parallel_capable(pipe, pipe_cfg, fmt, max_linewidth) &&
> +			    dpu_plane_is_multirect_parallel_capable(r_pipe, r_pipe_cfg, fmt, max_linewidth) &&
> +			    (test_bit(DPU_SSPP_SMART_DMA_V1, &pipe->sspp->cap->features) ||
> +			     test_bit(DPU_SSPP_SMART_DMA_V2, &pipe->sspp->cap->features))) {
> +				pipe->multirect_index = DPU_SSPP_RECT_0;
> +				pipe->multirect_mode = DPU_SSPP_MULTIRECT_PARALLEL;
> +
> +				DPU_DEBUG_PLANE(pdpu, "allocating sspp_%d for pipe %d and set pipe %d as multi-rect\n",
> +						pipe->sspp->idx - SSPP_NONE, i, i + 1);
> +				r_pipe->sspp = pipe->sspp;
> +				r_pipe->multirect_index = DPU_SSPP_RECT_1;
> +				r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_PARALLEL;
> +				i++;
> +			} else {
> +				pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> +				pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> +				DPU_DEBUG_PLANE(pdpu, "allocating sspp_%d for pipe %d.\n",
> +						pipe->sspp->idx - SSPP_NONE, i);
> +			}
>  		}
>  	}
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

