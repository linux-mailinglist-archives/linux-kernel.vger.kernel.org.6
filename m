Return-Path: <linux-kernel+bounces-401963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF2F9C21A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9A21F22213
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA7916F27E;
	Fri,  8 Nov 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lp8Eq1Ua"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4F13C69E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082241; cv=none; b=Deoe1Uf5u53q38d26dCAwpQktDW4yqzzLwK1W1aJvVoq94ucr4QbIF+U6pOV/CpcQvTcUQN3ZmRRHz/50xmZvg5xjxO5USHtvsoDJViZ+wuN2cUfSbm4q8Cph8lVYFf1BUIQjcFJGmQw5kxSeqJnr2CwfdRgO+Hrd52086NWDvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082241; c=relaxed/simple;
	bh=0Aeeq1wCcKN2Yu12bsnB66u09IIUWj+8HXPdVfR6f9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D6iMpmzH9081nCUgF7jzW+VHWHt+D0Eh0/63yebfNpYhEGjv1CqEp1Eu4Yel42yvV9rzIATOersTjXV9UUIjOSlPhm9HWrvDs9JWwDSkcwGAiIh0NfpIvCtGL6JEfLWwa1WSWUXYQ23HDjZBvs0g0cd+Nsc6BcqUgJjXsNGr95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lp8Eq1Ua; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SEzQX
	bnbGfPoBDwOXvONgdW8Ya05hdRwsukPz3n3efs=; b=lp8Eq1UanrSZh7+DpVnCl
	Uz50CIs4kLpT2kaJvoiKgPJMta8fU3UsOERVAplNUUT8zz+YVj+vyANsb0cH0xH5
	KR0tKs/9ctQum876I3zDI5MES6F/iKLxuEJLYlsfWsa0qHFuKQAlvDukAABWEr9C
	gIhpkgMqyw3YajZvaQv9bY=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3fTDANy5nviQBBg--.1546S4;
	Sat, 09 Nov 2024 00:09:43 +0800 (CST)
From: David Wang <00107082@163.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH 02/13] x86/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:09:30 +0800
Message-Id: <20241108160930.9603-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3fTDANy5nviQBBg--.1546S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFyUCF4xJr17Gry5WF17KFg_yoW3ur1xp3
	yfCFsrXw4fZr1Yqw13JasrXwn8KFn0yFy5twn3Kr4rA3Z8urs3JF1avr47WFy7GryIvrs5
	uFy5WrW2g3s8uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRVuW9UUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxuRqmcuKsHRRgAAsm

Performance improvement for reading /proc/interrupts on arch x86

Signed-off-by: David Wang <00107082@163.com>
---
 arch/x86/kernel/irq.c | 100 +++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 385e3a5fc304..66cc8f001bd0 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -62,103 +62,103 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
-	seq_printf(p, "%*s: ", prec, "NMI");
+	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->__nmi_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->__nmi_count, 10);
 	seq_puts(p, "  Non-maskable interrupts\n");
 #ifdef CONFIG_X86_LOCAL_APIC
-	seq_printf(p, "%*s: ", prec, "LOC");
+	seq_printf(p, "%*s:", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_timer_irqs);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->apic_timer_irqs, 10);
 	seq_puts(p, "  Local timer interrupts\n");
 
-	seq_printf(p, "%*s: ", prec, "SPU");
+	seq_printf(p, "%*s:", prec, "SPU");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_spurious_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_spurious_count, 10);
 	seq_puts(p, "  Spurious interrupts\n");
-	seq_printf(p, "%*s: ", prec, "PMI");
+	seq_printf(p, "%*s:", prec, "PMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_perf_irqs);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->apic_perf_irqs, 10);
 	seq_puts(p, "  Performance monitoring interrupts\n");
-	seq_printf(p, "%*s: ", prec, "IWI");
+	seq_printf(p, "%*s:", prec, "IWI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_irq_work_irqs);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->apic_irq_work_irqs, 10);
 	seq_puts(p, "  IRQ work interrupts\n");
-	seq_printf(p, "%*s: ", prec, "RTR");
+	seq_printf(p, "%*s:", prec, "RTR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->icr_read_retry_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->icr_read_retry_count, 10);
 	seq_puts(p, "  APIC ICR read retries\n");
 	if (x86_platform_ipi_callback) {
-		seq_printf(p, "%*s: ", prec, "PLT");
+		seq_printf(p, "%*s:", prec, "PLT");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_stats(j)->x86_platform_ipis);
+			seq_put_decimal_ull_width(p, " ", irq_stats(j)->x86_platform_ipis, 10);
 		seq_puts(p, "  Platform interrupts\n");
 	}
 #endif
 #ifdef CONFIG_SMP
-	seq_printf(p, "%*s: ", prec, "RES");
+	seq_printf(p, "%*s:", prec, "RES");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_resched_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_resched_count, 10);
 	seq_puts(p, "  Rescheduling interrupts\n");
-	seq_printf(p, "%*s: ", prec, "CAL");
+	seq_printf(p, "%*s:", prec, "CAL");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_call_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_call_count, 10);
 	seq_puts(p, "  Function call interrupts\n");
