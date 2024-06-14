Return-Path: <linux-kernel+bounces-215336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7574F909163
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695DC1C2158A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555F319B3E6;
	Fri, 14 Jun 2024 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YVZtGXQQ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79095383
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385941; cv=none; b=YEndE+48FQZUmXC2exIoDTMaDGzfsJpFObYI+2vsK3V0qAMrOfFvbvI3D7ZJ2jXQoGjuKrf3wmj36rBN/1woxDkwRCRilafIjp7bSV8n6lcJJes8tCecbih6EDUoaDogE/+m99JdRlp/YPGd0h6msJJChJq37Cqc4vpR0QDZI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385941; c=relaxed/simple;
	bh=vBX3EwghdfFnwNNHO1PeN15fRbTpUXNPhtOQH3q95ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE+cbIUMOGTMejnt7HVu0yz6eV4dnJWZal57ncA8GQ0obUKJRhYinHATYLMoWCFxNPNFnim3z8XpGrAzIVOTAw0fz/sx3sAfcASMsslcpXsH9f1Kobc2eSDDTKo97qvG8TRJdhHdxCJLP4e9HHfZW8lVMKNbRwXOvKtt7Z9RL5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YVZtGXQQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso13482041fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718385938; x=1718990738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rFdu1CPumeDQi2PZjjILFKgaVbO5huNzucSpNz1pQA=;
        b=YVZtGXQQVmx9AQ381SYgx+VFoAvvbCoHf6RkxaWQUUkgux4Mx+Dxf8xII83PP9LWha
         fBt5VLeLeMQN8eKGP6QJCCC47fYmP/Nu9VmaR/1kpOQUcTg3w8FZBXRLjwuLRAumN59J
         Te4kNoDkJA7I+PG3JzIMobIUwr++ipYDu0xMDQFfQU7QuhlV7/S6kve0JfXlaAdIMss9
         3VJjljw5NojfW561zsNXJYqc/llEOurHtM3X5ZyC3wZN85dHFJz7qsscZLwX0pPk7hpc
         cMytOEJ5NrMPUjH1K2px5kN8xPSVIxMA4S1hFkm3kgQfLImKYmKoRSjRd0GSfXUjzOQo
         3JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718385938; x=1718990738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rFdu1CPumeDQi2PZjjILFKgaVbO5huNzucSpNz1pQA=;
        b=GqHdQ/P9Sys2UC7A59KTH/vvBx4zDS12hzSEKoKcX1GR0Z0wslWiK+mNgzEz/+FDqi
         TRqyRiotRfo6rcIBcDTLXV8mBjbXVrojrJge46ggg1S8prTl24e98Ghnq0hyVEJhA3mT
         tVSiNzNxqUgq7vD2uMG/q2XUwH55CPrE7kQR/usJPDhPVJk64oaAXyd+VkrtKMMLRbHl
         HBG3RiStmyaxEjHFXIBY4InxUs0VIs6MdXjIdBQVhqrlohtH6lqvzp5nx3pQkKumi47n
         u/R0m8bHGzLQ+OVuAA1OeSI70yC52D3MgogrkkjiCHlaJRfLFOPxReQZgh8X2WmSCQ6w
         EQYA==
X-Forwarded-Encrypted: i=1; AJvYcCXRnmSUOSUD9Xu+C98VAKgbT0z60+kAathxmU/7uz5dU8Bb1ooDk/m/UkqDl9nX+4QfdKPjMWo4sGryk3Nr9mL1IeOAxPJ8++ThoH3c
X-Gm-Message-State: AOJu0YwmvQLVd3C+81GmGZVcO1sL9LlgJ9D53QCAPPMwjSOWMBE/oivZ
	ix+z4Pz2+0/j/iswvjW3K6corE5477bh6P9xVyQCFh3FMhKTtsTGrIpu2YMEuAg=
X-Google-Smtp-Source: AGHT+IHsgFB95HA5B8ZQ8zGJgQrY4MR3DTx88Avwk5jSpFJ5uW6dOElwLz0BkS5MZ0qDg05N2PTdZg==
X-Received: by 2002:a2e:2281:0:b0:2ec:ff6:3bcc with SMTP id 38308e7fff4ca-2ec0ff64128mr17646271fa.5.1718385937443;
        Fri, 14 Jun 2024 10:25:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c89bdbsm5853501fa.110.2024.06.14.10.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:25:36 -0700 (PDT)
Date: Fri, 14 Jun 2024 20:25:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/panel: starry-er88577: add new panel driver
Message-ID: <xiv3rvzpx7l2esosggybp6pheoa4zg3ew6vnhjxewnmvkdy73o@jflkmq77lxxn>
References: <20240614145609.25432-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240614145609.25432-3-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614145609.25432-3-lvzhaoxiong@huaqin.corp-partner.google.com>

