Return-Path: <linux-kernel+bounces-520170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF339A3A674
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F781883F65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87631E521C;
	Tue, 18 Feb 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n821mRkz"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2645272921;
	Tue, 18 Feb 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904933; cv=none; b=hchwUsSyBE7ECGsUh2ie1Ilj2aTYaXQ/AjssV0TjkVDJxePuUssOTTYP1D1M11X101kLlK4JbB/BtZOouXho0GFNbySa6Qw1LyhPJpdc2nMEvXDnB+xSfjGPDMASAO0kztEIpGvKveU7GXVXpBtuxx1BNtjm2kbG5k5NcRtHVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904933; c=relaxed/simple;
	bh=7QwO5VpPa8TZk35dGV2bd9HRVK2dvnnv0gedlR8nZ4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIbsjceBzWocCYpVzYscCLlKubUV85SEplnit75rkva2CTA2TlLwWifAlT7kv/QT9TBoue6pt7cCTEcrpFEE6nZHx1tMWiBAsJUm4JH7QQ1GTbZgefOpsU/3PHXU3QK1obN/RAdh84buctWzAkGUVSbeX+vMe2b4aCt+AvdMsIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n821mRkz; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51IItFwD061510
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 12:55:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739904915;
	bh=IK6z3Ci1qusIgI4R2i0RypC0roG8nXLJttUEzNVDJi4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=n821mRkz5F1LxxPTHshr2bBlmmk326IwMwGsmfVEMbleMOvqxjXHEQ71V6M0QCGvM
	 iZ3Sl2+ZeM4KU/pROQSSojYAL7SLLh0yOr/Yme7FkedHKwIw4iHdrxrTTxtygHvr+G
	 VwMeKgthlMtlReGPqJRWesguwMySrjR4Fv2gzGgM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51IItF0l021310
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Feb 2025 12:55:15 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 12:55:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 12:55:14 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51IIsrxd123821;
	Tue, 18 Feb 2025 12:55:11 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <jai.luthra@linux.dev>,
        <y-abhilashchandra@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 5/5] arm64: dts: ti: k3-j722s-evm: Add overlay for TEVI OV5640
Date: Wed, 19 Feb 2025 00:24:52 +0530
Message-ID: <20250218185452.600797-6-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218185452.600797-1-vaishnav.a@ti.com>
References: <20250218185452.600797-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

TechNexion TEVI OV5640 camera is a 5MP camera that can be used with
J722S EVM through the 22-pin CSI-RX connector. Add a reference overlay
for quad TEVI OV5640 modules on J722S EVM.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   4 +
 .../k3-j722s-evm-csi2-quad-tevi-ov5640.dtso   | 319 ++++++++++++++++++
 2 files changed, 323 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-tevi-ov5640.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9ae0917e5763..0370392abda8 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -120,6 +120,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am67a-beagley-ai.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
 
 # Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
@@ -212,6 +213,8 @@ k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
 	k3-j721s2-evm-pcie1-ep.dtbo
 k3-j722s-evm-csi2-quad-rpi-cam-imx219-dtbs := k3-j722s-evm.dtb \
 	k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
+k3-j722s-evm-csi2-quad-tevi-ov5640-dtbs := k3-j722s-evm.dtb \
+	k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
 k3-j784s4-evm-pcie0-pcie1-ep-dtbs := k3-j784s4-evm.dtb \
 	k3-j784s4-evm-pcie0-pcie1-ep.dtbo
 k3-j784s4-evm-quad-port-eth-exp1-dtbs := k3-j784s4-evm.dtb \
@@ -247,6 +250,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtb \
 	k3-j721s2-evm-pcie1-ep.dtb \
 	k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtb \
+	k3-j722s-evm-csi2-quad-tevi-ov5640.dtb \
 	k3-j784s4-evm-pcie0-pcie1-ep.dtb \
 	k3-j784s4-evm-quad-port-eth-exp1.dtb \
 	k3-j784s4-evm-usxgmii-exp1-exp2.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-tevi-ov5640.dtso
