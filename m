Return-Path: <linux-kernel+bounces-171025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE588BDEE7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55F1282223
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672015ECF8;
	Tue,  7 May 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kghJd4Bt"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DC15E81A;
	Tue,  7 May 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075111; cv=none; b=aZe41QuFgtAtLc5qEOE/cCzsgmMPLUtZbK9ihjRESHg5Ck3ITX8lfiMMN9f2L389oRdLeDBeAaHiIoKmGNN6vdemhAbK2YnmmsSWpLvNkGMx5qk1RPH7sby589tPaPwKHMuDR6OBJ9479Y1Pt3Non7bjaZy4BHVjKHsMvdH04yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075111; c=relaxed/simple;
	bh=SS7753ZUle2dSEv24G/BLSbLvh5ABnDU2VBdfty4xEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f7oNOE8MWlkzWiAh+aIiWu+7vvCReS2P6mQvITS0Fo0+fqAHP8ChfhQDuGHqanBbjAf6pYyHMubGWhYYXoa40kCSFvCpattOdy4Sg8uqBpAZxQ6dcfdjjk3Yem3IA5uriHHLggacZ0YhSvjUvT8n7geNanXDZh376E59pAK4N00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kghJd4Bt; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4479igro098073;
	Tue, 7 May 2024 04:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715075083;
	bh=3mzEMu6QILwsMpS99mGEpUYkEIGWcPmT1qGX3MyiYFo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=kghJd4BtA0ctVtlz5gAyXFqW2/gAAEM1kntyD0y+TbnJXTIMnCQHq0TtzDSa9MjBf
	 vW/BNEHZffMb/YPbf9zc4SiEUigegun40TBmFg7k3YiLeRIHsc68hP3em1+EyPR0SA
	 6bK2dHM5j1GrARoZip4mQzni0RwjsHxL26FEm4To=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4479ig1x026100
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 04:44:43 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 04:44:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 04:44:42 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4479iXjV117029;
	Tue, 7 May 2024 04:44:38 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 7 May 2024 15:14:28 +0530
Subject: [PATCH 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-* properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240507-b4-upstream-bootph-all-v1-1-c6d52651856f@ti.com>
References: <20240507-b4-upstream-bootph-all-v1-0-c6d52651856f@ti.com>
In-Reply-To: <20240507-b4-upstream-bootph-all-v1-0-c6d52651856f@ti.com>
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
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715075073; l=6887;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=SS7753ZUle2dSEv24G/BLSbLvh5ABnDU2VBdfty4xEE=;
 b=Rd6HxFtsrnLkFMFDzEBUKHiXvyGJudmZRTsyCicWKOSQue0RD5sM+m61/jLluynJCSMill7gf
 5gdZW43kK1nAhFt5a56bNXq2W/cczt8pa/NNVXD3X1i+QiBtMyXbkmD
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Adds bootph-* properties to the leaf nodes to enable U-boot to
utilise them.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi             |  1 +
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi       | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi           |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index c5a0b7cbb14f..6ce14f9e087b 100644
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
@@ -446,11 +457,13 @@ &usbss0 {
 	pinctrl-names = "default";
 	ti,vbus-divider;
 	ti,usb2-only;
+	bootph-all;
 };
 
 &usb0 {
 	dr_mode = "otg";
 	maximum-speed = "high-speed";
+	bootph-all;
 };
 
 &ospi1 {
@@ -469,6 +482,7 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <2>;
+		bootph-all;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index b70c8615e3c1..fd1513f33616 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -828,6 +828,7 @@ secure_proxy_main: mailbox@32c00000 {
 			      <0x00 0x32800000 0x00 0x100000>;
 			interrupt-names = "rx_011";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			bootph-all;
 		};
 
 		hwspinlock: spinlock@30e00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index eaf7f709440e..b5013bba8509 100644
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
 
@@ -59,6 +63,7 @@ secure_proxy_sa3: mailbox@43600000 {
 		 * firmware on non-MPU processors
 		 */
 		status = "disabled";
+		bootph-pre-ram;
 	};
 
 	mcu_ram: sram@41c00000 {
@@ -166,6 +171,7 @@ mcu_timer0: timer@40400000 {
 		ti,timer-pwm;
 		/* Non-MPU Firmware usage */
 		status = "reserved";
+		bootph-pre-ram;
 	};
 
 	mcu_timer1: timer@40410000 {
@@ -360,6 +366,7 @@ wkup_i2c0: i2c@42120000 {
 		clock-names = "fck";
 		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
+		bootph-all;
 	};
 
 	mcu_i2c0: i2c@40b00000 {
@@ -472,6 +479,7 @@ mcu_ringacc: ringacc@2b800000 {
 			ti,sci = <&sms>;
 			ti,sci-dev-id = <272>;
 			msi-parent = <&main_udmass_inta>;
+			bootph-all;
 		};
 
 		mcu_udmap: dma-controller@285c0000 {
@@ -495,6 +503,7 @@ mcu_udmap: dma-controller@285c0000 {
 			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
 						<0x0b>; /* RX_HCHAN */
 			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+			bootph-all;
 		};
 	};
 
@@ -511,6 +520,7 @@ secure_proxy_mcu: mailbox@2a480000 {
 		 * firmware on non-MPU processors
 		 */
 		status = "disabled";
+		bootph-pre-ram;
 	};
 
 	mcu_cpsw: ethernet@46000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index 623c8421525d..f3898cd49ed9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -16,6 +16,7 @@ memory@80000000 {
 		/* 16 GB RAM */
 		reg = <0x00 0x80000000 0x00 0x80000000>,
 		      <0x08 0x80000000 0x03 0x80000000>;
+		bootph-all;
 	};
 
 	/* Reserving memory regions still pending */
@@ -444,6 +445,7 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <4>;
+		bootph-all;
 	};
 };
 

-- 
2.43.2


