Return-Path: <linux-kernel+bounces-309223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C18B9667BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416D8286F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDADA1BA891;
	Fri, 30 Aug 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEou5jgV"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC11BA272
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038004; cv=none; b=VMPNv+sHhMTkqS0bDeptxiK6udjYtHGkIAlGblLtyNkTIPPLmeU2zLWBRTySWRS/3wNYyB0Isj3D6JziHHHAoHZ/9AXIUcb7wZkyj6prG6MEnfcp04GJgBUu/uwz7BPSdz1qDRmM7nGciyPmCkBr7ly86tZ8q6mwDkbT4g07S6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038004; c=relaxed/simple;
	bh=EejAFGHDc4+wHkURmZqyaIGTECLuPeJKxd/AqA2a8IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax+i1hv1c8wRjGCfP60Vcz9xGaFwHGCi52wGj3Qjdkle+JV2mM6FPDGsN/7MCojEkwM4PYhg7+DdmSydtQuVrKbTPYTmUxr5/o27jLbkLGdM7rLnzs5fmmvrPPtdGVrxitBcwQmuEs/dCa6/wiaadGBOfzphQJp9w4jldABwM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UEou5jgV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-534366c1aa2so2197319e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725038000; x=1725642800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WuoWF+ip5aM6TEiw7ZGe1txftEmX/FKCbSWMdfUV8/A=;
        b=UEou5jgVbVusNVWztTT+S0Vb5r5YKunq1LiqBGnSNgzmG6EJa77SuHShiY6tzvqQLG
         FPfQghKRRIOaeoGnHCk3PheZFUzgbQz6mylbIN+4P47Zl5miQVn8loxR0l8nNxZSgh2U
         7YuYa12Q++aBFXaSbs3yGpLK1qXbP2lGyjJGV57PYSi57DgA6s7JCMRQyPEz3OxWhxUh
         BP3oJ0s7/77bDfKOaM3AdS/CXSXy7kCCd33MEsNvL+ktX/gUuVL+0yrWbLJZoD+Xo0Wg
         Q8skY1sJyIH5eOT9wOLZHj+pQFW0WOW6/fwgLs2q353F2tQ0/hx1h9XqWTDsXcfHfmtq
         aF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725038000; x=1725642800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuoWF+ip5aM6TEiw7ZGe1txftEmX/FKCbSWMdfUV8/A=;
        b=Qvll4tHLK9KLYWScz855HIdkINpWim5rJcg/6TngstuIX3rcgzsYg2nzjuq++gSBUX
         9SdqOsgn5T5pOH7l9ParZTxSRY64ZFB4bCR5vCu3KbbMo1DtxYsugYl1H8ISoJNyBi2F
         Hky1yW3yn0E4llrdm1uVt54HGQDhIzz+z6AA4nRs0lg/Nopx0CL2fwu+hV8gfA+HH5CB
         DdzNzinBTOJEZZDQYTEAU9nXn/vHwIyBrUSgP2kihcpa1j1X1JokMl40kw/7AiZLsKo2
         r+9AvIyQgUR9IK0tgqY7yTmsXebpfCveRDYiXaBdYXPmcEN5j/nzVepeOsfqDoUX6GGc
         RB4g==
X-Forwarded-Encrypted: i=1; AJvYcCUWwiWI+ggp5Maknj2uwvvjp/ARpsPVTa85t9SbhrA6OJxNuRO5/8YkCUGFiaUbnsXsRU+qCxwqsS/g4h4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xg8+CvN2TVTo/ry7uL+Bg9Jx2URUF8T7xn37fUiLmu0N5vow
	64V5BnsVpciECxZJdtdOMvis7arFIeneE04YB9QUh3FaoSC9eZQ9Aa3BdVmpQ7Y=
X-Google-Smtp-Source: AGHT+IGpRicXrqdm01FNs2Xf4peUE9dkraN2jSOKc/ODVytIJ0oIAMDjBRGLiHk0ZMkrGisuSp5+Cw==
X-Received: by 2002:a05:6512:2308:b0:52e:9fd3:f0ca with SMTP id 2adb3069b0e04-53546b2c402mr2032494e87.33.1725037999329;
        Fri, 30 Aug 2024 10:13:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079b76asm695592e87.43.2024.08.30.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:13:18 -0700 (PDT)
Date: Fri, 30 Aug 2024 20:13:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 08/21] drm/msm/dpu: add CWB entry to catalog for SM8650
Message-ID: <audsl366wkyqlizb254haxchirlgycr4wpgmp7sbkmynafivoq@pyanmqyfwj7b>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-8-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-8-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:29PM GMT, Jessica Zhang wrote:
> From: Esha Bharadwaj <quic_ebharadw@quicinc.com>
> 
> Add new block for concurrent writeback mux to HW catalog and change
> pingpong index names to distinguish between general use pingpong blocks
> and pingpong blocks dedicated for concurrent writeback

Please split into two commits.

> 
> Signed-off-by: Esha Bharadwaj <quic_ebharadw@quicinc.com>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  .../drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h    | 29 +++++++++++++++++++---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  4 +--
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  4 +--
>  .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   |  4 +--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     | 13 ++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |  8 +++---
>  6 files changed, 48 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
> index eb5dfff2ec4f..ce2773029763 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
> @@ -252,25 +252,25 @@ static const struct dpu_pingpong_cfg sm8650_pp[] = {
>  		.merge_3d = MERGE_3D_2,
>  		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
>  	}, {
> -		.name = "pingpong_6", .id = PINGPONG_6,
> +		.name = "pingpong_6", .id = PINGPONG_CWB_0,

Should we also rename such blocks?

>  		.base = 0x66000, .len = 0,
>  		.features = BIT(DPU_PINGPONG_DITHER),
>  		.sblk = &sc7280_pp_sblk,
>  		.merge_3d = MERGE_3D_3,


-- 
With best wishes
Dmitry

