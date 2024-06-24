Return-Path: <linux-kernel+bounces-227135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBAC9148E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED751288D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF9139587;
	Mon, 24 Jun 2024 11:35:54 +0000 (UTC)
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849CE125D6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.13.118.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228954; cv=none; b=tZ/hTnpJ5lHYqmepEOa275S3LAjmNqQSj5d6Bf+okkAj7G7RjZBMVqgZ19WFF0g/NAqkcb9SwUW2K89Jz6r2Ki6WcwxSZ/TZ0d5RZSziUv7BJijE81vKJP6cQhtJ1IA1lVhQIN0Bqi8zWquTo9ijaPNhUI2209J6OFHzh8EqISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228954; c=relaxed/simple;
	bh=Qqyk+/haOh1CXJbk+9H1jxaRsYXnkuJfPXEiKLTQVxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hc61A1YPdtnYHNP2/0Z1bjvzSzl7nZL+8HSDjWwso2kVu4sA8YC+pJkinR2Uzcw0nLBuFWCt2jz6SadAOG2WYA35Ie1uL90PXGcqm0dcpZWKP5KdMIjmVXksZhfZxmIN6vVfWXYLXdYWauLLldBg3MzFWluHxn7akKWcDGvOwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com; spf=pass smtp.mailfrom=asrmicro.com; arc=none smtp.client-ip=210.13.118.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asrmicro.com
Received: from exch01.asrmicro.com (exch01.asrmicro.com [10.1.24.121])
	by spam.asrmicro.com with ESMTPS id 45OBZQ5d092315
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Mon, 24 Jun 2024 19:35:26 +0800 (GMT-8)
	(envelope-from zhengyan@asrmicro.com)
Received: from localhost (10.1.170.252) by exch01.asrmicro.com (10.1.24.121)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 24 Jun 2024 19:35:29
 +0800
From: zhengyan <zhengyan@asrmicro.com>
To: <zhengyan@asrmicro.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <maz@kernel.org>, <namcao@linutronix.de>, <paul.walmsley@sifive.com>,
        <qiaozhou@asrmicro.com>, <samuel.holland@sifive.com>,
        <tglx@linutronix.de>
Subject: [PATCH v2] irqchip/sifive-plic: ensure interrupt is enable before EOI
Date: Mon, 24 Jun 2024 11:35:23 +0000
Message-ID: <20240624113523.23-1-zhengyan@asrmicro.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <69174a28eff44ad1b069887aa514971e@exch03.asrmicro.com>
References: <69174a28eff44ad1b069887aa514971e@exch03.asrmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam.asrmicro.com 45OBZQ5d092315

RISC-V PLIC cannot "end-of-interrupt" (EOI) disabled interrupts, as
explained in the description of Interrupt Completion in the PLIC spec:
"The PLIC signals it has completed executing an interrupt handler by
 writing the interrupt ID it received from the claim to the claim/complete
 register. The PLIC does not check whether the completion ID is the same
 as the last claim ID for that target. If the completion ID does not match
 an interrupt source that *is currently enabled* for the target, the
 completion is silently ignored."

 Commit 9c92006b896c ("irqchip/sifive-plic: Enable interrupt if needed
 before EOI")
 ensured that EOI is enable when irqd IRQD_IRQ_DISABLED is set, before
 EOI

 Commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
 ensured that EOI is successful by enabling interrupt first, before EOI.

 Commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
 operations") removed the interrupt enabling code from the previous
 commit, because it assumes that interrupt should already be enabled at the
 point of EOI.

However, here still miss a corner case that if SMP is enabled. When
someone needs to set affinity from a cpu to another the original cpu
when handle the EOI meanwhile the IE is disabled by plic_set_affinity

For example, broadcast tick is working,
cpu0 is about to response, cpu1 is the next.
1. cpu0 responses the timer irq, read the claim REG, do timer isr event.
2. during the timer isr it will set next event
tick_broadcast_set_event -> irq_set_affinity->xxx->
plic_set_affinity -> plic_irq_enable
3. in plic_set_affinity disable cpu0's IE and enable cpu1'IE
4. cpu0 do the write claim to finish this irq, while cpu0's IE is disabled,
left an active state in plic.

So this patch ensure that won't happened

Signed-off-by: zhengyan <zhengyan@asrmicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e378f5..815ce8aa28f1 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -149,8 +149,10 @@ static void plic_irq_mask(struct irq_data *d)
 static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	void __iomem *reg = handler->enable_base + (d->hwirq / 32) * sizeof(u32);
+	u32 hwirq_mask = 1 << (d->hwirq % 32);
 
-	if (unlikely(irqd_irq_disabled(d))) {
+	if (unlikely((readl(reg) & hwirq_mask) == 0)) {
 		plic_toggle(handler, d->hwirq, 1);
 		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
 		plic_toggle(handler, d->hwirq, 0);
-- 
2.25.1


