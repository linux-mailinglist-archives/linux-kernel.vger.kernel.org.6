Return-Path: <linux-kernel+bounces-238055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F39242BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38011F25BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D7F1BD032;
	Tue,  2 Jul 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="nLTNumdC"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F0158DCE;
	Tue,  2 Jul 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935111; cv=none; b=QQ7fa1PLvqzRGvrEIOtoPka8ImLsy9IXiJV1iF5VwUZu9juMeJCUnmVDM2HzuO1uTIa6vc1ZKXvFW7KJqs9Ek9RXx8w0Kj/lGHutgZIRG/K/0o5pYZ1LErply2UT9JZ3t9qzasEo040cM8kQRotUV7HboRvzNtXH+QvK5elcEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935111; c=relaxed/simple;
	bh=bfbc30B7RTHCSbEg6yxR/+v0L+wwSFxnKdiYVc6yfV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxaFueistLJBHEGyRPuL5rrYXGskMfAjPrnc7ER8YAbwYZzvlO/o8FrkIOYcM9G+GcnBmGlZapJzG9mwCezuomN94EFVL6VDv3tsbIGBRStotWB/k+Zj0I8hV2cIuXM3t/fU2e2HfUnSpFKhhIDLgf/bnZZUusE/Idw8tCSVIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=nLTNumdC; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FD06BFB52;
	Tue,  2 Jul 2024 17:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1719935107; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=KXyK/RKjLMH3JqgExy+onXTs+08R6Z+USUtMK01FBpI=;
	b=nLTNumdCZbm+LoWrK3i+QY2MjMXWKhve38oLz78xapQiD9uHeqX6V2TQWCCORqSOJ/03QU
	cJmt3BlYqUZ7cqnsHuSKCCRJ/HGfHBS2aHP+Poa7ahkeLWLBFl6CPj+m5+TTI8DSymGbeK
	Dt00suyyhQf4xyGirRYhM2lBiIb3/akrVva1GdenK6KgJkDN+oE9HIf+OaSHdUQU7EY8fd
	mbBjILzSFHhoXdhoOxpVlogr2FxmsMmQdaiRgcci1T+yVWSUfqGRLe7nGhZYlw1Lk6NXCK
	7Da50DoAnnqD9Fs2qhEVXAx84L2lh72KCNL7fLoGxS6mh/ov7juxhrDPhEaR0Q==
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
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 3/3] arm64: dts: Add support for Kontron i.MX8MP SMARC module and eval carrier
Date: Tue,  2 Jul 2024 17:43:21 +0200
Message-ID: <20240702154413.968044-4-frieder@fris.de>
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

