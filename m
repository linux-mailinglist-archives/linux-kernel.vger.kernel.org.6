Return-Path: <linux-kernel+bounces-439338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995439EADE1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C341652E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE41DC9B0;
	Tue, 10 Dec 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QEI7pUSn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GKic31Sq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF362197A7F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826047; cv=none; b=R3VamJwnJD9GPdmH/5P1KRqFAlesdPDQbJHcprbU6sHbshwouX010B2ixwD/RaRoD2HcqYgqjtDy6lztHu4bRX0oDdFxScZkPaeVoD9HL4f9raraS5SuafVZqpptqmOmX3AtupGpVMo5O2wS6qxqtc4twg07m24af8TBAL0uB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826047; c=relaxed/simple;
	bh=vuNmMMWX1fv71HxaXsVGskpwiVOTZE7xPc1uXd9+QR0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DPcHdkgshTOWd29k+vXqwJs46Yq1XlOL25o/YlILXf+2xWTsqECv82bUrzxjFSafARc4AkVhT2ZCaxTEAVvQIc867SK019G+nEGDtYNSZturguXZSanNf3vUEvYamqI8DWZZUbftSWtbaopy0w6v17aTmuLqvdCjMQIf/0+QZvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QEI7pUSn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GKic31Sq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241210101811.497716609@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733826043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KmkAuzbm4a+qactOGR6smW7QItuLqmWVrEBlv9kYunM=;
	b=QEI7pUSnfM1VqmhOZOicb8+4VMSuHC6yYkj1skwU4fwVLOaQLtvbAplRR5bEerVZKFYaF4
	PVXuM8hs/tHYzXg+SFJRO5UAEX8bVG8KLOd01jDSU7S4YQ2TbQ4mhV9qEZdlJR0PZncLBH
	a5iWwa7hTn5J+aCy3MGeFnNiv1WfEySLIJvMl3anG4OuJay5vuQXS+ujsDlewc4o+ufDAE
	/FhnmxX13JgUAuhQnuuVxtQRbhySvNjLdGFa082i/Nh3oDkBh3hgCUTl+42+6/AlfNEpkH
	QUt5kXETc6OJgKXR9XUrIY4ihv70Si8W5LqMvtk9f3eoYx34rNgCLWwj5CHMoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733826043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KmkAuzbm4a+qactOGR6smW7QItuLqmWVrEBlv9kYunM=;
	b=GKic31SqVonzo25+jJRyyBpOemJcs5gFSNnnAfANKxzQRZMDUGFsR9iRa3xhSJzwjhC2wc
	WHXM5qeeNIHaGuBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>
Subject: [patch 1/2] genirq: Make handle_enforce_irqctx() unconditionally
 available
References: <20241210101114.126983214@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Dec 2024 11:20:43 +0100 (CET)

Commit 1b57d91b969c ("irqchip/gic-v2, v3: Prevent SW resends entirely")
sett the flag which enforces interrupt handling in interrupt context and
prevents software base resends for ARM GIC v2/v3.

But it missed that the helper function which checks the flag was hidden
behind CONFIG_GENERIC_PENDING_IRQ, which is not set by ARM[64].

Make the helper unconditionally available so that the enforcement actually
works.

Fixes: 1b57d91b969c ("irqchip/gic-v2, v3: Prevent SW resends entirely")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/irq/internals.h |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -441,10 +441,6 @@ static inline struct cpumask *irq_desc_g
 {
 	return desc->pending_mask;
 }
-static inline bool handle_enforce_irqctx(struct irq_data *data)
-{
-	return irqd_is_handle_enforce_irqctx(data);
-}
 bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear);
 #else /* CONFIG_GENERIC_PENDING_IRQ */
 static inline bool irq_can_move_pcntxt(struct irq_data *data)
@@ -471,11 +467,12 @@ static inline bool irq_fixup_move_pendin
 {
 	return false;
 }
+#endif /* !CONFIG_GENERIC_PENDING_IRQ */
+
 static inline bool handle_enforce_irqctx(struct irq_data *data)
 {
-	return false;
+	return irqd_is_handle_enforce_irqctx(data);
 }
-#endif /* !CONFIG_GENERIC_PENDING_IRQ */
 
 #if !defined(CONFIG_IRQ_DOMAIN) || !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
 static inline int irq_domain_activate_irq(struct irq_data *data, bool reserve)


