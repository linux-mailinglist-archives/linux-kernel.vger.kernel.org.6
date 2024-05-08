Return-Path: <linux-kernel+bounces-172803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E938BF6FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AC01C20A01
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97372C856;
	Wed,  8 May 2024 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUzy1csM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70112837C;
	Wed,  8 May 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152942; cv=none; b=tqwpQhOspwTRX+dUfMWzViIqJMHSI6ZYoHSo6LdV8sbnPPcRYpbEZeZcjUKWR5NQQ5AioyHewc5dQWRr5ZPoWz9MmHCFZdBlHiuS4B3VzpyYTDlDPsLKLwfD96xRLq+DjmtcyrA3VESI6zE5idGCQ+CFSrw1PT5hQQQKrHjRLPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152942; c=relaxed/simple;
	bh=55Acl1bdCOkPFJmvQVRlLRnWCaYJrFKa8y39srJkJ50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0VrLZg+pdBapo2oOAN/LxEn8XMY6KeCRSTVD1cp/7qOgZ5F4canPqSIiLeUVKlO121AzyBRsL7Qwbl2YfBsdI1OKGhNY2MEvT71s7pSQYpNNtfDazJvpp+W3GWneDllRVDHJNn8wJTuQhL1yl57G46R6389Iko/bPdh9cdcvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUzy1csM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572B7C113CC;
	Wed,  8 May 2024 07:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715152941;
	bh=55Acl1bdCOkPFJmvQVRlLRnWCaYJrFKa8y39srJkJ50=;
	h=From:To:Cc:Subject:Date:From;
	b=gUzy1csMfps0rf2KwWIWU0oRQLd9HEIk91RnbbLvRfeau641KxwhaueVs2Zfb8Lkv
	 zvLdYJ0TfhM1CHIIc0suaTuesXHXxbo4ty24fGVed0fYqCi9eU1zn831GKDAYGwgS6
	 XXljr4a2A3V4HW1FHkuDjvNLXhzeOosLWbwTu+FaDXg8gf25wTlh9fao9S4GwdWrRo
	 skOBtqWSQJF7aEQlDqqPyfvkP1LscKhMzq1U+qG6BXtw59n4UiAjU0sIbnqFzyJcf2
	 nXwnqPi0AMYdg7f+Po/UD+rcVqSmObpOupR3Hc+G9Gk/yRgCHISyHYBrVbGjCkz+Xb
	 wfT1gY/OCcuJw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: x86/aes-gcm - add VAES and AVX512 / AVX10 optimized AES-GCM
Date: Wed,  8 May 2024 00:17:34 -0700
Message-ID: <20240508071734.199462-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Add implementations of AES-GCM for x86_64 CPUs that support VAES (vector
AES), VPCLMULQDQ (vector carryless multiplication), and either AVX512 or
AVX10.  There are two implementations, sharing most source code: one
using 256-bit vectors and one using 512-bit vectors.

I wrote the new AES-GCM assembly code from scratch, focusing on
performance, code size (both source and binary), and documenting the
source.  The new assembly file aes-gcm-avx10-x86_64.S is about 1200
lines including extensive comments, and it generates less than 8 KB of
binary code.  This includes both 256-bit and 512-bit vector code; note
that only one is used at runtime.  The main loop does 4 vectors at a
time, with the AES and GHASH instructions interleaved.  Any remainder is
handled using a simple 1 vector at a time loop, with masking.

