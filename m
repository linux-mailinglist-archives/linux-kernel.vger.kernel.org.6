Return-Path: <linux-kernel+bounces-258754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A66938C63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BB2282D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60DF16C869;
	Mon, 22 Jul 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="PcnEOcQc"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3FF16F0DC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641435; cv=none; b=rr7oa44qBQ1BtVsgsupJFw+46K3qki1Ij0INQ2kodpwr7I+Yj82dj7pw79nnHTBt4QYaIgJmq8loA7C2C5VTDqaK+BvrOBkRfOQHB83uQbbe4BN85tbf5UEETPB2ttylcK6nBk1zr71xMp8lSorj3uUZMqj1y6GgXLppin1qYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641435; c=relaxed/simple;
	bh=55eerdBP4o0/u9Txs6EDQqNf+WvNLBqBndnEG4NkhBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSInVIErktUUgfl3TK8XWz0+bHtynyLpxuyk7TbLzEZVmTA14xZmiv24MmL/e50vPIOF+uVg0H++NwWkYkulKgVjqljUMf+VQG+4J3tUF8OR+bbhQOqVQWL8uuBkkvuaA1ADp4IuU1sj5K/hqmWZ9p2s9uHxR/AdxyYHjk8j2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=PcnEOcQc; arc=none smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 37FFD322A9C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641432;
	bh=55eerdBP4o0/u9Txs6EDQqNf+WvNLBqBndnEG4NkhBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PcnEOcQc8VAQdfDX6dwOGYKMiJ9+7ANO20I++44QqOBRPv2TVeg/Te0UbMG/hEXLF
	 LH5OxB5JQiMabkPMYYVpk2cad9lxkxiCdgdpf+awMBsKciAVksoZkBxh0VqDz3a4DU
	 D8nd18hFQHalJFZRhyv+cL8V1Uxizf4nKBWc80yU=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 1076332211E; Mon, 22 Jul
 2024 11:43:52 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 92B893228EB; Mon, 22 Jul
 2024 11:43:51 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 5259E40317; Mon, 22 Jul
 2024 11:43:51 +0200 (CEST)
X-Secumail-id: <aba9.669e29d7.8442e.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Guillaume Thouvenin <thouveng@gmail.com>,
 Jules Maselbas <jmaselbas@zdiv.net>
Subject: [RFC PATCH v3 33/37] kvx: Add support for cpuinfo
Date: Mon, 22 Jul 2024 11:41:44 +0200
Message-ID: <20240722094226.21602-34-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add support for cpuinfo on kvx arch.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: No changes
V2 -> V3:
- add missing function declaration for setup_cpuinfo()
- replace printk(KERN_WARNING... with pr_warn(...
---
 arch/kvx/include/asm/cpuinfo.h |  7 +++
 arch/kvx/kernel/cpuinfo.c      | 95 ++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/kvx/include/asm/cpuinfo.h
 create mode 100644 arch/kvx/kernel/cpuinfo.c

diff --git a/arch/kvx/include/asm/cpuinfo.h b/arch/kvx/include/asm/cpuinfo.h
new file mode 100644
index 0000000000000..ace9b85fbafaf
--- /dev/null
+++ b/arch/kvx/include/asm/cpuinfo.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_KVX_CPUINFO_H
+#define __ASM_KVX_CPUINFO_H
+
+extern void setup_cpuinfo(void);
+
+#endif /* __ASM_KVX_CPUINFO_H */
diff --git a/arch/kvx/kernel/cpuinfo.c b/arch/kvx/kernel/cpuinfo.c
new file mode 100644
index 0000000000000..6d46fd2a1bd93
--- /dev/null
+++ b/arch/kvx/kernel/cpuinfo.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#include <linux/seq_file.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+
+unsigned long elf_hwcap __read_mostly;
+
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	int cpu_num = *(unsigned int *)v;
+	struct cpuinfo_kvx *n = per_cpu_ptr(&cpu_info, cpu_num);
+
+	seq_printf(m, "processor\t: %d\nvendor_id\t: Kalray\n", cpu_num);
+
+	seq_printf(m,
+		   "copro enabled\t: %s\n"
+		   "arch revision\t: %d\n"
+		   "uarch revision\t: %d\n",
+		   n->copro_enable ? "yes" : "no",
+		   n->arch_rev,
+		   n->uarch_rev);
+
+	seq_printf(m,
+		   "bogomips\t: %lu.%02lu\n"
+		   "cpu MHz\t\t: %llu.%03llu\n\n",
+		   (loops_per_jiffy * HZ) / 500000,
+		   ((loops_per_jiffy * HZ) / 5000) % 100,
+		   n->freq / 1000000, (n->freq / 10000) % 100);
+
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	if (*pos == 0)
+		*pos = cpumask_first(cpu_online_mask);
+	if (*pos >= num_online_cpus())
+		return NULL;
+
+	return pos;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	*pos = cpumask_next(*pos, cpu_online_mask);
+
+	return c_start(m, pos);
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start = c_start,
+	.next = c_next,
+	.stop = c_stop,
+	.show = show_cpuinfo,
+};
+
+static int __init setup_cpuinfo(void)
+{
+	int cpu;
+	struct clk *clk;
+	unsigned long cpu_freq = 1000000000;
+	struct device_node *node = of_get_cpu_node(0, NULL);
+
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		pr_warn("Device tree missing CPU 'clock' parameter. Assuming frequency is 1GHZ");
+		goto setup_cpu_freq;
+	}
+
+	cpu_freq = clk_get_rate(clk);
+
+	clk_put(clk);
+
+setup_cpu_freq:
+	of_node_put(node);
+
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(&cpu_info, cpu)->freq = cpu_freq;
+
+	return 0;
+}
+
+late_initcall(setup_cpuinfo);
-- 
2.45.2






