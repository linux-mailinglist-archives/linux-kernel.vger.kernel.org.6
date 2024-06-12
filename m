Return-Path: <linux-kernel+bounces-212133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CAC905B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFBA1C21463
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F027E765;
	Wed, 12 Jun 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4nXj5/o"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF51C14
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219109; cv=none; b=qyDiq5okfsGIB3bA8mqFpQ8itgyoPmfV2wszk/xKfddgt4yjL22CTR2NURhYsyiDxOXUYFml+2/8AS8cQFzrf+zxAShWfXnwhTnWSL0lgf1n3QNJweflRZZ6ab055xP0Z+nV+0cmIJmK5ijyOqSUvqh7CWbCbkG8zNt+42CM5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219109; c=relaxed/simple;
	bh=o29J1h+958oSIVbTpGXXy4Yly7aJHs5CuoQNkKcVz6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om8/09JlJUJygI0CPTG5gMPhiYphlZevKoLYlV52UKlEYwbzeA4l/24iB2xs5HORW/zi3XT21B5H2f7UVbCDRurLbMQzQfcxj/qjtAhUwGtABIFHgftoOQiLROIUlCqSHvsD5zuHwc1gWQ8kt/HDzzkvOpO7k2tLlhE4y75yecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C4nXj5/o; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c8ddc2b29so253213e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718219106; x=1718823906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVn0gUr8jwuVMGQACKErKUFq31rOO6g1SOd15vC3Cks=;
        b=C4nXj5/oQXBJiuCP2IwcUa6fyvvA9tWAGe+73ibjIW/GtI0DdxxEBv97Bx0ggqZaJ1
         qZqodj+9LFzR3zcGR9EAd03HLz7OMPFdimn5AJo7Bk2vSoJYSoCkMf87eqkdmBwUj9BA
         ks9nKfMlOeRDeZbpg8u6ELuQ+2oR1OUghuvgUbHYReqaMWIlMlpkUjb2qtYcJp3ursZw
         Q7yZVcRFHk/YqJqSF05beWHzEENrixUJwlZnI/0whcgRCldgkWXj6DO7Dw4BwSrpT9C/
         b5NHdevPOFtzB30FQUMH3WtYQ+OpbqjPCmI22weDbXJIQ0t9iI83aBuxHM+Z83Lmk2jQ
         e0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718219106; x=1718823906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVn0gUr8jwuVMGQACKErKUFq31rOO6g1SOd15vC3Cks=;
        b=IKZHQ2rphBcNfc1SZEacbQdayzuVhg/FY6mRbVnYgLXiHxYiIL5Pf4TnN1gwhRPLJH
         DhjDMJAv1zz84l7Jtv8+6uj9cgJyPNvCK9d0wd/6X/52edcBgkGgAblNdrVwVpjksWRN
         OssEKDM+gSm7Oh17lX4OrbiYkD3SLInfS8I5pb6bt1Wazegcro02yATNvLyGCElfSdfH
         IiSH75gL/SoZppa/zT/sRdPK3+lYb20C0daAW9jGqGJHn2oOLz5TBCvw9inXgIXsI/8+
         faSaxdazVEm4b5brE+6M6ixbQOqJD9QiOlZ88BiOdvARmnyAWSnDbrmBTf0+0ldwYiXC
         DApg==
X-Forwarded-Encrypted: i=1; AJvYcCWE6vSIX/doeZg7ic+yqlsGcAbpmTmAaKorxkSyOSBI6uHskUDg6px/sv1jjNkyPx8iyAndH0o4E61a8R7+PFOse1Dbh6oaAwWFlnNm
X-Gm-Message-State: AOJu0YxQ0T7FsnRwmQKr4wvgJLNPNhzPBxFx3/ZNyVqJUpwqtmC8L60w
	TTLFgbSs8yYGz9LfFfMp3/NeIQvQcKCtLryUKwszqIDeL1bCcAOh/jnW9wr1wao=
X-Google-Smtp-Source: AGHT+IGykt0YUd4KoCQDPLnbKvOevsXXuj+TXY3BeFiPg46EyDmTIi4o32Gf4o4QJDGIBDrqpGJfXA==
X-Received: by 2002:a05:6512:799:b0:52b:befb:24ad with SMTP id 2adb3069b0e04-52c9a3c7449mr2080284e87.20.1718219105792;
        Wed, 12 Jun 2024 12:05:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb423dd68sm2601311e87.210.2024.06.12.12.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 12:05:05 -0700 (PDT)
Date: Wed, 12 Jun 2024 22:05:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quic_rmccann@quicinc.com, 
	konrad.dybcio@linaro.org, neil.armstrong@linaro.org, jonathan@marek.ca, 
	swboyd@chromium.org, quic_khsieh@quicinc.com, quic_jesszhan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/msm/dpu: Add SM7150 support
