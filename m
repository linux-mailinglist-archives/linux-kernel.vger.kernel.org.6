Return-Path: <linux-kernel+bounces-266214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C1293FC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BEB1C2160E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C711607A1;
	Mon, 29 Jul 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h45ne54h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7DkM/6j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C187603A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275054; cv=none; b=Qa+7K1Jjgn4qar1p29HpTayFN5GiaQcLrYb1kRwERakp6+BD+an+ttW9mjCnFA8nZVI1YNj4rfePGtbf3PFqGaNn0j1zMhLQrl1jECzZzCtjhimfs1G9wof+bCxH4Q+V25ZTKUL7N3xblupVMTzlDlT9M8AQERq3tGTQ5gaUgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275054; c=relaxed/simple;
	bh=3ZbbyYLavJnNgwF/dxPkEMw/CSb6lryQly9CUruVttw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D16OI1JXd+7IR91Jes/b8OTLxvo2Kg1sD/FTF+iVc1t8XtVD/XE2MRHI++ozjnywT5mWOYLvgONZw7X9uVnw3CkfyKJfnwWxX3xQv6clw7vc/ZwDeC0Ywc77PgRhYCr0oXdQKqMqiwRwMNcfFRV6fHP+TgxtdykL90RkSheIB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h45ne54h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I7DkM/6j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722275050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UR7j056kBeqA/y85jD/XvZyYPoCK+5ZQRQSva+HT7yk=;
	b=h45ne54hVSCmpgBX2gZBYa6L08BXHDfGS+eZvOfnNg3EUpWC5z9pZZAhZkNsn1rLWIrOkz
	KbstIKk+SQX3YR66ySRWuf1p2vDTrHabsj9Y5hoEUmO5mx/O26nN9xBUUthfi5ZSg83v1I
	5MIxo0W+pRa81Nq+NHHc3McrwOpaiw16ljNsCN0HnOi4Y/CRJu8Pek8hSEZPn+6LtSHI8K
	WQ6GwyLDqczVgk2N0BcDDaHffUq/ErmWUW39zCA0zFdJFof4gcUzWTNFastmu43U6pk/6r
	35xSgise5TqhzcY/GSjcKRoF4lpneOEjHEJkM2M8IrK0XqhPl1QSG9QZe9dFXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722275050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UR7j056kBeqA/y85jD/XvZyYPoCK+5ZQRQSva+HT7yk=;
	b=I7DkM/6j35AENgrZRyoNm15Oh3Bf9A0dugig+UApWtqsBB0RmUCmlY4SL6+FmZtsrZxniZ
	JFPmzqrZge23NkAQ==
To: Breno Leitao <leitao@debian.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, leit@meta.com, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Wei Liu <wei.liu@kernel.org>, Marc Zyngier
 <maz@kernel.org>, Adrian Huang <ahuang12@lenovo.com>, "open list:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/apic: Add retry mechanism to add_pin_to_irq_node()
In-Reply-To: <ZqfJmUF8sXIyuSHN@gmail.com>
References: <20240729140604.2814597-1-leitao@debian.org>
 <874j8889ch.ffs@tglx> <ZqfJmUF8sXIyuSHN@gmail.com>
Date: Mon, 29 Jul 2024 19:44:09 +0200
Message-ID: <871q3c855i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno!

On Mon, Jul 29 2024 at 09:55, Breno Leitao wrote:
>> > 	 panic
>> > 	   _printk
>> > 	   panic_smp_self_stop
>> > 	   rcu_is_watching
>> > 	   intel_irq_remapping_free
>> 
>> This completely lacks context. When does this happen? What's the system
>> state? What has intel_irq_remapping_free() to do with the allocation path?
>
> Sorry, let me clarify it a bit better:
>
> 1) This happens when the machine is booted up, and being under stress
> 2) This happens when I have failslab fault injection enabled.
> 3) The machine crashes after hitting this error.
> 4) This is reproducible with `stress-ng` using the `--aggressive` parameter
> 5) This is the full stack (sorry for not decoding the stack, but if you
>    need it, I am more than happy to give you a decoded stack)

Ok. That makes sense.

>> While it seems to make sense, the reality is that this is mostly early
>> boot code. If there is a real world memory allocation failure during
>> early boot then retries will not help at all.
>
> This is not happening at early boot, this is reproducible when running
> stress-ng in this aggressive mode.
>
> Since I have failslab injecting a kmalloc fault,
> __add_pin_to_irq_noder() returns -ENOMEM, which causes the undesired
> panic().

Fine. During runtime that allocation fail should not be fatal. It just
needs to be properly propagated.

>> > Introduce a retry mechanism that attempts to add the pin up to 3 times
>> > before giving up and panicking. This should improve the robustness of
>> > the IO-APIC code in the face of transient errors.
>> 
>> I'm absolutely not convinced by this loop heuristic. That's just a bad
>> hack.
>
> I will not disagree with you here, but I need to use this patch in order
> to be able t keep the system not panicking and stable while fault
> injecting slab errors and trying to reproduce a real bug in the network
> stack.

Something like the untested below should just work.

Thanks,

        tglx
