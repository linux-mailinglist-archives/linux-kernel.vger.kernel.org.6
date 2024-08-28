Return-Path: <linux-kernel+bounces-304442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF49962019
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F341C22F51
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906E2159571;
	Wed, 28 Aug 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgcVzFKd"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854B158A33;
	Wed, 28 Aug 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724828127; cv=none; b=nqrkmEic1bvRpa+1gj8Z3bFBJgWY1ZzfMQCfeFLlrZ4BQvuYNTOnEN7c67lMbs+AJ7UGn+LIVCDRT4PFyl/HKU4oXwIZaO7b/bkE1ttE1bTlSUQCl2EIZNf/FkcaKBLQfhxztuqrdAcT7CKoLN95PflDpGZuqjdy2yItFiDy3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724828127; c=relaxed/simple;
	bh=X+Zlzzvo70dibkz0HZksmGAgBAf5Kz9+21ynUcLxnMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Quv/aTVGEdooLBMlqtFAieS1AYpVgizR7OnuXC0hpnLqj0adlH/LMxkcd4ZoPcqzJt1CYI7pBusvkYdEBMaFCdXtM7WVTWdVuOk+ZTUnpcAboFiqn2feksYmAUz31l0AoHvYh39fVMMY+P8mkdFtwDEveH+4r+iUoy784Jsr3go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgcVzFKd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2020ac89cabso58868705ad.1;
        Tue, 27 Aug 2024 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724828125; x=1725432925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADaFrHDK9ZOzAQCFKsnssz1RoZQI/sdKuq5QgfmMJBo=;
        b=hgcVzFKd1gPIUoXS46TWmbgVC8A8BEN0s/7BXc0ypXu8bQzZies4XP4TSXByf3cS01
         c02DAvL/gfIZDpH3ZUyFIUD/IVE1Q5zsPQJHQR/t9jeZakFCuFm0QR/CkS4sqIJP3x5+
         zsXK4PWiyQE69kzIBhtKaQ1pk/mab+1YjF3fuKr6MLlweI1eHEhqaWl14wsvNUN8/ahT
         WOFhGR0O0F9ie68ZNcpD8+GHxCQP6ww6GGu1Kxk87H3R6fCsUYcP7ElW/sAlXhFCPhTi
         znUOAplcz9fRbvj+/q62eTByslfSgHRiMJgkEcHZL3gMDXDUYptElztwZGwjHEgflnqU
         +TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724828125; x=1725432925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADaFrHDK9ZOzAQCFKsnssz1RoZQI/sdKuq5QgfmMJBo=;
        b=oNBvJQHEdA8nXaxcovACpA8tEBqwgbI17TV52hwBWCs0+pLSxrD/sSHddl/dUaoAJx
         VN24fL0BzZoQ8mtkTCK5+KK9bpN0X7JvWF17yvF+9LjbXiO7llC9R9nQeVJ8JueGNaoN
         YIQi5FvunFKRSfky+ght4UoWePv7EJ7UAwAeHFoyqpU2HmqBkbpaOvAtqdbvOxM8mXDD
         N/kVFpTQIxLYLmXpa4Oo49TUN/hEKTHn2hBeOebbMPQHsNNZsVg5T6DPbgHGebWeAq15
         A8SbKZY4Fdlx7FbhuLAwkhdr03BI0DflDbjfDyA3Y7gmyjr0y370pA3YeskVBwxKD6lp
         IgiA==
X-Forwarded-Encrypted: i=1; AJvYcCU9UnICy3GR8yyppYsQemLBErfq8L25u9w6aQcN+2xhwgp7TuNzm2MzfFF55Fo/G0mRSA+iwCHnEao=@vger.kernel.org, AJvYcCXvWJ/Ei/K/Y0MBoIy9ebaxUQ0ZVyPMNuM71BI2hVPUlbnGzKjy9iPRZ48TPN+OSUluBkNOXSXlVlJRKRvI@vger.kernel.org
X-Gm-Message-State: AOJu0YybusZ/HYlzQz4Lqu7n6VNnXy/CeWyhx11ltpsquACAsv2ZpWfT
	1iqTXloe52KO1il8F0a7AwEaFCwChllvkHjzuQ6OIDKCU4a1jU/De8pDImmH
X-Google-Smtp-Source: AGHT+IF4i+BjBUycmBUoKtnssqJR+p5OnuLE/Jpi6Rk+k1EXgavhtDmvGzw4sUvLwFCHusYKmK+ctg==
X-Received: by 2002:a17:902:c946:b0:202:4464:c5f3 with SMTP id d9443c01a7336-2039e4f6368mr146874035ad.52.1724828125157;
        Tue, 27 Aug 2024 23:55:25 -0700 (PDT)
