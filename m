Return-Path: <linux-kernel+bounces-562210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C19A61F42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184F23BC5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D81F2066FB;
	Fri, 14 Mar 2025 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUp7OH/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5682066C2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988517; cv=none; b=qChsBf3JPlQ61ntGk6dkDgcSImyGMN2DHIICyg3p5AyoBu2DKffLjdS82ZcEQ9SwOehQ1Ik0hkc9PUClHfCsFRCTr5ldxG1yS5RlROqhwdDpaZAxMkqACYyPGGO2Ugr9kkPnb37Wpffup4jWDnK4u0CIA0saxexb/xIki5fkWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988517; c=relaxed/simple;
	bh=9bFRJxqvYNWVyNVhYDN2ROid6vXuKvJ2yw7P62LLCcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr3p0p5UfFf5fc/XWQymvhS9bigsYCESq9zaeHal3PNf1qu70uCc/RKApOJoX9DpG8KSFpURelwcoNPhCQBa0vOs5NWEeDcB4wi2vsMybpGfkn/Ia5lle08B/GL3NtfRMKBP3GpYW3hHIPdwg//bnF+tsXNmzakVXH+LYMiybtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUp7OH/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F30C4CEF7;
	Fri, 14 Mar 2025 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988516;
	bh=9bFRJxqvYNWVyNVhYDN2ROid6vXuKvJ2yw7P62LLCcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUp7OH/39b6sNPnYwE4gpkcHGGW9Tfhh3jWiBFOG61hF8PW+liIFkZhRjq9Hucrz7
	 RjS+4ZISBZz6JtGxpobwJNxhthALCDeZv3k3TPbY9JGieRsmcYh6MVC5x0DZUssbJV
	 ww1N/lOughfmuevn48V/bTXyVty27fdbaCl08mdns23bRAvbdLDbQAf7jXprcltNLI
	 RiSMi1dYR6mhqgoXGLHVGZ5LYSGgiwp/FYTFN5K2DkStrBZKAfb6TA/tlpEMYjVgZD
	 PLRT19y/k+QzgTDexDuKQR71Ua8NgPVKMYmcLk5z1EJjJBIkh6FUs6PEP1FLkQZady
	 yeYOXE9veAnvg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 05/20] x86/asm: Always use flag output operands
Date: Fri, 14 Mar 2025 14:41:18 -0700
Message-ID: <9bd607a5a8b79f1349f09b4e92270aeb8acd6b43.1741988314.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741988314.git.jpoimboe@kernel.org>
References: <cover.1741988314.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86, __GCC_ASM_FLAG_OUTPUTS__ is supported starting with GCC 6.0 and
Clang 9.

Now that the GCC minimum version on x86 has been bumped to 8.1 with the
following commit:

  commit a3e8fe814ad1 ("x86/build: Raise the minimum GCC version to 8.1")

the flag output operand support can be assumed everywhere.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/asm.h        |  9 ++-------
 arch/x86/include/asm/rmwcc.h      | 22 ----------------------
 tools/arch/x86/include/asm/asm.h  |  5 -----
 tools/perf/bench/find-bit-bench.c |  4 ----
 4 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 975ae7a9397e..fdebd4356860 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -131,13 +131,8 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
  * Macros to generate condition code outputs from inline assembly,
  * The output operand must be type "bool".
  */
-#ifdef __GCC_ASM_FLAG_OUTPUTS__
-# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
-# define CC_OUT(c) "=@cc" #c
-#else
-# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
-# define CC_OUT(c) [_cc_ ## c] "=qm"
-#endif
+#define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
+#define CC_OUT(c) "=@cc" #c
 
 #ifdef __KERNEL__
 
diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index 363266cbcada..a54303e3dfa1 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -6,26 +6,6 @@
 
 #define __CLOBBERS_MEM(clb...)	"memory", ## clb
 
-#ifndef __GCC_ASM_FLAG_OUTPUTS__
-
-/* Use asm goto */
-
-#define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
-({									\
-	bool c = false;							\
-	asm goto (fullop "; j" #cc " %l[cc_label]"		\
-			: : [var] "m" (_var), ## __VA_ARGS__		\
-			: clobbers : cc_label);				\
-	if (0) {							\
-cc_label:	c = true;						\
-	}								\
-	c;								\
-})
-
-#else /* defined(__GCC_ASM_FLAG_OUTPUTS__) */
-
-/* Use flags output or a set instruction */
-
 #define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
 ({									\
 	bool c;								\
@@ -35,8 +15,6 @@ cc_label:	c = true;						\
 	c;								\
 })
 
-#endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) */
-
 #define GEN_UNARY_RMWcc_4(op, var, cc, arg0)				\
 	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM())
 
diff --git a/tools/arch/x86/include/asm/asm.h b/tools/arch/x86/include/asm/asm.h
index 3ad3da9a7d97..f66cf34f6197 100644
--- a/tools/arch/x86/include/asm/asm.h
+++ b/tools/arch/x86/include/asm/asm.h
@@ -112,13 +112,8 @@
  * Macros to generate condition code outputs from inline assembly,
  * The output operand must be type "bool".
  */
-#ifdef __GCC_ASM_FLAG_OUTPUTS__
 # define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
 # define CC_OUT(c) "=@cc" #c
-#else
-# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
-# define CC_OUT(c) [_cc_ ## c] "=qm"
-#endif
 
 #ifdef __KERNEL__
 
diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 7e25b0e413f6..99d36dff9d86 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -37,7 +37,6 @@ static noinline void workload(int val)
 	accumulator++;
 }
 
-#if (defined(__i386__) || defined(__x86_64__)) && defined(__GCC_ASM_FLAG_OUTPUTS__)
 static bool asm_test_bit(long nr, const unsigned long *addr)
 {
 	bool oldbit;
@@ -48,9 +47,6 @@ static bool asm_test_bit(long nr, const unsigned long *addr)
 
 	return oldbit;
 }
-#else
-#define asm_test_bit test_bit
-#endif
 
 static int do_for_each_set_bit(unsigned int num_bits)
 {
-- 
2.48.1


