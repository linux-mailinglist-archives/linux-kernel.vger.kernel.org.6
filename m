Return-Path: <linux-kernel+bounces-396365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC319BCC25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7792835AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2C91D6DBB;
	Tue,  5 Nov 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zxqv08k/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A331D63C7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807282; cv=none; b=qQHAcDgysM0gIPqRcmmdvxLBGdTtH7Chzt/JUfvn8ArAKeb9cCml7ASES7Kf8FXolMsgn24fJ3itpdBYkIituMkSq/L4i+dGGJ/fofSZJOOPx3sj4TJVWA2k2Qx/TBXYAHu2QaTmBIPcLJY5g6VRuilVRj+snnFk3JhXULke7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807282; c=relaxed/simple;
	bh=l5OQNSZecjCPQC3yi/QLK4UysmI4wmK6qgLoDcgUEeo=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lh94V6G8M8BS1/wC69APAwR4u2IRfh2+iUkPJuqxHonteZEcnuh4y9tVorlcQO/hnC/W4O4sEXNs4tgvjqMwyAl2wNjC7qB7gY5OMjunhZ11jJRZqT8T8FG7Mo3l6ccVbgtQfQNFE5S19Xt46TQr6f4NoAItjbgQeb1XhGAS+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zxqv08k/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=QmxkW+8li/jPgMrSbUYDrqGPm3fY3Hfxs6K6yJC5hIg=; b=Zxqv08k/h7pOxmBdtjAhCIwzSo
	kI0astp2xBeZEpiuJg+49VmuoCWEDEalaH+vK3YwmxD9BmX9QoyYrmXQmLQcxwDRfjtFrDC+TWpMe
	yXh/kTL5OCN6ix7usfpWsQ5CFdiOaQrP7dQ7cL3c0rKh1/uz3m8Y8CuXEnMtYSU3tt8rPyXqltURd
	GD1aRMNTRG6WnvjM5v+C+5PkJihW2arhExiNjipq9ZPwuFUNpS277iU5UV/HaXPHbNX0MrK7YggtK
	96aDGQ5wcdDFTHLSsOrdOwa75o6iZXvD9kor4PNhktx7CkKZ+FAvSMTVA3nRDAt85hToXN/alKpPc
	Yfgmgawg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8I2E-00000002iAG-17GN;
	Tue, 05 Nov 2024 11:47:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D96BA300324; Tue,  5 Nov 2024 12:47:45 +0100 (CET)
Message-Id: <20241105114521.852053765@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 05 Nov 2024 12:39:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 alexei.starovoitov@gmail.com,
 ebiggers@kernel.org,
 samitolvanen@google.com,
 kees@kernel.org
Subject: [PATCH 1/8] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
References: <20241105113901.348320374@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The expectation is that all EXPORT'ed symbols are free to have their
address taken and called indirectly. The majority of the assembly
defined functions currently violate this expectation.

Make then all use SYM_TYPED_FUNC_START() in order to emit the proper
kCFI preamble.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |    7 ++++---
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |    1 +
 arch/x86/crypto/camellia-x86_64-asm_64.S     |    9 +++++----
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S  |    7 ++++---
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S |    5 +++--
 arch/x86/crypto/twofish-x86_64-asm_64.S      |    5 +++--
 arch/x86/entry/entry.S                       |    3 ++-
 arch/x86/entry/entry_64.S                    |    5 +++--
 arch/x86/lib/clear_page_64.S                 |    9 +++++----
 arch/x86/lib/copy_page_64.S                  |    3 ++-
 arch/x86/lib/copy_user_64.S                  |    3 ++-
 arch/x86/lib/copy_user_uncached_64.S         |    3 ++-
 arch/x86/lib/getuser.S                       |   17 +++++++++--------
 arch/x86/lib/hweight.S                       |    5 +++--
 arch/x86/lib/memmove_64.S                    |    3 ++-
 arch/x86/lib/memset_64.S                     |    3 ++-
 arch/x86/lib/msr-reg.S                       |    3 ++-
 arch/x86/lib/putuser.S                       |   17 +++++++++--------
 18 files changed, 63 insertions(+), 45 deletions(-)

--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -16,6 +16,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/frame.h>
 
 #define CAMELLIA_TABLE_BYTE_LEN 272
