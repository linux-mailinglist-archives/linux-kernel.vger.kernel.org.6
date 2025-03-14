Return-Path: <linux-kernel+bounces-561655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B658A61492
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AE546217E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B43202990;
	Fri, 14 Mar 2025 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF5zAUUl"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08F20127A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965158; cv=none; b=UrolzQ4fEapBXiv3PMkfKjVp+LVzB6memfiR9j67HzAsPGcuT1a3ey10L0fz8YuWxZl74+B2ZcIrdDrJnlXBl0dQzTMDWc4Dtkyjokt9Sr2IBE6f5OvtqZv6xB8dcTDP7IMem0z2jgMW0ubHsjZ5D3v1bFXwX8oa3JGI52uVHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965158; c=relaxed/simple;
	bh=pm9T5B4sdsYjPRdVC+F1Byq9w2I4k0t06pELg2M6ip8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADc3S4tXNIWAGNlrXZX22Jne9x1ftkezVGQhgPtXLXg45Vi5SEemn9+6ajYAk4U2GVnj63a/XvUiZ0CTwaIneAovLgjvy32AOP+dKWyjL3SVU8GlhckpTq057OOq7XdAuu+8X2Fujq6L8F2LaeGTqOUMdHi3dGWdvJrTGtvXY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BF5zAUUl; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c68fd223bcso248384fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965155; x=1742569955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0FTY0BX5cM6RJWpvhp9iEYhwAETiRxOOx2Wrv6MeBw=;
        b=BF5zAUUlo026yAX+G/uOoQSQuwzH9SbyqAdVI/tBHShKSFV52KeEzfz2O5FIHY72gJ
         6QbPeRZfeKTxd0WTpUc3LW7RG2eI/tLFZU3N+ENhPL2MOUO6o4wBARH23cSqXTyWZ8qJ
         2KKONNL2YishaPs7niXA+25o41O+wz1aLj4RHLVvsOecADpFcHi2As2Xk1cmDjowvdeP
         Uva7FRBjIfzfmFO2dEhmHyolrvbph4SIQdSf6LL0Gt03dOac7tidtGSdThibL9Kjr+Hd
         n4OUfTSH0gcwz+PKgwDLDobsgD5ru1imrirLLy84Mw0O+DYjdcHRa/6bG5QS5WIKeeEE
         1dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965155; x=1742569955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0FTY0BX5cM6RJWpvhp9iEYhwAETiRxOOx2Wrv6MeBw=;
        b=FiFeHYuRRPNPwGjilo/7P0S1uXOhY2QTOc1YTF3kbEk2aCA26Bly0NLVz24C3cSe6L
         2oYnCXG2U5xfOY8oWi18zGLxhlBB9HKr5Aoxn5RikRlJFyugUan7BCay6wlm6XvlAQe4
         xcCszJCMZDC2A5PxVigwNMwRB1b730OYPltzBCdx8fUa6rYxHNPsvAkqcC9uwtwz70c8
         9MzqGoa/eltnRgS53GlagQwsYQ3w4J9U2z1s2h9jtee3VDrFD6ib9KN1QkqWLstQB/aE
         PzmO2KDZbsYMqrtgRSwC7+2v8WUngsn3lvA8qKvIUS4NFrftnhDtNUexxcWryAuXKGtH
         ib1w==
X-Gm-Message-State: AOJu0Yy1mPZOoT9Na5ollHs+WlOV1w+/IquUzjSBqBY4F9Jw64QGknxa
	LZBrCZ5638CC/gxDuKqBjginrRmrcbC2tyRroe6ao04G9iw1I6iL+KuH
