Return-Path: <linux-kernel+bounces-286430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D8951ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADAD28393E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89D1B141B;
	Wed, 14 Aug 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z7LhPUvs"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413231B1400;
	Wed, 14 Aug 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638545; cv=none; b=OsN1NgQji/N9f8zVUHRIhNsRwGTp+B6Cogm4Q6eaGyUXyQgbRtWUlyzjA5oVmPE92DmDjZLeIV3rpEryWRzQpke4MzMyI0G5JUNPhZyY+/nas+LngzYWXaO/ZjixDkE9p2Kkpo4Y0onpyiFDr0OOHFsOaL/JWOCZuNKv0BdUPC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638545; c=relaxed/simple;
	bh=xenB0VaqkbfFyNwQjm11YfgqsREroIojIiJzTtFml2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plf4w6H0BFGL31+k+dsoQgxhkU/5G3MihGhRepaV9IAMYTU9SpYQkC6/cQCdR6zhv6kPT+X1VnWRZDJJczkwO+1p2ALScCy1EKhgO/Wo0RXx29veWmlJbGzMOqi2TvOKtgsvLXR9IJb/JYgIE/PuEStnp/bSSuxV4wbeNrizGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z7LhPUvs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723638545; x=1755174545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xenB0VaqkbfFyNwQjm11YfgqsREroIojIiJzTtFml2E=;
  b=Z7LhPUvs7QdZOfZNdsl28ThOlH6CXnoI/U0+QMviWuwez/juUbUAHMv3
   mr4K03bidElrVClOp4PuL4sVrrez2gv2dDgxBO+kSRnfNAvWCv3W7c5+F
   e/nHB/jo/c/1T/ndYlSPR0g7s8no0Kzlg5wt0W2FwN4FccHyuhEnl2Wkq
   JWtWAWVkxL4AboUCT7mSMulx4gxJciJtYK6evnKHM3zr4CPp3uQKzZpIf
   TdxR30QQTmxGMa+RlaIO/TnjJcsWF0+3S3LAFsNEEHDuI7U3NpZIqUMSS
   SCdoSTg+W+yN5r8At2FcCiuZaSNrWIcjDSE+XeWRG/FaCpXoglwqZ6rqk
   A==;
X-CSE-ConnectionGUID: 4X+cfYNUS7iIAk4JdwvsDg==
X-CSE-MsgGUID: ns5cuKNSRDGuyKwqAtT2zQ==
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="30486706"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 05:29:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 05:28:53 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 05:28:50 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <peda@axentia.se>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <cristian.birsan@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 5/5] ARM: dts: microchip: Rename LED sub nodes name
Date: Wed, 14 Aug 2024 15:26:33 +0300
Message-ID: <20240814122633.198562-6-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814122633.198562-1-andrei.simion@microchip.com>
References: <20240814122633.198562-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

dtbs_check warnings:
leds: 'd[0-9]', 'ds[0-9]' do not match any of the regexes:
'(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
leds: 'red', 'green', 'blue' do not match any of regexes:
'(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Rename the led sub nodes according to devicetree
specification and leds-gpio.yaml.

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
Split the bloadted patch into small patches on topics
based on comments:
https://lore.kernel.org/linux-arm-kernel/89f51615-0dee-4ab0-ab72-e3c057fee1e7@tuxon.dev/
---
 arch/arm/boot/dts/microchip/aks-cdu.dts        | 8 ++++----
 arch/arm/boot/dts/microchip/animeo_ip.dts      | 8 ++++----
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts | 6 +++---
 arch/arm/boot/dts/microchip/at91rm9200ek.dts   | 6 +++---
 arch/arm/boot/dts/microchip/at91sam9260ek.dts  | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9261ek.dts  | 6 +++---
 arch/arm/boot/dts/microchip/at91sam9263ek.dts  | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9g20ek.dts  | 4 ++--
 8 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/aks-cdu.dts b/arch/arm/boot/dts/microchip/aks-cdu.dts
