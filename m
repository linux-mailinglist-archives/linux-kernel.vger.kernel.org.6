Return-Path: <linux-kernel+bounces-547920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EE8A539EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15D93AE938
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9B207E0B;
	Wed,  5 Mar 2025 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ce7wpDrE"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99087207A14
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215649; cv=none; b=UcAvzpqyeIVR1cf1BnqsuSy5SLZhtFx1F6YEtWawlFqOjahcstZB32Hd7kgGbE2pReB2wS7DFOiB9TlECHL+OBfCfohkDbOnvnpc9AIIwehjuNN6RG941tGtnkOasodJtnFVtPe+2NIoskuJ2l/yd2CSecTvdPgIZZYiJQfCbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215649; c=relaxed/simple;
	bh=ji6jPR39ZKDby+guv8CCAiBLyKbpGz9Kynms9BH9fJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEyblRLKANe8EUtATEi9Ls3dFXoiPm6NPFLyVI55i1uVPg9wHlH939mcPcPe5PVVNPpZXKJJRjPjjBNiiXHZCoVm+0zSWwmUHte4fDkOju07pMh1RXcWLRRO8c2+ZMPq2UjRGSYMl4e8EcIG35s3vN4zd+u1zp/L4N2PMtoe638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ce7wpDrE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so163911a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 15:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741215647; x=1741820447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+zSCWqqyKc551VynXTcxotuXwo5gv9XFD/e4PnRFpw=;
        b=Ce7wpDrEPzuf5xb1OsDtw1lg03QQwwc5kVx73dS43QA0pJLfwUyCSuVroJ39GmOjoL
         JIjVnsKPBddLTjuZOJMAxqcwSg5DsuW/qLZOlxtyd6VadbkM6cwEySfDD84/iLRYYqlo
         ImdCRcivJlX42tPMN45+r/PC31VSJpDQINDW9EqFgsDa8QLu63FqxW6VygSdZhRoeKPF
         X7JZXh7yXDyOnlgFUboXAhKbw694M4f1OXFpBJeZ3PEnUkWfplV+OfJSTqQL077oBWIM
         RZC7TOJBH9QOrt6zDST4PZLjE72dGrKVXPhiLM7yX5Dd06SoZg/AYPhkdb4OeFlcdmUQ
         XUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215647; x=1741820447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+zSCWqqyKc551VynXTcxotuXwo5gv9XFD/e4PnRFpw=;
        b=FA/pYXWMhOU8e4xQ3DZCk2S5eG7SGITFP7soBejf2Wkext+gHRwNSd/3KiCPrA2NF2
         VwxM6Th0CMt3AxCKi/VYg8ErFeKr5IWtn8rby3yHPIqSiX7A5tRBwgvTHhZfdei/N9ih
         06y3yD2Vq48ylCg06qAqQohqcYLFRsw6O4M50LPBoa2BKcqmshRs56O9YU5MCmgcZ0P3
         D1iuH9qTgU/RMEWZVt13nQzmM8SG+TTf3/TfZ9AdtmkNg6WQ3SXhbGspSbvDF6Vk8tiq
         K3yFiEOeh97nckduDFa1yP1Al6T32n0/LAv1ldS5I3Tzff7v5Uz8DERlldWRQUaVAAk7
         eV3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0jxS1k0dHbZW8cBs3q3dL2Z49Tb8uv3vzpeOWN3PuivebPfSjuwicI9rfmfYtH10T3jqxjzb4v3Avdfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6/AQOqeBzflofsnLuVfVGM7CtmhIPVgQwkv4wKWhPtpUoZH6
	CUF7PgAeE0WEi2k6ESYftukc2Dwl20blJEzuo9BdwpFw2Mv5QtoZ4/tWVvjRTAU=
