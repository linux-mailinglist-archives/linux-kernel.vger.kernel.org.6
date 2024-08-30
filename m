Return-Path: <linux-kernel+bounces-308499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324F965DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AB21C22E51
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F81917E000;
	Fri, 30 Aug 2024 10:01:36 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043317C9E3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012095; cv=none; b=oQasfqHsoZ8oMhPZwgCPkgvp5P4bVvjR1A1urOssZ3vifwwZlqaw7pIXv3ZNakj8i7uKs8dFV6xVJQPGA+xUA3BVniLpCD0Cg7XeMaktlqLC/JYPKBAiQ0uBnq12DUCmcJLyLDpQktalv1h9aXOJRpekzZiLiP038fR27R9epKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012095; c=relaxed/simple;
	bh=6g7CK3OGqT00ZaRKzaRMV5Bga33IQARjCHRsRRokcJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gUzznx2abh2f1p48p0COgJi/MS9xiWom+g8eYElY7jjc9oY2EBGm2nZZ06lcCEfmWGHfVRl3xcpnws29hAakmcWyu4u7m0ZrP8fHZqxhDoSsedPTBp3FDjUBakC6Glm9Op0Syco+IGxRx4GfGd0bSb8MSjDMpOSRX+mcmzcCtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwDF22Kqmz2Cp1T
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:01:10 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F65C1400D7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:01:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 18:01:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] genirq: Fix IRQ_MOVE_PENDING try set when CONFIG_GENERIC_PENDING_IRQ not set
Date: Fri, 30 Aug 2024 18:09:23 +0800
Message-ID: <20240830100923.3818817-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The irqd_set_move_pending() and irq_copy_pending() appear in pairs, but
irq_copy_pending() is empty when CONFIG_GENERIC_PENDING_IRQ is not set,
irqd_set_move_pending always set IRQD_SETAFFINITY_PENDING flag.

And before commit 1fa46f1f0709 ("genirq: Simplify affinity related code"),
if the config not set, IRQ_MOVE_PENDING will not try set and
desc->pending_mask will not be copied no matter what. Fix it by combining
them to align with them, and define empty for both if the config
is not enabled.

Fixes: 1fa46f1f0709 ("genirq: Simplify affinity related code")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/internals.h |  7 +++++--
 kernel/irq/manage.c    | 19 +++++--------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index fe0272cd84a5..f3d83f3745cb 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -428,8 +428,11 @@ static inline bool irq_move_pending(struct irq_data *data)
 	return irqd_is_setaffinity_pending(data);
 }
 static inline void
-irq_copy_pending(struct irq_desc *desc, const struct cpumask *mask)
+irq_set_copy_pending(struct irq_data *data, const struct cpumask *mask)
 {
+	struct irq_desc *desc = irq_data_to_desc(data);
+
+	irqd_set_move_pending(data);
 	cpumask_copy(desc->pending_mask, mask);
 }
 static inline void
@@ -456,7 +459,7 @@ static inline bool irq_move_pending(struct irq_data *data)
 	return false;
 }
 static inline void
-irq_copy_pending(struct irq_desc *desc, const struct cpumask *mask)
+irq_set_copy_pending(struct irq_data *data, const struct cpumask *mask)
 {
 }
 static inline void
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f0803d6bd296..d03c3c4a869c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -293,23 +293,16 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	return ret;
 }
 
-#ifdef CONFIG_GENERIC_PENDING_IRQ
 static inline int irq_set_affinity_pending(struct irq_data *data,
 					   const struct cpumask *dest)
 {
-	struct irq_desc *desc = irq_data_to_desc(data);
-
-	irqd_set_move_pending(data);
-	irq_copy_pending(desc, dest);
+	irq_set_copy_pending(data, dest);
+#ifdef CONFIG_GENERIC_PENDING_IRQ
 	return 0;
-}
 #else
-static inline int irq_set_affinity_pending(struct irq_data *data,
-					   const struct cpumask *dest)
-{
 	return -EBUSY;
-}
 #endif
+}
 
 static int irq_try_set_affinity(struct irq_data *data,
 				const struct cpumask *dest, bool force)
@@ -365,10 +358,8 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 
 	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
 		ret = irq_try_set_affinity(data, mask, force);
-	} else {
-		irqd_set_move_pending(data);
-		irq_copy_pending(desc, mask);
-	}
+	} else
+		irq_set_copy_pending(data, mask);
 
 	if (desc->affinity_notify) {
 		kref_get(&desc->affinity_notify->kref);
-- 
2.34.1


