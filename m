Return-Path: <linux-kernel+bounces-559873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AB0A5FABF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E491881EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06CC26E14C;
	Thu, 13 Mar 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WRzI6LOE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E7X0/U5P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5E26D5A4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881614; cv=none; b=GPo5LJNSHGElozGMF2+VNpgS9/4zRXOLOjbqshH64yOgTLN4vewbNtyjL3F+fEUSklzZWs9Ph1YAXr1rV6LpgqM6h81G7x7tx+4Zh0YEV79mXT/ZeF6kZbxUlt4GNNaNrWtKLo29Xd9LpCJO86AE6NTiOYWLmLTN5sn07dwPTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881614; c=relaxed/simple;
	bh=vSuEFkUiIwR2lWjUNEItYlzLFkTCgRS7eBEJTslAWXc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Vre+G7TemaZGuCmUML/hc5V36DQInFu3X9P+p5fnFzDD0BpPoOL29bKqf7voVaffS9uAJTV43N0j4wBcblAMe3eWS7udBTCTF9/3iTljYM5vJ7FNCu0rnSRwGNMsT0+vkb9F/jXl8HjQ7f40pnqsIvL23YrcSPgAORBkLbRdhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WRzI6LOE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E7X0/U5P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.943799712@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=S/PCa3dU5Q78O6c+ooh++IFo/+FxyxivVyDPyxSN9/c=;
	b=WRzI6LOEmH8ZdqpT1CgSWDn8/8vi7TZuMhSgJBUz2IJp0V66S8NHxfRugxHYNRnW9odlyf
	KJjcgmkD6D6mwjMsDe7EvEDln0l9mxYdCOD8A0EYDnVrlWLyUEdUM4jkhB9XneNze8UagL
	+ZB/pDWDz/1fyu+NsKW7PqrmnlLj8tYzfAmbsxduMGjWBHT016djn+QUIiFR1WCl+D15JR
	nGD1cXKPZrNK574IKhdYh/B+XedYM9lewH5NC6MILcS+FNabGDPen4l1i+RImk4cRsaCml
	9s8EAqvKIk6tiHEMM5m++wgma5Fuyl4lwwFl8DggNPI+SGWppkUFqfdnoJbpNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=S/PCa3dU5Q78O6c+ooh++IFo/+FxyxivVyDPyxSN9/c=;
	b=E7X0/U5PuTRqnugi+3P8OZHRIWwo2iO/GRlpBBXJ5Fa442OKgIzO38avKCakeOqaWmjglx
	YD2sNFpkFe226BAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 16/46] genirq/chip: Rework handle_eoi_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:09 +0100 (CET)

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -653,20 +653,26 @@ static void cond_unmask_eoi_irq(struct i
 	}
 }
 
+static inline void cond_eoi_irq(struct irq_chip *chip, struct irq_data *data)
+{
+	if (!(chip->flags & IRQCHIP_EOI_IF_HANDLED))
+		chip->irq_eoi(data);
+}
+
 /**
- *	handle_fasteoi_irq - irq handler for transparent controllers
- *	@desc:	the interrupt description structure for this irq
+ * handle_fasteoi_irq - irq handler for transparent controllers
+ * @desc:	the interrupt description structure for this irq
  *
- *	Only a single callback will be issued to the chip: an ->eoi()
- *	call when the interrupt has been serviced. This enables support
- *	for modern forms of interrupt handlers, which handle the flow
- *	details in hardware, transparently.
+ * Only a single callback will be issued to the chip: an ->eoi() call when
+ * the interrupt has been serviced. This enables support for modern forms
+ * of interrupt handlers, which handle the flow details in hardware,
+ * transparently.
  */
 void handle_fasteoi_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
 
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 
 	/*
 	 * When an affinity change races with IRQ handling, the next interrupt
@@ -676,19 +682,14 @@ void handle_fasteoi_irq(struct irq_desc
 	if (!irq_can_handle_pm(desc)) {
 		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
 			desc->istate |= IRQS_PENDING;
-		goto out;
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
 	}
 
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	/*
-	 * If its disabled or no action available
-	 * then mask it and get out of here:
-	 */
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
+	if (!irq_can_handle_actions(desc)) {
 		mask_irq(desc);
-		goto out;
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
@@ -704,13 +705,6 @@ void handle_fasteoi_irq(struct irq_desc
 	 */
 	if (unlikely(desc->istate & IRQS_PENDING))
 		check_irq_resend(desc, false);
-
-	raw_spin_unlock(&desc->lock);
-	return;
-out:
-	if (!(chip->flags & IRQCHIP_EOI_IF_HANDLED))
-		chip->irq_eoi(&desc->irq_data);
-	raw_spin_unlock(&desc->lock);
 }
 EXPORT_SYMBOL_GPL(handle_fasteoi_irq);
 


