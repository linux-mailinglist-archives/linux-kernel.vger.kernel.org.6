Return-Path: <linux-kernel+bounces-526239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E5A3FC01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D46F866E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0C215068;
	Fri, 21 Feb 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6Q3n6QC"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71908215066
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156025; cv=none; b=SyUTRtvPSB1+oTS1KxuV3ijbenLAljGdQjwBw7gSQmTY5aqwsAICOkW8MxoFYl3Ne/3zdwwBx7a2uo9xaS3v7NPiqUnQjSm3QlRaAAEy10KmCw6AHRIxJKv0x27LteydbTxvZOXuhHuO0nH442zw5PJyO1blqCUT7FKS6bAyKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156025; c=relaxed/simple;
	bh=17uKUo9FOPy07r+XAiIBseIm0cdymLN5f3xEcVtffWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiZT9/4EpKzctitF0mWAYhJtMI2A4VAzYkBRathJMKRhv3XbpEhKNT7yPL6Pv0wcT1jd4z4yMZpSmMcDdbIDB6T1lCH2HxeRknuEqa9rUFAvGOd3OLclmkfg02jz0mfLndnCGftQuiN+UxR3ZOzYO+97UnMlPwhr4jbqm0N2ntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E6Q3n6QC; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5452e6f2999so2397283e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740156021; x=1740760821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeJTx/vmHBx5GNuwonywXW9ioDFWEnQJoc6Kq60Yt8U=;
        b=E6Q3n6QCPyYl/qtLwU94xCNQSql6zjpvWVCqvzHGb6UqQ4GTFRZoLr7ICjxNqSlcE2
         qsl0jhY3Ba9owghfbvkztyjirHiAbiYHdaawZCk5ncuHIg6DVKXliQWxhwQ2nbbp+9q1
         oNi0HM03UnlWfwjn24mGvDTbpnvBjQtHAGGnidVxswCT2FF8+JWNQLfaSQpZDBpsOacD
         +ID5ubx4lamDsB5MoKMxZ9kI/GhoD3RJAsHk5Ce5shPcCGO2gJIjMEWTWxs7ibOmIkJz
         QYRWeOSgRj46oQ0YQDkkSGPs/1NdZ6a+FXWNNP96NXRLr1/kXb3h9YWM1nPom4Cp9yZN
         nNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156021; x=1740760821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeJTx/vmHBx5GNuwonywXW9ioDFWEnQJoc6Kq60Yt8U=;
        b=s7wMtxcokhcFlsq4DLnF/FbbZMAAi3n4kZ9zCK6RjXhryBYVH5x98IF38KIejSl6ju
         m7jKGCRb8MxZ/p3bvhhl7wLuWBaA/Cmb8vHfz+jFqmqh0ObqoVfQgDDQac0u5XJfKnV/
         Ejl8Aw26OGb8xh30kWGF5Cn722JQBmVUH4ZavU9A6QCa6cem3k27381FBTRTEp8ef63A
         UCom+YRDScYjlVoMLJCN1Jm6rul49NiXry+3M9uR+tL1qpxdrgQqPmoQTLm9TJuq3EP/
         IkddDYFju49WDrylTG5HgQRwITGia6qEclnqtBtO6SItj7Epgk8KL7Om59SdBVJAXziq
         d9AA==
X-Forwarded-Encrypted: i=1; AJvYcCVz+pNpeOToIremypf0+KW7RBrPqG2Wbp4hecCOyZ3k55AID4g6qZfSyspVY6mXWp30szQuf7EuJsHJGjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFcaWYOp7bqyt+o7Py8B1RbOv1F53UodTQBbtFvE6/3QPPKTY
	XuV1jTgw6EZAL8XeTJEAGPW+y/jHDVh847iKFaA6znWphqooR+3U/nwpakFGkP8=
X-Gm-Gg: ASbGncvCq19GkVBqHh2TH9g+9JT4GUTePCYV2dIHBZifWqJE/gIVPKv6GGPOwYrXNgC
	c9LxEjUsQgET3jez4XQCUimA3yD4WkXld6ar7E+EECEExyPS9wugcTfLk6Y/YRUnsesmo3DbDqf
	Ik7SSmMfVstp7MIgTGlLfiPHq6fXyK/Hv192T72CtoCV4Nc0btE0pk1jcgIFquIUj2IgcxsPIhX
	e1NTMQ8cNoB6i5GY4FajMAFIhHoJni7EWnxRNlkCUjwB8Q+KaVm344/yewGFSENEg/rsz3AkUq9
	LJgnGeH/9j9OVmWsz89pPhhuT15Gm2Ez3ErJ8qWdVyuIGs35zztn3qhBrLodhPmwFvVFJxlAcwT
	WXzd9jw==
X-Google-Smtp-Source: AGHT+IG3sGSgu3fmfjjVa5dP0zopYhRJHZeGFgM+rQzAw/dbKCd7icrIJbdMAouX19sYLz/WmVSHOA==
X-Received: by 2002:a05:6512:e97:b0:544:11cf:10c1 with SMTP id 2adb3069b0e04-54838ef8ae9mr1535911e87.30.1740156021503;
        Fri, 21 Feb 2025 08:40:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54531815e02sm1992234e87.228.2025.02.21.08.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:40:20 -0800 (PST)
Date: Fri, 21 Feb 2025 18:40:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/15] drm/msm/dpu: Enable quad-pipe for DSC and
 dual-DSI case
Message-ID: <kouoar4xfsyuxmxjg3pc5jkbddpc7kbyvdpqkwnzecuroilnra@4aa4cpdkr7gc>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-15-c11402574367@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-15-c11402574367@linaro.org>

On Mon, Feb 17, 2025 at 10:16:04PM +0800, Jun Nie wrote:
> To support high-resolution cases that exceed the width limitation of
> a pair of SSPPs, or scenarios that surpass the maximum MDP clock rate,
> additional pipes are necessary to enable parallel data processing
> within the SSPP width constraints and MDP clock rate.
> 
> Request 4 mixers and 4 DSCs for high-resolution cases where both DSC
> and dual interfaces are enabled. More use cases can be incorporated
> later if quad-pipe capabilities are required.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h         |  6 ++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 28 ++++++++++++++++++------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h   |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h      |  2 +-
>  6 files changed, 28 insertions(+), 14 deletions(-)
> 

>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 64e220987be5682f26d02074505c5474a547a814..804858e69e7da1c8c67c725aa462c1a558d1b402 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -35,8 +35,8 @@
>  #endif
>  
>  #define STAGES_PER_PLANE		2
> -#define PIPES_PER_PLANE			2
>  #define PIPES_PER_STAGE			2
> +#define PIPES_PER_PLANE			(PIPES_PER_STAGE * STAGES_PER_PLANE)

This should be changes when STAGES_PER_PLANE is introduced. With that
fixed:

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

