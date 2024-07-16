Return-Path: <linux-kernel+bounces-253867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A6932813
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865CF284782
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3919D087;
	Tue, 16 Jul 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="dQn+rEA6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QwBZIgQD"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111E19CD0C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139319; cv=none; b=PwPIQqTlIAykyoxlkFqazaTPxg/iKUAqC+1X+5ttSIdjvpJck13xRYdlyXYqrboNfbIs5M3Z+h65so0XfvfdPslDLFWYEf/jDC3wz/dGNvBBv8yfO5IeqVqZbLvOCWJbz7sqOvHXiqCcGWfn5LYMrUdKG4ZMXle24blWUsO7QRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139319; c=relaxed/simple;
	bh=GGxWrxkIuiB6pNabPRprOT7hoV6uxOIbhuzgpQUjGtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuQbFy/Un0v5iUXN5Be2p8PjnUEjc1VwrKPW/pgqhlja/LogyCTM+sMh2W7246r6TcXqLYeF05bLUflMCYFW0ans2m5VFNqyNYr9kFN7Mq7eFKGvdTvv8ap2Ca1TXY1+lS9tJXmfeLl/qJko24X6QxIjT227QPWjaKP5hMUsik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=dQn+rEA6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QwBZIgQD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 70B8811479D5;
	Tue, 16 Jul 2024 10:15:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 16 Jul 2024 10:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721139317;
	 x=1721225717; bh=9P6k8vU9HH5Mx412/JWWGiX0r05o97rQ7dbH4Yr2Q24=; b=
	dQn+rEA6aJU0T88iGJXTGeOwlMBspzvhFrD7QRKnQITQnIT46cj0kMpzGzn7BISN
	etddLARYYKQ2nBAswEDRSFhDE948VsROhBEmnEIJp+XLO5+240c3R7gvodT+tiDh
	NSCwdkyDiVAU83jNnAa6LUvbO1K94Z/hpu/NirJSBRiTmEZH4xdAaePyeikMbL5D
	FSDWTP1PRV3hu5j8lZJPB5RNaGjZfFyk43enuPlZ+HxB2P1QyoZS3COQ9F8Npb6d
	NKSOhHQKx35wk6nqIc/u6Vt48vQY/pcbWWrxFq3r1dlSM7W/Cy2nOb/mTwYNWRJk
	Zfx6mi8dYNxExQ+u3kBfBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721139317; x=
	1721225717; bh=9P6k8vU9HH5Mx412/JWWGiX0r05o97rQ7dbH4Yr2Q24=; b=Q
	wBZIgQDd0A2hBSl1rjUhyhjlbfJHkUrXFvYQVI7A1IJuMOpSPy+wXbgRVKS6yB2D
	KsilXBVDUJ5McMr/Vg8NNpxwNoI6w+9S3MEAjH6+OAnj6AhG8l5H88wncUkT6Fzh
	HKV5ouaK4k/Xg9E6+DtAgjQKMIT+nrEXTllXHKZOhJNNcaMFqyoxPdfu9FfkMT3O
	qSe1v7uPqrj/gSKG+F7XdRIyvNOPxmWp4ziX74dOOln8J0rUGXYJy13W2hjmDmXT
	JQaS4Mo2ld7Dy4sQ15WDZ+pvqaQE/Pmel52pYdL1M/6/fgwjpmgtz/o7Ux5TJgPd
	X7o0hdE9UxS9Lua7aMinA==
X-ME-Sender: <xms:dYCWZuSLZ_WOBL6iMO07DiB8Ho7X93eNkMreDwBys9H7zBTlcbGNrA>
    <xme:dYCWZjyE63p7aPnZGZ-0m40M51Ux7DIwaKwAeqIfukyx-CtwI-izDHwmW3bfPA3yu
    PnL3l7ZNKXE4us-jc8>
