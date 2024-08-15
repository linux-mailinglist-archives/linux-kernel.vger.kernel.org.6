Return-Path: <linux-kernel+bounces-288050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F671953237
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0DB1F25D63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043561AED32;
	Thu, 15 Aug 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8MJAMoB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A911A7056;
	Thu, 15 Aug 2024 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730522; cv=none; b=C+w9djN2Ks2FW9bsNuwvno2aHo/WnDF+0E3zJik4HqE2pE2UxsN+Dmlw7QVxboxJh+1OAUvzfG5T8NIWafdzvKtUi4ueSiRSNhgfuyG19BDZLO1W7l3WhnKfRDuKssFksNrRm0q9r9OyK+Uh3jxBJtNEk4JKgbtXXdzJJp6bPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730522; c=relaxed/simple;
	bh=pX087AmU1PaUgpUD1h/mJcraFHVX9O0NaJswXItglDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEuWo3WLzDWH97A3vBJt47Hw+BN0MqBICuMOCZO84n22EOR1LYiw+sWLRp56i4HHQfIQHryL6DgUgnAGtR64cB8NG3z2278xdOUI66OFShaCTzyAadF0EK0709CjV5WrpzP2eodJaSpVJqbSeJlKIO/dzgfjM011e2cGfYVMFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8MJAMoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ACEC32786;
	Thu, 15 Aug 2024 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730522;
	bh=pX087AmU1PaUgpUD1h/mJcraFHVX9O0NaJswXItglDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8MJAMoB3RMbrKDcxeIEFBw++2H3qlyRoZHHOgEggMAb6a6Z0dFnUj9IFqjALz2lr
	 EyDo9geBCnDUY0uFjDFEXyRcGH78ET4HmFPCn9Xt88wy3+Zd2uRQOoNmqLeIufyxIS
	 4MIwFCItiwszWadPVmDoerQsY9xoQJ0g63iDnd88tauiukFdCOI+xwgQVd0f49DQBW
	 CcjkNgOhI4TS+xZW3dtBDpOsfoVvTwMIv6lF3kg5n5gRmy/I4WM0+uXEgjxDvbXj2b
	 o4eWcU4ezx0vwDb7eWEfyOT2sGfak+5AmK/bh+57hobHBhW1Wh6hmqmfNMFCbx6bIT
	 o6/UpiZtRVQ/Q==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/11] copy meson clk-regmap for now
Date: Thu, 15 Aug 2024 15:01:11 +0100
Message-ID: <20240815-skirmish-violator-8ce24c596b9f@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10704; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=7foUgvrOx4wJS1971cQwv0FEaKkGIfX/0niGM57yiMo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uHR95+69zHXwuvi1Lzd/v2ZJt9m4r4yD/5w7R9ikH J3cH9P3dpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiC/QZ/qfwLHLZsc3zY9TW jdsM14pF512ZF7mdSe3MQ+2S2oNiP6cw/E+XWsQj8KTfp8HTmdeeL/fxxLZFvmfv/9vS13+3Ltu jnwcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/Makefile     |   1 +
 drivers/clk/microchip/clk-regmap.c | 186 +++++++++++++++++++++++++++++
 drivers/clk/microchip/clk-regmap.h | 137 +++++++++++++++++++++
 3 files changed, 324 insertions(+)
 create mode 100644 drivers/clk/microchip/clk-regmap.c
 create mode 100644 drivers/clk/microchip/clk-regmap.h

diff --git a/drivers/clk/microchip/Makefile b/drivers/clk/microchip/Makefile
index 13250e04e46c..6b463066c64e 100644
--- a/drivers/clk/microchip/Makefile
+++ b/drivers/clk/microchip/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_COMMON_CLK_PIC32) += clk-core.o
 obj-$(CONFIG_PIC32MZDA) += clk-pic32mzda.o
 obj-$(CONFIG_MCHP_CLK_MPFS) += clk-mpfs.o
 obj-$(CONFIG_MCHP_CLK_MPFS) += clk-mpfs-ccc.o
