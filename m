Return-Path: <linux-kernel+bounces-542380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3E3A4C908
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAAA188EA4F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0777925FA1F;
	Mon,  3 Mar 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCaeIM0q"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379A25FA03
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020811; cv=none; b=S2ORvOCsmvpfayDgq9PRDrqXT/2XPq51UeVdmM1ngPty7Oug4TLWJzu59gmVNSZqhjuhoMCfGEMKzsDJTjhEvNVG0sxn2hP8SzU9yWQHHQ/f3Ph9wjG4pN112ih7Obv38i5RFdoFEWpQQxjg55sFsZQSCGo1SRV9sCmMtyrqm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020811; c=relaxed/simple;
	bh=sMsV0xjoxmWPqYhIhvlp1QSk3YpSjAVqBu7XTqzwgfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryUeyQZlqWHb0JPzIvLPTGQDbmtTFvrTtHCsATcSDUm5Ewd7GfbEyw2hsG15BKRRQ/Ou9U9j5hnS1ZAdgP6TOCp4+Sreu2gf7rY+ZUezocpj7S53tPTCMeotZ3eAZ0TXcMXynv5RYo8vLQp7z6efRKWZecZmppuX0nIyHTxAWx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCaeIM0q; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8c3a0d468so11461106d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020808; x=1741625608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIZPQr2eOAkEsD5/zDdOJhEiDfF60twwqPhGFSJXNyk=;
        b=TCaeIM0qmz8ApJ2saoMVQsZw5aszyNBbt3s+EBu25zWQ2YyhVOUQCqB7FLYT339DbJ
         59rkb+Jpw70a439w8JrGXyqceuB7cp7PGqfiDaCCMv0aWTezBqw2KsD3Vhj6R6rWwQVr
         NdrGiuBEwEioxyVSNrFq+n/XqQyRGyBKyVroQI1TIMZTcrWNjtO3/tJ8KjblfPyXylQK
         3/4xscXjiOtKncho65uzboAEeqv6zgGcEhAHyaXB5zGl4LdopVKml76ovUPz3i9k5jTn
         HUiFdqcgvQY8PZwFncxeXrNVr3Y8ivWS7pe6FLZqjQGhOU02+0OG4UO6UFGyeEVykT3q
         pyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020808; x=1741625608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIZPQr2eOAkEsD5/zDdOJhEiDfF60twwqPhGFSJXNyk=;
        b=DXz3ghuk3xwRDTeZabl9p1dA9fCxEfLcjJjk+gIuG4jXIOU9YMNcvi+SX7CarXSX/H
         7tZj2814z6Iu/1T5G0wUK9uyZUGMwTu3R321Hi6XxY9gwzfYDZVzBIpbI7eroCvf/RZ6
         Qwdt8AdJ1mkytieeLWHAH0H/MIXlw8mxWDimCJJlq1QKZZtmP6MvwJfDv3oyNPA/tw9n
         f/wa0ut3/ir0RWHXbvdtBaPAdA7synFTyr26Cv2xyWv3FozS6ABue7qyHaAOP3BHfgUy
         VFwFsxlYH7cN4s5wuIZfuhq1YlB/c7pn7RDG57bsPZUdCHVFNPQGWVUV+ihBrUMd2Ztf
         ZLnA==
X-Gm-Message-State: AOJu0Yw3OuFd01JEbOcumukou4yGaMBVkR73WR8oOyeKgDPSchtPyP1e
	kilCl4PFz7RDK/4ORVOjui0jok7Ewr2QbQLzUIRs40NBMjSrLGy3+NTn
X-Gm-Gg: ASbGnctfjSdosBtj0hDEocenZ4sIAofNKHQTGQDk1VASD75c/0updtPQSFAmYWW617/
	mPpLKZQbzUQX77+otiftF/WgfBhQrqd0LCh1+2zzjb8m7K6ye1ZhUaEy6p9pE/ZGiP2T9KV9QaL
	5ahcCO/JPPbEXnlPQKKxUBjrouA7zdZsKqXd3dC1cdQ4pePKSIWaEOAn/WsWYF8tdXuUOmVIW9P
	QOD9CVEtn1b4hkCCdTbaZAE7udK88++8bevB09TrMOUpwriQoOGkNH5rt+YCHbPk20SBcuHC5KZ
	K5k5VXdsjAWup5/YVHZ3KvQrcA==
X-Google-Smtp-Source: AGHT+IF8twjs5LqK9Y6gPVFlK5mkR0wxG91+iQn4l+qqNcJ449loDyByN0+NfqJhh/B+RlmkWE4jIQ==
X-Received: by 2002:a05:6214:f6f:b0:6e8:9c5c:5385 with SMTP id 6a1803df08f44-6e8a0c850a5mr260864196d6.5.1741020807797;
        Mon, 03 Mar 2025 08:53:27 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:26 -0800 (PST)
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
Subject: [PATCH v3 09/11] x86/percpu: Move current_task to percpu hot section
Date: Mon,  3 Mar 2025 11:52:44 -0500
Message-ID: <20250303165246.2175811-10-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
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
index 1ca290ba6f77..6fbb52abb594 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -549,7 +549,7 @@ do {									\
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
index a771aa77f05e..58b63fa4be6c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2049,11 +2049,9 @@ static __init int setup_setcpuid(char *arg)
 }
 __setup("setcpuid=", setup_setcpuid);
 
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
index 8ec44acb863b..4636ef359973 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -206,7 +206,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (prev->gs | next->gs)
 		loadsegment(gs, next->gs);
 
-	raw_cpu_write(pcpu_hot.current_task, next_p);
+	raw_cpu_write(current_task, next_p);
 
 	switch_fpu_finish(next_p);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 04da741dffd2..5016bbe1102b 100644
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
index 83ec0e90c98e..95beca8044af 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -842,7 +842,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
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


