Return-Path: <linux-kernel+bounces-202017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D411C8FC6AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418571F24991
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F070D18F2DB;
	Wed,  5 Jun 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFCXoGR3"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085F1946A3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576582; cv=none; b=J96QpAg4s/fnAVTOxdA3jTpc50VvjaQsUXiKU8iR6STEL2EmunofxomcsEzHqV/Hd3nMUfYF5T29ZyO4xiQCnqDavb0vwIiBu/1H8CpbqhcQ68mMC/qxg58jrDG1e2QgVnv798aNQqBDIWAu+EsljniWGvd1onrtLB6tWHQQwVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576582; c=relaxed/simple;
	bh=H1oPBnBVjQfRZGiyn/R9IIW2oNxYjDuYpXk5v2PKj3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBKwZG6gyDrJAeiZHnxzTS3m4Zc+2Tk1QAUA2BW6W2oWvUUI8eDkwF4ftJqJrFJAtYWmGGz18OS0BjwAms7O6fJbsvFTJgKfNS2/OJY2wm42CY7X7EutEiZ/0JuScpEcRv8xeP9bUu+J59vg4xprHs+GJaCl3DzYng22euS8C6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFCXoGR3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b94ad88cbso5527938e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717576578; x=1718181378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84Ae1JfcaJHvwS9d+rL4mTufO7JwirgpdTaxG9vcwaw=;
        b=gFCXoGR30fAj9Ho1dLlOeJDBgYeHq0iu8TeCir4cF/HaPcZG61JdGAjbCF9gSckUMK
         MIEdewRLeD6Q6nO4QdyF9YkoDhRYaO4+ryTiSgHgEAwmTCFwQwOvQB5Edn2qViD5+DYC
         ljsIniqnHXCz4upDxw0Y7DkpR0cLZBu5TWgslyyyiftEKRg3sNKGm8E2LpMWfNF8QXjS
         QaCcbo3V7YhsdqsmxMa9dWeBuMqximrcqLw98FH2a+DiKGiEDTb62PASyBcN5X0PRMJg
         YXs0ABMkpEIIfGawBr9+2gBIh2cClwcBtbGKLBpBMmwKBh0S2kp4oocIZ22bq+rMz4gk
         qn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576578; x=1718181378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=84Ae1JfcaJHvwS9d+rL4mTufO7JwirgpdTaxG9vcwaw=;
        b=j2AYfef2pR4+kkGOTlEpJGSR931owd9pejeZfIAjkDOu/OdhH0YLkBl3uPa7Z5iLwp
         kaxbquOFCYe3bMZ/vsihy/esT6iz8ldLUTJgM1+XrpNzst9h/+xEUb5YobQ2nOa/usb1
         6K0EQxw3x+nYqPEt5qsS6gVogaVl0m7Y3yBo5vahffWur7gjsqXojlFDAzl6LS42t3IF
         UbnLOt3LHrV/R/MRdfImHZ33TNN0hxQtlZQKPXgW/Kb7kaztmhT/b6CtdrrZQECjzDOz
         EDXPStdomvZMa9mnG9yre0kZ621j617naYM/a8Oc9odraOTpub9cDh3/ZhTIQkEn3XDN
         oB4g==
X-Gm-Message-State: AOJu0YzcyFUC6eorP2h8TmWWi1VysM5kEufCR3OkH8TnD2JfX8FaON6c
	pbIXYHc8QTK8QNgjlO+LmUtzZd1LdJda6/+iLR2/cflhhS6tzHv29kJvnW9f
X-Google-Smtp-Source: AGHT+IFgRgSVqto2iAKCurMgWdFKok4Dom4D0MKi4t16Mh0k8vtNn7y/9Tq5jbrHHt7Yrm8j1EENAg==
X-Received: by 2002:a05:6512:3b11:b0:512:e02f:9fa7 with SMTP id 2adb3069b0e04-52bab4ca5d1mr1778236e87.1.1717576577803;
        Wed, 05 Jun 2024 01:36:17 -0700 (PDT)