X-Gm-Gg: ASbGncvQe8pvk3Gae7zAccw0/5VznYNCdSZXFZQgDqxFgTjze5mMHd8lJJ75fT1cYOM
	SUqyw9fgY5HRkSAk7rJYzky6F0lGOKMwE2J8NJbre1bid4R7+8r6cEaIMuDndPInosbpoh1vlcb
	WmznAE8lRZigXIbWMrSxMpX+KApZawwDyo1hvW/lxBrEsm8kpdHsjC+Q/vSsEQdyKowIJ0oquTY
	BImjzw3e45yu1rONpBqMMGoqi1EJkFnS8Ylq+xkmhhbyNfNgBg/UhadnHttlG7cy38+FbtNnEKX
	zZE5n5sgTGMeZCzF0eqrJ7Rixg==
X-Google-Smtp-Source: AGHT+IGbJpju3ed7ZV+RQOwJv2DqAbgUJcqJmkXxx9PxT2C5IaC/lyw0dVBbvmSvQuqzwap+wAPx3g==
X-Received: by 2002:a05:6870:20f:b0:2c2:4d76:f1a7 with SMTP id 586e51a60fabf-2c69114dcc0mr1412080fac.25.1741965154341;
        Fri, 14 Mar 2025 08:12:34 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6710f21efsm883026fac.30.2025.03.14.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:12:32 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 2/7] x86/syscall/32: Move 32-bit syscall dispatch code
Date: Fri, 14 Mar 2025 11:12:15 -0400
Message-ID: <20250314151220.862768-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314151220.862768-1-brgerst@gmail.com>
References: <20250314151220.862768-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the 32-bit syscall dispatch code to syscall_32.c.

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/Makefile     |   2 +
 arch/x86/entry/common.c     | 321 -----------------------------------
 arch/x86/entry/syscall_32.c | 329 +++++++++++++++++++++++++++++++++++-
 3 files changed, 329 insertions(+), 323 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index ce1cc1622385..96a6b86e0a8b 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -8,8 +8,10 @@ UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
+CFLAGS_syscall_32.o		+= -fno-stack-protector
 
 obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ce4d88eda693..183efabefe57 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -125,327 +125,6 @@ __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 }
 #endif
 
