Return-Path: <linux-kernel+bounces-559881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F891A5FAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A1A421F20
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C74426E978;
	Thu, 13 Mar 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="muXYGaZM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVLQNSY/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8526E649
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881627; cv=none; b=KFbRRrbN6FV6qEcoY1jlpbzRFXV8yAwo6ZU5atzJF+Uuwsbc6XT+9LdJi3CM1hQF6SzWAZ7YoEnTkyv+SZ/aDkdY0gCvHb6Xwpzhf/hKY1aiAXIOvl014N+NxDppALJxNkXBH9hSiHCl4pSo258CjfUDgwnkDwT8u070Q2xedGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881627; c=relaxed/simple;
	bh=4XMSv95UnRHRfs9Dp9DKs5bSM7EeJBEDLVlMfMExvKQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lZ94cF2HCysZAOFNyYCRgX6q3BEoIASi/0KtpUjMMzQN/AF5JnDb2pXXT/OoTWyD2TI+2ju1szK7HMc+87530oG1i+niDYGa7mlYHrskhTZizlD5xmQfBqBumsJyHdjLd0sP6UtZHF01quIfbNCXzGuNhvJ+gCU53tIIHb/0G54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=muXYGaZM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bVLQNSY/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.521160607@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SZppYYpyTvmjB7MNa4nQjpEdTsOCMp/CZ0uXUVBIajU=;
	b=muXYGaZMKdhZ/ADsYGtBVTuHRDNvzGjti+ggh1jrloi1jJkG4dTbfuVRkecu1o9QvfLPZ6
	PTQ20W0TSfPhZv8qfQ0s1EMd0t09jU10CgoeMTpnKgmCNIJhrKC6YIaaT0HddCBbAdT5jZ
	RyHf6OmN8kKToPy8KM+teX/+/jpH0GAA4BqUw22ismMaK84D3BUlZ8X+eWyaDX3l/uECJG
	sdHNvNx4XigBP6QXhED4aFrXOZW8H5GkHMa/c20aw6/Z6ODB1riw+DFkqNIy0SBJA5OSEJ
	r4FMfB2GsMXw8zEEhgNcCoKRRABU4ytDK2VOdRkaAPi2miVdseWmOdvoi6xBuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SZppYYpyTvmjB7MNa4nQjpEdTsOCMp/CZ0uXUVBIajU=;
	b=bVLQNSY/IzZy9T/mdXlHAuD6Pc7kihOQ2JNM3Zk0whZiJjAa5upRWBDb4udlCYKK30YYDL
	E9ZZSbRKzTU3XvDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 24/46] genirq/chip: Rework irq_set_handler_data()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:23 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -67,22 +67,19 @@ int irq_set_irq_type(unsigned int irq, u
 EXPORT_SYMBOL(irq_set_irq_type);
 
 /**
- *	irq_set_handler_data - set irq handler data for an irq
- *	@irq:	Interrupt number
- *	@data:	Pointer to interrupt specific data
+ * irq_set_handler_data - set irq handler data for an irq
+ * @irq:	Interrupt number
+ * @data:	Pointer to interrupt specific data
  *
- *	Set the hardware irq controller data for an irq
+ * Set the hardware irq controller data for an irq
  */
 int irq_set_handler_data(unsigned int irq, void *data)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-
-	if (!desc)
-		return -EINVAL;
-	desc->irq_common_data.handler_data = data;
-	irq_put_desc_unlock(desc, flags);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		scoped_irqdesc->irq_common_data.handler_data = data;
+		return 0;
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL(irq_set_handler_data);
 