Received: from kepler.. (1F2EF2F4.nat.pool.telekom.hu. [31.46.242.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b3eaeb69sm611933766b.92.2024.06.05.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:36:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 2/3] x86/fpu: Remove the thread::fpu pointer
Date: Wed,  5 Jun 2024 10:35:56 +0200
Message-ID: <20240605083557.2051480-3-mingo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605083557.2051480-1-mingo@kernel.org>
References: <20240605083557.2051480-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Oleg, remove the thread::fpu pointer, as we can
calculate it via x86_task_fpu() at compile-time.

This improves code generation a bit:

   kepler:~/tip> size vmlinux.before vmlinux.after
   text        data        bss        dec         hex        filename
   26475405    10435342    1740804    38651551    24dc69f    vmlinux.before
   26475339    10959630    1216516    38651485    24dc65d    vmlinux.after

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>

==================>
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/include/asm/processor.h |  5 ++---
 arch/x86/include/asm/vm86.h      |  2 +-
 arch/x86/kernel/fpu/context.h    |  2 +-
 arch/x86/kernel/fpu/core.c       | 30 ++++++++++++++----------------
 arch/x86/kernel/fpu/init.c       |  7 +++----
 arch/x86/kernel/fpu/regset.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/signal.c     | 18 +++++++++---------
 arch/x86/kernel/fpu/xstate.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/xstate.h     |  6 +++---
 arch/x86/kernel/process.c        |  6 ++----
 arch/x86/kernel/signal.c         |  6 +++---
 arch/x86/kernel/traps.c          |  2 +-
 arch/x86/kernel/vmlinux.lds.S    |  4 ++++
 arch/x86/math-emu/fpu_aux.c      |  2 +-
 arch/x86/math-emu/fpu_entry.c    |  4 ++--
 arch/x86/math-emu/fpu_system.h   |  2 +-
 arch/x86/mm/extable.c            |  2 +-
 18 files changed, 71 insertions(+), 73 deletions(-)

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
Link: https://lore.kernel.org/r/ZgaFfyHMOdLHEKm+@gmail.com
---
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/include/asm/processor.h |  5 ++---
 arch/x86/kernel/fpu/context.h    |  2 +-
 arch/x86/kernel/fpu/core.c       | 30 ++++++++++++++----------------
 arch/x86/kernel/fpu/init.c       |  7 +++----
 arch/x86/kernel/fpu/regset.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/signal.c     | 18 +++++++++---------
 arch/x86/kernel/fpu/xstate.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/xstate.h     |  6 +++---
 arch/x86/kernel/process.c        |  6 ++----
 arch/x86/kernel/signal.c         |  6 +++---
 arch/x86/kernel/traps.c          |  2 +-
 arch/x86/kernel/vmlinux.lds.S    |  4 ++++
 arch/x86/math-emu/fpu_aux.c      |  2 +-
 arch/x86/math-emu/fpu_entry.c    |  4 ++--
 arch/x86/math-emu/fpu_system.h   |  2 +-
 arch/x86/mm/extable.c            |  2 +-
 17 files changed, 70 insertions(+), 72 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index 3cf20ab49b5f..1feaa68b7567 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -41,7 +41,7 @@ static inline void switch_fpu_prepare(struct task_struct *old, int cpu)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
 	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
-		struct fpu *old_fpu = old->thread.fpu;
+		struct fpu *old_fpu = x86_task_fpu(old);
 
 		save_fpregs_to_fpstate(old_fpu);
 		/*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 920b0beebd11..249c5fa20de4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -502,11 +502,10 @@ struct thread_struct {
 
 	struct thread_shstk	shstk;
 #endif
-
-	/* Floating point and extended processor state */
-	struct fpu		*fpu;
 };
 
+#define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
+
 /*
  * X86 doesn't need any embedded-FPU-struct quirks:
  */
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index 96d1f34179b3..10d0a720659c 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -53,7 +53,7 @@ static inline void fpregs_activate(struct fpu *fpu)
 /* Internal helper for switch_fpu_return() and signal frame setup */
 static inline void fpregs_restore_userregs(void)
 {
-	struct fpu *fpu = current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 	int cpu = smp_processor_id();
 
 	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_USER_WORKER)))
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 816d48978da4..0ccabcd3bf62 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -204,7 +204,7 @@ static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
 		return;
 
 	spin_lock_irq(&current->sighand->siglock);
-	fpuperm = &current->group_leader->thread.fpu->guest_perm;
+	fpuperm = &x86_task_fpu(current->group_leader)->guest_perm;
 	perm = fpuperm->__state_perm;
 
 	/* First fpstate allocation locks down permissions. */
