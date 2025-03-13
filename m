Return-Path: <linux-kernel+bounces-559877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C6A5FABC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C22317EC91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4E26E638;
	Thu, 13 Mar 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5OWeVDX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gf0BIsoH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280426E179
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881621; cv=none; b=WOXOb3oNpLbjdZwWyaBphsNwNC7MPIbFrmJFB+D9q37B3Q3D7ABSBBYgwKEK3wN7Yn6rDfxz0wz8xwSXRyPKIQ75nsbrIzgwipC9fXwGIVv4luWaU4QLR5/Wvoz93rpUYhzBEhqhv9N3JjpdxWPoA8dBQgGtDvtqvMEgpXKCga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881621; c=relaxed/simple;
	bh=+jb2cVMFrK3JLI4YXqGnO7W/g2skxpSgj42RVfVe45U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iYD/bQ/odSoVQ8uxqUJqFFmJER54JgY2kt0FcYs2fXBgxmGIsSaDxdTOj5gRodMEbeT2ppZ2kYQwYKoyk/eC0C2NxiFN0EZtO9ymJcuSvqzZ3zpPKlX/QBoXBAyEc2qHUN4XE+qm6UOEMeJYsi6JA69QQL50rb5M4/mkY6x5wyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5OWeVDX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gf0BIsoH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.232665756@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SWG0FodRQ91tGX7TEvKXx2mG4eaRCsEYB9dnpaH3VVM=;
	b=L5OWeVDXAbplbGD6nk/6onDcT/rtjipgFjrfndQ5vmmgmjBlgeB/9w/JEJGEbgiM24tm8c
	ggPZr01pLyoHF72oyKWeR/bejDu3c04WXJKzAVypob22EohMujLmpG1FiYhFRyHfgNAKWx
	jiDXsFIELYBuEybubNjZX86MdoJ/enX4e0bfq1l2E7LYgTNYa+AnRaKPXMWnNQ2YfFXjvY
	sjBqoDnJFdBAPNKATTW08G4BA4vavjP23q9ZKRbeCabUMKxmXkODrZNAY/C5zWxQseWcUi
	XRUmKrPNefUVGn6dvaD8wwyaaxz+wux4Cz/hIt/su1+0VrrTcn+eKZwFLw1cZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SWG0FodRQ91tGX7TEvKXx2mG4eaRCsEYB9dnpaH3VVM=;
	b=gf0BIsoHny5Ga9jsO14JKjVPi1He/XT39dARgs4gwYFeJ/9p1d/v2HRYf7B/6P4srGAF8g
	2i8zUcxHI0/sfsCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 20/46] genirq/chip: Rework handle_fasteoi_mask_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:16 +0100 (CET)

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Note: The mask_irq() operation in the second condition was redundant as the
interrupt is already masked right at the beginning of the function.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1176,51 +1176,31 @@ void handle_fasteoi_ack_irq(struct irq_d
 EXPORT_SYMBOL_GPL(handle_fasteoi_ack_irq);
 
 /**
- *	handle_fasteoi_mask_irq - irq handler for level hierarchy
- *	stacked on transparent controllers
+ * handle_fasteoi_mask_irq - irq handler for level hierarchy stacked on
+ *			     transparent controllers
  *
- *	@desc:	the interrupt description structure for this irq
+ * @desc:	the interrupt description structure for this irq
  *
- *	Like handle_fasteoi_irq(), but for use with hierarchy where
- *	the irq_chip also needs to have its ->irq_mask_ack() function
- *	called.
+ * Like handle_fasteoi_irq(), but for use with hierarchy where the irq_chip
+ * also needs to have its ->irq_mask_ack() function called.
  */
 void handle_fasteoi_mask_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
 
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 	mask_ack_irq(desc);
 
-	if (!irq_can_handle_pm(desc))
-		goto out;
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	/*
-	 * If its disabled or no action available
-	 * then mask it and get out of here:
-	 */
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
-		mask_irq(desc);
-		goto out;
+	if (!irq_can_handle(desc)) {
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
-	if (desc->istate & IRQS_ONESHOT)
-		mask_irq(desc);
 
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
 EXPORT_SYMBOL_GPL(handle_fasteoi_mask_irq);
 


