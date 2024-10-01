Return-Path: <linux-kernel+bounces-345206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F198B31C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4951F24303
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA171B984F;
	Tue,  1 Oct 2024 04:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eiXw0rh5"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A51B9837;
	Tue,  1 Oct 2024 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727757593; cv=none; b=em9Ir+ZwED/ua5IxigqFVCTwDWJDwaI5InNDx/Uusv1LjTXZrjy3jCxRNsfvwale9s9dvk/PXhsVvI0ynbS/9YMqSAx4Pk2jh3bbTfy2IBveBSbIzXgECje09pBM940kXQ5qZaRASww1YwywC6uHn3QaJ4EzRHCkU8+p0g7Xd2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727757593; c=relaxed/simple;
	bh=0V1Ookeeycp/R5rCacItScFvCKb6+3jLczQxITY6ufc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddQlpL6dpy9qvu76HvEnPFLE+00wWPQKze6EEJyG5RyWKFV/xxVy4/lJJEsL6WZV71u8ZROFJqEbt9TQioJof+Tw2QOmJ/ysw3MBbZApzkWPiTukB8XzPUzUOaSKHtjV5zJz1b+D0FSppjaL6DpCkJCdkLwdp91kC7S9hTM1Y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eiXw0rh5; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8A5ED23CAD;
	Tue,  1 Oct 2024 06:39:50 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W90cDK1kOghZ; Tue,  1 Oct 2024 06:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727757589; bh=0V1Ookeeycp/R5rCacItScFvCKb6+3jLczQxITY6ufc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eiXw0rh5fMrnLqvcXty6qEiTI3w19WxPvQ0wG5vl7/KzU0qCckejE1MxJk890Q2mL
	 qs0JOGececmxZpMYctfKAoEJnS122T02kaKdOjY+qj+kDH3HJvWfRg+Ec6QK6/kcVN
	 d4MhWM1oCxyVklv7qHCMyt+Ejef7Jm12KHZ0E5kPOfpYZznAwIsdKKH7t7dBAaWBg0
	 4PCyI2F9tpmkn3rz+ambGFNCGlIdi45wC6/jFvzRUZCIwsZ3Mq3+tq4neP+s6DQAhI
	 wDfMK+IJc8TkKclVpdivmKrKFFQmnfNTRV7ACt6JoQBk0Ugu3Ls9YdMss5qU2OwpmZ
	 KSUgZfwk/4Rvw==
From: Yao Zi <ziyao@disroot.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 8/8] arm64: dts: rockchip: Add UART clocks for RK3528 SoC
Date: Tue,  1 Oct 2024 04:38:38 +0000
Message-ID: <20241001043838.31963-2-ziyao@disroot.org>
In-Reply-To: <20241001042401.31903-2-ziyao@disroot.org>
References: <20241001042401.31903-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing clocks in UART nodes for RK3528 SoC.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index c0552ff7cd31..9c28e1d0d7ea 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -166,7 +166,8 @@ cru: clock-controller@ff4a0000 {
 		uart0: serial@ff9f0000 {
 			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
 			reg = <0x0 0xff9f0000 0x0 0x100>;
-			clock-frequency = <24000000>;
+			clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -176,6 +177,8 @@ uart0: serial@ff9f0000 {
 		uart1: serial@ff9f8000 {
 			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
 			reg = <0x0 0xff9f8000 0x0 0x100>;
+			clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -185,6 +188,8 @@ uart1: serial@ff9f8000 {
 		uart2: serial@ffa00000 {
 			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
 			reg = <0x0 0xffa00000 0x0 0x100>;
+			clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -193,6 +198,8 @@ uart2: serial@ffa00000 {
 
 		uart3: serial@ffa08000 {
 			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+			clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
+			clock-names = "baudclk", "apb_pclk";
 			reg = <0x0 0xffa08000 0x0 0x100>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -202,6 +209,8 @@ uart3: serial@ffa08000 {
 		uart4: serial@ffa10000 {
 			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
 			reg = <0x0 0xffa10000 0x0 0x100>;
+			clocks = <&cru SCLK_UART4>, <&cru PCLK_UART4>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -211,6 +220,8 @@ uart4: serial@ffa10000 {
 		uart5: serial@ffa18000 {
 			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
 			reg = <0x0 0xffa18000 0x0 0x100>;
+			clocks = <&cru SCLK_UART5>, <&cru PCLK_UART5>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -220,6 +231,8 @@ uart5: serial@ffa18000 {
 		uart6: serial@ffa20000 {
 			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
 			reg = <0x0 0xffa20000 0x0 0x100>;
+			clocks = <&cru SCLK_UART6>, <&cru PCLK_UART6>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -229,6 +242,8 @@ uart6: serial@ffa20000 {
 		uart7: serial@ffa28000 {
 			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
 			reg = <0x0 0xffa28000 0x0 0x100>;
+			clocks = <&cru SCLK_UART7>, <&cru PCLK_UART7>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
-- 
2.46.0


