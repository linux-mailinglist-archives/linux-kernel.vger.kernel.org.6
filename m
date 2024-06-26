Return-Path: <linux-kernel+bounces-231198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22256918795
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED9FB2477E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B5C186299;
	Wed, 26 Jun 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6R/KzEW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410E18F2CA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419754; cv=none; b=Gz0wA45bBtiRZbhV2kjAKtEK7Iby6oqaBzTVHpKxzvrKFbHTHd7+6ssgKpbPPaMBUuz74Qp6o8nKXjCFAwqCOP+LLLERkqJqh5MxY81zlGvatFoqnIyU/cXes9ySoIafugQr/xL5dQS4DW71of4dBUwZZQn9ItqdPDrGTvDvFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419754; c=relaxed/simple;
	bh=RTB1hNPS6npTJeUFTbS1TN7kOlMOv2jWtjZOJdMdVp4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m/WYYSKgIImPIFOYmC2LyGq2pGHfbOsldKWKaveDLcNSADN90Xa5L+V1J0dER4N0l9B+Bpo3otGTRYvzQZhJ1FI9azRwLN8xZJqF8KioX2ePz/bkCElwtQfeQfTZ7EaL0Y9WKpaw0DK41YykZprb7RKY24NAlfYht/hcl4oP0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c6R/KzEW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3626c29d3f0so3719840f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719419750; x=1720024550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4vPtzYS8MW/mrs3nz1y4FLUcW7RZm3+7QufSjVC7go=;
        b=c6R/KzEWvh47IcRZD7eR0XPer88niJP6JNZhR4xtkBGSOSDg1zDLkRCsRZnxVJD6gQ
         bFUzzQcQyL9I1kHBV7mg+sqPvprOegc5EAuJRYozMdK0sISMnPHqo2hGOp4cEvpb/3Ec
         Xw5AhttJ2xitpWwG2PiDARVj6R/L85VC5bFP/g5om9Gdo24Ektgyv+gcW4HaPmaiy/zG
         KqWdwQ60WagNbAH/EBlC1+9xtoe8E0B68i1ugfnp4nB/iLBVEGGsdryhwOBcV88A1xlX
         1rfMy0ohTI6pGn3d6WEBUGnvDWdOg/DTfreRVrBUKKi0iez4T4kmLI2zJnAkLNVPHqP+
         qTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719419750; x=1720024550;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K4vPtzYS8MW/mrs3nz1y4FLUcW7RZm3+7QufSjVC7go=;
        b=rfDJHY3z2fVD5Me22p3prvESBqnKqH8YPIpRrPZh7gw8h07CU1aUsbW1koEaI0mrcY
         vGvu1SbUoEkrac+1+SLS1qvSqxI9Dru7MG3ibH3vp0s70T1Ab3bPRn2yUHoC9b0GojhJ
         VMnLWeuALZq2UQH3u41/bOGBGQHw4p5Uztlkbo/RILgprO0GGEhZu6PW3CL0bIhx4X9K
         g+lQKJiLL++2EO4xQaAHxCqD21LHw7ohkfbPVhBcjrsiwJ14KWDuNu111UKtOP1fygK9
         KQDvueVSsp8WMdO2N5dk2Hsxs0WWk0R5N3337uMq1o4M0m+RL4DxDaD45aH6zvZtGLJU
         AgrA==
X-Gm-Message-State: AOJu0Yww6b9GD3iDGN6DLJUyFkL7V1tbc2VHhDfHGWCCPoVgl0/x2bhr
	xapHIm5FMuXohoh9OYJIHWK42kIffUQjR7n00YuZbg135RLm4nKkUFOc7Qwqet0=
