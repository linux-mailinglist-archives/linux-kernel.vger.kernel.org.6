Return-Path: <linux-kernel+bounces-559871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ACFA5FAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951D288153C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213526B961;
	Thu, 13 Mar 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k/jbdwni";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4hklptHE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955626BDA3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881611; cv=none; b=avGHwJMGCTUjqyQ83oB58XkDAjtRCXofcoyPLPt9JDlEbUAKfYy+vyztT2VFjTig0iSV/aIMVySxTC9DteVNimZMbQoBBa1hoPDbP5p3Fz44CS6xTDyP/7s5H5b/oYe6Ji/OnE5FRrVTXJNV5jO/ojnv61wMqgHb0JJdzGxRqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881611; c=relaxed/simple;
	bh=4mnaCxGgovjXolEdUuFx8EH//EbtYUMPBXLgkYv5aFo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=UVgu9ujwZmnZSPhuCaM+OCM18riNu/rQLu5fphjqF839bu8Ly7v4XzQOmi0n7mm4OXijPlYjdpS1PI4JYfhX07nVZcfRwgk5VgnQ388FLaeNVoxM4kxQ6SSO8KEwdpIFaZy1K85DO8F5demGnHwUIXHY25+/9gfewQyb5qbmhnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k/jbdwni; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4hklptHE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.876406863@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ZyvCyewrVvXAU/CZ99lPev68Sm1EYZjAV8kymcxiFF0=;
	b=k/jbdwnit2maZYwCqPhMCGw3J7WlF/yYZRCdztZDHI8QmlqWxusgwtPC6n8Wbo8Ooa3ANv
	F3N6cAHlofpgf59VsmIXN9Hmfk/K/n6NrbKzJPPe83xHPaV81yKwL6WY8ShjqeVbGlnhTL
	dIWb9VQt/sQKAYPtEvKws3bbNZpugNTGym6D1r0OL35Qto6GttUQZPG+WvRqswwZUROMnP
	F7TeSNO6a9xPq6QsjWI8lHJCZkoIxMfr4pHPJMIqrvgbwhLAnH1zBE31UmlFvUM9p/UiiW
	4gYIq5uUYOHzhZ4mraucbc+ewWSFXSFsZgeTDHaGQcJn1QB68amguBksMQB2JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ZyvCyewrVvXAU/CZ99lPev68Sm1EYZjAV8kymcxiFF0=;
	b=4hklptHEIPwqk4eZ2xb6tCuhtr0pnaXlEBwFpPBRqP6PDmylZIbVxMkxUUvrqVbrM9yKV+
	xLSWDwgGuOxL/gCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 15/46] genirq/chip: Rework handle_level_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:07 +0100 (CET)

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -609,40 +609,26 @@ static void cond_unmask_irq(struct irq_d
 }
 
 /**
- *	handle_level_irq - Level type irq handler
- *	@desc:	the interrupt description structure for this irq
+ * handle_level_irq - Level type irq handler
+ * @desc:	the interrupt description structure for this irq
  *
- *	Level type interrupts are active as long as the hardware line has
- *	the active level. This may require to mask the interrupt and unmask
- *	it after the associated handler has acknowledged the device, so the
- *	interrupt line is back to inactive.
+ * Level type interrupts are active as long as the hardware line has the
+ * active level. This may require to mask the interrupt and unmask it after
+ * the associated handler has acknowledged the device, so the interrupt
+ * line is back to inactive.
  */
 void handle_level_irq(struct irq_desc *desc)
 {
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 	mask_ack_irq(desc);
 
-	if (!irq_can_handle_pm(desc))
-		goto out_unlock;
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	/*
-	 * If its disabled or no action available
-	 * keep it masked and get out of here
-	 */
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
-		goto out_unlock;
-	}
+	if (!irq_can_handle(desc))
+		return;
 
 	kstat_incr_irqs_this_cpu(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_irq(desc);
-
-out_unlock:
-	raw_spin_unlock(&desc->lock);
 }
 EXPORT_SYMBOL_GPL(handle_level_irq);
 


