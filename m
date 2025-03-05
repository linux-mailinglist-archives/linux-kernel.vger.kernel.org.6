Return-Path: <linux-kernel+bounces-547919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F52A5389D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315F918906CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF212066C8;
	Wed,  5 Mar 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V4pB/nlM"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BC2066C4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215647; cv=none; b=a9Wg2s1lot9idOSF0dmXMI08AnlTz/jMdTKmnUquSPZkSETtjxtuZLCGy/yqlW+6PrHT7WCAJ2m9IZJoeK84BGZeyPO88Nk95UP9tubiQRegYIwXoYszhtsSljCguru6yq7bngmSrNDBtLJuOXklYSgONI6IDOgzVmXkxt2jnyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215647; c=relaxed/simple;
	bh=t9WBogxb56lApIirNVzIj0lHOk+/6g6AFgtrehj97DE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QReXAHM0j2mvdab+cIBx8vjzRlJ2DCsLhIgpm/KTCrEdq2RM6SXjAWnYJBQUeI/IH8i/hN1G/poPelcHgac6yHJa4IZIxGYnwxnKX/97/8S/g1M5plkkeZ3WBbvpurnwg5zYpT24maBJmYdAyDqo3X6+EOdJovS8NxFRTIea0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V4pB/nlM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2feb9076cdcso182840a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 15:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741215645; x=1741820445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnq3B23qbOBveDsFleAgWeOkAmZk3gQFKZw4IbSmZLU=;
        b=V4pB/nlMXDuXL9/BFfUPB78Oou0InK9LaFA0hc5RN0hEDGqihQcVyCVKSwsM85tbCx
         pmFU5B0VDsKmMq+sDIPHzbLgLO//+HSdPpkJZ0b8ntsZDXMpM7ZzHOxvebvf9iq0ulNq
         6pvK8NeB0ouEVur1ybOAIC0vCYQn2AB1plnJH9Gsk0kdY2qQ79ZEAmwigCTm7fkftTG/
         L3G5BvMWWTJAh8lemgoL3X1Og8pj4CdJuJ3NhxBr5TfBn/FqXKFEZgyt6nJrv6UESAFR
         bs5aa9ibtVEdnhwc7uf/Bp1Ki8nuIHT68ffyUg4uxTwhotfs8erCql7q+dPLWk8gJsLe
         GCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215645; x=1741820445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnq3B23qbOBveDsFleAgWeOkAmZk3gQFKZw4IbSmZLU=;
        b=Xfzj/EN5QXXMQz27Kmz11JSsqyvdlXQRBu+WTO23k067l/sBbTNUBLaFMdOr5JH7W3
         LNBSZ4kxRgM4BUTvhZWOABaI72fahKE0QjaJPfudALUPGip2Ff6jMQLWSpYwTEBqokxv
         Y8B7xt7RRhPVm0D9oXEWnLjjnYczDZ4T+IsLHZAPFaS6PmOPHN1GN4WaEOXUw5jQBMs2
         QZ7uDADqNT+rBBwWcWEDj66jljRzqyhjhYTf34SF4GopK/Y3j8tw97jpQUmf7TS3a8ew
         /jotRyY6FDFAEzB5ZsI2xfLC7hrp8Sjm4AotAzamhJ0MsItAfGpl4tv0eu/K9A1tn907
         HPyg==
X-Forwarded-Encrypted: i=1; AJvYcCWw77SzX2Ae9tsoqyQeMYPnSIE4fbHP3YFf48mNLyayKjmwwITzn7lmABbNeoSMteNoITM+vjqj1s8+gjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZoFk6m4vqRVTpCmncHJl0cNlqRnBGZ6Ndb01bJsNCm3Zm/52S
	i/nTcm9FaBeyp3F+nCRl7mCVirT66lc0DE6DxsiKX5WX45SQe1dOf0sIWz+zDPI=
X-Gm-Gg: ASbGncsH1TBMyCuYRojpXXmzogVGhFnVGU9b4OCELXLTD0nMyogP2v+hxRUFOxfvO0/
	S1euZKlZADHVDUMzC4fK/Ql9Jdaj61/KmdLVFk8N4fK3hCD6YtB41Bh/0HInPN1qqR6MLprx8o1
	2wnQuXZRaLZhZVGGS6+/xj+7BxsP1r2YUF1e9FB5kpTOc8URP04Tgb3GeGhUFNFTQnBMjG75CJ1
	QdMfxla7gWQ0x5Jw2pRzsjzxJKj6Dh7AgbHFhTiqgEKnvhEVfVwfd0dM8ReDlFwKcuoE75rRKxn
	9i20GovipiqjfzaI0po+UbLw7RynqEMlbX68mWQQYh6TIARUnCJgxX0wEF8c
X-Google-Smtp-Source: AGHT+IHvW5MI/rViqhq1DoMiw7xqnu+EXrlGQ4nTLYN2RziECr6n5eoBvZiwNc4aRRHQuXNm88Ho1Q==
X-Received: by 2002:a05:6a21:328c:b0:1ee:dcd3:80e6 with SMTP id adf61e73a8af0-1f3493303c1mr9715603637.0.1741215644639;
        Wed, 05 Mar 2025 15:00:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedd22esm10593413a12.63.2025.03.05.15.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:00:43 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 05 Mar 2025 15:00:26 -0800
