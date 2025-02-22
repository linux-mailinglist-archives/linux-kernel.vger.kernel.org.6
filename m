Return-Path: <linux-kernel+bounces-526955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50097A405A2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C8F4249D3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739F1DE3D9;
	Sat, 22 Feb 2025 05:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8mcmF8m"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862051D798E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740201954; cv=none; b=KunWh3A6VjYaePaOW+uNjMDdHGPUO1F7qYuEMDKtZ61DCz/+XOE8JtVp9gIffCIVlmqcP8cLIpsGrSW7iIp4tMynz8fVsNWmDBweYNmmzY9eNhxh/HPV6nmWiNbM/RdsR+S0MdIfc8J1voxgAZ6Kw2dN6cG287zGWQkRp3p5SsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740201954; c=relaxed/simple;
	bh=2oK/MZl6oosSTlFIVBXFlf6dBPxdEraVBjdeQjvzPGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id/wLHKz17sQuri/p/oB2Z3w4R8nENq4RPdW0nlC6ylOyVwxateZ6RFhM2+qrPIrQQviPz5kZ4j/9QmPXwpKr+NE1hg4tGFPa+plfQISfOvSHIRunX/1ndonhm+PcPLnVUCbMDfM3yFM86djPcfw7DqMROX2WdFBualc0MCjubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e8mcmF8m; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-545284eac3bso2725048e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740201950; x=1740806750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAZ/vcHzK4llo5zSYJieIl5qjQ34DX1vOJVYqnncBJE=;
        b=e8mcmF8mWxs3IflFyheR5ZleLvXSdFiBtvX0KlnIsjkODpEVuY9K0lvzwozkD0E9PJ
         iow+5bgrAO24ZQL98P+FrPt+p4VRozNIGYiDRPn69jbHUrbIBbDsNfikfGjaC1K+KEfJ
         idwnTuxMhl6pTNM9XFL4kkgohEd6D6LwjjSFZbXPowFosZE/A58xDJf+H8PQ4WmPZU2T
         9HW90VHKDftNLlQAc8JKq5FdmWGbKIDdSTdW08AbmFsffUaf9CB0VN49UO0zLONAMDws
         vTVnF6opUqP0o+RlSzblR/wxnPI3+yLGmm0ZPVMMxTOGhSIRLaT1RD7RufWaXh4GPUhk
         3BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740201950; x=1740806750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAZ/vcHzK4llo5zSYJieIl5qjQ34DX1vOJVYqnncBJE=;
        b=kVygEgbqpJybqrQtkiiqhK41u2K+EJbkpGqPk3FvUow5FjtvMi6iEvRLXXQc+g+fXv
         0LWjiKzBKxEROxRaJGrlTBRkSdry6LwrfPiSeD9OUJ33kTfWpKGlr59B1oMQ2IjL2CYq
         1NnDREUxTpps1CiQgc/HvknHnuPznqUw9oX0RdKjNEDRJJtyY9CrN31o19c0ntcsSQjJ
         RHdYjwk6yXxtwlUkwV7xlJuADO4XdoQZyvAmht/lTsINsxdHg+d+p/Lrrl1RtacnmzFc
         9xLzBkoPerkyLAJqsTAN9yyQT96whtf919olfvhk0dIoldARZutlCZTVkWGhBEFIpYaV
         wo+A==
X-Forwarded-Encrypted: i=1; AJvYcCUN8AIST877Np/2QO3jrayrjZyZrxNLHOvHZUKNSu6bbXtTUK7947wxEDg9SAjX+OyzcsyA0e5QykTxBbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhkky5Oq2IaSPzc2SFlQDioUzCJBpdnXRzyy41+uWQnsuZP69v
	rsVIS1gDkYM2Uy5FBPMyPalKouwOGGoCUDHSikI9QXLSlG1mSaVMTemv4n/qCtENE1yqa5fO5BV
	1
X-Gm-Gg: ASbGncuEkWJPZsh8FEm1vtBvFgQ332WHWKl4sykKb8R8ygoKLZ6uPm9xVfM7j7c/uf4
	uwrGXg2wpdLQ5uJRFxndU677mU+plL/flrUCwH6UNK1z4XI0E/JBtsxbWmLv5hYXbFa/HS+cEz4
	jf6q/AlzzoyCgY1TQ9R0JHP/V430Rpwa0B2uYtO6fRTblaYy7MKCTCHjdhiO5xLzDXcRwGpkclL
	luw3NA22eSHp12Kljdc9KryHS+MzKzYW1h7FqhFRGOue4YouZMGIfjdL1zDSZ21yrQs3qJkh4Iq
	oMpirvsBSYw+x8n9FPNE6Tg6lnC4FJy580zWSlhLE083AcK5s6g0ZoEBfenp+TbLEYWGa8fbtlo
	e0+Wp8Q==
