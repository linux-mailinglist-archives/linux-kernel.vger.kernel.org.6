Return-Path: <linux-kernel+bounces-252413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915039312C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BE51C212A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B976189F34;
	Mon, 15 Jul 2024 11:04:17 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C1188CA4;
	Mon, 15 Jul 2024 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041457; cv=none; b=RJmcoQopW9tQ7KfBPMt5WG4D1dbH99gnJoUXbEje4cp9ul8C1gkKrk4vd9VVqUZqIlstJLGEx8+JOqrkYA0WsCap62LkZVce97Wlub+Hz7D84EoFdZzmd4y6F1ebUW1KzzBgYK3fym/9K5m/WlznP+NznLsQOEiw+acgB1l/Y50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041457; c=relaxed/simple;
	bh=jQZXPjC9rL31xUb9Is+Qs2L8/C+PL4JdLjc+3vJPBMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rP1NLoZnlqJSKCTLH+wkb3dsQ86nPD6oFDnIkzk1Org8LPQ/CQgnEwzJ6HMq/TUABZiYpBC/Ndaw+AG6ggVociy9Ah1m+uVeaJJR+cbFd9XLLLs4TbYn3b4Sno89v+f3bbb47DHR9gEJvZ1qIXpPjB0p51WgM1v+ILy3hCBeUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sTJV4-0006GM-M0; Mon, 15 Jul 2024 13:04:10 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: fix the pcie refclock oscillator on Rock 5 ITX
Date: Mon, 15 Jul 2024 13:02:51 +0200
Message-Id: <20240715110251.261844-4-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240715110251.261844-1-heiko@sntech.de>
References: <20240715110251.261844-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rock 5 ITX uses two PCIe controllers to drive both a M.2 slot and its
SATA controller with 2 lanes each. The supply for the refclk oscillator is
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
 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
index d0b922b8d67e8..37bc53f2796fc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
@@ -72,6 +72,15 @@ hdd-led2 {
 		};
 	};
 
+	/* Unnamed voltage oscillator: 100MHz,3.3V,3225 */
+	pcie30_port0_refclk: pcie30_port1_refclk: pcie-voltage-oscillator {
+		compatible = "voltage-oscillator";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "pcie30_refclk";
+		vdd-supply = <&vcc3v3_pi6c_05>;
+	};
+
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
@@ -146,13 +155,14 @@ vcc3v3_lan: vcc3v3_lan_phy2: regulator-vcc3v3-lan {
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
@@ -513,6 +523,18 @@ &pcie30phy {
 
 /* ASMedia ASM1164 Sata controller */
 &pcie3x2 {
+	/*
+	 * The board has a "pcie_refclk" oscillator that needs enabling,
+	 * so add it to the list of clocks.
+	 */
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
@@ -522,6 +544,18 @@ &pcie3x2 {
 
 /* M.2 M.key */
 &pcie3x4 {
+	/*
+	 * The board has a "pcie_refclk" oscillator that needs enabling,
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


