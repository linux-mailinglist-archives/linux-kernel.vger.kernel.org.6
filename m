Return-Path: <linux-kernel+bounces-286043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD49515C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B0328A990
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F7F13D51E;
	Wed, 14 Aug 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rrhuxyKz"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0434DA00;
	Wed, 14 Aug 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621679; cv=none; b=b+cEg+gBpJRgas6xy6Qpyze9HKKIMEvsr6RV70hVqxXBeISrOBcMEU5naxwRopeyHP4SGoJiImpzb6YXJ2mNqIzNcJireSWzZISVQS/nEYXjdIHVCJA+eW6smPI7mSr/NDPQwcjBBqfGGx42G265Fjwj+MAaO+tJp2qX0VKV0Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621679; c=relaxed/simple;
	bh=E18ABw4VmZqc3yGsHecwERFeyMUEihA9E2+JvUrSWcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TAvs0K4m0IS/EqbvGJyUR5UeMxdUKXm3TVj1M7kVj4xEPAOXMfkkifscV18qsCB4fy4F4/eCE/901ZDObPpDBEydH1VF5OXX4i9LkzJmsKs2ELCasltY3J5S8f25xg2nmYthE77Oisz+/uIdbkFROaDwa5Y8Oq9JiOCeLriJur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rrhuxyKz; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E7le7C087691;
	Wed, 14 Aug 2024 02:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723621660;
	bh=HTE6CIoNEEGXnHWPsTmPYdGJCh1kTwWBMXVzCMoYXAA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=rrhuxyKzYkTkUYF9nVq6AWugLFsxwPEYBmkn1rFQyOM+bC9mdbK0wKmSz2GxRqh74
	 k/66oXP0IhjGGbSZLKcrGPxK2EPphvdOVq/AM3JWlSGUipVvaQ+NGyd6NGJ1wbtlOt
	 C/6xUw6pQc9RYq/XcIDgtWQxIy5gOa7t29slrwBc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E7lepw059827
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 02:47:40 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 02:47:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 02:47:39 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E7lT2F059812;
	Wed, 14 Aug 2024 02:47:35 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 14 Aug 2024 13:17:28 +0530
Subject: [PATCH v4 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-* properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240814-b4-upstream-bootph-all-v4-1-f2b462000f25@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723621650; l=8791;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=E18ABw4VmZqc3yGsHecwERFeyMUEihA9E2+JvUrSWcE=;
 b=pL34v6QpLr4pQ/3UBlxIHRLPyuMAawVefIyPcIx6UEQULaTdD4dHu46gBr+xmyWMQsJDo1kYK
 Gf2L2R3CE6CDpaJjwlsJLBu6wZqi/ll5K6R56aabJVP+IDPgWutJ8c5
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Adds bootph-* properties to the leaf nodes to enable bootloaders to
utilise them.

Reviewed-by: Andrew Davis <afd@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi             |  4 +++-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi       | 17 +++++++++++++++--
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi           |  2 ++
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index c5a0b7cbb14f..3b5f8f08cf32 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -138,6 +138,7 @@ J721S2_IOPAD(0x044, PIN_OUTPUT, 14) /* (Y26) MCASP0_AXR1.UART8_RTSn */
 			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
 			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
 		>;
+		bootph-all;
 	};
 
 	main_i2c3_pins_default: main-i2c3-default-pins {
@@ -165,6 +166,7 @@ J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
 			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
 			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
 		>;
+		bootph-all;
 	};
 
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
@@ -177,6 +179,7 @@ main_usbss0_pins_default: main-usbss0-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
 		>;
+		bootph-all;
 	};
 
 	main_mcan3_pins_default: main-mcan3-default-pins {
@@ -200,6 +203,7 @@ wkup_uart0_pins_default: wkup-uart0-default-pins {
 			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	mcu_uart0_pins_default: mcu-uart0-default-pins {
@@ -209,6 +213,7 @@ J721S2_WKUP_IOPAD(0x094, PIN_OUTPUT, 0) /* (D25) WKUP_GPIO0_15.MCU_UART0_RTSn */
 			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C24) WKUP_GPIO0_13.MCU_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (C25) WKUP_GPIO0_12.MCU_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
@@ -301,6 +306,7 @@ J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (A20) MCU_OSPI1_D3 */
 			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B19) MCU_OSPI1_DQS */
 			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
 		>;
+		bootph-all;
 	};
 };
 
