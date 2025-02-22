Return-Path: <linux-kernel+bounces-527429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DA5A40B1C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CD0189F75A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B882139DF;
	Sat, 22 Feb 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwF/vxFq"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95FB2135D3
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251210; cv=none; b=hywbnLbUEWUAUy7oLgDCEiaLWJPbfsCt6xrxKvw6krysmxojmeo6D/3RAvHlgLVwkQTr9YD2fj/k54ttwXb4MJPdzQcSyy6hARhxOgps8rcWDSTx5Er/afHnRxN/sN3DYNio9niWC94pJjNCWD6oRr5lWpzJmGGgaPZJ2EIuqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251210; c=relaxed/simple;
	bh=8j7HS6KRodJDG6j7e7qkjuAA7iFjSETcH3RrEkYZ8nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvkvNjQ+wemSTfnvB8x8i3Jxgb65couUYc9rL29RbuMPgOpFzwY7c7qZsuht1YSsXR9HCtgnsaax+nmppf1IDghssDSyS3tB1cET6FD9BSk22tGCXsq6M2M2yhX7NUpnPxXyb/UY472XqBMWtu/rA/O9xYEptY4gqs7HBxGP+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwF/vxFq; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0818add57so334002985a.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251207; x=1740856007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fJRQIUEeUCOVvELxBP9zDInBoFRFieHqHEjsUAYH7k=;
        b=EwF/vxFqKJtEBWpgBCKzX9YE0gnX88P4KBoCIsIv7SUeTcsaITyfWazn+vqIiUHYgP
         cu2uYe+DOMnXqjogLkM8+og0Dg6+ig6ROndSsC9Paad0+aaofEB2VnHobq3XBavPJq6c
         H6kTQK6kRsgl4iAZ1Rg+HcYtlW1UGDVL1CcrgB0UAzBlQ9bB+zwgVk9ByqlvEAalPQLM
         cXT6oNyrUEvFIaWZqO9A8PZHpShz+kC7NgwxFUVRpUFI+TONbDf9TtOCBQSJfFwhpvFf
         +2ZB0VT+J1sQfPrJxnH4dD8/ZH/NodL5d0mjr7BMZOskXJI+P3yEE+UyqFEdasmiP2QA
         Fs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251207; x=1740856007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fJRQIUEeUCOVvELxBP9zDInBoFRFieHqHEjsUAYH7k=;
        b=kFyU9hM3jPjGwGwX5zTXrUYaDLbhIHbpSIIDncaLlskiV7lq/qigQdhbf8pmRHxO1G
         YAjDgC/3l8UALJs52oDZyRLgctq6yK3rp56/+1R2PhlSTfweKiieTbTuAuAnzpZUuMlB
         p3uyoffUSwnjPrlVlz0WUdqqF796k+gac1Akn/vaAihwl0H3ZpH/1gXpcbLoPYVRKEhh
         BE3h6oXgQCrQODRKa38oBun4w1Lde962w82jnnDryaJwO3dGMoh3Ve0aiaugmzNOWMkR
         3u7FJ0GWPolZfBZiHLYZdJI1fEpoVBqJ73Qc4EyWCq5SaaVDXrrfRzBf/0V1O+XZpXP1
         qODA==
X-Gm-Message-State: AOJu0Yz+1qLfIc+QVDvB2q2Iof6BoBmg19c+1GJnBv8uDZLr+aIcwOYP
	1kfhiwmCncx1hMmiK2uz1sxbwwPYrV4nd0sYjdGA83zzdNRUVySizoEN
X-Gm-Gg: ASbGnctZRrIfmEYvTdXY6DH/WZh3voUv1CatfTgQJ22b7HByAvk/v+FcydYRdzYhwS6
	nMhSX5UQnqW2iyhG4/L4WC+8WzlXNhWnqGnCaMD00L9qE4jQs1H3Iwes5Uyng/HDH0Pl5AZGW69
	EMrl2T0Kp96lgMlEsr9WJFlsq93albO/i+NHwgJrHUOHVT7eoaTUhiYiIWgcRmF26gcNWpKMHJz
	bl7HBwm2rVWHynbjKgFGINrcQnshH4zWAR1cktSCcXjFjuEMHO2ZOc5H+vcAe6EnVDg3lRvyZAe
	dYY+ktw=
X-Google-Smtp-Source: AGHT+IFzVSDtGTaKw58OMNWSJZxoGLxdJ8q5okT1JUktKE86ry7B+FjY/K8mwuGW1cs22+PRO2b3EQ==
X-Received: by 2002:a05:620a:2a0f:b0:7c0:b76a:51d5 with SMTP id af79cd13be357-7c0cf7d816bmr993573185a.0.1740251207134;
        Sat, 22 Feb 2025 11:06:47 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:46 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [RFC PATCH 06/11] x86/percpu: Move current_task to percpu hot section
