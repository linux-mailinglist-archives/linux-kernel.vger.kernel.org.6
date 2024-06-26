Return-Path: <linux-kernel+bounces-231199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E099918785
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CD21C20A16
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F184318F2EE;
	Wed, 26 Jun 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzVq0lvO"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FEF18C33D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419823; cv=none; b=tX6hSoHV2GlYvMZn/mazJEJjh5wxSzCqAhYscHxqgFYPK5iNWwa7U+Nchd+wN+F+5K2xPf4Oc0lEmxP+JrFW175094XPkCwsD/ovnTULAeAGAVwgrzQpe2YDsb6StL3eyTJ/kzx3IpKrsfu4CkyUSHm6n+PmqNY/t11MMwljYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419823; c=relaxed/simple;
	bh=1dzYefEbZxhNwotNiZrOTVdYqyFuH+79IPigHWMyzys=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=d81JBYRh1fMqiLvEwFIbyqhy2hSu1w202iOdzz3xjdMKE/fz61nlheszwGbz2cVguSmO8C9OCfHrEgzxw8b5xbno3fzlvBTgjXsCTFT0BISSX3pnfMCq06I2UgWUz9EZrr+MACwxavNSjDRkGpnOxpYjtv/wcXDmQM5tTZNqXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YzVq0lvO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424f2b73629so9521755e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719419818; x=1720024618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfANfipJzykTY0n5S0AJhHW5FMcJgT1su4pZHXL0Rkg=;
        b=YzVq0lvOj7lMnnwb6xxpsHXrYCa5Ou0nSxXYe3x2OmGaHt1NFbsAe2dqMquWo5tpFd
         v58jd7+S4GQaIdT+uS5yL1lJ7/B3YpIvoQBEZ0LhzR3i0vtUktpuq7/+FvliRbZX+HNY
         3fJToauipFhlDne9qn0YOljal8Ub7yEczsfmfP1+BmYy6r8R05HR+V+eZorbTvkkEe5u
         Hh3xEPetd2+HbL6ZG0qL1YAf7BAZoJUjjd+TqF2NtvbYJCVnzRq4LLXEFB1TWEtDn7K4
         E1aroXMCSYuqvap2Ppndgsl1J+JOdoJNxg6+bMw/olFOl9ilY6SlhLR40zwlirpCj7Zi
         QAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719419818; x=1720024618;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qfANfipJzykTY0n5S0AJhHW5FMcJgT1su4pZHXL0Rkg=;
        b=RPbA41W2PDKddNpxwg6IIcuBk0vbUxH1dBqFOAv4FxpUu9VGcpTzPz3ywG1ul7MixI
         I3KuDMSbmBY9UPoVYsn3dlt3cq/cTg3D14enkU5rpdPNxFEyiR7DX+fRW/UyDxSCAurl
         KEcf6sjMZOvZMuCJ1uggAH5CaSlisyDmMgl9YidNTGTDj8EG9bHtlQxbFNc8EH1zO4ik
         ftJFFEYkIaX5i7jc70R1inKONAmVvyN4HbRSbOneC6+l7/jhBLWv1iz+xT1oA67QKHSA
         nq2DMkEAhRiB7AGAN5o0Xr7xkNP1yyxbZidcB1PfMAjWjD2V29DizL5jMaiyC3XL7MeH
         W+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXHAGz2DpDaq0qcGR1by+vGj+eAHRWQ+kOS7jX9Au5BY98Qdj1Er9+EbGaOm2SFeNCMiwqzzP+TvPrAXPh7vI83tyw+dnj2jmzCC7Ni
X-Gm-Message-State: AOJu0YzyhCv1WSGyegfFa4i9E3T1vtz/brMv1C7y7YNpxNVJNAjsCTlj
	2IhbuMCxjX2F56AhSNOX/8GlRf2JqNGrWIiYVMq5RBFW064uvnar1kywNlMZY0E=
