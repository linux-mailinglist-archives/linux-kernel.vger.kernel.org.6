Return-Path: <linux-kernel+bounces-171024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0806F8BDEE4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716741F21F64
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478BB15ECC0;
	Tue,  7 May 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yvTm6bcY"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7815E7F5;
	Tue,  7 May 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075109; cv=none; b=ZAPu410WAW7lPY9yND+kMsZA9tkwfCPJDb7kGsnW/WVUI/+AVjILX9el2UKl0awjThxzQ53u3EpWkSAk3DRdOOBUitND/X1YQtP24DPwevV2xcGJDqH7KVTxBeNjjN1eGQwc/3Lwp8yzMtMauUPbt5pAOxOJxoOaXoHAAOfgJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075109; c=relaxed/simple;
	bh=w7uu+6vTR+sleSuiePo/g4ujTTWpnx/Bo9uKkxO2FP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T4CIlPEmuK3ho8nbIe2djC1HeK7qUul+xVSOmen5nH43NisqADNHQqweggxYgIsg/c/YCi/Fre1BVkhO5zs6dlMUq5+p+nWmCudJAee6i78+UyQnxrNCacubsN9YQvdP1TckS8MYMEPHBr0jtjmagiEcjo0YpOrsrdiWCecabAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yvTm6bcY; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4479iqgh098085;
	Tue, 7 May 2024 04:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715075092;
	bh=skiUTWRA0pXoY+h0mZukTu658u5gJ5w8YMsYAEryM4c=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=yvTm6bcYuy2AGtn//OKAFi1Q1Laz3PIcVuANT1IpuQeuzVqzWqQY7m98smEEOjnP+
	 1Ke4zyMDNfCON6xu+iFKUsOCkW8DQLyB6C1TG1UCsSYil8594FJV2uD3a2hzGy8KRI
	 y66HHxXUYiuYdHuaRvWcx1IAuwzFoW1HUJAjwCdg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4479iqUL086947
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 04:44:52 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 04:44:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 04:44:51 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4479iXjX117029;
	Tue, 7 May 2024 04:44:47 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 7 May 2024 15:14:30 +0530
Subject: [PATCH 3/5] arm64: dts: ti: k3-am68*: Add bootph-* properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240507-b4-upstream-bootph-all-v1-3-c6d52651856f@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715075073; l=3580;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=w7uu+6vTR+sleSuiePo/g4ujTTWpnx/Bo9uKkxO2FP4=;
 b=qcDG1aAWDLlm2zyuhKGbpobQDnsjDmPLFVR3n/0tXmEHD25BX2Yrw37oxW5509R+XJiRfHB40
 b75WKHEhO5TCzwU4PDdTcp3o3w8LBXlmH5PfLRSd5FG2u/03ifTO7xz
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Adds bootph-* properties to the leaf nodes to enable U-boot to
utilise them.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi       |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index d743f023cdd9..df97884cd1c5 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -184,6 +184,7 @@ main_uart8_pins_default: main-uart8-default-pins {
 			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
 			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
 		>;
+		bootph-all;
 	};
 
 	main_i2c0_pins_default: main-i2c0-default-pins {
@@ -210,6 +211,7 @@ J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
 			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
 			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
 		>;
+		bootph-all;
 	};
 
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
@@ -222,6 +224,7 @@ main_usbss0_pins_default: main-usbss0-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
 		>;
+		bootph-all;
 	};
 
 	main_mcan6_pins_default: main-mcan6-default-pins {
@@ -312,6 +315,7 @@ J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (F28) WKUP_GPIO0_7.WKUP_UART0_RTSn */
 			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
@@ -412,12 +416,14 @@ &wkup_uart0 {
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
@@ -426,6 +432,7 @@ &main_uart8 {
 	pinctrl-0 = <&main_uart8_pins_default>;
 	/* Shared with TFA on this platform */
 	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
+	bootph-all;
 };
 
 &main_i2c0 {
@@ -520,6 +527,7 @@ &main_sdhci1 {
 	disable-wp;
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv>;
+	bootph-all;
 };
 
 &mcu_cpsw {
@@ -652,6 +660,7 @@ &usbss0 {
 	pinctrl-0 = <&main_usbss0_pins_default>;
 	pinctrl-names = "default";
 	ti,vbus-divider;
+	bootph-all;
 };
 
 &usb0 {
@@ -659,4 +668,5 @@ &usb0 {
 	maximum-speed = "super-speed";
 	phys = <&serdes0_usb_link>;
 	phy-names = "cdns3,usb3-phy";
+	bootph-all;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
index 0f4a5da0ebc4..85f02d8c645d 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -14,6 +14,7 @@ memory@80000000 {
 		/* 16 GB RAM */
 		reg = <0x00 0x80000000 0x00 0x80000000>,
 		      <0x08 0x80000000 0x03 0x80000000>;
+		bootph-all;
 	};
 
 	reserved_memory: reserved-memory {
@@ -136,6 +137,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (H24) WKUP_I2C0_SCL */
 			J721S2_WKUP_IOPAD(0x09c, PIN_INPUT, 0) /* (H27) WKUP_I2C0_SDA */
 		>;
+		bootph-all;
 	};
 };
 
@@ -149,6 +151,7 @@ eeprom@51 {
 		/* AT24C512C-MAHM-T */
 		compatible = "atmel,24c512";
 		reg = <0x51>;
+		bootph-all;
 	};
 };
 

-- 
2.43.2


