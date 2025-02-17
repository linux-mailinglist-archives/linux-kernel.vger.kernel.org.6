Return-Path: <linux-kernel+bounces-516849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA6A3783A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9283AF9F6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DD21A7AE3;
	Sun, 16 Feb 2025 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHmc41bF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953721A3169;
	Sun, 16 Feb 2025 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739746832; cv=none; b=elq+jol92K34TkrEGUF6fLqSC0M4q4y4BYLeOSA4WEWvObB3xlPkQ+Se540WNgJRf+n9X8R5FC4i49tAdGMC2sbCRShLsREvDktOPRFmL+9KqVIDTTy1N0BZYyarpQRnr2S/M1A5FaWdT5nrZ2o2XwkD/9rkTj8tz7oBKz5IPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739746832; c=relaxed/simple;
	bh=CrKjpjSJnMDAw+XXemZV5l2/Pd7FR1iZTJImF71zJ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIHMn+IVtOhfT6w4Tb8lLw59roY6PD1A3jGHTEYsRHDtXQqXr7b6KnZFAD1lZNEk0WGq9+zcEfw5tIPl0tAByR+dDZJB1a/Slrwkd8LMvBIMQb7J93k9R+2ll2FBiuLf3whJ6yZ7MazuiJYk3CB4gTUTgoBvrzWllqgo98ohI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHmc41bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B03C4CEE8;
	Sun, 16 Feb 2025 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739746832;
	bh=CrKjpjSJnMDAw+XXemZV5l2/Pd7FR1iZTJImF71zJ4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHmc41bFdCIcQeOix/am4JlPUoCKk0eta005AzUtfaQBJRLM5XNS4S7YjiQng0PgH
	 IH4zKvLDbOaSWC+6KT839BQxAHf0LFNEtuRzkqPFHJ2PVaIzJgct0oTR9CHMR4St8Z
	 ROrDYqy9fIXnWvZEjCsae50IkSe4ToK2jZ2A98iTtD253L2uUuDYtSOafe3AcbZ/fv
	 OVdlXsCqiaCWBo3HOAy8C83NJVd2QoG4ouMoMo6ED9U6+hKjapRxAhvmhU4GN3Kq0e
	 jKvRgSkAbwkgEvmoTfFsQn+1nhKiEvHFfpWKA2CrN+5h1A+fgAiCv0jmt2MY0sm4Nh
	 eNcMAj7vXejGA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 1/4] riscv/crc: add "template" for Zbc optimized CRC functions
Date: Sun, 16 Feb 2025 14:55:27 -0800
Message-ID: <20250216225530.306980-2-ebiggers@kernel.org>
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

Add a "template" crc-clmul-template.h that can generate RISC-V Zbc
optimized CRC functions.  Each generated CRC function is parameterized
by CRC length and bit order, and it accepts a pointer to the constants
struct required for the specific CRC polynomial desired.  Update
gen-crc-consts.py to support generating the needed constants structs.

This makes it possible to easily wire up a Zbc optimized implementation
of almost any CRC.

The design generally follows what I did for x86, but it is simplified by
using RISC-V's scalar carryless multiplication Zbc, which has no
equivalent on x86.  RISC-V's clmulr instruction is also helpful.  A
potential switch to Zvbc (or support for Zvbc alongside Zbc) is left for
future work.  For long messages Zvbc should be fastest, but it would
need to be shown to be worthwhile over just using Zbc which is
significantly more convenient to use, especially in the kernel context.