X-ME-Received: <xmr:dYCWZr2NxdWde5qHy2lNvjORllEjo23ieciY0WBtv8xkAm_fWEjUm0Szgu9Y-w_cJGLB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefgveeikefhgedufffggeduleejveehgfdvjeeivdeitdeiffel
    jefgvddvudetvdenucffohhmrghinhephhgvrggurdhssgenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:dYCWZqCTlFeAvwfIHv8FBbxkxtqepqCSp6CbqkAE2y-mvrtLuvx12g>
    <xmx:dYCWZnhfqNpKT1_pipBfn-cadWLjj7U4_3Gk2gZPFbAzdRnS5TFgxg>
    <xmx:dYCWZmoS_fLsBm93D1QsDyNZa0gHLQRJst6UFzGztEsOTiQXzf29bg>
    <xmx:dYCWZqikoSxdUfFoaL3on3FJVSSAhEFJLH63Pehu-zO3QmaDN6SyLg>
    <xmx:dYCWZniVbmpD047xHovxYV7B2xoZ_Rhvl-eK1cnG6U2wjwzCcXSqmrf1>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 10:15:15 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 16 Jul 2024 22:15:00 +0800
Subject: [PATCH v3 3/3] LoongArch: SMP: Implement parallel CPU bring up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-loongarch-hotplug-v3-3-af59b3bb35c8@flygoat.com>
References: <20240716-loongarch-hotplug-v3-0-af59b3bb35c8@flygoat.com>
In-Reply-To: <20240716-loongarch-hotplug-v3-0-af59b3bb35c8@flygoat.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6105;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=GGxWrxkIuiB6pNabPRprOT7hoV6uxOIbhuzgpQUjGtc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRpDRk75waXxr62qvOMvncqIf7Fu6Zj+fLuy00ue/ZfP
 Pw2feHDjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiI7y2G/0U12xXKv6kf7MgQ
 KLi3fqJtbZ8v2xRd33ctx984/NHJSGdkeOZx/Mby+XuebL36LPm4yZX1Gl8vGn7/erwh6q3Uac6
 kW6wA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Implement parallel CPU bring up for LoongArch to reduce
boot time consumption on bring up CPUs.

On my Loongson-3A5000 ~120ms boot time improvement is observed.

tp, sp register values are passed by MBUF now to avoid racing
cpuboot_data global struct.

cpu_running completion is handled by HOTPLUG_CORE_SYNC_FULL.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v3: Remove unecessary indirection (tglx)
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/smp.h    |  6 -----
 arch/loongarch/kernel/asm-offsets.c | 10 ---------
 arch/loongarch/kernel/head.S        |  7 +++---
 arch/loongarch/kernel/smp.c         | 44 ++++++++-----------------------------
 5 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ddc042895d01..656435c1dbd5 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -162,6 +162,7 @@ config LOONGARCH
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_TIF_NOHZ
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
+	select HOTPLUG_PARALLEL if SMP
 	select IRQ_FORCED_THREADING
 	select IRQ_LOONGARCH_CPU
 	select LOCK_MM_AND_FIND_VMA
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 50db503f44e3..f6953cb16492 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -75,12 +75,6 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_CALL_FUNCTION	BIT(ACTION_CALL_FUNCTION)
 #define SMP_IRQ_WORK		BIT(ACTION_IRQ_WORK)
 
-struct secondary_data {
-	unsigned long stack;
-	unsigned long thread_info;
-};
-extern struct secondary_data cpuboot_data;
-
 extern asmlinkage void smpboot_entry(void);
 extern asmlinkage void start_secondary(void);
 
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index bee9f7a3108f..598498f47a4c 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -257,16 +257,6 @@ static void __used output_signal_defines(void)
 	BLANK();
 }
 