Subject: [PATCH RESEND v4 2/4] riscv: entry: Split ret_from_fork() into
 user and kernel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-riscv_optimize_entry-v4-2-0d81bb45203f@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4442; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=t9WBogxb56lApIirNVzIj0lHOk+/6g6AFgtrehj97DE=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qJ69PKgi8V7xPjXmGYb6hQrvgjfnd2xYXS799eR28NP
 FG5XmdPRykLgxgXg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABNJms3I8Iq1Tv7tm/bAprj2
 6SaO39+sCbGcdkWd61+iQCeL86I0ZkaGpSUCEburIm5d+bT9h2hB1nc2rQXXr4qmanTdnGM8MU+
 OFQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

This function was unified into a single function in commit ab9164dae273
("riscv: entry: Consolidate ret_from_kernel_thread into ret_from_fork").
However that imposed a performance degradation. Partially reverting this
commit to have ret_from_fork() split again results in a 1% increase on
the number of times fork is able to be called per second.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/asm-prototypes.h |  3 ++-
 arch/riscv/kernel/entry.S               | 13 ++++++++++---
 arch/riscv/kernel/process.c             | 17 +++++++++++------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index 733ff609778797001006c33bba9e3cc5b1f15387..bfc8ea5f9319b19449ec59493b45b926df888832 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -52,7 +52,8 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
 DECLARE_DO_ERROR_INFO(do_trap_break);
 
-asmlinkage void ret_from_fork(void *fn_arg, int (*fn)(void *), struct pt_regs *regs);
+asmlinkage void ret_from_fork_kernel(void *fn_arg, int (*fn)(void *), struct pt_regs *regs);
+asmlinkage void ret_from_fork_user(struct pt_regs *regs);
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
 asmlinkage void do_page_fault(struct pt_regs *regs);
 asmlinkage void do_irq(struct pt_regs *regs);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index b2dc5e7c7b3a843fa4aa02eba2a911eb3ce31d1f..0fb338000c6dc0358742cd03497fa54b9e9d1aec 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -319,14 +319,21 @@ SYM_CODE_END(handle_kernel_stack_overflow)
 ASM_NOKPROBE(handle_kernel_stack_overflow)
 #endif
 
-SYM_CODE_START(ret_from_fork_asm)
+SYM_CODE_START(ret_from_fork_kernel_asm)
 	call schedule_tail
 	move a0, s1 /* fn_arg */
 	move a1, s0 /* fn */
 	move a2, sp /* pt_regs */
-	call ret_from_fork
+	call ret_from_fork_kernel
 	j ret_from_exception
-SYM_CODE_END(ret_from_fork_asm)
+SYM_CODE_END(ret_from_fork_kernel_asm)
+
+SYM_CODE_START(ret_from_fork_user_asm)
+	call schedule_tail
+	move a0, sp /* pt_regs */
+	call ret_from_fork_user
+	j ret_from_exception
+SYM_CODE_END(ret_from_fork_user_asm)
 
 #ifdef CONFIG_IRQ_STACKS
 /*
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 0d07e6d8f6b57beba438dbba5e8c74a014582bee..5f15236cb526bd9fe61636ed372b4b76c94df946 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -38,7 +38,8 @@ unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
-extern asmlinkage void ret_from_fork_asm(void);
+extern asmlinkage void ret_from_fork_kernel_asm(void);
+extern asmlinkage void ret_from_fork_user_asm(void);
 
 void noinstr arch_cpu_idle(void)
 {
@@ -208,14 +209,18 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
-asmlinkage void ret_from_fork(void *fn_arg, int (*fn)(void *), struct pt_regs *regs)
+asmlinkage void ret_from_fork_kernel(void *fn_arg, int (*fn)(void *), struct pt_regs *regs)
 {
-	if (unlikely(fn))
-		fn(fn_arg);
+	fn(fn_arg);
 
 	syscall_exit_to_user_mode(regs);
 }
 
+asmlinkage void ret_from_fork_user(struct pt_regs *regs)
+{
+	syscall_exit_to_user_mode(regs);
+}
+
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
@@ -238,6 +243,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 		p->thread.s[0] = (unsigned long)args->fn;
 		p->thread.s[1] = (unsigned long)args->fn_arg;
+		p->thread.ra = (unsigned long)ret_from_fork_kernel_asm;
 	} else {
 		*childregs = *(current_pt_regs());
 		/* Turn off status.VS */
@@ -247,12 +253,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		if (clone_flags & CLONE_SETTLS)
 			childregs->tp = tls;
 		childregs->a0 = 0; /* Return value of fork() */
-		p->thread.s[0] = 0;
+		p->thread.ra = (unsigned long)ret_from_fork_user_asm;
 	}
 	p->thread.riscv_v_flags = 0;
 	if (has_vector())
 		riscv_v_thread_alloc(p);
-	p->thread.ra = (unsigned long)ret_from_fork_asm;
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
 	return 0;
 }

-- 
2.43.0


