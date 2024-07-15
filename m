Return-Path: <linux-kernel+bounces-252608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADC19315E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60091F22964
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25018E74E;
	Mon, 15 Jul 2024 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="rC3aYHVe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJHVU+Ho"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4618EA61
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050555; cv=none; b=t+OWNpGc22ueD48ziMXf+Fnvilf8gxkbFf6wHNQobGJ2lO9cMfWgQGOgZ7ElMKFjL1mYCL+HNmTPu6Yso0whSe1A7bMnTnAHsXOI+UQSEby2eHmAWZyiVB/T0vcL1pMC7qltQ7Omb7T8VATW9Y+eqmbBhXK+TQ5s+oWpNvWWC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050555; c=relaxed/simple;
	bh=D2mqxCRzQvs1HI/FO9ROzuiLua0L8frnlc80PUjQ/tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XdeeIVREodkGadFUlqqs+U09UtJc7GEItiuwKaF0cSQiSp1bcREtpIPP3ArOB4fLEmVMKAohAtbDITA8V2PPf+nCpK/COWZ56KvKsAuh2ycWK//LT2qe29YtqlCsTpxISiJZWY42hauwJA2QAoS1Fkcx25UaoYD/vuGZKsNODfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=rC3aYHVe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJHVU+Ho; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6866E1147F64;
	Mon, 15 Jul 2024 09:35:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Jul 2024 09:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721050553;
	 x=1721136953; bh=HeqE0UK1T7UO6X2hOhXYyZrlSpcrQ0WC48brT+ZdXlU=; b=
	rC3aYHVePbwlgqXCGlhnLIHB5KSW9cZWAwznoJ9D8Z618oCY1CE6l+npN6VjeQ2o
	R/I2FnfvAojRyvpSJegPRLssL6Huc4PjM9/xZzf0ATLdUvTAF7uGZXY+7sY2oRR1
	OPXae4bFAgw3qtk61P69wjmumJ72RGvtzGqiykRY9ixhc3st4PYUV8INxeDekNuW
	pQDz33dM4daNlt4eWZW+JlB+w1W+yYMZrhWUcPRxOMhTVAqfdVKDxE6JHYQ40hhf
	dVYS7whVVlYEHQLg3WM3wgZwt3TFlD1t9JWFA0EWIgV2luBDuF4RMtWdlElW415D
	sSXxRKNS+RQo8tmKyhxy/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721050553; x=
	1721136953; bh=HeqE0UK1T7UO6X2hOhXYyZrlSpcrQ0WC48brT+ZdXlU=; b=e
	JHVU+HozAvP7IYQqYuVwyDwjHLnh4OPhqvltAYoZAibK/KM1Szx7q/Az5N/SmkAf
	2a1uOCDfFtUubP2IaR9DAqIrz/iIYhWuu27Aru/Cpm5l2Yous4if8gBFfr9dUeEt
	2m4V6Simwzl544VwIjlLpxC8OPR2/rVSxNBi8idpobUKFPfekG6ZlGZ6Clxsynis
	6RButDpLvJ/kzR/J314oIMCezPeXEquAQwQPdjDA+30HdBOk4lpVzgnZSJIQhm7X
	MrNSWBB8TDOToDWu6IuV2qgDypWuYBGfepi4susAjNeaqGLTZ8+sx9WyCg2hw3P/
	3/uJFiyyff7dMR/EKFqDA==
X-ME-Sender: <xms:uCWVZu0GAG_zHVPuD5G7Xqz-5m9uxh06q0O2bVH0qFFQNAK7Ahb9Ww>
    <xme:uCWVZhH9rXkNy-kk7yXijZB3bJmD_aNWOgsN_o02-Za--kcq06c4UA0VcUkPGLrDY
    Ly1SEJd3mgDzO-DlP4>
X-ME-Received: <xmr:uCWVZm5efiHHx6HFmL2K9SQDWGXVsVsdvtN03k_misM1Yl9W9Z_EVH1F74aavLn7Qxh5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefgveeikefhgedufffggeduleejveehgfdvjeeivdeitdeiffel
    jefgvddvudetvdenucffohhmrghinhephhgvrggurdhssgenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:uCWVZv108IGcdXQVvOJCE2Y7ZUIPBcyoDYwsANIq8RHrgEHGYDoPiw>
    <xmx:uCWVZhHi_NdUpiSpiBPfX-8XwTKQpap_wseF789JiItP6OGgmyz9KQ>
    <xmx:uCWVZo8jWtA78ndfNbiFm7AiOkRdKKUkzQPD4jIxamcyT0ryHuAjQA>
    <xmx:uCWVZmkvxe5wtW_djuDBsMttd6aatw9wE8wZ0fJDD10M0hdkTSbNDA>
    <xmx:uSWVZo3tRD_tJax7BNTiw_vg3gUfItXKwQijXTGdAXJRRQNMJQl3DpHh>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jul 2024 09:35:49 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 15 Jul 2024 21:35:30 +0800
Subject: [PATCH v2 3/3] LoongArch: SMP: Implement parallel CPU bring up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-loongarch-hotplug-v2-3-7d18b3d46b11@flygoat.com>
References: <20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com>
In-Reply-To: <20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5856;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=D2mqxCRzQvs1HI/FO9ROzuiLua0L8frnlc80PUjQ/tM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSpqitCCpoXuB433BvVk5FYW83BfC39V25HXM28x2YPm
 Dz4b5h3lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwETW6jEyLE45ETrx1x0GTT3x
 x4xfOZzrz75cE/3qw3qV96d1Gf6zn2BkuBY6z17k/6GXP+SMnAV3PQj4+dtQ4MP5r+z7t5/b7X7
 7ADcA
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


