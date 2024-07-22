Return-Path: <linux-kernel+bounces-258749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B4938C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF481F21F38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C516C864;
	Mon, 22 Jul 2024 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="RLi1KN7w"
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8816E88E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641431; cv=none; b=rU6DA3j8mU5ABwJNgE1mK3hW19qPbTLvi+MsLfhAuBUu27dXtnDwz8OKruvtcYtcFvjjSchVrUEszRn5W5WI8fkZ6gxjFOT6iqrxcxrHBzbHYEFeLwjjd/e28YQldJvA/jS/tvhi0luCS9urRaW7b5EKTA5F35b9u22hqwcP5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641431; c=relaxed/simple;
	bh=giN4n+jzmplOf9Ex5NGT7uwj8TAAZeGrZHbapAwQ1vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOmOJuELF1bAr1YbYkJuqeE1WHNo9ceUI1uWCljL0Y7c2ROLbVzFsH3yIBfy2xX1DH4ytFgSEMEz0TE33a6KaKT66cgZXIYKuSChsZqsvi+goHcj/LVxexRymARYxPWgDd11XTBnKkPTAXb57raPDKNFtDV7G3oXgsa7QkwDRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=RLi1KN7w; arc=none smtp.client-ip=85.31.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id 9E2E6335C57
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641426;
	bh=giN4n+jzmplOf9Ex5NGT7uwj8TAAZeGrZHbapAwQ1vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLi1KN7wCc1aE/+FkGL9iZdOOsjnBLoJPM749uy7NhVyK/ybzZQ2EqurOgedCgwa4
	 2RnTq6rNTwh5d24TF7Sfil+x0A8AzbTpar9kC1/yM/m+itCLfD41N247LXqv8+EVoX
	 XjQh93BYHrUQ+iBcMQ6zSP9y2fw4T9gP4L3ulDis=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 3FEF8335F91; Mon, 22 Jul
 2024 11:43:46 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx405.security-mail.net (Postfix) with ESMTPS id 32040335FA9; Mon, 22 Jul
 2024 11:43:44 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 7669240317; Mon, 22 Jul
 2024 11:43:44 +0200 (CEST)
X-Secumail-id: <114b4.669e29d0.b7bf2.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Jules Maselbas <jmaselbas@zdiv.net>
Subject: [RFC PATCH v3 26/37] kvx: Add signal handling support
Date: Mon, 22 Jul 2024 11:41:37 +0200
Message-ID: <20240722094226.21602-27-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add sigcontext definition and signal handling support for kvx.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: Use read_thread_flags() as suggested by Mark Rutland
V2 -> V3:
- Updated to use generic functions (e.g., arch_do_signal_or_restart)
- Remove do_work_pending (now done by generic exit_to_user_mode_loop)
---
 arch/kvx/include/uapi/asm/sigcontext.h |  16 ++
 arch/kvx/kernel/signal.c               | 252 +++++++++++++++++++++++++
 arch/kvx/kernel/vdso.c                 |  87 +++++++++
 3 files changed, 355 insertions(+)
 create mode 100644 arch/kvx/include/uapi/asm/sigcontext.h
 create mode 100644 arch/kvx/kernel/signal.c
 create mode 100644 arch/kvx/kernel/vdso.c

