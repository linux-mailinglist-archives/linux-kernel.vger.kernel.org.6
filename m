Return-Path: <linux-kernel+bounces-420437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AFB9D7AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 05:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924B51625E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 04:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB1B15F41F;
	Mon, 25 Nov 2024 04:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DESdya/i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1685270;
	Mon, 25 Nov 2024 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732507969; cv=none; b=mSnnm6g2TmZ1rrCsDpQX3qaSicYphPwFnXCynuPbop30m+KiyYsDKJfd9TVQrQxG2HigUtk73ETNqR/wdN0wHjy2Wk4On98E0aiiqqCRw7ZImmeueRV9fGNpuQRRBr4723bcv1FjpkfQxmfl020SfWjVn8dE8Nv721vXHHJT4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732507969; c=relaxed/simple;
	bh=75I+ZyoNc9JYHHqQuax90nCiaXQqm5LrwpPROmSUBDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6XcA56+4N1XHqs5Xh3GdgC1Uz+wKRt/1Dm8PZPYxcTU8clMT137E3tUj33p/SNZ6Q89efX/KOdi6z5pYmoXS6lsOJvetU4psYs2qPhIxb9mBK6ImwAwfxo/HAUdjRCNGgKlvxCycEPkBzIAmUouHB/VnkqwW9dKoHKyNYYqWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DESdya/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7BBC4CED8;
	Mon, 25 Nov 2024 04:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732507969;
	bh=75I+ZyoNc9JYHHqQuax90nCiaXQqm5LrwpPROmSUBDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DESdya/iPQjek2XgyFBguzF6I0CGpC9l7lSwPcXttQhPbRaLgddnHGnuT//rPAXqY
	 v0C59fz9tWt5RKoi5UgXXEjByhR1OLsmftPa1N3JvpRzp7ay1cispW2Eb15unTKhcR
	 vhAomEighAsEvqtZ6I/l4FOYaq96mKTJ2x7qJqLbdOCALz/TQ3A1BXOlVyHofM7VOE
	 RzHoS2cn066nRcQZQXrQ1eKInHLZEI+Unno6alpO1RfrGCbe/7Rqk/IkdHilgXcjkX
	 lLwe38nhFyzve8pWLcQm9tyW/8WeqMk6l7sboe5oQXU3oqSIR7cXJin+EzBQlYi8Zb
	 D5hMVTJTQx/fw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4/6] x86/crc32: implement crc32_le using new template
Date: Sun, 24 Nov 2024 20:11:27 -0800
Message-ID: <20241125041129.192999-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125041129.192999-1-ebiggers@kernel.org>
References: <20241125041129.192999-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Instantiate crc-pclmul-template.S for crc32_le, and delete the original
PCLMULQDQ optimized implementation.  This has the following advantages:

- Less CRC-variant-specific code.
- Full VPCLMULQDQ support, improving performance on newer CPUs.
- A faster final reduction from 128 bits.
- Support for lengths not a multiple of 16 bytes, improving performance
  for such lengths.
- Support for misaligned buffers, improving performance in such cases.

Benchmark results on AMD Ryzen 9 9950X (Zen 5) using crc_kunit:

	Length     Before        After
	------     ------        -----
	     1     274 MB/s      302 MB/s
	    16    3004 MB/s     2576 MB/s
	    64    3077 MB/s     7406 MB/s
	   127    2791 MB/s     9768 MB/s
	   128    8366 MB/s    12878 MB/s
	   200   10010 MB/s    15320 MB/s
	   256   16018 MB/s    22664 MB/s
	   511   11809 MB/s    27646 MB/s
	   512   18473 MB/s    48241 MB/s
	  1024   20002 MB/s    63912 MB/s
	  3173   20907 MB/s    78547 MB/s
	  4096   21291 MB/s    82808 MB/s
	 16384   21304 MB/s    83350 MB/s

The above results compare the state directly before this patch to the
state after this patch.  Note that performance was also improved earlier
by eliminating the indirect call associated with the crypto API.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/lib/crc-pclmul-consts.h |  55 ++++++++
 arch/x86/lib/crc32-glue.c        |  34 ++---
 arch/x86/lib/crc32-pclmul.S      | 219 +------------------------------
 3 files changed, 68 insertions(+), 240 deletions(-)
 create mode 100644 arch/x86/lib/crc-pclmul-consts.h

