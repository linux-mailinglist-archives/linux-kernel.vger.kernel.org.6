Return-Path: <linux-kernel+bounces-241968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66051928204
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09122B24365
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309521448EA;
	Fri,  5 Jul 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dfskai/R"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFFB143C70;
	Fri,  5 Jul 2024 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160815; cv=none; b=EbIcBgXk5jOA6hpUd2pYm0uMzmfIpoiwc4TTh311EAfurWFrMfl0PR0YxmNbqu0+9wrKTfobNIawdirRhILZnBLazLdWw06vWusTrs1dauxk0ETQNrtqRNlRitSBbNxuhmv0b2q+mBHC7qHylQhCWBNT5JcLfhUMZDieG87zvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160815; c=relaxed/simple;
	bh=5xcKcKdmh4LZwQH06hBeVDYPbhsy4QVjhGk/0ID6u3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VdjefVZ0WA2JPWRznj771JatYi+YDx3Cdvne6OIkKkWfaQNMwi2+YWhFG6zGkA/Vj+yzNcOLXd8HgnvuhutMr1PaiBvpuH6ZHhgZNFuTW1dWWKH3c7iA77Xvzz7Nh6QM4iUI78v/sSjeZjdzew4RZlgWw2E9UoahjRiG2GtRjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dfskai/R; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4656Qg8M108299;
	Fri, 5 Jul 2024 01:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720160802;
	bh=K3+3I0eA/Fq9o3fekulEf9ezOtXBcilsMKqwDoaFqEg=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=dfskai/RwQ2aKEjY1i5KnMP9S0kXU74eI4J4T6g3dko5q9W2Qakm+cnP3BpMmo/v0
	 RT88l06lavs+pDmJZ7F+OQ1RszrJlQ/jVfWg+nxq7gbcpCpaNhBWxdG/7aRo8MF8Rj
	 WOpQQcK8SmZoeiwC73NIui8mZt+WB9l1lOY/PQHY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4656Qgwp020378
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jul 2024 01:26:42 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 01:26:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 01:26:41 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4656QTjx127334;
	Fri, 5 Jul 2024 01:26:38 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 5 Jul 2024 11:56:28 +0530
Subject: [PATCH v2 2/5] arm64: dts: ti: k3-j784s4*: Remove bootph
 properties from parent nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240705-b4-upstream-bootph-all-v2-2-9007681ed7d8@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720160789; l=3672;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=5xcKcKdmh4LZwQH06hBeVDYPbhsy4QVjhGk/0ID6u3U=;
 b=jwEiHtTo1v3L2BbgXgjbfahFhRH5avO3eNTNw7m50ZIMAHZhDNhn4BXHyIbqDhibeKYe/2BAX
 SszkXlAIkleBEBoUdMl7xNC9XYIUZNtP9j8WwfQmuoMDn8Ih3Q1kuYs
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Removes bootph-* properties from parent nodes and aligns the bootph-* to
other u-boot.dtsi

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts         | 9 +--------
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 7 ++++---
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 9338d987180d..055e3fbbacff 100644
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
index f3a6ed1c979d..b2047828331b 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -39,7 +39,6 @@ k3_reset: reset-controller {
 	};
 
 	wkup_conf: bus@43000000 {
-		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -65,6 +64,7 @@ secure_proxy_sa3: mailbox@43600000 {
 		 * firmware on non-MPU processors
 		 */
 		status = "disabled";
+		bootph-pre-ram;
 	};
 
 	mcu_ram: sram@41c00000 {
@@ -175,10 +175,10 @@ mcu_timer0: timer@40400000 {
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
@@ -458,7 +458,6 @@ mcu_spi2: spi@40320000 {
 	};
 
 	mcu_navss: bus@28380000 {
-		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -521,6 +520,7 @@ secure_proxy_mcu: mailbox@2a480000 {
 		 * firmware on non-MPU processors
 		 */
 		status = "disabled";
+		bootph-pre-ram;
 	};
 
 	mcu_cpsw: ethernet@46000000 {
@@ -632,6 +632,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x42050000 0x00 0x350>;
 		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	tscadc0: tscadc@40200000 {

-- 
2.45.1


