Return-Path: <linux-kernel+bounces-439358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E3E9EAE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE85168550
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D16212D75;
	Tue, 10 Dec 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WHaoYXCR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UqBdfxwZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F8210F54
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826864; cv=none; b=DU+FoT8E3kkHto1OCyivzKwxqlTwxrDG97hjlQuxmrarUILvA0zqqOMU0AAh1Th52+cIIV+WnIS6/9x7PP6RRAEreCXk/2yTsBvHOaIKGkn0AuLUXNWCbtN0HSLvrKIbr0MjBDIafl5JnBktBAbgbYw1bASV60lmPwp0OCqajWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826864; c=relaxed/simple;
	bh=J/6HxjJew/LGYhubznOX5TMU1BpkqtPtYkZJmW0nVGw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=V/1CwR2t2Uc/ZvArrqnua1i3mhystSyIYxWfvsIRCRxvTsgKZRbvkWL17X5y8Yb01qTwbk6b8LiaUdih3Xucbr2eIp+frbq5LuToi9Ezgy1FqzWLzvDhEI/OGe0b3/Y1LgVu/JH/5G6QFpvGKOpYNBlGAkrSofbBCRG52QxEcoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WHaoYXCR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UqBdfxwZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241210103335.500314436@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733826854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sn6OR2UAKgql9hXOpQOx0ZOiWncZqBg4HOFQtaeau8U=;
	b=WHaoYXCRfDMtYB0zI2TucVkKC38k7sRjJCe23k4P/JVwIEGw47THqSVSQNjvT7QHgnucHS
	OvE+uhv6cFq0QoXRAYdGckr51I3wLnaQJQm3Xx4i3YEV3Rj7YPE5wrgdx1ajw8QlplyAWS
	Zoz1QBJ6OS7P5QnS2bnVTu6rxHH6KU31mKRKQ+Lg8u4n9ZFLqmGFmSe6Ubq9qt2fUorWUa
	6qZPnJ0xRPYxEJhK5UA2VHJZivH3ssnqBeAGLGm1VS5Mi+oaxTVlaYmU2W3tyToSJikwBT
	RId3L7cJvO5zz/Ia3y+Lqvd1qtBIheJOvscNCsoDqTWXcWDH394I0uAHKmlkXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733826854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sn6OR2UAKgql9hXOpQOx0ZOiWncZqBg4HOFQtaeau8U=;
	b=UqBdfxwZ6wHefk7qF/uYXbZaBATqK5+rjGpXwSUAu1Skl+qinbO+TgIbwfmU36XrwW/XmV
	/Z8KLMtsnp2xoNCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Anup Patel <apatel@ventanamicro.com>,
 Vineet Gupta <vgupta@kernel.org>,
 Brian Cain <bcain@quicinc.com>,
 Wei Liu <wei.liu@kernel.org>,
 Steve Wahl <steve.wahl@hpe.com>,
 Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Juergen Gross <jgross@suse.com>
Subject: [patch 3/5] genirq: Provide IRQCHIP_MOVE_DEFERRED
References: <20241210102148.760383417@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Dec 2024 11:34:14 +0100 (CET)

The logic of GENERIC_PENDING_IRQ is backwards for historical reasons. Most
interrupt controllers allow to move the interrupt from arbitrary
contexts. If GENERIC_PENDING_IRQ is enabled by an architecture to support a
chip, which requires the affinity change to happen in interrupt context,
all other chips have to be marked with IRQF_MOVE_PCNTXT.

That's tedious and there is no real good reason for the extra flags in the
irq descriptor and the irq data status fields. In fact the decision whether
interrupts can be moved in arbitrary context or not is a property of the
interrupt chip.

To simplify adoption for RISC-V provide a new mechanism which is enabled
via a config switch and allows to add a flag to irq_chip::flags to request
that interrupt affinity changes are deferred. Setting the top level chip of
an interrupt evaluates the flag and maps it into the existing logic.

The config switch and the various PCNTXT flags are temporary until x86 is
converted over to this scheme. This intermediate step also allows trivial
backporting of the mechanism to plug the affinity change race of various
RISC-V interrupt controllers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |    2 ++
 kernel/irq/Kconfig  |    4 ++++
 kernel/irq/chip.c   |   18 +++++++++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -567,6 +567,7 @@ struct irq_chip {
  *                                    in the suspend path if they are in disabled state
  * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before startup
  * IRQCHIP_IMMUTABLE:		      Don't ever change anything in this chip
+ * IRQCHIP_MOVE_DEFERRED:	      Move the interrupt in actual interrupt context
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -581,6 +582,7 @@ enum {
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
 	IRQCHIP_AFFINITY_PRE_STARTUP		= (1 << 10),
 	IRQCHIP_IMMUTABLE			= (1 << 11),
+	IRQCHIP_MOVE_DEFERRED			= (1 << 12),
 };
 
 #include <linux/irqdesc.h>
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -31,6 +31,10 @@ config GENERIC_IRQ_EFFECTIVE_AFF_MASK
 config GENERIC_PENDING_IRQ
 	bool
 
+# Deduce delayed migration from top-level interrupt chip flags
+config GENERIC_PENDING_IRQ_CHIPFLAGS
+	bool
+
 # Support for generic irq migrating off cpu before the cpu is offline.
 config GENERIC_IRQ_MIGRATION
 	bool
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -47,6 +47,13 @@ int irq_set_chip(unsigned int irq, const
 		return -EINVAL;
 
 	desc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
+
+	if (IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS) && chip) {
+		if (chip->flags & IRQCHIP_MOVE_DEFERRED)
+			irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
+		else
+			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
+	}
 	irq_put_desc_unlock(desc, flags);
 	/*
 	 * For !CONFIG_SPARSE_IRQ make the irq show up in
@@ -1114,16 +1121,21 @@ void irq_modify_status(unsigned int irq,
 	trigger = irqd_get_trigger_type(&desc->irq_data);
 
 	irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
-		   IRQD_TRIGGER_MASK | IRQD_LEVEL | IRQD_MOVE_PCNTXT);
+		   IRQD_TRIGGER_MASK | IRQD_LEVEL);
 	if (irq_settings_has_no_balance_set(desc))
 		irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
 	if (irq_settings_is_per_cpu(desc))
 		irqd_set(&desc->irq_data, IRQD_PER_CPU);
-	if (irq_settings_can_move_pcntxt(desc))
-		irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
 	if (irq_settings_is_level(desc))
 		irqd_set(&desc->irq_data, IRQD_LEVEL);
 
+	/* Keep this around until x86 is converted over */
+	if (!IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS)) {
+		irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
+		if (irq_settings_can_move_pcntxt(desc))
+			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
+	}
+
 	tmp = irq_settings_get_trigger_mask(desc);
 	if (tmp != IRQ_TYPE_NONE)
 		trigger = tmp;


