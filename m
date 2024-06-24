Return-Path: <linux-kernel+bounces-226946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9341914633
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15ACF1C20955
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0913665F;
	Mon, 24 Jun 2024 09:20:46 +0000 (UTC)
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE7136647
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.13.118.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220846; cv=none; b=Th3De04lzKnxGDVZLLgdyCTyFDclmpDxdCNhhnuJkQ05AITRMPJxvgyTg/c5zsotrRvFeL4OcB0mgC5UCslrgU9HZchoOjHNl0WLe9ARa4IvfdlHMUhyNqgsSZL4ojUoCxDDIpLHpYZhadv+IHuvJ1lCnqYtSPE98uDXz5detvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220846; c=relaxed/simple;
	bh=aKtpL8TEMGeUWkluo9pD8j4FnHMywJYbFfnGTPQOCA4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XNZDH0O8nXoyVSrliGuA4dPJZbzd7UKJf5L7iuMFUs78k5fExNVaRLWDI7+BtmFkhsxOJymTewEVhX9VNwIeKIMYEbAOX4AK1SshfZt+xcjFmfcryOebOErG0klV2rHkB/s7pZ+G1oO4AQSyDFBnMCWEHTLHB5cztE2Ab7LhY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com; spf=pass smtp.mailfrom=asrmicro.com; arc=none smtp.client-ip=210.13.118.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asrmicro.com
Received: from spam.asrmicro.com (localhost [127.0.0.2] (may be forged))
	by spam.asrmicro.com with ESMTP id 45O8t5ci053343
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:55:05 +0800 (GMT-8)
	(envelope-from zhengyan@asrmicro.com)
Received: from exch03.asrmicro.com (exch03.asrmicro.com [10.1.24.118])
	by spam.asrmicro.com with ESMTPS id 45O8s6oF053124
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Mon, 24 Jun 2024 16:54:06 +0800 (GMT-8)
	(envelope-from zhengyan@asrmicro.com)
Received: from localhost (10.1.170.252) by exch03.asrmicro.com (10.1.24.118)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 24 Jun 2024 16:54:09
 +0800
From: zhengyan <zhengyan@asrmicro.com>
To: <tglx@linutronix.de>, <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <samuel.holland@sifive.com>,
        <linux-riscv@lists.infradead.org>
CC: <qiaozhou@asrmicro.com>, zhengyan <zhengyan@asrmicro.com>
Subject: [PATCH] irqchip/sifive-plic: ensure interrupt is enable before EOI
Date: Mon, 24 Jun 2024 08:53:41 +0000
Message-ID: <20240624085341.3935-1-zhengyan@asrmicro.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam.asrmicro.com 45O8t5ci053343

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
someone need to set affinity from a cpu to another (Maybe like
boardcast-tick) the original cpu when handle the EOI meanwhile the IE is
disabled by plic_set_affinity

So this patch ensure that won't happened

Signed-off-by: zhengyan <zhengyan@asrmicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e378f5..e6acd134a691 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -149,8 +149,10 @@ static void plic_irq_mask(struct irq_data *d)
 static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	void __iomem *reg = handler->enable_base + (d->hwirq / 32) * sizeof(u32);
+	u32 hwirq_mask = 1 << (d->hwirq % 32);
 
-	if (unlikely(irqd_irq_disabled(d))) {
+	if (unlikely(irqd_irq_disabled(d)) || (readl(reg) & hwirq_mask) == 0) {
 		plic_toggle(handler, d->hwirq, 1);
 		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
 		plic_toggle(handler, d->hwirq, 0);
-- 
2.25.1