X-Gm-Gg: ASbGnctIr7pf9m3JR7cohxQKqxZKzfI4GAE80H0Puvna279w4ByYGzO5VMDGC8RnWsk
	rNPkyimzBihluMBtIIaLUxtWziyehq/uxP6akruuLwI1/WYNUW4lM6Ki2bvVGbN+LiPpjmYRhri
	lQEK8ItUWjUhziQDfmusP8FD29ixqA8H94+gBsOj8LDdTGgRKkYoO/xS/NsdiYVxo08reP4lTN2
	1RbdcrFe2rzjSR/XA/cmxUY41QmdFsfQqQdkQkhXtKNB6f3TgLvqClbzHU+34JplPYu/3jdiKD2
	ragCteeX+JmHjNBuugWZYYWNOy2paD/EBmTNFJeHEvCX9a5EE8PbVy6Ye/Vo
X-Google-Smtp-Source: AGHT+IFUZM1PszfzAWoVVShusmLCiU/XuuDYOST/feYMAaw+rilPbChpa9JEeP9Mv/q3NY/4Zidi4A==
X-Received: by 2002:a05:6a20:3943:b0:1f3:44de:619a with SMTP id adf61e73a8af0-1f349578ac5mr8989026637.38.1741215646383;
        Wed, 05 Mar 2025 15:00:46 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedd22esm10593413a12.63.2025.03.05.15.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:00:45 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 05 Mar 2025 15:00:27 -0800
Subject: [PATCH RESEND v4 3/4] LoongArch: entry: Migrate ret_from_fork() to
 C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-riscv_optimize_entry-v4-3-0d81bb45203f@rivosinc.com>
References: <20250305-riscv_optimize_entry-v4-0-0d81bb45203f@rivosinc.com>
In-Reply-To: <20250305-riscv_optimize_entry-v4-0-0d81bb45203f@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5547; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ji6jPR39ZKDby+guv8CCAiBLyKbpGz9Kynms9BH9fJU=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qJ69OPR8VFSwqH/4n0qgkyLi8SFnQ42Jfdc2SHSFLjz
 MsHOPk6SlkYxLgYZMUUWXiuNTC33tEvOypaNgFmDisTyBAGLk4BmMjc0wz/83n5w+0nHOfqudOq
 JzDnWcAb3oh9LXz3atJrmG/N6LBTZvineiBVcx/PRKVNumtfMlim7Kl5tPpZe8/V6Yqv+aaoXbN
 lBAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

LoongArch is the only architecture that calls
syscall_exit_to_user_mode() from asm. Move the call into C so that this
function can be inlined across all architectures.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/loongarch/include/asm/asm-prototypes.h |  8 +++++++
 arch/loongarch/kernel/entry.S               | 22 +++++++++----------
 arch/loongarch/kernel/process.c             | 33 +++++++++++++++++++++++------
 3 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch/include/asm/asm-prototypes.h
index 51f224bcfc654228ae423e9a066b25b35102a5b9..704066b4f7368be15be960fadbcd6c2574bbf6c0 100644
--- a/arch/loongarch/include/asm/asm-prototypes.h
+++ b/arch/loongarch/include/asm/asm-prototypes.h
@@ -12,3 +12,11 @@ __int128_t __ashlti3(__int128_t a, int b);
 __int128_t __ashrti3(__int128_t a, int b);
 __int128_t __lshrti3(__int128_t a, int b);
 #endif
+
+asmlinkage void noinstr __no_stack_protector ret_from_fork(struct task_struct *prev,
+							   struct pt_regs *regs);
+
+asmlinkage void noinstr __no_stack_protector ret_from_kernel_thread(struct task_struct *prev,
+								    struct pt_regs *regs,
+								    int (*fn)(void *),
+								    void *fn_arg);
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index 48e7e34e355e83eae8165957ba2eac05a8bf17df..2abc29e573810e000f2fef4646ddca0dbb80eabe 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -77,24 +77,22 @@ SYM_CODE_START(handle_syscall)
 SYM_CODE_END(handle_syscall)
 _ASM_NOKPROBE(handle_syscall)
 
-SYM_CODE_START(ret_from_fork)
+SYM_CODE_START(ret_from_fork_asm)
 	UNWIND_HINT_REGS
