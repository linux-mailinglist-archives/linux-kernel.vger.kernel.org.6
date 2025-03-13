Return-Path: <linux-kernel+bounces-559889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B128A5FAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1AD188874C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AE926FDA1;
	Thu, 13 Mar 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gSA0dc4b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AszdOOlu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749B26FA79
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881641; cv=none; b=nSBzPj1ySZo3t5ZbeGoAqCy/1X3SN1DU3MYFJLYAkeaX91YAmMnB0ZZf9KkGu8jtzKm2fFGWuHrW9p4Yan2pZDq5aIkC2pSwyOsT3mNIX69AOsljVcYMtamt4aK8TQvNWBcg+C+NsNYk2B3a5evWEoRhr+eanX9YRORYrt7yqaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881641; c=relaxed/simple;
	bh=G+O6RUMMR7PjSszWNkH6ckyVAHAcBkve6EKrbzFLgE8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mhO/zB5woELGGRLx2tYgF9hXiIDW/wBN5nnG3FvVVh5NrugqkH1mReVLX8+ISbxHNJzqCqhuR97nQXiyzDNu3MLXBNYLgci1j5+vSuSFOQ2nZGuKuntsUCYTrx+O+u6bp+iwP5G2VWRJOf6LbojQ0YpY70iFntm3S+lUcpCMPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gSA0dc4b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AszdOOlu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.064161381@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Zp9bqtXWJEgOWP1KXbSKC64/wDLZE5Pm7ZLMi8Ztu/Q=;
	b=gSA0dc4b78dWmKhrRcKJIn4FjTTg20qilKFrjF+OZON/sAX5QhVDGev0oSiw4cdF+1NNxt
	u3dw1fIg6QYjiW9HjLsFRzhk4K/Wg1s4jl4yLtTEVUdm83kdFcT2lK7qYwmBhLSy08Cb5l
	QPM5n+Aw3mkZorq481viEeeWPG3BQH8YS+5juv3IwgNmWY6ccDDtCcSBRadA90WsBQ2NhP
	CbItYNDucXM9nPfNWhRnPW/RxXY4ELDVFjMSSSxIJv7Sk8hSbZbg/rpnVuVVLzYdhXELDX
	7Z9nXcs5wf+Lh4YVZRkWu84P8J14s+Gf03wEDU0dsb9bcm1iJLhpelSgqaaZSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Zp9bqtXWJEgOWP1KXbSKC64/wDLZE5Pm7ZLMi8Ztu/Q=;
	b=AszdOOluoVxMJthyzCdCi03Z/u+/y9N/1fNhYyrOlQXiNP+MaLcty/H+uFUS00JmIDkd0F
	p/IBmVzF1z5FrrAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 32/46] genirq/manage: Rework __irq_apply_affinity_hint()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:37 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -478,26 +478,24 @@ int irq_force_affinity(unsigned int irq,
 }
 EXPORT_SYMBOL_GPL(irq_force_affinity);
 
-int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
-			      bool setaffinity)
+int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m, bool setaffinity)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
+	int ret = -EINVAL;
 
-	if (!desc)
-		return -EINVAL;
-	desc->affinity_hint = m;
-	irq_put_desc_unlock(desc, flags);
-	if (m && setaffinity)
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		scoped_irqdesc->affinity_hint = m;
+		ret = 0;
+	}
+
+	if (!ret && m && setaffinity)
 		__irq_set_affinity(irq, m, false);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
 
 static void irq_affinity_notify(struct work_struct *work)
 {
-	struct irq_affinity_notify *notify =
-		container_of(work, struct irq_affinity_notify, work);
+	struct irq_affinity_notify *notify = container_of(work, struct irq_affinity_notify, work);
 	struct irq_desc *desc = irq_to_desc(notify->irq);
 	cpumask_var_t cpumask;
 


