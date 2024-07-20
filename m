Return-Path: <linux-kernel+bounces-258068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CEE9382E5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 23:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13A7282B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FBD1494C2;
	Sat, 20 Jul 2024 21:11:13 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B2148FF3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721509872; cv=none; b=U6XyrqIPMWyeOSHp3yeKG3n0G7tfjwL9NbIyW2NFh6agvveEFheBG/ntXCeUT181cgyGa42ATpRQQQR8u4i99raHqNG+luGhMvz2/LSRPGA4YSJT1AQ7IKMkVwZ/6Jsa9vOJZgLT8v2E+v+Ek+Ap+56U9k44lT4jyQxWkMPinM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721509872; c=relaxed/simple;
	bh=8nshw+VonucN8pE6DwNpoD32btdzY5apzYXVStXpqXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TI8dJu3yOA3aCCs7qIlUy0c87ckxDAggFOv5eO+BNxkHppQmOJrYhftowRKydSchrf0dhgZkXJLqsQm4i1BDZaKu9UaWupblSYrxJGvfMH8A692MBC5dcuvlDyrcdbVb3kzt03awpW8JkDSA2SwcYHkL0xrZDnRjEXS02IUawJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVHKE-00061D-4I; Sat, 20 Jul 2024 23:09:06 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: rockchip: add hdd leds to Qnap-TS433
Date: Sat, 20 Jul 2024 23:08:56 +0200
Message-Id: <20240720210856.778014-11-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240720210856.778014-1-heiko@sntech.de>
References: <20240720210856.778014-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the 4 gpio-controlled LEDs to the Qnap-TS433.

They are meant for individual disk activitivy, but I haven't found a
way for how to connect them to their individual sata slot yet.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index c05433ca7dda4..d36467c2baf02 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "rk3568.dtsi"
 
@@ -22,6 +23,46 @@ chosen: chosen {
 		stdout-path = "serial2:115200n8";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led_hdd1: led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "disk-activity";
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdd1_led_pin>;
+		};
+
+		led_hdd2: led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "disk-activity";
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdd2_led_pin>;
+		};
+
+		led_hdd3: led-2 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			gpios = <&gpio1 RK_PD7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "disk-activity";
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdd3_led_pin>;
+		};
+
+		led_hdd4: led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "disk-activity";
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdd4_led_pin>;
+		};
+	};
+
 	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
@@ -158,6 +199,24 @@ &pcie3x2 {
 };
 
 &pinctrl {
+	leds {
+		hdd1_led_pin: hdd1-led-pin {
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		hdd2_led_pin: hdd2-led-pin {
+			rockchip,pins = <1 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		hdd3_led_pin: hdd3-led-pin {
+			rockchip,pins = <1 RK_PD7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		hdd4_led_pin: hdd4_led-pin {
+			rockchip,pins = <2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	usb {
 		vcc5v0_host_en: vcc5v0-host-en {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.39.2


