Return-Path: <linux-kernel+bounces-331003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C246197A724
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CDFFB236BE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDB015B149;
	Mon, 16 Sep 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CtQcxx7h"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC4A95E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726510247; cv=none; b=sntbuRx1ZiFQ9ZAFQT7BLHZp6AfAhQexeaIXY10AcsvnD2wzlw1077FhfLc1G2dtvpHsGfpWuFySfLZNxsEQCzmycE3bKl+tkUvDbUB1Nz9le8mwu/Wnmg15bt4FAl12AfK+nQ+rfnhtNg5RBgKVoQGyu5MLiuGgMvm6+D7BYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726510247; c=relaxed/simple;
	bh=7h72NlZcMJYtEx0qZGMCppeuDTUtLuP2KeWn1WDTH40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=od5N3vGkO2NyAWHd/FGMVacn7IiKrASnY/MAIrr7LQKqBQKKiMPXQqvLyiuIsa4e8utxDwYAYJtqzG+qJtEh7g+n5LOl1U/cysZsmUkRhyucNG8aI0I0IHAMCZ3f1LRUonnfBO6gjvFyGplOBnXBRISJpqSAcOYE26G1gM+QTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CtQcxx7h; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 48GIA1Eg416546
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 16 Sep 2024 11:10:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 48GIA1Eg416546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1726510205;
	bh=9W2T5PifLvHdFATzgiVfjwmAJK/VBp2QmMSmVMuPlNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CtQcxx7hlkHZlMrB/kG79fsHr4VgahYYanfom89tShfv7xMZQxe0vA1wH8HSWxI7H
	 Wutd/jmEH1UKlrdhowLkwdpXK84acKpDXJVbJ0kCPrWWHxjpK2K4nLD6Lj78TPN6Jr
	 3jwW5XwlGCXo8lsXwaiNtoyagBuAp9fX0IuMqsMh1b0xVyXVWFHyGd6/I3skmm4x18
	 0Rvh/1RQvz63ISur/RvOKP1h6HF46kfUE14r0LQRdmFhFd+SCqU8rKgEudcAu7thAH
	 BAGajTYvowlVkBOmJjsw3LWtguPBLaPsoNvLFB6xTy3Ave07QEKL6FEYMsqqmbJw8h
	 9nt3VuXpEuoSQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com
Subject: [PATCH v2 1/1] x86/fred: Clear WFE in missing-ENDBRANCH #CPs
Date: Mon, 16 Sep 2024 11:10:00 -0700
Message-ID: <20240916181000.416513-1-xin@zytor.com>
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
is left set, because the CPU IBT will be set in the WFE state upon
completion of the following ERETS instruction and then the CPU will
resume from the instruction that just caused the previous #CP.

Clear WFE to avoid dead looping in missing-ENDBRANCH #CPs.

Describe the IBT story in the comment of ibt_clear_fred_wfe() using
Andrew Cooper's write-up.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Changes since v1:
* Rewrite the comment of ibt_clear_fred_wfe() using Andrew Cooper's
  write-up (Andrew Cooper).
* Unconditionally clear WFE in missing-ENDBRANCH #CPs (Peter Zijlstra).
* Don't check X86_FEATURE_FRED in ibt_clear_fred_wfe() (Dave Hansen &
  Andrew Cooper).
---
 arch/x86/kernel/cet.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index d2c732a34e5d..d2cf6ee0d9a0 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -81,6 +81,36 @@ static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
 
 static __ro_after_init bool ibt_fatal = true;
 
+/*
+ * By definition, all missing-ENDBRANCH #CPs are a result of WFE && !ENDBR.
+ *
+ * But, in original CET under IDT delivery, any transfer for
+ * interrupt/exception/etc that does not change privilege will clobber the
+ * WFE state because MSR_{U,S}_CET.WFE is intentionally set by microcode so
+ * as to expect to find an ENDBR at the interrupt/exception/syscall entrypoint.
+ *
+ * In practice, this means interrupts and exceptions hitting the kernel, or
+ * user interrupts, lose the WFE state of the interrupted context.  And
+ * yes, this means that a well timed interrupt (to the precise instruction
+ * boundary) will let an attacker sneak a bad function pointer past the
+ * CET-IBT enforcement.
+ *
+ * In FRED, the WFE state of the interrupted context (even if it is the
+ * same privilege) is preserved and restored, in order to close this hole.
+ *
+ * Therefore, the missing-ENDBRANCH #CP handler needs to clear WFE to avoid
+ * dead looping, now that FRED is causing the state not to get lost.  Otherwise
+ * if the WFE bit is left set in an intentional ibt selftest or when !ibt_fatal,
+ * the CPU will generate another missing-ENDBRANCH #CP because the IBT will be
+ * set in the WFE state upon completion of the following ERETS instruction and
+ * then the CPU will resume from the instruction that just caused the previous
+ * missing-ENDBRANCH #CP.
+ */
+static void ibt_clear_fred_wfe(struct pt_regs *regs)
+{
+	regs->fred_cs.wfe = 0;
+}
+
 static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	if ((error_code & CP_EC) != CP_ENDBR) {
@@ -88,6 +118,8 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 		return;
 	}
 
+	ibt_clear_fred_wfe(regs);
+
 	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)) {
 		regs->ax = 0;
 		return;

base-commit: fe85ee391966c4cf3bfe1c405314e894c951f521
-- 
2.46.0