+obj-y += clk-regmap.o
diff --git a/drivers/clk/microchip/clk-regmap.c b/drivers/clk/microchip/clk-regmap.c
new file mode 100644
index 000000000000..ad116d24f700
--- /dev/null
+++ b/drivers/clk/microchip/clk-regmap.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/module.h>
+#include "clk-regmap.h"
+
+static int clk_regmap_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_gate_data *gate = clk_get_regmap_gate_data(clk);
+	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+
+	set ^= enable;
+
+	return regmap_update_bits(clk->map, gate->offset, BIT(gate->bit_idx),
+				  set ? BIT(gate->bit_idx) : 0);
+}
+
+static int clk_regmap_gate_enable(struct clk_hw *hw)
+{
+	return clk_regmap_gate_endisable(hw, 1);
+}
+
+static void clk_regmap_gate_disable(struct clk_hw *hw)
+{
+	clk_regmap_gate_endisable(hw, 0);
+}
+
+static int clk_regmap_gate_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_gate_data *gate = clk_get_regmap_gate_data(clk);
+	unsigned int val;
+
+	regmap_read(clk->map, gate->offset, &val);
+	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
+		val ^= BIT(gate->bit_idx);
+
+	val &= BIT(gate->bit_idx);
+
+	return val ? 1 : 0;
+}
+
+const struct clk_ops clk_regmap_gate_ops = {
+	.enable = clk_regmap_gate_enable,
+	.disable = clk_regmap_gate_disable,
+	.is_enabled = clk_regmap_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_gate_ops);
+
+const struct clk_ops clk_regmap_gate_ro_ops = {
+	.is_enabled = clk_regmap_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_gate_ro_ops);
+
+static unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
+						unsigned long prate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(clk->map, div->offset, &val);
+	if (ret)
+		/* Gives a hint that something is wrong */
+		return 0;
+
+	val >>= div->shift;
+	val &= clk_div_mask(div->width);
+	return divider_recalc_rate(hw, prate, val, div->table, div->flags,
+				   div->width);
+}
+
+static int clk_regmap_div_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+	unsigned int val;
+	int ret;
+
+	/* if read only, just return current value */
+	if (div->flags & CLK_DIVIDER_READ_ONLY) {
+		ret = regmap_read(clk->map, div->offset, &val);
+		if (ret)
+			return ret;
+
+		val >>= div->shift;
+		val &= clk_div_mask(div->width);
+
+		return divider_ro_determine_rate(hw, req, div->table,
+						 div->width, div->flags, val);
+	}
+
+	return divider_determine_rate(hw, req, div->table, div->width,
+				      div->flags);
+}
+
+static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+	unsigned int val;
+	int ret;
+
+	ret = divider_get_val(rate, parent_rate, div->table, div->width,
+			      div->flags);
+	if (ret < 0)
+		return ret;
+
+	val = (unsigned int)ret << div->shift;
+	return regmap_update_bits(clk->map, div->offset,
+				  clk_div_mask(div->width) << div->shift, val);
+};
+
+/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
+
+const struct clk_ops clk_regmap_divider_ops = {
+	.recalc_rate = clk_regmap_div_recalc_rate,
+	.determine_rate = clk_regmap_div_determine_rate,
+	.set_rate = clk_regmap_div_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_divider_ops);
+
+const struct clk_ops clk_regmap_divider_ro_ops = {
+	.recalc_rate = clk_regmap_div_recalc_rate,
+	.determine_rate = clk_regmap_div_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_divider_ro_ops);
+
+static u8 clk_regmap_mux_get_parent(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_mux_data *mux = clk_get_regmap_mux_data(clk);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(clk->map, mux->offset, &val);
+	if (ret)
+		return ret;
+
+	val >>= mux->shift;
+	val &= mux->mask;
+	return clk_mux_val_to_index(hw, mux->table, mux->flags, val);
+}
+
+static int clk_regmap_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_mux_data *mux = clk_get_regmap_mux_data(clk);
+	unsigned int val = clk_mux_index_to_val(mux->table, mux->flags, index);
+
+	return regmap_update_bits(clk->map, mux->offset,
+				  mux->mask << mux->shift,
+				  val << mux->shift);
+}
+
+static int clk_regmap_mux_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_mux_data *mux = clk_get_regmap_mux_data(clk);
+
+	return clk_mux_determine_rate_flags(hw, req, mux->flags);
+}
+
+const struct clk_ops clk_regmap_mux_ops = {
+	.get_parent = clk_regmap_mux_get_parent,
+	.set_parent = clk_regmap_mux_set_parent,
+	.determine_rate = clk_regmap_mux_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_mux_ops);
+
+const struct clk_ops clk_regmap_mux_ro_ops = {
+	.get_parent = clk_regmap_mux_get_parent,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_mux_ro_ops);
+
+MODULE_DESCRIPTION("Amlogic regmap backed clock driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/microchip/clk-regmap.h b/drivers/clk/microchip/clk-regmap.h
new file mode 100644
index 000000000000..e365312da54e
--- /dev/null
+++ b/drivers/clk/microchip/clk-regmap.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __CLK_REGMAP_H
+#define __CLK_REGMAP_H
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+/**
+ * struct clk_regmap - regmap backed clock
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @map:	pointer to the regmap structure controlling the clock
+ * @data:	data specific to the clock type
+ *
+ * Clock which is controlled by regmap backed registers. The actual type of
+ * of the clock is controlled by the clock_ops and data.
+ */
+struct clk_regmap {
+	struct clk_hw	hw;
+	struct regmap	*map;
+	void		*data;
+};
+
+static inline struct clk_regmap *to_clk_regmap(struct clk_hw *hw)
+{
+	return container_of(hw, struct clk_regmap, hw);
+}
+
+/**
+ * struct clk_regmap_gate_data - regmap backed gate specific data
+ *
+ * @offset:	offset of the register controlling gate
+ * @bit_idx:	single bit controlling gate
+ * @flags:	hardware-specific flags
+ *
+ * Flags:
+ * Same as clk_gate except CLK_GATE_HIWORD_MASK which is ignored
+ */
+struct clk_regmap_gate_data {
+	unsigned int	offset;
+	u8		bit_idx;
+	u8		flags;
+};
+
+static inline struct clk_regmap_gate_data *
+clk_get_regmap_gate_data(struct clk_regmap *clk)
+{
+	return (struct clk_regmap_gate_data *)clk->data;
+}
+
+extern const struct clk_ops clk_regmap_gate_ops;
+extern const struct clk_ops clk_regmap_gate_ro_ops;
+
+/**
+ * struct clk_regmap_div_data - regmap backed adjustable divider specific data
+ *
+ * @offset:	offset of the register controlling the divider
+ * @shift:	shift to the divider bit field
+ * @width:	width of the divider bit field
+ * @table:	array of value/divider pairs, last entry should have div = 0
+ *
+ * Flags:
+ * Same as clk_divider except CLK_DIVIDER_HIWORD_MASK which is ignored
+ */
+struct clk_regmap_div_data {
+	unsigned int	offset;
+	u8		shift;
+	u8		width;
+	u8		flags;
+	const struct clk_div_table	*table;
+};
+
+static inline struct clk_regmap_div_data *
+clk_get_regmap_div_data(struct clk_regmap *clk)
+{
+	return (struct clk_regmap_div_data *)clk->data;
+}
+
+extern const struct clk_ops clk_regmap_divider_ops;
+extern const struct clk_ops clk_regmap_divider_ro_ops;
+
+/**
+ * struct clk_regmap_mux_data - regmap backed multiplexer clock specific data
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @offset:	offset of theregister controlling multiplexer
+ * @table:	array of parent indexed register values
+ * @shift:	shift to multiplexer bit field
+ * @mask:	mask of mutliplexer bit field
+ * @flags:	hardware-specific flags
+ *
+ * Flags:
+ * Same as clk_divider except CLK_MUX_HIWORD_MASK which is ignored
+ */
+struct clk_regmap_mux_data {
+	unsigned int	offset;
+	u32		*table;
+	u32		mask;
+	u8		shift;
+	u8		flags;
+};
+
+static inline struct clk_regmap_mux_data *
+clk_get_regmap_mux_data(struct clk_regmap *clk)
+{
+	return (struct clk_regmap_mux_data *)clk->data;
+}
+
+extern const struct clk_ops clk_regmap_mux_ops;
+extern const struct clk_ops clk_regmap_mux_ro_ops;
+
+#define __MESON_PCLK(_name, _reg, _bit, _ops, _pname)			\
+struct clk_regmap _name = {						\
+	.data = &(struct clk_regmap_gate_data){				\
+		.offset = (_reg),					\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = #_name,						\
+		.ops = _ops,						\
+		.parent_hws = (const struct clk_hw *[]) { _pname },	\
+		.num_parents = 1,					\
+		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
+	},								\
+}
+
+#define MESON_PCLK(_name, _reg, _bit, _pname)	\
+	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ops, _pname)
+
+#define MESON_PCLK_RO(_name, _reg, _bit, _pname)	\
+	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ro_ops, _pname)
+#endif /* __CLK_REGMAP_H */
-- 
2.43.0