diff --git a/arch/x86/lib/crc-pclmul-consts.h b/arch/x86/lib/crc-pclmul-consts.h
new file mode 100644
index 0000000000000..ed9a625cdd2a6
--- /dev/null
+++ b/arch/x86/lib/crc-pclmul-consts.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CRC constants generated by:
+ *
+ *	./scripts/crc/gen-crc-consts.py x86_pclmul crc32_lsb_0xedb88320
+ *
+ * Do not edit manually.
+ */
+
+/*
+ * CRC folding constants generated for least-significant-bit-first CRC-32 using
+ * G(x) = x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 +
+ *        x^5 + x^4 + x^2 + x + 1
+ */
+static const struct {
+	u64 fold_across_2048_bits_consts[2];
+	u64 fold_across_1024_bits_consts[2];
+	u64 fold_across_512_bits_consts[2];
+	u64 fold_across_256_bits_consts[2];
+	u64 fold_across_128_bits_consts[2];
+	u8 shuf_table[48];
+	u64 barrett_reduction_consts[2];
+	u64 extract_crc_mask[2];
+} crc32_lsb_0xedb88320_consts __cacheline_aligned __maybe_unused = {
+	.fold_across_2048_bits_consts = {
+		0xce3371cb,	/* x^(2048+64-33) mod G(x) */
+		0xe95c1271,	/* x^(2048+0-33) mod G(x) */
+	},
+	.fold_across_1024_bits_consts = {
+		0x33fff533,	/* x^(1024+64-33) mod G(x) */
+		0x910eeec1,	/* x^(1024+0-33) mod G(x) */
+	},
+	.fold_across_512_bits_consts = {
+		0x8f352d95,	/* x^(512+64-33) mod G(x) */
+		0x1d9513d7,	/* x^(512+0-33) mod G(x) */
+	},
+	.fold_across_256_bits_consts = {
+		0xf1da05aa,	/* x^(256+64-33) mod G(x) */
+		0x81256527,	/* x^(256+0-33) mod G(x) */
+	},
+	.fold_across_128_bits_consts = {
+		0xae689191,	/* x^(128+64-33) mod G(x) */
+		0xccaa009e,	/* x^(128+0-33) mod G(x) */
+	},
+	.shuf_table = {
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+		 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+	},
+	.barrett_reduction_consts = {
+		0xb4e5b025f7011641,	/* floor(x^95 / G(x)) */
+		0x1db710641,	/* G(x) */
+	},
+	.extract_crc_mask = {0, 0xffffffff},
+};
diff --git a/arch/x86/lib/crc32-glue.c b/arch/x86/lib/crc32-glue.c
index 2dd18a886ded8..afcdeee429664 100644
--- a/arch/x86/lib/crc32-glue.c
+++ b/arch/x86/lib/crc32-glue.c
@@ -11,41 +11,23 @@
 #include <asm/simd.h>
 #include <crypto/internal/simd.h>
 #include <linux/crc32.h>
 #include <linux/linkage.h>
 #include <linux/module.h>
-
-/* minimum size of buffer for crc32_pclmul_le_16 */
-#define CRC32_PCLMUL_MIN_LEN	64
+#include "crc-pclmul-consts.h"
+#include "crc-pclmul-template-glue.h"
 
 static DEFINE_STATIC_KEY_FALSE(have_crc32);
 static DEFINE_STATIC_KEY_FALSE(have_pclmulqdq);
 
-u32 crc32_pclmul_le_16(u32 crc, const u8 *buffer, size_t len);
+DECLARE_CRC_PCLMUL_FUNCS(crc32_lsb, u32);
 
 u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 {
-	if (len >= CRC32_PCLMUL_MIN_LEN + 15 &&
-	    static_branch_likely(&have_pclmulqdq) && crypto_simd_usable()) {
-		size_t n = -(uintptr_t)p & 15;
-
-		/* align p to 16-byte boundary */
-		if (n) {
-			crc = crc32_le_base(crc, p, n);
-			p += n;
-			len -= n;
-		}
-		n = round_down(len, 16);
-		kernel_fpu_begin();
-		crc = crc32_pclmul_le_16(crc, p, n);
-		kernel_fpu_end();
-		p += n;
-		len -= n;
-	}
-	if (len)
-		crc = crc32_le_base(crc, p, len);
-	return crc;
+	CRC_PCLMUL(crc, p, len, crc32_lsb, crc32_lsb_0xedb88320_consts,
+		   have_pclmulqdq, IS_ENABLED(CONFIG_CRC32_SLICEBY8));
+	return crc32_le_base(crc, p, len);
 }
 EXPORT_SYMBOL(crc32_le_arch);
 
 #ifdef CONFIG_X86_64
 #define CRC32_INST "crc32q %1, %q0"
