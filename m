Return-Path: <linux-kernel+bounces-559904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20826A5FAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566F71887366
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6A7272924;
	Thu, 13 Mar 2025 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QcAbpmtl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NItHWSAy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D127291F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881665; cv=none; b=H3Fs033VuQVU4hyHvklwtiUKk1UamQXMSLDb9kM7HFF+eXNiYfwudep4rtg99qQYAvHsfJ1tW/DwHkqBYRsRT6j03iyrSRUOj2j9BHqH7gvt2Bze7RUcvgivxM7C0G7YNLhlu0DnwNpi4JxBGYyPXUXUEyJTYZArMd5ae3S98I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881665; c=relaxed/simple;
	bh=vMJNu4J7oiDUUh1E1vi9V+qoJCogfOGMeNQQ4+j8VoM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FATsm8ROqxTD3ZuBuDr4QUU/Hq0SW/vDVxC8xo3paRGeGyKZAPb0RI31pr4+NbB2dbv2is6nuxo9JYtWKmNvfHXr9v7+4skoCzbmEjpQ/oT4yBtqJhh0ILmI8UEGvo9VVpvi0E2pcFEpA0hSvp8Px3HpVmT7JIQnI6NeDmX93Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QcAbpmtl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NItHWSAy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.993446362@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t3I5KX7KDZZiUjgYflehk310ztwRwVsgtSnc9ulIycc=;
	b=QcAbpmtlHObnqUn7AKD36q2arhr/uxkUt5lpRXGE1ZvXw4wgnK3aV6fsRFH5RiiO5hwajs
	QWZPIRci5V6CX9zXVTIXm0TSt1X0acDFZS6SOWWP//1RCpnMep45cOjW7Ula41TJUNQfgW
	+pzblArLytDnyGv+6sAzM5j5kKIH48TG91keJ4ZyWCshbMb/u/vg1sznEKIXOvdK9UkLNt
	2Gx489HaILxBii7c47h828cFe04NdgfnwIyK7Omrj4wlIGgv6J1f/rizITU+6MobU0CGRF
	s5meHztECTX6axLv9X0G6ZrsuddEglX/xEzMUqsIkJPNecRPdYGu4ho02/1j1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t3I5KX7KDZZiUjgYflehk310ztwRwVsgtSnc9ulIycc=;
	b=NItHWSAyqBLRE5L0pTEMTE+svgCh2ArNfeJlVf0lYVlTdIK/tWOUUyAPwcHHIV8jftDzrB
	35gDUVVB8nrkEGAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 46/46] genirq: Remove irq_[get|put]_desc*()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:01:02 +0100 (CET)

All users are converted to the guards. Remove the helpers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/internals.h |   24 ------------------------
 1 file changed, 24 deletions(-)

--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -200,30 +200,6 @@ static inline class_irqdesc_lock_t class
 
 #define scoped_irqdesc		((struct irq_desc *)(__guard_ptr(irqdesc_lock)(&scope)))
 
-static inline struct irq_desc *
-irq_get_desc_buslock(unsigned int irq, unsigned long *flags, unsigned int check)
-{
-	return __irq_get_desc_lock(irq, flags, true, check);
-}
-
-static inline void
-irq_put_desc_busunlock(struct irq_desc *desc, unsigned long flags)
-{
-	__irq_put_desc_unlock(desc, flags, true);
-}
-
-static inline struct irq_desc *
-irq_get_desc_lock(unsigned int irq, unsigned long *flags, unsigned int check)
-{
-	return __irq_get_desc_lock(irq, flags, false, check);
-}
-
-static inline void
-irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags)
-{
-	__irq_put_desc_unlock(desc, flags, false);
-}
-
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
 
 static inline unsigned int irqd_get(struct irq_data *d)


