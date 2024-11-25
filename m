Return-Path: <linux-kernel+bounces-421383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFA9D8A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A491675BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A442500CB;
	Mon, 25 Nov 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kU+H2+Zg"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51437D268
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553205; cv=none; b=GcgsRFXdnNvVEuQQ5u7GVdPJ9s9Lz8YNt6XzDPScinUoK+PWLZXujzGzPcTbCTI5eHEa3lV6fzaCFB43NVFu3M2EU/PoOgOsrtJdSRnEYZI0FgAEt2vOZHphblaXInd8bDXuo36JJWq/R/ULpOc6sfYXipMdHyZsLEBDJoM+j3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553205; c=relaxed/simple;
	bh=TmhDZh4uJYsIr4ZcPM6+teizhg5NlbWqFLasKlVHwa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEumkcHVpH1V2k6ThQDukgjqtUIBJD5d0QqjGlaj0NFWsNNnDutnYkXA+XKqLzf1eFq27+BtzdModqf1O8fzmjzNmkeEDa7HAsZXuOLDH9M+GGkcX62K8z/6cSw3W1ggscem4/QmC1C6OyDpggt//b95UWS5PhaMSwBKO4dmxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kU+H2+Zg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dd59a2bc1so3633517e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732553201; x=1733158001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ykbKQkuo2I4PEhIhBhe30Yc7TSw4jX5a63Tm3U6voo=;
        b=kU+H2+ZgF2TSFVlz8DTyOx6BsROdtw4Cq99440/bkF8sW8b5BclVXQY1pLpTspStIs
         oFpKPLOmSb111kf7ofKCkcpAgXLf0FM2agZApr4tKSK0vW8sPAGgtqw9uUfCc5c8lyA9
         7/ogpUvmHX2a1q+jq6qYKDDRlLK9WubjHChdGWuXOOML3eRgYtJpT6/S6T7mxZlmPCZn
         DLIo4oCyduvvw9Q9BnBwHbdKRP1VUjTMXmC4iH8MKvoMr+PXZV9w9vxMRiosjGQ9G2n/
         mv7UDzCUA2Ha78wZsTHYUIdOx5oWn19m+yvEjeoRQNU3X00mSYZpGpaWyaJu84icjKbN
         Z/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732553201; x=1733158001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ykbKQkuo2I4PEhIhBhe30Yc7TSw4jX5a63Tm3U6voo=;
        b=FaY4rVp482nFpMbFltCCbZDPdDU9OfrbiF6Dom0cV/sWcTFjc+PDO/8DOBjj39tohG
         u804TiMj2qrlB00BTArYmV+InZBZ3LpWbxC6a92YOv4UXDaqiguft4R3WCVJ8uK+SB5o
         kgmK/uNUehLS6qWdUtBCXa0hDvpj0oAIA+lXtpxnxkDymMT6T5blKHfFjtIuEKuiresG
         CO8UwxM7d7KRD7dD+QX0Ddq0zz6a2cHrl5M/LtFWj+CXULm3S8U+fUOSe5PawiOGmo2i
         L7wBKtmNJHGk6jU7XYMXSXl8gsfwft7ILl4qamBrOuyUYzd5pMkVrmM9/NWfgkpizODo
         n+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU2GYgS/CYmEZiqBOOxIQ6jUI1m8LTGiMGFDGH+gbUHhHGPd7DT1WDfZqscOYHjT4YjUrY/ZBMxPLMgAkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIYfv8CKzUXxXdHqxtZ+02TLpwQVABa6DxPl0/o8t0YjQPRCbP
	RS8WMPQ30Bcyi6TZBZ9AbO1J6b6Tm7kX2AVYF09Hm2Ahk/9fN6sZ2vDK8tEqgx8=
X-Gm-Gg: ASbGncsRsFpYUWUVy6exQMeDGVRwuTeAzSeQxudfKN1h40WR0aRkt7TVn75GEw5GJrB
	IDSaV+toJU1DykQpqKKAx/Nr+FcMbXdOGcmPL4JGsxBsRfbOruvUuJFadlG2Uwqz0BiEvcvS8rW
	+9Amez3svHW2xC1ErYOa7xCZmE/QRyf0F4z4dcNYsj6kifAGK9TjhBMM5Nyo3y1mSqMejL2hGq/
	+v9keiIP1R5HqgW9Nkc8a5QMLsA3NRjYQ/8TJedzX0XkYAWf8wuIzc+WroKWngOkgPo24dERzZ4
	HHJISQ4FTf9faboxC7QkUls+JkAFVg==
