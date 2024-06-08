Return-Path: <linux-kernel+bounces-206930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B3D901001
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84AE1C209F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9B17920A;
	Sat,  8 Jun 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeofsdE5"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661713DB90
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717831947; cv=none; b=LCIbGkz1GJTA1Pj1+gS2iAGw9yV2PQpchf5yiPN7e+eWm67N4UUbUf52nI8aaUsYY4D5a1o+DIpF9VjEY/ljB5e9qUXPw3adAZDqdeyIh4RXePRJRBCV4bHo9NLKeOQayX83sonx6b3dbbjgWsVUZp3wAqOYyTOuQhPZijsBkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717831947; c=relaxed/simple;
	bh=XDZH9IEws56z+IXOYnMIYkJZCzATTFYM+Rp1MP4HDm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1n0agFRq/hKCBG3UGJ9B9iJbWmg5O+1UhdhVTNEww9LtFBwxr/q5e5hd78DNbrw8V8TXFetjRo6K+eeyhh6xeZHsJyM1aaq6V68v9RjJNPRjR1vLv6rtccc202h/0Ih3XJsvKfkjPsg9TF75fFKx6iSUrLieuMh7cyrzPdg/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeofsdE5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso1293937e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717831943; x=1718436743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+lBgMuuZ2Dd+zsmU6HUgP6ijp+tIzvqzbKgCVJv1Uw=;
        b=AeofsdE5Zz07ot8Jejhr2RkQ/c+i1TGRhWNXlrAtyOJOP5xX0b1kY67k/tR3NghLZ2
         FaAlOgZtpppV8mEGWrBax8JJUaaNyieTKBEMt5RTaswIRvateUbU1VndiTGj+pL8pvF7
         qSRe538kKWrX76Ik+H5TgkkKSGc1KfZ4S6FrdGrQfgSqcrxu9c6EiInBPL+Kq64vL6hl
         IkbIiPUvNCLVi0BEpJIvqyNh21jTQHpbROOk8lOHfpE1jawa+qQ0r+a1142D0jB38yLv
         W2bSfmDqnbwVRmi5vc5EBnpJYLhW4j4wav2iFOvE2PxnxT6Ep7ugt0rVH7DO32dd6kK/
         KeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717831943; x=1718436743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g+lBgMuuZ2Dd+zsmU6HUgP6ijp+tIzvqzbKgCVJv1Uw=;
        b=ObmjYa62tQtC984VIyJROQzdw3ww4n7ddgSGFlEUn0h6GbL4PQixVOa/MqjT7Zb989
         vxBHYlUdeokZ9IFJonwk7zRZY6cFfc4TKdh/OdGyIdMyyaGmQIFngniujnhWza0wN6WE
         +CI3kTL/pqx3Yl3LWLvIO7x+QL5M6pJRJNYFYQ6nnKQ7Dj2fM55QuVpu87pfkEmgmpEq
         IcDHNIi+Wva93CUKHA7LZR+re5LIMYuF7pv0ILzvuOeoDmWQ5qmcIyDJWpfCWFFfFUbw
         dxSJCA1KyVilwRzrPSdF4szgzCEh49VLV4yN0lbckJrTbKk42uG8cGwVbWZ+Jb7KJFsG
         OLkQ==
X-Gm-Message-State: AOJu0YzPlkSSnb0XyVJJATloPZoUmM1trndIrwDAwQtyNBp7DZega2vG
	s4fm4Oiq2UY9owyBjN14dmQ0eo6O1Q2/Yg+wMk0aRMEhGua8U7FE/C4FaNr6
X-Google-Smtp-Source: AGHT+IENMEzow4sI0ynD4kPhjo+ZOS7gtPqbiq2rH4V+Y+Aw2GOz6awtDaT3gV3Dpl3JJXxHSFDm8Q==
X-Received: by 2002:ac2:43ad:0:b0:529:b718:8d00 with SMTP id 2adb3069b0e04-52bb9f624f4mr3311999e87.8.1717831943027;
        Sat, 08 Jun 2024 00:32:23 -0700 (PDT)
