Return-Path: <linux-kernel+bounces-405876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 282B69C5A24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA85B36F99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6B67083A;
	Tue, 12 Nov 2024 12:57:14 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3F70819
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416234; cv=none; b=r1PMrOUBSCJUjHPRcJLmupPWl5dGWhfNoRDseZGjoHiB6tn+9aLB+UxBwegDpdAzinYNZtLgvpmj9GOV6fPfA/3r3Un0MoblyFC7mGoizDwFxH4+Gn9Y+vSCmhFw/kc3AAgii2Zd1tV/SFkV/7G2AOs6wdADfvwVG8p5pEMUHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416234; c=relaxed/simple;
	bh=xwGiqFWf8zCb9G6OIeIy5WDox194yEWZZ5z+X0t3njg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pKeJ9X3n3qxiI9cWrhjtPLx31/I3As7ZRnHYkz4qaSVpQSYnaj+vQSTGoI2xMcATu2657G/jIi9fHMblwBSq5nbi514/6H6TDnSdtcURugjrkReCX0if1UbDSDw/AwdJVHKllQlhYK60xNZFwCYPAtrnvgw/MUodrAwMBBs/H4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xnmbk44pNz10V7K
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 20:55:14 +0800 (CST)
Received: from kwepemk100005.china.huawei.com (unknown [7.202.194.53])
	by mail.maildlp.com (Postfix) with ESMTPS id D5F5B1800CF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 20:57:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemk100005.china.huawei.com
 (7.202.194.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Nov
 2024 20:57:07 +0800
From: Liu Chao <liuchao173@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <lixiaokeng@huawei.com>, <caihe@huawei.com>
Subject: [PATCH] Add interface to trigger backtrace on specified CPUs
Date: Tue, 12 Nov 2024 12:56:09 +0000
Message-ID: <20241112125609.1406586-1-liuchao173@huawei.com>
X-Mailer: git-send-email 2.23.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100005.china.huawei.com (7.202.194.53)

When the number of CPUs is large, the echo l > /proc/sysrq-trigger
prints a large number of logs. Users can use this interface to
trigger backtrace on specified CPUs.

Signed-off-by: Liu Chao <liuchao173@huawei.com>
---
 kernel/Makefile    |  1 +
 kernel/backtrace.c | 39 +++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug  |  9 +++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 kernel/backtrace.c

diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..330647518ae3 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -116,6 +116,7 @@ obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
+obj-$(CONFIG_BACKTRACE) += backtrace.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/backtrace.c b/kernel/backtrace.c
new file mode 100644
index 000000000000..767ad46d1add
--- /dev/null
+++ b/kernel/backtrace.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/debugfs.h>
+#include <linux/nmi.h>
+
+static ssize_t backtrace_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct cpumask mask;
+	int err;
+
+	err = cpumask_parselist_user(buf, count, &mask);
+	if (err < 0 || cpumask_last(&mask) >= nr_cpu_ids) {
+		pr_err("backtrace: incorrect CPU range.\n");
+		return -EINVAL;
+	}
+
+	if (!trigger_cpumask_backtrace(&mask)) {
+		pr_err("backtrace: backtrace printing fails.\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations backtrace_fops = {
+	.owner  = THIS_MODULE,
+	.write  = backtrace_write,
+	.llseek = no_llseek,
+};
+
+static int __init backtrace_init(void)
+{
+	debugfs_create_file("backtrace", 0200, NULL, NULL,
+						&backtrace_fops);
+
+	return 0;
+}
+device_initcall(backtrace_init);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7312ae7c3cc5..326ea9e6eba7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -698,6 +698,15 @@ source "lib/Kconfig.kgdb"
 source "lib/Kconfig.ubsan"
 source "lib/Kconfig.kcsan"
 
+config BACKTRACE
+	bool "Support trigger backtrace according cpulist"
+	depends on SMP && DEBUG_FS
+	help
+	  When the number of CPUs is large, the echo l > /proc/sysrq-trigger
+	  prints a large number of logs. Users can echo cpulist >
+	  /sys/kernel/debug/backtrace to trigger backtrace on specified
+	  CPUs.
+
 endmenu
 
 menu "Networking Debugging"
-- 
2.33.0


