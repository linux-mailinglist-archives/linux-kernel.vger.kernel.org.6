Return-Path: <linux-kernel+bounces-244053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F08929E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECF5284BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF84647F7A;
	Mon,  8 Jul 2024 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="GzgDePPF"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD39768EF;
	Mon,  8 Jul 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428103; cv=none; b=a24K4dM5rTNv+CNOShJO8nc/YJ7AID6SsZbQ2k99Wd9+WtLhhwwZW7IMArfhk6eLy+QQRqYQEJJyy433rU7ADZWr7WOzhbs4tt97/kGrWGY4Vd6Fk+J1iyI+E1sa4975E2H0+ktAYmIN/H5eBK7+Q7k+2nCx9C6Dtose73iHgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428103; c=relaxed/simple;
	bh=81wpWMDbEp8XLa9WMhS3B4cC79HQ88fFMX5MHCrTZno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJFeq2hjJ7T295Kkq4W7mywq4vu70q/oBwct83W6CUR1sIdCnsBYNHE20sbGMYHbXMG5/82NbkZ83Mvh8w0adxxCKoL4qxpGHzD9WOgLiLpf3wbtRY48pbOjiVsAxFwWXo1S7lX3rIGfxexOGBR8rso5kLshz2UWg0SZXMv2geo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=GzgDePPF; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C515BFBA8;
	Mon,  8 Jul 2024 10:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1720428098; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=j5c5NEwfDCzcK+X3ChRiJgZPE2mtbL8FXY+gGQit6RM=;
	b=GzgDePPFKTrXZFr9oB/XNmOhfohjIkzvVirfcaJCsP05D/EboROXB4qd++azMIyd2eLDhx
	Ppg6sR/lHSPu1dLtybzJ+jeN9KfllIfMfrIV6Kwn2MwGAxc/7SoTDqsAJSjitnjwCyAgB6
	2wLEe3gRimhANOezQdMscWMJBaSOJsFZAESwTzLWXA7SwF4ZV0x3JHMC61SALGNUkm92pz
	m5RU2w2D2gsecj8cp0H7Dow0vD2pbLk91rk+iPcMMEqV5RU9f0oGNCBwLnEvVB2FhnKute
	zBw0fG4gN5MX49zE9OKbUUygnc4s4dkmvvTUak+Rx9uDaiRwmu5wYEy7wR6ciQ==
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
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 5/5] arm64: dts: Add support for Kontron i.MX93 OSM-S SoM and BL carrier board
Date: Mon,  8 Jul 2024 10:40:35 +0200
Message-ID: <20240708084107.38986-6-frieder@fris.de>
In-Reply-To: <20240708084107.38986-1-frieder@fris.de>
References: <20240708084107.38986-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This adds support for the Kontron Electronics OSM-S i.MX93 SoM
and the matching baseboard BL i.MX93.