Received: from m91p.airy.home ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385607f94sm92816005ad.182.2024.08.27.23.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:55:24 -0700 (PDT)
From: Bo Gan <ganboing@gmail.com>
To: zong.li@sifive.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Pragnesh.patel@sifive.com,
	aou@eecs.berkeley.edu,
	erik.danie@sifive.com,
	hes@sifive.com,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	palmerdabbelt@google.com,
	paul.walmsley@sifive.com,
	pragnesh.patel@openfive.com,
	sboyd@kernel.org,
	schwab@linux-m68k.org,
	yash.shah@sifive.com
Subject: [PATCH 3/3] clk: sifive: prci: Add release_reset hooks for gemgxlpll/cltxpll
Date: Tue, 27 Aug 2024 23:55:20 -0700
Message-Id: <e47b943c0f685cd028ebd477e97e1706f184a7b6.1724827635.git.ganboing@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724827635.git.ganboing@gmail.com>
References: <cover.1724827635.git.ganboing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the release_reset hook interface to __prci_wrpll_data.
During clock enablement, the function (if present) will be called after PLL
registers are configured. It aligns the logic to the driver in u-boot. When
there's a previous bootloader stage, such as u-boot, it usually enables the
gemgxlpll clock when trying to PXE/network boot. The kernel boots fine, but
we should not depend on it being our previous stage, and the logic within:

 a. We (linux) can get directly invoked by firmware (OpenSBI).
 b. U-boot doesn't necessarily have to initialize ethernet and enable the
    clock (when not enabled in CONFIG).

When the kernel is the first to initialize gemgxlpll, it must also release
the corresponding reset. Otherwise the chip will just hang during macb
initialization, and even external JTAG debugger will lose control over the
risc-v debug module. (Observed with my Sifive Unmatched Rev.B board)

The patch took the dt-bindings and logics directly from u-boot with some
additional modifications:
 - Use __prci_writel after __prci_readl to have barrier semantic. U-boot
   has the strong version of readl/writel, but linux has the relaxed ones.
 - Use pd->reset.rcdev.ops to access the reset regs.
 - Split reset bindings for FU540/FU740 and use them directly, instead of
   looking it up through reset-names.

Signed-off-by: Bo Gan <ganboing@gmail.com>
---
 drivers/clk/sifive/fu540-prci.h  | 16 ++++++++++++++++
 drivers/clk/sifive/fu740-prci.h  | 31 +++++++++++++++++++++++++++++++
 drivers/clk/sifive/sifive-prci.c | 23 +++++++++++++++++++++++
 drivers/clk/sifive/sifive-prci.h |  8 ++++++++
 4 files changed, 78 insertions(+)

diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-prci.h
index e0173324f3c5..9d2ca18f47a4 100644
--- a/drivers/clk/sifive/fu540-prci.h
+++ b/drivers/clk/sifive/fu540-prci.h
@@ -23,9 +23,24 @@
 #include <linux/module.h>
 
 #include <dt-bindings/clock/sifive-fu540-prci.h>
+#include <dt-bindings/reset/sifive-fu540-prci.h>
 
 #include "sifive-prci.h"
 
