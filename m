Return-Path: <linux-kernel+bounces-260732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF1593AD81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3441C2224C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F561FF0;
	Wed, 24 Jul 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYwV0kl0"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A481AC4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807641; cv=none; b=lqOEmD7OMrwXZ2jzU/O6rvdRj7FVkVy1A8EnmyXfYGYy+wpy55WtmpEDWjyWWTzrQHtbmRVUMyNB7bhELi3tu3u3lHshmvYcTBnAfnATfrwQujjbQ/u737HS6Hpq/WbNpki13iUhnrCSoTVCn2mwOX/m5TPKVkYcBsqLXOQSZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807641; c=relaxed/simple;
	bh=HrypAteAGy/XTok6aN3mt/9eOnPMeF6ajXK9dY1/8p4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c/Khr8bEb8/E5DXCWd12BpW6NZAyWbAtGl0QhbMx/mVCKOt4GCCiO0EIBZIKpIJ7zWRlEwK2sjaNFk9IB4rMixED9KAK/115nAPrPkds0PEQ4V55x8R/QVo1cGq6YG3Fcj5js70XvOlcb8/nFMLl2Pbqnb9nNvr+EeRCNB+U4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tYwV0kl0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee920b0781so70775901fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721807637; x=1722412437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6XxiA8bDlv8vuRJ02SZhiMKDIku4c/DTdy0+z+J+7w=;
        b=tYwV0kl0Mj0GsrujeMq5qFU7R6W+7KY9UjEK6bbPfKuxEH8bl0+BRDskr9S/Z8Xofh
         YouZ/q6ywhRt6WvFkxBhm+H9biyGiO9tMIHX3IaAoNatE1ywMz+xIOwlhCJvgGI4D/WS
         psJRqMneWaKRYA0usqiy/tPmww9i1TMPMeQonyZRe5xoSRW0a2tMcv7EFp6B1bmCt3Ma
         XUVWlf6xNnuoTfkcXb+drRIPo1qW34KHR4DUbmhV2xgX63OUtzz84dje7FP6VB4NKD2M
         mw/3f+mmK2J/CDLsdr7Cd4XoIAkqEgtp1MxgZbkm+TnPWCKZJ4TxBKUaDJ75Qi7L4RhH
         elFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807637; x=1722412437;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g6XxiA8bDlv8vuRJ02SZhiMKDIku4c/DTdy0+z+J+7w=;
        b=J42rxiUbA6IivFJ0WQdyyHm2mEZunXbHFkjw5uBRP6TBs2bVLMbCJ5MRVMtDqqMaYd
         G59IqBYh0GsIsBYPR/sAbYM5NM3m4BHkD8WrKqjDCFfbOegbgyyvkvaLqU6yqE8/fPbm
         o1sZJnz2oCLDOpvH0P1TsoZxn7AeOMhpWYzI1Dt3e/LSPADbQmoUfA88mUmtbWhenGa2
         nREDmnzgZR09cWDhLjnnvfovIgECdffnH7s/dv3db8ADhTftMhnppBp5Eh3fDNVI3gMO
         /ZXVPKqtFyRvWJwl9oGJHzQ6jbDywbM/xWF7dHFw4W6mLO3EpbG5PZd3/c7ofPeIsN+y
         6IkA==
X-Forwarded-Encrypted: i=1; AJvYcCVmHVQcIw/a8Ih2QrKgBVmx4HZSWxGGSvXBt/Wm8M1NlHgGLz3KtjyGqYCTIbBCBsmfUvf5Vu5zvjbYm+hscKBnLSBJr4aGDDilQp7O
X-Gm-Message-State: AOJu0YxKdMYIpT5FdEPfpra/1oaP+R50z7oDbEOGzS8ArPiBZGcDYWy9
	j94A9aceZzLYv+D+MiB1PQOFgdJSuPiLw1n25Ew3Bj6g8AqBH6P1dKTPYEj5Sc8=
