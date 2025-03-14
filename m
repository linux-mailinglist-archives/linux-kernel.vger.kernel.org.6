Return-Path: <linux-kernel+bounces-562212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F5A61F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B63A1891D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100F820767B;
	Fri, 14 Mar 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgdR6p1T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F912066D8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988517; cv=none; b=GtiZDDINIYcoNqQoYaDGeyg3yzyBLGicWK3Bg9IcIDdC+fTnQiO0HoXnryfgpktviZcieLk7RiHEc8vDQ6WAnZc44o9fjyCg7NlYd8kuJ6QIYeKwAoBJXcI+CAVwRPT0Qetwu+nZ8C2kO6nOgBwXwowwuyoOjH4J7kL/ftTwlxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988517; c=relaxed/simple;
	bh=PorFgzHa3n8AH+cjYhe35ak5zLtn6Ejf+tmiPWhyFTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRAPUbCwdVe9EDRY3sYxlNRtX1Lq6TCphxBLXdr6pbyeCM5l6ujBWu3Lm7t0okyJYWDEvPp3twi3j6HpH7NehQyyBtV64lFxff6oKT0g8Au6O4Leg76CNvSozL/ZAz7g8XIpBuGn8cpKSS9Ky43PKSt0dwDBzNh7tM03w95vVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgdR6p1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B804C4CEEC;
	Fri, 14 Mar 2025 21:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988517;
	bh=PorFgzHa3n8AH+cjYhe35ak5zLtn6Ejf+tmiPWhyFTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgdR6p1TECz+YGqfj6v6YyPW5STgoCoI0XNknQCI0U5rHtSeMZU2lI3BXvGvfX5aX
	 p+p7iyMcsc80jcrLxLYYYFNSZcyJZEhBpN7GN9O7djjfHoqG9uv1q6eq3rXMDjjHJd
	 ght+1RyjIIcttfB+kkHzY2UbrrnJWjYlqoTs2IgYu+0ofn201iPD2xq0IkulUbUZSB
	 tcz0FMOwAzJk6Jt8ErrpJjBq5g3gTGdzDXuBor+492w5JA3mKTA5dptnrDSb58ONT8
	 ucqTPd/DYs5DVQpiVSk0MK/TQnxxF93yBR8eb/Zmvy6sX1jyUwPKPidcAe8QsO/rhr
	 QhbwxnFltrUUA==
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
Subject: [PATCH 06/20] x86/asm: Remove CC_SET()
Date: Fri, 14 Mar 2025 14:41:19 -0700
Message-ID: <fc92a93060fe0f17bbc9fcb2d447463fd3f9296c.1741988314.git.jpoimboe@kernel.org>
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

Now that flag output operands are unconditionally supported, CC_SET() is
just a comment.  Remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/boot/bitops.h               | 2 +-
 arch/x86/boot/boot.h                 | 4 ++--
 arch/x86/boot/string.c               | 2 +-
 arch/x86/include/asm/archrandom.h    | 2 --
 arch/x86/include/asm/asm.h           | 3 +--
 arch/x86/include/asm/bitops.h        | 6 ------
 arch/x86/include/asm/cmpxchg.h       | 4 ----
 arch/x86/include/asm/cmpxchg_32.h    | 2 --
 arch/x86/include/asm/cmpxchg_64.h    | 1 -
 arch/x86/include/asm/percpu.h        | 4 ----
 arch/x86/include/asm/rmwcc.h         | 2 +-
 arch/x86/include/asm/sev.h           | 1 -
 arch/x86/include/asm/signal.h        | 2 +-
 arch/x86/include/asm/special_insns.h | 1 -
 arch/x86/include/asm/uaccess.h       | 1 -
 tools/arch/x86/include/asm/asm.h     | 5 ++---
 16 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
index 8518ae214c9b..4f773e0957b0 100644
--- a/arch/x86/boot/bitops.h
+++ b/arch/x86/boot/bitops.h
@@ -27,7 +27,7 @@ static inline bool variable_test_bit(int nr, const void *addr)
 	bool v;
 	const u32 *p = addr;
 
-	asm("btl %2,%1" CC_SET(c) : CC_OUT(c) (v) : "m" (*p), "Ir" (nr));
+	asm("btl %2,%1" : CC_OUT(c) (v) : "m" (*p), "Ir" (nr));
 	return v;
 }
 
diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 0f24f7ebec9b..a35823039847 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -155,14 +155,14 @@ static inline void wrgs32(u32 v, addr_t addr)
 static inline bool memcmp_fs(const void *s1, addr_t s2, size_t len)
 {
 	bool diff;
-	asm volatile("fs; repe; cmpsb" CC_SET(nz)
+	asm volatile("fs; repe; cmpsb"
 		     : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
 static inline bool memcmp_gs(const void *s1, addr_t s2, size_t len)
 {
 	bool diff;
-	asm volatile("gs; repe; cmpsb" CC_SET(nz)
+	asm volatile("gs; repe; cmpsb"
 		     : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 84f7a883ce1e..c0cc6d1a7030 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -32,7 +32,7 @@
 int memcmp(const void *s1, const void *s2, size_t len)
 {
 	bool diff;
-	asm("repe; cmpsb" CC_SET(nz)
+	asm("repe; cmpsb"
 	    : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 02bae8e0758b..813a99b6ec7b 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -23,7 +23,6 @@ static inline bool __must_check rdrand_long(unsigned long *v)
 	unsigned int retry = RDRAND_RETRY_LOOPS;
 	do {
 		asm volatile("rdrand %[out]"
-			     CC_SET(c)
 			     : CC_OUT(c) (ok), [out] "=r" (*v));
 		if (ok)
 			return true;
@@ -35,7 +34,6 @@ static inline bool __must_check rdseed_long(unsigned long *v)
 {
 	bool ok;
 	asm volatile("rdseed %[out]"
-		     CC_SET(c)
 		     : CC_OUT(c) (ok), [out] "=r" (*v));
 	return ok;
 }
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index fdebd4356860..619817841f4c 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -128,10 +128,9 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 #endif
 
 /*
- * Macros to generate condition code outputs from inline assembly,
+ * Generate condition code outputs from inline assembly.
  * The output operand must be type "bool".
  */
-#define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
 #define CC_OUT(c) "=@cc" #c
 
 #ifdef __KERNEL__
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b96d45944c59..67b86e7c1ea3 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -99,7 +99,6 @@ static __always_inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 {
 	bool negative;
 	asm volatile(LOCK_PREFIX "xorb %2,%1"
-		CC_SET(s)
 		: CC_OUT(s) (negative), WBYTE_ADDR(addr)
 		: "iq" ((char)mask) : "memory");
 	return negative;
@@ -149,7 +148,6 @@ arch___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 	bool oldbit;
 
 	asm(__ASM_SIZE(bts) " %2,%1"
-	    CC_SET(c)
 	    : CC_OUT(c) (oldbit)
 	    : ADDR, "Ir" (nr) : "memory");
 	return oldbit;
@@ -175,7 +173,6 @@ arch___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 	bool oldbit;
 
 	asm volatile(__ASM_SIZE(btr) " %2,%1"
-		     CC_SET(c)
 		     : CC_OUT(c) (oldbit)
 		     : ADDR, "Ir" (nr) : "memory");
 	return oldbit;
@@ -187,7 +184,6 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 	bool oldbit;
 
 	asm volatile(__ASM_SIZE(btc) " %2,%1"
-		     CC_SET(c)
 		     : CC_OUT(c) (oldbit)
 		     : ADDR, "Ir" (nr) : "memory");
 
@@ -211,7 +207,6 @@ static __always_inline bool constant_test_bit_acquire(long nr, const volatile un
 	bool oldbit;
 
 	asm volatile("testb %2,%1"
-		     CC_SET(nz)
 		     : CC_OUT(nz) (oldbit)
 		     : "m" (((unsigned char *)addr)[nr >> 3]),
 		       "i" (1 << (nr & 7))
@@ -225,7 +220,6 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
 	bool oldbit;
 
 	asm volatile(__ASM_SIZE(bt) " %2,%1"
-		     CC_SET(c)
 		     : CC_OUT(c) (oldbit)
 		     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
 
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index fd8afc1f5f6b..e801dc982a64 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -166,7 +166,6 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u8 *__ptr = (volatile u8 *)(_ptr);		\
 		asm volatile(lock "cmpxchgb %[new], %[ptr]"		\
-			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
@@ -178,7 +177,6 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u16 *__ptr = (volatile u16 *)(_ptr);		\
 		asm volatile(lock "cmpxchgw %[new], %[ptr]"		\
-			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
@@ -190,7 +188,6 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u32 *__ptr = (volatile u32 *)(_ptr);		\
 		asm volatile(lock "cmpxchgl %[new], %[ptr]"		\
-			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
@@ -202,7 +199,6 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u64 *__ptr = (volatile u64 *)(_ptr);		\
 		asm volatile(lock "cmpxchgq %[new], %[ptr]"		\
-			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 6d7afee2fa07..50f973ca635d 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -46,7 +46,6 @@ static __always_inline u64 __cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new
 	bool ret;							\
 									\
 	asm volatile(_lock "cmpxchg8b %[ptr]"				\
-		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
@@ -125,7 +124,6 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 		ALTERNATIVE(_lock_loc					\
 			    "call cmpxchg8b_emu",			\
 			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		CC_SET(e)						\
 		: ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
 				"+a" (o.low), "+d" (o.high))		\
 		: "b" (n.low), "c" (n.high),				\
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 5e241306db26..03ab7699648c 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -66,7 +66,6 @@ static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old,
 	bool ret;							\
 									\
 	asm volatile(_lock "cmpxchg16b %[ptr]"				\
-		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 462d071c87d4..9c95f2576df1 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -294,7 +294,6 @@ do {									\
 									\
 	asm qual (__pcpu_op_##size("cmpxchg") "%[nval], "		\
 		  __percpu_arg([var])					\
-		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
 		    [oval] "+a" (pco_old__),				\
 		    [var] "+m" (__my_cpu_var(_var))			\
@@ -352,7 +351,6 @@ do {									\
 	asm_inline qual (						\
 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		CC_SET(z)						\
 		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
 				[var] "+m" (__my_cpu_var(_var)),	\
 				"+a" (old__.low), "+d" (old__.high))	\
@@ -421,7 +419,6 @@ do {									\
 	asm_inline qual (						\
 		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		CC_SET(z)						\
 		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
 				[var] "+m" (__my_cpu_var(_var)),	\
 				"+a" (old__.low), "+d" (old__.high))	\
@@ -570,7 +567,6 @@ do {									\
 	bool oldbit;							\
 									\
 	asm volatile("btl %[nr], " __percpu_arg([var])			\
-		     CC_SET(c)						\
 		     : CC_OUT(c) (oldbit)				\
 		     : [var] "m" (__my_cpu_var(_var)),			\
 		       [nr] "rI" (_nr));				\
diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index a54303e3dfa1..081311e22438 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -9,7 +9,7 @@
 #define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
 ({									\
 	bool c;								\
-	asm volatile (fullop CC_SET(cc)					\
+	asm volatile (fullop						\
 			: [var] "+m" (_var), CC_OUT(cc) (c)		\
 			: __VA_ARGS__ : clobbers);			\
 	c;								\
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ba7999f66abe..5bd058d3e133 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -440,7 +440,6 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 
 	/* "pvalidate" mnemonic support in binutils 2.36 and newer */
 	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFF\n\t"
-		     CC_SET(c)
 		     : CC_OUT(c) (no_rmpupdate), "=a"(rc)
 		     : "a"(vaddr), "c"(rmp_psize), "d"(validate)
 		     : "memory", "cc");
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 4a4043ca6493..e0d37bf00f27 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -83,7 +83,7 @@ static inline int __const_sigismember(sigset_t *set, int _sig)
 static inline int __gen_sigismember(sigset_t *set, int _sig)
 {
 	bool ret;
-	asm("btl %2,%1" CC_SET(c)
+	asm("btl %2,%1"
 	    : CC_OUT(c) (ret) : "m"(*set), "Ir"(_sig-1));
 	return ret;
 }
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index b905076cf7f6..9c1cc0ef8f3c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -274,7 +274,6 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 	 * See movdir64b()'s comment on operand specification.
 	 */
 	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
-		     CC_SET(z)
 		     : CC_OUT(z) (zf), "+m" (*__dst)
 		     : "m" (*__src), "a" (__dst), "d" (__src));
 
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..c37063121aaa 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -417,7 +417,6 @@ do {									\
 	__typeof__(*(_ptr)) __new = (_new);				\
 	asm volatile("\n"						\
 		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
-		     CC_SET(z)						\
 		     "2:\n"						\
 		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
 					   %[errout])			\
diff --git a/tools/arch/x86/include/asm/asm.h b/tools/arch/x86/include/asm/asm.h
index f66cf34f6197..b97b3b53045f 100644
--- a/tools/arch/x86/include/asm/asm.h
+++ b/tools/arch/x86/include/asm/asm.h
@@ -109,11 +109,10 @@
 #endif
 
 /*
- * Macros to generate condition code outputs from inline assembly,
+ * Generate condition code outputs from inline assembly.
  * The output operand must be type "bool".
  */
-# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
-# define CC_OUT(c) "=@cc" #c
+#define CC_OUT(c) "=@cc" #c
 
 #ifdef __KERNEL__
 
-- 
2.48.1