X-Google-Smtp-Source: AGHT+IFSFO1KDfWb3TxyXl8+fTjpxVCcbEiew4gFxwompznlf9nnHvpFW8fl5yfjVPslhcguzpR9AQ==
X-Received: by 2002:a05:600c:1712:b0:425:5f73:e2e1 with SMTP id 5b1f17b1804b1-4255f73e3e8mr16302545e9.22.1719419817911;
        Wed, 26 Jun 2024 09:36:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:afc0:84d8:433a:2d67? ([2a01:e0a:982:cbb0:afc0:84d8:433a:2d67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c823c1b7sm31196985e9.10.2024.06.26.09.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:36:57 -0700 (PDT)
Message-ID: <ae3dbe39-ebd1-476f-bc6d-12dd8f173cbe@linaro.org>
Date: Wed, 26 Jun 2024 18:36:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] drm/panel: add Ilitek ILI9806E panel driver
To: Michael Walle <mwalle@kernel.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>
References: <20240626144433.3097793-1-mwalle@kernel.org>
 <20240626144433.3097793-3-mwalle@kernel.org>
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
In-Reply-To: <20240626144433.3097793-3-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2024 16:44, Michael Walle wrote:
> The Ortustech COM35H3P70ULC panel is based on the ILI9806E DSI display
> controller.
> 
> Co-developed-by: Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>
> Signed-off-by: Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>   MAINTAINERS                                   |   5 +
>   drivers/gpu/drm/panel/Kconfig                 |   9 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   drivers/gpu/drm/panel/panel-ilitek-ili9806e.c | 402 ++++++++++++++++++
>   4 files changed, 417 insertions(+)
>   create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2d8fdda1737..61352f26f2d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7003,6 +7003,11 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
>   F:	drivers/gpu/drm/panel/panel-ilitek-ili9805.c
>   
> +DRM DRIVER FOR ILITEK ILI9806E PANELS
> +M:	Michael Walle <mwalle@kernel.org>
> +S:	Maintained
> +F:	drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
> +
>   DRM DRIVER FOR JADARD JD9365DA-H3 MIPI-DSI LCD PANELS
>   M:	Jagan Teki <jagan@edgeble.ai>
>   S:	Maintained
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index bf4eadfe21cb..904a928bc60e 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -205,6 +205,15 @@ config DRM_PANEL_ILITEK_ILI9805
>   	  Say Y if you want to enable support for panels based on the
>   	  Ilitek ILI9805 controller.
>   
> +config DRM_PANEL_ILITEK_ILI9806E
> +	tristate "Ilitek ILI9806E-based panels"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y if you want to enable support for panels based on the
> +	  Ilitek ILI9806E controller.
> +
>   config DRM_PANEL_ILITEK_ILI9881C
>   	tristate "Ilitek ILI9881C-based panels"
>   	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 051b75b3df7b..12ce91416849 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) += panel-himax-hx8394.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9805) += panel-ilitek-ili9805.o
> +obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9806E) += panel-ilitek-ili9806e.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9882T) += panel-ilitek-ili9882t.o
>   obj-$(CONFIG_DRM_PANEL_INNOLUX_EJ030NA) += panel-innolux-ej030na.o
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
> new file mode 100644
> index 000000000000..e4a44cd26c4d
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
> @@ -0,0 +1,402 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#include <video/mipi_display.h>
> +
> +struct panel_desc {
> +	const struct drm_display_mode *display_mode;
> +	unsigned long mode_flags;
> +	enum mipi_dsi_pixel_format format;
> +	unsigned int lanes;
> +	void (*init_sequence)(struct mipi_dsi_multi_context *ctx);
> +};
> +
> +struct ili9806e_panel {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data supplies[2];
> +	const struct panel_desc *desc;
> +	enum drm_panel_orientation orientation;
> +};
> +
> +static const char * const regulator_names[] = {
> +	"vdd",
> +	"vccio",
> +};
> +
> +static inline struct ili9806e_panel *to_ili9806e_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct ili9806e_panel, panel);
> +}
> +
> +static int ili9806e_power_on(struct ili9806e_panel *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	int ret;
> +
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(&dsi->dev, "regulator bulk enable failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(10000, 20000);
> +	gpiod_set_value(ctx->reset_gpio, 0);
> +	usleep_range(10000, 20000);
> +
> +	return 0;
> +}
> +
> +static int ili9806e_power_off(struct ili9806e_panel *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	int ret;
> +
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +
> +	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret)
> +		dev_err(&dsi->dev, "regulator bulk disable failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int ili9806e_on(struct ili9806e_panel *ili9806e)
> +{
> +	struct mipi_dsi_multi_context ctx = { .dsi = ili9806e->dsi };
> +
> +	if (ili9806e->desc->init_sequence)
> +		ili9806e->desc->init_sequence(&ctx);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
> +	mipi_dsi_msleep(&ctx, 120);
> +	mipi_dsi_dcs_set_display_on_multi(&ctx);
> +
> +	return ctx.accum_err;
> +}
> +
> +static int ili9806e_off(struct ili9806e_panel *panel)
> +{
> +	struct mipi_dsi_multi_context ctx = { .dsi = panel->dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&ctx);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
> +	mipi_dsi_msleep(&ctx, 120);
> +
> +	return ctx.accum_err;
> +}
> +
> +static int ili9806e_prepare(struct drm_panel *panel)
> +{
> +	struct ili9806e_panel *ctx = to_ili9806e_panel(panel);
> +	int ret;
> +
> +	ret = ili9806e_power_on(ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ili9806e_on(ctx);
> +	if (ret < 0) {
> +		ili9806e_power_off(ctx);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ili9806e_unprepare(struct drm_panel *panel)
> +{
> +	struct ili9806e_panel *ctx = to_ili9806e_panel(panel);
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	int ret;
> +
> +	ili9806e_off(ctx);
> +
> +	ret = ili9806e_power_off(ctx);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "power off failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int ili9806e_get_modes(struct drm_panel *panel,
> +			      struct drm_connector *connector)
> +{
> +	struct ili9806e_panel *ctx = to_ili9806e_panel(panel);
> +	const struct drm_display_mode *mode = ctx->desc->display_mode;
> +
> +	return drm_connector_helper_get_modes_fixed(connector, mode);
> +}
> +
> +static enum drm_panel_orientation ili9806e_get_orientation(struct drm_panel *panel)
> +{
> +	struct ili9806e_panel *ctx = to_ili9806e_panel(panel);
> +
> +	return ctx->orientation;
> +}
> +
> +static const struct drm_panel_funcs ili9806e_funcs = {
> +	.prepare = ili9806e_prepare,
> +	.unprepare = ili9806e_unprepare,
> +	.get_modes = ili9806e_get_modes,
> +	.get_orientation = ili9806e_get_orientation,
> +};
> +
> +static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct ili9806e_panel *ctx;
> +	int i, ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->desc = device_get_match_data(dev);
> +
> +	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++)
> +		ctx->supplies[i].supply = regulator_names[i];
> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> +				      ctx->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get reset-gpios\n");
> +
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +	ctx->dsi = dsi;
> +
> +	dsi->mode_flags = ctx->desc->mode_flags;
> +	dsi->format = ctx->desc->format;
> +	dsi->lanes = ctx->desc->lanes;
> +
> +	drm_panel_init(&ctx->panel, dev, &ili9806e_funcs,
> +		       DRM_MODE_CONNECTOR_DSI);
> +
> +	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get orientation\n");
> +
> +	ret = drm_panel_of_backlight(&ctx->panel);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get backlight\n");
> +
> +	ctx->panel.prepare_prev_first = true;
> +	drm_panel_add(&ctx->panel);
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
> +		drm_panel_remove(&ctx->panel);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ili9806e_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct ili9806e_panel *ctx = mipi_dsi_get_drvdata(dsi);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_panel_remove(&ctx->panel);
> +}
> +
> +static void com35h3p70ulc_init(struct mipi_dsi_multi_context *ctx)
> +{
> +	/* Switch to page 1 */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0xff, 0x98, 0x06, 0x04, 0x01);
> +	/* Interface Settings */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x08, 0x18);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x21, 0x01);
> +	/* Panel Settings */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x30, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x31, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x60, 0x0d);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x61, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x62, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x63, 0x09);
> +	/* Power Control */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x40, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x41, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x42, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x43, 0x89);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x44, 0x8e);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x45, 0xd9);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x46, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x47, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x50, 0x90);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x51, 0x90);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x56, 0x00);
> +	/* Gamma Settings */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xa0, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xa1, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xa2, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xa3, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xa4, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xa5, 0x0d);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xa6, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xa7, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xa8, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xa9, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xaa, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xab, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xac, 0x12);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xad, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xae, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xaf, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc0, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc2, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc3, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc4, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc5, 0x0d);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc6, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc7, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc8, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc9, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xca, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xcb, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xcc, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xcd, 0x21);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xce, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xcf, 0x0a);
> +
> +	/* Switch to page 7 */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0xff, 0x98, 0x06, 0x04, 0x07);
> +	/* Power Control */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x06, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x18, 0x1d);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x17, 0x32);
> +
> +	/* Switch to page 6 */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0xff, 0x98, 0x06, 0x04, 0x06);
> +	/* GIP settings */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x00, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x02, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x03, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x04, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x05, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x06, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x07, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x08, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x09, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x0a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x0b, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x0c, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x0d, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x0e, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x0f, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x10, 0x55);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x11, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x12, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x13, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x14, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x15, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x16, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x17, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x18, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x19, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x1a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x1b, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x1c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x1d, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x20, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x21, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x22, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x23, 0x67);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x24, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x25, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x26, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x27, 0x67);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x30, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x31, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x32, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x33, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x34, 0xaa);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x35, 0xbb);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x36, 0x66);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x37, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x38, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x39, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x3a, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x3b, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x3c, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x3d, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x3e, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x3f, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x40, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x12);
> +
> +	/* Switch to page 0 */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0xff, 0x98, 0x06, 0x04, 0x00);
> +	/* Interface Pixel format */
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x3a, 0x60);
> +};
> +
> +static const struct drm_display_mode com35h3p70ulc_default_mode = {
> +	.clock = 22400,
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 16,
> +	.hsync_end = 480 + 16 + 16,
> +	.htotal = 480 + 16 + 16 + 16,
> +	.vdisplay = 640,
> +	.vsync_start = 640 + 52,
> +	.vsync_end = 640 + 52 + 4,
> +	.vtotal = 640 + 52 + 4 + 16,
> +	.width_mm = 53,
> +	.height_mm = 71,
> +};
> +
> +static const struct panel_desc com35h3p70ulc_desc = {
> +	.init_sequence = com35h3p70ulc_init,
> +	.display_mode = &com35h3p70ulc_default_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +		      MIPI_DSI_MODE_LPM,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.lanes = 2,
> +};
> +
> +static const struct of_device_id ili9806e_of_match[] = {
> +	{ .compatible = "ortustech,com35h3p70ulc", .data = &com35h3p70ulc_desc },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ili9806e_of_match);
> +
> +static struct mipi_dsi_driver ili9806e_dsi_driver = {
> +	.driver = {
> +		.name = "ili9806e-dsi",
> +		.of_match_table = ili9806e_of_match,
> +	},
> +	.probe = ili9806e_dsi_probe,
> +	.remove = ili9806e_dsi_remove,
> +};
> +module_mipi_dsi_driver(ili9806e_dsi_driver);
> +
> +MODULE_AUTHOR("Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>");
> +MODULE_AUTHOR("Michael Walle <mwalle@kernel.org>");
> +MODULE_DESCRIPTION("Ilitek ILI9806E Controller Driver");
> +MODULE_LICENSE("GPL");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