This adds support for the Kontron Electronics i.MX8MP SMARC module
(which uses the OSM-S i.MX8MP SoM) on the Kontron SMARC eval carrier.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../imx8mp-kontron-smarc-eval-carrier.dts     | 224 +++++++++++++++
 .../dts/freescale/imx8mp-kontron-smarc.dtsi   | 271 ++++++++++++++++++
 3 files changed, 496 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 8688a85ba5a44..6d72558c1a9e3 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -175,6 +175,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-bl-osm-s.dtb
 imx8mp-kontron-dl-dtbs += imx8mp-kontron-bl-osm-s.dtb imx8mp-kontron-dl.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-dl.dtb
 
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-smarc-eval-carrier.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts b/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
new file mode 100644
index 0000000000000..7b202049eb217
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include "imx8mp-kontron-smarc.dtsi"
+
+/ {
+	model = "Kontron SMARC Eval Carrier with i.MX8MP";
+	compatible = "kontron,imx8mp-smarc-eval-carrier", "kontron,imx8mp-smarc",
+		     "kontron,imx8mp-osm-s", "fsl,imx8mp";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 50000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <100>;
+		enable-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+	};
+
+	extcon_usbc: usbc {
+		compatible = "linux,extcon-usb-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb1_id>;
+		id-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "imx8mp-wm8904";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN2L", "Line In Jack",
+			"IN2R", "Line In Jack",
+			"Headphone Jack", "MICBIAS",
+			"IN1L", "Headphone Jack";
+		simple-audio-card,widgets =
+			"Microphone", "Headphone Jack",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack";
+
+		codec_dai: simple-audio-card,codec {
+			clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
+			sound-dai = <&wm8904>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+	};
+};
+
+&ecspi1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "winbond,w25q128fw", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <60000000>;
+	};
+};
+
+&ecspi2 {
+	status = "okay";
+};
+
+&eqos {
+	status = "okay";
+};
+
+&fec {
+	status = "okay";
+};
+
+&flexcan1 {
+	status = "okay";
+};
+
+&flexcan2 {
+	status = "okay";
+};
+
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	ddc-i2c-bus = <&i2c3>;
+	status = "okay";
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	wm8904: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
+		clock-names = "mclk";
+		AVDD-supply = <&reg_vdd_1v8>;
+		CPVDD-supply = <&reg_vdd_1v8>;
+		DBVDD-supply = <&reg_vdd_1v8>;
+		DCVDD-supply = <&reg_vdd_1v8>;
+		MICVDD-supply = <&reg_vdd_3v3>;
+	};
+
+	carrier_gpio2: tca9554@20 {
+		compatible = "nxp,pca9554";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		status = "okay";
+	};
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	fsl,clkreq-unsupported;
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	status = "okay";
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio3 2 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&sai3 {
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&uart1 {
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart4 {
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
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_1 {
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
+	vmmc-supply = <&reg_vdd_3v3>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.dtsi
new file mode 100644
index 0000000000000..936849c5ecd4f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.dtsi
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Kontron Electronics GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include "imx8mp-kontron-osm-s.dtsi"
+
+/ {
+	model = "Kontron SMARC i.MX8MP";
+	compatible = "kontron,imx8mp-smarc", "kontron,imx8mp-osm-s", "fsl,imx8mp";
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&eqos {	/* Second ethernet (OSM-S ETH_B) */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos_rgmii>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
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
+/*
+ * Rename SoM signals according to SMARC module usage:
+ *   GPIO_A_2 -> GPIO0
+ *   GPIO_A_3 -> GPIO1
+ *   GPIO_A_4 -> GPIO2
+ *   GPIO_A_5 -> GPIO3
+ *   USB_B_EN -> n.a.
+ *   USB_B_ID -> n.a.
+ *   USB_B_OC -> n.a.
+ */
+&gpio1 {
+	gpio-line-names = "GPIO_A_0", "GPIO_A_1", "", "",
+			  "", "GPIO0", "GPIO1", "GPIO2",
+			  "GPIO3", "", "USB_A_ID", "",
+			  "USB_A_EN", "USB_A_OC","CAM_MCK", "",
+			  "ETH_B_MDC", "ETH_B_MDIO", "ETH_B_TXD3", "ETH_B_TXD2",
+			  "ETH_B_TXD1", "ETH_B_TXD0", "ETH_B_TX_EN", "ETH_B_TX_CLK",
+			  "ETH_B_RX_DV", "ETH_B_RX_CLK", "ETH_B_RXD0", "ETH_B_RXD1",
+			  "ETH_B_RXD2", "ETH_B_RXD3";
+};
+
+/*
+ * Rename SoM signals according to SMARC module usage:
+ *   SDIO_A_CD -> SDIO_CD
+ *   SDIO_A_CLK -> SDIO_CK
+ *   SDIO_A_CMD -> SDIO_CMD
+ *   SDIO_A_D0 -> SDIO_D0
+ *   SDIO_A_D1 -> SDIO_D1
+ *   SDIO_A_D2 -> SDIO_D2
+ *   SDIO_A_D3 -> SDIO_D3
+ *   SDIO_A_PWR_EN -> SDIO_PWR_EN
+ *   SDIO_A_WP -> SDIO_WP
+ */
+&gpio2 {
+	gpio-line-names = "", "", "", "", "", "", "", "", "", "", "", "",
+			  "SDIO_CD", "SDIO_CK", "SDIO_CMD", "SDIO_D0",
+			  "SDIO_D1", "SDIO_D2", "SDIO_D3", "SDIO_PWR_EN",
+			  "SDIO_WP";
+};
+
+/*
+ * Rename SoM signals according to SMARC module usage:
+ *   PCIE_CLKREQ -> PCIE_A_CKREQ
+ *   PCIE_A_PERST -> PCIE_A_RST
+ *   SDIO_B_D5 -> n.a.
+ *   SDIO_B_D6 -> n.a.
+ *   SDIO_B_D7 -> n.a.
+ *   SPI_A_WP -> n.a.
+ *   SPI_A_HOLD -> n.a.
+ *   UART_B_RTS -> SER2_RTS
+ *   UART_B_CTS -> SER2_CTS
+ *   SDIO_B_D0 -> GPIO_8
+ *   SDIO_B_D1 -> GPIO_9
+ *   SDIO_B_D2 -> GPIO_10
+ *   SDIO_B_D3 -> GPIO_11
+ *   SDIO_B_WP -> n.a.
+ *   SDIO_B_D4 -> n.a.
+ *   PCIE_SM_ALERT -> SMB_ALERT
+ *   SDIO_B_CLK -> GPIO_6
+ *   SDIO_B_CMD -> GPIO_7
+ *   GPIO_B_0 -> LCD0_BKLT_EN
+ *   GPIO_B_1 -> LCD1_BKLT_EN
+ *   BOOT_SEL0 -> BOOT_SEL2
+ *   SDIO_B_CD -> n.a.
+ *   SDIO_B_PWR_EN -> n.a.
+ *   HDMI_CEC -> n.a.
+ *   SDIO_B_PWR_EN -> n.a.
+ */
+&gpio3 {
+	pinctrl-0 = <&pinctrl_gpio3>, <&pinctrl_gpio3_smarc>;
+	gpio-line-names = "PCIE_WAKE", "PCIE_A_CKREQ", "PCIE_A_RST", "",
+			  "", "", "", "",
+			  "SER2_RTS", "SER2_CTS", "GPIO_8", "GPIO_9",
+			  "GPIO_10", "GPIO_11", "", "",
+			  "SMB_ALERT", "GPIO_6", "GPIO_7", "LCD0_BKLT_EN",
+			  "LCD1_BKLT_EN", "", "BOOT_SEL2", "BOOT_SEL1",
+			  "", "", "", "",
+			  "", "HDMI_HPD";
+};
+
+/*
+ * Rename SoM signals according to SMARC module usage:
+ *   GPIO_B_5 -> n.a.
+ *   GPIO_B_6 -> n.a.
+ *   GPIO_B_7 -> n.a.
+ *   GPIO_C_0 -> LED
+ *   GPIO_B_3 -> ETH2_INT
+ *   GPIO_B_4 -> USB_HUB_RST
+ *   GPIO_B_2 -> ETH1_INT
+ *   GPIO_A_6 -> GPIO4
+ *   CAN_A_TX -> CAN0_TX
+ *   UART_A_CTS -> SER0_CTS
+ *   UART_A_RTS -> SER0_RTS
+ *   CAN_A_RX -> CAN0_RX
+ *   CAN_B_TX -> CAN1_TX
+ *   CAN_B_RX -> CAN1_RX
+ *   GPIO_A_7 -> TEST
+ *   I2S_A_DATA_IN -> I2S0_SDIN
+ *   I2S_LRCLK -> I2S0_LRCK
+ */
+&gpio4 {
+	gpio-line-names = "", "", "", "LED",
+			  "ETH_A_MDC", "ETH_A_MDIO", "ETH_A_RXD0", "ETH_A_RXD1",
+			  "ETH_A_RXD2", "ETH_A_RXD3", "ETH_A_RX_DV", "ETH_A_RX_CLK",
+			  "ETH_A_TXD0", "ETH_A_TXD1", "ETH_A_TXD2", "ETH_A_TXD3",
+			  "ETH_A_TX_EN", "ETH_A_TX_CLK", "ETH2_INT", "USB_HUB_RST",
+			  "ETH1_INT", "GPIO4", "CAN0_TX", "SER0_CTS",
+			  "SER0_RTS", "CAN0_RX", "CAN1_TX", "CAN1_RX",
+			  "TEST", "CARRIER_PWR_EN", "I2S0_SDIN", "I2S0_LRCK";
+};
+
+/*
+ * Rename SoM signals according to SMARC module usage:
+ *   I2S_BITCLK -> I2S0_CK
+ *   I2S_A_DATA_OUT -> I2S0_SDOUT
+ *   I2S_MCLK -> AUDIO_MCK
+ *   PWM_2 -> GPIO5
+ *   PWM_1 -> LCD1_BKLT_PWM
+ *   PWM_0 -> LCD0_BKLT_PWM
+ *   SPI_A_SCK -> SPI0_CK
+ *   SPI_A_SDO -> SPI0_DO
+ *   SPI_A_SDI -> SPI0_DIN
+ *   SPI_A_CS0 -> SPI0_CS0
+ *   SPI_B_SCK -> ESPI_CK
+ *   SPI_B_SDO -> ESPI_IO_0
+ *   SPI_B_SDI -> ESPI_IO_1
+ *   SPI_B_CS0 -> ESPI_CS0
+ *   I2C_A_SCL -> I2C_PM_CK
+ *   I2C_A_SDA -> I2C_PM_DAT
+ *   I2C_B_SCL -> I2C_GP_CK
+ *   I2C_B_SDA -> I2C_GP_DAT
+ *   PCIE_SMCLK -> HDMI_CTRL_CK
+ *   PCIE_SMDAT -> HDMI_CTRL_DAT
+ *   I2C_CAM_SCL -> I2C_CAM1_CK
+ *   I2C_CAM_SDA -> I2C_CAM1_DAT
+ *   UART_A_RX -> SER0_RX
+ *   UART_A_TX -> SER0_TX
+ *   UART_C_RX -> SER3_RX
+ *   UART_C_TX -> SER3_TX
+ *   UART_CON_RX -> SER1_RX
+ *   UART_CON_TX -> SER1_TX
+ *   UART_B_RX -> SER2_RX
+ *   UART_B_TX -> SER2_TX
+ */
+&gpio5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio5_smarc>;
+	gpio-line-names = "I2S0_CK", "I2S0_SDOUT", "AUDIO_MCK", "GPIO5",
+			  "LCD1_BKLT_PWM", "LCD0_BKLT_PWM", "SPI0_CK", "SPI0_DO",
+			  "SPI0_DIN", "SPI0_CS0", "ESPI_CK", "ESPI_IO_0",
+			  "ESPI_IO_1", "ESPI_CS0", "I2C_PM_CK", "I2C_PM_DAT",
+			  "I2C_GP_CK", "I2C_GP_DAT", "HDMI_CTRL_CK", "HDMI_CTRL_DAT",
+			  "I2C_CAM1_CK", "I2C_CAM1_DAT", "SER0_RX", "SER0_TX",
+			  "SER3_RX", "SER3_TX", "SER1_RX", "SER1_TX",
+			  "SER2_RX", "SER2_TX";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usb1@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		reset-gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&usb3_1 {
+	fsl,disable-port-power-control;
+	fsl,permanently-attached;
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
+	pinctrl_gpio3_smarc: gpio3smarcgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_DATA04__GPIO3_IO10		0x1d0 /* SMARC GPIO8 */
+			MX8MP_IOMUXC_NAND_DATA05__GPIO3_IO11		0x1d0 /* SMARC GPIO9 */
+			MX8MP_IOMUXC_NAND_DATA06__GPIO3_IO12		0x1d0 /* SMARC GPIO10 */
+			MX8MP_IOMUXC_NAND_DATA07__GPIO3_IO13		0x1d0 /* SMARC GPIO11 */
+			MX8MP_IOMUXC_NAND_WE_B__GPIO3_IO17		0x190 /* SMARC GPIO6 */
+			MX8MP_IOMUXC_NAND_WP_B__GPIO3_IO18		0x1d0 /* SMARC GPIO7 */
+		>;
+	};
+
+	pinctrl_gpio5_smarc: gpio5smarcgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__GPIO5_IO04		0x1d0 /* SMARC GPIO5 */
+		>;
+	};
+};
-- 
2.45.2