The SoM hardware complies to the Open Standard Module (OSM) 1.1
specification, size S (https://sget.org/standards/osm).

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* none
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-kontron-bl-osm-s.dts  | 165 ++++++
 .../dts/freescale/imx93-kontron-osm-s.dtsi    | 547 ++++++++++++++++++
 3 files changed, 713 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index bd443c2bc5a48..f848c4b69b000 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -232,6 +232,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
new file mode 100644
index 0000000000000..2dfa2381f4691
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include "imx93-kontron-osm-s.dtsi"
+
+/ {
+	model = "Kontron BL i.MX93 OSM-S";
+	compatible = "kontron,imx93-bl-osm-s", "kontron,imx93-osm-s", "fsl,imx93";
+
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	pwm-beeper {
+		compatible = "pwm-beeper";
+		pwms = <&tpm6 1 5000 0>;
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
+&lpspi8 {
+	status = "okay";
+	assigned-clocks = <&clk IMX93_CLK_LPSPI8>;
+	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
+	assigned-clock-rates = <100000000>;
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
+			reset-assert-us = <10000>;
+			reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
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
+			reset-assert-us = <10000>;
+			reset-gpios = <&gpio2 18 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&flexcan1 {
+	status = "okay";
+};
+
+&lpi2c2 {
+	status = "okay";
+
+	gpio_expander_dio: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "DIO1_OUT","DIO1_IN", "DIO2_OUT","DIO2_IN",
+				  "DIO3_OUT","DIO3_IN", "DIO4_OUT","DIO4_IN";
+		interrupt-parent = <&gpio4>;
+		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&lpuart1 {
+	status = "okay";
+};
+
+&lpuart7 {
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&lpuart6 {
+	linux,rs485-enabled-at-boot-time;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&tpm6 {
+	status = "okay";
+};
+
+&usbotg1 {
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usb1@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+	};
+};
+
+&usbotg2 {
+	adp-disable;
+	hnp-disable;
+	srp-disable;
+
+	disable-over-current;
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+};
+
+&usdhc2 {
+	vmmc-supply = <&reg_vdd_3v3>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
new file mode 100644
index 0000000000000..926c622d380ee
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Kontron Electronics GmbH
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx93.dtsi"
+
+/ {
+	model = "Kontron OSM-S i.MX93";
+	compatible = "kontron,imx93-osm-s", "fsl,imx93";
+
+	aliases {
+		rtc0 = &rv3028;
+		rtc1 = &bbnsm_rtc;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_usdhc2_vcc: regulator-usdhc2-vcc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vcc>;
+		enable-active-high;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "VCC_SDIO_A";
+	};
+
+	reg_vdd_carrier: regulator-vdd-carrier {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_vdd_carrier>;
+		enable-active-high;
+		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
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
+&lpspi1 { /* OSM-S SPI_A */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi1>;
+	cs-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+};
+
+&lpspi8 { /* OSM-S SPI_B */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi8>;
+	cs-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
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
+	gpio-line-names = "", "", "I2C_A_SCL", "I2C_A_SDA",
+			  "UART_CON_RX", "UART_CON_TX", "UART_C_RX", "UART_C_TX",
+			  "CAN_A_TX", "CAN_A_RX", "GPIO_A_0", "SPI_A_CS0",
+			  "SPI_A_SDI", "SPI_A_SCK","SPI_A_SDO";
+};
+
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio2>;
+	gpio-line-names = "I2C_B_SDA", "I2C_B_SCL", "GPIO_B_1", "GPIO_A_2",
+			  "UART_B_TX", "UART_B_RX", "UART_B_RTS", "UART_B_CTS",
+			  "UART_A_TX", "UART_A_RX", "UART_A_RTS", "UART_A_CTS",
+			  "SPI_B_CS0", "SPI_B_SDI", "SPI_B_SDO", "SPI_B_SCK",
+			  "I2S_BITCLK", "I2S_MCLK", "GPIO_A_1", "I2S_A_DATA_OUT",
+			  "I2S_A_DATA_IN", "PWM_2", "GPIO_A_3", "PWM_1",
+			  "PWM_0", "CAN_B_TX", "I2S_LRCLK", "CAN_B_RX", "GPIO_A_4",
+			  "GPIO_A_5";
+};
+
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio3>;
+	gpio-line-names = "SDIO_A_CD", "SDIO_A_CLK", "SDIO_A_CMD", "SDIO_A_D0",
+			  "SDIO_A_D1", "SDIO_A_D2", "SDIO_A_D3", "SDIO_A_PWR_EN",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "SDIO_B_CLK", "SDIO_B_CMD", "SDIO_B_D0", "SDIO_B_D1",
+			  "SDIO_B_D2", "SDIO_B_D3", "GPIO_A_6", "GPIO_A_7";
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio4>;
+	gpio-line-names = "ETH_B_MDC", "ETH_B_MDIO", "ETH_B_TXD4", "ETH_B_TXD3",
+			  "ETH_B_TXD2", "ETH_B_TXD1", "ETH_B_TX_EN", "ETH_B_TX_CLK",
+			  "ETH_B_RX_CTL", "ETH_B_RX_CLK", "ETH_B_RXD0", "ETH_B_RXD1",
+			  "ETH_B_RXD2", "ETH_B_RXD3", "ETH_MDC", "ETH_MDIO",
+			  "ETH_A_TXD3", "ETH_A_TXD2", "ETH_A_TXD1", "ETH_A_TXD0",
+			  "ETH_A_TX_EN", "ETH_A_TX_CLK", "ETH_A_RX_CTL", "ETH_A_RX_CLK",
+			  "ETH_A_RXD0", "ETH_A_RXD1", "ETH_A_RXD2", "ETH_A_RXD3",
+			  "GPIO_B_0", "CARRIER_PWR_EN";
+};
+
+&lpi2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	status = "okay";
+
+	pca9451: pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		nxp,i2c-lt-enable;
+
+		regulators {
+			reg_vdd_soc: BUCK1 { /* dual phase with BUCK3 */
+				regulator-name = "+0V8_VDD_SOC (BUCK1)";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			reg_vddq_ddr: BUCK2 {
+				regulator-name = "+0V6_VDDQ_DDR (BUCK2)";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <600000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
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
+			reg_vdd_ana: LDO4 {
+				regulator-name = "+0V8_VDD_ANA (LDO4)";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
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
+	};
+};
+
+&lpi2c2 { /* OSM-S I2C_A */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+};
+
+&lpi2c3 { /* OSM-S I2C_B */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+};
+
+&tpm3 { /* OSM-S PWM_0 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm3>;
+};
+
+&tpm4 { /* OSM-S PWM_2 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm4>;
+};
+
+&tpm6 { /* OSM-S PWM_1 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm6>;
+};
+
+&lpuart1 { /* OSM-S UART_CON */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart1>;
+};
+
+&lpuart2 { /* OSM-S UART_C */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart2>;
+};
+
+&lpuart6 { /* OSM-S UART_B */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart6>;
+};
+
+&lpuart7 { /* OSM-S UART_A */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart7>;
+};
+
+&usdhc1 { /* eMMC */
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1>;
+	vmmc-supply = <&reg_vdd_3v3>;
+	vqmmc-supply = <&reg_vdd_1v8>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 { /* OSM-S SDIO_A */
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	vmmc-supply = <&reg_usdhc2_vcc>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+};
+
+&usdhc3 { /* OSM-S SDIO_B */
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3>;
+	pinctrl-2 = <&pinctrl_usdhc3>;
+	vqmmc-supply = <&reg_vdd_1v8>;
+};
+
+&wdog3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_lpspi1: lpspi1grp {
+		fsl,pins = <
+			MX93_PAD_SAI1_TXC__LPSPI1_SIN			0x3fe /* SPI_A_SDI_(IO0) */
+			MX93_PAD_SAI1_RXD0__LPSPI1_SOUT			0x3fe /* SPI_A_SDO_(IO1) */
+			MX93_PAD_SAI1_TXD0__LPSPI1_SCK			0x3fe /* SPI_A_SCK */
+			MX93_PAD_SAI1_TXFS__GPIO1_IO11			0x3fe /* SPI_A_CS0# */
+		>;
+	};
+
+	pinctrl_lpspi8: lpspi8grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO13__LPSPI8_SIN			0x3fe /* SPI_B_SDI */
+			MX93_PAD_GPIO_IO14__LPSPI8_SOUT			0x3fe /* SPI_B_SDO */
+			MX93_PAD_GPIO_IO15__LPSPI8_SCK			0x3fe /* SPI_B_SCK */
+			MX93_PAD_GPIO_IO12__GPIO2_IO12			0x3fe /* SPI_B_CS0# */
+		>;
+	};
+
+	pinctrl_enet_rgmii: enetrgmiigrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e /* ETH_MDC */
+			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x57e /* ETH_MDIO */
+			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e /* ETH_A_(S)(R)(G)MII_RXD0 */
+			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e /* ETH_A_(S)(R)(G)MII_RXD1 */
+			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e /* ETH_A_(R)(G)MII_RXD2 */
+			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e /* ETH_A_(R)(G)MII_RXD3 */
+			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe /* ETH_A_(R)(G)MII_RX_CLK */
+			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e /* ETH_A_(R)(G)MII_RX_DV(_ER) */
+			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e /* ETH_A_(S)(R)(G)MII_TXD0 */
+			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e /* ETH_A_(S)(R)(G)MII_TXD1 */
+			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e /* ETH_A_(S)(R)(G)MII_TXD2 */
+			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e /* ETH_A_(S)(R)(G)MII_TXD3 */
+			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x5fe /* ETH_A_(R)(G)MII_TX_CLK */
+			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e /* ETH_A_(R)(G)MII_TX_EN(_ER) */
+		>;
+	};
+
+	pinctrl_eqos_rgmii: eqosrgmiigrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_MDC__ENET_QOS_MDC		0x57e /* ETH_B_MDC */
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO		0x57e /* ETH_B_MDIO */
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0		0x57e /* ETH_B_(S)(R)(G)MII_RXD0 */
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1		0x57e /* ETH_B_(S)(R)(G)MII_RXD1 */
+			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2		0x57e /* ETH_B_(R)(G)MII_RXD2 */
+			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3		0x57e /* ETH_B_(R)(G)MII_RXD3 */
+			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK 0x57e /* ETH_B_(R)(G)MII_RX_CLK */
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x57e /* ETH_B_(R)(G)MII_RX_DV(_ER) */
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0		0x57e /* ETH_B_(S)(R)(G)MII_TXD0 */
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1		0x57e /* ETH_B_(S)(R)(G)MII_TXD1 */
+			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2		0x57e /* ETH_B_(S)(R)(G)MII_TXD2 */
+			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3		0x57e /* ETH_B_(S)(R)(G)MII_TXD3 */
+			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK 0x57e /* ETH_B_(R)(G)MII_TX_CLK */
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x57e /* ETH_B_(R)(G)MII_TX_EN(_ER) */
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX93_PAD_PDM_CLK__CAN1_TX			0x139e /* CAN_A_TX */
+			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX		0x139e /* CAN_A_RX */
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO25__CAN2_TX			0x139e /* CAN_B_TX */
+			MX93_PAD_GPIO_IO27__CAN2_RX			0x139e /* CAN_B_RX */
+		>;
+	};
+
+	pinctrl_gpio1: gpio1grp {
+		fsl,pins = <
+			MX93_PAD_PDM_BIT_STREAM1__GPIO1_IO10		0x31e /* GPIO_A_0 */
+		>;
+	};
+
+	pinctrl_gpio2: gpio2grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO18__GPIO2_IO18			0x31e /* GPIO_A_1 */
+			MX93_PAD_GPIO_IO03__GPIO2_IO03			0x31e /* GPIO_A_2 */
+			MX93_PAD_GPIO_IO22__GPIO2_IO22			0x31e /* GPIO_A_3 */
+			MX93_PAD_GPIO_IO28__GPIO2_IO28			0x31e /* GPIO_A_4 */
+			MX93_PAD_GPIO_IO29__GPIO2_IO29			0x31e /* GPIO_A_5 */
+			MX93_PAD_GPIO_IO02__GPIO2_IO02			0x31e /* GPIO_B_1 */
+		>;
+	};
+
+	pinctrl_gpio3: gpio3grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26			0x31e /* GPIO_A_6 */
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e /* GPIO_A_7 */
+		>;
+	};
+
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO3__GPIO4_IO28			0x31e /* GPIO_B_0 */
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e /* I2C_A_SCL */
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e /* I2C_A_SDA */
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO01__LPI2C3_SCL			0x40000b9e /* I2C_B_SCL */
+			MX93_PAD_GPIO_IO00__LPI2C3_SDA			0x40000b9e /* I2C_B_SDA */
+		>;
+	};
+
+	pinctrl_tpm3: tpm3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO24__TPM3_CH3			0x57e /* PWM_0 */
+		>;
+	};
+
+	pinctrl_tpm4: tpm4grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO21__TPM4_CH1			0x57e /* PWM_2 */
+		>;
+	};
+
+	pinctrl_tpm6: tpm6grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO23__TPM6_CH1			0x57e /* PWM_1 */
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vcc: regusdhc2vccgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07		0x31e /* SDIO_A_PWR_EN */
+		>;
+	};
+
+	pinctrl_reg_vdd_carrier: regvddcarriergrp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO4__GPIO4_IO29			0x31e /* CARRIER_PWR_EN */
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00		0x31e /* I2S_A_DATA_IN */
+			MX93_PAD_GPIO_IO19__SAI3_TX_DATA00		0x31e /* I2S_A_DATA_OUT */
+			MX93_PAD_GPIO_IO17__SAI3_MCLK			0x31e /* I2S_MCLK */
+			MX93_PAD_GPIO_IO26__SAI3_TX_SYNC		0x31e /* I2S_LRCLK */
+			MX93_PAD_GPIO_IO16__SAI3_TX_BCLK		0x31e /* I2S_BITCLK */
+		>;
+	};
+
+	pinctrl_lpuart1: lpuart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e /* UART_CON_RX */
+			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e /* UART_CON_TX */
+		>;
+	};
+
+	pinctrl_lpuart2: lpuart2grp {
+		fsl,pins = <
+			MX93_PAD_UART2_RXD__LPUART2_RX			0x31e /* UART_C_RX */
+			MX93_PAD_UART2_TXD__LPUART2_TX			0x31e /* UART_C_TX */
+		>;
+	};
+
+	pinctrl_lpuart6: lpuart6grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO05__LPUART6_RX			0x31e /* UART_B_RX */
+			MX93_PAD_GPIO_IO04__LPUART6_TX			0x31e /* UART_B_TX */
+			MX93_PAD_GPIO_IO07__LPUART6_RTS_B		0x31e /* UART_B_CTS */
+			MX93_PAD_GPIO_IO06__LPUART6_CTS_B		0x31e /* UART_B_RTS */
+		>;
+	};
+
+	pinctrl_lpuart7: lpuart7grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO09__LPUART7_RX			0x31e /* UART_A_RX */
+			MX93_PAD_GPIO_IO08__LPUART7_TX			0x31e /* UART_A_TX */
+			MX93_PAD_GPIO_IO11__LPUART7_RTS_B		0x31e /* UART_A_CTS */
+			MX93_PAD_GPIO_IO10__LPUART7_CTS_B		0x31e /* UART_A_RTS */
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK			0x15fe
+			MX93_PAD_SD1_CMD__USDHC1_CMD			0x13fe
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0		0x13fe
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1		0x13fe
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2		0x13fe
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3		0x13fe
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4		0x13fe
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5		0x13fe
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6		0x13fe
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7		0x13fe
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE		0x15fe
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK			0x15fe /* SDIO_A_CLK */
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x13fe /* SDIO_A_CMD */
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x13fe /* SDIO_A_D0 */
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x13fe /* SDIO_A_D1 */
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x13fe /* SDIO_A_D2 */
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x13fe /* SDIO_A_D3 */
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00			0x31e /* SDIO_A_CD# */
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__USDHC3_CLK			0x15fe /* SDIO_B_CLK */
+			MX93_PAD_SD3_CMD__USDHC3_CMD			0x13fe /* SDIO_B_CMD */
+			MX93_PAD_SD3_DATA0__USDHC3_DATA0		0x13fe /* SDIO_B_D0 */
+			MX93_PAD_SD3_DATA1__USDHC3_DATA1		0x13fe /* SDIO_B_D1 */
+			MX93_PAD_SD3_DATA2__USDHC3_DATA2		0x13fe /* SDIO_B_D2 */
+			MX93_PAD_SD3_DATA3__USDHC3_DATA3		0x13fe /* SDIO_B_D3 */
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX93_PAD_WDOG_ANY__WDOG1_WDOG_ANY		0xc6
+		>;
+	};
+};
-- 
2.45.2


