Return-Path: <linux-kernel+bounces-325745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB40F975DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DAA285983
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75B1BD008;
	Wed, 11 Sep 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="O6KJDir4"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75941BCA00
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096837; cv=none; b=AAQAM7x17K8AqgLawyOzbbsHYMQZb4nGrchVhSy+DQjN1gW2DdRRj03AKCB2fGN6ZfGC8ctxLCrzmopl8FUAmWpnKr+ylSe6Aoslq5KWVufp0J8DZDqqXQ/w4EhtWJOvL/5Zrw0tASPXz+Vi2GU52kzOzD316eMgtmWLIwzY/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096837; c=relaxed/simple;
	bh=MO5DdAYpFgWOl+EWWQCJGnrdilnGkk3DRyEolG0tFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5lBlColrnsv2hfzH5y5kZBYLs5Qp7R2h2FEm6HvSQzK/4vInpRYQyGNd6srpBbf+Po5R4T+t5QVm+0FSizHGzAIzM3Csp1V6tVSizTQaLCRtXDjkYFyiLn8C2LobfuM8Sfa1asgEJfzUY/mha+g8MRn3g1r9sOnaGKYwMEgjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=O6KJDir4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 48BNJTl72632708
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 11 Sep 2024 16:19:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 48BNJTl72632708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1726096773;
	bh=kAg6gKsnaLWRRKFlSJ1RdsIajGxWu5clQGg/TiLOtvg=;
	h=From:To:Cc:Subject:Date:From;
	b=O6KJDir4+3ySr6EcDlgOzxj05BrxTvnMARVbfsNQUziNv34NiLC0kio97OESVkEeF
	 EEIMILVqSdLqPh6AwtQzHZ7r4L18OP9IXD4LboqN6yHm6lj0WyCmv+cMmuwxfPjGwF
	 ev1uGEHjVyRpA3nIsA6tc/I+zmncbf1bCoqI+vVRQ7FEjDDl3M6SyPuf78VtmLlbd/
	 IrFf1uI+WPVjQHp7fKpGDcwbXYqdTWLW4iwzhzJkmrWVVpzbypt6l4vJ4ksDNS72YU
	 xPrNqI8UW1bddq3/krU2GbxMOGso2HpgdlTOi8hgTU+WaZ84uFkhUGyW9kDwjVsnXl
	 D2OEZPXWY4kQQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com
Subject: [PATCH v1 1/1] x86/fred: Clear the WFE bit in missing-ENDBRANCH #CP
Date: Wed, 11 Sep 2024 16:19:29 -0700
Message-ID: <20240911231929.2632698-1-xin@zytor.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WFE, i.e., WAIT_FOR_ENDBRANCH, bit in the augmented CS of FRED
stack frame is set to 1 in missing-ENDBRANCH #CP exceptions.

The CPU will generate another missing-ENDBRANCH #CP if the WFE bit
is left as 1, because the indirect branch tracker will be set in
the WAIT_FOR_ENDBRANCH state upon completion of the following ERETS
instruction and the CPU will restart from the IP that just caused a
previous missing-ENDBRANCH #CP.

Clear the WFE bit to avoid dead looping in missing-ENDBRANCH #CP.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/kernel/cet.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index d2c732a34e5d..a095575d4d64 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -81,6 +81,23 @@ static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
 
 static __ro_after_init bool ibt_fatal = true;
 
+/*
+ * The WFE (WAIT_FOR_ENDBRANCH) bit in the augmented CS of FRED stack frame is
+ * set to 1 in missing-ENDBRANCH #CP exceptions.
+ *
+ * If the WFE bit is left as 1, the CPU will generate another missing-ENDBRANCH
+ * #CP because the indirect branch tracker will be set in the WAIT_FOR_ENDBRANCH
+ * state upon completion of the following ERETS instruction and the CPU will
+ * restart from the IP that just caused a previous missing-ENDBRANCH #CP.
+ *
+ * Clear the WFE bit to avoid dead looping due to the above reason.
+ */
+static void ibt_clear_fred_wfe(struct pt_regs *regs)
+{
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		regs->fred_cs.wfe = 0;
+}
+
 static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	if ((error_code & CP_EC) != CP_ENDBR) {
@@ -90,6 +107,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 
 	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)) {
 		regs->ax = 0;
+		ibt_clear_fred_wfe(regs);
 		return;
 	}
 
@@ -97,6 +115,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 	if (!ibt_fatal) {
 		printk(KERN_DEFAULT CUT_HERE);
 		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+		ibt_clear_fred_wfe(regs);
 		return;
 	}
 	BUG();

base-commit: fe85ee391966c4cf3bfe1c405314e894c951f521
-- 
2.46.0


