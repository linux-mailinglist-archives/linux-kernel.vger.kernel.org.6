Return-Path: <linux-kernel+bounces-375858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF14D9A9BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A81C1F22B78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889FB15E5D3;
	Tue, 22 Oct 2024 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoC6vo5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F01547E7;
	Tue, 22 Oct 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584370; cv=none; b=XAd8akWzDI4Birr0ibcn1lVLGu6S222VQ06H1kIXodNQyNM5nWtwL8n5nRszUWnzGll9ACbY9IhcrxHWC7w6oOnaiXYFGKbb3JiGevD9hBpHcGy8Y/eRELvUzgSOn5W+fFvb+5zAxfBmUULs0UIbTmB6eaf4UDbhh2jsu6x4JNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584370; c=relaxed/simple;
	bh=IfJFuVqikpbJ3wM0OEgkC5Z/WRcc5ZBKy2dIIWAgvRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAw44R3sFJD1PT5mKUlBiczni6sA7e40x+Y5L2m9viPuScD5pKKsZCrk1qgZiodvl2tLRNsOa6T2ObZ2v3OSqEZOeuTAo1tir3E+irAW8Mdk5gnnTZ8Of0TCa01vZUvQ2qrNI445IDwyeSeDI+DQxT30Ti0OrVfK0zPND01lPD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoC6vo5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66289C4CEE3;
	Tue, 22 Oct 2024 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729584369;
	bh=IfJFuVqikpbJ3wM0OEgkC5Z/WRcc5ZBKy2dIIWAgvRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WoC6vo5hhYI8q7DARO9M4jmxc8tskBPBM5GVA41k7rBMDCuVjRXLBi4F/4WqvX6iN
	 J9ZETFkKFpes2dmKcOt9BvMBwhCeXPbM3Z1csg48TgkdOr61lNmvIZ20pl+YK88Hic
	 hYKzxpoB/Fm8ie3mCE7KH124rGhtuxIWXE5LdSU3ekWH1pp8qiJAdSR6Hg+H/wKj45
	 lvoff9hygsaAEgP4L8J1CGFeuCk+fSEyRWc1DZ3l7QP88LwLogHHi5UhH/iY8vaqDA
	 5HZVqSkPwh3gVQEqcpkOFQMQKOUigEBssHPk52TOfyR6gJ/qbtsbJ0YHO2jkookjdj
	 5xO25SXpxq5qQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1t39uG-0000000006x-14Z4;
	Tue, 22 Oct 2024 10:06:20 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
	Vivek Aknurwar <quic_viveka@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>,
	Jeevan Shriram <quic_jshriram@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] clk: qcom: clk-alpha-pll: drop lucid-evo pll enabled warning
Date: Tue, 22 Oct 2024 10:05:20 +0200
Message-ID: <20241022080521.359-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022080521.359-1-johan+linaro@kernel.org>
References: <20241022080521.359-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The boot firmware may have left the display enabled and its PLL running,
which currently generates a warning on boot (e.g. on x1e80100):

	disp_cc_pll0 PLL is already enabled

Drop the bogus warning and fix up the PLL enabled error handling
(trion_pll_is_enabled() only returns 0 or 1).

Fixes: d1b121d62b7e ("clk: qcom: Add LUCID_EVO PLL type for SDX65")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index f9105443d7db..99d6962d25bb 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2318,13 +2318,8 @@ static int alpha_pll_lucid_evo_enable(struct clk_hw *hw)
 	}
 
 	/* Check if PLL is already enabled */
-	ret = trion_pll_is_enabled(pll, regmap);
-	if (ret < 0) {
-		return ret;
-	} else if (ret) {
-		pr_warn("%s PLL is already enabled\n", clk_hw_get_name(&pll->clkr.hw));
+	if (trion_pll_is_enabled(pll, regmap))
 		return 0;
-	}
 
 	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
 	if (ret)
-- 
2.45.2


