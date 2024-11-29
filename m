Return-Path: <linux-kernel+bounces-425665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE2B9DE8B8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91A3B2286C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718813AA26;
	Fri, 29 Nov 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHaG+fky"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB84EB45
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891407; cv=none; b=scfgJUf4ULlxn12ZefCgIKRS+qFpjsmhOgTc8uNFfjSrPgpY3axuHhwFVS8+R/l6QIurI71eL1gvF2JshHt1ShUT3EwSlVG+xEMbPhX8j4/51LmxemEevS6LMarKN7WwHGEYfTmiZZUvgUK2M+MLVjaI3GcC/xyl2DF7DiGCBXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891407; c=relaxed/simple;
	bh=h26F3eNlkYbIuwt2n+Fxp3eG/MSK2uAH/TSTMdhWCj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DhMWO9eB12EYj8eVlTzngVyEwAz40cu8BRaNVwCFGc/pakncA2rI5YmjBp0QWArp14YWp+0cApC4xu6EPdsNZbTHWbBGzmKnuE/LZkyICRKtvy9wtgnVGD9ftgNavIAc+SjckX5WVJNfxPCIwGPxSVtgF2oHIlEFjguYE96KHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHaG+fky; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa578d10d50so311733566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 06:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732891404; x=1733496204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PiHlVfiJ60V3G6owms/djjiMKMNOCjBfCEUldGOmp90=;
        b=LHaG+fkyxo8omjZjuzseYzQj//6qAq1ZoDXntewG6qv5LjuJXmaioZHfNDB89HBNCv
         Wc2vrzHoM1bx3lczR7C5tlX1YPNDWmmXX2fSPxh0cDw5MNXQb9+jI8lVnq5FJWPETNap
         sIpzcVAsd5Rx9yKPgOW/w/1VfNGTIZs91cWV4ytG/hJowR4C+YO7Z4l1KMfwIZOCuIxL
         iFmHC5i+d/JqZ1JS+Bqw1iM2cPxprY974kvF7FtxVsbR8Z02HRwPhZuCbD3XJdoIaCLz
         y2ayuSkGvVvFpmIuuPQ3Pu/oBV5EQSiEgX4V74ifczeEG7iATwNWDeIG0yGqy+oci7cJ
         qZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732891404; x=1733496204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiHlVfiJ60V3G6owms/djjiMKMNOCjBfCEUldGOmp90=;
        b=pMr/bBm6gNgNopLBlGL98dEix1qOIRUjrZJXljjRY1bFUPOEQWPxoFGt0rwYtHcKkH
         tWdiUD8gu/HA/JyZYUfYJACxjSyVOVpCl39ugJWaqdMCfGXlvJTSlG+PmIwTfvfMRhK+
         jlFvGxNRTVwUHL4PLvaVnL1SGU/9SLy16T7UdfMtGV2GeM22L5i9B/4g4nDQPEat2oJO
         Bt/8mg//0WiT4JPU7VXMFG6c78uTTu2qaetuBpDFAb7HT4AuXiKqcziNAmNxxZvTsR+I
         LnWXXMulfSeirlaE+15Mu6BLL/U3TuQZTb+aVYkAi4/Xnhd7GUVkW06zuAnaczavxFZY
         BkDg==
X-Forwarded-Encrypted: i=1; AJvYcCW0R4lcol4wY2cUIT1WNkHtKRf6878WoYYcaJy1LGZFQdk4z5dWTcqjVppMPVTOa2t9lKhcxuDnXj1t+sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgKhNW0TSaW3VGMB75sQPtt52VB22MAwjWzf0hhon0BcpPqJR
	1cA7WVcLimHp4EgE3i6Q5XKQswlNYIBpIxPkPcol6OUAIJ9ZdvT3
