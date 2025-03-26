Return-Path: <linux-kernel+bounces-577457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB61A71D34
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6868C176552
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4923C8A9;
	Wed, 26 Mar 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="arDpxXX2"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97821767B;
	Wed, 26 Mar 2025 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010471; cv=none; b=DpD0glZI/k2VDvQv2EYsDJoCVO8/fscT+XNPT3YwFidhb6JrG+8MSpE8CNCCAsCowWr5MRsdUW8C9szv3WNsQBUWeMIzLQb52ruOx4RgrzjPeYZ1HGR0mRfUq7VkQ6pq0J2pKU+X34/ZL0lY80yOEfkal0eB2EaseJIlfLJpmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010471; c=relaxed/simple;
	bh=IVMKgayk/wm1ZTUoIFqiZ1irK5MDlnkRKXQmO/1F6pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrgOfCqoq3p97+ye9ryjxTHdvZqvhsSFh+d80IOQwC64+P4fNFli/vHcEOxsbZik0OmbeH953NEyJkG9IisRH0zSXL5A5012IGXB/MVXvMyQeXGXklWnzgtKdpSgzieWl5O377WkwMSzW4KJT/16kX+QzotcI+yhOsAarm6wqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=arDpxXX2; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CFCE101CA7F1;
	Wed, 26 Mar 2025 18:34:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743010466; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qJTpC5sAhsfwgi4VUrQhS89cZHgib6KieAtnayphjY8=;
	b=arDpxXX2gK1beIIYcB/7ptMVLO6s0Gr6S4rMnA5Iiq+KSyqMU0l760UmMtNPsCSRipy5cu
	JS2RFZF08JXfP+EeveXmqHx/Djaaenq4Vt8xzCNi4sLZ5oAVoC/ysW+CovtSwa6pF6/Bf0
	0/o6NsxS7PPEvSVL+Vj2x29crj01IgLjzA8brnzAJW8VK5Q+JgjGcH7hED2Uh44ayRHKgD
	15OCy6hSQhHnNILSN6VgOTl8FtJsprdP2Jy4zrNyk+xBLPIbvhVGWD+0JnM53QSFE52IBR
	LXINR0YakdwQwMX+CfBEKjaIOy6GPkUAhGPrOjLTfLc5shrzPh9A3qyMFIVa5w==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/2] ARM: dts: mxs: Add support for second revision of the XEA board (imx287)
Date: Wed, 26 Mar 2025 18:34:00 +0100
Message-Id: <20250326173400.2697684-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250326173400.2697684-1-lukma@denx.de>
References: <20250326173400.2697684-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Up till now the XEA had only single revision supported in Linux kernel.

As some in-HW adjustments were made - it has been required to extend
the support with second version.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/nxp/mxs/Makefile        |   3 +-
 arch/arm/boot/dts/nxp/mxs/imx28-xea-1.dts |  29 ++++
 arch/arm/boot/dts/nxp/mxs/imx28-xea-2.dts |  66 ++++++++
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts   | 100 -----------
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dtsi  | 191 ++++++++++++++++++++++
 5 files changed, 288 insertions(+), 101 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-xea-1.dts
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-xea-2.dts
 delete mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-xea.dtsi

diff --git a/arch/arm/boot/dts/nxp/mxs/Makefile b/arch/arm/boot/dts/nxp/mxs/Makefile
index 96dd31ea19ba..de4cafd820c2 100644
--- a/arch/arm/boot/dts/nxp/mxs/Makefile
+++ b/arch/arm/boot/dts/nxp/mxs/Makefile
@@ -31,4 +31,5 @@ dtb-$(CONFIG_ARCH_MXS) += \
 	imx28-sps1.dtb \
 	imx28-ts4600.dtb \
 	imx28-tx28.dtb \