Compared to the existing Zbc-optimized CRC32 code and the earlier
proposed Zbc-optimized CRC-T10DIF code
(https://lore.kernel.org/r/20250211071101.181652-1-zhihang.shao.iscas@gmail.com),
this submission deduplicates the code among CRC variants and is
significantly more optimized.  It uses "folding" to take better
advantage of instruction-level parallelism (to a more limited extent
than x86 for now, but it could be extended to more), it reworks the
Barrett reduction to eliminate unnecessary instructions, and it
documents all the math used and makes all the constants reproducible.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/lib/crc-clmul-template.h | 265 ++++++++++++++++++++++++++++
 scripts/gen-crc-consts.py           |  55 +++++-
 2 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/crc-clmul-template.h

diff --git a/arch/riscv/lib/crc-clmul-template.h b/arch/riscv/lib/crc-clmul-template.h
new file mode 100644
index 000000000000..77187e7f1762
--- /dev/null
+++ b/arch/riscv/lib/crc-clmul-template.h
@@ -0,0 +1,265 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2025 Google LLC */
+
+/*
+ * This file is a "template" that generates a CRC function optimized using the
+ * RISC-V Zbc (scalar carryless multiplication) extension.  The includer of this
+ * file must define the following parameters to specify the type of CRC:
+ *
+ *	crc_t: the data type of the CRC, e.g. u32 for a 32-bit CRC
+ *	LSB_CRC: 0 for a msb (most-significant-bit) first CRC, i.e. natural
+ *		 mapping between bits and polynomial coefficients
+ *	         1 for a lsb (least-significant-bit) first CRC, i.e. reflected
+ *	         mapping between bits and polynomial coefficients
+ */
+
+#include <asm/byteorder.h>
+#include <linux/minmax.h>
+
+#define CRC_BITS	(8 * sizeof(crc_t))	/* a.k.a. 'n' */
+
+static inline unsigned long clmul(unsigned long a, unsigned long b)
+{
+	unsigned long res;
+
+	asm(".option push\n"
+	    ".option arch,+zbc\n"
+	    "clmul %0, %1, %2\n"
+	    ".option pop\n"
+	    : "=r" (res) : "r" (a), "r" (b));
+	return res;
+}
+
+static inline unsigned long clmulh(unsigned long a, unsigned long b)
+{
+	unsigned long res;
+
+	asm(".option push\n"
+	    ".option arch,+zbc\n"
+	    "clmulh %0, %1, %2\n"
+	    ".option pop\n"
+	    : "=r" (res) : "r" (a), "r" (b));
+	return res;
+}
+
+static inline unsigned long clmulr(unsigned long a, unsigned long b)
+{
+	unsigned long res;
+
+	asm(".option push\n"
+	    ".option arch,+zbc\n"
+	    "clmulr %0, %1, %2\n"
+	    ".option pop\n"
+	    : "=r" (res) : "r" (a), "r" (b));
+	return res;
+}
+
+/*
+ * crc_load_long() loads one "unsigned long" of aligned data bytes, producing a
+ * polynomial whose bit order matches the CRC's bit order.
+ */
+#ifdef CONFIG_64BIT
+#  if LSB_CRC
+#    define crc_load_long(x)	le64_to_cpup(x)
+#  else
+#    define crc_load_long(x)	be64_to_cpup(x)
+#  endif
+#else
+#  if LSB_CRC
+#    define crc_load_long(x)	le32_to_cpup(x)
+#  else
+#    define crc_load_long(x)	be32_to_cpup(x)
+#  endif
+#endif
+
+/* XOR @crc into the end of @msgpoly that represents the high-order terms. */
+static inline unsigned long
+crc_clmul_prep(crc_t crc, unsigned long msgpoly)
+{
+#if LSB_CRC
+	return msgpoly ^ crc;
+#else
+	return msgpoly ^ ((unsigned long)crc << (BITS_PER_LONG - CRC_BITS));
+#endif
+}
+
+/*
+ * Multiply the long-sized @msgpoly by x^n (a.k.a. x^CRC_BITS) and reduce it
+ * modulo the generator polynomial G.  This gives the CRC of @msgpoly.
+ */
+static inline crc_t
+crc_clmul_long(unsigned long msgpoly, const struct crc_clmul_consts *consts)
+{
+	unsigned long tmp;
+
+	/*
+	 * First step of Barrett reduction with integrated multiplication by
+	 * x^n: calculate floor((msgpoly * x^n) / G).  This is the value by
+	 * which G needs to be multiplied to cancel out the x^n and higher terms
+	 * of msgpoly * x^n.  Do it using the following formula:
+	 *
+	 * msb-first:
+	 *    floor((msgpoly * floor(x^(BITS_PER_LONG-1+n) / G)) / x^(BITS_PER_LONG-1))
+	 * lsb-first:
+	 *    floor((msgpoly * floor(x^(BITS_PER_LONG-1+n) / G) * x) / x^BITS_PER_LONG)
+	 *
+	 * barrett_reduction_const_1 contains floor(x^(BITS_PER_LONG-1+n) / G),
+	 * which fits a long exactly.  Using any lower power of x there would
+	 * not carry enough precision through the calculation, while using any
+	 * higher power of x would require extra instructions to handle a wider
+	 * multiplication.  In the msb-first case, using this power of x results
+	 * in needing a floored division by x^(BITS_PER_LONG-1), which matches
+	 * what clmulr produces.  In the lsb-first case, a factor of x gets
+	 * implicitly introduced by each carryless multiplication (shown as
+	 * '* x' above), and the floored division instead needs to be by
+	 * x^BITS_PER_LONG which matches what clmul produces.
+	 */
+#if LSB_CRC
+	tmp = clmul(msgpoly, consts->barrett_reduction_const_1);
+#else
+	tmp = clmulr(msgpoly, consts->barrett_reduction_const_1);
+#endif
+
+	/*
+	 * Second step of Barrett reduction:
+	 *
+	 *    crc := (msgpoly * x^n) + (G * floor((msgpoly * x^n) / G))
+	 *
+	 * This reduces (msgpoly * x^n) modulo G by adding the appropriate
+	 * multiple of G to it.  The result uses only the x^0..x^(n-1) terms.
+	 * HOWEVER, since the unreduced value (msgpoly * x^n) is zero in those
+	 * terms in the first place, it is more efficient to do the equivalent:
+	 *
+	 *    crc := ((G - x^n) * floor((msgpoly * x^n) / G)) mod x^n
+	 *
+	 * In the lsb-first case further modify it to the following which avoids
+	 * a shift, as the crc ends up in the physically low n bits from clmulr:
+	 *
+	 *    product := ((G - x^n) * x^(BITS_PER_LONG - n)) * floor((msgpoly * x^n) / G) * x
+	 *    crc := floor(product / x^(BITS_PER_LONG + 1 - n)) mod x^n
+	 *
+	 * barrett_reduction_const_2 contains the constant multiplier (G - x^n)
+	 * or (G - x^n) * x^(BITS_PER_LONG - n) from the formulas above.  The
+	 * cast of the result to crc_t is essential, as it applies the mod x^n!
+	 */
+#if LSB_CRC
+	return clmulr(tmp, consts->barrett_reduction_const_2);
+#else
+	return clmul(tmp, consts->barrett_reduction_const_2);
+#endif
+}
+
+/* Update @crc with the data from @msgpoly. */
+static inline crc_t
+crc_clmul_update_long(crc_t crc, unsigned long msgpoly,
+		      const struct crc_clmul_consts *consts)
+{
+	return crc_clmul_long(crc_clmul_prep(crc, msgpoly), consts);
+}
+
+/* Update @crc with 1 <= @len < sizeof(unsigned long) bytes of data. */
+static inline crc_t
+crc_clmul_update_partial(crc_t crc, const u8 *p, size_t len,
+			 const struct crc_clmul_consts *consts)
+{
+	unsigned long msgpoly;
+	size_t i;
+
+#if LSB_CRC
+	msgpoly = (unsigned long)p[0] << (BITS_PER_LONG - 8);
+	for (i = 1; i < len; i++)
+		msgpoly = (msgpoly >> 8) ^ ((unsigned long)p[i] << (BITS_PER_LONG - 8));
+#else
+	msgpoly = p[0];
+	for (i = 1; i < len; i++)
+		msgpoly = (msgpoly << 8) ^ p[i];
+#endif
+
+	if (len >= sizeof(crc_t)) {
+	#if LSB_CRC
+		msgpoly ^= (unsigned long)crc << (BITS_PER_LONG - 8*len);
+	#else
+		msgpoly ^= (unsigned long)crc << (8*len - CRC_BITS);
+	#endif
+		return crc_clmul_long(msgpoly, consts);
+	}
+#if LSB_CRC
+	msgpoly ^= (unsigned long)crc << (BITS_PER_LONG - 8*len);
+	return crc_clmul_long(msgpoly, consts) ^ (crc >> (8*len));
+#else
+	msgpoly ^= crc >> (CRC_BITS - 8*len);
+	return crc_clmul_long(msgpoly, consts) ^ (crc << (8*len));
+#endif
+}
+
+static inline crc_t
+crc_clmul(crc_t crc, const void *p, size_t len,
+	  const struct crc_clmul_consts *consts)
+{
+	size_t align;
+
+	/* This implementation assumes that the CRC fits in an unsigned long. */
+	BUILD_BUG_ON(sizeof(crc_t) > sizeof(unsigned long));
+
+	/* If the buffer is not long-aligned, align it. */
+	align = (unsigned long)p % sizeof(unsigned long);
+	if (align && len) {
+		align = min(sizeof(unsigned long) - align, len);
+		crc = crc_clmul_update_partial(crc, p, align, consts);
+		p += align;
+		len -= align;
+	}
+
+	if (len >= 4 * sizeof(unsigned long)) {
+		unsigned long m0, m1;
+
+		m0 = crc_clmul_prep(crc, crc_load_long(p));
+		m1 = crc_load_long(p + sizeof(unsigned long));
+		p += 2 * sizeof(unsigned long);
+		len -= 2 * sizeof(unsigned long);
+		/*
+		 * Main loop.  Each iteration starts with a message polynomial
+		 * (x^BITS_PER_LONG)*m0 + m1, then logically extends it by two
+		 * more longs of data to form x^(3*BITS_PER_LONG)*m0 +
+		 * x^(2*BITS_PER_LONG)*m1 + x^BITS_PER_LONG*m2 + m3, then
+		 * "folds" that back into a congruent (modulo G) value that uses
+		 * just m0 and m1 again.  This is done by multiplying m0 by the
+		 * precomputed constant (x^(3*BITS_PER_LONG) mod G) and m1 by
+		 * the precomputed constant (x^(2*BITS_PER_LONG) mod G), then
+		 * adding the results to m2 and m3 as appropriate.  Each such
+		 * multiplication produces a result twice the length of a long,
+		 * which in RISC-V is two instructions clmul and clmulh.
+		 *
+		 * This could be changed to fold across more than 2 longs at a
+		 * time if there is a CPU that can take advantage of it.
+		 */
+		do {
+			unsigned long p0, p1, p2, p3;
+
+			p0 = clmulh(m0, consts->fold_across_2_longs_const_hi);
+			p1 = clmul(m0, consts->fold_across_2_longs_const_hi);
+			p2 = clmulh(m1, consts->fold_across_2_longs_const_lo);
+			p3 = clmul(m1, consts->fold_across_2_longs_const_lo);
+			m0 = (LSB_CRC ? p1 ^ p3 : p0 ^ p2) ^ crc_load_long(p);
+			m1 = (LSB_CRC ? p0 ^ p2 : p1 ^ p3) ^
+			     crc_load_long(p + sizeof(unsigned long));
+
+			p += 2 * sizeof(unsigned long);
+			len -= 2 * sizeof(unsigned long);
+		} while (len >= 2 * sizeof(unsigned long));
+
+		crc = crc_clmul_long(m0, consts);
+		crc = crc_clmul_update_long(crc, m1, consts);
+	}
+
+	while (len >= sizeof(unsigned long)) {
+		crc = crc_clmul_update_long(crc, crc_load_long(p), consts);
+		p += sizeof(unsigned long);
+		len -= sizeof(unsigned long);
+	}
+
+	if (len)
+		crc = crc_clmul_update_partial(crc, p, len, consts);
+
+	return crc;
+}
diff --git a/scripts/gen-crc-consts.py b/scripts/gen-crc-consts.py
index aa678a50897d..f9b44fc3a03f 100755
--- a/scripts/gen-crc-consts.py
+++ b/scripts/gen-crc-consts.py
@@ -103,10 +103,61 @@ def gen_slicebyN_tables(variants, n):
             s += (' ' if s else '') + next_entry
         if s:
             print(f'\t{s}')
         print('};')
 
+def print_riscv_const(v, bits_per_long, name, val, desc):
+    print(f'\t.{name} = {fmt_poly(v, val, bits_per_long)}, /* {desc} */')
+
+def do_gen_riscv_clmul_consts(v, bits_per_long):
+    (G, n, lsb) = (v.G, v.bits, v.lsb)
+
+    pow_of_x = 3 * bits_per_long - (1 if lsb else 0)
+    print_riscv_const(v, bits_per_long, 'fold_across_2_longs_const_hi',
+                      reduce(1 << pow_of_x, G), f'x^{pow_of_x} mod G')
+    pow_of_x = 2 * bits_per_long - (1 if lsb else 0)
+    print_riscv_const(v, bits_per_long, 'fold_across_2_longs_const_lo',
+                      reduce(1 << pow_of_x, G), f'x^{pow_of_x} mod G')
+
+    pow_of_x = bits_per_long - 1 + n
+    print_riscv_const(v, bits_per_long, 'barrett_reduction_const_1',
+                      div(1 << pow_of_x, G), f'floor(x^{pow_of_x} / G)')
+
+    val = G - (1 << n)
+    desc = f'G - x^{n}'
+    if lsb:
+        val <<= bits_per_long - n
+        desc = f'({desc}) * x^{bits_per_long - n}'
+    print_riscv_const(v, bits_per_long, 'barrett_reduction_const_2', val, desc)
+
+def gen_riscv_clmul_consts(variants):
+    print('')
+    print('struct crc_clmul_consts {');
+    print('\tunsigned long fold_across_2_longs_const_hi;');
+    print('\tunsigned long fold_across_2_longs_const_lo;');
+    print('\tunsigned long barrett_reduction_const_1;');
+    print('\tunsigned long barrett_reduction_const_2;');
+    print('};');
+    for v in variants:
+        print('');
+        if v.bits > 32:
+            print_header(v, 'Constants')
+            print('#ifdef CONFIG_64BIT')
+            print(f'static const struct crc_clmul_consts {v.name}_consts __maybe_unused = {{')
+            do_gen_riscv_clmul_consts(v, 64)
+            print('};')
+            print('#endif')
+        else:
+            print_header(v, 'Constants')
+            print(f'static const struct crc_clmul_consts {v.name}_consts __maybe_unused = {{')
+            print('#ifdef CONFIG_64BIT')
+            do_gen_riscv_clmul_consts(v, 64)
+            print('#else')
+            do_gen_riscv_clmul_consts(v, 32)
+            print('#endif')
+            print('};')
+
 # Generate constants for carryless multiplication based CRC computation.
 def gen_x86_pclmul_consts(variants):
     # These are the distances, in bits, to generate folding constants for.
     FOLD_DISTANCES = [2048, 1024, 512, 256, 128]
 
@@ -211,11 +262,11 @@ def parse_crc_variants(vars_string):
         variants.append(CrcVariant(bits, generator_poly, bit_order))
     return variants
 
 if len(sys.argv) != 3:
     sys.stderr.write(f'Usage: {sys.argv[0]} CONSTS_TYPE[,CONSTS_TYPE]... CRC_VARIANT[,CRC_VARIANT]...\n')
-    sys.stderr.write('  CONSTS_TYPE can be sliceby[1-8] or x86_pclmul\n')
+    sys.stderr.write('  CONSTS_TYPE can be sliceby[1-8], riscv_clmul, or x86_pclmul\n')
     sys.stderr.write('  CRC_VARIANT is crc${num_bits}_${bit_order}_${generator_poly_as_hex}\n')
     sys.stderr.write('     E.g. crc16_msb_0x8bb7 or crc32_lsb_0xedb88320\n')
     sys.stderr.write('     Polynomial must use the given bit_order and exclude x^{num_bits}\n')
     sys.exit(1)
 
@@ -230,9 +281,11 @@ print(' */')
 consts_types = sys.argv[1].split(',')
 variants = parse_crc_variants(sys.argv[2])
 for consts_type in consts_types:
     if consts_type.startswith('sliceby'):
         gen_slicebyN_tables(variants, int(consts_type.removeprefix('sliceby')))
+    elif consts_type == 'riscv_clmul':
+        gen_riscv_clmul_consts(variants)
     elif consts_type == 'x86_pclmul':
         gen_x86_pclmul_consts(variants)
     else:
         raise ValueError(f'Unknown consts_type: {consts_type}')
-- 
2.48.1


