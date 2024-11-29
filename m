Return-Path: <linux-kernel+bounces-420436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328949D7AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 05:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824ABB219E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 04:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC5A16FF37;
	Mon, 25 Nov 2024 04:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQckXhSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DE84039;
	Mon, 25 Nov 2024 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732507969; cv=none; b=ii60eINSlIWEF4V86lxRHDw2cRPXlFkj74CN4iW5u437WpiFTH9dfpv19JpJqlit2CHIY+gRKX8+NQnztDc6vBLPkitfC4HKHZQctZKBCvFQjru7juCPlzwh04I+s3d2xIBHdnN81ScbjP03Jgv7JG0gTu4kDPBvaEuPAIHBRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732507969; c=relaxed/simple;
	bh=vii0NZz5qfQ4U8lwiyzo1Zr5LJ0YQJ4B8xXF3umdvvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zx9T6UCsEl4OBYHh7ObQIYKgu5CrWVWw/hntYLBrFVaC0MS9mS+QqxnjKaESLXBMzacncwD2wioZfEP3EWPYlFqXtkl+mPEm7pJyZt2qW+lMYuc+AXQUHOxjAlKRufbx2QeXxPyvLrEYauNc2sSHClIdQMzklOWmeEshvxLYLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQckXhSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EC8C4CED3;
	Mon, 25 Nov 2024 04:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732507969;
	bh=vii0NZz5qfQ4U8lwiyzo1Zr5LJ0YQJ4B8xXF3umdvvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQckXhSjdUmiMEv2QqbMwQZvEhZfHrv4ZUVmAEThoGnzdWbqgj6CvZOiFl5bgf4Qb
	 VNqERf+enf+cXYXguXBhdrhb0gRMh+iZtPaotWEFOUn1KmlqT+SqcTs9EDjCv9CegR
	 HnpULlMES2DNHlHArWf505FP+cAAfyXuKqpm77BOhr29WchqAEPhPl2bUpT0yE7PoL
	 YkWAR7WOx2irkZYBiILoGLBJZqBrEbwPp/q1OeVqaSZ+VgOFgFBwtttLHiP+A22wD1
	 TqGVnsNog4Z/1XrNCXFt06rrIioPn6AH/tZyWcOWdeaNkR4pbhVPt0KcD1lxndJX1X
	 CTbDUdGHrYY8w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 3/6] x86/crc: add "template" for [V]PCLMULQDQ based CRC functions
Date: Sun, 24 Nov 2024 20:11:26 -0800
Message-ID: <20241125041129.192999-4-ebiggers@kernel.org>
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

