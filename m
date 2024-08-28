Return-Path: <linux-kernel+bounces-304239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D438B961C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02CF1C22F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B79512E1D9;
	Wed, 28 Aug 2024 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="qVyFASO7"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D201DA32;
	Wed, 28 Aug 2024 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813887; cv=none; b=FpIGZj+cmcEQVwBACZIvYbTjOgPwU/15+tPJMx0MZ3qPkspJUZ6XurQoUa/nVeKefssFOZzH1nFoz+A+mtI0POscBRSu2a9BQ59xpltODDf0MYIF0rsfitCHq6mIzyeN2fApHJqkQWEwjs45EXf0Kl8rk0GhQaxhzTMBiHbvLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813887; c=relaxed/simple;
	bh=nPx9YdlBIXgdWgdLoqa6K+eXmsLh6srBh7jUSB+X/qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9NnRiPKfczYgoUyntZWqCreCBquR9tCGVQItCnq8eKA5LQKbC0FSzD8BDm7+gZecOyyb5GzTWYA4I93FiuxFSuz4FFNVk7dJa6/QyPkwl1dVo+91ibfT5IGH1kABNU4rWtFIkp7FqvKLWJR2Yp7hQFaEJb2vbYUPkjRS7XAgkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=qVyFASO7; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=X1RX62/7f1Qoxwc2/x4KHc50bgg8EmJbNwkklLIgkt4=;
	b=qVyFASO7G80lZkeZVrGd41ENKbt2Z8BCrHvBlROAkAxI8JCTetNz0zL5oyJlCN
	O7sJrpJ4p2gFYuk1AJTJTr7JvZXe2PLJ8dkhVi2tb74M6SjfcMRNbY1WaQjtFqWS
	vt5en2UiyWDjPakgpOGasDY9VCOy8LUwdgSqDAvfd/p7I=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDn31nqkc5mtEIOAA--.25376S3;
	Wed, 28 Aug 2024 10:56:44 +0800 (CST)
Date: Wed, 28 Aug 2024 10:56:42 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 4/4] arm64: dts: imx8mm-kontron: Add DL (Display-Line)
 overlay with LVDS support
Message-ID: <Zs6R6pqpFybPDa31@dragon>
References: <20240806133352.440922-1-frieder@fris.de>
 <20240806133352.440922-5-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806133352.440922-5-frieder@fris.de>
X-CM-TRANSID:Mc8vCgDn31nqkc5mtEIOAA--.25376S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3XF4rJr13GF1fuFWfuFyrtFb_yoWxuw48pF
	9xGws3Wr1IqrnrAas0vF1kGrn8Aw4kKw4v9w1DuFy0yrZxu3sxAFy5Krs8ursF9F4UXw4F
	vF1rZrW29wn0q3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jkYFAUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEh9JZWbOiJUoRwAAs7

On Tue, Aug 06, 2024 at 03:33:02PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The Kontron Electronics DL i.MX8MM consists of the BL i.MX8MM board
> and a 7" LVDS panel. Provide an overlay that enables the panel.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Note: This currently throws the following warnings:
> 
> Warning (graph_port): /fragment@3: graph port node name should be 'port'
> Warning (graph_endpoint): /fragment@3/__overlay__: graph endpoint node name should be 'endpoint'
> Warning (graph_endpoint): /fragment@3/__overlay__: graph connection to node '/fragment@7/__overlay__/ports/port@0/endpoint' is not bidirectional
> 
> There is the following commit in DTC that relaxes these checks and
> will eventually resolve these warnings:
> 
> 84b056a89d ("checks: relax graph checks for overlays")
> 
> https://git.kernel.org/pub/scm/utils/dtc/dtc.git/commit/?id=84b056a89d3c5b6cf6c5eeeafd4c4b14d6333aa9
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   4 +
>  .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 210 ++++++++++++++++++
>  2 files changed, 214 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index f04c22b7de72e..d8af069139920 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -244,6 +244,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>  
> +imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
> +
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
> +
>  imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
>  imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
>  imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
> new file mode 100644
> index 0000000000000..b2d593d700e2d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Kontron Electronics GmbH

