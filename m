Return-Path: <linux-kernel+bounces-547918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE37CA5283D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8107169F0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32438207678;
	Wed,  5 Mar 2025 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JnL3oiR1"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2175202F80
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215645; cv=none; b=kF14eTaywzzPsdJQ2FwXehFCnxaCw269NhqHqIyANjUqXNM1cyKA42/LYRUvbf7X8dOo/rJ0StAvIvDXcf2cU4IOFf8PK8Iru81QGYFkgDWvHI4ghQgjtjF4BZJgjX9IcOgsWrgxEfZ9X2/ByHtZM1/ecMSRlvZ8DJ5A4GCwLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215645; c=relaxed/simple;
	bh=e+QmdYfzdsHe2i47iJnp8obSLIn3fW5B1Uv/wF/582w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJLHYNW8Xj+G4/Bdm2XBVnVQ4V70qVNR/l8+3pGWg6G4dGd9yi/8z5ud6KF10XZSYxrUp0aySMGDH7thS8cP6KrkhwyJHwiX1qvQmszJCiFKR78FWazqewLWwHq4G2m0c3q7bUSj0eAQ88tpDsnEM5hBLdyLZq64yrQAo0KT1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JnL3oiR1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso110826a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741215643; x=1741820443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNOxwbh8TJLovUJ4xbmkceu/OhoInCtt14EIM5E3MZs=;
        b=JnL3oiR13RxteGPWPiJhzhm2OGI/mBaWw2Gza0ZcbquOIvlkyS7Z6Do7sFt3VQXWAi
         ENAabJdj1bLo/YJkJBNZy8YMFTnZvGje7+ykgLc0iCRH8bYsH7v6KdKCM75q/95Opptr
         uYxU1S/XkBq0v6i4h1mMY2HFV18TB4WePdJnxXXKz9pnBHfITH6NYmKZrkyJ8fJ/+egk
         t6nkUD4RzBDOBYgID2qp7TyBqFNChkiTWQ6mdYy4zCjwYx2oEUITJvjHIS1LCf+RO5rJ
         RG2kbThpO0gwRIhtxtztxmQLRr72Ld7n+ruNF7UdBlXsqYRDiyKMQ52pvUAcQtg72SWe
         2sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215643; x=1741820443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNOxwbh8TJLovUJ4xbmkceu/OhoInCtt14EIM5E3MZs=;
        b=d++U/dn7SVCN7YeszKVmhMgdRWa830CuogCdPHiv/96cITcWQ9p9vSGOMnc8Ryf4xZ
         7cOZkgIRLhdggL89pVjzU26mauIYxyZ5148N5n2I0kQKnKBo19T0M/Wi4EproqEcLEtT
         tMvd5t++9KWzEl8VBmAA7wlpCFRtdY0+H3x+fFZO6E4C5jYXWNW8mf9nkicqdeN/JZgr
         Wyjp2DgA674YyMD61omKOKcQk3+d+jjneTvUgWGdwe5xkeEzGk3g1BGOyQ86R2F+Dlxo
         weNWT8fCdhs9URy3QD9+9PH7qxdTtvW5hOCX73R9RMC059JPBgxI1lzyZVjG77n3HnAq
         LPJA==
X-Forwarded-Encrypted: i=1; AJvYcCXTV0U8A70sJzrWRy8yYDpDLzAi+X+Uxut2VEmaRso/2/R75jckjF6kB0zDQBY7KTxELTuXsTJMupUVaXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCRyTk50+I3rWsSfk8L4Ez1AhJ1nyAuaVDvRx6rE7Bgn2GeV4
	byWzygXGcFG9Q6ovyDDJJ10n4TEOdJx0XhVrvsLGRASuANajdKcAXFxKeTBAhLc=
X-Gm-Gg: ASbGncvRV0wL49palsN+wKeLm9znIaEIMDUhBXhNnnq9WfKJTMewCmj1xyNd4zbFKM4
	HlR0gd5h18kFPLdJ0PzBr2ZhLwP0/NJELk3KextZQX+lySlmvxButA4JONvl0qYD7IuKGLkN2gr
	0jC1FU2MF0G4UYW+8rFJVASaLWH29X8sHt7NMuESGodpuccl/PMt8Ch4upnL49MAqibw2gnjFTW
	/Qykathg51tptngbpptEuTNOfsgZuktktXXnB7uCIHbiYu2RMTlbWcVJpU/Ni0fHphYbDT8I5XW
	Yut6hb/TnUG5yDZ/qYGgnlatfoXVv04Os12Bn6lKg8wr20xzONfzccYuCwZZ
