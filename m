Return-Path: <linux-kernel+bounces-216084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E1F909B32
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 03:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382A31C20CD8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 01:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191CA167283;
	Sun, 16 Jun 2024 01:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="CXiRa2IM"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413F1552EA
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718502925; cv=none; b=uHQW+UKCSAhCZkBXX091orcbgrOKj70GFKnZ9Ux1dAAz9jwyx9tv2Ab7RMac9hs8hjqYHIynAZ9EbPUFyhtpDLtYF6I9xXt13Z1gClXTA9WdHnVrQoOXABHRvezlufqeW2PZVR66cOwVGSTa5jeEeh+eXWFZGfVB8WGJ6ApDEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718502925; c=relaxed/simple;
	bh=tcSZvCqY4f30ocTN3dCnK1ftZtzavyOUXHtuuaqWtO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEAzrn638uEKaXiTuOM+DyRRLY/5g2qd9Dd0irBboTdqXdqJvYGAyKoLkUBQEi2Nxlu4wuaIyuPnI5W8xFKBKg9vK8O+hkXO8J3kDlstRCR3O+kTqCjpejZ0cv+y59z57wyXs5RC7DEQen5aZ8e7k3sO4zUZLVKTQBJQN6Dby6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=CXiRa2IM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2e72128b4so2391712a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718502922; x=1719107722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsOUmyLiy+gaJki0iphyaf4056TlTNZ65O9dY7YN+6k=;
        b=CXiRa2IMTGa9c3rUKTa22zY7za3fQxxARa1hKj1FQApM1RdCwqyV5Jgh9TdmpMCVmZ
         MK1q+dEsj1Z94gq5qltAKS7ZJ4dDk6nKA3lyi9mDX0Pf3Jxn5c3PkrKX+P+ScFYJ6Jly
         /8CqbO6KWrESsHZ+Wf3tFDeHVlxdu1FmkjCdeK7niyLsEgE6NVc6XBuOLe+W4ruY3bcM
         SQHO/m9JgMDVsAV8GQEPI1qrZA1Py994x0HVMfrsR0rO5iBpNAumvckmUPuNUscZAuOP
         0bM6c+wLZjjyBMa3y5zzqv8c0dBboZJ92CL/yeri6lxWXQypKKHazDJivHtqgij45ap1
         fNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718502922; x=1719107722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsOUmyLiy+gaJki0iphyaf4056TlTNZ65O9dY7YN+6k=;
        b=RyYnMYzDIv7Wlgz5oRhrLA2K7+mY6wTeRQbbBWChxD3qF38mKLhJdpvX0n4EB80XGI
         1KObS4umVrWn39ckIbj92m4GxLhv7pPbKGGx330iK3fuQV7r8fGt2rsmWz+q1u0YSWXB
         fAdLOELZXiLrkgDTAd/fIPl1nbEjsRhyidWwAFHuKjzPgrsCgmg5EZiQOGcMp+/YTM/0
         y8DwWqG8q8utpUueXXuDU75t48sOjL7JXfnu1k46lvUxInHgF4r3kMRpbDV37U4fjmDd
         +PxoJJ5JQWvuk0fWWC7zbs8cVPy5fgBTKqHPNpRwCbAk5kKkAqQvcj/y5dHIoC0Yy5w8
         8wFA==
X-Forwarded-Encrypted: i=1; AJvYcCW/erRS+j+2ZgIBONygVG2YoL8CGN6KV/NrQeHJMMrfu/rPkiree03n+mvt/CvCJhHltPxhJ0XRE8WaQEtAhdZoHkAXUsqrSkbPkswJ
X-Gm-Message-State: AOJu0YxVYetSqmxItB5n7BthI0H4DRKxASO2RIg6V/caL4utqYudYSHB
	lQMLgB8uGDcH8tBBMOJZGTR+zIkLHOD21z/7JrhUqaYBZ0N7efCfnnXr0gBsVz+iZborjOYyIKQ
	n
X-Google-Smtp-Source: AGHT+IHgEAMIIax+tuh4BTu0Zyo/QCMZK5bl6mBIjIEfJxDE/9IV1ej0aRldlVAgcU4HULn6otFbZQ==
X-Received: by 2002:a17:90a:fc92:b0:2c2:12d:fa01 with SMTP id 98e67ed59e1d1-2c4bd8bc029mr15081250a91.11.1718502922193;
        Sat, 15 Jun 2024 18:55:22 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:1cea:28dd:2ee0:e8e5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769aedbsm8751201a91.43.2024.06.15.18.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 18:55:21 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sat, 15 Jun 2024 18:54:31 -0700
Subject: [PATCH 2/6] clk: thead: Add support for T-Head TH1520 AP_SUBSYS
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240615-th1520-clk-v1-2-3ba4978c4d6b@tenstorrent.com>
References: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
In-Reply-To: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.12.3

