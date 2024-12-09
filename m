Return-Path: <linux-kernel+bounces-438397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA439EA0CB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E851652CB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8D19AA72;
	Mon,  9 Dec 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjqS4a7o"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E217BA5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778259; cv=none; b=hUAduvh8RixzDK9AQHv11UFir3oCESE7/uEkN2B7jacFBFRij0lbBKIudM+NDwnylbhXmuS8w0hLDk3cYOwPdgJaxQyhzCrrcl0EW4jg7gDnKiYId6xu1OBTS7LTLDDxsBKXq6o+CaWECRRdM1RJg9fgrOUv8JMpg+cBLrg3WKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778259; c=relaxed/simple;
	bh=mErQLaZMSehpj+0TcfYb3qU5y759ZkKuAh0LUXHnOJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oklSvV3/cAp4yOup0hu5tKuwyoLKhGkWCTa20dALPrMVhI8kG+MIpyxF5SVgGiz0TAa+0SRG0qJkU1sZVhqZTTdhxoOJJNOS/TFebyaLfhlPFzLRfV1Gz1nPgkzCQj6GmiGkpuWGlrqjSemutNY+ZP9p5z5jOCh3/y5UKRbDK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IjqS4a7o; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so44246901fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 13:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733778255; x=1734383055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ma5GtyG8ioog91EhM+P4GWHWrGCT15M/sea78+XBKE=;
        b=IjqS4a7o4XFkH+7w//FPT+Z+oazWHy/B3AH4f/KerZlhiRFiT1dHh6+WK6hXSfh498
         fY0s/kPWUPENJHaFlZWkS/zUKoP9gVt0TIu/fqK8JlrktK+r8epC7yNzUrORqjptw6sI
         n+eSahjYPYxAukPvuaVKW2lTqCPsAEjEMxH1FB/ysE69sSPyrOt2DMe6TRoeBxwFzDM7
         tvMiSReWeiDB9Mt78FCgX78xiTyCU58M5I32SBuXYFj6q10l+wTUoJZfTRXI3RvMr3GK
         jkA0FbA+9ETMV6SDWIdo49RpfhWa3Ve8zWmJG6Ukh6fG3BZWDpQwU87BjYVcHKEgvWuB
         EwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733778255; x=1734383055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ma5GtyG8ioog91EhM+P4GWHWrGCT15M/sea78+XBKE=;
        b=PjG3yXRO28ikQTNdTHTvR1U5iff/Xsdlh5Tr9xP+rdwtiEYG/kMXCopZCzC9+e550f
         ahBV7dgzor1btMUsM5YJFQqiIS0kqL5rp5dwiPkc2GKqlf+K3EiVUR8Sv6etnA2rsMLX
         8GkwuIJgLh0DJgFCb1XtaSES5fDQ27g5fddGYuQoH3X0BKliATAPfuzWHTFPRlMbZ8uB
         uT3t6YbmoToPFUlnFm6ICQJoAeMz3eDA0NeDs90tEhFzyjLeT1fHYmS+c+jwXrdIfAxy
         5jEpOd1R4JZ/HbEkpFl4GBxIHHEOi1JSA2bXl2jMIC08ko3fiv6aaU398wvjfHAKwjJh
         leEg==
X-Forwarded-Encrypted: i=1; AJvYcCVv/eptRfieJG6W91KtcPEOTL6jC/cCssHrE20JWYKwhHC/iHBbhFRwPMeGNn9bcxq/74uFHqdYToxowEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFj6fsH/zfIEiZGIXkWNiM/w/4v70FH3HfrjaQrtNuhnk9wZZo
	0Y6JJzNEK1VkdbIA15ywnjLMYo+6XJNHR2lDTylgQx4z0Vv6qrQd++wPSeJO7fU=
X-Gm-Gg: ASbGnctbd+djDz2RDxyO5419y9bFnNvRG29z3YaX9/4PflZiVt+RPCgFOhQR6KazyDK
	sTO5diI16BHUo4t8qEhodLzybzBcoiVO+c8nDYAhRM3O7W1TsHwiY8xzWAsDzDAI8EUguE5Ez6f
	rIzqGdFPFkM5sE/4YfY06bbsSwp728IWagKmEt8uEVfzUxISa6pWv/+Z2AsEJhDaSQZ6A6Y1Gll
	thgJ8mqJsgC4uMCF4RFHP/yaPaWFsMvPzYFQWh51mFp6ISFkmPisOlkOZuwcl3grJmo3zq3V/zB
	i3TsoN0w7yfaAi0LmGbICQP5/j6+FrNqVQ==
