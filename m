Return-Path: <linux-kernel+bounces-439340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93EF9EADE4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FD11888E52
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3C23DE8D;
	Tue, 10 Dec 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itRDma+n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BWqUJMIa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255911DC9A2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826048; cv=none; b=DbeX0BGEUnkUaGcrVYAp2xH3oOBdOH3zBId3pSG8L0TAW/pY7/gXYACB1wCa5Es6F0SYuEIla5re+MzWSxL+gSG0MfuVB/ii6gG8W/PlUEEs+X78lElhVIG7rgOVva+1xKUEExVEJ5r2w6sP3UuyafYVahjdnbpt1K8+MlVNbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826048; c=relaxed/simple;
	bh=PiOZnpgCk1m1HYScd2CMlNmCkVzgwsz3b0aUpo9y5Ls=;
	h=Message-ID:From:To:Subject:References:MIME-Version:Content-Type:
	 cc:Date; b=EArr5BsIg2JR+MuyjB/Z4mXkTHjDybd8eIYsvJsHXQ82etK0XUJ8Oae5qf0hErP/5278fhXDh9mmi7YB8u6Shjkk0PljrtdCRjNUiwJUyElgf3gg6DTNWQ2T5UZhkT7dwy5bIHZnvYAAE2PMWVoAwkQRCBe4mVs8uzRXEgUnhkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itRDma+n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BWqUJMIa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241210101811.561078243@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733826045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/oDl9VzvX50i0pSP6IgHha/x7PE6jIHoiziKXPgCOkc=;
	b=itRDma+nLjaXoTeblEJnucrxA8EpVLOcgF2dQQG+gQLS1GVS8zq0mxhyyG/ixoDsWs/QMq
	X1mDbDGe5DuUXS1yeoebT/souMEUKLGqV8RD0sQAxZd6pNMfEcWCt5jWWxJ4usPwLeWV1u
	lWbm+WgYRXtIkrS4rTLq7/ksKJrCOYKzbgfGplCejxiavxnq5+uC1KTUimma7bx+x3A572
	rSoL4FwHYtlKRYQ3ZuVXmJYzirLpm2kdRPv6dvxm6owuVm6kuwjovDzqLn8q/pgBEFGt5R
	Byy81oCQLHF94QDmu6epKhZ8ijfiAsdgK41iQD9p5+ggkvzbu3u38A85RpL5tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733826045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/oDl9VzvX50i0pSP6IgHha/x7PE6jIHoiziKXPgCOkc=;
	b=BWqUJMIaJuc/Z1+jYpFGKOl7m7ASX/STBib1/xrnU0fBTQb+rXiMPrqPjbwVDiHlSpEduF
	Y23RRouUbNimQGBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 2/2] genirq: Remove handle_enforce_irqctx() wrapper
References: <20241210101114.126983214@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
cc: Marc Zyngier <maz@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>
Date: Tue, 10 Dec 2024 11:20:45 +0100 (CET)

Now that it is unconditionally available, remove the wrapper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/internals.h |    5 -----
 kernel/irq/irqdesc.c   |    2 +-
 kernel/irq/resend.c    |    2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -469,11 +469,6 @@ static inline bool irq_fixup_move_pendin
 }
 #endif /* !CONFIG_GENERIC_PENDING_IRQ */
 
-static inline bool handle_enforce_irqctx(struct irq_data *data)
-{
-	return irqd_is_handle_enforce_irqctx(data);
-}
-
 #if !defined(CONFIG_IRQ_DOMAIN) || !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
 static inline int irq_domain_activate_irq(struct irq_data *data, bool reserve)
 {
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -708,7 +708,7 @@ int handle_irq_desc(struct irq_desc *des
 		return -EINVAL;
 
 	data = irq_desc_get_irq_data(desc);
-	if (WARN_ON_ONCE(!in_hardirq() && handle_enforce_irqctx(data)))
+	if (WARN_ON_ONCE(!in_hardirq() && irqd_is_handle_enforce_irqctx(data)))
 		return -EPERM;
 
 	generic_handle_irq_desc(desc);
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -53,7 +53,7 @@ static int irq_sw_resend(struct irq_desc
 	 * Validate whether this interrupt can be safely injected from
 	 * non interrupt context
 	 */
-	if (handle_enforce_irqctx(&desc->irq_data))
+	if (irqd_is_handle_enforce_irqctx(&desc->irq_data))
 		return -EINVAL;
 
 	/*


