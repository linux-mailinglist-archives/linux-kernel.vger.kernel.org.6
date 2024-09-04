Return-Path: <linux-kernel+bounces-314604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404AC96B59E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6A92885FC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041881CC144;
	Wed,  4 Sep 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="yj1qfDs1"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B719AD56;
	Wed,  4 Sep 2024 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440149; cv=none; b=RyZIC0VPrbjYbjv0hXu2TTYTQfwX2IJyyBc84RqYARFyFlX1BKFABmY1lej2HqN21CVCzzL3fzHOHDP1ac5nAEf1O+T5K6jKsvIn70fO/dr4lPF4hSUYw/A68Ao8d0Hapk0NiWh4sipcyzfel0J42U9EDYNJXcFMUfA3U9bwRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440149; c=relaxed/simple;
	bh=LQKHMlY9b89H0zbbtkSH+lybs6fFCfSr3EDp4yXnp4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtQEmzKXgyc87UMeomFCR5OCDhbGZ2J5F90JS+o58ZpS/Yq4W/0tjKbx/NezVOuDWpdvA9T3/elSUTf8knVLsJg5QTpXvVUW/R1OvTTjufgQZ3JugG3vX0JuTkRgMGwE4syz73lkGUXMqkx1NO4ZMRTpsekuzrFeOhFnegB2F6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=yj1qfDs1; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5934BFB47;
	Wed,  4 Sep 2024 10:55:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1725440144; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=z3Yv49qLslgfqX7IEHbIye/p2cOEEvmq2iw+RXTPF3A=;
	b=yj1qfDs142Ueh8V8zxAxrPVI91AyzNjyKhC/vdMQz+mFujDepc/OP6bO1QQdaLzY4H9RBo
	UBGh3CqxP9dtrOhOxbw8bh2rghWX8K86XmwUdVkVJITgO5gxLSV0d14s+RkEKPcBNK3ma1
	HoiepbVCf8a5pSekQXpN2etFtB3J1iNArVL72OkbzdfbVxvFaV+tFSHoIZlvl1boRaG9VS
	0QkozFOPERX1d0JOplO01f5GXbudhH78R3cDy7QdXY4TO1Of5cSo5dy93KNqBh5DLFgXjr
	vdhgNfTO7KLVdvHvSZAUe8al+PBY64rZbSyzBYkYVQbG5MejlYq0BM/G+Mdydw==
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
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 3/3] arm64: dts: Add support for Kontron i.MX8MP SMARC module and eval carrier
Date: Wed,  4 Sep 2024 10:53:21 +0200
Message-ID: <20240904085415.645031-4-frieder@fris.de>
In-Reply-To: <20240904085415.645031-1-frieder@fris.de>
References: <20240904085415.645031-1-frieder@fris.de>
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
Changes for v3:
* Address Shawn's review comments (thanks!)

Changes for v2:
* Fix GPIO labels
* Add support for TPM chip on SMARC module
* Disable PWM in favor of GPIO5 on SMARC carrier
* Enable LCDIF node to make HDMI work
* Add support for GPIO expanders on SMARC carrier
* Remove SPI flash as its removable and should be in an overlay
* Add CAN regulators to fix transceiver enable
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../imx8mp-kontron-smarc-eval-carrier.dts     | 254 ++++++++++++++++
 .../dts/freescale/imx8mp-kontron-smarc.dtsi   | 280 ++++++++++++++++++
 3 files changed, 535 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index e6f177e5fac26..250a7db037282 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -176,6 +176,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-bl-osm-s.dtb
 imx8mp-kontron-dl-dtbs += imx8mp-kontron-bl-osm-s.dtb imx8mp-kontron-dl.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-dl.dtb
 
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-smarc-eval-carrier.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts b/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
new file mode 100644
index 0000000000000..2173a36ff6917
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
@@ -0,0 +1,254 @@
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
+
+	regulator_can0: can0-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "can0_en";
+		gpio = <&expander_pm_out 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	regulator_can1: can1-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "can1_en";
+		gpio = <&expander_pm_out 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&ecspi1 {
+	status = "okay";
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
+	xceiver-supply = <&regulator_can0>;
+	status = "okay";
+};
+
+&flexcan2 {
+	xceiver-supply = <&regulator_can1>;
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
+
+	expander_pm_out: io-expander@22 {
+		compatible = "nxp,pca9554";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "EN_5V0_S0", "EN_3V3_S0", "EN_1V8_S0",
+				  "EN_1V5_S0", "EN_12V0_PCIE", "EN_3V3_S5",
+				  "CAN0_EN", "CAN1_EN";
+	};
+
+	expander_pm_in: io-expander@24 {
+		compatible = "nxp,pca9554";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "PG_5V0_3V3_S0", "PG_5V0_3V3_S5", "PG_1V8_S0",
+				  "PG_1V5_S0", "PG_BKLT_5V", "PG_BKLT_12V";
+	};
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
+	expander_audio: io-expander@20 {
+		compatible = "nxp,pca9554";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "I2C_SEL_CODEC_LOOPBACK", "FPAH_PRESENCE",
+				  "CODEC_OPTION_SW_I2S_HDA", "LINE_IN_JD",
+				  "LINE_OUT_JD", "HEADPHONES_JD", "MIC_JD";
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
+&lcdif3 {
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
index 0000000000000..1e831d9b8a935
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.dtsi
@@ -0,0 +1,280 @@
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
+&ecspi1 {
+	status = "okay";
+
+	tpm@0 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0>;
+		spi-max-frequency = <18500000>;
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
+ *   SDIO_B_D0 -> GPIO8
+ *   SDIO_B_D1 -> GPIO9
+ *   SDIO_B_D2 -> GPIO10
+ *   SDIO_B_D3 -> GPIO11
+ *   SDIO_B_WP -> n.a.
+ *   SDIO_B_D4 -> n.a.
+ *   PCIE_SM_ALERT -> SMB_ALERT
+ *   SDIO_B_CLK -> GPIO6
+ *   SDIO_B_CMD -> GPIO7
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
+			  "SER2_RTS", "SER2_CTS", "GPIO8", "GPIO9",
+			  "GPIO10", "GPIO11", "", "",
+			  "SMB_ALERT", "GPIO6", "GPIO7", "LCD0_BKLT_EN",
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
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usb-hub@1 {
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
2.46.0