-#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
-static __always_inline int syscall_32_enter(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_IA32_EMULATION))
-		current_thread_info()->status |= TS_COMPAT;
-
-	return (int)regs->orig_ax;
-}
-
-#ifdef CONFIG_IA32_EMULATION
-bool __ia32_enabled __ro_after_init = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
-
-static int __init ia32_emulation_override_cmdline(char *arg)
-{
-	return kstrtobool(arg, &__ia32_enabled);
-}
-early_param("ia32_emulation", ia32_emulation_override_cmdline);
-#endif
-
-/*
- * Invoke a 32-bit syscall.  Called with IRQs on in CT_STATE_KERNEL.
- */
-static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
-{
-	/*
-	 * Convert negative numbers to very high and thus out of range
-	 * numbers for comparisons.
-	 */
-	unsigned int unr = nr;
-
-	if (likely(unr < IA32_NR_syscalls)) {
-		unr = array_index_nospec(unr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call(regs, unr);
-	} else if (nr != -1) {
-		regs->ax = __ia32_sys_ni_syscall(regs);
-	}
-}
-
-#ifdef CONFIG_IA32_EMULATION
-static __always_inline bool int80_is_external(void)
-{
-	const unsigned int offs = (0x80 / 32) * 0x10;
-	const u32 bit = BIT(0x80 % 32);
-
-	/* The local APIC on XENPV guests is fake */
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
-		return false;
-
-	/*
-	 * If vector 0x80 is set in the APIC ISR then this is an external
-	 * interrupt. Either from broken hardware or injected by a VMM.
-	 *
-	 * Note: In guest mode this is only valid for secure guests where
-	 * the secure module fully controls the vAPIC exposed to the guest.
-	 */
-	return apic_read(APIC_ISR + offs) & bit;
-}
-
-/**
- * do_int80_emulation - 32-bit legacy syscall C entry from asm
- * @regs: syscall arguments in struct pt_args on the stack.
- *
- * This entry point can be used by 32-bit and 64-bit programs to perform
- * 32-bit system calls.  Instances of INT $0x80 can be found inline in
- * various programs and libraries.  It is also used by the vDSO's
- * __kernel_vsyscall fallback for hardware that doesn't support a faster
- * entry method.  Restarted 32-bit system calls also fall back to INT
- * $0x80 regardless of what instruction was originally used to do the
- * system call.
- *
- * This is considered a slow path.  It is not used by most libc
- * implementations on modern hardware except during process startup.
- *
- * The arguments for the INT $0x80 based syscall are on stack in the
- * pt_regs structure:
- *   eax:				system call number
- *   ebx, ecx, edx, esi, edi, ebp:	arg1 - arg 6
- */
-__visible noinstr void do_int80_emulation(struct pt_regs *regs)
-{
-	int nr;
-
-	/* Kernel does not use INT $0x80! */
-	if (unlikely(!user_mode(regs))) {
-		irqentry_enter(regs);
-		instrumentation_begin();
-		panic("Unexpected external interrupt 0x80\n");
-	}
-
-	/*
-	 * Establish kernel context for instrumentation, including for
-	 * int80_is_external() below which calls into the APIC driver.
-	 * Identical for soft and external interrupts.
-	 */
-	enter_from_user_mode(regs);
-
-	instrumentation_begin();
-	add_random_kstack_offset();
-
-	/* Validate that this is a soft interrupt to the extent possible */
-	if (unlikely(int80_is_external()))
-		panic("Unexpected external interrupt 0x80\n");
-
-	/*
-	 * The low level idtentry code pushed -1 into regs::orig_ax
-	 * and regs::ax contains the syscall number.
-	 *
-	 * User tracing code (ptrace or signal handlers) might assume
-	 * that the regs::orig_ax contains a 32-bit number on invoking
-	 * a 32-bit syscall.
-	 *
-	 * Establish the syscall convention by saving the 32bit truncated
-	 * syscall number in regs::orig_ax and by invalidating regs::ax.
-	 */
-	regs->orig_ax = regs->ax & GENMASK(31, 0);
-	regs->ax = -ENOSYS;
-
-	nr = syscall_32_enter(regs);
-
-	local_irq_enable();
-	nr = syscall_enter_from_user_mode_work(regs, nr);
-	do_syscall_32_irqs_on(regs, nr);
-
-	instrumentation_end();
-	syscall_exit_to_user_mode(regs);
-}
-
-#ifdef CONFIG_X86_FRED
-/*
- * A FRED-specific INT80 handler is warranted for the follwing reasons:
- *
- * 1) As INT instructions and hardware interrupts are separate event
- *    types, FRED does not preclude the use of vector 0x80 for external
- *    interrupts. As a result, the FRED setup code does not reserve
- *    vector 0x80 and calling int80_is_external() is not merely
- *    suboptimal but actively incorrect: it could cause a system call
- *    to be incorrectly ignored.
- *
- * 2) It is called only for handling vector 0x80 of event type
- *    EVENT_TYPE_SWINT and will never be called to handle any external
- *    interrupt (event type EVENT_TYPE_EXTINT).
- *
- * 3) FRED has separate entry flows depending on if the event came from
- *    user space or kernel space, and because the kernel does not use
- *    INT insns, the FRED kernel entry handler fred_entry_from_kernel()
- *    falls through to fred_bad_type() if the event type is
- *    EVENT_TYPE_SWINT, i.e., INT insns. So if the kernel is handling
- *    an INT insn, it can only be from a user level.
- *
- * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY. While FRED will
- *    likely take a different approach if it is ever needed: it
- *    probably belongs in either fred_intx()/ fred_other() or
- *    asm_fred_entrypoint_user(), depending on if this ought to be done
- *    for all entries from userspace or only system
- *    calls.
- *
- * 5) INT $0x80 is the fast path for 32-bit system calls under FRED.
- */
-DEFINE_FREDENTRY_RAW(int80_emulation)
-{
-	int nr;
-
-	enter_from_user_mode(regs);
-
-	instrumentation_begin();
-	add_random_kstack_offset();
-
-	/*
-	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
-	 * syscall number.
-	 *
-	 * User tracing code (ptrace or signal handlers) might assume
-	 * that the regs::orig_ax contains a 32-bit number on invoking
-	 * a 32-bit syscall.
-	 *
-	 * Establish the syscall convention by saving the 32bit truncated
-	 * syscall number in regs::orig_ax and by invalidating regs::ax.
-	 */
-	regs->orig_ax = regs->ax & GENMASK(31, 0);
-	regs->ax = -ENOSYS;
-
-	nr = syscall_32_enter(regs);
-
-	local_irq_enable();
-	nr = syscall_enter_from_user_mode_work(regs, nr);
-	do_syscall_32_irqs_on(regs, nr);
-
-	instrumentation_end();
-	syscall_exit_to_user_mode(regs);
-}
-#endif
-#else /* CONFIG_IA32_EMULATION */
-
-/* Handles int $0x80 on a 32bit kernel */
-__visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
-{
-	int nr = syscall_32_enter(regs);
-
-	add_random_kstack_offset();
-	/*
-	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
-	 * orig_ax, the int return value truncates it. This matches
-	 * the semantics of syscall_get_nr().
-	 */
-	nr = syscall_enter_from_user_mode(regs, nr);
-	instrumentation_begin();
-
-	do_syscall_32_irqs_on(regs, nr);
-
-	instrumentation_end();
-	syscall_exit_to_user_mode(regs);
-}
-#endif /* !CONFIG_IA32_EMULATION */
-
-static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
-{
-	int nr = syscall_32_enter(regs);
-	int res;
-
-	add_random_kstack_offset();
-	/*
-	 * This cannot use syscall_enter_from_user_mode() as it has to
-	 * fetch EBP before invoking any of the syscall entry work
-	 * functions.
-	 */
-	syscall_enter_from_user_mode_prepare(regs);
-
-	instrumentation_begin();
-	/* Fetch EBP from where the vDSO stashed it. */
-	if (IS_ENABLED(CONFIG_X86_64)) {
-		/*
-		 * Micro-optimization: the pointer we're following is
-		 * explicitly 32 bits, so it can't be out of range.
-		 */
-		res = __get_user(*(u32 *)&regs->bp,
-			 (u32 __user __force *)(unsigned long)(u32)regs->sp);
-	} else {
-		res = get_user(*(u32 *)&regs->bp,
-		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
-	}
-
-	if (res) {
-		/* User code screwed up. */
-		regs->ax = -EFAULT;
-
-		local_irq_disable();
-		instrumentation_end();
-		irqentry_exit_to_user_mode(regs);
-		return false;
-	}
-
-	nr = syscall_enter_from_user_mode_work(regs, nr);
-
-	/* Now this is just like a normal syscall. */
-	do_syscall_32_irqs_on(regs, nr);
-
-	instrumentation_end();
-	syscall_exit_to_user_mode(regs);
-	return true;
-}
-
-/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
-__visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
-{
-	/*
-	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
-	 * convention.  Adjust regs so it looks like we entered using int80.
-	 */
-	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
-					vdso_image_32.sym_int80_landing_pad;
-
-	/*
-	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
-	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
-	 * Fix it up.
-	 */
-	regs->ip = landing_pad;
-
-	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
-	if (!__do_fast_syscall_32(regs))
-		return false;
-
-	/*
-	 * Check that the register state is valid for using SYSRETL/SYSEXIT
-	 * to exit to userspace.  Otherwise use the slower but fully capable
-	 * IRET exit path.
-	 */
-
-	/* XEN PV guests always use the IRET path */
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
-		return false;
-
-	/* EIP must point to the VDSO landing pad */
-	if (unlikely(regs->ip != landing_pad))
-		return false;
-
-	/* CS and SS must match the values set in MSR_STAR */
-	if (unlikely(regs->cs != __USER32_CS || regs->ss != __USER_DS))
-		return false;
-
-	/* If the TF, RF, or VM flags are set, use IRET */
-	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)))
-		return false;
-
-	/* Use SYSRETL/SYSEXIT to exit to userspace */
-	return true;
-}
-
-/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
-__visible noinstr bool do_SYSENTER_32(struct pt_regs *regs)
-{
-	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
-	regs->sp = regs->bp;
-
-	/* SYSENTER clobbers EFLAGS.IF.  Assume it was set in usermode. */
-	regs->flags |= X86_EFLAGS_IF;
-
-	return do_fast_syscall_32(regs);
-}
-#endif
-
 SYSCALL_DEFINE0(ni_syscall)
 {
 	return -ENOSYS;
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 8cc9950d7104..06b9df10f2f8 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -1,10 +1,16 @@
-// SPDX-License-Identifier: GPL-2.0
-/* System call table for i386. */
+// SPDX-License-Identifier: GPL-2.0-only
+/* 32-bit system call dispatch */
 
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
+#include <linux/entry-common.h>
+#include <linux/nospec.h>
+#include <linux/uaccess.h>
+#include <asm/apic.h>
+#include <asm/traps.h>
+#include <asm/cpufeature.h>
 #include <asm/syscall.h>
 
 #ifdef CONFIG_IA32_EMULATION
@@ -42,3 +48,322 @@ long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 	default: return __ia32_sys_ni_syscall(regs);
 	}
 };