Add support for the AP sub-system clock controller in the T-Head TH1520.
This include CPU, DPU, GMAC and TEE PLLs.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
Co-developed-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Co-developed-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 MAINTAINERS                       |    1 +
 drivers/clk/Kconfig               |    1 +
 drivers/clk/Makefile              |    1 +
 drivers/clk/thead/Kconfig         |   12 +
 drivers/clk/thead/Makefile        |    2 +
 drivers/clk/thead/clk-th1520-ap.c | 1086 +++++++++++++++++++++++++++++++++++++
 6 files changed, 1103 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 761fcbddc8d6..75880648dd14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19322,6 +19322,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
 F:	arch/riscv/boot/dts/thead/
+F:	drivers/clk/thead/clk-th1520-ap.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 
 RNBD BLOCK DRIVERS
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3e9099504fad..d73ae04e427a 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -495,6 +495,7 @@ source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
 source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
+source "drivers/clk/thead/Kconfig"
 source "drivers/clk/stm32/Kconfig"
 source "drivers/clk/ti/Kconfig"
 source "drivers/clk/uniphier/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4abe16c8ccdf..f793a16cad40 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -127,6 +127,7 @@ obj-y					+= starfive/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 obj-y					+= sunxi-ng/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
+obj-$(CONFIG_ARCH_THEAD)		+= thead/
 obj-y					+= ti/
 obj-$(CONFIG_CLK_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_ARCH_U8500)		+= ux500/
