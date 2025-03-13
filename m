Return-Path: <linux-kernel+bounces-559868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB63AA5FAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFC019C6307
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5326269896;
	Thu, 13 Mar 2025 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aK0DSb2O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LIupAmLb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F726B2CD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881606; cv=none; b=gxMGI01x6VigYaIjklc08s4inV0Dyhiy2h92tgenAYw8S3Lzfot+4lkJCxlzDGAEfsFLoCdxBI+pUtY3eT/Ze2r4AgP+VTZYoCZFiNDJexjcWwYn2EK4LCkAbuzWcorb3b7KLCivJ8M1autIa+AaoYIPWFTBaerOi+fOS69zAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881606; c=relaxed/simple;
	bh=DeAIFcoJ+3BK85qfp+og+otEJSRQmyghxY1r0UFRW0Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ishNV1TdD+lOmMWEIFn0jDgDzvpeMKReoe23QJzlqMIZm5v/+VecmLtDoDQDoke0kFCdBaZiN8o/aHHLmuM5kKlr6PJxwKLZWSrRuzYqHo8gmMqhoSY1DXAvB2bpuwg2Cu4bVkv+DOE54EXmttCsv28Ei5tCOlJJRnn3OiaNMV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aK0DSb2O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LIupAmLb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.675005577@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0QyH5gseyEzpnbzDVArTJJZpJ/ETcuGqcMoalcKD/+g=;
	b=aK0DSb2OIlGxkoGcKiQYvhZ9hITO/avRcxipr/AKbPguZR1g8aEz/7ogcBndtCC+NaGrbS
	l8xHSwQwoC2jcdkN5q++JXm/scBEcdmLr+vJwnsruVV2EHjKxj1WoNz3u9lUKO4mGYia9t
	MOod/W5Txew9TR/0oew7E2+kdCgrPIVtTBnLmagV7Terjimyu9YMfEiw4rhJf8RbPuDv27
	QfNczuea1PC687X1sPS2nVgpj2yJQ9uXR7iFDn3lcIRtyCK1B3yDXfXxRXSD6pME/VLeYD
	6s3t7hWiPAsdDGNlTJbj0UC46Dy3W08Lc19LF2Wb1/qW1HFr22CxfyHbpe7IKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0QyH5gseyEzpnbzDVArTJJZpJ/ETcuGqcMoalcKD/+g=;
	b=LIupAmLbORKjFHjA1VyGXPXm0MWTKnCdQCel/gTQddpdvjaBcK14fW5od5kW0gd2gMptlA
	AvHB8sDv2SAoWqDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 12/46] genirq/chip: Rework handle_nested_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:02 +0100 (CET)

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   78 ++++++++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -450,48 +450,6 @@ void unmask_threaded_irq(struct irq_desc
 	unmask_irq(desc);
 }
 
-/*
- *	handle_nested_irq - Handle a nested irq from a irq thread
- *	@irq:	the interrupt number
- *
- *	Handle interrupts which are nested into a threaded interrupt
- *	handler. The handler function is called inside the calling
- *	threads context.
- */
-void handle_nested_irq(unsigned int irq)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-	struct irqaction *action;
-	irqreturn_t action_ret;
-
-	might_sleep();
-
-	raw_spin_lock_irq(&desc->lock);
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	action = desc->action;
-	if (unlikely(!action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
-		raw_spin_unlock_irq(&desc->lock);
-		return;
-	}
-
-	kstat_incr_irqs_this_cpu(desc);
-	atomic_inc(&desc->threads_active);
-	raw_spin_unlock_irq(&desc->lock);
-
-	action_ret = IRQ_NONE;
-	for_each_action_of_desc(desc, action)
-		action_ret |= action->thread_fn(action->irq, action->dev_id);
-
-	if (!irq_settings_no_debug(desc))
-		note_interrupt(desc, action_ret);
-
-	wake_threads_waitq(desc);
-}
-EXPORT_SYMBOL_GPL(handle_nested_irq);
-
 static bool irq_check_poll(struct irq_desc *desc)
 {
 	if (!(desc->istate & IRQS_POLL_INPROGRESS))
@@ -544,6 +502,42 @@ static inline bool irq_can_handle(struct
 }
 
 /**
+ * handle_nested_irq - Handle a nested irq from a irq thread
+ * @irq:	the interrupt number
+ *
+ * Handle interrupts which are nested into a threaded interrupt
+ * handler. The handler function is called inside the calling threads
+ * context.
+ */
+void handle_nested_irq(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irqaction *action;
+	irqreturn_t action_ret;
+
+	might_sleep();
+
+	scoped_guard (raw_spinlock_irq, &desc->lock) {
+		if (irq_can_handle_actions(desc))
+			return;
+
+		action = desc->action;
+		kstat_incr_irqs_this_cpu(desc);
+		atomic_inc(&desc->threads_active);
+	}
+
+	action_ret = IRQ_NONE;
+	for_each_action_of_desc(desc, action)
+		action_ret |= action->thread_fn(action->irq, action->dev_id);
+
+	if (!irq_settings_no_debug(desc))
+		note_interrupt(desc, action_ret);
+
+	wake_threads_waitq(desc);
+}
+EXPORT_SYMBOL_GPL(handle_nested_irq);
+
+/**
  *	handle_simple_irq - Simple and software-decoded IRQs.
  *	@desc:	the interrupt description structure for this irq
  *