X-Google-Smtp-Source: AGHT+IHHEuIwgv3xi7Vmd131rJ1KMuRCjVXd+1PHk7wkOPvuVA99Xd/83F2N0L6TEgx4ZV6IvKjssA==
X-Received: by 2002:adf:f109:0:b0:362:ed39:c1e6 with SMTP id ffacd0b85a97d-366e9629aa3mr7831177f8f.62.1719419750000;
        Wed, 26 Jun 2024 09:35:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:afc0:84d8:433a:2d67? ([2a01:e0a:982:cbb0:afc0:84d8:433a:2d67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366388c425fsm16196849f8f.38.2024.06.26.09.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:35:49 -0700 (PDT)
Message-ID: <bc622fb7-da9b-4183-916a-6f7393196aec@linaro.org>
Date: Wed, 26 Jun 2024 18:35:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/3] drm/panel: add lincolntech lcd197 support
To: Jerome Brunet <jbrunet@baylibre.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240626142212.1341556-1-jbrunet@baylibre.com>
 <20240626142212.1341556-4-jbrunet@baylibre.com>
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
In-Reply-To: <20240626142212.1341556-4-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2024 16:22, Jerome Brunet wrote:
> Add support for the Lincoln Technologies LCD197 1080x1920 DSI panel.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/gpu/drm/panel/Kconfig                 |  11 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   .../gpu/drm/panel/panel-lincolntech-lcd197.c  | 262 ++++++++++++++++++
>   3 files changed, 274 insertions(+)
>   create mode 100644 drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index bf4eadfe21cb..30206be56f68 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -328,6 +328,17 @@ config DRM_PANEL_LEADTEK_LTK500HD1829
>   	  24 bit RGB per pixel. It provides a MIPI DSI interface to
>   	  the host and has a built-in LED backlight.
>   
> +config DRM_PANEL_LINCOLNTECH_LCD197
> +	tristate "Lincoln Technologies lcd197 panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here if you want to enable support for lincolntech lcd197
> +	  TFT-LCD modules. The panel has a 1080x1920 resolution and uses
> +	  24 bit RGB per pixel. It provides a MIPI DSI interface to
> +	  the host.
> +
>   config DRM_PANEL_LG_LB035Q02
>   	tristate "LG LB035Q024573 RGB panel"
>   	depends on GPIOLIB && OF && SPI
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 051b75b3df7b..7706ff9087d8 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_DRM_PANEL_KHADAS_TS050) += panel-khadas-ts050.o
>   obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) += panel-kingdisplay-kd097d04.o
>   obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) += panel-leadtek-ltk050h3146w.o
>   obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) += panel-leadtek-ltk500hd1829.o
> +obj-$(CONFIG_DRM_PANEL_LINCOLNTECH_LCD197) += panel-lincolntech-lcd197.o
>   obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) += panel-lg-lb035q02.o
>   obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
>   obj-$(CONFIG_DRM_PANEL_LG_SW43408) += panel-lg-sw43408.o
> diff --git a/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c b/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
> new file mode 100644
> index 000000000000..032c542aab0f
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 BayLibre, SAS
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_device.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +
> +struct lincoln_lcd197_panel {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct regulator *supply;
> +	struct gpio_desc *enable_gpio;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +static inline
> +struct lincoln_lcd197_panel *to_lincoln_lcd197_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct lincoln_lcd197_panel, panel);
> +}
> +
> +static int lincoln_lcd197_panel_prepare(struct drm_panel *panel)
> +{
> +	struct lincoln_lcd197_panel *lcd = to_lincoln_lcd197_panel(panel);
> +	struct mipi_dsi_multi_context ctx = { .dsi = lcd->dsi };
> +	int err;
> +
> +	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
> +	err = regulator_enable(lcd->supply);
> +	if (err < 0)
> +		return err;
> +
> +	gpiod_set_value_cansleep(lcd->enable_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(lcd->reset_gpio, 1);
> +	usleep_range(5000, 6000);
> +	gpiod_set_value_cansleep(lcd->reset_gpio, 0);
> +	msleep(50);
> +
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb9, 0xff, 0x83, 0x99);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd2, 0x55);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0x02, 0x04, 0x70, 0x90, 0x01,
> +			       0x32, 0x33, 0x11, 0x11, 0x4d, 0x57, 0x56, 0x73,
> +			       0x02, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb2, 0x00, 0x80, 0x80, 0xae, 0x0a,
> +			       0x0e, 0x75, 0x11, 0x00, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb4, 0x00, 0xff, 0x04, 0xa4, 0x02,
> +			       0xa0, 0x00, 0x00, 0x10, 0x00, 0x00, 0x02, 0x00,
> +			       0x24, 0x02, 0x04, 0x0a, 0x21, 0x03, 0x00, 0x00,
> +			       0x08, 0xa6, 0x88, 0x04, 0xa4, 0x02, 0xa0, 0x00,
> +			       0x00, 0x10, 0x00, 0x00, 0x02, 0x00, 0x24, 0x02,
> +			       0x04, 0x0a, 0x00, 0x00, 0x08, 0xa6, 0x00, 0x08,
> +			       0x11);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd3, 0x00, 0x00, 0x00, 0x00, 0x00,
> +			       0x00, 0x18, 0x18, 0x32, 0x10, 0x09, 0x00, 0x09,
> +			       0x32, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +			       0x00, 0x00, 0x11, 0x00, 0x02, 0x02, 0x03, 0x00,
> +			       0x00, 0x00, 0x0a, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd5, 0x18, 0x18, 0x18, 0x18, 0x21,
> +			       0x20, 0x18, 0x18, 0x19, 0x19, 0x19, 0x19, 0x18,
> +			       0x18, 0x18, 0x18, 0x03, 0x02, 0x01, 0x00, 0x2f,
> +			       0x2f, 0x30, 0x30, 0x31, 0x31, 0x18, 0x18, 0x18,
> +			       0x18, 0x18, 0x18);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd6, 0x18, 0x18, 0x18, 0x18, 0x20,
> +			       0x21, 0x19, 0x19, 0x18, 0x18, 0x19, 0x19, 0x18,
> +			       0x18, 0x18, 0x18, 0x00, 0x01, 0x02, 0x03, 0x2f,
> +			       0x2f, 0x30, 0x30, 0x31, 0x31, 0x18, 0x18, 0x18,
> +			       0x18, 0x18, 0x18);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbd, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd8, 0x0a, 0xbe, 0xfa, 0xa0, 0x0a,
> +			       0xbe, 0xfa, 0xa0);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd8, 0x0f, 0xff, 0xff, 0xe0, 0x0f,
> +			       0xff, 0xff, 0xe0);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbd, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd8, 0x0f, 0xff, 0xff, 0xe0, 0x0f,
> +			       0xff, 0xff, 0xe0);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe0, 0x01, 0x11, 0x1c, 0x17, 0x39,
> +			       0x43, 0x54, 0x51, 0x5a, 0x64, 0x6c, 0x74, 0x7a,
> +			       0x83, 0x8d, 0x92, 0x99, 0xa4, 0xa9, 0xb4, 0xaa,
> +			       0xba, 0xbe, 0x63, 0x5e, 0x69, 0x73, 0x01, 0x11,
> +			       0x1c, 0x17, 0x39, 0x43, 0x54, 0x51, 0x5a, 0x64,
> +			       0x6c, 0x74, 0x7a, 0x83, 0x8d, 0x92, 0x99, 0xa4,
> +			       0xa7, 0xb2, 0xa9, 0xba, 0xbe, 0x63, 0x5e, 0x69,
> +			       0x73);
> +	mipi_dsi_usleep_range(&ctx, 200, 300);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb6, 0x92, 0x92);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcc, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbf, 0x40, 0x41, 0x50, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc6, 0xff, 0xf9);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc0, 0x25, 0x5a);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x02);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
> +	mipi_dsi_msleep(&ctx, 120);
> +
> +	if (ctx.accum_err) {
> +		gpiod_set_value_cansleep(lcd->enable_gpio, 0);
> +		gpiod_set_value_cansleep(lcd->reset_gpio, 1);
> +		regulator_disable(lcd->supply);
> +	}
> +
> +	return ctx.accum_err;
> +}
> +
> +static int lincoln_lcd197_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct lincoln_lcd197_panel *lcd = to_lincoln_lcd197_panel(panel);
> +	struct mipi_dsi_multi_context ctx = { .dsi = lcd->dsi };
> +
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
> +	mipi_dsi_usleep_range(&ctx, 5000, 6000);
> +	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
> +	gpiod_set_value_cansleep(lcd->reset_gpio, 1);
> +	regulator_disable(lcd->supply);
> +
> +	return ctx.accum_err;
> +}
> +
> +static int lincoln_lcd197_panel_enable(struct drm_panel *panel)
> +{
> +	struct lincoln_lcd197_panel *lcd = to_lincoln_lcd197_panel(panel);
> +	struct mipi_dsi_multi_context ctx = { .dsi = lcd->dsi };
> +
> +	mipi_dsi_dcs_set_display_on_multi(&ctx);
> +	mipi_dsi_msleep(&ctx, 20);
> +
> +	return ctx.accum_err;
> +}
> +
> +static int lincoln_lcd197_panel_disable(struct drm_panel *panel)
> +{
> +	struct lincoln_lcd197_panel *lcd = to_lincoln_lcd197_panel(panel);
> +	struct mipi_dsi_multi_context ctx = { .dsi = lcd->dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&ctx);
> +	mipi_dsi_msleep(&ctx, 50);
> +
> +	return ctx.accum_err;
> +}
> +
> +static const struct drm_display_mode lcd197_mode = {
> +	.clock = 154002,
> +	.hdisplay = 1080,
> +	.hsync_start = 1080 + 20,
> +	.hsync_end = 1080 + 20 + 6,
> +	.htotal = 1080 + 204,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 4,
> +	.vsync_end = 1920 + 4 + 4,
> +	.vtotal = 1920 + 79,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +	.width_mm = 79,
> +	.height_mm = 125,
> +	.type = DRM_MODE_TYPE_DRIVER,
> +};
> +
> +static int lincoln_lcd197_panel_get_modes(struct drm_panel *panel,
> +					  struct drm_connector *connector)
> +{
> +	return drm_connector_helper_get_modes_fixed(connector, &lcd197_mode);
> +}
> +
> +static const struct drm_panel_funcs lincoln_lcd197_panel_funcs = {
> +	.prepare = lincoln_lcd197_panel_prepare,
> +	.unprepare = lincoln_lcd197_panel_unprepare,
> +	.enable = lincoln_lcd197_panel_enable,
> +	.disable = lincoln_lcd197_panel_disable,
> +	.get_modes = lincoln_lcd197_panel_get_modes,
> +};
> +
> +static int lincoln_lcd197_panel_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct lincoln_lcd197_panel *lcd;
> +	struct device *dev = &dsi->dev;
> +	int err;
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = (MIPI_DSI_MODE_VIDEO |
> +			   MIPI_DSI_MODE_VIDEO_BURST);
> +
> +	lcd = devm_kzalloc(&dsi->dev, sizeof(*lcd), GFP_KERNEL);
> +	if (!lcd)
> +		return -ENOMEM;
> +
> +	mipi_dsi_set_drvdata(dsi, lcd);
> +	lcd->dsi = dsi;
> +
> +	lcd->supply = devm_regulator_get(dev, "power");
> +	if (IS_ERR(lcd->supply))
> +		return dev_err_probe(dev, PTR_ERR(lcd->supply),
> +				     "failed to get power supply");
> +
> +	lcd->enable_gpio = devm_gpiod_get(dev, "enable",
> +					  GPIOD_OUT_HIGH);
> +	if (IS_ERR(lcd->enable_gpio))
> +		return dev_err_probe(dev, PTR_ERR(lcd->enable_gpio),
> +				     "failed to get enable gpio");
> +
> +	lcd->reset_gpio = devm_gpiod_get(dev, "reset",
> +					  GPIOD_OUT_HIGH);
> +	if (IS_ERR(lcd->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(lcd->reset_gpio),
> +				     "failed to get reset gpio");
> +
> +	drm_panel_init(&lcd->panel, dev,
> +		       &lincoln_lcd197_panel_funcs, DRM_MODE_CONNECTOR_DSI);
> +
> +	err = drm_panel_of_backlight(&lcd->panel);
> +	if (err)
> +		return err;
> +
> +	drm_panel_add(&lcd->panel);
> +	err = mipi_dsi_attach(dsi);
> +	if (err)
> +		drm_panel_remove(&lcd->panel);
> +
> +	return err;
> +}
> +
> +static void lincoln_lcd197_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct lincoln_lcd197_panel *lcd = mipi_dsi_get_drvdata(dsi);
> +	int err;
> +
> +	err = mipi_dsi_detach(dsi);
> +	if (err < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
> +
> +	drm_panel_remove(&lcd->panel);
> +}
> +
> +static const struct of_device_id lincoln_lcd197_of_match[] = {
> +	{ .compatible = "lincolntech,lcd197", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, lincoln_lcd197_of_match);
> +
> +static struct mipi_dsi_driver lincoln_lcd197_panel_driver = {
> +	.driver = {
> +		.name = "panel-lincolntech-lcd197",
> +		.of_match_table = lincoln_lcd197_of_match,
> +	},
> +	.probe = lincoln_lcd197_panel_probe,
> +	.remove = lincoln_lcd197_panel_remove,
> +};
> +module_mipi_dsi_driver(lincoln_lcd197_panel_driver);
> +
> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
> +MODULE_DESCRIPTION("Lincoln Technologies LCD197 panel driver");
> +MODULE_LICENSE("GPL");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

