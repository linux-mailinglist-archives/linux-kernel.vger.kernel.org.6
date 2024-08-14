Return-Path: <linux-kernel+bounces-286046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A99515CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C221C22B51
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE413D298;
	Wed, 14 Aug 2024 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h8OdDONr"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17901411E6;
	Wed, 14 Aug 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621691; cv=none; b=lccRqcwE1bB23zM2SkN/vbsz7tZatXfdCnIElL/Dn7U8savXa5ZaIqeH7DDBckQe+BMVCaudhVx7fj45NqCgs3o7h+NObfKELxbYf3cd1LMY0aMcVJl1aPtwZdoJQG/37kB/fRrE0HkmOSuIfa2sleZLdXVyDYuY/3oXW7M9Y0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621691; c=relaxed/simple;
	bh=aHj/7FNn0DoPn17r60UPCCEoxDsKo0OQksFH02RaHKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IA92lVKSJsQ1MzEQMt61l5yJpX8jVZktdCXb/V0McCPLvyWJZqjvwdmVcdsB5BQ4nz+kfuXjl/8zdCVqZLmZ/f3q3WIY04Py3ut6LAc/kW4foNhL4u8TZFTCotwy/omIZ4AcxFmrFeJWp+XQhoFr41SmoihQbxGbZsVDFYszNLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h8OdDONr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E7lwrC038627;
	Wed, 14 Aug 2024 02:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723621678;
	bh=qS+BW/hgTndHzCxIYVO0zPWWillkrRHOe5vLymlBpu8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=h8OdDONrTDEDC9TWIm5wcqDKAdL/oK8HRJPKwZiEakK54cU7OEQcK72AjBfMOpJRh
	 BPuM9O0xQ/UmX2oiIX4fqc6Apwl04cHfogTXuq+LiJ41XPbNRL8QiUV9NG3rZLE/1Q
	 Bh/oWOu+alAa2qZ2/sCzkNzOXR062SXMeFZqi8XM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E7lwBS075499
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 02:47:58 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 02:47:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 02:47:58 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E7lT2J059812;
	Wed, 14 Aug 2024 02:47:54 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 14 Aug 2024 13:17:32 +0530
Subject: [PATCH v4 5/5] arm64: dts: ti: k3-j7200*: Add bootph-* properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240814-b4-upstream-bootph-all-v4-5-f2b462000f25@ti.com>
References: <20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com>
In-Reply-To: <20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis
	<afd@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723621650; l=9880;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=aHj/7FNn0DoPn17r60UPCCEoxDsKo0OQksFH02RaHKU=;
 b=GNfXWZYTEA30vviK7G/EaAhzE4OO3NEBl1khCWx9KMHXbN6Z5tVsyLYx0j3XTC4wBC4W78tH1
 ZmrTqEkYOD+Cp/F2y0d6N1xPxtnTIpPlT8EgkwwbWcfZjunWr8KosBW
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Adds bootph-* properties to the leaf nodes to enable bootloaders to
utilise them.