-	bl		schedule_tail		# a0 = struct task_struct *prev
-	move		a0, sp
-	bl 		syscall_exit_to_user_mode
+	move		a1, sp
+	bl 		ret_from_fork
 	RESTORE_STATIC
 	RESTORE_SOME
 	RESTORE_SP_AND_RET
-SYM_CODE_END(ret_from_fork)
+SYM_CODE_END(ret_from_fork_asm)
 
-SYM_CODE_START(ret_from_kernel_thread)
+SYM_CODE_START(ret_from_kernel_thread_asm)
 	UNWIND_HINT_REGS
-	bl		schedule_tail		# a0 = struct task_struct *prev
-	move		a0, s1
-	jirl		ra, s0, 0
-	move		a0, sp
-	bl		syscall_exit_to_user_mode
+	move		a1, sp
+	move		a2, s0
+	move		a3, s1
+	bl		ret_from_kernel_thread
 	RESTORE_STATIC
 	RESTORE_SOME
 	RESTORE_SP_AND_RET
-SYM_CODE_END(ret_from_kernel_thread)
+SYM_CODE_END(ret_from_kernel_thread_asm)
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 6e58f65455c7ca3eae2e88ed852c8655a6701e5c..98bc60d7c550fcc0225e8452f81a7d6cd7888015 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/entry-common.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task.h>
@@ -33,6 +34,7 @@
 #include <linux/prctl.h>
 #include <linux/nmi.h>
 
+#include <asm/asm-prototypes.h>
 #include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -47,6 +49,7 @@
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/reg.h>
+#include <asm/switch_to.h>
 #include <asm/unwind.h>
 #include <asm/vdso.h>
 
@@ -63,8 +66,9 @@ EXPORT_SYMBOL(__stack_chk_guard);
 unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
 
-asmlinkage void ret_from_fork(void);
-asmlinkage void ret_from_kernel_thread(void);
+asmlinkage void restore_and_ret(void);
+asmlinkage void ret_from_fork_asm(void);
+asmlinkage void ret_from_kernel_thread_asm(void);
 
 void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
 {
@@ -138,6 +142,23 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
+asmlinkage void noinstr __no_stack_protector ret_from_fork(struct task_struct *prev,
+							   struct pt_regs *regs)
+{
+	schedule_tail(prev);
+	syscall_exit_to_user_mode(regs);
+}
+
+asmlinkage void noinstr __no_stack_protector ret_from_kernel_thread(struct task_struct *prev,
+								    struct pt_regs *regs,
+								    int (*fn)(void *),
+								    void *fn_arg)
+{
+	schedule_tail(prev);
+	fn(fn_arg);
+	syscall_exit_to_user_mode(regs);
+}
+
 /*
  * Copy architecture-specific thread state
  */
@@ -165,8 +186,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		p->thread.reg03 = childksp;
 		p->thread.reg23 = (unsigned long)args->fn;
 		p->thread.reg24 = (unsigned long)args->fn_arg;
-		p->thread.reg01 = (unsigned long)ret_from_kernel_thread;
-		p->thread.sched_ra = (unsigned long)ret_from_kernel_thread;
+		p->thread.reg01 = (unsigned long)ret_from_kernel_thread_asm;
+		p->thread.sched_ra = (unsigned long)ret_from_kernel_thread_asm;
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->csr_euen = p->thread.csr_euen;
 		childregs->csr_crmd = p->thread.csr_crmd;
@@ -182,8 +203,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		childregs->regs[3] = usp;
 
 	p->thread.reg03 = (unsigned long) childregs;
-	p->thread.reg01 = (unsigned long) ret_from_fork;
-	p->thread.sched_ra = (unsigned long) ret_from_fork;
+	p->thread.reg01 = (unsigned long) ret_from_fork_asm;
+	p->thread.sched_ra = (unsigned long) ret_from_fork_asm;
 
 	/*
 	 * New tasks lose permission to use the fpu. This accelerates context

-- 
2.43.0


