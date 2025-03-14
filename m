Return-Path: <linux-kernel+bounces-562214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41319A61F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9168D3B869E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50862236F7;
	Fri, 14 Mar 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYPnGvmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BC20765E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988518; cv=none; b=SuVsvEhMj9e0lj7F/EAcwqP512xUp1WXZEaLfLlLaYSFmm7U1c8zXtTFCy/rEWmI5VLew8geJmBzh3CVrfWBSoB8fv9P7eJZNqo+Rquv0dgsPtHmowT+6e3swkGue9a7JESe4QiSSxQm8DWk8Fs4xksI9LqoFznhpSU0gve3dB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988518; c=relaxed/simple;
	bh=izdT47cZGsStDFz27dBAXEaLTeKotz3eSdtzETaRuKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jjoa/oVOnCb5x06LmZiqWww8OYZWxI3m3Xkgq9uJKFFCZvtdlisAH/qPPLaN8C1h7c0ShB2lZ14vxetOEtlYqCUGo4qnPbSxyXmnjX2M+FbFCmDalbGFqaOwud19Bz6pUCq32zQ7p23M7FvuaH8ko931auR66iHgTqFWqp2TKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYPnGvmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1B6C4CEE9;
	Fri, 14 Mar 2025 21:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988518;
	bh=izdT47cZGsStDFz27dBAXEaLTeKotz3eSdtzETaRuKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYPnGvmjb1rKr7Dtg8cvuU76mgwa8M1cFRvcXuIMc6n/yCzSU9oMDeIhwCJzEwHx9
	 pvLD/v7sMr5qynP5SFDusl2tT1B6lVNdd+kKcmekcAQgY84fIh6lDhg2OjUSqs4QTR
	 xo8+NRYavXegAO/OEBvJ6xlRI8DRM2vJTuJ2/dwNAD3zhKvoWs0oeTJkTvO8Ez8s3F
	 Ba/02Piuw4pwXJJtkx70WuljDJWlKw3b78X1HmaG6blxScj9PqVY/6bwTNdvEFUFaT
	 M88I5h4pLh4+XTCoeHwTF4U/32vFyyna0wscwlx7kOtiVshownnwgbUjZLFukB6PoT
	 dKjaMS4134JRw==
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
Subject: [PATCH 08/20] x86/asm: Replace ASM_{OUTPUT,INPUT}() with ARG()
Date: Fri, 14 Mar 2025 14:41:21 -0700
Message-ID: <6a9e1c01f21ba64aefc7082f660615508c3df8f3.1741988314.git.jpoimboe@kernel.org>
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

Replace ASM_OUTPUT() and ASM_INPUT() with ARG().  It provides more
visual separation and vertical alignment, making it easy to distinguish
the outputs, inputs and clobbers.  It will also come in handy for other
inline asm wrappers.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/apic.h          |  2 +-
 arch/x86/include/asm/asm.h           | 11 ++--
 arch/x86/include/asm/atomic64_32.h   | 93 +++++++++++++++-------------
 arch/x86/include/asm/page_64.h       | 12 ++--
 arch/x86/include/asm/segment.h       |  5 +-
 arch/x86/include/asm/special_insns.h |  2 +-
 6 files changed, 67 insertions(+), 58 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index ecf1b229f09b..6526bad6ec81 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -100,7 +100,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 
 	alternative_io("movl %[val], %[mem]",
 		       "xchgl %[val], %[mem]", X86_BUG_11AP,
-		       ASM_OUTPUT([val] "+r" (v), [mem] "+m" (*addr)));
+		       ARG([val] "+r" (v), [mem] "+m" (*addr)));
 }
 
 static inline u32 native_apic_mem_read(u32 reg)
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 619817841f4c..9f0f830628f9 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -212,11 +212,14 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 #define __COMMA(...)		, ##__VA_ARGS__
 
 /*
- * Combine multiple asm inline constraint args into a single arg for passing to
- * another macro.
+ * ARG() can be used to bundle multiple arguments into a single argument for
+ * passing to a macro.
+ *
+ * For inline asm constraint operands, this is recommended even for single
+ * operands as it provides visual separation and vertical alignment similar to
+ * the ':' characters in an inline asm statement.
  */
