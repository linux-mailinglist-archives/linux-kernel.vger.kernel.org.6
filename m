Return-Path: <linux-kernel+bounces-372858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10049A4E76
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBD71F26361
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 13:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94AF2CCB7;
	Sat, 19 Oct 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4aji6My"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B02BD0E
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729346386; cv=none; b=p030eTxmJYmL8+EAz3mVVQhrRloPsTYww6RyZ41/aZRua+jsWX4xbEB9xpa64l4NX2g8MkdXLnb/sLQf1RV2+I0l7ux0jWAvRHf9Nk85aQK3Ifk+dp+uWFCUghxWh4hmvaiSJu1gXBE7E8N6rZ65KwVoME1eCDO3Y2Uvx/XKFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729346386; c=relaxed/simple;
	bh=3uPz3+njCiSyITioMvfAPHUR7+3DaNhCPZlGWJXUoOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFY4VRJDZI0E+yrbx20bg/itGT5Lm8uVOrowJ35uGhDchRZHBbAcL7z4aaVH8e/Dvw5Oy7Dfz5y8toMSFQ2hiPAPavKP26xk8fdC9+oB5tB18BgXknXVzmzDXYWIx1Jix2hI+r6IuTXTFRqKHdGGjN/HNelsPXS0Ex2BKGkZJWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o4aji6My; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so35820111fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729346382; x=1729951182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYoxzo4bMNOQMkqsgaJWf0NI/6urhbP6naT0GF78T5w=;
        b=o4aji6MyiL1Y3jgzsrkGNtXK9OyeYXpBerX2v8R5AGEBwu71UYRdpR+CoTMdxIe5P+
         H1ohsySc/mLGUwgiofcE/e0iHcGFhwCObRgkT+BmGGFB1gno6MYpyK/Wo00OJzpuV8gJ
         VxKo1e1Ce7lD+LTzN4EKCpb6FSs4Dv8eWeLQs7JytvmgbA9saMilQaws5Nv9FDiPalbn
         rR0tMU6iX+ivumw1fRoyzwIiolgnMWFsdtTBAxX9X7vmrS/MQLntVnpt3QESKy3o9mnt
         Ogz24DfzYsSt1eWgGj/zDjetW9wMJN64W2ceZ+MB7g7/KwW5HyEOHQN8z+yOtQW/m2Z/
         r7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729346382; x=1729951182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYoxzo4bMNOQMkqsgaJWf0NI/6urhbP6naT0GF78T5w=;
        b=TpEb+34q6xz61tB8Atx0TQw9tqoHCbmjLrqKCX0L6NQg95Z1YeCObioMXKUAtSZYaD
         1Zx58yH1R4o3afNOKLKdvJRZPopHm9heyaDF9rEgxEFaYefEaw+J+pVfOvZHGIeVxLrO
         gELWxU9lOd7jFZCjk0pe8jF0JNB/006dhU3qFN165N4tSmuWjIHKX+LUZgl/ze5nO18q
         iAxdDiWsmkI1FSODSvGFHomCQxgzJirX1pOwcF8QAFcEAoAcwXN0sMOdNEgK6Ce1kkHv
         xtagDIbO2GdUx3JH7z89SIzaDLEaVjbLebA3QkWHvA1allvKnPb7wWttyBlbpNZUN/J+
         yvlA==
X-Forwarded-Encrypted: i=1; AJvYcCWNh70yFeufn0WjUTiHAbKJZobsgJvzD9XXWAkJxWMJBpPwbMHdxuXGKq6DY2JgoxUV3C1368V0Kl4bjf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYZclxu6X76qaTega/9jNYlPtPw1+McOTEIrDpiSVbzetTJhz
	WBH1K0uXNF5Ukuh1KFGKRZA4oCFjhh1G1IYdTsPTqx/xcC8Lkj+GhgrrKz1EKW4=
X-Google-Smtp-Source: AGHT+IGqqO8P2mMgLFVo7pHvPNuhv9WgIBf9B8g3YsSTbLEfDdr70Ztg/1Eb/nYyokxqqNXqEbxptA==
X-Received: by 2002:a05:6512:3ca3:b0:539:f1d2:725b with SMTP id 2adb3069b0e04-53a1583d16dmr1748947e87.4.1729346381509;
        Sat, 19 Oct 2024 06:59:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15203f64sm529715e87.188.2024.10.19.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 06:59:40 -0700 (PDT)
Date: Sat, 19 Oct 2024 16:59:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: shiyongbang <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-dp 3/4] drm/hisilicon/hibmc: add dp kapi moduel in
 hibmc drivers
Message-ID: <eslfc3ejjjpbw5wuf4khcoixeaitpb47iwf6kug7cryplcxcui@sieiyekdpczn>
References: <20240930100610.782363-1-shiyongbang@huawei.com>
 <20240930100610.782363-4-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930100610.782363-4-shiyongbang@huawei.com>