X-Google-Smtp-Source: AGHT+IEIEs10x32BmBHwyCvNs3GkmUc0gOFBfdig3YObcsa/6Cquloa5nXm0+6tXaumC980PBV2hcw==
X-Received: by 2002:a05:6512:1593:b0:53d:dd50:1a94 with SMTP id 2adb3069b0e04-53ddd501c1dmr3313733e87.53.1732553201410;
        Mon, 25 Nov 2024 08:46:41 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451091sm1715437e87.65.2024.11.25.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:46:40 -0800 (PST)
Date: Mon, 25 Nov 2024 18:46:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/msm/adreno: Introduce ADRENO_QUIRK_NO_SYSCACHE
Message-ID: <vfbklrbereo3j5dp2w4pvctef364sb2dqogccmaevjerkm5u43@jytwobqwvuv2>
References: <20241125-a612-gpu-support-v2-0-b7cc38e60191@quicinc.com>
 <20241125-a612-gpu-support-v2-1-b7cc38e60191@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125-a612-gpu-support-v2-1-b7cc38e60191@quicinc.com>

On Mon, Nov 25, 2024 at 10:03:00PM +0530, Akhil P Oommen wrote:
> There are a few chipsets which don't have system cache a.k.a LLC.
> Currently, the assumption in the driver is that the system cache
> availability correlates with the presence of GMU or RPMH, which
> is not true. For instance, Snapdragon 6 Gen 1 has RPMH and a GPU
> with a full blown GMU, but doesnot have a system cache. So,
> introduce an Adreno Quirk flag to check support for system cache
> instead of using gmu_wrapper flag.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 3 ++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 7 +------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   | 1 +
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 0c560e84ad5a..5e389f6b8b8a 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -682,6 +682,7 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = (SZ_128K + SZ_4K),
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +		.quirks = ADRENO_QUIRK_NO_SYSCACHE,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a610_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1331,7 +1332,7 @@ static const struct adreno_info a7xx_gpus[] = {
>  		},
>  		.gmem = SZ_128K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
> +		.quirks = ADRENO_QUIRK_HAS_HW_APRIV | ADRENO_QUIRK_NO_SYSCACHE,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a702_zap.mbn",
>  		.a6xx = &(const struct a6xx_info) {
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 019610341df1..a8b928d0f320 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1863,10 +1863,6 @@ static void a7xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
>  
>  static void a6xx_llc_slices_destroy(struct a6xx_gpu *a6xx_gpu)
>  {
> -	/* No LLCC on non-RPMh (and by extension, non-GMU) SoCs */
> -	if (adreno_has_gmu_wrapper(&a6xx_gpu->base))
> -		return;
> -

Shouldn't it also be a NO_SYSCACHE check?

>  	llcc_slice_putd(a6xx_gpu->llc_slice);
>  	llcc_slice_putd(a6xx_gpu->htw_llc_slice);
>  }
> @@ -1876,8 +1872,7 @@ static void a6xx_llc_slices_init(struct platform_device *pdev,
>  {
>  	struct device_node *phandle;
>  
> -	/* No LLCC on non-RPMh (and by extension, non-GMU) SoCs */
> -	if (adreno_has_gmu_wrapper(&a6xx_gpu->base))
> +	if (a6xx_gpu->base.info->quirks & ADRENO_QUIRK_NO_SYSCACHE)
>  		return;
>  
>  	/*
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index e71f420f8b3a..398be2218110 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -57,6 +57,7 @@ enum adreno_family {
>  #define ADRENO_QUIRK_HAS_HW_APRIV		BIT(3)
>  #define ADRENO_QUIRK_HAS_CACHED_COHERENT	BIT(4)
>  #define ADRENO_QUIRK_PREEMPTION			BIT(5)
> +#define ADRENO_QUIRK_NO_SYSCACHE		BIT(6)
>  
>  /* Helper for formating the chip_id in the way that userspace tools like
>   * crashdec expect.
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

