Return-Path: <linux-kernel+bounces-359085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B099873E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574CAB25FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18C1C8FD2;
	Thu, 10 Oct 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYhlM4sM"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB21BE245
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565850; cv=none; b=TYC2MjvFa14jIPd2krmLZ9CnbNgb1e6GLn3I/GczSZaiNOI90F5jXOcWJqIafK41TEJ5PhLceUM+9Yc4B+EWom6geu5FUWXzlKHsSg4BV8aLR7ByYrNvl35dezQry9FrNpEclJlW5MRe3cVxkUlOckepnCCr/7ovRH8YS4Lx/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565850; c=relaxed/simple;
	bh=Udd4pn2glGSczcTbf2nYjCAZ2rxzz7yJMHFlq0uAeQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK4HffPsutr7ue8xhboQhBnSYO8ltg6R2gzi4MUaL5LipeApL9QA98kuI34FfsWUcH+m7YMWqt0C0/FC0iqhZViWDIcra5BHtHxQbJqZlGWpzbodLhD14llquH+ZxUV99EERau1uns3T6pPDFpgZhahfVjse5nQT+nQ82lGB5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cYhlM4sM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539d0929f20so103899e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728565846; x=1729170646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pNpS+njt9cPkWZ6/CJqsL3zGajZBdNwsZNIu0dSvWo=;
        b=cYhlM4sMHU8P8R+7gLuWMKvyU3dW72JUvUnWCYWhGXBD38ySIcrfIf5Fr0TO5gRg6g
         LkT6hSq92Mx7ZIBEohbIarYgOsaUhtGJyielmljFGkE963NkCTc5dNpbjqw5lJSPn/cI
         CyCFxqFq5qggIU7Cu+ltjvYki/6wBK65E3SRGl/xGGlzrqKUiIdO/zzDmZ0tbT1aKJ/T
         6Hwubs6vzw5lyGCN9J9Busgxxk2AZOgsGcjl9N3qbnOGYWsDDclNhttzCtDQoaw/iwzo
         qdH86Wk8YjxMh4YXrZBzFN6AWpjc6HnDj5edgrD21ie8XdUBqjL6hD1eQwlXFLG96NYc
         cjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565846; x=1729170646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pNpS+njt9cPkWZ6/CJqsL3zGajZBdNwsZNIu0dSvWo=;
        b=cuMLLyAt5LsB/vcrOGiCBItbpEywVlq9SMomAifaJ7AjxOFuvUw/D2slPdI1CwRWz/
         cHnQ1HgL4Z6Aa3wnmr1IqhLLbr3HnRlaVDVRJKCQwDi4y0TApWCwEAn2A/hF+C+WfVBB
         eUUBKmulFLdhCQD6I2iHKpIZ0DTiFUb6hFY5WTL/V3Tqd0iz8JDXmBnhWyXtXtZit8FB
         vyjaEUsOCJWy4Yo5mu8SIcUZ5mTW8G6TyKRSN09tbvroYhBsSTXI2+xNrXVBSwXujf2+
         YvE+1cJJv3EQnsfSNmWcU69ZthsIBshihF2+ibXYsFVzmBHqShb00QTbJswMJFknoNYc
         4D5A==
X-Forwarded-Encrypted: i=1; AJvYcCUix0gFVeoUB9LMFfgXWip4c2EMIMOpw85MJzgy2Sjs5fjyKhKNQoSQoxePQ/W16tPVoVgxvqGFn0/hCvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnEl/jOLQb4U/sCplnqspttfBFPxVbjpn9i5HSWvWnOCDkP4B
	yw5pPOiDUgs2ecycnzrVFuYJV6YfGaZNTvcMDW2pprFcjrjUkLImE1rKSJnUB2U=
X-Google-Smtp-Source: AGHT+IFhrlaouxAJK8Q5oz79aOgKS1/HVBFwAarBhM3XTq5eethNmfRnt5mwLzZOc/yNhCF/pyuHOQ==
X-Received: by 2002:a05:6512:6409:b0:537:a82c:42ec with SMTP id 2adb3069b0e04-539c98689f5mr1180968e87.4.1728565846042;
        Thu, 10 Oct 2024 06:10:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb905aabsm247052e87.295.2024.10.10.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:10:45 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:10:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] drm/msm/dpu: bind correct pingpong for quad pipe
Message-ID: <brvjrwnwzkbobk47xb6i6ulzxabigsujomx4yhaa7oy5vrwvle@tn2ni4wcvdee>
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-7-76d4f5d413bf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-7-76d4f5d413bf@linaro.org>

On Wed, Oct 09, 2024 at 04:50:20PM GMT, Jun Nie wrote:
> There are 2 interfaces and 4 pingpong in quad pipe. Map the 2nd
> interface to 3rd PP instead of the 2nd PP.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index bd2509985c4d0..dfe282c607933 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1100,7 +1100,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>  	struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
>  	struct dpu_hw_blk *hw_dspp[MAX_CHANNELS_PER_ENC] = { NULL };
>  	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
> -	int num_lm, num_ctl, num_pp, num_dsc;
> +	int num_lm, num_ctl, num_pp, num_dsc, num_pp_per_intf;
>  	unsigned int dsc_mask = 0;
>  	int i;
>  
> @@ -1171,9 +1171,14 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>  
>  	cstate->num_dscs = num_dsc;
>  	cstate->num_mixers = num_lm;
> -

Nit: unrelated

>  	dpu_enc->connector = conn_state->connector;
>  
> +	/*
> +	 * There may be 4 PP and 2 INTF for quad pipe case, so INTF is not
> +	 * mapped to PP 1:1. Let's calculate the stride with pipe/INTF
> +	 */
> +	num_pp_per_intf = num_lm / dpu_enc->num_phys_encs;
> +
>  	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
>  		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
>  		struct dpu_hw_ctl *ctl0 = to_dpu_hw_ctl(hw_ctl[0]);
> @@ -1195,7 +1200,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>  			return;
>  		}
>  
> -		phys->hw_pp = dpu_enc->hw_pp[i];
> +		phys->hw_pp = dpu_enc->hw_pp[num_pp_per_intf * i];
>  
>  		phys->cached_mode = crtc_state->adjusted_mode;
>  		if (phys->ops.atomic_mode_set)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

