Return-Path: <linux-kernel+bounces-309229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20DF9667D3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A15D284911
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749221BA895;
	Fri, 30 Aug 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTE50tki"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F641B2503
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038314; cv=none; b=mDYxc2buP0L2L/67bpMLfVNUwBivX/1tTSvJ0QbXJis1ELTgnblzVRIIaAN3+Oq4KkLyupPw5RI9H6wYmKcblhb4CRTAvi5/vY5uiJtKQhLebYuA8tTfAkjv9Hfm3iKsCjCFlg1tcSAf6zAwqNIJGGSSJtUSkFapmNyW1941wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038314; c=relaxed/simple;
	bh=dIHrH+b7Exc4JyrPUEgMoL09faRO2CSuyQwT4fLzH98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA2Vqy/QDlo86CZQmyQo5Fw3r9xtQIRZM/Cn5r8d1boZkP6qKSc2oAxO2ipH2yfRQa+uRGwKPZZzPoYlZsCqWA8fZfVCaKMwZIH7x1vdaG6g4RWJFiX5zY7rZ2QYhXM3GMvsjiLyT1Go0Yg4y3H5ToOlhzSqi31dNxMuAmu5p/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bTE50tki; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5344ab30508so2958849e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725038311; x=1725643111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KpE0Uc5dFOEGFFibSJ4UWHOb/IqeB0GMqdfzV3gaXTQ=;
        b=bTE50tkiQJOJoRR0FnfMBROkeG9DUG3ioth6PlRcp7pz98TnFsEbAZL95xj85ETyVc
         m8Y5TXlOhX7DAMOlFJzM8hIEqFOQsz8lbPTm2FtwIGrs837ePUuQEz9KNDvePhOdBuZX
         DJ4p01o5fprhLJBHr3JqXXzIZxWNMNTBBmlw5DmMxqanBTYaIU5lGXltDcylsIfdH/YR
         TnkWUDc5nMPWN6qtBklc4rxrO/5wLtDkv9VY5O0txM1dWqPDwXrr1dZHj4vPZZ1yEmBP
         wNpTAk5m2eOH06TuCzAxPuHA4NrPw3a+ItT5T5IJJX3GLwhMDmXilSdH8TuzMrBQmK7O
         8V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725038311; x=1725643111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpE0Uc5dFOEGFFibSJ4UWHOb/IqeB0GMqdfzV3gaXTQ=;
        b=aDpIKOasXHbS7bm5xQ9ERNwV+XVcyOaNIQQvrcKtG4fyu9KzB47KLZOTbl3VfD9Bcs
         48QCGpm8bf60yik/5ohB4lx8GLWYyheLDk1r2oHBjwl4xA4v9zDBENBG5hyf1nhxtz0T
         dD/Q9uTeNIpz02620zykogRxoYzaWZ6POjTfNEoQvECQp9zjjgLoq5A0E3E+ODt3CoRx
         Rii3lCfKkYNJoeHZh941adUXpAuVqmRY4TP0CJZ2ysVB5+2ID8kwi3cNL9bnpGHzTM0O
         wj0ZzHICH/6TkCjGj4AAav7DOiIHXmrU9Udo0qaNeT7eGwBQtOKcuZitFmiFIAFxrhul
         o6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2VBE/beTHzXU3GCJdnh393JlHtExG8t60qEcBpqFiPFEWfBQiYoJcEQsHyl6uq3C5MTeHL8fJwIku3VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgW+Y4o8xNMVnIehoRyslk+sLgtWkeQ3WMSnJZyh7OjBH2bNYd
	osrzlyIKCNdSXEyijYUAvTfg3OveCmwiljrDleOqSgwfgevf6LTRbL4fAcW+2wA=
X-Google-Smtp-Source: AGHT+IH7lCDOnpQjJkBV0xBr9wZhLABIPrs5eADI+IUifWzRid0MPQk+CnkK+72iNFUgRHp+MLBZWQ==
X-Received: by 2002:a05:6512:239c:b0:52e:8161:4ce6 with SMTP id 2adb3069b0e04-5354634774fmr1184289e87.25.1725038310319;
        Fri, 30 Aug 2024 10:18:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac283sm693918e87.106.2024.08.30.10.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:18:29 -0700 (PDT)
Date: Fri, 30 Aug 2024 20:18:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 11/21] drm/msm/dpu: Add RM support for allocating CWB
Message-ID: <pf6xgu7yjanzjigfpupons4ud6jbcmbr5icnd7yur6qhh3n5sf@plj4bi3beguw>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-11-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-11-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:32PM GMT, Jessica Zhang wrote:
> Add support for allocating the concurrent writeback mux as part of the
> WB allocation
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  5 ++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 30 +++++++++++++++++++++++++++--
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index c17d2d356f7a..c43cb55fe1d2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -1,5 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
>   */
>  
>  #ifndef _DPU_HW_MDSS_H
> @@ -352,6 +354,7 @@ struct dpu_mdss_color {
>  #define DPU_DBG_MASK_DSPP     (1 << 10)
>  #define DPU_DBG_MASK_DSC      (1 << 11)
>  #define DPU_DBG_MASK_CDM      (1 << 12)
> +#define DPU_DBG_MASK_CWB      (1 << 13)
>  
>  /**
>   * struct dpu_hw_tear_check - Struct contains parameters to configure
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index bc99b04eae3a..738e9a081b10 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -1,9 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
> +#include <drm/drm_managed.h>
>  #include "msm_drv.h"
>  #define pr_fmt(fmt)	"[drm:%s] " fmt, __func__
>  #include "dpu_kms.h"
> @@ -34,6 +35,7 @@ int dpu_rm_init(struct drm_device *dev,
>  		void __iomem *mmio)
>  {
>  	int rc, i;
> +	struct dpu_hw_blk_reg_map *cwb_reg_map;
>  
>  	if (!rm || !cat || !mmio) {
>  		DPU_ERROR("invalid kms\n");
> @@ -100,11 +102,35 @@ int dpu_rm_init(struct drm_device *dev,
>  		rm->hw_intf[intf->id - INTF_0] = hw;
>  	}
>  
> +	if (cat->cwb_count > 0) {
> +		cwb_reg_map = drmm_kzalloc(dev,
> +				sizeof(*cwb_reg_map) * cat->cwb_count,
> +				GFP_KERNEL);

Please move CWB block pointers to dpu_rm. There is no need to allocate a
separate array.

> +
> +		if (!cwb_reg_map) {
> +			DPU_ERROR("failed cwb object creation\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +
> +	for (i = 0; i < cat->cwb_count; i++) {
> +		struct dpu_hw_blk_reg_map *cwb = &cwb_reg_map[i];
> +
> +		cwb->blk_addr = mmio + cat->cwb[i].base;
> +		cwb->log_mask = DPU_DBG_MASK_CWB;
> +	}
> +
>  	for (i = 0; i < cat->wb_count; i++) {
>  		struct dpu_hw_wb *hw;
>  		const struct dpu_wb_cfg *wb = &cat->wb[i];
>  
> -		hw = dpu_hw_wb_init(dev, wb, mmio, cat->mdss_ver);
> +		if (cat->cwb)
> +			hw = dpu_hw_wb_init_with_cwb(dev, wb, mmio,
> +					cat->mdss_ver, cwb_reg_map);
> +		else
> +			hw = dpu_hw_wb_init(dev, wb, mmio, cat->mdss_ver);
> +
>  		if (IS_ERR(hw)) {
>  			rc = PTR_ERR(hw);
>  			DPU_ERROR("failed wb object creation: err %d\n", rc);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

