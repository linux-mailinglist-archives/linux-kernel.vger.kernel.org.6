Return-Path: <linux-kernel+bounces-417712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09F9D583C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA5D2815C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6DB4CB5B;
	Fri, 22 Nov 2024 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtkJCnuR"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7F230988
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241903; cv=none; b=s97SzkUlfJPO8D/uRBLEinGLyJqkdu0dN/kuVUHXJCuR+Z3yGcyUoGMdkCkKDwEJ7negDIg8lPNbCJ3+18jFQpI+hWFNaQaVNgwD+q0neWf2QdR7REAP90yVk0Klv91h2hhQMJdBDkQ3XrO/TcVa6t4WWs//oho/q+aWnQTW0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241903; c=relaxed/simple;
	bh=ZeLntDMV5mjNM8Ple7apsV7xkXZ0/am6TvqAsAtzaXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKyGYoDp/zLiR0Mcphy4BlU+hWJ33KYm3v2iLC1w+mEV0if3YDANKTcda/PK49cngqdMPTyimyAiCg4dDN6aKGhl46yVRrNaX365pGKPCwObP1mFRHsMuxWhoJWtPCEIdqAoCbcTpWCc4Cwqqy+9Gg3Ovl04zL58KbeeyPEXJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KtkJCnuR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dd57589c8so31637e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732241900; x=1732846700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8r4mnejj7RLE9zF6UjcBekU7Owq8HMQeCRrqOVSEg0=;
        b=KtkJCnuRZHSfM0Ud1TzbNZp9aWz1JSAzjt/9RQsmgRNpK+0tbWVY2FpdSKXAVE2Kb3
         20y8lGjv00lXbBlYj2KjUPwPf9mIUEUj07aV/KauJcGnFHyVtJwHaBOfLMEjsnvYNrth
         K/LesB3nDFT9VpIdcg//jBTQzNag0CJFAwIiNsIoL8SsA6w+xWgx4Ls5UN1hDzYRyYni
         rXMBL0OreWKdpGz29lj+A295n2x4NlgIFA8aQL1WXagIgziEobKHG1XVC23yhT1fYUHO
         W8u6uBU+3ZVwh7fksbGw4E5cfjDAQmH3CrxeMLYxC6cy+5sDuZndADZRIReIwDKUkViV
         GOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241900; x=1732846700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8r4mnejj7RLE9zF6UjcBekU7Owq8HMQeCRrqOVSEg0=;
        b=NhhPkeJK7S3Uq+mOjNzQHfNBopx7hxxWxhMMSHfK2+aQLxYvcXgY6AiEJy0ns4NJln
         h7yUS9tT4jFE6QIeC+tHqseUb87yh9h7hxSKm3nmyH1jXU5KRioWw1/e6jwIcWPnJIVr
         C5gs2NOpbegTLK5zWL7J4lap88fc/OqsejBnLfw2BgLMn2+q3PUioh35aDqPGzQ9XRzm
         5e/+9mLuYFTm3Ershh2Y9dhGRPHBolybS8kkkelADNvico94fZ46lq7j5s9XtmAT4CdB
         DRYyGMTbTxSPAF8IPO4xBGg4kes2m1ZyaYHDCLbnhy0V3AweZFsekHFeBqU+vp7azx08
         29TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA81G5VIjHWmu6zHIEfLw2PvC2JT/ZdWkupFFjJ/+Z0wsyOin4gLNlexGuDORI3iNzUTq+EmepUSEpAIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyosHqPS/Oa08V2OpZiVnOFs+OL0wiZE2F+evVaI5A9FGPbKyvA
	BKMn3HB6Ri5aLsgv76WT15p1G9KhgU6xjkXnhyoU+eKWEj8xtdldGcN6Sm14MK4=
X-Gm-Gg: ASbGncuRYeyfkwLmO8Rapwp1Z0VFspp4lClmv3FWhj2QctKwBDeoLL9PvU/B5ioE2GJ
	mdfZbUK3zAAuNZ96Tl/ZEjsbNoXkdKouClq7dpRUI+tWtto0uvN+vstVPWiX+8cuyP/BVX6Zi4w
	7U2mfxDtuNJzOdYjhCKPal17VObCToEJvmkJQqUPLnw66QUvhNBgT9mgYSmrUTw/GlQhLnqrKN9
	4gd0/DbmWC4oLJrHeS3my3SYNdEVinftPaotIpN+knDvNMVLosYPCXetu1WYXS/em6pOla3U8sY
	0MwXBjKSQme99WdPidNGKwmB4XUyoQ==
X-Google-Smtp-Source: AGHT+IH2XVG4CrGcKLtMWVmsHezxyuZC2DkpmiAfjI5u+x2GLL/vigGbfq/KQOpmIov6vnUu63SYfg==
X-Received: by 2002:a05:6512:2c0e:b0:53d:a90e:685c with SMTP id 2adb3069b0e04-53dd2ace6d7mr430691e87.15.1732241899654;
        Thu, 21 Nov 2024 18:18:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481d5dsm166986e87.131.2024.11.21.18.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 18:18:18 -0800 (PST)
Date: Fri, 22 Nov 2024 04:18:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 drm-dp 3/5] drm/hisilicon/hibmc: add dp hw moduel in
 hibmc
Message-ID: <yqloscxeflxj6lvq5pmktpznmp2iv4p4ddavcvlscbtmytqt33@k5n66gh5axxq>
References: <20241118142805.3326443-1-shiyongbang@huawei.com>
 <20241118142805.3326443-4-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118142805.3326443-4-shiyongbang@huawei.com>

