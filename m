Return-Path: <linux-kernel+bounces-340500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92CF987437
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1660C287634
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEF02B9A6;
	Thu, 26 Sep 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTXt6tJG"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A98EEB7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356189; cv=none; b=SA4J85UeZoFLzapMKdC6Zi8xpnMjwuwal/d39iOTF7Gv6xvN01EGkoCjNuAOfpbIcBiCWodxN+c5gCuJNf89fXxGJL+6p+BudLsQhdUc+sPVPVy11a0Rl2GkLBRwm8DKDkq64rhH2qc+K0bbl828oSZ4NHk1wOtnn3o2M3EkKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356189; c=relaxed/simple;
	bh=I+dRXKEY2F5Vk/UYrWXZW9dZTuXlNQBEFA1b5xkyCRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXmGYNb9c3ix4XXljG1ROL+WB/r/+6o3lhjk7A+sD/1K6qgoNTDDrQqOR1JJ6MfPHb7xXjxyHfWRmhJKqARnzbKLo2UsfvQUdGQ9s+BkREOZELHTbSBg6OHbAtsjhCHBGukAPzIw0l8pieOJZwF4zz7XSG+5REOEfvCaPPlojds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTXt6tJG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f762de00fbso11622051fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727356186; x=1727960986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0SGTX2nctnE3KyD4azI9HnZaZaGIo1VmsjB0a2s02c=;
        b=eTXt6tJGE2+pyNRwTVVwno6lzaUqsh8BqugYRicrpM6MOu7m3uLPETeVbZ3obBc5yz
         MktMsDBrpTxrKakGcf0IsZgZksOSLCtvyaYzlbqC9kBz1K5OwwUgmtM19yI4DOSJiq0h
         ggVFJBeU8sDkbTDV3UcgohK9QSuYZhc772s/hndsfCXSxm2mKqceHXoOspkzv3rVL+Oe
         2hwt7aIPLbeHipIJ4GuaR7dIr8kR73eq1h5GLlBtr89A61n4FqrW+3KcRVv8ODbqrfDx
         31yBKQSox1Xn8XFcYM51jEP5+SuS3gCZ3xMWqLcOfD30M1FfLUcVyGm17CSxnyIe8JKm
         YJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727356186; x=1727960986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0SGTX2nctnE3KyD4azI9HnZaZaGIo1VmsjB0a2s02c=;
        b=eKah5DfCaPDEYC+s6PMzQlBdBcWJ+RLo3Q/6f3j1h4UIzZk5x9YLnSVGyqyG7w/o9K
         DClzoM9HU+i7FJ0vwcgGb1TH6+GOxy8+wb8lif1uRoas9e79JOQt90Msc0QnVnsanN5e
         EOOxPtkou3yB6+yxCTqVFWNvCcFyUNBlJZrwZD6RNXp9a+lfV9jToup0YIudyVWkGXwN
         l5nz29T4IYY6H1E7xMgMG1CepgWcHazCxijjEiapX020WYErc0EEpSPksQxXjmkakyYs
         HvygLV4ig/bK5sSYgGpxU1dlr/Xyyo9PmFjeJedPhOAwNLvLbS99tgU6MEDObhL13OTG
         OzVw==
X-Forwarded-Encrypted: i=1; AJvYcCWYYGqKnP7MqcNAehb25jnbl+DdTKwvoDUubUuKYs/3eHYRlvYlwInZk+kmJks9Pb8MldZwXyW0EvBH/3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXS2H/G84/m7t7S80818J6Fo3dAK2iN16P4UAXqDt+zLK4haAK
	As3b1UcHBUL7TD8cPeY7woAha122GnQGrOAyy5BYT7XKFLu1gk3R0eRN5WBY/p8=
