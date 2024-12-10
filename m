Return-Path: <linux-kernel+bounces-439355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B39EAE09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3986D16851F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785C2080D6;
	Tue, 10 Dec 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pYsadv+9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+VZCTW49"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D423DEB9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826859; cv=none; b=dmxrM2iSs6rNTtWp9ot2mF02wEfISU88buRuAtNNY4cPVf8C9vYbuQHlQDKfW3nb+md8sd8AWhP4ZrGY+Qtiyl5pWP1zVcBz3t8WU77wioHsnRsi6WdD0WYBCVTnLEQN3tdreMSi569mFu4Xphugurb0IWgBs1p+YOdMRsgt5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826859; c=relaxed/simple;
	bh=o60wCU2VnZ8PuDwGNWj2BCybBVp81F0WORBYw7xeBpA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=UdgQ/bRTBfEKBCyvInEaWzxmpB5PBh5dGGHac6X2YRijAYbzi0TJU5ibsrqj46N6LtPrGlwyJ9v1PxjY+zfLKuNTSYrvENkyFxdEeO44/HwscHn1amQl3sv4ElXxJ3VhhFDfRobm4nr9GG/Na70C5u0ptM0mOZPi5ZZb/X9FTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pYsadv+9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+VZCTW49; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241210103335.373392568@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733826851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0GBO+kXAiZqSYt9BqbnxtGix5vHwVBHq9zW5m+OuaGk=;
	b=pYsadv+9OFHFUr+wRyxUWeLR6mck8wFJshU5OIlBrbLCcICpw8N8VaPcY/YzOPpWnpbugU
	BoDo6klEIJcwDl1VJh0JRHXYoWkNFlMSlSVbOrxRs2sH4uMI041jr+11Bx7tAQpdYl2pNK
	BJrUJm7TqbUfesKmP+/5ORmYlEEqEUGKyLyashDG2EaQdx9mBQ0en7nqn8m8Mri48c5JVR
	dlCUCjLfChSFOHrcq5AWJNZtwrGDsnqptb2W9FM4M8QkdY/dff6G9EaDzgX/eAEMs4bAAe
	lsmDLRDBMjz1DYmdrN26P5M5nrlwP3DbgQ/I3B7kypYucgEnh///peW3qEz4DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733826851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0GBO+kXAiZqSYt9BqbnxtGix5vHwVBHq9zW5m+OuaGk=;
	b=+VZCTW49ETrI57GT7tJ4x9pE+mqtMUM/Jb/uNS28y8lJoN/rOUoQvtflcLr7l4bUEaOnYd
	cFxzAKJuk9oe6qDg==
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
Subject: [patch 1/5] ARC: Remove GENERIC_PENDING_IRQ
References: <20241210102148.760383417@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Dec 2024 11:34:10 +0100 (CET)

Nothing uses the actual functionality and the MCIP controller sets the
flags which disables the deferred affinity change. The other interrupt
controller does not support affinity setting at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig       |    1 -
 arch/arc/kernel/mcip.c |    2 --
 kernel/irq/debugfs.c   |    1 +
 3 files changed, 1 insertion(+), 3 deletions(-)

--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -24,7 +24,6 @@ config ARC
 	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
-	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IOREMAP
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -357,8 +357,6 @@ static void idu_cascade_isr(struct irq_d
 static int idu_irq_map(struct irq_domain *d, unsigned int virq, irq_hw_number_t hwirq)
 {
 	irq_set_chip_and_handler(virq, &idu_irq_chip, handle_level_irq);
-	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
-
 	return 0;
 }
 
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -53,6 +53,7 @@ static const struct irq_bit_descr irqchi
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
 	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
 	BIT_MASK_DESCR(IRQCHIP_IMMUTABLE),
+	BIT_MASK_DESCR(IRQCHIP_MOVE_DEFERRED),
 };
 
 static void


