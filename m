Return-Path: <linux-kernel+bounces-559858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96553A5FAA1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA33317E254
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634426A0B9;
	Thu, 13 Mar 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2HqymcWp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hHolmahl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF11269D16
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881589; cv=none; b=kbcMrIR9PlNUcc5pZF/MfFI6LFM2lUI1SqCbahlfd8DeO2tLXbmlbBWHBn21ShpZWfSzHzLAwsufFqjf4uV+J3K3X7Xm27nVxF3z4zz6EZFtZs9yRoCTJJvxTfQUWLGNhLw7jvD1b9h+0MYrsAEjBpsgVLqWcrPNCr0b533S/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881589; c=relaxed/simple;
	bh=IVJhpYURztDJOZBABhyAoqcfzgKz3pCP/FdaRTf/1WA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=es3dDL9O29wUZc6EMS5tzrRSwzl98KTEcYvFhlpPFJekuJtJboWJMFoMydT2DvUedYP8qsIS/QM4agQ4rC75haDMVfV5csXk7Px6+AGMbGYU4mh49iK/mSyqXVDPV7yMILjiHuOniXa0qH7AnYAycNHKrzdJ1eA1su5R0ItcTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2HqymcWp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hHolmahl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.010145118@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=waJW3YQ5oWNwI/K62CwSIbV5Ipj5dQb2DRtTEC5iKXQ=;
	b=2HqymcWpAVP30QeTxkq309VWpnQRwT1EZs/jYZuMKe34hSpQBxBh6GBuXNwkSKBb7vrEWv
	tevFf7ATtnQBTeQz2P1eNJgQ2Cs+Dc02MYGr7YREOPmnSkVa4LOz9H175YFmw7ygrIznyd
	4Na+493RquM0+VDxht0LyJ8XCZO27pKt0zkpQjn17bQ7F83zOSSqKN3uoZ1AUwpBvLAEMi
	PSvGiZXQxNpqeUDrzmPuZGfrsiqmKVAWgpJbveJUJKq5Ra7dJhH3LWWfqzWZ8xMCFr9dRl
	tXmkFz4a0Sg6xNQhwWpvXFe3/ZEShkyjXOB/oazQJktbgQX66XA7XQVNaFFAWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=waJW3YQ5oWNwI/K62CwSIbV5Ipj5dQb2DRtTEC5iKXQ=;
	b=hHolmahlfg0z+gf36erbdveDBwhWLl4BwWoOAsmiG2dqn8CimNjClFhyMoQYord2zNrbi/
	WCOBudo5kRVxQhAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 02/46] genirq/irqdesc: Switch to lock guards
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 16:59:44 +0100 (CET)

Replace all lock/unlock pairs with lock guards and simplify the code flow.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdesc.c |  136 +++++++++++++++------------------------------------
 1 file changed, 42 insertions(+), 94 deletions(-)

--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -266,104 +266,68 @@ static ssize_t per_cpu_count_show(struct
 }
 IRQ_ATTR_RO(per_cpu_count);
 
-static ssize_t chip_name_show(struct kobject *kobj,
-			      struct kobj_attribute *attr, char *buf)
+static ssize_t chip_name_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
-
-	raw_spin_lock_irq(&desc->lock);
-	if (desc->irq_data.chip && desc->irq_data.chip->name) {
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n",
-				desc->irq_data.chip->name);
-	}
-	raw_spin_unlock_irq(&desc->lock);
 
-	return ret;
+	guard(raw_spinlock_irq)(&desc->lock);
+	if (desc->irq_data.chip && desc->irq_data.chip->name)
+		return scnprintf(buf, PAGE_SIZE, "%s\n", desc->irq_data.chip->name);
+	return 0;
 }
 IRQ_ATTR_RO(chip_name);
 
-static ssize_t hwirq_show(struct kobject *kobj,
-			  struct kobj_attribute *attr, char *buf)
+static ssize_t hwirq_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
-
-	raw_spin_lock_irq(&desc->lock);
-	if (desc->irq_data.domain)
-		ret = sprintf(buf, "%lu\n", desc->irq_data.hwirq);
-	raw_spin_unlock_irq(&desc->lock);
 
-	return ret;
+	guard(raw_spinlock_irq)(&desc->lock);
+	return desc->irq_data.domain ? sprintf(buf, "%lu\n", desc->irq_data.hwirq) : 0;
 }
 IRQ_ATTR_RO(hwirq);
 
-static ssize_t type_show(struct kobject *kobj,
-			 struct kobj_attribute *attr, char *buf)
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
-
-	raw_spin_lock_irq(&desc->lock);
-	ret = sprintf(buf, "%s\n",
-		      irqd_is_level_type(&desc->irq_data) ? "level" : "edge");
-	raw_spin_unlock_irq(&desc->lock);
-
-	return ret;
 
+	guard(raw_spinlock_irq)(&desc->lock);
+	return sprintf(buf, "%s\n", irqd_is_level_type(&desc->irq_data) ? "level" : "edge");
 }
 IRQ_ATTR_RO(type);
 
-static ssize_t wakeup_show(struct kobject *kobj,
-			   struct kobj_attribute *attr, char *buf)
+static ssize_t wakeup_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
-
-	raw_spin_lock_irq(&desc->lock);
-	ret = sprintf(buf, "%s\n", str_enabled_disabled(irqd_is_wakeup_set(&desc->irq_data)));
-	raw_spin_unlock_irq(&desc->lock);
-
-	return ret;
 