X-Google-Smtp-Source: AGHT+IEepcfNAmY96vLvefzWdln+Lkk4CWfoHHeqwSHUYt29sHbWBkG3NBuXNUDJWnIVYyLhfwzKqw==
X-Received: by 2002:a05:6512:108b:b0:545:d54:2ec1 with SMTP id 2adb3069b0e04-54838ee9203mr2511039e87.21.1740201949905;
        Fri, 21 Feb 2025 21:25:49 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a3ce198e6sm13941521fa.3.2025.02.21.21.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:25:48 -0800 (PST)
Date: Sat, 22 Feb 2025 07:25:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 2/8] drm/hisilicon/hibmc: Add dp serdes cfg to
 adjust serdes rate, voltage and pre-emphasis
Message-ID: <dmq3iyxffg4jo7eup37zk4uqkqjtbn7wj2jmyl6ww5clksmgvq@jdslhlsbxrdr>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-3-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222025102.1519798-3-shiyongbang@huawei.com>

On Sat, Feb 22, 2025 at 10:50:55AM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> This dp controller need features of digital-to-analog conversion and
> high-speed transmission in chip by its extern serdes controller. Our
> serdes cfg is relatively simple, just need two register configurations.
> Don't need too much functions, like: power on/off, initialize, and some
> complex configurations, so I'm not going to use the phy framework.
> This serdes is inited and configured in dp initialization, and also
> integrating them into link training process.
> 
> For rate changing, we can change from 1.62-8.2Gpbs by cfg reg.
> For voltage and pre-emphasis levels changing, we can cfg different
> serdes ffe value.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 - > v3:
>   - add commit log about dp serdes, suggested by Dmitry Baryshkov.
>   - return value in hibmc_dp_serdes_init(), suggested by Dmitry Baryshkov.
>   - add static const in the array of serdes_tx_cfg[], suggested by Dmitry Baryshkov.
>   - change drm_warn to drm_dbg_dp, suggested by Dmitry Baryshkov.
>   - add explanations about dp serdes macros, suggested by Dmitry Baryshkov.
> v1 -> v2:
>   - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
>   - changing all names of dp phy to dp serdes.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |  2 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  1 +
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  6 ++
>  .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    | 72 +++++++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.h    | 34 +++++++++
>  5 files changed, 114 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> index 95a4ed599d98..43de077d6769 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> -	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o hibmc_drm_dp.o
> +	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o dp/dp_serdes.o hibmc_drm_dp.o
>  
>  obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> index 2c52a4476c4d..e7746bc4b592 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> @@ -38,6 +38,7 @@ struct hibmc_dp_dev {
>  	struct mutex lock; /* protects concurrent RW in hibmc_dp_reg_write_field() */
>  	struct hibmc_dp_link link;
>  	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> +	void __iomem *serdes_base;
>  };
>  
>  #define dp_field_modify(reg_value, mask, val)				\
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index a8d543881c09..59078483ec55 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -7,6 +7,7 @@
>  #include "dp_comm.h"
>  #include "dp_reg.h"
>  #include "dp_hw.h"
> +#include "dp_serdes.h"
>  
>  static void hibmc_dp_set_tu(struct hibmc_dp_dev *dp, struct drm_display_mode *mode)
>  {
> @@ -151,6 +152,7 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  {
>  	struct drm_device *drm_dev = dp->drm_dev;
>  	struct hibmc_dp_dev *dp_dev;
> +	int ret;
>  
>  	dp_dev = devm_kzalloc(drm_dev->dev, sizeof(struct hibmc_dp_dev), GFP_KERNEL);
>  	if (!dp_dev)
> @@ -165,6 +167,10 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  
>  	hibmc_dp_aux_init(dp_dev);
>  
> +	ret = hibmc_dp_serdes_init(dp_dev);
> +	if (ret)
> +		return ret;
> +
>  	dp_dev->link.cap.lanes = 0x2;
>  	dp_dev->link.cap.link_rate = DP_LINK_BW_2_7;
>  
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
> new file mode 100644
> index 000000000000..241b9ef782b0
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2025 Hisilicon Limited.
> +
> +#include <linux/delay.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_print.h>
> +#include "dp_comm.h"
> +#include "dp_config.h"
> +#include "dp_reg.h"
> +#include "dp_serdes.h"
> +
> +int hibmc_dp_serdes_set_tx_cfg(struct hibmc_dp_dev *dp, u8 train_set[HIBMC_DP_LANE_NUM_MAX])
> +{
> +	static const u32 serdes_tx_cfg[4][4] = { {DP_SERDES_VOL0_PRE0, DP_SERDES_VOL0_PRE1,
> +						  DP_SERDES_VOL0_PRE2, DP_SERDES_VOL0_PRE3},
> +						 {DP_SERDES_VOL1_PRE0, DP_SERDES_VOL1_PRE1,
> +						  DP_SERDES_VOL1_PRE2}, {DP_SERDES_VOL2_PRE0,
> +						  DP_SERDES_VOL2_PRE1}, {DP_SERDES_VOL3_PRE0}};
> +	int cfg[2];
> +	int i;
> +
> +	for (i = 0; i < HIBMC_DP_LANE_NUM_MAX; i++) {
> +		cfg[i] = serdes_tx_cfg[(train_set[i] & 0x3)]
> +			 [(train_set[i] << DP_TRAIN_PRE_EMPHASIS_SHIFT & 0x3)];

I think this will not work as expected. There should be no need to shift
train_set[i], otherwise first '&' is executed, reducing array index to
(train_set[i]) << 3), which then is out-of-boundaries for the array.

Most likely you meant:

cfg[i] = serdes_tx_cfg[FIELD_GET(DP_TRAIN_VOLTAGE_SWING_MASK, train_set[i]]
		      [FIELD_GET(DP_TRAIN_PRE_EMPHASIS_MASK, train_set[i]];


> +		if (!cfg[i])
> +			return -EINVAL;
> +
> +		/* lane1 offset is 4 */
> +		writel(FIELD_PREP(HIBMC_DP_PMA_TXDEEMPH, cfg[i]),
> +		       dp->serdes_base + HIBMC_DP_PMA_LANE0_OFFSET + i * 4);
> +	}
> +
> +	usleep_range(300, 500);
> +
> +	if (readl(dp->serdes_base + HIBMC_DP_LANE_STATUS_OFFSET) != DP_SERDES_DONE) {
> +		drm_dbg_dp(dp->dev, "dp serdes cfg failed\n");
> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +int hibmc_dp_serdes_rate_switch(u8 rate, struct hibmc_dp_dev *dp)
> +{
> +	writel(rate, dp->serdes_base + HIBMC_DP_LANE0_RATE_OFFSET);
> +	writel(rate, dp->serdes_base + HIBMC_DP_LANE1_RATE_OFFSET);
> +
> +	usleep_range(300, 500);
> +
> +	if (readl(dp->serdes_base + HIBMC_DP_LANE_STATUS_OFFSET) != DP_SERDES_DONE) {
> +		drm_dbg_dp(dp->dev, "dp serdes rate switching failed\n");
> +		return -EAGAIN;
> +	}
> +
> +	if (rate < DP_SERDES_BW_8_1)
> +		drm_dbg_dp(dp->dev, "reducing serdes rate to :%d\n",
> +			   rate ? rate * HIBMC_DP_LINK_RATE_CAL * 10 : 162);
> +
> +	return 0;
> +}
> +
> +int hibmc_dp_serdes_init(struct hibmc_dp_dev *dp)
> +{
> +	dp->serdes_base = dp->base + HIBMC_DP_HOST_OFFSET;
> +
> +	writel(FIELD_PREP(HIBMC_DP_PMA_TXDEEMPH, DP_SERDES_VOL0_PRE0),
> +	       dp->serdes_base + HIBMC_DP_PMA_LANE0_OFFSET);
> +	writel(FIELD_PREP(HIBMC_DP_PMA_TXDEEMPH, DP_SERDES_VOL0_PRE0),
> +	       dp->serdes_base + HIBMC_DP_PMA_LANE1_OFFSET);
> +
> +	return hibmc_dp_serdes_rate_switch(DP_SERDES_BW_8_1, dp);
> +}
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h
> new file mode 100644
> index 000000000000..812d0794543c
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright (c) 2025 Hisilicon Limited. */
> +
> +#ifndef DP_SERDES_H
> +#define DP_SERDES_H
> +

Why all these values are not a part of the dp_reg.h?

> +#define HIBMC_DP_HOST_OFFSET		0x10000
> +#define HIBMC_DP_LANE0_RATE_OFFSET	0x4
> +#define HIBMC_DP_LANE1_RATE_OFFSET	0xc
> +#define HIBMC_DP_LANE_STATUS_OFFSET	0x10
> +#define HIBMC_DP_PMA_LANE0_OFFSET	0x18
> +#define HIBMC_DP_PMA_LANE1_OFFSET	0x1c
> +#define HIBMC_DP_PMA_TXDEEMPH		GENMASK(18, 1)
> +
> +/* dp serdes TX-Deempth Configuration */
> +#define DP_SERDES_VOL0_PRE0		0x280
> +#define DP_SERDES_VOL0_PRE1		0x2300
> +#define DP_SERDES_VOL0_PRE2		0x53c0
> +#define DP_SERDES_VOL0_PRE3		0x8400
> +#define DP_SERDES_VOL1_PRE0		0x380
> +#define DP_SERDES_VOL1_PRE1		0x3440
> +#define DP_SERDES_VOL1_PRE2		0x6480
> +#define DP_SERDES_VOL2_PRE0		0x500
> +#define DP_SERDES_VOL2_PRE1		0x4500
> +#define DP_SERDES_VOL3_PRE0		0x600
> +#define DP_SERDES_BW_8_1		0x3
> +
> +#define DP_SERDES_DONE			0x3
> +
> +int hibmc_dp_serdes_init(struct hibmc_dp_dev *dp);
> +int hibmc_dp_serdes_rate_switch(u8 rate, struct hibmc_dp_dev *dp);
> +int hibmc_dp_serdes_set_tx_cfg(struct hibmc_dp_dev *dp, u8 train_set[HIBMC_DP_LANE_NUM_MAX]);
> +
> +#endif
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

