Return-Path: <linux-kernel+bounces-241972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA0492820F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6D01C22188
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C189F145B10;
	Fri,  5 Jul 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ke3I8Cyn"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8787A1448F6;
	Fri,  5 Jul 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160818; cv=none; b=poUBwllCdL/EVqC4uZ5sOcPQ9vZ/6T4E0bG8s4GnX0uLCDtj7s7DJoYJdP6P5PkFPFTBfjFKwG5tLlaybapESDv7PcnGBU+9Ws5nSpGs28osawmBLU7gTtLkL+q9u+CkM1pcjXJ1OCBscWApBlFzgj0y+nxwpQDPYognVMw3cv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160818; c=relaxed/simple;
	bh=K4889jfUqM3CBcIACF1FyaVzVjG6EZP0WeP8omxOl5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kM4wuZ7gTMhBdOdz0Q0/0oO3vC8YEiktVyz5PNnOQsXUFFeOrfi4O15g6hYGBNPDFrbdy+i/PMYpUVA8h2g+H39Im2VK0btbanxk954nIpbhscHx0QyYnxPKnY1Xw1HbGs5saxRV5vRFDTDQKh6Yc9oaqTTcg0H6/nVP+wa53GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ke3I8Cyn; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4656QoRd012625;
	Fri, 5 Jul 2024 01:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720160810;
	bh=IlWkNjSPW1TCcbFJGRMMI5/3JzdpGfCMmK35jmG8EJE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=Ke3I8CynG79ff7eynqYKeuyolnc4tRIrHnUS7sR9lQcCADX5m+GQ8n7MkHtI5Z254
	 Zir2nb+kA0MVOgERXbkLnO8vip9O5aYQfj4QSLTD3PyO8v9p5ME4M7GJmdgBe4k6RO
	 RMqtNwWtx14drG9a0jjuN2wYPVhbyf/jSjWsvaa0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4656QoWb060028
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jul 2024 01:26:50 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 01:26:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 01:26:50 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4656QTk1127334;
	Fri, 5 Jul 2024 01:26:46 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 5 Jul 2024 11:56:30 +0530
Subject: [PATCH v2 4/5] arm64: dts: ti: k3-j721e*: Add bootph-* properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240705-b4-upstream-bootph-all-v2-4-9007681ed7d8@ti.com>
References: <20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com>
In-Reply-To: <20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com>
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
	<b-padhi@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720160789; l=13653;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=K4889jfUqM3CBcIACF1FyaVzVjG6EZP0WeP8omxOl5A=;
 b=XC3GZZNHQ9d6H4hckLn3oc5gZFcbvYBvAl4Uy3p6l5PyEd4qRGhyxK0b2CItM0d566ixvTj8M
 6z3ANJvd4NQDus3cpjObruxTj/YQCRDUQVey4j7dTMdpRbT0QrmzX1B
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Adds bootph-* properties to the leaf nodes to enable U-boot to
utilise them.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 .../arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi            |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts               | 18 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi          |  5 +++++
 5 files changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8230d53cd696..ebc9ab3b6790 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -193,6 +193,7 @@ J721E_IOPAD(0x1c0, PIN_OUTPUT, 1) /* (AA2) SPI0_CS0.UART0_RTSn */
 			J721E_IOPAD(0x1e8, PIN_INPUT, 0) /* (AB2) UART0_RXD */
 			J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
@@ -234,6 +235,7 @@ J721E_IOPAD(0x240, PIN_INPUT, 0) /* (R26) MMC1_DAT3 */
 			J721E_IOPAD(0x258, PIN_INPUT, 0) /* (P23) MMC1_SDCD */
 			J721E_IOPAD(0x25c, PIN_INPUT, 0) /* (R28) MMC1_SDWP */
 		>;
