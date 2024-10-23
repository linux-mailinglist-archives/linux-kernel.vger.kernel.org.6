Return-Path: <linux-kernel+bounces-377493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0329ABF92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1422858B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A23154C04;
	Wed, 23 Oct 2024 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IuvLLb2a"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3321662F1;
	Wed, 23 Oct 2024 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666714; cv=none; b=E5fxfB41Sch5eUYMl7XNzgwxNC6uWZCWGN6D+O5Y7Yopf7Xk4L+z2BJMSkG2FKQqx/AOuIDthqnR4NMEK3PNdtJhPkzKHy02DRpv2axn+VKqX0uaj22pO/9m4SpP8XRF7r4xKXA6KwjJJ3lwvEELBvahXI4I2KAxUibqrCuWkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666714; c=relaxed/simple;
	bh=tew9JNhPhAeqYeQUqkgNOxX+WWvWtySM+AIf07Mqu8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qWYsvSsz5bloesk1i6rAU9eVeCybb7MW9X6iR9SQdv0yWyu6BgbNRe5BGNj55IPEcGPvF+Ku7Uga//MhtXzKIEnfl0tBI4cUbssD79rBNS6/h8uDw9vbNiN8gd7katEtq5umBX/m/d3oED3yf9+qxXFlcI+rf5uDlgkqRSdmcJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IuvLLb2a; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6wSBn031509;
	Wed, 23 Oct 2024 01:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666708;
	bh=hKDGmg/2zAciYofc1ILJrF+dk5yRt4r0MJZojyWNI4A=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=IuvLLb2auIAlmFdiEwtBcP+wpCdCOOzWk0eh6jLlEdvGQ1bQ+zcwwgqDBeLTI02dH
	 TUBW9bLgECL7G+EOB13K7mpntgIjwrrZyVcNtb4WfTuHILTy67rdS6NtetcLZJzGWI
	 hxnRluWEpwL63SG/LP2GEvBHeTgeYfkSYvB4mbnQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49N6wSMo068975
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 01:58:28 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:58:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:58:27 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUX129058;
	Wed, 23 Oct 2024 01:58:23 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 23 Oct 2024 12:27:24 +0530
Subject: [PATCH v5 10/12] arm64: dts: ti: k3-j721e-evm*: Add bootph-*
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241023-b4-upstream-bootph-all-v5-10-a974d06370ab@ti.com>
References: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
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
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=5924;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=tew9JNhPhAeqYeQUqkgNOxX+WWvWtySM+AIf07Mqu8E=;
 b=KbddTU8WxVXdqWJjQqVg1UkdagYdm+b9WMBAzUawt8hL1MrNe014ZWrbxKv4+N0pKMlkDRciw
 S4P6I00gMprBOqrfazJS3Mg2v0z7GO+wvQIOuLfS6RY1UBA+wVd0E8c
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Adds bootph-* properties to the leaf nodes to enable bootloaders to
utilise them.

Following adds bootph-* to:
- main_uart0, mcu_uart0(DM), wkup_uart0(TIFS) for Traces
- mmc0, mmc1, usb0, ospi0, ospi1, hbmc for enabling various bootmodes.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 16 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi           |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8230d53cd696..4c1e02a4e7a2 100644
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
@@ -342,6 +345,7 @@ wkup_uart0_pins_default: wkup-uart0-default-pins {
 			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
 			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	mcu_uart0_pins_default: mcu-uart0-default-pins {
@@ -351,6 +355,7 @@ J721E_WKUP_IOPAD(0xec, PIN_OUTPUT, 0) /* (J27) WKUP_GPIO0_15.MCU_UART0_RTSn */
 			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
 			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0) /* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	sw11_button_pins_default: sw11-button-default-pins {
@@ -370,6 +375,7 @@ J721E_WKUP_IOPAD(0x4c, PIN_INPUT, 0) /* (C23) MCU_OSPI1_D3 */
 			J721E_WKUP_IOPAD(0x3c, PIN_INPUT, 0) /* (B23) MCU_OSPI1_DQS */
 			J721E_WKUP_IOPAD(0x38, PIN_INPUT, 0) /* (A23) MCU_OSPI1_LBCLKO */
 		>;
+		bootph-all;
 	};
 
 	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
@@ -435,12 +441,14 @@ &wkup_uart0 {
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
@@ -449,6 +457,7 @@ &main_uart0 {
 	pinctrl-0 = <&main_uart0_pins_default>;
 	/* Shared with ATF on this platform */
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
+	bootph-all;
 };
 
 &main_uart1 {
@@ -487,6 +496,7 @@ &main_sdhci0 {
 	/* eMMC */
 	status = "okay";
 	non-removable;
+	bootph-all;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
@@ -498,12 +508,14 @@ &main_sdhci1 {
 	vqmmc-supply = <&vdd_sd_dv_alt>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
+	bootph-all;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
 &usb_serdes_mux {
 	idle-states = <1>, <0>; /* USB0 to SERDES3, USB1 to SERDES1 */
+	bootph-all;
 };
 
 &serdes_ln_ctrl {
@@ -513,6 +525,7 @@ &serdes_ln_ctrl {
 		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
 		      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
 		      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
+	bootph-all;
 };
 
 &serdes_wiz3 {
@@ -533,6 +546,7 @@ serdes3_usb_link: phy@0 {
 &usbss0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss0_pins_default>;
+	bootph-all;
 	ti,vbus-divider;
 };
 
@@ -541,6 +555,7 @@ &usb0 {
 	maximum-speed = "super-speed";
 	phys = <&serdes3_usb_link>;
 	phy-names = "cdns3,usb3-phy";
+	bootph-all;
 };
 
 &usbss1 {
@@ -613,6 +628,7 @@ partition@800000 {
 			partition@3fe0000 {
 				label = "qspi.phypattern";
 				reg = <0x3fe0000 0x20000>;
+				bootph-all;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index cef47c67493f..0722f6361cc8 100644
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
 
@@ -422,6 +425,7 @@ partition@800000 {
 			partition@3fe0000 {
 				label = "ospi.phypattern";
 				reg = <0x3fe0000 0x20000>;
+				bootph-all;
 			};
 		};
 	};
@@ -440,6 +444,7 @@ &hbmc {
 	flash@0,0 {
 		compatible = "cypress,hyperflash", "cfi-flash";
 		reg = <0x00 0x00 0x4000000>;
+		bootph-all;
 
 		partitions {
 			compatible = "fixed-partitions";

-- 
2.46.0


