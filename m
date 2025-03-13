Return-Path: <linux-kernel+bounces-559902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD44A5FADB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61C116E867
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B5272911;
	Thu, 13 Mar 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oV+AsFhA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpMF8uOl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B715271819
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881662; cv=none; b=UP4SLQ0rNvEDVxVipWQTlYPvVG7IlDDzIL6XoMAqcNtrmEDLqFmv0gBmPByT7tij0SdmiJ6XAdPuY17wVAzwvyF9L1/QVHgIuJriXA04tpl10AjV4/KgHduZhtD9Erv1BXuZfayWkpw7Tom8s6q1UZDzK7ArAB8FENc3xBk1roo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881662; c=relaxed/simple;
	bh=OTtHhkGGlcFKDopIicgXvVvIR1TMBLwXHoae0RuWRb4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=cwkeMQPk2lQZv0XdWTUUAVq6alNLV0UtMgMRpafcXogGy1q5OOHJW9EBslaXEErUe2rmqpSfEia99tALgbMJ7WMbaz2u1uveuTxuC+yEWe0aWZ4JxOUG2hwgFefUmifiUuRwVTPq4MjZUUAhFjh/OMmUEnG42kxwzKRRqOHJlZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oV+AsFhA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpMF8uOl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.858899502@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=58zsQ9UX99bgd9bgWnnVYlqUIZPx3Nt2FsMFZCwYlDQ=;
	b=oV+AsFhAkIKqvuYebhU78L8re/0CzIRRbizI0sdH1hlM1VjlKrqMDZ7Xik9Cx8sClakuw5
	q6jZFQ9oMbbEAiqSQDwi2V6e9ouN0gpMLLYxjhr0i3mfMqHe9MAiL3JiGWDpKK1L8I7znp
	ojbFa/Wo1M2L+9l/iR6/SRJoXqY0PPwYBVm2FDAzrUkftU9M0KkncumiVYx+iPTcEOs+0c
	lqGYdpOTlONtEiZG3ZTBGQa/Js+rDLtcDdHUauM1BJeq4voj5yzP2cKfzt88kpGQRZC2R7
	3FIq/aIOsnmlSYnwAe/WclDprt8qQwMlmB7B1kLpOP6kZV8Zh1Qc12ms6UojfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=58zsQ9UX99bgd9bgWnnVYlqUIZPx3Nt2FsMFZCwYlDQ=;
	b=zpMF8uOlchygSRiefK8E2PwAh0IhXOxVClASxQlxgMeZAgF+cjTPMKmPZOSDMggi+8wXOq
	yCSwiq8mntAJ0cAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 44/46] genirq/manage: Rework irq_get_irqchip_state()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:58 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2678,24 +2678,14 @@ int __irq_get_irqchip_state(struct irq_d
  * This function should be called with preemption disabled if the interrupt
  * controller has per-cpu registers.
  */
-int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
-			  bool *state)
+int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which, bool *state)
 {
-	struct irq_desc *desc;
-	struct irq_data *data;
-	unsigned long flags;
-	int err = -EINVAL;
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		struct irq_data *data = irq_desc_get_irq_data(scoped_irqdesc);
 
-	desc = irq_get_desc_buslock(irq, &flags, 0);
-	if (!desc)
-		return err;
-
-	data = irq_desc_get_irq_data(desc);
-
-	err = __irq_get_irqchip_state(data, which, state);
-
-	irq_put_desc_busunlock(desc, flags);
-	return err;
+		return __irq_get_irqchip_state(data, which, state);
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
 