@@ -95,12 +77,14 @@ EXPORT_SYMBOL(crc32_be_arch);
 
 static int __init crc32_x86_init(void)
 {
 	if (boot_cpu_has(X86_FEATURE_XMM4_2))
 		static_branch_enable(&have_crc32);
-	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ))
+	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
 		static_branch_enable(&have_pclmulqdq);
+		INIT_CRC_PCLMUL(crc32_lsb);
+	}
 	return 0;
 }
 arch_initcall(crc32_x86_init);
 
 static void __exit crc32_x86_exit(void)
diff --git a/arch/x86/lib/crc32-pclmul.S b/arch/x86/lib/crc32-pclmul.S
index f9637789cac19..cf07d571ae864 100644
--- a/arch/x86/lib/crc32-pclmul.S
+++ b/arch/x86/lib/crc32-pclmul.S
@@ -1,217 +1,6 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2012 Xyratex Technology Limited
- *
- * Using hardware provided PCLMULQDQ instruction to accelerate the CRC32
- * calculation.
- * CRC32 polynomial:0x04c11db7(BE)/0xEDB88320(LE)
- * PCLMULQDQ is a new instruction in Intel SSE4.2, the reference can be found
- * at:
- * http://www.intel.com/products/processor/manuals/
- * Intel(R) 64 and IA-32 Architectures Software Developer's Manual
- * Volume 2B: Instruction Set Reference, N-Z
- *
- * Authors:   Gregory Prestas <Gregory_Prestas@us.xyratex.com>
- *	      Alexander Boyko <Alexander_Boyko@xyratex.com>
- */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+// Copyright 2024 Google LLC
 
-#include <linux/linkage.h>
+#include "crc-pclmul-template.S"
 
