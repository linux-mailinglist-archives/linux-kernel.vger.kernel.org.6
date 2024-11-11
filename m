Return-Path: <linux-kernel+bounces-403537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA3E9C36F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075091C216AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9936E14A4DF;
	Mon, 11 Nov 2024 03:22:53 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C9146D7F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731295373; cv=none; b=L4i+eF3UXaVqL3QXl0Cd5oUtIF6EHHg536+GHlFnjYQ9FJM35meNUzOIuqtJwACQYxnVUl+3eQpg3cFVGZC3hJIhys+1up6sK1UeRyIAB882NuvCBzDiZwYbtcmclXRzT+tMUDuemunjCHxJyaE/XOnvX4vaX6H5F8s6v58CohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731295373; c=relaxed/simple;
	bh=wsvJ37tVBoM52rkphsmEyLfch5rpsOi5l9AHm0mG5HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMxponMf+gMDWZueXCncDQd8ckOB5Jm/ZtVip6SGuMJByt5RR02bpn9mb6yAU11NEkGQ2wiTl1KCUlLEPC4F3/8S9siYgUGRkBABXXffOX2pcNgOrtlGvIN3Xt3sQLZnymEZGJsJQF/bHAmFtNRav57pQu4GTC71hctLVa+u7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz5t1731295287t86m7ga
X-QQ-Originating-IP: /LUL+HLIGB/NES8ocSMYmMlww42rJYMefiuMTCsbuMs=
Received: from HX09040029.powercore.com.cn ( [116.233.136.127])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 11:21:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13334988639752082623
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH v2 2/8] powerpc/entry: cleanup syscall entry
Date: Mon, 11 Nov 2024 11:19:28 +0800
Message-ID: <A71D1C71E9993C21+20241111031934.1579-4-luming.yu@shingroup.cn>
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
X-QQ-XMAILINFO: OSUW9vQLVhiZTclshFBubYPkDXTre72zm5Z76+KDIiBHvx7fGO8F35RM
	BDfwguD52sfRLyiWUlTS4EQCV0tFcb7mnIJjqVcBBN0DiMZiMbdxquh5uWK3QqGRCkb7q26
	3QN1oxGtuvaMzrs5FadLSQH2Gqo604tu2JNQttfSdFXUWPzdgu3unp5SnZp4wX+KSsGux9w
	9ngJDgxINebSZZxFzYKoG8nbCp4QeeQeTW+0Qh8bCJLRopxsvJMdCxCpGUQgURa7Tp3zuX1
	7TQKstB+WxdZ0X7O1elqe2dbYitfmECcQ5lwsa+trXETHwID/unNHEeyY0yXthqYM//r1d9
	Vyvhp60LCHOHPxvpsEv3N0Oj0PyhLEGWZZ8WtYNEAh7T5zoEomgWHR9RO1FI51okbM3kyzp
	dqwoO40ZYtkph95g7XRM0wgO/mVPiFzmmtibZAk1BD3XKA8q3wsI0CxL4gQ26ZEvSDeGUjP
	zy5FbKiOpgJRGesfR3pQ2THOHgkLrfITxg/4zXs8l7NbigsbiE1AAe24IJg+zuP5Kn9658t
	4gtlppOWlIdczvHVtmn0K0Z9le320/m6phwkA4Ovuz/F8dad+86OLg2+roruyaO9i6huYWP
	XrM8lst14YBPcH/7RnzFxUxVG2L81OqT1kNcw3K/gbCjN+U7w5lqzc6jBQapImK+w7e8E2y
	9cEupsHn3HRSxFxiPw8/8evDwptoZCwibR3lSdUS+tY8j5OzRpssmVgYmbQxt+5Kwxswlt8
	po8vIXGpDQC80o/k8Die7QBa1VL2aaR+wtLKkuL8FtQkeerSahyen/ge7Oe+Js2sXkDVGng
	1jvmfQ8xoes3IxlU4th3cKQgFHiJXy5FzR0VcAi7Oqoia9oMAVPP69rdsCK5TUPhCnYxsAg
	EwxJFiiQLNDnfR8qVGop9lAHZ7wVrnLcuGLkmcrqceDBKUFphF9a5JzSoj/OrGzPR3mvD4/
	J6CAIM1aml4KcC/L7JvFuTFD622l0+Ce8lOA9/+kDoDE1TQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

cleanup do_syscall_trace_enter/leave and do_seccomp.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/kernel/interrupt.c     |   5 -
 arch/powerpc/kernel/ptrace/ptrace.c | 141 ----------------------------
 2 files changed, 146 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index c4f6d3c69ba9..8c532cecbc60 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -293,11 +293,6 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 		regs->gpr[3] = r3;
 	}
 
-	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
-		do_syscall_trace_leave(regs);
-		ret |= _TIF_RESTOREALL;
-	}
-
 	local_irq_disable();
 	ret = interrupt_exit_user_prepare_main(ret, regs);
 
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 727ed4a14545..6cd180bc36ab 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -21,9 +21,6 @@
 #include <asm/switch_to.h>
 #include <asm/debug.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/syscalls.h>