-#define ASM_OUTPUT(x...)	x
-#define ASM_INPUT(x...)		x
+#define ARG(x...) x
 
 /*
  * This output constraint should be used for any inline asm which has a "call"
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index ab838205c1c6..8775f84222e6 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -59,9 +59,11 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
 #else
 #define __alternative_atomic64(f, g, out, in, clobbers...)		\
-	alternative_call(atomic64_##f##_386, atomic64_##g##_cx8,	\
-			 X86_FEATURE_CX8, ASM_OUTPUT(out),		\
-			 ASM_INPUT(in), clobbers)
+	alternative_call(atomic64_##f##_386,				\
+			 atomic64_##g##_cx8, X86_FEATURE_CX8,		\
+			 ARG(out),					\
+			 ARG(in),					\
+			 ARG(clobbers))
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8); \
 	ATOMIC64_DECL_ONE(sym##_386)
@@ -73,7 +75,7 @@ ATOMIC64_DECL_ONE(dec_386);
 #endif
 
 #define alternative_atomic64(f, out, in, clobbers...) \
-	__alternative_atomic64(f, f, ASM_OUTPUT(out), ASM_INPUT(in), clobbers)
+	__alternative_atomic64(f, f, ARG(out), ARG(in), ARG(clobbers))
 
 ATOMIC64_DECL(read);
 ATOMIC64_DECL(set);
@@ -109,9 +111,9 @@ static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 	unsigned high = (unsigned)(n >> 32);
 	unsigned low = (unsigned)n;
 	alternative_atomic64(xchg,
-			     "=&A" (o),
-			     ASM_INPUT("S" (v), "b" (low), "c" (high)),
-			     "memory");
+			     ARG("=&A" (o)),
+			     ARG("S" (v), "b" (low), "c" (high)),
+			     ARG("memory"));
 	return o;
 }
 #define arch_atomic64_xchg arch_atomic64_xchg
@@ -121,24 +123,27 @@ static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 	unsigned high = (unsigned)(i >> 32);
 	unsigned low = (unsigned)i;
 	alternative_atomic64(set,
-			     /* no output */,
-			     ASM_INPUT("S" (v), "b" (low), "c" (high)),
-			     "eax", "edx", "memory");
+			     ARG(),
+			     ARG("S" (v), "b" (low), "c" (high)),
+			     ARG("eax", "edx", "memory"));
 }
 
 static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 r;
-	alternative_atomic64(read, "=&A" (r), "c" (v), "memory");
+	alternative_atomic64(read,
+			     ARG("=&A" (r)),
+			     ARG("c" (v)),
+			     ARG("memory"));
 	return r;
 }
 
 static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(add_return,
-			     ASM_OUTPUT("+A" (i), "+c" (v)),
-			     /* no input */,
-			     "memory");
+			     ARG("+A" (i), "+c" (v)),
+			     ARG(),
+			     ARG("memory"));
 	return i;
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
@@ -146,9 +151,9 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(sub_return,
-			     ASM_OUTPUT("+A" (i), "+c" (v)),
-			     /* no input */,
-			     "memory");
+			     ARG("+A" (i), "+c" (v)),
+			     ARG(),
+			     ARG("memory"));
 	return i;
 }
 #define arch_atomic64_sub_return arch_atomic64_sub_return
@@ -157,9 +162,9 @@ static __always_inline s64 arch_atomic64_inc_return(atomic64_t *v)
 {
 	s64 a;
 	alternative_atomic64(inc_return,
-			     "=&A" (a),
-			     "S" (v),
-			     "memory", "ecx");
+			     ARG("=&A" (a)),
+			     ARG("S" (v)),
+			     ARG("memory", "ecx"));
 	return a;
 }
 #define arch_atomic64_inc_return arch_atomic64_inc_return
@@ -168,9 +173,9 @@ static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 {
 	s64 a;
 	alternative_atomic64(dec_return,
-			     "=&A" (a),
-			     "S" (v),
-			     "memory", "ecx");
+			     ARG("=&A" (a)),
+			     ARG("S" (v)),
+			     ARG("memory", "ecx"));
 	return a;
 }
 #define arch_atomic64_dec_return arch_atomic64_dec_return
