Return-Path: <linux-kernel+bounces-447033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3904A9F2C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494421883F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E460202F67;
	Mon, 16 Dec 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mj0ldfGt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCB202F76
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338962; cv=none; b=gqzNvW98dnGiY/fzPvfR1S/DA2xYCGRox5dp5LaREe/HwKgrSG2BGLx13usPftSJlOA+aOiITMOR6TLhC9CKSXAOmU9E6MN0V/PGS3/0jH0BGJuW/QNq1YpAm9i/sRBP74RXW6TWRrjJK4OR16S6mFYT+7EOb1O9STBsV61IoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338962; c=relaxed/simple;
	bh=/UF8TiQXVCsue1KxAxeJnKAEsyyiKBXFs5IHFbhoBJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tv9gIcMxQ2NUpOgyALNwWOiRWsyIj1XSjNhVFd7/sIPHnmFqjju6t7itPXFVlVivH1+U2KqAWs5yDfsww4Qfk4rj3bd3zlpvhZXLVJyaPIIVqiw1ESIWa2NXO+DqiZbLsnZ+4Dg8KsWdeARE/RX+FA5bwamariPZh+umDt97ubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mj0ldfGt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21636268e43so46754565ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734338958; x=1734943758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8G2lzEGjyvQfBOtKRNxuvBVMdlmwHVHFBZ16sXaD00=;
        b=mj0ldfGtDLILfWpC+uquMo+pGlgUUfg2OT510Cntbnq+r33WcWjuFxJ9/+2Zih2UNo
         CVojqrLoZsstByO3wkvfCD3M0NxxUeVtrAy/G45nSTxKsRJ7J19zJl1zAJJyqiDVUz76
         kLzy174vbE1Wr1UNBe8HZSbWOIo35iiIhcOnCCoV34s+h1G3wfLcE5gkomc6uSTVxjXS
         FtU2GOreimk4w4mkL3ERKaiIgTNNODGbq7brpHfg8U4GnygYgcWrr0SrmUQCh0qb0ZWp
         0zbvFj19fdW8Lk1yaiw+7RMOc5hCkw8kr3w4g0mDohU+FJ70d/hCrh35U87CGqpKS7o0
         F+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338958; x=1734943758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8G2lzEGjyvQfBOtKRNxuvBVMdlmwHVHFBZ16sXaD00=;
        b=KHoKbq9VFJPz82oHucwn9NJoBjAWQT+1mkEKf3Fuldpq7Xow218k5HN1WgwNBkrb3L
         WoF5jUCZkaaU4ADXf3oYlAFE22KeXsDe/7kU8k8hMoP25WLelBgCaDrEFvSxpEu+xtq7
         DEVqOCAG7z44/GhYPC497vAkGZoRGeo65smPYEBdRgKf1S85Tligo0Eqlpo7dxxBKFwi
         FNA2gICS6/LP//tJ7pEf3VL4D9wZ+JWXx6NdhEPptHYeFm9DW36vyfJxSN8XQNCbzuet
         DgYr7N0Ybycmah1nhqxphEcx3OIe/wm3zseew3dK343GVXr/WpmmuM1o6XhFtWMyfyMj
         l+6w==
X-Forwarded-Encrypted: i=1; AJvYcCU3eZEJXQzyq7sO4JQcTn8R7DwMnIEuie17qKUiXoTfhjXL9TGaRABk/XdUmXo06X+0z6xXBtrzEpvTxBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlu4P4gWa5AQhfa22V8hxfI55qbekoppVGRBnNn3cN9Wqiqm0q
	Ns6auvpLu/xq7P9W55e01OWNpBrkiSVRUxDbKD3O5YIVrxr/lB3ur8ZmtCbopbE=
X-Gm-Gg: ASbGncvevkENDgV2Zl97m57TRyaTBBelPosIWNI0W3cgcauBdCPEEvOx6+64t+Hqi1n
	A51GlJo18t7h9Msfs9YtF7L6I1QdbNDezb85k6g3RqRCkUzu3gisML3ua1Obrd2n9PFdZb7hJu3
	KkKRYc5sh8wwO5yUP1dvFhNVPVkxkwnvPDd2WpdSeh4W5bwtSLj0p5V+bR5klWs9ceKfpuiHjbt
	Rqglh2x8tUTEaFfA5WA9gw0lV4agEAYQq4CYLSZ9oVscVdpgpnzgb0SfQ1OMM2grDLaMlCmwhPl
	eVoI1FqsB7679yE=