+		bootph-all;
 	};
 
 	vdd_sd_dv_alt_pins_default: vdd-sd-dv-alt-default-pins {
@@ -247,6 +249,7 @@ main_usbss0_pins_default: main-usbss0-default-pins {
 			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
 			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
 		>;
+		bootph-all;
 	};
 
 	main_usbss1_pins_default: main-usbss1-default-pins {
@@ -272,6 +275,7 @@ main_i2c0_pins_default: main-i2c0-default-pins {
 			J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
 			J721E_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (AA5) I2C0_SDA */
 		>;
+		bootph-all;
 	};
 
 	main_i2c1_pins_default: main-i2c1-default-pins {
@@ -342,6 +346,7 @@ wkup_uart0_pins_default: wkup-uart0-default-pins {
 			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
 			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	mcu_uart0_pins_default: mcu-uart0-default-pins {
@@ -351,6 +356,7 @@ J721E_WKUP_IOPAD(0xec, PIN_OUTPUT, 0) /* (J27) WKUP_GPIO0_15.MCU_UART0_RTSn */
 			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
 			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0) /* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	sw11_button_pins_default: sw11-button-default-pins {
@@ -370,6 +376,7 @@ J721E_WKUP_IOPAD(0x4c, PIN_INPUT, 0) /* (C23) MCU_OSPI1_D3 */
 			J721E_WKUP_IOPAD(0x3c, PIN_INPUT, 0) /* (B23) MCU_OSPI1_DQS */
 			J721E_WKUP_IOPAD(0x38, PIN_INPUT, 0) /* (A23) MCU_OSPI1_LBCLKO */
 		>;
+		bootph-all;
 	};
 
 	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
@@ -427,6 +434,7 @@ wkup_gpio_pins_default: wkup-gpio-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xd0, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_8 */
 		>;
+		bootph-all;
 	};
 };
 
@@ -435,12 +443,14 @@ &wkup_uart0 {
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
@@ -449,6 +459,7 @@ &main_uart0 {
 	pinctrl-0 = <&main_uart0_pins_default>;
 	/* Shared with ATF on this platform */
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
+	bootph-all;
 };
 
 &main_uart1 {
@@ -473,6 +484,7 @@ &wkup_gpio0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_gpio_pins_default>;
+	bootph-all;
 };
 
 &main_gpio0 {
@@ -489,6 +501,7 @@ &main_sdhci0 {
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
+	bootph-all;
 };
 
 &main_sdhci1 {
@@ -500,10 +513,12 @@ &main_sdhci1 {
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
+	bootph-all;
 };
 
 &usb_serdes_mux {
 	idle-states = <1>, <0>; /* USB0 to SERDES3, USB1 to SERDES1 */
+	bootph-all;
 };
 
 &serdes_ln_ctrl {
@@ -513,6 +528,7 @@ &serdes_ln_ctrl {
 		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
 		      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
 		      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
+	bootph-all;
 };
 
 &serdes_wiz3 {
@@ -534,6 +550,7 @@ &usbss0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss0_pins_default>;
 	ti,vbus-divider;
+	bootph-all;
 };
 
 &usb0 {
@@ -541,6 +558,7 @@ &usb0 {
 	maximum-speed = "super-speed";
 	phys = <&serdes3_usb_link>;
 	phy-names = "cdns3,usb3-phy";
+	bootph-all;
 };
 
 &usbss1 {
@@ -569,6 +587,7 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <2>;
+		bootph-all;
 
 		partitions {
 			compatible = "fixed-partitions";
@@ -650,6 +669,7 @@ exp2: gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		bootph-all;
 
 		p09-hog {
 			/* P11 - MCASP/TRACE_MUX_S0 */
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 0da785be80ff..584badcb796d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -226,6 +226,7 @@ secure_proxy_main: mailbox@32c00000 {
 			      <0x00 0x32800000 0x00 0x100000>;
 			interrupt-names = "rx_011";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			bootph-all;
 		};
 
 		smmu0: iommu@36600000 {
@@ -2854,5 +2855,6 @@ main_esm: esm@700000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x0 0x700000 0x0 0x1000>;
 		ti,esm-pins = <344>, <345>;
+		bootph-all;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 6b6ef6a30614..ff9d8a7c405c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -17,20 +17,24 @@ dmsc: system-controller@44083000 {
 
 		reg-names = "debug_messages";
 		reg = <0x00 0x44083000 0x0 0x1000>;
+		bootph-all;
 
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
 
@@ -61,6 +65,7 @@ wkup_conf: bus@43000000 {
 		chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
+			bootph-all;
 		};
 	};
 
@@ -115,6 +120,7 @@ mcu_timer0: timer@40400000 {
 		ti,timer-pwm;
 		/* Non-MPU Firmware usage */
 		status = "reserved";
+		bootph-pre-ram;
 	};
 
 	mcu_timer1: timer@40410000 {
@@ -475,6 +481,7 @@ mcu_ringacc: ringacc@2b800000 {
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <235>;
 			msi-parent = <&main_udmass_inta>;
+			bootph-all;
 		};
 
 		mcu_udmap: dma-controller@285c0000 {
@@ -499,6 +506,7 @@ mcu_udmap: dma-controller@285c0000 {
 			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
 						<0x0b>; /* RX_HCHAN */
 			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+			bootph-all;
 		};
 	};
 
@@ -515,6 +523,7 @@ secure_proxy_mcu: mailbox@2a480000 {
 		 * firmware on non-MPU processors
 		 */
 		status = "disabled";
+		bootph-pre-ram;
 	};
 
 	mcu_cpsw: ethernet@46000000 {
@@ -687,6 +696,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x43000300 0x00 0x10>;
 		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	mcu_esm: esm@40800000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 89fbfb21e5d3..b63d48719090 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -346,6 +346,7 @@ J721E_IOPAD(0x244, PIN_INPUT, 0) /* (R25) MMC1_DAT2 */
 			J721E_IOPAD(0x240, PIN_INPUT, 0) /* (R26) MMC1_DAT3 */
 			J721E_IOPAD(0x258, PIN_INPUT, 0) /* (P23) MMC1_SDCD */
 		>;
+		bootph-all;
 	};
 
 	main_uart0_pins_default: main-uart0-default-pins {
@@ -355,6 +356,7 @@ J721E_IOPAD(0x1f4, PIN_OUTPUT, 0) /* (AB1) UART0_RTSn */
 			J721E_IOPAD(0x1e8, PIN_INPUT, 0) /* (AB2) UART0_RXD */
 			J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
@@ -390,12 +392,14 @@ main_usbss0_pins_default: main-usbss0-default-pins {
 			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
 			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
 		>;
+		bootph-all;
 	};
 
 	main_usbss1_pins_default: main-usbss1-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
 		>;
+		bootph-all;
 	};
 
 	main_csi_mux_sel_pins_default: main-csi-mux-sel-default-pins {
@@ -594,6 +598,7 @@ J721E_WKUP_IOPAD(0x24, PIN_INPUT, 0) /* (B22) MCU_OSPI0_D6 */
 			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 0) /* (G21) MCU_OSPI0_D7 */
 			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 0) /* (D21) MCU_OSPI0_DQS */
 		>;
+		bootph-all;
 	};
 
 	vdd_mmc1_en_pins_default: vdd-mmc1-en-default-pins {
@@ -622,6 +627,7 @@ J721E_WKUP_IOPAD(0xf4, PIN_OUTPUT, 2)/* (D25) MCU_I3C0_SDA.MCU_UART0_RTSn */
 			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
 			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0)/* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
 		>;
+		bootph-pre-ram;
 	};
 
 	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
@@ -629,6 +635,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
 			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
 		>;
+		bootph-all;
 	};
 
 	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
@@ -657,6 +664,7 @@ &wkup_uart0 {
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
+	bootph-all;
 };
 
 &wkup_i2c0 {
@@ -821,6 +829,7 @@ &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
+	bootph-all;
 };
 
 &main_uart0 {
@@ -829,6 +838,7 @@ &main_uart0 {
 	pinctrl-0 = <&main_uart0_pins_default>;
 	/* Shared with ATF on this platform */
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
+	bootph-all;
 };
 
 &main_uart1 {
@@ -846,6 +856,7 @@ &main_sdhci1 {
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
+	bootph-all;
 };
 
 &ospi0 {
@@ -864,6 +875,7 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <4>;
+		bootph-all;
 
 		partitions {
 			compatible = "fixed-partitions";
@@ -1003,6 +1015,7 @@ &wkup_gpio0 {
 
 &usb_serdes_mux {
 	idle-states = <1>, <1>; /* USB0 to SERDES3, USB1 to SERDES2 */
+	bootph-all;
 };
 
 &serdes_ln_ctrl {
@@ -1012,6 +1025,7 @@ &serdes_ln_ctrl {
 		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
 		      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
 		      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
+	bootph-all;
 };
 
 &serdes_wiz3 {
@@ -1051,6 +1065,7 @@ &usbss0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss0_pins_default>;
 	ti,vbus-divider;
+	bootph-all;
 };
 
 &usb0 {
@@ -1058,6 +1073,7 @@ &usb0 {
 	maximum-speed = "super-speed";
 	phys = <&serdes3_usb_link>;
 	phy-names = "cdns3,usb3-phy";
+	bootph-all;
 };
 
 &serdes2 {
@@ -1074,6 +1090,7 @@ &usbss1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss1_pins_default>;
 	ti,vbus-divider;
+	bootph-all;
 };
 
 &usb1 {
@@ -1081,6 +1098,7 @@ &usb1 {
 	maximum-speed = "super-speed";
 	phys = <&serdes2_usb_link>;
 	phy-names = "cdns3,usb3-phy";
+	bootph-all;
 };
 
 &mcu_cpsw {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index 5ba947771b84..86bfc5e21eed 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -151,6 +151,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
 			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
 		>;
+		bootph-all;
 	};
 
 	pmic_irq_pins_default: pmic-irq-default-pins {
@@ -173,6 +174,7 @@ J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
 			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
 			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
 		>;
+		bootph-all;
 	};
 
 	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-default-pins {
@@ -192,6 +194,7 @@ J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ5 */
 			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ6 */
 			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ7 */
 		>;
+		bootph-all;
 	};
 };
 
@@ -378,6 +381,7 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
+		bootph-all;
 
 		partitions {
 			compatible = "fixed-partitions";
@@ -440,6 +444,7 @@ &hbmc {
 	flash@0,0 {
 		compatible = "cypress,hyperflash", "cfi-flash";
 		reg = <0x00 0x00 0x4000000>;
+		bootph-all;
 
 		partitions {
 			compatible = "fixed-partitions";

-- 
2.45.1


