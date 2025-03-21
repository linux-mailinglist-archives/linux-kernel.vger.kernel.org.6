Return-Path: <linux-kernel+bounces-571732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECCDA6C159
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5195174F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151922F160;
	Fri, 21 Mar 2025 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srwlV6+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421422DF8B;
	Fri, 21 Mar 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577823; cv=none; b=Wy79WZ7V2wYnEW4MKFhormcAEaJ6hwL4tHIBYTPSAPUQSiB8MN+bfofjCQvPHS9CYEzcTT4G7j9rlsDEmYX+aBYtU1u7qZVg3xbvbJ3HXjqlp27PMJQJz1YU6iR6HsSHR/MdBeQDGUM3vWZuMsYOTZokc1tms2uOyM+rvHHMHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577823; c=relaxed/simple;
	bh=aB34ByX9mpTgTIlR+cCfgK1543xO+JC1F3K//rNwxXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUGGcRpm8rif4lHoQg0vd3FaAPMUJ31RT9oazmFQdVyEFXkJDY7Jf8bX4RaUW1Neh0AD7IXeNtZlOuSBR9/08zk6Y5tcwzhY9IL/Xrt/v3mWdd8HRjIFIvaqudm3J+Gxc/kioLG2L9fpejkOWkI/5JYFaoTzljAdI9zMm106wls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srwlV6+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E60BC4CEE3;
	Fri, 21 Mar 2025 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577821;
	bh=aB34ByX9mpTgTIlR+cCfgK1543xO+JC1F3K//rNwxXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srwlV6+ypBgs+uY585agWaS6KpnkPd12sSwaUxkjfrz8B4clWO14I4/bhNxodnKQ+
	 sngZgYUCeF7jcuFGHqdrAI2gzSPJ4+yE1S1TlYf8wYRc290cFO2ni4S9Ng2UdzrZge
	 1x85la40sbaeryERil9BVXvSV78wpIwmrvP5KmqaXmnsE9pEYID5S9Q8G73XqxEp5S
	 yI+EeSAa8BmtyFK4+pSa8LpKnqB0i+/YYjpjRWw1qiTlTfMI/t7X+aVnY/TSq0mtFb
	 phXYuEv6hmJF4lWaWnfiPLMcjpOULY7n9E2I8qJmNeZs7DnaO1J0ayuG/EkbgzGnUG
	 GbKvmExZTT66A==
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 8/9] clk: divider, gate: create regmap-backed copies of gate and divider clocks
Date: Fri, 21 Mar 2025 17:22:41 +0000
Message-ID: <20250321-dandelion-canola-c10f5934434b@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23227; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=SCIDhTNPhozb9oBMIMNc8Q2Cnxi+hnFffsPWb9nTuRs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl3F0R1rNcynhvnzsAsZpnn/WhhzLJ3LbM5I+/tc46q2 9LmPdu6o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABMJMWT4K/L8fmJ6+YwpXuxX DoWUHGQ9n7nx56PS3A3lh59d7njfOJORYfE9yW3+759NOPRC9aRrzcogjhN8T++ueDv/kUu2Sve UE7wA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Implement regmap-backed copies of gate and divider clocks by replacing
the iomem pointer to the clock registers with a regmap and offset
within.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/Kconfig              |   8 +
 drivers/clk/Makefile             |   2 +
 drivers/clk/clk-divider-regmap.c | 270 +++++++++++++++++++++++++++++++
 drivers/clk/clk-gate-regmap.c    | 253 +++++++++++++++++++++++++++++
 drivers/clk/clk-gate.c           |   5 +-
 include/linux/clk-provider.h     | 120 ++++++++++++++
 6 files changed, 656 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/clk-divider-regmap.c
 create mode 100644 drivers/clk/clk-gate-regmap.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 713573b6c86c..c700b6ef4f34 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -33,6 +33,14 @@ menuconfig COMMON_CLK
 
 if COMMON_CLK
 
