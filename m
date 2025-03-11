Return-Path: <linux-kernel+bounces-555340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B2A5B5E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5269017150E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5626F1DF25D;
	Tue, 11 Mar 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EoSdcWJl"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAC05258
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 01:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656850; cv=none; b=W1LUQmO4dQZaM/z3luukd6qp5gf5AArTBjvqRLTqPRAIGb5pldPEy8pZY5SDXhhxIq6j9m9p/H//V6rMf84bq76vV+z8bq6KC1HDx9EJXVHt8oRqd7t8cMnhzTpaoYfDHONhKhn9KEoBHypICg0d9ap56Ij89oqrO/AkwG+heng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656850; c=relaxed/simple;
	bh=eDWMlP1e+y9TuF0qi8EilmMnhBooXOAt190P8/t/XQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XpD3KFdYariA8B39uoq7RYBiR3GngTK1cnSE2ki7bNXkBKXFGl5cKr+RWLjrlJnYe5fDslndUEjlNwlS9iEDdg18zGCOG1inCCiTlUFFXT3bRleE/PlW0AY5sVhdDjfO3BP7uzUeoBXirQA/a11WbKvWqWMfP/6qsx69VE8OyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EoSdcWJl; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741656846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7nlBb8Ci/KR7HexKQm5Z1j3z7u/2Id1d+MFKjs87dYA=;
	b=EoSdcWJl+2b/f/wGrqVQIRfVuGS8ibh6n5kD8Z2RXzccf8f1oLp2YB1TNVmdromJR+/zTX
	fq9HUEnsU4tvFcyI+Jfg3cS4oxK5+yE+8MK61161gknExWlP83bYiZXjL7wIkmUMO0SNET
	ebXjg8u75us6SEVSp+PWC+JIFr+zqCA=
From: Yajun Deng <yajun.deng@linux.dev>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] genirq: Keep affinity_hint unchanged if it has a value
Date: Tue, 11 Mar 2025 09:33:52 +0800
Message-Id: <20250311013352.2727490-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

affinity_hint is a hint to user space for preferred irq affinity, but
it could chang if the value it points to is changed. In other words,
the hint is invalid.

For example, if affinity_hint points to smp_affinity, smp_affinity
is changed by the user, and affinity_hint would chang. affinity_hint
couldn't as a hint to the user, it should keep the value if it has.

Allocate memory in alloc_masks(), and keep it unchanged if it has a
value in __irq_apply_affinity_hint().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/irqdesc.h |  2 +-
 kernel/irq/irqdesc.c    |  9 +++++++++
 kernel/irq/manage.c     |  9 ++-------
 kernel/irq/proc.c       | 15 +--------------
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index fd091c35d572..f6363ba435c6 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -84,7 +84,7 @@ struct irq_desc {
 	struct cpumask		*percpu_enabled;
 	const struct cpumask	*percpu_affinity;
 #ifdef CONFIG_SMP
-	const struct cpumask	*affinity_hint;
+	struct cpumask		*affinity_hint;
 	struct irq_affinity_notify *affinity_notify;
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	cpumask_var_t		pending_mask;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 287830739783..e4f87826b7c6 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -58,9 +58,16 @@ static int alloc_masks(struct irq_desc *desc, int node)
 				     GFP_KERNEL, node))
 		return -ENOMEM;
 
+	if (!zalloc_cpumask_var_node(&desc->affinity_hint,
+				     GFP_KERNEL, node)) {
+		free_cpumask_var(desc->irq_common_data.affinity);
+		return -ENOMEM;
+	}
+
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	if (!zalloc_cpumask_var_node(&desc->irq_common_data.effective_affinity,
 				     GFP_KERNEL, node)) {
+		free_cpumask_var(desc->affinity_hint);
 		free_cpumask_var(desc->irq_common_data.affinity);
 		return -ENOMEM;
 	}
@@ -71,6 +78,7 @@ static int alloc_masks(struct irq_desc *desc, int node)
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 		free_cpumask_var(desc->irq_common_data.effective_affinity);
 #endif
+		free_cpumask_var(desc->affinity_hint);
 		free_cpumask_var(desc->irq_common_data.affinity);
 		return -ENOMEM;
 	}
@@ -98,6 +106,7 @@ static void free_masks(struct irq_desc *desc)
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	free_cpumask_var(desc->pending_mask);
 #endif
+	free_cpumask_var(desc->affinity_hint);
 	free_cpumask_var(desc->irq_common_data.affinity);
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	free_cpumask_var(desc->irq_common_data.effective_affinity);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f300bb6be3bd..49500af3effa 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -507,7 +507,8 @@ int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
 
 	if (!desc)
 		return -EINVAL;
-	desc->affinity_hint = m;
+	if (m && cpumask_empty(desc->affinity_hint))
+		cpumask_copy(desc->affinity_hint, m);
 	irq_put_desc_unlock(desc, flags);
 	if (m && setaffinity)
 		__irq_set_affinity(irq, m, false);
@@ -1914,12 +1915,6 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 		irq_shutdown(desc);
 	}
 
-#ifdef CONFIG_SMP
-	/* make sure affinity_hint is cleaned up */
-	if (WARN_ON_ONCE(desc->affinity_hint))
-		desc->affinity_hint = NULL;
-#endif
-
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	/*
 	 * Drop bus_lock here so the changes which were done in the chip
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 8e29809de38d..b4d5932a1a1a 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -81,20 +81,7 @@ static int show_irq_affinity(int type, struct seq_file *m)
 static int irq_affinity_hint_proc_show(struct seq_file *m, void *v)
 {
 	struct irq_desc *desc = irq_to_desc((long)m->private);
-	unsigned long flags;
-	cpumask_var_t mask;
-
-	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	if (desc->affinity_hint)
-		cpumask_copy(mask, desc->affinity_hint);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-
-	seq_printf(m, "%*pb\n", cpumask_pr_args(mask));
-	free_cpumask_var(mask);
-
+	seq_printf(m, "%*pb\n", cpumask_pr_args(desc->affinity_hint));
 	return 0;
 }
 
-- 
2.25.1


