Return-Path: <linux-kernel+bounces-238054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C509242B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E6A288B88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752BB1BD015;
	Tue,  2 Jul 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="fAd5lRVy"
Received: from mail.fris.de (unknown [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09F1BC081;
	Tue,  2 Jul 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935105; cv=none; b=j6Dylii6rFs3rsTYp530HbdyfQZ2zNXdYEpP7eIvApxq9o21/lYR+LWAKXJSzrgy8k7tpKEYKcNhdIal1/tveznqsNWK83WGfvJchZoaeZuXrXMwQ+MN4OWNEKaLQB2sslLeOXpfCe4+WovADoUtjVI4WGF/Ca8Z/IBqH4msu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935105; c=relaxed/simple;
	bh=cOXNJdUyP0/HM/aVEfis/jWm9jRsqHNAy67O7qQu1gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgDpXdB+OlSnZYajw4d2iiV3Shv8Vs7fJCcFqpFdXiqm7iU8N3xqOIbivCU3Tlw2urWpG8I4KUHOjRf5zdn9uYd2pGTYYXQmBSNg1jakASftUA2fhfNRVQ0Vi5Y9xoMeNL0VfAGMrnCPNc8+/XWbYYKxU3dKVFgE3E9MD5YNGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=fAd5lRVy; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A28B8BFB30;
	Tue,  2 Jul 2024 17:44:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1719935100; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LrbdLhg7bH+ODgABkP+wn1j5z+2j71mYb6i04ALSnmI=;
	b=fAd5lRVysPWnO5ZfOy5sj/ydoecv3SihKA05y/MT/2MlDGUBcGREJ6uQwcT8FN3Tr57oMs
	72rMWfVvxHLKstY45fymgb8Nfap5nMs5naLlDtn1vwEWfgayr3T2bd9Mt6DeCoxWDyVfWe
	MCsmSyKa6nRT8qGphmHZ8N/NL24tkb3YLgH4g2bSETvjkG1hrcpvX+5lK6xMjw6DvE8nnA
	Vnr3E1LrhZsx3f9D1fzGQ+fZ120xeFVwSgh94vTDwNLKpWQnJesa3rMUWExgaPXas9HJfV
	h0NXNp51g+X5jM651EjWkWrHTm4/HZmxhXwYeo9ULBmwQLHxme29JhoUBP9CSw==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Fabio Estevam <festevam@gmail.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/3] arm64: dts: Add support for Kontron OSM-S i.MX8MP SoM and BL carrier board
Date: Tue,  2 Jul 2024 17:43:20 +0200
Message-ID: <20240702154413.968044-3-frieder@fris.de>
In-Reply-To: <20240702154413.968044-1-frieder@fris.de>
References: <20240702154413.968044-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This adds support for the Kontron Electronics OSM-S i.MX8MP SoM
and the matching baseboard BL i.MX8MP.

The SoM hardware complies to the Open Standard Module (OSM) 1.1
specification, size S (https://sget.org/standards/osm).

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/Makefile        |   5 +
 .../dts/freescale/imx8mp-kontron-bl-osm-s.dts | 307 ++++++
 .../boot/dts/freescale/imx8mp-kontron-dl.dtso | 112 +++
 .../dts/freescale/imx8mp-kontron-osm-s.dtsi   | 908 ++++++++++++++++++
 4 files changed, 1332 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index bd443c2bc5a48..8688a85ba5a44 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -170,6 +170,11 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-bl-osm-s.dtb
+
+imx8mp-kontron-dl-dtbs += imx8mp-kontron-bl-osm-s.dtb imx8mp-kontron-dl.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-dl.dtb
+
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
new file mode 100644
index 0000000000000..8fda582d12b4b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2022 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mp-kontron-osm-s.dtsi"
+
+/ {
+	model = "Kontron BL i.MX8MP OSM-S";
+	compatible = "kontron,imx8mp-bl-osm-s", "kontron,imx8mp-osm-s", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+	};
+
+	extcon_usbc: usbc {
+		compatible = "linux,extcon-usb-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb1_id>;
+		id-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	pwm-beeper {
+		compatible = "pwm-beeper";
+		pwms = <&pwm2 0 5000 0>;
+	};
+
+	reg_vcc_panel: regulator-vcc-panel {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VCC_PANEL";
+	};
+};
+
+&ecspi2 {
+	status = "okay";
+
+	eeram@0 {
+		compatible = "microchip,48l640";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&eqos {	/* Second ethernet (OSM-S ETH_B) */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos_rgmii>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-id4f51.e91b";
+			reg = <1>;
+			pinctrl-0 = <&pinctrl_ethphy1>;
+			pinctrl-names = "default";
+			reset-assert-us = <10000>;
+			reset-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&fec { /* First ethernet (OSM-S ETH_A) */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_rgmii>;
+	phy-connection-type = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-id4f51.e91b";
+			reg = <1>;
+			pinctrl-0 = <&pinctrl_ethphy0>;
+			pinctrl-names = "default";
+			reset-assert-us = <10000>;
+			reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&flexcan1 {
+	status = "okay";
+};
+
+/*
+ * Rename SoM signals according to board usage:
+ *   SDIO_A_PWR_EN -> CAN_ADDR2
+ *   SDIO_A_WP     -> CAN_ADDR3
+ */
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio2>;
+	gpio-line-names = "", "", "", "", "", "", "", "", "", "", "", "",
+			  "SDIO_A_CD", "SDIO_A_CLK", "SDIO_A_CMD", "SDIO_A_D0",
+			  "SDIO_A_D1", "SDIO_A_D2", "SDIO_A_D3", "CAN_ADDR2",
+			  "CAN_ADDR3";
+};
+
+/*
+ * Rename SoM signals according to board usage:
+ *   SPI_A_WP      -> CAN_ADDR0
+ *   SPI_A_HOLD    -> CAN_ADDR1
+ *   GPIO_B_0      -> DIO1_OUT
+ *   GPIO_B_1      -> DIO2_OUT
+ */
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio3>;
+	gpio-line-names = "PCIE_WAKE", "PCIE_CLKREQ", "PCIE_A_PERST", "SDIO_B_D5",
+			  "SDIO_B_D6", "SDIO_B_D7", "CAN_ADDR0", "CAN_ADDR1",
+			  "UART_B_RTS", "UART_B_CTS", "SDIO_B_D0", "SDIO_B_D1",
+			  "SDIO_B_D2", "SDIO_B_D3", "SDIO_B_WP", "SDIO_B_D4",
+			  "PCIE_SM_ALERT", "SDIO_B_CLK", "SDIO_B_CMD", "DIO1_OUT",
+			  "DIO2_OUT", "", "BOOT_SEL0", "BOOT_SEL1",
+			  "", "", "SDIO_B_CD", "SDIO_B_PWR_EN",
+			  "HDMI_CEC", "HDMI_HPD";
+};
+
+/*
+ * Rename SoM signals according to board usage:
+ *   GPIO_B_5      -> DIO2_IN
+ *   GPIO_B_6      -> DIO3_IN
+ *   GPIO_B_7      -> DIO4_IN
+ *   GPIO_B_3      -> DIO4_OUT
+ *   GPIO_B_4      -> DIO1_IN
+ *   GPIO_B_2      -> DIO3_OUT
+ */
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio4>;
+	gpio-line-names = "DIO2_IN", "DIO3_IN", "DIO4_IN", "GPIO_C_0",
+			  "ETH_A_MDC", "ETH_A_MDIO", "ETH_A_RXD0", "ETH_A_RXD1",
+			  "ETH_A_RXD2", "ETH_A_RXD3", "ETH_A_RX_DV", "ETH_A_RX_CLK",
+			  "ETH_A_TXD0", "ETH_A_TXD1", "ETH_A_TXD2", "ETH_A_TXD3",
+			  "ETH_A_TX_EN", "ETH_A_TX_CLK", "DIO4_OUT", "DIO1_IN",
+			  "DIO3_OUT", "GPIO_A_6", "CAN_A_TX", "UART_A_CTS",
+			  "UART_A_RTS", "CAN_A_RX", "CAN_B_TX", "CAN_B_RX",
+			  "GPIO_A_7", "CARRIER_PWR_EN", "I2S_A_DATA_IN", "I2S_LRCLK";
+};
+
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	ddc-i2c-bus = <&i2c4>;
+	status = "okay";
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	gpio_expander_dio: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "DIO1_OUT","DIO1_IN", "DIO2_OUT","DIO2_IN",
+				  "DIO3_OUT","DIO3_IN", "DIO4_OUT","DIO4_IN";
+		interrupt-parent = <&gpio3>;
+		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&lcdif3 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&reg_usdhc2_vcc {
+	status = "disabled";
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&uart1 {
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart4 {
+	linux,rs485-enabled-at-boot-time;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	adp-disable;
+	hnp-disable;
+	srp-disable;
+
+	dr_mode = "otg";
+	extcon = <&extcon_usbc>;
+	usb-role-switch;
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_hub>;
+	dr_mode = "host";
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usb1@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		reset-gpios = <&gpio3 14 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_1 {
+	fsl,disable-port-power-control;
+	fsl,permanently-attached;
+	status = "okay";
+};
+
+&usb3_phy0 {
+	vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	vmmc-supply = <&reg_vdd_3v3>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_ethphy0: ethphy0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01		0x46
+		>;
+	};
+
+	pinctrl_ethphy1: ethphy1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO00__GPIO1_IO00		0x46
+		>;
+	};
+
+	pinctrl_gpio2: gpio2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x46
+			MX8MP_IOMUXC_SD2_WP__GPIO2_IO20			0x46
+		>;
+	};
+
+	pinctrl_usb_hub: usbhubgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14		0x46
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
new file mode 100644
index 0000000000000..f2f2f07f9b4f7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2023 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "imx8mp-pinfunc.h"
+
+&{/} {
+	model = "Kontron DL i.MX8MP OSM-S";
+	compatible = "kontron,imx8mp-dl-osm-s", "kontron,imx8mp-bl-osm-s", "kontron,imx8mp-osm-s",
+		     "fsl,imx8mp";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 50000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <100>;
+	};
+
+	panel {
+		compatible = "panel-lvds";
+		width-mm = <154>;
+		height-mm = <86>;
+		data-mapping = "vesa-24";
+		backlight = <&backlight>;
+		enable-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_vcc_panel>;
+
+		panel-timing {
+			clock-frequency = <50000000>;
+			hactive = <1024>;
+			hback-porch = <80>;
+			hfront-porch = <40>;
+			hsync-len = <40>;
+			vactive = <600>;
+			vback-porch = <10>;
+			vfront-porch = <3>;
+			vsync-len = <10>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <0>;
+		};
+
+		port {
+			panel_in_lvds0: endpoint {
+				remote-endpoint = <&ldb_lvds_ch0>;
+			};
+		};
+	};
+};
+
+&gpio4 {
+	panel_rst {
+		gpio-hog;
+		gpios = <21 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "panel-reset";
+	};
+
+	panel_stby {
+		gpio-hog;
+		gpios = <28 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "panel-standby";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel_stby>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	gt911@5d {
+		compatible = "goodix,gt928";
+		reg = <0x5d>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <6 8>;
+		irq-gpios = <&gpio1 6 0>;
+		power-supply = <&reg_vcc_panel>;
+		reset-gpios = <&gpio1 7 0>;
+	};
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&ldb_lvds_ch0 {
+	remote-endpoint = <&panel_in_lvds0>;
+};
+
+&lvds_bridge {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_panel_stby: panelstbygrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28		0x19
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi
new file mode 100644
index 0000000000000..892710e4f9d1b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi
@@ -0,0 +1,908 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2022 Kontron Electronics GmbH
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx8mp.dtsi"
+
+/ {
+	model = "Kontron OSM-S i.MX8MP";
+	compatible = "kontron,imx8mp-osm-s", "fsl,imx8mp";
+
+	aliases {
+		rtc0 = &rv3028;
+		rtc1 = &snvs_rtc;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/*
+		 * There are multiple SoM flavors with different DDR sizes.
+		 * The smallest is 1GB. For larger sizes the bootloader will
+		 * update the reg property.
+		 */
+		reg = <0x0 0x40000000 0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb1_vbus>;
+		enable-active-high;
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "VBUS_USB_A";
+	};
+
+	reg_usb2_vbus: regulator-usb2-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb2_vbus>;
+		enable-active-high;
+		gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "VBUS_USB_B";
+	};
+
+	reg_usdhc2_vcc: regulator-usdhc2-vcc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vcc>;
+		enable-active-high;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "VCC_SDIO_A";
+	};
+
+	reg_usdhc3_vcc: regulator-usdhc3-vcc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc3_vcc>;
+		enable-active-high;
+		gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "VCC_SDIO_B";
+	};
+
+	reg_vdd_carrier: regulator-vdd-carrier {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_vdd_carrier>;
+		enable-active-high;
+		gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "VDD_CARRIER";
+
+		regulator-state-standby {
+			regulator-on-in-suspend;
+		};
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+
+		regulator-state-disk {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&ecspi1 { /* OSM-S SPI_A */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+};
+
+&ecspi2 { /* OSM-S SPI_B */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+};
+
+&flexcan1 { /* OSM-S CAN_A */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+};
+
+&flexcan2 { /* OSM-S CAN_B */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+};
+
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio1>;
+	gpio-line-names = "GPIO_A_0", "GPIO_A_1", "", "",
+			  "", "GPIO_A_2", "GPIO_A_3", "GPIO_A_4",
+			  "GPIO_A_5", "USB_B_EN", "USB_A_ID", "USB_B_ID",
+			  "USB_A_EN", "USB_A_OC","CAM_MCK", "USB_B_OC",
+			  "ETH_B_MDC", "ETH_B_MDIO", "ETH_B_TXD3", "ETH_B_TXD2",
+			  "ETH_B_TXD1", "ETH_B_TXD0", "ETH_B_TX_EN", "ETH_B_TX_CLK",
+			  "ETH_B_RX_DV", "ETH_B_RX_CLK", "ETH_B_RXD0", "ETH_B_RXD1",
+			  "ETH_B_RXD2", "ETH_B_RXD3";
+};
+
+&gpio2 {
+	gpio-line-names = "", "", "", "", "", "", "", "", "", "", "", "",
+			  "SDIO_A_CD", "SDIO_A_CLK", "SDIO_A_CMD", "SDIO_A_D0",
+			  "SDIO_A_D1", "SDIO_A_D2", "SDIO_A_D3", "SDIO_A_PWR_EN",
+			  "SDIO_A_WP";
+};
+
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio3>;
+	gpio-line-names = "PCIE_WAKE", "PCIE_CLKREQ", "PCIE_A_PERST", "SDIO_B_D5",
+			  "SDIO_B_D6", "SDIO_B_D7", "SPI_A_WP", "SPI_A_HOLD",
+			  "UART_B_RTS", "UART_B_CTS", "SDIO_B_D0", "SDIO_B_D1",
+			  "SDIO_B_D2", "SDIO_B_D3", "SDIO_B_WP", "SDIO_B_D4",
+			  "PCIE_SM_ALERT", "SDIO_B_CLK", "SDIO_B_CMD", "GPIO_B_0",
+			  "GPIO_B_1", "", "BOOT_SEL0", "BOOT_SEL1",
+			  "", "", "SDIO_B_CD", "SDIO_B_PWR_EN",
+			  "HDMI_CEC", "HDMI_HPD";
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio4>;
+	gpio-line-names = "GPIO_B_5", "GPIO_B_6", "GPIO_B_7", "GPIO_C_0",
+			  "ETH_A_MDC", "ETH_A_MDIO", "ETH_A_RXD0", "ETH_A_RXD1",
+			  "ETH_A_RXD2", "ETH_A_RXD3", "ETH_A_RX_DV", "ETH_A_RX_CLK",
+			  "ETH_A_TXD0", "ETH_A_TXD1", "ETH_A_TXD2", "ETH_A_TXD3",
+			  "ETH_A_TX_EN", "ETH_A_TX_CLK", "GPIO_B_3", "GPIO_B_4",
+			  "GPIO_B_2", "GPIO_A_6", "CAN_A_TX", "UART_A_CTS",
+			  "UART_A_RTS", "CAN_A_RX", "CAN_B_TX", "CAN_B_RX",
+			  "GPIO_A_7", "CARRIER_PWR_EN", "I2S_A_DATA_IN", "I2S_LRCLK";
+};
+
+&gpio5 {
+	gpio-line-names = "I2S_BITCLK", "I2S_A_DATA_OUT", "I2S_MCLK", "PWM_2",
+			  "PWM_1", "PWM_0", "SPI_A_SCK", "SPI_A_SDO",
+			  "SPI_A_SDI", "SPI_A_CS0", "SPI_B_SCK", "SPI_B_SDO",
+			  "SPI_B_SDI", "SPI_B_CS0", "I2C_A_SCL", "I2C_A_SDA",
+			  "I2C_B_SCL", "I2C_B_SDA", "PCIE_SMCLK", "PCIE_SMDAT",
+			  "I2C_CAM_SCL", "I2C_CAM_SDA", "UART_A_RX", "UART_A_TX",
+			  "UART_C_RX", "UART_C_TX", "UART_CON_RX", "UART_CON_TX",
+			  "UART_B_RX", "UART_B_TX";
+};
+
+&i2c1 { /* OSM-S I2C_A */
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c2 { /* OSM-S I2C_B */
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c3 { /* OSM-S PCIe SMDAT/SMCLK */
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c4 { /* OSM-S I2C_CAM */
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c5 { /* PMIC, EEPROM, RTC */
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c5>;
+	pinctrl-1 = <&pinctrl_i2c5_gpio>;
+	scl-gpios = <&gpio3 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio3 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	pca9450: pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		nxp,i2c-lt-enable;
+
+		regulators {
+			reg_vdd_soc: BUCK1 { /* dual phase with BUCK3 */
+				regulator-name = "+0V8_VDD_SOC (BUCK1)";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			reg_vdd_arm: BUCK2 {
+				regulator-name = "+0V9_VDD_ARM (BUCK2)";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			reg_vdd_3v3: BUCK4 {
+				regulator-name = "+3V3 (BUCK4)";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdd_1v8: BUCK5 {
+				regulator-name = "+1V8 (BUCK5)";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_dram: BUCK6 {
+				regulator-name = "+1V1_NVCC_DRAM (BUCK6)";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_snvs: LDO1 {
+				regulator-name = "+1V8_NVCC_SNVS (LDO1)";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdda: LDO3 {
+				regulator-name = "+1V8_VDDA (LDO3)";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_sd: LDO5 {
+				regulator-name = "NVCC_SD (LDO5)";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+
+	eeprom@50 {
+		compatible = "onnn,n24s64b", "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <32>;
+		size = <8192>;
+		num-addresses = <1>;
+	};
+
+	rv3028: rtc@52 {
+		compatible = "microcrystal,rv3028";
+		reg = <0x52>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupts-extended = <&gpio3 24 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&pwm1 { /* OSM-S PWM_0 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+};
+
+&pwm2 { /* OSM-S PWM_1 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+};
+
+&pwm3 { /* OSM-S PWM_2 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+};
+
+&sai3 { /* OSM-S I2S_A */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+};
+
+&uart1 { /* OSM-S UART_A */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+&uart2 { /* OSM-S UART_C */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+};
+
+&uart3 { /* OSM-S UART_CON */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&uart4 { /* OSM-S UART_B */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+};
+
+&usb3_0 { /* OSM-S USB_A */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1_oc>;
+	fsl,over-current-active-low;
+};
+
+&usb3_1 { /* OSM-S USB_B */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2_oc>;
+	fsl,over-current-active-low;
+};
+
+&usdhc1 { /* eMMC */
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	vmmc-supply = <&reg_vdd_3v3>;
+	vqmmc-supply = <&reg_vdd_1v8>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 { /* OSM-S SDIO_A */
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>, <&pinctrl_usdhc2_wp>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>, <&pinctrl_usdhc2_wp>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>, <&pinctrl_usdhc2_wp>;
+	vmmc-supply = <&reg_usdhc2_vcc>;
+	vqmmc-supply = <&reg_nvcc_sd>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+};
+
+&usdhc3 { /* OSM-S SDIO_B */
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_usdhc3_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>, <&pinctrl_usdhc3_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>, <&pinctrl_usdhc3_gpio>;
+	vmmc-supply = <&reg_usdhc3_vcc>;
+	vqmmc-supply = <&reg_nvcc_sd>;
+	cd-gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_csi_mck: csimckgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__CCM_CLKO1		0x59 /* CAM_MCK */
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO		0x44 /* SPI_A_SDI_(IO0) */
+			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI		0x44 /* SPI_A_SDO_(IO1) */
+			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK		0x44 /* SPI_A_SCK */
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09		0x40 /* SPI_A_CS0# */
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x44 /* SPI_B_SDI */
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x44 /* SPI_B_SDO */
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x44 /* SPI_B_SCK */
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13		0x40 /* SPI_B_CS0# */
+		>;
+	};
+
+	pinctrl_enet_rgmii: enetrgmiigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3 /* ETH_MDC */
+			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3 /* ETH_MDIO */
+			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91 /* ETH_A_(S)(R)(G)MII_RXD0 */
+			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91 /* ETH_A_(S)(R)(G)MII_RXD1 */
+			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x91 /* ETH_A_(R)(G)MII_RXD2 */
+			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x91 /* ETH_A_(R)(G)MII_RXD3 */
+			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91 /* ETH_A_(R)(G)MII_RX_CLK */
+			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91 /* ETH_A_(R)(G)MII_RX_DV(_ER) */
+			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x1f /* ETH_A_(S)(R)(G)MII_TXD0 */
+			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x1f /* ETH_A_(S)(R)(G)MII_TXD1 */
+			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x1f /* ETH_A_(S)(R)(G)MII_TXD2 */
+			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x1f /* ETH_A_(S)(R)(G)MII_TXD3 */
+			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x1f /* ETH_A_(R)(G)MII_TX_CLK */
+			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f /* ETH_A_(R)(G)MII_TX_EN(_ER) */
+		>;
+	};
+
+	pinctrl_eqos_rgmii: eqosrgmiigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x3 /* ETH_B_MDC */
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x3 /* ETH_B_MDIO */
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x91 /* ETH_B_(S)(R)(G)MII_RXD0 */
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x91 /* ETH_B_(S)(R)(G)MII_RXD1 */
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x91 /* ETH_B_(R)(G)MII_RXD2 */
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x91 /* ETH_B_(R)(G)MII_RXD3 */
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK 0x91 /* ETH_B_(R)(G)MII_RX_CLK */
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x91 /* ETH_B_(R)(G)MII_RX_DV(_ER) */
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x1f /* ETH_B_(S)(R)(G)MII_TXD0 */
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x1f /* ETH_B_(S)(R)(G)MII_TXD1 */
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x1f /* ETH_B_(S)(R)(G)MII_TXD2 */
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x1f /* ETH_B_(S)(R)(G)MII_TXD3 */
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK 0x1f /* ETH_B_(R)(G)MII_TX_CLK */
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x1f /* ETH_B_(R)(G)MII_TX_EN(_ER) */
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXC__CAN1_TX			0x154 /* CAN_A_TX */
+			MX8MP_IOMUXC_SAI2_TXC__CAN1_RX			0x154 /* CAN_A_RX */
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_TXD0__CAN2_TX			0x154 /* CAN_B_TX */
+			MX8MP_IOMUXC_SAI2_MCLK__CAN2_RX			0x154 /* CAN_B_RX */
+		>;
+	};
+
+	pinctrl_gpio1: gpio1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO00__GPIO1_IO00		0x19 /* GPIO_A_0 */
+			MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01		0x19 /* GPIO_A_1 */
+			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x19 /* GPIO_A_2 */
+			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x19 /* GPIO_A_3 */
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x19 /* GPIO_A_4 */
+			MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08		0x19 /* GPIO_A_5 */
+		>;
+	};
+
+	pinctrl_gpio3: gpio3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE0_B__GPIO3_IO01		0x19 /* GPIO_A_7 */
+			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19		0x19 /* GPIO_B_0 */
+			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x19 /* GPIO_B_1 */
+			MX8MP_IOMUXC_SAI5_RXD1__GPIO3_IO22		0x19 /* BOOT_SEL0# */
+			MX8MP_IOMUXC_SAI5_RXD2__GPIO3_IO23		0x19 /* BOOT_SEL1# */
+		>;
+	};
+
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00		0x19 /* GPIO_B_5 */
+			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01		0x19 /* GPIO_B_6 */
+			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x19 /* GPIO_B_7 */
+			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03		0x19 /* GPIO_C_0 */
+			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18		0x19 /* GPIO_B_3 */
+			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19		0x19 /* GPIO_B_4 */
+			MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20		0x19 /* GPIO_B_2 */
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21		0x19 /* GPIO_A_6 */
+		>;
+	};
+
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x19 /* HDMI_HPD */
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL			0x40000084 /* I2C_A_SCL */
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA			0x40000084 /* I2C_A_SDA */
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14		0x84 /* I2C_A_SCL */
+			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15		0x84 /* I2C_A_SDA */
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL			0x40000084 /* I2C_B_SCL */
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA			0x40000084 /* I2C_B_SDA */
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16		0x84 /* I2C_B_SCL */
+			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17		0x84 /* I2C_B_SDA */
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL			0x40000084 /* PCIe_SMCLK */
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA			0x40000084 /* PCIe_SMDAT */
+		>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18		0x84 /* PCIe_SMCLK */
+			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19		0x84 /* PCIe_SMDAT */
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL			0x40000084 /* I2C_CAM_SCL/CSI_TX_P */
+			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA			0x40000084 /* I2C_CAM_SDA/CSI_TX_N */
+		>;
+	};
+
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20		0x84 /* I2C_CAM_SCL/CSI_TX_P */
+			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21		0x84 /* I2C_CAM_SDA/CSI_TX_N */
+		>;
+	};
+
+	pinctrl_i2c5: i2c5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD0__I2C5_SCL		0x40000084
+			MX8MP_IOMUXC_SAI5_MCLK__I2C5_SDA		0x40000084
+		>;
+	};
+
+	pinctrl_i2c5_gpio: i2c5gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21		0x84
+			MX8MP_IOMUXC_SAI5_MCLK__GPIO3_IO25		0x84
+		>;
+	};
+
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART4_RXD__PCIE_CLKREQ_B		0x19 /* PCIe_CLKREQ# */
+			MX8MP_IOMUXC_NAND_CE1_B__GPIO3_IO02		0x19 /* PCIe_A_PERST# */
+			MX8MP_IOMUXC_NAND_ALE__GPIO3_IO00		0x19 /* PCIe_WAKE# */
+			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16		0x19 /* PCIe_SM_ALERT */
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x1c0
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__PWM1_OUT		0x6 /* PWM_0 */
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__PWM2_OUT			0x6 /* PWM_1 */
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_TX__PWM3_OUT			0x6 /* PWM_2 */
+		>;
+	};
+
+	pinctrl_reg_usb1_vbus: regusb1vbusgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x19 /* USB_A_EN */
+		>;
+	};
+
+	pinctrl_reg_usb2_vbus: regusb2vbusgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09		0x19 /* USB_B_EN */
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vcc: regusdhc2vccgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x19 /* SDIO_A_PWR_EN */
+		>;
+	};
+
+	pinctrl_reg_usdhc3_vcc: regusdhc3vccgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SDA__GPIO3_IO27		0x19 /* SDIO_B_PWR_EN */
+		>;
+	};
+
+	pinctrl_reg_vdd_carrier: regvddcarriergrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29		0x19 /* CARRIER_PWR_EN */
+		>;
+	};
+
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD3__GPIO3_IO24		0x1c0
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00		0xd6 /* I2S_A_DATA_IN */
+			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00		0xd6 /* I2S_A_DATA_OUT */
+			MX8MP_IOMUXC_SAI3_RXFS__AUDIOMIX_SAI3_RX_DATA01		0xd6 /* I2S_B_DATA_IN */
+			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_DATA01		0xd6 /* I2S_B_DATA_OUT */
+			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK		0xd6 /* I2S_MCLK */
+			MX8MP_IOMUXC_NAND_DATA01__AUDIOMIX_SAI3_TX_SYNC		0xd6 /* I2S_LRCLK */
+			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK		0xd6 /* I2S_BITCLK */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX		0x140 /* UART_A_RX */
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX		0x140 /* UART_A_TX */
+			MX8MP_IOMUXC_SAI2_RXD0__UART1_DCE_RTS		0x140 /* UART_A_CTS */
+			MX8MP_IOMUXC_SAI2_TXFS__UART1_DCE_CTS		0x140 /* UART_A_RTS */
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX		0x140 /* UART_C_RX */
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX		0x140 /* UART_C_TX */
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX		0x140 /* UART_CON_RX */
+			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX		0x140 /* UART_CON_TX */
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_DATA00__UART4_DCE_RX		0x140 /* UART_B_RX */
+			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX		0x140 /* UART_B_TX */
+			MX8MP_IOMUXC_NAND_DATA03__UART4_DCE_RTS		0x140 /* UART_B_CTS */
+			MX8MP_IOMUXC_NAND_DATA02__UART4_DCE_CTS		0x140 /* UART_B_RTS */
+		>;
+	};
+
+	pinctrl_usb1_id: usb1idgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x1c4 /* USB_A_ID */
+		>;
+	};
+
+	pinctrl_usb1_oc: usb1ocgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO13__USB1_OTG_OC		0x1c0 /* USB_A_OC# */
+		>;
+	};
+
+	pinctrl_usb2_id: usb2idgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO11__USB2_OTG_ID		0x1c4 /* USB_B_ID */
+		>;
+	};
+
+	pinctrl_usb2_oc: usb2ocgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO15__USB2_OTG_OC		0x1c0 /* USB_B_OC# */
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x190
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d0
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d0
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d0
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d0
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d0
+			MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4		0x1d0
+			MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5		0x1d0
+			MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6		0x1d0
+			MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7		0x1d0
+			MX8MP_IOMUXC_SD1_RESET_B__USDHC1_RESET_B	0x141
+			MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE		0x190
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x194
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d4
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d4
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d4
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d4
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d4
+			MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4		0x1d4
+			MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5		0x1d4
+			MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6		0x1d4
+			MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7		0x1d4
+			MX8MP_IOMUXC_SD1_RESET_B__USDHC1_RESET_B	0x141
+			MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE		0x194
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x196
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d6
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d6
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d6
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d6
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d6
+			MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4		0x1d6
+			MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5		0x1d6
+			MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6		0x1d6
+			MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7		0x1d6
+			MX8MP_IOMUXC_SD1_RESET_B__USDHC1_RESET_B	0x141
+			MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE		0x196
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190 /* SDIO_A_CLK */
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0 /* SDIO_A_CMD */
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0 /* SDIO_A_D0 */
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0 /* SDIO_A_D1 */
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0 /* SDIO_A_D2 */
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0 /* SDIO_A_D3 */
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194 /* SDIO_A_CLK */
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4 /* SDIO_A_CMD */
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4 /* SDIO_A_D0 */
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4 /* SDIO_A_D1 */
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4 /* SDIO_A_D2 */
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4 /* SDIO_A_D3 */
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196 /* SDIO_A_CLK */
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6 /* SDIO_A_CMD */
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6 /* SDIO_A_D0 */
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6 /* SDIO_A_D1 */
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6 /* SDIO_A_D2 */
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6 /* SDIO_A_D3 */
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12		0x19 /* SDIO_A_CD# */
+		>;
+	};
+
+	pinctrl_usdhc2_wp: usdhc2wpgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_WP__USDHC2_WP			0x400000d6 /* SDIO_A_WP */
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x190 /* SDIO_B_CLK */
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d0 /* SDIO_B_CMD */
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d0 /* SDIO_B_D0 */
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d0 /* SDIO_B_D1 */
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d0 /* SDIO_B_D2 */
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d0 /* SDIO_B_D3 */
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d0 /* SDIO_B_D4 */
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d0 /* SDIO_B_D5 */
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d0 /* SDIO_B_D6 */
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d0 /* SDIO_B_D7 */
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194 /* SDIO_B_CLK */
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4 /* SDIO_B_CMD */
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d4 /* SDIO_B_D0 */
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d4 /* SDIO_B_D1 */
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d4 /* SDIO_B_D2 */
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d4 /* SDIO_B_D3 */
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d4 /* SDIO_B_D4 */
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d4 /* SDIO_B_D5 */
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d4 /* SDIO_B_D6 */
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d4 /* SDIO_B_D7 */
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x196 /* SDIO_B_CLK */
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d6 /* SDIO_B_CMD */
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d6 /* SDIO_B_D0 */
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d6 /* SDIO_B_D1 */
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d6 /* SDIO_B_D2 */
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d6 /* SDIO_B_D3 */
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d6 /* SDIO_B_D4 */
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d6 /* SDIO_B_D5 */
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d6 /* SDIO_B_D6 */
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d6 /* SDIO_B_D7 */
+		>;
+	};
+
+	pinctrl_usdhc3_gpio: usdhc3gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__GPIO3_IO26		0x19 /* SDIO_B_CD# */
+			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14		0x19 /* SDIO_B_WP */
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0xc6
+		>;
+	};
+};
-- 
2.45.2


