Return-Path: <linux-kernel+bounces-538514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0589A4998D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D52170F83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D066D26B2D2;
	Fri, 28 Feb 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDN6DZlt"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575E26E626
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746312; cv=none; b=oTGBQtvxvMD2L4FOIGAdqm965+4Qp888sfVAJSUeVPfCOAc4cx7CQSujLaXuQMxpRD01418aO5S1xKkVVJN0jWmPET5O6X3VEtaEXntR4WAHvZ/faVofX5PFFPaz0+RJ3k49O4b6VdZG9s+jdGxsoorcoCKvOg6u5k5oNP2B+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746312; c=relaxed/simple;
	bh=mhR4dtrke4P0N8ttaX8p7NCZMyP+TUiYD1BRmMGC1dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bz4O31+FOZ6srIwLQ/5YSBQdMC2ngSc6gXy7ACfZZNoNqTEgtxV5duXGB8hxGDJEXlBI0/Ose2nNnugMynUkbhCPXjR6otaBcQ3zhAs/ZW83SQ0W6jBKDssPfbOgMh8umz/R54Zt5EcHxHWZaTTJch/5IRxe5MYY3nG+p7ONE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDN6DZlt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso2683402a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740746309; x=1741351109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U1doiMwGcrOOHqhq59dRiGl75gZObfJxrhgRgmDF2QA=;
        b=IDN6DZltyE8sGUqQnJfU7Ln9F3di7N7KW9pTxXwLR9Q7wkGOjaPum0cX6Fq+qWcoRY
         BgBirYe0lA6X1tP3bWkbWP8ek+bK4mSBG2a6fXncRt5FUvgvNO4jd334IfQbnJdnhpLC
         wgU1QerWh4WNG6WIy6dS84AFL6vP1XkfgyzY2NNvRqRrk0oqCFqQn/1TsWo2SoykUjvc
         MrsS+FJkeAvZceWnZnbqXYziCnin0J7s1TRNirGnMf8Ir8ZuxuPl2IctO5RFQtfk+Sfv
         P/JtO74azOLPH4bQrwP6//bbkIFfOfIQA52DYN5Gb7qguzb8I4vxg05d9QOS/0Oqc+3y
         ysug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746309; x=1741351109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1doiMwGcrOOHqhq59dRiGl75gZObfJxrhgRgmDF2QA=;
        b=euOJuATA2OKzblino0IZIDIj263Yfm/z2vZzXka6hDWlZESo3uAqAMsFFCpSCB808d
         D05gOmIlQKjy33ut/KPsdgp3m9iPnbWYUCHmb2kdnG6AptVvn8WotPwhYe/hE0+DGqyp
         mT8kdQdsTaflqW7S+oYPnsfMmAl5KO5oxVtnQuXehqx9zlSGaMPnWly4+zX36+34/Qm+
         QePmnauEQB1JaVX/FbN4UXSO8h+AY7Gu2bFSdMUIVaxGTmueEzeSOFQBy36WA9a+DBkQ
         CCRLI3IH9nIiMpz2oNIXsc5eykxro7EFYsrO3nnkHDk4w67bLncNXdPLphV1PawfRnrb
         9xNg==
X-Forwarded-Encrypted: i=1; AJvYcCUIH7+duPEOI6NYjtJlZv+5ag8stYHe2SZQlE/yqLhbwrafXmLmNwps/wLUkwI6vF48sWKzuwulvAVQvkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uHeX1MpZfks/t1iO/rrLvsYz3eqIRicMWB2JRYnHJB1ByiqR
	X+/1wkLzFAjHModJHXvgojf0lUwwoEPq8GiNcTv/7xrl9SGr2W/h
X-Gm-Gg: ASbGnctfjg3AOriXPOdNpLlG9fk/st6WgagkCuQOteVPCLRQrFRSg036KD97U2eER26
	0a47tcB7EyiIA7Z8M8SlUuNHIMeM+u3f5ufUITamUph7kVPuRqUZxgMZf4dMWp6mjY8VsObbyAU
	2boWYjxXQy3/EcQHz4ypjufxV8S5WqpThZpAY7BQI2pyGWyOd7JNZBHYbw3Hh6i/NVS/2B5cide
	zLLSvaFfdH1tB0/ZC0dJRxH9rPM3N9TXCDKQgQT0U0SE2w3iieU/fmkxX1rHWIaCeFOJJt3FRJA
	e5DfgNS43jOHQFfclw==
