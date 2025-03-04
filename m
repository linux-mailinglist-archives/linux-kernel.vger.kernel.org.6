Return-Path: <linux-kernel+bounces-543039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154DEA4D0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E2A3AD578
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9414901B;
	Tue,  4 Mar 2025 01:30:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079D1754B;
	Tue,  4 Mar 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051838; cv=none; b=LlXnq/KqoUB/nrXFT2hQ3S5KbIKgILmZcXASvYIPmOWP63f16wcLJYanT3nRuLMwsDRNyYEtufDbCEpXC58bMtEbpKdWoDB5laHpSVsPMtVJa0yIW6SHZ6ZFTeEnOVqXuaslZwV10u2Zdt0rA3EBp3aK6DZNhIXDy3JCrP0LXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051838; c=relaxed/simple;
	bh=gjvQVDmknlC8nq//NDlr46aMC3U84nzCKHABrxLhUHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrYZGtOqZ63gThYqJ2iZ3wkBC9HmocwfbsDs2Ad6ZYWC+TgPq32Vn1yh1AuN/8tA0rlq1HjYGYKwd8a8/CcY8S5ByuTooLrfr3wgKFU8BRfoEZBtIwLw5iWwb1+uNeyXaqLiDEev0fNtO0qzZiMPTwzkuNavqwCBuI291eFOYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63CBA1063;
	Mon,  3 Mar 2025 17:30:49 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A34B63F673;
	Mon,  3 Mar 2025 17:30:33 -0800 (PST)
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
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/15] clk: sunxi-ng: mp: introduce dual-divider clock
Date: Tue,  4 Mar 2025 01:27:51 +0000
Message-ID: <20250304012805.28594-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250304012805.28594-1-andre.przywara@arm.com>
References: <20250304012805.28594-1-andre.przywara@arm.com>
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
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_common.h |  1 +
 drivers/clk/sunxi-ng/ccu_mp.c     | 51 +++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index dd330426a6e5f..50fd268329671 100644
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
index 2bb8987ddcc20..354c981943b6f 100644
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
2.46.3


