Return-Path: <linux-kernel+bounces-559857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97054A5FAA0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAA0179DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749826A091;
	Thu, 13 Mar 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="twDVoK7c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y9dib2Su"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD52690F2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881587; cv=none; b=hSUBBGz5kwfu9DNvqZ3kYcZGhgV3fz6GUmBskF8AIwA4xWvyFrK54wYSZSqiArKRFJPIPXw0pp4gOm6iUDHPR2SHMvhiej2VxLMuFVcvg7MfLzdHLQdRCUqal9UGJ9w5uFrft/UhltidCHiB6wgoQDtlnFUTJvDRbJbIpZY5nXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881587; c=relaxed/simple;
	bh=46A3UhnYd7qHpQVGclqJIBmLNsxJAxIKhYFDvz9/UgE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Dz1Z+LFSmRxOTcJH++WLQIfLhJ3d5z7aPjpvfoG7lkIyZVazYcLI7RO3Ul7hxxXNXPKelhgApmeIFrd833WSHYmuGHFyTM0Hglu6g7PaSaY7w/kcpVwpo6c6OjFIGLKtAYDi+DkegamPm8lm5cAUAwGyGYWcU9DihD1F3GhOsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=twDVoK7c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y9dib2Su; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155913.943406435@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ock9hFbrCX/0jm57e6t3l2AeBjWICriMwni1mvhD8xw=;
	b=twDVoK7cubkvuOfqM+NtrWLAbzsXjgV1BIeS87rMK5S3lDDPDnsN4TXmH8wzRJtx6koQK/
	tgkwqP3P/JECsazRSoJ/4ukDtNM2VDlg5qFVsUg087XXf6b1NAfGtbbIIx5+4HKx60gVFB
	7mJ6/kwPhxMrf5P5pEj5RWonwSgf9iMZ6vAXbCFcmmZ7oECcU0l09AMfAG7tT9uYKVZ09w
	cICVNkSSquDf1yuWS8Nii5GKjLnq2dF61Z/IMVu9jbt5heJ+HLg6uQ0AxIud2XjRdKgX54
	uNNFqdvgI04HRU9WU145AGS2qyg5brr93x3NxvBhItlzXtK95gY5PXvbiw9T5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ock9hFbrCX/0jm57e6t3l2AeBjWICriMwni1mvhD8xw=;
	b=Y9dib2Su5PG2HJXoaxY3SuUyTvpJzEAC+M/0eYFuJBNnZu3pIPMMfpkk+2ddELimWCVTMT
	cNqPVzLOBj1tXIAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 01/46] genirq: Provide conditional lock guards
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 16:59:42 +0100 (CET)

The interrupt core code has an ever repeating pattern:

    unsigned long flags;
    struct irq_desc *desc = irq_get_desc_[bus]lock(irq, &flags, mode);

    if (!desc)
       return -EINVAL;
    ....
    irq_put_desc_[bus]unlock(desc, flags);

That requires gotos in failure paths and just creates visual clutter.

Provide lock guards, which allow to simplify the code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>
---
 kernel/irq/internals.h |   35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -150,6 +150,10 @@ extern int irq_setup_affinity(struct irq
 static inline int irq_setup_affinity(struct irq_desc *desc) { return 0; }
 #endif
 
+
+#define for_each_action_of_desc(desc, act)			\
+	for (act = desc->action; act; act = act->next)
+
 /* Inline functions for support of irq chips on slow busses */
 static inline void chip_bus_lock(struct irq_desc *desc)
 {
@@ -169,14 +173,33 @@ static inline void chip_bus_sync_unlock(
 #define IRQ_GET_DESC_CHECK_GLOBAL	(_IRQ_DESC_CHECK)
 #define IRQ_GET_DESC_CHECK_PERCPU	(_IRQ_DESC_CHECK | _IRQ_DESC_PERCPU)
 
-#define for_each_action_of_desc(desc, act)			\
-	for (act = desc->action; act; act = act->next)
-
-struct irq_desc *
-__irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
-		    unsigned int check);
+struct irq_desc *__irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
+				     unsigned int check);
 void __irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags, bool bus);
 
+__DEFINE_CLASS_IS_CONDITIONAL(irqdesc_lock, true);
+__DEFINE_UNLOCK_GUARD(irqdesc_lock, struct irq_desc,
+		      __irq_put_desc_unlock(_T->lock, _T->flags, _T->bus),
+		      unsigned long flags; bool bus);
+
+static inline class_irqdesc_lock_t class_irqdesc_lock_constructor(unsigned int irq, bool bus,
+								  unsigned int check)
+{
+	class_irqdesc_lock_t _t = {
+		.bus	= bus,
+		.lock	= __irq_get_desc_lock(irq, &_t.flags, bus, check),
+	};
+	return _t;
+}
+
+#define scoped_irqdesc_get_and_lock(_irq, _check)		\
+	scoped_guard(irqdesc_lock, _irq, false, _check)
+
+#define scoped_irqdesc_get_and_buslock(_irq, _check)		\
+	scoped_guard(irqdesc_lock, _irq, true, _check)
+
+#define scoped_irqdesc		((struct irq_desc *)(__guard_ptr(irqdesc_lock)(&scope)))
+
 static inline struct irq_desc *
 irq_get_desc_buslock(unsigned int irq, unsigned long *flags, unsigned int check)
 {


