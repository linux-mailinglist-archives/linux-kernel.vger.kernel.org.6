Return-Path: <linux-kernel+bounces-541268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AED5A4BABD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D897A606B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190E1F0E42;
	Mon,  3 Mar 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHtGDha5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD113C8E8;
	Mon,  3 Mar 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993980; cv=none; b=Y+n/rFqiCJmfSFtBfb4mjdkDd3TFNR0AB/kJOkPAK9iHVXRyngmPaJrlKuf0P+b8NSmHo71OY+mdWBN6m5Nz6Z74GYfR40gYgaX31NfRMXcQZjiito4PdrVXxn1/6vmWVeRg/1LIHb2mFt3pH/C+Uiq/rnmeugDayFOTw9XIDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993980; c=relaxed/simple;
	bh=m7pLdPXQWCNRenKWCOj9QGklukAUggqeQTZ/jePvJ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjAB3lxBM7hdDwt/YBr6Uk8UdEuyIYFOI0Q9tg6QJF/S9uZYSTfHVQndo2SrloC5E8S1YOQ0rm/TVjcKwF1maUr7RNqp7MY/64yAhvRqS8P5qtozNaZBKl7SbNgHLy+KAamEiMz55O3TGx/HvYJK2B4OYJcVwgM2j4aLM3D/FMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHtGDha5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44854C4CEE4;
	Mon,  3 Mar 2025 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740993980;
	bh=m7pLdPXQWCNRenKWCOj9QGklukAUggqeQTZ/jePvJ+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHtGDha5Zbwwl8eFABfT3/lOyOAPQyA941Oy3/pisGsByfKaNroKCJJdkeYMkYRYQ
	 08Qx51MIsWAIJEg5b0dI0v/VNC6bwSHJgSpV8iAVRtz6NX0FC9lVxFsAwjPs6Rs12b
	 CYVS/Gj4opkVuplXo+M1sERIWKz6zjFTEu1CVpLcPtG//Xe5YBinZT+cxoVoTQKVnR
	 JS/EMs3BKH9rVbmhQXJbsJB0sEaem/VFFFx8l6aGpF/yIUpsNpERSW301+HeqOxBAf
	 sWC3gL3o+kWCdqssPE3PvHzhy0x+SuEBE72LkIWKwx9nR0rWtZ35ZCENGkXOQOTq1w
	 MExLrwKSJzUag==
Date: Mon, 3 Mar 2025 10:26:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm: panel: Add a driver for Generic
 MIPI-DSI/DPI(+SPI) panels
Message-ID: <20250303-massive-beagle-of-authority-40bbb5@krzk-bin>
References: <20250226112552.52494-1-kikuchan98@gmail.com>
 <20250226112552.52494-4-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226112552.52494-4-kikuchan98@gmail.com>

On Wed, Feb 26, 2025 at 08:25:50PM +0900, Hironori KIKUCHI wrote:
> +
> +struct panel_firmware_header {
> +	u8 magic[15];
> +	u8 file_format_version; /* must be 1 */
> +} __packed;
> +
> +struct panel_firmware_config {
> +	u16 width_mm, height_mm;
> +	u16 rotation;
> +	u8 _reserved_1[2];
> +	u8 _reserved_2[8];
> +
> +	u16 reset_delay; /* delay after the reset command, in ms */
> +	u16 init_delay; /* delay for sending the initial command sequence, in ms */
> +	u16 sleep_delay; /* delay after the sleep command, in ms */
> +	u16 backlight_delay; /* delay for enabling the backlight, in ms */

These should be implied by compatible.

> +	u16 _reserved_3[4];
> +
> +	u16 dsi_lanes; /* unsigned int */
> +	u16 dsi_format; /* enum mipi_dsi_pixel_format */
> +	u32 dsi_mode_flags; /* unsigned long */
> +	u32 bus_flags; /* struct drm_bus_flags */
> +	u8 _reserved_4[2];
> +	u8 preferred_timing;
> +	u8 num_timings;
> +} __packed;
> +

...

