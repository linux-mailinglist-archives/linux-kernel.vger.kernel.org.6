Return-Path: <linux-kernel+bounces-233033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A8691B164
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17027B256FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6321A38C0;
	Thu, 27 Jun 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+wqoFUO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944FB1A2C27
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523085; cv=none; b=mMD1BlvzPCnzGvukUZOBbH8ozxD6dkG4dNrjmdiyEg7WVqbSA0kW5n3kmd+2o95ieeOwU+rqoiCVhSCH+IW4O7ivPXwTysHZZSyILZEvO8cfukM8CrHXmY0EOVRv2tB19NBqH9SWqlCmkPR+QRvIYkAIonEPYx4pc5R1xhkkqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523085; c=relaxed/simple;
	bh=HUJ9LSfhhn02zD3UAcctMlo4qwYQVreOVPX1DTop6B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRfH3etb3Xw0Gfqg1iYnWNuSqM1TdnVF93SjiM+lDnS0ZV28pLHFjjnOu9yHJMGLFwVE+woy3R0Lq7mOVX91v22AKwxTUlr0+llavthqO4G3faibdZHTVb/l3pJ+mNCTJ1rQDMrvHpWkVtYTIM4HSNAbHRbAEP+ML0cbAeQl4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b+wqoFUO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RKBV5g013620;
	Thu, 27 Jun 2024 21:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=N
	h+olNtldS0TNFB36AevoAG2xVEmIqKWnI63TyasIG8=; b=b+wqoFUOvmE0+i71+
	yTOTvxg1T55mkxCscIN32ODDjw3eO966qav/Iklxxyrs14qLzeF1WiNHtimYRQag
	H2XrAi2+z0KWiAtxNKmwHG9wSyoqjDVNK+SKGuURTOqajKl6rcnbjivdvkc53kIB
	4YTxGYJ+HiXXmJAJBVZZcdUwT7RACsrhLn2DswP+dy+M7DpWlI+LYXV0nVjzHkI+
	2HFv0i1KpT49IANCFDu+Uz4KyZtFbIhgTfFv5bqhawyigc+fBQH3Lcf5iTSaCRSk
	SsOx/DInvW8Uen7uxkLbOZpUIp6LcDNXPW2khgRHzIzkoZ8atFjv0xiZ7HQeqAO5
	Az4/g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn70f1a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 21:17:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RJb9OO017874;
	Thu, 27 Jun 2024 21:17:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2awm4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 21:17:40 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RLHct4016897;
	Thu, 27 Jun 2024 21:17:39 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2awm35-2;
	Thu, 27 Jun 2024 21:17:39 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, jeffxu@chromium.org, keith.lucas@oracle.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v6 1/5] x86/pkeys: Add PKRU as a parameter in signal handling functions
Date: Thu, 27 Jun 2024 21:17:33 +0000
Message-Id: <20240627211737.323214-2-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240627211737.323214-1-aruna.ramakrishna@oracle.com>
References: <20240627211737.323214-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270158
X-Proofpoint-ORIG-GUID: 4v8vGF-RsacZRG5NNytQx4CT5rOCEK2m
X-Proofpoint-GUID: 4v8vGF-RsacZRG5NNytQx4CT5rOCEK2m

Problem description:
Let's assume there's a multithreaded application that runs untrusted
user code. Each thread has its stack/code protected by a non-zero pkey,
and the PKRU register is set up such that only that particular non-zero
pkey is enabled. Each thread also sets up an alternate signal stack to
handle signals, which is protected by pkey zero. The pkeys man page
documents that the PKRU will be reset to init_pkru when the signal
handler is invoked, which means that pkey zero access will be enabled.
But this reset happens after the kernel attempts to push fpu state
to the alternate stack, which is not (yet) accessible by the kernel,
which leads to a new SIGSEGV being sent to the application, terminating
it.

Enabling both the non-zero pkey (for the thread) and pkey zero in
userspace will not work for this use case. We cannot have the alt stack
writeable by all - the rationale here is that the code running in that
thread (using a non-zero pkey) is untrusted and should not have access
to the alternate signal stack (that uses pkey zero), to prevent the
return address of a function from being changed. The expectation is that
kernel should be able to set up the alternate signal stack and deliver
the signal to the application even if pkey zero is explicitly disabled
by the application. The signal handler accessibility should not be
dictated by whatever PKRU value the thread sets up.

Solution:
The PKRU register is managed by XSAVE, which means the sigframe contents
must match the register contents - which is not the case here. We want
the sigframe to contain the user-defined PKRU value (so that it is
restored correctly from sigcontext) but the actual register must be
reset to init_pkru so that the alt stack is accessible and the signal
can be delivered to the application. It seems that the proper fix here
would be to remove PKRU from the XSAVE framework and manage it
separately, which is quite complicated. As a workaround, do this:

        orig_pkru = rdpkru();
        wrpkru(orig_pkru & init_pkru_value);
        xsave_to_user_sigframe();
        put_user(pkru_sigframe_addr, orig_pkru)

This change is split over multiple patches.

In preparation for writing PKRU to sigframe in a later patch, pass in
PKRU as an additional parameter down the chain from handle_signal:
        setup_rt_frame()
          xxx_setup_rt_frame()
            get_sigframe()
              copy_fpstate_to_sigframe()
                copy_fpregs_to_sigframe()