---
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -352,27 +352,26 @@ static void ioapic_mask_entry(int apic,
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static int __add_pin_to_irq_node(struct mp_chip_data *data,
-				 int node, int apic, int pin)
+static bool add_pin_to_irq_node(struct mp_chip_data *data, int node, int apic, int pin)
 {
 	struct irq_pin_list *entry;
 
 	/* don't allow duplicates */
-	for_each_irq_pin(entry, data->irq_2_pin)
+	for_each_irq_pin(entry, data->irq_2_pin) {
 		if (entry->apic == apic && entry->pin == pin)
-			return 0;
+			return true;
+	}
 
 	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_ATOMIC, node);
 	if (!entry) {
-		pr_err("can not alloc irq_pin_list (%d,%d,%d)\n",
-		       node, apic, pin);
-		return -ENOMEM;
+		pr_err("can not alloc irq_pin_list (%d,%d,%d)\n", node, apic, pin);
+		return false;
 	}
+
 	entry->apic = apic;
 	entry->pin = pin;
 	list_add_tail(&entry->list, &data->irq_2_pin);
-
-	return 0;
+	return true;
 }
 
 static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
@@ -387,35 +386,6 @@ static void __remove_pin_from_irq(struct
 		}
 }
 
-static void add_pin_to_irq_node(struct mp_chip_data *data,
-				int node, int apic, int pin)
-{
-	if (__add_pin_to_irq_node(data, node, apic, pin))
-		panic("IO-APIC: failed to add irq-pin. Can not proceed\n");
-}
-
-/*
- * Reroute an IRQ to a different pin.
- */
-static void __init replace_pin_at_irq_node(struct mp_chip_data *data, int node,
-					   int oldapic, int oldpin,
-					   int newapic, int newpin)
-{
-	struct irq_pin_list *entry;
-
-	for_each_irq_pin(entry, data->irq_2_pin) {
-		if (entry->apic == oldapic && entry->pin == oldpin) {
-			entry->apic = newapic;
-			entry->pin = newpin;
-			/* every one is different, right? */
-			return;
-		}
-	}
-
-	/* old apic/pin didn't exist, so just add new ones */
-	add_pin_to_irq_node(data, node, newapic, newpin);
-}
-
 static void io_apic_modify_irq(struct mp_chip_data *data, bool masked,
 			       void (*final)(struct irq_pin_list *entry))
 {
@@ -1002,8 +972,7 @@ static int alloc_isa_irq_from_domain(str
 	if (irq_data && irq_data->parent_data) {
 		if (!mp_check_pin_attr(irq, info))
 			return -EBUSY;
-		if (__add_pin_to_irq_node(irq_data->chip_data, node, ioapic,
-					  info->ioapic.pin))
+		if (!add_pin_to_irq_node(irq_data->chip_data, node, ioapic, info->ioapic.pin))
 			return -ENOMEM;
 	} else {
 		info->flags |= X86_IRQ_ALLOC_LEGACY;
@@ -2131,10 +2100,10 @@ static int __init disable_timer_pin_setu
 }
 early_param("disable_timer_pin_1", disable_timer_pin_setup);
 
-static int mp_alloc_timer_irq(int ioapic, int pin)
+static int __init mp_alloc_timer_irq(int ioapic, int pin)
 {
-	int irq = -1;
 	struct irq_domain *domain = mp_ioapic_irqdomain(ioapic);
+	int irq = -1;
 
 	if (domain) {
 		struct irq_alloc_info info;
@@ -2150,6 +2119,24 @@ static int mp_alloc_timer_irq(int ioapic
 	return irq;
 }
 
+static void __init replace_pin_at_irq_node(struct mp_chip_data *data, int node,
+					   int oldapic, int oldpin,
+					   int newapic, int newpin)
+{
+	struct irq_pin_list *entry;
+
+	for_each_irq_pin(entry, data->irq_2_pin) {
+		if (entry->apic == oldapic && entry->pin == oldpin) {
+			entry->apic = newapic;
+			entry->pin = newpin;
+			return;
+		}
+	}
+
+	/* Old apic/pin didn't exist, so just add a new one */
+	add_pin_to_irq_node(data, node, newapic, newpin);
+}
+
 /*
  * This code may look a bit paranoid, but it's supposed to cooperate with
  * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
@@ -2996,9 +2983,9 @@ int mp_irqdomain_alloc(struct irq_domain
 		       unsigned int nr_irqs, void *arg)
 {
 	struct irq_alloc_info *info = arg;
+	int ret = -ENOMEM, ioapic, pin;
 	struct mp_chip_data *data;
 	struct irq_data *irq_data;
-	int ret, ioapic, pin;
 	unsigned long flags;
 
 	if (!info || nr_irqs > 1)
@@ -3016,22 +3003,21 @@ int mp_irqdomain_alloc(struct irq_domain
 	if (!data)
 		return -ENOMEM;
 
-	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
-	if (ret < 0) {
-		kfree(data);
-		return ret;
-	}
-
 	INIT_LIST_HEAD(&data->irq_2_pin);
 	irq_data->hwirq = info->ioapic.pin;
 	irq_data->chip = (domain->parent == x86_vector_domain) ?
 			  &ioapic_chip : &ioapic_ir_chip;
 	irq_data->chip_data = data;
 	mp_irqdomain_get_attr(mp_pin_to_gsi(ioapic, pin), data, info);
+	mp_preconfigure_entry(data);
 
-	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
+	if (!add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin))
+		goto out_data;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
+	if (ret < 0)
+		goto out_pin;
 
-	mp_preconfigure_entry(data);
 	mp_register_handler(virq, data->is_level);
 
 	local_irq_save(flags);
@@ -3044,6 +3030,12 @@ int mp_irqdomain_alloc(struct irq_domain
 		    ioapic, mpc_ioapic_id(ioapic), pin, virq,
 		    data->is_level, data->active_low);
 	return 0;
+
+out_pin:
+	__remove_pin_from_irq(data, ioapic, (int)irq_data->hwirq);
+out_data:
+	kfree(data);
+	return ret;
 }
 
 void mp_irqdomain_free(struct irq_domain *domain, unsigned int virq,