+/**
+ * sifive_fu540_prci_ethernet_release_reset() - Release ethernet reset
+ * @pd: struct __prci_data * for the PRCI containing the Ethernet CLK mux reg
+ *
+ */
+static void sifive_fu540_prci_ethernet_release_reset(struct __prci_data *pd)
+{
+	/* Release GEMGXL reset */
+	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU540_PRCI_RST_GEMGXL_N);
+
+	/* Procmon => core clock */
+	sifive_prci_set_procmoncfg(pd, PRCI_PROCMONCFG_CORE_CLOCK_MASK);
+}
+
 /* PRCI integration data for each WRPLL instance */
 
 static struct __prci_wrpll_data sifive_fu540_prci_corepll_data = {
@@ -43,6 +58,7 @@ static struct __prci_wrpll_data sifive_fu540_prci_ddrpll_data = {
 static struct __prci_wrpll_data sifive_fu540_prci_gemgxlpll_data = {
 	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
+	.release_reset = sifive_fu540_prci_ethernet_release_reset,
 };
 
 /* Linux clock framework integration */
diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-prci.h
index f31cd30fc395..dd0f54277a99 100644
--- a/drivers/clk/sifive/fu740-prci.h
+++ b/drivers/clk/sifive/fu740-prci.h
@@ -10,9 +10,38 @@
 #include <linux/module.h>
 
 #include <dt-bindings/clock/sifive-fu740-prci.h>
+#include <dt-bindings/reset/sifive-fu740-prci.h>
 
 #include "sifive-prci.h"
 
+/**
+ * sifive_fu740_prci_ethernet_release_reset() - Release ethernet reset
+ * @pd: struct __prci_data * for the PRCI containing the Ethernet CLK mux reg
+ *
+ */
+static void sifive_fu740_prci_ethernet_release_reset(struct __prci_data *pd)
+{
+	/* Release GEMGXL reset */
+	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU740_PRCI_RST_GEMGXL_N);
+
+	/* Procmon => core clock */
+	sifive_prci_set_procmoncfg(pd, PRCI_PROCMONCFG_CORE_CLOCK_MASK);
+
+	/* Release Chiplink reset */
+	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU740_PRCI_RST_CLTX_N);
+}
+
+/**
+ * sifive_fu740_prci_cltx_release_reset() - Release cltx reset
+ * @pd: struct __prci_data * for the PRCI containing the Ethernet CLK mux reg
+ *
+ */
+static void sifive_fu740_prci_cltx_release_reset(struct __prci_data *pd)
+{
+	/* Release CLTX reset */
+	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU740_PRCI_RST_CLTX_N);
+}
+
 /* PRCI integration data for each WRPLL instance */
 
 static struct __prci_wrpll_data sifive_fu740_prci_corepll_data = {
@@ -30,6 +59,7 @@ static struct __prci_wrpll_data sifive_fu740_prci_ddrpll_data = {
 static struct __prci_wrpll_data sifive_fu740_prci_gemgxlpll_data = {
 	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
+	.release_reset = sifive_fu740_prci_ethernet_release_reset,
 };
 
 static struct __prci_wrpll_data sifive_fu740_prci_dvfscorepll_data = {
@@ -49,6 +79,7 @@ static struct __prci_wrpll_data sifive_fu740_prci_hfpclkpll_data = {
 static struct __prci_wrpll_data sifive_fu740_prci_cltxpll_data = {
 	.cfg0_offs = PRCI_CLTXPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_CLTXPLLCFG1_OFFSET,
+	.release_reset = sifive_fu740_prci_cltx_release_reset,
 };
 
 /* Linux clock framework integration */
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index caba0400f8a2..ae8055a84466 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -249,6 +249,9 @@ int sifive_prci_clock_enable(struct clk_hw *hw)
 	if (pwd->disable_bypass)
 		pwd->disable_bypass(pd);
 
+	if (pwd->release_reset)
+		pwd->release_reset(pd);
+
 	return 0;
 }
 
@@ -448,6 +451,26 @@ void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd)
 	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);	/* barrier */
 }
 
+/*
+ * PROCMONCFG
+ */
+
+/**
+ * sifive_prci_set_procmoncfg() - set PROCMONCFG
+ * @pd: struct __prci_data * PRCI context
+ * @val: u32 value to write to PROCMONCFG register
+ *
+ * Set the PROCMONCFG register to @val
+ *
+ * Context: Any context.  Caller must prevent concurrent changes to the
+ *          PROCMONCFG_OFFSET register.
+ */
+void sifive_prci_set_procmoncfg(struct __prci_data *pd, u32 val)
+{
+	__prci_writel(val, PRCI_PROCMONCFG_OFFSET, pd);
+	__prci_readl(pd, PRCI_PROCMONCFG_OFFSET);	/* barrier */
+}
+
 /* PCIE AUX clock APIs for enable, disable. */
 int sifive_prci_pcie_aux_clock_is_enabled(struct clk_hw *hw)
 {
diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index 91658a88af4e..825a0aef9fd5 100644
--- a/drivers/clk/sifive/sifive-prci.h
+++ b/drivers/clk/sifive/sifive-prci.h
@@ -210,6 +210,9 @@
 
 /* PROCMONCFG */
 #define PRCI_PROCMONCFG_OFFSET			0xf0
+#define PRCI_PROCMONCFG_CORE_CLOCK_SHIFT	24
+#define PRCI_PROCMONCFG_CORE_CLOCK_MASK					\
+		(0x1 << PRCI_PROCMONCFG_CORE_CLOCK_SHIFT)
 
 /*
  * Private structures
@@ -235,6 +238,7 @@ struct __prci_data {
  * @disable_bypass: fn ptr to code to not bypass the WRPLL (or NULL)
  * @cfg0_offs: WRPLL CFG0 register offset (in bytes) from the PRCI base address
  * @cfg1_offs: WRPLL CFG1 register offset (in bytes) from the PRCI base address
+ * @release_reset: fn ptr to code to release clock reset
  *
  * @enable_bypass and @disable_bypass are used for WRPLL instances
  * that contain a separate external glitchless clock mux downstream
@@ -246,6 +250,7 @@ struct __prci_wrpll_data {
 	void (*disable_bypass)(struct __prci_data *pd);
 	u8 cfg0_offs;
 	u8 cfg1_offs;
+	void (*release_reset)(struct __prci_data *pd);
 };
 
 /**
@@ -290,6 +295,9 @@ void sifive_prci_corepllsel_use_corepll(struct __prci_data *pd);
 void sifive_prci_hfpclkpllsel_use_hfclk(struct __prci_data *pd);
 void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd);
 
+/* PROCMONCFG */
+void sifive_prci_set_procmoncfg(struct __prci_data *pd, u32 val);
+
 /* Linux clock framework integration */
 long sifive_prci_wrpll_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *parent_rate);
-- 
2.34.1