Reviewed-by: Aniket Limaye <a-limaye@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 .../arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi            |  2 ++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 13 ++++++++++++-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi          |  7 +++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 6593c5da82c0..134a43346c13 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -129,6 +129,7 @@ J721E_WKUP_IOPAD(0x94, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
 			J721E_WKUP_IOPAD(0x8c, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
 			J721E_WKUP_IOPAD(0x88, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
@@ -136,6 +137,7 @@ wkup_uart0_pins_default: wkup-uart0-default-pins {
 			J721E_WKUP_IOPAD(0x48, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
 			J721E_WKUP_IOPAD(0x4c, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
@@ -159,6 +161,7 @@ wkup_gpio_pins_default: wkup-gpio-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x70, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_6 */
 		>;
+		bootph-all;
 	};
 
 	mcu_mdio_pins_default: mcu-mdio1-default-pins {
@@ -204,6 +207,7 @@ J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
 			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
 			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
 		>;
+		bootph-all;
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
@@ -238,6 +242,7 @@ J721E_IOPAD(0xf0, PIN_INPUT, 0) /* (N20) MMC1_DAT2 */
 			J721E_IOPAD(0xec, PIN_INPUT, 0) /* (N19) MMC1_DAT3 */
 			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
 		>;
+		bootph-all;
 	};
 
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
@@ -259,6 +264,7 @@ main_usbss0_pins_default: main-usbss0-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
 		>;
+		bootph-all;
 	};
 };
 
@@ -267,12 +273,14 @@ &wkup_uart0 {
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
+	bootph-all;
 };
 
 &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
+	bootph-all;
 };
 
 &main_uart0 {
@@ -281,6 +289,7 @@ &main_uart0 {
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
+	bootph-all;
 };
 
 &main_uart1 {
@@ -310,6 +319,7 @@ &wkup_gpio0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_gpio_pins_default>;
+	bootph-all;
 };
 
 &mcu_cpsw {
@@ -341,6 +351,7 @@ exp1: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		bootph-all;
 	};
 
 	exp2: gpio@22 {
@@ -348,6 +359,7 @@ exp2: gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		bootph-all;
 	};
 };
 
@@ -381,6 +393,7 @@ &main_sdhci0 {
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
+	bootph-all;
 };
 
 &main_sdhci1 {
@@ -392,20 +405,24 @@ &main_sdhci1 {
 	vqmmc-supply = <&vdd_sd_dv>;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
+	bootph-all;
 };
 
 &serdes_ln_ctrl {
 	idle-states = <J7200_SERDES0_LANE0_PCIE1_LANE0>, <J7200_SERDES0_LANE1_PCIE1_LANE1>,
 		      <J7200_SERDES0_LANE2_QSGMII_LANE1>, <J7200_SERDES0_LANE3_IP4_UNUSED>;
+	bootph-all;
 };
 
 &usb_serdes_mux {
 	idle-states = <1>; /* USB0 to SERDES lane 3 */
+	bootph-all;
 };
 
 &usbss0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss0_pins_default>;
+	bootph-all;
 	ti,vbus-divider;
 	ti,usb2-only;
 };
@@ -413,6 +430,7 @@ &usbss0 {
 &usb0 {
 	dr_mode = "otg";
 	maximum-speed = "high-speed";
+	bootph-all;
 };
 
 &tscadc0 {
@@ -432,6 +450,7 @@ serdes0_pcie_link: phy@0 {
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_PCIE>;
 		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
+		bootph-all;
 	};
 
 	serdes0_qsgmii_link: phy@1 {
@@ -440,6 +459,7 @@ serdes0_qsgmii_link: phy@1 {
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_QSGMII>;
 		resets = <&serdes_wiz0 3>;
+		bootph-all;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 9386bf3ef9f6..ac9c0a939461 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -136,6 +136,7 @@ secure_proxy_main: mailbox@32c00000 {
 			      <0x00 0x32800000 0x00 0x100000>;
 			interrupt-names = "rx_011";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			bootph-all;
 		};
 
 		hwspinlock: spinlock@30e00000 {
@@ -1527,6 +1528,7 @@ main_r5fss0_core1: r5f@5d00000 {
 	main_esm: esm@700000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x0 0x700000 0x0 0x1000>;
+		bootph-pre-ram;
 		ti,esm-pins = <656>, <657>;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 5097d192c2b2..7fc6f268bfe6 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -21,16 +21,19 @@ dmsc: system-controller@44083000 {
 		k3_pds: power-controller {
 			compatible = "ti,sci-pm-domain";
 			#power-domain-cells = <2>;
+			bootph-all;
 		};
 
 		k3_clks: clock-controller {
 			compatible = "ti,k2g-sci-clk";
 			#clock-cells = <2>;
+			bootph-all;
 		};
 
 		k3_reset: reset-controller {
 			compatible = "ti,sci-reset";
 			#reset-cells = <2>;
+			bootph-all;
 		};
 	};
 
@@ -44,6 +47,7 @@ mcu_timer0: timer@40400000 {
 		assigned-clocks = <&k3_clks 35 1>;
 		assigned-clock-parents = <&k3_clks 35 2>;
 		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		bootph-pre-ram;
 		ti,timer-pwm;
 	};
 
@@ -191,6 +195,7 @@ wkup_conf: bus@43000000 {
 		chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
+			bootph-all;
 		};
 	};
 
@@ -344,6 +349,7 @@ mcu_ringacc: ringacc@2b800000 {
 			      <0x00 0x28440000 0x00 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg",
 				    "proxy_target", "cfg";
+			bootph-all;
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
@@ -363,6 +369,7 @@ mcu_udmap: dma-controller@285c0000 {
 				    "tchan", "rchan", "rflow";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
+			bootph-all;
 
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <236>;
@@ -383,6 +390,8 @@ secure_proxy_mcu: mailbox@2a480000 {
 		reg = <0x0 0x2a480000 0x0 0x80000>,
 		      <0x0 0x2a380000 0x0 0x80000>,
 		      <0x0 0x2a400000 0x0 0x80000>;
+		bootph-pre-ram;
+
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -534,6 +543,7 @@ hbmc_mux: mux-controller@47000004 {
 			reg = <0x00 0x47000004 0x00 0x4>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x0 0x2>; /* HBMC select */
+			bootph-all;
 		};
 
 		hbmc: hyperbus@47034000 {
@@ -652,13 +662,14 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x42050000 0x00 0x350>;
 		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	mcu_esm: esm@40800000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x40800000 0x00 0x1000>;
-		ti,esm-pins = <95>;
 		bootph-pre-ram;
+		ti,esm-pins = <95>;
 	};
 
 	mcu_mcan0: can@40528000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index 89b68325e4e2..2b4aa02b2077 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -121,6 +121,7 @@ J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (B8) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
 			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (A8) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
 			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
 		>;
+		bootph-all;
 	};
 
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
@@ -137,6 +138,7 @@ J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
 			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
 			J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
 		>;
+		bootph-all;
 	};
 };
 
@@ -146,6 +148,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 			J721E_WKUP_IOPAD(0x98, PIN_INPUT_PULLUP, 0) /* (F20) WKUP_I2C0_SCL */
 			J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
 		>;
+		bootph-all;
 	};
 };
 
@@ -163,6 +166,7 @@ main_i2c0_pins_default: main-i2c0-default-pins {
 			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
 			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
 		>;
+		bootph-all;
 	};
 
 	main_mcan0_pins_default: main-mcan0-default-pins {
@@ -186,6 +190,7 @@ &hbmc {
 	flash@0,0 {
 		compatible = "cypress,hyperflash", "cfi-flash";
 		reg = <0x00 0x00 0x4000000>;
+		bootph-all;
 
 		partitions {
 			compatible = "fixed-partitions";
@@ -330,6 +335,7 @@ bucka1: buck1 {
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			bucka2: buck2 {
@@ -503,6 +509,7 @@ partition@800000 {
 			partition@3fc0000 {
 				label = "ospi.phypattern";
 				reg = <0x3fc0000 0x40000>;
+				bootph-all;
 			};
 		};
 	};

-- 
2.46.0