-
 #include "ptrace-decl.h"
 
 /*
@@ -195,144 +192,6 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-#ifdef CONFIG_SECCOMP
-static int do_seccomp(struct pt_regs *regs)
-{
-	if (!test_thread_flag(TIF_SECCOMP))
-		return 0;
-
-	/*
-	 * The ABI we present to seccomp tracers is that r3 contains
-	 * the syscall return value and orig_gpr3 contains the first
-	 * syscall parameter. This is different to the ptrace ABI where
-	 * both r3 and orig_gpr3 contain the first syscall parameter.
-	 */
-	regs->gpr[3] = -ENOSYS;
-
-	/*
-	 * We use the __ version here because we have already checked
-	 * TIF_SECCOMP. If this fails, there is nothing left to do, we
-	 * have already loaded -ENOSYS into r3, or seccomp has put
-	 * something else in r3 (via SECCOMP_RET_ERRNO/TRACE).
-	 */
-	if (__secure_computing(NULL))
-		return -1;
-
-	/*
-	 * The syscall was allowed by seccomp, restore the register
-	 * state to what audit expects.
-	 * Note that we use orig_gpr3, which means a seccomp tracer can
-	 * modify the first syscall parameter (in orig_gpr3) and also
-	 * allow the syscall to proceed.
-	 */
-	regs->gpr[3] = regs->orig_gpr3;
-
-	return 0;
-}
-#else
-static inline int do_seccomp(struct pt_regs *regs) { return 0; }
-#endif /* CONFIG_SECCOMP */
-
-/**
- * do_syscall_trace_enter() - Do syscall tracing on kernel entry.
- * @regs: the pt_regs of the task to trace (current)
- *
- * Performs various types of tracing on syscall entry. This includes seccomp,
- * ptrace, syscall tracepoints and audit.
- *
- * The pt_regs are potentially visible to userspace via ptrace, so their
- * contents is ABI.
- *
- * One or more of the tracers may modify the contents of pt_regs, in particular
- * to modify arguments or even the syscall number itself.
- *
- * It's also possible that a tracer can choose to reject the system call. In
- * that case this function will return an illegal syscall number, and will put
- * an appropriate return value in regs->r3.
- *
- * Return: the (possibly changed) syscall number.
- */
-long do_syscall_trace_enter(struct pt_regs *regs)
-{
-	u32 flags;
-
-	flags = read_thread_flags() & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
-
-	if (flags) {
-		int rc = ptrace_report_syscall_entry(regs);
-
-		if (unlikely(flags & _TIF_SYSCALL_EMU)) {
-			/*
-			 * A nonzero return code from
-			 * ptrace_report_syscall_entry() tells us to prevent
-			 * the syscall execution, but we are not going to
-			 * execute it anyway.
-			 *
-			 * Returning -1 will skip the syscall execution. We want
-			 * to avoid clobbering any registers, so we don't goto
-			 * the skip label below.
-			 */
-			return -1;
-		}
-
-		if (rc) {
-			/*
-			 * The tracer decided to abort the syscall. Note that
-			 * the tracer may also just change regs->gpr[0] to an
-			 * invalid syscall number, that is handled below on the
-			 * exit path.
-			 */
-			goto skip;
-		}
-	}
-
-	/* Run seccomp after ptrace; allow it to set gpr[3]. */
-	if (do_seccomp(regs))
-		return -1;
-
-	/* Avoid trace and audit when syscall is invalid. */
-	if (regs->gpr[0] >= NR_syscalls)
-		goto skip;
-
-	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
-		trace_sys_enter(regs, regs->gpr[0]);
-
-	if (!is_32bit_task())
-		audit_syscall_entry(regs->gpr[0], regs->gpr[3], regs->gpr[4],
-				    regs->gpr[5], regs->gpr[6]);
-	else
-		audit_syscall_entry(regs->gpr[0],
-				    regs->gpr[3] & 0xffffffff,
-				    regs->gpr[4] & 0xffffffff,
-				    regs->gpr[5] & 0xffffffff,
-				    regs->gpr[6] & 0xffffffff);
-
-	/* Return the possibly modified but valid syscall number */
-	return regs->gpr[0];
-
-skip:
-	/*
-	 * If we are aborting explicitly, or if the syscall number is
-	 * now invalid, set the return value to -ENOSYS.
-	 */
-	regs->gpr[3] = -ENOSYS;
-	return -1;
-}
-
-void do_syscall_trace_leave(struct pt_regs *regs)
-{
-	int step;
-
-	audit_syscall_exit(regs);
-
-	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
-		trace_sys_exit(regs, regs->result);
-
-	step = test_thread_flag(TIF_SINGLESTEP);
-	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		ptrace_report_syscall_exit(regs, step);
-}
-
 void __init pt_regs_check(void);
 
 /*
-- 
2.42.0.windows.2