X-Google-Smtp-Source: AGHT+IEE+uFeMXOngXBS+MwEu+/njU82ujp2n9Gk7cg/ztp8BdiqgaGc4di7wRVCz5TmsgltNLgP7Q==
X-Received: by 2002:a17:906:8e0f:b0:abf:22b9:3cb8 with SMTP id a640c23a62f3a-abf22b94180mr348684066b.7.1740746308424;
        Fri, 28 Feb 2025 04:38:28 -0800 (PST)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0ba58asm283633166b.31.2025.02.28.04.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:38:27 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic locking insns
Date: Fri, 28 Feb 2025 13:35:59 +0100
Message-ID: <20250228123825.2729925-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to:

  https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html

the usage of asm pseudo directives in the asm template can confuse
the compiler to wrongly estimate the size of the generated
code.

The LOCK_PREFIX macro expands to several asm pseudo directives, so
its usage in atomic locking insns causes instruction length estimate
to fail significantly (the specially instrumented compiler reports
the estimated length of these asm templates to be 6 instructions long).

This incorrect estimate further causes unoptimal inlining decisions,
unoptimal instruction scheduling and unoptimal code block alignments
for functions that use these locking primitives.

Use asm_inline instead:

  https://gcc.gnu.org/pipermail/gcc-patches/2018-December/512349.html

which is a feature that makes GCC pretend some inline assembler code
is tiny (while it would think it is huge), instead of just asm.

For code size estimation, the size of the asm is then taken as
the minimum size of one instruction, ignoring how many instructions
compiler thinks it is.

The code size of the resulting x86_64 defconfig object file increases
for 33.264 kbytes, representing 1.2% code size increase:

   text    data     bss     dec     hex filename
27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o

mainly due to different inlining decisions of -O2 build.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/atomic.h      | 14 +++++++-------
 arch/x86/include/asm/atomic64_64.h | 14 +++++++-------
 arch/x86/include/asm/bitops.h      | 14 +++++++-------
 arch/x86/include/asm/cmpxchg.h     | 24 ++++++++++++------------
 arch/x86/include/asm/cmpxchg_32.h  |  4 ++--
 arch/x86/include/asm/cmpxchg_64.h  |  4 ++--
 arch/x86/include/asm/rmwcc.h       |  2 +-
 7 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 55b4d24356ea..75743f1dfd4e 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -30,14 +30,14 @@ static __always_inline void arch_atomic_set(atomic_t *v, int i)
 
 static __always_inline void arch_atomic_add(int i, atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "addl %1,%0"
+	asm_inline volatile(LOCK_PREFIX "addl %1, %0"
 		     : "+m" (v->counter)
 		     : "ir" (i) : "memory");
 }
 
 static __always_inline void arch_atomic_sub(int i, atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "subl %1,%0"
+	asm_inline volatile(LOCK_PREFIX "subl %1, %0"
 		     : "+m" (v->counter)
 		     : "ir" (i) : "memory");
 }
@@ -50,14 +50,14 @@ static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "incl %0"
+	asm_inline volatile(LOCK_PREFIX "incl %0"
 		     : "+m" (v->counter) :: "memory");
 }
 #define arch_atomic_inc arch_atomic_inc
 
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "decl %0"
+	asm_inline volatile(LOCK_PREFIX "decl %0"
 		     : "+m" (v->counter) :: "memory");
 }
 #define arch_atomic_dec arch_atomic_dec
@@ -116,7 +116,7 @@ static __always_inline int arch_atomic_xchg(atomic_t *v, int new)
 
 static __always_inline void arch_atomic_and(int i, atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "andl %1,%0"
+	asm_inline volatile(LOCK_PREFIX "andl %1, %0"
 			: "+m" (v->counter)
 			: "ir" (i)
 			: "memory");
@@ -134,7 +134,7 @@ static __always_inline int arch_atomic_fetch_and(int i, atomic_t *v)
 
 static __always_inline void arch_atomic_or(int i, atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "orl %1,%0"
+	asm_inline volatile(LOCK_PREFIX "orl %1, %0"
 			: "+m" (v->counter)
 			: "ir" (i)
 			: "memory");
@@ -152,7 +152,7 @@ static __always_inline int arch_atomic_fetch_or(int i, atomic_t *v)
 
 static __always_inline void arch_atomic_xor(int i, atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "xorl %1,%0"
+	asm_inline volatile(LOCK_PREFIX "xorl %1, %0"
 			: "+m" (v->counter)
 			: "ir" (i)
 			: "memory");
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index ae12acae5b06..87b496325b5b 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -22,14 +22,14 @@ static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 
 static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "addq %1,%0"
+	asm_inline volatile(LOCK_PREFIX "addq %1, %0"
 		     : "=m" (v->counter)
 		     : "er" (i), "m" (v->counter) : "memory");
 }
 
 static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "subq %1,%0"
+	asm_inline volatile(LOCK_PREFIX "subq %1, %0"
 		     : "=m" (v->counter)
 		     : "er" (i), "m" (v->counter) : "memory");
 }
@@ -42,7 +42,7 @@ static __always_inline bool arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
 
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "incq %0"
+	asm_inline volatile(LOCK_PREFIX "incq %0"
 		     : "=m" (v->counter)
 		     : "m" (v->counter) : "memory");
 }
