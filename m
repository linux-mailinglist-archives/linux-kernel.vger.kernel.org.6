Return-Path: <linux-kernel+bounces-362077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFA299B099
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD02A2848BE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA94126C1D;
	Sat, 12 Oct 2024 04:01:02 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6C126C08
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705662; cv=none; b=KJLeCM5ocUfao7vFc7fEHBpgZN7QDK3mjTsT6uVUWY+R1ejO+IbAbw2SdIKeO+QUSK1M8fbKZmc0n1/sdiU+CMQM0VZocxvr7g3iDaR2dH8gsZ+KM5GdNalpSGWZ0pLzIKFyMOicmlXuAIUiNNFs950DBOLbUTIIpEVaoWKOsxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705662; c=relaxed/simple;
	bh=RV6thIRGF/tL1z2uHfbLRISz14cNo8bKEFbkYtUlqUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBfNul8WoJTugt6y4ycxZeDyXXwKXwP4SvNxOfzPe37vaQOzgNDfseS2nPeBYaCt8ap4UlIi+nypF8ymSsoYZcEzYOgAAXINWoBbgXGxQNZpZMInGP84LDtr8pfXpF5LDrD/Owg0EUr53tuzZUEGcLA7hLiAk9U44dW31q/q17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz3t1728705575tbh0my9
X-QQ-Originating-IP: evgYxnrRA2WGchSnnVqidAQmo6I3OZGYQ4vQkF864E0=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 12 Oct 2024 11:59:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10512866763440344402
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	jialong.yang@shingroup.cn,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH 1/7] powerpc/entry: convert to common and generic entry
Date: Sat, 12 Oct 2024 11:56:15 +0800
Message-ID: <88E2581B1D024E9A+20241012035621.1245-3-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MWsoaJIuuiAXvfnlZfkjgL8PdfQANVHPgRbe2Comh3RuthrH9FeuKqTC
	mOxK/GrGBxrbh+nZS+KXrON8AK6aZvGZ0XAtmnz6Ses9l/nl8/FsXVnbap3O4eL56df9EST
	vmvl5LUCeO2UFbJHFdVzPrflzogks2hUtmwbtoMR7R4/YA3wVC4lHuMEH1ToGtG72wnwy3y
	cb+VJcbqQNgyUE9TH85TsYnYqriufWvQUx0dGNwjDCwjYnNIwEVBi8VJAgg4UZ2HQ5Ud4QT
	BOkLqQoB237pz/kXdkEYudDVZIfWPeOdRe1s6rErrISk4E5pxK2fmsn2dtamYaYPpqoTE7V
	hYXdkaOTsngrJ+T05im2HeN2ZxFGSzZLRWx6GmS5qEM3Ben3uxrlhYNRVID749Bh/dM0pZ5
	VgN/0ExQ5F9bzL77tusqWKjfcIBNcsn2xKNjbIGsQ72w9Ez357KkVPViUaSNBJnJ0K/xw24
	kboJtooMhoi+lXWBnRN8XNnrIbVbty1tBqY9f1HY1hzyO4idWvoCWdKmTy3AjwiIpfl3nRb
	TzwKxIjwU8YGjCvJ8wZnu+KrXaNV8FXOiqjWuPaF4oBSAiFy9ltNmfrxqZAy8CEsuoPQezs
	ehoIOeeu8r5VRn8iqEW1piJKC7ZojDJbuxEW4pRs1dI4rDj4MXLcBIUKMs1RfHait+aY1aM
	L2vcV5FwwEL955J0w3Fx5cpkCYr8K7TpU8xpK95ADs4wWIWDM95lYKAJm0FBM7w6Q04cLOi
	79o0kgS8zM2leZzazZtl533Coe4mWy88LC0+vhlW8qWtqHVvJy0xSucZZQjns57IkpdAFAI
	ARNTnrjlnTRLCpFY+QcjP9f9lBjONEjTfsrVL7CA5sFx85r7ZwByvvO03wQoze0QMJVBHSf
	jvlNgUOG0nqORoeITiOBU7O2hWvfQck8l9fNVrR+vhHlz3HKqYEzSjt08sYI/QFnkTSoKoL
	Eh+cREpOrfHP7Qw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

