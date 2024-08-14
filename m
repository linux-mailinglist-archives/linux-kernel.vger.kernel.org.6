Return-Path: <linux-kernel+bounces-286042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E5C9515C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B901C229E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD16A01E;
	Wed, 14 Aug 2024 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dj2CLBGA"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154164DA00;
	Wed, 14 Aug 2024 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621672; cv=none; b=OvYMsj7TtUMRltoZa0Z+HUxT09x1iaKzkV394WlJ5QuvtzPYFtL+tNi8qmfzjUOMAdCUSlGE1EjYPLLEA93Ry1/1wcnCu7JWAjwoWgEhD6EO8XhiDFisxhAxW+bm6WNBC+9jy/ZepndZGcs2mOkKtNO7gXuH52Pj33GByv2mNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621672; c=relaxed/simple;
	bh=MnJSlDIzS3p80J0ddGpEn71a3q+1W+2Dm9IKE2uIXN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GPBuHBrs/T6Jd0ASr+KnJ1yjOFExghIP4mcxgaHRZKQAk0RxnLbKEHxRsnxVV5kh/6ufmHic6e8Ekf9YMGWZmxL6I7JSG1t4VkPYvNhhoHQInIpMI9DxCWHpyghhL1xjOq37+n+W6H/Hu65GfJ1pId8U1pJA3ieAEro+tWp3bs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dj2CLBGA; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E7li58106505;
	Wed, 14 Aug 2024 02:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723621664;
	bh=n+vzytBZzz809tlKpC3QW1kjxZli/HYBhbgQW+QsigU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=dj2CLBGAyUqeHu0YPISSdULN4RY+AjfGTiIalwMM6KkfcVHZiccnhWNjXcOkqL3Mi
	 z1rimKuwXlI+KLGjt392YUUrD+nWhjQpAt2UWDUZZQv7VznXkDLPtlsOVeqLxWPyY7
	 qJs9np3L3kOPF6mFB+IC91TJz8HwDqaHzD14yKKs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E7liGN113709
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 02:47:44 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 02:47:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 02:47:44 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E7lT2G059812;
	Wed, 14 Aug 2024 02:47:40 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 14 Aug 2024 13:17:29 +0530
Subject: [PATCH v4 2/5] arm64: dts: ti: k3-j784s4*: Remove bootph
 properties from parent nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240814-b4-upstream-bootph-all-v4-2-f2b462000f25@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723621650; l=4521;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=MnJSlDIzS3p80J0ddGpEn71a3q+1W+2Dm9IKE2uIXN8=;
 b=Sa+GpxuE06IpbYpQNr0vR74U6FmFemCPtNfAh7bVUaJ/0E020PRQwKyUk2XEwZReIrejA35Pe
 FIzGOkeNcneBrfi/A+y8zi4Zx+YSQQ9VzhUvrh3KwRzbEi2aofDMQbf
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Removes bootph-* properties from parent nodes and adds bootph for other
bootloader nodes.

Also moves bootph from mcu_timer1 to mcu_timer0 as that is the one that
is used in bootloader.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts         | 10 +---------
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 10 ++++++----
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index ffa38f41679d..08f4791a3ee8 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -334,7 +334,6 @@ &wkup_gpio0 {
 };
 
 &main_pmx0 {
-	bootph-all;
 	main_cpsw2g_default_pins: main-cpsw2g-default-pins {
 		pinctrl-single,pins = <
 			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
@@ -461,7 +460,6 @@ J784S4_IOPAD(0x078, PIN_OUTPUT, 1) /* (AH37) MCAN2_RX.AUDIO_EXT_REFCLK1 */
 };
 
 &wkup_pmx2 {
-	bootph-all;
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -577,7 +575,6 @@ J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
 };
 
 &wkup_pmx0 {
-	bootph-all;
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -597,7 +594,6 @@ J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
 };
 
 &wkup_pmx1 {
-	bootph-all;
 	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -668,6 +664,7 @@ bucka12: buck12 {
 				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-pre-ram;
 			};
 
 			bucka3: buck3 {
@@ -769,18 +766,15 @@ &ufs_wrapper {
 };
 
 &fss {
-	bootph-all;
 	status = "okay";
 };
 
 &ospi0 {
-	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
 
 	flash@0 {
-		bootph-all;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -837,13 +831,11 @@ partition@3fc0000 {
 };
 
 &ospi1 {
-	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
 
 	flash@0 {
-		bootph-all;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index f3a6ed1c979d..6409e702ffd4 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -7,7 +7,6 @@
 
 &cbass_mcu_wakeup {
 	sms: system-controller@44083000 {
-		bootph-all;
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 
@@ -39,7 +38,6 @@ k3_reset: reset-controller {
 	};
 
 	wkup_conf: bus@43000000 {
-		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -59,6 +57,8 @@ secure_proxy_sa3: mailbox@43600000 {
 		reg = <0x00 0x43600000 0x00 0x10000>,
 		      <0x00 0x44880000 0x00 0x20000>,
 		      <0x00 0x44860000 0x00 0x20000>;
+		bootph-pre-ram;
+
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -172,13 +172,13 @@ mcu_timer0: timer@40400000 {
 		assigned-clocks = <&k3_clks 35 2>;
 		assigned-clock-parents = <&k3_clks 35 3>;
 		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		bootph-all;
 		ti,timer-pwm;
 		/* Non-MPU Firmware usage */
 		status = "reserved";
 	};
 
 	mcu_timer1: timer@40410000 {
-		bootph-all;
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x40410000 0x00 0x400>;
 		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
@@ -458,7 +458,6 @@ mcu_spi2: spi@40320000 {
 	};
 
 	mcu_navss: bus@28380000 {
-		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -515,6 +514,8 @@ secure_proxy_mcu: mailbox@2a480000 {
 		reg = <0x00 0x2a480000 0x00 0x80000>,
 		      <0x00 0x2a380000 0x00 0x80000>,
 		      <0x00 0x2a400000 0x00 0x80000>;
+		bootph-pre-ram;
+
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -632,6 +633,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x42050000 0x00 0x350>;
 		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	tscadc0: tscadc@40200000 {

-- 
2.46.0


