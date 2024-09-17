Return-Path: <linux-kernel+bounces-332085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC997B540
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878101C22C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF541917E0;
	Tue, 17 Sep 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUsd9osz"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF70446A1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608724; cv=none; b=sutNqycOMDsMtOvIaaVHC9u87b5CrA1jCeRPFjdU5JAieOjgbM/INQ7gtsuyL9gd9QaluASQOy+0/VrtJgLMse731f+Mdw/yXXof8O2LpZ6sw91alp2JOa1q8+KjqLJdF1f3bP6cumY1sDWwpvHphP/pb70UWzlwqE1/qSNDPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608724; c=relaxed/simple;
	bh=7imgg8MHnR9gxNsCcaxlqJr1rg23llfOC/+tu1YfRZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNIeEzrlHt5zZOMJbJoj/unk2UT4mdh22LFP+mHsHh3uQl8Cr6pmK9mxdvs4dIIDmgsgSKLKuGgereJMKsvUNEg+S2tAB7pzUEeXTefb61ptuvdBr1qJHMGH4w3IGAjIXqN4lfxiM7l89jrrSAEgJR2N/5nQt+05nwIz6DiHTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uUsd9osz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53653682246so7257087e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726608719; x=1727213519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1R6BTw3CyHrPVMyIN0XqxDT3g5ElbidWKYOyL9ivcME=;
        b=uUsd9oszLmhHzREMuF0DhArJ4j2m5ClBXdtpkH+QKKaNONHEPw08MffuFNnr5FCPQm
         UhiwHTDwAgxy+FuP0cGTnjDxw6knaz7SwqKK+MtXgmq8nSFu7ASc02aQgPZbbCvBLoAB
         le/BVaBe6J2iWYF+AAXmsv1JsuKcHjpNyb++Ko68YxygnmSy74snzr5V+qGqfPvyCyR2
         /Aw7zChbVFahu12GTlqSBCH80ErbSuMqfmphE4WXvs8sPgzbKjVxH8qvlKdfcfl72CZ7
         wi3TJKSa2slxY+Lf6PSunKn2/ZKPGNb7QPxhh97nLedb83RbccMXA5RFgpsPNUjjBGNI
         ef8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726608719; x=1727213519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R6BTw3CyHrPVMyIN0XqxDT3g5ElbidWKYOyL9ivcME=;
        b=i1XCwdcEFVkviaQ/TakJXLvpOHiM1HWwW5WQgXh0a20pO293rW7r7t/CER2X3ERa7D
         WUNXpjMcti6ArvH382dSVeZXE6CMlRDfNzg02iS2blC34wB5eRtoBQM5Qi+5GqH5HaE3
         aQmAEJxu2gQMu3wFjquUtLhBy7AA5ps5nc1mnxUrX5rCpEcEW62e4OJFVIfRFk+s9+aJ
         +F4Et7v5hOXsp9w5Z08SbrrFuG/Dl77merOHQumsyTk+5T8DP/nxSYd7blRdy/LbYUOj
         OKIvOJSAaItIsL+qk7OgvrEzu5aFx8fq4MrJVO46OChSTH2lz1AOZoZY1yKSy4uuVnRw
         EA5A==
X-Forwarded-Encrypted: i=1; AJvYcCVnAl7ay0OUWCns7I+J46lxTTSo/5xQpMoB0jJoiSJqB6FEcGWAqGuAMNJNmu2rrdDumf7CJNyFNcSf+LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYarfUxjNHhBqc1S0bEu/TyVCuDU7lzNWNdPgFA2skkQk21rX+
	fqmefc4u9lNZsDf7Ah2a43VPzJ61heIBQjjlO3FihAkZNVTJ3578Xm8s8X/lHUc=
X-Google-Smtp-Source: AGHT+IHhcqmPzBEx+mRQGBWjo5mWxJ/GGeo4PSbS+lWwhv89D5TADe1zKDPSG1PO6BnyN1AO9gTdww==
X-Received: by 2002:a05:6512:3995:b0:52c:e326:f4cf with SMTP id 2adb3069b0e04-53678fb4606mr12705813e87.3.1726608718749;
        Tue, 17 Sep 2024 14:31:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704def1sm1313577e87.84.2024.09.17.14.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 14:31:57 -0700 (PDT)
Date: Wed, 18 Sep 2024 00:31:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Subject: Re: [PATCH 1/3] drm/msm/a6xx: Add support for A663
Message-ID: <vahykyu4cck26sstulzukl323rskjoqebogz4ckv2aoibb2eo6@kmbrw7voa5tx>
References: <20240918-a663-gpu-support-v1-0-25fea3f3d64d@quicinc.com>
 <20240918-a663-gpu-support-v1-1-25fea3f3d64d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918-a663-gpu-support-v1-1-25fea3f3d64d@quicinc.com>

