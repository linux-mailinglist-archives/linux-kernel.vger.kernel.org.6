Return-Path: <linux-kernel+bounces-559864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6670AA5FAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C4881882
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030CE26983A;
	Thu, 13 Mar 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uganGIAH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0TZF+5P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28EE26982D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881600; cv=none; b=TuvSPZWMcAhGTXhB2MKtauYHLIQ8wD6HYggyGmqclNuFUTca2K/eZJEo7g6j15q+cWMd/bZSsidOq6r4M9jXKx+u55aoqnp/VFXdeu3SOWaekMJvneBW/1fmlC90PbV71xSVH5RX1b+WU5R5dM/ymTM8LIqUzlrTI4uTIXNxHEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881600; c=relaxed/simple;
	bh=Nr8MDFSzC9BiU6791X4HYjhJnXQXWAAGArxTTP+vc0Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=i3x6K/80ezYqhI2PuOIBLdkfV0MMlLd6BnbvJvnqDAFGgQCZUs2bD5iObarrxfLvxaRVtX/eE7tpk/dTZU9SPC5UB7OSRuboU5xo8n/csjF06X+czJEiFVTbasa4d/ubOSaJlr8Byy9azF7m69IVBpCTNTp6PmQU39bcmVcM9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uganGIAH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0TZF+5P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.408460923@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DU6XMVOUDxJPH8jcWvqONJ1ImJNmXAVWjdvJGxN/vho=;
	b=uganGIAH5do37fVQrvHA3jGKN2sT8AdpKaBBLNNgkMuW8M7Gp51asa0EQ4FT4EGs55JIJP
	ezGtXW0sVVTKoFkHKWjwrjxnf0RYXz6Qoowtppzcj5clu5NUF5oeSr+qQzWNkOBlPPuIui
	VYfbC9WWoRy2EPs9TKXxKpNTNnwbtFlA6emteQomwbQHEh7b8/q1XJOhaEoFI79OJbYZIL
	5JhBz844s+q56d3+yxR2ozf8dWHqE8xMnngK10+QFGBeuQBW/Y1usPXeHVMO42F4wrlAZN
	fY2TurSeE1isJWtY29mq1COoh9k6332Zs2DZqERtnFaYpdmhDCphG/RQO/axRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DU6XMVOUDxJPH8jcWvqONJ1ImJNmXAVWjdvJGxN/vho=;
	b=U0TZF+5PPkWENab+vZ/z9BUnOk2KxKgnHYI0bC5NpHgUzUt2BDyHcHpzY+yAQC4zDQ6d0d
	yOyNdX0ZcrkSHkBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 08/46] genirq/spurious: Switch to lock guards
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 16:59:55 +0100 (CET)

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/spurious.c |   30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -60,37 +60,35 @@ bool irq_wait_for_poll(struct irq_desc *
 /*
  * Recovery handler for misrouted interrupts.
  */
-static int try_one_irq(struct irq_desc *desc, bool force)
+static bool try_one_irq(struct irq_desc *desc, bool force)
 {
-	irqreturn_t ret = IRQ_NONE;
 	struct irqaction *action;
+	bool ret = false;
 
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 
 	/*
 	 * PER_CPU, nested thread interrupts and interrupts explicitly
 	 * marked polled are excluded from polling.
 	 */
-	if (irq_settings_is_per_cpu(desc) ||
-	    irq_settings_is_nested_thread(desc) ||
+	if (irq_settings_is_per_cpu(desc) || irq_settings_is_nested_thread(desc) ||
 	    irq_settings_is_polled(desc))
-		goto out;
+		return false;
 
 	/*
 	 * Do not poll disabled interrupts unless the spurious
 	 * disabled poller asks explicitly.
 	 */
 	if (irqd_irq_disabled(&desc->irq_data) && !force)
-		goto out;
+		return false;
 
 	/*
 	 * All handlers must agree on IRQF_SHARED, so we test just the
 	 * first.
 	 */
 	action = desc->action;
-	if (!action || !(action->flags & IRQF_SHARED) ||
-	    (action->flags & __IRQF_TIMER))
-		goto out;
+	if (!action || !(action->flags & IRQF_SHARED) || (action->flags & __IRQF_TIMER))
+		return false;
 
 	/* Already running on another processor */
 	if (irqd_irq_inprogress(&desc->irq_data)) {
@@ -99,21 +97,19 @@ static int try_one_irq(struct irq_desc *
 		 * CPU to go looking for our mystery interrupt too
 		 */
 		desc->istate |= IRQS_PENDING;
-		goto out;
+		return false;
 	}
 
 	/* Mark it poll in progress */
 	desc->istate |= IRQS_POLL_INPROGRESS;
 	do {
 		if (handle_irq_event(desc) == IRQ_HANDLED)
-			ret = IRQ_HANDLED;
+			ret = true;
 		/* Make sure that there is still a valid action */
 		action = desc->action;
 	} while ((desc->istate & IRQS_PENDING) && action);
 	desc->istate &= ~IRQS_POLL_INPROGRESS;
-out:
-	raw_spin_unlock(&desc->lock);
-	return ret == IRQ_HANDLED;
+	return ret;
 }
 
 static int misrouted_irq(int irq)
@@ -192,7 +188,6 @@ static void __report_bad_irq(struct irq_
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct irqaction *action;
-	unsigned long flags;
 
 	if (bad_action_ret(action_ret))
 		pr_err("irq event %d: bogus return value %x\n", irq, action_ret);
@@ -207,14 +202,13 @@ static void __report_bad_irq(struct irq_
 	 * with something else removing an action. It's ok to take
 	 * desc->lock here. See synchronize_irq().
 	 */
-	raw_spin_lock_irqsave(&desc->lock, flags);
+	guard(raw_spinlock_irqsave)(&desc->lock);
 	for_each_action_of_desc(desc, action) {
 		pr_err("[<%p>] %ps", action->handler, action->handler);
 		if (action->thread_fn)
 			pr_cont(" threaded [<%p>] %ps", action->thread_fn, action->thread_fn);
 		pr_cont("\n");
 	}
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
 
 static void report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)