-	imx28-xea.dtb
+	imx28-xea-1.dtb \
+	imx28-xea-2.dtb
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea-1.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea-1.dts
new file mode 100644
index 000000000000..a56c9930752a
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea-1.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2025
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx28-xea.dtsi"
+
+/ {
+	model = "XEA v1";
+};
+
+&pinctrl {
+	pinctrl-0 = <&hog_pins_a &hog_pins_tiva &hog_pins_rev1>;
+
+	hog_pins_rev1: hog@3 {
+		reg = <3>;
+		fsl,pinmux-ids = <
+			MX28_PAD_SSP1_SCK__GPIO_2_12
+			MX28_PAD_SSP1_SCK__GPIO_2_12
+			MX28_PAD_SSP2_SS1__GPIO_2_20
+			MX28_PAD_SSP2_SS2__GPIO_2_21
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea-2.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea-2.dts
new file mode 100644
index 000000000000..498905def9c1
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea-2.dts
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2025
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx28-xea.dtsi"
+
+/ {
+	model = "XEA v2";
+};
+
+&pinctrl {
+	pinctrl-0 = <&hog_pins_a &hog_pins_tiva &hog_pins_rev1>;
+
+	hog_pins_rev1: hog@3 {
+		reg = <3>;
+		fsl,pinmux-ids = <
+			MX28_PAD_SAIF0_LRCLK__GPIO_3_21
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
+	spi1_pins_a: spi1@0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_SSP1_SCK__SSP1_SCK
+			MX28_PAD_SSP1_CMD__SSP1_CMD
+			MX28_PAD_SSP1_DATA0__SSP1_D0
+			MX28_PAD_SSP1_DATA3__GPIO_2_15
+		>;
+		fsl,drive-strength = <MXS_DRIVE_8mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_ENABLE>;
+	};
+};
+
+&ssp1 {
+	compatible = "fsl,imx28-spi";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins_a>;
+	status = "okay";
+
+	spidev0@0 {
+		compatible = "lwn,btt";
+		spi-max-frequency = <100000000>;
+		reg = <0>;
+	};
+
+	spidev2@2 {
+		compatible = "lwn,btt";
+		spi-max-frequency = <100000000>;
+		reg = <2>;
+	};
+};
+
+&ssp3 {
+	spidev1@1 {
+		compatible = "lwn,btt";
+		spi-max-frequency = <100000000>;
+		reg = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
deleted file mode 100644
index 6c5e6856648a..000000000000
--- a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
+++ /dev/null
@@ -1,100 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright 2021
- * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
- */
-
-/dts-v1/;
-#include "imx28-lwe.dtsi"
-
-/ {
-	model = "Liebherr XEA board";
-	compatible = "lwn,imx28-xea", "fsl,imx28";
-};
-
-&can0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&can1_pins_a>;
-	status = "okay";
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_b>;
-	status = "okay";
-};
-
-&pinctrl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hog_pins_a &hog_pins_tiva>;
-
-	hog_pins_a: hog@0 {
-		reg = <0>;
-		fsl,pinmux-ids = <
-			MX28_PAD_GPMI_D00__GPIO_0_0
-			MX28_PAD_GPMI_D02__GPIO_0_2
-			MX28_PAD_GPMI_D05__GPIO_0_5
-			MX28_PAD_GPMI_CE1N__GPIO_0_17
-			MX28_PAD_GPMI_RDY0__GPIO_0_20
-			MX28_PAD_GPMI_RDY1__GPIO_0_21
-			MX28_PAD_GPMI_RDY2__GPIO_0_22
-			MX28_PAD_GPMI_RDN__GPIO_0_24
-			MX28_PAD_GPMI_CLE__GPIO_0_27
-			MX28_PAD_LCD_VSYNC__GPIO_1_28
-			MX28_PAD_SSP1_SCK__GPIO_2_12
-			MX28_PAD_SSP1_CMD__GPIO_2_13
-			MX28_PAD_SSP2_SS1__GPIO_2_20
-			MX28_PAD_SSP2_SS2__GPIO_2_21
-			MX28_PAD_LCD_D00__GPIO_1_0
-			MX28_PAD_LCD_D01__GPIO_1_1
-			MX28_PAD_LCD_D02__GPIO_1_2
-			MX28_PAD_LCD_D03__GPIO_1_3
-			MX28_PAD_LCD_D04__GPIO_1_4
-			MX28_PAD_LCD_D05__GPIO_1_5
-			MX28_PAD_LCD_D06__GPIO_1_6
-		>;
-		fsl,drive-strength = <MXS_DRIVE_4mA>;
-		fsl,voltage = <MXS_VOLTAGE_HIGH>;
-		fsl,pull-up = <MXS_PULL_DISABLE>;
-	};
-
-	hog_pins_tiva: hog@1 {
-		reg = <1>;
-		fsl,pinmux-ids = <
-			MX28_PAD_GPMI_RDY3__GPIO_0_23
-			MX28_PAD_GPMI_WRN__GPIO_0_25
-		>;
-		fsl,voltage = <MXS_VOLTAGE_HIGH>;
-		fsl,pull-up = <MXS_PULL_DISABLE>;
-	};
-
-	hog_pins_coding: hog@2 {
-		reg = <2>;
-		fsl,pinmux-ids = <
-			MX28_PAD_GPMI_D01__GPIO_0_1
-			MX28_PAD_GPMI_D03__GPIO_0_3
-			MX28_PAD_GPMI_D04__GPIO_0_4
-			MX28_PAD_GPMI_D06__GPIO_0_6
-			MX28_PAD_GPMI_D07__GPIO_0_7
-		>;
-		fsl,voltage = <MXS_VOLTAGE_HIGH>;
-		fsl,pull-up = <MXS_PULL_DISABLE>;
-	};
-};
-
-&reg_fec_3v3 {
-	gpio = <&gpio0 0 0>;
-};
-
-&reg_usb_5v {
-	gpio = <&gpio0 2 0>;
-};
-
-&spi2_pins_a {
-	fsl,pinmux-ids = <
-		MX28_PAD_SSP2_SCK__SSP2_SCK
-		MX28_PAD_SSP2_MOSI__SSP2_CMD
-		MX28_PAD_SSP2_MISO__SSP2_D0
-		MX28_PAD_SSP2_SS0__GPIO_2_19
-	>;
-};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dtsi
new file mode 100644
index 000000000000..adbdc3871045
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dtsi
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2025
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx28-lwe.dtsi"
+
+/ {
+	compatible = "lwn,imx28-xea", "fsl,imx28";
+
+	reg_standby: regulator-standby {
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 20 GPIO_ACTIVE_LOW>;
+		regulator-name = "enable-standby";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&can1_pins_a>;
+	xceiver-supply = <&reg_usb_5v>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_b>;
+	status = "okay";
+};
+
+&eth_switch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
+	phy-supply = <&reg_fec_3v3>;
+	phy-reset-duration = <25>;
+	phy-reset-post-delay = <10>;
+	status = "okay";
+
+	ethernet-ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mtip_port1: port@1 {
+			reg = <1>;
+			label = "lan0";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy0>;
+		};
+
+		mtip_port2: port@2 {
+			reg = <2>;
+			label = "lan1";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy1>;
+		};
+	};
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			smsc,disable-energy-detect;
+			/* Both PHYs (i.e. 0,1) have the same, single GPIO, */
+			/* line to handle both, their interrupts (AND'ed) */
+			interrupt-parent = <&gpio4>;
+			interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		};
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			smsc,disable-energy-detect;
+			interrupt-parent = <&gpio4>;
+			interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
+};
+
+&mac0 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mac0_pins_a>;
+	phy-supply = <&reg_fec_3v3>;
+	phy-reset-duration = <100>;
+	local-mac-address = [ 00 11 B8 00 BF 8A ];
+	status = "okay";
+};
+
+&mac1 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mac1_pins_a>;
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hog_pins_a &hog_pins_tiva>;
+
+	hog_pins_a: hog@0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_D00__GPIO_0_0
+			MX28_PAD_GPMI_D02__GPIO_0_2
+			MX28_PAD_GPMI_D05__GPIO_0_5
+			MX28_PAD_GPMI_CE1N__GPIO_0_17
+			MX28_PAD_GPMI_RDY0__GPIO_0_20
+			MX28_PAD_GPMI_RDY1__GPIO_0_21
+			MX28_PAD_GPMI_RDY2__GPIO_0_22
+			MX28_PAD_GPMI_RDN__GPIO_0_24
+			MX28_PAD_GPMI_CLE__GPIO_0_27
+			MX28_PAD_LCD_VSYNC__GPIO_1_28
+			MX28_PAD_LCD_D00__GPIO_1_0
+			MX28_PAD_LCD_D01__GPIO_1_1
+			MX28_PAD_LCD_D02__GPIO_1_2
+			MX28_PAD_LCD_D03__GPIO_1_3
+			MX28_PAD_LCD_D04__GPIO_1_4
+			MX28_PAD_LCD_D05__GPIO_1_5
+			MX28_PAD_LCD_D06__GPIO_1_6
+			MX28_PAD_LCD_D15__GPIO_1_15
+			MX28_PAD_LCD_D16__GPIO_1_16
+			MX28_PAD_LCD_D17__GPIO_1_17
+			MX28_PAD_LCD_D18__GPIO_1_18
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
+	hog_pins_tiva: hog@1 {
+		reg = <1>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_RDY3__GPIO_0_23
+			MX28_PAD_GPMI_WRN__GPIO_0_25
+		>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
+	hog_pins_coding: hog@2 {
+		reg = <2>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_D01__GPIO_0_1
+			MX28_PAD_GPMI_D03__GPIO_0_3
+			MX28_PAD_GPMI_D04__GPIO_0_4
+			MX28_PAD_GPMI_D06__GPIO_0_6
+			MX28_PAD_GPMI_D07__GPIO_0_7
+		>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+};
+
+&reg_fec_3v3 {
+	gpio = <&gpio0 0 0>;
+};
+
+&reg_usb_5v {
+	gpio = <&gpio0 2 0>;
+};
+
+&ssp2 {
+	spidev1@1 {
+		compatible = "lwn,btt";
+		spi-max-frequency = <100000000>;
+		reg = <1>;
+	};
+
+	spidev2@2 {
+		compatible = "lwn,btt";
+		spi-max-frequency = <100000000>;
+		reg = <2>;
+	};
+};
+
+&spi2_pins_a {
+	fsl,pinmux-ids = <
+		MX28_PAD_SSP2_SCK__SSP2_SCK
+		MX28_PAD_SSP2_MOSI__SSP2_CMD
+		MX28_PAD_SSP2_MISO__SSP2_D0
+		MX28_PAD_SSP2_SS0__GPIO_2_19
+	>;
+};
-- 
2.39.5


