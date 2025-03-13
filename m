Return-Path: <linux-kernel+bounces-559860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37941A5FAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B49A17DAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17EF269810;
	Thu, 13 Mar 2025 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yqz9oADB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YRJNLEm8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3F26A0C6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881592; cv=none; b=l+te+frWtpcrvuLh/sB4dE6EtcmmDUqsoJlflJBvrxlOY/U/ccb7SoYg4fLBSpDxzqzeQFJURprZlsK+HdfIrczYHIpubUln38KSd9U6FY5Ja+6LhQ42Y2Z1Re0m6VWx9stvtIO4cvGHOyMz4QkZ+vUITBBo1m8n8uTekuGwaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881592; c=relaxed/simple;
	bh=ntM8kArfe0z/VjhhrlgBHB8lnNjQHLxcq2864LhbFUg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=NoT/kn8CIWjqolYYRZHDaLT+0wxudYSd0TGU3uPQh8Y9rp6evoXuG8Bzro0fb2HkU8o9SVHUwDDAgJPLngjEaPkZOHADteRZqc7rsBzLuAznMpGXfkbzjqk6G+08WMaP9bP3U3fbVOygaCdXD/SibIbDOP+eyfk9h3W678DTBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yqz9oADB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YRJNLEm8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.142099076@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zhvgbTp0hOygVEusPPs0+mNX6DOrLT/xrzx98rZIlSk=;
	b=Yqz9oADB1sWLue193XFQ4oIBUHmRTqGOUoQEnKN9XYAFrczT3X2Ga65xRqXVdnu6ZsdvoD
	hKtdrUMf/3uxO4f3bseXTof43XEQTw9aW7NC2zxqxEVGLY3oGyocFQfOh7e3ihQjaekEki
	RbtWefnfiYEynnA9A9uszFZ2NYP0alZag3/EllwR1dW1mrTxKkE8EllAO1vR0SI3tNSUN9
	CpIsaouICz9mjvu0uXJfWR/C6mlDLnuhqB5mD1EIkI7YRumraB0CTHhbOf6cA9k7eZqHMb
	Y/5z/WthCX3zRYLi/BIGtUvwB/azNkAjeuljpzZzeoqNXHJrIxc4JYmNnVnfzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zhvgbTp0hOygVEusPPs0+mNX6DOrLT/xrzx98rZIlSk=;
	b=YRJNLEm8V5yGk/YTfu47XHj4Kvbo2i9NYMiinRUrk7yPw2dqj2EwIZ1M/a0I/yyU/jZN9a
	sa1d68ehNVtmH4CQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 04/46] genirq/pm: Switch to lock guards
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 16:59:48 +0100 (CET)

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/pm.c |   38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -46,8 +46,7 @@ void irq_pm_install_action(struct irq_de
 		desc->cond_suspend_depth++;
 
 	WARN_ON_ONCE(desc->no_suspend_depth &&
-		     (desc->no_suspend_depth +
-			desc->cond_suspend_depth) != desc->nr_actions);
+		     (desc->no_suspend_depth + desc->cond_suspend_depth) != desc->nr_actions);
 }
 
 /*
@@ -134,14 +133,12 @@ void suspend_device_irqs(void)
 	int irq;
 
 	for_each_irq_desc(irq, desc) {
-		unsigned long flags;
 		bool sync;
 
 		if (irq_settings_is_nested_thread(desc))
 			continue;
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		sync = suspend_device_irq(desc);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		scoped_guard (raw_spinlock_irqsave, &desc->lock)
+			sync = suspend_device_irq(desc);
 
 		if (sync)
 			synchronize_irq(irq);
@@ -186,18 +183,15 @@ static void resume_irqs(bool want_early)
 	int irq;
 
 	for_each_irq_desc(irq, desc) {
-		unsigned long flags;
-		bool is_early = desc->action &&
-			desc->action->flags & IRQF_EARLY_RESUME;
+		bool is_early = desc->action &&	desc->action->flags & IRQF_EARLY_RESUME;
 
 		if (!is_early && want_early)
 			continue;
 		if (irq_settings_is_nested_thread(desc))
 			continue;
 
-		raw_spin_lock_irqsave(&desc->lock, flags);
+		guard(raw_spinlock_irqsave)(&desc->lock);
 		resume_irq(desc);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
 
@@ -207,22 +201,16 @@ static void resume_irqs(bool want_early)
  */
 void rearm_wake_irq(unsigned int irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	if (!desc)
-		return;
-
-	if (!(desc->istate & IRQS_SUSPENDED) ||
-	    !irqd_is_wakeup_set(&desc->irq_data))
-		goto unlock;
-
-	desc->istate &= ~IRQS_SUSPENDED;
-	irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
-	__enable_irq(desc);
+		if (!(desc->istate & IRQS_SUSPENDED) || !irqd_is_wakeup_set(&desc->irq_data))
+			return;
 
-unlock:
-	irq_put_desc_busunlock(desc, flags);
+		desc->istate &= ~IRQS_SUSPENDED;
+		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
+		__enable_irq(desc);
+	}
 }
 
 /**


