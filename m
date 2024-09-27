Return-Path: <linux-kernel+bounces-342131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646E988AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5EFB2423B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530CF1C2DCF;
	Fri, 27 Sep 2024 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hk2Tlov0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C941714B8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466655; cv=none; b=G0D19116BuqOsu7cI/EPS1K6EtM2LooZLfIECRX1s3K46hfHhB9TE5n+zzoDQPhWsFeU3rX4hdYvJ8OdIk4fowVawFj/Ji2R4b8C06NAZdq/kLaI0mx/46EVw8hd5xBlolAlOKMl9dpeR0rRL0o85xJy79/xLi9pNSgX46+iwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466655; c=relaxed/simple;
	bh=Qfj5skINFFABCKIJM2jyxqp/bgXcco5fHnAGbxuyFzY=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jvAbayifBWjBKq8IN1fMiIv9dfQaq361PNoBVCW7Tf+iqvesOqHhuRg9CqcCz3zEZyMGV6AFcWygrWlrxiLTzX6M3EYkA81bk9WhpCabLiHn0mjfxYEQLhvPi8Fa3ZXeZUWPgSkjbBES769ZkyzQd2BeVSxk/NpBeX39tJTRzFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hk2Tlov0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=DYk/ii3NJ1TG/DXWXke3E5hmJXxv8Z/BRxQS68QUbZ4=; b=hk2Tlov0XA7JH9ceId///4cjZw
	7s3wL/Hto5DU5WKOg6gtGeFw5+GoRDGqnTluE8PFO/abntRxPWfnGvtFINroI+nl3+WKXt3xmNUwY
	aDj7GV+JrzzXxGsSJ6+nuCfNg27geD0t2BbID4Sm6s7v4NXNYJlidXNpsV+FMP2l+V5wk7Bkfy9tW
	yuHo9fblWkds/FV6PM1p4bcG6E5aGBwoORYh1OKnMHMEn7Rc8VH5qwQ4HUs7zM85Ecq3GK/39Juab
	1lzFA7ThNf2VPRLY0GcQsHBtVQ4z/dymWjLPMlDxAWOoz4Ns54nve3o6yD4aPk+a+bG2KhjzhCLUE
	RfPz7J9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzG-0000000AVcy-3Ey6;
	Fri, 27 Sep 2024 19:50:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DA676308CC6; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194925.707462984@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:09 +0200
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
 alexei.starovoitov@gmail.com
Subject: [PATCH 13/14] x86: BHI stubs
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Mostly generated combinatorical stubs used to poison function
argument pointers.

Notably, since this targets eIBRS parts which do not suffer from
retbleed, use normal return instructions to save some space.

In total: 6c1 + 6c2 + 6c3 + 6c4 + 1 = 6 + 15 + 20 + 15 + 1 = 57 stubs.

Note: Scott said only 0.6% of the kernel functions take 5 or more
pointer arguments, if any of those turns out to be performance
critical, we can add more stubs.

Note: the nested for loops are horrid, should be fixed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cfi.h    |   11 
 arch/x86/kernel/alternative.c |   94 ++++++
 arch/x86/lib/Makefile         |    1 
 arch/x86/lib/bhi.S            |  602 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 708 insertions(+)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -101,6 +101,17 @@ enum cfi_mode {
 
 extern enum cfi_mode cfi_mode;
 
+typedef u8 bhi_thunk_8[8];
+typedef u8 bhi_thunk_16[16];
+typedef u8 bhi_thunk_32[32];
+
+extern bhi_thunk_8  __bhi_args_6c1[];
+extern bhi_thunk_16 __bhi_args_6c2[];
+extern bhi_thunk_16 __bhi_args_6c3[];
+extern bhi_thunk_32 __bhi_args_6c4[];
+
+extern u8 __bhi_args_all[];
+
 struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1039,10 +1039,104 @@ u32 cfi_get_func_hash(void *func)
 
 	return hash;
 }
+
 #endif
 
 #ifdef CONFIG_FINEIBT
 
