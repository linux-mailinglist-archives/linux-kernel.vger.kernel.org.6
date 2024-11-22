Return-Path: <linux-kernel+bounces-418086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE89D5CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8DE1F22AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C111DE3D9;
	Fri, 22 Nov 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pj7MZCM8"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052BB67F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270040; cv=none; b=T6Cf0/RaYK97TpdYQJx8PUubg6GHdrdEX/mbAXQ49WN8TIFKHHMUhA4DEs6xIQIJVaVgWxdPl3MLge/GNJu3eJWy41pJa1ICVEa7L6NAb00bIxik8ik7uSzitZcBU0aEBGWqu/WT2X7qCWHaRKyfChZT2V8Qj/VRLueEPdCtln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270040; c=relaxed/simple;
	bh=ePTtXXdtrb2V6GMKMuYSIWDcQsD3/Vz0olaoJ86XrP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7+Exs4eZVdEHznBqRZ4wZfhiNlfI2MmQ6bMUrxRY7wc7tasWdEhXz01L5/ij/7ZFx/wdacCVqPcq6GHOOOLnG8a3pRBvj1HAmnmmeeb/nkhnmoW+VFWCeAxnEvdW1LXBBPS1BwJoVzfc7cd5tESQHeLu3/JQMQqgysxhEqPPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pj7MZCM8; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53da2140769so2203066e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732270037; x=1732874837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GO7fVK+g5VXFiw6jUirAsxcaeR1tJ6lVtHXzxXnqFYQ=;
        b=Pj7MZCM8EzxpsSkKNsn1jIHFFXFm43FL9O8R1ieBoutADEeOuzfSQ/kUkscAv8mlSi
         1Zk9NsnQ6wADpEYJXn28bPEQNxDQR/0OCk2rjXSuBa9Tt+O1DGZ2XF4rfxUvrKhLpvek
         cSwrbs7rYEaI2bpNjOss22e7o6j1MW1it0468nO9Wdg/fBHEZ6uJVmPrEJkoopEwSY88
         vKUiS+XjT2zRGh+WyE854TE0/R6VwCRawOl15PXKNnwwNr5jzGcK0MKo/iGbOJmkZN2t
         xheCMqW9BU6KKeKA3YTrzPrRLJBWqFY9LcEh0Nofwla6L3HSfEEbJNRlVVCZTKdQldK8
         d4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270037; x=1732874837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO7fVK+g5VXFiw6jUirAsxcaeR1tJ6lVtHXzxXnqFYQ=;
        b=D6NH6vFArmRkvYd229pUCS50r/efL2IU13nlzzlq8fvqLlVm3nJvI0Nj+gogLJuptB
         12ZLsKmqduOE+6bsNB5DMAXXQ7WPmBirf31jy+O1Rrh7E9yXrJwOhWwN9VMPlxhCq8vi
         B2NkHKgZw0W0wXlfkQ80QfstwuDKrRPyXXMgnjyJqda39UMCRhUYqtRNDjy6qxs+8Z3G
         rqrSTlML65SUgJnLy5BMFt+DWEbSffI53l490sRwLgzLBjdymmNkxDIIKiFqNCetJPp6
         g3WrjU2HXPIKb7AjNy1Vb0+Juwvy3v7Ygs6Xv90Z/2tOUO+WaMwA7cs6muKdewrOeD91
         tE8A==
X-Forwarded-Encrypted: i=1; AJvYcCXAe4IIfzoUelpaPp7xTt9zKhZf1mbpgfIVqwgbhMwLW+dwiecj0eYlVvXUwNispW+tzZjT1FX6JxnMCBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxenbff71BJvXdt1ZW+QcqL670UIaUf9HwwGhD0kSF/V0aW8sPU
	grLrjTCCSnTP4Q4STunEL6buv3jFxfa8Yey43YFzpl3h9FFxzvaUAGNc1aeKGG4=
X-Gm-Gg: ASbGncssBPUkcb7+hBaUUfqEDgCgv44HwZbqlSB4uMfYX+RquxQ3ogkSz621LbLisuZ
	r8IJVQzvXiUYbB1QU+zsBbBgVrDGmufVN9u7OshEEFv5mnIDRSlnA24uR/r3B9LNsQfAvla0/cv
	WTHUDpQa4M+7k5KkLgHXdPbyMtmA3rqT2z3d2AKOQHpU5yWZJ3R1yx+TeXaCWTtUQ19ClpWazCs
	G+KFvhScFKtgL1m/Nu0Yt3ujnKflGleW2JPES/4MQ3q0S4HioHqUxGCVpKGBP03Ceoe+cR3mMMt
	X+zvm9PKT5X1UG+5n7vVqR3jz/MNVg==
X-Google-Smtp-Source: AGHT+IEAFmL7UZg1uTfDDRPoy0BBuksKzzgZGM3TutSiUK4Zl501M3PKPyCwG30hNRGeBsF6mBGDwg==
X-Received: by 2002:a05:6512:1110:b0:536:a695:942c with SMTP id 2adb3069b0e04-53dd35a4f17mr1072878e87.7.1732270036793;
        Fri, 22 Nov 2024 02:07:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2445712sm314765e87.40.2024.11.22.02.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:07:16 -0800 (PST)
Date: Fri, 22 Nov 2024 12:07:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Li Liu <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/9] drm/msm/dpu: Add SM6150 support
Message-ID: <bhylewwvztm7gsmkjwo6asceuph2jlqgvy2lhocdvg6r7y4i6w@duvbnsko3xg2>
References: <20241122-add-display-support-for-qcs615-platform-v3-0-35252e3a51fe@quicinc.com>
 <20241122-add-display-support-for-qcs615-platform-v3-5-35252e3a51fe@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-add-display-support-for-qcs615-platform-v3-5-35252e3a51fe@quicinc.com>

On Fri, Nov 22, 2024 at 05:56:48PM +0800, Fange Zhang wrote:
> From: Li Liu <quic_lliu6@quicinc.com>
> 
> Add definitions for the display hardware used on the Qualcomm SM6150
> platform.
> 
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h | 263 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  4 files changed, 266 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..e8b7f694b885d69a9bbfaa85b0faf0c7af677a75
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
> @@ -0,0 +1,263 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DPU_5_3_SM6150_H
> +#define _DPU_5_3_SM6150_H
> +
> +	}, {
> +		.name = "intf_2", .id = INTF_2,
> +		.base = 0x6b000, .len = 0x2c0,
> +		.features = INTF_SC7180_MASK,
> +		.type = INTF_NONE,
> +		.controller_id = 0,
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 28),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 29),

Please drop. No need to declare missing blocks.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> +	}, {
> +		.name = "intf_3", .id = INTF_3,
> +		.base = 0x6b800, .len = 0x280,
> +		.features = INTF_SC7180_MASK,
> +		.type = INTF_DP,
> +		.controller_id = MSM_DP_CONTROLLER_1,
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
> +	},
> +};
> +

-- 
With best wishes
Dmitry

