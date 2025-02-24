Return-Path: <linux-kernel+bounces-529088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF3A41FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0728169CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84224EF66;
	Mon, 24 Feb 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NlYyERSp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6C21930E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401164; cv=none; b=tJ9qwlKo/P0rOmyfMK+tE5L6ZOq68TUp9BJXpPQIhG1tSb6YflL9RKvRz6epruHIRhYLqGEyJrOWLsEDxC0IIa+q+7pC6u9qgdvXEFcLokJozO5dWBRmcBf9Ab0mv+I0gmAsW9tgYQPbdZykSr9Eec+I3N5UOmMi0ugeeZGFRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401164; c=relaxed/simple;
	bh=fWc+Fuw0k4sUEWKZxXxObCDs5KXrWXOOIuRvUtq9krw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Y1J9nGTFsJZkyhhDtLlfZMfkpv019Gq6tDTlwiiHutzdygy1Wm6MNyzbV21/GP+fC6kCju6yVLd+Q/nD2zLiZukSfvWYj9lwh3A1Omsb5A761WBpPI4YGlkM+Ufqd1R225Ka0Tm6Y73HG9HATkheM047fAvDYTThNkMx78rE+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NlYyERSp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=94t6o8AkyshOtxSEKb/7p5vb1+FDXIF2IGvFBSAPtx4=; b=NlYyERSpwa78hnW4eZ8alLeCqf
	xNA0TMispOirO5dHtwA0gWVbX/Jjc5iSRDmGSNQeLTlltvna81qzIRWJRLu6eYCqm6Nx7xG5vy9zH
	nxuawC/cbyL0uQBTKqWTRABlZlEIR4VrgAsk7WBHFDbLnWRR27uCeURgBE3+5WN+6r31MA9QpnPdP
	3vmp/EFtJ+nPHwuJweerx286cOFWJLyHo1nGxnT3ABltYLSX9roDn+WgulFjl4drrtBXTjCbZovco
	tUmGeDp9La3aIrGH6w1rv45OrJ5qXz9Ex9mveTpMVxeXy7MyEm4Ku85OTdKvUyYu5WG8NgIWR6h+f
	PxrvOU+A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXqN-000000079ml-0jab;
	Mon, 24 Feb 2025 12:45:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2EF61307F02; Mon, 24 Feb 2025 13:45:54 +0100 (CET)
Message-ID: <20250224124200.717378681@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 24 Feb 2025 13:37:11 +0100
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
Subject: [PATCH v4 08/10] x86: BHI stubs
References: <20250224123703.843199044@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cfi.h |    4 +
 arch/x86/lib/Makefile      |    3 
 arch/x86/lib/bhi.S         |  146 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -101,6 +101,10 @@ enum cfi_mode {
 
 extern enum cfi_mode cfi_mode;
 
+typedef u8 bhi_thunk[32];
+extern bhi_thunk __bhi_args[];
+extern bhi_thunk __bhi_args_end[];
+
 struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -66,5 +66,6 @@ endif
         lib-y += clear_page_64.o copy_page_64.o
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o copy_user_uncached_64.o
-	lib-y += cmpxchg16b_emu.o
+        lib-y += cmpxchg16b_emu.o
+        lib-y += bhi.o
 endif
--- /dev/null
+++ b/arch/x86/lib/bhi.S
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/unwind_hints.h>
+#include <asm/nospec-branch.h>
+
+/*
+ * Notably, the FineIBT preamble calling these will have ZF set and r10 zero.
+ *
+ * The very last element is in fact larger than 32 bytes, but since its the
+ * last element, this does not matter,
+ *
+ * There are 2 #UD sites, located between 0,1-2,3 and 4,5-6,7 such that they
+ * can be reached using Jcc.d8, these elements (1 and 5) have sufficiently
+ * big alignment holes for this to not stagger the array.
+ */
+
+.pushsection .noinstr.text, "ax"
+
+	.align 32
+SYM_CODE_START(__bhi_args)
+
+#ifdef CONFIG_FINEIBT_BHI
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_1
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_1, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_1
+	cmovne %r10, %rdi
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 8
+	ANNOTATE_REACHABLE
+.Lud_1:	ud2
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_2, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_1
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_3, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_1
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_4, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_2
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_5, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_2
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 8
+	ANNOTATE_REACHABLE
+.Lud_2:	ud2
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_6, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_2
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_7, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_2
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	cmovne %r10, %rsp
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+#endif /* CONFIG_FINEIBT_BHI */
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
+SYM_CODE_END(__bhi_args)
+
+.popsection



