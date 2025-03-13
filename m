Return-Path: <linux-kernel+bounces-560195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D631EA5FF25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61F1189D31C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF561F2BA1;
	Thu, 13 Mar 2025 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glhJFjHC"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496851F0E27
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890171; cv=none; b=FxudQTs41QqnUu5MDj/BBTg79Qyudt9L6aQOxla/4B+VashQfoiEn5mu72QkE4nkfVYNjTFq5eK1NOMMbCLIX9tSkAdeV9fwA9nEVbVoDO4ahMbeayGru5KgH63DDuWcLg/PhkdNb4r+nmJCQp09a57q6SS2Nmc3b+J5s4/15KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890171; c=relaxed/simple;
	bh=Ih/15p3e+YusF5SBfkMrut+LZSUneG59jPziLo5dmRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3Se9KcsxRxYTMyZzehxwkLCn2Xd4a27Xe2fq/vJavlQnIZM/kuygmQEcfdpKzbCmncOiGZ+e6kMng9glb4yqS9z1wwvez14qHT8WFs4hm/tgylN12enRwcdl/K67FmaU7M+aOFHvJzbqNefaojRDjSNRznhZ8hOdDSqqG3NrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glhJFjHC; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ff0c9d1761so12180647b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741890163; x=1742494963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A1kHXEAvFzpWlz21OYBee4KubY/kyVNoRGmvJidEss=;
        b=glhJFjHCuzAVzxT6M9PSVh/lxasWFbwnpKpXEd7Oa7/+iQ4s1/REdFhn45/YGWg113
         D6WGS5M8ND6cYsxhwiFG8t6q98NwVUiLOmH+tJwng3825mM0Bd0QbHblX8t8zaNp2dse
         RhwyCj4HdlgB+rX2Sb2XyzkFsAUxyelTdyPuHN0JAjAk92NCozyxlSEq63xw4vr41UdI
         A48y7BtceUayP6T7M2QRoD6MKq5kiPE98Bb9+TaKJKEh3B6FQ0hTtffApL4cOfwfA8MO
         ziEvIPgKsaLz0C70Kos3taCh0hg0jzcfz/8+vo/h9XctOgUc14ks1PUkFXOZfZ9Y5KOg
         EmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890163; x=1742494963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+A1kHXEAvFzpWlz21OYBee4KubY/kyVNoRGmvJidEss=;
        b=GCMBhiPEaH0TrDEBEOTBYcaFMR7uBBVnODAmhslbu+a9w67ifw9SpQu59cGbl8BzT3
         +8WKRqNa4x+AUQuvfYru3vPUkCUmLBXNh/8ZcLJOlVqv+i4Qm8ZiAmIGjyZ+xllVAesk
         9LOP0EH38ee7QuWZLoATk4CcOc3l/7DDasIL7SziegHNFGj6l/HoXpnoRmnnnlbqKk5T
         HXswTOg3KCPvb0tW5nro5cDXwxnv5S+KrZRG3u4uv3wtB8XQpkla6es2Cb7xBYFmbHlT
         3nJ72G1wKLUJMllNIJO0/HWGaX9EdLGd82y88qKp6bH/n2sQTkN31kS6dft38SsvUs6R
         9CJw==
X-Gm-Message-State: AOJu0Yzs4B89lECRj974H8kL4apwbfGoGcJpInspL5UT4JBBVPQm8BYE
	F+9X0wCA36vwYXz2KoEcWVsYjvnnnn0QoessjFoDLRfDTcSJ21G2inZS
X-Gm-Gg: ASbGncv+EM5sM6jQI2IyntJCs04ns4BhzGkyi1HSrB9hl92VH+FKQbW+33MPxDiEdyf
	+yLtmHWFEW8g8kcH3zo3mkY1YnVhT/NhY0P7FnYjD+Ij7HP9+/NNY9qN4IkY48+jSz+WX+uW7RC
	x1N+vpnNco5X4Wpg9G06ucfj/PBJ2q2jnLN7stwdiYqtCus2bC5CwzVeq/7kKiE+F2xFUiELIre
	Gpso6+oAKU4Axp4ODvN6grqqZ003BKNBzV1qR98BM1lpcCmVwpTvPezPuqC0N0bJ0RfirbB1XV2
	hn+qNy2D0XDQjaerjLIkECPK6A==
X-Google-Smtp-Source: AGHT+IFRlyXzA7o0jrl0P5fDVCba5QQzgZPf1rtm6v9nS3SupVujqQHIg6rTkr8AlnUnb4BoXj3HHQ==
X-Received: by 2002:a05:690c:25c3:b0:6f7:50b7:8fe0 with SMTP id 00721157ae682-6ff41f0c834mr8999407b3.1.1741890161864;
        Thu, 13 Mar 2025 11:22:41 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff3288f0absm4910347b3.54.2025.03.13.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:22:41 -0700 (PDT)
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
Subject: [PATCH 2/5] x86/syscall/32: Move 32-bit syscall dispatch code
Date: Thu, 13 Mar 2025 14:22:33 -0400
Message-ID: <20250313182236.655724-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313182236.655724-1-brgerst@gmail.com>
References: <20250313182236.655724-1-brgerst@gmail.com>
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
 arch/x86/entry/common.c     | 321 ----------------------------------
 arch/x86/entry/syscall_32.c | 336 +++++++++++++++++++++++++++++++++++-
 3 files changed, 336 insertions(+), 323 deletions(-)

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
index 8cc9950d7104..7c286e89fd04 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -1,10 +1,23 @@
-// SPDX-License-Identifier: GPL-2.0
-/* System call table for i386. */
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * 32-bit system call dispatch
+ *
+ * Copyright (c) 2015 Andrew Lutomirski
+ *
+ * Based on asm and ptrace code by many authors.  The code here originated
+ * in ptrace.c and signal.c.
+ */
 
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
@@ -42,3 +55,322 @@ long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
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


