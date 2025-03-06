Return-Path: <linux-kernel+bounces-548056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEFBA53F49
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63543AFD8D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD23CF58;
	Thu,  6 Mar 2025 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="05jPVfS9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052531BC20
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221849; cv=none; b=EIkbNL7WyEkyS6n+pkqLYx76/tqFKz87RqXZ4wxQgjiY9rAWuWvpqPjKVOLljzIrVqJsf8qqUkpNxuFGYmC5cGjdioPVPufhjRHEVKGiGAU0QVU6eYOURoXz1FkJ83yLCEE/QIVtbhpFXDHkQu4TQJD2S9QxOCsLTmOduGDER4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221849; c=relaxed/simple;
	bh=gaq/v9YuAdYAHAPq6G2li6XLwEhlQb1rcc0R86FQKSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJr7AQqHcbX/EZK2DSuikHDeysIjHphA+pRGDM4ernmA1VOCABgW7I6NJb9Y/8Lz+j1Wu3lUfxDyIy269u9LgOV9lBlJorWlNXKXFruRW8widZi+sUnk0QhISwfNecp97rRvKEqoqijDcIZ3dpC4van2Kj8aANiE8I4YBbkuG/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=05jPVfS9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2234e5347e2so996195ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 16:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741221847; x=1741826647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3jS1rl0NyPiPtBrV6gbvaKvWtHD4LTe2LvNMOIdkhU=;
        b=05jPVfS9KwqNHxZl2G5BIfH9D1Ub+FXc2sDPcMpZ8vHIG512yFWcxhtnJYhu6eh1ke
         geyahNNays0DQob808OPwSl1kU4c0t8GcSiQpv0FPfCw/wKkuvzl4lRYCne1VWfrJEyF
         CBygSWCgvUBuaiQbP0vXFeTpQAYc6GXGCk2xt/ev9Avl++ua6UN52oznbuTKgIhicV5w
         wOSuIAkBCImrkOoyIzTFtpWG7AhgAuYQ9N1njN4XI3JquB8WDg67ylg17rB0mhIJZg6T
         xpqhUbFu4Fi3swxO7PXZqDVfVAmGfFeN3Sx9q1ZUjMI5fV6KzNsM2ElmIDAO5GcmgQzb
         1NFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741221847; x=1741826647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3jS1rl0NyPiPtBrV6gbvaKvWtHD4LTe2LvNMOIdkhU=;
        b=IvYO0+tl0GQkUc2qhoa01XCieiK2ife3EJZQG4xlJi+uAFYLv3G/a3zAu3ecbU29+V
         gWRyO3FN5NdlmlMs2AVGekAqgms4ZmYts6Ax4+H5kMDxkFU3QmRXGD0lY8Dh4tUxBd/r
         gcN6ztXjy9yz7Rj1M4ArlflJJSEEvzZcPn1n3Mmj/2+NX1KNA9Z4C+/YOI5hy8cXzWg9
         k4yKGKcvFPTd4ZGsIMeYLGR4KBkymL23racp5e1cfLcgFLoMYVdWx/JF1G5eu/NLE4/6
         bLE7nwhRzjsaC9FrG3G8flryrbPB0mObSvliV6sTlHvo4iJeJzN0DHdoANNlRd5PDF+U
         6c0w==
X-Forwarded-Encrypted: i=1; AJvYcCXD3RSz2DYKgAcI2F5qK1X4XsYxhELQcO9NcfbLvMuOMb05V5n+oTRVmgeQ6fQdvVgXaMvjVg4u7NDiK4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rfsGLAav8LxUiV7KLXRJCWLrdGg9UIzjhBgUJJNzy1kuuUsh
	rdIKBWSyPrEPDPMIx4bCErH/TV3fD/iMGHUcajP0ktHjnNjhNnwrDsx6XKfTTl4=
X-Gm-Gg: ASbGnctUEsJg2ACNz5g/9T1bcmY8rqZk07QS6uy9HTvCYFjHBt3wmzAmOCAHWMalZjp
	UrRj36jum6sM4I5JqWTTGfaGUvOmSP44J86sE3oS1UyxK16IYzTScSselnPYyrpessGqDdv+6Ul
	BcdfmCMD1fLRwBCHW+w+Rp6GQYYR2MnKV52cdT+6THpZWQHmQN0hnKeaDCdcnkWFvXIh+UyU38p
	hDyYqiIG4k8/7Dn5tym020UPzz5m6+tV5gYFrZVoboCGWk2XYfxlIH2HhqhKoFUjDPo5bzj5V98
	geEKrzQTSelNrz8xKEnWZX30vXlEWfd61jHkbAiewy5ZTnyQhlUIGWr1htpY
X-Google-Smtp-Source: AGHT+IF34qhqv3xIO9NNzcZh5fK7vqon1KbTtupxHGRr8Axwn6/+XVCjLb/ogfXTpG9fz+kT+EQwYg==
X-Received: by 2002:a17:902:f606:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-223f9a457a2mr63068485ad.29.1741221847212;
        Wed, 05 Mar 2025 16:44:07 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f7efsm347085ad.132.2025.03.05.16.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:44:06 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 05 Mar 2025 16:43:44 -0800
Subject: [PATCH v5 1/4] riscv: entry: Convert ret_from_fork() to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-riscv_optimize_entry-v5-1-6507b5dff3ce@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3515; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=gaq/v9YuAdYAHAPq6G2li6XLwEhlQb1rcc0R86FQKSc=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qJ95cmmFbUVL2sO39dKoPRMmj9pzsX2Qs+M8168p73+
 VOJGWfbO0pZGMS4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZhI7VFGhsfPeK/yBc58PmH/
 xAU9hi8Wqni+fhxzylBn0evACz3GjdwMv9mKOK8wLMzQEsx4Ob15ef/Hi1oMOlvuvJux01vD0Td
 nMhcA
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
index 7c244de7718008947075357ea4502d56419d507c..7b0a0bfe29aec896c2bdd8976d855dd390de88d7 100644
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
 	if (has_vector() || has_xtheadvector())
 		riscv_v_thread_alloc(p);
-	p->thread.ra = (unsigned long)ret_from_fork;
+	p->thread.ra = (unsigned long)ret_from_fork_asm;
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
 	return 0;
 }

-- 
2.43.0


