Return-Path: <linux-kernel+bounces-209423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527F903486
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FB1B2CB94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80372172BC1;
	Tue, 11 Jun 2024 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQ/LTyf/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A51172BBA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092306; cv=none; b=U+pNZxepXSvetzf67+qIwvrlk1szj85wXRlDwffG4S+O29ZNRdMux4BthofnrGdBJroWyE/y+DzEQDtEcu7cKgDFQqKr/8lrs1/Tr+MbE4pKBZxZ1f5ccWiQxKDGEvI7MQVdMYLQouOR3xN7+t+lzIEf/Sr88TicPqJb4eEcUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092306; c=relaxed/simple;
	bh=A75FD6DytObZXtVAQa7UpZHf8XqVcKXKzHIlv2OZqY0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hskHXXIrw0+lTNWdXq4Zc0n8pKJW0euKou+N4njFyDLA1Zav4iZwyImTL2URsrlWXEYT6HItiEn3z7f3oOMKWVGx72gXg+yyLVmpeiCaiVdLrooY9e8N6OKMgaSL3Tb47Nskp95C4mKf2dA9HVpKlIX8AHMUY8jlb7/NNyorMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQ/LTyf/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354f3f6c3b1so4268805f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718092301; x=1718697101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4p6K0G6wV9PB0oWVckGjSIKaLa97Rva83QHCXxZmHI=;
        b=LQ/LTyf//U30FgZ6ofzdezBebYuqfD8isjvZWFSCOQDeDHpo/NocWR9O1IKS2+RUnS
         gTCP3S7mj3ytxSF0VRhL3oI3AG67Oxi7WyeFDKGfpGN4cyeFFMdnBs8Yd3pWKrlLYATQ
         AqzhadgOxKVKWlv/wkJ2aBye/GtiL8SnzTwb2QdBdMXeprGpll/Qvlyi2g1XPIWwnh2D
         53LQZt77wh8KcCOZdccl/5aaEMBVSeoI+zuR/azDa6w+db5Pl/l8cSDqoU/x1qiGOwoT
         CoKLWtCeVxHlVjasiT3vmAT2Hf/PXBKvE7Ceb5V20eMEYDy4SKBk3En05/ULFLxVdZ3T
         vh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092301; x=1718697101;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P4p6K0G6wV9PB0oWVckGjSIKaLa97Rva83QHCXxZmHI=;
        b=rZlG//4Oxyde3kH6yuW2BGGxTHW0QCCUpgYx2g19HgZ7cis0lYzNRefv9MXzQLaCA3
         w0kpCKUh8kS384Pqzp98ztEfe2hufdpyyLcwIpE8FcPK2TGkX9IsB3EjQmBnSy/nne9i
         yf5dVG0Ss91leGADXpW+PG6IXrfYYvveOvyM5Zi+Y3eIJdUgICVQmhQ+PrY3EmmDsMyk
         Km3MilocMzgDOnDUMO6ravM+T38Ikj6+hIkHEwy42YN+xdi9LAQ1agK+I2Sm9ocfLuMM
         bNNgKXtyjcsTLm4Z+Z+IPBXu8tFfeWTNiSLnq6TwlKrXFslkOBTbTU+EsmxkinIMmLDv
         abEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj/hjqltDUqKf+dtB1cZQp0FEhH4hRVryIZD3cU1Me4s+rDa7hOvWxgb2AHfBw4qGeui2i8L5Uq4Cfqh4us/4Bar2ZuoOEZl5/4XQV
X-Gm-Message-State: AOJu0YyojcxWgIqZo1dsRorI+ddQqrmTpw+g0A4StlXzLCE4v1rOK7Hi
	eJZqru5pOi71wXeDEnI7G3gywURS5SWMtPhPQ1i8oHXVvGYt+LICPMr4vGPVPHk=
