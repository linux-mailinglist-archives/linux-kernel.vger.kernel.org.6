Return-Path: <linux-kernel+bounces-403539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C59C36FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A73282312
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2D3147C86;
	Mon, 11 Nov 2024 03:23:28 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E444C77
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731295407; cv=none; b=XKwMsIW7V3bVulPutFHR2U6oGR0Aii422cbMuVUoUy0lvYXZjHve5NqZ3bIR1oag1j/0bLszYgXqSXQ+vt8Dif4ROal4RiD86wNM+N7DYZk3C+1MC3Aoru6quQ9fMAUvUvea0hEY9fY0eAehH8BTTV9wITsg1LB5rGuRpdqvoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731295407; c=relaxed/simple;
	bh=e8ww/Zus1+spRjzRNLU0FqhxMa8zhQSa2/Vns/ZOFSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjPp684fMYJ1fPSU8Hvd3Qrmc+z7nTO4bIWFjqowIep6dmd1mUfoUK88wLXyM3AO1AuI5xFTJxaT5EnCXh9I6BoYzPQi89D0WMb6zu5dfjlAuNa1/x6kGmO549B2Fn+Lf1lmkpcUIguSlNgvR61dMDT4FnlL/5ScWmGl1RJm3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz5t1731295337tbelslj
X-QQ-Originating-IP: oSKWjFQ2QFU3uf3v/YaUB+xwzwIus0Rs9ZSUn0gWrn4=
Received: from HX09040029.powercore.com.cn ( [116.233.136.127])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 11:22:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3230749710390263555
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH v2 5/8] powerpc/entry: add irqentry_state and generic entry support
Date: Mon, 11 Nov 2024 11:19:34 +0800
Message-ID: <B8D89E4E26FBB584+20241111031934.1579-10-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20241111031934.1579-2-luming.yu@shingroup.cn>
References: <20241111031934.1579-2-luming.yu@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NuQRJUP0KJGkzLuTsvrGVe1Ue/IhCowR6uPPvTSIyLMhMIOX6AsZopRn
	ImkR3wdg/ilqTuxwG/+XmXVQ/n5sbA+vKgPJN8RGiUGEzKVFhdiZxLH9K9AA+PcOi9C+zJc
	HeOt24s21QsgZ4XqScRCETKlk6uTdzS9TP8JC9vBXj5C29LMxlnlwo8o8hJkaskfZQYqgjo
	BVuNVnbcQWbX1CMisMlx+VzItD5z8s4jYEcpU85vBgj8lPFOrFQvcnjYOOnr0W8jcU0Iuhd
	ogSXUVyTJLt/X7t35fbOa0BBB1WWCJbGy3+G0ByJBCn/Ogxawy7jTABd/M0SL8Gki3UVRfi
	EYUzPp1mDb6VHl1Rf6piqwHeu63ftgZLJH7NWwE6aHuwG3pL3B3MJQnXGxEiGYZxD7Y7ePu
	3YdmcAzDNxueh56y7X0yceID06EcId0g/twNOaBwoiBlqk6N0AijB6n/9E4PmFTIv45t94R
	70YKAu5mA+kF4RBkVBoxy21A81eGUmmf1Mh3NuYWyxBteNi9mGSWz6KHbbixCDR4VVyPeHa
	JZamtFLlfPPe9yoZdec3JNsyzulJ3jNMbJMXOWGw5Z7FXv71eykAhGL6EJDc9QhU4Fgce+v
	7xWRvIKjcKZRkx0CC19mW4wg0fpkc74mwthxxM0DOeWd7cbPwJY6+3i52x4ucNXF52Rjd7v
	7ImpSRQWSUARKjrOhZvBXA7KCJ0JgHBS9NnjrBiTrVMx6IU7O5TqD5f479wFtjUyNsiKmgb
	SeDtdaLmV+0nsDGeFRfi2f4ERoFXR9Gfs2ATN0ikrd/PNYzu8fqLK+H0o1aAg1hlA1+np4y
	EFVHRtfeLhDMDOr/OEJdZdnOb1klWT1u4a8v3ZKThuConN2awvdvBU6Y8zd0pPzNz2e3G2Q
	iZhPXXCZvJg7vRPjJ8UhICoHlIc6pzTvt5WFpDgnrYjJebq9s1mVrjdolmt86cpasZw0gP8
	wqHNHHBsd0gb9ELWO1ADr4+mcAWx4FnFGtlGNSDT0wdirOUeBAXWyGI9hwgylrmPjBUc=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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


