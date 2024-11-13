Return-Path: <linux-kernel+bounces-407280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A969C6B43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466FF283947
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF371C8FBA;
	Wed, 13 Nov 2024 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jYoOeafH"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013A1C7B99
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489259; cv=none; b=A4+I382W+8fYbjslB4NmLF9SgkFEyZMyJEaU4FhaK1MIi8khQJBZ3Qqcmw+qRmFTnTl/z92v5N2NBk0C2l7uEQ3MdTg/QtGOmx1c232QBFpzcs777JAHz2SqTYQErfxek35+U+bPYrf1DAg2MVfGPV7aZizZKtcWLLALaTFIWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489259; c=relaxed/simple;
	bh=k3u1i+EkOUGyydWDxegjN8Z+dsO/4h73UeTsckZJ1pI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0heSCJesXbovUvlu9mysQ0vQhHFH1Lr/ZJKRy9c7Mr7hMAk6jHEFekl/KP8THNoK46gzzpBvJRhgB0QMmquumu8p5nksMaz9bcykQApBQj8ItMy/q6g0mfLG+sLxS8GRdzYqseds0P+rKnARyZV8SWU3XambnpejlWgC7U+Zx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=jYoOeafH; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4AD9DDIp3717348
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 01:13:19 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4AD9DDIp3717348
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731489200;
	bh=8nDYQSOmddAD+wN5L5Wxofedcz2xjD/+8HfS2spkzPw=;
	h=From:To:Cc:Subject:Date:From;
	b=jYoOeafH3Bo+uH+2ougSWoOkM05a+3FBNnueuT/lt4fp/m4oyEpC9zUs5hdf4n5Nl
	 hpD/qg7Dxknq9S6xWNR4i+nYK93/aIHkygpiqIxG4fn/5cnj5wNDUUpRx9wRKN8uwh
	 yrSuTMmmZhZ0AgpEJoIePb2UKe7Ozriq6HPF6lCfBxAH3MPHk7Dda8V6HCKDI5acxu
	 UM3ta3KkL0pz2l0i4Y+LvNTU5xPzauFWkEAqw/vyu+Mro5rDTluv4PX0355ugQSXHy
	 whgWd33jc7vp4GlZCXJWKd7/QQRZr6sItKTBDTsDxPRXxWOgD1hqVw0XrYwvoyb2uB
	 KzuQNmclohBUA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com
Subject: [PATCH v3 1/1] x86/fred: Clear WFE in missing-ENDBRANCH #CPs
Date: Wed, 13 Nov 2024 01:13:12 -0800
Message-ID: <20241113091313.3717338-1-xin@zytor.com>
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
triggerred, the WFE state of the interrupted context needs to be
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
---

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
index d2c732a34e5d..f14156b45c90 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -81,6 +81,34 @@ static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
 
 static __ro_after_init bool ibt_fatal = true;
 
+/*
+ * By definition, all missing-ENDBRANCH #CPs are a result of WFE && !ENDBR.
+ *
+ * For the kernel IBT no ENDBR selftest where #CPs are deliberately triggerred,
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
+	 * as 0s into stack, and later IRET ignores these bits.
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

base-commit: be42adbe196a218ef345e2ffa0f8b70492df7dd1
-- 
2.47.0


