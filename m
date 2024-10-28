Return-Path: <linux-kernel+bounces-384440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D440F9B2A21
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91E91C21B09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7815EFA1;
	Mon, 28 Oct 2024 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="tZVZdQda"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5581917F6;
	Mon, 28 Oct 2024 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103832; cv=none; b=Wgnw6GMcnzyqrGESW3ljMe0D4cILBD2cbzUddvf9lZDbz/rhUarZ5rG4K/S41TI4Sx6K7r/5KNR5EssBZbdogqkMTWppacmfblrA5I7Rt2bf+oSl0Wkpdkgp2OzUUNPyi0iqR/TbNhr1jGt0Nl3sQseKHCPnERzyvkVeImSHqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103832; c=relaxed/simple;
	bh=kiK6t80OBsOq7Gu5GluXEInndT70qijOC/jMVkY4mks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VLnwO8n6bB6Iv36iNVgaN0p/5HmaBkDc/EoqulvjlPM1EcjLjpsFqwsfm1laYbq6Hu0OVmdWdXB71DR+3MWomUqRenXAMET3SEtPugZhE1vuqhv7xJ1Xur5jimVJdnidPb7u8axpaY5MTiQ7FEp47EoQ2dQlY3GAtmtZw3MN7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=tZVZdQda; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (89-186-114-4.pool.digikabel.hu [89.186.114.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 53B3189085;
	Mon, 28 Oct 2024 09:23:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730103825;
	bh=VBoM2nWkP9SCwtwpDG9rqfiUQXiFZC9n9aLNw6j0mLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZVZdQdaYpSWm+G/HT2r+2zP3nFYfSnm3ngGXa4atcP40F9zxYQlsoKvv0OtDq9qR
	 tdYXrvwH/9w6tBXUofEoh0q6wYOaUK6UeB+nqQg3xQdn8oOnPgZCHkK0fdpP0a00q+
	 2KS07WS9ZBfbnRX334zkVwgfiOylHe/C9ce7dEpfOmCEwN1GdFm24GqW9ES8FJZoR8
	 1avjBVHOIixruNF6duZQjqkv3kRd9e9G/xLABOFqsiwx5eJB2+GlJdVR+IlCU7zzLN
	 njvQeB/oX/qG78i8Fmmxd9YNMJ9IEuAtV+uksCMyg4MNIkoD179OXTmz7Q7LLfsCyM
	 RDjG8MA9ZWFmQ==
From: Heiko Schocher <hs@denx.de>
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/2] arm64: dts: imx8mp: add aristainetos3 board support
Date: Mon, 28 Oct 2024 09:23:32 +0100
Message-Id: <20241028082332.21672-3-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241028082332.21672-1-hs@denx.de>
References: <20241028082332.21672-1-hs@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add support for the i.MX8MP based aristainetos3 boards from ABB.

The board uses a ABB specific SoM from ADLink, based on NXP
i.MX8MP SoC. The SoM is used on 3 different carrier boards,
with small differences, which are all catched up in
devicetree overlays. The kernel image, the basic dtb
and all dtbos are collected in a fitimage. As bootloader
is used U-Boot which detects in his SPL stage the carrier
board by probing some i2c devices. When the correct
carrier is probed, the SPL applies all needed dtbos to
the dtb with which U-Boot gets loaded. Same principle
later before linux image boot, U-Boot applies the dtbos
needed for the carrier board before booting Linux.

Signed-off-by: Heiko Schocher <hs@denx.de>
---
checkpatch dropped the following warnings:
arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi:248: warning: DT compatible string "ethernet-phy-id2000.a231" appears un-documented -- check ./Documentation/devicetree/bindings/

ignored, as this compatible string is usedin other dts too, for example in

arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi

 arch/arm64/boot/dts/freescale/Makefile        |    5 +
 .../imx8mp-aristainetos3-adpismarc.dtsi       |   64 +
 .../imx8mp-aristainetos3-adpismarc.dtso       |   14 +
 .../imx8mp-aristainetos3-helios-lvds.dtsi     |   89 ++
 .../imx8mp-aristainetos3-helios-lvds.dtso     |   13 +
 .../imx8mp-aristainetos3-helios.dtsi          |  103 ++
 .../imx8mp-aristainetos3-helios.dtso          |   13 +
 .../imx8mp-aristainetos3-proton2s.dtsi        |  176 +++
 .../imx8mp-aristainetos3-proton2s.dtso        |   13 +
 .../imx8mp-aristainetos3a-som-v1.dts          |   18 +
 .../imx8mp-aristainetos3a-som-v1.dtsi         | 1210 +++++++++++++++++
 11 files changed, 1718 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9d3df8b218a2..7c3586509b8b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -163,6 +163,11 @@ imx8mn-tqma8mqnl-mba8mx-usbotg-dtbs += imx8mn-tqma8mqnl-mba8mx.dtb imx8mn-tqma8m
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-lvds-tm070jvhg33.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-usbotg.dtb
 
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3a-som-v1.dtb \
+			  imx8mp-aristainetos3-adpismarc.dtbo \
+			  imx8mp-aristainetos3-proton2s.dtbo \
+			  imx8mp-aristainetos3-helios.dtbo \
+			  imx8mp-aristainetos3-helios-lvds.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-data-modul-edm-sbc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-model-a.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
new file mode 100644
index 000000000000..cc0cddaa33ea
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&ecspi1 {
+	spidev0: spi@0 {
+		reg = <0>;
+		compatible = "rohm,dh2228fv";
+		spi-max-frequency = <500000>;
+	};
+};
+
+&ecspi2 {
+	spidev1: spi@0 {
+		reg = <0>;
+		compatible = "rohm,dh2228fv";
+		spi-max-frequency = <500000>;
+	};
+};
+
+&i2c2 {
+	/* SX1509(2) U1001@IPi SMARC Plus */
+	gpio8: i2c2_gpioext0@3e {
+		/* GPIO Expander 2 Mapping :
+		 * - 0: E_GPIO1_0	<=>	IPi SMARC Plus CN101_PIN29: E_GPIO1_0
+		 * - 1: E_GPIO1_1	<=>	IPi SMARC Plus CN101_PIN31: E_GPIO1_1
+		 * - 2: E_GPIO1_2	<=>	IPi SMARC Plus CN101_PIN32: E_GPIO1_2
+		 * - 3: E_GPIO1_3	<=>	IPi SMARC Plus CN101_PIN33: E_GPIO1_3
+		 * - 4: E_GPIO1_4	<=>	IPi SMARC Plus CN101_PIN35: E_GPIO1_4
+		 * - 5: E_GPIO1_5	<=>	IPi SMARC Plus CN101_PIN36: E_GPIO1_5
+		 * - 6: E_GPIO1_6	<=>	IPi SMARC Plus CN101_PIN37: E_GPIO1_6
+		 * - 7: E_GPIO1_7	<=>	IPi SMARC Plus CN101_PIN38: E_GPIO1_7
+		 * - 8: E_GPIO2_8	<=>	IPi SMARC Plus CN101_PIN40: E_GPIO2_8
+		 * - 9: TP1002		<=>	IPi SMARC Plus TP1002 (won't use)
+		 * - 10: TP1003		<=>	IPi SMARC Plus TP1003 (won't use)
+		 * - 11: TP1004		<=>	IPi SMARC Plus TP1004 (won't use)
+		 * - 12: TP1005		<=>	IPi SMARC Plus TP1005 (won't use)
+		 * - 13: TP1006		<=>	IPi SMARC Plus TP1006 (won't use)
+		 * - 14: TP1007		<=>	IPi SMARC Plus TP1007 (won't use)
+		 * - 15: TP1008		<=>	IPi SMARC Plus TP1008 (won't use)
+		 * - 16: OSCIO		<=>	IPi SMARC Plus TP1001 (won't use)
+		 */
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+		compatible = "semtech,sx1509q";
+		reg = <0x3e>;
+
+		semtech,probe-reset;
+		gpio-controller;
+		interrupt-controller;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+};
+
+&flexcan1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
new file mode 100644
index 000000000000..5a9adccbf7cf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
+ */
+/dts-v1/;
+/plugin/;
+
+#include "imx8mp-aristainetos3-adpismarc.dtsi"
+
+&{/} {
+	model = "Aristainetos3 ADLink PI SMARC carrier";
+	compatible = "abb,aristainetos3-adpismarc", "imx8mp-aristianetos3",
+		     "abb,aristianetos3-som", "fsl,imx8mp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
new file mode 100644
index 000000000000..55aabd6fc1f7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pwm/pwm.h>
+
+&{/} {
+	panel: panel {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd0_vdd_en>;
+		compatible = "lg,lb070wv8";
+		backlight = <&lvds_backlight>;
+		enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&ldb_lvds_ch0>;
+			};
+		};
+	};
+};
+
+&gpio3 {
+	mipi_lvds_select {
+		gpio-hog;
+		gpios = <23 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "mipi_lvds_select";
+	};
+};
+
+&hdmi_blk_ctrl {
+	status = "disabled";
+};
+
+&hdmi_pvi {
+	status = "disabled";
+};
+
+&hdmi_tx {
+	status = "disabled";
+};
+
+&hdmi_tx_phy {
+	status = "disabled";
+};
+
+&irqsteer_hdmi {
+	status = "disabled";
+};
+
+&ldb_lvds_ch0 {
+	fsl,data-mapping = "jeida";
+	fsl,data-width = <24>;
+	remote-endpoint = <&panel_in>;
+};
+
+&lcdif1 {
+	status = "disabled";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lcdif3 {
+	status = "disabled";
+};
+
+&lvds_backlight {
+	status = "okay";
+};
+
+&lvds_bridge {
+	status = "okay";
+};
+
+&media_blk_ctrl {
+	/*
+	 * The internal divider will always divide the output LVDS clock by 7
+	 * so our display needs 33246000 Hz, so set VIDEO_PLL1 to
+	 * 33246000 * 7 = 232722000 Hz
+	 */
+	assigned-clock-rates = <500000000>, <200000000>, <0>, <0>, <232722000>;
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
new file mode 100644
index 000000000000..06d1883b962a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
+ */
+/dts-v1/;
+/plugin/;
+
+#include "imx8mp-aristainetos3-helios-lvds.dtsi"
+
+&{/} {
+	model = "Aristainetos3 helios LVDS carrier";
+	compatible = "abb,aristainetos3-helios-lvds", "abb,aristainetos3-helios", "abb,aristianetos3-som", "fsl,imx8mp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
new file mode 100644
index 000000000000..b4b1cb3b0cb3
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+&{/} {
+	helios_gpio_leds {
+		compatible = "gpio-leds";
+
+		helios_blue {
+			label = "helios:blue";
+			gpios = <&helios_pca6416 15 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		helios_green {
+			label = "helios:green";
+			gpios = <&helios_pca6416 14 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		helios_red {
+			label = "helios:red";
+			gpios = <&helios_pca6416 12 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		helios_yellow {
+			label = "helios:yellow";
+			gpios = <&helios_pca6416 13 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+};
+
+&dp83867_0 {
+	status = "disabled";
+};
+
+&ecspi1 {
+	spidev1_0: spi@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <54000000>;
+	};
+
+	spidev1_1: spi@1 {
+		compatible = "rohm,dh2228fv";
+		reg = <1>;
+		spi-max-frequency = <54000000>;
+	};
+};
+
+&ecspi2 {
+	spidev2_0: spi@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <54000000>;
+	};
+};
+
+&fec {
+	status = "disabled";
+};
+
+&i2c1 {
+	eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+	};
+};
+
+&i2c3 {
+	helios_pca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "DIN0_CON",
+			"DIN1_CON",
+			"DIN2_CON",
+			"DIN3_CON",
+			"DIN4_CON",
+			"DIN5_CON",
+			"DIN6_CON",
+			"DIN7_CON",
+			"PM102_RES",
+			"COMx_RES",
+			"BPL_RES",
+			"PC_RES",
+			"LED_RED",
+			"LED_YELLOW",
+			"LED_GREEN",
+			"LED_BLUE";
+	};
+
+	rtc@68 {
+		compatible = "st,m41t00";
+		reg = <0x68>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtso b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtso
new file mode 100644
index 000000000000..e4f6cefe0d7e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtso
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
+ */
+/dts-v1/;
+/plugin/;
+
+#include "imx8mp-aristainetos3-helios.dtsi"
+
+&{/} {
+	model = "Aristainetos3 helios carrier";
+	compatible = "abb,aristainetos3-helios", "abb,aristianetos3-som", "fsl,imx8mp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtsi
new file mode 100644
index 000000000000..31f244981580
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtsi
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+&{/} {
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		leda0 {
+			label = "leda0";
+			gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		leda1 {
+			label = "leda1";
+			gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	watchdog {
+		/* MAX6371KA */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_watchdog_gpio>;
+		compatible = "linux,wdt-gpio";
+		always-running;
+		gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		hw_algo = "level";
+		/* Reset triggers in 3..9 seconds */
+		hw_margin_ms = <1500>;
+		status = "okay";
+	};
+};
+
+&dp83867_0 {
+	status = "disabled";
+};
+
+&eqos {
+	max-speed = <100>;
+};
+
+&fec {
+	status = "disabled";
+};
+
+&ecspi1{
+	fsl,spi-num-chipselects = <1>;
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+
+	spidev1_0: spi@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <54000000>;
+	};
+
+};
+
+&ecspi2 {
+	spidev2_0: spi@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <54000000>;
+	};
+};
+
+&gpio1 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "power",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio6 {
+	gpio-line-names =
+		"relay0", "relay1", "relay2",
+		"heater", "fan", "spare",
+		"clear", "fault";
+};
+
+&i2c2 {
+	tlc59108@40 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,tlc59108";
+		reg = <0x40>;
+
+		system_red@0 {
+			label = "system:red";
+			reg = <0x0>;
+		};
+
+		system_green@1 {
+			label = "system:green";
+			reg = <0x1>;
+		};
+
+		hydrogen_green@2 {
+			label = "hydrogen:green";
+			reg = <0x2>;
+		};
+
+		hydrogen_red@3 {
+			label = "hydrogen:red";
+			reg = <0x3>;
+		};
+
+		hydrogen_blue@4 {
+			label = "hydrogen:blue";
+			reg = <0x4>;
+		};
+
+		moisture_red@5 {
+			label = "moisture:red";
+			reg = <0x5>;
+		};
+
+		moisture_green@6 {
+			label = "moisture:green";
+			reg = <0x6>;
+		};
+
+		moisture_blue@7 {
+			label = "moisture:blue";
+			reg = <0x7>;
+		};
+	};
+
+	rtc1: rtc@68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
+
+// SER3
+&uart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+// SER0
+&uart2 {
+	pinctrl-0 = <&pinctrl_uart2>;
+};
+
+// SER1
+&uart3 {
+	pinctrl-0 = <&pinctrl_uart3>;
+};
+
+// SER2
+&uart4 {
+	linux,rs485-enabled-at-boot-time;
+	uart-has-rtscts;
+	rs485-rts-active-low;
+	rs485-rts-delay = <0 0>;
+	rts-gpios = <&gpio3 9 GPIO_ACTIVE_HIGH>;
+};
+
+&usdhc1 {
+	status = "disabled";
+};
+
+&wdog1 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_gpio_proton2s>;
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtso b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtso
new file mode 100644
index 000000000000..6956059553d7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtso
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
+ */
+/dts-v1/;
+/plugin/;
+
+#include "imx8mp-aristainetos3-proton2s.dtsi"
+
+&{/} {
+	model = "Aristainetos3 proton2s carrier";
+	compatible = "abb,aristainetos3-proton2s", "abb,aristianetos3-som", "fsl,imx8mp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dts b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dts
new file mode 100644
index 000000000000..b53a2f4eb0ff
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
+ *
+ * IMX8MP ADLINK raw SoM carrier variant
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include "imx8mp-aristainetos3a-som-v1.dtsi"
+
+/ {
+	model = "Aristainetos3 raw SoM carrier";
+	compatible = "abb,imx8mp-aristianetos3", "abb,imx8mp-aristianetos3-som",
+		     "fsl,imx8mp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
new file mode 100644
index 000000000000..903917bf0061
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
@@ -0,0 +1,1210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
+ */
+
+#include "imx8mp.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	model = "ADLINK LEC-iMX8MP-Q-N-4G-32G";
+	compatible = "abb,imx8mp-aristianetos3-som", "fsl,imx8mp";
+
+	aliases {
+		mmc0 = &usdhc3;	/* eMMC */
+		mmc1 = &usdhc2;	/* MicroSD */
+		ethernet0 = &eqos;
+		ethernet1 = &fec;
+	};
+
+	chosen {
+		bootargs = "console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200";
+		stdout-path = &uart2;
+	};
+
+	connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		data-role = "dual";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				usb_c_0_hs_ep: endpoint {
+					remote-endpoint = <&dwc3_0_hs_ep>;
+				};
+			};
+		};
+	};
+
+	fixed-regulators {
+		compatible = "simple-bus";
+		device_type = "fixed-regulators";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dp83867_2v5: regulator-enet {
+			compatible = "regulator-fixed";
+			regulator-name = "enet-2v5";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			gpio = <&gpio7 15 GPIO_ACTIVE_HIGH>;
+			regulator-boot-on;
+			regulator-always-on;
+			enable-active-high;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		status {
+			label = "yellow:status";
+			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	lvds_backlight: lvds_backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lvds_pwr_en>;
+		pwms = <&pwm2 0 100000>;
+		enable-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <80>;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/* Memory size 512 MiB..8 GiB will be filled by U-Boot */
+		reg = <0x0 0x40000000 0 0x08000000>;
+	};
+
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can1-stby";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan1_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan2_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usb1_host_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1_host_vbus";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb1_vbus>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 19 0>; /* SD2_RESET */
+		off-on-delay-us = <12000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_vmmc>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VDD_3V3_SD";
+		startup-delay-us = <100>;
+		vin-supply = <&buck4>;
+	};
+
+	reg_vdd_3p3v_awo: regulator-vdd-3p3v-awo {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "VDD_3P3V_AWO";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		rpmsg_reserved: rpmsg@55800000 {
+			no-map;
+			reg = <0 0x55800000 0 0x800000>;
+		};
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
+};
+
+&clk {
+	init-on-array = <IMX8MP_CLK_HSIO_ROOT>;
+	clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
+		 <&clk_ext3>, <&clk_ext4>;
+	clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
+		      "clk_ext3", "clk_ext4";
+	assigned-clocks = <&clk IMX8MP_CLK_A53_SRC>,
+			  <&clk IMX8MP_CLK_A53_CORE>,
+			  <&clk IMX8MP_CLK_NOC>,
+			  <&clk IMX8MP_CLK_NOC_IO>,
+			  <&clk IMX8MP_CLK_GIC>,
+			  <&clk IMX8MP_CLK_AUDIO_AHB>,
+			  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>,
+			  <&clk IMX8MP_AUDIO_PLL1>,
+			  <&clk IMX8MP_AUDIO_PLL2>,
+			  <&clk IMX8MP_VIDEO_PLL1>;
+};
+
+&ecspi1{
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	fsl,spi-num-chipselects = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs2>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW &gpio1 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&ecspi2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	fsl,spi-num-chipselects = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+/* eth0 */
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos_rgmii>;
+	phy-handle = <&dp83867_1>;
+	phy-mode = "rgmii-id";
+	snps,force_thresh_dma_mode;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dp83867_1: eqos-ethernet-phy@0 {
+			compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_1_75_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_75_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,min-output-impedance;
+			ti,dp83867-rxctrl-strap-quirk;
+			interrupt-parent = <&gpio4>;
+			interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
+			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <5>;
+		snps,tx-sched-sp;
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+		};
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+		};
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <5>;
+		snps,rx-sched-sp;
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+			snps,map-to-dma-channel = <0>;
+		};
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+			snps,map-to-dma-channel = <1>;
+		};
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+			snps,map-to-dma-channel = <2>;
+		};
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+			snps,map-to-dma-channel = <3>;
+		};
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+			snps,map-to-dma-channel = <4>;
+		};
+	};
+
+};
+
+/* eth1 */
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_rgmii>;
+	phy-handle = <&dp83867_0>;
+	phy-mode = "rgmii-id";
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dp83867_0: ethernet-phy@1 {
+			compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+			reset-gpio = <&gpio4 2 GPIO_ACTIVE_LOW>;
+
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_1_75_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_75_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+
+			ti,min-output-impedance;
+			ti,dp83867-rxctrl-strap-quirk;
+			eee-broken-1000t;
+		};
+	};
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "disabled";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "disabled";
+};
+
+&hdmi_blk_ctrl {
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
+	status = "okay";
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	pmic: pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		/*
+		 * i.MX 8M Plus Data Sheet for Consumer Products
+		 * 3.1.4 Operating ranges
+		 * MIMX8ML8CVNKZAB
+		 */
+		regulators {
+			buck1: BUCK1 {	/* VDD_SOC (dual-phase with BUCK3) */
+				regulator-compatible = "BUCK1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-ramp-delay = <3125>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck2: BUCK2 {	/* VDD_ARM */
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+				regulator-compatible = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-ramp-delay = <3125>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck4: BUCK4 {	/* VDD_3V3 */
+				regulator-compatible = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck5: BUCK5 {	/* VDD_1V8 */
+				regulator-compatible = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck6: BUCK6 {	/* NVCC_DRAM_1V1 */
+				regulator-compatible = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo1: LDO1 {	/* NVCC_SNVS_1V8 */
+				regulator-compatible = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo2: LDO2 {	/* VDDA_1V8 */
+				regulator-compatible = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo3: LDO3 {	/* VDDA_1V8 */
+				regulator-compatible = "LDO3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo4: LDO4 {	/* PMIC_LDO4 */
+				regulator-compatible = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo5: LDO5 {	/* NVCC_SD2 */
+				regulator-compatible = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio5 19 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&i2c5 {
+	#address-cells = <1>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c5>;
+	status = "okay";
+};
+
+&i2c6 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c6>;
+	pinctrl-1 = <&pinctrl_i2c6_gpio>;
+	scl-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	/* TPM - ST33TPHF2XI2C U2301 */
+	tpm: tpm@2e {
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+		compatible = "st,st33ktpm2xi2c";
+		reg = <0x2e>;
+
+		label = "tpm";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c6_tpm_irq &pinctrl_tpm>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpio = <&gpio6 11 GPIO_ACTIVE_LOW>;
+		status = "okay";
+	};
+
+	/* SX1509(0) U2605 */
+	gpio6: i2c6_gpioext0@3f {
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+		compatible = "semtech,sx1509q";
+		reg = <0x3f>;
+
+		semtech,probe-reset;
+		gpio-controller;
+		interrupt-controller;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	/* SX1509(1) U2606 */
+	gpio7: i2c6_gpioext1@70 {
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+		compatible = "semtech,sx1509q";
+		reg = <0x70>;
+
+		semtech,probe-reset;
+		gpio-controller;
+		interrupt-controller;
+
+		interrupt-parent = <&gpio4>;
+		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl_tpm: aristainetos3-tpm-grp {
+			pins = "gpio6","gpio7"; // TPM_PP, TPM_LP
+			output-high;
+		};
+	};
+
+	/* RTC U2607 */
+	rtc0: rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+	};
+};
+
+&irqsteer_hdmi {
+	status = "okay";
+};
+
+&lcdif1 {
+	status = "disabled";
+};
+
+&lcdif2 {
+	status = "disabled";
+};
+
+/* HDMI */
+&lcdif3 {
+	status = "okay";
+
+};
+
+&lvds_bridge {
+	status = "disabled";
+};
+
+&mipi_dsi {
+	status = "disabled";
+};
+
+&pcie{
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio4 20 GPIO_ACTIVE_LOW>;
+	ext_osc = <0>;
+	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
+		 <&clk IMX8MP_CLK_PCIE_AUX>,
+		 <&clk IMX8MP_CLK_HSIO_AXI>,
+		 <&clk IMX8MP_CLK_PCIE_ROOT>;
+	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	assigned-clocks = <&clk IMX8MP_CLK_HSIO_AXI>,
+			  <&clk IMX8MP_CLK_PCIE_AUX>;
+	assigned-clock-rates = <500000000>, <10000000>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_500M>,
+				 <&clk IMX8MP_SYS_PLL2_50M>;
+	reserved-region = <&rpmsg_reserved>;
+	fsl,tx-deemph-gen1 = <0x1f>;
+	fsl,max-link-speed = <3>;
+	status = "okay";
+};
+
+&pcie_phy{
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	clocks = <&pcie0_refclk>;
+	clock-names = "ref";
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	#pwm-cells = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usb3_phy0 {
+	fsl,phy-tx-vref-tune = <0xe>;
+	fsl,phy-tx-preemp-amp-tune = <3>;
+	fsl,phy-tx-vboost-level = <5>;
+	fsl,phy-comp-dis-tune = <7>;
+	fsl,pcs-tx-deemph-3p5db = <0x21>;
+	fsl,phy-pcs-tx-swing-full = <0x7f>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	role-switch-default-mode = "peripheral";
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dwc3_0_hs_ep: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usb_c_0_hs_ep>;
+		};
+	};
+};
+
+&usb3_phy1 {
+	fsl,phy-tx-preemp-amp-tune = <3>;
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
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
+/* SD slot */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&buck5>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
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
+	pinctrl-names = "default";
+
+	pinctrl_disp_select:  aristainetos3-dispselect-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD2__GPIO3_IO23		0xd6
+		>;
+	};
+
+	pinctrl_ecspi1: aristainetos3-ecspi1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK		0x82
+			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI		0x82
+			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO		0x82
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09		0x40000
+		>;
+	};
+
+	pinctrl_ecspi1_cs2: aristainetos3-ecspi1-cs2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x40000
+		>;
+	};
+
+	pinctrl_ecspi2: aristainetos3-ecspi2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x82
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x82
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x82
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13		0x40000
+		>;
+	};
+
+	pinctrl_eqos_rgmii: aristainetos3-eqos-rgmii-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x3
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x3
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x91
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x91
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x91
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x91
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x91
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x1f
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x1f
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x1f
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x1f
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x1f
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22				0x19
+		>;
+	};
+
+	pinctrl_fec_rgmii: aristainetos3-fec-rgmii-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
+			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3
+			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91
+			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91
+			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x91
+			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x91
+			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91
+			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91
+			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x1f
+			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x1f
+			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x1f
+			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x1f
+			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f
+			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x1f
+			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x19
+		>;
+	};
+
+	pinctrl_flexcan1: aristainetos3-flexcan1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX			0x154
+			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX			0x154
+		>;
+	};
+
+	pinctrl_flexcan2: aristainetos3-flexcan2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX         0x154
+			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
+		>;
+	};
+
+	pinctrl_flexcan1_reg: aristainetos3-flexcan1-reg-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
+		>;
+	};
+
+	pinctrl_flexcan2_reg: aristainetos3-flexcan2-reg-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
+		>;
+	};
+
+	pinctrl_gpio_led: aristainetos3-gpio-led-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x19
+		>;
+	};
+
+	pinctrl_gpio_led_proton2s: aristainetos3-gpio-proton2s-led-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x19
+			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x19
+		>;
+	};
+
+	pinctrl_gpio_proton2s: aristainetos3-gpio-proton2s-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07	0x19
+		>;
+	};
+
+	pinctrl_hdmi: aristainetos3-hdmi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c3
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x40000019
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x40000019
+		>;
+	};
+
+	pinctrl_i2c1: aristainetos3-i2c1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c1_gpio: aristainetos3-i2c1-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14	0x1c3
+			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15	0x1c3
+		>;
+	};
+
+	pinctrl_i2c2: aristainetos3-i2c2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c3
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c2_gpio: aristainetos3-i2c2-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16	0x1c3
+			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17	0x1c3
+		>;
+	};
+
+	pinctrl_i2c3: aristainetos3-i2c3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c3_gpio: aristainetos3-i2c3-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18	0x1c3
+			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19	0x1c3
+		>;
+	};
+
+	pinctrl_i2c5: aristainetos3-i2c5-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD0__I2C5_SCL	0x400001c3
+			MX8MP_IOMUXC_SAI5_MCLK__I2C5_SDA	0x400001c3
+		>;
+	};
+
+	pinctrl_i2c6: aristainetos3-i2c6-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL	0x400001c3
+			MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c6_gpio: aristainetos3-i2c6-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19	0x1c3
+			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20	0x1c3
+		>;
+	};
+
+	pinctrl_i2c6_rtc_irq: aristainetos3-i2c6-rtc-irq-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD1__GPIO3_IO22		0xd6
+		>;
+	};
+
+	pinctrl_i2c6_tpm_irq: aristainetos3-i2c6-tpm-irq-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14		0xd6
+		>;
+	};
+
+	pinctrl_lcd0_vdd_en: aristainetos3-lcd0-vdden-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0xd6
+		>;
+	};
+
+	pinctrl_lcd1_vdd_en: aristainetos3-lcd1-vdden-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0xd6
+		>;
+	};
+
+	pinctrl_lvds_pwr_en: aristainetos3-lvds-pwren-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0xd6
+		>;
+	};
+
+	pinctrl_pcie: aristainetos3-pcie-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B		0x61
+			MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20		0x41
+		>;
+	};
+
+	pinctrl_pmic: aristainetos3-pmic-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x41
+		>;
+	};
+
+	pinctrl_pwm1: aristainetos3-pwm1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__PWM1_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm2: aristainetos3-pwm2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO11__PWM2_OUT	0x116
+		>;
+	};
+
+	pinctrl_uart1: aristainetos3-uart1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart1_rs485: aristainetos3-uart1-rs485-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
+			MX8MP_IOMUXC_SD1_DATA0__GPIO2_IO02	0x140
+		>;
+	};
+
+	pinctrl_uart2: aristainetos3-uart2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x140
+			MX8MP_IOMUXC_SD1_DATA5__UART2_DCE_CTS	0x140
+		>;
+	};
+
+	pinctrl_uart3: aristainetos3-uart3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_ALE__UART3_DCE_RX	0x140
+			MX8MP_IOMUXC_NAND_CE0_B__UART3_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart3_rs485: aristainetos3-uart3-rs485-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_ALE__UART3_DCE_RX	0x140
+			MX8MP_IOMUXC_NAND_CE0_B__UART3_DCE_TX	0x140
+			MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10	0x140
+		>;
+	};
+
+	pinctrl_uart4: aristainetos3-uart4-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX    0x140
+			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX    0x140
+			MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x140
+			MX8MP_IOMUXC_NAND_DATA02__UART4_DCE_CTS 0x140
+		>;
+	};
+
+	pinctrl_usb1_vbus: aristainetos3-usb1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x19
+		>;
+	};
+
+	pinctrl_usdhc1: aristainetos3-usdhc1-grp {
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
+	pinctrl_usdhc1_100mhz: aristainetos3-usdhc1-100mhz-grp {
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
+	pinctrl_usdhc1_200mhz: aristainetos3-usdhc1-200mhz-grp {
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
+	pinctrl_usdhc2: aristainetos3-usdhc2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: aristainetos3-usdhc2-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: aristainetos3-usdhc2-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: aristainetos3-usdhc2-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x40000080
+		>;
+	};
+
+	pinctrl_usdhc2_vmmc: aristainetos3-usdhc2-vmmc-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
+		>;
+	};
+
+	pinctrl_usdhc3: aristainetos3-usdhc3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: aristainetos3-usdhc3-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: aristainetos3-usdhc3-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
+		>;
+	};
+
+	pinctrl_watchdog_gpio: aristainetos3-wdog-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x19
+		>;
+	};
+
+	pinctrl_wdog: aristainetos3-wdog-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0xc6
+		>;
+	};
+};
-- 
2.20.1