On Mon, Sep 30, 2024 at 06:06:09PM +0800, shiyongbang wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Build a kapi level that hibmc driver can enable dp by
> calling these kapi functions.
> 
> Signed-off-by: baihan li <libaihan@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |  2 +-
>  .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    | 20 ++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c  | 12 ++---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h  | 48 +++++++++++++++++++
>  4 files changed, 75 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> index 94d77da88bbf..693036dfab52 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> -	       dp/dp_aux.o dp/dp_link.o
> +	       dp/dp_aux.o dp/dp_link.o dp/dp_kapi.o
>  
>  obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> new file mode 100644
> index 000000000000..a6353a808cc4
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright (c) 2024 Hisilicon Limited. */
> +
> +#ifndef DP_CONFIG_H
> +#define DP_CONFIG_H
> +
> +#define DP_BPP 24
> +#define DP_SYMBOL_PER_FCLK 4
> +#define DP_MIN_PULSE_NUM 0x9
> +#define DP_MSA1 0x20
> +#define DP_MSA2 0x845c00
> +#define DP_OFFSET 0x1e0000
> +#define DP_HDCP 0x2
> +#define DP_INT_RST 0xffff
> +#define DP_DPTX_RST 0x3ff
> +#define DP_CLK_EN 0x7
> +#define DP_SYNC_EN_MASK 0x3
> +#define DP_LINK_RATE_CAL 27

I think some of these defines were used in previous patches. Please make
sure that at each step the code builds without errors.

> +
> +#endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c
> index 4091723473ad..ca7edc69427c 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c
> @@ -64,12 +64,12 @@ static void hibmc_dp_set_tu(struct hibmc_dp_dev *dp, struct dp_mode *mode)
>  	rate_ks = dp->link.cap.link_rate * DP_LINK_RATE_CAL;
>  	value = (pixel_clock * bpp * 5000) / (61 * lane_num * rate_ks);
>  
> -	if (value % 10 == 9) { /* 10: div, 9: carry */
> -		tu_symbol_size = value / 10 + 1; /* 10: div */
> +	if (value % 10 == 9) { /* 9 carry */
> +		tu_symbol_size = value / 10 + 1;
>  		tu_symbol_frac_size = 0;
>  	} else {
> -		tu_symbol_size = value / 10; /* 10: div */
> -		tu_symbol_frac_size = value % 10 + 1; /* 10: div */
> +		tu_symbol_size = value / 10;
> +		tu_symbol_frac_size = value % 10 + 1;
>  	}
>  
>  	drm_info(dp->dev, "tu value: %u.%u value: %u\n",
> @@ -158,7 +158,7 @@ static void hibmc_dp_link_cfg(struct hibmc_dp_dev *dp, struct dp_mode *mode)
>  	dp_write_bits(dp->base + DP_VIDEO_CTRL,
>  		      DP_CFG_STREAM_HSYNC_POLARITY, mode->h_pol);
>  
> -	/* MSA mic 0 and 1*/
> +	/* MSA mic 0 and 1 */
>  	writel(DP_MSA1, dp->base + DP_VIDEO_MSA1);
>  	writel(DP_MSA2, dp->base + DP_VIDEO_MSA2);
>  
> @@ -167,7 +167,7 @@ static void hibmc_dp_link_cfg(struct hibmc_dp_dev *dp, struct dp_mode *mode)
>  	dp_write_bits(dp->base + DP_VIDEO_CTRL, DP_CFG_STREAM_RGB_ENABLE, 0x1);
>  	dp_write_bits(dp->base + DP_VIDEO_CTRL, DP_CFG_STREAM_VIDEO_MAPPING, 0);
>  
> -	/*divide 2: up even */
> +	/* divide 2: up even */
>  	if (timing_delay % 2)
>  		timing_delay++;
>  

This should be squashed into the previous commits.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h
> new file mode 100644
> index 000000000000..6b07642d55b8
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright (c) 2024 Hisilicon Limited. */
> +
> +#ifndef DP_KAPI_H
> +#define DP_KAPI_H
> +
> +#include <linux/types.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_encoder.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_print.h>
> +#include <linux/delay.h>

Sort the headers, please.

> +
> +struct hibmc_dp_dev;
> +
> +struct dp_mode {
> +	u32 h_total;
> +	u32 h_active;
> +	u32 h_blank;
> +	u32 h_front;
> +	u32 h_sync;
> +	u32 h_back;
> +	bool h_pol;
> +	u32 v_total;
> +	u32 v_active;
> +	u32 v_blank;
> +	u32 v_front;
> +	u32 v_sync;
> +	u32 v_back;
> +	bool v_pol;
> +	u32 field_rate;
> +	u32 pixel_clock; // khz

Why do you need a separate struct for this?

> +};
> +
> +struct hibmc_dp {
> +	struct hibmc_dp_dev *dp_dev;
> +	struct drm_device *drm_dev;
> +	struct drm_encoder encoder;
> +	struct drm_connector connector;
> +	void __iomem *mmio;
> +};
> +
> +int hibmc_dp_kapi_init(struct hibmc_dp *dp);
> +void hibmc_dp_kapi_uninit(struct hibmc_dp *dp);
> +int hibmc_dp_mode_set(struct hibmc_dp *dp, struct dp_mode *mode);
> +void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable);

It looks like this should also be defined earlier.

> +
> +#endif
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