X-Google-Smtp-Source: AGHT+IGyoN5lvEyWoIQKeZ0cauegZG/9/HnT3c9dEG7V7kOpedR0OZrCmSQf0J/flV38TzNZUm43Vg==
X-Received: by 2002:a05:651c:541:b0:302:2c61:a1d3 with SMTP id 38308e7fff4ca-3022fd89c5dmr7913551fa.36.1733778255053;
        Mon, 09 Dec 2024 13:04:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30220d0b34fsm4716121fa.60.2024.12.09.13.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 13:04:13 -0800 (PST)
Date: Mon, 9 Dec 2024 23:04:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] drm/msm/dpu: check dpu_plane_atomic_print_state() for
 valid sspp
Message-ID: <d5yfas7yzilvjryrtdi2miaw5khnycm7egn4dd5ff3vu7z4op5@oit2xvsyx5l5>
References: <20241209-check-state-before-dump-v1-1-7a9d8bc6048f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-check-state-before-dump-v1-1-7a9d8bc6048f@quicinc.com>

On Mon, Dec 09, 2024 at 12:37:51PM -0800, Abhinav Kumar wrote:
> Similar to the r_pipe sspp protect, add a check to protect
> the pipe state prints to avoid NULL ptr dereference for cases when
> the state is dumped without a corresponding atomic_check() where the
> pipe->sspp is assigned.
> 
> Fixes: 31f7148fd370 ("drm/msm/dpu: move pstate->pipe initialization to dpu_plane_atomic_check")
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/67
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> To: Rob Clark <robdclark@gmail.com>
> To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> To: Sean Paul <sean@poorly.run>
> To: Marijn Suijten <marijn.suijten@somainline.org>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 3ffac24333a2a5b01135d4ece418432d4a74dc04..fe3fd9587ec61f241ccb8c28925c7902b92bcdcd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -1333,14 +1333,17 @@ static void dpu_plane_atomic_print_state(struct drm_printer *p,
>  	const struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
>  	const struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
>  
> -	drm_printf(p, "\tstage=%d\n", pstate->stage);
> -
> -	drm_printf(p, "\tsspp[0]=%s\n", pipe->sspp->cap->name);
> -	drm_printf(p, "\tmultirect_mode[0]=%s\n", dpu_get_multirect_mode(pipe->multirect_mode));
> -	drm_printf(p, "\tmultirect_index[0]=%s\n",
> -		   dpu_get_multirect_index(pipe->multirect_index));
> -	drm_printf(p, "\tsrc[0]=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&pipe_cfg->src_rect));
> -	drm_printf(p, "\tdst[0]=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&pipe_cfg->dst_rect));
> +	if (pipe->sspp) {
> +		drm_printf(p, "\tstage=%d\n", pstate->stage);

Please keep pstate->stage out of the if() statement. LGTM otherwise.

> +
> +		drm_printf(p, "\tsspp[0]=%s\n", pipe->sspp->cap->name);
> +		drm_printf(p, "\tmultirect_mode[0]=%s\n",
> +			   dpu_get_multirect_mode(pipe->multirect_mode));
> +		drm_printf(p, "\tmultirect_index[0]=%s\n",
> +			   dpu_get_multirect_index(pipe->multirect_index));
> +		drm_printf(p, "\tsrc[0]=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&pipe_cfg->src_rect));
> +		drm_printf(p, "\tdst[0]=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&pipe_cfg->dst_rect));
> +	}
>  
>  	if (r_pipe->sspp) {
>  		drm_printf(p, "\tsspp[1]=%s\n", r_pipe->sspp->cap->name);
> 
> ---
> base-commit: 9d6a414ad31e8eb296cd6f2c1834b2c6994960a0
> change-id: 20241209-check-state-before-dump-2a015ace5f49
> 
> Best regards,
> -- 
> Abhinav Kumar <quic_abhinavk@quicinc.com>
> 

-- 
With best wishes
Dmitry

