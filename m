Return-Path: <linux-kernel+bounces-516848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB650A37839
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB6316F2EC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A831A76DA;
	Sun, 16 Feb 2025 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZbcywjJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406D18FC89;
	Sun, 16 Feb 2025 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739746832; cv=none; b=NX3up/d49pelQUtemEOqDaPTEZEJBCwTUxbyHQfGIvVniyn7wC7jAbH6LkjUUYJgCKeZJNUJ6wXdTs+L9GEMB89RqIWwYSDnl55/uZvaSzQuYT0NTDXep4NqQ9H+K33bR22aVpLv6nnY+JJsNa+qAZuIRI3O2Op2MdCnEG3kDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739746832; c=relaxed/simple;
	bh=n3QS9UDn4sQ33onbfipQ0mGDpU0ZBGjKLwA9GWJRNjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssy4ay96PMdrPupWgb2ZM43rn9khkhuBV10BdJGo84TnR5iBahJPqmV9iwKbf9sw2RxMgAFTeSNB3NwXUeTlm9R/iODcqSMLbo415i1YzevYfTMIgYVvQjpCAW24jnH5lSm1If8PKvgcJ8r0mBHGzSbhKF4cwZIoTiZO+/XUC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZbcywjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D746C4CEE9;
	Sun, 16 Feb 2025 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739746832;
	bh=n3QS9UDn4sQ33onbfipQ0mGDpU0ZBGjKLwA9GWJRNjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZbcywjJEu0BvDA/Su6dNowHx7Um/HOK/QFFJqhYB5bCOiijH+Lr9fF5CC6/L3X2I
	 Ogdt+ZCLJUT2pb0KT8Raq0J36QWKw6pppOpVf7r+MLgfxZjWh301issd1AZDPGugsR
	 LkV0I4ZN9r3qMyHIsth/6tFAY6YXgufEo74UhOMzGmJToJAR5uBpdoSsRk3FTpa51w
	 BH+WB8Nom1S0mps8iMT1ZnoWcGZJdxy7F1oA8tTZapBHNPfKdpIdEu2Kmtvo64nvDv
	 yzAk0npbw2up0r4UpTvw1fT6857r/5WdwDa6oxeitFH7L6lpBUOcuSGarzXc1WjpGF
	 Pktx1g9TGS/zA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 2/4] riscv/crc32: reimplement the CRC32 functions using new template
Date: Sun, 16 Feb 2025 14:55:28 -0800
Message-ID: <20250216225530.306980-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216225530.306980-1-ebiggers@kernel.org>
References: <20250216225530.306980-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Delete the previous Zbc optimized CRC32 code, and re-implement it using
the new template.  The new implementation is more optimized and shares
more code among CRC variants.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/lib/Makefile           |   1 +
 arch/riscv/lib/crc-clmul-consts.h |  72 +++++++
 arch/riscv/lib/crc-clmul.h        |  15 ++
 arch/riscv/lib/crc32-riscv.c      | 310 ------------------------------
 arch/riscv/lib/crc32.c            |  53 +++++
 arch/riscv/lib/crc32_lsb.c        |  18 ++
 arch/riscv/lib/crc32_msb.c        |  18 ++
 7 files changed, 177 insertions(+), 310 deletions(-)
 create mode 100644 arch/riscv/lib/crc-clmul-consts.h
 create mode 100644 arch/riscv/lib/crc-clmul.h
 delete mode 100644 arch/riscv/lib/crc32-riscv.c
 create mode 100644 arch/riscv/lib/crc32.c
 create mode 100644 arch/riscv/lib/crc32_lsb.c
 create mode 100644 arch/riscv/lib/crc32_msb.c

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 79368a895fee..7b32d3e88337 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -14,8 +14,9 @@ lib-$(CONFIG_RISCV_ISA_V)	+= uaccess_vector.o
 endif
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
 obj-$(CONFIG_CRC32_ARCH)	+= crc32-riscv.o
