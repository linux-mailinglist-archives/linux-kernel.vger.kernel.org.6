Return-Path: <linux-kernel+bounces-326154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB499763E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0DB284E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B2189B88;
	Thu, 12 Sep 2024 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlyLnDGU"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879118FDB3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128282; cv=none; b=Ox4s8Dq749DYCnce3E8OR8Lcpeh6zaHnVe/e46sz3oYTqBEcI8zgxLlleIz0GJ5+7YJUmm+zSXYF1rOxunBN1k3SIBlydnYYD7os2ft8LVPlUlLnaF122BVZg+FWTjZ4+A9qb9MWJD3M5RrPEfeMku3VwvOkabgUgCpPL07RA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128282; c=relaxed/simple;
	bh=ofKsj6aZqEywP9MjGapwGSwvAr2ks20i1SxP6pmTEKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYKtZAM8WqAYVT63RELU7G+pfXcbKvSmmN9eAL8IRwI3bRt3TrHTcD9WbtBVRhQ4b0R8RNCk5+WD3kyHMxoVR0bBZuiJ97KtmanC6KWcQeI+hf0izzksBF6j8spnsgRqPI+INvGetJicy0yidi2WUMbFVPn0pAvCMZFq5Ubx3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DlyLnDGU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f7528f4658so6152261fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726128278; x=1726733078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oEATaPF98HAEF9WeFPXVXD5Ur+2p7oYCwhrXntghxU=;
        b=DlyLnDGUf4rAmVdH/opVq+aXiKusPrrzV3huAWclleld+2CPS+dAMe/ZdtsJRFGV8C
         ZJF0QmnC+Xz1RwrkLbGBwPL+b+UlnhT3E34SyxTW4FgSGl9vNAm0a6vlBtJxsQDuoXoY
         1czsT52SjbKo+vQkiZMpFzU/7KqooHHaO6hWzy3c0XjNkST1q/6JcsT9FbMguFQosPep
         HwvJWXENGmPNKlYx5o9RitSjmeQtmMMTptxjEshnnl6TWTST6eRKnqZHLvQtgXLmx6NT
         q+crqa1FYkkhSpwIWlz6JMXn+XHqqFzi1pwYC8M8a+Srwg1YJgwk8xI4Zm2OudtfFsGf
         1tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726128278; x=1726733078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oEATaPF98HAEF9WeFPXVXD5Ur+2p7oYCwhrXntghxU=;
        b=etqYkCLcYyNyVb7of/gCA/3m06Bp/m3ZVI8suJLtX78FoqRgecdmFitxyZcXyaAg1m
         giSCj8wWRZazUMJ/DawviG4cdYsbvcOJCstD2sy8YnbeZdCw/HvqV60dZD/dzmiLJ61l
         kOmQdmcpDkEkYxGyUJ2xy5JoHQV11W5cKmxmPb9nYGbqQGfgXM8tE7jNA0Zwkq27n8Y5
         Cu0itvobbbbPZNKd7Bd+QP21Bd3WuLMkyi9f9A55qn6NnHZXoy1D8KgOIdgUesRGd+DL
         gM+v3w2rz15p9v2EN4sZk036liHaCRtgcxjNu6CMioXTvg72zevyUAkOu8QJlyx0IWDv
         +dYw==
X-Forwarded-Encrypted: i=1; AJvYcCW/zHgSvDIfJzyJWQh1lShSMYVKisH4MrZD4scQN8vu6ODm2eMw+z1o2jldyH650SoF8+0X1h4ksBVg0rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEm2pM6pgPVt/D5Aj/Yghj49LROe+rbo35Jg9sW/TnUluib//
	tAYVo2pHz/0ofLfwpwLsxWzSHiBC7K46jmKGALF064oZNa3v+USZiM5GtqydbbQ=
X-Google-Smtp-Source: AGHT+IFHqLiPTltXOGd+Ez/Xm33J5+NdUdX8mL2x0mImf1QuSSFBf5X3gzGSMAQm5S0Bh13eVJrfug==
X-Received: by 2002:a05:6512:3511:b0:535:d4e9:28ca with SMTP id 2adb3069b0e04-53678fec5e1mr766262e87.55.1726128277942;
        Thu, 12 Sep 2024 01:04:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f871662sm1827694e87.115.2024.09.12.01.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:04:37 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:04:35 +0300
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
Subject: Re: [PATCH 4/5] drm/msm/dpu: Add SA8775P support
Message-ID: <v4cnmso3nl5oi3scd2lkg6kepb52vjrzgoti42ikds3y2wq6aw@sbn2yu4xeiun>
References: <20240912071437.1708969-1-quic_mahap@quicinc.com>
 <20240912071437.1708969-5-quic_mahap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912071437.1708969-5-quic_mahap@quicinc.com>

