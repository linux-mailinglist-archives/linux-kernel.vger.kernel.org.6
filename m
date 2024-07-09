Return-Path: <linux-kernel+bounces-245800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0829192B97F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF85B24F05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC3A1591F1;
	Tue,  9 Jul 2024 12:31:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFB14532C;
	Tue,  9 Jul 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528309; cv=none; b=rkWYHgXhLF0jE8/mivwM6be+LvxDbaRRjhZAskw7ovyikTch716a4+53lqVlzUzw6AGKmKoSHoUEg8mhqvYLHs6PVnN9g5UEegglT7+mDvb7jiOZY8ecuNEavUIxlfgoWRe+4OX/0xY1aPKYoAQQMJHGCu09FmQQMWEsHfwChIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528309; c=relaxed/simple;
	bh=srr3rG7zk9AQybXcR7VTgAzXU5q9doJfEgMH9LtLYLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgE+wAi0zU++hTTDlzEYEwfNi/0XnGepReVa6cYf5vo1cMjXF+uEKeyGABSxmOYkHVSZScKnqB/UE39HoU5L382Pd+2sNswT7HbPhJQ4MhzXyzapoDs9xs8xN8/X4hlw4wqfbdS9aCjcSGw6bUw4QpnAhrHMKMd8SxIv+MkOs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sRA0U-00074P-6m; Tue, 09 Jul 2024 14:31:42 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 3/6] arm64: dts: rockchip: fix the pcie clock generator on Rock 5 ITX
Date: Tue,  9 Jul 2024 14:31:18 +0200
Message-Id: <20240709123121.1452394-4-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240709123121.1452394-1-heiko@sntech.de>
References: <20240709123121.1452394-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rock 5 ITX uses two PCIe controllers to drive both a M.2 slot and its
SATA controller with 2 lanes each. The supply for the clock generator is
the same that supplies the M.2 slot, but the SATA controller port is
supplied by a different rail.

This leads to the effect that if the PCIe30x4 controller for the M.2
probes first, everything works normally. But if the PCIe30x2 controller
that is connected to the SATA controller probes first, it will hang on
the first DBI read as nothing will have enabled the refclock before.

Fix this by describing the clock generator with its supplies so that
both controllers can reference it as needed.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../boot/dts/rockchip/rk3588-rock-5itx.dts    | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5itx.dts
index 41d92ceeeb09c..21fb3d940b489 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5itx.dts
@@ -77,6 +77,15 @@ hdd-led2 {
 		};
 	};
 
+	/* Unnamed clock generator: 100MHz,3.3V,3225 */
+	pcie30_port0_refclk: pcie30_port1_refclk: pcie-clock-generator {
+		compatible = "clock-generator";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "pcie30_refclk";
+		vdd-supply = <&vcc3v3_pi6c_05>;
+	};
+
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
@@ -151,13 +160,14 @@ vcc3v3_lan: vcc3v3_lan_phy2: regulator-vcc3v3-lan {
 		vin-supply = <&vcc_3v3_s3>;
 	};
 
-	vcc3v3_mkey: regulator-vcc3v3-mkey {
+	/* The PCIE30x4_PWREN_H controls two regulators */
+	vcc3v3_mkey: vcc3v3_pi6c_05: regulator-vcc3v3-pi6c-05 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pcie30x4_pwren_h>;
-		regulator-name = "vcc3v3_mkey";
+		regulator-name = "vcc3v3_pi6c_05";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <5000>;
@@ -519,6 +529,14 @@ &pcie30phy {
 
 /* ASMedia ASM1164 Sata controller */
 &pcie3x2 {
+	clocks = <&cru ACLK_PCIE_2L_MSTR>, <&cru ACLK_PCIE_2L_SLV>,
+		 <&cru ACLK_PCIE_2L_DBI>, <&cru PCLK_PCIE_2L>,
+		 <&cru CLK_PCIE_AUX1>, <&cru CLK_PCIE2L_PIPE>,
+		 <&pcie30_port1_refclk>;
+	clock-names = "aclk_mst", "aclk_slv",
+		      "aclk_dbi", "pclk",
+		      "aux", "pipe",
+		      "ref";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie30x2_perstn_m1_l>;
 	reset-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
@@ -528,6 +546,18 @@ &pcie3x2 {
 
 /* M.2 M.key */
 &pcie3x4 {
+	/*
+	 * The board has a gpio-controlled "pcie_refclk" generator,
+	 * so add it to the list of clocks.
+	 */
+	clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
+		 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
+		 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>,
+		 <&pcie30_port0_refclk>;
+	clock-names = "aclk_mst", "aclk_slv",
+		      "aclk_dbi", "pclk",
+		      "aux", "pipe",
+		      "ref";
 	num-lanes = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie30x4_perstn_m1_l>;
-- 
2.39.2