-	seq_printf(p, "%*s: ", prec, "TLB");
+	seq_printf(p, "%*s:", prec, "TLB");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_tlb_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_tlb_count, 10);
 	seq_puts(p, "  TLB shootdowns\n");
 #endif
 #ifdef CONFIG_X86_THERMAL_VECTOR
-	seq_printf(p, "%*s: ", prec, "TRM");
+	seq_printf(p, "%*s:", prec, "TRM");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_thermal_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_thermal_count, 10);
 	seq_puts(p, "  Thermal event interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_THRESHOLD
-	seq_printf(p, "%*s: ", prec, "THR");
+	seq_printf(p, "%*s:", prec, "THR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_threshold_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_threshold_count, 10);
 	seq_puts(p, "  Threshold APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_AMD
-	seq_printf(p, "%*s: ", prec, "DFR");
+	seq_printf(p, "%*s:", prec, "DFR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_deferred_error_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_deferred_error_count, 10);
 	seq_puts(p, "  Deferred Error APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE
-	seq_printf(p, "%*s: ", prec, "MCE");
+	seq_printf(p, "%*s:", prec, "MCE");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(mce_exception_count, j));
+		seq_put_decimal_ull_width(p, " ", per_cpu(mce_exception_count, j), 10);
 	seq_puts(p, "  Machine check exceptions\n");
-	seq_printf(p, "%*s: ", prec, "MCP");
+	seq_printf(p, "%*s:", prec, "MCP");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
+		seq_put_decimal_ull_width(p, " ", per_cpu(mce_poll_count, j), 10);
 	seq_puts(p, "  Machine check polls\n");
 #endif
 #ifdef CONFIG_X86_HV_CALLBACK_VECTOR
 	if (test_bit(HYPERVISOR_CALLBACK_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HYP");
+		seq_printf(p, "%*s:", prec, "HYP");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
-				   irq_stats(j)->irq_hv_callback_count);
+			seq_put_decimal_ull_width(p, " ",
+						  irq_stats(j)->irq_hv_callback_count, 10);
 		seq_puts(p, "  Hypervisor callback interrupts\n");
 	}
 #endif
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (test_bit(HYPERV_REENLIGHTENMENT_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HRE");
+		seq_printf(p, "%*s:", prec, "HRE");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
-				   irq_stats(j)->irq_hv_reenlightenment_count);
+			seq_put_decimal_ull_width(p, " ",
+						  irq_stats(j)->irq_hv_reenlightenment_count, 10);
 		seq_puts(p, "  Hyper-V reenlightenment interrupts\n");
 	}
 	if (test_bit(HYPERV_STIMER0_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HVS");
+		seq_printf(p, "%*s:", prec, "HVS");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
-				   irq_stats(j)->hyperv_stimer0_count);
+			seq_put_decimal_ull_width(p, " ",
+						  irq_stats(j)->hyperv_stimer0_count, 10);
 		seq_puts(p, "  Hyper-V stimer0 interrupts\n");
 	}
 #endif
@@ -167,28 +167,28 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	seq_printf(p, "%*s: %10u\n", prec, "MIS", atomic_read(&irq_mis_count));
 #endif
 #if IS_ENABLED(CONFIG_KVM)
-	seq_printf(p, "%*s: ", prec, "PIN");
+	seq_printf(p, "%*s:", prec, "PIN");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->kvm_posted_intr_ipis);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->kvm_posted_intr_ipis, 10);
 	seq_puts(p, "  Posted-interrupt notification event\n");
 
-	seq_printf(p, "%*s: ", prec, "NPI");
+	seq_printf(p, "%*s:", prec, "NPI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
-			   irq_stats(j)->kvm_posted_intr_nested_ipis);
+		seq_put_decimal_ull_width(p, " ",
+					  irq_stats(j)->kvm_posted_intr_nested_ipis, 10);
 	seq_puts(p, "  Nested posted-interrupt event\n");
 
-	seq_printf(p, "%*s: ", prec, "PIW");
+	seq_printf(p, "%*s:", prec, "PIW");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
-			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
+		seq_put_decimal_ull_width(p, " ",
+					  irq_stats(j)->kvm_posted_intr_wakeup_ipis, 10);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
 #endif
 #ifdef CONFIG_X86_POSTED_MSI
-	seq_printf(p, "%*s: ", prec, "PMN");
+	seq_printf(p, "%*s:", prec, "PMN");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
-			   irq_stats(j)->posted_msi_notification_count);
+		seq_put_decimal_ull_width(p, " ",
+					  irq_stats(j)->posted_msi_notification_count, 10);
 	seq_puts(p, "  Posted MSI notification event\n");
 #endif
 	return 0;
-- 
2.39.2