@@ -178,34 +183,34 @@ static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(add, add_return,
-			       ASM_OUTPUT("+A" (i), "+c" (v)),
-			       /* no input */,
-			       "memory");
+			       ARG("+A" (i), "+c" (v)),
+			       ARG(),
+			       ARG("memory"));
 }
 
 static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(sub, sub_return,
-			       ASM_OUTPUT("+A" (i), "+c" (v)),
-			       /* no input */,
-			       "memory");
+			       ARG("+A" (i), "+c" (v)),
+			       ARG(),
+			       ARG("memory"));
 }
 
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	__alternative_atomic64(inc, inc_return,
-			       /* no output */,
-			       "S" (v),
-			       "memory", "eax", "ecx", "edx");
+			       ARG(),
+			       ARG("S" (v)),
+			       ARG("memory", "eax", "ecx", "edx"));
 }
 #define arch_atomic64_inc arch_atomic64_inc
 
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	__alternative_atomic64(dec, dec_return,
-			       /* no output */,
-			       "S" (v),
-			       "memory", "eax", "ecx", "edx");
+			       ARG(),
+			       ARG("S" (v)),
+			       ARG("memory", "eax", "ecx", "edx"));
 }
 #define arch_atomic64_dec arch_atomic64_dec
 
@@ -214,9 +219,9 @@ static __always_inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 	unsigned low = (unsigned)u;
 	unsigned high = (unsigned)(u >> 32);
 	alternative_atomic64(add_unless,
-			     ASM_OUTPUT("+A" (a), "+c" (low), "+D" (high)),
-			     "S" (v),
-			     "memory");
+			     ARG("+A" (a), "+c" (low), "+D" (high)),
+			     ARG("S" (v)),
+			     ARG("memory"));
 	return (int)a;
 }
 #define arch_atomic64_add_unless arch_atomic64_add_unless
@@ -225,9 +230,9 @@ static __always_inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
 	int r;
 	alternative_atomic64(inc_not_zero,
-			     "=&a" (r),
-			     "S" (v),
-			     "ecx", "edx", "memory");
+			     ARG("=&a" (r)),
+			     ARG("S" (v)),
+			     ARG("ecx", "edx", "memory"));
 	return r;
 }
 #define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
@@ -236,9 +241,9 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 r;
 	alternative_atomic64(dec_if_positive,
-			     "=&A" (r),
-			     "S" (v),
-			     "ecx", "memory");
+			     ARG("=&A" (r)),
+			     ARG("S" (v)),
+			     ARG("ecx", "memory"));
 	return r;
 }
 #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index db3003acd41e..0604e9d49221 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -54,9 +54,9 @@ static inline void clear_page(void *page)
 	alternative_call_2(clear_page_orig,
 			   clear_page_rep, X86_FEATURE_REP_GOOD,
 			   clear_page_erms, X86_FEATURE_ERMS,
-			   "=D" (page),
-			   "D" (page),
-			   "cc", "memory", "rax", "rcx");
+			   ARG("=D" (page)),
+			   ARG("D" (page)),
+			   ARG("cc", "memory", "rax", "rcx"));
 }
 
 void copy_page(void *to, void *from);
@@ -87,9 +87,9 @@ static __always_inline unsigned long task_size_max(void)
 
 	alternative_io("movq %[small], %[ret]",
 		       "movq %[large], %[ret]", X86_FEATURE_LA57,
-			[ret] "=r" (ret),
-			[small] "i" ((1ul << 47)-PAGE_SIZE),
-			[large] "i" ((1ul << 56)-PAGE_SIZE));
+			ARG([ret] "=r" (ret)),
+			ARG([small] "i" ((1ul << 47)-PAGE_SIZE),
+			    [large] "i" ((1ul << 56)-PAGE_SIZE)));
 
 	return ret;
 }
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 9d6411c65920..32b1aa9f721b 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -254,10 +254,11 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 	 *
 	 * If RDPID is available, use it.
 	 */
-	alternative_io ("lsl %[seg],%[p]",
+	alternative_io("lsl %[seg],%[p]",
 			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
 			X86_FEATURE_RDPID,
-			[p] "=a" (p), [seg] "r" (__CPUNODE_SEG));
+			ARG([p] "=a" (p)),
+			ARG([seg] "r" (__CPUNODE_SEG)));
 
 	if (cpu)
 		*cpu = (p & VDSO_CPUNODE_MASK);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 9c1cc0ef8f3c..a6a3f4c95f03 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -178,7 +178,7 @@ static inline void clflushopt(volatile void *__p)
 {
 	alternative_io(".byte 0x3e; clflush %[val]",
 		       ".byte 0x66; clflush %[val]", X86_FEATURE_CLFLUSHOPT,
-		       [val] "+m" (*(volatile char __force *)__p));
+		       ARG([val] "+m" (*(volatile char __force *)__p)));
 }
 
 static inline void clwb(volatile void *__p)
-- 
2.48.1


