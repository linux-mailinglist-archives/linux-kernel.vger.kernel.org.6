Return-Path: <linux-kernel+bounces-270750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C969444CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254B7282470
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10863158A23;
	Thu,  1 Aug 2024 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jtbvTQ37"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38301158549
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495116; cv=none; b=sk+4juJSnEc+SQD73ibYYYU7edhWFwf6dvW5Y9J3UZ8iSI38Qi8orphfjZHNcQir6cUpgeLmSKqPtjPgJCp9qfTo7G45veQDaYd9dK3xuTU5zC5njJ7EQmq3kLd1kbj32l5TjpkyP90/L5y6CB03DQWx+P6K7xxCqU7865Oajeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495116; c=relaxed/simple;
	bh=LPXjtMMpQZI8k8paf8J+PicfqHOPihHKxzMwFv+Z4eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=geNIwQyoQwl3RYkv8l0oG272XRpnWhfnGGrI5fhEjjMscuOaqxNB8h1ERtlVzmvP5fTytU0rUNk9AAdE2XU2Dz+qLfO9D6LhfNdQNBv10aK5/rDK8rpNnvjgP7X16go4ZFhFMSRAK9rw4yq8PMAcT8jGBcnTFhOFrEitdLYtook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jtbvTQ37; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VLGvI6005722;
	Thu, 1 Aug 2024 06:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=M
	KU+WG2gzC94jUgb0tLE7u9uI0Bei7s8TSL3t2RlLeo=; b=jtbvTQ37PLeXqm+XI
	royK+S37eMmisilBy5ySnlj5trGZKLAqaEDvbGjDwfD4RNhP3woyjxFoXNzr5xrf
	bG6eqhaevkj4RvOQGAPJ+A+pf+MWtkyycmxvT8hKgqrNAHvdJk6z1BSCPenwyYJS
	vuKJpwoW/TOD1LUWAN5pJMmFjFKEqsQ18535S0Fwb3tiS1JcRV7EpVrt1q+miSOT
	GFUsnlixK4LF16pY76/rg8kdExusNjvSRfo42ukQbyolrFpRC8cgQnGJZuya7ACf
	3A250GG8tLt9Azsej+pMLd4cOOYNBkCnUooWtK6qoMbKvtHBQBEOXvFfX3M2w/UT
	4qBtg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqp214n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 06:51:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47152vFv030993;
	Thu, 1 Aug 2024 06:51:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehveh7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 06:51:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4716pHNE033596;
	Thu, 1 Aug 2024 06:51:17 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40nehveh6x-2;
	Thu, 01 Aug 2024 06:51:17 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-mm@kvack.org, keith.lucas@oracle.com,
        jeffxu@chromium.org, rick.p.edgecombe@intel.com, jorgelo@chromium.org,
        keescook@chromium.org, sroettger@google.com, jannh@google.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH  v7 1/5] x86/pkeys: Add PKRU as a parameter in signal handling functions
Date: Thu,  1 Aug 2024 06:51:12 +0000
Message-Id: <20240801065116.2088582-2-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801065116.2088582-1-aruna.ramakrishna@oracle.com>
References: <20240801065116.2088582-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010038
X-Proofpoint-ORIG-GUID: X4z3E578c0JDELBUOm_lQRLKs0ZM6qEx
X-Proofpoint-GUID: X4z3E578c0JDELBUOm_lQRLKs0ZM6qEx

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
PKRU as an additional parameter down the chain from get_sigframe():
	get_sigframe()
          copy_fpstate_to_sigframe()
            copy_fpregs_to_sigframe()

There are no functional changes in this patch.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/include/asm/fpu/signal.h | 2 +-
 arch/x86/kernel/fpu/signal.c      | 6 +++---
 arch/x86/kernel/signal.c          | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

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
index 31b6f5dddfc2..1f1e8e0ac5a3 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -84,6 +84,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
+	u32 pkru = read_pkru();
 
 	/* redzone */
 	if (!ia32_frame)
@@ -139,7 +140,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	}
 
 	/* save i387 and extended state */
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size))
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, pkru))
 		return (void __user *)-1L;
 
 	return (void __user *)sp;
-- 
2.39.3