@@ -316,12 +322,14 @@ &wkup_uart0 {
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
 
 &main_uart8 {
@@ -330,6 +338,7 @@ &main_uart8 {
 	pinctrl-0 = <&main_uart8_pins_default>;
 	/* Shared with TFA on this platform */
 	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
+	bootph-all;
 };
 
 &main_i2c0 {
@@ -385,6 +394,7 @@ &main_sdhci0 {
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
+	bootph-all;
 };
 
 &main_sdhci1 {
@@ -395,6 +405,7 @@ &main_sdhci1 {
 	disable-wp;
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv>;
+	bootph-all;
 };
 
 &mcu_cpsw {
@@ -444,6 +455,7 @@ &usbss0 {
 	status = "okay";
 	pinctrl-0 = <&main_usbss0_pins_default>;
 	pinctrl-names = "default";
+	bootph-all;
 	ti,vbus-divider;
 	ti,usb2-only;
 };
@@ -451,6 +463,7 @@ &usbss0 {
 &usb0 {
 	dr_mode = "otg";
 	maximum-speed = "high-speed";
+	bootph-all;
 };
 
 &ospi1 {
@@ -464,6 +477,7 @@ flash@0 {
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <40000000>;
+		bootph-all;
 		cdns,tshsl-ns = <60>;
 		cdns,tsd2d-ns = <60>;
 		cdns,tchsh-ns = <60>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 9ed6949b40e9..0d72dd0b5033 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -816,6 +816,7 @@ secure_proxy_main: mailbox@32c00000 {
 			      <0x00 0x32800000 0x00 0x100000>;
 			interrupt-names = "rx_011";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			bootph-all;
 		};
 
 		hwspinlock: spinlock@30e00000 {
@@ -1225,6 +1226,7 @@ usb0: usb@6000000 {
 			interrupt-names = "host", "peripheral", "otg";
 			maximum-speed = "super-speed";
 			dr_mode = "otg";
+			bootph-all;
 		};
 	};
 
@@ -1944,8 +1946,8 @@ c71_1: dsp@65800000 {
 	main_esm: esm@700000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x700000 0x00 0x1000>;
-		ti,esm-pins = <688>, <689>;
 		bootph-pre-ram;
+		ti,esm-pins = <688>, <689>;
 	};
 
 	watchdog0: watchdog@2200000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 8feb42c89e47..05a5e35fddcd 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -21,16 +21,19 @@ sms: system-controller@44083000 {
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
 
@@ -43,6 +46,7 @@ wkup_conf: bus@43000000 {
 		chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
+			bootph-all;
 		};
 	};
 
@@ -53,6 +57,8 @@ secure_proxy_sa3: mailbox@43600000 {
 		reg = <0x00 0x43600000 0x00 0x10000>,
 		      <0x00 0x44880000 0x00 0x20000>,
 		      <0x00 0x44860000 0x00 0x20000>;
+		bootph-pre-ram;
+
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -167,6 +173,7 @@ mcu_timer0: timer@40400000 {
 		assigned-clocks = <&k3_clks 35 1>;
 		assigned-clock-parents = <&k3_clks 35 2>;
 		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		bootph-pre-ram;
 		ti,timer-pwm;
 		/* Non-MPU Firmware usage */
 		status = "reserved";
@@ -361,6 +368,7 @@ wkup_i2c0: i2c@42120000 {
 		clocks = <&k3_clks 223 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
+		bootph-all;
 		status = "disabled";
 	};
 
@@ -469,6 +477,7 @@ mcu_ringacc: ringacc@2b800000 {
 			      <0x0 0x2a500000 0x0 0x40000>,
 			      <0x0 0x28440000 0x0 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+			bootph-all;
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>;
 			ti,sci = <&sms>;
@@ -488,6 +497,7 @@ mcu_udmap: dma-controller@285c0000 {
 				    "tchan", "rchan", "rflow";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
+			bootph-all;
 
 			ti,sci = <&sms>;
 			ti,sci-dev-id = <273>;
@@ -507,6 +517,8 @@ secure_proxy_mcu: mailbox@2a480000 {
 		reg = <0x00 0x2a480000 0x00 0x80000>,
 		      <0x00 0x2a380000 0x00 0x80000>,
 		      <0x00 0x2a400000 0x00 0x80000>;
+		bootph-pre-ram;
+
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -667,6 +679,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x42050000 0x0 0x350>;
 		power-domains = <&k3_pds 180 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	mcu_r5fss0: r5fss@41000000 {
@@ -712,15 +725,15 @@ mcu_r5fss0_core1: r5f@41400000 {
 	mcu_esm: esm@40800000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x40800000 0x00 0x1000>;
-		ti,esm-pins = <95>;
 		bootph-pre-ram;
+		ti,esm-pins = <95>;
 	};
 
 	wkup_esm: esm@42080000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x42080000 0x00 0x1000>;
-		ti,esm-pins = <63>;
 		bootph-pre-ram;
+		ti,esm-pins = <63>;
 	};
 
 	/*
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index 36136db26a47..c333148f2789 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -170,6 +170,7 @@ J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (F20) MCU_OSPI0_D7 */
 			J721S2_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (E18) MCU_OSPI0_DQS */
 			J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E20) MCU_OSPI0_LBCLKO */
 		>;
+		bootph-all;
 	};
 };
 
@@ -440,6 +441,7 @@ flash@0 {
 		spi-tx-bus-width = <8>;
 		spi-rx-bus-width = <8>;
 		spi-max-frequency = <25000000>;
+		bootph-all;
 		cdns,tshsl-ns = <60>;
 		cdns,tsd2d-ns = <60>;
 		cdns,tchsh-ns = <60>;

-- 
2.46.0