X-Google-Smtp-Source: AGHT+IFIZ8N2PzyIbt/P6m8oH4XHu1xxQSGSi1EgiBbvFKiw4ooio7bVELxIdaHYqsHU5DjpOpkmaw==
X-Received: by 2002:a2e:a9aa:0:b0:2ef:2490:46fb with SMTP id 38308e7fff4ca-2f91ca45fd8mr43948201fa.37.1727356185641;
        Thu, 26 Sep 2024 06:09:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d283c427sm7986751fa.53.2024.09.26.06.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:09:44 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:09:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mahadevan <quic_mahap@quicinc.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, swboyd@chromium.org, 
	konrad.dybcio@linaro.org, danila@jiaxyga.com, bigfoot@classfun.cn, 
	neil.armstrong@linaro.org, mailingradian@gmail.com, quic_jesszhan@quicinc.com, 
	andersson@kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_kalyant@quicinc.com, quic_jmadiset@quicinc.com, quic_vpolimer@quicinc.com
Subject: Re: [PATCH v2 4/5] drm/msm/dpu: Add SA8775P support
Message-ID: <w26xpuqeltoxjvewo4zesnjazw23onovcasltzcwrejdpgav2h@p6fj2lts2n4s>
References: <20240926110137.2200158-1-quic_mahap@quicinc.com>
 <20240926110137.2200158-5-quic_mahap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926110137.2200158-5-quic_mahap@quicinc.com>

On Thu, Sep 26, 2024 at 04:31:36PM GMT, Mahadevan wrote:
> Add definitions for the display hardware used on the
> Qualcomm SA8775P platform.
> 
> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nit below.

> [v2]
> - Reorder compatible string of DPU based on alphabetical order.[Dmitry]
> 
> ---
>  .../msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h   | 485 ++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |   3 +-
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   3 +-
>  4 files changed, 491 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
> new file mode 100644
> index 000000000000..14d65b5d4093
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
> @@ -0,0 +1,485 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2015-2018, 2020 The Linux Foundation. All rights reserved.

What exactly is copyrighted by LF?

> + */
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index dcb4fd85e73b..6f60fff2c9a6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2024, Qualcomm Innovation Center, Inc. All rights reserved.

I am not a lawyer, but I don't think a single #include is copyrightable.
Neither are single data lines in other files.

>   */
>  
>  #define pr_fmt(fmt)	"[drm:%s:%d] " fmt, __func__, __LINE__
> @@ -699,6 +699,7 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
>  
>  #include "catalog/dpu_8_0_sc8280xp.h"
>  #include "catalog/dpu_8_1_sm8450.h"
> +#include "catalog/dpu_8_4_sa8775p.h"
>  
>  #include "catalog/dpu_9_0_sm8550.h"
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 37e18e820a20..cff16dcf277f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>   * Copyright (c) 2015-2018, 2020 The Linux Foundation. All rights reserved.
>   */
>  
> @@ -850,6 +850,7 @@ extern const struct dpu_mdss_cfg dpu_sm8350_cfg;
>  extern const struct dpu_mdss_cfg dpu_sc7280_cfg;
>  extern const struct dpu_mdss_cfg dpu_sc8280xp_cfg;
>  extern const struct dpu_mdss_cfg dpu_sm8450_cfg;
> +extern const struct dpu_mdss_cfg dpu_sa8775p_cfg;
>  extern const struct dpu_mdss_cfg dpu_sm8550_cfg;
>  extern const struct dpu_mdss_cfg dpu_sm8650_cfg;
>  extern const struct dpu_mdss_cfg dpu_x1e80100_cfg;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 9bcae53c4f45..16a0b417435e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright (C) 2013 Red Hat
>   * Copyright (c) 2014-2018, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   *
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
> @@ -1447,6 +1447,7 @@ static const struct dev_pm_ops dpu_pm_ops = {
>  static const struct of_device_id dpu_dt_match[] = {
>  	{ .compatible = "qcom,msm8998-dpu", .data = &dpu_msm8998_cfg, },
>  	{ .compatible = "qcom,qcm2290-dpu", .data = &dpu_qcm2290_cfg, },
> +	{ .compatible = "qcom,sa8775p-dpu", .data = &dpu_sa8775p_cfg, },
>  	{ .compatible = "qcom,sdm630-mdp5", .data = &dpu_sdm630_cfg, },
>  	{ .compatible = "qcom,sdm660-mdp5", .data = &dpu_sdm660_cfg, },
>  	{ .compatible = "qcom,sdm670-dpu", .data = &dpu_sdm670_cfg, },
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

