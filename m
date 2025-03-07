Return-Path: <linux-kernel+bounces-550148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E79A55BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C091D3A5DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABB454F81;
	Fri,  7 Mar 2025 00:26:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAD333997;
	Fri,  7 Mar 2025 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307203; cv=none; b=kOszH9NAnUMFOLaJWx0TpA/5psM2KJcRq174i/ppQkNhEfKnHt+HGa4mpY/S2aq02qWEDUDdUOGAHw6GnrZLMEYgT0Is66tC6KjaCyRv+M+Fy/cEEIdmRTiRkSkYTFB0V5oHWigXoDaETL8/PfCluG9aSWMD+RUC+JyADP/eMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307203; c=relaxed/simple;
	bh=ZxoLrYw+M+Km5MXU+bcA9wC1wVKCdqx3vhs0L7p0do4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsUvYTNxorjwvZrqKzlnbjAFmNhYlH+aNiuBgxeqBQ9SDqPmSWgJTsyF+O5OlHSCf098RbRIPw8H1Ivz+vaIqd5zp6TPRIDjXOMwICPef3gzVzcmsJEA6wHlLyAupv6x80KskTtnInPMNH3MEp1inrnOUulGh7SHrap9S6lZv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37F391BC0;
	Thu,  6 Mar 2025 16:26:54 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B3143F673;
	Thu,  6 Mar 2025 16:26:39 -0800 (PST)
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
Subject: [PATCH v4 03/14] clk: sunxi-ng: Add support for update bit
Date: Fri,  7 Mar 2025 00:26:17 +0000
Message-ID: <20250307002628.10684-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250307002628.10684-1-andre.przywara@arm.com>
References: <20250307002628.10684-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some clocks in the Allwinner A523 SoC contain an "update bit" (bit 27),
which must be set to apply any register changes, namely the mux
selector, the divider and the gate bit.

Add a new CCU feature bit to mark those clocks, and set bit 27 whenever
we are applying any changes.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/clk/sunxi-ng/ccu_common.h | 4 ++++
 drivers/clk/sunxi-ng/ccu_div.c    | 2 ++
 drivers/clk/sunxi-ng/ccu_gate.c   | 4 ++++
 drivers/clk/sunxi-ng/ccu_mux.c    | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index 50fd268329671..bbec283b9d993 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -20,10 +20,14 @@
 #define CCU_FEATURE_KEY_FIELD		BIT(8)
 #define CCU_FEATURE_CLOSEST_RATE	BIT(9)
 #define CCU_FEATURE_DUAL_DIV		BIT(10)
+#define CCU_FEATURE_UPDATE_BIT		BIT(11)
 
 /* MMC timing mode switch bit */
 #define CCU_MMC_NEW_TIMING_MODE		BIT(30)
 
+/* Some clocks need this bit to actually apply register changes */
+#define CCU_SUNXI_UPDATE_BIT		BIT(27)
+
 struct device_node;
 
 struct ccu_common {
diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index 7f4691f09e01f..916d6da6d8a3b 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -106,6 +106,8 @@ static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	reg = readl(cd->common.base + cd->common.reg);
 	reg &= ~GENMASK(cd->div.width + cd->div.shift - 1, cd->div.shift);
+	if (cd->common.features & CCU_FEATURE_UPDATE_BIT)
+		reg |= CCU_SUNXI_UPDATE_BIT;
 
 	writel(reg | (val << cd->div.shift),
 	       cd->common.base + cd->common.reg);
diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu_gate.c
index ac52fd6bff677..474a9e8831f87 100644
--- a/drivers/clk/sunxi-ng/ccu_gate.c
+++ b/drivers/clk/sunxi-ng/ccu_gate.c
@@ -20,6 +20,8 @@ void ccu_gate_helper_disable(struct ccu_common *common, u32 gate)
 	spin_lock_irqsave(common->lock, flags);
 
 	reg = readl(common->base + common->reg);
+	if (common->features & CCU_FEATURE_UPDATE_BIT)
+		reg |= CCU_SUNXI_UPDATE_BIT;
 	writel(reg & ~gate, common->base + common->reg);
 
 	spin_unlock_irqrestore(common->lock, flags);
@@ -44,6 +46,8 @@ int ccu_gate_helper_enable(struct ccu_common *common, u32 gate)
 	spin_lock_irqsave(common->lock, flags);
 
 	reg = readl(common->base + common->reg);
+	if (common->features & CCU_FEATURE_UPDATE_BIT)
+		reg |= CCU_SUNXI_UPDATE_BIT;
 	writel(reg | gate, common->base + common->reg);
 
 	spin_unlock_irqrestore(common->lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index d7ffbdeee9e04..74f9e98a5d355 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -197,6 +197,8 @@ int ccu_mux_helper_set_parent(struct ccu_common *common,
 	/* The key field always reads as zero. */
 	if (common->features & CCU_FEATURE_KEY_FIELD)
 		reg |= CCU_MUX_KEY_VALUE;
+	if (common->features & CCU_FEATURE_UPDATE_BIT)
+		reg |= CCU_SUNXI_UPDATE_BIT;
 
 	reg &= ~GENMASK(cm->width + cm->shift - 1, cm->shift);
 	writel(reg | (index << cm->shift), common->base + common->reg);
-- 
2.46.3