diff --git a/arch/kvx/include/uapi/asm/sigcontext.h b/arch/kvx/include/uapi/asm/sigcontext.h
new file mode 100644
index 0000000000000..a26688fe8571f
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/sigcontext.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _UAPI_ASM_KVX_SIGCONTEXT_H
+#define _UAPI_ASM_KVX_SIGCONTEXT_H
+
+#include <asm/ptrace.h>
+
+struct sigcontext {
+	struct user_regs_struct sc_regs;
+};
+
+#endif	/* _UAPI_ASM_KVX_SIGCONTEXT_H */
diff --git a/arch/kvx/kernel/signal.c b/arch/kvx/kernel/signal.c
new file mode 100644
index 0000000000000..f49c66aef2df6
--- /dev/null
+++ b/arch/kvx/kernel/signal.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/bug.h>
+#include <linux/entry-common.h>
+#include <linux/syscalls.h>
+
+#include <asm/ucontext.h>
+#include <asm/processor.h>
+#include <asm/cacheflush.h>
+#include <asm/syscall.h>
+#include <asm/syscalls.h>
+#include <linux/resume_user_mode.h>
+
+struct rt_sigframe {
+	struct siginfo info;
+	struct ucontext uc;
+};
+
+int __init setup_syscall_sigreturn_page(void *sigpage_addr)
+{
+	unsigned int frame_size = (uintptr_t) &user_scall_rt_sigreturn_end -
+				  (uintptr_t) &user_scall_rt_sigreturn;
+
+	/* Copy the sigreturn scall implementation */
+	memcpy(sigpage_addr, &user_scall_rt_sigreturn, frame_size);
+
+	flush_icache_range((unsigned long) sigpage_addr,
+			   (unsigned long) sigpage_addr + frame_size);
+
+	return 0;
+}
+
+static long restore_sigcontext(struct pt_regs *regs,
+			       struct sigcontext __user *sc)
+{
+	long err;
+
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
+
+	return err;
+}
+
+long sys_rt_sigreturn(void)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_sigframe __user *frame;
+	struct task_struct *task;
+	sigset_t set;
+
+	current->restart_block.fn = do_no_restart_syscall;
+
+	frame = (struct rt_sigframe __user *) user_stack_pointer(regs);
+
+	/*
+	 * Stack is not aligned but should be !
+	 * User probably did some malicious things.
+	 */
+	if (user_stack_pointer(regs) & STACK_ALIGN_MASK)
+		goto badframe;
+
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+
+	/* Restore sigmask */
+	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (restore_sigcontext(regs, &frame->uc.uc_mcontext))
+		goto badframe;
+
+	if (restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->r0;
+
+badframe:
+	task = current;
+	if (show_unhandled_signals) {
+		pr_info_ratelimited(
+			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
+			task->comm, task_pid_nr(task), __func__,
+			frame, (void *) instruction_pointer(regs),
+			(void *) user_stack_pointer(regs));
+	}
+	force_sig(SIGSEGV);
+	return 0;
+}
+
+
+static long setup_sigcontext(struct rt_sigframe __user *frame,
+			     struct pt_regs *regs)
+{
+	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
+	long err;
+
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
+
+	return err;
+}
+
+static inline void __user *get_sigframe(struct ksignal *ksig,
+					struct pt_regs *regs, size_t framesize)
+{
+	unsigned long sp;
+	/* Default to using normal stack */
+	sp = regs->sp;
+
+	/*
+	 * If we are on the alternate signal stack and would overflow it, don't.
+	 * Return an always-bogus address instead so we will die with SIGSEGV.
+	 */
+	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize)))
+		return (void __user __force *)(-1UL);
+
+	/* This is the X/Open sanctioned signal stack switching. */
+	sp = sigsp(sp, ksig) - framesize;
+
+	/* Align the stack frame on 16bytes */
+	sp &= ~STACK_ALIGN_MASK;
+
+	return (void __user *)sp;
+}
+
+/* TODO: Use VDSO when ready ! */
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
+{
+	unsigned long sigpage = current->mm->context.sigpage;
+	struct rt_sigframe __user *frame;
+	long err = 0;
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
+	if (!access_ok(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
+
+	/* Create the ucontext. */
+	err |= __put_user(0, &frame->uc.uc_flags);
+	err |= __put_user(NULL, &frame->uc.uc_link);
+	err |= __save_altstack(&frame->uc.uc_stack, user_stack_pointer(regs));
+	err |= setup_sigcontext(frame, regs);
+	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	if (err)
+		return -EFAULT;
+
+	/*
+	 * When returning from the handler, we want to jump to the
+	 * sigpage which will execute the sigreturn scall.
+	 */
+	regs->ra = sigpage;
+	/* Return to signal handler */
+	regs->spc = (unsigned long)ksig->ka.sa.sa_handler;
+	regs->sp = (unsigned long) frame;
+
+	/* Parameters for signal handler */
+	regs->r0 = ksig->sig;                     /* r0: signal number */
+	regs->r1 = (unsigned long)(&frame->info); /* r1: siginfo pointer */
+	regs->r2 = (unsigned long)(&frame->uc);   /* r2: ucontext pointer */
+
+	return 0;
+}
+
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
+{
+	bool stepping;
+	sigset_t *oldset = sigmask_to_save();
+	int ret;
+
+	/* Are we in a system call? */
+	if (in_syscall(regs)) {
+		/* If so, check system call restarting.. */
+		switch (regs->r0) {
+		case -ERESTART_RESTARTBLOCK:
+		case -ERESTARTNOHAND:
+			regs->r0 = -EINTR;
+			break;
+		case -ERESTARTSYS:
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
+				regs->r0 = -EINTR;
+				break;
+			}
+			fallthrough;
+		case -ERESTARTNOINTR:
+			regs->r0 = regs->orig_r0;
+			regs->spc -= 0x4;
+			break;
+		}
+	}
+
+	/*
+	 * If TF is set due to a debugger (TIF_FORCED_TF), clear TF now
+	 * so that register information in the sigcontext is correct and
+	 * then notify the tracer before entering the signal handler.
+	 */
+	stepping = test_thread_flag(TIF_SINGLESTEP);
+	if (stepping)
+		user_disable_single_step(current);
+
+	ret = setup_rt_frame(ksig, oldset, regs);
+
+	signal_setup_done(ret, ksig, stepping);
+}
+
+void arch_do_signal_or_restart(struct pt_regs *regs)
+{
+	struct ksignal ksig;
+
+	if (get_signal(&ksig)) {
+		handle_signal(&ksig, regs);
+		return;
+	}
+
+	/* Did we come from a system call? */
+	if (in_syscall(regs)) {
+		/*
+		 * If we are here, this means there is no handler
+		 * present and we must restart the syscall.
+		 */
+		switch (regs->r0) {
+		case -ERESTART_RESTARTBLOCK:
+			/* Modify the syscall number in order to restart it */
+			regs->r6 = __NR_restart_syscall;
+			fallthrough;
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
+			/* We are restarting the syscall */
+			regs->r0 = regs->orig_r0;
+			/*
+			 * scall instruction isn't bundled with anything else,
+			 * so we can just revert the spc to restart the syscall.
+			 */
+			regs->spc -= 0x4;
+			break;
+		}
+	}
+
+	/*
+	 * If there's no signal to deliver, we just put the saved sigmask
+	 * back.
+	 */
+	restore_saved_sigmask();
+}
diff --git a/arch/kvx/kernel/vdso.c b/arch/kvx/kernel/vdso.c
new file mode 100644
index 0000000000000..1515de15eb31b
--- /dev/null
+++ b/arch/kvx/kernel/vdso.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/binfmts.h>
+
+#include <asm/syscall.h>
+
+static struct page *signal_page;
+
+static int __init init_sigreturn(void)
+{
+	struct page *sigpage;
+	void *mapped_sigpage;
+	int err;
+
+	sigpage = alloc_page(GFP_KERNEL);
+	if (!sigpage)
+		panic("Cannot allocate sigreturn page");
+
+	mapped_sigpage = vmap(&sigpage, 1, 0, PAGE_KERNEL);
+	if (!mapped_sigpage)
+		panic("Cannot map sigreturn page");
+
+	clear_page(mapped_sigpage);
+
+	err = setup_syscall_sigreturn_page(mapped_sigpage);
+	if (err)
+		panic("Cannot set signal return syscall, err: %x.", err);
+
+	vunmap(mapped_sigpage);
+
+	signal_page = sigpage;
+
+	return 0;
+}
+arch_initcall(init_sigreturn);
+
+static int sigpage_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	current->mm->context.sigpage = new_vma->vm_start;
+	return 0;
+}
+
+static const struct vm_special_mapping sigpage_mapping = {
+	.name = "[sigpage]",
+	.pages = &signal_page,
+	.mremap = sigpage_mremap,
+};
+
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	int ret = 0;
+	unsigned long addr;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	mmap_write_lock(mm);
+
+	addr = get_unmapped_area(NULL, STACK_TOP, PAGE_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		ret = addr;
+		goto up_fail;
+	}
+
+	vma = _install_special_mapping(
+			mm,
+			addr,
+			PAGE_SIZE,
+			VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
+			&sigpage_mapping);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto up_fail;
+	}
+
+	mm->context.sigpage = addr;
+
+up_fail:
+	mmap_write_unlock(mm);
+	return ret;
+}
-- 
2.45.2






