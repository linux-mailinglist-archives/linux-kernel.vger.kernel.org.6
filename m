Return-Path: <linux-kernel+bounces-260369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591A793A7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BA8284E25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7674D148841;
	Tue, 23 Jul 2024 19:55:53 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089E14265F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764552; cv=none; b=huoqGNNY2c8IawooL8mBA49g9PZB8Qm2oQE8oXdWrOUPM98qfH55hRgntIWRuvOfTJaSYxY7+TC6KxTLgmI/M00MQS9ehwvEz3o4aUmpqTKGFkamGADAy4IWc2+J1Mc7atD2jxXVs3/3q1zwLw0oNpH9ZP/FvR8X5MoJzvQmBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764552; c=relaxed/simple;
	bh=blULZrk13edLjmvHGMo0BEZQI3JntETqqMg35CNfIOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4VL9w3KHqzeEMqpS+9BZ+rLRZeaKKtnYqpH35+fSZQOGc6cTUluB8JbKUgvl/vBpfY1UE/Aa2Ku9+N+7VPYicVX6v/w8ylCPIhYW4pi3yIxQKvtF3pziGOSRJ01D36XhcYjIEDyE/R3lOBYJk0DUykYpQsVu2xJgqrK2TBMQRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sWLbu-0005iD-48; Tue, 23 Jul 2024 21:55:46 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/14] arm64: dts: rockchip: add hdd leds to Qnap-TS433
Date: Tue, 23 Jul 2024 21:55:32 +0200
Message-Id: <20240723195538.1133436-9-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723195538.1133436-1-heiko@sntech.de>
References: <20240723195538.1133436-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the 4 gpio-controlled LEDs to the Qnap-TS433.

They are meant for individual disk activitivy, but I haven't found a
way for how to connect them to their individual sata slot yet.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 8be36250aa13d..abeb00add42a0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "rk3568.dtsi"
 
@@ -23,6 +24,46 @@ chosen {
 		stdout-path = "serial2:115200n8";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "disk-activity";
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdd1_led_pin>;
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "disk-activity";
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdd2_led_pin>;
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			gpios = <&gpio1 RK_PD7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "disk-activity";
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdd3_led_pin>;
+		};
+
+		led-3 {
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
@@ -161,6 +202,24 @@ &pcie3x2 {
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