@@ -50,7 +50,7 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
 
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "decq %0"
+	asm_inline volatile(LOCK_PREFIX "decq %0"
 		     : "=m" (v->counter)
 		     : "m" (v->counter) : "memory");
 }
@@ -110,7 +110,7 @@ static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 new)
 
 static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "andq %1,%0"
+	asm_inline volatile(LOCK_PREFIX "andq %1, %0"
 			: "+m" (v->counter)
 			: "er" (i)
 			: "memory");
@@ -128,7 +128,7 @@ static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 
 static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "orq %1,%0"
+	asm_inline volatile(LOCK_PREFIX "orq %1, %0"
 			: "+m" (v->counter)
 			: "er" (i)
 			: "memory");
@@ -146,7 +146,7 @@ static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 
 static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "xorq %1,%0"
+	asm_inline volatile(LOCK_PREFIX "xorq %1, %0"
 			: "+m" (v->counter)
 			: "er" (i)
 			: "memory");
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b96d45944c59..100413aff640 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -52,12 +52,12 @@ static __always_inline void
 arch_set_bit(long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
-		asm volatile(LOCK_PREFIX "orb %b1,%0"
+		asm_inline volatile(LOCK_PREFIX "orb %b1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" (CONST_MASK(nr))
 			: "memory");
 	} else {
-		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
+		asm_inline volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
@@ -72,11 +72,11 @@ static __always_inline void
 arch_clear_bit(long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
-		asm volatile(LOCK_PREFIX "andb %b1,%0"
+		asm_inline volatile(LOCK_PREFIX "andb %b1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" (~CONST_MASK(nr)));
 	} else {
-		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
+		asm_inline volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
@@ -98,7 +98,7 @@ static __always_inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 		volatile unsigned long *addr)
 {
 	bool negative;
-	asm volatile(LOCK_PREFIX "xorb %2,%1"
+	asm_inline volatile(LOCK_PREFIX "xorb %2,%1"
 		CC_SET(s)
 		: CC_OUT(s) (negative), WBYTE_ADDR(addr)
 		: "iq" ((char)mask) : "memory");
@@ -122,11 +122,11 @@ static __always_inline void
 arch_change_bit(long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
-		asm volatile(LOCK_PREFIX "xorb %b1,%0"
+		asm_inline volatile(LOCK_PREFIX "xorb %b1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" (CONST_MASK(nr)));
 	} else {
-		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
+		asm_inline volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index fd8afc1f5f6b..b61f32c3459f 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -44,22 +44,22 @@ extern void __add_wrong_size(void)
 	        __typeof__ (*(ptr)) __ret = (arg);			\
 		switch (sizeof(*(ptr))) {				\
 		case __X86_CASE_B:					\
-			asm volatile (lock #op "b %b0, %1\n"		\
+			asm_inline volatile (lock #op "b %b0, %1"	\
 				      : "+q" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
 		case __X86_CASE_W:					\
-			asm volatile (lock #op "w %w0, %1\n"		\
+			asm_inline volatile (lock #op "w %w0, %1"	\
 				      : "+r" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
 		case __X86_CASE_L:					\
-			asm volatile (lock #op "l %0, %1\n"		\
+			asm_inline volatile (lock #op "l %0, %1"	\
 				      : "+r" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
 		case __X86_CASE_Q:					\
-			asm volatile (lock #op "q %q0, %1\n"		\
+			asm_inline volatile (lock #op "q %q0, %1"	\
 				      : "+r" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
@@ -91,7 +91,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_B:						\
 	{								\
 		volatile u8 *__ptr = (volatile u8 *)(ptr);		\
-		asm volatile(lock "cmpxchgb %2,%1"			\
+		asm_inline volatile(lock "cmpxchgb %2, %1"		\
 			     : "=a" (__ret), "+m" (*__ptr)		\
 			     : "q" (__new), "0" (__old)			\
 			     : "memory");				\
@@ -100,7 +100,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_W:						\
 	{								\
 		volatile u16 *__ptr = (volatile u16 *)(ptr);		\
-		asm volatile(lock "cmpxchgw %2,%1"			\
+		asm_inline volatile(lock "cmpxchgw %2, %1"		\
 			     : "=a" (__ret), "+m" (*__ptr)		\
 			     : "r" (__new), "0" (__old)			\
 			     : "memory");				\
@@ -109,7 +109,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_L:						\
 	{								\
 		volatile u32 *__ptr = (volatile u32 *)(ptr);		\
-		asm volatile(lock "cmpxchgl %2,%1"			\
+		asm_inline volatile(lock "cmpxchgl %2, %1"		\
 			     : "=a" (__ret), "+m" (*__ptr)		\
 			     : "r" (__new), "0" (__old)			\
 			     : "memory");				\
@@ -118,7 +118,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_Q:						\
 	{								\
 		volatile u64 *__ptr = (volatile u64 *)(ptr);		\
-		asm volatile(lock "cmpxchgq %2,%1"			\
+		asm_inline volatile(lock "cmpxchgq %2, %1"		\
 			     : "=a" (__ret), "+m" (*__ptr)		\
 			     : "r" (__new), "0" (__old)			\
 			     : "memory");				\
@@ -165,7 +165,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_B:						\
 	{								\
 		volatile u8 *__ptr = (volatile u8 *)(_ptr);		\
-		asm volatile(lock "cmpxchgb %[new], %[ptr]"		\
+		asm_inline volatile(lock "cmpxchgb %[new], %[ptr]"	\
 			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
@@ -177,7 +177,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_W:						\
 	{								\
 		volatile u16 *__ptr = (volatile u16 *)(_ptr);		\
-		asm volatile(lock "cmpxchgw %[new], %[ptr]"		\
+		asm_inline volatile(lock "cmpxchgw %[new], %[ptr]"	\
 			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
@@ -189,7 +189,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_L:						\
 	{								\
 		volatile u32 *__ptr = (volatile u32 *)(_ptr);		\
-		asm volatile(lock "cmpxchgl %[new], %[ptr]"		\
+		asm_inline volatile(lock "cmpxchgl %[new], %[ptr]"	\
 			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
@@ -201,7 +201,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_Q:						\
 	{								\
 		volatile u64 *__ptr = (volatile u64 *)(_ptr);		\
-		asm volatile(lock "cmpxchgq %[new], %[ptr]"		\
+		asm_inline volatile(lock "cmpxchgq %[new], %[ptr]"	\
 			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 8806c646d452..3dd278593960 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -19,7 +19,7 @@ union __u64_halves {
 	union __u64_halves o = { .full = (_old), },			\
 			   n = { .full = (_new), };			\
 									\
-	asm volatile(_lock "cmpxchg8b %[ptr]"				\
+	asm_inline volatile(_lock "cmpxchg8b %[ptr]"			\
 		     : [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
@@ -45,7 +45,7 @@ static __always_inline u64 __cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new
 			   n = { .full = (_new), };			\
 	bool ret;							\
 									\
-	asm volatile(_lock "cmpxchg8b %[ptr]"				\
+	asm_inline volatile(_lock "cmpxchg8b %[ptr]"			\
 		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 5e241306db26..71d1e72ed879 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -38,7 +38,7 @@ union __u128_halves {
 	union __u128_halves o = { .full = (_old), },			\
 			    n = { .full = (_new), };			\
 									\
-	asm volatile(_lock "cmpxchg16b %[ptr]"				\
+	asm_inline volatile(_lock "cmpxchg16b %[ptr]"			\
 		     : [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
@@ -65,7 +65,7 @@ static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old,
 			    n = { .full = (_new), };			\
 	bool ret;							\
 									\
-	asm volatile(_lock "cmpxchg16b %[ptr]"				\
+	asm_inline volatile(_lock "cmpxchg16b %[ptr]"			\
 		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index 363266cbcada..3821ee3fae35 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -29,7 +29,7 @@ cc_label:	c = true;						\
 #define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
 ({									\
 	bool c;								\
-	asm volatile (fullop CC_SET(cc)					\
+	asm_inline volatile (fullop CC_SET(cc)				\
 			: [var] "+m" (_var), CC_OUT(cc) (c)		\
 			: __VA_ARGS__ : clobbers);			\
 	c;								\
-- 
2.48.1