new file mode 100644
index 000000000000..f33f50465a07
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-tevi-ov5640.dtso
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * 4 x TEVI OV5640 MIPI Camera module on RPI camera connector.
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-pinctrl.h"
+
+&{/} {
+	clk_ov5640_fixed: ov5640-xclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+};
+
+
+&main_pmx0 {
+	cam0_reset_pins_default: cam0-reset-pins-default {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x03c, PIN_OUTPUT, 7)
+		>;
+	};
+
+	cam1_reset_pins_default: cam1-reset-pins-default {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x044, PIN_OUTPUT, 7)
+		>;
+	};
+
+	cam2_reset_pins_default: cam2-reset-pins-default {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x04c, PIN_OUTPUT, 7)
+		>;
+	};
+
+	cam3_reset_pins_default: cam3-reset-pins-default {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x054, PIN_OUTPUT, 7)
+		>;
+	};
+};
+
+&exp1 {
+	p06-hog{
+		/* P06 - CSI01_MUX_SEL_2 */
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "CSI01_MUX_SEL_2";
+	};
+
+	p07-hog{
+		/* P01 - CSI23_MUX_SEL_2 */
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "CSI23_MUX_SEL_2";
+	};
+};
+
+&main_gpio0 {
+	p15-hog {
+		/* P15 - CSI2_CAMERA_GPIO1 */
+		gpio-hog;
+		gpios = <15 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "CSI2_CAMERA_GPIO1";
+	};
+
+	p17-hog {
+		/* P17 - CSI2_CAMERA_GPIO2 */
+		gpio-hog;
+		gpios = <17 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "CSI2_CAMERA_GPIO2";
+	};
+
+	p19-hog {
+		/* P19 - CSI2_CAMERA_GPIO3 */
+		gpio-hog;
+		gpios = <19 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "CSI2_CAMERA_GPIO3";
+	};
+
+	p21-hog {
+		/* P21 - CSI2_CAMERA_GPIO4 */
+		gpio-hog;
+		gpios = <21 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "CSI2_CAMERA_GPIO4";
+	};
+};
+
+&pca9543_0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	i2c-alias-pool = /bits/ 16 <0x3c 0x3d>;
+
+	i2c@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+
+		ov5640_0: camera@3c {
+			compatible = "ovti,ov5640";
+			reg = <0x3c>;
+			clocks = <&clk_ov5640_fixed>;
+			clock-names = "xclk";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&cam0_reset_pins_default>;
+
+			port {
+				csi2_cam0: endpoint {
+					remote-endpoint = <&csi2rx0_in_sensor>;
+					clock-lanes = <0>;
+					data-lanes = <1 2>;
+				};
+			};
+		};
+	};
+
+	i2c@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>;
+
+		ov5640_1: camera@3c {
+			compatible = "ovti,ov5640";
+			reg = <0x3c>;
+			clocks = <&clk_ov5640_fixed>;
+			clock-names = "xclk";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&cam1_reset_pins_default>;
+
+			port {
+				csi2_cam1: endpoint {
+					remote-endpoint = <&csi2rx1_in_sensor>;
+					clock-lanes = <0>;
+					data-lanes = <1 2>;
+				};
+			};
+		};
+	};
+};
+
+&pca9543_1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	i2c-alias-pool = /bits/ 16 <0x3c 0x3d>;
+
+	i2c@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+
+		ov5640_2: camera@3c {
+			compatible = "ovti,ov5640";
+			reg = <0x3c>;
+			clocks = <&clk_ov5640_fixed>;
+			clock-names = "xclk";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&cam2_reset_pins_default>;
+
+			port {
+				csi2_cam2: endpoint {
+					remote-endpoint = <&csi2rx2_in_sensor>;
+					clock-lanes = <0>;
+					data-lanes = <1 2>;
+				};
+			};
+		};
+	};
+
+	i2c@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>;
+
+		ov5640_3: camera@3c {
+			compatible = "ovti,ov5640";
+			reg = <0x3c>;
+			clocks = <&clk_ov5640_fixed>;
+			clock-names = "xclk";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&cam3_reset_pins_default>;
+
+			port {
+				csi2_cam3: endpoint {
+					remote-endpoint = <&csi2rx3_in_sensor>;
+					clock-lanes = <0>;
+					data-lanes = <1 2>;
+				};
+			};
+		};
+	};
+};
+
+&cdns_csi2rx0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi0_port0: port@0 {
+			reg = <0>;
+			status = "okay";
+
+			csi2rx0_in_sensor: endpoint {
+				remote-endpoint = <&csi2_cam0>;
+				bus-type = <4>; /* CSI2 DPHY */
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&cdns_csi2rx1 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi1_port0: port@0 {
+			reg = <0>;
+			status = "okay";
+
+			csi2rx1_in_sensor: endpoint {
+				remote-endpoint = <&csi2_cam1>;
+				bus-type = <4>; /* CSI2 DPHY */
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&cdns_csi2rx2 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi2_port0: port@0 {
+			reg = <0>;
+			status = "okay";
+
+			csi2rx2_in_sensor: endpoint {
+				remote-endpoint = <&csi2_cam2>;
+				bus-type = <4>; /* CSI2 DPHY */
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&cdns_csi2rx3 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi3_port0: port@0 {
+			reg = <0>;
+			status = "okay";
+
+			csi2rx3_in_sensor: endpoint {
+				remote-endpoint = <&csi2_cam3>;
+				bus-type = <4>; /* CSI2 DPHY */
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&ti_csi2rx0 {
+	status = "okay";
+};
+
+&dphy0 {
+	status = "okay";
+};
+
+&ti_csi2rx1 {
+	status = "okay";
+};
+
+&dphy1 {
+	status = "okay";
+};
+
+
+&ti_csi2rx2 {
+	status = "okay";
+};
+
+&dphy2 {
+	status = "okay";
+};
+
+
+&ti_csi2rx3 {
+	status = "okay";
+};
+
+&dphy3 {
+	status = "okay";
+};
-- 
2.34.1