On Thu, Sep 12, 2024 at 12:44:36PM GMT, Mahadevan wrote:
> Add definitions for the display hardware used on the
> Qualcomm SA8775P platform.
> 
> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>
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
> + */
> +
> +#ifndef _DPU_8_4_SA8775P_H
> +#define _DPU_8_4_SA8775P_H
> +
> +static const struct dpu_caps sa8775p_dpu_caps = {
> +	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> +	.max_mixer_blendstages = 0xb,
> +	.has_src_split = true,
> +	.has_dim_layer = true,
> +	.has_idle_pc = true,
> +	.has_3d_merge = true,
> +	.max_linewidth = 5120,
> +	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
> +};
> +
> +static const struct dpu_mdp_cfg sa8775p_mdp = {
> +	.name = "top_0",
> +	.base = 0x0, .len = 0x494,
> +	.features = BIT(DPU_MDP_PERIPH_0_REMOVED),
> +	.clk_ctrls = {
> +		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
> +		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
> +		[DPU_CLK_CTRL_VIG2] = { .reg_off = 0x2bc, .bit_off = 0 },
> +		[DPU_CLK_CTRL_VIG3] = { .reg_off = 0x2c4, .bit_off = 0 },
> +		[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8 },
> +		[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8 },
> +		[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x2bc, .bit_off = 8 },
> +		[DPU_CLK_CTRL_DMA3] = { .reg_off = 0x2c4, .bit_off = 8 },
> +		[DPU_CLK_CTRL_WB2] = { .reg_off = 0x2bc, .bit_off = 16 },
> +		[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
> +	},
> +};
> +
> +/* FIXME: get rid of DPU_CTL_SPLIT_DISPLAY in favour of proper ACTIVE_CTL support */
> +static const struct dpu_ctl_cfg sa8775p_ctl[] = {
> +	{
> +		.name = "ctl_0", .id = CTL_0,
> +		.base = 0x15000, .len = 0x204,
> +		.features = BIT(DPU_CTL_SPLIT_DISPLAY) | CTL_SC7280_MASK,
> +		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
> +	}, {
> +		.name = "ctl_1", .id = CTL_1,
> +		.base = 0x16000, .len = 0x204,
> +		.features = BIT(DPU_CTL_SPLIT_DISPLAY) | CTL_SC7280_MASK,
> +		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 10),
> +	}, {
> +		.name = "ctl_2", .id = CTL_2,
> +		.base = 0x17000, .len = 0x204,
> +		.features = CTL_SC7280_MASK,
> +		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 11),
> +	}, {
> +		.name = "ctl_3", .id = CTL_3,
> +		.base = 0x18000, .len = 0x204,
> +		.features = CTL_SC7280_MASK,
> +		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 12),
> +	}, {
> +		.name = "ctl_4", .id = CTL_4,
> +		.base = 0x19000, .len = 0x204,
> +		.features = CTL_SC7280_MASK,
> +		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 13),
> +	}, {
> +		.name = "ctl_5", .id = CTL_5,
> +		.base = 0x1a000, .len = 0x204,
> +		.features = CTL_SC7280_MASK,
> +		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 23),
> +	},
> +};
> +
> +static const struct dpu_sspp_cfg sa8775p_sspp[] = {
> +	{
> +		.name = "sspp_0", .id = SSPP_VIG0,
> +		.base = 0x4000, .len = 0x32c,
> +		.features = VIG_SDM845_MASK_SDMA,
> +		.sblk = &dpu_vig_sblk_qseed3_3_1,
> +		.xin_id = 0,
> +		.type = SSPP_TYPE_VIG,
> +		.clk_ctrl = DPU_CLK_CTRL_VIG0,
> +	}, {
> +		.name = "sspp_1", .id = SSPP_VIG1,
> +		.base = 0x6000, .len = 0x32c,
> +		.features = VIG_SDM845_MASK_SDMA,
> +		.sblk = &dpu_vig_sblk_qseed3_3_1,
> +		.xin_id = 4,
> +		.type = SSPP_TYPE_VIG,
> +		.clk_ctrl = DPU_CLK_CTRL_VIG1,
> +	}, {
> +		.name = "sspp_2", .id = SSPP_VIG2,
> +		.base = 0x8000, .len = 0x32c,
> +		.features = VIG_SDM845_MASK_SDMA,
> +		.sblk = &dpu_vig_sblk_qseed3_3_1,
> +		.xin_id = 8,
> +		.type = SSPP_TYPE_VIG,
> +		.clk_ctrl = DPU_CLK_CTRL_VIG2,
> +	}, {
> +		.name = "sspp_3", .id = SSPP_VIG3,
> +		.base = 0xa000, .len = 0x32c,
> +		.features = VIG_SDM845_MASK_SDMA,
> +		.sblk = &dpu_vig_sblk_qseed3_3_1,
> +		.xin_id = 12,
> +		.type = SSPP_TYPE_VIG,
> +		.clk_ctrl = DPU_CLK_CTRL_VIG3,
> +	}, {
> +		.name = "sspp_8", .id = SSPP_DMA0,
> +		.base = 0x24000, .len = 0x32c,
> +		.features = DMA_SDM845_MASK_SDMA,
> +		.sblk = &dpu_dma_sblk,
> +		.xin_id = 1,
> +		.type = SSPP_TYPE_DMA,
> +		.clk_ctrl = DPU_CLK_CTRL_DMA0,
> +	}, {
> +		.name = "sspp_9", .id = SSPP_DMA1,
> +		.base = 0x26000, .len = 0x32c,
> +		.features = DMA_SDM845_MASK_SDMA,
> +		.sblk = &dpu_dma_sblk,
> +		.xin_id = 5,
> +		.type = SSPP_TYPE_DMA,
> +		.clk_ctrl = DPU_CLK_CTRL_DMA1,
> +	}, {
> +		.name = "sspp_10", .id = SSPP_DMA2,
> +		.base = 0x28000, .len = 0x32c,
> +		.features = DMA_CURSOR_SDM845_MASK_SDMA,
> +		.sblk = &dpu_dma_sblk,
> +		.xin_id = 9,
> +		.type = SSPP_TYPE_DMA,
> +		.clk_ctrl = DPU_CLK_CTRL_DMA2,
> +	}, {
> +		.name = "sspp_11", .id = SSPP_DMA3,
> +		.base = 0x2a000, .len = 0x32c,
> +		.features = DMA_CURSOR_SDM845_MASK_SDMA,
> +		.sblk = &dpu_dma_sblk,
> +		.xin_id = 13,
> +		.type = SSPP_TYPE_DMA,
> +		.clk_ctrl = DPU_CLK_CTRL_DMA3,
> +	},
> +};
> +
> +static const struct dpu_lm_cfg sa8775p_lm[] = {
> +	{
> +		.name = "lm_0", .id = LM_0,
> +		.base = 0x44000, .len = 0x400,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = LM_1,
> +		.pingpong = PINGPONG_0,
> +		.dspp = DSPP_0,
> +	}, {
> +		.name = "lm_1", .id = LM_1,
> +		.base = 0x45000, .len = 0x400,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = LM_0,
> +		.pingpong = PINGPONG_1,
> +		.dspp = DSPP_1,
> +	}, {
> +		.name = "lm_2", .id = LM_2,
> +		.base = 0x46000, .len = 0x400,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = LM_3,
> +		.pingpong = PINGPONG_2,
> +		.dspp = DSPP_2,
> +	}, {
> +		.name = "lm_3", .id = LM_3,
> +		.base = 0x47000, .len = 0x400,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = LM_2,
> +		.pingpong = PINGPONG_3,
> +		.dspp = DSPP_3,
> +	}, {
> +		.name = "lm_4", .id = LM_4,
> +		.base = 0x48000, .len = 0x400,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = LM_5,
> +		.pingpong = PINGPONG_4,
> +	}, {
> +		.name = "lm_5", .id = LM_5,
> +		.base = 0x49000, .len = 0x400,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = LM_4,
> +		.pingpong = PINGPONG_5,
> +	},
> +};
> +
> +static const struct dpu_dspp_cfg sa8775p_dspp[] = {
> +	{
> +		.name = "dspp_0", .id = DSPP_0,
> +		.base = 0x54000, .len = 0x1800,
> +		.features = DSPP_SC7180_MASK,
> +		.sblk = &sdm845_dspp_sblk,
> +	}, {
> +		.name = "dspp_1", .id = DSPP_1,
> +		.base = 0x56000, .len = 0x1800,
> +		.features = DSPP_SC7180_MASK,
> +		.sblk = &sdm845_dspp_sblk,
> +	}, {
> +		.name = "dspp_2", .id = DSPP_2,
> +		.base = 0x58000, .len = 0x1800,
> +		.features = DSPP_SC7180_MASK,
> +		.sblk = &sdm845_dspp_sblk,
> +	}, {
> +		.name = "dspp_3", .id = DSPP_3,
> +		.base = 0x5a000, .len = 0x1800,
> +		.features = DSPP_SC7180_MASK,
> +		.sblk = &sdm845_dspp_sblk,
> +	},
> +};
> +
> +static const struct dpu_pingpong_cfg sa8775p_pp[] = {
> +	{
> +		.name = "pingpong_0", .id = PINGPONG_0,
> +		.base = 0x69000, .len = 0,
> +		.features = BIT(DPU_PINGPONG_DITHER),
> +		.sblk = &sc7280_pp_sblk,
> +		.merge_3d = MERGE_3D_0,
> +		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +	}, {
> +		.name = "pingpong_1", .id = PINGPONG_1,
> +		.base = 0x6a000, .len = 0,
> +		.features = BIT(DPU_PINGPONG_DITHER),
> +		.sblk = &sc7280_pp_sblk,
> +		.merge_3d = MERGE_3D_0,
> +		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +	}, {
> +		.name = "pingpong_2", .id = PINGPONG_2,
> +		.base = 0x6b000, .len = 0,
> +		.features = BIT(DPU_PINGPONG_DITHER),
> +		.sblk = &sc7280_pp_sblk,
> +		.merge_3d = MERGE_3D_1,
> +		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
> +	}, {
> +		.name = "pingpong_3", .id = PINGPONG_3,
> +		.base = 0x6c000, .len = 0,
> +		.features = BIT(DPU_PINGPONG_DITHER),
> +		.sblk = &sc7280_pp_sblk,
> +		.merge_3d = MERGE_3D_1,
> +		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
> +	}, {
> +		.name = "pingpong_4", .id = PINGPONG_4,
> +		.base = 0x6d000, .len = 0,
> +		.features = BIT(DPU_PINGPONG_DITHER),
> +		.sblk = &sc7280_pp_sblk,
> +		.merge_3d = MERGE_3D_2,
> +		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
> +	}, {
> +		.name = "pingpong_5", .id = PINGPONG_5,
> +		.base = 0x6e000, .len = 0,
> +		.features = BIT(DPU_PINGPONG_DITHER),
> +		.sblk = &sc7280_pp_sblk,
> +		.merge_3d = MERGE_3D_2,
> +		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
> +	}, {
> +		.name = "pingpong_6", .id = PINGPONG_6,
> +		.base = 0x65800, .len = 0,
> +		.features = BIT(DPU_PINGPONG_DITHER),
> +		.sblk = &sc7280_pp_sblk,
> +		.merge_3d = MERGE_3D_3,
> +	}, {
> +		.name = "pingpong_7", .id = PINGPONG_7,
> +		.base = 0x65c00, .len = 0,
> +		.features = BIT(DPU_PINGPONG_DITHER),
> +		.sblk = &sc7280_pp_sblk,
> +		.merge_3d = MERGE_3D_3,
> +	},
> +};
> +
> +static const struct dpu_merge_3d_cfg sa8775p_merge_3d[] = {
> +	{
> +		.name = "merge_3d_0", .id = MERGE_3D_0,
> +		.base = 0x4e000, .len = 0x8,
> +	}, {
> +		.name = "merge_3d_1", .id = MERGE_3D_1,
> +		.base = 0x4f000, .len = 0x8,
> +	}, {
> +		.name = "merge_3d_2", .id = MERGE_3D_2,
> +		.base = 0x50000, .len = 0x8,
> +	}, {
> +		.name = "merge_3d_3", .id = MERGE_3D_3,
> +		.base = 0x65f00, .len = 0x8,
> +	},
> +};
> +
> +/*
> + * NOTE: Each display compression engine (DCE) contains dual hard
> + * slice DSC encoders so both share same base address but with
> + * its own different sub block address.
> + */
> +static const struct dpu_dsc_cfg sa8775p_dsc[] = {
> +	{
> +		.name = "dce_0_0", .id = DSC_0,
> +		.base = 0x80000, .len = 0x4,
> +		.features = BIT(DPU_DSC_HW_REV_1_2),
> +		.sblk = &dsc_sblk_0,
> +	}, {
> +		.name = "dce_0_1", .id = DSC_1,
> +		.base = 0x80000, .len = 0x4,
> +		.features = BIT(DPU_DSC_HW_REV_1_2),
> +		.sblk = &dsc_sblk_1,
> +	}, {
> +		.name = "dce_1_0", .id = DSC_2,
> +		.base = 0x81000, .len = 0x4,
> +		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
> +		.sblk = &dsc_sblk_0,
> +	}, {
> +		.name = "dce_1_1", .id = DSC_3,
> +		.base = 0x81000, .len = 0x4,
> +		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
> +		.sblk = &dsc_sblk_1,
> +	}, {
> +		.name = "dce_2_0", .id = DSC_4,
> +		.base = 0x82000, .len = 0x4,
> +		.features = BIT(DPU_DSC_HW_REV_1_2),
> +		.sblk = &dsc_sblk_0,
> +	}, {
> +		.name = "dce_2_1", .id = DSC_5,
> +		.base = 0x82000, .len = 0x4,
> +		.features = BIT(DPU_DSC_HW_REV_1_2),
> +		.sblk = &dsc_sblk_1,
> +	},
> +};
> +
> +static const struct dpu_wb_cfg sa8775p_wb[] = {
> +	{
> +		.name = "wb_2", .id = WB_2,
> +		.base = 0x65000, .len = 0x2c8,
> +		.features = WB_SM8250_MASK,
> +		.format_list = wb2_formats_rgb_yuv,
> +		.num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
> +		.clk_ctrl = DPU_CLK_CTRL_WB2,
> +		.xin_id = 6,
> +		.vbif_idx = VBIF_RT,
> +		.maxlinewidth = 4096,
> +		.intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 4),
> +	},
> +};
> +/* TODO: INTF 3, 6, 7 and 8 are used for MST, marked as INTF_NONE for now */
> +static const struct dpu_intf_cfg sa8775p_intf[] = {
> +	{
> +		.name = "intf_0", .id = INTF_0,
> +		.base = 0x34000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_DP,
> +		.controller_id = MSM_DP_CONTROLLER_0,
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25),
> +	}, {
> +		.name = "intf_1", .id = INTF_1,
> +		.base = 0x35000, .len = 0x300,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_DSI,
> +		.controller_id = MSM_DSI_CONTROLLER_0,
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 26),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 27),
> +		.intr_tear_rd_ptr = DPU_IRQ_IDX(MDP_INTF1_TEAR_INTR, 2),
> +	}, {
> +		.name = "intf_2", .id = INTF_2,
> +		.base = 0x36000, .len = 0x300,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_DSI,
> +		.controller_id = MSM_DSI_CONTROLLER_1,
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 28),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 29),
> +		.intr_tear_rd_ptr = DPU_IRQ_IDX(MDP_INTF2_TEAR_INTR, 2),
> +	}, {
> +		.name = "intf_3", .id = INTF_3,
> +		.base = 0x37000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_NONE,
> +		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
> +	}, {
> +		.name = "intf_4", .id = INTF_4,
> +		.base = 0x38000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_DP,
> +		.controller_id = MSM_DP_CONTROLLER_1,
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 20),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 21),
> +	}, {

Where is intf_5 ?

> +		.name = "intf_6", .id = INTF_6,
> +		.base = 0x3A000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_NONE,
> +		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
> +	}, {
> +		.name = "intf_7", .id = INTF_7,
> +		.base = 0x3b000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_NONE,
> +		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 18),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 19),
> +	}, {
> +		.name = "intf_8", .id = INTF_8,
> +		.base = 0x3c000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_NONE,
> +		.controller_id = MSM_DP_CONTROLLER_1,	/* pair with intf_4 for DP MST */
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),
> +	},
> +};
> +
> +static const struct dpu_perf_cfg sa8775p_perf_data = {
> +	.max_bw_low = 13600000,
> +	.max_bw_high = 18200000,
> +	.min_core_ib = 2500000,
> +	.min_llcc_ib = 0,
> +	.min_dram_ib = 800000,
> +	.min_prefill_lines = 35,
> +	/* FIXME: lut tables */
> +	.danger_lut_tbl = {0x3ffff, 0x3ffff, 0x0},
> +	.safe_lut_tbl = {0xfff0, 0xfff0, 0x1},
> +	.qos_lut_tbl = {
> +		{.nentry = ARRAY_SIZE(sm6350_qos_linear_macrotile),
> +		.entries = sm6350_qos_linear_macrotile
> +		},
> +		{.nentry = ARRAY_SIZE(sm6350_qos_linear_macrotile),
> +		.entries = sm6350_qos_linear_macrotile
> +		},
> +		{.nentry = ARRAY_SIZE(sc7180_qos_nrt),
> +		.entries = sc7180_qos_nrt
> +		},
> +		/* TODO: macrotile-qseed is different from macrotile */
> +	},
> +	.cdp_cfg = {
> +		{.rd_enable = 1, .wr_enable = 1},
> +		{.rd_enable = 1, .wr_enable = 0}
> +	},
> +	.clk_inefficiency_factor = 105,
> +	.bw_inefficiency_factor = 120,
> +};
> +
> +static const struct dpu_mdss_version sa8775p_mdss_ver = {
> +	.core_major_ver = 8,
> +	.core_minor_ver = 4,
> +};
> +
> +const struct dpu_mdss_cfg dpu_sa8775p_cfg = {
> +	.mdss_ver = &sa8775p_mdss_ver,
> +	.caps = &sa8775p_dpu_caps,
> +	.mdp = &sa8775p_mdp,
> +	.cdm = &sc7280_cdm,
> +	.ctl_count = ARRAY_SIZE(sa8775p_ctl),
> +	.ctl = sa8775p_ctl,
> +	.sspp_count = ARRAY_SIZE(sa8775p_sspp),
> +	.sspp = sa8775p_sspp,
> +	.mixer_count = ARRAY_SIZE(sa8775p_lm),
> +	.mixer = sa8775p_lm,
> +	.dspp_count = ARRAY_SIZE(sa8775p_dspp),
> +	.dspp = sa8775p_dspp,
> +	.pingpong_count = ARRAY_SIZE(sa8775p_pp),
> +	.pingpong = sa8775p_pp,
> +	.dsc_count = ARRAY_SIZE(sa8775p_dsc),
> +	.dsc = sa8775p_dsc,
> +	.merge_3d_count = ARRAY_SIZE(sa8775p_merge_3d),
> +	.merge_3d = sa8775p_merge_3d,
> +	.wb_count = ARRAY_SIZE(sa8775p_wb),
> +	.wb = sa8775p_wb,
> +	.intf_count = ARRAY_SIZE(sa8775p_intf),
> +	.intf = sa8775p_intf,
> +	.vbif_count = ARRAY_SIZE(sdm845_vbif),
> +	.vbif = sdm845_vbif,
> +	.perf = &sa8775p_perf_data,
> +};
> +
> +#endif
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index dcb4fd85e73b..6f60fff2c9a6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2024, Qualcomm Innovation Center, Inc. All rights reserved.
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
> index 9bcae53c4f45..20b17477cb98 100644
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
> @@ -1464,6 +1464,7 @@ static const struct of_device_id dpu_dt_match[] = {
>  	{ .compatible = "qcom,sm8250-dpu", .data = &dpu_sm8250_cfg, },
>  	{ .compatible = "qcom,sm8350-dpu", .data = &dpu_sm8350_cfg, },
>  	{ .compatible = "qcom,sm8450-dpu", .data = &dpu_sm8450_cfg, },
> +	{ .compatible = "qcom,sa8775p-dpu", .data = &dpu_sa8775p_cfg, },

Wrong sorting order

>  	{ .compatible = "qcom,sm8550-dpu", .data = &dpu_sm8550_cfg, },
>  	{ .compatible = "qcom,sm8650-dpu", .data = &dpu_sm8650_cfg, },
>  	{ .compatible = "qcom,x1e80100-dpu", .data = &dpu_x1e80100_cfg, },
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

