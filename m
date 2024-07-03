Return-Path: <linux-kernel+bounces-238991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03535925498
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CE51C22F57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73E136986;
	Wed,  3 Jul 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cWCUWJRE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VfecQw4B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08063131BDD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991637; cv=none; b=ntktQMgWWfbEQcnr+sQ+/zWaq6shysTEcojNsgWB9ymhFq2SO/CPY/FWk/5EwFkajAcaA7x+B8VERdX+AE+sW3gd0DbK/h4uTm6EJQPDY/4qQxzhWqaiLc9IpgxdOaMz5XKy00kpCDWuoe4JhFzM+JU+zgEZiRxMjxlA58t5fl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991637; c=relaxed/simple;
	bh=cM8/M8U634gVxIx336CkQPrPYnfeztmQtdkWIoUGX8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eKw6GiC/T8FnYJWMqFrU+HPLFVeySxkAL2+HrvCojT+s4HczSACRdqjB2cUavx/2A48X5NrP7lcMd5XsjYDVB0w7oPyZ/SJHm7+1tfS4ccDbLnBKQZxbIM9qFgitFd6fOaeg9pbX892e9aocBJjOM1hck3XOXUfkgP2WcClMid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cWCUWJRE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VfecQw4B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719991632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MRcJPtwAugYmLwEOwHvkFNkj81DmVpTFKEzVl8DhqJA=;
	b=cWCUWJREPkgjz37I6P43j3hFhZiohMBVz1GQbLrPDZnFfwz4OhL8sRSHHNUVvqbenZUhQk
	DFmNoElj7rVxYLBoNenv8g+uQ9C30Hr3r/AOLX3LrfW43KJhk1gydRHLt4ar6+wyxsgpeg
	XqjytzayiC6s1QnhNV9yWmoJYP1YrXwvNEVb5PEsD2GBFkUEhZxCRRr9Y/QT8pkHHfSeEw
	xkRhFYjnwtUshJhQBoQULnjmOEcKIYjflpYh7UJkN2Zt2s4jSZVhRfErJIoMhWh7poqVvR
	nHizDL/udwwRD1QJSzVDz9icxEsPb9mR8wBV1OE2F3ilvveMUyPTTQBYjihpNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719991632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MRcJPtwAugYmLwEOwHvkFNkj81DmVpTFKEzVl8DhqJA=;
	b=VfecQw4BTpl4G88MXoxRxCmbv0R/oY7OVgFVy++xzFwQ0gAjrd6gCE2wvuMsU0+CHfauGK
	g7e5fp+5fuxt/PBA==
To: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: b.spranger@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Anup Patel <anup@brainfault.org>,
	Christoph Hellwig <hch@lst.de>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] irqchip/sifive-plic: Fix plic_set_affinity() only enables 1 cpu
Date: Wed,  3 Jul 2024 09:26:59 +0200
Message-Id: <20240703072659.1427616-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

plic_set_affinity() only enables interrupt for the first possible CPU in
the mask. The point is to prevent all CPUs trying to claim an interrupt,
but only one CPU succeeds and the other CPUs wasted some clock cycles for
nothing.

However, there are two problems with that:
1. Users cannot enable interrupt on multiple CPUs (for example, to minimize
interrupt latency).
2. Even if users do not touch SMP interrupt affinity, plic_set_affinity()
is still invoked once (in plic_irqdomain_map()). Thus, by default, only
CPU0 handles interrupts from PLIC. That may overload CPU0.

Considering this optimization is not strictly the best (it is tradeoff
between CPU cycles and interrupt latency), it should not be forced on
users.

Rewrite plic_set_affinity() to enable interrupt for all possible CPUs in
the mask.