@@ -882,7 +883,7 @@ SYM_FUNC_START_LOCAL(__camellia_dec_blk1
 	jmp .Ldec_max24;
 SYM_FUNC_END(__camellia_dec_blk16)
 
-SYM_FUNC_START(camellia_ecb_enc_16way)
+SYM_TYPED_FUNC_START(camellia_ecb_enc_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -907,7 +908,7 @@ SYM_FUNC_START(camellia_ecb_enc_16way)
 	RET;
 SYM_FUNC_END(camellia_ecb_enc_16way)
 
-SYM_FUNC_START(camellia_ecb_dec_16way)
+SYM_TYPED_FUNC_START(camellia_ecb_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -937,7 +938,7 @@ SYM_FUNC_START(camellia_ecb_dec_16way)
 	RET;
 SYM_FUNC_END(camellia_ecb_dec_16way)
 
-SYM_FUNC_START(camellia_cbc_dec_16way)
+SYM_TYPED_FUNC_START(camellia_cbc_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/frame.h>
 
 #define CAMELLIA_TABLE_BYTE_LEN 272
--- a/arch/x86/crypto/camellia-x86_64-asm_64.S
+++ b/arch/x86/crypto/camellia-x86_64-asm_64.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 
 .file "camellia-x86_64-asm_64.S"
 .text
@@ -177,7 +178,7 @@
 	bswapq				RAB0; \
 	movq RAB0,			4*2(RIO);
 
-SYM_FUNC_START(__camellia_enc_blk)
+SYM_TYPED_FUNC_START(__camellia_enc_blk)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -224,7 +225,7 @@ SYM_FUNC_START(__camellia_enc_blk)
 	RET;
 SYM_FUNC_END(__camellia_enc_blk)
 
-SYM_FUNC_START(camellia_dec_blk)
+SYM_TYPED_FUNC_START(camellia_dec_blk)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -411,7 +412,7 @@ SYM_FUNC_END(camellia_dec_blk)
 		bswapq				RAB1; \
 		movq RAB1,			12*2(RIO);
 
-SYM_FUNC_START(__camellia_enc_blk_2way)
+SYM_TYPED_FUNC_START(__camellia_enc_blk_2way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -460,7 +461,7 @@ SYM_FUNC_START(__camellia_enc_blk_2way)
 	RET;
 SYM_FUNC_END(__camellia_enc_blk_2way)
 
-SYM_FUNC_START(camellia_dec_blk_2way)
+SYM_TYPED_FUNC_START(camellia_dec_blk_2way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -9,6 +9,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/frame.h>
 #include "glue_helper-asm-avx.S"
 
@@ -656,7 +657,7 @@ SYM_FUNC_START_LOCAL(__serpent_dec_blk8_
 	RET;
 SYM_FUNC_END(__serpent_dec_blk8_avx)
 
-SYM_FUNC_START(serpent_ecb_enc_8way_avx)
+SYM_TYPED_FUNC_START(serpent_ecb_enc_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -674,7 +675,7 @@ SYM_FUNC_START(serpent_ecb_enc_8way_avx)
 	RET;
 SYM_FUNC_END(serpent_ecb_enc_8way_avx)
 
-SYM_FUNC_START(serpent_ecb_dec_8way_avx)
+SYM_TYPED_FUNC_START(serpent_ecb_dec_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -692,7 +693,7 @@ SYM_FUNC_START(serpent_ecb_dec_8way_avx)
 	RET;
 SYM_FUNC_END(serpent_ecb_dec_8way_avx)
 
-SYM_FUNC_START(serpent_cbc_dec_8way_avx)
+SYM_TYPED_FUNC_START(serpent_cbc_dec_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
--- a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 
 .file "twofish-x86_64-asm-3way.S"
 .text
@@ -220,7 +221,7 @@
 	rorq $32,			RAB2; \
 	outunpack3(mov, RIO, 2, RAB, 2);
 
-SYM_FUNC_START(__twofish_enc_blk_3way)
+SYM_TYPED_FUNC_START(__twofish_enc_blk_3way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -269,7 +270,7 @@ SYM_FUNC_START(__twofish_enc_blk_3way)
 	RET;
 SYM_FUNC_END(__twofish_enc_blk_3way)
 
-SYM_FUNC_START(twofish_dec_blk_3way)
+SYM_TYPED_FUNC_START(twofish_dec_blk_3way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
--- a/arch/x86/crypto/twofish-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64.S
@@ -8,6 +8,7 @@
 .text
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/asm-offsets.h>
 
 #define a_offset	0
@@ -202,7 +203,7 @@
 	xor	%r8d,		d ## D;\
 	ror	$1,		d ## D;
 
-SYM_FUNC_START(twofish_enc_blk)
+SYM_TYPED_FUNC_START(twofish_enc_blk)
 	pushq    R1
 
 	/* %rdi contains the ctx address */
@@ -255,7 +256,7 @@ SYM_FUNC_START(twofish_enc_blk)
 	RET
 SYM_FUNC_END(twofish_enc_blk)
 
-SYM_FUNC_START(twofish_dec_blk)
+SYM_TYPED_FUNC_START(twofish_dec_blk)
 	pushq    R1
 
 	/* %rdi contains the ctx address */
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -5,6 +5,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
 #include <asm/segment.h>
@@ -16,7 +17,7 @@
 
 .pushsection .noinstr.text, "ax"
 
-SYM_FUNC_START(entry_ibpb)
+SYM_TYPED_FUNC_START(entry_ibpb)
 	movl	$MSR_IA32_PRED_CMD, %ecx
 	movl	$PRED_CMD_IBPB, %eax
 	xorl	%edx, %edx
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -20,6 +20,7 @@
  */
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/segment.h>
 #include <asm/cache.h>
 #include <asm/errno.h>
@@ -742,7 +743,7 @@ _ASM_NOKPROBE(common_interrupt_return)
  *
  * Is in entry.text as it shouldn't be instrumented.
  */
-SYM_FUNC_START(asm_load_gs_index)
+SYM_TYPED_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
 	swapgs
 .Lgs_change:
@@ -1526,7 +1527,7 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * The alignment is for performance and not for safety, and may be safely
  * refactored in the future if needed.
  */
-SYM_FUNC_START(clear_bhb_loop)
+SYM_TYPED_FUNC_START(clear_bhb_loop)
 	push	%rbp
 	mov	%rsp, %rbp
 	movl	$5, %ecx
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/asm.h>
 
 /*
@@ -14,7 +15,7 @@
  * Zero a page.
  * %rdi	- page
  */
-SYM_FUNC_START(clear_page_rep)
+SYM_TYPED_FUNC_START(clear_page_rep)
 	movl $4096/8,%ecx
 	xorl %eax,%eax
 	rep stosq
@@ -22,7 +23,7 @@ SYM_FUNC_START(clear_page_rep)
 SYM_FUNC_END(clear_page_rep)
 EXPORT_SYMBOL_GPL(clear_page_rep)
 
-SYM_FUNC_START(clear_page_orig)
+SYM_TYPED_FUNC_START(clear_page_orig)
 	xorl   %eax,%eax
 	movl   $4096/64,%ecx
 	.p2align 4
@@ -44,7 +45,7 @@ SYM_FUNC_START(clear_page_orig)
 SYM_FUNC_END(clear_page_orig)
 EXPORT_SYMBOL_GPL(clear_page_orig)
 
-SYM_FUNC_START(clear_page_erms)
+SYM_TYPED_FUNC_START(clear_page_erms)
 	movl $4096,%ecx
 	xorl %eax,%eax
 	rep stosb
@@ -62,7 +63,7 @@ EXPORT_SYMBOL_GPL(clear_page_erms)
  * Output:
  * rcx: uncleared bytes or 0 if successful.
  */
-SYM_FUNC_START(rep_stos_alternative)
+SYM_TYPED_FUNC_START(rep_stos_alternative)
 	cmpq $64,%rcx
 	jae .Lunrolled
 
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -3,6 +3,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
@@ -13,7 +14,7 @@
  * prefetch distance based on SMP/UP.
  */
 	ALIGN
-SYM_FUNC_START(copy_page)
+SYM_TYPED_FUNC_START(copy_page)
 	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
 	movl	$4096/8, %ecx
 	rep	movsq
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -8,6 +8,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 #include <asm/asm.h>
@@ -29,7 +30,7 @@
  * just a plain 'rep movs' on machines that have FSRM.  But to make
  * it simpler for us, we can clobber rsi/rdi and rax freely.
  */
-SYM_FUNC_START(rep_movs_alternative)
+SYM_TYPED_FUNC_START(rep_movs_alternative)
 	cmpq $64,%rcx
 	jae .Llarge
 
--- a/arch/x86/lib/copy_user_uncached_64.S
+++ b/arch/x86/lib/copy_user_uncached_64.S
@@ -5,6 +5,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/asm.h>
 
 /*
@@ -26,7 +27,7 @@
  * Output:
  * rax uncopied bytes or 0 if successful.
  */
-SYM_FUNC_START(__copy_user_nocache)
+SYM_TYPED_FUNC_START(__copy_user_nocache)
 	/* If destination is not 7-byte aligned, we'll have to align it */
 	testb $7,%dil
 	jne .Lalign
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -28,6 +28,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/page_types.h>
 #include <asm/errno.h>
 #include <asm/asm-offsets.h>
@@ -62,7 +63,7 @@
 
 
 	.text
-SYM_FUNC_START(__get_user_1)
+SYM_TYPED_FUNC_START(__get_user_1)
 	check_range size=1
 	ASM_STAC
 	UACCESS movzbl (%_ASM_AX),%edx
@@ -72,7 +73,7 @@ SYM_FUNC_START(__get_user_1)
 SYM_FUNC_END(__get_user_1)
 EXPORT_SYMBOL(__get_user_1)
 
-SYM_FUNC_START(__get_user_2)
+SYM_TYPED_FUNC_START(__get_user_2)
 	check_range size=2
 	ASM_STAC
 	UACCESS movzwl (%_ASM_AX),%edx
@@ -82,7 +83,7 @@ SYM_FUNC_START(__get_user_2)
 SYM_FUNC_END(__get_user_2)
 EXPORT_SYMBOL(__get_user_2)
 
-SYM_FUNC_START(__get_user_4)
+SYM_TYPED_FUNC_START(__get_user_4)
 	check_range size=4
 	ASM_STAC
 	UACCESS movl (%_ASM_AX),%edx
@@ -92,7 +93,7 @@ SYM_FUNC_START(__get_user_4)
 SYM_FUNC_END(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
 
-SYM_FUNC_START(__get_user_8)
+SYM_TYPED_FUNC_START(__get_user_8)
 #ifndef CONFIG_X86_64
 	xor %ecx,%ecx
 #endif
@@ -111,7 +112,7 @@ SYM_FUNC_END(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
 /* .. and the same for __get_user, just without the range checks */
-SYM_FUNC_START(__get_user_nocheck_1)
+SYM_TYPED_FUNC_START(__get_user_nocheck_1)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 	UACCESS movzbl (%_ASM_AX),%edx
@@ -121,7 +122,7 @@ SYM_FUNC_START(__get_user_nocheck_1)
 SYM_FUNC_END(__get_user_nocheck_1)
 EXPORT_SYMBOL(__get_user_nocheck_1)
 
-SYM_FUNC_START(__get_user_nocheck_2)
+SYM_TYPED_FUNC_START(__get_user_nocheck_2)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 	UACCESS movzwl (%_ASM_AX),%edx
@@ -131,7 +132,7 @@ SYM_FUNC_START(__get_user_nocheck_2)
 SYM_FUNC_END(__get_user_nocheck_2)
 EXPORT_SYMBOL(__get_user_nocheck_2)
 
-SYM_FUNC_START(__get_user_nocheck_4)
+SYM_TYPED_FUNC_START(__get_user_nocheck_4)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 	UACCESS movl (%_ASM_AX),%edx
@@ -141,7 +142,7 @@ SYM_FUNC_START(__get_user_nocheck_4)
 SYM_FUNC_END(__get_user_nocheck_4)
 EXPORT_SYMBOL(__get_user_nocheck_4)
 
-SYM_FUNC_START(__get_user_nocheck_8)
+SYM_TYPED_FUNC_START(__get_user_nocheck_8)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 #ifdef CONFIG_X86_64
--- a/arch/x86/lib/hweight.S
+++ b/arch/x86/lib/hweight.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 
 #include <asm/asm.h>
 
@@ -8,7 +9,7 @@
  * unsigned int __sw_hweight32(unsigned int w)
  * %rdi: w
  */
-SYM_FUNC_START(__sw_hweight32)
+SYM_TYPED_FUNC_START(__sw_hweight32)
 
 #ifdef CONFIG_X86_64
 	movl %edi, %eax				# w
@@ -41,7 +42,7 @@ EXPORT_SYMBOL(__sw_hweight32)
  * on top of __arch_hweight32():
  */
 #ifdef CONFIG_X86_64
-SYM_FUNC_START(__sw_hweight64)
+SYM_TYPED_FUNC_START(__sw_hweight64)
 	pushq   %rdi
 	pushq   %rdx
 
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -8,6 +8,7 @@
  */
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
@@ -26,7 +27,7 @@
  * Output:
  * rax: dest
  */
-SYM_FUNC_START(__memmove)
+SYM_TYPED_FUNC_START(__memmove)
 
 	mov %rdi, %rax
 
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -3,6 +3,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
@@ -28,7 +29,7 @@
  * only for the return value that is the same as the source input,
  * which the compiler could/should do much better anyway.
  */
-SYM_FUNC_START(__memset)
+SYM_TYPED_FUNC_START(__memset)
 	ALTERNATIVE "jmp memset_orig", "", X86_FEATURE_FSRS
 
 	movq %rdi,%r9
--- a/arch/x86/lib/msr-reg.S
+++ b/arch/x86/lib/msr-reg.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
 #include <linux/errno.h>
+#include <linux/cfi_types.h>
 #include <asm/asm.h>
 #include <asm/msr.h>
 
@@ -12,7 +13,7 @@
  *
  */
 .macro op_safe_regs op
-SYM_FUNC_START(\op\()_safe_regs)
+SYM_TYPED_FUNC_START(\op\()_safe_regs)
 	pushq %rbx
 	pushq %r12
 	movq	%rdi, %r10	/* Save pointer */
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -13,6 +13,7 @@
  */
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/thread_info.h>
 #include <asm/errno.h>
 #include <asm/asm.h>
@@ -44,7 +45,7 @@
 .endm
 
 .text
-SYM_FUNC_START(__put_user_1)
+SYM_TYPED_FUNC_START(__put_user_1)
 	check_range size=1
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
@@ -54,7 +55,7 @@ SYM_FUNC_START(__put_user_1)
 SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
-SYM_FUNC_START(__put_user_nocheck_1)
+SYM_TYPED_FUNC_START(__put_user_nocheck_1)
 	ASM_STAC
 2:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -63,7 +64,7 @@ SYM_FUNC_START(__put_user_nocheck_1)
 SYM_FUNC_END(__put_user_nocheck_1)
 EXPORT_SYMBOL(__put_user_nocheck_1)
 
-SYM_FUNC_START(__put_user_2)
+SYM_TYPED_FUNC_START(__put_user_2)
 	check_range size=2
 	ASM_STAC
 3:	movw %ax,(%_ASM_CX)
@@ -73,7 +74,7 @@ SYM_FUNC_START(__put_user_2)
 SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
-SYM_FUNC_START(__put_user_nocheck_2)
+SYM_TYPED_FUNC_START(__put_user_nocheck_2)
 	ASM_STAC
 4:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -82,7 +83,7 @@ SYM_FUNC_START(__put_user_nocheck_2)
 SYM_FUNC_END(__put_user_nocheck_2)
 EXPORT_SYMBOL(__put_user_nocheck_2)
 
-SYM_FUNC_START(__put_user_4)
+SYM_TYPED_FUNC_START(__put_user_4)
 	check_range size=4
 	ASM_STAC
 5:	movl %eax,(%_ASM_CX)
@@ -92,7 +93,7 @@ SYM_FUNC_START(__put_user_4)
 SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
-SYM_FUNC_START(__put_user_nocheck_4)
+SYM_TYPED_FUNC_START(__put_user_nocheck_4)
 	ASM_STAC
 6:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -101,7 +102,7 @@ SYM_FUNC_START(__put_user_nocheck_4)
 SYM_FUNC_END(__put_user_nocheck_4)
 EXPORT_SYMBOL(__put_user_nocheck_4)
 
-SYM_FUNC_START(__put_user_8)
+SYM_TYPED_FUNC_START(__put_user_8)
 	check_range size=8
 	ASM_STAC
 7:	mov %_ASM_AX,(%_ASM_CX)
@@ -114,7 +115,7 @@ SYM_FUNC_START(__put_user_8)
 SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
-SYM_FUNC_START(__put_user_nocheck_8)
+SYM_TYPED_FUNC_START(__put_user_nocheck_8)
 	ASM_STAC
 9:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32



