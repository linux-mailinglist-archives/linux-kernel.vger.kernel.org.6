Return-Path: <linux-kernel+bounces-401990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8D9C2202
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235151F2234E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452511885A4;
	Fri,  8 Nov 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oJd+CIvE"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322BE18B09
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083064; cv=none; b=bo2OeTY6K+wZdlPZQSpmM4YXhOySlmpxu9Voi2FJlj1GT7TdfzVriHNYy3NWjvHyDf7baPZf0j+tX4tyDaNuUe7MZEyr+BHrdKqpcEFEXs5TaMh3rGO+FZ9qc17AqoTzxs00bzqK6+tQwGwaymns3gPw3QYDfKyraShOOmX4iTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083064; c=relaxed/simple;
	bh=Sbt8x+/j2UkXXk/kZLNcfaatbVWNHmjDlz2G3HdnJtg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F28m8aM6+awiWDwP8z4l5jJ4Zyrf+MOQffWAHJUEtx1su5lzu6bJpmP3qhdUorK7NVy1a3GItassP9vfOQAdd76eYLRspEIK9Z6X+3Zmd8PeJAYLCmYN1CszSgNLHu728RKaEVZpRjDKXR5ZdDLAamZmgT0xk7tQZV5GK7vJRlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oJd+CIvE; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zMKR9
	m10pMGgPA2owiS0OIe8hUhnak/8WG7bNyYEFK4=; b=oJd+CIvEa/55hazHPJ3DY
	bcNQIR+/A1KqOjtfxtKFv0tLatgzA7+qNCVH/4TIsNGuyYZIBp4rZufhzmBJjETc
	Nq7S/ItEWl0KXjpwO8WwalkGKo5JIAJ/UGsjkKp63P6MfsmDxbbjRz6asRvxq0l1
	xrq+KSjV+RyPCOk42rzaH8=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHpzEAOy5nKkoCBg--.1049S4;
	Sat, 09 Nov 2024 00:23:34 +0800 (CST)
From: David Wang <00107082@163.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	David Wang <00107082@163.com>
Subject: [PATCH 11/13] powerpc/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:23:27 +0800
Message-Id: <20241108162327.9887-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCHpzEAOy5nKkoCBg--.1049S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxur47Xw18WFykAF1ktFWrKrg_yoWrCF4rp3
	ySkF17Xw4fZr1Yq3W3AanFvwn8KFn0ya4Ygwn3Gr4rAa1DurWkWFnIvF47XFW7Gry2qrsa
	9r9agr18Kr98Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjD7cUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0hmRqmcuN-cU9QAGse

Performance improvement for reading /proc/interrupts on arch powerpc

Signed-off-by: David Wang <00107082@163.com>
---
 arch/powerpc/kernel/irq.c | 44 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2e1600a8bbbb..a0e8b998c9b5 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -89,69 +89,69 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 #if defined(CONFIG_PPC32) && defined(CONFIG_TAU_INT)
 	if (tau_initialized) {
-		seq_printf(p, "%*s: ", prec, "TAU");
+		seq_printf(p, "%*s:", prec, "TAU");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", tau_interrupts(j));
+			seq_put_decimal_ull_width(p, " ", tau_interrupts(j), 10);
 		seq_puts(p, "  PowerPC             Thermal Assist (cpu temp)\n");
 	}
 #endif /* CONFIG_PPC32 && CONFIG_TAU_INT */
 
-	seq_printf(p, "%*s: ", prec, "LOC");
+	seq_printf(p, "%*s:", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs_event);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).timer_irqs_event, 10);
         seq_printf(p, "  Local timer interrupts for timer event device\n");
 
-	seq_printf(p, "%*s: ", prec, "BCT");
+	seq_printf(p, "%*s:", prec, "BCT");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).broadcast_irqs_event);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).broadcast_irqs_event, 10);
 	seq_printf(p, "  Broadcast timer interrupts for timer event device\n");
 
-	seq_printf(p, "%*s: ", prec, "LOC");
+	seq_printf(p, "%*s:", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs_others);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).timer_irqs_others, 10);
         seq_printf(p, "  Local timer interrupts for others\n");
 
-	seq_printf(p, "%*s: ", prec, "SPU");
+	seq_printf(p, "%*s:", prec, "SPU");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).spurious_irqs);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).spurious_irqs, 10);
 	seq_printf(p, "  Spurious interrupts\n");
 
-	seq_printf(p, "%*s: ", prec, "PMI");
+	seq_printf(p, "%*s:", prec, "PMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).pmu_irqs);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).pmu_irqs, 10);
 	seq_printf(p, "  Performance monitoring interrupts\n");
 
-	seq_printf(p, "%*s: ", prec, "MCE");
+	seq_printf(p, "%*s:", prec, "MCE");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).mce_exceptions);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).mce_exceptions, 10);
 	seq_printf(p, "  Machine check exceptions\n");
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
-		seq_printf(p, "%*s: ", prec, "HMI");
+		seq_printf(p, "%*s:", prec, "HMI");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", paca_ptrs[j]->hmi_irqs);
+			seq_put_decimal_ull_width(p, " ", paca_ptrs[j]->hmi_irqs, 10);
 		seq_printf(p, "  Hypervisor Maintenance Interrupts\n");
 	}
 #endif
 
-	seq_printf(p, "%*s: ", prec, "NMI");
+	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).sreset_irqs);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).sreset_irqs, 10);
 	seq_printf(p, "  System Reset interrupts\n");
 
 #ifdef CONFIG_PPC_WATCHDOG
-	seq_printf(p, "%*s: ", prec, "WDG");
+	seq_printf(p, "%*s:", prec, "WDG");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).soft_nmi_irqs);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).soft_nmi_irqs, 10);
 	seq_printf(p, "  Watchdog soft-NMI interrupts\n");
 #endif
 
 #ifdef CONFIG_PPC_DOORBELL
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
-		seq_printf(p, "%*s: ", prec, "DBL");
+		seq_printf(p, "%*s:", prec, "DBL");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", per_cpu(irq_stat, j).doorbell_irqs);
+			seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).doorbell_irqs, 10);
 		seq_printf(p, "  Doorbell interrupts\n");
 	}
 #endif
-- 
2.39.2


