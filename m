Return-Path: <linux-kernel+bounces-337459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C9984A58
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E508F1C22E58
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41A41AC438;
	Tue, 24 Sep 2024 17:37:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D717B418
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199452; cv=none; b=lijIRR9AUxKkp9IuS7gi871baWAa91IvFp+0j7Wle1LMXopNo91TIsMKrZN2C9VYKrl14ebtpKiOvWfpcj1YOIla5TgIMAhunSF7nSK+iIpQlEky8rabq8QwXyQnFGg0qYvU6Gmd/TJv7WNnxLC+Gq1RF8F1I0vAWJKZ/gJMd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199452; c=relaxed/simple;
	bh=CqApft43dF7LllW247f0o5jAFB9bKcgbcUaNsBIHteo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmJou0mJnnXrOLBUO45E0zJBFOPRSun2LtGL1puOsNYQOkuogs3C0ssbMSMkKbPhXNntlkPglvoir2aMlt8gVBebqU/xWrwHFdZAJU2cYvf+/Y082fZMStuXzxgZzzU1oMAX9WekqnwS9k+zAiMGSmlyfzml/ZP8ZQuahJm5pLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1st9TR-0001pU-2Y; Tue, 24 Sep 2024 19:37:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1st9TO-001GDE-Kq; Tue, 24 Sep 2024 19:37:14 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1st9TO-009VGp-1h;
	Tue, 24 Sep 2024 19:37:14 +0200
Date: Tue, 24 Sep 2024 19:37:14 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Walle <mwalle@kernel.org>, devicetree@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Petr Benes <petr.benes@ysoft.com>, linux-usb@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] arm64: dts: imx: Add imx8mp-iota2-lumpy board
Message-ID: <20240924173714.qxxkhn6wscze7q5n@pengutronix.de>
References: <20240924103941.1729061-1-michal.vokac@ysoft.com>
 <20240924103941.1729061-3-michal.vokac@ysoft.com>
 <ZvLXenqG/++AR4We@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvLXenqG/++AR4We@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Frank,

On 24-09-24, Frank Li wrote:
> On Tue, Sep 24, 2024 at 12:39:41PM +0200, Michal Vokáč wrote:
> > The IOTA2 Lumpy board is based on the i.MX8MPlus EVK.
> >
> > Basic features are:
> > - 4GB LPDDR4
> > - 64GB eMMC
> > - 2x 1GB Ethernet
> > - USB 3.0 Type-C dual role port, without power delivery
> > - USB 3.0 Type-A host port
> > - RGB LED - PWM driven
> > - speaker - PWM driven
> > - RTC with super capacitor backup
> >
> > Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> > ---
> > v4:
> > - Moved the iomuxc node to the end of the file.
> > - Moved the bus-width and non-removeable properties below
> >   the pinctrl-* properties in &usdhc3 node.
> > - Moved the fsl,ext-reset-output below the pinctrl-* properties
> >   in &wdog1 node.
> > v3:
> > - Dropped pinctrl-names property from &usb_dwc3_1 node.
> > v2:
> > - Dropped unused property from pwm4 node.
> > - Sorted all nodes and properties using dt-format tool from Frank.
> >
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 423 ++++++++++++++++++
> 
> Suggest use https://github.com/lznuaa/dt-format
> sort node. any issue, let me know.

Thanks for the link :) would be nice to have this script to be part of
the kernel. The script follows the rules in [1] I'm just used to have
common properties like pinctrl-* in front of the device specific
properties e.g. "enable-active-high". But this rule is not part of [1]
so I can't blame the script.

Regards,
  Marco

