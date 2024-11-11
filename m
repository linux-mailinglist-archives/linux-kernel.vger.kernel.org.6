Return-Path: <linux-kernel+bounces-403536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068B59C36F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D2BB212BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1A11494C3;
	Mon, 11 Nov 2024 03:22:53 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C072595
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731295372; cv=none; b=Nw8oGOGnv4bMWImCfQiyK7sdJvIuQ1TsetrkvgaTa1zpMGFTB7eJJH/s3OqU7nRUkZIDt66BAv5ol5LMLZbHsRmr2q9bRNU0sncDMiKtEVP5YyH9gXB/csqU5ruus+4dEFas64KpVR6I4WeYj6NqSbRYWOIvnPxp1V4KApSwYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731295372; c=relaxed/simple;
	bh=rKROmmDoSOObRig7ZH4oIvpqzZR23pDY8BRvxFH7zAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOH+44BauoAl0LB+qJh4IDCAZ3p0iDshaGGXdEfKLMHboglL8JB6wrtwmWNxYn3vHogMX5qiDfLu8eq1XdRZZ1grOQewXfHtLBspFo7+5wwzcAtrL7zfIwQN65nwCeEowj0A5p7tPxMjxTyMPquunGA288GG34PeF5778IlEdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz5t1731295266thwmuwl
X-QQ-Originating-IP: Q2y7X3cnjFZOhjfAcpkHrhgyw0X7/r3GqnDyvzLJO1M=
Received: from HX09040029.powercore.com.cn ( [116.233.136.127])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 11:21:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11046684575156124262
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH v2 1/8] powerpc/entry: convert to common and generic entry
Date: Mon, 11 Nov 2024 11:19:26 +0800
Message-ID: <F0AE0A4571CE3126+20241111031934.1579-2-luming.yu@shingroup.cn>
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
X-QQ-XMAILINFO: NOnalZjVTVf0PdX+TiWwR5wGXQfDdiUaDSO3CqQsmaX3kcJPiR2QwaG8
	pVWp7gE3muz6RH37o3sE6VMEYGGAozv/mMzvT5Hcy+3uNUpVY2lHfGLVogPySlU4igZzOZr
	1g2clOaNceUnaUnk7A42baYn/o7x3GHv6vy0AbXPVyooHef5/AQRaKc/+ul4zh4izmWKwJY
	e8LQzDXFI3716Tsfo4G4zR+s/iQd13LGMpuqeEdGaC8WE3mLGt5Xg0ujs/4ObSqsPe2U0L6
	sV2gzWtcIXa8Br2Uy+OPtfYGLaZKwyE0oiBIv0ljQiPr+qGq/4jzGnT1JajeinUCjescykA
	/j1nhLRnfpk/I0Hm7R7U2g0gRPJr+m7kq2hhxuo2LTtznbKWX3PgK9aW2HO7WRxMhvMCpwi
	Xu6HG/Rnku2dDjsi4XHQNP/3Zj9hLrzV6wMhah0/xokhQ4qJ9Vw7lBR2ynr8DZhMiK/GpU8
	xmH1/bKUr2N+inwdNrPkBbE04rAESLy0DmZTefKWSX4gSZL/Es1ShS9K6i2PYqtIVULRldN
	9/VJWku1j8gk7tyHIjJcjGpamSqS61y9yV/eN/Cqsl4vdniyApqDi12hujcT9cssYI2xYQ6
	xedXqKiHcMc5i8rIOqIVR+AC4NqkWYylU8RtujEqnfftWtfC+HjYSGyxvW2rjZn+vg1G88+
	BN5LLrr+Z/tlqsOvaLRMXLA7eUGzhcpoq2NlohV9UqlEQFfI68rDWxq8ASi7Oe/yq+O8bQI
	VWQf2SPkRBXOpksTjUXaAY1/+FSfoVTTQHXdlt9D3UuUmypHfxEQQp9V/9q2RGy0XT90FSs
	Oj4UH2HWYjZ1Bmudsyu7hCsV3PUuhfzJlQZWrnU5aHs1eOPDcltjHZbl3DlMEQcFprjGHIc
	JVmvWpEvo+8enCAPqS5h1O9vFaGWUoZtFfZTKQbCbHiiNiVRsJOHD1ZhDFkBhO1h9k54Pkn
	g9JnAFUhtzqWkEZPbWi2AA6X6
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

convert powerpc entry code in syscall and fault to use syscall_work
and irqentry_state as well as common calls implemented in generic
entry infrastructure.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
v1->v2: fix ppc syscall entry seccomp_bpf test errors for common entry conversion.
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


