Return-Path: <linux-kernel+bounces-559874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C1EA5FAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AEA8822AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC27477104;
	Thu, 13 Mar 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CDenwpdK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s81nQXk8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02726D5D9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881615; cv=none; b=tYGjataAGrq2pqI74DBuswkZQtt2IVLTQ1BSuzgOgRJu3/lPLCkuTedptPnZacikHCSzFxjzFZFZbp7sNWPUzORaBRDJIobL2+aTc61z1+R+FzBFdEIAupM/MJEM4VUJDQg2WN9/MN6B2fg0vJ8AFI10gTxUnBnaTHq3OhgLOf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881615; c=relaxed/simple;
	bh=0eKkvuqFSp6vxp+jRrwS/VA28lWYTAA5kR/e4n8yz2w=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lpCZoQXX/URJXnsoC42OvClPNe4XyZOBi7zV2TkJIK0qGdSFf9RlOfADgM8MYCn1EwfMDAeC+jZhAKq6P0bVB/LhVTFgdJcz3tvj5R1GHUvQQizpNwMoNJhOqo9XhlKuUYuEcVOqwB40uo949O2GR7fGyWsDPC8mpjsNXS3c5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CDenwpdK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s81nQXk8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.025486178@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ft+O9QRslr5GYC25zM4McalUWCmc7dV25og/dDV+Foo=;
	b=CDenwpdKMBvC/sMDiTRC/EUSS62yCuYVZiMRBEjrVN3TwhW5zJ38xDZYvKgSYIYWd76uNs
	5QCMf2Q1XA+awrOWfw42NAfqITCmQzNaOkzDxY2PKnR5d3yIHkPkgjyk9ukkFkvwCw7sVM
	GuKHX2rjtEatgSWqbm5MYe+v7x1n5CTVxuwyQ7g0MAL5tLaeuCbgdVJvcuEy/ftUgy6BFw
	wViszPaA89AA9rwFNxYvZAk/JpoiG+oWPd79qa/+FZbrYKj3LioQFUTgXCeQo/cXWbqCC2
	NEM+vI4NKRptYQWRp/IqqeShBiUhIotlusiweHU9gqTdoATWm10BmAZvItG+RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ft+O9QRslr5GYC25zM4McalUWCmc7dV25og/dDV+Foo=;
	b=s81nQXk8sPxBv7fu2MeVgZrEasPpnvrnfSsKB7RSEWE334+5a8BtKNM7rV6QVIO+mJFXla
	83YfgC4J/4WDJVCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 17/46] genirq/chip: Rework handle_edge_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:11 +0100 (CET)

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   49 ++++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -742,40 +742,27 @@ void handle_fasteoi_nmi(struct irq_desc
 EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
 
 /**
- *	handle_edge_irq - edge type IRQ handler
- *	@desc:	the interrupt description structure for this irq
+ * handle_edge_irq - edge type IRQ handler
+ * @desc:	the interrupt description structure for this irq
  *
- *	Interrupt occurs on the falling and/or rising edge of a hardware
- *	signal. The occurrence is latched into the irq controller hardware
- *	and must be acked in order to be reenabled. After the ack another
- *	interrupt can happen on the same source even before the first one
- *	is handled by the associated event handler. If this happens it
- *	might be necessary to disable (mask) the interrupt depending on the
- *	controller hardware. This requires to reenable the interrupt inside
- *	of the loop which handles the interrupts which have arrived while
- *	the handler was running. If all pending interrupts are handled, the
- *	loop is left.
+ * Interrupt occurs on the falling and/or rising edge of a hardware
+ * signal. The occurrence is latched into the irq controller hardware and
+ * must be acked in order to be reenabled. After the ack another interrupt
+ * can happen on the same source even before the first one is handled by
+ * the associated event handler. If this happens it might be necessary to
+ * disable (mask) the interrupt depending on the controller hardware. This
+ * requires to reenable the interrupt inside of the loop which handles the
+ * interrupts which have arrived while the handler was running. If all
+ * pending interrupts are handled, the loop is left.
  */
 void handle_edge_irq(struct irq_desc *desc)
 {
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	if (!irq_can_handle_pm(desc)) {
-		desc->istate |= IRQS_PENDING;
-		mask_ack_irq(desc);
-		goto out_unlock;
-	}
-
-	/*
-	 * If its disabled or no action available then mask it and get
-	 * out of here.
-	 */
-	if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
+	if (!irq_can_handle(desc)) {
 		desc->istate |= IRQS_PENDING;
 		mask_ack_irq(desc);
-		goto out_unlock;
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
@@ -786,7 +773,7 @@ void handle_edge_irq(struct irq_desc *de
 	do {
 		if (unlikely(!desc->action)) {
 			mask_irq(desc);
-			goto out_unlock;
+			return;
 		}
 
 		/*
@@ -802,11 +789,7 @@ void handle_edge_irq(struct irq_desc *de
 
 		handle_irq_event(desc);
 
-	} while ((desc->istate & IRQS_PENDING) &&
-		 !irqd_irq_disabled(&desc->irq_data));
-
-out_unlock:
-	raw_spin_unlock(&desc->lock);
+	} while ((desc->istate & IRQS_PENDING) && !irqd_irq_disabled(&desc->irq_data));
 }
 EXPORT_SYMBOL(handle_edge_irq);
 