@@ -316,7 +316,7 @@ EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
  */
 void fpu_sync_guest_vmexit_xfd_state(void)
 {
-	struct fpstate *fps = current->thread.fpu->fpstate;
+	struct fpstate *fps = x86_task_fpu(current)->fpstate;
 
 	lockdep_assert_irqs_disabled();
 	if (fpu_state_size_dynamic()) {
@@ -330,7 +330,7 @@ EXPORT_SYMBOL_GPL(fpu_sync_guest_vmexit_xfd_state);
 int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 {
 	struct fpstate *guest_fps = guest_fpu->fpstate;
-	struct fpu *fpu = current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 	struct fpstate *cur_fps = fpu->fpstate;
 
 	fpregs_lock();
@@ -430,7 +430,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
-		save_fpregs_to_fpstate(current->thread.fpu);
+		save_fpregs_to_fpstate(x86_task_fpu(current));
 	}
 	__cpu_invalidate_fpregs_state();
 
@@ -458,7 +458,7 @@ EXPORT_SYMBOL_GPL(kernel_fpu_end);
  */
 void fpu_sync_fpstate(struct fpu *fpu)
 {
-	WARN_ON_FPU(fpu != current->thread.fpu);
+	WARN_ON_FPU(fpu != x86_task_fpu(current));
 
 	fpregs_lock();
 	trace_x86_fpu_before_save(fpu);
@@ -543,7 +543,7 @@ void fpstate_reset(struct fpu *fpu)
 static inline void fpu_inherit_perms(struct fpu *dst_fpu)
 {
 	if (fpu_state_size_dynamic()) {
-		struct fpu *src_fpu = current->group_leader->thread.fpu;
+		struct fpu *src_fpu = x86_task_fpu(current->group_leader);
 
 		spin_lock_irq(&current->sighand->siglock);
 		/* Fork also inherits the permissions of the parent */
@@ -563,7 +563,7 @@ static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
 	if (!ssp)
 		return 0;
 
-	xstate = get_xsave_addr(&dst->thread.fpu->fpstate->regs.xsave,
+	xstate = get_xsave_addr(&x86_task_fpu(dst)->fpstate->regs.xsave,
 				XFEATURE_CET_USER);
 
 	/*
@@ -591,13 +591,11 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	 * This is safe because task_struct size is a multiple of cacheline size.
 	 */
 	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
-	struct fpu *src_fpu = current->thread.fpu;
+	struct fpu *src_fpu = x86_task_fpu(current);
 
 	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
 	BUG_ON(!src_fpu);
 
-	dst->thread.fpu = dst_fpu;
-
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
 
@@ -678,7 +676,7 @@ void fpu__drop(struct fpu *fpu)
 {
 	preempt_disable();
 
-	if (fpu == current->thread.fpu) {
+	if (fpu == x86_task_fpu(current)) {
 		/* Ignore delayed exceptions from user space */
 		asm volatile("1: fwait\n"
 			     "2:\n"
@@ -712,7 +710,7 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
  */
 static void fpu_reset_fpregs(void)
 {
-	struct fpu *fpu = current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 
 	fpregs_lock();
 	__fpu_invalidate_fpregs_state(fpu);
@@ -741,7 +739,7 @@ static void fpu_reset_fpregs(void)
  */
 void fpu__clear_user_states(struct fpu *fpu)
 {
-	WARN_ON_FPU(fpu != current->thread.fpu);
+	WARN_ON_FPU(fpu != x86_task_fpu(current));
 
 	fpregs_lock();
 	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
@@ -774,7 +772,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 void fpu_flush_thread(void)
 {
-	fpstate_reset(current->thread.fpu);
+	fpstate_reset(x86_task_fpu(current));
 	fpu_reset_fpregs();
 }
 /*
@@ -815,7 +813,7 @@ void fpregs_lock_and_load(void)
  */
 void fpregs_assert_state_consistent(void)
 {
-	struct fpu *fpu = current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		return;
@@ -827,7 +825,7 @@ EXPORT_SYMBOL_GPL(fpregs_assert_state_consistent);
 
 void fpregs_mark_activate(void)
 {
-	struct fpu *fpu = current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 
 	fpregs_activate(fpu);
 	fpu->last_cpu = smp_processor_id();
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index de618ec509aa..11aa31410df2 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		fpstate_init_soft(&current->thread.fpu->fpstate->regs.soft);
+		fpstate_init_soft(&x86_task_fpu(current)->fpstate->regs.soft);
 	else
 #endif
 		asm volatile ("fninit");
@@ -78,7 +78,6 @@ static void __init fpu__init_system_early_generic(void)
 	int this_cpu = smp_processor_id();
 
 	fpstate_reset(&x86_init_fpu);
-	current->thread.fpu = &x86_init_fpu;
 	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
 	x86_init_fpu.last_cpu = this_cpu;
 
@@ -165,7 +164,7 @@ static void __init fpu__init_task_struct_size(void)
 	 * Subtract off the static size of the register state.
 	 * It potentially has a bunch of padding.
 	 */
-	task_size -= sizeof(current->thread.fpu->__fpstate.regs);
+	task_size -= sizeof(x86_task_fpu(current)->__fpstate.regs);
 
 	/*
 	 * Add back the dynamically-calculated register state
@@ -210,7 +209,7 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_kernel_cfg.default_size = size;
 	fpu_user_cfg.max_size = size;
 	fpu_user_cfg.default_size = size;
-	fpstate_reset(current->thread.fpu);
+	fpstate_reset(x86_task_fpu(current));
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 38bc0b390d02..19fd159217f7 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -45,7 +45,7 @@ int regset_xregset_fpregs_active(struct task_struct *target, const struct user_r
  */
 static void sync_fpstate(struct fpu *fpu)
 {
-	if (fpu == current->thread.fpu)
+	if (fpu == x86_task_fpu(current))
 		fpu_sync_fpstate(fpu);
 }
 
@@ -63,7 +63,7 @@ static void fpu_force_restore(struct fpu *fpu)
 	 * Only stopped child tasks can be used to modify the FPU
 	 * state in the fpstate buffer:
 	 */
-	WARN_ON_FPU(fpu == current->thread.fpu);
+	WARN_ON_FPU(fpu == x86_task_fpu(current));
 
 	__fpu_invalidate_fpregs_state(fpu);
 }
@@ -71,7 +71,7 @@ static void fpu_force_restore(struct fpu *fpu)
 int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
-	struct fpu *fpu = target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 
 	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
@@ -91,7 +91,7 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 		unsigned int pos, unsigned int count,
 		const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct fxregs_state newstate;
 	int ret;
 
@@ -133,7 +133,7 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	sync_fpstate(target->thread.fpu);
+	sync_fpstate(x86_task_fpu(target));
 
 	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_XSAVE);
 	return 0;
@@ -143,7 +143,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 		  unsigned int pos, unsigned int count,
 		  const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct xregs_state *tmpbuf = NULL;
 	int ret;
 
@@ -187,7 +187,7 @@ int ssp_active(struct task_struct *target, const struct user_regset *regset)
 int ssp_get(struct task_struct *target, const struct user_regset *regset,
 	    struct membuf to)
 {
-	struct fpu *fpu = target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct cet_user_state *cetregs;
 
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
@@ -213,7 +213,7 @@ int ssp_set(struct task_struct *target, const struct user_regset *regset,
 	    unsigned int pos, unsigned int count,
 	    const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct xregs_state *xsave = &fpu->fpstate->regs.xsave;
 	struct cet_user_state *cetregs;
 	unsigned long user_ssp;
@@ -367,7 +367,7 @@ static void __convert_from_fxsr(struct user_i387_ia32_struct *env,
 void
 convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
 {
-	__convert_from_fxsr(env, tsk, &tsk->thread.fpu->fpstate->regs.fxsave);
+	__convert_from_fxsr(env, tsk, &x86_task_fpu(tsk)->fpstate->regs.fxsave);
 }
 
 void convert_to_fxsr(struct fxregs_state *fxsave,
@@ -400,7 +400,7 @@ void convert_to_fxsr(struct fxregs_state *fxsave,
 int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 	       struct membuf to)
 {
-	struct fpu *fpu = target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct user_i387_ia32_struct env;
 	struct fxregs_state fxsave, *fx;
 
@@ -432,7 +432,7 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	       unsigned int pos, unsigned int count,
 	       const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct user_i387_ia32_struct env;
 	int ret;
 
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 6b262d0b8fc1..b203bf4617fc 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -38,7 +38,7 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	/* Check for the first magic field and other error scenarios. */
 	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
 	    fx_sw->xstate_size < min_xstate_size ||
-	    fx_sw->xstate_size > current->thread.fpu->fpstate->user_size ||
+	    fx_sw->xstate_size > x86_task_fpu(current)->fpstate->user_size ||
 	    fx_sw->xstate_size > fx_sw->extended_size)
 		goto setfx;
 
@@ -54,7 +54,7 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	if (likely(magic2 == FP_XSTATE_MAGIC2))
 		return true;
 setfx:
-	trace_x86_fpu_xstate_check_failed(current->thread.fpu);
+	trace_x86_fpu_xstate_check_failed(x86_task_fpu(current));
 
 	/* Set the parameters for fx only state */
 	fx_sw->magic1 = 0;
@@ -69,13 +69,13 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
 {
 	if (use_fxsr()) {
-		struct xregs_state *xsave = &tsk->thread.fpu->fpstate->regs.xsave;
+		struct xregs_state *xsave = &x86_task_fpu(tsk)->fpstate->regs.xsave;
 		struct user_i387_ia32_struct env;
 		struct _fpstate_32 __user *fp = buf;
 
 		fpregs_lock();
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-			fxsave(&tsk->thread.fpu->fpstate->regs.fxsave);
+			fxsave(&x86_task_fpu(tsk)->fpstate->regs.fxsave);
 		fpregs_unlock();
 
 		convert_from_fxsr(&env, tsk);
@@ -188,7 +188,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
 	struct task_struct *tsk = current;
-	struct fpstate *fpstate = tsk->thread.fpu->fpstate;
+	struct fpstate *fpstate = x86_task_fpu(tsk)->fpstate;
 	bool ia32_fxstate = (buf != buf_fx);
 	int ret;
 
@@ -276,7 +276,7 @@ static int __restore_fpregs_from_user(void __user *buf, u64 ufeatures,
  */
 static bool restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
-	struct fpu *fpu = current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 	int ret;
 
 	/* Restore enabled features only. */
@@ -336,7 +336,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			      bool ia32_fxstate)
 {
 	struct task_struct *tsk = current;
-	struct fpu *fpu = tsk->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(tsk);
 	struct user_i387_ia32_struct env;
 	bool success, fx_only = false;
 	union fpregs_state *fpregs;
@@ -456,7 +456,7 @@ static inline unsigned int xstate_sigframe_size(struct fpstate *fpstate)
  */
 bool fpu__restore_sig(void __user *buf, int ia32_frame)
 {
-	struct fpu *fpu = current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 	void __user *buf_fx = buf;
 	bool ia32_fxstate = false;
 	bool success = false;
@@ -503,7 +503,7 @@ unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size)
 {
-	unsigned long frame_size = xstate_sigframe_size(current->thread.fpu->fpstate);
+	unsigned long frame_size = xstate_sigframe_size(x86_task_fpu(current)->fpstate);
 
 	*buf_fx = sp = round_down(sp - frame_size, 64);
 	if (ia32_frame && use_fxsr()) {
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1d1f6599731b..90b11671e943 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -735,7 +735,7 @@ static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 	 */
 	init_fpstate.xfd = 0;
 
-	fpstate_reset(current->thread.fpu);
+	fpstate_reset(x86_task_fpu(current));
 }
 
 /*
@@ -845,7 +845,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 
 	/* Reset the state for the current task */
-	fpstate_reset(current->thread.fpu);
+	fpstate_reset(x86_task_fpu(current));
 
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
@@ -919,7 +919,7 @@ void fpu__resume_cpu(void)
 	}
 
 	if (fpu_state_size_dynamic())
-		wrmsrl(MSR_IA32_XFD, current->thread.fpu->fpstate->xfd);
+		wrmsrl(MSR_IA32_XFD, x86_task_fpu(current)->fpstate->xfd);
 }
 
 /*
@@ -1188,8 +1188,8 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			     enum xstate_copy_mode copy_mode)
 {
-	__copy_xstate_to_uabi_buf(to, tsk->thread.fpu->fpstate,
-				  tsk->thread.fpu->fpstate->user_xfeatures,
+	__copy_xstate_to_uabi_buf(to, x86_task_fpu(tsk)->fpstate,
+				  x86_task_fpu(tsk)->fpstate->user_xfeatures,
 				  tsk->thread.pkru, copy_mode);
 }
 
@@ -1329,7 +1329,7 @@ int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u
 int copy_sigframe_from_user_to_xstate(struct task_struct *tsk,
 				      const void __user *ubuf)
 {
-	return copy_uabi_to_xstate(tsk->thread.fpu->fpstate, NULL, ubuf, &tsk->thread.pkru);
+	return copy_uabi_to_xstate(x86_task_fpu(tsk)->fpstate, NULL, ubuf, &tsk->thread.pkru);
 }
 
 static bool validate_independent_components(u64 mask)
@@ -1423,7 +1423,7 @@ static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
 	  * The XFD MSR does not match fpstate->xfd. That's invalid when
 	  * the passed in fpstate is current's fpstate.
 	  */
-	if (fpstate->xfd == current->thread.fpu->fpstate->xfd)
+	if (fpstate->xfd == x86_task_fpu(current)->fpstate->xfd)
 		return false;
 
 	/*
@@ -1500,7 +1500,7 @@ void fpstate_free(struct fpu *fpu)
 static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 			   unsigned int usize, struct fpu_guest *guest_fpu)
 {
-	struct fpu *fpu = current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 	struct fpstate *curfps, *newfps = NULL;
 	unsigned int fpsize;
 	bool in_use;
@@ -1593,7 +1593,7 @@ static int __xstate_request_perm(u64 permitted, u64 requested, bool guest)
 	 * AVX512.
 	 */
 	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
-	struct fpu *fpu = current->group_leader->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current->group_leader);
 	struct fpu_state_perm *perm;
 	unsigned int ksize, usize;
 	u64 mask;
@@ -1696,7 +1696,7 @@ int __xfd_enable_feature(u64 xfd_err, struct fpu_guest *guest_fpu)
 		return -EPERM;
 	}
 
-	fpu = current->group_leader->thread.fpu;
+	fpu = x86_task_fpu(current->group_leader);
 	perm = guest_fpu ? &fpu->guest_perm : &fpu->perm;
 	ksize = perm->__state_size;
 	usize = perm->__user_state_size;
@@ -1801,7 +1801,7 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
  */
 static void avx512_status(struct seq_file *m, struct task_struct *task)
 {
-	unsigned long timestamp = READ_ONCE(task->thread.fpu->avx512_timestamp);
+	unsigned long timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
 	long delta;
 
 	if (!timestamp) {
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 1c720c376a69..391fa3c69e5e 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -22,7 +22,7 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 
 static inline u64 xstate_get_group_perm(bool guest)
 {
-	struct fpu *fpu = current->group_leader->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current->group_leader);
 	struct fpu_state_perm *perm;
 
 	/* Pairs with WRITE_ONCE() in xstate_request_perm() */
@@ -265,7 +265,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 	 * internally, e.g. PKRU. That's user space ABI and also required
 	 * to allow the signal handler to modify PKRU.
 	 */
-	struct fpstate *fpstate = current->thread.fpu->fpstate;
+	struct fpstate *fpstate = x86_task_fpu(current)->fpstate;
 	u64 mask = fpstate->user_xfeatures;
 	u32 lmask;
 	u32 hmask;
@@ -296,7 +296,7 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64
 	u32 hmask = mask >> 32;
 	int err;
 
-	xfd_validate_state(current->thread.fpu->fpstate, mask, true);
+	xfd_validate_state(x86_task_fpu(current)->fpstate, mask, true);
 
 	stac();
 	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5f3f48713870..4184c085627e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -96,8 +96,6 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
-	/* Drop the copied pointer to current's fpstate */
-	dst->thread.fpu = NULL;
 
 	return 0;
 }
@@ -106,7 +104,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	if (fpu_state_size_dynamic())
-		fpstate_free(tsk->thread.fpu);
+		fpstate_free(x86_task_fpu(tsk));
 }
 #endif
 
@@ -116,7 +114,7 @@ void arch_release_task_struct(struct task_struct *tsk)
 void exit_thread(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
-	struct fpu *fpu = t->fpu;
+	struct fpu *fpu = x86_task_fpu(tsk);
 
 	if (test_thread_flag(TIF_IO_BITMAP))
 		io_bitmap_exit(tsk);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 7e709ae8e99a..d7906f5979a4 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -228,7 +228,7 @@ static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	bool stepping, failed;
-	struct fpu *fpu = current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 
 	if (v8086_mode(regs))
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
@@ -396,14 +396,14 @@ bool sigaltstack_size_valid(size_t ss_size)
 	if (!fpu_state_size_dynamic() && !strict_sigaltstack_size)
 		return true;
 
-	fsize += current->group_leader->thread.fpu->perm.__user_state_size;
+	fsize += x86_task_fpu(current->group_leader)->perm.__user_state_size;
 	if (likely(ss_size > fsize))
 		return true;
 
 	if (strict_sigaltstack_size)
 		return ss_size > fsize;
 
-	mask = current->group_leader->thread.fpu->perm.__state_perm;
+	mask = x86_task_fpu(current->group_leader)->perm.__state_perm;
 	if (mask & XFEATURE_MASK_USER_DYNAMIC)
 		return ss_size > fsize;
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c79e36c4071b..b19fb494c57c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1148,7 +1148,7 @@ DEFINE_IDTENTRY_RAW(exc_debug)
 static void math_error(struct pt_regs *regs, int trapnr)
 {
 	struct task_struct *task = current;
-	struct fpu *fpu = task->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(task);
 	int si_code;
 	char *str = (trapnr == X86_TRAP_MF) ? "fpu exception" :
 						"simd exception";
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3509afc6a672..226244a894da 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -170,6 +170,10 @@ SECTIONS
 		/* equivalent to task_pt_regs(&init_task) */
 		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
 
+		__x86_init_fpu_begin = .;
+		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
+		__x86_init_fpu_end = .;
+
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
 		NOSAVE_DATA
diff --git a/arch/x86/math-emu/fpu_aux.c b/arch/x86/math-emu/fpu_aux.c
index 8087953164fc..5f253ae406b6 100644
--- a/arch/x86/math-emu/fpu_aux.c
+++ b/arch/x86/math-emu/fpu_aux.c
@@ -53,7 +53,7 @@ void fpstate_init_soft(struct swregs_state *soft)
 
 void finit(void)
 {
-	fpstate_init_soft(&current->thread.fpu->fpstate->regs.soft);
+	fpstate_init_soft(&x86_task_fpu(current)->fpstate->regs.soft);
 }
 
 /*
diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index 30400d95d9d0..5034df617740 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -641,7 +641,7 @@ int fpregs_soft_set(struct task_struct *target,
 		    unsigned int pos, unsigned int count,
 		    const void *kbuf, const void __user *ubuf)
 {
-	struct swregs_state *s387 = &target->thread.fpu->fpstate->regs.soft;
+	struct swregs_state *s387 = &x86_task_fpu(target)->fpstate->regs.soft;
 	void *space = s387->st_space;
 	int ret;
 	int offset, other, i, tags, regnr, tag, newtop;
@@ -692,7 +692,7 @@ int fpregs_soft_get(struct task_struct *target,
 		    const struct user_regset *regset,
 		    struct membuf to)
 {
-	struct swregs_state *s387 = &target->thread.fpu->fpstate->regs.soft;
+	struct swregs_state *s387 = &x86_task_fpu(target)->fpstate->regs.soft;
 	const void *space = s387->st_space;
 	int offset = (S387->ftop & 7) * 10, other = 80 - offset;
 
diff --git a/arch/x86/math-emu/fpu_system.h b/arch/x86/math-emu/fpu_system.h
index 3417337e7d99..5e238e930fe3 100644
--- a/arch/x86/math-emu/fpu_system.h
+++ b/arch/x86/math-emu/fpu_system.h
@@ -73,7 +73,7 @@ static inline bool seg_writable(struct desc_struct *d)
 	return (d->type & SEG_TYPE_EXECUTE_MASK) == SEG_TYPE_WRITABLE;
 }
 
-#define I387			(&current->thread.fpu->fpstate->regs)
+#define I387			(&x86_task_fpu(current)->fpstate->regs)
 #define FPU_info		(I387->soft.info)
 
 #define FPU_CS			(*(unsigned short *) &(FPU_info->regs->cs))
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 9400c1c29fc8..1359ad75da3a 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -111,7 +111,7 @@ static bool ex_handler_sgx(const struct exception_table_entry *fixup,
 
 /*
  * Handler for when we fail to restore a task's FPU state.  We should never get
- * here because the FPU state of a task using the FPU (task->thread.fpu->state)
+ * here because the FPU state of a task using the FPU (x86_task_fpu(task)->state)
  * should always be valid.  However, past bugs have allowed userspace to set
  * reserved bits in the XSAVE area using PTRACE_SETREGSET or sys_rt_sigreturn().
  * These caused XRSTOR to fail when switching to the task, leaking the FPU
-- 
2.43.0


