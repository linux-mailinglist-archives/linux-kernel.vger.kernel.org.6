Return-Path: <linux-kernel+bounces-362073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A499B093
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FA4283EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE882126C0A;
	Sat, 12 Oct 2024 04:00:53 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477A11185
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705653; cv=none; b=O4q5slsObd4JrcPkPCGcK3P1NaFyWPVpJGT1wVf4jDCXrlFpCEyolarSPhNEpUkS2ZqrXhAKYV8MlAlTICDgMLO67xgjgl6RtxEMPzhQMAy+XEKv46DG7h0Rh/erMVi70cYmxH+e5HfZ4A2vb1ny5YoU++fCYrbhZcrEPVw1aO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705653; c=relaxed/simple;
	bh=e8ww/Zus1+spRjzRNLU0FqhxMa8zhQSa2/Vns/ZOFSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tz/SS/qHDRcLKaoUopamAPWj2aPynaZ5MV/K87F3k/bmR0D8wWvdFRXXgjCUDS0xBr8PuXkxJcZVh4ad/p/sVCovNh5VwytKkjMbfFrvfVT0f7xwVlEZ7GdbwlgkacNVMqrdTeXjN87keZXfn8b3gsjLEek8C3Q4qDX+e2HPeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz3t1728705585tru68vi
X-QQ-Originating-IP: dPzeGZMY/guyAa0JyerkWJKSZdNWTaVlJKwJFdT4Hu0=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 12 Oct 2024 11:59:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1889317134298449464
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	jialong.yang@shingroup.cn,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH 5/7] powerpc/entry: add irqentry_state and generic entry support
Date: Sat, 12 Oct 2024 11:56:19 +0800
Message-ID: <5ADB50C5F6678977+20241012035621.1245-7-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20241012035621.1245-3-luming.yu@shingroup.cn>
References: <20241012035621.1245-3-luming.yu@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OZOGECUHcopq1p3DJjt/esgaKLlu2WyzxeCTRpWsGWmve4b86vYBJV4i
	rpcODtBuXPYhIO7Yp4pisJCPhW1ksDwfgjgKoOYhbilQzwvQFPrzLsRgpBBrJ3RDCCp9EdU
	yWKLQY0a/U8wrUk0V7p0sZET4wR4AaYv1c9QyzsXsZbE2Q+DoKtppy0281TjKZ4xwhho5Cc
	429Mh9a124OPhfYqdWZd9T3eMiw0ies4ArXkltGFoygkd/jxv77Tw5qG0fjbx4qysqbaOZf
	JL+bIE3ViJbLosNHpSVQ0V90/LQRipEZBigyba+pascyHSQpCOkiL0nJiA7ohIWf7k/KL28
	rBDkBG6dlS3bYzLPEihZp/FcDkwJa8bLy7+mFrJXA02pgaCQ1r8hDG+jt8+7V44C5movm6t
	JB1C4KgarRcxy9SSF5q1SEtVq3scUbTmLlSmi149C5Qi/6be1pl1s6GOTOX1RdlRI0k7JsU
	HnsfnsMl73XvGivQs31iQ6bp2sg1SNm4RO4SLtx4NlLtnzKjvhBTUjCCrNfLlsV20SXGOS+
	KUkI/phKg6H4SjOCjnq7FBf4pMtyaBjJ5l6Ej81Ar/ZKiuscfIsoqj3IE6WNLmixMkIWfbP
	rMGV4L04T4+RaLUoH2cCHVUR7CwE4jH9n+SJimYLp/owO9/c/x2nr2P5rnqICYcJNec7GHS
	dk6kFB6l/XmTQDpksiI6iAuG2GXGgeaBLRd3VwI4Q+Xj4xfxucsS2kp1MsAKXKIQNSKZ/sP
	bGjwL4BhysC6rX6jejpsFt4RpjxSBaQsieoKb83wPDpXZSYyckVzmM0eTjj0OFJUpGnosIo
	NcHw7ri3eBXuyDkMH2iHg+PZINbmCHOSalHOOIhcqOY6/4heKa+7FRsAxYyBqzk3NsbRKrw
	3UPps9e9D0qaDhKYwUX4Dlk9ShsB/4h2rTXje1bJm7ZxHOByEL1eR24N9FlvlHbROmzWfbk
	vqaNtYbzn0N8W7Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

generic irq entry support via generic irqentry is added for powerpc.
There may be duplciate calls and missing callbacks requires further
work.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/include/asm/entry-common.h | 32 ++++++++++++++++
 arch/powerpc/kernel/interrupt.c         | 51 +++++--------------------
 arch/powerpc/kernel/signal.c            |  7 ++++
 arch/powerpc/kernel/syscall.c           |  2 -
 4 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index 51f1eb767696..faa829e15b5d 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -3,6 +3,7 @@
 #define ARCH_POWERPC_ENTRY_COMMON_H
 
 #include <linux/user-return-notifier.h>
