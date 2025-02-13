Return-Path: <linux-kernel+bounces-512088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9530DA333E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F2B3A6F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B31CF8B;
	Thu, 13 Feb 2025 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqOFnR0F"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6E4A29
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405810; cv=none; b=avEx7+r9KoGCMvyy9cfZ2SUq535+Tp/cQXdndg2IB15lKdir01IDWsXtnw2sv8Q22nOo5GLKn0ZIV9mR/rnHSbmRdKuR33gX5jXsygUKQMi0HC169sP0LvLyvm4Owa5qF834mV8nIo5+vUXEB5PCZONL9BDuyj1nlVZYUlw/+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405810; c=relaxed/simple;
	bh=oi/Xbw+NrhqZAPFqjnowxgAxDfeverLv7UuUyMNS/UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOFdPXQMKYHWriwTUpocF/SMITaDD3S/NxTYL2kdBS6pS1eJumn2JrLobYg1HeqeK3d++N5oG5WryFc6Bq6Djipscatfj/PXgEvtFoPhIN2gKcbzPjQ6pdiPcAtqbNX8/KIlA7k/tJVOWKCzuez0z4JiC8kc6HDv3AVsYvjpSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqOFnR0F; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5450cf0cb07so232558e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739405806; x=1740010606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNojiPGIwmTnD2aQgl4PtXpSpweN7zZq2UUPGSnBLak=;
        b=aqOFnR0FrQM7TnEB+TNR/Cwkci3Sw6olSQyphL2vIFVfkY5BObYJYPoidJzjgQVdMv
         lwdV0kB4bTaTdJ491UTZM5CHDOpRHfVV4BxC1JznCJ/00LWkRRrj0BMilqVEjVHmMx2k
         ZbMWUSGJL0/pjVYciPkmCYpKDwBOpE78zZlYlIbaxJNRMUCTR/ZNE0T0J5AQQxJpIyqf
         sCHnL0ojFsHv8SMpkLsh97nF8Qc0kuNG3Wmmgrp8Zy2mfTaFisrScPX7U3jq+H7iuc5v
         PT35DCeiHy1FCXewn0jLQSEKE0tWBRiZ36ofIN6DRcFttre4uikGDC85ZQBJYfAcIbHe
         TNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739405806; x=1740010606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNojiPGIwmTnD2aQgl4PtXpSpweN7zZq2UUPGSnBLak=;
        b=AEFcFC9BIrERFDSUgzxX4H28X/G/tYxAgRYsYsOSvgiURaoPopzhisg3LOkAbXI/C4
         zoMwEmvVLh4Hc7n2wWy8K6kDjdlKeOp/tOB+D58Mw6XxzvdOqG8M/egAmEKiigVUheSX
         9sHM5tKolyY8+rBjyr66RE4pJxUbXvlBPLUoRaJiJlDGHfKTNXMjaACj+ATpOpQnvWVY
         vitwh/fsV3yTT6wgmmUKHtMCZj8ziSvuMo12iunJTVPztiYe3oPGAq8UrlP5+M6FQRnz
         LAV4kuE71H6GTmuagYilU7XWuBjFOS3YI4ZrmTy150I6b7TVK0/73+q29bV0bZBnr/33
         pwwA==
X-Forwarded-Encrypted: i=1; AJvYcCUYePB04Cd+umapG7ALbIPfd3NPuYfewURViDFcPoL012xdmvLS7qqalvNfKeTrdIf21c75jKyYi34GhsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ArD2S2JLOo153GYpChxiPhGcjh8BPEEjJsdYl+65liIYh3ua
	/P0o0zkYA2ToVoqXLfj2hhbMV33YxvoqLPYIlvzQ3BBx8ZKF8MwxFBjtj9zdPAEciaAUCIOpFPb
	pA10=
X-Gm-Gg: ASbGnctc8m+qCEnCeIGpNAH4Fb/FT1GgFIOd+yZg3t83C20S2DFUlF8uyS27JHJzHe/
	ky5Dnv6fmXlS/3+aoQVojc/MHZISOcdCJ1uy2Xb82fmExEjnygMsmA2VGl+9rK7wmyw/YprxeXE
	qeyYH6XNCmJcU661LnGjXvgFG+PPBc1YZ73uhYqBjDQg0m0gTpp6Y+GxLuTl/yvNIcYh3zU4J5b
	XTiE/0qdXKJLo0oHIydR6M1UI8SI28VvMCJX1kVFgLSfsUAu91XK+fseOfba7Qpr9xrBTCOOyZi
	oEJK6Cr1UxCKa+hSCPjl0Ho3Pp7OozpFoNo4rWNhNN1yczLY5uSx6Mcrj8NAMjFJ/+pFkGE=
X-Google-Smtp-Source: AGHT+IFm2b5ZFdLpsW1I/jMStjPpwbZ6rfWR3X6ILYKNwXLU3A6PtwOHOnRtb0hSYaN/5Cbm1RucuQ==
X-Received: by 2002:a05:6512:1288:b0:545:1104:617d with SMTP id 2adb3069b0e04-545180ea318mr1509102e87.11.1739405806487;
        Wed, 12 Feb 2025 16:16:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f0832absm16331e87.39.2025.02.12.16.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:16:45 -0800 (PST)
Date: Thu, 13 Feb 2025 02:16:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 drm-dp 4/7] drm/hisilicon/hibmc: Add colorbar-cfg: set
 color bar cfg
