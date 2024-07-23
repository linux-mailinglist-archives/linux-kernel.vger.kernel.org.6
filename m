Return-Path: <linux-kernel+bounces-260373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438E993A7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76EA1F23D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584AC14290C;
	Tue, 23 Jul 2024 19:56:31 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049D1422C2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764590; cv=none; b=dldW9c3mLK6C9/3iEOzdqBPZEwu+W6hlFJSzZlLn48mcpc0lnOi07dD5cAzks4Zrm6zPAvDqJUUTpnl2HA/uHKBVBZ0pdacf836UD6oropkPfjioH64N/nvs22WkHzw6QYnw5g0Tngrpzznw5B/p+WGlvYtPl9Z9YooyhQ+R5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764590; c=relaxed/simple;
	bh=ZbBdeRJxuk7YbO/bXBzO3YnepfTaBAf2cbZ75sW7jcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lers1YbI0tAEEqlfZkPV4z+zoTbdsSxutZGKf2oqCESVSBTi26ZvrgLgI4qkS6bDaBuBQ6XDrdx+FffjThK7KDJtfCOXefTU0Gy8VrhIDYQ0GGNJNUz32GPeu3bZNM1aG3kD37lDwS2pYovKJzdLG2L9Nek1jg634Z3zohguFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sWLbv-0005iD-0R; Tue, 23 Jul 2024 21:55:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/14] arm64: dts: rockchip: define cpu-supply on the Qnap-TS433
Date: Tue, 23 Jul 2024 21:55:35 +0200
Message-Id: <20240723195538.1133436-12-heiko@sntech.de>
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

The TS433 seems to use a silergy,syr827 regulator for the cpu supply.
At least that is the compatible used in the vendor devicetree, though
it could very well also be another fan53555 clone.

Define the needed regulator node and hook up the cpu-supply to the
cpu cores.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 9f964b6f411c9..4bccefc0537ed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -130,6 +130,16 @@ vcc5v0_otg: regulator-vcc5v0-otg {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
+	vcc5v0_sys: regulator-vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
 	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
@@ -156,6 +166,22 @@ &combphy2 {
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
 &gmac0 {
 	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
 	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
@@ -175,12 +201,27 @@ &gmac0_rgmii_clk
 };
 
 &i2c0 {
+	status = "okay";
+
 	pmic@20 {
 		compatible = "rockchip,rk809";
 		reg = <0x20>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	vdd_cpu: regulator@40 {
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1390000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+	};
 };
 
 &i2c1 {
-- 
2.39.2


