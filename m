Return-Path: <linux-kernel+bounces-206926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0AD900FFC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425E11C21E68
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3385217798F;
	Sat,  8 Jun 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lofrRM/R"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FD176AC4
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717831942; cv=none; b=clDJpTdx3LJYWuyKWIQ/r8LIBTTRHQSdzDyQjCNlwg0bGQqCEOjG7sVbw6K212MMWynMlj0pRA/jV6gTz5q26BN9bXc3u9XcGXwJXUHM/VraGDYTl75sOP6IMWr/Mhop2/KginMQPucIGW4anFq8tAZsWvKX4MHpgXMHTpE3gYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717831942; c=relaxed/simple;
	bh=dUho5uu3FDRl4teKfKhv8mx7CKTPs/XI9U//jwHm6Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T53cb1j5nRLfdOcydLiXYjxTWkl9nk1EfT2pzCM29P0OsJ3dAhbuPV6rXjLNm9p9+8Pv9fNKGrCffHH+XS+6Sq5x89ilIodjMe0lkdg/sQgTtRiXdTeZVZm8YVyvd+4NMI/NOmoQAONPyPh3lnVQzjmndEuMWGSPXgqhbj5M5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lofrRM/R; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68ca4d6545so502242166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717831938; x=1718436738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hE6lNRiVH6pWKbAdIlDDgiuQI0UwwWkBZbu+xX0YaKY=;
        b=lofrRM/R/Ui+DHpkEVQg+uJggYpe4x3d5wAYO+YAxMvXxQ8+khxt5kIF+RtseO9kpm
         vlaqzM3/pns8UodANdnHpgZbSEAqKGHD9nIRozR/geObthuh75miN3kpLAN6RuG0jRjR
         wEc0FNb5lhCEMIPmlvLCMHxBkECZr6mpa/KHzsM/W3EMd27hF3UpRMieJcjBjZGQ4s46
         HwpwlembIpg0ogb1lRL0ie8+R4Ol75yif+8LxRMKJHbEllL8fpTJUf79QoVO13mkuqVz
         NZ1JV8M1fzk+KTHCJpm5v0shOcp+uNNBHhsFJzjEbo5DquEgMHnblwYPQnXpW/xlMJGA
         4v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717831938; x=1718436738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hE6lNRiVH6pWKbAdIlDDgiuQI0UwwWkBZbu+xX0YaKY=;
        b=mA/MJePb1IB3ohG95XfMa6AON8njeHKB4tSsp5ypL1qglxeS5CBPQBvfXfGzZwEmL0
         YNsC2tqsVbW8bZVsftJxyVGOIspfqFzjPF8wzIQMn2afP/8/5Xb4/vk9NmzHustFgFj3
         ZXFwI3phnDs0iVlM1XC08Dq2KuctEQRo7iXc9BiGY41eoQqpWJREficRVnyXPaa+u3/D
         5TgaW/GsXTV13NFUHUL+BhYuVmqRvWUCXyEoXRYF9osM1f1uiJtuaX4rrOsYp0BG1f6D
         yTS9e97HFEx1oBjBjYVsnE/XA8lCf7OFOBG+MJde8VKkMMMkkupsk0oqy48NmxdLmeVe
         u8pQ==
X-Gm-Message-State: AOJu0YxFYzfByvCA6V5gQBzdkxZdbumCTkV6GFGS0+HYzcM2ODtlLWG7
	Sw0ATqL8tu3ewR6j4nc9Q8imi4iCGJNymUrtGiQiB4UjKG9HshqkngBihAGL
X-Google-Smtp-Source: AGHT+IHkYd1R3XC27NQWfXGPgC5pza2WApwrDvBIzfoMGUu3HFFYqaX/ejTpA7YPX0QO1/76ZbPHmQ==
X-Received: by 2002:a17:906:4154:b0:a68:e268:fa30 with SMTP id a640c23a62f3a-a6c7651ad4emr527918166b.38.1717831938299;
        Sat, 08 Jun 2024 00:32:18 -0700 (PDT)
Received: from kepler.. (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efe5262cdsm61350466b.117.2024.06.08.00.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:32:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 3/9] x86/fpu: Make task_struct::thread constant size
Date: Sat,  8 Jun 2024 09:31:28 +0200
Message-ID: <20240608073134.264210-4-mingo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240608073134.264210-1-mingo@kernel.org>
References: <20240608073134.264210-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn thread.fpu into a pointer. Since most FPU code internals work by passing
around the FPU pointer already, the code generation impact is small.

This allows us to remove the old kludge of task_struct being variable size:

  struct task_struct {

       ...
       /*
        * New fields for task_struct should be added above here, so that
        * they are included in the randomized portion of task_struct.
        */
       randomized_struct_fields_end

       /* CPU-specific state of this task: */
       struct thread_struct            thread;

       /*
        * WARNING: on x86, 'thread_struct' contains a variable-sized
        * structure.  It *MUST* be at the end of 'task_struct'.
        *
        * Do not put anything below here!
        */
  };

... which creates a number of problems, such as requiring thread_struct to be
the last member of the struct - not allowing it to be struct-randomized, etc.

