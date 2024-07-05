Return-Path: <linux-kernel+bounces-241905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662329280ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880DC1C22B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7C21369A8;
	Fri,  5 Jul 2024 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="QDkKCy5f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLzJmZu3"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A57344F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720150195; cv=none; b=TszVKDanU+oLdr7UKVfwUpRdJDmELcJFpQ7zn60FdZ5oG3APzjH1xAcViFoX42c//HJx9oavJxcQ6/L/nuPhe/rTI1RE+DynVmJG5JiVgmQ61jxFBc3OJOpUB7lH4Zmeqg5rN+yL4Y4koLgAswONIq3NOIyumGosLs/H3kGADKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720150195; c=relaxed/simple;
	bh=D2mqxCRzQvs1HI/FO9ROzuiLua0L8frnlc80PUjQ/tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6GX0vXGIj1GywHMEElYzDM1hip/0njverKQO5cDDSB4WtwevD9rccH/7McJiJHKnJL9AGPDwdMLSaYJCCO4mIpuAhaD97qLaw7m/WUlC8hPgmOk7sNJLKtv+ctwdkHVMvTE1gsEUjvTKBdxQ248I5YXozIZGZRvcQBXE8Oy/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=QDkKCy5f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLzJmZu3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id E81B11380289;
	Thu,  4 Jul 2024 23:29:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Jul 2024 23:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1720150191;
	 x=1720236591; bh=HeqE0UK1T7UO6X2hOhXYyZrlSpcrQ0WC48brT+ZdXlU=; b=
	QDkKCy5foSyTpYtIC9cKQ/4EZsUmrlc2MxXvKhcNRHIbxSOOLBbwG1HF0c9AmnVS
	Y65gx7kDysi/HjIhw5jugKMOEhnfGNxa6zHehxXgsPSpYCbr8+1XO8wINvtmUx0I
	bjY9gemW6Z6ZJ6W0UyQZSt7dNqHmlprNJwepRH6AEBIFAfXsCHZlaZ2bims4FtwE
	DFsArGjiYF666FKnyGJG0nXTYwXpTucHWrzs0SGinLCSpCFDggmVXgf3pBBOlHLo
	hAuMLl0PVFiUMPiRcFu4vCTJY0FDUa0PkyN9aCVKJkihVZAYU2zUuWAqi/5AmYYe
	LL130km7vI4yCb+lHTQ/Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720150191; x=
	1720236591; bh=HeqE0UK1T7UO6X2hOhXYyZrlSpcrQ0WC48brT+ZdXlU=; b=F
	LzJmZu3birrPfDLIt4i4aHaEZJih1wSD52Ez9+oOQxYBJXWqJEFOL48kGhTO1Jl2
	gH922ZPKpbIiSidYeP7TvR1vxQGV1HMadfbtIIHTzsAmhcpQRexV5zmK05EpOFUu
	d4SsKHd1KYZC0sgFju0po1a9aGW2aRJdslBmC67f/XAD3CiZJX3sbbwUHned7TSX
	4OrbLtNFo8GS2qGOh5+GK8uxlVhwdnABKrOKFKG9hBE/J+9AfKbeiAH9zis09Ab/
	s0/1AWunIk674WuQzteCvBQkSL3uQ2Of1p5odo400h45TFwhiqhp0/E8r7Czf46C
	ieXdyDDnmxRXU6HoFUlFQ==
X-ME-Sender: <xms:r2iHZt5soISnsXh83uRfXbY5fL69NIgn_IgUB1aUVaRA7qBTCPnM_w>
    <xme:r2iHZq7qu8KSuwrBI2aC3dTopkq9AaXbO3G6lmtShrZa0ozQAfRb41vuX35uyredR
    U01JaRjP8ceB652vAg>
X-ME-Received: <xmr:r2iHZkeYo_I3VNrTfy-7WSxJ71CSRNv26-5pWQZ34JhB4DaTB_U-w_hDIcyE0yt0Pg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefgveeikefhgedufffggeduleejveehgfdvjeeivdeitdeiffel
    jefgvddvudetvdenucffohhmrghinhephhgvrggurdhssgenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:r2iHZmIMz4Lp32SRyfWeiCFbxws4_BPDScQkwEyB38j-GFbtxL18vg>
    <xmx:r2iHZhIW5Fkkx0rAx9PYWqp6dHy2717vp0Pn4cebyNmRc_0KUM94IQ>
    <xmx:r2iHZvwtcKeizCJXAXq4AuiI9_Ax1Cbk0QPCfrMDgNtbVC1T8KcJ7g>
    <xmx:r2iHZtKNAXPXcLqEuF54LQdJeCwQINIYPCkF9FFZruG4f4dnQu9EYg>
    <xmx:r2iHZmp8zXJk1EZ-3kzyIs9zDdigxEs-jJxGIkS87LoZsKnLAC8IG7j7>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jul 2024 23:29:49 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 05 Jul 2024 11:29:39 +0800
Subject: [PATCH 3/3] LoongArch: SMP: Implement parallel CPU bring up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-loongarch-hotplug-v1-3-67d9c4709aa9@flygoat.com>
References: <20240705-loongarch-hotplug-v1-0-67d9c4709aa9@flygoat.com>
In-Reply-To: <20240705-loongarch-hotplug-v1-0-67d9c4709aa9@flygoat.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5856;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=D2mqxCRzQvs1HI/FO9ROzuiLua0L8frnlc80PUjQ/tM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT2jCWW/yKfLjLlCDzgyqokFXDnbdHDUtEJf2wPJq74K
 Zc/K4mzo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACayZCEjw62JnVlnbl9d/+mE
 3E6nKZoLOGZX32OYIlJyPnv3hbb+07MZGU7v8l5ouXbFB9GDVf6KMhrlpipmAk4eR8IztjO+/P5
 FmxUA
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
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/smp.h    |  6 ------
 arch/loongarch/kernel/asm-offsets.c | 10 ----------
 arch/loongarch/kernel/head.S        |  7 ++++---
 arch/loongarch/kernel/smp.c         | 35 +++++++----------------------------
 5 files changed, 12 insertions(+), 47 deletions(-)

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
index ca405ab86aae..ca6a95a0280d 100644
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
@@ -340,14 +335,16 @@ void __init loongson_prepare_cpus(unsigned int max_cpus)
  */
 void loongson_boot_secondary(int cpu, struct task_struct *idle)
 {
-	unsigned long entry;
+	unsigned long entry, stack, thread_info;
 
 	pr_info("Booting CPU#%d...\n", cpu);
 
 	entry = __pa_symbol((unsigned long)&smpboot_entry);
-	cpuboot_data.stack = (unsigned long)__KSTK_TOS(idle);
-	cpuboot_data.thread_info = (unsigned long)task_thread_info(idle);
+	stack = (unsigned long)__KSTK_TOS(idle);
+	thread_info = (unsigned long)task_thread_info(idle);
 
+	csr_mail_send(thread_info, cpu_logical_map(cpu), 2);
+	csr_mail_send(stack, cpu_logical_map(cpu), 1);
 	csr_mail_send(entry, cpu_logical_map(cpu), 0);
 
 	loongson_send_ipi_single(cpu, ACTION_BOOT_CPU);
@@ -525,20 +522,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 #endif
 }
 
-int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle)
 {
 	loongson_boot_secondary(cpu, tidle);
 
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
 	return 0;
 }
 
@@ -561,22 +548,14 @@ asmlinkage void start_secondary(void)
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


