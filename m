Return-Path: <linux-kernel+bounces-537508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA19A48CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB0516C469
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A0B276D14;
	Thu, 27 Feb 2025 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Awzz1Z6Z"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC2D276D02
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698827; cv=none; b=rJ/jEg6vwpJtCDrWRIiLeOi5DGL1aPI34Qa8xW8iWbD2ywdEIWX7gRnYWYLm2mlhmvCLh9G/wne/bqyjRbP5RnXuUlVInkdZu5NaA9swu5yfmYMaAWFAW7S69C+nvtER/vlQSVTb/oLEJE9R3FaMwXH1eGywznZWiezZAltos7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698827; c=relaxed/simple;
	bh=vHArphDL+AF63sqMCEKJ2/8BT0u2aDwUEc1CXbvGc0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+39pAROzm7iYeYVHnQZ+VwPXfRx9BXKEaELL4YtVK5rSfVpITdbGC3FcWu4ruwohQux5tHIw1h5SS9FZhHJTCAcho6fuTqaHZEzoC3e1bAdEGyWBRAlwejIpSuSE+rjwsM3D8dqz99v0UXitPzGvO10yXl7fNzn+2ofu37XwFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Awzz1Z6Z; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5494cb8c2e7so333440e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740698823; x=1741303623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7WNTtnPyIuJT+/uJWKYo/FYFhAssVEsvM4kIc7boJOo=;
        b=Awzz1Z6Z8n7F8JyYL1Qw34WCRENDCcJdmOFUW9XqZs5ZraNYJgsHtNTDjYuV+DS6FE
         0wclzxD8a9Iue3UuuNw+0SkbKwVswNV2+/UOpBDOdsNdO92CazZmI8W6iKyCEFdUqJGf
         TIHvkvBIUAF1Ns8f5AO+cAJ/nykg8xJTwm/QFQ1Wkhgqrr6d+xZjEcdhEkVDfWmH00j+
         aN1QcPjNXdCH7IutDkue4MAR0y1740Y3RcrZQ2mXVMntsp8qs2w5Lo5H7XPi93p6e2ir
         3gnLbsgAiGmPUWLxjRHQNZ3lyuPZVacelea+8XU8OLPw132o7/JQdU0VpZB4QPUsVZTX
         XRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740698823; x=1741303623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WNTtnPyIuJT+/uJWKYo/FYFhAssVEsvM4kIc7boJOo=;
        b=KYwRX3X7kI8+VPZESU+FEe3hutwhqhVOnfIN9FcY8nJk0EzyQ9qzGy/1WHwLfrX26e
         2NCaGHRIJkW0lHTCsTsLrqOj7megeJ8TaJZqxEpboPZ1QMS0bPPsFHhado1rzKjbVOt6
         Df7xuTYlWD3P4yfwr+bOCO/EMC6dl+ZBGXIDD/Zng8QgIBwORyMF9JbRgPPe+G4HOgl8
         PDdKhSReMVN1waGl47qZpPolwyjXA6QnS6cUhY/slhfcrigIS1UNBsREzc46WosT2PZt
         pdmATv9yQkrdQGZ2hGWcAVC5VylIIDac9DOTTH8+iAUjzjrXlFQcW3CR4lDfW0nVG5Vx
         2exw==
X-Forwarded-Encrypted: i=1; AJvYcCUN9cVaNqELHOFaDB6gqo0Zd5yhdcQ/sUSSH5cnvhVHomtIcB3axjR0u8e2NHTj+UrhoFMZ5OPbXjLBbaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaA9GnM4Txr8bsxCekHltdlADA4WldIXgzgpWD6mp44JarhjP2
	nRANyU0uzSoORnsI2wefmG2XGYgW+pZykmS1S/oewQLOQv0UmRIvsKYM2papyv4=
X-Gm-Gg: ASbGncs9ZcjfhUrjr6VX/Zptc4SHgV47+ZJblrdcaDiPP/InA50HsD7Fj+lrwLEBj45
	PZhIHmQCZPzrQow2i+dueGBTxuWhJPvrjA54b9kOwTo6+DK0QtrmIi63v9XhxQok5gE0RKHPsQQ
	XLq1MjCGqt7IEOTbHx5OVdYb2Lkaj+2IrpFPphpbEE415f+TN/OlcBQ0+kleegZx00ZRvR1ZclG
	ZABiSYg3SNaAhnqK5P57OuqvokbezBXe4tflWKIJc29qoYUZb7hYobuShYI8Pf9EM0vpVVSUwf1
	n6NGbHnzCcRyAsRuJ9rZHfiW4RVVUPvkLIIOria4jaB5XJIfP3sA9ik6js+TzwINZdnwkuy8uiQ
	yb9fAQA==
X-Google-Smtp-Source: AGHT+IHxjxlMLhD3oxVC5PDwEv4tONUbYy57JLfGirnQiWK4YcosMJV+1qf98e7hbSx7Q8klj5cPTw==
X-Received: by 2002:a05:6512:281d:b0:545:2950:5361 with SMTP id 2adb3069b0e04-5494c129f93mr514211e87.5.1740698823331;
        Thu, 27 Feb 2025 15:27:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443be608sm299637e87.173.2025.02.27.15.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:27:01 -0800 (PST)
Date: Fri, 28 Feb 2025 01:26:59 +0200
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
Subject: Re: [PATCH v2 3/6] drm/msm/a6xx: Add support for Adreno 623
Message-ID: <67jiudy4bopd3mzoylj47stuxwc5jdt63akxwn5qqo4dov47za@xcece4v2k3m5>
References: <20250228-a623-gpu-support-v2-0-aea654ecc1d3@quicinc.com>
 <20250228-a623-gpu-support-v2-3-aea654ecc1d3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-a623-gpu-support-v2-3-aea654ecc1d3@quicinc.com>

On Fri, Feb 28, 2025 at 01:37:51AM +0530, Akhil P Oommen wrote:
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
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 0ae29a7c8a4d3f74236a35cc919f69d5c0a384a0..1820c167fcee609deee3d49e7b5dd3736da23d99 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -616,6 +616,14 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
>  		gpu->ubwc_config.uavflagprd_inv = 2;
>  	}
>  
> +	if (adreno_is_a623(gpu)) {
> +		gpu->ubwc_config.highest_bank_bit = 16;

Just to doublecheck, the MDSS patch for QCS8300 used HBB=2, which
means 15. Is 16 correct here? Or might the be a mistake in the MDSS
patch?

> +		gpu->ubwc_config.amsbc = 1;
> +		gpu->ubwc_config.rgb565_predicator = 1;
> +		gpu->ubwc_config.uavflagprd_inv = 2;
> +		gpu->ubwc_config.macrotile_mode = 1;
> +	}
> +
>  	if (adreno_is_a640_family(gpu))
>  		gpu->ubwc_config.amsbc = 1;
>  
-- 
With best wishes
Dmitry

