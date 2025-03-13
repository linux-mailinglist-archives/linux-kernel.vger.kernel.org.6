Return-Path: <linux-kernel+bounces-559896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E8A5FAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2083B16734E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B67270EDE;
	Thu, 13 Mar 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UJIhb5wu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jn/KcOYG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F772690F6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881654; cv=none; b=a5+hfgsmihXwD/I777dymXcfiDgrHORfN662fAp3j91Yu/o4/k903bezuh5QrW0GY9z+msuxJ1Pa9ilgPjJHLv7Rdgh3dvxwHbgYZx8AJlC6PhOIqC5xR13+SeTvY2JVbfzwLKpx1lQnwXJ6HK1OljjcSGBr60KEKHRHhYKpWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881654; c=relaxed/simple;
	bh=h/dtPELlqYG4UUaTn/ldfEgaz4FJRzqajpH3K8Iv1fI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=d6piZVAjZEEVNtcb6nweX2OCHjy6i/ZKesApULAG7dMp/sZJXFnLaOkpqEfAzHgqIXIhtplpxYCtWSL9xVOx1JbrglA8IDlVa/KKa268O1vlYQnosBh4gGlENzKKIgN3xF0yzg2xsnPNVWoQVw8QWLCJlWUDmLQM5Q6k13RD6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UJIhb5wu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jn/KcOYG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.527722355@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mLbsf8I7JWl/g0FpxPntaLQi4iP1ArHtbHP0OlmBo4g=;
	b=UJIhb5wuSLw1jESMazpUj0EH2XPyQb47VKjNoN270nzlaKwMkLAvLKTx8a/d971XEU309s
	vFmIdlaS1ATbY2NpJIlOXtKG38HbSyQ0LHFkTLHwJDplOyxTxymPBAYuqWhVmORcHkqsSN
	33wNibofL70lvaLafoD/eGGVvpGXOB93vQtNvpryEAtTKos4ThXPcHMxllztqhpfigZnA/
	JqqCX8+NvfSTj2pCM/KW6JK9mFPh1f3IETcwnfz8nlYUxwp87siqlLBmh1YjclgB+/f/IT
	d0BhkDfKX7dRAgv+JMqTJ2a12zlYPaIg9OQjC1w9XrhQ7lmFjQq8BbdRbMEXsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mLbsf8I7JWl/g0FpxPntaLQi4iP1ArHtbHP0OlmBo4g=;
	b=Jn/KcOYGuJ/T9giGzoT+krteMFtV6x9tByHPxU0vvBveXmMbY66oWd9SMoWKZoSxbbTQCM
	zcmxICdoKYJgzNCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 39/46] genirq/manage: Rework enable_percpu_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:50 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2285,35 +2285,25 @@ int request_nmi(unsigned int irq, irq_ha
 
 void enable_percpu_irq(unsigned int irq, unsigned int type)
 {
-	unsigned int cpu = smp_processor_id();
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_PERCPU);
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_PERCPU) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	if (!desc)
-		return;
-
-	/*
-	 * If the trigger type is not specified by the caller, then
-	 * use the default for this interrupt.
-	 */
-	type &= IRQ_TYPE_SENSE_MASK;
-	if (type == IRQ_TYPE_NONE)
-		type = irqd_get_trigger_type(&desc->irq_data);
-
-	if (type != IRQ_TYPE_NONE) {
-		int ret;
-
-		ret = __irq_set_trigger(desc, type);
-
-		if (ret) {
-			WARN(1, "failed to set type for IRQ%d\n", irq);
-			goto out;
+		/*
+		 * If the trigger type is not specified by the caller, then
+		 * use the default for this interrupt.
+		 */
+		type &= IRQ_TYPE_SENSE_MASK;
+		if (type == IRQ_TYPE_NONE)
+			type = irqd_get_trigger_type(&desc->irq_data);
+
+		if (type != IRQ_TYPE_NONE) {
+			if (__irq_set_trigger(desc, type)) {
+				WARN(1, "failed to set type for IRQ%d\n", irq);
+				return;
+			}
 		}
+		irq_percpu_enable(desc, smp_processor_id());
 	}
-
-	irq_percpu_enable(desc, cpu);
-out:
-	irq_put_desc_unlock(desc, flags);
 }
 EXPORT_SYMBOL_GPL(enable_percpu_irq);
 