Message-ID: <qinrviffefuy77tmk5itgiyapgpnfpzupggb6bgvlxk6kybxjn@h4wmocovtdch>
References: <20240612184336.11794-1-danila@jiaxyga.com>
 <20240612184336.11794-5-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612184336.11794-5-danila@jiaxyga.com>

On Wed, Jun 12, 2024 at 09:43:36PM +0300, Danila Tikhonov wrote:
> Add definitions for the display hardware used on the Qualcomm SM7150
> platform.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../msm/disp/dpu1/catalog/dpu_5_2_sm7150.h    | 349 ++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |   1 +
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
>  4 files changed, 352 insertions(+)
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
> 

[...]

> +static const struct dpu_sspp_cfg sm7150_sspp[] = {
> +	{
> +		.name = "sspp_0", .id = SSPP_VIG0,
> +		.base = 0x4000, .len = 0x1f0,
> +		.features = VIG_SDM845_MASK,
> +		.sblk = &dpu_vig_sblk_qseed3_1_4,

dpu_vig_sblk_qseed3_2_4 (and further on).

> +		.xin_id = 0,
> +		.type = SSPP_TYPE_VIG,
> +		.clk_ctrl = DPU_CLK_CTRL_VIG0,
> +	}, {
> +		.name = "sspp_1", .id = SSPP_VIG1,
> +		.base = 0x6000, .len = 0x1f0,
> +		.features = VIG_SDM845_MASK,
> +		.sblk = &dpu_vig_sblk_qseed3_1_4,
> +		.xin_id = 4,
> +		.type = SSPP_TYPE_VIG,
> +		.clk_ctrl = DPU_CLK_CTRL_VIG1,
> +	}, {
> +		.name = "sspp_2", .id = SSPP_DMA0,
> +		.base = 0x24000, .len = 0x1f0,
> +		.features = DMA_SDM845_MASK,
> +		.sblk = &dpu_dma_sblk,
> +		.xin_id = 1,
> +		.type = SSPP_TYPE_DMA,
> +		.clk_ctrl = DPU_CLK_CTRL_DMA0,
> +	}, {
> +		.name = "sspp_9", .id = SSPP_DMA1,
> +		.base = 0x26000, .len = 0x1f0,
> +		.features = DMA_SDM845_MASK,
> +		.sblk = &dpu_dma_sblk,
> +		.xin_id = 5,
> +		.type = SSPP_TYPE_DMA,
> +		.clk_ctrl = DPU_CLK_CTRL_DMA1,
> +	}, {
> +		.name = "sspp_10", .id = SSPP_DMA2,
> +		.base = 0x28000, .len = 0x1f0,
> +		.features = DMA_CURSOR_SDM845_MASK,
> +		.sblk = &dpu_dma_sblk,
> +		.xin_id = 9,
> +		.type = SSPP_TYPE_DMA,
> +		.clk_ctrl = DPU_CLK_CTRL_DMA2,
> +	},
> +};
> +
> +static const struct dpu_lm_cfg sm7150_lm[] = {
> +	{
> +		.name = "lm_0", .id = LM_0,
> +		.base = 0x44000, .len = 0x320,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = LM_1,
> +		.pingpong = PINGPONG_0,
> +		.dspp = DSPP_0,
> +	}, {
> +		.name = "lm_1", .id = LM_1,
> +		.base = 0x45000, .len = 0x320,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = LM_0,
> +		.pingpong = PINGPONG_1,
> +		.dspp = DSPP_1,
> +	}, {
> +		.name = "lm_2", .id = LM_2,
> +		.base = 0x46000, .len = 0x320,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = LM_3,
> +		.pingpong = PINGPONG_2,
> +	}, {
> +		.name = "lm_3", .id = LM_3,
> +		.base = 0x47000, .len = 0x320,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = LM_2,
> +		.pingpong = PINGPONG_3,
> +	}, {
> +		.name = "lm_4", .id = LM_4,
> +		.base = 0x0, .len = 0x320,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = 0,
> +		.pingpong = PINGPONG_4,
> +	}, {
> +		.name = "lm_5", .id = LM_5,
> +		.base = 0x0, .len = 0x320,
> +		.features = MIXER_SDM845_MASK,
> +		.sblk = &sdm845_lm_sblk,
> +		.lm_pair = 0,
> +		.pingpong = PINGPONG_5,
> +	},

Please drop LM_4 and LM_5, I don't think they are really a part of the
hardware (especially with base = 0).

> +};
> +

-- 
With best wishes
Dmitry