+crc32-riscv-y := crc32.o crc32_msb.o crc32_lsb.o
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 lib-$(CONFIG_RISCV_ISA_V)	+= xor.o
 lib-$(CONFIG_RISCV_ISA_V)	+= riscv_v_helpers.o
diff --git a/arch/riscv/lib/crc-clmul-consts.h b/arch/riscv/lib/crc-clmul-consts.h
new file mode 100644
index 000000000000..6fdf10648a20
--- /dev/null
+++ b/arch/riscv/lib/crc-clmul-consts.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CRC constants generated by:
+ *
+ *	./scripts/gen-crc-consts.py riscv_clmul crc32_msb_0x04c11db7,crc32_lsb_0xedb88320,crc32_lsb_0x82f63b78
+ *
+ * Do not edit manually.
+ */
+
+struct crc_clmul_consts {
+	unsigned long fold_across_2_longs_const_hi;
+	unsigned long fold_across_2_longs_const_lo;
+	unsigned long barrett_reduction_const_1;
+	unsigned long barrett_reduction_const_2;
+};
+
+/*
+ * Constants generated for most-significant-bit-first CRC-32 using
+ * G(x) = x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 +
+ *        x^5 + x^4 + x^2 + x^1 + x^0
+ */
+static const struct crc_clmul_consts crc32_msb_0x04c11db7_consts __maybe_unused = {
+#ifdef CONFIG_64BIT
+	.fold_across_2_longs_const_hi = 0x00000000c5b9cd4c, /* x^192 mod G */
+	.fold_across_2_longs_const_lo = 0x00000000e8a45605, /* x^128 mod G */
+	.barrett_reduction_const_1 = 0x826880efa40da72d, /* floor(x^95 / G) */
+	.barrett_reduction_const_2 = 0x0000000004c11db7, /* G - x^32 */
+#else
+	.fold_across_2_longs_const_hi = 0xf200aa66, /* x^96 mod G */
+	.fold_across_2_longs_const_lo = 0x490d678d, /* x^64 mod G */
+	.barrett_reduction_const_1 = 0x826880ef, /* floor(x^63 / G) */
+	.barrett_reduction_const_2 = 0x04c11db7, /* G - x^32 */
+#endif
+};
+
+/*
+ * Constants generated for least-significant-bit-first CRC-32 using
+ * G(x) = x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 +
+ *        x^5 + x^4 + x^2 + x^1 + x^0
+ */
+static const struct crc_clmul_consts crc32_lsb_0xedb88320_consts __maybe_unused = {
+#ifdef CONFIG_64BIT
+	.fold_across_2_longs_const_hi = 0x65673b4600000000, /* x^191 mod G */
+	.fold_across_2_longs_const_lo = 0x9ba54c6f00000000, /* x^127 mod G */
+	.barrett_reduction_const_1 = 0xb4e5b025f7011641, /* floor(x^95 / G) */
+	.barrett_reduction_const_2 = 0x00000000edb88320, /* (G - x^32) * x^32 */
+#else
+	.fold_across_2_longs_const_hi = 0xccaa009e, /* x^95 mod G */
+	.fold_across_2_longs_const_lo = 0xb8bc6765, /* x^63 mod G */
+	.barrett_reduction_const_1 = 0xf7011641, /* floor(x^63 / G) */
+	.barrett_reduction_const_2 = 0xedb88320, /* (G - x^32) * x^0 */
+#endif
+};
+
+/*
+ * Constants generated for least-significant-bit-first CRC-32 using
+ * G(x) = x^32 + x^28 + x^27 + x^26 + x^25 + x^23 + x^22 + x^20 + x^19 + x^18 +
+ *        x^14 + x^13 + x^11 + x^10 + x^9 + x^8 + x^6 + x^0
+ */
+static const struct crc_clmul_consts crc32_lsb_0x82f63b78_consts __maybe_unused = {
+#ifdef CONFIG_64BIT
+	.fold_across_2_longs_const_hi = 0x3743f7bd00000000, /* x^191 mod G */
+	.fold_across_2_longs_const_lo = 0x3171d43000000000, /* x^127 mod G */
+	.barrett_reduction_const_1 = 0x4869ec38dea713f1, /* floor(x^95 / G) */
+	.barrett_reduction_const_2 = 0x0000000082f63b78, /* (G - x^32) * x^32 */
+#else
+	.fold_across_2_longs_const_hi = 0x493c7d27, /* x^95 mod G */
+	.fold_across_2_longs_const_lo = 0xdd45aab8, /* x^63 mod G */
+	.barrett_reduction_const_1 = 0xdea713f1, /* floor(x^63 / G) */
+	.barrett_reduction_const_2 = 0x82f63b78, /* (G - x^32) * x^0 */
+#endif
+};
diff --git a/arch/riscv/lib/crc-clmul.h b/arch/riscv/lib/crc-clmul.h
new file mode 100644
index 000000000000..62bd41080785
--- /dev/null
+++ b/arch/riscv/lib/crc-clmul.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2025 Google LLC */
+
+#ifndef _RISCV_CRC_CLMUL_H
+#define _RISCV_CRC_CLMUL_H
+
+#include <linux/types.h>
+#include "crc-clmul-consts.h"
+
+u32 crc32_msb_clmul(u32 crc, const void *p, size_t len,
+		    const struct crc_clmul_consts *consts);
+u32 crc32_lsb_clmul(u32 crc, const void *p, size_t len,
+		    const struct crc_clmul_consts *consts);
+
+#endif /* _RISCV_CRC_CLMUL_H */
diff --git a/arch/riscv/lib/crc32-riscv.c b/arch/riscv/lib/crc32-riscv.c
deleted file mode 100644
index b5cb752847c4..000000000000
--- a/arch/riscv/lib/crc32-riscv.c
+++ /dev/null
@@ -1,310 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Accelerated CRC32 implementation with Zbc extension.
- *
- * Copyright (C) 2024 Intel Corporation
- */
-
-#include <asm/hwcap.h>
-#include <asm/alternative-macros.h>
-#include <asm/byteorder.h>
-
-#include <linux/types.h>
-#include <linux/minmax.h>
-#include <linux/crc32poly.h>
-#include <linux/crc32.h>
-#include <linux/byteorder/generic.h>
-#include <linux/module.h>
-
-/*
- * Refer to https://www.corsix.org/content/barrett-reduction-polynomials for
- * better understanding of how this math works.
- *
- * let "+" denotes polynomial add (XOR)
- * let "-" denotes polynomial sub (XOR)
- * let "*" denotes polynomial multiplication
- * let "/" denotes polynomial floor division
- * let "S" denotes source data, XLEN bit wide
- * let "P" denotes CRC32 polynomial
- * let "T" denotes 2^(XLEN+32)
- * let "QT" denotes quotient of T/P, with the bit for 2^XLEN being implicit
- *
- * crc32(S, P)
- * => S * (2^32) - S * (2^32) / P * P
- * => lowest 32 bits of: S * (2^32) / P * P
- * => lowest 32 bits of: S * (2^32) * (T / P) / T * P
- * => lowest 32 bits of: S * (2^32) * quotient / T * P
- * => lowest 32 bits of: S * quotient / 2^XLEN * P
- * => lowest 32 bits of: (clmul_high_part(S, QT) + S) * P
- * => clmul_low_part(clmul_high_part(S, QT) + S, P)
- *
- * In terms of below implementations, the BE case is more intuitive, since the
- * higher order bit sits at more significant position.
- */
-
-#if __riscv_xlen == 64
-/* Slide by XLEN bits per iteration */
-# define STEP_ORDER 3
-
-/* Each below polynomial quotient has an implicit bit for 2^XLEN */
-
-/* Polynomial quotient of (2^(XLEN+32))/CRC32_POLY, in LE format */
-# define CRC32_POLY_QT_LE	0x5a72d812fb808b20
-
-/* Polynomial quotient of (2^(XLEN+32))/CRC32C_POLY, in LE format */
-# define CRC32C_POLY_QT_LE	0xa434f61c6f5389f8
-
-/* Polynomial quotient of (2^(XLEN+32))/CRC32_POLY, in BE format, it should be
- * the same as the bit-reversed version of CRC32_POLY_QT_LE
- */
-# define CRC32_POLY_QT_BE	0x04d101df481b4e5a
-
-static inline u64 crc32_le_prep(u32 crc, unsigned long const *ptr)
-{
-	return (u64)crc ^ (__force u64)__cpu_to_le64(*ptr);
-}
-
-static inline u32 crc32_le_zbc(unsigned long s, u32 poly, unsigned long poly_qt)
-{
-	u32 crc;
-
-	/* We don't have a "clmulrh" insn, so use clmul + slli instead. */
-	asm volatile (".option push\n"
-		      ".option arch,+zbc\n"
-		      "clmul	%0, %1, %2\n"
-		      "slli	%0, %0, 1\n"
-		      "xor	%0, %0, %1\n"
-		      "clmulr	%0, %0, %3\n"
-		      "srli	%0, %0, 32\n"
-		      ".option pop\n"
-		      : "=&r" (crc)
-		      : "r" (s),
-			"r" (poly_qt),
-			"r" ((u64)poly << 32)
-		      :);
-	return crc;
-}
-
-static inline u64 crc32_be_prep(u32 crc, unsigned long const *ptr)
-{
-	return ((u64)crc << 32) ^ (__force u64)__cpu_to_be64(*ptr);
-}
-
-#elif __riscv_xlen == 32
-# define STEP_ORDER 2
-/* Each quotient should match the upper half of its analog in RV64 */
-# define CRC32_POLY_QT_LE	0xfb808b20
-# define CRC32C_POLY_QT_LE	0x6f5389f8
-# define CRC32_POLY_QT_BE	0x04d101df
-
-static inline u32 crc32_le_prep(u32 crc, unsigned long const *ptr)
-{
-	return crc ^ (__force u32)__cpu_to_le32(*ptr);
-}
-
-static inline u32 crc32_le_zbc(unsigned long s, u32 poly, unsigned long poly_qt)
-{
-	u32 crc;
-
-	/* We don't have a "clmulrh" insn, so use clmul + slli instead. */
-	asm volatile (".option push\n"
-		      ".option arch,+zbc\n"
-		      "clmul	%0, %1, %2\n"
-		      "slli	%0, %0, 1\n"
-		      "xor	%0, %0, %1\n"
-		      "clmulr	%0, %0, %3\n"
-		      ".option pop\n"
-		      : "=&r" (crc)
-		      : "r" (s),
-			"r" (poly_qt),
-			"r" (poly)
-		      :);
-	return crc;
-}
-
-static inline u32 crc32_be_prep(u32 crc, unsigned long const *ptr)
-{
-	return crc ^ (__force u32)__cpu_to_be32(*ptr);
-}
-
-#else
-# error "Unexpected __riscv_xlen"
-#endif
-
-static inline u32 crc32_be_zbc(unsigned long s)
-{
-	u32 crc;
-
-	asm volatile (".option push\n"
-		      ".option arch,+zbc\n"
-		      "clmulh	%0, %1, %2\n"
-		      "xor	%0, %0, %1\n"
-		      "clmul	%0, %0, %3\n"
-		      ".option pop\n"
-		      : "=&r" (crc)
-		      : "r" (s),
-			"r" (CRC32_POLY_QT_BE),
-			"r" (CRC32_POLY_BE)
-		      :);
-	return crc;
-}
-
-#define STEP		(1 << STEP_ORDER)
-#define OFFSET_MASK	(STEP - 1)
-
-typedef u32 (*fallback)(u32 crc, unsigned char const *p, size_t len);
-
-static inline u32 crc32_le_unaligned(u32 crc, unsigned char const *p,
-				     size_t len, u32 poly,
-				     unsigned long poly_qt)
-{
-	size_t bits = len * 8;
-	unsigned long s = 0;
-	u32 crc_low = 0;
-
-	for (int i = 0; i < len; i++)
-		s = ((unsigned long)*p++ << (__riscv_xlen - 8)) | (s >> 8);
-
-	s ^= (unsigned long)crc << (__riscv_xlen - bits);
-	if (__riscv_xlen == 32 || len < sizeof(u32))
-		crc_low = crc >> bits;
-
-	crc = crc32_le_zbc(s, poly, poly_qt);
-	crc ^= crc_low;
-
-	return crc;
-}
-
-static inline u32 crc32_le_generic(u32 crc, unsigned char const *p, size_t len,
-				   u32 poly, unsigned long poly_qt,
-				   fallback crc_fb)
-{
-	size_t offset, head_len, tail_len;
-	unsigned long const *p_ul;
-	unsigned long s;
-
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-			     RISCV_ISA_EXT_ZBC, 1)
-		 : : : : legacy);
-
-	/* Handle the unaligned head. */
-	offset = (unsigned long)p & OFFSET_MASK;
-	if (offset && len) {
-		head_len = min(STEP - offset, len);
-		crc = crc32_le_unaligned(crc, p, head_len, poly, poly_qt);
-		p += head_len;
-		len -= head_len;
-	}
-
-	tail_len = len & OFFSET_MASK;
-	len = len >> STEP_ORDER;
-	p_ul = (unsigned long const *)p;
-
-	for (int i = 0; i < len; i++) {
-		s = crc32_le_prep(crc, p_ul);
-		crc = crc32_le_zbc(s, poly, poly_qt);
-		p_ul++;
-	}
-
-	/* Handle the tail bytes. */
-	p = (unsigned char const *)p_ul;
-	if (tail_len)
-		crc = crc32_le_unaligned(crc, p, tail_len, poly, poly_qt);
-
-	return crc;
-
-legacy:
-	return crc_fb(crc, p, len);
-}
-
-u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
-{
-	return crc32_le_generic(crc, p, len, CRC32_POLY_LE, CRC32_POLY_QT_LE,
-				crc32_le_base);
-}
-EXPORT_SYMBOL(crc32_le_arch);
-
-u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
-{
-	return crc32_le_generic(crc, p, len, CRC32C_POLY_LE,
-				CRC32C_POLY_QT_LE, crc32c_base);
-}
-EXPORT_SYMBOL(crc32c_arch);
-
-static inline u32 crc32_be_unaligned(u32 crc, unsigned char const *p,
-				     size_t len)
-{
-	size_t bits = len * 8;
-	unsigned long s = 0;
-	u32 crc_low = 0;
-
-	s = 0;
-	for (int i = 0; i < len; i++)
-		s = *p++ | (s << 8);
-
-	if (__riscv_xlen == 32 || len < sizeof(u32)) {
-		s ^= crc >> (32 - bits);
-		crc_low = crc << bits;
-	} else {
-		s ^= (unsigned long)crc << (bits - 32);
-	}
-
-	crc = crc32_be_zbc(s);
-	crc ^= crc_low;
-
-	return crc;
-}
-
-u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
-{
-	size_t offset, head_len, tail_len;
-	unsigned long const *p_ul;
-	unsigned long s;
-
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-			     RISCV_ISA_EXT_ZBC, 1)
-		 : : : : legacy);
-
-	/* Handle the unaligned head. */
-	offset = (unsigned long)p & OFFSET_MASK;
-	if (offset && len) {
-		head_len = min(STEP - offset, len);
-		crc = crc32_be_unaligned(crc, p, head_len);
-		p += head_len;
-		len -= head_len;
-	}
-
-	tail_len = len & OFFSET_MASK;
-	len = len >> STEP_ORDER;
-	p_ul = (unsigned long const *)p;
-
-	for (int i = 0; i < len; i++) {
-		s = crc32_be_prep(crc, p_ul);
-		crc = crc32_be_zbc(s);
-		p_ul++;
-	}
-
-	/* Handle the tail bytes. */
-	p = (unsigned char const *)p_ul;
-	if (tail_len)
-		crc = crc32_be_unaligned(crc, p, tail_len);
-
-	return crc;
-
-legacy:
-	return crc32_be_base(crc, p, len);
-}
-EXPORT_SYMBOL(crc32_be_arch);
-
-u32 crc32_optimizations(void)
-{
-	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBC))
-		return CRC32_LE_OPTIMIZATION |
-		       CRC32_BE_OPTIMIZATION |
-		       CRC32C_OPTIMIZATION;
-	return 0;
-}
-EXPORT_SYMBOL(crc32_optimizations);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Accelerated CRC32 implementation with Zbc extension");
diff --git a/arch/riscv/lib/crc32.c b/arch/riscv/lib/crc32.c
new file mode 100644
index 000000000000..a3188b7d9c40
--- /dev/null
+++ b/arch/riscv/lib/crc32.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RISC-V optimized CRC32 functions
+ *
+ * Copyright 2025 Google LLC
+ */
+
+#include <asm/hwcap.h>
+#include <asm/alternative-macros.h>
+#include <linux/crc32.h>
+#include <linux/module.h>
+
+#include "crc-clmul.h"
+
+u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
+{
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBC))
+		return crc32_lsb_clmul(crc, p, len,
+				       &crc32_lsb_0xedb88320_consts);
+	return crc32_le_base(crc, p, len);
+}
+EXPORT_SYMBOL(crc32_le_arch);
+
+u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
+{
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBC))
+		return crc32_msb_clmul(crc, p, len,
+				       &crc32_msb_0x04c11db7_consts);
+	return crc32_be_base(crc, p, len);
+}
+EXPORT_SYMBOL(crc32_be_arch);
+
+u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
+{
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBC))
+		return crc32_lsb_clmul(crc, p, len,
+				       &crc32_lsb_0x82f63b78_consts);
+	return crc32c_base(crc, p, len);
+}
+EXPORT_SYMBOL(crc32c_arch);
+
+u32 crc32_optimizations(void)
+{
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBC))
+		return CRC32_LE_OPTIMIZATION |
+		       CRC32_BE_OPTIMIZATION |
+		       CRC32C_OPTIMIZATION;
+	return 0;
+}
+EXPORT_SYMBOL(crc32_optimizations);
+
+MODULE_DESCRIPTION("RISC-V optimized CRC32 functions");
+MODULE_LICENSE("GPL");
diff --git a/arch/riscv/lib/crc32_lsb.c b/arch/riscv/lib/crc32_lsb.c
new file mode 100644
index 000000000000..72fd67e7470c
--- /dev/null
+++ b/arch/riscv/lib/crc32_lsb.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RISC-V optimized least-significant-bit-first CRC32
+ *
+ * Copyright 2025 Google LLC
+ */
+
+#include "crc-clmul.h"
+
+typedef u32 crc_t;
+#define LSB_CRC 1
+#include "crc-clmul-template.h"
+
+u32 crc32_lsb_clmul(u32 crc, const void *p, size_t len,
+		    const struct crc_clmul_consts *consts)
+{
+	return crc_clmul(crc, p, len, consts);
+}
diff --git a/arch/riscv/lib/crc32_msb.c b/arch/riscv/lib/crc32_msb.c
new file mode 100644
index 000000000000..fdbeaccc369f
--- /dev/null
+++ b/arch/riscv/lib/crc32_msb.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RISC-V optimized most-significant-bit-first CRC32
+ *
+ * Copyright 2025 Google LLC
+ */
+
+#include "crc-clmul.h"
+
+typedef u32 crc_t;
+#define LSB_CRC 0
+#include "crc-clmul-template.h"
+
+u32 crc32_msb_clmul(u32 crc, const void *p, size_t len,
+		    const struct crc_clmul_consts *consts)
+{
+	return crc_clmul(crc, p, len, consts);
+}
-- 
2.48.1


