Return-Path: <linux-kernel+bounces-403419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64F19C3576
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F78281FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F4AD58;
	Mon, 11 Nov 2024 00:47:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D91EAF9;
	Mon, 11 Nov 2024 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286059; cv=none; b=iKRqwRMwLCjBPJJ6LA3Y3PLWep8iK/UUkqjHvODQd/2gQ3sL1goKQf0Huc2xBUKfjeUrMHqcY0+u0sHzOIz1k+WAwgFilhEIstAfEBdVYg14TZEO3mXA1zrQPrFfJ14HcyC7UQ0txkaFGyMpUPetqQ4tzbdHxMZtREY0G8zbyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286059; c=relaxed/simple;
	bh=dPTZs1X6MbudQQjJSUcFCojh1plgmdGcZJfd6cqjdTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCqzmCZLcJsLWE6rFKbL803oYDH5JzMwRcrBAn+Odr+pdHg3cgUUsDaPD8vL3xhLKysXDCjL3H55ur4v3BcnbS75HOGSlk2rKaIYwBSkTGu5Pb1ymfw6u3xhA855MJVqwf+mbk9DwZF9NU+9TRVK0XwclCuI02eW5umWdxq0lBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE1321CDD;
	Sun, 10 Nov 2024 16:48:06 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00ECF3F66E;
	Sun, 10 Nov 2024 16:47:34 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Icenowy Zheng <uwu@icenowy.me>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] clk: sunxi-ng: mp: introduce dual-divider clock
Date: Mon, 11 Nov 2024 00:47:17 +0000
Message-ID: <20241111004722.10130-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241111004722.10130-1-andre.przywara@arm.com>
References: <20241111004722.10130-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A523 SoC introduces some new MP-style mod clock, where the
second "P" divider is an actual numerical divider value, and not the
numbers of bits to shift (1..32 instead of 1,2,4,8).
The rest of the clock is the same as the existing MP clock, so enhance the
existing code to accommodate for this.

Introduce the new CCU feature bit CCU_FEATURE_DUAL_DIV to mark an MP
clock as having two dividers, and change the dividing and encoding code
to differentiate the two cases.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu_common.h |  1 +
 drivers/clk/sunxi-ng/ccu_mp.c     | 51 +++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index 329734f8cf42b..4bb05207bb5df 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -19,6 +19,7 @@
 #define CCU_FEATURE_SIGMA_DELTA_MOD	BIT(7)
 #define CCU_FEATURE_KEY_FIELD		BIT(8)
 #define CCU_FEATURE_CLOSEST_RATE	BIT(9)
+#define CCU_FEATURE_DUAL_DIV		BIT(10)
 
 /* MMC timing mode switch bit */
 #define CCU_MMC_NEW_TIMING_MODE		BIT(30)
diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index cc94a694cb676..1be4668abef7c 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -10,15 +10,23 @@
 #include "ccu_gate.h"
 #include "ccu_mp.h"
 