Date: Sat, 22 Feb 2025 14:06:18 -0500
Message-ID: <20250222190623.262689-7-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222190623.262689-1-brgerst@gmail.com>
References: <20250222190623.262689-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/current.h | 9 ++++++---
 arch/x86/include/asm/percpu.h  | 2 +-
 arch/x86/kernel/asm-offsets.c  | 1 -
 arch/x86/kernel/cpu/common.c   | 8 +++++---
 arch/x86/kernel/head_64.S      | 4 ++--
 arch/x86/kernel/process_32.c   | 2 +-
 arch/x86/kernel/process_64.c   | 2 +-
 arch/x86/kernel/smpboot.c      | 2 +-
 arch/x86/kernel/vmlinux.lds.S  | 1 +
 scripts/gdb/linux/cpus.py      | 2 +-
 10 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 8adbe0e3c5e7..d51299af6145 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -15,7 +15,6 @@ struct task_struct;
 struct pcpu_hot {
 	union {
 		struct {
-			struct task_struct	*current_task;
 			void			*hardirq_stack_ptr;
 			u16			softirq_pending;
 #ifdef CONFIG_X86_64
@@ -35,12 +34,16 @@ DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
 DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
 			const_pcpu_hot);
 
+DECLARE_PER_CPU_HOT(struct task_struct *, current_task);
+/* const-qualified alias provided by the linker. */
+DECLARE_PER_CPU_HOT(struct task_struct * const, const_current_task);
+
 static __always_inline struct task_struct *get_current(void)
 {
 	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
-		return this_cpu_read_const(const_pcpu_hot.current_task);
+		return this_cpu_read_const(const_current_task);
 
-	return this_cpu_read_stable(pcpu_hot.current_task);
+	return this_cpu_read_stable(current_task);
 }
 
 #define current get_current()
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index cc19bd785f0e..370778c55091 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -560,7 +560,7 @@ do {									\
  * it is accessed while this_cpu_read_stable() allows the value to be cached.
  * this_cpu_read_stable() is more efficient and can be used if its value
  * is guaranteed to be valid across CPUs.  The current users include
- * pcpu_hot.current_task and cpu_current_top_of_stack, both of which are
+ * current_task and cpu_current_top_of_stack, both of which are
  * actually per-thread variables implemented as per-CPU variables and
  * thus stable for the duration of the respective task.
  */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 54ace808defd..ad4ea6fb3b6c 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -107,7 +107,6 @@ static void __used common(void)
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
-	OFFSET(X86_current_task, pcpu_hot, current_task);
 #if IS_ENABLED(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64)
 	/* Offset for fields in aria_ctx */
 	BLANK();
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 25a5806e15aa..f4ec6bcb2a5e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2014,12 +2014,14 @@ static __init int setup_clearcpuid(char *arg)
 }
 __setup("clearcpuid=", setup_clearcpuid);
 
-DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
-	.current_task	= &init_task,
-};
+DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
+DEFINE_PER_CPU_HOT(struct task_struct *, current_task) = &init_task;
+EXPORT_PER_CPU_SYMBOL(current_task);
+EXPORT_PER_CPU_SYMBOL(const_current_task);
+
 DEFINE_PER_CPU_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 2843b0a56198..fefe2a25cf02 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -322,7 +322,7 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 	 *
 	 * RDX contains the per-cpu offset
 	 */
-	movq	pcpu_hot + X86_current_task(%rdx), %rax
+	movq	current_task(%rdx), %rax
 	movq	TASK_threadsp(%rax), %rsp
 
 	/*
@@ -433,7 +433,7 @@ SYM_CODE_START(soft_restart_cpu)
 	UNWIND_HINT_END_OF_STACK
 
 	/* Find the idle task stack */
-	movq	PER_CPU_VAR(pcpu_hot + X86_current_task), %rcx
+	movq	PER_CPU_VAR(current_task), %rcx
 	movq	TASK_threadsp(%rcx), %rsp
 
 	jmp	.Ljump_to_C_code
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 3afb2428bedb..c276dfda387f 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -206,7 +206,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (prev->gs | next->gs)
 		loadsegment(gs, next->gs);
 
-	raw_cpu_write(pcpu_hot.current_task, next_p);
+	raw_cpu_write(current_task, next_p);
 
 	switch_fpu_finish(next_p);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4252b11718f2..1517314da34a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -668,7 +668,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/*
 	 * Switch the PDA and FPU contexts.
 	 */
-	raw_cpu_write(pcpu_hot.current_task, next_p);
+	raw_cpu_write(current_task, next_p);
 	raw_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
 	switch_fpu_finish(next_p);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 15e054f4cbf6..c89545a61d08 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -841,7 +841,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	/* Just in case we booted with a single CPU. */
 	alternatives_enable_smp();
 
-	per_cpu(pcpu_hot.current_task, cpu) = idle;
+	per_cpu(current_task, cpu) = idle;
 	cpu_init_stack_canary(cpu, idle);
 
 	/* Initialize the interrupt stack(s) */
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ee019c1ea859..3c87bb620434 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -44,6 +44,7 @@ ENTRY(phys_startup_64)
 
 jiffies = jiffies_64;
 const_pcpu_hot = pcpu_hot;
+const_current_task = current_task;
 const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 
 #if defined(CONFIG_X86_64)
diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 13eb8b3901b8..8f7c4fb78c2c 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -164,7 +164,7 @@ def get_current_task(cpu):
             var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
             return var_ptr.dereference()
         else:
-            var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
+            var_ptr = gdb.parse_and_eval("&current_task")
             return per_cpu(var_ptr, cpu).dereference()
     elif utils.is_target_arch("aarch64"):
         current_task_addr = gdb.parse_and_eval("(unsigned long)$SP_EL0")
-- 
2.48.1


