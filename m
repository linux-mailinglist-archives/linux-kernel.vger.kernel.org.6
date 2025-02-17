Return-Path: <linux-kernel+bounces-517041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660AFA37B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C7716C9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EFA193425;
	Mon, 17 Feb 2025 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BfG3D5WK"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAA4191F62;
	Mon, 17 Feb 2025 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739772799; cv=none; b=J8AuCn2GxKZ9RycFBZ32wYvvm+9lVvTo7/qhTWd/20066DnDQuKqxcIJVlu3hLoAt/DJODUr6/S6ZCEfDYdFJ41B7KDNTKT3n+uEpTpTrFClNloImni91GSxbB/W8vTrNckx33h/WOufmkCRZZ8xiw2EiXD4DFM1suWSAbYVVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739772799; c=relaxed/simple;
	bh=58xzbLCdhNCilxabqnQbn6q6tobvOe7G9WeMgslUdXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVpSbEXvZmd4Y8Br3vOvS5T7JK4jUBhDTVW+BTEzGFaRfFB8h4umwYeKeNWAnQ4vmVCBNLqoE/FPRp9fz3FVm87vaOXc2DvIqWqqg12pzT1ij7Jg3D+20g9ncpgKS2ANnxzkULeHHywB77VBjvZ12mS9QHRvFwBbu9Q6kTLcWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BfG3D5WK; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1482625B74;
	Mon, 17 Feb 2025 07:13:15 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3J08wnY5d9p; Mon, 17 Feb 2025 07:13:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1739772794; bh=58xzbLCdhNCilxabqnQbn6q6tobvOe7G9WeMgslUdXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BfG3D5WKvdopBWufa82rVui6rj7ZIjL2eUJDRKkmBYPFAc/wgD7+TLBOUQom9Jcaf
	 2hXqZbX2n5qNh1UOhZkl163Uj8vxa/NDDYOl2jJA7maBA57IVZCne6YNs8oFhrvrQn
	 GE3jLCHEJcTpio82h5H4J78npXOKXIPKq7dH4o25ARDjkNw1s2XI15rphcskVeib+/
	 IrCDVzUQF0JzOkupWHAkJ1hQTC7yDiiilCNSYWF+Q+7mynmDN+Cj4nebUNULAi/nRl
	 8d1IbOSJfCi8KKEGbVfzc1Vc/Me8QnjdMzt8F4jQsBRe7HBTyXdTEVc/v337gr8XTR
	 iKCs9SEM4ecZQ==
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
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3 2/5] clk: rockchip: Add PLL flag ROCKCHIP_PLL_FIXED_MODE
Date: Mon, 17 Feb 2025 06:11:43 +0000
Message-ID: <20250217061142.38480-7-ziyao@disroot.org>
In-Reply-To: <20250217061142.38480-5-ziyao@disroot.org>
References: <20250217061142.38480-5-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3528 comes with a new PLL variant: its "PPLL", which mainly generates
clocks for the PCIe controller, operates in normal mode only. Let's
describe it with flag ROCKCHIP_PLL_FIXED_MODE and handle it in code.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/rockchip/clk-pll.c | 10 ++++++----
 drivers/clk/rockchip/clk.h     |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index fe76756e592e..2c2abb3b4210 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -204,10 +204,12 @@ static int rockchip_rk3036_pll_set_params(struct rockchip_clk_pll *pll,
 	rockchip_rk3036_pll_get_params(pll, &cur);
 	cur.rate = 0;
 
-	cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
-	if (cur_parent == PLL_MODE_NORM) {
-		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
-		rate_change_remuxed = 1;
+	if (!(pll->flags & ROCKCHIP_PLL_FIXED_MODE)) {
+		cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
+		if (cur_parent == PLL_MODE_NORM) {
+			pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
+			rate_change_remuxed = 1;
+		}
 	}
 
 	/* update pll values */
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 9b37d44b9e5d..460de5a67faf 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -444,6 +444,7 @@ struct rockchip_pll_rate_table {
  * Flags:
  * ROCKCHIP_PLL_SYNC_RATE - check rate parameters to match against the
  *	rate_table parameters and ajust them if necessary.
+ * ROCKCHIP_PLL_FIXED_MODE - the pll operates in normal mode only
  */
 struct rockchip_pll_clock {
 	unsigned int		id;
@@ -461,6 +462,7 @@ struct rockchip_pll_clock {
 };
 
 #define ROCKCHIP_PLL_SYNC_RATE		BIT(0)
+#define ROCKCHIP_PLL_FIXED_MODE		BIT(1)
 
 #define PLL(_type, _id, _name, _pnames, _flags, _con, _mode, _mshift,	\
 		_lshift, _pflags, _rtable)				\
-- 
2.48.1


