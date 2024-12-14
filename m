Return-Path: <linux-kernel+bounces-446226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C14259F2157
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF082165FE4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6971B4135;
	Sat, 14 Dec 2024 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0XE8byCm"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546B374FF;
	Sat, 14 Dec 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734216518; cv=none; b=nv1uwGuYWjxWmyssjxDddarnMb9Sm5dJost5j8OMEZlinSkjvdcEv3DAtGnJWaePVfeV8GG+sdjBMhweUq3wgl6wmbEuCWbXstimzzUy9zirjndUYonApBgh7xSmH2KWJ2RRgtZK9i4jeh8AJspBc8M2235w4uh5JW/piqaA0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734216518; c=relaxed/simple;
	bh=cnWMBdJhjRflNaOJVBSpemvy1cg2o3A54r2tYAo/T8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/eGWDAyxxBpPoXG/od3n+EVksYslooJn4al18AwIjzXkQnEqcf4y0LLEuxd37qmMu4GtqSoBlGhAbuNVKkx/pImSCq6j48BF+JkcN1OgO+yy9V6tTECBLSXfcZns+OAUkX1U1U5nrDXZMd71vuKum0yvyX36xJ/GzSLZz0KQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0XE8byCm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w/mwqlldhdUNZw8mhvNpRd4TsYnOabctYvvTfesFo7E=; b=0XE8byCmo+jmC1INaQjAPTlrus
	pPgB1W+DtrHXZxckAdQ8tpoNGo63j6EWf5xQYwEE2TzLhZS/5d4tkvPOVm8LlywyT//jfGfw/HXaW
	T6yDc68rzv5Meia8jIcZREvC4R2K+Lrk1FMeYDMCJGZgCMEAoDmIsbjUS43Elf6h6NRzIkkBXAvoJ
	avrIKxVO7Luc6zYYSFENDqDRaG0SFx0GuIJvNBGaosdmVFCVH14K1i1RaPSVwU/JhR67ddXf+MK7s
	yw+xv1oA7FtwI62+Z+jmu9uDogCzzpyBqL+ezXeiqDvn4LC6gYGhEbItOLeCwjP6G2J090ckNAq75
	TrOJStGw==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tMavv-0000P4-Tk; Sat, 14 Dec 2024 23:48:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-clk@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] clk: rockchip: rk3588: make refclko25m_ethX critical
Date: Sat, 14 Dec 2024 23:48:19 +0100
Message-ID: <20241214224820.200665-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Ethernet phys normally need a 25MHz refclk input. On a lot of boards
this is done with a dedicated 25MHz crystal. But the rk3588 CRU also
provides a means for that via the refclko25m_ethX clock outputs that
can be used for that function.

The mdio bus normally probes devices on the bus at runtime, by reading
specific phy registers. This requires the phy to be running and thus
also being supplied by its reference clock.

While there exist the possibility and dt-binding to declare these
input clocks for each phy in the phy-dt-node, this is only relevant
_after_ the phy has been detected and during the drivers probe-run.

This results in a chicken-and-egg-problem. The refclks in the CRU are
running on boot of course, but phy-probing can very well happen after
clk_disable_unused has run.

In the past I tried to make clock-handling part of the mdio bus code [0]
but that wasn't very well received, due to it being specific to OF and
clocks with the consensus being that resources needed for detection
need to be enabled before.

So to make probing ethernet phys using the internal refclks possible,
make those 2 clocks critical.

[0] https://lore.kernel.org/netdev/13590315.F0gNSz5aLb@diego/T/

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/clk/rockchip/clk-rk3588.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk-rk3588.c
index 0ffaf639f807..2f63985a6d07 100644
--- a/drivers/clk/rockchip/clk-rk3588.c
+++ b/drivers/clk/rockchip/clk-rk3588.c
@@ -792,10 +792,10 @@ static struct rockchip_clk_branch rk3588_clk_branches[] __initdata = {
 	COMPOSITE(MCLK_GMAC0_OUT, "mclk_gmac0_out", gpll_cpll_p, 0,
 			RK3588_CLKSEL_CON(15), 7, 1, MFLAGS, 0, 7, DFLAGS,
 			RK3588_CLKGATE_CON(5), 3, GFLAGS),
-	COMPOSITE(REFCLKO25M_ETH0_OUT, "refclko25m_eth0_out", gpll_cpll_p, 0,
+	COMPOSITE(REFCLKO25M_ETH0_OUT, "refclko25m_eth0_out", gpll_cpll_p, CLK_IS_CRITICAL,
 			RK3588_CLKSEL_CON(15), 15, 1, MFLAGS, 8, 7, DFLAGS,
 			RK3588_CLKGATE_CON(5), 4, GFLAGS),
-	COMPOSITE(REFCLKO25M_ETH1_OUT, "refclko25m_eth1_out", gpll_cpll_p, 0,
+	COMPOSITE(REFCLKO25M_ETH1_OUT, "refclko25m_eth1_out", gpll_cpll_p, CLK_IS_CRITICAL,
 			RK3588_CLKSEL_CON(16), 7, 1, MFLAGS, 0, 7, DFLAGS,
 			RK3588_CLKGATE_CON(5), 5, GFLAGS),
 	COMPOSITE(CLK_CIFOUT_OUT, "clk_cifout_out", gpll_cpll_24m_spll_p, 0,
-- 
2.45.2