+config COMMON_CLK_DIVIDER_REGMAP
+	bool
+	select REGMAP
+
+config COMMON_CLK_GATE_REGMAP
+	bool
+	select REGMAP
+
 config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index bf4bd45adc3a..c57f72af5db9 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -20,11 +20,13 @@ clk-test-y			:= clk_test.o \
 				   kunit_clk_assigned_rates_zero_consumer.dtbo.o \
 				   kunit_clk_parent_data_test.dtbo.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-divider.o
+obj-$(CONFIG_COMMON_CLK_DIVIDER_REGMAP)	+= clk-divider-regmap.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
 obj-$(CONFIG_CLK_FIXED_RATE_KUNIT_TEST)	+= clk-fixed-rate-test.o
 clk-fixed-rate-test-y		:= clk-fixed-rate_test.o kunit_clk_fixed_rate_test.dtbo.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
+obj-$(CONFIG_COMMON_CLK_GATE_REGMAP)	+= clk-gate-regmap.o
 obj-$(CONFIG_CLK_GATE_KUNIT_TEST) += clk-gate_test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-multiplier.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
diff --git a/drivers/clk/clk-divider-regmap.c b/drivers/clk/clk-divider-regmap.c
new file mode 100644
index 000000000000..2906130a2b47
--- /dev/null
+++ b/drivers/clk/clk-divider-regmap.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+
+static inline u32 clk_div_regmap_readl(struct clk_divider_regmap *divider)
+{
+	u32 val;
+
+	regmap_read(divider->regmap, divider->map_offset, &val);
+
+	return val;
+}
+
+static inline void clk_div_regmap_writel(struct clk_divider_regmap *divider, u32 val)
+{
+	regmap_write(divider->regmap, divider->map_offset, val);
+
+}
+
+static unsigned long clk_divider_regmap_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_divider_regmap *divider = to_clk_divider_regmap(hw);
+	unsigned int val;
+
+	val = clk_div_regmap_readl(divider) >> divider->shift;
+	val &= clk_div_mask(divider->width);
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->flags, divider->width);
+}
+
+static long clk_divider_regmap_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct clk_divider_regmap *divider = to_clk_divider_regmap(hw);
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		u32 val;
+
+		val = clk_div_regmap_readl(divider) >> divider->shift;
+		val &= clk_div_mask(divider->width);
+
+		return divider_ro_round_rate(hw, rate, prate, divider->table,
+					     divider->width, divider->flags,
+					     val);
+	}
+
+	return divider_round_rate(hw, rate, prate, divider->table,
+				  divider->width, divider->flags);
+}
+
+static int clk_divider_regmap_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct clk_divider_regmap *divider = to_clk_divider_regmap(hw);
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		u32 val;
+
+		val = clk_div_regmap_readl(divider) >> divider->shift;
+		val &= clk_div_mask(divider->width);
+
+		return divider_ro_determine_rate(hw, req, divider->table,
+						 divider->width,
+						 divider->flags, val);
+	}
+
+	return divider_determine_rate(hw, req, divider->table, divider->width,
+				      divider->flags);
+}
+
+static int clk_divider_regmap_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_divider_regmap *divider = to_clk_divider_regmap(hw);
+	int value;
+	unsigned long flags = 0;
+	u32 val;
+
+	value = divider_get_val(rate, parent_rate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
+		val = clk_div_mask(divider->width) << (divider->shift + 16);
+	} else {
+		val = clk_div_regmap_readl(divider);
+		val &= ~(clk_div_mask(divider->width) << divider->shift);
+	}
+	val |= (u32)value << divider->shift;
+	clk_div_regmap_writel(divider, val);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+const struct clk_ops clk_divider_regmap_ops = {
+	.recalc_rate = clk_divider_regmap_recalc_rate,
+	.round_rate = clk_divider_regmap_round_rate,
+	.determine_rate = clk_divider_regmap_determine_rate,
+	.set_rate = clk_divider_regmap_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_divider_regmap_ops);
+
+const struct clk_ops clk_divider_regmap_ro_ops = {
+	.recalc_rate = clk_divider_regmap_recalc_rate,
+	.round_rate = clk_divider_regmap_round_rate,
+	.determine_rate = clk_divider_regmap_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_divider_regmap_ro_ops);
+
+struct clk_hw *__clk_hw_register_divider_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		struct regmap *regmap, u8 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock)
+{
+	struct clk_divider_regmap *div;
+	struct clk_hw *hw;
+	struct clk_init_data init = {};
+	int ret;
+
+	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
+		if (width + shift > 16) {
+			pr_warn("divider value exceeds LOWORD field\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	/* allocate the divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
+		init.ops = &clk_divider_regmap_ro_ops;
+	else
+		init.ops = &clk_divider_regmap_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.parent_hws = parent_hw ? &parent_hw : NULL;
+	init.parent_data = parent_data;
+	if (parent_name || parent_hw || parent_data)
+		init.num_parents = 1;
+	else
+		init.num_parents = 0;
+
+	/* struct clk_divider assignments */
+	div->regmap = regmap;
+	div->map_offset = map_offset;
+	div->shift = shift;
+	div->width = width;
+	div->flags = clk_divider_flags;
+	div->lock = lock;
+	div->hw.init = &init;
+	div->table = table;
+
+	/* register the clock */
+	hw = &div->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(div);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(__clk_hw_register_divider_regmap);
+
+struct clk *clk_register_divider_regmap_table(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		struct regmap *regmap, u8 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock)
+{
+	struct clk_hw *hw;
+
+	hw =  __clk_hw_register_divider_regmap(dev, NULL, name, parent_name, NULL,
+					       NULL, flags, regmap, map_offset,
+					       shift, width, clk_divider_flags,
+					       table, lock);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
+}
+EXPORT_SYMBOL_GPL(clk_register_divider_regmap_table);
+
+void clk_unregister_divider_regmap(struct clk *clk)
+{
+	struct clk_divider_regmap *div;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	div = to_clk_divider_regmap(hw);
+
+	clk_unregister(clk);
+	kfree(div);
+}
+EXPORT_SYMBOL_GPL(clk_unregister_divider_regmap);
+
+/**
+ * clk_hw_unregister_divider_regmap - unregister a clk divider
+ * @hw: hardware-specific clock data to unregister
+ */
+void clk_hw_unregister_divider_regmap(struct clk_hw *hw)
+{
+	struct clk_divider_regmap *div;
+
+	div = to_clk_divider_regmap(hw);
+
+	clk_hw_unregister(hw);
+	kfree(div);
+}
+EXPORT_SYMBOL_GPL(clk_hw_unregister_divider_regmap);
+
+static void devm_clk_hw_release_divider_regmap(struct device *dev, void *res)
+{
+	clk_hw_unregister_divider_regmap(*(struct clk_hw **)res);
+}
+
+struct clk_hw *__devm_clk_hw_register_divider_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		struct regmap *regmap, u8 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock)
+{
+	struct clk_hw **ptr, *hw;
+
+	ptr = devres_alloc(devm_clk_hw_release_divider_regmap, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hw = __clk_hw_register_divider_regmap(dev, np, name, parent_name, parent_hw,
+					      parent_data, flags, regmap, map_offset,
+					      shift, width, clk_divider_flags, table,
+					      lock);
+
+	if (!IS_ERR(hw)) {
+		*ptr = hw;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(__devm_clk_hw_register_divider_regmap);
diff --git a/drivers/clk/clk-gate-regmap.c b/drivers/clk/clk-gate-regmap.c
new file mode 100644
index 000000000000..cf9e48407971
--- /dev/null
+++ b/drivers/clk/clk-gate-regmap.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/string.h>
+
+/**
+ * DOC: basic gatable clock which can gate and ungate its output
+ *
+ * Traits of this clock:
+ * prepare - clk_(un)prepare only ensures parent is (un)prepared
+ * enable - clk_enable and clk_disable are functional & control gating
+ * rate - inherits rate from parent.  No clk_set_rate support
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+static inline u32 clk_gate_regmap_readl(struct clk_gate_regmap *gate)
+{
+	u32 val;
+
+	regmap_read(gate->map, gate->map_offset, &val);
+
+	return val;
+}
+
+static inline void clk_gate_regmap_writel(struct clk_gate_regmap *gate, u32 val)
+{
+	regmap_write(gate->map, gate->map_offset, val);
+
+}
+
+/*
+ * It works on following logic:
+ *
+ * For enabling clock, enable = 1
+ *	set2dis = 1	-> clear bit	-> set = 0
+ *	set2dis = 0	-> set bit	-> set = 1
+ *
+ * For disabling clock, enable = 0
+ *	set2dis = 1	-> set bit	-> set = 1
+ *	set2dis = 0	-> clear bit	-> set = 0
+ *
+ * So, result is always: enable xor set2dis.
+ */
+static void clk_gate_regmap_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_gate_regmap *gate = to_clk_gate_regmap(hw);
+	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+	unsigned long flags;
+	u32 reg;
+
+	set ^= enable;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+	else
+		__acquire(gate->lock);
+
+	if (gate->flags & CLK_GATE_HIWORD_MASK) {
+		reg = BIT(gate->bit_idx + 16);
+		if (set)
+			reg |= BIT(gate->bit_idx);
+	} else {
+		reg = clk_gate_regmap_readl(gate);
+
+		if (set)
+			reg |= BIT(gate->bit_idx);
+		else
+			reg &= ~BIT(gate->bit_idx);
+	}
+
+	clk_gate_regmap_writel(gate, reg);
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+	else
+		__release(gate->lock);
+}
+
+static int clk_gate_regmap_enable(struct clk_hw *hw)
+{
+	clk_gate_regmap_endisable(hw, 1);
+
+	return 0;
+}
+
+static void clk_gate_regmap_disable(struct clk_hw *hw)
+{
+	clk_gate_regmap_endisable(hw, 0);
+}
+
+int clk_gate_regmap_is_enabled(struct clk_hw *hw)
+{
+	u32 reg;
+	struct clk_gate_regmap *gate = to_clk_gate_regmap(hw);
+
+	reg = clk_gate_regmap_readl(gate);
+
+	/* if a set bit disables this clk, flip it before masking */
+	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
+		reg ^= BIT(gate->bit_idx);
+
+	reg &= BIT(gate->bit_idx);
+
+	return reg ? 1 : 0;
+}
+EXPORT_SYMBOL_GPL(clk_gate_regmap_is_enabled);
+
+const struct clk_ops clk_gate_regmap_ops = {
+	.enable = clk_gate_regmap_enable,
+	.disable = clk_gate_regmap_disable,
+	.is_enabled = clk_gate_regmap_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_gate_regmap_ops);
+
+struct clk_hw *__clk_hw_register_gate_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
+		struct regmap *map, u8 map_offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clk_gate_regmap *gate;
+	struct clk_hw *hw;
+	struct clk_init_data init = {};
+	int ret = -EINVAL;
+
+	if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
+		if (bit_idx > 15) {
+			pr_err("gate bit exceeds LOWORD field\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	/* allocate the gate */
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_gate_regmap_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.parent_hws = parent_hw ? &parent_hw : NULL;
+	init.parent_data = parent_data;
+	if (parent_name || parent_hw || parent_data)
+		init.num_parents = 1;
+	else
+		init.num_parents = 0;
+
+	/* struct clk_gate_regmap assignments */
+	gate->map = map;
+	gate->map_offset = map_offset;
+	gate->bit_idx = bit_idx;
+	gate->flags = clk_gate_flags;
+	gate->lock = lock;
+	gate->hw.init = &init;
+
+	hw = &gate->hw;
+	if (dev || !np)
+		ret = clk_hw_register(dev, hw);
+	else if (np)
+		ret = of_clk_hw_register(np, hw);
+	if (ret) {
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+
+}
+EXPORT_SYMBOL_GPL(__clk_hw_register_gate_regmap);
+
+struct clk *clk_register_gate_regmap(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags, struct regmap *map,
+		u8 map_offset, u8 bit_idx, u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clk_hw *hw;
+
+	hw = __clk_hw_register_gate_regmap(dev, NULL, name, parent_name, NULL,
+					   NULL, flags, map, map_offset, bit_idx,
+					   clk_gate_flags, lock);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
+}
+EXPORT_SYMBOL_GPL(clk_register_gate_regmap);
+
+void clk_unregister_gate_regmap(struct clk *clk)
+{
+	struct clk_gate_regmap *gate;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	gate = to_clk_gate_regmap(hw);
+
+	clk_unregister(clk);
+	kfree(gate);
+}
+EXPORT_SYMBOL_GPL(clk_unregister_gate_regmap);
+
+void clk_hw_unregister_gate_regmap(struct clk_hw *hw)
+{
+	struct clk_gate_regmap *gate;
+
+	gate = to_clk_gate_regmap(hw);
+
+	clk_hw_unregister(hw);
+	kfree(gate);
+}
+EXPORT_SYMBOL_GPL(clk_hw_unregister_gate_regmap);
+
+static void devm_clk_hw_release_gate_regmap(struct device *dev, void *res)
+{
+	clk_hw_unregister_gate_regmap(*(struct clk_hw **)res);
+}
+
+struct clk_hw *__devm_clk_hw_register_gate_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags, struct regmap *map,
+		u8 map_offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clk_hw **ptr, *hw;
+
+	ptr = devres_alloc(devm_clk_hw_release_gate_regmap, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hw = __clk_hw_register_gate_regmap(dev, np, name, parent_name, parent_hw,
+					   parent_data, flags, map, map_offset,
+					   bit_idx, clk_gate_flags, lock);
+
+	if (!IS_ERR(hw)) {
+		*ptr = hw;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(__devm_clk_hw_register_gate_regmap);
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 68e585a02fd9..1e3f21a249ca 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -34,10 +34,11 @@ static inline u32 clk_gate_readl(struct clk_gate *gate)
 
 static inline void clk_gate_writel(struct clk_gate *gate, u32 val)
 {
-	if (gate->flags & CLK_GATE_BIG_ENDIAN)
+	if (gate->flags & CLK_GATE_BIG_ENDIAN) {
 		iowrite32be(val, gate->reg);
-	else
+	} else {
 		writel(val, gate->reg);
+	}
 }
 
 /*
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2e6e603b7493..6f5cf6670b48 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -8,6 +8,7 @@
 
 #include <linux/of.h>
 #include <linux/of_clk.h>
+#include <linux/regmap.h>
 
 /*
  * flags used across common struct clk.  these flags should only affect the
@@ -526,6 +527,7 @@ void of_fixed_clk_setup(struct device_node *np);
 struct clk_gate {
 	struct clk_hw hw;
 	void __iomem	*reg;
+	u8		map_offset;
 	u8		bit_idx;
 	u8		flags;
 	spinlock_t	*lock;
@@ -538,6 +540,37 @@ struct clk_gate {
 #define CLK_GATE_BIG_ENDIAN		BIT(2)
 
 extern const struct clk_ops clk_gate_ops;
+
+#ifdef CONFIG_COMMON_CLK_GATE_REGMAP
+/**
+ * struct clk_gate_regmap - gating clock via regmap
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @map:	regmap controlling gate
+ * @map_offset:	register offset within the regmap controlling gate
+ * @bit_idx:	single bit controlling gate
+ * @flags:	hardware-specific flags
+ * @lock:	register lock
+ *
+ * Clock which can gate its output.  Implements .enable & .disable
+ *
+ * Flags:
+ * See clk_gate
+ */
+struct clk_gate_regmap {
+	struct clk_hw hw;
+	struct regmap	*map;
+	u8		map_offset;
+	u8		bit_idx;
+	u8		flags;
+	spinlock_t	*lock;
+};
+
+#define to_clk_gate_regmap(_hw) container_of(_hw, struct clk_gate_regmap, hw)
+
+extern const struct clk_ops clk_gate_regmap_ops;
+#endif
+
 struct clk_hw *__clk_hw_register_gate(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
@@ -663,6 +696,31 @@ void clk_unregister_gate(struct clk *clk);
 void clk_hw_unregister_gate(struct clk_hw *hw);
 int clk_gate_is_enabled(struct clk_hw *hw);
 
+#ifdef CONFIG_COMMON_CLK_GATE_REGMAP
+struct clk_hw *__clk_hw_register_gate_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
+		struct regmap *map, u8 map_offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
+struct clk_hw *__devm_clk_hw_register_gate_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
+		struct regmap *map, u8 map_offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
+struct clk *clk_register_gate_regmap(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		struct regmap *map, u8 map_offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
+
+void clk_unregister_gate_regmap(struct clk *clk);
+void clk_hw_unregister_gate_regmap(struct clk_hw *hw);
+int clk_gate_regmap_is_enabled(struct clk_hw *hw);
+#endif
+
 struct clk_div_table {
 	unsigned int	val;
 	unsigned int	div;
@@ -736,6 +794,41 @@ struct clk_divider {
 extern const struct clk_ops clk_divider_ops;
 extern const struct clk_ops clk_divider_ro_ops;
 
+#ifdef CONFIG_COMMON_CLK_DIVIDER_REGMAP
+/**
+ * struct clk_divider_regmap - adjustable divider clock via regmap
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @map:	regmap containing the divider
+ * @map_offset:	register offset within the regmap containing the divider
+ * @shift:	shift to the divider bit field
+ * @width:	width of the divider bit field
+ * @table:	array of value/divider pairs, last entry should have div = 0
+ * @lock:	register lock
+ *
+ * Clock with an adjustable divider affecting its output frequency.  Implements
+ * .recalc_rate, .set_rate and .round_rate
+ *
+ * @flags:
+ * See clk_divider
+ */
+struct clk_divider_regmap {
+	struct clk_hw	hw;
+	struct regmap	*regmap;
+	u8		map_offset;
+	u8		shift;
+	u8		width;
+	u8		flags;
+	const struct clk_div_table	*table;
+	spinlock_t	*lock;
+};
+
+#define to_clk_divider_regmap(_hw) container_of(_hw, struct clk_divider_regmap, hw)
+
+extern const struct clk_ops clk_divider_regmap_ops;
+extern const struct clk_ops clk_divider_regmap_ro_ops;
+#endif
+
 unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 		unsigned int val, const struct clk_div_table *table,
 		unsigned long flags, unsigned long width);
@@ -972,6 +1065,33 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 void clk_unregister_divider(struct clk *clk);
 void clk_hw_unregister_divider(struct clk_hw *hw);
 
+#ifdef CONFIG_COMMON_CLK_DIVIDER_REGMAP
+struct clk_hw *__clk_hw_register_divider_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		struct regmap *regmap, u8 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock);
+
+struct clk_hw *__devm_clk_hw_register_divider_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		struct regmap *regmap, u8 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock);
+
+struct clk *clk_register_divider_regmap_table(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		struct regmap *regmap, u8 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock);
+
+void clk_unregister_divider_regmap(struct clk *clk);
+void clk_hw_unregister_divider_regmap(struct clk_hw *hw);
+#endif
+
 /**
  * struct clk_mux - multiplexer clock
  *
-- 
2.45.2


