Return-Path: <linux-kernel+bounces-553310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D337A58747
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979BA188801E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2B1DF732;
	Sun,  9 Mar 2025 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXzn7eh+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VJGal2R8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1372628C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741545511; cv=none; b=oLMPlwer/xFYDGlbHGyLkJdU6sjAjqXT8nqEQ7Q3ESfCrAQZni+rmnRIMBItWoqIZzdQBSuiJlyCr7vsnLYBo7s1bjFdQL0NlNoQiqsOQvP6/o3TSt4LtZlwoi6BF/e3Ttsp1w8D34+Cp1on/uOCPs4RONyjSYV5LJYZe7g7vSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741545511; c=relaxed/simple;
	bh=tSi+HjDkxL1af7CPV5Aep+JbhuecGAyBSu2kiKmaMqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mc6vMhYso+auMYgq0PaFaU3ulwR3AvqdQKFGHp14kgo6jWeDrgc9X1Vk9/35sPlTcHAlqpbRtKHdvMhDfqN3V0ElhflHBcQ64Wyuh+94gZ67vpaXVqbQNVOWV6hO1TAJPItqaqID8+x1LCMXg82JSf+Pmr8JpwAbJuAYik7iEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXzn7eh+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VJGal2R8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741545507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UrmzBA+7P+YKb+S3bR5gaJE7HT8coTqFOm4DRhG/I7o=;
	b=LXzn7eh+U+qfuYtPQ0iJ9vtDA/t1sTY/oQ1c5lUiWCc7Gh3frf4mxWqEpihuPDfqwlf9Wh
	ibYc4nDNxRjk1DU5R1KYnpCFYClTgay/wRc2J9h/MDr8e47eZndyZbwwNPIh5l63qYeSMe
	3tWw6GFZy/h5t7qDoeJzFNI4C/8xNWfZ0sr6HiL5leepYWNXcOiTaoiY81LODeD/algbl0
	uPzW2KmkTSZX+celEBEBPsZZCuG8F1/7HJwh6WlgnKBwJZdBTnuFlkBD6NCUfgmT27V/Yt
	KeQbu2g/a8YjmddZ4We9QYYTg328Mys0yecdlndyPhw28uc90ztaSN8At+ehcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741545507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UrmzBA+7P+YKb+S3bR5gaJE7HT8coTqFOm4DRhG/I7o=;
	b=VJGal2R8CnFmQ2VklireAPEVABaFg+RsGRemtlNP8dNYo44uMAUm0Ce402mC7KdfM3v5Tg
	wUfkkLF2PCSfc+DA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] genirq: Make a few functions static
Date: Sun, 09 Mar 2025 19:38:26 +0100
Message-ID: <878qpe2gnx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

None of these functions are used outside of their source files.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h |    3 ---
 kernel/irq/chip.c         |   30 +++++++++++++++---------------
 kernel/irq/internals.h    |    9 ---------
 kernel/irq/irqdesc.c      |    2 +-
 kernel/irq/irqdomain.c    |    5 ++---
 kernel/irq/manage.c       |    7 ++++---
 6 files changed, 22 insertions(+), 34 deletions(-)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -628,9 +628,6 @@ static inline int irq_domain_alloc_irqs(
 				       NULL);
 }
 
-extern int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
-					   unsigned int irq_base,
-					   unsigned int nr_irqs, void *arg);
 extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 unsigned int virq,
 					 irq_hw_number_t hwirq,
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -232,6 +232,21 @@ static __always_inline int
 }
 #endif
 
+static void irq_enable(struct irq_desc *desc)
+{
+	if (!irqd_irq_disabled(&desc->irq_data)) {
+		unmask_irq(desc);
+	} else {
+		irq_state_clr_disabled(desc);
+		if (desc->irq_data.chip->irq_enable) {
+			desc->irq_data.chip->irq_enable(&desc->irq_data);
+			irq_state_clr_masked(desc);
+		} else {
+			unmask_irq(desc);
+		}
+	}
+}
+
 static int __irq_startup(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
@@ -332,21 +347,6 @@ void irq_shutdown_and_deactivate(struct
 	irq_domain_deactivate_irq(&desc->irq_data);
 }
 
-void irq_enable(struct irq_desc *desc)
-{
-	if (!irqd_irq_disabled(&desc->irq_data)) {
-		unmask_irq(desc);
-	} else {
-		irq_state_clr_disabled(desc);
-		if (desc->irq_data.chip->irq_enable) {
-			desc->irq_data.chip->irq_enable(&desc->irq_data);
-			irq_state_clr_masked(desc);
-		} else {
-			unmask_irq(desc);
-		}
-	}
-}
-
 static void __irq_disable(struct irq_desc *desc, bool mask)
 {
 	if (irqd_irq_disabled(&desc->irq_data)) {
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -90,7 +90,6 @@ extern int irq_startup(struct irq_desc *
 
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
-extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
@@ -98,18 +97,12 @@ extern void mask_irq(struct irq_desc *de
 extern void unmask_irq(struct irq_desc *desc);
 extern void unmask_threaded_irq(struct irq_desc *desc);
 
-extern unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask);
-
 #ifdef CONFIG_SPARSE_IRQ
 static inline void irq_mark_irq(unsigned int irq) { }
 #else
 extern void irq_mark_irq(unsigned int irq);
 #endif
 
-extern int __irq_get_irqchip_state(struct irq_data *data,
-				   enum irqchip_irq_state which,
-				   bool *state);
-
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
@@ -139,8 +132,6 @@ static inline void unregister_handler_pr
 
 extern bool irq_can_set_affinity_usr(unsigned int irq);
 
-extern void irq_set_thread_affinity(struct irq_desc *desc);
-
 extern int irq_do_set_affinity(struct irq_data *data,
 			       const struct cpumask *dest, bool force);
 
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -991,7 +991,7 @@ unsigned int kstat_irqs_cpu(unsigned int
 	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
-unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask)
+static unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask)
 {
 	unsigned int sum = 0;
 	int cpu;
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1589,9 +1589,8 @@ static void irq_domain_free_irqs_hierarc
 	}
 }
 
-int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
-				    unsigned int irq_base,
-				    unsigned int nr_irqs, void *arg)
+static int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain, unsigned int irq_base,
+					   unsigned int nr_irqs, void *arg)
 {
 	if (!domain->ops->alloc) {
 		pr_debug("domain->ops->alloc() is NULL\n");
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -35,6 +35,8 @@ static int __init setup_forced_irqthread
 early_param("threadirqs", setup_forced_irqthreads);
 #endif
 
+static int __irq_get_irqchip_state(struct irq_data *d, enum irqchip_irq_state which, bool *state);
+
 static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 {
 	struct irq_data *irqd = irq_desc_get_irq_data(desc);
@@ -187,7 +189,7 @@ bool irq_can_set_affinity_usr(unsigned i
  *	set_cpus_allowed_ptr() here as we hold desc->lock and this
  *	code can be called from hard interrupt context.
  */
-void irq_set_thread_affinity(struct irq_desc *desc)
+static void irq_set_thread_affinity(struct irq_desc *desc)
 {
 	struct irqaction *action;
 
@@ -2789,8 +2791,7 @@ void teardown_percpu_nmi(unsigned int ir
 	irq_put_desc_unlock(desc, flags);
 }
 
-int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which,
-			    bool *state)
+static int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which, bool *state)
 {
 	struct irq_chip *chip;
 	int err = -EINVAL;