Received: from kepler.. (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efe5262cdsm61350466b.117.2024.06.08.00.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:32:22 -0700 (PDT)
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
Subject: [PATCH 7/9] x86/fpu: Remove init_task FPU state dependencies, add debugging warning for PF_KTHREAD tasks
Date: Sat,  8 Jun 2024 09:31:32 +0200
Message-ID: <20240608073134.264210-8-mingo@kernel.org>
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

init_task's FPU state initialization was a bit of a hack:

		__x86_init_fpu_begin = .;
		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
		__x86_init_fpu_end = .;

But the init task isn't supposed to be using the FPU context
in any case, so remove the hack and add in some debug warnings.

As Linus noted in the discussion, the init task (and other
PF_KTHREAD tasks) *can* use the FPU via kernel_fpu_begin()/_end(),
but they don't need the context area because their FPU use is not
preemptible or reentrant, and they don't return to user-space.

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
Link: https://lore.kernel.org/r/20240605083557.2051480-4-mingo@kernel.org
---
 arch/x86/include/asm/processor.h |  6 +++++-
 arch/x86/kernel/fpu/core.c       | 15 +++++++++++----
 arch/x86/kernel/fpu/init.c       |  3 +--
 arch/x86/kernel/fpu/xstate.c     |  3 ---
 arch/x86/kernel/vmlinux.lds.S    |  4 ----
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3de609aad0af..4fd3364dbc73 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -504,7 +504,11 @@ struct thread_struct {
 #endif
 };
 
-#define x86_task_fpu(task)	((struct fpu *)((void *)(task) + sizeof(*(task))))
+#ifdef CONFIG_X86_DEBUG_FPU
+extern struct fpu *x86_task_fpu(struct task_struct *task);
+#else
+# define x86_task_fpu(task)	((struct fpu *)((void *)(task) + sizeof(*(task))))
+#endif
 
 /*
  * X86 doesn't need any embedded-FPU-struct quirks:
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 52d5843c886c..db608afa686f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -51,6 +51,16 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
+#ifdef CONFIG_X86_DEBUG_FPU
+struct fpu *x86_task_fpu(struct task_struct *task)
+{
+	if (WARN_ON_ONCE(task->flags & PF_KTHREAD))
+		return NULL;
+
+	return (void *)task + sizeof(*task);
+}
+#endif
+
 /*
  * Can we use the FPU in kernel mode with the
  * whole "kernel_fpu_begin/end()" sequence?
@@ -590,11 +600,9 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	 *
 	 * This is safe because task_struct size is a multiple of cacheline size.
 	 */
-	struct fpu *src_fpu = x86_task_fpu(current);
-	struct fpu *dst_fpu = x86_task_fpu(dst);
+	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
 
 	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
-	BUG_ON(!src_fpu);
 
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
@@ -657,7 +665,6 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	if (update_fpu_shstk(dst, ssp))
 		return 1;
 
-	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
 	return 0;
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 794682b52373..53580e59e5db 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		fpstate_init_soft(&x86_task_fpu(current)->fpstate->regs.soft);
+		;
 	else
 #endif
 		asm volatile ("fninit");
@@ -209,7 +209,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_kernel_cfg.default_size = size;
 	fpu_user_cfg.max_size = size;
 	fpu_user_cfg.default_size = size;
-	fpstate_reset(x86_task_fpu(current));
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 90b11671e943..1f37da22ddbe 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -844,9 +844,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	if (err)
 		goto out_disable;
 
-	/* Reset the state for the current task */
-	fpstate_reset(x86_task_fpu(current));
-
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 226244a894da..3509afc6a672 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -170,10 +170,6 @@ SECTIONS
 		/* equivalent to task_pt_regs(&init_task) */
 		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
 
-		__x86_init_fpu_begin = .;
-		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
-		__x86_init_fpu_end = .;
-
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
 		NOSAVE_DATA
-- 
2.43.0


