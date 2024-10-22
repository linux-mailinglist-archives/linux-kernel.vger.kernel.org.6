Return-Path: <linux-kernel+bounces-376476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7B9AB226
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5870C2838B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC061B0109;
	Tue, 22 Oct 2024 15:30:41 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B013BAD5;
	Tue, 22 Oct 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611040; cv=none; b=Ur+SxVg6yMSq5xtEkJFUIB856zVe/p0vzQBJwWfF4PrHKq3HwqdGF8Nb/lpBkCLN05xjX0/fN5SCBCrGKtaDD7PZO7gNLKpEyQ1oyNaUU7NhXIkbZIbuwsVn/rQSuqLYKNpgKe6zcf4ueLE0akEQqyTgrWAt73iIJzAm5XoxPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611040; c=relaxed/simple;
	bh=V+mXa774TU7LjtLtt2+nqt0b/bwsCWHTYGccMC2JDYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=doG0jlELdcO0bQAa5ijK/AuZsShR9wskWEo/9/EA4ZFHFW6JOcpmyvCJJfDgOnHRyI3V7kh07T8P0fZ9pSeiNljJewTrJtbTFzfHbulWgbavgVq89+RZxXvN30PR/yTShuGz18eWv0gBWLNmIu+Un4wu39OAIgl429G47Vmc5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1t3GqA-001At8-77;
	Tue, 22 Oct 2024 15:30:34 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 2/2] arm64: dts: imx: Add i.MX8M Plus Gateworks GW82XX-2X support
Date: Tue, 22 Oct 2024 08:30:31 -0700
Message-Id: <20241022153031.1231934-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022153031.1231934-1-tharvey@gateworks.com>
References: <20241022153031.1231934-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Gateworks GW82XX-2X is an ARM based single board computer (SBC)
comprised of the i.MX8M Plus based gw702x SoM and the gw82xx baseboard
featuring:
 - i.MX8M Plus SoC
 - LPDDR4 DRAM
 - eMMC FLASH
 - Gateworks System Controller (GSC)
 - microSD (1.8V/3.3V Capable)
 - panel status bi-color LED
 - pushbutton switch
 - fan controller with tachometer
 - USB Type-C connector
 - PCIe switch
 - 2x GbE RJ45 connectors
 - multi-protocol RS232/RS485/RS422 Serial ports
 - 2x Flexible Socket Adapters with SDIO/UART/USB/PCIe
   (for M.2 and miniPCIe expansion)
 - 2x isolated CAN
 - GPS
 - accelerometer
 - magnetometer
 - off-board connectors for: SPI, GPIO, I2C, ADC
 - Wide range DC power input
 - support for 802.3at PoE (via adapter)

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3:
- use GPIO_ACTIVE_HIGH for regulator and remove unecessary comment
v2:
- remove invalid st,drdy-int-pin from LIS2MDL magnetometer
- remove {adp,hnp,srp}-disable props from USB controller in host mode
  (these are only applicable if the controller is in OTG/Peripheral mode)
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mp-venice-gw82xx-2x.dts |  19 +
 .../dts/freescale/imx8mp-venice-gw82xx.dtsi   | 533 ++++++++++++++++++
 3 files changed, 553 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx-2x.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 91b72a1d5bb8..d1f205187454 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -196,6 +196,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw72xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw73xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw75xx-2x.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw82xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-ivy.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx-2x.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx-2x.dts
