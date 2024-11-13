Return-Path: <linux-kernel+bounces-408111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AED2D9C7A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B051F23406
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5FF15E5B5;
	Wed, 13 Nov 2024 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LPJJLnqH"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70321209F2D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520809; cv=none; b=SyjYxruBa83LpYpQ0aDB5M2feuCVv6GEMeHgrs7+sggk1CFRz2kKW07uJ11TNdmPkQPjYt9TrjkxpXdJgj8MA/NdzQU3nd6ot7rgwgs/H7ZBUwgkMR8t5/XWqfnGRhqXoW5NcolSJzqWTEgCWZJ5vzfx2v9LhKsLc32EGAOG2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520809; c=relaxed/simple;
	bh=nwvluWG1Za1oEdNoLMNcHLY1yMaG8dbQ3bUpxtsWhvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYq7SSxHKyz8gYRiTzVFAqQE5ZhVXDftyoPJeMCYLnuf9RxVRKZHSv9Bvds/AUZZ4LNZk3lWBxBQCd7ZTJc9fdZaORaB39HZ29HZDJVztKds1NUzV33QWLUvlyHR6Y/RsbYGxeWZrz27Ms7ioPUArFFJcpQAv42oVz9M/yUsX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LPJJLnqH; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4ADHxYB33897551
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 09:59:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4ADHxYB33897551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731520779;
	bh=yzCt+5eNmezlEy4mRsnpAtCpm07XvZ+ueQJAh+t2w7U=;
	h=From:To:Cc:Subject:Date:From;
	b=LPJJLnqHRrCLWR0YVTQJrtNUboPjKUPm8OyNnJonyybGcpzN/QwpRN1UYkD9xHOLI
	 d/me6+kfJ83JTX879ycSZr6V+9OD+x0Ua4Sm/vfA4B5MZsSfZ7+kHNfjDkSpNCR2/6
	 eF6h9beGIU1jEVQLfb/ltyk/XbzzkJ+agJdDxFQtShhnZkd8yDlJXJXsU1AR3zg4h8
	 wwMOtBqECHIBi59MKZ+SVCAVwPLECaKTNhwJZHFjJcUTQB3KK562hLtDL1j7pBnLIo
	 VMibjhzSljyfMOesTKLX+CWmIRzIbW9A9ZyeHtgHkkrJqz77hWX8hodKBZxiYqQA+K
	 sYv2/S/BM21SQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com
Subject: [PATCH v4 1/1] x86/fred: Clear WFE in missing-ENDBRANCH #CPs
Date: Wed, 13 Nov 2024 09:59:34 -0800
Message-ID: <20241113175934.3897541-1-xin@zytor.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An indirect branch instruction sets the CPU indirect branch tracker
(IBT) into WAIT_FOR_ENDBRANCH (WFE) state, and WFE stays asserted
across the instruction boundary.  When decoder finds an instruction
and WFE is set, and the instruction is not the appropriate ENDBR, it
raises a #CP fault.

For the kernel IBT no ENDBR selftest where #CPs are deliberately
triggered, the WFE state of the interrupted context needs to be
cleared to let execution continue.  Otherwise when the CPU resumes
from the instruction that just caused the previous #CP, another
missing-ENDBRANCH #CP is raised and the CPU enters a dead loop.

This is not a problem with IDT because it doesn't preserve WFE and
IRET doesn't set WFE.  But FRED provides space on the entry stack
(in an expanded CS area) to save and restore the WFE state, thus the
WFE state is no longer clobbered, so software must clear it.

Clear WFE to avoid dead looping in ibt_clear_fred_wfe() and the
!ibt_fatal code path when execution is allowed to continue.

Clobbering WFE in any other circumstance is a security-relevant bug.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---

Change since v3:
* Fix a typo and a grammar issue (Ingo Molnar).

Changes since v2:
* Explain why the FRED-specific code in ibt_clear_fred_wfe() doesn't
  do any FRED checks (Dave Hansen).
* ibt_clear_fred_wfe() needs to be inside the ibt_selftest_noendbr
  path (Andrew Cooper & Dave Hansen).
* Simplify the changelog and comment, create an IBT WFE document
  in Documentation/ later (Dave Hansen).
* Rewrite changelog based on feedbacks from Dave and Andrew.

Changes since v1:
* Rewrite the comment of ibt_clear_fred_wfe() using Andrew Cooper's
  write-up (Andrew Cooper).
* Unconditionally clear WFE in missing-ENDBRANCH #CPs (Peter Zijlstra).
* Don't check X86_FEATURE_FRED in ibt_clear_fred_wfe() (Dave Hansen &
  Andrew Cooper).
---
 arch/x86/kernel/cet.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index d2c732a34e5d..303bf74d175b 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -81,6 +81,34 @@ static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
 
 static __ro_after_init bool ibt_fatal = true;
 
+/*
+ * By definition, all missing-ENDBRANCH #CPs are a result of WFE && !ENDBR.
+ *
+ * For the kernel IBT no ENDBR selftest where #CPs are deliberately triggered,
+ * the WFE state of the interrupted context needs to be cleared to let execution
+ * continue.  Otherwise when the CPU resumes from the instruction that just
+ * caused the previous #CP, another missing-ENDBRANCH #CP is raised and the CPU
+ * enters a dead loop.
+ *
+ * This is not a problem with IDT because it doesn't preserve WFE and IRET doesn't
+ * set WFE.  But FRED provides space on the entry stack (in an expanded CS area)
+ * to save and restore the WFE state, thus the WFE state is no longer clobbered,
+ * so software must clear it.
+ */
+static void ibt_clear_fred_wfe(struct pt_regs *regs)
+{
+	/*
+	 * No need to do any FRED checks.
+	 *
+	 * For IDT event delivery, the high-order 48 bits of CS are pushed
+	 * as 0s into the stack, and later IRET ignores these bits.
+	 *
+	 * For FRED, a test to check if fred_cs.wfe is set would be dropped
+	 * by compilers.
+	 */
+	regs->fred_cs.wfe = 0;
+}
+
 static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	if ((error_code & CP_EC) != CP_ENDBR) {
@@ -90,6 +118,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 
 	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)) {
 		regs->ax = 0;
+		ibt_clear_fred_wfe(regs);
 		return;
 	}
 
@@ -97,6 +126,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 	if (!ibt_fatal) {
 		printk(KERN_DEFAULT CUT_HERE);
 		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+		ibt_clear_fred_wfe(regs);
 		return;
 	}
 	BUG();

base-commit: 5283b49a869ba4d60e8b7fc4d353955512404bec
-- 
2.47.0