The Linux kernel implements many variants of CRC, such as crc16,
crct10dif, crc32_le, crc32c, crc32_be, crc64_rocksoft, and crc64_be.  On
x86, except for crc32c which has special x86 scalar instructions, the
fastest way to compute any of these CRCs is to use the SIMD carryless
multiplication instructions PCLMULQDQ or VPCLMULQDQ.  Depending on the
available CPU features this can mean PCLMULQDQ+SSE4.1, VPCLMULQDQ+AVX2,
VPCLMULQDQ+AVX10/256, or VPCLMULQDQ+AVX10/512 (or the AVX512 equivalents
to AVX10/*).  This results in a total of 20+ CRC implementations being
potentially needed to properly optimize all CRCs that someone cares
about for x86.  Besides crc32c, currently only crc32_le and crct10dif
are actually optimized for x86, and they only use PCLMULQDQ, which means
they can be 2-4x slower than what is possible with VPCLMULQDQ.

Fortunately, at a high level the code that is needed for any
[V]PCLMULQDQ based CRC implementation is mostly the same.  Therefore,
this patch introduces an assembly macro that expands into the body of a
[V]PCLMULQDQ based CRC function for a given number of bits (8, 16, 32,
or 64), bit order (LSB or MSB-first), vector length, and AVX level.

The function expects to be passed a constants table, specific to the
polynomial desired, that was generated by the script previously added.
When two CRC variants share the same number of bits and bit order, the
same functions can be reused, with only the constants table differing.

A new C header crc-pclmul-template-glue.h is also added to make it easy
to integrate the new assembly code using a static call.

The result is that it becomes straightforward to wire up a fully
optimized implementation of any CRC-8, CRC-16, CRC-32, or CRC-64 for x86
(except for crc32c, which usually does a bit better with its specialized
instructions).  Later patches will wire up specific CRC variants.

Although this new template allows easily generating many functions, care
was taken to still keep the binary size fairly low.  Each generated
function is only ~520 bytes for LSB CRCs or ~660 bytes for MSB CRCs.

Note that a similar approach should also work for other architectures
that have carryless multiplication instructions, such as arm64.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/lib/crc-pclmul-template-glue.h |  84 ++++
 arch/x86/lib/crc-pclmul-template.S      | 588 ++++++++++++++++++++++++
 2 files changed, 672 insertions(+)
 create mode 100644 arch/x86/lib/crc-pclmul-template-glue.h
 create mode 100644 arch/x86/lib/crc-pclmul-template.S

diff --git a/arch/x86/lib/crc-pclmul-template-glue.h b/arch/x86/lib/crc-pclmul-template-glue.h
new file mode 100644
index 0000000000000..7a8f9175dcc54
--- /dev/null
+++ b/arch/x86/lib/crc-pclmul-template-glue.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Macros for accessing the [V]PCLMULQDQ-based CRC functions that are
+ * instantiated by crc-pclmul-template.S
+ *
+ * Copyright 2024 Google LLC
+ *
+ * Author: Eric Biggers <ebiggers@google.com>
+ */
+#ifndef _CRC_PCLMUL_TEMPLATE_GLUE_H
+#define _CRC_PCLMUL_TEMPLATE_GLUE_H
+
+#include <asm/cpufeatures.h>
+#include <crypto/internal/simd.h>
+#include <linux/static_call.h>
+
+#define DECLARE_CRC_PCLMUL_FUNCS(prefix, crc_t)				\
+crc_t prefix##_pclmul_sse(crc_t crc, const u8 *p, size_t len,		\
+			  const void *consts_ptr);			\
+crc_t prefix##_vpclmul_avx2(crc_t crc, const u8 *p, size_t len,		\
+			    const void *consts_ptr);			\
+crc_t prefix##_vpclmul_avx10_256(crc_t crc, const u8 *p, size_t len,	\
+				 const void *consts_ptr);		\
+crc_t prefix##_vpclmul_avx10_512(crc_t crc, const u8 *p, size_t len,	\
+				 const void *consts_ptr);		\
+									\
+DEFINE_STATIC_CALL(prefix##_pclmul, prefix##_pclmul_sse)
+
+#define INIT_CRC_PCLMUL(prefix)						\
+do {									\
+	if (IS_ENABLED(CONFIG_AS_VPCLMULQDQ) &&				\
+	    boot_cpu_has(X86_FEATURE_VPCLMULQDQ) &&			\
+	    boot_cpu_has(X86_FEATURE_AVX2) &&				\
+	    cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL)) {		\
+		if (boot_cpu_has(X86_FEATURE_AVX512BW) &&		\
+		    boot_cpu_has(X86_FEATURE_AVX512VL) &&		\
+		    cpu_has_xfeatures(XFEATURE_MASK_AVX512, NULL)) {	\
+			if (boot_cpu_has(X86_FEATURE_PREFER_YMM))	\
+				static_call_update(prefix##_pclmul,	\
+						   prefix##_vpclmul_avx10_256); \
+			else						\
+				static_call_update(prefix##_pclmul,	\
+						   prefix##_vpclmul_avx10_512); \
+		} else {						\
+			static_call_update(prefix##_pclmul,		\
+					   prefix##_vpclmul_avx2);	\
+		}							\
+	}								\
+} while (0)
+
+/*
+ * Call a [V]PCLMULQDQ optimized CRC function if SIMD is usable and the CPU has
+ * PCLMULQDQ support, and the length is not very small.
+ *
+ * The SIMD functions require len >= 16.  However, if the fallback
+ * implementation uses slice-by-8 instead of slice-by-1 (which makes it much
+ * faster, assuming the larger tables stay in dcache...), then roughly len >= 64
+ * is needed for the overhead of the kernel_fpu_{begin,end}() to be worth it.
+ *
+ * (64 is just a rough estimate.  The exact breakeven point varies by factors
+ * such as the CPU model; how many FPU sections are executed before returning to
+ * userspace, considering that only one XSAVE + XRSTOR pair is executed no
+ * matter how many FPU sections there are; whether the userspace thread used ymm
+ * or zmm registers which makes the XSAVE + XRSTOR more expensive; and whether
+ * the thread is a kernel thread, which never needs the XSAVE + XRSTOR.)
+ */
+#define CRC_PCLMUL(crc, p, len, prefix, consts,				\
+		   have_pclmulqdq, is_fallback_sliced)			\
+do {									\
+	if ((len) >= ((is_fallback_sliced) ? 64 : 16) &&		\
+	    static_branch_likely(&(have_pclmulqdq)) &&			\
+	    crypto_simd_usable()) {					\
+		const void *consts_ptr;					\
+									\
+		consts_ptr = (consts).fold_across_128_bits_consts;	\
+		kernel_fpu_begin();					\
+		crc = static_call(prefix##_pclmul)((crc), (p), (len),	\
+						   consts_ptr);		\
+		kernel_fpu_end();					\
+		return crc;						\
+	}								\
+} while (0)
+
+#endif /* _CRC_PCLMUL_TEMPLATE_GLUE_H */
diff --git a/arch/x86/lib/crc-pclmul-template.S b/arch/x86/lib/crc-pclmul-template.S
new file mode 100644
index 0000000000000..54c6b74b7729b
--- /dev/null
+++ b/arch/x86/lib/crc-pclmul-template.S
@@ -0,0 +1,588 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+//
+// Template to generate [V]PCLMULQDQ-based CRC functions for x86
+//
+// Copyright 2024 Google LLC
+//
+// Author: Eric Biggers <ebiggers@google.com>
+
+#include <linux/linkage.h>
+
+// Offsets within the generated constants table
+.set OFFSETOF_BSWAP_MASK,			-5*16	// only used for MSB CRC
+.set OFFSETOF_FOLD_ACROSS_2048BIT_CONSTS,	-4*16	// must precede next
+.set OFFSETOF_FOLD_ACROSS_1024BIT_CONSTS,	-3*16	// must precede next
+.set OFFSETOF_FOLD_ACROSS_512BIT_CONSTS,	-2*16	// must precede next
+.set OFFSETOF_FOLD_ACROSS_256BIT_CONSTS,	-1*16	// must precede next
+.set OFFSETOF_FOLD_ACROSS_128BIT_CONSTS,	0*16	// must be 0 offset
+.set OFFSETOF_SHUF_TABLE,			1*16
+.set OFFSETOF_BARRETT_REDUCTION_CONSTS,		4*16
+.set OFFSETOF_EXTRACT_CRC_MASK,			5*16	// only used for LSB CRC
+
+// Emit a VEX (or EVEX) coded instruction if allowed, or emulate it using the
+// corresponding non-VEX instruction plus any needed moves.  \insn gives the
+// instruction without a "v" prefix and including any immediate argument, and
+// \arg1-\arg3 give up to three non-immediate arguments as expected by the
+// VEX-coded form of the instruction.  If \arg1 is an unaligned mem operand,
+// \unaligned_mem_tmp must be specified as a temporary register.  If \arg3 is
+// given and \arg2 != \arg3, then it is required that \arg1 != \arg3.
+.macro	_cond_vex	insn:req, arg1:req, arg2:req, arg3, unaligned_mem_tmp
+.if AVX_LEVEL == 0
+  // VEX not allowed.  Emulate it.
+  .ifnb \arg3 // Three arguments
+    .ifc "\arg2", "\arg3" // arg2 == arg3?
+      .ifnb \unaligned_mem_tmp
+	movdqu		\arg1, \unaligned_mem_tmp
+	\insn		\unaligned_mem_tmp, \arg3
+      .else
+	\insn		\arg1, \arg3
+      .endif
+    .else // arg2 != arg3
+      .ifc "\arg1", "\arg3"
+	.error "Can't have arg1 == arg3 when arg2 != arg3"
+      .endif
+      .ifnb \unaligned_mem_tmp
+	movdqu		\arg1, \unaligned_mem_tmp
+	movdqa		\arg2, \arg3
+	\insn		\unaligned_mem_tmp, \arg3
+      .else
+	movdqa		\arg2, \arg3
+	\insn		\arg1, \arg3
+      .endif
+    .endif
+  .else // Only two arguments
+    .ifnb \unaligned_mem_tmp
+	movdqu		\arg1, \unaligned_mem_tmp
+	\insn		\unaligned_mem_tmp, \arg2
+    .else
+	\insn		\arg1, \arg2
+    .endif
+  .endif
+.else
+  // VEX is allowed.  Emit the desired instruction directly.
+  .ifnb \arg3
+	v\insn		\arg1, \arg2, \arg3
+  .else
+	v\insn		\arg1, \arg2
+  .endif
+.endif
+.endm
+
+// Broadcast an aligned 128-bit mem operand to all 128-bit lanes of a vector
+// register of length VL.
+.macro	_vbroadcast	src, dst
+.if VL == 16
+	_cond_vex movdqa,	\src, \dst
+.elseif VL == 32
+	vbroadcasti128		\src, \dst
+.else
+	vbroadcasti32x4		\src, \dst
+.endif
+.endm
+
+// Load bytes from the unaligned mem operand \src into \dst, and if the CRC is
+// MSB-first use \bswap_mask to reflect the bytes within each 128-bit lane.
+.macro	_load_data	src, bswap_mask, dst
+.if VL < 64
+	_cond_vex movdqu,	"\src", \dst
+.else
+	vmovdqu8		\src, \dst
+.endif
+.if !LSB_CRC
+	_cond_vex pshufb,	\bswap_mask, \dst, \dst
+.endif
+.endm
+
+// Fold \acc into \data and store the result back into \acc.  \data can be an
+// unaligned mem operand if using VEX is allowed and the CRC is LSB-first so no
+// byte-reflection is needed; otherwise it must be a vector register.  \consts
+// is a vector register containing the needed fold constants, and \tmp is a
+// temporary vector register.  All arguments must be the same length.
+.macro	_fold_vec	acc, data, consts, tmp
+	_cond_vex "pclmulqdq $0x00,",	\consts, \acc, \tmp
+	_cond_vex "pclmulqdq $0x11,",	\consts, \acc, \acc
+.if AVX_LEVEL < 10
+	_cond_vex pxor,	\data, \tmp, \tmp
+	_cond_vex pxor,	\tmp, \acc, \acc
+.else
+	vpternlogq	$0x96, \data, \tmp, \acc
+.endif
+.endm
+
+// Fold \acc into \data and store the result back into \acc.  \data is an
+// unaligned mem operand, \consts is a vector register containing the needed
+// fold constants, \bswap_mask is a vector register containing the
+// byte-reflection table if the CRC is MSB-first and \tmp1 and \tmp2 are
+// temporary vector registers.  All arguments must be the same length.
+.macro	_fold_vec_mem	acc, data, consts, bswap_mask, tmp1, tmp2
+.if AVX_LEVEL == 0 || !LSB_CRC
+	_load_data	\data, \bswap_mask, \tmp1
+	_fold_vec	\acc, \tmp1, \consts, \tmp2
+.else
+	_fold_vec	\acc, \data, \consts, \tmp1
+.endif
+.endm
+
+// Load the constants for folding across 2**i vectors of length VL at a time
+// into all 128-bit lanes of the vector register CONSTS.
+.macro	_load_vec_folding_consts	i
+	_vbroadcast OFFSETOF_FOLD_ACROSS_128BIT_CONSTS+(4-LOG2_VL-\i)*16(CONSTS_PTR), \
+		    CONSTS
+.endm
+
+// Given vector registers \v0 and \v1 of length \vl, fold \v0 into \v1 and store
+// the result back into \v0.  If the remaining length mod \vl is nonzero, also
+// fold \vl bytes from (BUF).  For both operations the fold distance is \vl.
+// \consts must be a register of length \vl containing the fold constants.
+.macro	_fold_vec_final	vl, v0, v1, consts, bswap_mask, tmp1, tmp2
+	_fold_vec	\v0, \v1, \consts, \tmp1
+	test		$\vl, LEN8
+	jz		.Lfold_vec_final_done\@
+	_fold_vec_mem	\v0, (BUF), \consts, \bswap_mask, \tmp1, \tmp2
+	add		$\vl, BUF
+.Lfold_vec_final_done\@:
+.endm
+
+// This macro generates the body of a CRC function with the following prototype:
+//
+// crc_t crc_func(crc_t crc, const u8 *buf, size_t len, const void *consts);
+//
+// |crc| is the initial CRC.  |buf| is the data to checksum.  |len| is the data
+// length in bytes, which must be at least \vl if \vl is 16 or 32, or at least
+// 4*\vl if \vl is 64.  |consts| is a pointer to the fold_across_128_bits_consts
+// field of the constants table that was generated for the chosen CRC variant.
+// crc_t is the smallest unsigned integer data type that can hold a CRC of
+// length \crc_bits, e.g. u32 for a CRC-32.
+//
+// Moving onto the macro parameters, \crc_bits is the number of bits in the CRC,
+// e.g. 32 for a CRC-32.  Currently the supported values are 8, 16, 32, and 64.
+// If the file is compiled in i386 mode, values above 32 are unsupported.
+//
+// \lsb_crc is 1 if the CRC processes the least significant bit of each byte
+// first, i.e. maps bit0 to x^7, bit1 to x^6, ..., bit7 to x^0.  \lsb_crc is 0
+// if the CRC processes the most significant bit of each byte first, i.e. maps
+// bit0 to x^0, bit1 to x^1, bit7 to x^7.
+//
+// \vl is the maximum length of vector register to use in bytes: 16, 32, or 64.
+//
+// \avx_level is the level of AVX support to use: 0 for SSE only, 2 for AVX2, or
+// 10 for AVX10 or AVX512.
+//
+// If \vl == 16 && \avx_level == 0, the generated code requires:
+// PCLMULQDQ && SSE4.1.  (Note: all known CPUs with PCLMULQDQ also have SSE4.1.)
+//
+// If \vl == 32 && \avx_level == 2, the generated code requires:
+// VPCLMULQDQ && AVX2.
+//
+// If \vl == 32 && \avx_level == 10, the generated code requires:
+// VPCLMULQDQ && (AVX10/256 || (AVX512BW && AVX512VL))
+//
+// If \vl == 64 && \avx_level == 10, the generated code requires:
+// VPCLMULQDQ && (AVX10/512 || (AVX512BW && AVX512VL))
+//
+// Other \vl and \avx_level combinations are either not supported or not useful.
+.macro	_crc_pclmul	crc_bits, lsb_crc, vl, avx_level
+	.set	LSB_CRC,	\lsb_crc
+	.set	VL,		\vl
+	.set	AVX_LEVEL,	\avx_level
+
+	// Define aliases for the xmm, ymm, or zmm registers according to VL.
+.irp i, 0,1,2,3,4,5,6,7
+  .if VL == 16
+	.set	V\i,		%xmm\i
+	.set	LOG2_VL,	4
+  .elseif VL == 32
+	.set	V\i,		%ymm\i
+	.set	LOG2_VL,	5
+  .elseif VL == 64
+	.set	V\i,		%zmm\i
+	.set	LOG2_VL,	6
+  .else
+	.error "Unsupported vector length"
+  .endif
+.endr
+	// Define aliases for the function parameters.
+#ifdef __x86_64__
+	.set	CRC64,		%rdi
+	.set	CRC32,		%edi
+	.set	CRC16,		%di
+	.set	CRC8,		%dil
+	.set	BUF,		%rsi
+	.set	LEN,		%rdx
+	.set	LEN32,		%edx
+	.set	LEN8,		%dl
+	.set	CONSTS_PTR,	%rcx
+#else
+	// 32-bit support, assuming -mregparm=3 and not including support for
+	// CRC-64 (which would use both eax and edx to pass the crc parameter).
+	.set	CRC32,		%eax
+	.set	CRC16,		%ax
+	.set	CRC8,		%al
+	.set	BUF,		%edx
+	.set	LEN,		%ecx
+	.set	LEN32,		%ecx
+	.set	LEN8,		%cl
+	.set	CONSTS_PTR,	%ebx	// Passed on stack
+#endif
+
+	// Define aliases for some local variables.  V0-V5 are used without
+	// aliases (for accumulators, data, temporary values, etc).  Staying
+	// within the first 8 vector registers keeps the code 32-bit SSE
+	// compatible and reduces the size of 64-bit SSE code slightly.
+	.set	BSWAP_MASK,	V6
+	.set	BSWAP_MASK_YMM,	%ymm6
+	.set	BSWAP_MASK_XMM,	%xmm6
+	.set	CONSTS,		V7
+	.set	CONSTS_YMM,	%ymm7
+	.set	CONSTS_XMM,	%xmm7
+
+#ifdef __i386__
+	push		CONSTS_PTR
+	mov		8(%esp), CONSTS_PTR
+#endif
+
+	// Zero-extend the initial CRC if it is shorter than 32 bits.
+.if \crc_bits <= 8
+	movzbl		CRC8, CRC32
+.elseif \crc_bits <= 16
+	movzwl		CRC16, CRC32
+.endif
+
+	// Load the first vector of data and XOR the initial CRC into the end of
+	// it that represents the high-order polynomial coefficients.
+.if LSB_CRC
+  .if \crc_bits <= 32
+	_cond_vex movd,	CRC32, %xmm0
+  .else
+	_cond_vex movq,	CRC64, %xmm0
+  .endif
+  .if VL < 64
+	_cond_vex pxor,	0*VL(BUF), V0, V0, unaligned_mem_tmp=V1
+  .else
+	vpxord		0*VL(BUF), V0, V0
+  .endif
+.else
+	_vbroadcast	OFFSETOF_BSWAP_MASK(CONSTS_PTR), BSWAP_MASK
+	_load_data	0*VL(BUF), BSWAP_MASK, V0
+	_cond_vex pxor,	%xmm1, %xmm1, %xmm1
+  .if \crc_bits == 8
+	_cond_vex "pinsrb $15,", CRC32, %xmm1, %xmm1
+  .elseif \crc_bits == 16
+	_cond_vex "pinsrw $7,", CRC32, %xmm1, %xmm1
+  .elseif \crc_bits == 32
+	_cond_vex "pinsrd $3,", CRC32, %xmm1, %xmm1
+  .elseif \crc_bits == 64
+	_cond_vex "pinsrq $1,", CRC64, %xmm1, %xmm1
+  .else
+	.error "Unsupported crc_bits: \crc_bits"
+  .endif
+  .if VL < 64
+	_cond_vex pxor,	V1, V0, V0
+  .else
+	vpxord		V1, V0, V0
+  .endif
+.endif
+
+	// Handle VL <= LEN < 4*VL, unless VL=64 in which case the function is
+	// only called for LEN >= 4*VL.
+.if VL != 64
+	cmp		$4*VL-1, LEN
+	ja		.Lfold_4vecs_prepare\@
+
+	add		$VL, BUF
+	cmp		$2*VL-1, LEN32
+	jbe		.Lless_than_2vecs\@
+	_load_data	(BUF), BSWAP_MASK, V1
+	add		$VL, BUF
+	jmp		.Lreduce_2vecs_to_1\@
+.Lless_than_2vecs\@:
+.if VL == 16
+	_cond_vex movdqa, OFFSETOF_FOLD_ACROSS_128BIT_CONSTS(CONSTS_PTR), CONSTS_XMM
+.endif // Else, the reduction from ymm to xmm will load it.
+	jmp		.Lreduce_1vec_to_128bits\@
+.endif
+
+.Lfold_4vecs_prepare\@:
+	// Load 3 more vectors of data.
+	_load_data	1*VL(BUF), BSWAP_MASK, V1
+	_load_data	2*VL(BUF), BSWAP_MASK, V2
+	_load_data	3*VL(BUF), BSWAP_MASK, V3
+	sub		$-4*VL, BUF	// Shorter than 'add 4*VL' when VL=32
+	add		$-4*VL, LEN	// Shorter than 'sub 4*VL' when VL=32
+
+	// While >= 4 vectors of data remain, fold the 4 vectors V0-V3 into the
+	// next 4 vectors of data and write the result back to V0-V3.
+	cmp		$4*VL-1, LEN	// Shorter than 'cmp 4*VL' when VL=32
+	jbe		.Lreduce_4vecs_to_2\@
+	_load_vec_folding_consts	2
+.Lfold_4vecs_loop\@:
+	_fold_vec_mem	V0, 0*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	_fold_vec_mem	V1, 1*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	_fold_vec_mem	V2, 2*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	_fold_vec_mem	V3, 3*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	sub		$-4*VL, BUF
+	add		$-4*VL, LEN
+	cmp		$4*VL-1, LEN
+	ja		.Lfold_4vecs_loop\@
+
+	// Fold V0,V1 into V2,V3 and write the result back to V0,V1.
+	// Then fold two vectors of data, if at least that much remains.
+.Lreduce_4vecs_to_2\@:
+	_load_vec_folding_consts	1
+	_fold_vec	V0, V2, CONSTS, V4
+	_fold_vec	V1, V3, CONSTS, V4
+	test		$2*VL, LEN8
+	jz		.Lreduce_2vecs_to_1\@
+	_fold_vec_mem	V0, 0*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	_fold_vec_mem	V1, 1*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	sub		$-2*VL, BUF
+
+	// Fold V0 into V1 and write the result back to V0.
+	// Then fold one vector of data, if at least that much remains.
+.Lreduce_2vecs_to_1\@:
+	_load_vec_folding_consts	0
+	_fold_vec_final	VL, V0, V1, CONSTS, BSWAP_MASK, V4, V5
+
+.Lreduce_1vec_to_128bits\@:
+	// Reduce V0 to 128 bits xmm0.
+.if VL == 64
+	// zmm0 => ymm0
+	vbroadcasti128	OFFSETOF_FOLD_ACROSS_256BIT_CONSTS(CONSTS_PTR), CONSTS_YMM
+	vextracti64x4	$1, %zmm0, %ymm1
+	_fold_vec_final	32, %ymm0, %ymm1, CONSTS_YMM, BSWAP_MASK_YMM, %ymm4, %ymm5
+.endif
+.if VL >= 32
+	// ymm0 => xmm0
+	vmovdqa		OFFSETOF_FOLD_ACROSS_128BIT_CONSTS(CONSTS_PTR), CONSTS_XMM
+	vextracti128	$1, %ymm0, %xmm1
+	_fold_vec_final	16, %xmm0, %xmm1, CONSTS_XMM, BSWAP_MASK_XMM, %xmm4, %xmm5
+.endif
+
+	and		$15, LEN32
+	jz		.Lpartial_block_done\@
+
+	// 1 <= LEN <= 15 data bytes remain.  The polynomial is now
+	// A*(x^(8*LEN)) + B, where A = xmm0 and B is the polynomial of the
+	// remaining LEN bytes.  To reduce this to 128 bits without needing fold
+	// constants for each possible LEN, rearrange this expression into
+	// C1*(x^128) + C2, where C1 = floor(A / x^(128 - 8*LEN)) and
+	// C2 = A*x^(8*LEN) + B mod x^128.  Then fold C1 into C2, which is just
+	// another fold across 128 bits.
+
+	// Load the last 16 data bytes.
+.if LSB_CRC
+	_load_data	"-16(BUF,LEN)", BSWAP_MASK_XMM, %xmm2
+.else
+	_load_data	"-16(BUF,LEN)", BSWAP_MASK_XMM, %xmm1
+.endif
+
+	// tmp = A*x^(8*LEN) mod x^128
+.if LSB_CRC
+	// pshufb by [LEN, LEN+1, ..., 15, -1, -1, ..., -1];
+	// i.e. right-shift by LEN bytes
+	_cond_vex movdqu,	"OFFSETOF_SHUF_TABLE+16(CONSTS_PTR,LEN)", %xmm3
+	_cond_vex pshufb,	%xmm3, %xmm0, %xmm1
+.else
+	// pshufb by [-1, -1, ..., -1, 0, 1, ..., 15-LEN];
+	// i.e. left-shift by LEN bytes
+	neg		LEN
+	_cond_vex pshufb,	"OFFSETOF_SHUF_TABLE+16(CONSTS_PTR,LEN)", \
+				%xmm0, %xmm2, unaligned_mem_tmp=%xmm4
+.endif
+
+	// C1 = floor(A / x^(128 - 8*LEN))
+.if LSB_CRC
+	// pshufb by [-1, -1, ..., -1, 0, 1, ..., LEN-1];
+	// i.e. left-shift by 16-LEN bytes
+	_cond_vex pshufb,	"OFFSETOF_SHUF_TABLE+0(CONSTS_PTR,LEN)", \
+				%xmm0, %xmm0, unaligned_mem_tmp=%xmm4
+.else
+	// pshufb by [16-LEN, 16-LEN+1, ..., 15, -1, -1, ..., -1];
+	// i.e. right-shift by 16-LEN bytes
+	_cond_vex movdqu,	"OFFSETOF_SHUF_TABLE+32(CONSTS_PTR,LEN)", \
+				%xmm3
+	_cond_vex pshufb,	%xmm3, %xmm0, %xmm0
+.endif
+
+	// C2 = tmp + B
+	// LSB CRC: blend 1=B,0=tmp by [LEN, LEN+1, ..., 15, -1, -1, ..., -1]
+	// MSB CRC: blend 1=tmp,0=B by [16-LEN, 16-LEN+1, ..., 15, -1, -1, ..., -1]
+.if AVX_LEVEL == 0
+	movdqa		%xmm0, %xmm4
+	movdqa		%xmm3, %xmm0
+	pblendvb	%xmm2, %xmm1	// uses %xmm0 as implicit operand
+	movdqa		%xmm4, %xmm0
+.else
+	vpblendvb	%xmm3, %xmm2, %xmm1, %xmm1
+.endif
+
+	// Fold C1 into C2 and store the result in xmm0.
+	_fold_vec	%xmm0, %xmm1, CONSTS_XMM, %xmm4
+
+.Lpartial_block_done\@:
+	// Generate the final n-bit CRC from the 128-bit xmm0 = A as follows:
+	//
+	//	crc = x^n * A mod G
+	//	    = x^n * (x^64*A_H + A_L) mod G
+	//	    = x^n * (x^(64-n)*(x^n*A_H mod G) + A_L) mod G
+	//
+	// I.e.:
+	//	crc := 0
+	//	crc := x^n * (x^(64-n)*crc + A_H) mod G
+	//	crc := x^n * (x^(64-n)*crc + A_L) mod G
+	//
+	// A_H and A_L denote the high and low 64 polynomial coefficients in A.
+	//
+	// Using Barrett reduction to do the 'mod G', this becomes:
+	//
+	//	crc := floor((A_H * floor(x^(m+n) / G)) / x^m) * G mod x^n
+	//	A_L := x^(64-n)*crc + A_L
+	//	crc := floor((A_L * floor(x^(m+n) / G)) / x^m) * G mod x^n
+	//
+	// 'm' must be an integer >= 63 (the max degree of A_L and A_H) for
+	// sufficient precision to be carried through the calculation.  For
+	// an LSB-first CRC we use m == 63, which results in floor(x^(m+n) / G)
+	// being 64-bit which is the most pclmulqdq can accept.  The
+	// multiplication with floor(x^(63+n) / G) then produces a 127-bit
+	// product, and the floored division by x^63 just takes the first qword.
+	// For an MSB-first CRC, we would instead need to take the high 64 bits
+	// of a 127-bit product which is inconvenient, so we use m == 64 in that
+	// case instead and handle multiplying by a 65-bit floor(x^(64+n) / G).
+
+	_cond_vex movdqa,	OFFSETOF_BARRETT_REDUCTION_CONSTS(CONSTS_PTR), \
+				CONSTS_XMM
+
+	// crc := floor((A_H * floor(x^(m+n) / G)) / x^m) * G mod x^n
+.if LSB_CRC
+	// tmp := floor((A_H * floor(x^(63+n) / G)) / x^63)
+	_cond_vex "pclmulqdq $0x00,",	CONSTS_XMM, %xmm0, %xmm1
+	// tmp is in bits [0:64) of xmm1.
+
+	// crc := tmp * G mod x^n
+  .if \crc_bits == 64
+	// Multiply by 65-bit G.
+	_cond_vex "pclmulqdq $0x10,",	CONSTS_XMM, %xmm1, %xmm2
+	_cond_vex "pshufd $0x4e,",	%xmm1, %xmm1
+	_cond_vex pxor,			%xmm2, %xmm1, %xmm1
+  .else
+	// Multiply by 64-bit or less G.
+	_cond_vex "pclmulqdq $0x10,",	CONSTS_XMM, %xmm1, %xmm1
+  .endif
+	// crc is in bits [64:64+n) of xmm1.
+
+.else
+	// tmp := floor((A_H * floor(x^(64+n) / G)) / x^64)
+	// In this case the constant multiplicand is 65-bit.
+	_cond_vex "pclmulqdq $0x01,",	CONSTS_XMM, %xmm0, %xmm1
+	_cond_vex pxor,			%xmm0, %xmm1, %xmm1
+	// tmp is in bits [64:128) of xmm1.
+
+	// crc := tmp * G mod x^n
+	_cond_vex "pclmulqdq $0x11,",	CONSTS_XMM, %xmm1, %xmm1
+	// crc is in bits [0:n) of xmm1.
+.endif
+
+	// A_L := x^(64-n)*crc + A_L
+.if LSB_CRC
+	// For LSB CRCs, crc is already aligned to add (XOR) it directly to A_L.
+	// If \crc_bits < 64, it needs to be selected using a mask.
+  .if \crc_bits == 64
+	_cond_vex pxor,	%xmm1, %xmm0, %xmm0
+  .elseif AVX_LEVEL >= 10
+	vpternlogq	$0x78, OFFSETOF_EXTRACT_CRC_MASK(CONSTS_PTR), %xmm1, %xmm0
+  .else
+	_cond_vex pand,	OFFSETOF_EXTRACT_CRC_MASK(CONSTS_PTR), %xmm1, %xmm1
+	_cond_vex pxor,	%xmm1, %xmm0, %xmm0
+  .endif
+.else
+  .if \crc_bits != 64
+	_cond_vex psllq,	$64-\crc_bits, %xmm1, %xmm1
+  .endif
+	_cond_vex pxor,		%xmm1, %xmm0, %xmm0
+.endif
+
+	// crc := floor((A_L * floor(x^(m+n) / G)) / x^m) * G mod x^n
+	//
+	// Same as previous but uses the low-order 64 coefficients of A.
+.if LSB_CRC
+	_cond_vex "pclmulqdq $0x01,",	CONSTS_XMM, %xmm0, %xmm0
+  .if \crc_bits == 64
+	_cond_vex "pclmulqdq $0x10,",	CONSTS_XMM, %xmm0, %xmm1
+	_cond_vex "pshufd $0x4e,",	%xmm0, %xmm0
+	_cond_vex pxor,			%xmm1, %xmm0, %xmm0
+  .else
+	_cond_vex "pclmulqdq $0x10,",	CONSTS_XMM, %xmm0, %xmm0
+  .endif
+.else
+	_cond_vex "pclmulqdq $0x00,",	CONSTS_XMM, %xmm0, %xmm1
+	_cond_vex "pshufd $0x4e,",	%xmm0, %xmm0
+	_cond_vex pxor,			%xmm1, %xmm0, %xmm0
+	_cond_vex "pclmulqdq $0x11,",	CONSTS_XMM, %xmm0, %xmm0
+.endif
+
+.if LSB_CRC
+	// Extract the CRC from bits [64:64+n) of xmm0.
+  .if \crc_bits == 8
+	_cond_vex "pextrb $8,", %xmm0, %eax
+  .elseif \crc_bits == 16
+	_cond_vex "pextrw $4,", %xmm0, %eax
+  .elseif \crc_bits == 32
+	_cond_vex "pextrd $2,", %xmm0, %eax
+  .elseif \crc_bits == 64
+	_cond_vex "pextrq $1,", %xmm0, %rax
+  .else
+	.error "Unsupported crc_bits: \crc_bits"
+  .endif
+.else
+	// Extract the CRC from bits [0:n) of xmm0.
+  .if \crc_bits == 8
+	_cond_vex "pextrb $0,", %xmm0, %eax
+  .elseif \crc_bits == 16
+	_cond_vex "pextrw $0,", %xmm0, %eax
+  .elseif \crc_bits == 32
+	_cond_vex movd,		%xmm0, %eax
+  .elseif \crc_bits == 64
+	_cond_vex movq,		%xmm0, %rax
+  .else
+	.error "Unsupported crc_bits: \crc_bits"
+  .endif
+.endif
+
+.if VL > 16
+	vzeroupper	// Needed when ymm or zmm registers were used.
+.endif
+#ifdef __i386__
+	pop		CONSTS_PTR
+#endif
+	RET
+.endm
+
+#ifdef CONFIG_AS_VPCLMULQDQ
+#define DEFINE_CRC_PCLMUL_FUNCS(prefix, bits, lsb)			\
+SYM_FUNC_START(prefix##_pclmul_sse);					\
+	_crc_pclmul	crc_bits=bits, lsb_crc=lsb, vl=16, avx_level=0;	\
+SYM_FUNC_END(prefix##_pclmul_sse);					\
+									\
+SYM_FUNC_START(prefix##_vpclmul_avx2);					\
+	cmp		$32, LEN;					\
+	jb		prefix##_pclmul_sse;				\
+	_crc_pclmul	crc_bits=bits, lsb_crc=lsb, vl=32, avx_level=2;	\
+SYM_FUNC_END(prefix##_vpclmul_avx2);					\
+									\
+SYM_FUNC_START(prefix##_vpclmul_avx10_256);				\
+	cmp		$32, LEN;					\
+	jb		prefix##_pclmul_sse;				\
+	_crc_pclmul	crc_bits=bits, lsb_crc=lsb, vl=32, avx_level=10;\
+SYM_FUNC_END(prefix##_vpclmul_avx10_256);				\
+									\
+SYM_FUNC_START(prefix##_vpclmul_avx10_512);				\
+	cmp		$256, LEN;					\
+	jb		prefix##_vpclmul_avx10_256;			\
+	_crc_pclmul	crc_bits=bits, lsb_crc=lsb, vl=64, avx_level=10;\
+SYM_FUNC_END(prefix##_vpclmul_avx10_512);
+#else
+#define DEFINE_CRC_PCLMUL_FUNCS(prefix, bits, lsb)			\
+SYM_FUNC_START(prefix##_pclmul_sse);					\
+	_crc_pclmul	crc_bits=bits, lsb_crc=lsb, vl=16, avx_level=0;	\
+SYM_FUNC_END(prefix##_pclmul_sse);
+#endif // !CONFIG_AS_VPCLMULQDQ
-- 
2.47.0


