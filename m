Return-Path: <linux-kernel+bounces-258729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B93A0938C31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F5B21578
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79516C86C;
	Mon, 22 Jul 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="YR3UOs4h"
Received: from smtpout149.security-mail.net (smtpout149.security-mail.net [85.31.212.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5816C862
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641411; cv=none; b=VdSoQ9cJ5wHs2T7m68DzzzBws4tDdTunkJ35K/09jB1EMZrBZ5h64MtpEyofng0oj/Hvrn+hWUSMjm5uhVk+Ch8luI8jmi5QarzzEA3ENh3G26nwHA3tO3ssihX75huzkbkwESk8exTd9wdwtMwlS7ctB4Hxu5jOjAw1a3d7P8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641411; c=relaxed/simple;
	bh=yiIIaJWJm3G+BS5HXK8fiZQ3PgG4MBqpY9GLN4Ty0cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaFXunCglzTHbwaX7eEsBOqeRFN/GhNx9aGgez1eZZ9YmJb2GmqLhgWprKUo76sHBmyaSzCF240VOPyz3k0aZp5E5IcSKMzNJP2UIzNHWqyYMK1myzJMHjxQD4lrTgLYjW/Dd5zZycIx246xbUFtwa3nd6r3+EFPfgNxycMQIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=YR3UOs4h; arc=none smtp.client-ip=85.31.212.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 748B7349A5D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641407;
	bh=yiIIaJWJm3G+BS5HXK8fiZQ3PgG4MBqpY9GLN4Ty0cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YR3UOs4hdTeLnBjze7nfeP22D1Dit9F2Iyj/zFLNuFS4pFbfpnQv2wAGNgcZte9VY
	 okFQ34X1wO0Y55ZRujWGYWXYpMxgO55pQfcBpyl2pDn9RmUDLsjacZk6wxw1Ks3+SS
	 cb6TTw0YfSMyfQJF2vyxpL0PiXZ5+VdPnnrZ8tLY=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 3189E349A3F; Mon, 22 Jul
 2024 11:43:27 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 7E162349A79; Mon, 22 Jul
 2024 11:43:26 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 3C40640317; Mon, 22 Jul
 2024 11:43:26 +0200 (CEST)
X-Secumail-id: <182ba.669e29be.7935d.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Mark
 Rutland <mark.rutland@arm.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Jules Maselbas <jmaselbas@zdiv.net>,
 Julien Villette <julien.villette@gmail.com>
Subject: [RFC PATCH v3 15/37] kvx: Add atomic/locking headers
Date: Mon, 22 Jul 2024 11:41:26 +0200
Message-ID: <20240722094226.21602-16-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add common headers (atomic, bitops, barrier and locking) for basic
kvx support.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Julien Villette <julien.villette@gmail.com>
Signed-off-by: Julien Villette <julien.villette@gmail.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2:
- use {READ,WRITE}_ONCE for arch_atomic64_{read,set}
- use asm-generic/bitops/atomic.h instead of __test_and_*_bit
- removed duplicated includes
- rewrite xchg and cmpxchg in C using builtins for acswap insn

V2 -> V3:
- use arch_atomic64_read instead of plain pointer dereference
- undef ATOMIC64_RETURN_OP
- override generic atomics for:
  - arch_atomic64_{add,sub}_return
  - arch_atomic64_fetch_{add,sub,and,or,xor}
- add missing if (!word) return 0 in __ffs
- typos
---
 arch/kvx/include/asm/atomic.h  | 119 +++++++++++++++++++++++
 arch/kvx/include/asm/barrier.h |  15 +++
 arch/kvx/include/asm/bitops.h  | 118 +++++++++++++++++++++++
 arch/kvx/include/asm/bitrev.h  |  32 +++++++
 arch/kvx/include/asm/cmpxchg.h | 170 +++++++++++++++++++++++++++++++++
 5 files changed, 454 insertions(+)
 create mode 100644 arch/kvx/include/asm/atomic.h
 create mode 100644 arch/kvx/include/asm/barrier.h
 create mode 100644 arch/kvx/include/asm/bitops.h
 create mode 100644 arch/kvx/include/asm/bitrev.h
 create mode 100644 arch/kvx/include/asm/cmpxchg.h

diff --git a/arch/kvx/include/asm/atomic.h b/arch/kvx/include/asm/atomic.h
new file mode 100644
index 0000000000000..1ccd5ca51a763
--- /dev/null
+++ b/arch/kvx/include/asm/atomic.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_ATOMIC_H
+#define _ASM_KVX_ATOMIC_H
+
+#include <linux/types.h>
+
+#include <asm/cmpxchg.h>
+
+#define ATOMIC64_INIT(i)     { (i) }
+
+#define arch_atomic64_cmpxchg(v, old, new) (arch_cmpxchg(&((v)->counter), old, new))
+#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
+
+static inline long arch_atomic64_read(const atomic64_t *v)
+{
+	return READ_ONCE(v->counter);
+}
+
+static inline void arch_atomic64_set(atomic64_t *v, long i)
+{
+	WRITE_ONCE(v->counter, i);
+}
+
+#define ATOMIC64_RETURN_OP(op, c_op)					\
+static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
+{									\
+	long new, old, ret;						\
+									\
+	do {								\
+		old = arch_atomic64_read(v);				\
+		new = old c_op i;					\
+		ret = arch_cmpxchg(&v->counter, old, new);		\
+	} while (ret != old);						\
+									\
+	return new;							\
+}
+
+#define ATOMIC64_OP(op, c_op)						\
+static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
+{									\
+	long new, old, ret;						\
+									\
+	do {								\
+		old = arch_atomic64_read(v);				\
+		new = old c_op i;					\
+		ret = arch_cmpxchg(&v->counter, old, new);		\
+	} while (ret != old);						\
+}
+
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+static inline long arch_atomic64_fetch_##op(long i, atomic64_t *v)	\
+{									\
+	long new, old, ret;						\
+									\
+	do {								\
+		old = arch_atomic64_read(v);				\
+		new = old c_op i;					\
+		ret = arch_cmpxchg(&v->counter, old, new);		\
+	} while (ret != old);						\
+									\
+	return old;							\
+}
+
+#define ATOMIC64_OPS(op, c_op)						\
+	ATOMIC64_OP(op, c_op)						\
+	ATOMIC64_RETURN_OP(op, c_op)					\
+	ATOMIC64_FETCH_OP(op, c_op)
+
+ATOMIC64_OPS(and, &)
+ATOMIC64_OPS(or, |)
+ATOMIC64_OPS(xor, ^)
+ATOMIC64_OPS(add, +)
+ATOMIC64_OPS(sub, -)
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
+#undef ATOMIC64_RETURN_OP
+#undef ATOMIC64_OP
+
+static inline int arch_atomic_add_return(int i, atomic_t *v)
+{
+	int new, old, ret;
+
+	do {
+		old = v->counter;
+		new = old + i;
+		ret = arch_cmpxchg(&v->counter, old, new);
+	} while (ret != old);
+
+	return new;
+}
+
+static inline int arch_atomic_sub_return(int i, atomic_t *v)
+{
+	return arch_atomic_add_return(-i, v);
+}
+
+#define arch_atomic64_add_return		arch_atomic64_add_return
+
+#define arch_atomic64_fetch_add			arch_atomic64_fetch_add
+
+#define arch_atomic64_fetch_sub			arch_atomic64_fetch_sub
+
+#define arch_atomic64_fetch_and			arch_atomic64_fetch_and
+
+#define arch_atomic64_fetch_or			arch_atomic64_fetch_or
+
+#define arch_atomic64_fetch_xor			arch_atomic64_fetch_xor
+
+#define arch_atomic64_sub_return		arch_atomic64_sub_return
+
+#include <asm-generic/atomic.h>
+
+#endif	/* _ASM_KVX_ATOMIC_H */
diff --git a/arch/kvx/include/asm/barrier.h b/arch/kvx/include/asm/barrier.h
new file mode 100644
index 0000000000000..371f1c70746dc
--- /dev/null
+++ b/arch/kvx/include/asm/barrier.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BARRIER_H
+#define _ASM_KVX_BARRIER_H
+
+/* fence is sufficient to guarantee write ordering */
+#define mb()	__builtin_kvx_fence()
+
+#include <asm-generic/barrier.h>
+
+#endif /* _ASM_KVX_BARRIER_H */
diff --git a/arch/kvx/include/asm/bitops.h b/arch/kvx/include/asm/bitops.h
new file mode 100644
index 0000000000000..7782ce93cfee4
--- /dev/null
+++ b/arch/kvx/include/asm/bitops.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#ifndef _ASM_KVX_BITOPS_H
+#define _ASM_KVX_BITOPS_H
+
+#ifdef __KERNEL__
+
+#ifndef _LINUX_BITOPS_H
+#error only <linux/bitops.h> can be included directly
+#endif
+
+#include <asm/cmpxchg.h>
+
+static inline int fls(int x)
+{
+	return 32 - __builtin_kvx_clzw(x);
+}
+
+static inline int fls64(__u64 x)
+{
+	return 64 - __builtin_kvx_clzd(x);
+}
+
+/**
+ * __ffs - find first set bit in word
+ * @word: The word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+	if (!word)
+		return 0;
+
+	return __builtin_kvx_ctzd(word);
+}
+
+/**
+ * __fls - find last set bit in word
+ * @word: The word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __fls(unsigned long word)
+{
+	return 63 - __builtin_kvx_clzd(word);
+}
+
+
+/**
+ * ffs - find first set bit in word
+ * @x: the word to search
+ *
+ * This is defined the same way as the libc and compiler builtin ffs
+ * routines, therefore differs in spirit from the other bitops.
+ *
+ * ffs(value) returns 0 if value is 0 or the position of the first
+ * set bit if value is nonzero. The first (least significant) bit
+ * is at position 1.
+ */
+static inline int ffs(int x)
+{
+	if (!x)
+		return 0;
+	return __builtin_kvx_ctzw(x) + 1;
+}
+
+static inline unsigned int __arch_hweight32(unsigned int w)
+{
+	unsigned int count;
+
+	asm volatile ("cbsw %0 = %1\n\t;;"
+	: "=r" (count)
+	: "r" (w));
+
+	return count;
+}
+
+static inline unsigned int __arch_hweight64(__u64 w)
+{
+	unsigned int count;
+
+	asm volatile ("cbsd %0 = %1\n\t;;"
+	: "=r" (count)
+	: "r" (w));
+
+	return count;
+}
+
+static inline unsigned int __arch_hweight16(unsigned int w)
+{
+	return __arch_hweight32(w & 0xffff);
+}
+
+static inline unsigned int __arch_hweight8(unsigned int w)
+{
+	return __arch_hweight32(w & 0xff);
+}
+
+#include <asm-generic/bitops/ffz.h>
+
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/const_hweight.h>
+
+#include <asm-generic/bitops/atomic.h>
+#include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/lock.h>
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+
+#endif
+
+#endif
diff --git a/arch/kvx/include/asm/bitrev.h b/arch/kvx/include/asm/bitrev.h
new file mode 100644
index 0000000000000..79865081905a6
--- /dev/null
+++ b/arch/kvx/include/asm/bitrev.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BITREV_H
+#define _ASM_KVX_BITREV_H
+
+#include <linux/swab.h>
+
+/* Bit reversal constant for matrix multiply */
+#define BIT_REVERSE 0x0102040810204080ULL
+
+static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
+{
+	/* Reverse all bits for each bytes and then byte-reverse the 32 LSB */
+	return swab32(__builtin_kvx_sbmm8(BIT_REVERSE, x));
+}
+
+static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
+{
+	/* Reverse all bits for each bytes and then byte-reverse the 16 LSB */
+	return swab16(__builtin_kvx_sbmm8(BIT_REVERSE, x));
+}
+
+static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
+{
+	return __builtin_kvx_sbmm8(BIT_REVERSE, x);
+}
+
+#endif
diff --git a/arch/kvx/include/asm/cmpxchg.h b/arch/kvx/include/asm/cmpxchg.h
new file mode 100644
index 0000000000000..041a3e7797103
--- /dev/null
+++ b/arch/kvx/include/asm/cmpxchg.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ *            Jules Maselbas
+ */
+
+#ifndef _ASM_KVX_CMPXCHG_H
+#define _ASM_KVX_CMPXCHG_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+#include <linux/align.h>
+#include <linux/build_bug.h>
+
+/*
+ * On kvx, we have a boolean compare and swap which means that the operation
+ * returns only the success of operation.
+ * If operation succeed, this is simple, we just need to return the provided
+ * old value. However, if it fails, we need to load the value to return it for
+ * the caller. If the loaded value is different from the "old" provided by the
+ * caller, we can return it since it will means it failed.
+ * However, if for some reason the value we read is equal to the old value
+ * provided by the caller, we can't simply return it or the caller will think it
+ * succeeded. So if the value we read is the same as the "old" provided by
+ * the caller, we try again until either we succeed or we fail with a different
+ * value than the provided one.
+ */
+
+static inline unsigned int __cmpxchg_u32(unsigned int old, unsigned int new,
+					 volatile unsigned int *ptr)
+{
+	unsigned int exp = old;
+
+	__builtin_kvx_fence();
+	while (exp == old) {
+		if (__builtin_kvx_acswapw((void *)ptr, new, exp))
+			break; /* acswap succeed */
+		exp = *ptr;
+	}
+
+	return exp;
+}
+
+static inline unsigned long __cmpxchg_u64(unsigned long old, unsigned long new,
+					  volatile unsigned long *ptr)
+{
+	unsigned long exp = old;
+
+	__builtin_kvx_fence();
+	while (exp == old) {
+		if (__builtin_kvx_acswapd((void *)ptr, new, exp))
+			break; /* acswap succeed */
+		exp = *ptr;
+	}
+
+	return exp;
+}
+
+extern unsigned long __cmpxchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for cmpxchg");
+
+static __always_inline unsigned long __cmpxchg(unsigned long old,
+					       unsigned long new,
+					       volatile void *ptr, int size)
+{
+	switch (size) {
+	case 4:
+		return __cmpxchg_u32(old, new, ptr);
+	case 8:
+		return __cmpxchg_u64(old, new, ptr);
+	default:
+		return __cmpxchg_called_with_bad_pointer();
+	}
+}
+
+#define arch_cmpxchg(ptr, old, new)					\
+	((__typeof__(*(ptr))) __cmpxchg(				\
+		(unsigned long)(old), (unsigned long)(new),		\
+		(ptr), sizeof(*(ptr))))
+
+/*
+ * In order to optimize xchg for 16 bits, we can use insf/extfz if we know the
+ * bounds. This way, we only take one more bundle than standard xchg. We simply
+ * do a read modify acswap on a 32 bits word.
+ */
+
+#define __kvx_insf(org, val, start, stop) __asm__ __volatile__(	\
+		"insf %[_org] = %[_val], %[_stop], %[_start]\n\t;;"	\
+		: [_org]"+r"(org)					\
+		: [_val]"r"(val), [_stop]"i"(stop), [_start]"i"(start))
+
+#define __kvx_extfz(out, val, start, stop) __asm__ __volatile__(	\
+		"extfz %[_out] = %[_val], %[_stop], %[_start]\n\t;;"	\
+		: [_out]"=r"(out)					\
+		: [_val]"r"(val), [_stop]"i"(stop), [_start]"i"(start))
+
+/* Needed for generic qspinlock implementation */
+static inline unsigned int __xchg_u16(unsigned int old, unsigned int new,
+				      volatile unsigned int *ptr)
+{
+	unsigned int off = ((unsigned long)ptr) % sizeof(unsigned int);
+	unsigned int val;
+
+	ptr = PTR_ALIGN_DOWN(ptr, sizeof(unsigned int));
+	__builtin_kvx_fence();
+	do {
+		old = *ptr;
+		val = old;
+		if (off == 0)
+			__kvx_insf(val, new, 0, 15);
+		else
+			__kvx_insf(val, new, 16, 31);
+	} while (!__builtin_kvx_acswapw((void *)ptr, val, old));
+
+	if (off == 0)
+		__kvx_extfz(old, old, 0, 15);
+	else
+		__kvx_extfz(old, old, 16, 31);
+
+	return old;
+}
+
+static inline unsigned int __xchg_u32(unsigned int old, unsigned int new,
+				      volatile unsigned int *ptr)
+{
+	__builtin_kvx_fence();
+	do
+		old = *ptr;
+	while (!__builtin_kvx_acswapw((void *)ptr, new, old));
+
+	return old;
+}
+
+static inline unsigned long __xchg_u64(unsigned long old, unsigned long new,
+				       volatile unsigned long *ptr)
+{
+	__builtin_kvx_fence();
+	do
+		old = *ptr;
+	while (!__builtin_kvx_acswapd((void *)ptr, new, old));
+
+	return old;
+}
+
+extern unsigned long __xchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for xchg");
+
+static __always_inline unsigned long __xchg(unsigned long val,
+					    volatile void *ptr, int size)
+{
+	switch (size) {
+	case 2:
+		return __xchg_u16(0, val, ptr);
+	case 4:
+		return __xchg_u32(0, val, ptr);
+	case 8:
+		return __xchg_u64(0, val, ptr);
+	default:
+		return __xchg_called_with_bad_pointer();
+	}
+}
+
+#define arch_xchg(ptr, val)						\
+	((__typeof__(*(ptr))) __xchg(					\
+		(unsigned long)(val),					\
+		(ptr), sizeof(*(ptr))))
+
+#endif
-- 
2.45.2