+static void *bhi_args_1(u8 args, void *addr)
+{
+	u8 bytes[5];
+
+	for (int i = 0; i < 6; i++) {
+		if (args != BIT(i))
+			continue;
+
+		bytes[0] = 0x2e;
+		memcpy(&bytes[1], &__bhi_args_6c1[i], 4);
+
+		text_poke_early(addr, bytes, 5);
+
+		return NULL;
+	}
+
+	return __bhi_args_all;
+}
+
+static void *bhi_args_2(u8 args, void *addr)
+{
+	int x = 0;
+
+	for (int i = 0; i < 6; i++) {
+		for (int j = i + 1; j < 6; j++) {
+			if (args == (BIT(i) | BIT(j)))
+				return &__bhi_args_6c2[x];
+			x++;
+		}
+	}
+
+	return __bhi_args_all;
+}
+
+static void *bhi_args_3(u8 args, void *addr)
+{
+	int x = 0;
+
+	for (int i = 0; i < 6; i++) {
+		for (int j = i + 1; j < 6; j++) {
+			for (int k = j + 1; k < 6; k++) {
+				if (args == (BIT(i) | BIT(j) | BIT(k)))
+					return &__bhi_args_6c3[x];
+				x++;
+			}
+		}
+	}
+
+	return __bhi_args_all;
+}
+
+static void *bhi_args_4(u8 args, void *addr)
+{
+	int x = 0;
+
+	for (int i = 0; i < 6; i++) {
+		for (int j = i + 1; j < 6; j++) {
+			for (int k = j + 1; k < 6; k++) {
+				for (int l = k + 1; l < 6; l++) {
+					if (args == (BIT(i) | BIT(j) | BIT(k) | BIT(l)))
+						return &__bhi_args_6c4[x];
+					x++;
+				}
+			}
+		}
+	}
+
+	return __bhi_args_all;
+}
+
+static void bhi_args(u8 args, void *addr)
+{
+	void *dest = __bhi_args_all;
+
+	if (WARN_ON_ONCE(!args))
+		return;
+
+	switch(hweight8(args)) {
+	case 1: if (bhi_args_1(args, addr) == dest)
+			break;
+		return;
+
+	case 2: dest = bhi_args_2(args, addr); break;
+	case 3: dest = bhi_args_3(args, addr); break;
+	case 4: dest = bhi_args_4(args, addr); break;
+
+	default:
+		break;
+	}
+
+	text_poke_early(addr, text_gen_insn(CALL_INSN_OPCODE, addr, dest), 5);
+}
+
 static bool cfi_rand __ro_after_init = true;
 static u32  cfi_seed __ro_after_init;
 
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -60,4 +60,5 @@ endif
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o copy_user_uncached_64.o
 	lib-y += cmpxchg16b_emu.o
+	lib-y += bhi.o
 endif
--- /dev/null
+++ b/arch/x86/lib/bhi.S
@@ -0,0 +1,602 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/unwind_hints.h>
+#include <asm/nospec-branch.h>
+
+/*
+ * At the function start, launder function arguments that are a pointer through
+ * CMOVcc, this will create a write dependency in the speculation flow.
+ *
+ * Notably, the CFI preambles calling these will have ZF set and r10 zero.
+ */
+
+.pushsection .noinstr.text, "ax"
+
+	.align 8
+SYM_CODE_START(__bhi_args_6c1)
+	ANNOTATE_NOENDBR
+	.align 8
+SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 8
+SYM_INNER_LABEL(__bhi_args_1, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 8
+SYM_INNER_LABEL(__bhi_args_2, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 8
+SYM_INNER_LABEL(__bhi_args_3, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 8
+SYM_INNER_LABEL(__bhi_args_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 8
+SYM_INNER_LABEL(__bhi_args_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+SYM_CODE_END(__bhi_args_6c1)
+
+
+	.align 16
+SYM_CODE_START(__bhi_args_6c2)
+	ANNOTATE_NOENDBR
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_1, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_2, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rdx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_3, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_1_2, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_1_3, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_1_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_1_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_2_3, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_2_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_2_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_3_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_3_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rcx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+SYM_CODE_END(__bhi_args_6c2)
+
+
+	.align 16
+SYM_CODE_START(__bhi_args_6c3)
+	ANNOTATE_NOENDBR
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_1_2, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_1_3, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_1_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_1_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_2_3, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_2_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rdx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_2_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rdx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_3_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_3_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rcx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_0_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_1_2_3, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_1_2_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_1_2_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_1_3_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_1_3_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rcx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_1_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_2_3_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_2_3_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_2_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 16
+SYM_INNER_LABEL(__bhi_args_3_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+SYM_CODE_END(__bhi_args_6c3)
+
+
+	.align 32
+SYM_CODE_START(__bhi_args_6c4)
+	ANNOTATE_NOENDBR
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0_1_2_3, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0_1_2_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0_1_2_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0_1_3_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0_1_3_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rcx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0_1_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0_2_3_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0_2_3_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0_2_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rdx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0_3_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdi
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_1_2_3_4, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_1_2_3_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_1_2_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_1_3_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rsi
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_2_3_4_5, SYM_L_LOCAL)
+	UNWIND_HINT_FUNC
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+SYM_CODE_END(__bhi_args_6c4)
+
+SYM_CODE_START(__bhi_args_all)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
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
+SYM_CODE_END(__bhi_args_all)
+
+.popsection



