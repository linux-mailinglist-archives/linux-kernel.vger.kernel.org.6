Return-Path: <linux-kernel+bounces-559875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E61A5FAC2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C65D3A7A00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E4D267F77;
	Thu, 13 Mar 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W3xUzLF0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n1C322h7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8326E14D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881616; cv=none; b=gUBq3u0CnKf+LqgHt77UyUZDX90642rXw/IdehtctfTWW6d9EH0NbNtAkrdpW20CmylCk/TN2El8xwihnj5RUdh89ylIgIoTGpI3nkZMCkDZHFZP4x/yfj1IM6lE1gO8h/1U8PU4L08EvpFKdaKaUr7VBcROw0oedsq14YeW0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881616; c=relaxed/simple;
	bh=WWq3KUG5f/nCLj5Qcgqq4kUJ18GwI47BH3UZ0s+Of50=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kmwA073KAHUlXyULHQPlwvquZzjxTvWruICaeMdbQsKIqVWmgkcKHFqT3I830R41ZPkMAvLr4Oq8/QlYzVdB5JfYa7TccWsGr99UlKRwGXF+yud/bigpxe/Lk1s3GfJY9+MLYKcox///Nj45f6bF7ywvLhVbndwBC0UoZ58JrGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W3xUzLF0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n1C322h7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.094037144@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Jcmv7B5DflHiH05XE6cttIs2h3vY47Eqkh2aShVo4cE=;
	b=W3xUzLF0jYuNIaDIzqI34LjdmIWYtyUjJmtHUH3V1EHCRm/7nnl3fsIrEHukmDc+apdPx5
	5Hz/6WJr9AcB4R71gCEPacGnKGTSF4oCGeugJONZH5VzMKsqZsp0G7im+eLqrulRd3E1j8
	ru8XWc0CY46VV2TFwliZYX9VRcK2LYh0JeQgS5d3hCp00eVLnvSSX6+mpBGNrM9HK+GNOV
	u5uzeVaqeiZKCBlYz2AekFWIUwxJplUULTCkmw298qa9JJ4oo5rw3/bIma6lrFxzNIyOuD
	j56HchcR5YyZn02aGvMhE/IL2Svd5WLcOcHRWJonnSvsf2O86DrOBGNe7gY45Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Jcmv7B5DflHiH05XE6cttIs2h3vY47Eqkh2aShVo4cE=;
	b=n1C322h7601CtFReeflJByBVaT8i/xYP7kBBI/+EC+DmxDYg4hk4fnDpLt5EFvEu8XW165
	F1Nxsn/+59U/hAAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 18/46] genirq/chip: Rework handle_edge_eoi_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:13 +0100 (CET)

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -795,8 +795,8 @@ EXPORT_SYMBOL(handle_edge_irq);
 
 #ifdef CONFIG_IRQ_EDGE_EOI_HANDLER
 /**
- *	handle_edge_eoi_irq - edge eoi type IRQ handler
- *	@desc:	the interrupt description structure for this irq
+ * handle_edge_eoi_irq - edge eoi type IRQ handler
+ * @desc:	the interrupt description structure for this irq
  *
  * Similar as the above handle_edge_irq, but using eoi and w/o the
  * mask/unmask logic.
@@ -805,38 +805,23 @@ void handle_edge_eoi_irq(struct irq_desc
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	if (!irq_can_handle_pm(desc)) {
-		desc->istate |= IRQS_PENDING;
-		goto out_eoi;
-	}
-
-	/*
-	 * If its disabled or no action available then mask it and get
-	 * out of here.
-	 */
-	if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
+	if (!irq_can_handle(desc)) {
 		desc->istate |= IRQS_PENDING;
-		goto out_eoi;
+		chip->irq_eoi(&desc->irq_data);
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
 
 	do {
 		if (unlikely(!desc->action))
-			goto out_eoi;
-
+			break;
 		handle_irq_event(desc);
+	} while ((desc->istate & IRQS_PENDING) && !irqd_irq_disabled(&desc->irq_data));
 
-	} while ((desc->istate & IRQS_PENDING) &&
-		 !irqd_irq_disabled(&desc->irq_data));
-
-out_eoi:
 	chip->irq_eoi(&desc->irq_data);
-	raw_spin_unlock(&desc->lock);
 }
 #endif
 


