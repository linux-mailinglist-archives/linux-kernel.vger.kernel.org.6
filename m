Return-Path: <linux-kernel+bounces-576910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 809CFA715E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292328400E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040BC1DDA0F;
	Wed, 26 Mar 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JEusnVnx"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0E19CC3E;
	Wed, 26 Mar 2025 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988986; cv=none; b=e0/BDNb642THI9R7C7rt4/qIRKj9GujcYC9VChFiTRJ+OMBPAHYXPdoxfADYph4rhliZwhlrdDXjGHwUiFdQ0MI++8x/O5f4wk717VD0pRiqrg4vCrOisevhxaXLr89ZKrFoAFqQzMxEp+ey4khmd3sPzIdCAbvI74//UZc9hU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988986; c=relaxed/simple;
	bh=i+1SA1AXJQX4Q9Crpe7MCE2kgK7BHEod+Flw4MdzIdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSl8isl2xi3qqQK5GfPeZ9zJIZMCpnwH1rNfSf3BveyjW6qvnBraivobmSLitJ7mjEHH63KDtE+j9/MSV1koz+phxuTzWLqFElVftJAmY7hPnlWryfcjbQ2o/lwSmhuLuYMcRtXAFlZYKRzd2k9Vg/nAtKn9TP+mVAPSgKQKkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JEusnVnx; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 71A1525D79;
	Wed, 26 Mar 2025 12:36:15 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L35YDY5GWVHS; Wed, 26 Mar 2025 12:36:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1742988974; bh=i+1SA1AXJQX4Q9Crpe7MCE2kgK7BHEod+Flw4MdzIdE=;
	h=From:To:Cc:Subject:Date;
	b=JEusnVnxCcLq5kc8e3+v66/68lTz7j7OUh6mkbl8CT8T6tvtQr6jw62C5VsbJJMMd
	 I/9VWOZurlvmrOOz89NfCPM0m9w0/wjtP82BQEmIhmj2QanHt5Dsmrrrhkepagpot7
	 /n65OZMjdQTl5zs1iigHL9VbA4kN4ArY4Dg5BcuQyKOoXaBMS6qMf57MA10GnpjY4S
	 e5PnPIwdRNE7UMT0lAmKQ0JoQYpIvVvdJalwgHFF54CrfM4y8XERNLfkQuDCJoqyfP
	 WYYfXvHrDFOR+K5pXM27DwyDTTKlzypWZs52SPIDMHYnaadwHO6yWlIs0Q0Ee6e6Ot
	 qZw7plq3SOHhQ==
From: Yao Zi <ziyao@disroot.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] clk: rockchip: Drop empty init callback for rk3588 PLL type
Date: Wed, 26 Mar 2025 11:35:56 +0000
Message-ID: <20250326113556.21039-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike PLLs in previous geneation of SoCs, PLLs in RK3588 type don't
require any platform-specific initialization. Drop callback
rockchip_rk3588_pll_init() that does nothing in fact to clean the
driver up.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/rockchip/clk-pll.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index fe76756e592e..a2a57d47bbf8 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -1025,16 +1025,6 @@ static int rockchip_rk3588_pll_is_enabled(struct clk_hw *hw)
 	return !(pllcon & RK3588_PLLCON1_PWRDOWN);
 }
 
-static int rockchip_rk3588_pll_init(struct clk_hw *hw)
-{
-	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
-
-	if (!(pll->flags & ROCKCHIP_PLL_SYNC_RATE))
-		return 0;
-
-	return 0;
-}
-
 static const struct clk_ops rockchip_rk3588_pll_clk_norate_ops = {
 	.recalc_rate = rockchip_rk3588_pll_recalc_rate,
 	.enable = rockchip_rk3588_pll_enable,
@@ -1049,7 +1039,6 @@ static const struct clk_ops rockchip_rk3588_pll_clk_ops = {
 	.enable = rockchip_rk3588_pll_enable,
 	.disable = rockchip_rk3588_pll_disable,
 	.is_enabled = rockchip_rk3588_pll_is_enabled,
-	.init = rockchip_rk3588_pll_init,
 };
 
 /*
-- 
2.49.0