X-Gm-Gg: ASbGnctOUeD2gUNxTc/PSIeEtqVqQQBefqCmKcJKe3h4SZC8b3/YdTcrUPnbPVstOL7
	gHjEpaqoY0D3E4YbD2aMUpqao/SxzS7LirA98ah+Eg4G52zsFbINsfK3ENIrWLNm2+IWzkBQXt7
	dItPQkPFngKL6pUVykrT6HFBvq0pKfenA7Aqia8k7vQ+llQwjLz86xtgvcq3aQMTDTOH9cQRI3u
	IQ5yAMXA2etcmYg1U10LFjlE3WhvacLj3wg/qZDdlc1Q/xFE4ZD02Vr5A78fg==
X-Google-Smtp-Source: AGHT+IG0rNx1REuD5SvmWmALJN+JnxSGMt6psPHrgEJ3ol+4tvOlR3VOetIu+YlqI+fY6lJvQrPOqQ==
X-Received: by 2002:a17:907:aa5:b0:aa5:4ea6:fcae with SMTP id a640c23a62f3a-aa580f566d2mr1300523666b.28.1732891403773;
        Fri, 29 Nov 2024 06:43:23 -0800 (PST)
Received: from localhost.localdomain ([212.200.182.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6f99sm180703366b.131.2024.11.29.06.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 06:43:23 -0800 (PST)
From: Aleksandar Rikalo <arikalo@gmail.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrea Parri <parri.andrea@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Eric Chan <ericchancf@google.com>,
	Aleksandar Rikalo <arikalo@gmail.com>,
	linux-kernel@vger.kernel.org,
	Djordje Todorovic <djordje.todorovic@htecgroup.com>
Subject: [PATCH] riscv: Rewrite AMO instructions via lr and sc.
Date: Fri, 29 Nov 2024 15:43:19 +0100
Message-Id: <20241129144319.74257-1-arikalo@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao-ying Fu <cfu@mips.com>

Use lr and sc to implement all atomic functions. Some CPUs have
native support for lr and sc, but emulate AMO instructions through
trap handlers that are slow.

Add config RISCV_ISA_ZALRSC_ONLY.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
---
 arch/riscv/Kconfig               | 10 ++++++
 arch/riscv/include/asm/atomic.h  | 52 +++++++++++++++++++++++++++++++-
 arch/riscv/include/asm/bitops.h  | 45 +++++++++++++++++++++++++++
 arch/riscv/include/asm/cmpxchg.h | 16 ++++++++++
 arch/riscv/include/asm/futex.h   | 46 ++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index cc63aef41e94..767538c27875 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -715,6 +715,16 @@ config RISCV_ISA_ZACAS
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_ZALRSC_ONLY
+	bool "Zalrsc extension support only"
+	default n
+	help
+	   Use lr and sc to build all atomic functions. Some CPUs have
+	   native support for lr and sc, but emulate amo instructions through
+	   trap handlers that are slow.
+
+	   If you don't know what to do here, say n.
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 5b96c2f61adb..f484babecb9e 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -50,6 +50,7 @@ static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
  * have the AQ or RL bits set.  These don't return anything, so there's only
  * one version to worry about.
  */
+#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
 #define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)		\
 static __always_inline							\
 void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
@@ -59,7 +60,23 @@ void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
 		: "+A" (v->counter)					\
 		: "r" (I)						\
 		: "memory");						\
-}									\
+}
+#else
+#define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)		\
+static __always_inline							\
+void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
+{									\
+	register c_type ret, temp;					\
+	__asm__ __volatile__ (						\
+		"1:	lr." #asm_type " %1, %0\n"			\
+		"	" #asm_op " %2, %1, %3\n"			\
+		"	sc." #asm_type " %2, %2, %0\n"			\
+		"	bnez %2, 1b\n"					\
+		: "+A" (v->counter), "=&r" (ret), "=&r" (temp)		\
+		: "r" (I)						\
+		: "memory");						\
+}
+#endif
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #define ATOMIC_OPS(op, asm_op, I)					\
@@ -84,6 +101,7 @@ ATOMIC_OPS(xor, xor,  i)
  * There's two flavors of these: the arithmatic ops have both fetch and return
  * versions, while the logical ops only have fetch versions.
  */
