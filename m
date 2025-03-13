Return-Path: <linux-kernel+bounces-559859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35876A5FAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7457A5D25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC01126A09F;
	Thu, 13 Mar 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAsCqzrn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIC+Ig0/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8926A0A7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881590; cv=none; b=T7tQEeAiMxppSJD6/8PyhgvrLy3YKKIXoQJlciFq0LeNan5Nt1qedxyQnp0XfRbnFpN6oQrI/4ljS8QBTbiOfa707/T5w5aqRjZTc7mOe2+jnWM0n4kygdNg1/iT6bjRg+dM4n2QPJwNnHam5Qg/d59rxmtseo40FNW+BMfhxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881590; c=relaxed/simple;
	bh=bU3D3wueHKoa5YCZCU6TXnzyYTdb0pCfbkU5jkkZ3Ek=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Vrwpib7TflW891qN2PLzsEAskU2UBnzXtjbTxYrzCOvppZxmzxe7Lk9LxW3SgP2U+DuPBQD5mtLIYjx8TnfPQghhkiAQGTWKRtQGOP48MpjioI32OtsI3Nqcdtoku6KDHzGkCwOvSJZ2kc6sjU7YvYtSKgqvdA8dXk2lgRuXUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAsCqzrn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIC+Ig0/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.075759643@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MzACv4gnMoRysCOuFSlNKThBLFwRas/s/LdFd8yEeYc=;
	b=sAsCqzrnY/JDCInUnIfuRZKlIApZ5BHXy0R3jfbN1I/CHJR1Arp6WQnGL8nqwDN3kfegCD
	RY2w4UrhU27ziNU0Fl3OpcHS5k6EyoeRqCO6w/XXxKpBouTf7jf4CX3k2MTHcRzqfabF/4
	cpuoOoCp86guk9lY8/fanahKaz/y6tGe/2REmlJyizuDEnHi/s4wCAFVtG4vHHtw1LNx9M
	PizOLYUP4CFExWSHyT7X71QiwOF1YyIaiGDdxlv3THDn1dC0a7HSlNQe12c9A38kv+CpmQ
	ATDLQE3k3PKcR/Z6T9dwHXH3QB7Sopt5BLijbXL03CMjJEWV7ptOOfEssQivQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MzACv4gnMoRysCOuFSlNKThBLFwRas/s/LdFd8yEeYc=;
	b=TIC+Ig0/YzlcNTZqDg8IsV83B5Ss/jI+Ys+wm9UC6+QSkLFI6P66NZDWK4SDsQ9zq95B8C
	Vozzs+pVA8zhfEBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 03/46] genirq/autoprobe: Switch to lock guards
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 16:59:46 +0100 (CET)

Convert all lock/unlock pairs to guards.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/autoprobe.c |   26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -43,18 +43,16 @@ unsigned long probe_irq_on(void)
 	 * flush such a longstanding irq before considering it as spurious.
 	 */
 	for_each_irq_desc_reverse(i, desc) {
-		raw_spin_lock_irq(&desc->lock);
+		guard(raw_spinlock_irq)(&desc->lock);
 		if (!desc->action && irq_settings_can_probe(desc)) {
 			/*
 			 * Some chips need to know about probing in
 			 * progress:
 			 */
 			if (desc->irq_data.chip->irq_set_type)
-				desc->irq_data.chip->irq_set_type(&desc->irq_data,
-							 IRQ_TYPE_PROBE);
+				desc->irq_data.chip->irq_set_type(&desc->irq_data, IRQ_TYPE_PROBE);
 			irq_activate_and_startup(desc, IRQ_NORESEND);
 		}
-		raw_spin_unlock_irq(&desc->lock);
 	}
 
 	/* Wait for longstanding interrupts to trigger. */
@@ -66,13 +64,12 @@ unsigned long probe_irq_on(void)
 	 * happened in the previous stage, it may have masked itself)
 	 */
 	for_each_irq_desc_reverse(i, desc) {
-		raw_spin_lock_irq(&desc->lock);
+		guard(raw_spinlock_irq)(&desc->lock);
 		if (!desc->action && irq_settings_can_probe(desc)) {
 			desc->istate |= IRQS_AUTODETECT | IRQS_WAITING;
 			if (irq_activate_and_startup(desc, IRQ_NORESEND))
 				desc->istate |= IRQS_PENDING;
 		}
-		raw_spin_unlock_irq(&desc->lock);
 	}
 
 	/*
@@ -84,18 +81,16 @@ unsigned long probe_irq_on(void)
 	 * Now filter out any obviously spurious interrupts
 	 */
 	for_each_irq_desc(i, desc) {
-		raw_spin_lock_irq(&desc->lock);
-
+		guard(raw_spinlock_irq)(&desc->lock);
 		if (desc->istate & IRQS_AUTODETECT) {
 			/* It triggered already - consider it spurious. */
 			if (!(desc->istate & IRQS_WAITING)) {
 				desc->istate &= ~IRQS_AUTODETECT;
 				irq_shutdown_and_deactivate(desc);
-			} else
-				if (i < 32)
-					mask |= 1 << i;
+			} else if (i < 32) {
+				mask |= 1 << i;
+			}
 		}
-		raw_spin_unlock_irq(&desc->lock);
 	}
 
 	return mask;
@@ -121,7 +116,7 @@ unsigned int probe_irq_mask(unsigned lon
 	int i;
 
 	for_each_irq_desc(i, desc) {
-		raw_spin_lock_irq(&desc->lock);
+		guard(raw_spinlock_irq)(&desc->lock);
 		if (desc->istate & IRQS_AUTODETECT) {
 			if (i < 16 && !(desc->istate & IRQS_WAITING))
 				mask |= 1 << i;
@@ -129,7 +124,6 @@ unsigned int probe_irq_mask(unsigned lon
 			desc->istate &= ~IRQS_AUTODETECT;
 			irq_shutdown_and_deactivate(desc);
 		}
-		raw_spin_unlock_irq(&desc->lock);
 	}
 	mutex_unlock(&probing_active);
 
@@ -160,8 +154,7 @@ int probe_irq_off(unsigned long val)
 	struct irq_desc *desc;
 
 	for_each_irq_desc(i, desc) {
-		raw_spin_lock_irq(&desc->lock);
-
+		guard(raw_spinlock_irq)(&desc->lock);
 		if (desc->istate & IRQS_AUTODETECT) {
 			if (!(desc->istate & IRQS_WAITING)) {
 				if (!nr_of_irqs)
@@ -171,7 +164,6 @@ int probe_irq_off(unsigned long val)
 			desc->istate &= ~IRQS_AUTODETECT;
 			irq_shutdown_and_deactivate(desc);
 		}
-		raw_spin_unlock_irq(&desc->lock);
 	}
 	mutex_unlock(&probing_active);
 


