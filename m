Return-Path: <linux-kernel+bounces-267204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27539940E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0CE1F230AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA43197A87;
	Tue, 30 Jul 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AtlYzQPj"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A1196D90;
	Tue, 30 Jul 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333268; cv=none; b=HkywlwEMCuUeURoP3vAmsYvitM/HwkVgz8j7S040Zzds56GjAVydVyNyfHGxZlLi/77E2O5z60fqcEsoxJPXMFTL6XSV5RrkJ5Sfmc3+rVOCUiqErltY23yrz8yOVhg8JrN0qr6tK6a7WOfbwB5hMG3BI8A5swqU9Nf8fSKC+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333268; c=relaxed/simple;
	bh=zry/bodtwVll3pFkNc5YctAhK3qFagPkEVKM0V03aTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GHPSsjAB3wRxwwNZktd6XzUXjFd5ve4H+SEphJRWlaTLI78wyGHqVh93LrmauyWEo+INheVAPMuwZh1y2U8ewPWmzanwGDs7thcTgZOzut1vXcAEZR2HvWA3Un6E3rLwFFXytoodG4JkReuCWfUfpqYkyeTF1Mp9wZQMtmNJPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AtlYzQPj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U9sAnN006266;
	Tue, 30 Jul 2024 04:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722333250;
	bh=y0XmRH2km8u1WBSPAhLdIwBWAGS7cOAerD0MdNPBl0U=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=AtlYzQPjO3XRpfuOiFtVOR/K6fYg0dDm8cC/aITT2XWgDGhUNPuEYrvzgr8o3f/p7
	 f6zGC09XLIa90CqBJKrsPuOnFcMuWyGXqVumNbqP9ZsP1crNvrJbz9QluWZRd5PEiK
	 tn8b5GgID+1PWiEf7p/BMMcOxuM2B1f/9tOVfCyI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U9sAr7087502
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 04:54:10 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 04:54:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 04:54:09 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46U9rulw008969;
	Tue, 30 Jul 2024 04:54:05 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 30 Jul 2024 15:23:52 +0530
Subject: [PATCH v3 2/5] arm64: dts: ti: k3-j784s4*: Remove bootph
 properties from parent nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240730-b4-upstream-bootph-all-v3-2-9bc2eccb6952@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722333236; l=3825;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=zry/bodtwVll3pFkNc5YctAhK3qFagPkEVKM0V03aTI=;
 b=RZOKC6WoxxcvkCnj4f3LcC2cMutzsIsn+0FQWCrFhmyvPoENGFF29+Hd/zU3evUq3vSA9Bgvi
 m2CXay0alpaChIse1GS1/JRhbRVCs3TaP2tM/M4BXFj8icgpX4mjslC
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Removes bootph-* properties from parent nodes and aligns the bootph-* to
other u-boot.dtsi

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts         | 9 +--------
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 8 ++++----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index ffa38f41679d..311844490027 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -461,7 +461,6 @@ J784S4_IOPAD(0x078, PIN_OUTPUT, 1) /* (AH37) MCAN2_RX.AUDIO_EXT_REFCLK1 */
 };
 
 &wkup_pmx2 {
-	bootph-all;
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -577,7 +576,6 @@ J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
 };
 
 &wkup_pmx0 {
-	bootph-all;
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -597,7 +595,6 @@ J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
 };
 
 &wkup_pmx1 {
-	bootph-all;
 	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -668,6 +665,7 @@ bucka12: buck12 {
 				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-pre-ram;
 			};
 
 			bucka3: buck3 {
@@ -769,18 +767,15 @@ &ufs_wrapper {
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
@@ -837,13 +832,11 @@ partition@3fc0000 {
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
index f3a6ed1c979d..3f89277e3c2c 100644
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
@@ -65,6 +63,7 @@ secure_proxy_sa3: mailbox@43600000 {
 		 * firmware on non-MPU processors
 		 */
 		status = "disabled";
+		bootph-pre-ram;
 	};
 
 	mcu_ram: sram@41c00000 {
@@ -175,10 +174,10 @@ mcu_timer0: timer@40400000 {
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
@@ -458,7 +457,6 @@ mcu_spi2: spi@40320000 {
 	};
 
 	mcu_navss: bus@28380000 {
-		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -521,6 +519,7 @@ secure_proxy_mcu: mailbox@2a480000 {
 		 * firmware on non-MPU processors
 		 */
 		status = "disabled";
+		bootph-pre-ram;
 	};
 
 	mcu_cpsw: ethernet@46000000 {
@@ -632,6 +631,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x42050000 0x00 0x350>;
 		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	tscadc0: tscadc@40200000 {

-- 
2.45.1


