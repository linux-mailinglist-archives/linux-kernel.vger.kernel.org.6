Return-Path: <linux-kernel+bounces-528610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BACA419B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B3B7A5566
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F924BC12;
	Mon, 24 Feb 2025 09:55:14 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700324A058;
	Mon, 24 Feb 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390914; cv=none; b=cFs1kyt07NtYd6YrgFCm0sRlEaPFE6edOVZYzmlVBsLgqTCVBwiONMDxwmolX6OHxK34XT5X1HezyjldPfV5vFVGIWSJyAu0JDQjp3rzOLr0Tw8vgRoNplWOOvqGDQ8djBwR3gRlchcJoaW73lYBKDlFobTefHAl/ZVRkUrukgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390914; c=relaxed/simple;
	bh=K6BQ6HQLexaptt6xH8aCwUW3W4n9kJGqMVmFNwQfsIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ku6DKdEHigYACw4H6J1CdhgDCmpYWq/Uj4UneCPEA7ZDpYnx0OrK06vsnr3089eODUp1M1bzz+iTOlgn4PkRca4n30UHyJIFFZ/BJBXAhAZUGDPfkxv7bySdc01HpjrpFKwnKEvxToTbPPnpRRq/r92Yoj+5DXK6HHFkj7Evhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 24 Feb
 2025 17:55:07 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 24 Feb 2025 17:55:07 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@aj.id.au>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1 clock define
Date: Mon, 24 Feb 2025 17:55:04 +0800
Message-ID: <20250224095506.2047064-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

-remove redundant SOC0_CLK_UART_DIV13:
SOC0_CLK_UART_DIV13 is not use at clk-ast2700.c, the clock
source tree is uart clk src -> uart_div_table -> uart clk.

-Change SOC0_CLK_HPLL_DIV_AHB to SOC0_CLK_AHBMUX:
modify clock tree implement.
older CLK_AHB use mpll_div_ahb/hpll_div_ahb to be ahb clock source.
mpll->mpll_div_ahb
                  -> clk_ahb
hpll->hpll_div_ahb

new use SOC0_CLK_AHBMUX for more understand clock source divide tree.
mpll->
      ahb_mux -> div_table -> clk_ahb
hpll->

-new add clock:
 SOC0_CLK_MPHYSRC: UFS MPHY clock source.
 SOC0_CLK_U2PHY_REFCLKSRC: USB2.0 phy clock reference source.
 SOC1_CLK_I3C: I3C clock source.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 include/dt-bindings/clock/aspeed,ast2700-scu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/aspeed,ast2700-scu.h b/include/dt-bindings/clock/aspeed,ast2700-scu.h
index 63021af3caf5..c7389530629d 100644
--- a/include/dt-bindings/clock/aspeed,ast2700-scu.h
+++ b/include/dt-bindings/clock/aspeed,ast2700-scu.h
@@ -13,18 +13,17 @@
 #define SCU0_CLK_24M		1
 #define SCU0_CLK_192M		2
 #define SCU0_CLK_UART		3
-#define SCU0_CLK_UART_DIV13	3
 #define SCU0_CLK_PSP		4
 #define SCU0_CLK_HPLL		5
 #define SCU0_CLK_HPLL_DIV2	6
 #define SCU0_CLK_HPLL_DIV4	7
-#define SCU0_CLK_HPLL_DIV_AHB	8
+#define SCU0_CLK_AHBMUX		8
 #define SCU0_CLK_DPLL		9
 #define SCU0_CLK_MPLL		10
 #define SCU0_CLK_MPLL_DIV2	11
 #define SCU0_CLK_MPLL_DIV4	12
 #define SCU0_CLK_MPLL_DIV8	13
-#define SCU0_CLK_MPLL_DIV_AHB	14
+#define SCU0_CLK_MPHYSRC	14
 #define SCU0_CLK_D0		15
 #define SCU0_CLK_D1		16
 #define SCU0_CLK_CRT0		17
@@ -68,6 +67,7 @@
 #define SCU0_CLK_GATE_UFSCLK	53
 #define SCU0_CLK_GATE_EMMCCLK	54
 #define SCU0_CLK_GATE_RVAS1CLK	55
+#define SCU0_CLK_U2PHY_REFCLKSRC 56
 
 /* SOC1 clk */
 #define SCU1_CLKIN		0
@@ -160,4 +160,5 @@
 #define SCU1_CLK_GATE_PORTDUSB2CLK	85
 #define SCU1_CLK_GATE_LTPI1TXCLK	86
 
+#define SCU1_CLK_I3C	87
 #endif
-- 
2.34.1