Several VAES + AVX512 implementations of AES-GCM exist from Intel,
including one in OpenSSL and one proposed for inclusion in Linux in 2021
(https://lore.kernel.org/linux-crypto/1611386920-28579-6-git-send-email-megha.dey@intel.com/).
These aren't really suitable to be used, though, due to the massive
amount of binary code generated (696 KB for OpenSSL, 200 KB for Linux)
and well as the significantly larger amount of assembly source (4978
lines for OpenSSL, 1788 lines for Linux).  Also, Intel's code does not
support 256-bit vectors, which makes it not usable on future
AVX10/256-only CPUs, and also not ideal for certain Intel CPUs that have
downclocking issues.  So I ended up starting from scratch.  Often my
much shorter code is actually slightly faster than Intel's AVX512 code,
though it depends on message length and on which of Intel's
implementations is used; for details, see Table 3 and 4 later on.

To facilitate potential integration into other projects, I've
dual-licensed aes-gcm-avx10-x86_64.S under Apache-2.0 OR BSD-2-Clause,
the same as the recently added RISC-V crypto code.

Note that although much of the new assembly code is agnostic to vector
length, it wouldn't be easy to make it support CPUs that lack AVX512 or
AVX10.  This was doable for the new AES-XTS code I recently added;
however, AES-GCM relies more heavily on the full set of 32 SIMD
registers, masking, and new instructions provided by AVX512 or AVX10.

The following two tables summarize the performance improvement over the
existing AES-GCM code in Linux that uses AES-NI and AVX2:

Table 1: AES-256-GCM encryption throughput improvement,
         CPU microarchitecture vs. message length in bytes:

                      | 16384 |  4096 |  4095 |  1420 |   512 |   500 |
----------------------+-------+-------+-------+-------+-------+-------+
Intel Ice Lake        |   45% |   51% |   61% |   60% |   65% |   62% |
Intel Sapphire Rapids |  152% |  140% |  157% |  115% |   94% |   94% |
Intel Emerald Rapids  |  150% |  140% |  157% |  114% |   94% |   94% |
AMD Zen 4             |   95% |   81% |   69% |   51% |   51% |   48% |

                      |   300 |   200 |    64 |    63 |    16 |
----------------------+-------+-------+-------+-------+-------+
Intel Ice Lake        |   60% |   39% |   44% |   61% |   45% |
Intel Sapphire Rapids |   79% |   60% |   43% |   61% |   37% |
Intel Emerald Rapids  |   78% |   58% |   43% |   62% |   38% |
AMD Zen 4             |   47% |   30% |   26% |   29% |   26% |

Table 2: AES-256-GCM decryption throughput improvement,
         CPU microarchitecture vs. message length in bytes:

                      | 16384 |  4096 |  4095 |  1420 |   512 |   500 |
----------------------+-------+-------+-------+-------+-------+-------+
Intel Ice Lake        |   51% |   57% |   66% |   70% |   72% |   80% |
Intel Sapphire Rapids |  159% |  145% |  162% |  125% |  100% |  103% |
Intel Emerald Rapids  |  158% |  145% |  162% |  125% |  101% |  103% |
AMD Zen 4             |  100% |   86% |   74% |   55% |   57% |   58% |

                      |   300 |   200 |    64 |    63 |    16 |
----------------------+-------+-------+-------+-------+-------+
Intel Ice Lake        |   73% |   60% |   49% |   81% |   59% |
Intel Sapphire Rapids |   82% |   65% |   42% |   66% |   47% |
Intel Emerald Rapids  |   80% |   64% |   43% |   63% |   45% |
AMD Zen 4             |   52% |   40% |   31% |   39% |   29% |

The above numbers are percentage improvements in single-thread
throughput, so e.g. an increase from 4000 MB/s to 6000 MB/s would be
listed as 50%.  They were collected by directly measuring the Linux
crypto API performance using a custom kernel module.  Note that indirect
benchmarks (e.g. 'cryptsetup benchmark' or benchmarking dm-crypt I/O)
include more overhead and won't see quite as much of a difference.  All
these benchmarks used an associated data length of 16 bytes.  Note that
AES-GCM is almost always used with short associated data lengths.

The following two tables summarize how the performance of my code
compares with Intel's AVX512 AES-GCM code, both the version that is in
OpenSSL and the version that was proposed for inclusion in Linux.
Neither version exists in Linux currently, but these are alternative
AES-GCM implementations that could be chosen instead of mine.  I
collected the following numbers on Sapphire Rapids using a userspace
benchmark program that calls the assembly functions directly.

Table 3: VAES-based AES-256-GCM encryption throughput in MB/s,
         implementation name vs. message length in bytes:

                     | 16384 |  4096 |  4095 |  1420 |   512 |   500 |
---------------------+-------+-------+-------+-------+-------+-------+
This implementation  | 12846 | 11654 | 11228 |  8776 |  6704 |  5724 |
AVX512_Intel_OpenSSL | 12960 | 11482 | 10844 |  8418 |  5469 |  5643 |
AVX512_Intel_Linux   | 12829 | 11232 | 10711 |  7973 |  5694 |  4971 |

                     |   300 |   200 |    64 |    63 |    16 |
---------------------+-------+-------+-------+-------+-------+
This implementation  |  4625 |  3511 |  1780 |  1758 |   710 |
AVX512_Intel_OpenSSL |  4315 |  4251 |  2532 |  2187 |  1034 |
AVX512_Intel_Linux   |  3590 |  2700 |  1411 |  1210 |   574 |

Table 4: VAES-based AES-256-GCM decryption throughput in MB/s,
         implementation name vs. message length in bytes:

                     | 16384 |  4096 |  4095 |  1420 |   512 |   500 |
---------------------+-------+-------+-------+-------+-------+-------+
This implementation  | 13293 | 11681 | 12090 |  9548 |  7586 |  7124 |
AVX512_Intel_OpenSSL | 13039 | 11555 | 11483 |  8402 |  5535 |  5878 |
AVX512_Intel_Linux   | 12680 | 11673 | 11357 |  8430 |  6327 |  5559 |

                     |   300 |   200 |    64 |    63 |    16 |
---------------------+-------+-------+-------+-------+-------+
This implementation  |  6159 |  4287 |  2471 |  2441 |   982 |
AVX512_Intel_OpenSSL |  4544 |  5092 |  2717 |  2408 |  1160 |
AVX512_Intel_Linux   |  3760 |  2977 |  1374 |  1197 |   554 |

So, often my code is actually slightly faster than Intel's code, though
the OpenSSL implementation has a slight edge on messages shorter than
256 bytes in this microbenchmark.  It can be seen that the large code
size (up to 90x larger!) of the Intel implementations doesn't seem to
bring much benefit, so starting from scratch with much smaller code, as
I've done, seems appropriate.  The performance of my code on messages
shorter than 256 bytes could be improved through a limited amount of
unrolling, but it's unclear it would be worth it, given code size
considerations (e.g. caches) that don't get measured in microbenchmarks.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/Kconfig                |    1 +
 arch/x86/crypto/Makefile               |    3 +
 arch/x86/crypto/aes-gcm-avx10-x86_64.S | 1201 ++++++++++++++++++++++++
 arch/x86/crypto/aesni-intel_glue.c     |  515 +++++++++-
 4 files changed, 1706 insertions(+), 14 deletions(-)
 create mode 100644 arch/x86/crypto/aes-gcm-avx10-x86_64.S

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index c9e59589a1ce..24875e6295f2 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -16,10 +16,11 @@ config CRYPTO_CURVE25519_X86
 config CRYPTO_AES_NI_INTEL
 	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XTR, XTS, GCM (AES-NI)"
 	depends on X86
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
+	select CRYPTO_LIB_GF128MUL
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
 	help
 	  Block cipher: AES cipher algorithms
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 9c5ce5613738..a2a536b690fa 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -48,10 +48,13 @@ chacha-x86_64-$(CONFIG_AS_AVX512) += chacha-avx512vl-x86_64.o
 
 obj-$(CONFIG_CRYPTO_AES_NI_INTEL) += aesni-intel.o
 aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o
 aesni-intel-$(CONFIG_64BIT) += aesni-intel_avx-x86_64.o \
 	aes_ctrby8_avx-x86_64.o aes-xts-avx-x86_64.o
+ifeq ($(CONFIG_AS_VAES)$(CONFIG_AS_VPCLMULQDQ),yy)
+aesni-intel-$(CONFIG_64BIT) += aes-gcm-avx10-x86_64.o
+endif
 
 obj-$(CONFIG_CRYPTO_SHA1_SSSE3) += sha1-ssse3.o
 sha1-ssse3-y := sha1_avx2_x86_64_asm.o sha1_ssse3_asm.o sha1_ssse3_glue.o
 sha1-ssse3-$(CONFIG_AS_SHA1_NI) += sha1_ni_asm.o
 
diff --git a/arch/x86/crypto/aes-gcm-avx10-x86_64.S b/arch/x86/crypto/aes-gcm-avx10-x86_64.S
new file mode 100644
index 000000000000..787b4e922b8a
--- /dev/null
+++ b/arch/x86/crypto/aes-gcm-avx10-x86_64.S
@@ -0,0 +1,1201 @@
+/* SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause */
+//
+// VAES and VPCLMULQDQ optimized AES-GCM for x86_64
+//
+// Copyright 2024 Google LLC
+//
+// Author: Eric Biggers <ebiggers@google.com>
+//
+//------------------------------------------------------------------------------
+//
+// This file is dual-licensed, meaning that you can use it under your choice of
+// either of the following two licenses:
+//
+// Licensed under the Apache License 2.0 (the "License").  You may obtain a copy
+// of the License at
+//
+//	http://www.apache.org/licenses/LICENSE-2.0
+//
+// Unless required by applicable law or agreed to in writing, software
+// distributed under the License is distributed on an "AS IS" BASIS,
+// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+// See the License for the specific language governing permissions and
+// limitations under the License.
+//
+// or
+//
+// Redistribution and use in source and binary forms, with or without
+// modification, are permitted provided that the following conditions are met:
+//
+// 1. Redistributions of source code must retain the above copyright notice,
+//    this list of conditions and the following disclaimer.
+//
+// 2. Redistributions in binary form must reproduce the above copyright
+//    notice, this list of conditions and the following disclaimer in the
+//    documentation and/or other materials provided with the distribution.
+//
+// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
+// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+// POSSIBILITY OF SUCH DAMAGE.
+//
+//------------------------------------------------------------------------------
+//
+// This file implements AES-GCM (Galois/Counter Mode) for x86_64 CPUs that
+// support VAES (vector AES), VPCLMULQDQ (vector carryless multiplication), and
+// either AVX512 or AVX10.  Some of the functions, notably the encryption and
+// decryption update functions which are the most performance-critical, are
+// provided in two variants generated from a macro: one using 256-bit vectors
+// (suffix: vaes_avx10_256) and one using 512-bit vectors (vaes_avx10_512).  The
+// other, "shared" functions (vaes_avx10) use at most 256-bit vectors.
+//
+// The functions that use 512-bit vectors are intended for CPUs that support
+// 512-bit vectors *and* where using them doesn't cause significant
+// downclocking.  They require the following CPU features:
+//
+//	VAES && VPCLMULQDQ && BMI2 && ((AVX512BW && AVX512VL) || AVX10/512)
+//
+// The other functions require the following CPU features:
+//
+//	VAES && VPCLMULQDQ && BMI2 && ((AVX512BW && AVX512VL) || AVX10/256)
+//
+// All functions use the "System V" ABI.  The Windows ABI is not supported.
+//
+// Note that we use "avx10" in the names of the functions as a shorthand to
+// really mean "AVX10 or a certain set of AVX512 features".  Due to Intel's
+// introduction of AVX512 and then its replacement by AVX10, there doesn't seem
+// to be a simple way to name things that makes sense on all CPUs.
+//
+// Note that the macros that support both 256-bit and 512-bit vectors could
+// fairly easily be changed to support 128-bit too.  However, this would *not*
+// be sufficient to allow the code to run on CPUs without AVX512 or AVX10,
+// because the code heavily uses several features of these extensions other than
+// the vector length: the increase in the number of SIMD registers from 16 to
+// 32, masking support, and new instructions such as vpternlogd (which can do a
+// three-argument XOR).  These features are very useful for AES-GCM.  For a
+// similar reason, this file doesn't provide an implementation for CPUs that
+// support VAES and VPCLMULQDQ with only AVX2 (e.g., Alder Lake and Zen 3).
+
+#include <linux/linkage.h>
+
+.section .rodata
+.p2align 6
+
+	// A shuffle mask that reflects the bytes of 16-byte blocks
+.Lbswap_mask:
+	.octa   0x000102030405060708090a0b0c0d0e0f
+
+	// This is the GHASH reducing polynomial without its constant term, i.e.
+	// x^128 + x^7 + x^2 + x, represented using the backwards mapping
+	// between bits and polynomial coefficients.
+	//
+	// Alternatively, it can be interpreted as the naturally-ordered
+	// representation of the polynomial x^127 + x^126 + x^121 + 1, i.e. the
+	// "reversed" GHASH reducing polynomial without its x^128 term.
+.Lgfpoly:
+	.octa	0xc2000000000000000000000000000001
+
+	// Same as above, but with the (1 << 64) bit set.
+.Lgfpoly_and_internal_carrybit:
+	.octa	0xc2000000000000010000000000000001
+
+	// The below constants are used for incrementing the counter blocks.
+	// ctr_pattern points to the four 128-bit values [0, 1, 2, 3].
+	// inc_2blocks and inc_4blocks point to the single 128-bit values 2 and
+	// 4.  Note that the same '2' is reused in ctr_pattern and inc_2blocks.
+.Lctr_pattern:
+	.octa	0
+	.octa	1
+.Linc_2blocks:
+	.octa	2
+	.octa	3
+.Linc_4blocks:
+	.octa	4
+
+// Number of powers of the hash key stored in the key struct.  The powers are
+// stored from highest (H^NUM_KEY_POWERS) to lowest (H^1).
+#define NUM_KEY_POWERS		16
+
+// Number of powers of the hash key including zero padding at the end.  Zero
+// padding is appended so that partial vectors can be handled more easily.  E.g.
+// if VL=64 and two blocks remain, we load the 4 values [H^2, H^1, 0, 0].  The
+// most padding blocks needed is 3, which occurs if [H^1, 0, 0, 0] is loaded.
+#define FULL_NUM_KEY_POWERS	(NUM_KEY_POWERS + 3)
+
+// Offset to AES key length in the key struct
+#define OFFSETOF_KEYLEN		480
+
+// Offset to start of key powers array in the key struct
+#define OFFSETOF_KEY_POWERS	512
+
+// Offset to end of key powers array, not including the zero padding
+#define OFFSETOFEND_KEY_POWERS	(OFFSETOF_KEY_POWERS + (NUM_KEY_POWERS * 16))
+
+.text
+
+// Set the vector length in bytes.  This sets the VL variable and defines
+// register aliases V0-V31 that map to the ymm or zmm registers.
+.macro	_set_veclen	vl
+	.set	VL,	\vl
+.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15, \
+	16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
+.if VL == 32
+	.set	V\i,	%ymm\i
+.elseif VL == 64
+	.set	V\i,	%zmm\i
+.else
+	.error "Unsupported vector length"
+.endif
+.endr
+.endm
+
+// The _ghash_mul_step macro does one step of GHASH multiplication of the
+// 128-bit lanes of \a by the corresponding 128-bit lanes of \b and storing the
+// reduced products in \dst.  \t0, \t1, and \t2 are temporary registers of the
+// same size as \a and \b.  To complete all steps, this must invoked with \i=0
+// through \i=9.  The division into steps allows users of this macro to
+// optionally interleave the computation with other instructions.  Users of this
+// macro must preserve the parameter registers across steps.
+//
+// The multiplications are done in GHASH's representation of the finite field
+// GF(2^128).  Elements of GF(2^128) are represented as binary polynomials
+// (i.e. polynomials whose coefficients are bits) modulo a reducing polynomial
+// G.  The GCM specification uses G = x^128 + x^7 + x^2 + x + 1.  Addition is
+// just XOR, while multiplication is more complex and has two parts: (a) do
+// carryless multiplication of two 128-bit input polynomials to get a 256-bit
+// intermediate product polynomial, and (b) reduce the intermediate product to
+// 128 bits by adding multiples of G that cancel out terms in it.  (Adding
+// multiples of G doesn't change which field element the polynomial represents.)
+//
+// Unfortunately, the GCM specification maps bits to/from polynomial
+// coefficients backwards from the natural order.  In each byte it specifies the
+// highest bit to be the lowest order polynomial coefficient, *not* the highest!
+// This makes it nontrivial to work with the GHASH polynomials.  We could
+// reflect the bits, but x86 doesn't have an instruction that does that.
+//
+// Instead, we operate on the values without bit-reflecting them.  This *mostly*
+// just works, since XOR and carryless multiplication are symmetric with respect
+// to bit order, but it has some consequences.  First, due to GHASH's byte
+// order, by skipping bit reflection, *byte* reflection becomes necessary to
+// give the polynomial terms a consistent order.  E.g., considering an N-bit
+// value interpreted using the G = x^128 + x^7 + x^2 + x + 1 convention, bits 0
+// through N-1 of the byte-reflected value represent the coefficients of x^(N-1)
+// through x^0, whereas bits 0 through N-1 of the non-byte-reflected value
+// represent x^7...x^0, x^15...x^8, ..., x^(N-1)...x^(N-8) which can't be worked
+// with.  Fortunately, x86's vpshufb instruction can do byte reflection.
+//
+// Second, forgoing the bit reflection causes an extra multiple of x (still
+// using the G = x^128 + x^7 + x^2 + x + 1 convention) to be introduced by each
+// multiplication.  This is because an M-bit by N-bit carryless multiplication
+// really produces a (M+N-1)-bit product, but in practice it's zero-extended to
+// M+N bits.  In the G = x^128 + x^7 + x^2 + x + 1 convention, which maps bits
+// to polynomial coefficients backwards, this zero-extension actually changes
+// the product by introducing an extra factor of x.  Therefore, users of this
+// macro must ensure that one of the inputs has an extra factor of x^-1, i.e.
+// the multiplicative inverse of x, to cancel out the extra x.
+//
+// Third, the backwards coefficients convention is just confusing to work with,
+// since it makes "low" and "high" in the polynomial math mean the opposite of
+// their normal meaning in computer programming.  This can be solved by using an
+// alternative interpretation: the polynomial coefficients are understood to be
+// in the natural order, and the multiplication is actually \a * \b * x^-128 mod
+// x^128 + x^127 + x^126 + x^121 + 1.  This doesn't change the inputs, outputs,
+// or the implementation at all; it just changes the mathematical interpretation
+// of what each instruction is doing.  Starting from here, we'll use this
+// alternative interpretation, as it's easier to understand the code that way.
+//
+// Moving onto the implementation, the vpclmulqdq instruction does 64 x 64 =>
+// 128-bit carryless multiplication, so we break the 128 x 128 multiplication
+// into parts as follows (the _L and _H suffixes denote low and high 64 bits):
+//
+//     LO = a_L * b_L
+//     MI = (a_L * b_H) + (a_H * b_L)
+//     HI = a_H * b_H
+//
+// The 256-bit product is x^128*HI + x^64*MI + LO.  LO, MI, and HI are 128-bit.
+// Note that MI "overlaps" with LO and HI.  We don't consolidate MI into LO and
+// HI right away, since the way the reduction works makes that unnecessary.
+//
+// For the reduction, we cancel out the low 128 bits by adding multiples of G =
+// x^128 + x^127 + x^126 + x^121 + 1.  This is done by two iterations, each of
+// which cancels out the next lowest 64 bits.  Consider a value x^64*A + B,
+// where A and B are 128-bit.  Adding B_L*G to that value gives:
+//
+//       x^64*A + B + B_L*G
+//     = x^64*A + x^64*B_H + B_L + B_L*(x^128 + x^127 + x^126 + x^121 + 1)
+//     = x^64*A + x^64*B_H + B_L + x^128*B_L + x^64*B_L*(x^63 + x^62 + x^57) + B_L
+//     = x^64*A + x^64*B_H + x^128*B_L + x^64*B_L*(x^63 + x^62 + x^57) + B_L + B_L
+//     = x^64*(A + B_H + x^64*B_L + B_L*(x^63 + x^62 + x^57))
+//
+// So: if we sum A, B with its halves swapped, and the low half of B times x^63
+// + x^62 + x^57, we get a 128-bit value C where x^64*C is congruent to the
+// original value x^64*A + B.  I.e., the low 64 bits got canceled out.
+//
+// We just need to apply this twice: first to fold LO into MI, and second to
+// fold the updated MI into HI.
+//
+// The needed three-argument XORs are done using the vpternlogd instruction with
+// immediate 0x96, since this is faster than two vpxord instructions.
+.macro	_ghash_mul_step	i, a, b, dst, gfpoly, t0, t1, t2
+.if \i == 0
+	vpclmulqdq	$0x00, \a, \b, \t0	  // LO = a_L * b_L
+	vpclmulqdq	$0x01, \a, \b, \t1	  // MI_0 = a_L * b_H
+.elseif \i == 1
+	vpclmulqdq	$0x10, \a, \b, \t2	  // MI_1 = a_H * b_L
+.elseif \i == 2
+	vpxord		\t2, \t1, \t1		  // MI = MI_0 + MI_1
+.elseif \i == 3
+	vpclmulqdq	$0x01, \t0, \gfpoly, \t2  // LO_L*(x^63 + x^62 + x^57)
+.elseif \i == 4
+	vpshufd		$0x4e, \t0, \t0		  // Swap halves of LO
+.elseif \i == 5
+	vpternlogd	$0x96, \t2, \t0, \t1	  // Fold LO into MI
+.elseif \i == 6
+	vpclmulqdq	$0x11, \a, \b, \dst	  // HI = a_H * b_H
+.elseif \i == 7
+	vpclmulqdq	$0x01, \t1, \gfpoly, \t0  // MI_L*(x^63 + x^62 + x^57)
+.elseif \i == 8
+	vpshufd		$0x4e, \t1, \t1		  // Swap halves of MI
+.elseif \i == 9
+	vpternlogd	$0x96, \t0, \t1, \dst	  // Fold MI into HI
+.endif
+.endm
+
+// GHASH-multiply the 128-bit lanes of \a by the 128-bit lanes of \b and store
+// the reduced products in \dst.  See _ghash_mul_step for full explanation.
+.macro	_ghash_mul	a, b, dst, gfpoly, t0, t1, t2
+.irp i, 0,1,2,3,4,5,6,7,8,9
+	_ghash_mul_step	\i, \a, \b, \dst, \gfpoly, \t0, \t1, \t2
+.endr
+.endm
+
+// GHASH-multiply the 128-bit lanes of \a by the 128-bit lanes of \b and add the
+// *unreduced* products to \lo, \mi, and \hi.
+.macro	_ghash_mul_noreduce	a, b, lo, mi, hi, t0, t1, t2, t3
+	vpclmulqdq	$0x01, \a, \b, \t0
+	vpclmulqdq	$0x10, \a, \b, \t1
+	vpclmulqdq	$0x00, \a, \b, \t2
+	vpclmulqdq	$0x11, \a, \b, \t3
+	vpternlogd	$0x96, \t0, \t1, \mi
+	vpxord		\t2, \lo, \lo
+	vpxord		\t3, \hi, \hi
+.endm
+
+// Reduce the unreduced products from \lo, \mi, and \hi and store the 128-bit
+// reduced products in \hi.  See _ghash_mul_step for explanation of reduction.
+.macro	_ghash_reduce	lo, mi, hi, gfpoly, t0
+	vpclmulqdq	$0x01, \lo, \gfpoly, \t0
+	vpshufd		$0x4e, \lo, \lo
+	vpternlogd	$0x96, \t0, \lo, \mi
+	vpclmulqdq	$0x01, \mi, \gfpoly, \t0
+	vpshufd		$0x4e, \mi, \mi
+	vpternlogd	$0x96, \t0, \mi, \hi
+.endm
+
+// void aes_gcm_precompute_##suffix(struct aes_gcm_key_avx10 *key);
+//
+// Given the expanded AES key |key->aes_key|, this function derives the GHASH
+// subkey and initializes |key->ghash_key_powers| with powers of it.
+//
+// The number of key powers initialized is NUM_KEY_POWERS, and they are stored
+// in the order H^NUM_KEY_POWERS to H^1.  The zeroized padding blocks after the
+// key powers themselves (see FULL_NUM_KEY_POWERS) are also initialized.
+//
+// This macro supports both VL=32 and VL=64.  _set_veclen must have been invoked
+// with the desired length.  In the VL=32 case, the function computes twice as
+// many key powers than are actually used by the VL=32 GCM update functions.
+// This is done to keep the key format the same regardless of vector length.
+.macro	_aes_gcm_precompute
+
+	// Function arguments
+	.set	KEY,		%rdi
+
+	// Additional local variables.  V0-V2 and %rax are used as temporaries.
+	.set	POWERS_PTR,	%rsi
+	.set	RNDKEYLAST_PTR,	%rcx
+	.set	H_CUR,		V3
+	.set	H_CUR_YMM,	%ymm3
+	.set	H_CUR_XMM,	%xmm3
+	.set	H_INC,		V4
+	.set	H_INC_YMM,	%ymm4
+	.set	H_INC_XMM,	%xmm4
+	.set	GFPOLY,		V5
+	.set	GFPOLY_YMM,	%ymm5
+	.set	GFPOLY_XMM,	%xmm5
+
+	// Get pointer to lowest set of key powers (located at end of array).
+	lea		OFFSETOFEND_KEY_POWERS-VL(KEY), POWERS_PTR
+
+	// Encrypt an all-zeroes block to get the raw hash subkey.
+	movl		OFFSETOF_KEYLEN(KEY), %eax  // AES key length in bytes
+	lea		6*16(KEY,%rax,4), RNDKEYLAST_PTR
+	vmovdqu		(KEY), %xmm0  // Zero-th round key XOR all-zeroes block
+	add		$16, KEY
+1:
+	vaesenc		(KEY), %xmm0, %xmm0
+	add		$16, KEY
+	cmp		KEY, RNDKEYLAST_PTR
+	jne		1b
+	vaesenclast	(RNDKEYLAST_PTR), %xmm0, %xmm0
+
+	// Reflect the bytes of the raw hash subkey.
+	vpshufb		.Lbswap_mask(%rip), %xmm0, H_CUR_XMM
+
+	// Zeroize the padding blocks.
+	vpxor		%xmm0, %xmm0, %xmm0
+	vmovdqu		%ymm0, VL(POWERS_PTR)
+	vmovdqu		%xmm0, VL+2*16(POWERS_PTR)
+
+	// Finish preprocessing the first key power, H^1.  Since this GHASH
+	// implementation operates directly on values with the backwards bit
+	// order specified by the GCM standard, it's necessary to preprocess the
+	// raw key as follows.  First, reflect its bytes.  Second, multiply it
+	// by x^-1 mod x^128 + x^7 + x^2 + x + 1 (if using the backwards
+	// interpretation of polynomial coefficients), which can also be
+	// interpreted as multiplication by x mod x^128 + x^127 + x^126 + x^121
+	// + 1 using the alternative, natural interpretation of polynomial
+	// coefficients.  For details, see the comment above _ghash_mul_step.
+	//
+	// Either way, for the multiplication the concrete operation performed
+	// is a left shift of the 128-bit value by 1 bit, then an XOR with (0xc2
+	// << 120) | 1 if a 1 bit was carried out.  However, there's no 128-bit
+	// wide shift instruction, so instead double each of the two 64-bit
+	// halves and incorporate the internal carry bit into the value XOR'd.
+	vpshufd		$0xd3, H_CUR_XMM, %xmm0
+	vpsrad		$31, %xmm0, %xmm0
+	vpaddq		H_CUR_XMM, H_CUR_XMM, H_CUR_XMM
+	vpand		.Lgfpoly_and_internal_carrybit(%rip), %xmm0, %xmm0
+	vpxor		%xmm0, H_CUR_XMM, H_CUR_XMM
+
+	// Load the gfpoly constant.
+	vbroadcasti32x4	.Lgfpoly(%rip), GFPOLY
+
+	// Square H^1 to get H^2.
+	//
+	// Note that as with H^1, all higher key powers also need an extra
+	// factor of x^-1 (or x using the natural interpretation).  Nothing
+	// special needs to be done to make this happen, though: H^1 * H^1 would
+	// end up with two factors of x^-1, but the multiplication consumes one.
+	// So the product H^2 ends up with the desired one factor of x^-1.
+	_ghash_mul	H_CUR_XMM, H_CUR_XMM, H_INC_XMM, GFPOLY_XMM, \
+			%xmm0, %xmm1, %xmm2
+
+	// Create H_CUR_YMM = [H^2, H^1] and H_INC_YMM = [H^2, H^2].
+	vinserti128	$1, H_CUR_XMM, H_INC_YMM, H_CUR_YMM
+	vinserti128	$1, H_INC_XMM, H_INC_YMM, H_INC_YMM
+
+.if VL == 64
+	// Create H_CUR = [H^4, H^3, H^2, H^1] and H_INC = [H^4, H^4, H^4, H^4].
+	_ghash_mul	H_INC_YMM, H_CUR_YMM, H_INC_YMM, GFPOLY_YMM, \
+			%ymm0, %ymm1, %ymm2
+	vinserti64x4	$1, H_CUR_YMM, H_INC, H_CUR
+	vshufi64x2	$0, H_INC, H_INC, H_INC
+.endif
+
+	// Store the lowest set of key powers.
+	vmovdqu8	H_CUR, (POWERS_PTR)
+	sub		$VL, POWERS_PTR
+
+	// Compute and store the remaining key powers.  With VL=32, repeatedly
+	// multiply [H^(i+1), H^i] by [H^2, H^2] to get [H^(i+3), H^(i+2)].
+	// With VL=64, repeatedly multiply [H^(i+3), H^(i+2), H^(i+1), H^i] by
+	// [H^4, H^4, H^4, H^4] to get [H^(i+7), H^(i+6), H^(i+5), H^(i+4)].
+	mov		$(NUM_KEY_POWERS*16/VL) - 1, %eax
+.Lprecompute_next\@:
+	_ghash_mul	H_INC, H_CUR, H_CUR, GFPOLY, V0, V1, V2
+	vmovdqu8	H_CUR, (POWERS_PTR)
+	sub		$VL, POWERS_PTR
+	dec		%eax
+	jnz		.Lprecompute_next\@
+
+	vzeroupper	// This is needed after using ymm or zmm registers.
+	RET
+.endm
+
+// XOR together the 128-bit lanes of \src (whose low lane is \src_xmm) and store
+// the result in \dst_xmm.  This implicitly zeroes the other lanes of dst.
+.macro	_horizontal_xor	src, src_xmm, dst_xmm, t0_xmm, t1_xmm, t2_xmm
+	vextracti32x4	$1, \src, \t0_xmm
+.if VL == 32
+	vpxord		\t0_xmm, \src_xmm, \dst_xmm
+.elseif VL == 64
+	vextracti32x4	$2, \src, \t1_xmm
+	vextracti32x4	$3, \src, \t2_xmm
+	vpxord		\t0_xmm, \src_xmm, \dst_xmm
+	vpternlogd	$0x96, \t1_xmm, \t2_xmm, \dst_xmm
+.else
+	.error "Unsupported vector length"
+.endif
+.endm
+
+// Do one step of the GHASH update of the data blocks given in the vector
+// registers \a through \d.  \i specifies the step to do, 0 through 9.  The
+// division into steps allows users of this macro to interleave the computation
+// with other instructions.  This uses the vector register GHASH_ACC as
+// input/output; \a, \b, \c, \d, H_POW[4-1], and GFPOLY as input; and
+// GHASHTMP[0-8] as temporaries.  This handles the byte-reflection of the input
+// data.  The parameter registers must be preserved across steps.
+//
+// The GHASH update does: GHASH_ACC = H_POW4*(\a + GHASH_ACC) + H_POW3*\b +
+// H_POW2*\c + H_POW1*\d, where the operations are vectorized operations on
+// vectors of 16-byte blocks.  E.g., with VL=32 there are 2 blocks per vector
+// and the vectorized terms correspond to the following non-vectorized terms:
+//
+//	H_POW4*(\a + GHASH_ACC) => H^8*(blk0 + GHASH_ACC_XMM) and H^7*(blk1 + 0)
+//	H_POW3*\b => H^6*blk2 and H^5*blk3
+//	H_POW2*\c => H^4*blk4 and H^3*blk5
+//	H_POW1*\d => H^2*blk6 and H^1*blk7
+//
+// With VL=64, we use 4 blocks/vector, H^16 through H^1, and blk0 through blk15.
+//
+// More concretely, this code does:
+//   - Do vectorized "schoolbook" multiplications to compute the intermediate
+//     256-bit product of each block and its corresponding hash key power.
+//     There are 4*VL/16 of these intermediate products.
+//   - Sum (XOR) the intermediate 256-bit products across vectors.  This leaves
+//     VL/16 256-bit intermediate values.
+//   - Do a vectorized reduction of these 256-bit intermediate values to
+//     128-bits each.  This leaves VL/16 128-bit intermediate values.
+//   - Sum (XOR) these values and store the 128-bit result in GHASH_ACC_XMM.
+//
+// See _ghash_mul_step for the full explanation of the operations performed for
+// each individual finite field multiplication and reduction.
+.macro	_ghash_step_4x	i, a, b, c, d
+.if \i == 0
+	vpshufb		BSWAP_MASK, \a, GHASHTMP0  // Byte-reflect input data
+	vpxord		GHASH_ACC, GHASHTMP0, GHASHTMP0	 // blk0 += GHASH_ACC
+	vpshufb		BSWAP_MASK, \b, GHASHTMP1  // Byte-reflect input data
+	vpshufb		BSWAP_MASK, \c, GHASHTMP2  // Byte-reflect input data
+.elseif \i == 1
+	vpshufb		BSWAP_MASK, \d, GHASHTMP3  // Byte-reflect input data
+	vpclmulqdq	$0x00, H_POW4, GHASHTMP0, GHASH_ACC	// LO_0
+	vpclmulqdq	$0x00, H_POW3, GHASHTMP1, GHASHTMP4	// LO_1
+	vpclmulqdq	$0x00, H_POW2, GHASHTMP2, GHASHTMP5	// LO_2
+.elseif \i == 2
+	vpclmulqdq	$0x00, H_POW1, GHASHTMP3, GHASHTMP6	// LO_3
+	vpxord		GHASHTMP4, GHASH_ACC, GHASH_ACC		// sum(LO_{1,0})
+	vpclmulqdq	$0x01, H_POW4, GHASHTMP0, GHASHTMP4	// MI_0
+	vpclmulqdq	$0x01, H_POW3, GHASHTMP1, GHASHTMP7	// MI_1
+.elseif \i == 3
+	vpternlogd	$0x96, GHASHTMP6, GHASHTMP5, GHASH_ACC	// LO = sum(LO_{3,2,1,0})
+	vpclmulqdq	$0x01, H_POW2, GHASHTMP2, GHASHTMP5	// MI_2
+	vpternlogd	$0x96, GHASHTMP5, GHASHTMP7, GHASHTMP4	// sum(MI_{2,1,0})
+	vpclmulqdq	$0x01, H_POW1, GHASHTMP3, GHASHTMP5	// MI_3
+.elseif \i == 4
+	vpclmulqdq	$0x01, GHASH_ACC, GFPOLY, GHASHTMP8	// LO_L*(x^63 + x^62 + x^57)
+	vpclmulqdq	$0x10, H_POW4, GHASHTMP0, GHASHTMP6	// MI_4
+	vpclmulqdq	$0x10, H_POW3, GHASHTMP1, GHASHTMP7	// MI_5
+	vpshufd		$0x4e, GHASH_ACC, GHASH_ACC		// Swap halves of LO
+.elseif \i == 5
+	vpternlogd	$0x96, GHASHTMP7, GHASHTMP6, GHASHTMP5	// sum(MI_{5,4,3})
+	vpclmulqdq	$0x10, H_POW2, GHASHTMP2, GHASHTMP6	// MI_6
+	vpclmulqdq	$0x10, H_POW1, GHASHTMP3, GHASHTMP7	// MI_7
+	vpternlogd	$0x96, GHASHTMP7, GHASHTMP6, GHASHTMP4	// sum(MI_{7,6,2,1,0})
+.elseif \i == 6
+	vpclmulqdq	$0x11, H_POW4, GHASHTMP0, GHASHTMP0	// HI_0
+	vpxord		GHASHTMP5, GHASHTMP4, GHASHTMP4		// MI = sum(MI_{7,6,5,4,3,2,1,0})
+	vpclmulqdq	$0x11, H_POW3, GHASHTMP1, GHASHTMP1	// HI_1
+	vpclmulqdq	$0x11, H_POW2, GHASHTMP2, GHASHTMP2	// HI_2
+.elseif \i == 7
+	vpternlogd	$0x96, GHASHTMP8, GHASH_ACC, GHASHTMP4	// Fold LO into MI
+	vpclmulqdq	$0x11, H_POW1, GHASHTMP3, GHASHTMP3	// HI_3
+	vpternlogd	$0x96, GHASHTMP2, GHASHTMP1, GHASHTMP0	// sum(HI_{2,1,0})
+	vpclmulqdq	$0x01, GHASHTMP4, GFPOLY, GHASHTMP1	// MI_L*(x^63 + x^62 + x^57)
+.elseif \i == 8
+	vpxord		GHASHTMP3, GHASHTMP0, GHASH_ACC		// HI = sum(HI_{3,2,1,0})
+	vpshufd		$0x4e, GHASHTMP4, GHASHTMP4		// Swap halves of MI
+	vpternlogd	$0x96, GHASHTMP1, GHASHTMP4, GHASH_ACC	// Fold MI into HI
+.elseif \i == 9
+	_horizontal_xor	GHASH_ACC, GHASH_ACC_XMM, GHASH_ACC_XMM, \
+			GHASHTMP0_XMM, GHASHTMP1_XMM, GHASHTMP2_XMM
+.endif
+.endm
+
+// Do one round of AES encryption on the block(s) in \data using the round
+// key(s) in \round_key.  The register length determines the number of AES
+// blocks encrypted.  \last specifies whether it's the last round or not.
+.macro	_vaesenc	last, round_key, data
+.if \last
+	vaesenclast	\round_key, \data, \data
+.else
+	vaesenc		\round_key, \data, \data
+.endif
+.endm
+
+// Do one round of AES encryption on the counter blocks in V0-V3 using the round
+// key that has been broadcast to all 128-bit lanes of \round_key.
+.macro	_vaesenc_4x	last, round_key
+	_vaesenc	\last, \round_key, V0
+	_vaesenc	\last, \round_key, V1
+	_vaesenc	\last, \round_key, V2
+	_vaesenc	\last, \round_key, V3
+.endm
+
+// Do one round of AES encryption on the counter blocks in V0-V3 using the round
+// key that has been broadcast to all 128-bit lanes of \round_key.  In addition,
+// do one step of the GHASH update of the ciphertext blocks in V4-V7.
+.macro	_vaesenc_and_ghash_4x	last, round_key, ghash_step
+	_ghash_step_4x	\ghash_step, V4, V5, V6, V7
+	_vaesenc_4x	\last, \round_key
+.endm
+
+// Start the AES encryption of four vectors of counter blocks.
+.macro	_ctr_begin_4x
+
+	// Swap the counters from little endian to big endian.
+	vpshufb		BSWAP_MASK, LE_CTR1, V0
+	vpshufb		BSWAP_MASK, LE_CTR2, V1
+	vpshufb		BSWAP_MASK, LE_CTR3, V2
+	vpshufb		BSWAP_MASK, LE_CTR4, V3
+
+	// AES "round zero": XOR in the zero-th round key.
+	vpxord		RNDKEY0, V0, V0
+	vpxord		RNDKEY0, V1, V1
+	vpxord		RNDKEY0, V2, V2
+	vpxord		RNDKEY0, V3, V3
+
+	// Advance the counters.
+	vpaddd		LE_CTR_INC, LE_CTR1, LE_CTR1
+	vpaddd		LE_CTR_INC, LE_CTR2, LE_CTR2
+	vpaddd		LE_CTR_INC, LE_CTR3, LE_CTR3
+	vpaddd		LE_CTR_INC, LE_CTR4, LE_CTR4
+.endm
+
+// AES-encrypt the counter blocks LE_CTR[1-4], storing the resulting keystream
+// blocks in V0-V3.  In parallel, update GHASH with the ciphertext blocks in
+// V4-V7.  Also increment LE_CTR[1-4].  RNDKEY and GHASHTMP[0-8] are clobbered.
+.macro	_ctr_and_ghash_4x
+	_ctr_begin_4x
+	cmp		$24, AESKEYLEN
+	jl		128f	// AES-128?
+	je		192f	// AES-192?
+	// Else, it's AES-256.
+	vbroadcasti32x4	-13*16(RNDKEYLAST_PTR), RNDKEY
+	_vaesenc_4x	0, RNDKEY
+	vbroadcasti32x4	-12*16(RNDKEYLAST_PTR), RNDKEY
+	_vaesenc_4x	0, RNDKEY
+192:
+	vbroadcasti32x4	-11*16(RNDKEYLAST_PTR), RNDKEY
+	_vaesenc_4x	0, RNDKEY
+	vbroadcasti32x4	-10*16(RNDKEYLAST_PTR), RNDKEY
+	_vaesenc_4x	0, RNDKEY
+128:
+.irp i, 0,1,2,3,4,5,6,7,8
+	vbroadcasti32x4	(\i-9)*16(RNDKEYLAST_PTR), RNDKEY
+	_vaesenc_and_ghash_4x	0, RNDKEY, \i
+.endr
+	_vaesenc_and_ghash_4x	1, RNDKEYLAST, 9
+.endm
+
+// XOR four vectors of plaintext blocks from SRC with the keystream blocks in
+// V0-V3.  Store the resulting ciphertext to DST and also leave it in V4-V7.
+.macro	_xor_plaintext_4x
+	vpxord		0*VL(SRC), V0, V4
+	vpxord		1*VL(SRC), V1, V5
+	vpxord		2*VL(SRC), V2, V6
+	vpxord		3*VL(SRC), V3, V7
+	vmovdqu8	V4, 0*VL(DST)
+	vmovdqu8	V5, 1*VL(DST)
+	vmovdqu8	V6, 2*VL(DST)
+	vmovdqu8	V7, 3*VL(DST)
+.endm
+
+// void aes_gcm_{enc,dec}_update_##suffix(const struct aes_gcm_key_avx10 *key,
+//					  const u32 le_ctr[4], u8 ghash_acc[16],
+//					  const u8 *src, u8 *dst, int datalen);
+//
+// This macro generates a GCM encryption or decryption update function with the
+// above prototype (with \enc selecting which one).  This macro supports both
+// VL=32 and VL=64.  _set_veclen must have been invoked with the desired length.
+//
+// This function computes the next portion of the CTR keystream, XOR's it with
+// |datalen| bytes from |src|, and writes the resulting encrypted or decrypted
+// data to |dst|.  It also updates the GHASH accumulator |ghash_acc| using the
+// next |datalen| ciphertext bytes.
+//
+// |datalen| must be a multiple of 16, except on the last call where it can be
+// any length.  The caller must do any buffering needed to ensure this.  Both
+// in-place and out-of-place en/decryption are supported.
+//
+// |le_ctr| must give the current counter in little endian format.  For a new
+// message, the low word of the counter must be 2.  This function loads the
+// counter from |le_ctr| and increments the loaded counter as needed, but it
+// does *not* store the updated counter back to |le_ctr|.  The caller must
+// update |le_ctr| if any more data segments follow.  Internally, only the low
+// 32-bit word of the counter is incremented, following the GCM standard.
+.macro	_aes_gcm_update	enc
+
+	// Function arguments
+	.set	KEY,		%rdi
+	.set	LE_CTR,		%rsi
+	.set	GHASH_ACC_PTR,	%rdx
+	.set	SRC,		%rcx
+	.set	DST,		%r8
+	.set	DATALEN,	%r9d
+	.set	DATALEN64,	%r9	// Zero-extend DATALEN before using!
+
+	// Additional local variables
+
+	// %rax and %k1 are used as temporary registers.  LE_CTR is also
+	// available as a temporary register after the counter is loaded.  In
+	// the main loop, V0-V3 are used as AES input and output, and V4-V7 are
+	// used as GHASH input.  Elsewhere they are used as temporary registers.
+
+	// AES key length in bytes
+	.set	AESKEYLEN,	%r10d
+	.set	AESKEYLEN64,	%r10
+
+	// Pointer to the last AES round key for the chosen AES variant
+	.set	RNDKEYLAST_PTR,	%r11
+
+	// BSWAP_MASK is the shuffle mask for byte-reflecting 128-bit values
+	// using vpshufb, copied to all 128-bit lanes.
+	.set	BSWAP_MASK,	V8
+
+	// RNDKEY temporarily holds the next AES round key.
+	.set	RNDKEY,		V9
+
+	// GHASH_ACC is the accumulator variable for GHASH.  When fully reduced,
+	// only the lowest 128-bit lane can be nonzero.  When not fully reduced,
+	// more than one lane may be used, and they need to be XOR'd together.
+	.set	GHASH_ACC,	V10
+	.set	GHASH_ACC_XMM,	%xmm10
+
+	// LE_CTR_INC is the vector of 32-bit words that needs to be added to
+	// the counter vectors after each iteration.  It is (u32[]){N, 0, 0, 0,
+	// N, 0, 0, 0, ...} where N is the number of AES blocks being advanced.
+	.set	LE_CTR_INC,	V11
+
+	// RNDKEY0 is the zero-th AES round key, copied to all 128-bit lanes.
+	.set	RNDKEY0,	V12
+
+	// RNDKEYLAST is the last AES round key, copied to all 128-bit lanes.
+	.set	RNDKEYLAST,	V13
+
+	// LE_CTR[1-4] contain the next set of little-endian counter blocks.
+	.set	LE_CTR1,	V14
+	.set	LE_CTR2,	V15
+	.set	LE_CTR3,	V16
+	.set	LE_CTR4,	V17
+
+	// GHASHTMP[0-8] are temporary variables used by _ghash_step_4x.  These
+	// cannot coincide with anything used for AES encryption, since for
+	// performance reasons GHASH and AES encryption are interleaved.
+	.set	GHASHTMP0,	V18
+	.set	GHASHTMP0_XMM,	%xmm18
+	.set	GHASHTMP1,	V19
+	.set	GHASHTMP1_XMM,	%xmm19
+	.set	GHASHTMP2,	V20
+	.set	GHASHTMP2_XMM,	%xmm20
+	.set	GHASHTMP3,	V21
+	.set	GHASHTMP4,	V22
+	.set	GHASHTMP5,	V23
+	.set	GHASHTMP6,	V24
+	.set	GHASHTMP7,	V25
+	.set	GHASHTMP8,	V26
+
+	// H_POW[4-1] contain the powers of the hash key H^(4*VL/16)...H^1.  The
+	// descending numbering reflects the order of the key powers.
+	.set	H_POW4,		V27
+	.set	H_POW3,		V28
+	.set	H_POW2,		V29
+	.set	H_POW1,		V30
+
+	// GFPOLY contains the .Lgfpoly constant, copied to all 128-bit lanes.
+	.set	GFPOLY,		V31
+
+	// Load some constants.
+	vbroadcasti32x4	.Lbswap_mask(%rip), BSWAP_MASK
+	vbroadcasti32x4	.Lgfpoly(%rip), GFPOLY
+
+	// Load the GHASH accumulator and the starting counter.
+	vmovdqu		(GHASH_ACC_PTR), GHASH_ACC_XMM
+	vbroadcasti32x4	(LE_CTR), LE_CTR1
+
+	// Load the AES key length in bytes.
+	movl		OFFSETOF_KEYLEN(KEY), AESKEYLEN
+
+	// Load the lowest set of powers of the hash key.
+	vmovdqu8	OFFSETOFEND_KEY_POWERS-VL(KEY), H_POW1
+
+	// Make RNDKEYLAST_PTR point to the last AES round key.  This is the
+	// round key with index 10, 12, or 14 for AES-128, AES-192, or AES-256
+	// respectively.  Then load the zero-th and last round keys.
+	lea		6*16(KEY,AESKEYLEN64,4), RNDKEYLAST_PTR
+	vbroadcasti32x4	(KEY), RNDKEY0
+	vbroadcasti32x4	(RNDKEYLAST_PTR), RNDKEYLAST
+
+	// Finish initializing LE_CTR1 by adding [0, 1, ...] to its low words.
+	vpaddd		.Lctr_pattern(%rip), LE_CTR1, LE_CTR1
+
+	// Initialize LE_CTR_INC for 1 vector.
+.if VL == 32
+	vbroadcasti32x4	.Linc_2blocks(%rip), LE_CTR_INC
+.elseif VL == 64
+	vbroadcasti32x4	.Linc_4blocks(%rip), LE_CTR_INC
+.else
+	.error "Unsupported vector length"
+.endif
+
+	// If there are at least 4*VL bytes of data, then continue into the loop
+	// that processes 4*VL bytes of data at a time.  Otherwise skip it.
+	//
+	// Pre-subtracting 4*VL from DATALEN saves an instruction from the main
+	// loop and also ensures that at least one write always occurs to
+	// DATALEN, zero-extending it and allowing DATALEN64 to be used later.
+	sub		$4*VL, DATALEN
+	jl		.Lcrypt_loop_4x_done\@
+
+	// Load higher powers of the hash key.
+	vmovdqu8	OFFSETOFEND_KEY_POWERS-4*VL(KEY), H_POW4
+	vmovdqu8	OFFSETOFEND_KEY_POWERS-3*VL(KEY), H_POW3
+	vmovdqu8	OFFSETOFEND_KEY_POWERS-2*VL(KEY), H_POW2
+
+	// Initialize LE_CTR[2-4].
+	vpaddd		LE_CTR_INC, LE_CTR1, LE_CTR2
+	vpaddd		LE_CTR_INC, LE_CTR2, LE_CTR3
+	vpaddd		LE_CTR_INC, LE_CTR3, LE_CTR4
+
+	// Make LE_CTR_INC increment by 4 vectors instead of 1.
+	vpslld		$2, LE_CTR_INC, LE_CTR_INC
+
+	// Main loop: en/decrypt and hash 4 vectors at a time.
+	//
+	// When possible, interleave the AES encryption of the counter blocks
+	// with the GHASH update of the ciphertext blocks.  This improves
+	// performance on many CPUs because the execution ports used by the VAES
+	// instructions often differ from those used by vpclmulqdq and other
+	// instructions used in GHASH.  For example, many Intel CPUs dispatch
+	// vaesenc to port 0 and 1 and vpclmulqdq to port 5.
+	//
+	// The interleaving is easiest to do during decryption, since during
+	// decryption the ciphertext blocks are immediately available.  For
+	// encryption, instead encrypt the first set of blocks, then hash those
+	// blocks while encrypting the next set of blocks, repeat that as
+	// needed, and finally hash the last set of blocks.
+
+.if \enc
+	// Encrypt the first 4 vectors of plaintext blocks.
+	// Leave the resulting ciphertext in V4-V7 for GHASH.
+	_ctr_begin_4x
+	lea		16(KEY), %rax
+1:
+	vbroadcasti32x4	(%rax), RNDKEY
+	_vaesenc_4x	0, RNDKEY
+	add		$16, %rax
+	cmp		%rax, RNDKEYLAST_PTR
+	jne		1b
+	_vaesenc_4x	1, RNDKEYLAST
+	_xor_plaintext_4x
+	add		$4*VL, SRC
+	add		$4*VL, DST
+	sub		$4*VL, DATALEN
+	jl		.Lghash_last_ciphertext_4x\@
+
+.Lenc_loop_4x\@:
+	// Encrypt the next 4 vectors of plaintext blocks, interleaved with the
+	// GHASH update of the previous ciphertext blocks in V4-V7.
+	_ctr_and_ghash_4x
+	_xor_plaintext_4x
+	add		$4*VL, SRC
+	add		$4*VL, DST
+	sub		$4*VL, DATALEN
+	jge		.Lenc_loop_4x\@
+
+.Lghash_last_ciphertext_4x\@:
+	// Update GHASH with the last set of ciphertext blocks in V4-V7.
+.irp i, 0,1,2,3,4,5,6,7,8,9
+	_ghash_step_4x	\i, V4, V5, V6, V7
+.endr
+.else // Decrypting
+
+.Ldec_loop_4x\@:
+	// Load the next 4 vectors of ciphertext blocks.
+	vmovdqu8	0*VL(SRC), V4
+	vmovdqu8	1*VL(SRC), V5
+	vmovdqu8	2*VL(SRC), V6
+	vmovdqu8	3*VL(SRC), V7
+
+	// Compute the keystream blocks and update GHASH (interleaved).
+	_ctr_and_ghash_4x
+
+	// plaintext = ciphertext XOR keystream
+	vpxord		V0, V4, V0
+	vpxord		V1, V5, V1
+	vpxord		V2, V6, V2
+	vpxord		V3, V7, V3
+
+	// Store the plaintext.
+	vmovdqu8	V0, 0*VL(DST)
+	vmovdqu8	V1, 1*VL(DST)
+	vmovdqu8	V2, 2*VL(DST)
+	vmovdqu8	V3, 3*VL(DST)
+
+	add		$4*VL, SRC
+	add		$4*VL, DST
+	sub		$4*VL, DATALEN
+	jge		.Ldec_loop_4x\@
+.endif
+
+	// Make LE_CTR_INC increment by 1 vector instead of 4.
+	vpsrld		$2, LE_CTR_INC, LE_CTR_INC
+
+.Lcrypt_loop_4x_done\@:
+
+	// Undo the extra subtraction by 4*VL and check whether data remains.
+	add		$4*VL, DATALEN
+	jz		.Ldone\@
+
+	// The data length isn't a multiple of 4*VL.  Process the remaining data
+	// of length 1 <= DATALEN < 4*VL, up to one vector (VL bytes) at a time.
+	// Going one vector at a time may seem inefficient compared to having
+	// separate code paths for each possible number of vectors remaining.
+	// However, using a loop keeps the code size down, and it performs
+	// surprising well; modern CPUs will start executing the next iteration
+	// before the previous one finishes and also predict the number of loop
+	// iterations.  For a similar reason, we roll up the AES rounds.
+	//
+	// On the last iteration, the remaining length may be less than VL.
+	// Handle this using masking.
+	//
+	// Since there are enough key powers available for all remaining data,
+	// there is no need to do a GHASH reduction after each iteration.
+	// Instead, multiply each remaining block by its own key power, and only
+	// do a GHASH reduction at the very end.
+
+	// Make POWERS_PTR point to the key powers [H^N, H^(N-1), ...] where N
+	// is the number of blocks that remain.
+	.set		POWERS_PTR, LE_CTR	// LE_CTR is free to be reused.
+	mov		DATALEN, %eax
+	neg		%rax
+	and		$~15, %rax  // -round_up(DATALEN, 16)
+	lea		OFFSETOFEND_KEY_POWERS(KEY,%rax), POWERS_PTR
+
+	// The unreduced GHASH intermediate value is collected in xmm2-xmm4.
+	vpxor		%xmm2, %xmm2, %xmm2	// LO
+	vpxor		%xmm3, %xmm3, %xmm3	// MI
+	vpxor		%xmm4, %xmm4, %xmm4	// HI
+
+.Lcrypt_loop_1x\@:
+
+	// Select the appropriate mask for this iteration: all 1's if
+	// DATALEN >= VL, otherwise DATALEN 1's.  Do this branchlessly using the
+	// bzhi instruction from BMI2.  (This relies on DATALEN <= 255.)
+.if VL < 64
+	mov		$-1, %eax
+	bzhi		DATALEN, %eax, %eax
+	kmovd		%eax, %k1
+.else
+	mov		$-1, %rax
+	bzhi		DATALEN64, %rax, %rax
+	kmovq		%rax, %k1
+.endif
+
+	// Encrypt a vector of counter blocks.  This does not need to be masked.
+	vpshufb		BSWAP_MASK, LE_CTR1, V0
+	vpaddd		LE_CTR_INC, LE_CTR1, LE_CTR1
+	vpxord		RNDKEY0, V0, V0
+	lea		16(KEY), %rax
+1:
+	vbroadcasti32x4	(%rax), RNDKEY
+	vaesenc		RNDKEY, V0, V0
+	add		$16, %rax
+	cmp		%rax, RNDKEYLAST_PTR
+	jne		1b
+	vaesenclast	RNDKEYLAST, V0, V0
+
+	// XOR the data with the appropriate number of keystream bytes.
+	vmovdqu8	(SRC), V1{%k1}{z}
+	vpxord		V1, V0, V0
+	vmovdqu8	V0, (DST){%k1}
+
+	// Update GHASH with the ciphertext block(s), without reducing.
+	//
+	// In the case of DATALEN < VL, the ciphertext is zero-padded to VL.
+	// (If decrypting, it's done by the above masked load.  If encrypting,
+	// it's done by the below masked register-to-register move.)  Note that
+	// if DATALEN <= VL - 16, there will be additional padding beyond the
+	// padding of the last block specified by GHASH itself; i.e., there may
+	// be whole block(s) that get processed by the GHASH multiplication and
+	// reduction instructions but should not actually be included in the
+	// GHASH.  However, any such blocks are all-zeroes, and the values that
+	// they're multiplied with are also all-zeroes.  Therefore they just add
+	// 0 * 0 = 0 to the final GHASH result, which makes no difference.
+	vmovdqu8        (POWERS_PTR), H_POW1
+.if \enc
+	vmovdqu8	V0, V1{%k1}{z}
+.endif
+	vpshufb		BSWAP_MASK, V1, V1
+	vpxord		GHASH_ACC, V1, V1
+	_ghash_mul_noreduce	H_POW1, V1, V2, V3, V4, V5, V6, V7, V0
+	vpxor		GHASH_ACC_XMM, GHASH_ACC_XMM, GHASH_ACC_XMM
+
+	add		$VL, POWERS_PTR
+	add		$VL, SRC
+	add		$VL, DST
+	sub		$VL, DATALEN
+	jg		.Lcrypt_loop_1x\@
+
+	// Finally, do the GHASH reduction.
+	_ghash_reduce	V2, V3, V4, GFPOLY, V0
+	_horizontal_xor	V4, %xmm4, GHASH_ACC_XMM, %xmm0, %xmm1, %xmm2
+
+.Ldone\@:
+	// Store the updated GHASH accumulator back to memory.
+	vmovdqu		GHASH_ACC_XMM, (GHASH_ACC_PTR)
+
+	vzeroupper	// This is needed after using ymm or zmm registers.
+	RET
+.endm
+
+// void aes_gcm_enc_final_vaes_avx10(const struct aes_gcm_key_avx10 *key,
+//				     const u32 le_ctr[4],
+//				     const u8 ghash_acc[16],
+//				     u64 total_aadlen, u64 total_datalen,
+//				     u8 *tag, int taglen);
+// bool aes_gcm_dec_final_vaes_avx10(const struct aes_gcm_key_avx10 *key,
+//				     const u32 le_ctr[4],
+//				     const u8 ghash_acc[16],
+//				     u64 total_aadlen, u64 total_datalen,
+//				     const u8 *tag, int taglen);
+//
+// This macro generates one of the above two functions (with \enc selecting
+// which one).  Both functions finish computing the GCM authentication tag by
+// updating GHASH with the lengths block and encrypting the GHASH accumulator.
+// |total_aadlen| and |total_datalen| must be the total length of the additional
+// authenticated data and the en/decrypted data in bytes, respectively.
+//
+// The encryption function then stores the computed authentication tag to |tag|.
+// The decryption function instead loads the expected authentication tag (the
+// one that was transmitted) from |tag|, compares it to the computed tag in
+// constant time, and returns true if and only if they match.  In both cases,
+// |taglen| is the length of the tag in bytes, 4 <= |taglen| <= 16.
+.macro	_aes_gcm_final	enc
+
+	// Function arguments
+	.set	KEY,		%rdi
+	.set	LE_CTR,		%rsi
+	.set	GHASH_ACC_PTR,	%rdx
+	.set	TOTAL_AADLEN,	%rcx
+	.set	TOTAL_DATALEN,	%r8
+	.set	TAG,		%r9
+	.set	TAGLEN,		%r10d	// Originally at 8(%rsp)
+
+	// Additional local variables.
+	// %rax, %xmm0-%xmm3, and %k1 are used as temporary registers.
+	.set	AESKEYLEN,	%r11d
+	.set	AESKEYLEN64,	%r11
+	.set	GFPOLY,		%xmm4
+	.set	BSWAP_MASK,	%xmm5
+	.set	LE_CTR1,	%xmm6
+	.set	GHASH_ACC,	%xmm7
+	.set	H_POW1,		%xmm8
+
+	// Load some constants.
+	vmovdqa		.Lgfpoly(%rip), GFPOLY
+	vmovdqa		.Lbswap_mask(%rip), BSWAP_MASK
+
+	// Load the AES key length in bytes.
+	movl		OFFSETOF_KEYLEN(KEY), AESKEYLEN
+
+	// Set up a counter block with 1 in the low 32-bit word.  This is the
+	// counter that produces the ciphertext needed to encrypt the auth tag.
+	// GFPOLY has 1 in the low word, so grab the 1 from there using a blend.
+	vpblendd	$0xe, (LE_CTR), GFPOLY, LE_CTR1
+
+	// Build the lengths block and XOR it with the GHASH accumulator.
+	// Although the lengths block is defined as the AAD length followed by
+	// the en/decrypted data length, both in big-endian byte order, a byte
+	// reflection of the full block is needed because of the way we compute
+	// GHASH (see _ghash_mul_step).  By using little endian values in the
+	// opposite order, we avoid having to reflect any bytes here.
+	vmovq		TOTAL_DATALEN, %xmm0
+	vpinsrq		$1, TOTAL_AADLEN, %xmm0, %xmm0
+	vpsllq		$3, %xmm0, %xmm0	// Bytes to bits
+	vpxor		(GHASH_ACC_PTR), %xmm0, GHASH_ACC
+
+	// Load the first hash key power (H^1), which is stored last.
+	vmovdqu8	OFFSETOFEND_KEY_POWERS-16(KEY), H_POW1
+
+	// Prepare the mask that will be used to store or load the auth tag.
+	movl		8(%rsp), TAGLEN
+	mov		$-1, %eax
+	bzhi		TAGLEN, %eax, %eax
+	kmovd		%eax, %k1
+
+	// Make %rax point to the last AES round key for the chosen AES variant.
+	lea		6*16(KEY,AESKEYLEN64,4), %rax
+
+	// Start the AES encryption of the counter block by swapping the counter
+	// block to big-endian and XOR-ing it with the zero-th AES round key.
+	vpshufb		BSWAP_MASK, LE_CTR1, %xmm0
+	vpxor		(KEY), %xmm0, %xmm0
+
+	// Complete the AES encryption and multiply GHASH_ACC by H^1.
+	// Interleave the AES and GHASH instructions to improve performance.
+	cmp		$24, AESKEYLEN
+	jl		128f	// AES-128?
+	je		192f	// AES-192?
+	// Else, it's AES-256.
+	vaesenc		-13*16(%rax), %xmm0, %xmm0
+	vaesenc		-12*16(%rax), %xmm0, %xmm0
+192:
+	vaesenc		-11*16(%rax), %xmm0, %xmm0
+	vaesenc		-10*16(%rax), %xmm0, %xmm0
+128:
+.irp i, 0,1,2,3,4,5,6,7,8,9
+	_ghash_mul_step	\i, H_POW1, GHASH_ACC, GHASH_ACC, GFPOLY, \
+			%xmm1, %xmm2, %xmm3
+	_vaesenc	(\i == 9), (\i-9)*16(%rax), %xmm0
+.endr
+
+	// Undo the byte reflection of the GHASH accumulator, then encrypt it to
+	// produce the full-length authentication tag.
+	vpshufb		BSWAP_MASK, GHASH_ACC, GHASH_ACC
+	vpxor		%xmm0, GHASH_ACC, GHASH_ACC
+
+	// Store or compare the authentication tag.  To support authentication
+	// tags shorter than 16 bytes, use masking.
+.if \enc
+	// Encrypting: store the computed authentication tag.
+	vmovdqu8	GHASH_ACC, (TAG){%k1}
+.else
+	// Decrypting: compare the expected authentication tag (TAG) with the
+	// computed authentication tag GHASH_ACC.  Return a true/false boolean.
+	//
+	// Do this by XOR'ing the tags together and using vptest to check
+	// whether all bits are 0.  This should be constant-time.
+	xor		%eax, %eax
+	vmovdqu8	(TAG), %xmm0{%k1}{z}
+	vmovdqu8	GHASH_ACC, GHASH_ACC{%k1}{z}
+	vpxor		GHASH_ACC, %xmm0, %xmm0
+	vptest		%xmm0, %xmm0
+	sete		%al
+.endif
+	// No need for vzeroupper here, since only used xmm registers were used.
+	RET
+.endm
+
+_set_veclen 32
+SYM_FUNC_START(aes_gcm_precompute_vaes_avx10_256)
+	_aes_gcm_precompute
+SYM_FUNC_END(aes_gcm_precompute_vaes_avx10_256)
+SYM_FUNC_START(aes_gcm_enc_update_vaes_avx10_256)
+	_aes_gcm_update	1
+SYM_FUNC_END(aes_gcm_enc_update_vaes_avx10_256)
+SYM_FUNC_START(aes_gcm_dec_update_vaes_avx10_256)
+	_aes_gcm_update	0
+SYM_FUNC_END(aes_gcm_dec_update_vaes_avx10_256)
+
+_set_veclen 64
+SYM_FUNC_START(aes_gcm_precompute_vaes_avx10_512)
+	_aes_gcm_precompute
+SYM_FUNC_END(aes_gcm_precompute_vaes_avx10_512)
+SYM_FUNC_START(aes_gcm_enc_update_vaes_avx10_512)
+	_aes_gcm_update	1
+SYM_FUNC_END(aes_gcm_enc_update_vaes_avx10_512)
+SYM_FUNC_START(aes_gcm_dec_update_vaes_avx10_512)
+	_aes_gcm_update	0
+SYM_FUNC_END(aes_gcm_dec_update_vaes_avx10_512)
+
+// void aes_gcm_aad_update_vaes_avx10(const struct aes_gcm_key_avx10 *key,
+//				      u8 ghash_acc[16],
+//				      const u8 *aad, int aadlen);
+//
+// This function processes the AAD (Additional Authenticated Data) in GCM.
+// Using the key |key|, it updates the GHASH accumulator |ghash_acc| with the
+// data given by |aad| and |aadlen|.  |key->ghash_key_powers| must have been
+// initialized.  On the first call, |ghash_acc| must be all zeroes.  |aadlen|
+// must be a multiple of 16, except on the last call where it can be any length.
+// The caller must do any buffering needed to ensure this.
+//
+// AES-GCM is almost always used with small amounts of AAD, less than 32 bytes.
+// Therefore, for AAD processing we currently only provide this implementation
+// which uses 256-bit vectors (ymm) registers and only has a 1x-wide loop.  This
+// keeps the code size down, and it enables some micro-optimizations (e.g. using
+// VEX-coded instructions instead of EVEX-coded to save some instruction bytes).
+// To optimize for large amounts of AAD, we could implement a 4x-wide loop and
+// provide a version using 512-bit vectors, but that doesn't seem to be useful.
+SYM_FUNC_START(aes_gcm_aad_update_vaes_avx10)
+
+	// Function arguments
+	.set	KEY,		%rdi
+	.set	GHASH_ACC_PTR,	%rsi
+	.set	AAD,		%rdx
+	.set	AADLEN,		%ecx
+	.set	AADLEN64,	%rcx	// Zero-extend AADLEN before using!
+
+	// Additional local variables.
+	// %rax, %ymm0-%ymm3, and %k1 are used as temporary registers.
+	.set	BSWAP_MASK,	%ymm4
+	.set	GFPOLY,		%ymm5
+	.set	GHASH_ACC,	%ymm6
+	.set	GHASH_ACC_XMM,	%xmm6
+	.set	H_POW1,		%ymm7
+
+	// Load some constants.
+	vbroadcasti128	.Lbswap_mask(%rip), BSWAP_MASK
+	vbroadcasti128	.Lgfpoly(%rip), GFPOLY
+
+	// Load the GHASH accumulator.
+	vmovdqu		(GHASH_ACC_PTR), GHASH_ACC_XMM
+
+	// Update GHASH with 32 bytes of AAD at a time.
+	//
+	// Pre-subtracting 32 from AADLEN saves an instruction from the loop and
+	// also ensures that at least one write always occurs to AADLEN,
+	// zero-extending it and allowing AADLEN64 to be used later.
+	sub		$32, AADLEN
+	jl		.Laad_loop_1x_done
+	vmovdqu8	OFFSETOFEND_KEY_POWERS-32(KEY), H_POW1	// [H^2, H^1]
+.Laad_loop_1x:
+	vmovdqu		(AAD), %ymm0
+	vpshufb		BSWAP_MASK, %ymm0, %ymm0
+	vpxor		%ymm0, GHASH_ACC, GHASH_ACC
+	_ghash_mul	H_POW1, GHASH_ACC, GHASH_ACC, GFPOLY, \
+			%ymm0, %ymm1, %ymm2
+	vextracti128	$1, GHASH_ACC, %xmm0
+	vpxor		%xmm0, GHASH_ACC_XMM, GHASH_ACC_XMM
+	add		$32, AAD
+	sub		$32, AADLEN
+	jge		.Laad_loop_1x
+.Laad_loop_1x_done:
+	add		$32, AADLEN
+	jz		.Laad_done
+
+	// Update GHASH with the remaining 1 <= AADLEN < 32 bytes of AAD.
+	mov		$-1, %eax
+	bzhi		AADLEN, %eax, %eax
+	kmovd		%eax, %k1
+	vmovdqu8	(AAD), %ymm0{%k1}{z}
+	neg		AADLEN64
+	and		$~15, AADLEN64  // -round_up(AADLEN, 16)
+	vmovdqu8	OFFSETOFEND_KEY_POWERS(KEY,AADLEN64), H_POW1
+	vpshufb		BSWAP_MASK, %ymm0, %ymm0
+	vpxor		%ymm0, GHASH_ACC, GHASH_ACC
+	_ghash_mul	H_POW1, GHASH_ACC, GHASH_ACC, GFPOLY, \
+			%ymm0, %ymm1, %ymm2
+	vextracti128	$1, GHASH_ACC, %xmm0
+	vpxor		%xmm0, GHASH_ACC_XMM, GHASH_ACC_XMM
+
+.Laad_done:
+	// Store the updated GHASH accumulator back to memory.
+	vmovdqu		GHASH_ACC_XMM, (GHASH_ACC_PTR)
+
+	vzeroupper	// This is needed after using ymm or zmm registers.
+	RET
+SYM_FUNC_END(aes_gcm_aad_update_vaes_avx10)
+
+SYM_FUNC_START(aes_gcm_enc_final_vaes_avx10)
+	_aes_gcm_final	1
+SYM_FUNC_END(aes_gcm_enc_final_vaes_avx10)
+SYM_FUNC_START(aes_gcm_dec_final_vaes_avx10)
+	_aes_gcm_final	0
+SYM_FUNC_END(aes_gcm_dec_final_vaes_avx10)
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 5b25d2a58aeb..e4dec49023af 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1212,17 +1212,481 @@ static struct simd_skcipher_alg *aes_xts_simdalg_##suffix
 DEFINE_XTS_ALG(aesni_avx, "xts-aes-aesni-avx", 500);
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
 DEFINE_XTS_ALG(vaes_avx2, "xts-aes-vaes-avx2", 600);
 DEFINE_XTS_ALG(vaes_avx10_256, "xts-aes-vaes-avx10_256", 700);
 DEFINE_XTS_ALG(vaes_avx10_512, "xts-aes-vaes-avx10_512", 800);
-#endif
+
+#define NUM_KEY_POWERS		16 /* excludes zero padding */
+#define FULL_NUM_KEY_POWERS	(NUM_KEY_POWERS + 3) /* includes zero padding */
+
+struct aes_gcm_key_avx10 {
+	struct crypto_aes_ctx aes_key AESNI_ALIGN_ATTR;
+	u32 rfc4106_nonce AESNI_ALIGN_ATTR;
+	u8 ghash_key_powers[FULL_NUM_KEY_POWERS][16] AESNI_ALIGN_ATTR;
+};
+
+asmlinkage void
+aes_gcm_precompute_vaes_avx10_256(struct aes_gcm_key_avx10 *key);
+asmlinkage void
+aes_gcm_precompute_vaes_avx10_512(struct aes_gcm_key_avx10 *key);
+
+asmlinkage void
+aes_gcm_aad_update_vaes_avx10(const struct aes_gcm_key_avx10 *key,
+			      u8 ghash_acc[16], const u8 *aad, int aadlen);
+
+asmlinkage void
+aes_gcm_enc_update_vaes_avx10_256(const struct aes_gcm_key_avx10 *key,
+				  const u32 le_ctr[4], u8 ghash_acc[16],
+				  const u8 *src, u8 *dst, int datalen);
+asmlinkage void
+aes_gcm_enc_update_vaes_avx10_512(const struct aes_gcm_key_avx10 *key,
+				  const u32 le_ctr[4], u8 ghash_acc[16],
+				  const u8 *src, u8 *dst, int datalen);
+
+asmlinkage void
+aes_gcm_dec_update_vaes_avx10_256(const struct aes_gcm_key_avx10 *key,
+				  const u32 le_ctr[4], u8 ghash_acc[16],
+				  const u8 *src, u8 *dst, int datalen);
+asmlinkage void
+aes_gcm_dec_update_vaes_avx10_512(const struct aes_gcm_key_avx10 *key,
+				  const u32 le_ctr[4], u8 ghash_acc[16],
+				  const u8 *src, u8 *dst, int datalen);
+
+asmlinkage void
+aes_gcm_enc_final_vaes_avx10(const struct aes_gcm_key_avx10 *key,
+			     const u32 le_ctr[4], const u8 ghash_acc[16],
+			     u64 total_aadlen, u64 total_datalen,
+			     u8 *tag, int taglen);
+asmlinkage bool
+aes_gcm_dec_final_vaes_avx10(const struct aes_gcm_key_avx10 *key,
+			     const u32 le_ctr[4], const u8 ghash_acc[16],
+			     u64 total_aadlen, u64 total_datalen,
+			     const u8 *tag, int taglen);
+
+static int gcm_setkey_vaes_avx10(struct crypto_aead *tfm, const u8 *raw_key,
+				 unsigned int keylen, bool vl256)
+{
+	struct aes_gcm_key_avx10 *key = aes_align_addr(crypto_aead_ctx(tfm));
+	int err;
+
+	/* The assembly code assumes the following offsets. */
+	BUILD_BUG_ON(offsetof(typeof(*key), aes_key.key_enc) != 0);
+	BUILD_BUG_ON(offsetof(typeof(*key), aes_key.key_length) != 480);
+	BUILD_BUG_ON(offsetof(typeof(*key), ghash_key_powers) != 512);
+
+	if (likely(crypto_simd_usable())) {
+		err = aes_check_keylen(keylen);
+		if (err)
+			return err;
+		kernel_fpu_begin();
+		aesni_set_key(&key->aes_key, raw_key, keylen);
+		if (vl256)
+			aes_gcm_precompute_vaes_avx10_256(key);
+		else
+			aes_gcm_precompute_vaes_avx10_512(key);
+		kernel_fpu_end();
+	} else {
+		static const u8 x_to_the_minus1[16] __aligned(__alignof__(be128)) = {
+			[0] = 0xc2, [15] = 1
+		};
+		be128 h1 = {};
+		be128 h;
+		int i;
+
+		err = aes_expandkey(&key->aes_key, raw_key, keylen);
+		if (err)
+			return err;
+		/*
+		 * Emulate the aes_gcm_precompute assembly function in portable
+		 * C code: Encrypt the all-zeroes block to get the hash key H^1,
+		 * zeroize the padding at the end of ghash_key_powers, and store
+		 * H^1 * x^-1 through H^NUM_KEY_POWERS * x^-1, byte-reversed.
+		 */
+		aes_encrypt(&key->aes_key, (u8 *)&h1, (u8 *)&h1);
+		memset(key->ghash_key_powers, 0, sizeof(key->ghash_key_powers));
+		h = h1;
+		gf128mul_lle(&h, (const be128 *)x_to_the_minus1);
+		for (i = NUM_KEY_POWERS - 1; i >= 0; i--) {
+			put_unaligned_be64(h.a, &key->ghash_key_powers[i][8]);
+			put_unaligned_be64(h.b, &key->ghash_key_powers[i][0]);
+			gf128mul_lle(&h, &h1);
+		}
+	}
+	return 0;
+}
+
+static int gcm_setkey_vaes_avx10_256(struct crypto_aead *tfm, const u8 *raw_key,
+				     unsigned int keylen)
+{
+	return gcm_setkey_vaes_avx10(tfm, raw_key, keylen, true);
+}
+
+static int gcm_setkey_vaes_avx10_512(struct crypto_aead *tfm, const u8 *raw_key,
+				     unsigned int keylen)
+{
+	return gcm_setkey_vaes_avx10(tfm, raw_key, keylen, false);
+}
+
+static int rfc4106_setkey_vaes_avx10_256(struct crypto_aead *tfm,
+					 const u8 *raw_key, unsigned int keylen)
+{
+	struct aes_gcm_key_avx10 *key = aes_align_addr(crypto_aead_ctx(tfm));
+
+	if (keylen < 4)
+		return -EINVAL;
+	keylen -= 4;
+	key->rfc4106_nonce = get_unaligned_be32(raw_key + keylen);
+	return gcm_setkey_vaes_avx10(tfm, raw_key, keylen, true);
+}
+
+static int rfc4106_setkey_vaes_avx10_512(struct crypto_aead *tfm,
+					 const u8 *raw_key, unsigned int keylen)
+{
+	struct aes_gcm_key_avx10 *key = aes_align_addr(crypto_aead_ctx(tfm));
+
+	if (keylen < 4)
+		return -EINVAL;
+	keylen -= 4;
+	key->rfc4106_nonce = get_unaligned_be32(raw_key + keylen);
+	return gcm_setkey_vaes_avx10(tfm, raw_key, keylen, false);
+}
+
+#define FLAG_RFC4106	BIT(0)
+#define FLAG_ENC	BIT(1)
+#define FLAG_VL256	BIT(2)
+
+/*
+ * Initialize @ghash_acc, then pass all @assoclen bytes of associated data
+ * (a.k.a. additional authenticated data) from @sg_src through the GHASH update
+ * assembly function.  kernel_fpu_begin() must have already been called.
+ */
+static void gcm_process_assoc_vaes_avx10(const struct aes_gcm_key_avx10 *key,
+					 u8 ghash_acc[16],
+					 struct scatterlist *sg_src,
+					 unsigned int assoclen)
+{
+	struct scatter_walk walk;
+	/*
+	 * The assembly function requires that the length of any non-last
+	 * segment of associated data be a multiple of 16 bytes, so this
+	 * function does the buffering needed to achieve that.
+	 */
+	unsigned int pos = 0;
+	u8 buf[16];
+
+	memset(ghash_acc, 0, 16);
+	scatterwalk_start(&walk, sg_src);
+
+	while (assoclen) {
+		unsigned int len_this_page = scatterwalk_clamp(&walk, assoclen);
+		void *mapped = scatterwalk_map(&walk);
+		const void *src = mapped;
+		unsigned int len;
+
+		assoclen -= len_this_page;
+		scatterwalk_advance(&walk, len_this_page);
+		if (unlikely(pos)) {
+			len = min(len_this_page, 16 - pos);
+			memcpy(&buf[pos], src, len);
+			pos += len;
+			src += len;
+			len_this_page -= len;
+			if (pos < 16)
+				goto next;
+			aes_gcm_aad_update_vaes_avx10(key, ghash_acc, buf, 16);
+			pos = 0;
+		}
+		len = len_this_page;
+		if (unlikely(assoclen)) /* Not the last segment yet? */
+			len = round_down(len, 16);
+		aes_gcm_aad_update_vaes_avx10(key, ghash_acc, src, len);
+		src += len;
+		len_this_page -= len;
+		if (unlikely(len_this_page)) {
+			memcpy(buf, src, len_this_page);
+			pos = len_this_page;
+		}
+next:
+		scatterwalk_unmap(mapped);
+		scatterwalk_pagedone(&walk, 0, assoclen);
+		if (need_resched()) {
+			kernel_fpu_end();
+			kernel_fpu_begin();
+		}
+	}
+	if (unlikely(pos))
+		aes_gcm_aad_update_vaes_avx10(key, ghash_acc, buf, pos);
+}
+
+/* __always_inline to optimize out the branches based on @flags */
+static __always_inline void
+aes_gcm_update_vaes_avx10(const struct aes_gcm_key_avx10 *key,
+			  const u32 le_ctr[4], u8 ghash_acc[16],
+			  const u8 *src, u8 *dst, int datalen, int flags)
+{
+	if (flags & FLAG_ENC) {
+		if (flags & FLAG_VL256)
+			aes_gcm_enc_update_vaes_avx10_256(key, le_ctr,
+							  ghash_acc,
+							  src, dst, datalen);
+		else
+			aes_gcm_enc_update_vaes_avx10_512(key, le_ctr,
+							  ghash_acc,
+							  src, dst, datalen);
+	} else {
+		if (flags & FLAG_VL256)
+			aes_gcm_dec_update_vaes_avx10_256(key, le_ctr,
+							  ghash_acc,
+							  src, dst, datalen);
+		else
+			aes_gcm_dec_update_vaes_avx10_512(key, le_ctr,
+							  ghash_acc,
+							  src, dst, datalen);
+	}
+}
+
+/* __always_inline to optimize out the branches based on @flags */
+static __always_inline int
+gcm_crypt_vaes_avx10(struct aead_request *req, int flags)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	const struct aes_gcm_key_avx10 *key =
+		aes_align_addr(crypto_aead_ctx(tfm));
+	unsigned int assoclen = req->assoclen;
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	u8 ghash_acc[16]; /* GHASH accumulator */
+	u32 le_ctr[4]; /* Counter in little-endian format */
+	int taglen;
+	int err;
+
+	/* Initialize the counter and determine the associated data length. */
+	le_ctr[0] = 2;
+	if (flags & FLAG_RFC4106) {
+		if (unlikely(assoclen != 16 && assoclen != 20))
+			return -EINVAL;
+		assoclen -= 8;
+		le_ctr[1] = get_unaligned_be32(req->iv + 4);
+		le_ctr[2] = get_unaligned_be32(req->iv + 0);
+		le_ctr[3] = key->rfc4106_nonce; /* already byte-swapped */
+	} else {
+		le_ctr[1] = get_unaligned_be32(req->iv + 8);
+		le_ctr[2] = get_unaligned_be32(req->iv + 4);
+		le_ctr[3] = get_unaligned_be32(req->iv + 0);
+	}
+
+	/* Begin walking through the plaintext or ciphertext. */
+	if (flags & FLAG_ENC)
+		err = skcipher_walk_aead_encrypt(&walk, req, false);
+	else
+		err = skcipher_walk_aead_decrypt(&walk, req, false);
+
+	/*
+	 * Since the AES-GCM assembly code requires that at least three assembly
+	 * functions be called to process any message (this is needed to support
+	 * incremental updates cleanly), to reduce overhead we try to do all
+	 * three calls in the same kernel FPU section if possible.  We close the
+	 * section and start a new one if there are multiple data segments or if
+	 * rescheduling is needed while processing the associated data.
+	 */
+	kernel_fpu_begin();
+
+	/* Pass the associated data through GHASH. */
+	gcm_process_assoc_vaes_avx10(key, ghash_acc, req->src, assoclen);
+
+	/* En/decrypt the data and pass the ciphertext through GHASH. */
+	while ((nbytes = walk.nbytes) != 0) {
+		if (unlikely(nbytes < walk.total)) {
+			/*
+			 * Non-last segment.  In this case, the assembly
+			 * function requires that the length be a multiple of 16
+			 * (AES_BLOCK_SIZE) bytes.  The needed buffering of up
+			 * to 16 bytes is handled by the skcipher_walk.  Here we
+			 * just need to round down to a multiple of 16.
+			 */
+			nbytes = round_down(nbytes, AES_BLOCK_SIZE);
+			aes_gcm_update_vaes_avx10(key, le_ctr, ghash_acc,
+						  walk.src.virt.addr,
+						  walk.dst.virt.addr,
+						  nbytes, flags);
+			le_ctr[0] += nbytes / AES_BLOCK_SIZE;
+			kernel_fpu_end();
+			err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+			kernel_fpu_begin();
+		} else {
+			/* Last segment: process all remaining data. */
+			aes_gcm_update_vaes_avx10(key, le_ctr, ghash_acc,
+						  walk.src.virt.addr,
+						  walk.dst.virt.addr,
+						  nbytes, flags);
+			err = skcipher_walk_done(&walk, 0);
+			/*
+			 * The low word of the counter isn't used by the
+			 * finalize, so there's no need to increment it here.
+			 */
+		}
+	}
+	if (err)
+		goto out;
+
+	/* Finalize */
+	taglen = crypto_aead_authsize(tfm);
+	if (flags & FLAG_ENC) {
+		unsigned int datalen = req->cryptlen;
+		u8 tag[16];
+
+		/* Finish computing the auth tag. */
+		aes_gcm_enc_final_vaes_avx10(key, le_ctr, ghash_acc, assoclen,
+					     datalen, tag, taglen);
+
+		/* Store the computed auth tag in the dst scatterlist. */
+		scatterwalk_map_and_copy(tag, req->dst, req->assoclen + datalen,
+					 taglen, 1);
+	} else {
+		unsigned int datalen = req->cryptlen - taglen;
+		u8 tag[16];
+
+		/* Get the transmitted auth tag from the src scatterlist. */
+		scatterwalk_map_and_copy(tag, req->src, req->assoclen + datalen,
+					 taglen, 0);
+		/*
+		 * Finish computing the auth tag and compare it to the
+		 * transmitted one.  The assembly function does the actual tag
+		 * comparison.  Here, just check the boolean result.
+		 */
+		if (!aes_gcm_dec_final_vaes_avx10(key, le_ctr, ghash_acc,
+						  assoclen, datalen,
+						  tag, taglen))
+			err = -EBADMSG;
+	}
+out:
+	kernel_fpu_end();
+	return err;
+}
+
+static int rfc4106_encrypt_vaes_avx10_256(struct aead_request *req)
+{
+	return gcm_crypt_vaes_avx10(req, FLAG_RFC4106|FLAG_ENC|FLAG_VL256);
+}
+
+static int rfc4106_decrypt_vaes_avx10_256(struct aead_request *req)
+{
+	return gcm_crypt_vaes_avx10(req, FLAG_RFC4106|FLAG_VL256);
+}
+
+static int gcm_encrypt_vaes_avx10_256(struct aead_request *req)
+{
+	return gcm_crypt_vaes_avx10(req, FLAG_ENC|FLAG_VL256);
+}
+
+static int gcm_decrypt_vaes_avx10_256(struct aead_request *req)
+{
+	return gcm_crypt_vaes_avx10(req, FLAG_VL256);
+}
+
+static int rfc4106_encrypt_vaes_avx10_512(struct aead_request *req)
+{
+	return gcm_crypt_vaes_avx10(req, FLAG_RFC4106|FLAG_ENC);
+}
+
+static int rfc4106_decrypt_vaes_avx10_512(struct aead_request *req)
+{
+	return gcm_crypt_vaes_avx10(req, FLAG_RFC4106);
+}
+
+static int gcm_encrypt_vaes_avx10_512(struct aead_request *req)
+{
+	return gcm_crypt_vaes_avx10(req, FLAG_ENC);
+}
+
+static int gcm_decrypt_vaes_avx10_512(struct aead_request *req)
+{
+	return gcm_crypt_vaes_avx10(req, 0);
+}
+
+static struct aead_alg aes_gcm_algs_vaes_avx10_256[] = { {
+	.setkey			= rfc4106_setkey_vaes_avx10_256,
+	.setauthsize		= common_rfc4106_set_authsize,
+	.encrypt		= rfc4106_encrypt_vaes_avx10_256,
+	.decrypt		= rfc4106_decrypt_vaes_avx10_256,
+	.ivsize			= GCM_RFC4106_IV_SIZE,
+	.chunksize		= AES_BLOCK_SIZE,
+	.maxauthsize		= 16,
+	.base = {
+		.cra_name		= "__rfc4106(gcm(aes))",
+		.cra_driver_name	= "__rfc4106-gcm-vaes-avx10_256",
+		.cra_priority		= 700,
+		.cra_flags		= CRYPTO_ALG_INTERNAL,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct aes_gcm_key_avx10),
+		.cra_module		= THIS_MODULE,
+	},
+}, {
+	.setkey			= gcm_setkey_vaes_avx10_256,
+	.setauthsize		= generic_gcmaes_set_authsize,
+	.encrypt		= gcm_encrypt_vaes_avx10_256,
+	.decrypt		= gcm_decrypt_vaes_avx10_256,
+	.ivsize			= GCM_AES_IV_SIZE,
+	.chunksize		= AES_BLOCK_SIZE,
+	.maxauthsize		= 16,
+	.base = {
+		.cra_name		= "__gcm(aes)",
+		.cra_driver_name	= "__generic-gcm-vaes-avx10_256",
+		.cra_priority		= 700,
+		.cra_flags		= CRYPTO_ALG_INTERNAL,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct aes_gcm_key_avx10),
+		.cra_module		= THIS_MODULE,
+	},
+} };
+
+static struct aead_alg aes_gcm_algs_vaes_avx10_512[] = { {
+	.setkey			= rfc4106_setkey_vaes_avx10_512,
+	.setauthsize		= common_rfc4106_set_authsize,
+	.encrypt		= rfc4106_encrypt_vaes_avx10_512,
+	.decrypt		= rfc4106_decrypt_vaes_avx10_512,
+	.ivsize			= GCM_RFC4106_IV_SIZE,
+	.chunksize		= AES_BLOCK_SIZE,
+	.maxauthsize		= 16,
+	.base = {
+		.cra_name		= "__rfc4106(gcm(aes))",
+		.cra_driver_name	= "__rfc4106-gcm-vaes-avx10_512",
+		.cra_priority		= 800,
+		.cra_flags		= CRYPTO_ALG_INTERNAL,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct aes_gcm_key_avx10),
+		.cra_module		= THIS_MODULE,
+	},
+}, {
+	.setkey			= gcm_setkey_vaes_avx10_512,
+	.setauthsize		= generic_gcmaes_set_authsize,
+	.encrypt		= gcm_encrypt_vaes_avx10_512,
+	.decrypt		= gcm_decrypt_vaes_avx10_512,
+	.ivsize			= GCM_AES_IV_SIZE,
+	.chunksize		= AES_BLOCK_SIZE,
+	.maxauthsize		= 16,
+	.base = {
+		.cra_name		= "__gcm(aes)",
+		.cra_driver_name	= "__generic-gcm-vaes-avx10_512",
+		.cra_priority		= 800,
+		.cra_flags		= CRYPTO_ALG_INTERNAL,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct aes_gcm_key_avx10),
+		.cra_module		= THIS_MODULE,
+	},
+} };
+
+static struct simd_aead_alg *aes_gcm_simdalgs_vaes_avx10_256[2];
+static struct simd_aead_alg *aes_gcm_simdalgs_vaes_avx10_512[2];
+
+#endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
 
 /*
  * This is a list of CPU models that are known to suffer from downclocking when
- * zmm registers (512-bit vectors) are used.  On these CPUs, the AES-XTS
- * implementation with zmm registers won't be used by default.  An
- * implementation with ymm registers (256-bit vectors) will be used instead.
+ * zmm registers (512-bit vectors) are used.  On these CPUs, the AES mode
+ * implementations with zmm registers won't be used by default.  Implementations
+ * with ymm registers (256-bit vectors) will be used by default instead.
  */
 static const struct x86_cpu_id zmm_exclusion_list[] = {
 	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_SKYLAKE_X },
 	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_X },
 	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_D },
