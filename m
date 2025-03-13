Return-Path: <linux-kernel+bounces-559870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B15A5FAB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F5D3A4077
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F626BD9C;
	Thu, 13 Mar 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2jBFcl8i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yx+2Usc2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998A26B2A9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881609; cv=none; b=RzARCzeVnMDIo9AdsrwejSNKQJmuMvc/IKGlUaASd0HJziezSvoyIPRyOEh5F6tuNJxjqb/0v7sd6WiRT4c6LOQoNvlukAU0Hfmb3wW0ka7XD0j6VbeIGdEQ8J8fkjLdUeXP78My3uHUYwfQeIpNoZz4efSP9Q/9T3sO034ccSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881609; c=relaxed/simple;
	bh=5ck3CiLrFDp8Ga3ABgCm8jslT3D/G6CsWLORrMGaGOs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PQL8VrbRhcbF/BuKysDypyZ8Wqv+w418jmJ3UJ+9QRewHgtE5YbaCzEVvoDieAds9860AtdjC8/AozwS+9OfCHhJEjieylPKRtbNiwgrEt8RKD/u6YREwOrZK7TZyRKlADzh3uinEKLK96S1NgT8PWcTt6nYlgyFryRS7OXMRJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2jBFcl8i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yx+2Usc2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.809874100@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6cbl1KwfK64weuhvN54DXi2/npqBXHAy3T7/1BalF2U=;
	b=2jBFcl8iS8YmKtgwoATrauJsa5d+Xm4EXfEYDrImh0bwUW/GTaHrgtKOVrPQSb3dpN1NLf
	dSh/95HVp/j9YJDS5CG45Miejixy9HSxVsJ+gnRbvCPUBz1E5pHMLsrD0p9kBCgJK1vIIY
	pgYoz4/+iZR9pQOyHyq0nOMzEfWfWz8BpiAFNo4DG/0PICW76l5+D6qFaKqx0UkIZfH1c3
	mIVg0UCfDKaLNnyh34tPc/ha2+9tN1H/gVLzJif0i9X8gSEMmyk36I6mivyknZYRVolL7d
	kUHzkLdi933afgCNfgE0eIGkKXbhVtzN6HDD8aaqofOjPL+0Ts+ywnAmLrVFbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6cbl1KwfK64weuhvN54DXi2/npqBXHAy3T7/1BalF2U=;
	b=Yx+2Usc2Oo/YnkyhWacc8v2tSB4N5JEbViR4GSS++0HgZfjF1Z3d7XWrpV1Y/ZuzHOBYon
	U6Mw0ro9WK0+npAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 14/46] genirq/chip: Rework handle_untracked_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:06 +0100 (CET)

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -561,43 +561,32 @@ void handle_simple_irq(struct irq_desc *
 EXPORT_SYMBOL_GPL(handle_simple_irq);
 
 /**
- *	handle_untracked_irq - Simple and software-decoded IRQs.
- *	@desc:	the interrupt description structure for this irq
+ * handle_untracked_irq - Simple and software-decoded IRQs.
+ * @desc:	the interrupt description structure for this irq
  *
- *	Untracked interrupts are sent from a demultiplexing interrupt
- *	handler when the demultiplexer does not know which device it its
- *	multiplexed irq domain generated the interrupt. IRQ's handled
- *	through here are not subjected to stats tracking, randomness, or
- *	spurious interrupt detection.
+ * Untracked interrupts are sent from a demultiplexing interrupt handler
+ * when the demultiplexer does not know which device it its multiplexed irq
+ * domain generated the interrupt. IRQ's handled through here are not
+ * subjected to stats tracking, randomness, or spurious interrupt
+ * detection.
  *
- *	Note: Like handle_simple_irq, the caller is expected to handle
- *	the ack, clear, mask and unmask issues if necessary.
+ * Note: Like handle_simple_irq, the caller is expected to handle the ack,
+ * clear, mask and unmask issues if necessary.
  */
 void handle_untracked_irq(struct irq_desc *desc)
 {
-	raw_spin_lock(&desc->lock);
+	scoped_guard (raw_spinlock, &desc->lock) {
+		if (!irq_can_handle(desc))
+			return;
 
-	if (!irq_can_handle_pm(desc))
-		goto out_unlock;
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
-		goto out_unlock;
+		desc->istate &= ~IRQS_PENDING;
+		irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	}
 
-	desc->istate &= ~IRQS_PENDING;
-	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
-	raw_spin_unlock(&desc->lock);
-
 	__handle_irq_event_percpu(desc);
 
-	raw_spin_lock(&desc->lock);
-	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
-
-out_unlock:
-	raw_spin_unlock(&desc->lock);
+	scoped_guard (raw_spinlock, &desc->lock)
+		irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 }
 EXPORT_SYMBOL_GPL(handle_untracked_irq);
 