But the primary motivation is to allow the decoupling of task_struct from
hardware details (<asm/processor.h> in particular), and to eventually allow
the per-task infrastructure:

   DECLARE_PER_TASK(type, name);
   ...
   per_task(current, name) = val;

... which requires task_struct to be a constant size struct.

The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
now that the FPU structure is not embedded in the task struct anymore, which
reduces text footprint a bit.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20240605083557.2051480-2-mingo@kernel.org
---
 arch/x86/include/asm/processor.h | 20 +++++++++-----------
 arch/x86/kernel/fpu/core.c       | 23 ++++++++++++-----------
 arch/x86/kernel/fpu/init.c       | 19 ++++++++++++-------
 arch/x86/kernel/process.c        |  2 +-
 include/linux/sched.h            | 13 +++----------
 5 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 35aa8f652964..64509c7f26c8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -504,21 +504,19 @@ struct thread_struct {
 #endif
 
 	/* Floating point and extended processor state */
-	struct fpu		fpu;
-	/*
-	 * WARNING: 'fpu' is dynamically-sized.  It *MUST* be at
-	 * the end.
-	 */
+	struct fpu		*fpu;
 };
 
-#define x86_task_fpu(task) (&(task)->thread.fpu)
+#define x86_task_fpu(task) ((task)->thread.fpu)
 
-extern void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size);
-
-static inline void arch_thread_struct_whitelist(unsigned long *offset,
-						unsigned long *size)
+/*
+ * X86 doesn't need any embedded-FPU-struct quirks:
+ */
+static inline void
+arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
 {
-	fpu_thread_struct_whitelist(offset, size);
+	*offset = 0;
+	*size = 0;
 }
 
 static inline void
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ca6745f8ac2a..f0c4367804b3 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -584,8 +584,19 @@ static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
 int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	      unsigned long ssp)
 {
+	/*
+	 * We allocate the new FPU structure right after the end of the task struct.
+	 * task allocation size already took this into account.
+	 *
+	 * This is safe because task_struct size is a multiple of cacheline size.
+	 */
 	struct fpu *src_fpu = x86_task_fpu(current);
-	struct fpu *dst_fpu = x86_task_fpu(dst);
+	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
+
+	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
+	BUG_ON(!src_fpu);
+
+	dst->thread.fpu = dst_fpu;
 
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
@@ -654,16 +665,6 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	return 0;
 }
 
-/*
- * Whitelist the FPU register state embedded into task_struct for hardened
- * usercopy.
- */
-void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
-{
-	*offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
-	*size = fpu_kernel_cfg.default_size;
-}
-
 /*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index ad5cb2943d37..4e8d37b5a90b 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -71,8 +71,17 @@ static bool __init fpu__probe_without_cpuid(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
+static struct fpu x86_init_fpu __read_mostly;
+
 static void __init fpu__init_system_early_generic(void)
 {
+	int this_cpu = smp_processor_id();
+
+	fpstate_reset(&x86_init_fpu);
+	current->thread.fpu = &x86_init_fpu;
+	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
+	x86_init_fpu.last_cpu = this_cpu;
+
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
 		if (fpu__probe_without_cpuid())
@@ -150,6 +159,8 @@ static void __init fpu__init_task_struct_size(void)
 {
 	int task_size = sizeof(struct task_struct);
 
+	task_size += sizeof(struct fpu);
+
 	/*
 	 * Subtract off the static size of the register state.
 	 * It potentially has a bunch of padding.
@@ -164,14 +175,9 @@ static void __init fpu__init_task_struct_size(void)
 
 	/*
 	 * We dynamically size 'struct fpu', so we require that
-	 * it be at the end of 'thread_struct' and that
-	 * 'thread_struct' be at the end of 'task_struct'.  If
-	 * you hit a compile error here, check the structure to
-	 * see if something got added to the end.
+	 * 'state' be at the end of 'it:
 	 */
 	CHECK_MEMBER_AT_END_OF(struct fpu, __fpstate);
-	CHECK_MEMBER_AT_END_OF(struct thread_struct, fpu);
-	CHECK_MEMBER_AT_END_OF(struct task_struct, thread);
 
 	arch_task_struct_size = task_size;
 }
@@ -213,7 +219,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 void __init fpu__init_system(void)
 {
-	fpstate_reset(x86_task_fpu(current));
 	fpu__init_system_early_generic();
 
 	/*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index adfeefd6375a..5bb73bc0e31a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -97,7 +97,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.vm86 = NULL;
 #endif
 	/* Drop the copied pointer to current's fpstate */
-	x86_task_fpu(dst)->fpstate = NULL;
+	dst->thread.fpu = NULL;
 
 	return 0;
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..215a7380e41c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1554,21 +1554,14 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+	/* CPU-specific state of this task: */
+	struct thread_struct		thread;
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
 	 */
 	randomized_struct_fields_end
-
-	/* CPU-specific state of this task: */
-	struct thread_struct		thread;
-
-	/*
-	 * WARNING: on x86, 'thread_struct' contains a variable-sized
-	 * structure.  It *MUST* be at the end of 'task_struct'.
-	 *
-	 * Do not put anything below here!
-	 */
 };
 
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
-- 
2.43.0