@@ -1234,11 +1698,11 @@ static const struct x86_cpu_id zmm_exclusion_list[] = {
 	/* Allow Rocket Lake and later, and Sapphire Rapids and later. */
 	/* Also allow AMD CPUs (starting with Zen 4, the first with AVX-512). */
 	{},
 };
 
-static int __init register_xts_algs(void)
+static int __init register_avx_algs(void)
 {
 	int err;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX))
 		return 0;
@@ -1267,23 +1731,38 @@ static int __init register_xts_algs(void)
 
 	err = simd_register_skciphers_compat(&aes_xts_alg_vaes_avx10_256, 1,
 					     &aes_xts_simdalg_vaes_avx10_256);
 	if (err)
 		return err;
+	err = simd_register_aeads_compat(aes_gcm_algs_vaes_avx10_256,
+					 ARRAY_SIZE(aes_gcm_algs_vaes_avx10_256),
+					 aes_gcm_simdalgs_vaes_avx10_256);
+	if (err)
+		return err;
+
+	if (x86_match_cpu(zmm_exclusion_list)) {
+		int i;
 
-	if (x86_match_cpu(zmm_exclusion_list))
 		aes_xts_alg_vaes_avx10_512.base.cra_priority = 1;
+		for (i = 0; i < ARRAY_SIZE(aes_gcm_algs_vaes_avx10_512); i++)
+			aes_gcm_algs_vaes_avx10_512[i].base.cra_priority = 1;
+	}
 
 	err = simd_register_skciphers_compat(&aes_xts_alg_vaes_avx10_512, 1,
 					     &aes_xts_simdalg_vaes_avx10_512);
 	if (err)
 		return err;