diff --git a/drivers/clk/thead/Kconfig b/drivers/clk/thead/Kconfig
new file mode 100644
index 000000000000..1710d50bf9d4
--- /dev/null
+++ b/drivers/clk/thead/Kconfig
@@ -0,0 +1,12 @@
+#SPDX-License-Identifier: GPL-2.0
+
+config CLK_THEAD_TH1520_AP
+	bool "T-HEAD TH1520 AP clock support"
+	depends on ARCH_THEAD || COMPILE_TEST
+	default ARCH_THEAD
+	select REGMAP_MMIO
+	help
+	  Say yes here to support the AP sub system clock controller
+	  on the T-HEAD TH1520 SoC. This includes configuration of
+	  both CPU PLLs, both DPU PLLs as well as the GMAC, VIDEO,
+	  and TEE PLLs.
diff --git a/drivers/clk/thead/Makefile b/drivers/clk/thead/Makefile
new file mode 100644
index 000000000000..7ee0bec1f251
--- /dev/null
+++ b/drivers/clk/thead/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CLK_THEAD_TH1520_AP) += clk-th1520-ap.o
diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
new file mode 100644
index 000000000000..982d4d40f783
--- /dev/null
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -0,0 +1,1086 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
+ *  Authors: Yangtao Li <frank.li@vivo.com>
+ */
+
+#include <dt-bindings/clock/thead,th1520-clk-ap.h>
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define TH1520_PLL_POSTDIV2	GENMASK(26, 24)
+#define TH1520_PLL_POSTDIV1	GENMASK(22, 20)
+#define TH1520_PLL_FBDIV	GENMASK(19, 8)
+#define TH1520_PLL_REFDIV	GENMASK(5, 0)
+#define TH1520_PLL_BYPASS	BIT(30)
+#define TH1520_PLL_DSMPD	BIT(24)
+#define TH1520_PLL_FRAC		GENMASK(23, 0)
+#define TH1520_PLL_FRAC_BITS    24
+
+struct ccu_internal {
+	u8	shift;
+	u8	width;
+};
+
+struct ccu_div_internal {
+	u8	shift;
+	u8	width;
+	u32	flags;
+};
+
+struct ccu_common {
+	int		clkid;
+	struct regmap	*map;
+	u16		cfg0;
+	u16		cfg1;
+	struct clk_hw	hw;
+};
+
+struct ccu_mux {
+	struct ccu_internal	mux;
+	struct ccu_common	common;
+};
+
+struct ccu_gate {
+	u32			enable;
+	struct ccu_common	common;
+};
+
+struct ccu_div {
+	u32			enable;
+	struct ccu_div_internal	div;
+	struct ccu_internal	mux;
+	struct ccu_common	common;
+};
+
+struct ccu_pll {
+	struct ccu_common	common;
+};
+
+#define TH_CCU_ARG(_shift, _width)					\
+	{								\
+		.shift	= _shift,					\
+		.width	= _width,					\
+	}
+
+#define TH_CCU_DIV_FLAGS(_shift, _width, _flags)			\
+	{								\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.flags	= _flags,					\
+	}
+
+#define CCU_GATE(_clkid, _struct, _name, _parent, _reg, _gate, _flags)	\
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.clkid		= _clkid,			\
+			.cfg0		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(	\
+						_name,			\
+						_parent,		\
+						&clk_gate_ops,		\
+						_flags),		\
+		}							\
+	}
+
+static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
+{
+	return container_of(hw, struct ccu_common, hw);
+}
+
+static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_mux, common);
+}
+
+static inline struct ccu_pll *hw_to_ccu_pll(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_pll, common);
+}
+
+static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_div, common);
+}
+
+static inline struct ccu_gate *hw_to_ccu_gate(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_gate, common);
+}
+
+static u8 ccu_get_parent_helper(struct ccu_common *common,
+				struct ccu_internal *mux)
+{
+	unsigned int val;
+	u8 parent;
+
+	regmap_read(common->map, common->cfg0, &val);
+	parent = val >> mux->shift;
+	parent &= GENMASK(mux->width - 1, 0);
+
+	return parent;
+}
+
+static int ccu_set_parent_helper(struct ccu_common *common,
+				 struct ccu_internal *mux,
+				 u8 index)
+{
+	return regmap_update_bits(common->map, common->cfg0,
+			GENMASK(mux->width - 1, 0) << mux->shift,
+			index << mux->shift);
+}
+
+static void ccu_disable_helper(struct ccu_common *common, u32 gate)
+{
+	if (!gate)
+		return;
+	regmap_update_bits(common->map, common->cfg0,
+			   gate, ~gate);
+}
+
+static int ccu_enable_helper(struct ccu_common *common, u32 gate)
+{
+	unsigned int val;
+	int ret;
+
+	if (!gate)
+		return 0;
+
+	ret = regmap_update_bits(common->map, common->cfg0, gate, gate);
+	regmap_read(common->map, common->cfg0, &val);
+	return ret;
+}
+
+static int ccu_is_enabled_helper(struct ccu_common *common, u32 gate)
+{
+	unsigned int val;
+
+	if (!gate)
+		return true;
+
+	regmap_read(common->map, common->cfg0, &val);
+	return val & gate;
+}
+
+static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+	unsigned long rate;
+	unsigned int val;
+
+	regmap_read(cd->common.map, cd->common.cfg0, &val);
+	val = val >> cd->div.shift;
+	val &= GENMASK(cd->div.width - 1, 0);
+	rate = divider_recalc_rate(hw, parent_rate, val, NULL,
+				   cd->div.flags, cd->div.width);
+
+	return rate;
+}
+
+static u8 ccu_div_get_parent(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_get_parent_helper(&cd->common, &cd->mux);
+}
+
+static int ccu_div_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_set_parent_helper(&cd->common, &cd->mux, index);
+}
+
+static void ccu_div_disable(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	ccu_disable_helper(&cd->common, cd->enable);
+}
+
+static int ccu_div_enable(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_enable_helper(&cd->common, cd->enable);
+}
+
+static int ccu_div_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_is_enabled_helper(&cd->common, cd->enable);
+}
+
+static const struct clk_ops ccu_div_ops = {
+	.disable	= ccu_div_disable,
+	.enable		= ccu_div_enable,
+	.is_enabled	= ccu_div_is_enabled,
+	.get_parent	= ccu_div_get_parent,
+	.set_parent	= ccu_div_set_parent,
+	.recalc_rate	= ccu_div_recalc_rate,
+	.determine_rate	= clk_hw_determine_rate_no_reparent,
+};
+
+static unsigned long th1520_pll_vco_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+	unsigned long div, mul, frac, rate = parent_rate;
+	unsigned int cfg0, cfg1;
+
+	regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
+	regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
+
+	mul = FIELD_GET(TH1520_PLL_FBDIV, cfg0);
+	div = FIELD_GET(TH1520_PLL_REFDIV, cfg0);
+	if (!(cfg1 & TH1520_PLL_DSMPD)) {
+		mul <<= TH1520_PLL_FRAC_BITS;
+		frac = FIELD_GET(TH1520_PLL_FRAC, cfg1);
+		mul += frac;
+		div <<= TH1520_PLL_FRAC_BITS;
+	}
+	rate = parent_rate * mul;
+	do_div(rate, div);
+	return rate;
+}
+
+static unsigned long th1520_pll_postdiv_recalc_rate(struct clk_hw *hw,
+						    unsigned long parent_rate)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+	unsigned long rate = parent_rate;
+	unsigned int cfg0, cfg1;
+
+	regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
+	regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
+
+	if (cfg1 & TH1520_PLL_BYPASS)
+		return rate;
+
+	do_div(rate, FIELD_GET(TH1520_PLL_POSTDIV1, cfg0) *
+		     FIELD_GET(TH1520_PLL_POSTDIV2, cfg0));
+
+	return rate;
+}
+
+static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	unsigned long rate = parent_rate;
+
+	rate = th1520_pll_vco_recalc_rate(hw, rate);
+	rate = th1520_pll_postdiv_recalc_rate(hw, rate);
+
+	return rate;
+}
+
+static const struct clk_ops clk_pll_ops = {
+	.recalc_rate	= ccu_pll_recalc_rate,
+};
+
+static const struct clk_parent_data osc_24m_clk[] = {
+	{ .index = 0 }
+};
+
+static struct ccu_pll cpu_pll0_clk = {
+	.common		= {
+		.clkid		= CLK_CPU_PLL0,
+		.cfg0		= 0x000,
+		.cfg1		= 0x004,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("cpu-pll0",
+					      osc_24m_clk,
+					      &clk_pll_ops,
+					      0),
+	},
+};
+
+static struct ccu_pll cpu_pll1_clk = {
+	.common		= {
+		.clkid		= CLK_CPU_PLL1,
+		.cfg0		= 0x010,
+		.cfg1		= 0x014,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("cpu-pll1",
+					      osc_24m_clk,
+					      &clk_pll_ops,
+					      0),
+	},
+};
+
+static struct ccu_pll gmac_pll_clk = {
+	.common		= {
+		.clkid		= CLK_GMAC_PLL,
+		.cfg0		= 0x020,
+		.cfg1		= 0x024,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("gmac-pll",
+					      osc_24m_clk,
+					      &clk_pll_ops,
+					      0),
+	},
+};
+
+static const struct clk_hw *gmac_pll_clk_parent[] = {
+	&gmac_pll_clk.common.hw
+};
+
+static const struct clk_parent_data gmac_pll_clk_pd[] = {
+	{ .hw = &gmac_pll_clk.common.hw }
+};
+
+static struct ccu_pll video_pll_clk = {
+	.common		= {
+		.clkid		= CLK_VIDEO_PLL,
+		.cfg0		= 0x030,
+		.cfg1		= 0x034,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("video-pll",
+					      osc_24m_clk,
+					      &clk_pll_ops,
+					      0),
+	},
+};
+
+static const struct clk_hw *video_pll_clk_parent[] = {
+	&video_pll_clk.common.hw
+};
+
+static const struct clk_parent_data video_pll_clk_pd[] = {
+	{ .hw = &video_pll_clk.common.hw }
+};
+
+static struct ccu_pll dpu0_pll_clk = {
+	.common		= {
+		.clkid		= CLK_DPU0_PLL,
+		.cfg0		= 0x040,
+		.cfg1		= 0x044,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("dpu0-pll",
+					      osc_24m_clk,
+					      &clk_pll_ops,
+					      0),
+	},
+};
+
+static const struct clk_hw *dpu0_pll_clk_parent[] = {
+	&dpu0_pll_clk.common.hw
+};
+
+static struct ccu_pll dpu1_pll_clk = {
+	.common		= {
+		.clkid		= CLK_DPU1_PLL,
+		.cfg0		= 0x050,
+		.cfg1		= 0x054,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("dpu1-pll",
+					      osc_24m_clk,
+					      &clk_pll_ops,
+					      0),
+	},
+};
+
+static const struct clk_hw *dpu1_pll_clk_parent[] = {
+	&dpu1_pll_clk.common.hw
+};
+
+static struct ccu_pll tee_pll_clk = {
+	.common		= {
+		.clkid		= CLK_TEE_PLL,
+		.cfg0		= 0x060,
+		.cfg1		= 0x064,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("tee-pll",
+					      osc_24m_clk,
+					      &clk_pll_ops,
+					      0),
+	},
+};
+
+static const struct clk_parent_data c910_i0_parents[] = {
+	{ .hw = &cpu_pll0_clk.common.hw },
+	{ .index = 0 }
+};
+
+struct ccu_mux c910_i0_clk = {
+	.mux	= TH_CCU_ARG(1, 1),
+	.common	= {
+		.clkid		= CLK_C910_I0,
+		.cfg0		= 0x100,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("c910-i0",
+					      c910_i0_parents,
+					      &clk_mux_ops,
+					      0),
+	}
+};
+
+static const struct clk_parent_data c910_parents[] = {
+	{ .hw = &c910_i0_clk.common.hw },
+	{ .hw = &cpu_pll1_clk.common.hw }
+};
+
+struct ccu_mux c910_clk = {
+	.mux	= TH_CCU_ARG(0, 1),
+	.common	= {
+		.clkid		= CLK_C910,
+		.cfg0		= 0x100,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("c910",
+					      c910_parents,
+					      &clk_mux_ops,
+					      0),
+	}
+};
+
+static const struct clk_parent_data ahb2_cpusys_parents[] = {
+	{ .hw = &gmac_pll_clk.common.hw },
+	{ .index = 0 }
+};
+
+static struct ccu_div ahb2_cpusys_hclk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(5, 1),
+	.common		= {
+		.clkid          = CLK_AHB2_CPUSYS_HCLK,
+		.cfg0		= 0x120,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("ahb2-cpusys-hclk",
+						      ahb2_cpusys_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static const struct clk_parent_data ahb2_cpusys_hclk_pd[] = {
+	{ .hw = &ahb2_cpusys_hclk.common.hw }
+};
+
+static const struct clk_hw *ahb2_cpusys_hclk_parent[] = {
+	&ahb2_cpusys_hclk.common.hw,
+};
+
+static struct ccu_div apb3_cpusys_pclk = {
+	.div		= TH_CCU_ARG(0, 3),
+	.common		= {
+		.clkid          = CLK_APB3_CPUSYS_PCLK,
+		.cfg0		= 0x130,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("apb3-cpusys-pclk",
+							   ahb2_cpusys_hclk_parent,
+							   &ccu_div_ops,
+							   0),
+	},
+};
+
+static const struct clk_parent_data apb3_cpusys_pclk_pd[] = {
+	{ .hw = &apb3_cpusys_pclk.common.hw }
+};
+
+static struct ccu_div axi4_cpusys2_aclk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.clkid          = CLK_AXI4_CPUSYS2_ACLK,
+		.cfg0		= 0x134,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("axi4-cpusys2-aclk",
+					      gmac_pll_clk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static const struct clk_parent_data axi4_cpusys2_aclk_pd[] = {
+	{ .hw = &axi4_cpusys2_aclk.common.hw }
+};
+
+static const struct clk_parent_data axi_parents[] = {
+	{ .hw = &video_pll_clk.common.hw },
+	{ .index = 0 }
+};
+
+static struct ccu_div axi_aclk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(5, 1),
+	.common		= {
+		.clkid          = CLK_AXI_ACLK,
+		.cfg0		= 0x138,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("axi-aclk",
+						      axi_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static const struct clk_parent_data axi_aclk_pd[] = {
+	{ .hw = &axi_aclk.common.hw }
+};
+
+static const struct clk_parent_data perisys_ahb_hclk_parents[] = {
+	{ .hw = &gmac_pll_clk.common.hw },
+	{ .index = 0 },
+};
+
+static struct ccu_div perisys_ahb_hclk = {
+	.enable		= BIT(6),
+	.div		= TH_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(5, 1),
+	.common		= {
+		.clkid          = CLK_PERI_AHB_HCLK,
+		.cfg0		= 0x140,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("perisys-ahb-hclk",
+						      perisys_ahb_hclk_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static const struct clk_parent_data perisys_ahb_hclk_pd[] = {
+	{ .hw = &perisys_ahb_hclk.common.hw }
+};
+
+static const struct clk_hw *perisys_ahb_hclk_parent[] = {
+	&perisys_ahb_hclk.common.hw
+};
+
+static struct ccu_div perisys_apb_pclk = {
+	.div		= TH_CCU_ARG(0, 3),
+	.common		= {
+		.clkid          = CLK_PERI_APB_PCLK,
+		.cfg0		= 0x150,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("perisys-apb-pclk",
+					      perisys_ahb_hclk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static const struct clk_parent_data perisys_apb_pclk_pd[] = {
+	{ .hw = &perisys_apb_pclk.common.hw }
+};
+
+static struct ccu_div peri2sys_apb_pclk = {
+	.div		= TH_CCU_DIV_FLAGS(4, 3, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.clkid          = CLK_PERI2APB_PCLK,
+		.cfg0		= 0x150,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("peri2sys-apb-pclk",
+					      gmac_pll_clk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static const struct clk_parent_data peri2sys_apb_pclk_pd[] = {
+	{ .hw = &peri2sys_apb_pclk.common.hw }
+};
+
+static CLK_FIXED_FACTOR_FW_NAME(osc12m_clk, "osc_12m", "osc_24m", 2, 1, 0);
+
+static const char * const out_parents[] = { "osc_24m", "osc_12m" };
+
+static struct ccu_div out1_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(4, 1),
+	.common		= {
+		.clkid          = CLK_OUT1,
+		.cfg0		= 0x1b4,
+		.hw.init	= CLK_HW_INIT_PARENTS("out1",
+						      out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div out2_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(4, 1),
+	.common		= {
+		.clkid          = CLK_OUT2,
+		.cfg0		= 0x1b8,
+		.hw.init	= CLK_HW_INIT_PARENTS("out2",
+						      out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div out3_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(4, 1),
+	.common		= {
+		.clkid          = CLK_OUT3,
+		.cfg0		= 0x1bc,
+		.hw.init	= CLK_HW_INIT_PARENTS("out3",
+						      out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div out4_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(4, 1),
+	.common		= {
+		.clkid          = CLK_OUT4,
+		.cfg0		= 0x1c0,
+		.hw.init	= CLK_HW_INIT_PARENTS("out4",
+						      out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static const struct clk_parent_data apb_parents[] = {
+	{ .hw = &gmac_pll_clk.common.hw },
+	{ .index = 0 },
+};
+
+static struct ccu_div apb_pclk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(7, 1),
+	.common		= {
+		.clkid          = CLK_APB_PCLK,
+		.cfg0		= 0x1c4,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("apb-pclk",
+						      apb_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static const struct clk_hw *npu_parents[] = {
+	&gmac_pll_clk.common.hw,
+	&video_pll_clk.common.hw
+};
+
+static struct ccu_div npu_clk = {
+	.enable		= BIT(4),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(6, 1),
+	.common		= {
+		.clkid          = CLK_NPU,
+		.cfg0		= 0x1c8,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("npu",
+						      npu_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div vi_clk = {
+	.div		= TH_CCU_DIV_FLAGS(16, 4, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.clkid          = CLK_VI,
+		.cfg0		= 0x1d0,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("vi",
+					      video_pll_clk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div vi_ahb_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.clkid          = CLK_VI_AHB,
+		.cfg0		= 0x1d0,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("vi-ahb",
+					      video_pll_clk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div vo_axi_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.clkid          = CLK_VO_AXI,
+		.cfg0		= 0x1dc,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("vo-axi",
+					      video_pll_clk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div vp_apb_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.clkid          = CLK_VP_APB,
+		.cfg0		= 0x1e0,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("vp-apb",
+					      gmac_pll_clk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div vp_axi_clk = {
+	.enable		= BIT(15),
+	.div		= TH_CCU_DIV_FLAGS(8, 4, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.clkid          = CLK_VP_AXI,
+		.cfg0		= 0x1e0,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("vp-axi",
+					      video_pll_clk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div venc_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.clkid          = CLK_VENC,
+		.cfg0		= 0x1e4,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("venc",
+					      gmac_pll_clk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div dpu0_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.clkid          = CLK_DPU0,
+		.cfg0		= 0x1e8,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu0",
+					      dpu0_pll_clk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div dpu1_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.clkid          = CLK_DPU1,
+		.cfg0		= 0x1ec,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu1",
+					      dpu1_pll_clk_parent,
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static CCU_GATE(CLK_BROM, brom_clk, "brom", ahb2_cpusys_hclk_pd, 0x100, BIT(4), 0);
+static CCU_GATE(CLK_BMU, bmu_clk, "bmu", axi4_cpusys2_aclk_pd, 0x100, BIT(5), 0);
+static CCU_GATE(CLK_AON2CPU_A2X, aon2cpu_a2x_clk, "aon2cpu-a2x", axi4_cpusys2_aclk_pd,
+		0x134, BIT(8), 0);
+static CCU_GATE(CLK_X2X_CPUSYS, x2x_cpusys_clk, "x2x-cpusys", axi4_cpusys2_aclk_pd,
+		0x134, BIT(7), 0);
+static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd, 0x138, BIT(8), 0);
+static CCU_GATE(CLK_CPU2PERI_X2H, cpu2peri_x2h_clk, "cpu2peri-x2h", axi4_cpusys2_aclk_pd,
+		0x140, BIT(9), 0);
+static CCU_GATE(CLK_PERISYS_APB1_HCLK, perisys_apb1_hclk, "perisys-apb1-hclk", perisys_ahb_hclk_pd,
+		0x150, BIT(9), 0);
+static CCU_GATE(CLK_PERISYS_APB2_HCLK, perisys_apb2_hclk, "perisys-apb2-hclk", perisys_ahb_hclk_pd,
+		0x150, BIT(10), 0);
+static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3_hclk, "perisys-apb3-hclk", perisys_ahb_hclk_pd,
+		0x150, BIT(11), 0);
+static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-hclk", perisys_ahb_hclk_pd,
+		0x150, BIT(12), 0);
+static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), 0);
+static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, BIT(13), 0);
+static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", video_pll_clk_pd, 0x204, BIT(30), 0);
+static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, BIT(26), 0);
+static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk_pd, 0x204, BIT(24), 0);
+static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_pd, 0x204, BIT(23), 0);
+static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb_pclk_pd, 0x204, BIT(22), 0);
+static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi", axi4_cpusys2_aclk_pd, 0x204, BIT(21), 0);
+static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk", peri2sys_apb_pclk_pd, 0x204, BIT(20), 0);
+static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd, 0x204, BIT(19), 0);
+static CCU_GATE(CLK_PWM, pwm_clk, "pwm", perisys_apb_pclk_pd, 0x204, BIT(18), 0);
+static CCU_GATE(CLK_QSPI0, qspi0_clk, "qspi0", video_pll_clk_pd, 0x204, BIT(17), 0);
+static CCU_GATE(CLK_QSPI1, qspi1_clk, "qspi1", video_pll_clk_pd, 0x204, BIT(16), 0);
+static CCU_GATE(CLK_SPI, spi_clk, "spi", video_pll_clk_pd, 0x204, BIT(15), 0);
+static CCU_GATE(CLK_UART0_PCLK, uart0_pclk, "uart0-pclk", perisys_apb_pclk_pd, 0x204, BIT(14), 0);
+static CCU_GATE(CLK_UART1_PCLK, uart1_pclk, "uart1-pclk", perisys_apb_pclk_pd, 0x204, BIT(13), 0);
+static CCU_GATE(CLK_UART2_PCLK, uart2_pclk, "uart2-pclk", perisys_apb_pclk_pd, 0x204, BIT(12), 0);
+static CCU_GATE(CLK_UART3_PCLK, uart3_pclk, "uart3-pclk", perisys_apb_pclk_pd, 0x204, BIT(11), 0);
+static CCU_GATE(CLK_UART4_PCLK, uart4_pclk, "uart4-pclk", perisys_apb_pclk_pd, 0x204, BIT(10), 0);
+static CCU_GATE(CLK_UART5_PCLK, uart5_pclk, "uart5-pclk", perisys_apb_pclk_pd, 0x204, BIT(9), 0);
+static CCU_GATE(CLK_GPIO0, gpio0_clk, "gpio0-clk", perisys_apb_pclk_pd, 0x204, BIT(8), 0);
+static CCU_GATE(CLK_GPIO1, gpio1_clk, "gpio1-clk", perisys_apb_pclk_pd, 0x204, BIT(7), 0);
+static CCU_GATE(CLK_GPIO2, gpio2_clk, "gpio2-clk", peri2sys_apb_pclk_pd, 0x204, BIT(6), 0);
+static CCU_GATE(CLK_I2C0, i2c0_clk, "i2c0", perisys_apb_pclk_pd, 0x204, BIT(5), 0);
+static CCU_GATE(CLK_I2C1, i2c1_clk, "i2c1", perisys_apb_pclk_pd, 0x204, BIT(4), 0);
+static CCU_GATE(CLK_I2C2, i2c2_clk, "i2c2", perisys_apb_pclk_pd, 0x204, BIT(3), 0);
+static CCU_GATE(CLK_I2C3, i2c3_clk, "i2c3", perisys_apb_pclk_pd, 0x204, BIT(2), 0);
+static CCU_GATE(CLK_I2C4, i2c4_clk, "i2c4", perisys_apb_pclk_pd, 0x204, BIT(1), 0);
+static CCU_GATE(CLK_I2C5, i2c5_clk, "i2c5", perisys_apb_pclk_pd, 0x204, BIT(0), 0);
+static CCU_GATE(CLK_SPINLOCK, spinlock_clk, "spinlock", ahb2_cpusys_hclk_pd, 0x208, BIT(10), 0);
+static CCU_GATE(CLK_DMA, dma_clk, "dma", axi4_cpusys2_aclk_pd, 0x208, BIT(8), 0);
+static CCU_GATE(CLK_MBOX0, mbox0_clk, "mbox0", apb3_cpusys_pclk_pd, 0x208, BIT(7), 0);
+static CCU_GATE(CLK_MBOX1, mbox1_clk, "mbox1", apb3_cpusys_pclk_pd, 0x208, BIT(6), 0);
+static CCU_GATE(CLK_MBOX2, mbox2_clk, "mbox2", apb3_cpusys_pclk_pd, 0x208, BIT(5), 0);
+static CCU_GATE(CLK_MBOX3, mbox3_clk, "mbox3", apb3_cpusys_pclk_pd, 0x208, BIT(4), 0);
+static CCU_GATE(CLK_WDT0, wdt0_clk, "wdt0", apb3_cpusys_pclk_pd, 0x208, BIT(3), 0);
+static CCU_GATE(CLK_WDT1, wdt1_clk, "wdt1", apb3_cpusys_pclk_pd, 0x208, BIT(2), 0);
+static CCU_GATE(CLK_TIMER0, timer0_clk, "timer0", apb3_cpusys_pclk_pd, 0x208, BIT(1), 0);
+static CCU_GATE(CLK_TIMER1, timer1_clk, "timer1", apb3_cpusys_pclk_pd, 0x208, BIT(0), 0);
+static CCU_GATE(CLK_SRAM0, sram0_clk, "sram0", axi_aclk_pd, 0x20c, BIT(4), 0);
+static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
+static CCU_GATE(CLK_SRAM2, sram2_clk, "sram2", axi_aclk_pd, 0x20c, BIT(2), 0);
+static CCU_GATE(CLK_SRAM3, sram3_clk, "sram3", axi_aclk_pd, 0x20c, BIT(1), 0);
+
+static CLK_FIXED_FACTOR_HW(gmac_pll_clk_100m, "gmac-pll-clk-100m",
+			   &gmac_pll_clk.common.hw, 10, 1, 0);
+
+static const struct clk_parent_data uart_sclk_parents[] = {
+	{ .hw = &gmac_pll_clk_100m.hw },
+	{ .index = 0 },
+};
+
+struct ccu_mux uart_sclk = {
+	.mux	= TH_CCU_ARG(0, 1),
+	.common	= {
+		.clkid          = CLK_UART_SCLK,
+		.cfg0		= 0x210,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("uart-sclk",
+					      uart_sclk_parents,
+					      &clk_mux_ops,
+					      0),
+	}
+};
+
+static struct ccu_common *th1520_pll_clks[] = {
+	&cpu_pll0_clk.common,
+	&cpu_pll1_clk.common,
+	&gmac_pll_clk.common,
+	&video_pll_clk.common,
+	&dpu0_pll_clk.common,
+	&dpu1_pll_clk.common,
+	&tee_pll_clk.common,
+};
+
+static struct ccu_common *th1520_div_clks[] = {
+	&ahb2_cpusys_hclk.common,
+	&apb3_cpusys_pclk.common,
+	&axi4_cpusys2_aclk.common,
+	&perisys_ahb_hclk.common,
+	&perisys_apb_pclk.common,
+	&axi_aclk.common,
+	&peri2sys_apb_pclk.common,
+	&out1_clk.common,
+	&out2_clk.common,
+	&out3_clk.common,
+	&out4_clk.common,
+	&apb_pclk.common,
+	&npu_clk.common,
+	&vi_clk.common,
+	&vi_ahb_clk.common,
+	&vo_axi_clk.common,
+	&vp_apb_clk.common,
+	&vp_axi_clk.common,
+	&cpu2vp_clk.common,
+	&venc_clk.common,
+	&dpu0_clk.common,
+	&dpu1_clk.common,
+};
+
+static struct ccu_common *th1520_mux_clks[] = {
+	&c910_i0_clk.common,
+	&c910_clk.common,
+	&uart_sclk.common,
+};
+
+static struct ccu_common *th1520_gate_clks[] = {
+	&emmc_sdio_clk.common,
+	&aon2cpu_a2x_clk.common,
+	&x2x_cpusys_clk.common,
+	&brom_clk.common,
+	&bmu_clk.common,
+	&cpu2aon_x2h_clk.common,
+	&cpu2peri_x2h_clk.common,
+	&perisys_apb1_hclk.common,
+	&perisys_apb2_hclk.common,
+	&perisys_apb3_hclk.common,
+	&perisys_apb4_hclk.common,
+	&npu_axi_clk.common,
+	&gmac1_clk.common,
+	&padctrl1_clk.common,
+	&dsmart_clk.common,
+	&padctrl0_clk.common,
+	&gmac_axi_clk.common,
+	&gpio3_clk.common,
+	&gmac0_clk.common,
+	&pwm_clk.common,
+	&qspi0_clk.common,
+	&qspi1_clk.common,
+	&spi_clk.common,
+	&uart0_pclk.common,
+	&uart1_pclk.common,
+	&uart2_pclk.common,
+	&uart3_pclk.common,
+	&uart4_pclk.common,
+	&uart5_pclk.common,
+	&gpio0_clk.common,
+	&gpio1_clk.common,
+	&gpio2_clk.common,
+	&i2c0_clk.common,
+	&i2c1_clk.common,
+	&i2c2_clk.common,
+	&i2c3_clk.common,
+	&i2c4_clk.common,
+	&i2c5_clk.common,
+	&spinlock_clk.common,
+	&dma_clk.common,
+	&mbox0_clk.common,
+	&mbox1_clk.common,
+	&mbox2_clk.common,
+	&mbox3_clk.common,
+	&wdt0_clk.common,
+	&wdt1_clk.common,
+	&timer0_clk.common,
+	&timer1_clk.common,
+	&sram0_clk.common,
+	&sram1_clk.common,
+	&sram2_clk.common,
+	&sram3_clk.common,
+};
+
+#define NR_CLKS	(CLK_UART_SCLK + 1)
+
+static const struct regmap_config th1520_clk_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+};
+
+static int th1520_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct clk_hw_onecell_data *priv;
+
+	struct regmap *map;
+	void __iomem *base;
+	struct clk_hw *hw;
+	int ret, i;
+
+	priv = devm_kzalloc(dev, struct_size(priv, hws, NR_CLKS), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->num = NR_CLKS;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	map = devm_regmap_init_mmio(dev, base, &th1520_clk_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	for (i = 0; i < ARRAY_SIZE(th1520_pll_clks); i++) {
+		struct ccu_pll *cp = hw_to_ccu_pll(&th1520_pll_clks[i]->hw);
+
+		th1520_pll_clks[i]->map = map;
+
+		ret = devm_clk_hw_register(dev, &th1520_pll_clks[i]->hw);
+		if (ret)
+			return ret;
+
+		priv->hws[cp->common.clkid] = &cp->common.hw;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(th1520_div_clks); i++) {
+		struct ccu_div *cd = hw_to_ccu_div(&th1520_div_clks[i]->hw);
+
+		th1520_div_clks[i]->map = map;
+
+		ret = devm_clk_hw_register(dev, &th1520_div_clks[i]->hw);
+		if (ret)
+			return ret;
+
+		priv->hws[cd->common.clkid] = &cd->common.hw;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(th1520_mux_clks); i++) {
+		struct ccu_mux *cm = hw_to_ccu_mux(&th1520_mux_clks[i]->hw);
+		const struct clk_init_data *init = cm->common.hw.init;
+
+		th1520_mux_clks[i]->map = map;
+		hw = devm_clk_hw_register_mux_parent_data_table(dev,
+								init->name,
+								init->parent_data,
+								init->num_parents,
+								0,
+								base + cm->common.cfg0,
+								cm->mux.shift,
+								cm->mux.width,
+								0, NULL, NULL);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		priv->hws[cm->common.clkid] = hw;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(th1520_gate_clks); i++) {
+		struct ccu_gate *cg = hw_to_ccu_gate(&th1520_gate_clks[i]->hw);
+
+		th1520_gate_clks[i]->map = map;
+
+		hw = devm_clk_hw_register_gate_parent_data(dev,
+							   cg->common.hw.init->name,
+							   cg->common.hw.init->parent_data,
+							   0, base + cg->common.cfg0,
+							   ffs(cg->enable) - 1, 0, NULL);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		priv->hws[cg->common.clkid] = hw;
+	}
+
+	ret = devm_clk_hw_register(dev, &osc12m_clk.hw);
+	if (ret)
+		return ret;
+	priv->hws[CLK_OSC12M] = &osc12m_clk.hw;
+
+	ret = devm_clk_hw_register(dev, &gmac_pll_clk_100m.hw);
+	if (ret)
+		return ret;
+	priv->hws[CLK_PLL_GMAC_100M] = &gmac_pll_clk_100m.hw;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, priv);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id th1520_clk_match[] = {
+	{
+		.compatible = "thead,th1520-clk-ap",
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, th1520_clk_match);
+
+static struct platform_driver th1520_clk_driver = {
+	.probe		= th1520_clk_probe,
+	.driver		= {
+		.name	= "th1520-clk",
+		.of_match_table = th1520_clk_match,
+	},
+};
+module_platform_driver(th1520_clk_driver);
+
+MODULE_DESCRIPTION("T-HEAD TH1520 AP Clock driver");
+MODULE_AUTHOR("Yangtao Li <frank.li@vivo.com>");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_LICENSE("GPL");

-- 
2.40.1


