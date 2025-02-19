Return-Path: <linux-kernel+bounces-522048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF66A3C52C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D371171336
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E729020CCE5;
	Wed, 19 Feb 2025 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="icstvHM6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A531FDA9D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983013; cv=none; b=iv2FKNAdBWQEBWN78rt3gJWMOZEULrVVmEjyzfjJFGXWql+KZp31fUOl9FvZ891Gv/9UOPWcCTxDW3+Web/VrugPJ4pqq0uEiQr8qJbuTL7aYhs9GS4sJvzouKMPYXfdk7iO4ZIMK1rNlDfvvjUPVF9EHer+4tTxr+xwfECNHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983013; c=relaxed/simple;
	bh=vDtfpVS7JsMghIsD5j58iOIqHJHa3Hky7Gqd6rSqidY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GTMw64P/Sh+W1giK1/D4zvZ0vTMJzWh4SiwjhYAmrcZb+zrgOHm3tsbILVCClgz8ewkf0KDPcas74gYD55SGWdgjWjfPE1JWNE53U2jhBDVK78rJXsCMCRmiNmzs92fx+JpqA2PWvscaxe6S0rV1aeXQK+V9aH1Ozlr8F2TZodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=icstvHM6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=4gavA9yGarxIk7e0bFuvMl3MjG58bvR3QzZc+2BZfSQ=; b=icstvHM6RG32kIawRuDSqrrKVk
	7FPvn/ZNbpra7ukMgtjgDQjMn/RLg9WgoKyRuQliLnVq+1A1e0pAQfY8nZ+Ib/jJWWoepFV6hnG4b
	pxcur5KAbvoyPkChjiQX6e8L6UFHhCas85NKSV+6Sp3MpEsH9wNBQmjgCNaQCvKBcyHo7cvwwnZGi
	hoG5S9WVyUZ4cl6X20b4+wCJWGMFxEg9F3UnRZ2MPHRBMS2lweLo4uRMekhzyEfmO24+HP/d1gUlt
	uuzzTwKQ19XEyxQraEOUheEtKDgTnfhSdv4vNEmvY6nQPuz8uWXhaPj+1SVDd8JWGD+UXmrS4rA1E
	50XnRK8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn40-00000006Whk-2OwH;
	Wed, 19 Feb 2025 16:36:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0A57F3021DF; Wed, 19 Feb 2025 17:36:43 +0100 (CET)
Message-ID: <20250219163514.928125334@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 19 Feb 2025 17:21:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com,
 mhiramat@kernel.org,
 jmill@asu.edu
Subject: [PATCH v3 06/10] x86/traps: Decode LOCK Jcc.d8 #UD
References: <20250219162107.880673196@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Because overlapping code sequences are all the rage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h |    2 ++
 arch/x86/kernel/traps.c    |   30 +++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -17,6 +17,7 @@
  * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
  */
 #define INSN_ASOP		0x67
+#define INSN_LOCK		0xf0
 #define OPCODE_ESCAPE		0x0f
 #define SECOND_BYTE_OPCODE_UD1	0xb9
 #define SECOND_BYTE_OPCODE_UD2	0x0b
@@ -26,6 +27,7 @@
 #define BUG_UD1			0xfffd
 #define BUG_UD1_UBSAN		0xfffc
 #define BUG_EA			0xffea
+#define BUG_LOCK		0xfff0
 
 #ifdef CONFIG_GENERIC_BUG
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -97,6 +97,7 @@ __always_inline int is_valid_bugaddr(uns
  * If it's a UD1, further decode to determine its use:
  *
  * FineIBT:      ea                      (bad)
+ * FineIBT:      0f 75 f9                lock jne . - 6
  * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
  * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
  * static_call:  0f b9 cc                ud1    %esp,%ecx
@@ -106,6 +107,7 @@ __always_inline int is_valid_bugaddr(uns
 __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 {
 	unsigned long start = addr;
+	bool lock = false;
 	u8 v;
 
 	if (addr < TASK_SIZE_MAX)
@@ -114,12 +116,29 @@ __always_inline int decode_bug(unsigned
 	v = *(u8 *)(addr++);
 	if (v == INSN_ASOP)
 		v = *(u8 *)(addr++);
-	if (v == 0xea) {
+
+	if (v == INSN_LOCK) {
+		lock = true;
+		v = *(u8 *)(addr++);
+	}
+
+	switch (v) {
+	case 0x70 ... 0x7f: /* Jcc.d8 */
+		addr += 1; /* d8 */
+		*len = addr - start;
+		WARN_ON_ONCE(!lock);
+		return BUG_LOCK;
+
+	case 0xea:
 		*len = addr - start;
 		return BUG_EA;
-	}
-	if (v != OPCODE_ESCAPE)
+
+	case OPCODE_ESCAPE:
+		break;
+
+	default:
 		return BUG_NONE;
+	}
 
 	v = *(u8 *)(addr++);
 	if (v == SECOND_BYTE_OPCODE_UD2) {
@@ -315,7 +334,8 @@ static noinstr bool handle_bug(struct pt
 
 	switch (ud_type) {
 	case BUG_EA:
-		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
+	case BUG_LOCK:
+		if (handle_cfi_failure(ud_type, regs) == BUG_TRAP_TYPE_WARN) {
 			if (regs->ip == addr)
 				regs->ip += ud_len;
 			handled = true;
@@ -324,7 +344,7 @@ static noinstr bool handle_bug(struct pt
 
 	case BUG_UD2:
 		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
-		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
+		    handle_cfi_failure(ud_type, regs) == BUG_TRAP_TYPE_WARN) {
 			if (regs->ip == addr)
 				regs->ip += ud_len;
 			handled = true;