+#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
 #define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)	\
 static __always_inline							\
 c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
@@ -108,6 +126,38 @@ c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
 		: "memory");						\
 	return ret;							\
 }
+#else
+#define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)	\
+static __always_inline							\
+c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
+					     atomic##prefix##_t *v)	\
+{									\
+	register c_type ret, temp;					\
+	__asm__ __volatile__ (						\
+		"1:	lr." #asm_type " %1, %0\n"			\
+		"	" #asm_op " %2, %1, %3\n"			\
+		"	sc." #asm_type " %2, %2, %0\n"			\
+		"	bnez %2, 1b\n"					\
+		: "+A" (v->counter), "=&r" (ret), "=&r" (temp)		\
+		: "r" (I)						\
+		: "memory");						\
+	return ret;							\
+}									\
+static __always_inline							\
+c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
+{									\
+	register c_type ret, temp;					\
+	__asm__ __volatile__ (						\
+		"1:	lr." #asm_type ".aqrl %1, %0\n"			\
+		"	" #asm_op " %2, %1, %3\n"			\
+		"	sc." #asm_type ".aqrl %2, %2, %0\n"		\
+		"	bnez %2, 1b\n"					\
+		: "+A" (v->counter), "=&r" (ret), "=&r" (temp)		\
+		: "r" (I)						\
+		: "memory");						\
+	return ret;							\
+}
+#endif
 
 #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)	\
 static __always_inline							\
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index fae152ea0508..b51cb18f7d9e 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -187,12 +187,17 @@ static __always_inline int variable_fls(unsigned int x)
 
 #if (BITS_PER_LONG == 64)
 #define __AMO(op)	"amo" #op ".d"
+#define __LR	"lr.d"
+#define __SC	"sc.d"
 #elif (BITS_PER_LONG == 32)
 #define __AMO(op)	"amo" #op ".w"
+#define __LR	"lr.w"
+#define __SC	"sc.w"
 #else
 #error "Unexpected BITS_PER_LONG"
 #endif
 
+#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
 #define __test_and_op_bit_ord(op, mod, nr, addr, ord)		\
 ({								\
 	unsigned long __res, __mask;				\
@@ -211,6 +216,33 @@ static __always_inline int variable_fls(unsigned int x)
 		: "+A" (addr[BIT_WORD(nr)])			\
 		: "r" (mod(BIT_MASK(nr)))			\
 		: "memory");
+#else
+#define __test_and_op_bit_ord(op, mod, nr, addr, ord)		\
+({								\
+	unsigned long __res, __mask, __temp;			\
+	__mask = BIT_MASK(nr);					\
+	__asm__ __volatile__ (					\
+		"1: " __LR #ord " %0, %1\n"			\
+		#op " %2, %0, %3\n"				\
+		__SC #ord " %2, %2, %1\n"			\
+		"bnez %2, 1b\n"					\
+		: "=&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=&r" (__temp)	\
+		: "r" (mod(__mask))				\
+		: "memory");					\
+	((__res & __mask) != 0);				\
+})
+
+#define __op_bit_ord(op, mod, nr, addr, ord)			\
+	unsigned long __res, __temp;				\
+	__asm__ __volatile__ (					\
+		"1: " __LR #ord " %0, %1\n"			\
+		#op " %2, %0, %3\n"				\
+		__SC #ord " %2, %2, %1\n"			\
+		"bnez %2, 1b\n"					\
+		: "=&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=&r" (__temp)	\
+		: "r" (mod(BIT_MASK(nr)))			\
+		: "memory")
+#endif
 
 #define __test_and_op_bit(op, mod, nr, addr) 			\
 	__test_and_op_bit_ord(op, mod, nr, addr, .aqrl)
@@ -354,12 +386,25 @@ static inline void arch___clear_bit_unlock(
 static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 		volatile unsigned long *addr)
 {
+#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
 	unsigned long res;
 	__asm__ __volatile__ (
 		__AMO(xor) ".rl %0, %2, %1"
 		: "=r" (res), "+A" (*addr)
 		: "r" (__NOP(mask))
 		: "memory");
+#else
+	unsigned long res, temp;
+
+	__asm__ __volatile__ (
+		"1: " __LR ".rl %0, %1\n"
+		"xor %2, %0, %3\n"
+		__SC ".rl %2, %2, %1\n"
+		"bnez %2, 1b\n"
+		: "=&r" (res), "+A" (*addr), "=&r" (temp)
+		: "r" (__NOP(mask))
+		: "memory");
+#endif
 	return (res & BIT(7)) != 0;
 }
 
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 4cadc56220fe..881082b05110 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -51,6 +51,7 @@
 	}									\
 })
 
