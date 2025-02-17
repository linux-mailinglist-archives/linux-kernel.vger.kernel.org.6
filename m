Return-Path: <linux-kernel+bounces-513520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17773A34AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31C37A5E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FF028A2B3;
	Thu, 13 Feb 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKBTWCnP"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A128A2AC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465701; cv=none; b=QOMgWqGJk80WYZbUygtHv8DxYo1Y88zUapqkFRiAzhq/qGNu6a5vhvcXdf+rnUpt+nD0Mv5o5qAww9x2Q+GvbOdr6ra4aaOxrNJ9o6DZK9W1b4sZLztwJcP4bgyQbe7Vvcj/fx+Q287EBCIQETK9xS0lMyVwLjsCeFN8N1YLOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465701; c=relaxed/simple;
	bh=RkDWSmnahsB/HZ7aQ7IkiNMnnFlUzUm+oA0hC7jr5/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbSwjan7yaae8rM20U1mmvGTJotslvEvfm6jvd+bLLfCaB6j3FEl6SCVun5iJBeK/2LOTwH3yZLfU8RrjlvaaFwHEmdaqEcW0mVXpbIoCLLoDFrjceEzpTQX5w3GaazlyRFJmHajNsI5whtGravsTL6ABr9YqgiUUkwz6rTi6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gKBTWCnP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5450f38393aso1023353e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739465696; x=1740070496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwV45hdyS0glOo3jiZV6QnhWvFYdES0z/A44sINBKLA=;
        b=gKBTWCnPS2s3zV5vYrqNxL+K4btRM5c21tXuu35SzahsMnjgJP9hFETNdVIf6UxVJr
         8sd0vAzVAe5WYmFVFk78YxFt9jvk1aM8VnZhGriCmxfoPGCpDyoxerxwiFtdq3fKXW1F
         IVhmvJZEUtLEFNDuCqnk1kx7fJCsCNCeAHH8AyXqOl4WVekvGWFhi9G8DF6PZqw/OzVL
         mHOOEYUlqJY5BTYptk/di0NpVZCfz96uUVIr3gOX/NEPnEr+/0nmQKMCrbFrABrogrFs
         0jW5WWG/dgLcxq2gJUnrJ2b/Hj5WyBVIGAf2+7NCt7rma+bqB2Ulpz2jsnGj5czP3Fqp
         iLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739465696; x=1740070496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwV45hdyS0glOo3jiZV6QnhWvFYdES0z/A44sINBKLA=;
        b=QqK5GJJK7oqPiV6KbtRgfN06jEFO5pZB3ig5d5/Hexd+D19f6121YsObM1fMtggLBC
         FblJON7sE9T4972IF2gsx5ELYqvvtE16VM45NlQXTULiVwoKln+TEcSHci8tNXF+FSpX
         dEc+CPCFHnpWzq9jMEvH/xfFSunUHTREVy77kp8O76MhW8W2AAcvi/b/AOTLWF0xcSum
         khvHVgBtuZqdglnQ5m8K03FHhZFrN1DYG29Sxdp5167/jFRlv2GzC/IX41ag/r/b2Q+n
         uHcQAQMtzQPbOqgNdIJJWpeP5iIKgo07fZFt7JqP3aIXET78oYNWEjsG8uxEdn+Lfdid
         Q71Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0WoZIp2qQiDJXwYPvWsWFceQsKTuPcQPhx7YCZsi7E+3JXk9ofNU2rAbQy0XBzBnI3QYXEAxmPK/toxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsJfCXgHNwirTNeDS2Gy890snKfJLhPRdSqtExIYOLI/dmQom
	XTJMf+o19oZb+1aZIVaBQzpmpGn8oYGGGh/3UqEoLCUEd+y/UeVWwhOYU4ZEJjJe/zgNMRdp6Ql
	4d8g=
X-Gm-Gg: ASbGncvO3uJds0CN6Q7FfM+pbOL0eCdw1tWvXbTP5Z6it63QzsLaGRnbjKJ7tuvkwLM
	ESuOK5NO5uMebhd8cTcbj3ItCh/Jhs8tcJ955lV1j91S/fkiKnbq2a48GKs/NjCldQnQf3k6Qx2
	NJjSbpzvfljzeikzVmh3dmjqGQFFxVoA5V+gsnPudSTKZgScCp0ENa+PwoJGIQxY44hmP+Ik81u
	5jMXU0peKscQg5BOPeAdMUqSRamIDtam8BeDOeMEn1IkuA5qUn89ckMTJuZ+Xw+msjeJS5NjWDu
	+WKqBbJYvDlAKLWE5eZGcCSgOM70T8SAhEXx38bZAFJfBq0LM6v9DV4tA5SAhWjkqzsbaho=