+	err = simd_register_aeads_compat(aes_gcm_algs_vaes_avx10_512,
+					 ARRAY_SIZE(aes_gcm_algs_vaes_avx10_512),
+					 aes_gcm_simdalgs_vaes_avx10_512);
+	if (err)
+		return err;
 #endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
 	return 0;
 }
 
-static void unregister_xts_algs(void)
+static void unregister_avx_algs(void)
 {
 	if (aes_xts_simdalg_aesni_avx)
 		simd_unregister_skciphers(&aes_xts_alg_aesni_avx, 1,
 					  &aes_xts_simdalg_aesni_avx);
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
@@ -1291,22 +1770,30 @@ static void unregister_xts_algs(void)
 		simd_unregister_skciphers(&aes_xts_alg_vaes_avx2, 1,
 					  &aes_xts_simdalg_vaes_avx2);
 	if (aes_xts_simdalg_vaes_avx10_256)
 		simd_unregister_skciphers(&aes_xts_alg_vaes_avx10_256, 1,
 					  &aes_xts_simdalg_vaes_avx10_256);
+	if (aes_gcm_simdalgs_vaes_avx10_256[0])
+		simd_unregister_aeads(aes_gcm_algs_vaes_avx10_256,
+				      ARRAY_SIZE(aes_gcm_algs_vaes_avx10_256),
+				      aes_gcm_simdalgs_vaes_avx10_256);
 	if (aes_xts_simdalg_vaes_avx10_512)
 		simd_unregister_skciphers(&aes_xts_alg_vaes_avx10_512, 1,
 					  &aes_xts_simdalg_vaes_avx10_512);
+	if (aes_gcm_simdalgs_vaes_avx10_512[0])
+		simd_unregister_aeads(aes_gcm_algs_vaes_avx10_512,
+				      ARRAY_SIZE(aes_gcm_algs_vaes_avx10_512),
+				      aes_gcm_simdalgs_vaes_avx10_512);
 #endif
 }
 #else /* CONFIG_X86_64 */
