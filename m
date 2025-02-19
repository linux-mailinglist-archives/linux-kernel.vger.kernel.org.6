Return-Path: <linux-kernel+bounces-522039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16073A3C534
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E0189D6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BA21FECBA;
	Wed, 19 Feb 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m6E47sfs"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E51FCCFD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983011; cv=none; b=TdL6vVNOpW8Xgn/dGbhISLkzn28CwR0s2rWF/IPHrskq3oqqDiEFpoGcxqcVf5obBnwAuA+iJ18/8NnybFOjgwH0V37s74NFpK/V1ymhN8fzuTcyl9zyt0qBObTN0VnetsHDfIrGOKgPsrsCU1yVdGRan06E77jXv3NzlkTo68Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983011; c=relaxed/simple;
	bh=Btti5HdLHNcBRd1KzoFWC5o4jtbV4UKRZPpvGQwFmYs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=onjJCo509PTRHu36nFgV71igltE6sih1MeukfocFSvB7K03svwP/lPwOA6w6WXkJ/OC4Rx2jAQZUsMGcdrCTCxmShfLXq8W21vu0t2In7/VCXQC7nrXiFbjNsX0Vpa03ygUUoPZ9ufsjfmjdcq0996DNIUnrtYSTu8rhmZEl628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m6E47sfs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=EO/UeWnTi587WDLa+KBtfMxZo5oSImtpAx4xhvYuAZk=; b=m6E47sfsI3mOxUXYn2MCWPsrlF
	QJY5qT/vVAzn6xd4Kw1vxZ3s3YXhtmsBHzJMUoagwX1CyZEU4HczkqcxYGnyAQJHf3mS2VZzhm7oC
	qw2SluBt2Xs8N72wXkZP5AfCGwrZ5mTuuRZcC3yCbnFvALzQqmAg/gIqBnjhDYNPeHOgvNlti1L6d
	Z0DL7DaLJWMlZfV5wvh317bF3yG4Qq5Z0jy2+lLSBOczouOkTDr6CFdJtMhQsqDuJGHZBapxQl8Ib
	ByjwaUYq55rZ7KjNruVrwUHRgMRMhfPOXfxvXqih7mknjv9cVfA2ktd5Blxkv5lLMQ7A8QXUzZWwq
	UXiNkDbg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn41-00000002HAU-065T;
	Wed, 19 Feb 2025 16:36:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 113C1306573; Wed, 19 Feb 2025 17:36:43 +0100 (CET)
Message-ID: <20250219163515.150619755@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 19 Feb 2025 17:21:15 +0100
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
Subject: [PATCH v3 08/10] x86: BHI stubs
References: <20250219162107.880673196@infradead.org>
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
@@ -102,6 +102,10 @@ enum cfi_mode {
 extern enum cfi_mode cfi_mode;
 extern bool cfi_warn;
 
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



