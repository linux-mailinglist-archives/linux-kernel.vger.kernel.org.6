Return-Path: <linux-kernel+bounces-318178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360B96E983
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36916286604
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C123D13B783;
	Fri,  6 Sep 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li+xwak6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6B1304BF;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601957; cv=none; b=IGpa74cZDZ2/yTQchTPmPoJNUD3OgPN0g5x5MlLmktTq/V32Io0E3fgWuegV+Qs3OAu03EKBUoduvhQJdar9NpOu0kAUGHVwtGwA3uK+ETdz3eqVPHlMiELutFxBDMj9H21+VEZ5nSYYiOKuvVbBBpgMtl8pSJPdmMojjOvwH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601957; c=relaxed/simple;
	bh=I9JprPGgr2Q1JvjMeHkxOvLVu+H/5UNCtWt/M48Ns14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ojxctj/d2H15xpOjqXh5o2sYCtyNlaZSsF3qJWaF+RzbVkR7zCq5SMVNfNqAHJwHjdNS5eBSnyI1Brgr4rE4QHGS7iqDvXBzDIQklZ+VpkPh3G/ywfTHrA+1nmGuOkgjDX9z9v2ho1F6LesYXB6utLgrAUgJ63dgjYRbl/hpS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li+xwak6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1FAFC4CEC8;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725601956;
	bh=I9JprPGgr2Q1JvjMeHkxOvLVu+H/5UNCtWt/M48Ns14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Li+xwak6lwSBbAuxqsHiQ70CrZ4YDmU8reJOfqLZE2sDhVY22EzngQQ76gWGEYPwy
	 FR1cP+SB+1+HZWggmz9cIG3X78F4ZPjTIayCiJBPhtNVpw71m/5Ub2/zdw+hucl412
	 K3v12+KuOYxjdhDPYTXuFr017hkMQUSIqUlR5L4xQKMGV/yxaGisM2QKyQH1LLpQDy
	 nlIcPvGmrQcDgKHp+rNJq+X9ZPEPXqqbyQmoCQR45RbKxSLmJxqEX9x2e5r7iHukpX
	 N9l5t7DGkSlDZy/w1GEGVp7rBQWvm33/Uz7Qri9f7zk5cyNTsVsRX/tf3qSWw6c2X0
	 X8FCl7YgsFrTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD64CD5BDD;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 06 Sep 2024 13:52:33 +0800
Subject: [PATCH 1/4] clk: meson: Support PLL with fixed fractional
 denominators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-fix_clk-v1-1-2977ef0d72e7@amlogic.com>
References: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
In-Reply-To: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725601955; l=2567;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=SoIKZiELa8FSJI7fmIZsiz6qIoB6+tJ8z3x3hDJR/OM=;
 b=HYGdsd4TDjl5DW9tu+regMVhcuVnmoqEWuyRRdEK8IXmAPDX+KAM5EnWN+mXPd6AJqh1qj1XV
 DlfZzdykYAXDTgKqia5Qg17K3yaT8fizM93sTUuRayorsD/5VsvJQC+
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Some PLLs with fractional multipliers have fractional denominators that
are fixed to "100000" instead of the previous "(1 << pll->frac.width)".

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 22 +++++++++++++++++++---
 drivers/clk/meson/clk-pll.h |  1 +
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index bc570a2ff3a3..f0009c174564 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -36,6 +36,12 @@
 #include "clk-regmap.h"
 #include "clk-pll.h"
 
+/*
+ * Some PLLs with fractional multipliers have fractional denominators that
+ * are fixed to "100000" instead of the previous "(1 << pll->frac.width)".
+ */
+#define FIXED_FRAC_MAX			100000
+
 static inline struct meson_clk_pll_data *
 meson_clk_pll_data(struct clk_regmap *clk)
 {
@@ -57,12 +63,17 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
 					  struct meson_clk_pll_data *pll)
 {
 	u64 rate = (u64)parent_rate * m;
+	unsigned int frac_max;
 
 	if (frac && MESON_PARM_APPLICABLE(&pll->frac)) {
 		u64 frac_rate = (u64)parent_rate * frac;
 
-		rate += DIV_ROUND_UP_ULL(frac_rate,
-					 (1 << pll->frac.width));
+		if (pll->flags & CLK_MESON_PLL_FIXED_FRAC_MAX)
+			frac_max = FIXED_FRAC_MAX;
+		else
+			frac_max = (1 << pll->frac.width);
+
+		rate += DIV_ROUND_UP_ULL(frac_rate, frac_max);
 	}
 
 	return DIV_ROUND_UP_ULL(rate, n);
@@ -100,13 +111,18 @@ static unsigned int __pll_params_with_frac(unsigned long rate,
 					   unsigned int n,
 					   struct meson_clk_pll_data *pll)
 {
-	unsigned int frac_max = (1 << pll->frac.width);
+	unsigned int frac_max;
 	u64 val = (u64)rate * n;
 
 	/* Bail out if we are already over the requested rate */
 	if (rate < parent_rate * m / n)
 		return 0;
 
+	if (pll->flags & CLK_MESON_PLL_FIXED_FRAC_MAX)
+		frac_max = FIXED_FRAC_MAX;
+	else
+		frac_max = (1 << pll->frac.width);
+
 	if (pll->flags & CLK_MESON_PLL_ROUND_CLOSEST)
 		val = DIV_ROUND_CLOSEST_ULL(val * frac_max, parent_rate);
 	else
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 7b6b87274073..e996d3727eb1 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -29,6 +29,7 @@ struct pll_mult_range {
 
 #define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
 #define CLK_MESON_PLL_NOINIT_ENABLED	BIT(1)
+#define CLK_MESON_PLL_FIXED_FRAC_MAX	BIT(2)
 
 struct meson_clk_pll_data {
 	struct parm en;

-- 
2.42.0