> +
> +static int panel_mipi_probe(struct device *dev, int connector_type)
> +{
> +	struct panel_mipi *mipi;
> +	int err;
> +
> +	mipi = devm_kzalloc(dev, sizeof(*mipi), GFP_KERNEL);
> +	if (!mipi)
> +		return -ENOMEM;
> +
> +	mutex_init(&mipi->lock);
> +
> +	mipi->display_id = -1;
> +
> +	/* Get `power-supply` and `io-supply` (if any) */
> +	mipi->supplies[0].supply = "power";
> +	mipi->supplies[1].supply = "io";
> +	err = devm_regulator_bulk_get(dev, ARRAY_SIZE(mipi->supplies),
> +				      mipi->supplies);
> +	if (err < 0) {
> +		return dev_err_probe(dev, err,
> +				     "%pOF: Failed to get regulators\n",
> +				     dev->of_node);

Drop pOF. Device name already tells this.

> +	}
> +
> +	/* GPIO for /RESET */
> +	mipi->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(mipi->reset))
> +		return dev_err_probe(dev, PTR_ERR(mipi->reset),
> +				     "%pOF: Failed to get GPIO for RESET\n",

Drop pOF. Device name already tells this.

> +				     dev->of_node);
> +
> +	/* Load the firmware */
> +	mipi->firmware = panel_mipi_load_firmware(dev);
> +	if (IS_ERR(mipi->firmware))
> +		return dev_err_probe(dev, PTR_ERR(mipi->firmware),
> +				     "Failed to load firmware\n");
> +
> +	err = panel_mipi_read_firmware(dev, mipi, mipi->firmware);
> +	if (err)
> +		return err;
> +
> +	err = panel_mipi_probe_modes(dev, mipi);
> +	if (err)
> +		return err;
> +
> +	/* DRM panel setup */
> +	drm_panel_init(&mipi->panel, dev, &panel_mipi_funcs, connector_type);
> +
> +	err = panel_mipi_set_backlight(&mipi->panel, dev, mipi);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to set backlight\n");
> +
> +	drm_panel_add(&mipi->panel);
> +
> +	dev_set_drvdata(dev, mipi);
> +
> +	panel_mipi_debugfs_init(dev, mipi);
> +
> +	return devm_add_action_or_reset(dev, panel_mipi_cleanup, mipi);
> +}
> +
> +static int panel_mipi_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct panel_mipi *mipi;
> +	int err;
> +
> +	err = panel_mipi_probe(&dsi->dev, DRM_MODE_CONNECTOR_DSI);
> +	if (err)
> +		return err;
> +
> +	mipi = dev_get_drvdata(&dsi->dev);
> +	mipi->dsi = dsi;
> +	mipi->write_command = panel_mipi_dsi_write;
> +	mipi->read_command = panel_mipi_dsi_read;
> +
> +	/* Read from the firmware */
> +	dsi->lanes = be16_to_cpu(mipi->firmware->config->dsi_lanes);

lanes are from DT, because they are depending on how panel is wired. At
least usually.

> +	dsi->format = be16_to_cpu(mipi->firmware->config->dsi_format);
> +	dsi->mode_flags = be32_to_cpu(mipi->firmware->config->dsi_mode_flags);
> +
> +	if (!dsi->lanes)
> +		return dev_err_probe(&dsi->dev, -EINVAL,
> +				     "dsi-lanes == 0 for DSI panel\n");
> +
> +	/* Adjust bus_format */
> +	switch (dsi->format) {
> +	case MIPI_DSI_FMT_RGB888:
> +		mipi->bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
> +	case MIPI_DSI_FMT_RGB666:
> +		mipi->bus_format = MEDIA_BUS_FMT_RGB666_1X24_CPADHI;
> +		break;
> +	case MIPI_DSI_FMT_RGB666_PACKED:
> +		mipi->bus_format = MEDIA_BUS_FMT_RGB666_1X18;
> +		break;
> +	case MIPI_DSI_FMT_RGB565:
> +		mipi->bus_format = MEDIA_BUS_FMT_RGB565_1X16;
> +		break;
> +	}

Best regards,
Krzysztof