-
-.section .rodata
-.align 16
-/*
- * [x4*128+32 mod P(x) << 32)]'  << 1   = 0x154442bd4
- * #define CONSTANT_R1  0x154442bd4LL
- *
- * [(x4*128-32 mod P(x) << 32)]' << 1   = 0x1c6e41596
- * #define CONSTANT_R2  0x1c6e41596LL
- */
-.Lconstant_R2R1:
-	.octa 0x00000001c6e415960000000154442bd4
-/*
- * [(x128+32 mod P(x) << 32)]'   << 1   = 0x1751997d0
- * #define CONSTANT_R3  0x1751997d0LL
- *
- * [(x128-32 mod P(x) << 32)]'   << 1   = 0x0ccaa009e
- * #define CONSTANT_R4  0x0ccaa009eLL
- */
-.Lconstant_R4R3:
-	.octa 0x00000000ccaa009e00000001751997d0
-/*
- * [(x64 mod P(x) << 32)]'       << 1   = 0x163cd6124
- * #define CONSTANT_R5  0x163cd6124LL
- */
-.Lconstant_R5:
-	.octa 0x00000000000000000000000163cd6124
-.Lconstant_mask32:
-	.octa 0x000000000000000000000000FFFFFFFF
-/*
- * #define CRCPOLY_TRUE_LE_FULL 0x1DB710641LL
- *
- * Barrett Reduction constant (u64`) = u` = (x**64 / P(x))` = 0x1F7011641LL
- * #define CONSTANT_RU  0x1F7011641LL
- */
-.Lconstant_RUpoly:
-	.octa 0x00000001F701164100000001DB710641
-
-#define CONSTANT %xmm0
-
-#ifdef __x86_64__
-#define CRC     %edi
-#define BUF     %rsi
-#define LEN     %rdx
-#else
-#define CRC     %eax
-#define BUF     %edx
-#define LEN     %ecx
-#endif
-
-
-
-.text
-/**
- *      Calculate crc32
- *      CRC - initial crc32
- *      BUF - buffer (16 bytes aligned)
- *      LEN - sizeof buffer (16 bytes aligned), LEN should be greater than 63
- *      return %eax crc32
- *      u32 crc32_pclmul_le_16(u32 crc, const u8 *buffer, size_t len);
- */
-
-SYM_FUNC_START(crc32_pclmul_le_16) /* buffer and buffer size are 16 bytes aligned */
-	movdqa  (BUF), %xmm1
-	movdqa  0x10(BUF), %xmm2
-	movdqa  0x20(BUF), %xmm3
-	movdqa  0x30(BUF), %xmm4
-	movd    CRC, CONSTANT
-	pxor    CONSTANT, %xmm1
-	sub     $0x40, LEN
-	add     $0x40, BUF
-	cmp     $0x40, LEN
-	jb      .Lless_64
-
-#ifdef __x86_64__
-	movdqa .Lconstant_R2R1(%rip), CONSTANT
-#else
-	movdqa .Lconstant_R2R1, CONSTANT
-#endif
-
-.Lloop_64:/*  64 bytes Full cache line folding */
-	prefetchnta    0x40(BUF)
-	movdqa  %xmm1, %xmm5
-	movdqa  %xmm2, %xmm6
-	movdqa  %xmm3, %xmm7
-#ifdef __x86_64__
-	movdqa  %xmm4, %xmm8
-#endif
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pclmulqdq $0x00, CONSTANT, %xmm2
-	pclmulqdq $0x00, CONSTANT, %xmm3
-#ifdef __x86_64__
-	pclmulqdq $0x00, CONSTANT, %xmm4
-#endif
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pclmulqdq $0x11, CONSTANT, %xmm6
-	pclmulqdq $0x11, CONSTANT, %xmm7
-#ifdef __x86_64__
-	pclmulqdq $0x11, CONSTANT, %xmm8
-#endif
-	pxor    %xmm5, %xmm1
-	pxor    %xmm6, %xmm2
-	pxor    %xmm7, %xmm3
-#ifdef __x86_64__
-	pxor    %xmm8, %xmm4
-#else
-	/* xmm8 unsupported for x32 */
-	movdqa  %xmm4, %xmm5
-	pclmulqdq $0x00, CONSTANT, %xmm4
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pxor    %xmm5, %xmm4
-#endif
-
-	pxor    (BUF), %xmm1
-	pxor    0x10(BUF), %xmm2
-	pxor    0x20(BUF), %xmm3
-	pxor    0x30(BUF), %xmm4
-
-	sub     $0x40, LEN
-	add     $0x40, BUF
-	cmp     $0x40, LEN
-	jge     .Lloop_64
-.Lless_64:/*  Folding cache line into 128bit */
-#ifdef __x86_64__
-	movdqa  .Lconstant_R4R3(%rip), CONSTANT
-#else
-	movdqa  .Lconstant_R4R3, CONSTANT
-#endif
-	prefetchnta     (BUF)
-
-	movdqa  %xmm1, %xmm5
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pxor    %xmm5, %xmm1
-	pxor    %xmm2, %xmm1
-
-	movdqa  %xmm1, %xmm5
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pxor    %xmm5, %xmm1
-	pxor    %xmm3, %xmm1
-
-	movdqa  %xmm1, %xmm5
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pxor    %xmm5, %xmm1
-	pxor    %xmm4, %xmm1
-
-	cmp     $0x10, LEN
-	jb      .Lfold_64
-.Lloop_16:/* Folding rest buffer into 128bit */
-	movdqa  %xmm1, %xmm5
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pxor    %xmm5, %xmm1
-	pxor    (BUF), %xmm1
-	sub     $0x10, LEN
-	add     $0x10, BUF
-	cmp     $0x10, LEN
-	jge     .Lloop_16
-
-.Lfold_64:
-	/* perform the last 64 bit fold, also adds 32 zeroes
-	 * to the input stream */
-	pclmulqdq $0x01, %xmm1, CONSTANT /* R4 * xmm1.low */
-	psrldq  $0x08, %xmm1
-	pxor    CONSTANT, %xmm1
-
-	/* final 32-bit fold */
-	movdqa  %xmm1, %xmm2
-#ifdef __x86_64__
-	movdqa  .Lconstant_R5(%rip), CONSTANT
-	movdqa  .Lconstant_mask32(%rip), %xmm3
-#else
-	movdqa  .Lconstant_R5, CONSTANT
-	movdqa  .Lconstant_mask32, %xmm3
-#endif
-	psrldq  $0x04, %xmm2
-	pand    %xmm3, %xmm1
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pxor    %xmm2, %xmm1
-
-	/* Finish up with the bit-reversed barrett reduction 64 ==> 32 bits */
-#ifdef __x86_64__
-	movdqa  .Lconstant_RUpoly(%rip), CONSTANT
-#else
-	movdqa  .Lconstant_RUpoly, CONSTANT
-#endif
-	movdqa  %xmm1, %xmm2
-	pand    %xmm3, %xmm1
-	pclmulqdq $0x10, CONSTANT, %xmm1
-	pand    %xmm3, %xmm1
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pxor    %xmm2, %xmm1
-	pextrd  $0x01, %xmm1, %eax
-
-	RET
-SYM_FUNC_END(crc32_pclmul_le_16)
+DEFINE_CRC_PCLMUL_FUNCS(crc32_lsb, /* bits= */ 32, /* lsb= */ 1)
-- 
2.47.0