-static int __init register_xts_algs(void)
+static int __init register_avx_algs(void)
 {
 	return 0;
 }
 
-static void unregister_xts_algs(void)
+static void unregister_avx_algs(void)
 {
 }
 #endif /* !CONFIG_X86_64 */
 
 #ifdef CONFIG_X86_64
@@ -1445,18 +1932,18 @@ static int __init aesni_init(void)
 						     &aesni_simd_xctr);
 	if (err)
 		goto unregister_aeads;
 #endif /* CONFIG_X86_64 */
 
-	err = register_xts_algs();
+	err = register_avx_algs();
 	if (err)
-		goto unregister_xts;
+		goto unregister_avx;
 
 	return 0;
 
-unregister_xts:
-	unregister_xts_algs();
+unregister_avx:
+	unregister_avx_algs();
 #ifdef CONFIG_X86_64
 	if (aesni_simd_xctr)
 		simd_unregister_skciphers(&aesni_xctr, 1, &aesni_simd_xctr);
 unregister_aeads:
 #endif /* CONFIG_X86_64 */
@@ -1480,11 +1967,11 @@ static void __exit aesni_exit(void)
 	crypto_unregister_alg(&aesni_cipher_alg);
 #ifdef CONFIG_X86_64
 	if (boot_cpu_has(X86_FEATURE_AVX))
 		simd_unregister_skciphers(&aesni_xctr, 1, &aesni_simd_xctr);
 #endif /* CONFIG_X86_64 */
-	unregister_xts_algs();
+	unregister_avx_algs();
 }
 
 late_initcall(aesni_init);
 module_exit(aesni_exit);
 

base-commit: 6117af86365916e4202b5a709c155f7e6e5df810
-- 
2.45.0