X-Google-Smtp-Source: AGHT+IHqn9ZmkW3LZkTPkj+m1MCblgpPi2UZ8N8AVafYCTqx9Ty092XKkAQdDnczRdakBEOnQSMMbQ==
X-Received: by 2002:a17:902:ea0e:b0:216:5e6e:68cb with SMTP id d9443c01a7336-218929a1ec5mr136515605ad.16.1734338958456;
        Mon, 16 Dec 2024 00:49:18 -0800 (PST)
Received: from localhost.localdomain ([223.185.130.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e501d0sm37711495ad.116.2024.12.16.00.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:49:17 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [RFC PATCH 8/8] clk: Add clock driver for the RISC-V RPMI clock service group
Date: Mon, 16 Dec 2024 14:18:17 +0530
Message-ID: <20241216084817.373131-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216084817.373131-1-apatel@ventanamicro.com>
References: <20241216084817.373131-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Pathak <rpathak@ventanamicro.com>

The RPMI specification defines a clock service group which can be
accessed via SBI MPXY extension or dedicated S-mode RPMI transport.

Add mailbox client based clock driver for the RISC-V RPMI clock
service group.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Rahul Pathak <rpathak@ventanamicro.com>
---
 drivers/clk/Kconfig                        |   8 +
 drivers/clk/Makefile                       |   1 +
 drivers/clk/clk-rpmi.c                     | 588 +++++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h |  16 +
 4 files changed, 613 insertions(+)
 create mode 100644 drivers/clk/clk-rpmi.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 713573b6c86c..874cea2ab21c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -493,6 +493,14 @@ config COMMON_CLK_SP7021
 	  Not all features of the PLL are currently supported
 	  by the driver.
 
+config COMMON_CLK_RPMI
+	tristate "Clock driver based on RISC-V RPMI"
+	depends on MAILBOX || COMPILE_TEST
+	default RISCV
+	help
+	  Support for clocks based on the clock service group defined by
+	  the RISC-V platform management interface (RPMI) specification.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index bf4bd45adc3a..95ef59e439bf 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_COMMON_CLK_VC5)		+= clk-versaclock5.o
 obj-$(CONFIG_COMMON_CLK_VC7)		+= clk-versaclock7.o
 obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
 obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
+obj-$(CONFIG_COMMON_CLK_RPMI)		+= clk-rpmi.o
 
 # please keep this section sorted lexicographically by directory path name
 obj-y					+= actions/
diff --git a/drivers/clk/clk-rpmi.c b/drivers/clk/clk-rpmi.c
new file mode 100644
index 000000000000..ed8e32527d3d
--- /dev/null
+++ b/drivers/clk/clk-rpmi.c
@@ -0,0 +1,588 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V MPXY Based Clock Driver
+ *
+ * Copyright (C) 2024 Ventana Micro Systems Ltd.
+ */
+
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/clk-provider.h>
+
+#define RPMI_CLK_MAX_NUM_RATES		16
+#define RPMI_CLK_NAME_LEN		16
+
+#define GET_RATE_LO_U32(rate_u64)	((u32)rate_u64)
+#define GET_RATE_HI_U32(rate_u64)	((u32)((u64)(rate_u64) >> 32))
+#define GET_RATE_U64(hi_u32, lo_u32)	((u64)(hi_u32) << 32 | (lo_u32))
+
+enum rpmi_clk_config {
+	RPMI_CLK_DISABLE = 0,
+	RPMI_CLK_ENABLE = 1,
+};
+
+enum rpmi_clk_type {
+	RPMI_CLK_DISCRETE = 0,
+	RPMI_CLK_LINEAR = 1,
+	RPMI_CLK_TYPE_MAX_IDX,
+};
+
+struct rpmi_clk_context {
+	struct device *dev;
+	struct mbox_chan *chan;
+	struct mbox_client client;
+};
+
+union rpmi_clk_rate {
+	struct {
+		u32 lo;
+		u32 hi;
+	} discrete[RPMI_CLK_MAX_NUM_RATES];
+	struct {
+		u32 min_lo;
+		u32 min_hi;
+		u32 max_lo;
+		u32 max_hi;
+		u32 step_lo;
+		u32 step_hi;
+	} linear;
+};
+
+union rpmi_clk_rates {
+	u64 discrete[RPMI_CLK_MAX_NUM_RATES];
+	struct {
+		u64 min;
+		u64 max;
+		u64 step;
+	} linear;
+};
+
+struct rpmi_clk {
+	struct rpmi_clk_context *context;
+	u32 id;
+	u32 num_rates;
+	u32 transition_latency;
+	enum rpmi_clk_type type;
+	union rpmi_clk_rates *rates;
+	char name[RPMI_CLK_NAME_LEN];
+	struct clk_hw hw;
+};
+
+#define to_rpmi_clk(clk)	container_of(clk, struct rpmi_clk, hw)
+
+struct rpmi_get_num_clocks_rx {
+	s32 status;
+	u32 num_clocks;
+};
+
+struct rpmi_get_attrs_tx {
+	u32 clkid;
+};
+
+struct rpmi_get_attrs_rx {
+	s32 status;
+	u32 flags;
+	u32 num_rates;
+	u32 transition_latency;
+	char name[RPMI_CLK_NAME_LEN];
+};
+
+struct rpmi_get_supp_rates_tx {
+	u32 clkid;
+	u32 clk_rate_idx;
+};
+
+struct rpmi_get_supp_rates_rx {
+	u32 status;
+	u32 flags;
+	u32 remaining;
+	u32 returned;
+	union rpmi_clk_rate rates;
+};
+
+struct rpmi_get_rate_tx {
+	u32 clkid;
+};
+
+struct rpmi_get_rate_rx {
+	u32 status;
+	u32 lo;
+	u32 hi;
+};
+
+struct rpmi_set_rate_tx {
+	u32 clkid;
+	u32 flags;
+	u32 lo;
+	u32 hi;
+};
+
+struct rpmi_set_rate_rx {
+	u32 status;
+};
+
+struct rpmi_set_config_tx {
+	u32 clkid;
+	u32 config;
+};
+
+struct rpmi_set_config_rx {
+	u32 status;
+};
+
+static int rpmi_clk_get_num_clocks(struct rpmi_clk_context *context)
+{
+	struct rpmi_get_num_clocks_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_NUM_CLOCKS,
+					  NULL, 0, &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	return rx.num_clocks;
+}
+
+/**
+ * Get the RPMI Clock Attributes.
+ * These attributes belong to a particular clock(clkid)
+ * which are different from the MPXY channel attributes.
+ */
+static int rpmi_clk_get_attrs(u32 clkid, struct rpmi_clk *rpmi_clk)
+{
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_get_attrs_tx tx;
+	struct rpmi_get_attrs_rx rx;
+	u8 format;
+	int ret;
+
+	tx.clkid = cpu_to_le32(clkid);
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_ATTRIBUTES,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	rpmi_clk->id = clkid;
+	rpmi_clk->num_rates = rx.num_rates;
+	rpmi_clk->transition_latency = rx.transition_latency;
+	strscpy(rpmi_clk->name, rx.name, RPMI_CLK_NAME_LEN);
+
+	format = rx.flags & 1U;
+	if (format >= RPMI_CLK_TYPE_MAX_IDX)
+		return -EINVAL;
+
+	rpmi_clk->type = format;
+
+	return 0;
+}
+
+static int rpmi_clk_get_supported_rates(u32 clkid, struct rpmi_clk *rpmi_clk)
+{
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_get_supp_rates_tx tx;
+	struct rpmi_get_supp_rates_rx rx;
+	struct rpmi_mbox_message msg;
+	size_t clk_rate_idx = 0;
+	int ret, rateidx, j;
+
+	tx.clkid = cpu_to_le32(clkid);
+	tx.clk_rate_idx = 0;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_SUPPORTED_RATES,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+	if (!rx.returned)
+		return -EINVAL;
+
+	if (rpmi_clk->type == RPMI_CLK_DISCRETE) {
+		for (rateidx = 0; rateidx < rx.returned; rateidx++) {
+			rpmi_clk->rates->discrete[rateidx] =
+					GET_RATE_U64(rx.rates.discrete[rateidx].hi,
+						     rx.rates.discrete[rateidx].lo);
+		}
+
+		while (rx.remaining) {
+			clk_rate_idx += rx.returned;
+			tx.clk_rate_idx = clk_rate_idx;
+
+			rpmi_mbox_init_send_with_response(&msg,
+							  RPMI_CLK_SRV_GET_SUPPORTED_RATES,
+							  &tx, sizeof(tx), &rx, sizeof(rx));
+			ret = rpmi_mbox_send_message(context->chan, &msg);
+			if (ret)
+				return ret;
+
+			for (j = 0; j < rx.returned; j++) {
+				if (rateidx >= (clk_rate_idx + rx.returned))
+					break;
+				rpmi_clk->rates->discrete[rateidx++] =
+					GET_RATE_U64(rx.rates.discrete[j].hi,
+						     rx.rates.discrete[j].lo);
+			}
+		}
+	} else if (rpmi_clk->type == RPMI_CLK_LINEAR) {
+		rpmi_clk->rates->linear.min =
+				GET_RATE_U64(rx.rates.linear.min_hi,
+					     rx.rates.linear.min_lo);
+		rpmi_clk->rates->linear.max =
+				GET_RATE_U64(rx.rates.linear.max_hi,
+					     rx.rates.linear.max_lo);
+		rpmi_clk->rates->linear.step =
+				GET_RATE_U64(rx.rates.linear.step_hi,
+					     rx.rates.linear.step_lo);
+	}
+
+	return 0;
+}
+
+static unsigned long rpmi_clk_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_get_rate_tx tx;
+	struct rpmi_get_rate_rx rx;
+	int ret;
+
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_RATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rx.status;
+
+	return GET_RATE_U64(rx.hi, rx.lo);
+}
+
+static long rpmi_clk_round_rate(struct clk_hw *hw,
+				unsigned long rate,
+				unsigned long *parent_rate)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	u64 fmin, fmax, ftmp;
+
+	if (rpmi_clk->type == RPMI_CLK_DISCRETE)
+		return rate;
+
+	fmin = rpmi_clk->rates->linear.min;
+	fmax = rpmi_clk->rates->linear.max;
+
+	if (rate <= fmin)
+		return fmin;
+	else if (rate >=  fmax)
+		return fmax;
+
+	ftmp = rate - fmin;
+	ftmp += rpmi_clk->rates->linear.step - 1;
+	do_div(ftmp, rpmi_clk->rates->linear.step);
+
+	return ftmp * rpmi_clk->rates->linear.step + fmin;
+}
+
+static int rpmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_set_rate_tx tx;
+	struct rpmi_set_rate_rx rx;
+	int ret;
+
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+	tx.lo = cpu_to_le32(GET_RATE_LO_U32(rate));
+	tx.hi = cpu_to_le32(GET_RATE_HI_U32(rate));
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_SET_RATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	return 0;
+}
+
+static int rpmi_clk_enable(struct clk_hw *hw)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_set_config_tx tx;
+	struct rpmi_set_config_rx rx;
+	int ret;
+
+	tx.config = cpu_to_le32(RPMI_CLK_ENABLE);
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_SET_CONFIG,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	return 0;
+}
+
+static void rpmi_clk_disable(struct clk_hw *hw)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_set_config_tx tx;
+	struct rpmi_set_config_rx rx;
+	int ret;
+
+	tx.config = cpu_to_le32(RPMI_CLK_DISABLE);
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_SET_CONFIG,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret || rx.status)
+		pr_err("Failed to disable clk-%u\n", rpmi_clk->id);
+}
+
+static const struct clk_ops rpmi_clk_ops = {
+	.recalc_rate = rpmi_clk_recalc_rate,
+	.round_rate = rpmi_clk_round_rate,
+	.set_rate = rpmi_clk_set_rate,
+	.prepare = rpmi_clk_enable,
+	.unprepare = rpmi_clk_disable,
+};
+
+static struct clk_hw *rpmi_clk_enumerate(struct rpmi_clk_context *context, u32 clkid)
+{
+	struct device *dev = context->dev;
+	unsigned long min_rate, max_rate;
+	union rpmi_clk_rates *rates;
+	struct rpmi_clk *rpmi_clk;
+	struct clk_init_data init;
+	struct clk_hw *clk_hw;
+	int ret;
+
+	rates = devm_kzalloc(dev, sizeof(union rpmi_clk_rates), GFP_KERNEL);
+	if (!rates)
+		return ERR_PTR(-ENOMEM);
+
+	rpmi_clk = devm_kzalloc(dev, sizeof(struct rpmi_clk), GFP_KERNEL);
+	if (!rpmi_clk)
+		return ERR_PTR(-ENOMEM);
+	rpmi_clk->context = context;
+	rpmi_clk->rates = rates;
+
+	ret = rpmi_clk_get_attrs(clkid, rpmi_clk);
+	if (ret) {
+		dev_err(dev, "Failed to get clk-%u attributes\n", clkid);
+		return ERR_PTR(ret);
+	}
+
+	ret = rpmi_clk_get_supported_rates(clkid, rpmi_clk);
+	if (ret) {
+		dev_err(dev, "Get supported rates failed for clk-%u, %d\n",
+			clkid, ret);
+		return ERR_PTR(ret);
+	}
+
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.num_parents = 0;
+	init.ops = &rpmi_clk_ops;
+	init.name = rpmi_clk->name;
+	clk_hw = &rpmi_clk->hw;
+	clk_hw->init = &init;
+
+	ret = devm_clk_hw_register(dev, clk_hw);
+	if (ret) {
+		dev_err(dev, "Unable to register clk-%u\n", clkid);
+		return ERR_PTR(ret);
+	}
+
+	if (rpmi_clk->type == RPMI_CLK_DISCRETE) {
+		min_rate = rpmi_clk->rates->discrete[0];
+		max_rate = rpmi_clk->rates->discrete[rpmi_clk->num_rates -  1];
+	} else {
+		min_rate = rpmi_clk->rates->linear.min;
+		max_rate = rpmi_clk->rates->linear.max;
+	}
+
+	clk_hw_set_rate_range(clk_hw, min_rate, max_rate);
+
+	return NULL;
+}
+
+static void rpmi_clk_receive_message(struct mbox_client *cl, void *msg)
+{
+	/* Nothing to do here. */
+}
+
+static int rpmi_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct clk_hw_onecell_data *clk_data;
+	struct rpmi_clk_context *context;
+	struct rpmi_mbox_message msg;
+	int ret, num_clocks, i;
+	struct clk_hw *hw_ptr;
+
+	/* Allocate RPMI clock context */
+	context = devm_kzalloc(dev, sizeof(*context), GFP_KERNEL);
+	if (!context)
+		return -ENOMEM;
+	context->dev = dev;
+	platform_set_drvdata(pdev, context);
+
+	/* Setup mailbox client */
+	context->client.dev		= context->dev;
+	context->client.rx_callback	= rpmi_clk_receive_message;
+	context->client.tx_block	= false;
+	context->client.knows_txdone	= true;
+	context->client.tx_tout		= 0;
+
+	/* Request mailbox channel */
+	context->chan = mbox_request_channel(&context->client, 0);
+	if (IS_ERR(context->chan))
+		return PTR_ERR(context->chan);
+
+	/* Validate RPMI specification version */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SPEC_VERSION);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret) {
+		dev_err(dev, "Failed to get spec version\n");
+		goto fail_free_channel;
+	}
+	if (msg.attr.value < RPMI_MKVER(1, 0)) {
+		dev_err(dev,
+			"msg protocol version mismatch, expected 0x%x, found 0x%x\n",
+			RPMI_MKVER(1, 0), msg.attr.value);
+		ret = -EINVAL;
+		goto fail_free_channel;
+	}
+
+	/* Validate clock service group ID */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_ID);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret) {
+		dev_err(dev, "Failed to get service group ID\n");
+		goto fail_free_channel;
+	}
+	if (msg.attr.value != RPMI_SRVGRP_CLOCK) {
+		dev_err(dev,
+			"service group match failed, expected 0x%x, found 0x%x\n",
+			RPMI_SRVGRP_CLOCK, msg.attr.value);
+		ret = -EINVAL;
+		goto fail_free_channel;
+	}
+
+	/* Validate clock service group version */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_VERSION);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret) {
+		dev_err(dev, "Failed to get service group version\n");
+		goto fail_free_channel;
+	}
+	if (msg.attr.value < RPMI_MKVER(1, 0)) {
+		dev_err(dev,
+			"service group version failed, expected 0x%x, found 0x%x\n",
+			RPMI_MKVER(1, 0), msg.attr.value);
+		ret = -EINVAL;
+		goto fail_free_channel;
+	}
+
+	/* Find-out number of clocks */
+	num_clocks = rpmi_clk_get_num_clocks(context);
+	if (!num_clocks) {
+		dev_err(dev, "No clocks found\n");
+		ret = -ENODEV;
+		goto fail_free_channel;
+	}
+
+	/* Allocate clock data */
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_clocks),
+				GFP_KERNEL);
+	if (!clk_data) {
+		ret = -ENOMEM;
+		goto fail_free_channel;
+	}
+	clk_data->num = num_clocks;
+
+	/* Setup clock data */
+	for (i = 0; i < clk_data->num; i++) {
+		hw_ptr = rpmi_clk_enumerate(context, i);
+		if (IS_ERR(hw_ptr)) {
+			dev_err(dev, "failed to register clk-%d\n", i);
+			ret = PTR_ERR(hw_ptr);
+			goto fail_free_channel;
+		}
+		clk_data->hws[i] = hw_ptr;
+	}
+
+	/* Register clock HW provider */
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	if (ret) {
+		dev_err(dev, "failed to register clock HW provider\n");
+		goto fail_free_channel;
+	}
+
+	dev_info(dev, "clk HW provider registered with %d clocks\n",
+		 num_clocks);
+	return 0;
+
+fail_free_channel:
+	mbox_free_channel(context->chan);
+	return ret;
+}
+
+static void rpmi_clk_remove(struct platform_device *pdev)
+{
+	struct rpmi_clk_context *context = platform_get_drvdata(pdev);
+
+	mbox_free_channel(context->chan);
+}
+
+static const struct of_device_id rpmi_clk_of_match[] = {
+	{ .compatible = "riscv,rpmi-clock" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, rpmi_clk_of_match);
+
+static struct platform_driver rpmi_clk_driver = {
+	.driver = {
+		.name = "riscv-rpmi-clock",
+		.of_match_table = rpmi_clk_of_match,
+	},
+	.probe = rpmi_clk_probe,
+	.remove = rpmi_clk_remove,
+};
+module_platform_driver(rpmi_clk_driver);
+
+MODULE_AUTHOR("Rahul Pathak <rpathak@ventanamicro.com>");
+MODULE_DESCRIPTION("Clock Driver based on RPMI message protocol");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mailbox/riscv-rpmi-message.h b/include/linux/mailbox/riscv-rpmi-message.h
index 8f4b3a0edbce..4e9478c4c0a3 100644
--- a/include/linux/mailbox/riscv-rpmi-message.h
+++ b/include/linux/mailbox/riscv-rpmi-message.h
@@ -89,6 +89,22 @@ static inline int rpmi_to_linux_error(int rpmi_error)
 	}
 }
 
+/** RPMI service group IDs */
+#define RPMI_SRVGRP_CLOCK		0x00007
+
+/** RPMI clock service IDs */
+enum rpmi_clock_service_id {
+	RPMI_CLK_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_CLK_SRV_GET_NUM_CLOCKS = 0x02,
+	RPMI_CLK_SRV_GET_ATTRIBUTES = 0x03,
+	RPMI_CLK_SRV_GET_SUPPORTED_RATES = 0x04,
+	RPMI_CLK_SRV_SET_CONFIG = 0x05,
+	RPMI_CLK_SRV_GET_CONFIG = 0x06,
+	RPMI_CLK_SRV_SET_RATE = 0x07,
+	RPMI_CLK_SRV_GET_RATE = 0x08,
+	RPMI_CLK_SRV_ID_MAX_COUNT,
+};
+
 /** RPMI linux mailbox attribute IDs */
 enum rpmi_mbox_attribute_id {
 	RPMI_MBOX_ATTR_SPEC_VERSION = 0,
-- 
2.43.0