X-Google-Smtp-Source: AGHT+IFZ+i1Qz1ahRuGcKGins4bu7z8M9C1FwDbIDVWNBp3KcbGS663YTxh6LRJKMcCBjv5AyDj1MQ==
X-Received: by 2002:a5d:6da8:0:b0:35f:22e4:c575 with SMTP id ffacd0b85a97d-35f22e4c5d5mr4373683f8f.56.1718092301169;
        Tue, 11 Jun 2024 00:51:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a4:3b2:c750:ef5c? ([2a01:e0a:982:cbb0:5a4:3b2:c750:ef5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1bcbc31bsm7356546f8f.44.2024.06.11.00.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 00:51:40 -0700 (PDT)
Message-ID: <c3cd2399-05a6-4cdc-ad28-79a85534112d@linaro.org>
Date: Tue, 11 Jun 2024 09:51:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel: Add Samsung AMS639RQ08 panel driver
To: Danila Tikhonov <danila@jiaxyga.com>, quic_jesszhan@quicinc.com,
 sam@ravnborg.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, adrian@travitia.xyz, degdagmohamed@gmail.com
References: <20240609203618.49413-1-danila@jiaxyga.com>
 <20240609203618.49413-3-danila@jiaxyga.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240609203618.49413-3-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/06/2024 22:36, Danila Tikhonov wrote:
> Add the driver for Samsung AMS639RQ08 FHD Plus CMD mode panel support
> found in:
> - Xiaomi Mi 9 Lite / CC9 (sdm710-xiaomi-pyxis)
> - Xiaomi Mi 9T / Redmi K20 (sm7150-xiaomi-davinci)
> - Xiaomi Mi 9T Pro / Redmi K20 Pro (sm8150-xiaomi-raphael)
> 
> Tested-by: Degdag Mohamed <degdagmohamed@gmail.com> # xiaomi-raphael
> Tested-by: Jens Reidel <adrian@travitia.xyz> # xiaomi-davinci
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>   drivers/gpu/drm/panel/Kconfig                 |   9 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   .../gpu/drm/panel/panel-samsung-ams639rq08.c  | 362 ++++++++++++++++++
>   3 files changed, 372 insertions(+)
>   create mode 100644 drivers/gpu/drm/panel/panel-samsung-ams639rq08.c
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 2ae0eb0638f32..8a86960ae812a 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -576,6 +576,15 @@ config DRM_PANEL_RONBO_RB070D30
>   	  Say Y here if you want to enable support for Ronbo Electronics
>   	  RB070D30 1024x600 DSI panel.
>   
> +config DRM_PANEL_SAMSUNG_AMS639RQ08
> +	tristate "Samsung AMS639RQ08 panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y or M here if you want to enable support for the
> +	  Samsung AMS639RQ08 FHD Plus (2340x1080@60Hz) CMD mode panel.
> +
>   config DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01
>   	tristate "Samsung AMS452EF01 panel with S6E88A0 DSI video mode controller"
>   	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index f0203f6e02f44..eb87bc01b0414 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -58,6 +58,7 @@ obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
>   obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM692E5) += panel-raydium-rm692e5.o
>   obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM69380) += panel-raydium-rm69380.o
>   obj-$(CONFIG_DRM_PANEL_RONBO_RB070D30) += panel-ronbo-rb070d30.o
> +obj-$(CONFIG_DRM_PANEL_SAMSUNG_AMS639RQ08) += panel-samsung-ams639rq08.o
>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20) += panel-samsung-atna33xc20.o
>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_DB7430) += panel-samsung-db7430.o
>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
> diff --git a/drivers/gpu/drm/panel/panel-samsung-ams639rq08.c b/drivers/gpu/drm/panel/panel-samsung-ams639rq08.c
> new file mode 100644
> index 0000000000000..f9789fdd6c326
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-samsung-ams639rq08.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +/* Manufacturer Command Set */
> +#define MCS_ACCESS_PROT_OFF	0xb0
> +#define MCS_UNKNOWN_B7		0xb7
> +#define MCS_BIAS_CURRENT_CTRL	0xd1
> +#define MCS_PASSWD1		0xf0
> +#define MCS_PASSWD2		0xfc
> +#define MCS_UNKNOWN_FF		0xff
> +
> +struct ams639rq08 {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data supplies[4];
> +};
> +
> +static inline struct ams639rq08 *to_ams639rq08(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct ams639rq08, panel);
> +}
> +
> +static void ams639rq08_reset(struct ams639rq08 *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +}
> +
> +static int ams639rq08_on(struct ams639rq08 *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	/* Delay 2ms for VCI1 power */
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_ACCESS_PROT_OFF, 0x0c);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_UNKNOWN_FF, 0x10);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_ACCESS_PROT_OFF, 0x2f);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_BIAS_CURRENT_CTRL, 0x01);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0xa5, 0xa5);
> +
> +	/* Sleep Out */
> +	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> +		return ret;
> +	}
> +	usleep_range(10000, 11000);
> +
> +	/* TE OUT (Vsync On) */
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0x5a, 0x5a);
> +
> +	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set tear on: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* DBV Smooth Transition */
> +	mipi_dsi_dcs_write_seq(dsi, MCS_UNKNOWN_B7, 0x01, 0x4b);
> +
> +	/* Edge Dimming Speed Setting */
> +	mipi_dsi_dcs_write_seq(dsi, MCS_ACCESS_PROT_OFF, 0x06);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_UNKNOWN_B7, 0x10);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
> +
> +	/* Page Address Set */
> +	ret = mipi_dsi_dcs_set_page_address(dsi, 0x0000, 0x0923);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set page address: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0x5a, 0x5a);
> +
> +	/* Set DDIC internal HFP */
> +	mipi_dsi_dcs_write_seq(dsi, MCS_ACCESS_PROT_OFF, 0x23);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_BIAS_CURRENT_CTRL, 0x11);
> +
> +	/* OFC Setting 84.1 Mhz */
> +	mipi_dsi_dcs_write_seq(dsi, 0xe9, 0x11, 0x55,
> +				    0xa6, 0x75, 0xa3,
> +				    0xb9, 0xa1, 0x4a,
> +				    0x00, 0x1a, 0xb8);
> +
> +	/* Err_FG Setting */
> +	mipi_dsi_dcs_write_seq(dsi, 0xe1,
> +				    0x00, 0x00, 0x02,
> +				    0x02, 0x42, 0x02);
> +	mipi_dsi_dcs_write_seq(dsi, 0xe2,
> +				    0x00, 0x00, 0x00,
> +				    0x00, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_ACCESS_PROT_OFF, 0x0c);
> +	mipi_dsi_dcs_write_seq(dsi, 0xe1, 0x19);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0xa5, 0xa5);
> +	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
> +
> +	/* Brightness Control */
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x0000);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set display brightness: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Display On */
> +	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
> +	msleep(67);
> +
> +	ret = mipi_dsi_dcs_set_display_on(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set display on: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ams639rq08_off(struct ams639rq08 *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	ret = mipi_dsi_dcs_set_display_off(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set display off: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
> +		return ret;
> +	}
> +	msleep(120);
> +
> +	return 0;
> +}
> +
> +static int ams639rq08_prepare(struct drm_panel *panel)
> +{
> +	struct ams639rq08 *ctx = to_ams639rq08(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ams639rq08_reset(ctx);
> +
> +	ret = ams639rq08_on(ctx);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ams639rq08_unprepare(struct drm_panel *panel)
> +{
> +	struct ams639rq08 *ctx = to_ams639rq08(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	ret = ams639rq08_off(ctx);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode ams639rq08_mode = {
> +	.clock = (1080 + 64 + 20 + 64) * (2340 + 64 + 20 + 64) * 60 / 1000,
> +	.hdisplay = 1080,
> +	.hsync_start = 1080 + 64,
> +	.hsync_end = 1080 + 64 + 20,
> +	.htotal = 1080 + 64 + 20 + 64,
> +	.vdisplay = 2340,
> +	.vsync_start = 2340 + 64,
> +	.vsync_end = 2340 + 64 + 20,
> +	.vtotal = 2340 + 64 + 20 + 64,
> +	.width_mm = 68,
> +	.height_mm = 147,
> +	.type = DRM_MODE_TYPE_DRIVER,
> +};
> +
> +static int ams639rq08_get_modes(struct drm_panel *panel,
> +					struct drm_connector *connector)
> +{
> +	return drm_connector_helper_get_modes_fixed(connector, &ams639rq08_mode);
> +}
> +
> +static const struct drm_panel_funcs ams639rq08_panel_funcs = {
> +	.prepare = ams639rq08_prepare,
> +	.unprepare = ams639rq08_unprepare,
> +	.get_modes = ams639rq08_get_modes,
> +};
> +
> +static int ams639rq08_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness = backlight_get_brightness(bl);
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}
> +
> +static int ams639rq08_bl_get_brightness(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness;
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_get_display_brightness_large(dsi, &brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return brightness;
> +}
> +
> +static const struct backlight_ops ams639rq08_bl_ops = {
> +	.update_status = ams639rq08_bl_update_status,
> +	.get_brightness = ams639rq08_bl_get_brightness,
> +};
> +
> +static struct backlight_device *
> +ams639rq08_create_backlight(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	const struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.brightness = 1023,
> +		.max_brightness = 2047,
> +	};
> +
> +	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
> +						&ams639rq08_bl_ops, &props);
> +}
> +
> +static int ams639rq08_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct ams639rq08 *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->supplies[0].supply = "vdd3p3";
> +	ctx->supplies[1].supply = "vddio";
> +	ctx->supplies[2].supply = "vsn";
> +	ctx->supplies[3].supply = "vsp";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> +								ctx->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +					"Failed to get reset-gpios\n");
> +
> +	ctx->dsi = dsi;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM;
> +
> +	drm_panel_init(&ctx->panel, dev, &ams639rq08_panel_funcs,
> +			DRM_MODE_CONNECTOR_DSI);
> +	ctx->panel.prepare_prev_first = true;
> +
> +	ctx->panel.backlight = ams639rq08_create_backlight(dsi);
> +	if (IS_ERR(ctx->panel.backlight))
> +		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> +					"Failed to create backlight\n");
> +
> +	drm_panel_add(&ctx->panel);
> +
> +	ret = devm_mipi_dsi_attach(dev, dsi);
> +	if (ret < 0) {
> +		drm_panel_remove(&ctx->panel);
> +		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void ams639rq08_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct ams639rq08 *ctx = mipi_dsi_get_drvdata(dsi);
> +
> +	drm_panel_remove(&ctx->panel);
> +}
> +
> +static const struct of_device_id ams639rq08_of_match[] = {
> +	{ .compatible = "samsung,ams639rq08" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ams639rq08_of_match);
> +
> +static struct mipi_dsi_driver ams639rq08_driver = {
> +	.probe = ams639rq08_probe,
> +	.remove = ams639rq08_remove,
> +	.driver = {
> +		.name = "panel-samsung-ams639rq08",
> +		.of_match_table = ams639rq08_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(ams639rq08_driver);
> +
> +MODULE_AUTHOR("Danila Tikhonov <danila@jiaxyga.com>");
> +MODULE_DESCRIPTION("DRM driver for SAMSUNG AMS639RQ08 cmd mode dsi panel");
> +MODULE_LICENSE("GPL");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