On Mon, Nov 18, 2024 at 10:28:03PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Build a dp level that hibmc driver can enable dp by
> calling their functions.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - changed the type of train_set to array, suggested by Dmitry Baryshkov.
>   - using actual link rate instead of magic num, suggested by Dmitry Baryshkov.
>   - deleting hibmc_dp_hw_uninit(), suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202410250931.UDQ9s66H-lkp@intel.com/
> v1 -> v2:
>   - changed some defines and functions to former patch, suggested by Dmitry Baryshkov.
>   - sorting the headers including in dp_hw.h and hibmc_drm_drv.c files, suggested by Dmitry Baryshkov.
>   - deleting struct dp_mode and dp_mode_cfg function, suggested by Dmitry Baryshkov.
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202410040328.VeVxM9yB-lkp@intel.com/
>   v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   2 +-
>  .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  19 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 217 ++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  28 +++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  41 ++++
>  5 files changed, 306 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> index 94d77da88bbf..214228052ccf 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> -	       dp/dp_aux.o dp/dp_link.o
> +	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o
>  
>  obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> new file mode 100644
> index 000000000000..74dd9956144e
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright (c) 2024 Hisilicon Limited. */
> +
> +#ifndef DP_CONFIG_H
> +#define DP_CONFIG_H
> +
> +#define HIBMC_DP_BPP			24
> +#define HIBMC_DP_SYMBOL_PER_FCLK	4
> +#define HIBMC_DP_MSA1			0x20
> +#define HIBMC_DP_MSA2			0x845c00
> +#define HIBMC_DP_OFFSET			0x1e0000
> +#define HIBMC_DP_HDCP			0x2
> +#define HIBMC_DP_INT_RST		0xffff
> +#define HIBMC_DP_DPTX_RST		0x3ff
> +#define HIBMC_DP_CLK_EN			0x7
> +#define HIBMC_DP_SYNC_EN_MASK		0x3
> +#define HIBMC_DP_LINK_RATE_CAL		27
> +
> +#endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> new file mode 100644
> index 000000000000..9d7337cd9309
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2024 Hisilicon Limited.
> +
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include "dp_config.h"
> +#include "dp_comm.h"
> +#include "dp_reg.h"
> +#include "dp_hw.h"
> +
> +static void hibmc_dp_set_tu(struct hibmc_dp_dev *dp, struct drm_display_mode *mode)
> +{
> +	u32 tu_symbol_frac_size;
> +	u32 tu_symbol_size;
> +	u32 rate_ks;
> +	u8 lane_num;
> +	u32 value;
> +	u32 bpp;
> +
> +	lane_num = dp->link.cap.lanes;
> +	if (lane_num == 0) {
> +		drm_err(dp->dev, "set tu failed, lane num cannot be 0!\n");
> +		return;
> +	}
> +
> +	bpp = HIBMC_DP_BPP;
> +	rate_ks = dp->link.cap.link_rate * HIBMC_DP_LINK_RATE_CAL;
> +	value = (mode->clock * bpp * 5) / (61 * lane_num * rate_ks);
> +
> +	if (value % 10 == 9) { /* 9 carry */
> +		tu_symbol_size = value / 10 + 1;
> +		tu_symbol_frac_size = 0;
> +	} else {
> +		tu_symbol_size = value / 10;
> +		tu_symbol_frac_size = value % 10 + 1;
> +	}
> +
> +	drm_info(dp->dev, "tu value: %u.%u value: %u\n",
> +		 tu_symbol_size, tu_symbol_frac_size, value);

drm_dbg_driver()

> +
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_PACKET,
> +				 HIBMC_DP_CFG_STREAM_TU_SYMBOL_SIZE, tu_symbol_size);
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_PACKET,
> +				 HIBMC_DP_CFG_STREAM_TU_SYMBOL_FRAC_SIZE, tu_symbol_frac_size);
> +}
> +
> +static void hibmc_dp_set_sst(struct hibmc_dp_dev *dp, struct drm_display_mode *mode)
> +{
> +	u32 hblank_size;
> +	u32 htotal_size;
> +	u32 htotal_int;
> +	u32 hblank_int;
> +	u32 fclk; /* flink_clock */
> +
> +	fclk = dp->link.cap.link_rate * HIBMC_DP_LINK_RATE_CAL;
> +
> +	htotal_int = mode->htotal * 9947 / 10000;
> +	htotal_size = htotal_int * fclk / (HIBMC_DP_SYMBOL_PER_FCLK * (mode->clock / 1000));
> +
> +	hblank_int = mode->htotal - mode->hdisplay - mode->hdisplay * 53 / 10000;
> +	hblank_size = hblank_int * fclk * 9947 /

Still no idea, what 0.9947 is.

> +		      (mode->clock * 10 * HIBMC_DP_SYMBOL_PER_FCLK);
> +
> +	drm_info(dp->dev, "h_active %u v_active %u htotal_size %u hblank_size %u",
> +		 mode->hdisplay, mode->vdisplay, htotal_size, hblank_size);
> +	drm_info(dp->dev, "flink_clock %u pixel_clock %d", fclk, mode->clock / 1000);

And here. Please review the driver not to output any debug information
by default.

> +
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_HORIZONTAL_SIZE,
> +				 HIBMC_DP_CFG_STREAM_HTOTAL_SIZE, htotal_size);
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_HORIZONTAL_SIZE,
> +				 HIBMC_DP_CFG_STREAM_HBLANK_SIZE, hblank_size);
> +}
> +

Other than that LGTM

-- 
With best wishes
Dmitry