X-Google-Smtp-Source: AGHT+IHmHfTqLsAoX8QLu52kx0svE3LQoUJ0tRblqSyDipPsAv620UI+8nfG4DUj1UTRWfZkvLSswg==
X-Received: by 2002:a05:6512:3ca3:b0:545:22ec:8b68 with SMTP id 2adb3069b0e04-54522ec8df0mr398466e87.1.1739465695839;
        Thu, 13 Feb 2025 08:54:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105d2dsm221273e87.128.2025.02.13.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:54:54 -0800 (PST)
Date: Thu, 13 Feb 2025 18:54:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
Subject: Re: [PATCH 2/5] drm/msm/a6xx: Add support for Adreno 623
Message-ID: <ttipuo56z76svx3womcrrqurglvovkqehsx2orgnegjj2z7uxn@d3cov6qmmalm>
References: <20250213-a623-gpu-support-v1-0-993c65c39fd2@quicinc.com>
 <20250213-a623-gpu-support-v1-2-993c65c39fd2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-a623-gpu-support-v1-2-993c65c39fd2@quicinc.com>

On Thu, Feb 13, 2025 at 09:40:07PM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Add support for Adreno 623 GPU found in QCS8300 chipsets.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c   | 29 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  8 ++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  5 +++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index edffb7737a97..ac156c8b5af9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -879,6 +879,35 @@ static const struct adreno_info a6xx_gpus[] = {
>  			{ 0, 0 },
>  			{ 137, 1 },
>  		),
> +	}, {
> +		.chip_ids = ADRENO_CHIP_IDS(0x06020300),
> +		.family = ADRENO_6XX_GEN3,
> +		.fw = {
> +			[ADRENO_FW_SQE] = "a650_sqe.fw",
> +			[ADRENO_FW_GMU] = "a623_gmu.bin",
> +		},
> +		.gmem = SZ_512K,
> +		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> +			ADRENO_QUIRK_HAS_HW_APRIV,
> +		.init = a6xx_gpu_init,
> +		.a6xx = &(const struct a6xx_info) {
> +			.hwcg = a620_hwcg,
> +			.protect = &a650_protect,
> +			.gmu_cgc_mode = 0x00020200,
> +			.prim_fifo_threshold = 0x00010000,
> +			.bcms = (const struct a6xx_bcm[]) {
> +				{ .name = "SH0", .buswidth = 16 },
> +				{ .name = "MC0", .buswidth = 4 },
> +				{
> +					.name = "ACV",
> +					.fixed = true,
> +					.perfmode = BIT(3),
> +				},
> +				{ /* sentinel */ },
> +			},
> +		},
> +		.address_space_size = SZ_16G,
>  	}, {
>  		.chip_ids = ADRENO_CHIP_IDS(
>  			0x06030001,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 0ae29a7c8a4d..1820c167fcee 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -616,6 +616,14 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
>  		gpu->ubwc_config.uavflagprd_inv = 2;
>  	}
>  
> +	if (adreno_is_a623(gpu)) {
> +		gpu->ubwc_config.highest_bank_bit = 16;
> +		gpu->ubwc_config.amsbc = 1;

This bit causes my question: the patch for msm_mdss states that on the
display side both UBWC encoder and decoder are 4.0, which means that the
UBWC_AMSBC bit won't be set in the UBWC_STATIC register.

> +		gpu->ubwc_config.rgb565_predicator = 1;
> +		gpu->ubwc_config.uavflagprd_inv = 2;
> +		gpu->ubwc_config.macrotile_mode = 1;
> +	}
> +
>  	if (adreno_is_a640_family(gpu))
>  		gpu->ubwc_config.amsbc = 1;
>  
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> index 2c10474ccc95..3222a406d089 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -1227,7 +1227,7 @@ static void a6xx_get_gmu_registers(struct msm_gpu *gpu,
>  	_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gmu_reglist[1],
>  		&a6xx_state->gmu_registers[1], true);
>  
> -	if (adreno_is_a621(adreno_gpu))
> +	if (adreno_is_a621(adreno_gpu) || adreno_is_a623(adreno_gpu))
>  		_a6xx_get_gmu_registers(gpu, a6xx_state, &a621_gpucc_reg,
>  			&a6xx_state->gmu_registers[2], false);
>  	else
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index dcf454629ce0..92caba3584da 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -442,6 +442,11 @@ static inline int adreno_is_a621(const struct adreno_gpu *gpu)
>  	return gpu->info->chip_ids[0] == 0x06020100;
>  }
>  
> +static inline int adreno_is_a623(const struct adreno_gpu *gpu)
> +{
> +	return gpu->info->chip_ids[0] == 0x06020300;
> +}
> +
>  static inline int adreno_is_a630(const struct adreno_gpu *gpu)
>  {
>  	return adreno_is_revn(gpu, 630);
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