+	guard(raw_spinlock_irq)(&desc->lock);
+	return sprintf(buf, "%s\n", str_enabled_disabled(irqd_is_wakeup_set(&desc->irq_data)));
 }
 IRQ_ATTR_RO(wakeup);
 
-static ssize_t name_show(struct kobject *kobj,
-			 struct kobj_attribute *attr, char *buf)
+static ssize_t name_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
 
-	raw_spin_lock_irq(&desc->lock);
-	if (desc->name)
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n", desc->name);
-	raw_spin_unlock_irq(&desc->lock);
-
-	return ret;
+	guard(raw_spinlock_irq)(&desc->lock);
+	return desc->name ? scnprintf(buf, PAGE_SIZE, "%s\n", desc->name) : 0;
 }
 IRQ_ATTR_RO(name);
 
-static ssize_t actions_show(struct kobject *kobj,
-			    struct kobj_attribute *attr, char *buf)
+static ssize_t actions_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
 	struct irqaction *action;
 	ssize_t ret = 0;
 	char *p = "";
 
-	raw_spin_lock_irq(&desc->lock);
-	for_each_action_of_desc(desc, action) {
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
-				 p, action->name);
-		p = ",";
+	scoped_guard (raw_spinlock_irq, &desc->lock) {
+		for_each_action_of_desc(desc, action) {
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s", p, action->name);
+			p = ",";
+		}
 	}
-	raw_spin_unlock_irq(&desc->lock);
-
-	if (ret)
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
 
-	return ret;
+	return ret ? ret + scnprintf(buf + ret, PAGE_SIZE - ret, "\n") : 0;
 }
 IRQ_ATTR_RO(actions);
 
@@ -418,19 +382,14 @@ static int __init irq_sysfs_init(void)
 	int irq;
 
 	/* Prevent concurrent irq alloc/free */
-	irq_lock_sparse();
-
+	guard(mutex)(&sparse_irq_lock);
 	irq_kobj_base = kobject_create_and_add("irq", kernel_kobj);
-	if (!irq_kobj_base) {
-		irq_unlock_sparse();
+	if (!irq_kobj_base)
 		return -ENOMEM;
-	}
 
 	/* Add the already allocated interrupts */
 	for_each_irq_desc(irq, desc)
 		irq_sysfs_add(irq, desc);
-	irq_unlock_sparse();
-
 	return 0;
 }
 postcore_initcall(irq_sysfs_init);
@@ -573,12 +532,12 @@ static int alloc_descs(unsigned int star
 	return -ENOMEM;
 }
 
-static int irq_expand_nr_irqs(unsigned int nr)
+static bool irq_expand_nr_irqs(unsigned int nr)
 {
 	if (nr > MAX_SPARSE_IRQS)
-		return -ENOMEM;
+		return false;
 	nr_irqs = nr;
-	return 0;
+	return true;
 }
 
 int __init early_irq_init(void)
@@ -656,11 +615,9 @@ EXPORT_SYMBOL(irq_to_desc);
 static void free_desc(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	scoped_guard (raw_spinlock_irqsave, &desc->lock)
+		desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
 	delete_irq_desc(irq);
 }
 
@@ -681,14 +638,13 @@ static inline int alloc_descs(unsigned i
 
 static int irq_expand_nr_irqs(unsigned int nr)
 {
-	return -ENOMEM;
+	return false;
 }
 
 void irq_mark_irq(unsigned int irq)
 {
-	mutex_lock(&sparse_irq_lock);
+	guard(mutex)(&sparse_irq_lock);
 	irq_insert_desc(irq, irq_desc + irq);
-	mutex_unlock(&sparse_irq_lock);
 }
 
 #ifdef CONFIG_GENERIC_IRQ_LEGACY
@@ -827,11 +783,9 @@ void irq_free_descs(unsigned int from, u
 	if (from >= nr_irqs || (from + cnt) > nr_irqs)
 		return;
 
-	mutex_lock(&sparse_irq_lock);
+	guard(mutex)(&sparse_irq_lock);
 	for (i = 0; i < cnt; i++)
 		free_desc(from + i);
-
-	mutex_unlock(&sparse_irq_lock);
 }
 EXPORT_SYMBOL_GPL(irq_free_descs);
 
@@ -848,11 +802,10 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
  *
  * Returns the first irq number or error code
  */
-int __ref
-__irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		  struct module *owner, const struct irq_affinity_desc *affinity)
+int __ref __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
+			    struct module *owner, const struct irq_affinity_desc *affinity)
 {
-	int start, ret;
+	int start;
 
 	if (!cnt)
 		return -EINVAL;
@@ -870,22 +823,17 @@ int __ref
 		from = arch_dynirq_lower_bound(from);
 	}
 
-	mutex_lock(&sparse_irq_lock);
+	guard(mutex)(&sparse_irq_lock);
 
 	start = irq_find_free_area(from, cnt);
-	ret = -EEXIST;
 	if (irq >=0 && start != irq)
-		goto unlock;
+		return -EEXIST;
 
 	if (start + cnt > nr_irqs) {
-		ret = irq_expand_nr_irqs(start + cnt);
-		if (ret)
-			goto unlock;
+		if (!irq_expand_nr_irqs(start + cnt))
+			return -ENOMEM;
 	}
-	ret = alloc_descs(start, cnt, node, affinity, owner);
-unlock:
-	mutex_unlock(&sparse_irq_lock);
-	return ret;
+	return alloc_descs(start, cnt, node, affinity, owner);
 }
 EXPORT_SYMBOL_GPL(__irq_alloc_descs);
 