On Wed, Sep 18, 2024 at 02:08:41AM GMT, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> 
> Add support for Adreno 663 found on sa8775p based platforms.
> 
> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 19 ++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  8 +++++++-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c     | 33 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  5 +++++
>  4 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 0312b6ee0356..8d8d0d7630f0 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -972,6 +972,25 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.prim_fifo_threshold = 0x00300200,
>  		},
>  		.address_space_size = SZ_16G,
> +	}, {
> +		.chip_ids = ADRENO_CHIP_IDS(0x06060300),
> +		.family = ADRENO_6XX_GEN4,
> +		.fw = {
> +			[ADRENO_FW_SQE] = "a660_sqe.fw",
> +			[ADRENO_FW_GMU] = "a663_gmu.bin",
> +		},
> +		.gmem = SZ_1M + SZ_512K,
> +		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> +			ADRENO_QUIRK_HAS_HW_APRIV,
> +		.init = a6xx_gpu_init,
> +		.a6xx = &(const struct a6xx_info) {
> +			.hwcg = a690_hwcg,
> +			.protect = &a660_protect,
> +			.gmu_cgc_mode = 0x00020200,
> +			.prim_fifo_threshold = 0x00300200,
> +		},
> +		.address_space_size = SZ_16G,
>  	}, {
>  		.chip_ids = ADRENO_CHIP_IDS(0x06030500),
>  		.family = ADRENO_6XX_GEN4,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 06cab2c6fd66..e317780caeae 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -541,6 +541,12 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
>  		gpu->ubwc_config.macrotile_mode = 1;
>  	}
>  
> +	if (adreno_is_a663(gpu)) {
> +		gpu->ubwc_config.highest_bank_bit = 13;
> +		gpu->ubwc_config.ubwc_swizzle = 0x4;
> +		gpu->ubwc_config.macrotile_mode = 1;

If this looks like A660 / A690, shouldn't the driver also enable .amsbc,
.rgb565_predicator and .uavflagprd_inv?

> +	}
> +
>  	if (adreno_is_7c3(gpu)) {
>  		gpu->ubwc_config.highest_bank_bit = 14;
>  		gpu->ubwc_config.amsbc = 1;
> @@ -1062,7 +1068,7 @@ static int hw_init(struct msm_gpu *gpu)
>  	if (adreno_is_a690(adreno_gpu))
>  		gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG, 0x90);
>  	/* Set dualQ + disable afull for A660 GPU */
> -	else if (adreno_is_a660(adreno_gpu))
> +	else if (adreno_is_a660(adreno_gpu) || adreno_is_a663(adreno_gpu))
>  		gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG, 0x66906);
>  	else if (adreno_is_a7xx(adreno_gpu))
>  		gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index cdb3f6e74d3e..f1196d66055c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -478,6 +478,37 @@ static void a660_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>  	msg->cnoc_cmds_data[1][0] =  0x60000001;
>  }
>  
> +static void a663_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
> +{
> +	/*
> +	 * Send a single "off" entry just to get things running
> +	 * TODO: bus scaling
> +	 */
> +	msg->bw_level_num = 1;
> +
> +	msg->ddr_cmds_num = 3;
> +	msg->ddr_wait_bitmask = 0x07;
> +
> +	msg->ddr_cmds_addrs[0] = 0x50004;
> +	msg->ddr_cmds_addrs[1] = 0x50000;
> +	msg->ddr_cmds_addrs[2] = 0x500b4;
> +
> +	msg->ddr_cmds_data[0][0] =  0x40000000;
> +	msg->ddr_cmds_data[0][1] =  0x40000000;
> +	msg->ddr_cmds_data[0][2] =  0x40000000;
> +
> +	/*
> +	 * These are the CX (CNOC) votes - these are used by the GMU but the
> +	 * votes are known and fixed for the target
> +	 */
> +	msg->cnoc_cmds_num = 1;
> +	msg->cnoc_wait_bitmask = 0x01;
> +
> +	msg->cnoc_cmds_addrs[0] = 0x50058;
> +	msg->cnoc_cmds_data[0][0] =  0x40000000;
> +	msg->cnoc_cmds_data[1][0] =  0x60000001;
> +}
> +
>  static void adreno_7c3_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>  {
>  	/*
> @@ -646,6 +677,8 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>  		adreno_7c3_build_bw_table(&msg);
>  	else if (adreno_is_a660(adreno_gpu))
>  		a660_build_bw_table(&msg);
> +	else if (adreno_is_a663(adreno_gpu))
> +		a663_build_bw_table(&msg);
>  	else if (adreno_is_a690(adreno_gpu))
>  		a690_build_bw_table(&msg);
>  	else if (adreno_is_a730(adreno_gpu))
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 58d7e7915c57..10f8f25d8826 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -455,6 +455,11 @@ static inline int adreno_is_a680(const struct adreno_gpu *gpu)
>  	return adreno_is_revn(gpu, 680);
>  }
>  
> +static inline int adreno_is_a663(const struct adreno_gpu *gpu)
> +{
> +	return gpu->info->chip_ids[0] == 0x06060300;
> +}
> +
>  static inline int adreno_is_a690(const struct adreno_gpu *gpu)
>  {
>  	return gpu->info->chip_ids[0] == 0x06090000;
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