+static unsigned int next_div(unsigned int div, bool shift)
+{
+	if (shift)
+		return div << 1;
+	return div + 1;
+}
+
 static unsigned long ccu_mp_find_best(unsigned long parent, unsigned long rate,
 				      unsigned int max_m, unsigned int max_p,
+				      bool shift,
 				      unsigned int *m, unsigned int *p)
 {
 	unsigned long best_rate = 0;
 	unsigned int best_m = 0, best_p = 0;
 	unsigned int _m, _p;
 
-	for (_p = 1; _p <= max_p; _p <<= 1) {
+	for (_p = 1; _p <= max_p; _p = next_div(_p, shift)) {
 		for (_m = 1; _m <= max_m; _m++) {
 			unsigned long tmp_rate = parent / _p / _m;
 
@@ -43,7 +51,8 @@ static unsigned long ccu_mp_find_best_with_parent_adj(struct clk_hw *hw,
 						      unsigned long *parent,
 						      unsigned long rate,
 						      unsigned int max_m,
-						      unsigned int max_p)
+						      unsigned int max_p,
+						      bool shift)
 {
 	unsigned long parent_rate_saved;
 	unsigned long parent_rate, now;
@@ -60,7 +69,7 @@ static unsigned long ccu_mp_find_best_with_parent_adj(struct clk_hw *hw,
 	maxdiv = max_m * max_p;
 	maxdiv = min(ULONG_MAX / rate, maxdiv);
 
-	for (_p = 1; _p <= max_p; _p <<= 1) {
+	for (_p = 1; _p <= max_p; _p = next_div(_p, shift)) {
 		for (_m = 1; _m <= max_m; _m++) {
 			div = _m * _p;
 
@@ -103,18 +112,26 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
 	struct ccu_mp *cmp = data;
 	unsigned int max_m, max_p;
 	unsigned int m, p;
+	bool shift = true;
 
 	if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= cmp->fixed_post_div;
 
+	if (cmp->common.features & CCU_FEATURE_DUAL_DIV)
+		shift = false;
+
 	max_m = cmp->m.max ?: 1 << cmp->m.width;
-	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
+	if (shift)
+		max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
+	else
+		max_p = cmp->p.max ?: 1 << cmp->p.width;
 
 	if (!clk_hw_can_set_rate_parent(&cmp->common.hw)) {
-		rate = ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
+		rate = ccu_mp_find_best(*parent_rate, rate, max_m, max_p, shift,
+					&m, &p);
 	} else {
 		rate = ccu_mp_find_best_with_parent_adj(hw, parent_rate, rate,
-							max_m, max_p);
+							max_m, max_p, shift);
 	}
 
 	if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
@@ -167,7 +184,11 @@ static unsigned long ccu_mp_recalc_rate(struct clk_hw *hw,
 	p = reg >> cmp->p.shift;
 	p &= (1 << cmp->p.width) - 1;
 
-	rate = (parent_rate >> p) / m;
+	if (cmp->common.features & CCU_FEATURE_DUAL_DIV)
+		rate = (parent_rate / p) / m;
+	else
+		rate = (parent_rate >> p) / m;
+
 	if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= cmp->fixed_post_div;
 
@@ -190,20 +211,27 @@ static int ccu_mp_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags;
 	unsigned int max_m, max_p;
 	unsigned int m, p;
+	bool shift = true;
 	u32 reg;
 
+	if (cmp->common.features & CCU_FEATURE_DUAL_DIV)
+		shift = false;
+
 	/* Adjust parent_rate according to pre-dividers */
 	parent_rate = ccu_mux_helper_apply_prediv(&cmp->common, &cmp->mux, -1,
 						  parent_rate);
 
 	max_m = cmp->m.max ?: 1 << cmp->m.width;
-	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
+	if (shift)
+		max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
+	else
+		max_p = cmp->p.max ?: 1 << cmp->p.width;
 
 	/* Adjust target rate according to post-dividers */
 	if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate = rate * cmp->fixed_post_div;
 
-	ccu_mp_find_best(parent_rate, rate, max_m, max_p, &m, &p);
+	ccu_mp_find_best(parent_rate, rate, max_m, max_p, shift, &m, &p);
 
 	spin_lock_irqsave(cmp->common.lock, flags);
 
@@ -211,7 +239,10 @@ static int ccu_mp_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg &= ~GENMASK(cmp->m.width + cmp->m.shift - 1, cmp->m.shift);
 	reg &= ~GENMASK(cmp->p.width + cmp->p.shift - 1, cmp->p.shift);
 	reg |= (m - cmp->m.offset) << cmp->m.shift;
-	reg |= ilog2(p) << cmp->p.shift;
+	if (shift)
+		reg |= ilog2(p) << cmp->p.shift;
+	else
+		reg |= (p - cmp->p.offset) << cmp->p.shift;
 
 	writel(reg, cmp->common.base + cmp->common.reg);
 
-- 
2.46.2