+
+static __always_inline int syscall_32_enter(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_IA32_EMULATION))
+		current_thread_info()->status |= TS_COMPAT;
+
+	return (int)regs->orig_ax;
+}
+
+#ifdef CONFIG_IA32_EMULATION
+bool __ia32_enabled __ro_after_init = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
+
+static int __init ia32_emulation_override_cmdline(char *arg)
+{
+	return kstrtobool(arg, &__ia32_enabled);
+}
+early_param("ia32_emulation", ia32_emulation_override_cmdline);
+#endif
+
+/*
+ * Invoke a 32-bit syscall.  Called with IRQs on in CT_STATE_KERNEL.
+ */
+static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Convert negative numbers to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int unr = nr;
+
+	if (likely(unr < IA32_NR_syscalls)) {
+		unr = array_index_nospec(unr, IA32_NR_syscalls);
+		regs->ax = ia32_sys_call(regs, unr);
+	} else if (nr != -1) {
+		regs->ax = __ia32_sys_ni_syscall(regs);
+	}
+}
+
+#ifdef CONFIG_IA32_EMULATION
+static __always_inline bool int80_is_external(void)
+{
+	const unsigned int offs = (0x80 / 32) * 0x10;
+	const u32 bit = BIT(0x80 % 32);
+
+	/* The local APIC on XENPV guests is fake */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+
+	/*
+	 * If vector 0x80 is set in the APIC ISR then this is an external
+	 * interrupt. Either from broken hardware or injected by a VMM.
+	 *
+	 * Note: In guest mode this is only valid for secure guests where
+	 * the secure module fully controls the vAPIC exposed to the guest.
+	 */
+	return apic_read(APIC_ISR + offs) & bit;
+}
+
+/**
+ * do_int80_emulation - 32-bit legacy syscall C entry from asm
+ * @regs: syscall arguments in struct pt_args on the stack.
+ *
+ * This entry point can be used by 32-bit and 64-bit programs to perform
+ * 32-bit system calls.  Instances of INT $0x80 can be found inline in
+ * various programs and libraries.  It is also used by the vDSO's
+ * __kernel_vsyscall fallback for hardware that doesn't support a faster
+ * entry method.  Restarted 32-bit system calls also fall back to INT
+ * $0x80 regardless of what instruction was originally used to do the
+ * system call.
+ *
+ * This is considered a slow path.  It is not used by most libc
+ * implementations on modern hardware except during process startup.
+ *
+ * The arguments for the INT $0x80 based syscall are on stack in the
+ * pt_regs structure:
+ *   eax:				system call number
+ *   ebx, ecx, edx, esi, edi, ebp:	arg1 - arg 6
+ */
+__visible noinstr void do_int80_emulation(struct pt_regs *regs)
+{
+	int nr;
+
+	/* Kernel does not use INT $0x80! */
+	if (unlikely(!user_mode(regs))) {
+		irqentry_enter(regs);
+		instrumentation_begin();
+		panic("Unexpected external interrupt 0x80\n");
+	}
+
+	/*
+	 * Establish kernel context for instrumentation, including for
+	 * int80_is_external() below which calls into the APIC driver.
+	 * Identical for soft and external interrupts.
+	 */
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	add_random_kstack_offset();
+
+	/* Validate that this is a soft interrupt to the extent possible */
+	if (unlikely(int80_is_external()))
+		panic("Unexpected external interrupt 0x80\n");
+
+	/*
+	 * The low level idtentry code pushed -1 into regs::orig_ax
+	 * and regs::ax contains the syscall number.
+	 *
+	 * User tracing code (ptrace or signal handlers) might assume
+	 * that the regs::orig_ax contains a 32-bit number on invoking
+	 * a 32-bit syscall.
+	 *
+	 * Establish the syscall convention by saving the 32bit truncated
+	 * syscall number in regs::orig_ax and by invalidating regs::ax.
+	 */
+	regs->orig_ax = regs->ax & GENMASK(31, 0);
+	regs->ax = -ENOSYS;
+
+	nr = syscall_32_enter(regs);
+
+	local_irq_enable();
+	nr = syscall_enter_from_user_mode_work(regs, nr);
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+}
+
+#ifdef CONFIG_X86_FRED
+/*
+ * A FRED-specific INT80 handler is warranted for the follwing reasons:
+ *
+ * 1) As INT instructions and hardware interrupts are separate event
+ *    types, FRED does not preclude the use of vector 0x80 for external
+ *    interrupts. As a result, the FRED setup code does not reserve
+ *    vector 0x80 and calling int80_is_external() is not merely
+ *    suboptimal but actively incorrect: it could cause a system call
+ *    to be incorrectly ignored.
+ *
+ * 2) It is called only for handling vector 0x80 of event type
+ *    EVENT_TYPE_SWINT and will never be called to handle any external
+ *    interrupt (event type EVENT_TYPE_EXTINT).
+ *
+ * 3) FRED has separate entry flows depending on if the event came from
+ *    user space or kernel space, and because the kernel does not use
+ *    INT insns, the FRED kernel entry handler fred_entry_from_kernel()
+ *    falls through to fred_bad_type() if the event type is
+ *    EVENT_TYPE_SWINT, i.e., INT insns. So if the kernel is handling
+ *    an INT insn, it can only be from a user level.
+ *
+ * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY. While FRED will
+ *    likely take a different approach if it is ever needed: it
+ *    probably belongs in either fred_intx()/ fred_other() or
+ *    asm_fred_entrypoint_user(), depending on if this ought to be done
+ *    for all entries from userspace or only system
+ *    calls.
+ *
+ * 5) INT $0x80 is the fast path for 32-bit system calls under FRED.
+ */
+DEFINE_FREDENTRY_RAW(int80_emulation)
+{
+	int nr;
+
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	add_random_kstack_offset();
+
+	/*
+	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
+	 * syscall number.
+	 *
+	 * User tracing code (ptrace or signal handlers) might assume
+	 * that the regs::orig_ax contains a 32-bit number on invoking
+	 * a 32-bit syscall.
+	 *
+	 * Establish the syscall convention by saving the 32bit truncated
+	 * syscall number in regs::orig_ax and by invalidating regs::ax.
+	 */
+	regs->orig_ax = regs->ax & GENMASK(31, 0);
+	regs->ax = -ENOSYS;
+
+	nr = syscall_32_enter(regs);
+
+	local_irq_enable();
+	nr = syscall_enter_from_user_mode_work(regs, nr);
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+}
+#endif
+#else /* CONFIG_IA32_EMULATION */
+
+/* Handles int $0x80 on a 32bit kernel */
+__visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
+{
+	int nr = syscall_32_enter(regs);
+
+	add_random_kstack_offset();
+	/*
+	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
+	 * orig_ax, the int return value truncates it. This matches
+	 * the semantics of syscall_get_nr().
+	 */
+	nr = syscall_enter_from_user_mode(regs, nr);
+	instrumentation_begin();
+
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+}
+#endif /* !CONFIG_IA32_EMULATION */
+
+static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
+{
+	int nr = syscall_32_enter(regs);
+	int res;
+
+	add_random_kstack_offset();
+	/*
+	 * This cannot use syscall_enter_from_user_mode() as it has to
+	 * fetch EBP before invoking any of the syscall entry work
+	 * functions.
+	 */
+	syscall_enter_from_user_mode_prepare(regs);
+
+	instrumentation_begin();
+	/* Fetch EBP from where the vDSO stashed it. */
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/*
+		 * Micro-optimization: the pointer we're following is
+		 * explicitly 32 bits, so it can't be out of range.
+		 */
+		res = __get_user(*(u32 *)&regs->bp,
+			 (u32 __user __force *)(unsigned long)(u32)regs->sp);
+	} else {
+		res = get_user(*(u32 *)&regs->bp,
+		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
+	}
+
+	if (res) {
+		/* User code screwed up. */
+		regs->ax = -EFAULT;
+
+		local_irq_disable();
+		instrumentation_end();
+		irqentry_exit_to_user_mode(regs);
+		return false;
+	}
+
+	nr = syscall_enter_from_user_mode_work(regs, nr);
+
+	/* Now this is just like a normal syscall. */
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+	return true;
+}
+
+/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
+__visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
+{
+	/*
+	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
+	 * convention.  Adjust regs so it looks like we entered using int80.
+	 */
+	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
+					vdso_image_32.sym_int80_landing_pad;
+
+	/*
+	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
+	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
+	 * Fix it up.
+	 */
+	regs->ip = landing_pad;
+
+	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
+	if (!__do_fast_syscall_32(regs))
+		return false;
+
+	/*
+	 * Check that the register state is valid for using SYSRETL/SYSEXIT
+	 * to exit to userspace.  Otherwise use the slower but fully capable
+	 * IRET exit path.
+	 */
+
+	/* XEN PV guests always use the IRET path */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+
+	/* EIP must point to the VDSO landing pad */
+	if (unlikely(regs->ip != landing_pad))
+		return false;
+
+	/* CS and SS must match the values set in MSR_STAR */
+	if (unlikely(regs->cs != __USER32_CS || regs->ss != __USER_DS))
+		return false;
+
+	/* If the TF, RF, or VM flags are set, use IRET */
+	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)))
+		return false;
+
+	/* Use SYSRETL/SYSEXIT to exit to userspace */
+	return true;
+}
+
+/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
+__visible noinstr bool do_SYSENTER_32(struct pt_regs *regs)
+{
+	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
+	regs->sp = regs->bp;
+
+	/* SYSENTER clobbers EFLAGS.IF.  Assume it was set in usermode. */
+	regs->flags |= X86_EFLAGS_IF;
+
+	return do_fast_syscall_32(regs);
+}
-- 
2.48.1


