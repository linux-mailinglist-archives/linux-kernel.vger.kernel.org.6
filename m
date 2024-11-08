Return-Path: <linux-kernel+bounces-401988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B6F9C21FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF21A1F21A92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7571991D7;
	Fri,  8 Nov 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NTzzsbwi"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11BD19A288;
	Fri,  8 Nov 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082943; cv=none; b=iklsxjvyJgL1KVjshx6oqbHJdOYAKiZnEV8ikDG0S8B985F80LTTx1znmE/IT8OWdA7+IMckGWsSd2t7iBrFZ7sjWT+n1I7f+YCPV5B2n1hGNtzqbkWgtIAZwVGndnvxTx2t8bHCSH6GKIwAtCjHr7ncSyHM2FGHJwGYWrVFQ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082943; c=relaxed/simple;
	bh=Wc9cLe7IVYxZLT9/5tiwY+AQh4oiPQMTZDWcoqSOIdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amJtLYLf+RuyB7y74a7k4B5cXiC1feYKgVTn5FZCj04SdggjuZaiepjqviNTI5atu1Edu6IfDuRC2ZyCzfopSnLboKQMXfjU2stYKg8q7vM+K/ng7yXguHatcDDNq0f8aic9X3L535/kECdBW9QXrpKIBAcBp5T+DCp725RrwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NTzzsbwi; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=W9dQM
	r8jOEecKFU+yREnJFJ6sLM3jGmavbMn1MTCrSM=; b=NTzzsbwiAP1qmhkbrWDVW
	pbbJ5UWSHSUht4baIVeCQKjTkHLPOQrkb7JKK5UJ3XtKoCnnAPcmPOhYjdblEhKa
	qDC6xiVTgPt6fylJknbbUdxyLj2TBBDlMZp/8TV1OUciTC3iAI8Tja6lloOp6pW+
	ujkjwAXDeXcmmgAbr7nBLc=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn19irOi5nxBV0Fw--.56359S4;
	Sat, 09 Nov 2024 00:22:09 +0800 (CST)
From: David Wang <00107082@163.com>
To: James.Bottomley@HansenPartnership.com,
	deller@gmx.de
Cc: linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH 10/13] parisc/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:22:01 +0800
Message-Id: <20241108162201.9853-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn19irOi5nxBV0Fw--.56359S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxur43Gr1xtw1ktrW3ur4UArb_yoW5ZF4rpa
	n3CFsrXw4fZw1Yqr13Jay7ZwnxKFn0yFyYqwsxKrWfA3Z8uws3X3W3ur17WFy7KryIvrs3
	uF98Wry2gF909w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRw2-8UUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqR2RqmcuNe9NzAAAsd

Performance improvement for reading /proc/interrupts on arch parisc

Signed-off-by: David Wang <00107082@163.com>
---
 arch/parisc/kernel/irq.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index dff66be65d29..b060d7e6da46 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -133,40 +133,42 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	int j;
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
-	seq_printf(p, "%*s: ", prec, "STK");
+	seq_printf(p, "%*s:", prec, "STK");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->kernel_stack_usage);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->kernel_stack_usage, 10);
 	seq_puts(p, "  Kernel stack usage\n");
 # ifdef CONFIG_IRQSTACKS
-	seq_printf(p, "%*s: ", prec, "IST");
+	seq_printf(p, "%*s:", prec, "IST");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_stack_usage);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_stack_usage, 10);
 	seq_puts(p, "  Interrupt stack usage\n");
 # endif
 #endif
 #ifdef CONFIG_SMP
 	if (num_online_cpus() > 1) {
-		seq_printf(p, "%*s: ", prec, "RES");
+		seq_printf(p, "%*s:", prec, "RES");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_stats(j)->irq_resched_count);
+			seq_put_decimal_ull_width(p, " ",
+						  irq_stats(j)->irq_resched_count, 10);
 		seq_puts(p, "  Rescheduling interrupts\n");
-		seq_printf(p, "%*s: ", prec, "CAL");
+		seq_printf(p, "%*s:", prec, "CAL");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_stats(j)->irq_call_count);
+			seq_put_decimal_ull_width(p, " ",
+						  irq_stats(j)->irq_call_count, 10);
 		seq_puts(p, "  Function call interrupts\n");
 	}
 #endif
-	seq_printf(p, "%*s: ", prec, "UAH");
+	seq_printf(p, "%*s:", prec, "UAH");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_unaligned_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_unaligned_count, 10);
 	seq_puts(p, "  Unaligned access handler traps\n");
-	seq_printf(p, "%*s: ", prec, "FPA");
+	seq_printf(p, "%*s:", prec, "FPA");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_fpassist_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_fpassist_count, 10);
 	seq_puts(p, "  Floating point assist traps\n");
-	seq_printf(p, "%*s: ", prec, "TLB");
+	seq_printf(p, "%*s:", prec, "TLB");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_tlb_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_tlb_count, 10);
 	seq_puts(p, "  TLB shootdowns\n");
 	return 0;
 }
@@ -195,10 +197,10 @@ int show_interrupts(struct seq_file *p, void *v)
 		action = desc->action;
 		if (!action)
 			goto skip;
-		seq_printf(p, "%3d: ", i);
+		seq_printf(p, "%3d:", i);
 
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(desc, j));
+			seq_put_decimal_ull_width(p, " ", irq_desc_kstat_cpu(desc, j), 10);
 
 		seq_printf(p, " %14s", irq_desc_get_chip(desc)->name);
 #ifndef PARISC_IRQ_CR16_COUNTS
-- 
2.39.2