Message-ID: <msjbkixuc27nxqzqgewvtwaa3yszfp3fwrv4qiot4petpxrtyu@3n6crntdm2ay>
References: <20250210144959.100551-1-shiyongbang@huawei.com>
 <20250210144959.100551-5-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210144959.100551-5-shiyongbang@huawei.com>

On Mon, Feb 10, 2025 at 10:49:56PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> This is a DP IP controller's feature. It can be used as a debug method
> which can check DP controller is working good. The colorbar displaying
> doesn't rely on other IPs work in the chip, like: GPU or DDR (vram) and
> so on, because colorbar diplaying data is generated by controller itself
> inside the DP IP.

You are describing it in a pretty strange manner. Does this sound
better?

DP controller can support generating a color bar signal over the
DisplayPort interface. This can be useful to check for possible memory
or GPU problems, as the signal generator resides completely in the DP
block. Add debugfs file that controls colorbar generator.

This also requires having corresponding debugfs entry here.

> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>   - add colorbar introduction in commit, suggested by Dmitry Baryshkov.
>   - splittting colorbar and debugfs in different patches, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c  | 43 +++++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h  | 29 ++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h |  2 +
>  3 files changed, 74 insertions(+)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index 77f02d5151f7..8adace0befde 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -226,3 +226,46 @@ int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode)
>  
>  	return 0;
>  }
> +
> +static const struct hibmc_dp_color_raw g_rgb_raw[] = {
> +	{CBAR_COLOR_BAR, 0x000, 0x000, 0x000},
> +	{CBAR_WHITE,     0xfff, 0xfff, 0xfff},
> +	{CBAR_RED,       0xfff, 0x000, 0x000},
> +	{CBAR_ORANGE,    0xfff, 0x800, 0x000},
> +	{CBAR_YELLOW,    0xfff, 0xfff, 0x000},
> +	{CBAR_GREEN,     0x000, 0xfff, 0x000},
> +	{CBAR_CYAN,      0x000, 0x800, 0x800},
> +	{CBAR_BLUE,      0x000, 0x000, 0xfff},
> +	{CBAR_PURPLE,    0x800, 0x000, 0x800},
> +	{CBAR_BLACK,     0x000, 0x000, 0x000},
> +};
> +
> +void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
> +{
> +	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> +	struct hibmc_dp_color_raw raw_data;
> +
> +	if (cfg->enable) {
> +		hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(9),
> +					 cfg->self_timing);
> +		hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, GENMASK(8, 1),
> +					 cfg->dynamic_rate);
> +		if (cfg->pattern == CBAR_COLOR_BAR) {
> +			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(10), 0);
> +		} else {
> +			raw_data = g_rgb_raw[cfg->pattern];
> +			drm_dbg_dp(dp->drm_dev, "r:%x g:%x b:%x\n", raw_data.r_value,
> +				   raw_data.g_value, raw_data.b_value);
> +			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(10), 1);
> +			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, GENMASK(23, 12),
> +						 raw_data.r_value);
> +			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL1, GENMASK(23, 12),
> +						 raw_data.g_value);
> +			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL1, GENMASK(11, 0),
> +						 raw_data.b_value);
> +		}
> +	}
> +
> +	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(0), cfg->enable);
> +	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
> +}
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 53b6d0beecea..621a0a1d7eb7 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -14,6 +14,33 @@
>  
>  struct hibmc_dp_dev;
>  
> +enum hibmc_dp_cbar_pattern {
> +	CBAR_COLOR_BAR,
> +	CBAR_WHITE,
> +	CBAR_RED,
> +	CBAR_ORANGE,
> +	CBAR_YELLOW,
> +	CBAR_GREEN,
> +	CBAR_CYAN,
> +	CBAR_BLUE,
> +	CBAR_PURPLE,
> +	CBAR_BLACK,
> +};
> +
> +struct hibmc_dp_color_raw {
> +	enum hibmc_dp_cbar_pattern pattern;
> +	u32 r_value;
> +	u32 g_value;
> +	u32 b_value;
> +};
> +
> +struct hibmc_dp_cbar_cfg {
> +	bool enable;
> +	bool self_timing;
> +	u8 dynamic_rate; /* 0:static, 1-255(frame):dynamic */
> +	enum hibmc_dp_cbar_pattern pattern;
> +};
> +
>  struct hibmc_dp {
>  	struct hibmc_dp_dev *dp_dev;
>  	struct drm_device *drm_dev;
> @@ -21,10 +48,12 @@ struct hibmc_dp {
>  	struct drm_connector connector;
>  	void __iomem *mmio;
>  	struct drm_dp_aux aux;
> +	struct hibmc_dp_cbar_cfg cfg;
>  };
>  
>  int hibmc_dp_hw_init(struct hibmc_dp *dp);
>  int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode);
>  void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable);
> +void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg);
>  
>  #endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> index f2fa9807d8ab..c43ad6b30c2c 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> @@ -23,6 +23,8 @@
>  #define HIBMC_DP_VIDEO_MSA1			0x11c
>  #define HIBMC_DP_VIDEO_MSA2			0x120
>  #define HIBMC_DP_VIDEO_HORIZONTAL_SIZE		0X124
> +#define HIBMC_DP_COLOR_BAR_CTRL			0x260
> +#define HIBMC_DP_COLOR_BAR_CTRL1		0x264
>  #define HIBMC_DP_TIMING_GEN_CONFIG0		0x26c
>  #define HIBMC_DP_TIMING_GEN_CONFIG2		0x274
>  #define HIBMC_DP_TIMING_GEN_CONFIG3		0x278
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

