Return-Path: <linux-kernel+bounces-548057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB75A53F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD7C3A74EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD1E86344;
	Thu,  6 Mar 2025 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h4uHD4+k"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE386487BF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221852; cv=none; b=Ly7KpgcPjKoUQfa5H9U2uNVB1XIeAfJevzIcjlzqczi6R+5Uf6Gv+3rGjsoSoPH/GQw2B2IgdsztQtS61Q/154pvYQqwH04uaBNtds2pveIjuqFiIpWVxItkuJ273vDGDwcWAZ9NmD7lhXNF8Tdb9/S59djY2De85kA++5+e5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221852; c=relaxed/simple;
	bh=LoTSopBOka5A9kpDiPFFurbF+1mjOb81UBycxnBlNbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5MxF5MWjxWTOoTu+Auf/1FklfIVIEdE1IqIklDw749yQDNCNEKSD6uxYcReMa7g5nS0+Xp/xl9S7VrtTjlikDjoqJGz00PWrWBk9DLfeFb2Sv2s2mySTeUoZaqCfptrOjXiNCP/Kzywwp45pDp92x93bkl1P8Yxo4j+M1M0dxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h4uHD4+k; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2235189adaeso2147555ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 16:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741221849; x=1741826649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehMUm3J1yyvZGiQlan49h9651rjeLktXjDjteQa4YzI=;
        b=h4uHD4+k0Ln0p30rwrlS23bOEfOAaclc9uXb9P7QsovsIw37FX6O8s6maZuaQCl1PE
         LrDqID8tch3sabExKE4WwRfxdGW/K29ztVCFB8GYF6fK7A/w2uZlXvY2IUB0D7jGqleM
         fh82vnk1ds4KCP2kt5WoBkD40S7TbXQY66AcL82F2sxrVcLp6697F5KTN2C+mc6O/7EI
         yErzQrLB4y2D9ezjHzH5ViZrmZZNMwOSROd1rPJfxgE3ZAcALzdZ+u1cDyyOQtuAo+FD
         G2MSb4Qwh3GNz3cKBCHbbGv1Mys7i8iE/RIay4FeJxqi/Phqi2J4CESgQfVzhzn4pT8O
         R2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741221849; x=1741826649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehMUm3J1yyvZGiQlan49h9651rjeLktXjDjteQa4YzI=;
        b=E1+YVtHqWnEIISkGQR9JlgiGgr5CgHGT1HimW2xLy8Zkqpjoru8xKyD3bHb+GBUcwI
         TMqWKX0pjDjg3uiXR7UNaTEe0vVHyy6ixqpSHNLy/vBgZjpPsWNCQ+gvNC8SFy0hoGnu
         i4JVaFomnQvG36/Ik1pXqn1LBFKexDyTt1gR73bR296qj4yNVO9jWKgegQXVuknaN+SJ
         JqQJnWUYxr7BchwchdFEQ8SYnkAWuoPYfLVT/sGPyZzQOEik6n+P/7Z0G4vjCN/GQnzI
         9z0Yc/bLWOd8oci4i7fa0TtG7HbGZwqDxzowUKrh/tgX4i/xgLNTLZvU4CtwNN7Z11SG
         qZnA==
X-Forwarded-Encrypted: i=1; AJvYcCW2nvIAhmCj+/Maz0hE5j6wjk56jSk0RWeCgotqcLAWubjaXF3qvrnQFAZ/klvP43P1y1q6rP3MhyFjh9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1zS+HBgFN5Y9hRJbET7WY1NqhSbr+OrNIh7tD6NZMwh7TPIa
	qH4mKrljk+/eJqJ+QFRpRqz7TZhwbfHdNFRR8lvHUIIri/TcvGQqvCx/G9d8hl0=
X-Gm-Gg: ASbGncuiiPakWVmmmcJCX7PRZHuukQIhQbV/z6fM2fLmMeYA5yDX1K2h3s1ritOkicG
	NYozF2l/0zxHkl9uHuPBNlyoOWIt+jvQTdMUO/tyZp0Q5d+g2YypTmvvp1kIfOGbJHsT70/RSrp
	poSjIl26pYYn7Rgsd3Y4klV7lAWJ0+XL6tQql8L83kviWhVabja+ak97AUVBIhOv6K0V5cUgKBi
	TvLRg3QsPDLdqGq7s1BxB8EacsVeJbpy8GIsEVSNTW50x1rJqctDJdYrSiubRZI9gd92Ql6k06S
	HYEoJcjjWF0pdiHIW4GXf/wD44aPlI9SV782TxtZ4VWJ8JmfxBfnU7Apes0F
X-Google-Smtp-Source: AGHT+IHUzwBDw/uha6a2fjM59Txc8WQN/Vrb5TcHaRq3eYqWZnWT8m/ex64QjFGpr4eyefI929SBSw==
X-Received: by 2002:a17:902:c943:b0:220:e91f:4408 with SMTP id d9443c01a7336-2240948d12fmr21414815ad.22.1741221848994;
        Wed, 05 Mar 2025 16:44:08 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f7efsm347085ad.132.2025.03.05.16.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:44:08 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 05 Mar 2025 16:43:45 -0800
Subject: [PATCH v5 2/4] riscv: entry: Split ret_from_fork() into user and
 kernel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-riscv_optimize_entry-v5-2-6507b5dff3ce@rivosinc.com>
References: <20250305-riscv_optimize_entry-v5-0-6507b5dff3ce@rivosinc.com>
In-Reply-To: <20250305-riscv_optimize_entry-v5-0-6507b5dff3ce@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4464; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=LoTSopBOka5A9kpDiPFFurbF+1mjOb81UBycxnBlNbA=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qJ95dzi+tVwqu5bU9Lb1zHVqURfOznouv2s2e7/J+z/
 ItZ042DHaUsDGJcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEwk7wIjw6S+bwF+haUsh6ez
 hRkGTla4Vckfo5V87KSvdlx+58+kXYwM3Z1PzoZozOg7tNdk7WpRtQWuZe9XxbPb9S5Xu/P274Z
 8TgA=
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
index 7b0a0bfe29aec896c2bdd8976d855dd390de88d7..485ec7a80a56097e8905cd6395af29633846b5c8 100644
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
 	if (has_vector() || has_xtheadvector())
 		riscv_v_thread_alloc(p);
-	p->thread.ra = (unsigned long)ret_from_fork_asm;
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
 	return 0;
 }

-- 
2.43.0


