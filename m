Return-Path: <linux-kernel+bounces-267203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80505940E64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BF0B2AF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AF198A03;
	Tue, 30 Jul 2024 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jJzBue33"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A59196D90;
	Tue, 30 Jul 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333261; cv=none; b=gqeWUcx7q3tyX9SIuLX/gnIGOem4Dbvp9NtMsJOVesRdiCmVy1pgPrOiKNv/Op8U3uxNitrf7iBmlLGyjlE7zawVIVm/JfTfNLTPiNvjKXxOLHRUDAVlYjmJEWormDGpYZV/TVU394lk3hFdqnMpGyaEznBDbpqofktBtzUQtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333261; c=relaxed/simple;
	bh=Tqq4mGbTWUGJWWPDhDmAnhaqMawTIFDH4UGbyC+QCO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sixyN9anhPLdta3JfFsSKYRjeHhKXrmO12YmsSEvUYJfUwR59ApXpXXtqii3S76fC7/GBxejCPu/uJRKCa3y1YZpCIAbNu6dIU+OY4ZvtrQzKw/hpf0OR8uZyOMXWNt1ApRqI3PbuMKFccvsOtoWNu7Po1Q1ltZ6KxA9FAhz9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jJzBue33; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U9sEPQ034494;
	Tue, 30 Jul 2024 04:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722333254;
	bh=0A24xGHGG/aAsy6393xK5rJc+zzzl+M+wxBl0ou5iug=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=jJzBue33BM8bRMAp0szJ3mHGXIBcg/NULYSNxjlctCCM5m8Lov7xRZKhZPzWz/7gN
	 O48NZe/GERRRvLl44lzHEHi8SaNfetSRVnkNSCBytZGsvqAB9SbdcVx2m/Mah/EnJN
	 tvEFdZhteQL4kCX3FjjrCptud/fMjgJbB1WXseKg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U9sE2O110834
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 04:54:14 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 04:54:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 04:54:14 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46U9rulx008969;
	Tue, 30 Jul 2024 04:54:10 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 30 Jul 2024 15:23:53 +0530
Subject: [PATCH v3 3/5] arm64: dts: ti: k3-am68*: Add bootph-* properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240730-b4-upstream-bootph-all-v3-3-9bc2eccb6952@ti.com>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
In-Reply-To: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
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
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Manorit Chawdhry
	<m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722333236; l=3401;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=Tqq4mGbTWUGJWWPDhDmAnhaqMawTIFDH4UGbyC+QCO4=;
 b=4PEsAmu9t65V2/HxgLzhvHRP2wu3FI82/7nfsF9wqT1wcgw6iLY2HCw8q6nTwp/vAL+yckWzd
 +yuYNX85uUQDjB8vOd+24KH4923vJB/Zu0wdG71KDuwIMc+/TCf8TV9
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Adds bootph-* properties to the leaf nodes to enable U-boot to
utilise them.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi       |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 90dbe31c5b81..38f146f6d8e9 100644
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
@@ -412,6 +416,7 @@ &wkup_uart0 {
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
+	bootph-all;
 };
 
 &wkup_i2c0 {
@@ -494,6 +499,7 @@ &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
+	bootph-all;
 };
 
 &main_uart8 {
@@ -502,6 +508,7 @@ &main_uart8 {
 	pinctrl-0 = <&main_uart8_pins_default>;
 	/* Shared with TFA on this platform */
 	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
+	bootph-all;
 };
 
 &main_i2c0 {
@@ -596,6 +603,7 @@ &main_sdhci1 {
 	disable-wp;
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv>;
+	bootph-all;
 };
 
 &mcu_cpsw {
@@ -728,6 +736,7 @@ &usbss0 {
 	pinctrl-0 = <&main_usbss0_pins_default>;
 	pinctrl-names = "default";
 	ti,vbus-divider;
+	bootph-all;
 };
 
 &usb0 {
@@ -735,4 +744,5 @@ &usb0 {
 	maximum-speed = "super-speed";
 	phys = <&serdes0_usb_link>;
 	phy-names = "cdns3,usb3-phy";
+	bootph-all;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
index 5c66e0ec6e82..f2ec7ed0f2ec 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -156,6 +156,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (H24) WKUP_I2C0_SCL */
 			J721S2_WKUP_IOPAD(0x09c, PIN_INPUT, 0) /* (H27) WKUP_I2C0_SDA */
 		>;
+		bootph-all;
 	};
 };
 
@@ -169,6 +170,7 @@ eeprom@51 {
 		/* AT24C512C-MAHM-T */
 		compatible = "atmel,24c512";
 		reg = <0x51>;
+		bootph-all;
 	};
 };
 

-- 
2.45.1