+#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
 #define __arch_xchg(sfx, prepend, append, r, p, n)			\
 ({									\
 	__asm__ __volatile__ (						\
@@ -61,6 +62,21 @@
 		: "r" (n)						\
 		: "memory");						\
 })
+#else
+#define __arch_xchg(sfx, prepend, append, r, p, n)			\
+({									\
+	__typeof__(*(__ptr)) temp;					\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"1:	lr" sfx " %0, %1\n"				\
+		"	sc" sfx " %2, %3, %1\n"				\
+		"	bnez %2, 1b\n"					\
+		append							\
+		: "=&r" (r), "+A" (*(p)), "=&r" (temp)			\
+		: "r" (n)						\
+		: "memory");						\
+})
+#endif
 
 #define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
 		   sc_append, swap_append)				\
diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index fc8130f995c1..47297f47ec35 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -19,6 +19,7 @@
 #define __disable_user_access()		do { } while (0)
 #endif
 
+#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
 {								\
 	__enable_user_access();					\
@@ -32,16 +33,39 @@
 	: "memory");						\
 	__disable_user_access();				\
 }
+#else
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
+{								\
+	__enable_user_access();					\
+	__asm__ __volatile__ (					\
+	"1:	lr.w.aqrl %[ov], %[u]\n"			\
+	"	" insn "\n"					\
+	"	sc.w.aqrl %[t], %[t], %[u]\n"			\
+	"	bnez %[t], 1b\n"				\
+	"2:\n"							\
+	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %[r])			\
+	: [r] "+r" (ret), [ov] "=&r" (oldval),			\
+	  [t] "=&r" (temp), [u] "+m" (*uaddr)			\
+	: [op] "Jr" (oparg)					\
+	: "memory");						\
+	__disable_user_access();				\
+}
+#endif
 
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
+#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
 	int oldval = 0, ret = 0;
+#else
+	int oldval = 0, ret = 0, temp = 0;
+#endif
 
 	if (!access_ok(uaddr, sizeof(u32)))
 		return -EFAULT;
 
 	switch (op) {
+#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
 	case FUTEX_OP_SET:
 		__futex_atomic_op("amoswap.w.aqrl %[ov],%z[op],%[u]",
 				  ret, oldval, uaddr, oparg);
@@ -62,6 +86,28 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		__futex_atomic_op("amoxor.w.aqrl %[ov],%z[op],%[u]",
 				  ret, oldval, uaddr, oparg);
 		break;
+#else
+	case FUTEX_OP_SET:
+		__futex_atomic_op("mv %[t], %z[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("add %[t], %[ov], %z[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("or %[t], %[ov], %z[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("and %[t], %[ov], %z[op]",
+				  ret, oldval, uaddr, ~oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xor %[t], %[ov], %z[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+#endif
 	default:
 		ret = -ENOSYS;
 	}
-- 
2.25.1


