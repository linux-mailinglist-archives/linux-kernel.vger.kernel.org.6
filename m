Return-Path: <linux-kernel+bounces-548291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC2A542FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E068B3AF7B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B1F1A5BAF;
	Thu,  6 Mar 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWRdOsAb"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDD1A238F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243504; cv=none; b=pt6um6zjRmfLErzX8Ci1nloZARZUFtTmuZv+hzlWWs5/vhyPx1QXa5mNKrGV3k44rRi0T6nhvt35aeRi2L831QZ7DBKABx8e81pL3+hB8YoiU9UZTvZvCS/FbwITquvMutb8zEHeRstLqST0yfgUUYUWUnRdFUIJMPGSqH1nNyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243504; c=relaxed/simple;
	bh=y5E08rWlMslvB/K+XX3+OWFa9aCDHykKOGuGEwH0wPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/Z90eHdP/WZlcTK5o8IkCtDoiQBEFj1slPAi8O6VRAf8uZps+w86gFDy4KSLbET/VfNbo3uCFO/gcnzAaACe46de4NkzooS9sJ92UwyfR1dw1iEBFgT7L3FgCgY3YfQIHeuh7RmK+K5HF7E1xSw/3VMreTuLfUDV+SZd2DNhog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zWRdOsAb; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bee1cb370so547551fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 22:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741243500; x=1741848300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJcWTKFiNofQSBl8Y+/9Hv1NdwHNGxMC5GhCSRQfHSY=;
        b=zWRdOsAbSpLP57bPSWoFMx0r+zQrQGiv5gboBIy9QBL4fZIKFGoeHIJASrjL6i9E/V
         Xdt0nF8fERTaS0HUh//Z3i0fn1XkC8RIxL2s2sPDu8zU7dWb9fWx5TmnC9IHXUkED8VQ
         bCFkKOgy0+T+Ed4xGlaVpo+bLc69zbp/IxcWPzb6vM5QbDlRCUQP3YKmumM04IctHTem
         ar6wMqzqim7Q0jWFM5SKcRVZLY0uPnilGBF/CaidUVluPRNwjLM2GcLVa3WUahlCUWTu
         K2yxPBaSG+2sBmHfUaFqJdJVHYQGS2qW4t2jssy1FhJmY88U+93DLVrnqn5beEaXpR21
         wNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741243500; x=1741848300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJcWTKFiNofQSBl8Y+/9Hv1NdwHNGxMC5GhCSRQfHSY=;
        b=M7YA/6j1ZROGTolDNBFRpytZEz7GdEADb6RiFNC8d408nVrdTDyhGULidrRs+NvpiY
         X4uAxIko67tWOb491bonsH6LPonqIrUg2/w/d5Y8ChiNS0yfJ+vkgJQlD3D6URUYlCDh
         kFOK+leYG0BsG997n/1Zrq3jcOq22oo+j/sr1IyiJCItdqMMxuT5fXcHFtUV+tiFGJJS
         oq9UVPw7qt39m6hxI8Q6LGvhuu9vB0j20N5Zgn14Qw/kQGi77U+1XpbAzbA1qJDHyCIV
         2eNtwxDyskCh2xFhi/8+d4/cXGwLjQoSm49cLZI2tKbRyJvuN1h9/GMvKfjNOxk3S2+0
         LRdg==
X-Forwarded-Encrypted: i=1; AJvYcCVcHL5kVzNly0m0QLWeGRxh+d7FP57t1fQG7aYQ3V+DTnnR0/p83HZDKlDNKXDHwZMvbzMmyqehfPtIcjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QbqXxvNuHAp007hObEhDxp1ZrI8n5QRTml58RxMjsBRZQe8o
	ChCftcufgJd1GReFGEZDmnYya/e9cSkoKLyG49TQFgnFGKd/V6+WKmH/uh9/BxM=
X-Gm-Gg: ASbGncteVtwTxSD5awJ0ImP0m+VHao9nQAEvomKw8B0klbDUJ/0pmrK3N4d5n/GL1b1
	sHTxpIrqWKQq82vZn0rJPab7zYc/9ojccMZZmKv8Tx7FkKBUaZi7oUH5AVFVpQ2TEEcwXI6zUSH
	cBJzMq/magPWpa9PE5hbiUb1XxRU3Jl7H/DdO1ghsrvp/vBgP9WMxgRVMcnviZbnlifIx48XVrp
	qnH63sCW7u0mq5+uvZwQZweuS/Xa/uiR4/8zmYeJqoD20zXK2Bu9bK99Xxy/c31iUweAbkk289r
	xRWRIuZdncnQwLd89WuJw1U2m37X3io1KQDpEo09O1x+iV9eCkd1lrAmIkcKiSnYy5r6Prbe40p
	F051smViVtPBqAbSpgEg+amsk
X-Google-Smtp-Source: AGHT+IGKZmSCFgA/R9sb1yzYNL1vBOalW8LPwb3ZSbsOkodGM8bD2zIilQTAga0vyIRSmk9t4Oethg==
X-Received: by 2002:a05:651c:4cb:b0:30b:ee44:b692 with SMTP id 38308e7fff4ca-30bee44d138mr619121fa.33.1741243499788;
        Wed, 05 Mar 2025 22:44:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be99c8319sm1034191fa.76.2025.03.05.22.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:44:58 -0800 (PST)
Date: Thu, 6 Mar 2025 08:44:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Adjust CDM_MUX to support CWB PINGPONG
Message-ID: <vjufkcrkungrwy7w4pxzsac57ilzk2dt3eeypzy6pna2z5ocxg@uf237ixu6kqq>
References: <20250305-cdm-cwb-mux-fix-v1-1-16148ca6e4d2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-cdm-cwb-mux-fix-v1-1-16148ca6e4d2@quicinc.com>

On Wed, Mar 05, 2025 at 07:16:51PM -0800, Jessica Zhang wrote:
> Similar to WB_MUX, CDM_MUX also needs to be adjusted to support
> dedicated CWB PINGPONGs
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
> index ae1534c49ae0..3f88c3641d4a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
> @@ -214,7 +214,9 @@ static void dpu_hw_cdm_bind_pingpong_blk(struct dpu_hw_cdm *ctx, const enum dpu_
>  	mux_cfg = DPU_REG_READ(c, CDM_MUX);
>  	mux_cfg &= ~0xf;
>  
> -	if (pp)
> +	if (pp >= PINGPONG_CWB_0)
> +		mux_cfg |= 0xd;

Shouldn't it be 0xb for PINGPONG_CWB_2 and 3?

> +	else if (pp)
>  		mux_cfg |= (pp - PINGPONG_0) & 0x7;
>  	else
>  		mux_cfg |= 0xf;
> 
> ---
> base-commit: 6d3175a72cc07e90f81fb35841048a8a9b5134cb
> change-id: 20250305-cdm-cwb-mux-fix-69ed5297d4f7
> 
> Best regards,
> -- 
> Jessica Zhang <quic_jesszhan@quicinc.com>
> 

-- 
With best wishes
Dmitry

