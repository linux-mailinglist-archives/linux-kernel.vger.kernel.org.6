Return-Path: <linux-kernel+bounces-245803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61A92B989
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A1D1F230CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290315ECE5;
	Tue,  9 Jul 2024 12:31:51 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6EA14EC41;
	Tue,  9 Jul 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528310; cv=none; b=htdwxSltQJswCS7ImDxeS4F4w9lySqRlFC6uqMOXb6CFx3qnCyOEJYo/Fh7soqFFqJIwJjSb/ZVOUGwynvcZq7ndt3LD8haCUKF9IQTzKpRQ3DSx9UVg5XUI17XgsOhbnMvqPYe8LsyoWOQxDCi+Pk+HF8Bd6J+ZyyqVHd+d6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528310; c=relaxed/simple;
	bh=DlzPkirboh4VclwZWaIpOoQYphFDi38NOQeBo0jwcis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kbUtakY4TZSY65hpmDhgLRRo6XPgNaBE/BOpcldyc1dqftyI/SWlTcp6mzcVmx8TXJV5lI5F+R788eOJM0H3SbUDfBYp0kv7llqgILV3KvdIn33tOb/q9a+ruoWLKKqSfyW7RUTfjh6S0Pn1NaiUS4UiZFKS+ktdMFEDlyshE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sRA0V-00074P-AQ; Tue, 09 Jul 2024 14:31:43 +0200
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
Subject: [PATCH 5/6] arm64: dts: rockchip: use clock-generator for pcie-refclk on rk3588-tiger
Date: Tue,  9 Jul 2024 14:31:20 +0200
Message-Id: <20240709123121.1452394-6-heiko@sntech.de>
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

Using a combination of fixed clock and gpio-gate clock works but does
not describe the actual hardware. Use the new clock-generator binding
to describe this in a nicer way.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index f870f84da1e6d..4c5be356fa7fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -49,19 +49,14 @@ led-1 {
 	 * 100MHz reference clock for PCIe peripherals from PI6C557-05BLE
 	 * clock generator.
 	 * The clock output is gated via the OE pin on the clock generator.
-	 * This is modeled as a fixed-clock plus a gpio-gate-clock.
 	 */
-	pcie_refclk_gen: pcie-refclk-gen-clock {
-		compatible = "fixed-clock";
+	pcie_refclk: pcie-clock-generator {
+		compatible = "diodes,pi6c557-05b", "clock-generator";
 		#clock-cells = <0>;
 		clock-frequency = <100000000>;
-	};
-
-	pcie_refclk: pcie-refclk-clock {
-		compatible = "gpio-gate-clock";
-		clocks = <&pcie_refclk_gen>;
-		#clock-cells = <0>;
+		clock-output-names = "pcie3_refclk";
 		enable-gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>; /* PCIE30X4_CLKREQN_M1_L */
+		vdd-supply = <&vcca_3v3_s0>;
 	};
 
 	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
-- 
2.39.2