+#include <asm/switch_to.h>
 
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
@@ -13,4 +14,35 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
+static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
+						unsigned long ti_work)
+{
+
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && IS_ENABLED(CONFIG_PPC_FPU)) {
+		if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
+				unlikely((ti_work & _TIF_RESTORE_TM))) {
+			restore_tm_state(regs);
+		} else {
+			unsigned long mathflags = MSR_FP;
+
+			if (cpu_has_feature(CPU_FTR_VSX))
+				mathflags |= MSR_VEC | MSR_VSX;
+			else if (cpu_has_feature(CPU_FTR_ALTIVEC))
+				mathflags |= MSR_VEC;
+
+			/*
+			 * If userspace MSR has all available FP bits set,
+			 * then they are live and no need to restore. If not,
+			 * it means the regs were given up and restore_math
+			 * may decide to restore them (to avoid taking an FP
+			 * fault).
+			 */
+			if ((regs->msr & mathflags) != mathflags)
+				restore_math(regs);
+		}
+	}
+}
+
+#define arch_exit_to_user_mode_work arch_exit_to_user_mode_work
+
 #endif
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 609ba48034de..42af9217136d 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -3,6 +3,7 @@
 #include <linux/context_tracking.h>
 #include <linux/err.h>
 #include <linux/compat.h>
+#include <linux/entry-common.h>
 #include <linux/sched/debug.h> /* for show_regs */
 
 #include <asm/kup.h>
@@ -183,47 +184,11 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 
 again:
 	ti_flags = read_thread_flags();
-	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
-		local_irq_enable();
-		if (ti_flags & _TIF_NEED_RESCHED) {
-			schedule();
-		} else {
-			/*
-			 * SIGPENDING must restore signal handler function
-			 * argument GPRs, and some non-volatiles (e.g., r1).
-			 * Restore all for now. This could be made lighter.
-			 */
-			if (ti_flags & _TIF_SIGPENDING)
-				ret |= _TIF_RESTOREALL;
-			do_notify_resume(regs, ti_flags);
-		}
-		local_irq_disable();
-		ti_flags = read_thread_flags();
-	}
 
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && IS_ENABLED(CONFIG_PPC_FPU)) {
-		if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
-				unlikely((ti_flags & _TIF_RESTORE_TM))) {
-			restore_tm_state(regs);
-		} else {
-			unsigned long mathflags = MSR_FP;
-
-			if (cpu_has_feature(CPU_FTR_VSX))
-				mathflags |= MSR_VEC | MSR_VSX;
-			else if (cpu_has_feature(CPU_FTR_ALTIVEC))
-				mathflags |= MSR_VEC;
-
-			/*
-			 * If userspace MSR has all available FP bits set,
-			 * then they are live and no need to restore. If not,
-			 * it means the regs were given up and restore_math
-			 * may decide to restore them (to avoid taking an FP
-			 * fault).
-			 */
-			if ((regs->msr & mathflags) != mathflags)
-				restore_math(regs);
-		}
-	}
+	if (ti_flags & _TIF_SIGPENDING)
+		ret |= _TIF_RESTOREALL;
+	if (unlikely(ti_flags & EXIT_TO_USER_MODE_WORK))
+		ti_flags = exit_to_user_mode_loop(regs, ti_flags);
 
 	check_return_regs_valid(regs);
 
@@ -297,11 +262,15 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	}
 
 	local_irq_disable();
-	ret = interrupt_exit_user_prepare_main(ret, regs);
+	if (ti_flags & _TIF_RESTOREALL)
+		ret |= _TIF_RESTOREALL;
 
+	if (ti_flags & _TIF_SIGPENDING)
+		ret |= _TIF_RESTOREALL;
 #ifdef CONFIG_PPC64
 	regs->exit_result = ret;
 #endif
+	syscall_exit_to_user_mode(regs);
 
 	return ret;
 }
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index aa17e62f3754..da21e7fef46a 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -11,6 +11,7 @@
 #include <linux/uprobes.h>
 #include <linux/key.h>
 #include <linux/context_tracking.h>
+#include <linux/entry-common.h>
 #include <linux/livepatch.h>
 #include <linux/syscalls.h>
 #include <asm/hw_breakpoint.h>
@@ -368,3 +369,9 @@ void signal_fault(struct task_struct *tsk, struct pt_regs *regs,
 		printk_ratelimited(regs->msr & MSR_64BIT ? fm64 : fm32, tsk->comm,
 				   task_pid_nr(tsk), where, ptr, regs->nip, regs->link);
 }
+
+void arch_do_signal_or_restart(struct pt_regs *regs)
+{
+	BUG_ON(regs != current->thread.regs);
+	do_signal(current);
+}
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index e0338bd8d383..97f158d13944 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -185,8 +185,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	 * So the resulting 6 or 7 bits of entropy is seen in SP[9:4] or SP[9:3].
 	 */
 	choose_random_kstack_offset(mftb());
-	/*common entry*/
-	syscall_exit_to_user_mode(regs);
 
 	return ret;
 }
-- 
2.42.0.windows.2


