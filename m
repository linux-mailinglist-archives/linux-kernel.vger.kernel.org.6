Return-Path: <linux-kernel+bounces-379212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252869ADB76
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96413B21277
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B42F17BEC1;
	Thu, 24 Oct 2024 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FzNz47j5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8217ADF7;
	Thu, 24 Oct 2024 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747324; cv=none; b=kd4a9/Z+T6I8zDrPMA1TRyPF2eFRdP3whznSofVkOlK0m75NtXbXtOFsKusCiTjUeKvbRaOruoWV9duaSfOtDZdyyZNgCMWQ7w75IqEvVSuYbPhCXMiMZr4BPZ2Ul+LsQEToQ8dlvb5Ahh3BARsA0j5lRyjeNIvXrnbU52C80PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747324; c=relaxed/simple;
	bh=UtejR6grqAuE+MAJVhno24cA68ue7ucdlNNzKIU/uXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZUe+gxpw4G67gAFlM8CAMuW0R7YtGIlREY+EPhDV10cvKct/mcpp2jnqdHT/d8MeonaG8MImG4D6AW1lhj7BQNLeLc37RN8KARal8dGajq/foUWgSAjjAEoxhJS9fdZ6PY8jNteDGteP/mjFXCc1afKRG3WkZKQ3uCL+dkPJyLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FzNz47j5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49O5LvBT015452;
	Thu, 24 Oct 2024 00:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729747317;
	bh=aB3WoEHAF6tI4zUJ9SrQIzL5HLo3Mxo21sIFEn0ICe8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=FzNz47j5/fMYlp50K6MoXVoghUZ/RFqjZQbNRvD5pU3gWf+B+HVQDnFq2/xy1n1Bt
	 wx95tKlIxs68Vl2wzQFROAS1UTgugUT8qyGXDxL78YUBRADKlZ/C2d69hY1apACCKM
	 lWh64u7MCO4jN7FdUMUZ7TBlMz15SKyMyfeJ8734=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5LvTu025155;
	Thu, 24 Oct 2024 00:21:57 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 00:21:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 00:21:56 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5L4lJ090467;
	Thu, 24 Oct 2024 00:21:53 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 24 Oct 2024 10:51:08 +0530
Subject: [PATCH v6 11/12] arm64: dts: ti: k3-j721e-sk*: Add bootph-*
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-b4-upstream-bootph-all-v6-11-2af90e3a4fe7@ti.com>
References: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
In-Reply-To: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729747264; l=4879;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=UtejR6grqAuE+MAJVhno24cA68ue7ucdlNNzKIU/uXk=;
 b=03aQ9Iojt79IjSlkvd1gy8sXArTyoHx2R1MgIO0jn2aynJI0HjEQBNWFaXDQgd4VVfxKH1ZmO
 4wgVu0M4WJMBanJy5j4B49HSc7HQShE0DDHoTFqFt0ZGxzriqqBWdA2
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Adds bootph-* properties to the leaf nodes to enable bootloaders to
utilise them.

Following adds bootph-* to:
- main_uart0, mcu_uart0(DM), wkup_uart0(TIFS) for Traces
- mmc1, usb0, usb1, ospi0 for enabling various bootmodes.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    R-by picked up in v5 ( Neha )

 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 6285e8d94ddeb75003468176bfbad7150c77facf..69b3d1ed8a21c26916721be6d10af1ba63ded156 100644
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
+		bootph-all;
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
@@ -844,6 +854,7 @@ &main_sdhci1 {
 	vqmmc-supply = <&vdd_sd_dv_alt>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
+	bootph-all;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
@@ -908,6 +919,7 @@ partition@800000 {
 			partition@3fc0000 {
 				label = "ospi.phypattern";
 				reg = <0x3fc0000 0x40000>;
+				bootph-all;
 			};
 		};
 	};
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
@@ -1050,6 +1064,7 @@ &mhdp {
 &usbss0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss0_pins_default>;
+	bootph-all;
 	ti,vbus-divider;
 };
 
@@ -1058,6 +1073,7 @@ &usb0 {
 	maximum-speed = "super-speed";
 	phys = <&serdes3_usb_link>;
 	phy-names = "cdns3,usb3-phy";
+	bootph-all;
 };
 
 &serdes2 {
@@ -1073,6 +1089,7 @@ serdes2_usb_link: phy@1 {
 &usbss1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss1_pins_default>;
+	bootph-all;
 	ti,vbus-divider;
 };
 
@@ -1081,6 +1098,7 @@ &usb1 {
 	maximum-speed = "super-speed";
 	phys = <&serdes2_usb_link>;
 	phy-names = "cdns3,usb3-phy";
+	bootph-all;
 };
 
 &mcu_cpsw {

-- 
2.46.0