X-Google-Smtp-Source: AGHT+IH3RVhJiPkhqd/bqG8a3KDfnEDCCNAyJMI1TbkKhtbdBjj6Trw6bdv7DpASwnHCRQSd27HxhA==
X-Received: by 2002:a2e:87ca:0:b0:2ee:8555:4742 with SMTP id 38308e7fff4ca-2f02b741c3dmr13617521fa.27.1721807636493;
        Wed, 24 Jul 2024 00:53:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7? ([2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687869439esm13416638f8f.52.2024.07.24.00.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 00:53:56 -0700 (PDT)
Message-ID: <d41e0587-689a-47d5-9473-dc980be66650@linaro.org>
Date: Wed, 24 Jul 2024 09:53:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/5] drm/panel: st7701: Add support for SPI for
 configuration
To: Hironori KIKUCHI <kikuchan98@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20240706102338.99231-1-kikuchan98@gmail.com>
 <20240706102338.99231-5-kikuchan98@gmail.com>
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
In-Reply-To: <20240706102338.99231-5-kikuchan98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/07/2024 12:23, Hironori KIKUCHI wrote:
> The ST7701 supports not only MIPI DSI, but also SPI as an interface
> for configuration. To support a panel connected via SPI with an RGB
> parallel interface, add support for SPI using MIPI DBI helpers.
> 
> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> ---
>   drivers/gpu/drm/panel/Kconfig                 |   3 +-
>   drivers/gpu/drm/panel/panel-sitronix-st7701.c | 123 +++++++++++++++---
>   2 files changed, 110 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 2ae0eb0638f..3dd52869520 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -755,7 +755,8 @@ config DRM_PANEL_SHARP_LS060T1SX01
>   config DRM_PANEL_SITRONIX_ST7701
>   	tristate "Sitronix ST7701 panel driver"
>   	depends on OF
> -	depends on DRM_MIPI_DSI
> +	depends on SPI || DRM_MIPI_DSI
> +	select DRM_MIPI_DBI if SPI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for the Sitronix
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> index a0644f7a4c8..9e83a760a8a 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> @@ -4,6 +4,7 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> +#include <drm/drm_mipi_dbi.h>
>   #include <drm/drm_mipi_dsi.h>
>   #include <drm/drm_modes.h>
>   #include <drm/drm_panel.h>
> @@ -14,6 +15,7 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
>   
>   #include <video/mipi_display.h>
>   
> @@ -130,12 +132,16 @@ struct st7701_panel_desc {
>   struct st7701 {
>   	struct drm_panel panel;
>   	struct mipi_dsi_device *dsi;
> +	struct mipi_dbi dbi;
>   	const struct st7701_panel_desc *desc;
>   
>   	struct regulator_bulk_data supplies[2];
>   	struct gpio_desc *reset;
>   	unsigned int sleep_delay;
>   	enum drm_panel_orientation orientation;
> +
> +	int (*write_command)(struct st7701 *st7701, u8 cmd, const u8 *seq,
> +			     size_t len);
>   };
>   
>   static inline struct st7701 *panel_to_st7701(struct drm_panel *panel)
> @@ -143,16 +149,22 @@ static inline struct st7701 *panel_to_st7701(struct drm_panel *panel)
>   	return container_of(panel, struct st7701, panel);
>   }
>   
> -static inline int st7701_dsi_write(struct st7701 *st7701, const void *seq,
> -				   size_t len)
> +static int st7701_dsi_write(struct st7701 *st7701, u8 cmd, const u8 *seq,
> +			    size_t len)
>   {
> -	return mipi_dsi_dcs_write_buffer(st7701->dsi, seq, len);
> +	return mipi_dsi_dcs_write(st7701->dsi, cmd, seq, len);
>   }
>   
> -#define ST7701_WRITE(st7701, seq...)				\
> -	{							\
> -		const u8 d[] = { seq };				\
> -		st7701_dsi_write(st7701, d, ARRAY_SIZE(d));	\
> +static int st7701_dbi_write(struct st7701 *st7701, u8 cmd, const u8 *seq,
> +			    size_t len)
> +{
> +	return mipi_dbi_command_stackbuf(&st7701->dbi, cmd, seq, len);
> +}
> +
> +#define ST7701_WRITE(st7701, cmd, seq...)				\
> +	{								\
> +		const u8 d[] = { seq };					\
> +		st7701->write_command(st7701, cmd, d, ARRAY_SIZE(d));	\
>   	}
>   
>   static u8 st7701_vgls_map(struct st7701 *st7701)
> @@ -211,10 +223,10 @@ static void st7701_init_sequence(struct st7701 *st7701)
>   	/* Command2, BK0 */
>   	st7701_switch_cmd_bkx(st7701, true, 0);
>   
> -	mipi_dsi_dcs_write(st7701->dsi, ST7701_CMD2_BK0_PVGAMCTRL,
> -			   desc->pv_gamma, ARRAY_SIZE(desc->pv_gamma));
> -	mipi_dsi_dcs_write(st7701->dsi, ST7701_CMD2_BK0_NVGAMCTRL,
> -			   desc->nv_gamma, ARRAY_SIZE(desc->nv_gamma));
> +	st7701->write_command(st7701, ST7701_CMD2_BK0_PVGAMCTRL, desc->pv_gamma,
> +			      ARRAY_SIZE(desc->pv_gamma));
> +	st7701->write_command(st7701, ST7701_CMD2_BK0_NVGAMCTRL, desc->nv_gamma,
> +			      ARRAY_SIZE(desc->nv_gamma));
>   	/*
>   	 * Vertical line count configuration:
>   	 * Line[6:0]: select number of vertical lines of the TFT matrix in
> @@ -1051,6 +1063,10 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
>   
>   	st7701 = dev_get_drvdata(&dsi->dev);
>   	st7701->dsi = dsi;
> +	st7701->write_command = st7701_dsi_write;
> +
> +	if (!st7701->desc->lanes)
> +		return dev_err_probe(&dsi->dev, -EINVAL, "This panel is not for MIPI DSI\n");
>   
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>   			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
> @@ -1064,30 +1080,107 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
>   	return 0;
>   }
>   
> +static int st7701_spi_probe(struct spi_device *spi)
> +{
> +	struct st7701 *st7701;
> +	struct gpio_desc *dc;
> +	int err;
> +
> +	err = st7701_probe(&spi->dev, DRM_MODE_CONNECTOR_DPI);
> +	if (err)
> +		return err;
> +
> +	st7701 = dev_get_drvdata(&spi->dev);
> +	st7701->write_command = st7701_dbi_write;
> +
> +	dc = devm_gpiod_get_optional(&spi->dev, "dc", GPIOD_OUT_LOW);
> +	if (IS_ERR(dc))
> +		return dev_err_probe(&spi->dev, PTR_ERR(dc), "Failed to get GPIO for D/CX\n");
> +
> +	err = mipi_dbi_spi_init(spi, &st7701->dbi, dc);
> +	if (err)
> +		return dev_err_probe(&spi->dev, err, "Failed to init MIPI DBI\n");
> +	st7701->dbi.read_commands = NULL;
> +
> +	return 0;
> +}
> +
>   static void st7701_dsi_remove(struct mipi_dsi_device *dsi)
>   {
>   	mipi_dsi_detach(dsi);
>   }
>   
> -static const struct of_device_id st7701_of_match[] = {
> +static const struct of_device_id st7701_dsi_of_match[] = {
>   	{ .compatible = "anbernic,rg-arc-panel", .data = &rg_arc_desc },
>   	{ .compatible = "densitron,dmt028vghmcmi-1a", .data = &dmt028vghmcmi_1a_desc },
>   	{ .compatible = "elida,kd50t048a", .data = &kd50t048a_desc },
>   	{ .compatible = "techstar,ts8550b", .data = &ts8550b_desc },
>   	{ }
>   };
> -MODULE_DEVICE_TABLE(of, st7701_of_match);
> +MODULE_DEVICE_TABLE(of, st7701_dsi_of_match);
> +
> +static const struct of_device_id st7701_spi_of_match[] = {
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, st7701_spi_of_match);
> +
> +static const struct spi_device_id st7701_spi_ids[] = {
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(spi, st7701_spi_ids);
>   
>   static struct mipi_dsi_driver st7701_dsi_driver = {
>   	.probe		= st7701_dsi_probe,
>   	.remove		= st7701_dsi_remove,
>   	.driver = {
>   		.name		= "st7701",
> -		.of_match_table	= st7701_of_match,
> +		.of_match_table	= st7701_dsi_of_match,
>   	},
>   };
> -module_mipi_dsi_driver(st7701_dsi_driver);
> +
> +static struct spi_driver st7701_spi_driver = {
> +	.probe		= st7701_spi_probe,
> +	.id_table	= st7701_spi_ids,
> +	.driver = {
> +		.name		= "st7701",
> +		.of_match_table	= st7701_spi_of_match,
> +	},
> +};
> +
> +static int __init st7701_driver_init(void)
> +{
> +	int err;
> +
> +	if (IS_ENABLED(CONFIG_SPI)) {
> +		err = spi_register_driver(&st7701_spi_driver);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI)) {
> +		err = mipi_dsi_driver_register(&st7701_dsi_driver);
> +		if (err) {
> +			if (IS_ENABLED(CONFIG_SPI))
> +				spi_unregister_driver(&st7701_spi_driver);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +module_init(st7701_driver_init);
> +
> +static void __exit st7701_driver_exit(void)
> +{
> +	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI))
> +		mipi_dsi_driver_unregister(&st7701_dsi_driver);
> +
> +	if (IS_ENABLED(CONFIG_SPI))
> +		spi_unregister_driver(&st7701_spi_driver);
> +}
> +module_exit(st7701_driver_exit);
>   
>   MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
> +MODULE_AUTHOR("Hironori KIKUCHI <kikuchan98@gmail.com>");
>   MODULE_DESCRIPTION("Sitronix ST7701 LCD Panel Driver");
>   MODULE_LICENSE("GPL");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