There are no functional changes in this patch.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/include/asm/fpu/signal.h  |  2 +-
 arch/x86/include/asm/sighandling.h | 10 +++++-----
 arch/x86/kernel/fpu/signal.c       |  6 +++---
 arch/x86/kernel/signal.c           | 19 ++++++++++---------
 arch/x86/kernel/signal_32.c        |  8 ++++----
 arch/x86/kernel/signal_64.c        |  8 ++++----
 6 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 611fa41711af..eccc75bc9c4f 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -29,7 +29,7 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 unsigned long fpu__get_fpstate_size(void);
 
-extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size, u32 pkru);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
 
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index e770c4fc47f4..de458354a3ea 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -17,11 +17,11 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 
 void __user *
 get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
-	     void __user **fpstate);
+	     void __user **fpstate, u32 pkru);
 
-int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
-int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
-int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
-int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
 
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 247f2225aa9f..2b3b9e140dd4 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -156,7 +156,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 	return !err;
 }
 
-static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
+static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
 	if (use_xsave())
 		return xsave_to_user_sigframe(buf);
@@ -185,7 +185,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  * For [f]xsave state, update the SW reserved fields in the [f]xsave frame
  * indicating the absence/presence of the extended state to the user.
  */
-bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
+bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size, u32 pkru)
 {
 	struct task_struct *tsk = current;
 	struct fpstate *fpstate = tsk->thread.fpu.fpstate;
@@ -228,7 +228,7 @@ bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 		fpregs_restore_userregs();
 
 	pagefault_disable();
-	ret = copy_fpregs_to_sigframe(buf_fx);
+	ret = copy_fpregs_to_sigframe(buf_fx, pkru);
 	pagefault_enable();
 	fpregs_unlock();
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 31b6f5dddfc2..94b894437327 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -74,7 +74,7 @@ static inline int is_x32_frame(struct ksignal *ksig)
  */
 void __user *
 get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
-	     void __user **fpstate)
+	     void __user **fpstate, u32 pkru)
 {
 	struct k_sigaction *ka = &ksig->ka;
 	int ia32_frame = is_ia32_frame(ksig);
@@ -139,7 +139,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	}
 
 	/* save i387 and extended state */
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size))
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, pkru))
 		return (void __user *)-1L;
 
 	return (void __user *)sp;
@@ -206,7 +206,7 @@ unsigned long get_sigframe_size(void)
 }
 
 static int
-setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 {
 	/* Perform fixup for the pre-signal frame. */
 	rseq_signal_deliver(ksig, regs);
@@ -214,21 +214,22 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	/* Set up the stack frame */
 	if (is_ia32_frame(ksig)) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-			return ia32_setup_rt_frame(ksig, regs);
+			return ia32_setup_rt_frame(ksig, regs, pkru);
 		else
-			return ia32_setup_frame(ksig, regs);
+			return ia32_setup_frame(ksig, regs, pkru);
 	} else if (is_x32_frame(ksig)) {
-		return x32_setup_rt_frame(ksig, regs);
+		return x32_setup_rt_frame(ksig, regs, pkru);
 	} else {
-		return x64_setup_rt_frame(ksig, regs);
+		return x64_setup_rt_frame(ksig, regs, pkru);
 	}
 }
 
 static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
-	bool stepping, failed;
 	struct fpu *fpu = &current->thread.fpu;
+	u32 pkru = read_pkru();
+	bool stepping, failed;
 
 	if (v8086_mode(regs))
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
@@ -264,7 +265,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	if (stepping)
 		user_disable_single_step(current);
 
-	failed = (setup_rt_frame(ksig, regs) < 0);
+	failed = (setup_rt_frame(ksig, regs, pkru) < 0);
 	if (!failed) {
 		/*
 		 * Clear the direction flag as per the ABI for function entry.
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index ef654530bf5a..b437d02ecfd7 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -228,7 +228,7 @@ do {									\
 		goto label;						\
 } while(0)
 
-int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 {
 	sigset32_t *set = (sigset32_t *) sigmask_to_save();
 	struct sigframe_ia32 __user *frame;
@@ -246,7 +246,7 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 		0x80cd,		/* int $0x80 */
 	};
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp, pkru);
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
 		restorer = ksig->ka.sa.sa_restorer;
@@ -299,7 +299,7 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 	return -EFAULT;
 }
 
-int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 {
 	sigset32_t *set = (sigset32_t *) sigmask_to_save();
 	struct rt_sigframe_ia32 __user *frame;
@@ -319,7 +319,7 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 		0,
 	};
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp, pkru);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 8a94053c5444..ccfb7824ab2c 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -161,7 +161,7 @@ static unsigned long frame_uc_flags(struct pt_regs *regs)
 	return flags;
 }
 
-int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 {
 	sigset_t *set = sigmask_to_save();
 	struct rt_sigframe __user *frame;
@@ -172,7 +172,7 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
-	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp, pkru);
 	uc_flags = frame_uc_flags(regs);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
@@ -300,7 +300,7 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *to,
 	return __copy_siginfo_to_user32(to, from);
 }
 
-int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 {
 	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
 	struct rt_sigframe_x32 __user *frame;
@@ -311,7 +311,7 @@ int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp, pkru);
 
 	uc_flags = frame_uc_flags(regs);
 
-- 
2.39.3


