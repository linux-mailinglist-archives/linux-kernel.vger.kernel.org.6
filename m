Return-Path: <linux-kernel+bounces-191991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C488D16F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E295B24350
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D013D29A;
	Tue, 28 May 2024 09:11:04 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672994594A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887464; cv=none; b=QvFUv3RrNQV54UjNOB6X6bR+UKr9gsR7TrJy07JPmIn4kmDRdEuFZdai/XBQGx585WwYZ5DhoU2zulhegRLfLP/9cStPr/lEyS7nay7WvOgcFlrIBveK4DX/bivynsrpIY1L8PPYVPZYMXWnCvauFZYVmr4SfKVbjEevzGKpAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887464; c=relaxed/simple;
	bh=1RwQvCe3Yc/wpvVhbqyoP9WETRw6+GsL8em9Rc0ezjM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HeTwuqyonuZW48V8sd7RHfDtha6hVcqd3QxumwCi50Zw6a4ujauO/8TzjTjrsEZmzH/bW9OcmldofnbWDnw+ow95RBDj9dBnHoD5z2+fuA6iaFiWfNz+c2FFecIYe1ldUHOok4Z3X8bCqKWlj+OtOEoj+1Lq8Lr5xw3YtaNRJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VpRV85DVszwQ7Y
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:07:12 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id B9E7A18006E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:10:58 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 28 May
 2024 17:10:58 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] genirq/debugfs: Print irqdomain flags as human-readable strings
Date: Tue, 28 May 2024 09:09:17 +0000
Message-ID: <20240528090917.3624463-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)

This patch improves the readability of irqdomain debugging information in
debugfs by printing the flags field of domain files as human-readable
strings instead of a raw bitmask, which aligned with the existing style
used for irqchip flags in the irq debug files.

Before:
	#cat :cpus:cpu@0:interrupt-controller
	name:   :cpus:cpu@0:interrupt-controller
	 size:   0
	 mapped: 2
	 flags:  0x00000003

After:
	#cat :cpus:cpu@0:interrupt-controller
	name:   :cpus:cpu@0:interrupt-controller
	 size:   0
	 mapped: 3
	 flags:  0x00000003
	            IRQ_DOMAIN_FLAG_HIERARCHY
	            IRQ_DOMAIN_NAME_ALLOCATED

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/debugfs.c   | 17 -----------------
 kernel/irq/internals.h | 19 +++++++++++++++++++
 kernel/irq/irqdomain.c | 15 +++++++++++++++
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index aae0402507ed..61a21a4c43ac 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -9,23 +9,6 @@
 
 static struct dentry *irq_dir;
 
-struct irq_bit_descr {
-	unsigned int	mask;
-	char		*name;
-};
-#define BIT_MASK_DESCR(m)	{ .mask = m, .name = #m }
-
-static void irq_debug_show_bits(struct seq_file *m, int ind, unsigned int state,
-				const struct irq_bit_descr *sd, int size)
-{
-	int i;
-
-	for (i = 0; i < size; i++, sd++) {
-		if (state & sd->mask)
-			seq_printf(m, "%*s%s\n", ind + 12, "", sd->name);
-	}
-}
-
 #ifdef CONFIG_SMP
 static void irq_debug_show_masks(struct seq_file *m, struct irq_desc *desc)
 {
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ed28059e9849..e2ea3f6917ac 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -501,6 +501,25 @@ static inline struct irq_data *irqd_get_parent_data(struct irq_data *irqd)
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 #include <linux/debugfs.h>
 
+struct irq_bit_descr {
+	unsigned int	mask;
+	char		*name;
+};
+
+#define BIT_MASK_DESCR(m)	{ .mask = m, .name = #m }
+
+static inline void irq_debug_show_bits(struct seq_file *m, int ind,
+				       unsigned int state,
+				       const struct irq_bit_descr *sd, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++, sd++) {
+		if (state & sd->mask)
+			seq_printf(m, "%*s%s\n", ind + 12, "", sd->name);
+	}
+}
+
 void irq_add_debugfs_entry(unsigned int irq, struct irq_desc *desc);
 static inline void irq_remove_debugfs_entry(struct irq_desc *desc)
 {
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index c5832caf24cd..ba5c5cc90c3d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1927,6 +1927,19 @@ static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq
 
 static struct dentry *domain_dir;
 
+static const struct irq_bit_descr irqdomain_flags[] = {
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_HIERARCHY),
+	BIT_MASK_DESCR(IRQ_DOMAIN_NAME_ALLOCATED),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_IPI_PER_CPU),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_IPI_SINGLE),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_MSI),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_ISOLATED_MSI),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_NO_MAP),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_MSI_PARENT),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_MSI_DEVICE),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_NONCORE),
+};
+
 static void
 irq_domain_debug_show_one(struct seq_file *m, struct irq_domain *d, int ind)
 {
@@ -1934,6 +1947,8 @@ irq_domain_debug_show_one(struct seq_file *m, struct irq_domain *d, int ind)
 	seq_printf(m, "%*ssize:   %u\n", ind + 1, "", d->revmap_size);
 	seq_printf(m, "%*smapped: %u\n", ind + 1, "", d->mapcount);
 	seq_printf(m, "%*sflags:  0x%08x\n", ind +1 , "", d->flags);
+	irq_debug_show_bits(m, ind, d->flags, irqdomain_flags,
+			    ARRAY_SIZE(irqdomain_flags));
 	if (d->ops && d->ops->debug_show)
 		d->ops->debug_show(m, d, NULL, ind + 1);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-- 
2.34.1