Before:
$ cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 10:       2538       2695       3080       2309  RISC-V INTC   5 Edge      riscv-timer
 12:          3          0          0          0  SiFive PLIC 111 Edge      17030000.power-controller
 13:       1163          0          0          0  SiFive PLIC  25 Edge      13010000.spi
 14:         60          0          0          0  SiFive PLIC   7 Edge      end0
 15:          0          0          0          0  SiFive PLIC   6 Edge      end0
 16:          0          0          0          0  SiFive PLIC   5 Edge      end0
 17:          0          0          0          0  SiFive PLIC  78 Edge      end1
 18:          0          0          0          0  SiFive PLIC  77 Edge      end1
 19:          0          0          0          0  SiFive PLIC  76 Edge      end1
 22:        796          0          0          0  SiFive PLIC  32 Edge      ttyS0
 23:          0          0          0          0  SiFive PLIC  38 Edge      pl022
 24:       9062          0          0          0  SiFive PLIC  75 Edge      dw-mci
 25:          0          0          0          0  SiFive PLIC  35 Edge      10030000.i2c
 26:          0          0          0          0  SiFive PLIC  37 Edge      10050000.i2c
 27:          1          0          0          0  SiFive PLIC  50 Edge      12050000.i2c
 28:          0          0          0          0  SiFive PLIC  51 Edge      12060000.i2c
IPI0:       118         98         88        138  Rescheduling interrupts
IPI1:      2272       1910       3758       3200  Function call interrupts
IPI2:         0          0          0          0  CPU stop interrupts
IPI3:         0          0          0          0  CPU stop (for crash dump) interrupts
IPI4:         0          0          0          0  IRQ work interrupts
IPI5:         0          0          0          0  Timer broadcast interrupts

After:
$ cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 10:       2539       2734       2295       2552  RISC-V INTC   5 Edge      riscv-timer
 12:          2          1          0          0  SiFive PLIC 111 Edge      17030000.power-controller
 13:        643        194        368         75  SiFive PLIC  25 Edge      13010000.spi
 14:          6         22         19         27  SiFive PLIC   7 Edge      end0
 15:          0          0          0          0  SiFive PLIC   6 Edge      end0
 16:          0          0          0          0  SiFive PLIC   5 Edge      end0
 17:          0          0          0          0  SiFive PLIC  78 Edge      end1
 18:          0          0          0          0  SiFive PLIC  77 Edge      end1
 19:          0          0          0          0  SiFive PLIC  76 Edge      end1
 22:        158        254        226        207  SiFive PLIC  32 Edge      ttyS0
 23:          0          0          0          0  SiFive PLIC  38 Edge      pl022
 24:       2265       2250       1452       2024  SiFive PLIC  75 Edge      dw-mci
 25:          0          0          0          0  SiFive PLIC  35 Edge      10030000.i2c
 26:          0          0          0          0  SiFive PLIC  37 Edge      10050000.i2c
 27:          0          0          0          1  SiFive PLIC  50 Edge      12050000.i2c
 28:          0          0          0          0  SiFive PLIC  51 Edge      12060000.i2c
IPI0:        92        118        116        120  Rescheduling interrupts
IPI1:      4135       2653       2170       3160  Function call interrupts
IPI2:         0          0          0          0  CPU stop interrupts
IPI3:         0          0          0          0  CPU stop (for crash dump) interrupts
IPI4:         0          0          0          0  IRQ work interrupts
IPI5:         0          0          0          0  Timer broadcast interrupts

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Anup Patel <anup@brainfault.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-sifive-plic.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e378f5..f30bdb94ceeb 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -163,20 +163,19 @@ static void plic_irq_eoi(struct irq_data *d)
 static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
-	unsigned int cpu;
 	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+	struct cpumask new_mask;
 
-	if (force)
-		cpu = cpumask_first_and(&priv->lmask, mask_val);
-	else
-		cpu = cpumask_first_and_and(&priv->lmask, mask_val, cpu_online_mask);
+	cpumask_and(&new_mask, mask_val, &priv->lmask);
+	if (!force)
+		cpumask_and(&new_mask, &new_mask, cpu_online_mask);
 
-	if (cpu >= nr_cpu_ids)
+	if (cpumask_empty(&new_mask))
 		return -EINVAL;
 
 	plic_irq_disable(d);
 
-	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+	irq_data_update_effective_affinity(d, &new_mask);
 
 	if (!irqd_irq_disabled(d))
 		plic_irq_enable(d);
-- 
2.39.2