X-Google-Smtp-Source: AGHT+IE0LT3egsCf9Urz66Hr4bJMn+zainSmz8nEsKJAFaaZPyaYH4qzNRLADAIJB2bEWLdIN8btRw==
X-Received: by 2002:a05:6a21:a43:b0:1ee:ce5b:853d with SMTP id adf61e73a8af0-1f349570abcmr8120592637.39.1741215642914;
        Wed, 05 Mar 2025 15:00:42 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedd22esm10593413a12.63.2025.03.05.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:00:41 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 05 Mar 2025 15:00:25 -0800
Subject: [PATCH RESEND v4 1/4] riscv: entry: Convert ret_from_fork() to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-riscv_optimize_entry-v4-1-0d81bb45203f@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3493; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=e+QmdYfzdsHe2i47iJnp8obSLIn3fW5B1Uv/wF/582w=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qJ69PiNd+oeFsds8zszVLMP1HHUte0ZAm/YvjifVG3J
 lz6OkWuo5SFQYyLQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgIlc/cfI8Fb52bE/3fqqn9pY
 j5QxTM783rF7xm3Bx3y1eQkHNeZEHmT4p/R6+499UV/jbyb9ubj4WFiuRHdFRXrlg8+RQUHrrX5
 oMAEA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Move the main section of ret_from_fork() to C to allow inlining of
syscall_exit_to_user_mode().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/asm-prototypes.h |  1 +
 arch/riscv/kernel/entry.S               | 15 ++++++---------
 arch/riscv/kernel/process.c             | 14 ++++++++++++--
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index cd627ec289f163a630b73dd03dd52a6b28692997..733ff609778797001006c33bba9e3cc5b1f15387 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -52,6 +52,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
 DECLARE_DO_ERROR_INFO(do_trap_break);
 
+asmlinkage void ret_from_fork(void *fn_arg, int (*fn)(void *), struct pt_regs *regs);
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
 asmlinkage void do_page_fault(struct pt_regs *regs);
 asmlinkage void do_irq(struct pt_regs *regs);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 33a5a9f2a0d4e1eeccfb3621b9e518b88e1b0704..b2dc5e7c7b3a843fa4aa02eba2a911eb3ce31d1f 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -319,17 +319,14 @@ SYM_CODE_END(handle_kernel_stack_overflow)
 ASM_NOKPROBE(handle_kernel_stack_overflow)
 #endif
 
-SYM_CODE_START(ret_from_fork)
+SYM_CODE_START(ret_from_fork_asm)
 	call schedule_tail
-	beqz s0, 1f	/* not from kernel thread */
-	/* Call fn(arg) */
-	move a0, s1
-	jalr s0
-1:
-	move a0, sp /* pt_regs */
-	call syscall_exit_to_user_mode
+	move a0, s1 /* fn_arg */
+	move a1, s0 /* fn */
+	move a2, sp /* pt_regs */
+	call ret_from_fork
 	j ret_from_exception
-SYM_CODE_END(ret_from_fork)
+SYM_CODE_END(ret_from_fork_asm)
 
 #ifdef CONFIG_IRQ_STACKS
 /*
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 58b6482c2bf662bf5224ca50c8e21a68760a6b41..0d07e6d8f6b57beba438dbba5e8c74a014582bee 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -17,7 +17,9 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
 #include <linux/personality.h>
+#include <linux/entry-common.h>
 
+#include <asm/asm-prototypes.h>
 #include <asm/unistd.h>
 #include <asm/processor.h>
 #include <asm/csr.h>
@@ -36,7 +38,7 @@ unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
-extern asmlinkage void ret_from_fork(void);
+extern asmlinkage void ret_from_fork_asm(void);
 
 void noinstr arch_cpu_idle(void)
 {
@@ -206,6 +208,14 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
+asmlinkage void ret_from_fork(void *fn_arg, int (*fn)(void *), struct pt_regs *regs)
+{
+	if (unlikely(fn))
+		fn(fn_arg);
+
+	syscall_exit_to_user_mode(regs);
+}
+
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
@@ -242,7 +252,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	p->thread.riscv_v_flags = 0;
 	if (has_vector())
 		riscv_v_thread_alloc(p);
-	p->thread.ra = (unsigned long)ret_from_fork;
+	p->thread.ra = (unsigned long)ret_from_fork_asm;
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
 	return 0;
 }

-- 
2.43.0


