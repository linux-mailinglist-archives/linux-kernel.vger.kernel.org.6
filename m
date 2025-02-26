Return-Path: <linux-kernel+bounces-534598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCAAA468EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C167173BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B54238D50;
	Wed, 26 Feb 2025 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLY2O273"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38023815F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593170; cv=none; b=Nife9aYUWdeyF2nANDcnS5FMSJbMfBXhTFcR1EGn4LF+CERF4/NXKJ746km/314QqVHGNjcR0kxwrvwoX/a/KqY1+i3gkLJW5VGDk+2jSzBB9LRZAgTnDGGLGWDsJAWnSQ+jIWZ7dLOH1j7LGmiBkTMEoy7c3szt/OweZ7qlhIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593170; c=relaxed/simple;
	bh=ZFzEnDq8KgjuURenm9ik6dY5TfGXOxRURJTNWlmo0+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk7icyx/GMceamFT542xnwaj/UXMCBhh2mrsjP4JRBTCOAejuWykf4RpWsTpcdYaExvI4nyrXAkKG6ndCWSpHd/a6JDsI9lapcd6ifMFcwGfg9sLmaJvOmjEK46uHA3u4NNNDrwdjTEHUv/tlxSxD+WeJ/W702d1ufZLarMiiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLY2O273; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fce03395d4so36606eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593167; x=1741197967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy1ju9SebX5v1mWl0+k0224cFXdsKGZNI8ymJ4KND2o=;
        b=LLY2O273i/+mYTUrp+zKj//tPOJZQYIg7K6atdN41odO+W7mkOgyFCM28Lz9/q9jWS
         zLE7oiHBwtCI3an06y+5iNz2rxMohcH58mh3e90ubxHX4SDAUDsFmfbZcEYr+5VJCVk+
         WK7zhbwC73H/UtHbymQ6fNM6d0fQDp0rUNmRCptIzM2+S/7ZRqIaD/XaR0s5rfxRm3U3
         AryLuhcwm49L71wlY25W2AGIe6MIy41tMZHqXJ7nYIlfzqY8kc7BO+GX4Cl74v6hBLH4
         imQADLEQj9CzM3K6qbnQOyEziWkBWq9uQmqG5Etxh8VslBzH0/+goU+GXefx0CEUxz2B
         WocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593167; x=1741197967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vy1ju9SebX5v1mWl0+k0224cFXdsKGZNI8ymJ4KND2o=;
        b=Uzv9nfzvMZ9qZksfEpvzY3y7u8TNytnRRMaiCJ+uQIdJiJn8vbzwjU+oTjEYjJcxLt
         gTvI6jVDUKBpU1pwB8T1XBYvJddh7K869+gX4g1GngNvW+TEyaFjaps0vRq1fzBg2TPJ
         eydwD3+N9z1NCYg/S1qxIYKlgwkGFoFfhMJMP9OtiJfjhNJj9+gBX3kVJzYpmkWk1JJA
         N5smcaKv5CXIVDGtQTUtP3N88I6KWf+BNlm+wHOY/QO/ndAeZDsx9lRwdiAegBJPSFTf
         MdK5SG63O/e3taSe+30Q4RUa9mFJI2inYgvKUPCf2ARn+LXvSfPr8dBzN+GgSkoQUZjG
         ao1g==
X-Gm-Message-State: AOJu0YwbOlM/8mXSY1GQKaZScP4kWKjtq1/726oPRsPgKD3W2+Iaesuy
	0JDp9FJyScTFV0w/5WAL+J0rjA2TPf8zTphSJ5IuX1tZJpSfD3cGk2+1
X-Gm-Gg: ASbGncvxYohAr83IVmQEk8OJbO0v49aL9uJd/UjrfpXwUYJ9E65Z2RNdhbiLaBINxnE
	VhTWf6bSAdXR9Q7F029svp+iDEmx4y+Au+lv4ewFEe0SmzSH3SohZ3fFdCyqDlUQQDd6poUtBrg
	LrlDtwWu/luUj9agCqL2t+D5bgftTaYIC6C3DPCaV5UD1UhrG7LSM+td7sbmfUF2baC/+E1Baeo
	Eqxa+rkysVH9X7ACU/rGQSFXBksQ8+AC4RHUc66qFfMYm0w4a+yj59mrSygbjJmoUPyOpjaL9nD
	T2Tjz5g=
X-Google-Smtp-Source: AGHT+IFUnBI5a7MiiktlMTCWimF3hQEAHEbEDDvLuwmkHUGlozp+ySgd/sKZIK34KglEqEaii0rq9g==
X-Received: by 2002:a05:6820:1611:b0:5fc:e3b3:3c10 with SMTP id 006d021491bc7-5fe9d5d390cmr2129145eaf.2.1740593167435;
        Wed, 26 Feb 2025 10:06:07 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:06:05 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 09/11] x86/percpu: Move current_task to percpu hot section
Date: Wed, 26 Feb 2025 13:05:28 -0500
Message-ID: <20250226180531.1242429-10-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226180531.1242429-1-brgerst@gmail.com>
References: <20250226180531.1242429-1-brgerst@gmail.com>
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
 arch/x86/include/asm/current.h | 17 ++++++-----------
 arch/x86/include/asm/percpu.h  |  2 +-
 arch/x86/kernel/asm-offsets.c  |  1 -
 arch/x86/kernel/cpu/common.c   |  8 +++-----
 arch/x86/kernel/head_64.S      |  4 ++--
 arch/x86/kernel/process_32.c   |  2 +-
 arch/x86/kernel/process_64.c   |  2 +-
 arch/x86/kernel/smpboot.c      |  2 +-
 arch/x86/kernel/vmlinux.lds.S  |  2 +-
 scripts/gdb/linux/cpus.py      |  2 +-
 10 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 3d1b123c2ee3..dea7d8b854f0 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -12,22 +12,17 @@
 
 struct task_struct;
 
-struct pcpu_hot {
-	struct task_struct	*current_task;
-};
-
-DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
-
-/* const-qualified alias to pcpu_hot, aliased by linker. */
-DECLARE_PER_CPU_CACHE_HOT(const struct pcpu_hot __percpu_seg_override,
-			const_pcpu_hot);
+DECLARE_PER_CPU_CACHE_HOT(struct task_struct *, current_task);
+/* const-qualified alias provided by the linker. */
+DECLARE_PER_CPU_CACHE_HOT(struct task_struct * const __percpu_seg_override,
+			  const_current_task);
 
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
index 044410462d36..e347c6656ce8 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -554,7 +554,7 @@ do {									\
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
index fc059e9c8867..ac8721a0eb3a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2014,11 +2014,9 @@ static __init int setup_clearcpuid(char *arg)
 }
 __setup("clearcpuid=", setup_clearcpuid);
 
-DEFINE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot) = {
-	.current_task	= &init_task,
-};
-EXPORT_PER_CPU_SYMBOL(pcpu_hot);
-EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
+DEFINE_PER_CPU_CACHE_HOT(struct task_struct *, current_task) = &init_task;
+EXPORT_PER_CPU_SYMBOL(current_task);
+EXPORT_PER_CPU_SYMBOL(const_current_task);
 
 DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
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
index f68da7b7e50c..13893ec03d85 100644
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
index 85032c085af2..9ac6b42701fa 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -43,7 +43,7 @@ ENTRY(phys_startup_64)
 #endif
 
 jiffies = jiffies_64;
-const_pcpu_hot = pcpu_hot;
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


