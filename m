Return-Path: <linux-kernel+bounces-559876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674DDA5FAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434F67AA30C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F626E62F;
	Thu, 13 Mar 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DHNIrRNM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dAKYmhQ8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5226E16E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881618; cv=none; b=CIIsRS5hhjJori7BPvo4vhIXD2LOsJ0nww06ftrEo7SNY3SbAOkiKavvyeYrxejGQpC/OuLcmtpJyQkEACn6tyJz/IrGNB/dgE92jI0ogfa09uMxQI2Ni3Gzh9ZJJ3gnxDo0OJRQ5k0nFIrlAfOY3O2MibxkjdLdicSFSqaCAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881618; c=relaxed/simple;
	bh=Q3LUk1H85yAzbN+t7w+kRu37buqF/Wl7SkFxbxxeCBM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fbSgSqgIhw49SDo+AaGHhb3Vv5TWQLAybbEVFccL7R6NrP1wE0TWo/0cH9UoYqp0IBZ46lIEorqKmxo8fGnIYZ3cvO1D/96UwwRlgViym+4BPyrDve7P+3oSnYP96Y5lmUkvs7Nh16cWFZAAe3zLAYPmJwz7WIRnrsP0wZoE+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DHNIrRNM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dAKYmhQ8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.160710373@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Etegges49MUlZBBJQ6BosTJUnMsDSkEARClmQPZjN6s=;
	b=DHNIrRNMBxri68Pm5VzxX54ty6kXMPahQ5viLCFKKIX6gUZBd2D6luwaiPd9kVab9KDuxM
	oLeurF3EEIC8hwVdNXI6JxRO3s0QVk3Gfr+OJeB/N9neESK3sY5ikNOgRtstp0zVr4lJ8p
	duznFfAyGqwrGQxNoH8EtYSHi6E3S2+3aggiC6V2SI+ksWNp4KqgPNACH1opa3vcSIsXs1
	CJKqsYFe5x5MTowUcOMdHlza5997yNI4ncfAan+gnOMIKmqSZ+z8SOasqY9C+3BVTJ6hP2
	u6y2rNrjRdg3zKyxndmnvtMkDZujCTTxmmddTRHQvqEDcBTdD01ucUqjNZnGWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Etegges49MUlZBBJQ6BosTJUnMsDSkEARClmQPZjN6s=;
	b=dAKYmhQ8+nc0DY2QUZVgXJ/myi+ZBLrr3DhE0ngDGDpww1nxkEUBaB2EfoAqI4yhVdPWe+
	W9fv7tMEFTJSgQAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 19/46] genirq/chip: Rework handle_fasteoi_ack_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:14 +0100 (CET)

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1138,53 +1138,40 @@ void irq_cpu_offline(void)
 
 #ifdef CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS
 /**
- *	handle_fasteoi_ack_irq - irq handler for edge hierarchy
- *	stacked on transparent controllers
+ * handle_fasteoi_ack_irq - irq handler for edge hierarchy stacked on
+ *			    transparent controllers
  *
- *	@desc:	the interrupt description structure for this irq
+ * @desc:	the interrupt description structure for this irq
  *
- *	Like handle_fasteoi_irq(), but for use with hierarchy where
- *	the irq_chip also needs to have its ->irq_ack() function
- *	called.
+ * Like handle_fasteoi_irq(), but for use with hierarchy where the irq_chip
+ * also needs to have its ->irq_ack() function called.
  */
 void handle_fasteoi_ack_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
 
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 
-	if (!irq_can_handle_pm(desc))
-		goto out;
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+	if (!irq_can_handle_pm(desc)) {
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
+	}
 
-	/*
-	 * If its disabled or no action available
-	 * then mask it and get out of here:
-	 */
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
+	if (unlikely(!irq_can_handle_actions(desc))) {
 		mask_irq(desc);
-		goto out;
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
 
-	/* Start handling the irq */
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
-
-	raw_spin_unlock(&desc->lock);
-	return;
-out:
-	if (!(chip->flags & IRQCHIP_EOI_IF_HANDLED))
-		chip->irq_eoi(&desc->irq_data);
-	raw_spin_unlock(&desc->lock);
 }
 EXPORT_SYMBOL_GPL(handle_fasteoi_ack_irq);
 