index 52e166c8a365..95a0639c5579 100644
--- a/arch/arm/boot/dts/microchip/aks-cdu.dts
+++ b/arch/arm/boot/dts/microchip/aks-cdu.dts
@@ -98,23 +98,23 @@ rootfs@500000 {
 	leds {
 		compatible = "gpio-leds";
 
-		red {
+		led-red {
 			gpios = <&pioC 10 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "none";
 		};
 
-		green {
+		led-green {
 			gpios = <&pioA 5 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 			default-state = "on";
 		};
 
-		yellow {
+		led-yellow {
 			gpios = <&pioB 20 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		blue {
+		led-blue {
 			gpios = <&pioB 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
diff --git a/arch/arm/boot/dts/microchip/animeo_ip.dts b/arch/arm/boot/dts/microchip/animeo_ip.dts
index 911c8d9ee013..52ac840bcd35 100644
--- a/arch/arm/boot/dts/microchip/animeo_ip.dts
+++ b/arch/arm/boot/dts/microchip/animeo_ip.dts
@@ -146,23 +146,23 @@ ohci: usb@500000 {
 	leds {
 		compatible = "gpio-leds";
 
-		power_green {
+		led-power-green {
 			label = "power_green";
 			gpios = <&pioC 17 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		power_red {
+		led-power-red {
 			label = "power_red";
 			gpios = <&pioA 2 GPIO_ACTIVE_HIGH>;
 		};
 
-		tx_green {
+		led-tx-green {
 			label = "tx_green";
 			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
 		};
 
-		tx_red {
+		led-tx-red {
 			label = "tx_red";
 			gpios = <&pioC 18 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
index b9a21f9f9a6d..da31b07d6828 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
@@ -53,17 +53,17 @@ leds {
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 		status = "okay"; /* Conflict with pwm0. */
 
-		red {
+		led-red {
 			label = "red";
 			gpios = <&pioB 11 GPIO_ACTIVE_HIGH>;
 		};
 
-		green {
+		led-green {
 			label = "green";
 			gpios = <&pioB 12 GPIO_ACTIVE_HIGH>;
 		};
 
-		blue {
+		led-blue {
 			label = "blue";
 			gpios = <&pioB 13 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/microchip/at91rm9200ek.dts b/arch/arm/boot/dts/microchip/at91rm9200ek.dts
index 3089912dd6be..641d443e6ca9 100644
--- a/arch/arm/boot/dts/microchip/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/microchip/at91rm9200ek.dts
@@ -127,19 +127,19 @@ root@350000  {
 	leds {
 		compatible = "gpio-leds";
 
-		ds2 {
+		led-ds2 {
 			label = "green";
 			gpios = <&pioB 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "mmc0";
 		};
 
-		ds4 {
+		led-ds4 {
 			label = "yellow";
 			gpios = <&pioB 1 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		ds6 {
+		led-ds6 {
 			label = "red";
 			gpios = <&pioB 2 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/microchip/at91sam9260ek.dts b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
index ed259e2cb853..4933971d0585 100644
--- a/arch/arm/boot/dts/microchip/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
@@ -174,13 +174,13 @@ eeprom@50 {
 	leds {
 		compatible = "gpio-leds";
 
-		ds1 {
+		led-ds1 {
 			label = "ds1";
 			gpios = <&pioA 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		ds5 {
+		led-ds5 {
 			label = "ds5";
 			gpios = <&pioA 6 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/microchip/at91sam9261ek.dts b/arch/arm/boot/dts/microchip/at91sam9261ek.dts
index 4d9269cc5f32..9c44177db714 100644
--- a/arch/arm/boot/dts/microchip/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9261ek.dts
@@ -192,19 +192,19 @@ watchdog@fffffd40 {
 	leds {
 		compatible = "gpio-leds";
 
-		ds8 {
+		led-ds8 {
 			label = "ds8";
 			gpios = <&pioA 13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		ds7 {
+		led-ds7 {
 			label = "ds7";
 			gpios = <&pioA 14 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "nand-disk";
 		};
 
-		ds1 {
+		led-ds1 {
 			label = "ds1";
 			gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/microchip/at91sam9263ek.dts b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
index a8ea36db4c04..cf5434f9449d 100644
--- a/arch/arm/boot/dts/microchip/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
@@ -219,13 +219,13 @@ &pioA 21 GPIO_ACTIVE_HIGH
 	leds {
 		compatible = "gpio-leds";
 
-		d3 {
+		led-d3 {
 			label = "d3";
 			gpios = <&pioB 7 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		d2 {
+		led-d2 {
 			label = "d2";
 			gpios = <&pioC 29 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "nand-disk";
diff --git a/arch/arm/boot/dts/microchip/at91sam9g20ek.dts b/arch/arm/boot/dts/microchip/at91sam9g20ek.dts
index 6de7a7cd3c07..1e62fd371ddb 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g20ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9g20ek.dts
@@ -14,13 +14,13 @@ / {
 	leds {
 		compatible = "gpio-leds";
 
-		ds1 {
+		led-ds1 {
 			label = "ds1";
 			gpios = <&pioA 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		ds5 {
+		led-ds5 {
 			label = "ds5";
 			gpios = <&pioA 6 GPIO_ACTIVE_LOW>;
 		};
-- 
2.34.1