new file mode 100644
index 000000000000..597813308630
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx-2x.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 Gateworks Corporation
+ */
+
+/dts-v1/;
+
+#include "imx8mp.dtsi"
+#include "imx8mp-venice-gw702x.dtsi"
+#include "imx8mp-venice-gw82xx.dtsi"
+
+/ {
+	model = "Gateworks Venice GW82xx-2x i.MX8MP Development Kit";
+	compatible = "gateworks,imx8mp-gw82xx-2x", "fsl,imx8mp";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx.dtsi
new file mode 100644
index 000000000000..2b86cc62a41a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx.dtsi
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 Gateworks Corporation
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+/ {
+	aliases {
+		ethernet1 = &eth1;
+		fsa1 = &fsa0;
+		fsa2 = &fsa1;
+	};
+
+	led-controller {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	pcie0_refclk: clock-pcie0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	pps {
+		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
+		gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_usb2_vbus: regulator-usb2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb2_en>;
+		regulator-name = "usb2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_vmmc>;
+		regulator-name = "VDD_3V3_SD";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <12000>;
+		startup-delay-us = <100>;
+	};
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2>;
+	cs-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>,	/* CS0 onboard TPM */
+		   <&gpio5 13 GPIO_ACTIVE_LOW>, /* CS1 off-board J32 SPI */
+		   <&gpio1 12 GPIO_ACTIVE_LOW>, /* CS3 off-board J52 FSA1 */
+		   <&gpio4 26 GPIO_ACTIVE_LOW>; /* CS2 off-board J51 FSA2 */
+	status = "okay";
+
+	tpm@0 {
+		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
+		reg = <0x0>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can2>;
+	status = "okay";
+};
+
+&gpio1 {
+	gpio-line-names =
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "fsa2_gpio1", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", "", "", "",
+		"", "", "", "",
+		"dio1", "fsa1_gpio2", "", "dio0",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "rs485_en", "rs485_term",
+		"fsa2_gpio2", "fsa1_gpio1", "", "rs485_half",
+		"", "", "", "";
+};
+
+&i2c2 {
+	accelerometer@19 {
+		compatible = "st,lis2de12";
+		reg = <0x19>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_accel>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		st,drdy-int-pin = <1>;
+	};
+
+	magnetometer@1e {
+		compatible = "st,lis2mdl";
+		reg = <0x1e>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mag>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&i2c3 {
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* J30 */
+		fsa1: i2c@0 {
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_fsa2i2c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@20 {
+				compatible = "nxp,pca9555";
+				reg = <0x20>;
+				interrupt-parent = <&gpio4>;
+				interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c02";
+				reg = <0x54>;
+				pagesize = <16>;
+			};
+
+			eeprom@55 {
+				compatible = "atmel,24c02";
+				reg = <0x55>;
+				pagesize = <16>;
+			};
+		};
+
+		/* J29 */
+		fsa0: i2c@1 {
+			reg = <1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_fsa1i2c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@20 {
+				compatible = "nxp,pca9555";
+				reg = <0x20>;
+				interrupt-parent = <&gpio4>;
+				interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c02";
+				reg = <0x54>;
+				pagesize = <16>;
+			};
+
+			eeprom@55 {
+				compatible = "atmel,24c02";
+				reg = <0x55>;
+				pagesize = <16>;
+			};
+		};
+
+		/* J33 */
+		i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&pcie_phy {
+	clocks = <&pcie0_refclk>;
+	clock-names = "ref";
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	fsl,clkreq-unsupported;
+	status = "okay";
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio4 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x0000 0 0 0 0>;
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		pcie@0,0 {
+			reg = <0x0000 0 0 0 0>;
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			pcie@7,0 {
+				reg = <0x3800 0 0 0 0>;
+				device_type = "pci";
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				eth1: ethernet@0,0 {
+					reg = <0x0000 0 0 0 0>;
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+					local-mac-address = [00 00 00 00 00 00];
+				};
+			};
+		};
+	};
+};
+
+/* GPS */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* RS232 */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+/* USB1 - FSA1 */
+&usb3_0 {
+	fsl,permanently-attached;
+	fsl,disable-port-power-control;
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* USB2 - USB3.0 Hub */
+&usb3_1 {
+	fsl,permanently-attached;
+	fsl,disable-port-power-control;
+	status = "okay";
+};
+
+&usb3_phy1 {
+	vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* SDIO 1.8V */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+/* microSD */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_HIGH>; /* CD is active high */
+	bus-width = <4>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD6__GPIO4_IO08	0x40000146 /* DIO1 */
+			MX8MP_IOMUXC_SAI1_TXC__GPIO4_IO11	0x40000146 /* DIO0 */
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27	0x40000106 /* RS485_HALF */
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22	0x40000106 /* RS485_EN */
+			MX8MP_IOMUXC_SAI2_RXD0__GPIO4_IO23	0x40000106 /* RS485_TERM */
+		>;
+	};
+
+	pinctrl_accel: accelgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21	0x150	/* IRQ# */
+		>;
+	};
+
+	pinctrl_can1: can1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX		0x154
+			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX		0x154
+		>;
+	};
+
+	pinctrl_can2: can2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX		0x154
+			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX		0x154
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01	0x6	/* LEDG */
+			MX8MP_IOMUXC_SAI1_RXD3__GPIO4_IO05	0x6	/* LEDR */
+		>;
+	};
+
+	pinctrl_fsa1i2c: fsa1i2cgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD2__GPIO4_IO14	0x1d0		/* FSA1_ALERT# */
+			MX8MP_IOMUXC_SAI2_TXC__GPIO4_IO25	0x400001d0	/* FSA1_GPIO1 */
+			MX8MP_IOMUXC_SAI1_RXD7__GPIO4_IO09	0x400001d0	/* FSA1_GPIO2 */
+		>;
+	};
+
+	pinctrl_fsa2i2c: fsa2i2cgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD2__GPIO4_IO04	0x1d0		/* FSA2_ALERT# */
+			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13	0x400001d0	/* FSA2_GPIO1 */
+			MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24	0x400001d0	/* FSA2_GPIO2 */
+		>;
+	};
+
+	pinctrl_mag: maggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x140	/* IRQ# */
+		>;
+	};
+
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x106	/* PERST# */
+		>;
+	};
+
+	pinctrl_pps: ppsgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03	0x146
+		>;
+	};
+
+	pinctrl_reg_usb2_en: regusb2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD0__GPIO4_IO12	0x146	/* USBHUB_RST# */
+		>;
+	};
+
+	pinctrl_spi2: spi2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK	0xd0
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI	0xd0
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO	0xd0
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13	0x140	/* J32_CS */
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10	0x140	/* TPM_CS */
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x140	/* FSA1_CS */
+			MX8MP_IOMUXC_SAI2_TXD0__GPIO4_IO26	0x140	/* FSA2_CS */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX	0x140
+			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x194
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d4
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d4
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d4
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d4
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x196
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d6
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d6
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d6
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d6
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d6
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_vmmc: usdhc2-vmmc-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
+		>;
+	};
+};
-- 
2.25.1