-#ifdef CONFIG_SMP
-static void __used output_smpboot_defines(void)
-{
-	COMMENT("Linux smp cpu boot offsets.");
-	OFFSET(CPU_BOOT_STACK, secondary_data, stack);
-	OFFSET(CPU_BOOT_TINFO, secondary_data, thread_info);
-	BLANK();
-}
-#endif
-
 #ifdef CONFIG_HIBERNATION
 static void __used output_pbe_defines(void)
 {
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index fdb831dc64df..8dd8fb450f46 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -136,9 +136,10 @@ SYM_CODE_START(smpboot_entry)
 	li.w		t0, 0x00		# FPE=0, SXE=0, ASXE=0, BTE=0
 	csrwr		t0, LOONGARCH_CSR_EUEN
 
-	la.pcrel	t0, cpuboot_data
-	ld.d		sp, t0, CPU_BOOT_STACK
-	ld.d		tp, t0, CPU_BOOT_TINFO
+	li.w		t0, LOONGARCH_IOCSR_MBUF1
+	iocsrrd.d	sp, t0
+	li.w		t0, LOONGARCH_IOCSR_MBUF2
+	iocsrrd.d	tp, t0
 
 	bl		start_secondary
 	ASM_BUG()
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ca405ab86aae..967bdc66217f 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -48,10 +48,6 @@ EXPORT_SYMBOL(cpu_sibling_map);
 /* Representing the core map of multi-core chips of each logical CPU */
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
-
-static DECLARE_COMPLETION(cpu_starting);
-static DECLARE_COMPLETION(cpu_running);
-
 /*
  * A logcal cpu mask containing only one VPE per core to
  * reduce the number of IPIs on large MT systems.
@@ -65,7 +61,6 @@ static cpumask_t cpu_sibling_setup_map;
 /* representing cpus for which core maps can be computed */
 static cpumask_t cpu_core_setup_map;
 
-struct secondary_data cpuboot_data;
 static DEFINE_PER_CPU(int, cpu_state);
 
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
@@ -338,19 +333,23 @@ void __init loongson_prepare_cpus(unsigned int max_cpus)
 /*
  * Setup the PC, SP, and TP of a secondary processor and start it running!
  */
-void loongson_boot_secondary(int cpu, struct task_struct *idle)
+int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle)
 {
-	unsigned long entry;
+	unsigned long entry, stack, thread_info;
 
 	pr_info("Booting CPU#%d...\n", cpu);
 
 	entry = __pa_symbol((unsigned long)&smpboot_entry);
-	cpuboot_data.stack = (unsigned long)__KSTK_TOS(idle);
-	cpuboot_data.thread_info = (unsigned long)task_thread_info(idle);
+	stack = (unsigned long)__KSTK_TOS(tidle);
+	thread_info = (unsigned long)task_thread_info(tidle);
 
+	csr_mail_send(thread_info, cpu_logical_map(cpu), 2);
+	csr_mail_send(stack, cpu_logical_map(cpu), 1);
 	csr_mail_send(entry, cpu_logical_map(cpu), 0);
 
 	loongson_send_ipi_single(cpu, ACTION_BOOT_CPU);
+
+	return 0;
 }
 
 /*
@@ -525,23 +524,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 #endif
 }
 
-int __cpu_up(unsigned int cpu, struct task_struct *tidle)
-{
-	loongson_boot_secondary(cpu, tidle);
-
-	/* Wait for CPU to start and be ready to sync counters */
-	if (!wait_for_completion_timeout(&cpu_starting,
-					 msecs_to_jiffies(5000))) {
-		pr_crit("CPU%u: failed to start\n", cpu);
-		return -EIO;
-	}
-
-	/* Wait for CPU to finish startup & mark itself online before return */
-	wait_for_completion(&cpu_running);
-
-	return 0;
-}
-
 /*
  * First C code run on the secondary CPUs after being started up by
  * the master.
@@ -561,22 +543,14 @@ asmlinkage void start_secondary(void)
 	set_cpu_sibling_map(cpu);
 	set_cpu_core_map(cpu);
 
+	cpuhp_ap_sync_alive();
 	notify_cpu_starting(cpu);
 
-	/* Notify boot CPU that we're starting */
-	complete(&cpu_starting);
-
 	/* The CPU is running, now mark it online */
 	set_cpu_online(cpu, true);
 
 	calculate_cpu_foreign_map();
 
-	/*
-	 * Notify boot CPU that we're up & online and it can safely return
-	 * from __cpu_up()
-	 */
-	complete(&cpu_running);
-
 	/*
 	 * irq will be enabled in loongson_smp_finish(), enabling it too
 	 * early is dangerous.

-- 
2.45.2


