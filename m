Return-Path: <linux-kernel+bounces-559898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD44A5FAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D07917F226
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13172690F4;
	Thu, 13 Mar 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uoRXRbd5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itc1WTwX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6027126C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881657; cv=none; b=i4mimYGbfg/5aHc+Wa0CsqohbcKVrFbs8GL+mDOLV7cPfm7AxBynhj6MJXoz8LXzjVCHTlSmB/X1BmbhpVfBKmRwxFS6iH4miqlGu8vThfhnSLvMX+oBFPg7Pvl28kgLzRvg6ajfCCboeEU2/79Y4EgCxcCBJx6lOcE5yc6PD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881657; c=relaxed/simple;
	bh=X6jwkEB9yQWrChjq2uc6ZtiKiZeDwJ0TDGLwjPBCJhk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=q8VvAbGQczRy2U8JeJDmozuXh3OSbibFKRtBgr2FmnhGrpmiJjmvAUxqkjfXDd/gOqujgce0QG25wVtMmY45jiK9Obrg8sN92iMf6qZRR2i0opfGUAqdaI1FovRnTJwTjSH6wzZaLWbDxBOLhLTls3dO8UyPa+1x6s5tWcSNrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uoRXRbd5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itc1WTwX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.660125402@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0QQlKjU5JNcUlgDlp+1nxq44TSqQa/e/i1U/EtqxR+U=;
	b=uoRXRbd5/b82Ka964KP9fS5ArAbuEVQI+aQRTsE7OamElr9LvgW+6BBYgZvz4aIOwKahpe
	ikzxchl+NRex0/1R92E8Dsaz9vZzCZeKPNRiZR38Zr2maeM8qCJDQKMy8FIMM66E3CctD4
	rBZsSAhwBbj1WPDjq9odT3eobqZeT5Im3qNoYmCbBsLrAQQRw1nGrwKPbzrD57wqIuezuS
	eJwdcs35ivU8ylQ1ASNGBkElmdFIX76ONy6QhVccctWCFFSE/b/B2GoscrGs4ysO9bj28M
	GWKdP6LctwSBeyPgYNpY60aQ5AwvG+ueGvpHGoMIvnoYBrCt3Q58uPyP1BYwvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0QQlKjU5JNcUlgDlp+1nxq44TSqQa/e/i1U/EtqxR+U=;
	b=itc1WTwX4edH0PB4nsjFquUsX3Rs3uDmKjhe+in1vc4T7xXRINyqAuuTVH5F/s9hG4NkUg
	F9M92HBhQjGwL6Dg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 41/46] genirq/manage: Rework disable_percpu_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:53 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2329,15 +2329,8 @@ EXPORT_SYMBOL_GPL(irq_percpu_is_enabled)
 
 void disable_percpu_irq(unsigned int irq)
 {
-	unsigned int cpu = smp_processor_id();
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_PERCPU);
-
-	if (!desc)
-		return;
-
-	irq_percpu_disable(desc, cpu);
-	irq_put_desc_unlock(desc, flags);
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_PERCPU)
+		irq_percpu_disable(scoped_irqdesc, smp_processor_id());
 }
 EXPORT_SYMBOL_GPL(disable_percpu_irq);
 