2024?

> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "imx8mm-pinfunc.h"
> +
> +&{/} {
> +	compatible = "kontron,imx8mm-bl", "kontron,imx8mm-sl", "fsl,imx8mm";

Not sure we need compatible in overlay.

> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 50000 0>;
> +		brightness-levels = <0 100>;
> +		num-interpolated-steps = <100>;
> +		default-brightness-level = <100>;
> +	};
> +
> +	panel {
> +		compatible = "jenson,bl-jt60050-01a", "panel-lvds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_panel>;
> +		backlight = <&backlight>;
> +		data-mapping = "vesa-24";
> +		enable-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> +		height-mm = <86>;
> +		width-mm = <154>;
> +
> +		panel-timing {
> +			clock-frequency = <51200000>;
> +			hactive = <1024>;
> +			vactive = <600>;
> +			hsync-len = <1>;
> +			hfront-porch = <160>;
> +			hback-porch = <160>;
> +			vsync-len = <1>;
> +			vfront-porch = <12>;
> +			vback-porch = <23>;
> +		};
> +
> +		port {
> +			panel_out_bridge: endpoint {
> +				remote-endpoint = <&bridge_out_panel>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsi_mux_sel_hdmi {
> +	status = "disabled";
> +};
> +
> +&dsi_mux_sel_lvds {
> +	status = "okay";
> +};
> +
> +&dsi_out_bridge {
> +	remote-endpoint = <&bridge_in_dsi_lvds>;
> +};
> +
> +&gpio3 {
> +	panel-rst-hog {
> +		gpio-hog;
> +		gpios = <20 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "panel-reset";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_panel_rst>;

Are you sure the pinctrl in the gpio-hog node works?  Grouping these
pins as pinctrl_gpio3 in parent node (like you did in patch #3) might be
a good idea.

> +	};
> +
> +	panel-stby-hog {
> +		gpio-hog;
> +		gpios = <21 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "panel-standby";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_panel_stby>;
> +	};
> +
> +	panel-hinv-hog {
> +		gpio-hog;
> +		gpios = <24 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "panel-horizontal-invert";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_panel_hinv>;
> +	};
> +
> +	panel-vinv-hog {
> +		gpio-hog;
> +		gpios = <25 GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name = "panel-vertical-invert";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_panel_vinv>;
> +	};
> +};
> +
> +&hdmi {
> +	status = "disabled";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;

Can we move these two into property list above which ends with 'status'?

> +
> +	gt911@5d {

Can we use a generic name for the device node?

Shawn

> +		compatible = "goodix,gt928";
> +		reg = <0x5d>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touch>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <22 8>;
> +		reset-gpios = <&gpio3 23 0>;
> +		irq-gpios = <&gpio3 22 0>;
> +	};
> +};
> +
> +&lvds {
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			bridge_in_dsi_lvds: endpoint {
> +				remote-endpoint = <&dsi_out_bridge>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +
> +		port@2 {
> +			reg = <2>;
> +
> +			bridge_out_panel: endpoint {
> +				remote-endpoint = <&panel_out_bridge>;
> +			};
> +		};
> +	};
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm1>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x40000083
> +			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x40000083
> +		>;
> +	};
> +
> +	pinctrl_panel: panelgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x19
> +		>;
> +	};
> +
> +	pinctrl_panel_hinv: panelhinvgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x19
> +		>;
> +	};
> +
> +	pinctrl_panel_rst: panelrstgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x19
> +		>;
> +	};
> +
> +	pinctrl_panel_stby: panelstbygrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21		0x19
> +		>;
> +	};
> +
> +	pinctrl_panel_vinv: panelvinvgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x19
> +		>;
> +	};
> +
> +	pinctrl_pwm1: pwm1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT		0x6
> +		>;
> +	};
> +
> +	pinctrl_touch: touchgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x19
> +			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x19
> +		>;
> +	};
> +};
> -- 
> 2.45.2
> 