[1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

> 
> Frank
> 
> >  2 files changed, 424 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 9d3df8b218a2..aa26a50b7bb4 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -171,6 +171,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> > new file mode 100644
> > index 000000000000..9eb58e818dc7
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> > @@ -0,0 +1,423 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2023 Y Soft
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx8mp.dtsi"
> > +
> > +/ {
> > +	compatible = "ysoft,imx8mp-iota2-lumpy", "fsl,imx8mp";
> > +	model = "Y Soft i.MX8MPlus IOTA2 Lumpy board";
> > +
> > +	beeper {
> > +		compatible = "pwm-beeper";
> > +		pwms = <&pwm4 0 500000 0>;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = &uart2;
> > +	};
> > +
> > +	gpio_keys: gpio-keys {
> > +		compatible = "gpio-keys";
> > +		pinctrl-0 = <&pinctrl_gpio_keys>;
> > +		pinctrl-names = "default";
> > +
> > +		button-reset {
> > +			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> > +			label = "Factory RESET";
> > +			linux,code = <BTN_0>;
> > +		};
> > +	};
> > +
> > +	reg_usb_host: regulator-usb-host {
> > +		compatible = "regulator-fixed";
> > +		enable-active-high;
> > +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-0 = <&pinctrl_usb_host_vbus>;
> > +		pinctrl-names = "default";
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-name = "usb-host";
> > +	};
> > +
> > +	memory@40000000 {
> > +		reg = <0x0 0x40000000 0 0x80000000>,
> > +		      <0x1 0x00000000 0 0x80000000>;
> > +		device_type = "memory";
> > +	};
> > +};
> > +
> > +&A53_0 {
> > +	cpu-supply = <&reg_arm>;
> > +};
> > +
> > +&A53_1 {
> > +	cpu-supply = <&reg_arm>;
> > +};
> > +
> > +&A53_2 {
> > +	cpu-supply = <&reg_arm>;
> > +};
> > +
> > +&A53_3 {
> > +	cpu-supply = <&reg_arm>;
> > +};
> > +
> > +&eqos {
> > +	phy-handle = <&ethphy0>;
> > +	phy-mode = "rgmii-id";
> > +	pinctrl-0 = <&pinctrl_eqos>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +
> > +	mdio {
> > +		compatible = "snps,dwmac-mdio";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		ethphy0: ethernet-phy@0 {
> > +			reg = <0>;
> > +			interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> > +			interrupt-parent = <&gpio3>;
> > +			micrel,led-mode = <0>;
> > +			pinctrl-0 = <&pinctrl_ethphy0>;
> > +			pinctrl-names = "default";
> > +			reset-assert-us = <1000>;
> > +			reset-deassert-us = <1000>;
> > +			reset-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> > +		};
> > +	};
> > +};
> > +
> > +&fec {
> > +	fsl,magic-packet;
> > +	phy-handle = <&ethphy1>;
> > +	phy-mode = "rgmii-id";
> > +	pinctrl-0 = <&pinctrl_fec>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +
> > +	mdio {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		ethphy1: ethernet-phy@0 {
> > +			reg = <0>;
> > +			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> > +			interrupt-parent = <&gpio3>;
> > +			micrel,led-mode = <0>;
> > +			pinctrl-0 = <&pinctrl_ethphy1>;
> > +			pinctrl-names = "default";
> > +			reset-assert-us = <1000>;
> > +			reset-deassert-us = <1000>;
> > +			reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
> > +		};
> > +	};
> > +};
> > +
> > +&i2c1 {
> > +	clock-frequency = <400000>;
> > +	pinctrl-0 = <&pinctrl_i2c1>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +
> > +	pmic@25 {
> > +		compatible = "nxp,pca9450c";
> > +		reg = <0x25>;
> > +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-parent = <&gpio1>;
> > +		pinctrl-0 = <&pinctrl_pmic>;
> > +		pinctrl-names = "default";
> > +
> > +		regulators {
> > +			BUCK1 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-max-microvolt = <1000000>;
> > +				regulator-min-microvolt = <720000>;
> > +				regulator-name = "BUCK1";
> > +				regulator-ramp-delay = <3125>;
> > +			};
> > +
> > +			reg_arm: BUCK2 {
> > +				nxp,dvs-run-voltage = <950000>;
> > +				nxp,dvs-standby-voltage = <850000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-max-microvolt = <1025000>;
> > +				regulator-min-microvolt = <720000>;
> > +				regulator-name = "BUCK2";
> > +				regulator-ramp-delay = <3125>;
> > +			};
> > +
> > +			BUCK4 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-max-microvolt = <3600000>;
> > +				regulator-min-microvolt = <3000000>;
> > +				regulator-name = "BUCK4";
> > +			};
> > +
> > +			BUCK5 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-max-microvolt = <1950000>;
> > +				regulator-min-microvolt = <1650000>;
> > +				regulator-name = "BUCK5";
> > +			};
> > +
> > +			BUCK6 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-max-microvolt = <1155000>;
> > +				regulator-min-microvolt = <1045000>;
> > +				regulator-name = "BUCK6";
> > +			};
> > +
> > +			LDO1 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-max-microvolt = <1950000>;
> > +				regulator-min-microvolt = <1650000>;
> > +				regulator-name = "LDO1";
> > +			};
> > +
> > +			LDO3 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-max-microvolt = <1890000>;
> > +				regulator-min-microvolt = <1710000>;
> > +				regulator-name = "LDO3";
> > +			};
> > +
> > +			LDO4 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-max-microvolt = <950000>;
> > +				regulator-min-microvolt = <850000>;
> > +				regulator-name = "LDO4";
> > +			};
> > +
> > +			LDO5 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-name = "LDO5";
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&i2c2 {
> > +	clock-frequency = <400000>;
> > +	pinctrl-0 = <&pinctrl_i2c2>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +
> > +	rtc: rtc@68 {
> > +		compatible = "dallas,ds1341";
> > +		reg = <0x68>;
> > +	};
> > +};
> > +
> > +&pwm4 {
> > +	pinctrl-0 = <&pinctrl_pwm4>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +};
> > +
> > +&uart2 {
> > +	pinctrl-0 = <&pinctrl_uart2>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +};
> > +
> > +&usb3_1 {
> > +	status = "okay";
> > +};
> > +
> > +&usb3_phy1 {
> > +	vbus-supply = <&reg_usb_host>;
> > +	status = "okay";
> > +};
> > +
> > +&usb_dwc3_1 {
> > +	dr_mode = "host";
> > +	status = "okay";
> > +};
> > +
> > +&usdhc3 {
> > +	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
> > +	assigned-clock-rates = <400000000>;
> > +	pinctrl-0 = <&pinctrl_usdhc3>;
> > +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> > +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +	bus-width = <8>;
> > +	non-removable;
> > +	status = "okay";
> > +};
> > +
> > +&wdog1 {
> > +	pinctrl-0 = <&pinctrl_wdog>;
> > +	pinctrl-names = "default";
> > +	fsl,ext-reset-output;
> > +	status = "okay";
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl_eqos: eqosgrp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x2
> > +			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x2
> > +			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x90
> > +			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x90
> > +			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x90
> > +			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x90
> > +			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x90
> > +			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
> > +			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x16
> > +			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x16
> > +			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x16
> > +			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x16
> > +			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x16
> > +			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
> > +		>;
> > +	};
> > +
> > +	pinctrl_ethphy0: ethphy0grp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21		0x10
> > +			MX8MP_IOMUXC_SAI5_RXD1__GPIO3_IO22		0x10
> > +		>;
> > +	};
> > +
> > +	pinctrl_ethphy1: ethphy1grp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19		0x10
> > +			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x10
> > +		>;
> > +	};
> > +
> > +	pinctrl_fec: fecgrp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x2
> > +			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x2
> > +			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x90
> > +			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x90
> > +			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x90
> > +			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x90
> > +			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x90
> > +			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x90
> > +			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x16
> > +			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x16
> > +			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x16
> > +			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x16
> > +			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x16
> > +			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x16
> > +		>;
> > +	};
> > +
> > +	pinctrl_gpio_keys: gpiokeysgrp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07	0x80
> > +		>;
> > +	};
> > +
> > +	pinctrl_i2c1: i2c1grp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2
> > +			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
> > +		>;
> > +	};
> > +
> > +	pinctrl_i2c2: i2c2grp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
> > +			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
> > +		>;
> > +	};
> > +
> > +	pinctrl_pmic: pmicgrp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x1c0
> > +		>;
> > +	};
> > +
> > +	pinctrl_pwm4: pwm4grp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x102
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart2: uart2grp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x0
> > +			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x0
> > +		>;
> > +	};
> > +
> > +	pinctrl_usb_host_vbus: usb1grp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x0
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
> > +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
> > +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
> > +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
> > +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
> > +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
> > +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
> > +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
> > +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
> > +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
> > +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
> > +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
> > +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
> > +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
> > +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
> > +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
> > +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
> > +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
> > +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
> > +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
> > +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc3: usdhc3grp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
> > +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
> > +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
> > +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
> > +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
> > +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
> > +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
> > +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
> > +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
> > +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
> > +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
> > +		>;
> > +	};
> > +
> > +	pinctrl_wdog: wdoggrp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0x166
> > +		>;
> > +	};
> > +};
> > --
> > 2.43.0
> >
> 
> 