On Fri, Jun 14, 2024 at 10:56:09PM GMT, Zhaoxiong Lv wrote:
> The bias IC of this starry-er88577 panel is placed
> on the panel side, so when the panel is powered on,
> there is no need to control AVDD and AVEE in the driver,
> only 3.3v and reset are needed.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> 
> ---
> 
> Chage since V3:
> 
> -  Separate Starry-er88577 from the panel-kingdisplay-kd101ne3 driver.
> -  Use mipi_dsi_dcs_set_display_on_multi().
> -  Use mipi_dsi_dcs_exit_sleep_mode_multi() and mipi_dsi_msleep().
> 
> v2: https://lore.kernel.org/all/20240601084528.22502-5-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> Chage since V2:
> 
> -  Add compatible for Starry er88577 in panel-kingdisplay-kd101ne3 drivers.
> ---
>  drivers/gpu/drm/panel/Kconfig                |   9 +
>  drivers/gpu/drm/panel/Makefile               |   1 +
>  drivers/gpu/drm/panel/panel-starry-er88577.c | 343 +++++++++++++++++++
>  3 files changed, 353 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-starry-er88577.c
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index e54f6f5604ed..a52aa2552ab8 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -781,6 +781,15 @@ config DRM_PANEL_SITRONIX_ST7789V
>  	  Say Y here if you want to enable support for the Sitronix
>  	  ST7789V controller for 240x320 LCD panels
>  
> +config DRM_PANEL_STARRY_ER88577
> +	tristate "Starry er88577 panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y if you want to enable support for panels based on the
> +	  Starry er88577 controller.
> +
>  config DRM_PANEL_SONY_ACX565AKM
>  	tristate "Sony ACX565AKM panel"
>  	depends on GPIOLIB && OF && SPI
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index f0203f6e02f4..ecd843a6dc6e 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_DRM_PANEL_SHARP_LS060T1SX01) += panel-sharp-ls060t1sx01.o
>  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) += panel-sitronix-st7701.o
>  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
>  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
> +obj-$(CONFIG_DRM_PANEL_STARRY_ER88577) += panel-starry-er88577.o
>  obj-$(CONFIG_DRM_PANEL_SYNAPTICS_R63353) += panel-synaptics-r63353.o
>  obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
>  obj-$(CONFIG_DRM_PANEL_SONY_TD4353_JDI) += panel-sony-td4353-jdi.o
> diff --git a/drivers/gpu/drm/panel/panel-starry-er88577.c b/drivers/gpu/drm/panel/panel-starry-er88577.c
> new file mode 100644
> index 000000000000..a8250a464883
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-starry-er88577.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Panels based on the JD9365DA display controller.
> + * Author: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/mipi_display.h>
> +#include <drm/drm_probe_helper.h>
> +
> +struct starry_panel;
> +
> +struct panel_desc {
> +	const struct drm_display_mode *modes;
> +	unsigned int bpc;
> +	unsigned long mode_flags;
> +	enum mipi_dsi_pixel_format format;
> +	const struct panel_init_cmd *init_cmds;
> +	int (*init)(struct starry_panel *starry);
> +	unsigned int lanes;
> +	bool discharge_on_disable;
> +	bool lp11_before_reset;
> +	unsigned int power_off_delay_ms;
> +};
> +
> +struct starry_panel {
> +	struct drm_panel base;
> +	struct mipi_dsi_device *dsi;
> +
> +	const struct panel_desc *desc;
> +
> +	enum drm_panel_orientation orientation;
> +	struct regulator *vccio;
> +	struct gpio_desc *reset;
> +};
> +
> +static int starry_er88577_init(struct starry_panel *starry)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = starry->dsi };
> +
> +	/* T5:HWreset to init_code >= 120ms */
> +	mipi_dsi_msleep(dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0xab, 0xba);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0xba, 0xab);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb1, 0x10, 0x01, 0x47, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x0c, 0x14, 0x04, 0x50, 0x50, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3, 0x56, 0x53, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb4, 0x33, 0x30, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0xb0, 0x00, 0x00, 0x10, 0x00, 0x10, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x05, 0x12, 0x29, 0x49, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x7c, 0x61, 0x4f, 0x42, 0x3e, 0x2d, 0x31,
> +				     0x1a, 0x33, 0x33, 0x33, 0x52, 0x40, 0x47, 0x38, 0x34, 0x26,
> +				     0x0e, 0x06, 0x7c, 0x61, 0x4f, 0x42, 0x3e, 0x2d, 0x31, 0x1a,
> +				     0x33, 0x33, 0x33, 0x52, 0x40, 0x47, 0x38, 0x34, 0x26, 0x0e,
> +				     0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0xcc, 0x76, 0x12, 0x34, 0x44, 0x44, 0x44,
> +				     0x44, 0x98, 0x04, 0x98, 0x04, 0x0f, 0x00, 0x00, 0xc1);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x54, 0x94, 0x02, 0x85, 0x9f, 0x00, 0x6f,
> +				     0x00, 0x54, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x17, 0x09, 0x08, 0x89, 0x08, 0x11, 0x22,
> +				     0x20, 0x44, 0xff, 0x18, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x87, 0x47, 0x05, 0x05, 0x1c, 0x1c, 0x1d,
> +				     0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f, 0x0f, 0x0f, 0x0d, 0x0d,
> +				     0x13, 0x13, 0x11, 0x11, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x06, 0x06, 0x04, 0x04, 0x1c, 0x1c, 0x1d,
> +				     0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f, 0x0e, 0x0e, 0x0c, 0x0c,
> +				     0x12, 0x12, 0x10, 0x10, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x21, 0x00, 0x31, 0x42, 0x34, 0x16);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0xcb, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcd, 0x0e, 0x4b, 0x4b, 0x20, 0x19, 0x6b, 0x06,
> +				     0xb3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd2, 0xe3, 0x2b, 0x38, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x00, 0x01, 0x00, 0x0e, 0x04, 0x44, 0x08,
> +				     0x10, 0x00, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x80, 0x09, 0xff, 0xff, 0xff, 0xff, 0xff,
> +				     0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x12, 0x03, 0x20, 0x00, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0x00);

This looks pretty close to panel-boe-th101mb31ig002-28a.c

> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +


-- 
With best wishes
Dmitry

