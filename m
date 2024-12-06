Return-Path: <linux-kernel+bounces-434847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9459E6C05
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE4616D897
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A45202F90;
	Fri,  6 Dec 2024 10:18:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439461DB362
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480295; cv=none; b=TVNS2+aIPdcik4aMV4OzMi39Yek2Ryfoz9ia8N7YrfCbc/Kr4ONzkOOcQOu4Ji8cWUF2vpnabQSraYFATX5I10bW/HR5hdCW8Q1sABV9cf9WzgOURj2//hjeNID4zAmd+khCVXZTWP2ULyk81/QqFcdmj8tjLZYNsDHnhICnaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480295; c=relaxed/simple;
	bh=de8OTUJPcJzqaktysdg1rIGQL6GDLSIpHmL5BJycq34=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqkuH7A2kh7ky8Ggpis8Xfdax+Dd+LQpJrS0vsGEs33vh9gUQRvXQo637Rhfp/wH1DFW7PNsbRBGVltJzXAmpgrcWG4uQtUx8lkKpGny91CPxusxAP+6SPr3Q8dw9yaCTJesWEV0Qs7xvF9R9sN32CCvDc76F5ddp3POLVHWeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y4RxJ14MkzqTVR;
	Fri,  6 Dec 2024 18:16:20 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BBA41800D9;
	Fri,  6 Dec 2024 18:18:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 18:18:06 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<luto@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kees@kernel.org>, <wad@chromium.org>,
	<akpm@linux-foundation.org>, <samitolvanen@google.com>,
	<masahiroy@kernel.org>, <hca@linux.ibm.com>, <aliceryhl@google.com>,
	<rppt@kernel.org>, <xur@google.com>, <paulmck@kernel.org>, <arnd@arndb.de>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <mark.rutland@arm.com>,
	<ruanjinjie@huawei.com>, <pcc@google.com>, <ardb@kernel.org>,
	<sudeep.holla@arm.com>, <guohanjun@huawei.com>, <rafael@kernel.org>,
	<liuwei09@cestc.cn>, <dwmw@amazon.co.uk>, <Jonathan.Cameron@huawei.com>,
	<liaochang1@huawei.com>, <kristina.martsenko@arm.com>, <ptosi@google.com>,
	<broonie@kernel.org>, <thiago.bauermann@linaro.org>, <kevin.brodsky@arm.com>,
	<joey.gouly@arm.com>, <liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH -next v5 01/22] arm64: ptrace: Replace interrupts_enabled() with regs_irqs_disabled()
Date: Fri, 6 Dec 2024 18:17:23 +0800
Message-ID: <20241206101744.4161990-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206101744.4161990-1-ruanjinjie@huawei.com>
References: <20241206101744.4161990-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)

The generic entry code expects architecture code to provide
regs_irqs_disabled(regs) function, but arm64 does not have this and
provides inerrupts_enabled(regs), which has the opposite polarity.

In preparation for moving arm64 over to the generic entry code,
relace arm64's interrupts_enabled() with regs_irqs_disabled() and
update its callers under arch/arm64.

For the moment, a definition of interrupts_enabled() is provided for
the GICv3 driver. Once arch/arm implement regs_irqs_disabled(), this
can be removed.

No functional changes.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/daifflags.h  | 2 +-
 arch/arm64/include/asm/ptrace.h     | 7 +++++++
 arch/arm64/include/asm/xen/events.h | 2 +-
 arch/arm64/kernel/acpi.c            | 2 +-
 arch/arm64/kernel/debug-monitors.c  | 2 +-
 arch/arm64/kernel/entry-common.c    | 4 ++--
 arch/arm64/kernel/sdei.c            | 2 +-
 7 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index fbb5c99eb2f9..5fca48009043 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -128,7 +128,7 @@ static inline void local_daif_inherit(struct pt_regs *regs)
 {
 	unsigned long flags = regs->pstate & DAIF_MASK;
 
-	if (interrupts_enabled(regs))
+	if (!regs_irqs_disabled(regs))
 		trace_hardirqs_on();
 
 	if (system_uses_irq_prio_masking())
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 47ff8654c5ec..bcfa96880377 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -214,9 +214,16 @@ static inline void forget_syscall(struct pt_regs *regs)
 		(regs)->pmr == GIC_PRIO_IRQON :				\
 		true)
 
+/*
+ * Used by the GICv3 driver, can be removed once arch/arm implements
+ * regs_irqs_disabled() directly.
+ */
 #define interrupts_enabled(regs)			\
 	(!((regs)->pstate & PSR_I_BIT) && irqs_priority_unmasked(regs))
 
+#define regs_irqs_disabled(regs)			\
+	(((regs)->pstate & PSR_I_BIT) || (!irqs_priority_unmasked(regs)))
+
 #define fast_interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_F_BIT))
 
diff --git a/arch/arm64/include/asm/xen/events.h b/arch/arm64/include/asm/xen/events.h
index 2788e95d0ff0..2977b5fe068d 100644
--- a/arch/arm64/include/asm/xen/events.h
+++ b/arch/arm64/include/asm/xen/events.h
@@ -14,7 +14,7 @@ enum ipi_vector {
 
 static inline int xen_irqs_disabled(struct pt_regs *regs)
 {
-	return !interrupts_enabled(regs);
+	return regs_irqs_disabled(regs);
 }
 
 #define xchg_xen_ulong(ptr, val) xchg((ptr), (val))
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e6f66491fbe9..732f89daae23 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -403,7 +403,7 @@ int apei_claim_sea(struct pt_regs *regs)
 	return_to_irqs_enabled = !irqs_disabled_flags(arch_local_save_flags());
 
 	if (regs)
-		return_to_irqs_enabled = interrupts_enabled(regs);
+		return_to_irqs_enabled = !regs_irqs_disabled(regs);
 
 	/*
 	 * SEA can interrupt SError, mask it and describe this as an NMI so
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 58f047de3e1c..460c09d03a73 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -231,7 +231,7 @@ static void send_user_sigtrap(int si_code)
 	if (WARN_ON(!user_mode(regs)))
 		return;
 
-	if (interrupts_enabled(regs))
+	if (!regs_irqs_disabled(regs))
 		local_irq_enable();
 
 	arm64_force_sig_fault(SIGTRAP, si_code, instruction_pointer(regs),
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index b260ddc4d3e9..c547e70428d3 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -73,7 +73,7 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs)
 {
 	lockdep_assert_irqs_disabled();
 
-	if (interrupts_enabled(regs)) {
+	if (!regs_irqs_disabled(regs)) {
 		if (regs->exit_rcu) {
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare();
@@ -569,7 +569,7 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
 {
 	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
 
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && regs_irqs_disabled(regs))
 		__el1_pnmi(regs, handler);
 	else
 		__el1_irq(regs, handler);
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 255d12f881c2..27a17da635d8 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -247,7 +247,7 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	 * If we interrupted the kernel with interrupts masked, we always go
 	 * back to wherever we came from.
 	 */
-	if (mode == kernel_mode && !interrupts_enabled(regs))
+	if (mode == kernel_mode && regs_irqs_disabled(regs))
 		return SDEI_EV_HANDLED;
 
 	/*
-- 
2.34.1