convert powerpc entry code in syscall and fault to use syscall_work
and irqentry_state as well as common calls implemented in generic
entry infrastructure.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/Kconfig                   | 1 +
 arch/powerpc/include/asm/hw_irq.h      | 5 +++++
 arch/powerpc/include/asm/processor.h   | 6 ++++++
 arch/powerpc/include/asm/syscall.h     | 5 +++++
 arch/powerpc/include/asm/thread_info.h | 1 +
 arch/powerpc/kernel/syscall.c          | 5 ++++-
 arch/powerpc/mm/fault.c                | 3 +++
 7 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6f105ee4f3cf..261c9116d6fa 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -202,6 +202,7 @@ config PPC
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP		if PCI
 	select GENERIC_PTDUMP
+        select GENERIC_ENTRY
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 317659fdeacf..a3d591784c95 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -216,6 +216,11 @@ static inline bool arch_irqs_disabled(void)
 	return arch_irqs_disabled_flags(arch_local_save_flags());
 }
 
+/*common entry*/
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
+{
+	return arch_irqs_disabled();
+}
 static inline void set_pmi_irq_pending(void)
 {
 	/*
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index b2c51d337e60..1292282f8b0e 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -383,6 +383,12 @@ int validate_sp(unsigned long sp, struct task_struct *p);
 int validate_sp_size(unsigned long sp, struct task_struct *p,
 		     unsigned long nbytes);
 
+/*for common entry*/
+static __always_inline bool on_thread_stack(void)
+{
+	return validate_sp(current_stack_pointer, current);
+}
+
 /*
  * Prefetch macros.
  */
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 3dd36c5e334a..0e94806c7bfe 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -119,4 +119,9 @@ static inline int syscall_get_arch(struct task_struct *task)
 	else
 		return AUDIT_ARCH_PPC64;
 }
+
+static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	return false;
+}
 #endif	/* _ASM_SYSCALL_H */
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index bf5dde1a4114..9df2bcf28544 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -58,6 +58,7 @@ struct thread_info {
 	unsigned int	cpu;
 #endif
 	unsigned long	local_flags;		/* private flags for thread */
+	unsigned long	syscall_work;
 #ifdef CONFIG_LIVEPATCH_64
 	unsigned long *livepatch_sp;
 #endif
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index 77fedb190c93..e0338bd8d383 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -3,6 +3,7 @@
 #include <linux/compat.h>
 #include <linux/context_tracking.h>
 #include <linux/randomize_kstack.h>
+#include <linux/entry-common.h>
 
 #include <asm/interrupt.h>
 #include <asm/kup.h>
@@ -131,7 +132,7 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 		 * and the test against NR_syscalls will fail and the return
 		 * value to be used is in regs->gpr[3].
 		 */
-		r0 = do_syscall_trace_enter(regs);
+		r0 = syscall_enter_from_user_mode(regs, r0);
 		if (unlikely(r0 >= NR_syscalls))
 			return regs->gpr[3];
 
@@ -184,6 +185,8 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	 * So the resulting 6 or 7 bits of entropy is seen in SP[9:4] or SP[9:3].
 	 */
 	choose_random_kstack_offset(mftb());
+	/*common entry*/
+	syscall_exit_to_user_mode(regs);
 
 	return ret;
 }
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 9e49ede2bc1c..6cb923fe4c4d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -23,6 +23,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/entry-common.h>
 #include <linux/highmem.h>
 #include <linux/extable.h>
 #include <linux/kprobes.h>
@@ -577,7 +578,9 @@ static __always_inline void __do_page_fault(struct pt_regs *regs)
 
 DEFINE_INTERRUPT_HANDLER(do_page_fault)
 {
+	irqentry_state_t state = irqentry_enter(regs);
 	__do_page_fault(regs);
+	irqentry_exit(regs, state);
 }
 
 #ifdef CONFIG_PPC_BOOK3S_64
-- 
2.42.0.windows.2


