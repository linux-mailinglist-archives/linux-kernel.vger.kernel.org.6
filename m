Return-Path: <linux-kernel+bounces-171021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2B18BDEDE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE60B1F224F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392214F10E;
	Tue,  7 May 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t+e7mPD6"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65515E5BB;
	Tue,  7 May 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075104; cv=none; b=ShrsOomxaGY3GFpVMdL1aI2iMS7oJ9TSyPiQfDmFwF5ZaFlHYeSi956UE7r/bD+VqD0+L1YLgWPonInxb3X4LCoqUZmcTrZMC8FSOf4aIMaLmKVA5e0LPRhWx+zu1OODitSOfdUGQLr6myfoGf+WiaumYA/x+ou/R5sbLQ5TyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075104; c=relaxed/simple;
	bh=BONsjm43a6vU/CXa6qDMbtJT3z1qMQHysxnl1rgkKVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qbjPgI+WpeRkKohssR+lnLrf5eZppOLhuQTaLCYgga59g9pLMK9+7M9VVYjPnaBS7KfbZAQTB+KM3NEue9ZnSzQ4Z83zEdgWICcOG0YRLU/Dc1RFz4gsHQyqUDrARhx0GVV++YkVcE3iNK9sTWqxcAL50UhSgGpoG0WKY7L0YDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t+e7mPD6; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4479ilVD054872;
	Tue, 7 May 2024 04:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715075087;
	bh=pkOS5m+eyJ1WxYIqnI2Svp6a7Kob3Ol/IrREcrUuNTA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=t+e7mPD6DMruqemriMUa9dtIBeL+G9ccu14eZ1G4WdcB9aQFhv0Qmw4CVerQVqJJi
	 0U08bW8XshzEgc8HGo0d9lyp0wIZrx/M9jOU0L3NJ40rFoKIKd1uzmd+UaXqTDY2cL
	 YF9ScsecjZvdai4Qck0ERwD8XFeKsHUDS60jf/qg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4479ilQc026160
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 04:44:47 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 04:44:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 04:44:47 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4479iXjW117029;
	Tue, 7 May 2024 04:44:43 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 7 May 2024 15:14:29 +0530
Subject: [PATCH 2/5] arm64: dts: ti: k3-j784s4*: Remove bootph properties
 from parent nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240507-b4-upstream-bootph-all-v1-2-c6d52651856f@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715075073; l=4211;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=BONsjm43a6vU/CXa6qDMbtJT3z1qMQHysxnl1rgkKVs=;
 b=qWfF1quFikUZV/kw4uTC5muhqJroARVt53l42DYut7GYzpVQ1c+nHLe+p+RYeEK++X6K0785x
 FQUfzRaD/XHBfg0WX30L1mXWT3AXarPOnoofC1mnU7jbIoCqgWkk83n
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Removes bootph-* properties from parent nodes and aligns the bootph-* to
other u-boot.dtsi

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts         | 10 +---------
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |  1 +
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi |  6 +++---
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 81fd7afac8c5..f262eb1a6c65 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -279,7 +279,6 @@ &wkup_gpio0 {
 };
 
 &main_pmx0 {
-	bootph-all;
 	main_uart8_pins_default: main-uart8-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -339,7 +338,6 @@ J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
 };
 
 &wkup_pmx2 {
-	bootph-all;
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -429,7 +427,6 @@ J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
 };
 
 &wkup_pmx0 {
-	bootph-all;
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -449,7 +446,6 @@ J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
 };
 
 &wkup_pmx1 {
-	bootph-all;
 	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -520,6 +516,7 @@ bucka12: buck12 {
 				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-pre-ram;
 			};
 
 			bucka3: buck3 {
@@ -600,18 +597,15 @@ &ufs_wrapper {
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
@@ -668,13 +662,11 @@ partition@3fc0000 {
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
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index b67c37460a73..46bd3cd1b006 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1120,6 +1120,7 @@ secure_proxy_main: mailbox@32c00000 {
 			      <0x00 0x32800000 0x00 0x100000>;
 			interrupt-names = "rx_011";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			bootph-all;
 		};
 
 		hwspinlock: hwlock@30e00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 77a8d99139ec..951ff3ec3ea0 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -39,7 +39,6 @@ k3_reset: reset-controller {
 	};
 
 	wkup_conf: bus@43000000 {
-		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -171,10 +170,10 @@ mcu_timer0: timer@40400000 {
 		ti,timer-pwm;
 		/* Non-MPU Firmware usage */
 		status = "reserved";
+		bootph-all;
 	};
 
 	mcu_timer1: timer@40410000 {
-		bootph-all;
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x40410000 0x00 0x400>;
 		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
@@ -456,7 +455,6 @@ mcu_spi2: spi@40320000 {
 	};
 
 	mcu_navss: bus@28380000 {
-		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -519,6 +517,7 @@ secure_proxy_mcu: mailbox@2a480000 {
 		 * firmware on non-MPU processors
 		 */
 		status = "disabled";
+		bootph-pre-ram;
 	};
 
 	mcu_cpsw: ethernet@46000000 {
@@ -630,6 +629,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x42050000 0x00 0x350>;
 		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	tscadc0: tscadc@40200000 {

-- 
2.43.2


