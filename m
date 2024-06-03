Return-Path: <linux-kernel+bounces-198458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8262C8D78DB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 00:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4181C20C16
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DF778C87;
	Sun,  2 Jun 2024 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzpDBOEb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931578C6E;
	Sun,  2 Jun 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717367082; cv=none; b=deilgZf3JGbKQ4LTO7yDl+6+Y4beD0w7fPYVbMZlMJ4TTi+Mq1VGM1dWTtYD/MUTmCK/Enpw51XSAezyoVfO1VJbHl6L4PXt3r/iCV4CrZIAzhqp26ctQQaW9DzFPTXkPztPKgEimb8nRlt2UbqJi8ZT+KhPS+xgCuArA1DuctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717367082; c=relaxed/simple;
	bh=YRfPT3U9OwyZur/TCXQgrc5HwaaP+PJ9mXyBGBFPNfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTy0j1N1bqkClGGYZKykwpdqecVmYljLSvZl7OjYwPblQlEvJuXWx7ZsX42olW9DrGEgM6ZFVK8yS6P2iXQ0wBICTEs3gNmeJS3Yi4Q2IXG5FyVi83d5uI34fE5MoyFXCXKzt+iuNKQJbrDBqGcwGfXsHQoZhdZPEigrw0w+MZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzpDBOEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD8DC4AF0A;
	Sun,  2 Jun 2024 22:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717367081;
	bh=YRfPT3U9OwyZur/TCXQgrc5HwaaP+PJ9mXyBGBFPNfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzpDBOEb9nr/l12ibRGkxqFr9COpMg7J7ZR6AfDS8ujxP2LdJiz4Id2YRVquNF9hJ
	 Fm0N0wd63aKxG8jWxXVXGXZ6Wc6fgg0U7xixsWH6jAdZntgquiaf1aQz2zBxgYlel+
	 YcNUvH1NsIcz6CTolT6pPW4SzxXQ4XNQQzn5H3pgX9uLEY7Q5CliCK87zqbpb4BxxX
	 cDBZ1oQpEi+HDJ718qrgZuDvGPpOtCXLEmJCRo08SDtrEjb6uouvKj+RhHbIo9Xyoi
	 qx1W6FwnEn8hWMOUeLoSEjSwmZFaxL/2bUSotXjZzEWI3iDbUZQXAtaicQbk/8X5/O
	 UXNKYnPsdIymQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] crypto: x86/aes-gcm - rewrite the AES-NI optimized AES-GCM
Date: Sun,  2 Jun 2024 15:22:20 -0700
Message-ID: <20240602222221.176625-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240602222221.176625-1-ebiggers@kernel.org>
References: <20240602222221.176625-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Rewrite the AES-NI implementations of AES-GCM, taking advantage of
things I learned while writing the VAES-AVX10 implementations.  This is
a complete rewrite that reduces the AES-NI GCM source code size by about
70% and the binary code size by about 95%, while not regressing
performance and in fact improving it significantly in many cases.

The following summarizes the state before this patch:

- The aesni-intel module registered algorithms "generic-gcm-aesni" and
  "rfc4106-gcm-aesni" with the crypto API that actually delegated to one
  of three underlying implementations according to the CPU capabilities
  detected at runtime: AES-NI, AES-NI + AVX, or AES-NI + AVX2.

- The AES-NI + AVX and AES-NI + AVX2 assembly code was in
  aesni-intel_avx-x86_64.S and consisted of 2804 lines of source and
  257 KB of binary.  This massive binary size was not really
  appropriate, and depending on the kconfig it could take up over 1% the
  size of the entire vmlinux.  The main loops did 8 blocks per
  iteration.  The AVX code minimized the use of carryless multiplication
  whereas the AVX2 code did not.  The "AVX2" code did not actually use
  AVX2; the check for AVX2 was really a check for Intel Haswell or later
  to detect support for fast carryless multiplication.  The long source
  length was caused by factors such as significant code duplication.

- The AES-NI only assembly code was in aesni-intel_asm.S and consisted
  of 1501 lines of source and 15 KB of binary.  The main loops did 4
  blocks per iteration and minimized the use of carryless multiplication
  by using Karatsuba multiplication and a multiplication-less reduction.

- The assembly code was contributed in 2010-2013.  Maintenance has been
  sporadic and most design choices haven't been revisited.

- The assembly function prototypes and the corresponding glue code were
  separate from and were not consistent with the new VAES-AVX10 code I
  recently added.  The older code had several issues such as not
  precomputing the GHASH key powers, which hurt performance.

This rewrite achieves the following goals:

- Much shorter source and binary sizes.  The assembly source shrinks
  from 4300 lines to 1130 lines, and it produces about 9 KB of binary
  instead of 272 KB.  This is achieved via a better designed AES-GCM
  implementation that doesn't excessively unroll the code and instead
  prioritizes the parts that really matter.  Sharing the C glue code
  with the VAES-AVX10 implementations also saves 250 lines of C source.

- Improve performance on most (possibly all) CPUs on which this code
  runs, for most (possibly all) message lengths.  Benchmark results are
  given in Tables 1 and 2 below.

- Use the same function prototypes and glue code as the new VAES-AVX10
  algorithms.  This fixes some issues with the integration of the
  assembly and results in some significant performance improvements,
  primarily on short messages.  Also, the AVX and non-AVX
  implementations are now registered as separate algorithms with the
  crypto API, which makes them both testable by the self-tests.

- Keep support for AES-NI without AVX (for Westmere, Silvermont,
  Goldmont, and Tremont), but unify the source code with AES-NI + AVX.
  Since 256-bit vectors cannot be used without VAES anyway, this is made
  feasible by just using the non-VEX coded form of most instructions.

- Use a unified approach where the main loop does 8 blocks per iteration
  and uses Karatsuba multiplication to save one pclmulqdq per block but
  does not use the multiplication-less reduction.  This strikes a good
  balance across the range of CPUs on which this code runs.

- Don't spam the kernel log with an informational message on every boot.

The following tables summarize the improvement in AES-GCM throughput on
various CPU microarchitectures as a result of this patch:

Table 1: AES-256-GCM encryption throughput improvement,
         CPU microarchitecture vs. message length in bytes:

                   | 16384 |  4096 |  4095 |  1420 |   512 |   500 |
-------------------+-------+-------+-------+-------+-------+-------+
Intel Broadwell    |    2% |    8% |   11% |   18% |   31% |   26% |
Intel Skylake      |    1% |    4% |    7% |   12% |   26% |   19% |
Intel Cascade Lake |    3% |    8% |   10% |   18% |   33% |   24% |
AMD Zen 1          |    6% |   12% |    6% |   15% |   27% |   24% |
AMD Zen 2          |    8% |   13% |   13% |   19% |   26% |   28% |
AMD Zen 3          |    8% |   14% |   13% |   19% |   26% |   25% |

                   |   300 |   200 |    64 |    63 |    16 |
-------------------+-------+-------+-------+-------+-------+
Intel Broadwell    |   35% |   29% |   45% |   55% |   54% |
Intel Skylake      |   25% |   19% |   28% |   33% |   27% |
Intel Cascade Lake |   36% |   28% |   39% |   49% |   54% |
AMD Zen 1          |   27% |   22% |   23% |   29% |   26% |
AMD Zen 2          |   32% |   24% |   22% |   25% |   31% |
AMD Zen 3          |   30% |   24% |   22% |   23% |   26% |

Table 2: AES-256-GCM decryption throughput improvement,
         CPU microarchitecture vs. message length in bytes:

                   | 16384 |  4096 |  4095 |  1420 |   512 |   500 |
-------------------+-------+-------+-------+-------+-------+-------+
Intel Broadwell    |    3% |    8% |   11% |   19% |   32% |   28% |
Intel Skylake      |    3% |    4% |    7% |   13% |   28% |   27% |
Intel Cascade Lake |    3% |    9% |   11% |   19% |   33% |   28% |
AMD Zen 1          |   15% |   18% |   14% |   20% |   36% |   33% |
AMD Zen 2          |    9% |   16% |   13% |   21% |   26% |   27% |
AMD Zen 3          |    8% |   15% |   12% |   18% |   23% |   23% |

                   |   300 |   200 |    64 |    63 |    16 |
-------------------+-------+-------+-------+-------+-------+
Intel Broadwell    |   36% |   31% |   40% |   51% |   53% |
Intel Skylake      |   28% |   21% |   23% |   30% |   30% |
Intel Cascade Lake |   36% |   29% |   36% |   47% |   53% |
AMD Zen 1          |   35% |   31% |   32% |   35% |   36% |
AMD Zen 2          |   31% |   30% |   27% |   38% |   30% |
AMD Zen 3          |   27% |   23% |   24% |   32% |   26% |

The above numbers are percentage improvements in single-thread
throughput, so e.g. an increase from 3000 MB/s to 3300 MB/s would be
listed as 10%.  They were collected by directly measuring the Linux
crypto API performance using a custom kernel module.  Note that indirect
benchmarks (e.g. 'cryptsetup benchmark' or benchmarking dm-crypt I/O)
include more overhead and won't see quite as much of a difference.  All
these benchmarks used an associated data length of 16 bytes.  Note that
AES-GCM is almost always used with short associated data lengths.

I didn't test Intel CPUs before Broadwell, AMD CPUs before Zen 1, or
Intel low-power CPUs, as these weren't readily available to me.
However, based on the design of the new code and the available
information about these other CPU microarchitectures, I wouldn't expect
any significant regressions, and there's a good chance performance is
improved just as it is above.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/Makefile                 |    5 +-
 arch/x86/crypto/aes-gcm-aesni-x86_64.S   | 1128 +++++++++
 arch/x86/crypto/aesni-intel_asm.S        | 1503 +-----------
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 2804 ----------------------
 arch/x86/crypto/aesni-intel_glue.c       |  768 ++----
 5 files changed, 1390 insertions(+), 4818 deletions(-)
 create mode 100644 arch/x86/crypto/aes-gcm-aesni-x86_64.S
 delete mode 100644 arch/x86/crypto/aesni-intel_avx-x86_64.S

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index a2a536b690fa..53b4a277809e 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -46,12 +46,13 @@ obj-$(CONFIG_CRYPTO_CHACHA20_X86_64) += chacha-x86_64.o
 chacha-x86_64-y := chacha-avx2-x86_64.o chacha-ssse3-x86_64.o chacha_glue.o
 chacha-x86_64-$(CONFIG_AS_AVX512) += chacha-avx512vl-x86_64.o
 
 obj-$(CONFIG_CRYPTO_AES_NI_INTEL) += aesni-intel.o
 aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o
-aesni-intel-$(CONFIG_64BIT) += aesni-intel_avx-x86_64.o \
-	aes_ctrby8_avx-x86_64.o aes-xts-avx-x86_64.o
+aesni-intel-$(CONFIG_64BIT) += aes_ctrby8_avx-x86_64.o \
+			       aes-gcm-aesni-x86_64.o \
+			       aes-xts-avx-x86_64.o
 ifeq ($(CONFIG_AS_VAES)$(CONFIG_AS_VPCLMULQDQ),yy)
 aesni-intel-$(CONFIG_64BIT) += aes-gcm-avx10-x86_64.o
 endif
 
 obj-$(CONFIG_CRYPTO_SHA1_SSSE3) += sha1-ssse3.o
diff --git a/arch/x86/crypto/aes-gcm-aesni-x86_64.S b/arch/x86/crypto/aes-gcm-aesni-x86_64.S
new file mode 100644
index 000000000000..45940e2883a0
--- /dev/null
+++ b/arch/x86/crypto/aes-gcm-aesni-x86_64.S
@@ -0,0 +1,1128 @@
+/* SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause */
+//
+// AES-NI optimized AES-GCM for x86_64
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
+// support the original set of AES instructions, i.e. AES-NI.  Two
+// implementations are provided, one that uses AVX and one that doesn't.  They
+// are very similar, being generated by the same macros.  The only difference is
+// that the AVX implementation takes advantage of VEX-coded instructions in some
+// places to avoid some 'movdqu' and 'movdqa' instructions.  The AVX
+// implementation does *not* use 256-bit vectors, as AES is not supported on
+// 256-bit vectors until the VAES feature (which this file doesn't target).
+//
+// The specific CPU feature prerequisites are AES-NI and PCLMULQDQ, plus SSE4.1
+// for the *_aesni functions or AVX for the *_aesni_avx ones.  (But it seems
+// there are no CPUs that support AES-NI without also PCLMULQDQ and SSE4.1.)
+//
+// The design generally follows that of aes-gcm-avx10-x86_64.S, and that file is
+// more thoroughly commented.  This file has the following notable changes:
+//
+//    - The vector length is fixed at 128-bit, i.e. xmm registers.  This means
+//      there is only one AES block (and GHASH block) per register.
+//
+//    - Without AVX512 / AVX10, only 16 SIMD registers are available instead of
+//      32.  We work around this by being much more careful about using
+//      registers, relying heavily on loads to load values as they are needed.
+//
+//    - Masking is not available either.  We work around this by implementing
+//      partial block loads and stores using overlapping scalar loads and stores
+//      combined with shifts and SSE4.1 insertion and extraction instructions.
+//
+//    - The main loop is organized differently due to the different design
+//      constraints.  First, with just one AES block per SIMD register, on some
+//      CPUs 4 registers don't saturate the 'aesenc' throughput.  We therefore
+//      do an 8-register wide loop.  Considering that and the fact that we have
+//      just 16 SIMD registers to work with, it's not feasible to cache AES
+//      round keys and GHASH key powers in registers across loop iterations.
+//      That's not ideal, but also not actually that bad, since loads can run in
+//      parallel with other instructions.  Significantly, this also makes it
+//      possible to roll up the inner loops, relying on hardware loop unrolling
+//      instead of software loop unrolling, greatly reducing code size.
+//
+//    - We implement the GHASH multiplications in the main loop using Karatsuba
+//      multiplication instead of schoolbook multiplication.  This saves one
+//      pclmulqdq instruction per block, at the cost of one 64-bit load, one
+//      pshufd, and 0.25 pxors per block.  (This is without the three-argument
+//      XOR support that would be provided by AVX512 / AVX10, which would be
+//      more beneficial to schoolbook than Karatsuba.)
+//
+//      As a rough approximation, we can assume that Karatsuba multiplication is
+//      faster than schoolbook multiplication in this context if one pshufd and
+//      0.25 pxors are cheaper than a pclmulqdq.  (We assume that the 64-bit
+//      load is "free" due to running in parallel with arithmetic instructions.)
+//      This is true on AMD CPUs, including all that support pclmulqdq up to at
+//      least Zen 3.  It's also true on older Intel CPUs: Westmere through
+//      Haswell on the Core side, and Silvermont through Goldmont Plus on the
+//      low-power side.  On some of these CPUs, pclmulqdq is quite slow, and the
+//      benefit of Karatsuba should be substantial.  On newer Intel CPUs,
+//      schoolbook multiplication should be faster, but only marginally.
+//
+//      Not all these CPUs were available to be tested.  However, benchmarks on
+//      available CPUs suggest that this approximation is plausible.  Switching
+//      to Karatsuba showed negligible change (< 1%) on Intel Broadwell,
+//      Skylake, and Cascade Lake, but it improved AMD Zen 1-3 by 6-7%.
+//      Considering that and the fact that Karatsuba should be even more
+//      beneficial on older Intel CPUs, it seems like the right choice here.
+//
+//      An additional 0.25 pclmulqdq per block (2 per 8 blocks) could be
+//      saved by using a multiplication-less reduction method.  We don't do that
+//      because it would require a large number of shift and xor instructions,
+//      making it less worthwhile and likely harmful on newer CPUs.
+//
+//      It does make sense to sometimes use a different reduction optimization
+//      that saves a pclmulqdq, though: precompute the hash key times x^64, and
+//      multiply the low half of the data block by the hash key with the extra
+//      factor of x^64.  This eliminates one step of the reduction.  However,
+//      this is incompatible with Karatsuba multiplication.  Therefore, for
+//      multi-block processing we use Karatsuba multiplication with a regular
+//      reduction.  For single-block processing, we use the x^64 optimization.
+
+#include <linux/linkage.h>
+
+.section .rodata
+.p2align 4
+.Lbswap_mask:
+	.octa   0x000102030405060708090a0b0c0d0e0f
+.Lgfpoly:
+	.quad	0xc200000000000000
+.Lone:
+	.quad	1
+.Lgfpoly_and_internal_carrybit:
+	.octa	0xc2000000000000010000000000000001
+	// Loading 16 bytes from '.Lzeropad_mask + 16 - len' produces a mask of
+	// 'len' 0xff bytes and the rest zeroes.
+.Lzeropad_mask:
+	.octa	0xffffffffffffffffffffffffffffffff
+	.octa	0
+
+// Offsets in struct aes_gcm_key_aesni
+#define OFFSETOF_AESKEYLEN	480
+#define OFFSETOF_H_POWERS	496
+#define OFFSETOF_H_POWERS_XORED	624
+#define OFFSETOF_H_TIMES_X64	688
+
+.text
+
+// Do a vpclmulqdq, or fall back to a movdqa and a pclmulqdq.  The fallback
+// assumes that all operands are distinct and that any mem operand is aligned.
+.macro	_vpclmulqdq	imm, src1, src2, dst
+.if USE_AVX
+	vpclmulqdq	\imm, \src1, \src2, \dst
+.else
+	movdqa		\src2, \dst
+	pclmulqdq	\imm, \src1, \dst
+.endif
+.endm
+
+// Do a vpshufb, or fall back to a movdqa and a pshufb.  The fallback assumes
+// that all operands are distinct and that any mem operand is aligned.
+.macro	_vpshufb	src1, src2, dst
+.if USE_AVX
+	vpshufb		\src1, \src2, \dst
+.else
+	movdqa		\src2, \dst
+	pshufb		\src1, \dst
+.endif
+.endm
+
+// Do a vpand, or fall back to a movdqu and a pand.  The fallback assumes that
+// all operands are distinct.
+.macro	_vpand		src1, src2, dst
+.if USE_AVX
+	vpand		\src1, \src2, \dst
+.else
+	movdqu		\src1, \dst
+	pand		\src2, \dst
+.endif
+.endm
+
+// XOR the unaligned memory operand \mem into the xmm register \reg.  \tmp must
+// be a temporary xmm register.
+.macro	_xor_mem_to_reg	mem, reg, tmp
+.if USE_AVX
+	vpxor		\mem, \reg, \reg
+.else
+	movdqu		\mem, \tmp
+	pxor		\tmp, \reg
+.endif
+.endm
+
+// Test the unaligned memory operand \mem against the xmm register \reg.  \tmp
+// must be a temporary xmm register.
+.macro	_test_mem	mem, reg, tmp
+.if USE_AVX
+	vptest		\mem, \reg
+.else
+	movdqu		\mem, \tmp
+	ptest		\tmp, \reg
+.endif
+.endm
+
+// Load 1 <= %ecx <= 15 bytes from the pointer \src into the xmm register \dst
+// and zeroize any remaining bytes.  Clobbers %rax, %rcx, and \tmp{64,32}.
+.macro	_load_partial_block	src, dst, tmp64, tmp32
+	sub		$8, %ecx		// LEN - 8
+	jle		.Lle8\@
+
+	// Load 9 <= LEN <= 15 bytes.
+	movq		(\src), \dst		// Load first 8 bytes
+	mov		(\src, %rcx), %rax	// Load last 8 bytes
+	neg		%ecx
+	shl		$3, %ecx
+	shr		%cl, %rax		// Discard overlapping bytes
+	pinsrq		$1, %rax, \dst
+	jmp		.Ldone\@
+
+.Lle8\@:
+	add		$4, %ecx		// LEN - 4
+	jl		.Llt4\@
+
+	// Load 4 <= LEN <= 8 bytes.
+	mov		(\src), %eax		// Load first 4 bytes
+	mov		(\src, %rcx), \tmp32	// Load last 4 bytes
+	jmp		.Lcombine\@
+
+.Llt4\@:
+	// Load 1 <= LEN <= 3 bytes.
+	add		$2, %ecx		// LEN - 2
+	movzbl		(\src), %eax		// Load first byte
+	jl		.Lmovq\@
+	movzwl		(\src, %rcx), \tmp32	// Load last 2 bytes
+.Lcombine\@:
+	shl		$3, %ecx
+	shl		%cl, \tmp64
+	or		\tmp64, %rax		// Combine the two parts
+.Lmovq\@:
+	movq		%rax, \dst
+.Ldone\@:
+.endm
+
+// Store 1 <= %ecx <= 15 bytes from the xmm register \src to the pointer \dst.
+// Clobbers %rax, %rcx, and %rsi.
+.macro	_store_partial_block	src, dst
+	sub		$8, %ecx		// LEN - 8
+	jl		.Llt8\@
+
+	// Store 8 <= LEN <= 15 bytes.
+	pextrq		$1, \src, %rax
+	mov		%ecx, %esi
+	shl		$3, %ecx
+	ror		%cl, %rax
+	mov		%rax, (\dst, %rsi)	// Store last LEN - 8 bytes
+	movq		\src, (\dst)		// Store first 8 bytes
+	jmp		.Ldone\@
+
+.Llt8\@:
+	add		$4, %ecx		// LEN - 4
+	jl		.Llt4\@
+
+	// Store 4 <= LEN <= 7 bytes.
+	pextrd		$1, \src, %eax
+	mov		%ecx, %esi
+	shl		$3, %ecx
+	ror		%cl, %eax
+	mov		%eax, (\dst, %rsi)	// Store last LEN - 4 bytes
+	movd		\src, (\dst)		// Store first 4 bytes
+	jmp		.Ldone\@
+
+.Llt4\@:
+	// Store 1 <= LEN <= 3 bytes.
+	pextrb		$0, \src, 0(\dst)
+	cmp		$-2, %ecx		// LEN - 4 == -2, i.e. LEN == 2?
+	jl		.Ldone\@
+	pextrb		$1, \src, 1(\dst)
+	je		.Ldone\@
+	pextrb		$2, \src, 2(\dst)
+.Ldone\@:
+.endm
+
+// Do one step of GHASH-multiplying \a by \b and storing the reduced product in
+// \b.  To complete all steps, this must be invoked with \i=0 through \i=9.
+// \a_times_x64 must contain \a * x^64 in reduced form, \gfpoly must contain the
+// .Lgfpoly constant, and \t0-\t1 must be temporary registers.
+.macro	_ghash_mul_step	i, a, a_times_x64, b, gfpoly, t0, t1
+
+	// MI = (a_L * b_H) + ((a*x^64)_L * b_L)
+.if \i == 0
+	_vpclmulqdq	$0x01, \a, \b, \t0
+.elseif \i == 1
+	_vpclmulqdq	$0x00, \a_times_x64, \b, \t1
+.elseif \i == 2
+	pxor		\t1, \t0
+
+	// HI = (a_H * b_H) + ((a*x^64)_H * b_L)
+.elseif \i == 3
+	_vpclmulqdq	$0x11, \a, \b, \t1
+.elseif \i == 4
+	pclmulqdq	$0x10, \a_times_x64, \b
+.elseif \i == 5
+	pxor		\t1, \b
+.elseif \i == 6
+
+	// Fold MI into HI.
+	pshufd		$0x4e, \t0, \t1		// Swap halves of MI
+.elseif \i == 7
+	pclmulqdq	$0x00, \gfpoly, \t0	// MI_L*(x^63 + x^62 + x^57)
+.elseif \i == 8
+	pxor		\t1, \b
+.elseif \i == 9
+	pxor		\t0, \b
+.endif
+.endm
+
+// GHASH-multiply \a by \b and store the reduced product in \b.
+// See _ghash_mul_step for details.
+.macro	_ghash_mul	a, a_times_x64, b, gfpoly, t0, t1
+.irp i, 0,1,2,3,4,5,6,7,8,9
+	_ghash_mul_step	\i, \a, \a_times_x64, \b, \gfpoly, \t0, \t1
+.endr
+.endm
+
+// GHASH-multiply \a by \b and add the unreduced product to \lo, \mi, and \hi.
+// This does Karatsuba multiplication and must be paired with _ghash_reduce.  On
+// the first call, \lo, \mi, and \hi must be zero.  \a_xored must contain the
+// two halves of \a XOR'd together, i.e. a_L + a_H.  \b is clobbered.
+.macro	_ghash_mul_noreduce	a, a_xored, b, lo, mi, hi, t0
+
+	// LO += a_L * b_L
+	_vpclmulqdq	$0x00, \a, \b, \t0
+	pxor		\t0, \lo
+
+	// b_L + b_H
+	pshufd		$0x4e, \b, \t0
+	pxor		\b, \t0
+
+	// HI += a_H * b_H
+	pclmulqdq	$0x11, \a, \b
+	pxor		\b, \hi
+
+	// MI += (a_L + a_H) * (b_L + b_H)
+	pclmulqdq	$0x00, \a_xored, \t0
+	pxor		\t0, \mi
+.endm
+
+// Reduce the product from \lo, \mi, and \hi, and store the result in \dst.
+// This assumes that _ghash_mul_noreduce was used.
+.macro	_ghash_reduce	lo, mi, hi, dst, t0
+
+	movq		.Lgfpoly(%rip), \t0
+
+	// MI += LO + HI (needed because we used Karatsuba multiplication)
+	pxor		\lo, \mi
+	pxor		\hi, \mi
+
+	// Fold LO into MI.
+	pshufd		$0x4e, \lo, \dst
+	pclmulqdq	$0x00, \t0, \lo
+	pxor		\dst, \mi
+	pxor		\lo, \mi
+
+	// Fold MI into HI.
+	pshufd		$0x4e, \mi, \dst
+	pclmulqdq	$0x00, \t0, \mi
+	pxor		\hi, \dst
+	pxor		\mi, \dst
+.endm
+
+// Do the first step of the GHASH update of a set of 8 ciphertext blocks.
+//
+// The whole GHASH update does:
+//
+//	GHASH_ACC = (blk0+GHASH_ACC)*H^8 + blk1*H^7 + blk2*H^6 + blk3*H^5 +
+//				blk4*H^4 + blk5*H^3 + blk6*H^2 + blk7*H^1
+//
+// This macro just does the first step: it does the unreduced multiplication
+// (blk0+GHASH_ACC)*H^8 and starts gathering the unreduced product in the xmm
+// registers LO, MI, and GHASH_ACC a.k.a. HI.  It also zero-initializes the
+// inner block counter in %rax, which is a value that counts up by 8 for each
+// block in the set of 8 and is used later to index by 8*blknum and 16*blknum.
+//
+// To reduce the number of pclmulqdq instructions required, both this macro and
+// _ghash_update_continue_8x use Karatsuba multiplication instead of schoolbook
+// multiplication.  See the file comment for more details about this choice.
+//
+// Both macros expect the ciphertext blocks blk[0-7] to be available at DST if
+// encrypting, or SRC if decrypting.  They also expect the precomputed hash key
+// powers H^i and their XOR'd-together halves to be available in the struct
+// pointed to by KEY.  Both macros clobber TMP[0-2].
+.macro	_ghash_update_begin_8x	enc
+
+	// Initialize the inner block counter.
+	xor		%eax, %eax
+
+	// Load the highest hash key power, H^8.
+	movdqa		OFFSETOF_H_POWERS(KEY), TMP0
+
+	// Load the first ciphertext block and byte-reflect it.
+.if \enc
+	movdqu		(DST), TMP1
+.else
+	movdqu		(SRC), TMP1
+.endif
+	pshufb		BSWAP_MASK, TMP1
+
+	// Add the GHASH accumulator to the ciphertext block to get the block
+	// 'b' that needs to be multiplied with the hash key power 'a'.
+	pxor		TMP1, GHASH_ACC
+
+	// b_L + b_H
+	pshufd		$0x4e, GHASH_ACC, MI
+	pxor		GHASH_ACC, MI
+
+	// LO = a_L * b_L
+	_vpclmulqdq	$0x00, TMP0, GHASH_ACC, LO
+
+	// HI = a_H * b_H
+	pclmulqdq	$0x11, TMP0, GHASH_ACC
+
+	// MI = (a_L + a_H) * (b_L + b_H)
+	pclmulqdq	$0x00, OFFSETOF_H_POWERS_XORED(KEY), MI
+.endm
+
+// Continue the GHASH update of 8 ciphertext blocks as described above by doing
+// an unreduced multiplication of the next ciphertext block by the next lowest
+// key power and accumulating the result into LO, MI, and GHASH_ACC a.k.a. HI.
+.macro	_ghash_update_continue_8x enc
+	add		$8, %eax
+
+	// Load the next lowest key power.
+	movdqa		OFFSETOF_H_POWERS(KEY,%rax,2), TMP0
+
+	// Load the next ciphertext block and byte-reflect it.
+.if \enc
+	movdqu		(DST,%rax,2), TMP1
+.else
+	movdqu		(SRC,%rax,2), TMP1
+.endif
+	pshufb		BSWAP_MASK, TMP1
+
+	// LO += a_L * b_L
+	_vpclmulqdq	$0x00, TMP0, TMP1, TMP2
+	pxor		TMP2, LO
+
+	// b_L + b_H
+	pshufd		$0x4e, TMP1, TMP2
+	pxor		TMP1, TMP2
+
+	// HI += a_H * b_H
+	pclmulqdq	$0x11, TMP0, TMP1
+	pxor		TMP1, GHASH_ACC
+
+	// MI += (a_L + a_H) * (b_L + b_H)
+	movq		OFFSETOF_H_POWERS_XORED(KEY,%rax), TMP1
+	pclmulqdq	$0x00, TMP1, TMP2
+	pxor		TMP2, MI
+.endm
+
+// Reduce LO, MI, and GHASH_ACC a.k.a. HI into GHASH_ACC.  This is similar to
+// _ghash_reduce, but it's hardcoded to use the registers of the main loop and
+// it uses the same register for HI and the destination.  It's also divided into
+// two steps.  TMP1 must be preserved across steps.
+//
+// One pshufd could be saved by shuffling MI and XOR'ing LO into it, instead of
+// shuffling LO, XOR'ing LO into MI, and shuffling MI.  However, this would
+// increase the critical path length, and it seems to slightly hurt performance.
+.macro	_ghash_update_end_8x_step	i
+.if \i == 0
+	movq		.Lgfpoly(%rip), TMP1
+	pxor		LO, MI
+	pxor		GHASH_ACC, MI
+	pshufd		$0x4e, LO, TMP2
+	pclmulqdq	$0x00, TMP1, LO
+	pxor		TMP2, MI
+	pxor		LO, MI
+.elseif \i == 1
+	pshufd		$0x4e, MI, TMP2
+	pclmulqdq	$0x00, TMP1, MI
+	pxor		TMP2, GHASH_ACC
+	pxor		MI, GHASH_ACC
+.endif
+.endm
+
+// void aes_gcm_precompute_##suffix(struct aes_gcm_key_aesni *key);
+//
+// Given the expanded AES key, derive the GHASH subkey and initialize the GHASH
+// related fields in the key struct.
+.macro	_aes_gcm_precompute
+
+	// Function arguments
+	.set	KEY,		%rdi
+
+	// Additional local variables.
+	// %xmm0-%xmm1 and %rax are used as temporaries.
+	.set	RNDKEYLAST_PTR,	%rsi
+	.set	H_CUR,		%xmm2
+	.set	H_POW1,		%xmm3	// H^1
+	.set	H_POW1_X64,	%xmm4	// H^1 * x^64
+	.set	GFPOLY,		%xmm5
+
+	// Encrypt an all-zeroes block to get the raw hash subkey.
+	movl		OFFSETOF_AESKEYLEN(KEY), %eax
+	lea		6*16(KEY,%rax,4), RNDKEYLAST_PTR
+	movdqa		(KEY), H_POW1  // Zero-th round key XOR all-zeroes block
+	lea		16(KEY), %rax
+1:
+	aesenc		(%rax), H_POW1
+	add		$16, %rax
+	cmp		%rax, RNDKEYLAST_PTR
+	jne		1b
+	aesenclast	(RNDKEYLAST_PTR), H_POW1
+
+	// Preprocess the raw hash subkey as needed to operate on GHASH's
+	// bit-reflected values directly: reflect its bytes, then multiply it by
+	// x^-1 (using the backwards interpretation of polynomial coefficients
+	// from the GCM spec) or equivalently x^1 (using the alternative,
+	// natural interpretation of polynomial coefficients).
+	pshufb		.Lbswap_mask(%rip), H_POW1
+	movdqa		H_POW1, %xmm0
+	pshufd		$0xd3, %xmm0, %xmm0
+	psrad		$31, %xmm0
+	paddq		H_POW1, H_POW1
+	pand		.Lgfpoly_and_internal_carrybit(%rip), %xmm0
+	pxor		%xmm0, H_POW1
+
+	// Store H^1.
+	movdqa		H_POW1, OFFSETOF_H_POWERS+7*16(KEY)
+
+	// Compute and store H^1 * x^64.
+	movq		.Lgfpoly(%rip), GFPOLY
+	pshufd		$0x4e, H_POW1, %xmm0
+	_vpclmulqdq	$0x00, H_POW1, GFPOLY, H_POW1_X64
+	pxor		%xmm0, H_POW1_X64
+	movdqa		H_POW1_X64, OFFSETOF_H_TIMES_X64(KEY)
+
+	// Compute and store the halves of H^1 XOR'd together.
+	pxor		H_POW1, %xmm0
+	movq		%xmm0, OFFSETOF_H_POWERS_XORED+7*8(KEY)
+
+	// Compute and store the remaining key powers H^2 through H^8.
+	movdqa		H_POW1, H_CUR
+	mov		$6*8, %eax
+.Lprecompute_next\@:
+	// Compute H^i = H^{i-1} * H^1.
+	_ghash_mul	H_POW1, H_POW1_X64, H_CUR, GFPOLY, %xmm0, %xmm1
+	// Store H^i.
+	movdqa		H_CUR, OFFSETOF_H_POWERS(KEY,%rax,2)
+	// Compute and store the halves of H^i XOR'd together.
+	pshufd		$0x4e, H_CUR, %xmm0
+	pxor		H_CUR, %xmm0
+	movq		%xmm0, OFFSETOF_H_POWERS_XORED(KEY,%rax)
+	sub		$8, %eax
+	jge		.Lprecompute_next\@
+
+	RET
+.endm
+
+// void aes_gcm_aad_update_aesni(const struct aes_gcm_key_aesni *key,
+//				 u8 ghash_acc[16], const u8 *aad, int aadlen);
+//
+// This function processes the AAD (Additional Authenticated Data) in GCM.
+// Using the key |key|, it updates the GHASH accumulator |ghash_acc| with the
+// data given by |aad| and |aadlen|.  On the first call, |ghash_acc| must be all
+// zeroes.  |aadlen| must be a multiple of 16, except on the last call where it
+// can be any length.  The caller must do any buffering needed to ensure this.
+.macro	_aes_gcm_aad_update
+
+	// Function arguments
+	.set	KEY,		%rdi
+	.set	GHASH_ACC_PTR,	%rsi
+	.set	AAD,		%rdx
+	.set	AADLEN,		%ecx
+	// Note: _load_partial_block relies on AADLEN being in %ecx.
+
+	// Additional local variables.
+	// %rax, %r10, and %xmm0-%xmm1 are used as temporary registers.
+	.set	BSWAP_MASK,	%xmm2
+	.set	GHASH_ACC,	%xmm3
+	.set	H_POW1,		%xmm4	// H^1
+	.set	H_POW1_X64,	%xmm5	// H^1 * x^64
+	.set	GFPOLY,		%xmm6
+
+	movdqa		.Lbswap_mask(%rip), BSWAP_MASK
+	movdqu		(GHASH_ACC_PTR), GHASH_ACC
+	movdqa		OFFSETOF_H_POWERS+7*16(KEY), H_POW1
+	movdqa		OFFSETOF_H_TIMES_X64(KEY), H_POW1_X64
+	movq		.Lgfpoly(%rip), GFPOLY
+
+	// Process the AAD one full block at a time.
+	sub		$16, AADLEN
+	jl		.Laad_loop_1x_done\@
+.Laad_loop_1x\@:
+	movdqu		(AAD), %xmm0
+	pshufb		BSWAP_MASK, %xmm0
+	pxor		%xmm0, GHASH_ACC
+	_ghash_mul	H_POW1, H_POW1_X64, GHASH_ACC, GFPOLY, %xmm0, %xmm1
+	add		$16, AAD
+	sub		$16, AADLEN
+	jge		.Laad_loop_1x\@
+.Laad_loop_1x_done\@:
+	// Check whether there is a partial block at the end.
+	add		$16, AADLEN
+	jz		.Laad_done\@
+
+	// Process a partial block of length 1 <= AADLEN <= 15.
+	// _load_partial_block assumes that %ecx contains AADLEN.
+	_load_partial_block	AAD, %xmm0, %r10, %r10d
+	pshufb		BSWAP_MASK, %xmm0
+	pxor		%xmm0, GHASH_ACC
+	_ghash_mul	H_POW1, H_POW1_X64, GHASH_ACC, GFPOLY, %xmm0, %xmm1
+
+.Laad_done\@:
+	movdqu		GHASH_ACC, (GHASH_ACC_PTR)
+	RET
+.endm
+
+// Increment LE_CTR eight times to generate eight little-endian counter blocks,
+// swap each to big-endian, and store them in AESDATA[0-7].  Also XOR them with
+// the zero-th AES round key.  Clobbers TMP0 and TMP1.
+.macro	_ctr_begin_8x
+	movq		.Lone(%rip), TMP0
+	movdqa		(KEY), TMP1		// zero-th round key
+.irp i, 0,1,2,3,4,5,6,7
+	_vpshufb	BSWAP_MASK, LE_CTR, AESDATA\i
+	pxor		TMP1, AESDATA\i
+	paddd		TMP0, LE_CTR
+.endr
+.endm
+
+// Do a non-last round of AES on AESDATA[0-7] using \round_key.
+.macro	_aesenc_8x	round_key
+.irp i, 0,1,2,3,4,5,6,7
+	aesenc		\round_key, AESDATA\i
+.endr
+.endm
+
+// Do the last round of AES on AESDATA[0-7] using \round_key.
+.macro	_aesenclast_8x	round_key
+.irp i, 0,1,2,3,4,5,6,7
+	aesenclast	\round_key, AESDATA\i
+.endr
+.endm
+
+// XOR eight blocks from SRC with the keystream blocks in AESDATA[0-7], and
+// store the result to DST.  Clobbers TMP0.
+.macro	_xor_data_8x
+.irp i, 0,1,2,3,4,5,6,7
+	_xor_mem_to_reg	\i*16(SRC), AESDATA\i, tmp=TMP0
+.endr
+.irp i, 0,1,2,3,4,5,6,7
+	movdqu		AESDATA\i, \i*16(DST)
+.endr
+.endm
+
+// void aes_gcm_{enc,dec}_update_##suffix(const struct aes_gcm_key_aesni *key,
+//					  const u32 le_ctr[4], u8 ghash_acc[16],
+//					  const u8 *src, u8 *dst, int datalen);
+//
+// This macro generates a GCM encryption or decryption update function with the
+// above prototype (with \enc selecting which one).
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
+// |le_ctr| must give the current counter in little-endian format.  For a new
+// message, the low word of the counter must be 2.  This function loads the
+// counter from |le_ctr| and increments the loaded counter as needed, but it
+// does *not* store the updated counter back to |le_ctr|.  The caller must
+// update |le_ctr| if any more data segments follow.  Internally, only the low
+// 32-bit word of the counter is incremented, following the GCM standard.
+.macro	_aes_gcm_update	enc
+
+	// Function arguments
+	.set	KEY,		%rdi
+	.set	LE_CTR_PTR,	%rsi	// Note: overlaps with usage as temp reg
+	.set	GHASH_ACC_PTR,	%rdx
+	.set	SRC,		%rcx
+	.set	DST,		%r8
+	.set	DATALEN,	%r9d
+	.set	DATALEN64,	%r9	// Zero-extend DATALEN before using!
+	// Note: the code setting up for _load_partial_block assumes that SRC is
+	// in %rcx (and that DATALEN is *not* in %rcx).
+
+	// Additional local variables
+
+	// %rax and %rsi are used as temporary registers.  Note: %rsi overlaps
+	// with LE_CTR_PTR, which is used only at the beginning.
+
+	.set	AESKEYLEN,	%r10d	// AES key length in bytes
+	.set	AESKEYLEN64,	%r10
+	.set	RNDKEYLAST_PTR,	%r11	// Pointer to last AES round key
+
+	// Put the most frequently used values in %xmm0-%xmm7 to reduce code
+	// size.  (%xmm0-%xmm7 take fewer bytes to encode than %xmm8-%xmm15.)
+	.set	TMP0,		%xmm0
+	.set	TMP1,		%xmm1
+	.set	TMP2,		%xmm2
+	.set	LO,		%xmm3	// Low part of unreduced product
+	.set	MI,		%xmm4	// Middle part of unreduced product
+	.set	GHASH_ACC,	%xmm5	// GHASH accumulator; in main loop also
+					// the high part of unreduced product
+	.set	BSWAP_MASK,	%xmm6	// Shuffle mask for reflecting bytes
+	.set	LE_CTR,		%xmm7	// Little-endian counter value
+	.set	AESDATA0,	%xmm8
+	.set	AESDATA1,	%xmm9
+	.set	AESDATA2,	%xmm10
+	.set	AESDATA3,	%xmm11
+	.set	AESDATA4,	%xmm12
+	.set	AESDATA5,	%xmm13
+	.set	AESDATA6,	%xmm14
+	.set	AESDATA7,	%xmm15
+
+	movdqa		.Lbswap_mask(%rip), BSWAP_MASK
+	movdqu		(GHASH_ACC_PTR), GHASH_ACC
+	movdqu		(LE_CTR_PTR), LE_CTR
+
+	movl		OFFSETOF_AESKEYLEN(KEY), AESKEYLEN
+	lea		6*16(KEY,AESKEYLEN64,4), RNDKEYLAST_PTR
+
+	// If there are at least 8*16 bytes of data, then continue into the main
+	// loop, which processes 8*16 bytes of data per iteration.
+	//
+	// The main loop interleaves AES and GHASH to improve performance on
+	// CPUs that can execute these instructions in parallel.  When
+	// decrypting, the GHASH input (the ciphertext) is immediately
+	// available.  When encrypting, we instead encrypt a set of 8 blocks
+	// first and then GHASH those blocks while encrypting the next set of 8,
+	// repeat that as needed, and finally GHASH the last set of 8 blocks.
+	//
+	// Code size optimization: Prefer adding or subtracting -8*16 over 8*16,
+	// as this makes the immediate fit in a signed byte, saving 3 bytes.
+	add		$-8*16, DATALEN
+	jl		.Lcrypt_loop_8x_done\@
+.if \enc
+	// Encrypt the first 8 plaintext blocks.
+	_ctr_begin_8x
+	lea		16(KEY), %rsi
+	.p2align 4
+1:
+	movdqa		(%rsi), TMP0
+	_aesenc_8x	TMP0
+	add		$16, %rsi
+	cmp		%rsi, RNDKEYLAST_PTR
+	jne		1b
+	movdqa		(%rsi), TMP0
+	_aesenclast_8x	TMP0
+	_xor_data_8x
+	// Don't increment DST until the ciphertext blocks have been hashed.
+	sub		$-8*16, SRC
+	add		$-8*16, DATALEN
+	jl		.Lghash_last_ciphertext_8x\@
+.endif
+
+	.p2align 4
+.Lcrypt_loop_8x\@:
+
+	// Generate the next set of 8 counter blocks and start encrypting them.
+	_ctr_begin_8x
+	lea		16(KEY), %rsi
+
+	// Do a round of AES, and start the GHASH update of 8 ciphertext blocks
+	// by doing the unreduced multiplication for the first ciphertext block.
+	movdqa		(%rsi), TMP0
+	add		$16, %rsi
+	_aesenc_8x	TMP0
+	_ghash_update_begin_8x \enc
+
+	// Do 7 more rounds of AES, and continue the GHASH update by doing the
+	// unreduced multiplication for the remaining ciphertext blocks.
+	.p2align 4
+1:
+	movdqa		(%rsi), TMP0
+	add		$16, %rsi
+	_aesenc_8x	TMP0
+	_ghash_update_continue_8x \enc
+	cmp		$7*8, %eax
+	jne		1b
+
+	// Do the remaining AES rounds.
+	.p2align 4
+1:
+	movdqa		(%rsi), TMP0
+	add		$16, %rsi
+	_aesenc_8x	TMP0
+	cmp		%rsi, RNDKEYLAST_PTR
+	jne		1b
+
+	// Do the GHASH reduction and the last round of AES.
+	movdqa		(RNDKEYLAST_PTR), TMP0
+	_ghash_update_end_8x_step	0
+	_aesenclast_8x	TMP0
+	_ghash_update_end_8x_step	1
+
+	// XOR the data with the AES-CTR keystream blocks.
+.if \enc
+	sub		$-8*16, DST
+.endif
+	_xor_data_8x
+	sub		$-8*16, SRC
+.if !\enc
+	sub		$-8*16, DST
+.endif
+	add		$-8*16, DATALEN
+	jge		.Lcrypt_loop_8x\@
+
+.if \enc
+.Lghash_last_ciphertext_8x\@:
+	// Update GHASH with the last set of 8 ciphertext blocks.
+	_ghash_update_begin_8x		\enc
+	.p2align 4
+1:
+	_ghash_update_continue_8x	\enc
+	cmp		$7*8, %eax
+	jne		1b
+	_ghash_update_end_8x_step	0
+	_ghash_update_end_8x_step	1
+	sub		$-8*16, DST
+.endif
+
+.Lcrypt_loop_8x_done\@:
+
+	sub		$-8*16, DATALEN
+	jz		.Ldone\@
+
+	// Handle the remainder of length 1 <= DATALEN < 8*16 bytes.  We keep
+	// things simple and keep the code size down by just going one block at
+	// a time, again taking advantage of hardware loop unrolling.  Since
+	// there are enough key powers available for all remaining data, we do
+	// the GHASH multiplications unreduced, and only reduce at the very end.
+
+	.set	HI,		TMP2
+	.set	H_POW,		AESDATA0
+	.set	H_POW_XORED,	AESDATA1
+	.set	ONE,		AESDATA2
+
+	movq		.Lone(%rip), ONE
+
+	// Start collecting the unreduced GHASH intermediate value LO, MI, HI.
+	pxor		LO, LO
+	pxor		MI, MI
+	pxor		HI, HI
+
+	// Set up a block counter %rax to contain 8*(8-n), where n is the number
+	// of blocks that remain, counting any partial block.  This will be used
+	// to access the key powers H^n through H^1.
+	mov		DATALEN, %eax
+	neg		%eax
+	and		$~15, %eax
+	sar		$1, %eax
+	add		$64, %eax
+
+	sub		$16, DATALEN
+	jl		.Lcrypt_loop_1x_done\@
+
+	// Process the data one full block at a time.
+.Lcrypt_loop_1x\@:
+
+	// Encrypt the next counter block.
+	_vpshufb	BSWAP_MASK, LE_CTR, TMP0
+	paddd		ONE, LE_CTR
+	pxor		(KEY), TMP0
+	lea		-6*16(RNDKEYLAST_PTR), %rsi	// Reduce code size
+	cmp		$24, AESKEYLEN
+	jl		128f	// AES-128?
+	je		192f	// AES-192?
+	// AES-256
+	aesenc		-7*16(%rsi), TMP0
+	aesenc		-6*16(%rsi), TMP0
+192:
+	aesenc		-5*16(%rsi), TMP0
+	aesenc		-4*16(%rsi), TMP0
+128:
+.irp i, -3,-2,-1,0,1,2,3,4,5
+	aesenc		\i*16(%rsi), TMP0
+.endr
+	aesenclast	(RNDKEYLAST_PTR), TMP0
+
+	// Load the next key power H^i.
+	movdqa		OFFSETOF_H_POWERS(KEY,%rax,2), H_POW
+	movq		OFFSETOF_H_POWERS_XORED(KEY,%rax), H_POW_XORED
+
+	// XOR the keystream block that was just generated in TMP0 with the next
+	// source data block and store the resulting en/decrypted data to DST.
+.if \enc
+	_xor_mem_to_reg	(SRC), TMP0, tmp=TMP1
+	movdqu		TMP0, (DST)
+.else
+	movdqu		(SRC), TMP1
+	pxor		TMP1, TMP0
+	movdqu		TMP0, (DST)
+.endif
+
+	// Update GHASH with the ciphertext block.
+.if \enc
+	pshufb		BSWAP_MASK, TMP0
+	pxor		TMP0, GHASH_ACC
+.else
+	pshufb		BSWAP_MASK, TMP1
+	pxor		TMP1, GHASH_ACC
+.endif
+	_ghash_mul_noreduce	H_POW, H_POW_XORED, GHASH_ACC, LO, MI, HI, TMP0
+	pxor		GHASH_ACC, GHASH_ACC
+
+	add		$8, %eax
+	add		$16, SRC
+	add		$16, DST
+	sub		$16, DATALEN
+	jge		.Lcrypt_loop_1x\@
+.Lcrypt_loop_1x_done\@:
+	// Check whether there is a partial block at the end.
+	add		$16, DATALEN
+	jz		.Lghash_reduce\@
+
+	// Process a partial block of length 1 <= DATALEN <= 15.
+
+	// Encrypt a counter block for the last time.
+	pshufb		BSWAP_MASK, LE_CTR
+	pxor		(KEY), LE_CTR
+	lea		16(KEY), %rsi
+1:
+	aesenc		(%rsi), LE_CTR
+	add		$16, %rsi
+	cmp		%rsi, RNDKEYLAST_PTR
+	jne		1b
+	aesenclast	(RNDKEYLAST_PTR), LE_CTR
+
+	// Load the lowest key power, H^1.
+	movdqa		OFFSETOF_H_POWERS(KEY,%rax,2), H_POW
+	movq		OFFSETOF_H_POWERS_XORED(KEY,%rax), H_POW_XORED
+
+	// Load and zero-pad 1 <= DATALEN <= 15 bytes of data from SRC.  SRC is
+	// in %rcx, but _load_partial_block needs DATALEN in %rcx instead.
+	// RNDKEYLAST_PTR is no longer needed, so reuse it for SRC.
+	mov		SRC, RNDKEYLAST_PTR
+	mov		DATALEN, %ecx
+	_load_partial_block	RNDKEYLAST_PTR, TMP0, %rsi, %esi
+
+	// XOR the keystream block that was just generated in LE_CTR with the
+	// source data block and store the resulting en/decrypted data to DST.
+	pxor		TMP0, LE_CTR
+	mov		DATALEN, %ecx
+	_store_partial_block	LE_CTR, DST
+
+	// If encrypting, zero-pad the final ciphertext block for GHASH.  (If
+	// decrypting, this was already done by _load_partial_block.)
+.if \enc
+	lea		.Lzeropad_mask+16(%rip), %rax
+	sub		DATALEN64, %rax
+	_vpand		(%rax), LE_CTR, TMP0
+.endif
+
+	// Update GHASH with the final ciphertext block.
+	pshufb		BSWAP_MASK, TMP0
+	pxor		TMP0, GHASH_ACC
+	_ghash_mul_noreduce	H_POW, H_POW_XORED, GHASH_ACC, LO, MI, HI, TMP0
+
+.Lghash_reduce\@:
+	// Finally, do the GHASH reduction.
+	_ghash_reduce	LO, MI, HI, GHASH_ACC, TMP0
+
+.Ldone\@:
+	// Store the updated GHASH accumulator back to memory.
+	movdqu		GHASH_ACC, (GHASH_ACC_PTR)
+
+	RET
+.endm
+
+// void aes_gcm_enc_final_##suffix(const struct aes_gcm_key_aesni *key,
+//				   const u32 le_ctr[4], u8 ghash_acc[16],
+//				   u64 total_aadlen, u64 total_datalen);
+// bool aes_gcm_dec_final_##suffix(const struct aes_gcm_key_aesni *key,
+//				   const u32 le_ctr[4], const u8 ghash_acc[16],
+//				   u64 total_aadlen, u64 total_datalen,
+//				   const u8 tag[16], int taglen);
+//
+// This macro generates one of the above two functions (with \enc selecting
+// which one).  Both functions finish computing the GCM authentication tag by
+// updating GHASH with the lengths block and encrypting the GHASH accumulator.
+// |total_aadlen| and |total_datalen| must be the total length of the additional
+// authenticated data and the en/decrypted data in bytes, respectively.
+//
+// The encryption function then stores the full-length (16-byte) computed
+// authentication tag to |ghash_acc|.  The decryption function instead loads the
+// expected authentication tag (the one that was transmitted) from the 16-byte
+// buffer |tag|, compares the first 4 <= |taglen| <= 16 bytes of it to the
+// computed tag in constant time, and returns true if and only if they match.
+.macro	_aes_gcm_final	enc
+
+	// Function arguments
+	.set	KEY,		%rdi
+	.set	LE_CTR_PTR,	%rsi
+	.set	GHASH_ACC_PTR,	%rdx
+	.set	TOTAL_AADLEN,	%rcx
+	.set	TOTAL_DATALEN,	%r8
+	.set	TAG,		%r9
+	.set	TAGLEN,		%r10d	// Originally at 8(%rsp)
+	.set	TAGLEN64,	%r10
+
+	// Additional local variables.
+	// %rax and %xmm0-%xmm2 are used as temporary registers.
+	.set	AESKEYLEN,	%r11d
+	.set	AESKEYLEN64,	%r11
+	.set	BSWAP_MASK,	%xmm3
+	.set	GHASH_ACC,	%xmm4
+	.set	H_POW1,		%xmm5	// H^1
+	.set	H_POW1_X64,	%xmm6	// H^1 * x^64
+	.set	GFPOLY,		%xmm7
+
+	movdqa		.Lbswap_mask(%rip), BSWAP_MASK
+	movl		OFFSETOF_AESKEYLEN(KEY), AESKEYLEN
+
+	// Set up a counter block with 1 in the low 32-bit word.  This is the
+	// counter that produces the ciphertext needed to encrypt the auth tag.
+	movdqu		(LE_CTR_PTR), %xmm0
+	mov		$1, %eax
+	pinsrd		$0, %eax, %xmm0
+
+	// Build the lengths block and XOR it into the GHASH accumulator.
+	movq		TOTAL_DATALEN, GHASH_ACC
+	pinsrq		$1, TOTAL_AADLEN, GHASH_ACC
+	psllq		$3, GHASH_ACC	// Bytes to bits
+	_xor_mem_to_reg	(GHASH_ACC_PTR), GHASH_ACC, %xmm1
+
+	movdqa		OFFSETOF_H_POWERS+7*16(KEY), H_POW1
+	movdqa		OFFSETOF_H_TIMES_X64(KEY), H_POW1_X64
+	movq		.Lgfpoly(%rip), GFPOLY
+
+	// Make %rax point to the 6th from last AES round key.  (Using signed
+	// byte offsets -7*16 through 6*16 decreases code size.)
+	lea		(KEY,AESKEYLEN64,4), %rax
+
+	// AES-encrypt the counter block and also multiply GHASH_ACC by H^1.
+	// Interleave the AES and GHASH instructions to improve performance.
+	pshufb		BSWAP_MASK, %xmm0
+	pxor		(KEY), %xmm0
+	cmp		$24, AESKEYLEN
+	jl		128f	// AES-128?
+	je		192f	// AES-192?
+	// AES-256
+	aesenc		-7*16(%rax), %xmm0
+	aesenc		-6*16(%rax), %xmm0
+192:
+	aesenc		-5*16(%rax), %xmm0
+	aesenc		-4*16(%rax), %xmm0
+128:
+.irp i, 0,1,2,3,4,5,6,7,8
+	aesenc		(\i-3)*16(%rax), %xmm0
+	_ghash_mul_step	\i, H_POW1, H_POW1_X64, GHASH_ACC, GFPOLY, %xmm1, %xmm2
+.endr
+	aesenclast	6*16(%rax), %xmm0
+	_ghash_mul_step	9, H_POW1, H_POW1_X64, GHASH_ACC, GFPOLY, %xmm1, %xmm2
+
+	// Undo the byte reflection of the GHASH accumulator.
+	pshufb		BSWAP_MASK, GHASH_ACC
+
+	// Encrypt the GHASH accumulator.
+	pxor		%xmm0, GHASH_ACC
+
+.if \enc
+	// Return the computed auth tag.
+	movdqu		GHASH_ACC, (GHASH_ACC_PTR)
+.else
+	.set		ZEROPAD_MASK_PTR, TOTAL_AADLEN // Reusing TOTAL_AADLEN!
+
+	// Verify the auth tag in constant time by XOR'ing the transmitted and
+	// computed auth tags together and using the ptest instruction to check
+	// whether the first TAGLEN bytes of the result are zero.
+	_xor_mem_to_reg	(TAG), GHASH_ACC, tmp=%xmm0
+	movl		8(%rsp), TAGLEN
+	lea		.Lzeropad_mask+16(%rip), ZEROPAD_MASK_PTR
+	sub		TAGLEN64, ZEROPAD_MASK_PTR
+	xor		%eax, %eax
+	_test_mem	(ZEROPAD_MASK_PTR), GHASH_ACC, tmp=%xmm0
+	sete		%al
+.endif
+	RET
+.endm
+
+.set	USE_AVX, 0
+SYM_FUNC_START(aes_gcm_precompute_aesni)
+	_aes_gcm_precompute
+SYM_FUNC_END(aes_gcm_precompute_aesni)
+SYM_FUNC_START(aes_gcm_aad_update_aesni)
+	_aes_gcm_aad_update
+SYM_FUNC_END(aes_gcm_aad_update_aesni)
+SYM_FUNC_START(aes_gcm_enc_update_aesni)
+	_aes_gcm_update	1
+SYM_FUNC_END(aes_gcm_enc_update_aesni)
+SYM_FUNC_START(aes_gcm_dec_update_aesni)
+	_aes_gcm_update	0
+SYM_FUNC_END(aes_gcm_dec_update_aesni)
+SYM_FUNC_START(aes_gcm_enc_final_aesni)
+	_aes_gcm_final	1
+SYM_FUNC_END(aes_gcm_enc_final_aesni)
+SYM_FUNC_START(aes_gcm_dec_final_aesni)
+	_aes_gcm_final	0
+SYM_FUNC_END(aes_gcm_dec_final_aesni)
+
+.set	USE_AVX, 1
+SYM_FUNC_START(aes_gcm_precompute_aesni_avx)
+	_aes_gcm_precompute
+SYM_FUNC_END(aes_gcm_precompute_aesni_avx)
+SYM_FUNC_START(aes_gcm_aad_update_aesni_avx)
+	_aes_gcm_aad_update
+SYM_FUNC_END(aes_gcm_aad_update_aesni_avx)
+SYM_FUNC_START(aes_gcm_enc_update_aesni_avx)
+	_aes_gcm_update	1
+SYM_FUNC_END(aes_gcm_enc_update_aesni_avx)
+SYM_FUNC_START(aes_gcm_dec_update_aesni_avx)
+	_aes_gcm_update	0
+SYM_FUNC_END(aes_gcm_dec_update_aesni_avx)
+SYM_FUNC_START(aes_gcm_enc_final_aesni_avx)
+	_aes_gcm_final	1
+SYM_FUNC_END(aes_gcm_enc_final_aesni_avx)
+SYM_FUNC_START(aes_gcm_dec_final_aesni_avx)
+	_aes_gcm_final	0
+SYM_FUNC_END(aes_gcm_dec_final_aesni_avx)
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 39066b57a70e..eb153eff9331 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -8,116 +8,18 @@
  * Copyright (C) 2008, Intel Corp.
  *    Author: Huang Ying <ying.huang@intel.com>
  *            Vinodh Gopal <vinodh.gopal@intel.com>
  *            Kahraman Akdemir
  *
- * Added RFC4106 AES-GCM support for 128-bit keys under the AEAD
- * interface for 64-bit kernels.
- *    Authors: Erdinc Ozturk (erdinc.ozturk@intel.com)
- *             Aidan O'Mahony (aidan.o.mahony@intel.com)
- *             Adrian Hoban <adrian.hoban@intel.com>
- *             James Guilford (james.guilford@intel.com)
- *             Gabriele Paoloni <gabriele.paoloni@intel.com>
- *             Tadeusz Struk (tadeusz.struk@intel.com)
- *             Wajdi Feghali (wajdi.k.feghali@intel.com)
- *    Copyright (c) 2010, Intel Corporation.
+ * Copyright (c) 2010, Intel Corporation.
  *
  * Ported x86_64 version to x86:
  *    Author: Mathias Krause <minipli@googlemail.com>
  */
 
 #include <linux/linkage.h>
 #include <asm/frame.h>
-#include <asm/nospec-branch.h>
-
-/*
- * The following macros are used to move an (un)aligned 16 byte value to/from
- * an XMM register.  This can done for either FP or integer values, for FP use
- * movaps (move aligned packed single) or integer use movdqa (move double quad
- * aligned).  It doesn't make a performance difference which instruction is used
- * since Nehalem (original Core i7) was released.  However, the movaps is a byte
- * shorter, so that is the one we'll use for now. (same for unaligned).
- */
-#define MOVADQ	movaps
-#define MOVUDQ	movups
-
-#ifdef __x86_64__
-
-# constants in mergeable sections, linker can reorder and merge
-.section	.rodata.cst16.POLY, "aM", @progbits, 16
-.align 16
-POLY:   .octa 0xC2000000000000000000000000000001
-.section	.rodata.cst16.TWOONE, "aM", @progbits, 16
-.align 16
-TWOONE: .octa 0x00000001000000000000000000000001
-
-.section	.rodata.cst16.SHUF_MASK, "aM", @progbits, 16
-.align 16
-SHUF_MASK:  .octa 0x000102030405060708090A0B0C0D0E0F
-.section	.rodata.cst16.MASK1, "aM", @progbits, 16
-.align 16
-MASK1:      .octa 0x0000000000000000ffffffffffffffff
-.section	.rodata.cst16.MASK2, "aM", @progbits, 16
-.align 16
-MASK2:      .octa 0xffffffffffffffff0000000000000000
-.section	.rodata.cst16.ONE, "aM", @progbits, 16
-.align 16
-ONE:        .octa 0x00000000000000000000000000000001
-.section	.rodata.cst16.F_MIN_MASK, "aM", @progbits, 16
-.align 16
-F_MIN_MASK: .octa 0xf1f2f3f4f5f6f7f8f9fafbfcfdfeff0
-.section	.rodata.cst16.dec, "aM", @progbits, 16
-.align 16
-dec:        .octa 0x1
-.section	.rodata.cst16.enc, "aM", @progbits, 16
-.align 16
-enc:        .octa 0x2
-
-# order of these constants should not change.
-# more specifically, ALL_F should follow SHIFT_MASK,
-# and zero should follow ALL_F
-.section	.rodata, "a", @progbits
-.align 16
-SHIFT_MASK: .octa 0x0f0e0d0c0b0a09080706050403020100
-ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
-            .octa 0x00000000000000000000000000000000
-
-.text
-
-#define AadHash 16*0
-#define AadLen 16*1
-#define InLen (16*1)+8
-#define PBlockEncKey 16*2
-#define OrigIV 16*3
-#define CurCount 16*4
-#define PBlockLen 16*5
-#define	HashKey		16*6	// store HashKey <<1 mod poly here
-#define	HashKey_2	16*7	// store HashKey^2 <<1 mod poly here
-#define	HashKey_3	16*8	// store HashKey^3 <<1 mod poly here
-#define	HashKey_4	16*9	// store HashKey^4 <<1 mod poly here
-#define	HashKey_k	16*10	// store XOR of High 64 bits and Low 64
-				// bits of  HashKey <<1 mod poly here
-				//(for Karatsuba purposes)
-#define	HashKey_2_k	16*11	// store XOR of High 64 bits and Low 64
-				// bits of  HashKey^2 <<1 mod poly here
-				// (for Karatsuba purposes)
-#define	HashKey_3_k	16*12	// store XOR of High 64 bits and Low 64
-				// bits of  HashKey^3 <<1 mod poly here
-				// (for Karatsuba purposes)
-#define	HashKey_4_k	16*13	// store XOR of High 64 bits and Low 64
-				// bits of  HashKey^4 <<1 mod poly here
-				// (for Karatsuba purposes)
-
-#define arg1 rdi
-#define arg2 rsi
-#define arg3 rdx
-#define arg4 rcx
-#define arg5 r8
-#define arg6 r9
-#define keysize 2*15*16(%arg1)
-#endif
-
 
 #define STATE1	%xmm0
 #define STATE2	%xmm4
 #define STATE3	%xmm5
 #define STATE4	%xmm6
@@ -160,1413 +62,10 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 #define KLEN	%ebx
 #define T1	%ecx
 #define TKEYP	T1
 #endif
 
-.macro FUNC_SAVE
-	push	%r12
-	push	%r13
-	push	%r14
-#
-# states of %xmm registers %xmm6:%xmm15 not saved
-# all %xmm registers are clobbered
-#
-.endm
-
-
-.macro FUNC_RESTORE
-	pop	%r14
-	pop	%r13
-	pop	%r12
-.endm
-
-# Precompute hashkeys.
-# Input: Hash subkey.
-# Output: HashKeys stored in gcm_context_data.  Only needs to be called
-# once per key.
-# clobbers r12, and tmp xmm registers.
-.macro PRECOMPUTE SUBKEY TMP1 TMP2 TMP3 TMP4 TMP5 TMP6 TMP7
-	mov	\SUBKEY, %r12
-	movdqu	(%r12), \TMP3
-	movdqa	SHUF_MASK(%rip), \TMP2
-	pshufb	\TMP2, \TMP3
-
-	# precompute HashKey<<1 mod poly from the HashKey (required for GHASH)
-
-	movdqa	\TMP3, \TMP2
-	psllq	$1, \TMP3
-	psrlq	$63, \TMP2
-	movdqa	\TMP2, \TMP1
-	pslldq	$8, \TMP2
-	psrldq	$8, \TMP1
-	por	\TMP2, \TMP3
-
-	# reduce HashKey<<1
-
-	pshufd	$0x24, \TMP1, \TMP2
-	pcmpeqd TWOONE(%rip), \TMP2
-	pand	POLY(%rip), \TMP2
-	pxor	\TMP2, \TMP3
-	movdqu	\TMP3, HashKey(%arg2)
-
-	movdqa	   \TMP3, \TMP5
-	pshufd	   $78, \TMP3, \TMP1
-	pxor	   \TMP3, \TMP1
-	movdqu	   \TMP1, HashKey_k(%arg2)
-
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^2<<1 (mod poly)
-	movdqu	   \TMP5, HashKey_2(%arg2)
-# HashKey_2 = HashKey^2<<1 (mod poly)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqu	   \TMP1, HashKey_2_k(%arg2)
-
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^3<<1 (mod poly)
-	movdqu	   \TMP5, HashKey_3(%arg2)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqu	   \TMP1, HashKey_3_k(%arg2)
-
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^3<<1 (mod poly)
-	movdqu	   \TMP5, HashKey_4(%arg2)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqu	   \TMP1, HashKey_4_k(%arg2)
-.endm
-
-# GCM_INIT initializes a gcm_context struct to prepare for encoding/decoding.
-# Clobbers rax, r10-r13 and xmm0-xmm6, %xmm13
-.macro GCM_INIT Iv SUBKEY AAD AADLEN
-	mov \AADLEN, %r11
-	mov %r11, AadLen(%arg2) # ctx_data.aad_length = aad_length
-	xor %r11d, %r11d
-	mov %r11, InLen(%arg2) # ctx_data.in_length = 0
-	mov %r11, PBlockLen(%arg2) # ctx_data.partial_block_length = 0
-	mov %r11, PBlockEncKey(%arg2) # ctx_data.partial_block_enc_key = 0
-	mov \Iv, %rax
-	movdqu (%rax), %xmm0
-	movdqu %xmm0, OrigIV(%arg2) # ctx_data.orig_IV = iv
-
-	movdqa  SHUF_MASK(%rip), %xmm2
-	pshufb %xmm2, %xmm0
-	movdqu %xmm0, CurCount(%arg2) # ctx_data.current_counter = iv
-
-	PRECOMPUTE \SUBKEY, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7
-	movdqu HashKey(%arg2), %xmm13
-
-	CALC_AAD_HASH %xmm13, \AAD, \AADLEN, %xmm0, %xmm1, %xmm2, %xmm3, \
-	%xmm4, %xmm5, %xmm6
-.endm
-
-# GCM_ENC_DEC Encodes/Decodes given data. Assumes that the passed gcm_context
-# struct has been initialized by GCM_INIT.
-# Requires the input data be at least 1 byte long because of READ_PARTIAL_BLOCK
-# Clobbers rax, r10-r13, and xmm0-xmm15
-.macro GCM_ENC_DEC operation
-	movdqu AadHash(%arg2), %xmm8
-	movdqu HashKey(%arg2), %xmm13
-	add %arg5, InLen(%arg2)
-
-	xor %r11d, %r11d # initialise the data pointer offset as zero
-	PARTIAL_BLOCK %arg3 %arg4 %arg5 %r11 %xmm8 \operation
-
-	sub %r11, %arg5		# sub partial block data used
-	mov %arg5, %r13		# save the number of bytes
-
-	and $-16, %r13		# %r13 = %r13 - (%r13 mod 16)
-	mov %r13, %r12
-	# Encrypt/Decrypt first few blocks
-
-	and	$(3<<4), %r12
-	jz	.L_initial_num_blocks_is_0_\@
-	cmp	$(2<<4), %r12
-	jb	.L_initial_num_blocks_is_1_\@
-	je	.L_initial_num_blocks_is_2_\@
-.L_initial_num_blocks_is_3_\@:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, \operation
-	sub	$48, %r13
-	jmp	.L_initial_blocks_\@
-.L_initial_num_blocks_is_2_\@:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, \operation
-	sub	$32, %r13
-	jmp	.L_initial_blocks_\@
-.L_initial_num_blocks_is_1_\@:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, \operation
-	sub	$16, %r13
-	jmp	.L_initial_blocks_\@
-.L_initial_num_blocks_is_0_\@:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, \operation
-.L_initial_blocks_\@:
-
-	# Main loop - Encrypt/Decrypt remaining blocks
-
-	test	%r13, %r13
-	je	.L_zero_cipher_left_\@
-	sub	$64, %r13
-	je	.L_four_cipher_left_\@
-.L_crypt_by_4_\@:
-	GHASH_4_ENCRYPT_4_PARALLEL_\operation	%xmm9, %xmm10, %xmm11, %xmm12, \
-	%xmm13, %xmm14, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, \
-	%xmm7, %xmm8, enc
-	add	$64, %r11
-	sub	$64, %r13
-	jne	.L_crypt_by_4_\@
-.L_four_cipher_left_\@:
-	GHASH_LAST_4	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, \
-%xmm15, %xmm1, %xmm2, %xmm3, %xmm4, %xmm8
-.L_zero_cipher_left_\@:
-	movdqu %xmm8, AadHash(%arg2)
-	movdqu %xmm0, CurCount(%arg2)
-
-	mov	%arg5, %r13
-	and	$15, %r13			# %r13 = arg5 (mod 16)
-	je	.L_multiple_of_16_bytes_\@
-
-	mov %r13, PBlockLen(%arg2)
-
-	# Handle the last <16 Byte block separately
-	paddd ONE(%rip), %xmm0                # INCR CNT to get Yn
-	movdqu %xmm0, CurCount(%arg2)
-	movdqa SHUF_MASK(%rip), %xmm10
-	pshufb %xmm10, %xmm0
-
-	ENCRYPT_SINGLE_BLOCK	%xmm0, %xmm1        # Encrypt(K, Yn)
-	movdqu %xmm0, PBlockEncKey(%arg2)
-
-	cmp	$16, %arg5
-	jge	.L_large_enough_update_\@
-
-	lea (%arg4,%r11,1), %r10
-	mov %r13, %r12
-	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
-	jmp	.L_data_read_\@
-
-.L_large_enough_update_\@:
-	sub	$16, %r11
-	add	%r13, %r11
-
-	# receive the last <16 Byte block
-	movdqu	(%arg4, %r11, 1), %xmm1
-
-	sub	%r13, %r11
-	add	$16, %r11
-
-	lea	SHIFT_MASK+16(%rip), %r12
-	# adjust the shuffle mask pointer to be able to shift 16-r13 bytes
-	# (r13 is the number of bytes in plaintext mod 16)
-	sub	%r13, %r12
-	# get the appropriate shuffle mask
-	movdqu	(%r12), %xmm2
-	# shift right 16-r13 bytes
-	pshufb  %xmm2, %xmm1
-
-.L_data_read_\@:
-	lea ALL_F+16(%rip), %r12
-	sub %r13, %r12
-
-.ifc \operation, dec
-	movdqa  %xmm1, %xmm2
-.endif
-	pxor	%xmm1, %xmm0            # XOR Encrypt(K, Yn)
-	movdqu	(%r12), %xmm1
-	# get the appropriate mask to mask out top 16-r13 bytes of xmm0
-	pand	%xmm1, %xmm0            # mask out top 16-r13 bytes of xmm0
-.ifc \operation, dec
-	pand    %xmm1, %xmm2
-	movdqa SHUF_MASK(%rip), %xmm10
-	pshufb %xmm10 ,%xmm2
-
-	pxor %xmm2, %xmm8
-.else
-	movdqa SHUF_MASK(%rip), %xmm10
-	pshufb %xmm10,%xmm0
-
-	pxor	%xmm0, %xmm8
-.endif
-
-	movdqu %xmm8, AadHash(%arg2)
-.ifc \operation, enc
-	# GHASH computation for the last <16 byte block
-	movdqa SHUF_MASK(%rip), %xmm10
-	# shuffle xmm0 back to output as ciphertext
-	pshufb %xmm10, %xmm0
-.endif
-
-	# Output %r13 bytes
-	movq %xmm0, %rax
-	cmp $8, %r13
-	jle .L_less_than_8_bytes_left_\@
-	mov %rax, (%arg3 , %r11, 1)
-	add $8, %r11
-	psrldq $8, %xmm0
-	movq %xmm0, %rax
-	sub $8, %r13
-.L_less_than_8_bytes_left_\@:
-	mov %al,  (%arg3, %r11, 1)
-	add $1, %r11
-	shr $8, %rax
-	sub $1, %r13
-	jne .L_less_than_8_bytes_left_\@
-.L_multiple_of_16_bytes_\@:
-.endm
-
-# GCM_COMPLETE Finishes update of tag of last partial block
-# Output: Authorization Tag (AUTH_TAG)
-# Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
-.macro GCM_COMPLETE AUTHTAG AUTHTAGLEN
-	movdqu AadHash(%arg2), %xmm8
-	movdqu HashKey(%arg2), %xmm13
-
-	mov PBlockLen(%arg2), %r12
-
-	test %r12, %r12
-	je .L_partial_done\@
-
-	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
-
-.L_partial_done\@:
-	mov AadLen(%arg2), %r12  # %r13 = aadLen (number of bytes)
-	shl	$3, %r12		  # convert into number of bits
-	movd	%r12d, %xmm15		  # len(A) in %xmm15
-	mov InLen(%arg2), %r12
-	shl     $3, %r12                  # len(C) in bits (*128)
-	movq    %r12, %xmm1
-
-	pslldq	$8, %xmm15		  # %xmm15 = len(A)||0x0000000000000000
-	pxor	%xmm1, %xmm15		  # %xmm15 = len(A)||len(C)
-	pxor	%xmm15, %xmm8
-	GHASH_MUL	%xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
-	# final GHASH computation
-	movdqa SHUF_MASK(%rip), %xmm10
-	pshufb %xmm10, %xmm8
-
-	movdqu OrigIV(%arg2), %xmm0       # %xmm0 = Y0
-	ENCRYPT_SINGLE_BLOCK	%xmm0,  %xmm1	  # E(K, Y0)
-	pxor	%xmm8, %xmm0
-.L_return_T_\@:
-	mov	\AUTHTAG, %r10                     # %r10 = authTag
-	mov	\AUTHTAGLEN, %r11                    # %r11 = auth_tag_len
-	cmp	$16, %r11
-	je	.L_T_16_\@
-	cmp	$8, %r11
-	jl	.L_T_4_\@
-.L_T_8_\@:
-	movq	%xmm0, %rax
-	mov	%rax, (%r10)
-	add	$8, %r10
-	sub	$8, %r11
-	psrldq	$8, %xmm0
-	test	%r11, %r11
-	je	.L_return_T_done_\@
-.L_T_4_\@:
-	movd	%xmm0, %eax
-	mov	%eax, (%r10)
-	add	$4, %r10
-	sub	$4, %r11
-	psrldq	$4, %xmm0
-	test	%r11, %r11
-	je	.L_return_T_done_\@
-.L_T_123_\@:
-	movd	%xmm0, %eax
-	cmp	$2, %r11
-	jl	.L_T_1_\@
-	mov	%ax, (%r10)
-	cmp	$2, %r11
-	je	.L_return_T_done_\@
-	add	$2, %r10
-	sar	$16, %eax
-.L_T_1_\@:
-	mov	%al, (%r10)
-	jmp	.L_return_T_done_\@
-.L_T_16_\@:
-	movdqu	%xmm0, (%r10)
-.L_return_T_done_\@:
-.endm
-
-#ifdef __x86_64__
-/* GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
-*
-*
-* Input: A and B (128-bits each, bit-reflected)
-* Output: C = A*B*x mod poly, (i.e. >>1 )
-* To compute GH = GH*HashKey mod poly, give HK = HashKey<<1 mod poly as input
-* GH = GH * HK * x mod poly which is equivalent to GH*HashKey mod poly.
-*
-*/
-.macro GHASH_MUL GH HK TMP1 TMP2 TMP3 TMP4 TMP5
-	movdqa	  \GH, \TMP1
-	pshufd	  $78, \GH, \TMP2
-	pshufd	  $78, \HK, \TMP3
-	pxor	  \GH, \TMP2            # TMP2 = a1+a0
-	pxor	  \HK, \TMP3            # TMP3 = b1+b0
-	pclmulqdq $0x11, \HK, \TMP1     # TMP1 = a1*b1
-	pclmulqdq $0x00, \HK, \GH       # GH = a0*b0
-	pclmulqdq $0x00, \TMP3, \TMP2   # TMP2 = (a0+a1)*(b1+b0)
-	pxor	  \GH, \TMP2
-	pxor	  \TMP1, \TMP2          # TMP2 = (a0*b0)+(a1*b0)
-	movdqa	  \TMP2, \TMP3
-	pslldq	  $8, \TMP3             # left shift TMP3 2 DWs
-	psrldq	  $8, \TMP2             # right shift TMP2 2 DWs
-	pxor	  \TMP3, \GH
-	pxor	  \TMP2, \TMP1          # TMP2:GH holds the result of GH*HK
-
-        # first phase of the reduction
-
-	movdqa    \GH, \TMP2
-	movdqa    \GH, \TMP3
-	movdqa    \GH, \TMP4            # copy GH into TMP2,TMP3 and TMP4
-					# in in order to perform
-					# independent shifts
-	pslld     $31, \TMP2            # packed right shift <<31
-	pslld     $30, \TMP3            # packed right shift <<30
-	pslld     $25, \TMP4            # packed right shift <<25
-	pxor      \TMP3, \TMP2          # xor the shifted versions
-	pxor      \TMP4, \TMP2
-	movdqa    \TMP2, \TMP5
-	psrldq    $4, \TMP5             # right shift TMP5 1 DW
-	pslldq    $12, \TMP2            # left shift TMP2 3 DWs
-	pxor      \TMP2, \GH
-
-        # second phase of the reduction
-
-	movdqa    \GH,\TMP2             # copy GH into TMP2,TMP3 and TMP4
-					# in in order to perform
-					# independent shifts
-	movdqa    \GH,\TMP3
-	movdqa    \GH,\TMP4
-	psrld     $1,\TMP2              # packed left shift >>1
-	psrld     $2,\TMP3              # packed left shift >>2
-	psrld     $7,\TMP4              # packed left shift >>7
-	pxor      \TMP3,\TMP2		# xor the shifted versions
-	pxor      \TMP4,\TMP2
-	pxor      \TMP5, \TMP2
-	pxor      \TMP2, \GH
-	pxor      \TMP1, \GH            # result is in TMP1
-.endm
-
-# Reads DLEN bytes starting at DPTR and stores in XMMDst
-# where 0 < DLEN < 16
-# Clobbers %rax, DLEN and XMM1
-.macro READ_PARTIAL_BLOCK DPTR DLEN XMM1 XMMDst
-        cmp $8, \DLEN
-        jl .L_read_lt8_\@
-        mov (\DPTR), %rax
-        movq %rax, \XMMDst
-        sub $8, \DLEN
-        jz .L_done_read_partial_block_\@
-	xor %eax, %eax
-.L_read_next_byte_\@:
-        shl $8, %rax
-        mov 7(\DPTR, \DLEN, 1), %al
-        dec \DLEN
-        jnz .L_read_next_byte_\@
-        movq %rax, \XMM1
-	pslldq $8, \XMM1
-        por \XMM1, \XMMDst
-	jmp .L_done_read_partial_block_\@
-.L_read_lt8_\@:
-	xor %eax, %eax
-.L_read_next_byte_lt8_\@:
-        shl $8, %rax
-        mov -1(\DPTR, \DLEN, 1), %al
-        dec \DLEN
-        jnz .L_read_next_byte_lt8_\@
-        movq %rax, \XMMDst
-.L_done_read_partial_block_\@:
-.endm
-
-# CALC_AAD_HASH: Calculates the hash of the data which will not be encrypted.
-# clobbers r10-11, xmm14
-.macro CALC_AAD_HASH HASHKEY AAD AADLEN TMP1 TMP2 TMP3 TMP4 TMP5 \
-	TMP6 TMP7
-	MOVADQ	   SHUF_MASK(%rip), %xmm14
-	mov	   \AAD, %r10		# %r10 = AAD
-	mov	   \AADLEN, %r11		# %r11 = aadLen
-	pxor	   \TMP7, \TMP7
-	pxor	   \TMP6, \TMP6
-
-	cmp	   $16, %r11
-	jl	   .L_get_AAD_rest\@
-.L_get_AAD_blocks\@:
-	movdqu	   (%r10), \TMP7
-	pshufb	   %xmm14, \TMP7 # byte-reflect the AAD data
-	pxor	   \TMP7, \TMP6
-	GHASH_MUL  \TMP6, \HASHKEY, \TMP1, \TMP2, \TMP3, \TMP4, \TMP5
-	add	   $16, %r10
-	sub	   $16, %r11
-	cmp	   $16, %r11
-	jge	   .L_get_AAD_blocks\@
-
-	movdqu	   \TMP6, \TMP7
-
-	/* read the last <16B of AAD */
-.L_get_AAD_rest\@:
-	test	   %r11, %r11
-	je	   .L_get_AAD_done\@
-
-	READ_PARTIAL_BLOCK %r10, %r11, \TMP1, \TMP7
-	pshufb	   %xmm14, \TMP7 # byte-reflect the AAD data
-	pxor	   \TMP6, \TMP7
-	GHASH_MUL  \TMP7, \HASHKEY, \TMP1, \TMP2, \TMP3, \TMP4, \TMP5
-	movdqu \TMP7, \TMP6
-
-.L_get_AAD_done\@:
-	movdqu \TMP6, AadHash(%arg2)
-.endm
-
-# PARTIAL_BLOCK: Handles encryption/decryption and the tag partial blocks
-# between update calls.
-# Requires the input data be at least 1 byte long due to READ_PARTIAL_BLOCK
-# Outputs encrypted bytes, and updates hash and partial info in gcm_data_context
-# Clobbers rax, r10, r12, r13, xmm0-6, xmm9-13
-.macro PARTIAL_BLOCK CYPH_PLAIN_OUT PLAIN_CYPH_IN PLAIN_CYPH_LEN DATA_OFFSET \
-	AAD_HASH operation
-	mov 	PBlockLen(%arg2), %r13
-	test	%r13, %r13
-	je	.L_partial_block_done_\@	# Leave Macro if no partial blocks
-	# Read in input data without over reading
-	cmp	$16, \PLAIN_CYPH_LEN
-	jl	.L_fewer_than_16_bytes_\@
-	movups	(\PLAIN_CYPH_IN), %xmm1	# If more than 16 bytes, just fill xmm
-	jmp	.L_data_read_\@
-
-.L_fewer_than_16_bytes_\@:
-	lea	(\PLAIN_CYPH_IN, \DATA_OFFSET, 1), %r10
-	mov	\PLAIN_CYPH_LEN, %r12
-	READ_PARTIAL_BLOCK %r10 %r12 %xmm0 %xmm1
-
-	mov PBlockLen(%arg2), %r13
-
-.L_data_read_\@:				# Finished reading in data
-
-	movdqu	PBlockEncKey(%arg2), %xmm9
-	movdqu	HashKey(%arg2), %xmm13
-
-	lea	SHIFT_MASK(%rip), %r12
-
-	# adjust the shuffle mask pointer to be able to shift r13 bytes
-	# r16-r13 is the number of bytes in plaintext mod 16)
-	add	%r13, %r12
-	movdqu	(%r12), %xmm2		# get the appropriate shuffle mask
-	pshufb	%xmm2, %xmm9		# shift right r13 bytes
-
-.ifc \operation, dec
-	movdqa	%xmm1, %xmm3
-	pxor	%xmm1, %xmm9		# Ciphertext XOR E(K, Yn)
-
-	mov	\PLAIN_CYPH_LEN, %r10
-	add	%r13, %r10
-	# Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
-	sub	$16, %r10
-	# Determine if partial block is not being filled and
-	# shift mask accordingly
-	jge	.L_no_extra_mask_1_\@
-	sub	%r10, %r12
-.L_no_extra_mask_1_\@:
-
-	movdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
-	# get the appropriate mask to mask out bottom r13 bytes of xmm9
-	pand	%xmm1, %xmm9		# mask out bottom r13 bytes of xmm9
-
-	pand	%xmm1, %xmm3
-	movdqa	SHUF_MASK(%rip), %xmm10
-	pshufb	%xmm10, %xmm3
-	pshufb	%xmm2, %xmm3
-	pxor	%xmm3, \AAD_HASH
-
-	test	%r10, %r10
-	jl	.L_partial_incomplete_1_\@
-
-	# GHASH computation for the last <16 Byte block
-	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
-	xor	%eax, %eax
-
-	mov	%rax, PBlockLen(%arg2)
-	jmp	.L_dec_done_\@
-.L_partial_incomplete_1_\@:
-	add	\PLAIN_CYPH_LEN, PBlockLen(%arg2)
-.L_dec_done_\@:
-	movdqu	\AAD_HASH, AadHash(%arg2)
-.else
-	pxor	%xmm1, %xmm9			# Plaintext XOR E(K, Yn)
-
-	mov	\PLAIN_CYPH_LEN, %r10
-	add	%r13, %r10
-	# Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
-	sub	$16, %r10
-	# Determine if partial block is not being filled and
-	# shift mask accordingly
-	jge	.L_no_extra_mask_2_\@
-	sub	%r10, %r12
-.L_no_extra_mask_2_\@:
-
-	movdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
-	# get the appropriate mask to mask out bottom r13 bytes of xmm9
-	pand	%xmm1, %xmm9
-
-	movdqa	SHUF_MASK(%rip), %xmm1
-	pshufb	%xmm1, %xmm9
-	pshufb	%xmm2, %xmm9
-	pxor	%xmm9, \AAD_HASH
-
-	test	%r10, %r10
-	jl	.L_partial_incomplete_2_\@
-
-	# GHASH computation for the last <16 Byte block
-	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
-	xor	%eax, %eax
-
-	mov	%rax, PBlockLen(%arg2)
-	jmp	.L_encode_done_\@
-.L_partial_incomplete_2_\@:
-	add	\PLAIN_CYPH_LEN, PBlockLen(%arg2)
-.L_encode_done_\@:
-	movdqu	\AAD_HASH, AadHash(%arg2)
-
-	movdqa	SHUF_MASK(%rip), %xmm10
-	# shuffle xmm9 back to output as ciphertext
-	pshufb	%xmm10, %xmm9
-	pshufb	%xmm2, %xmm9
-.endif
-	# output encrypted Bytes
-	test	%r10, %r10
-	jl	.L_partial_fill_\@
-	mov	%r13, %r12
-	mov	$16, %r13
-	# Set r13 to be the number of bytes to write out
-	sub	%r12, %r13
-	jmp	.L_count_set_\@
-.L_partial_fill_\@:
-	mov	\PLAIN_CYPH_LEN, %r13
-.L_count_set_\@:
-	movdqa	%xmm9, %xmm0
-	movq	%xmm0, %rax
-	cmp	$8, %r13
-	jle	.L_less_than_8_bytes_left_\@
-
-	mov	%rax, (\CYPH_PLAIN_OUT, \DATA_OFFSET, 1)
-	add	$8, \DATA_OFFSET
-	psrldq	$8, %xmm0
-	movq	%xmm0, %rax
-	sub	$8, %r13
-.L_less_than_8_bytes_left_\@:
-	movb	%al, (\CYPH_PLAIN_OUT, \DATA_OFFSET, 1)
-	add	$1, \DATA_OFFSET
-	shr	$8, %rax
-	sub	$1, %r13
-	jne	.L_less_than_8_bytes_left_\@
-.L_partial_block_done_\@:
-.endm # PARTIAL_BLOCK
-
-/*
-* if a = number of total plaintext bytes
-* b = floor(a/16)
-* num_initial_blocks = b mod 4
-* encrypt the initial num_initial_blocks blocks and apply ghash on
-* the ciphertext
-* %r10, %r11, %r12, %rax, %xmm5, %xmm6, %xmm7, %xmm8, %xmm9 registers
-* are clobbered
-* arg1, %arg2, %arg3 are used as a pointer only, not modified
-*/
-
-
-.macro INITIAL_BLOCKS_ENC_DEC TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
-	XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
-	MOVADQ		SHUF_MASK(%rip), %xmm14
-
-	movdqu AadHash(%arg2), %xmm\i		    # XMM0 = Y0
-
-	# start AES for num_initial_blocks blocks
-
-	movdqu CurCount(%arg2), \XMM0                # XMM0 = Y0
-
-.if (\i == 5) || (\i == 6) || (\i == 7)
-
-	MOVADQ		ONE(%RIP),\TMP1
-	MOVADQ		0(%arg1),\TMP2
-.irpc index, \i_seq
-	paddd		\TMP1, \XMM0                 # INCR Y0
-.ifc \operation, dec
-        movdqa     \XMM0, %xmm\index
-.else
-	MOVADQ		\XMM0, %xmm\index
-.endif
-	pshufb	%xmm14, %xmm\index      # perform a 16 byte swap
-	pxor		\TMP2, %xmm\index
-.endr
-	lea	0x10(%arg1),%r10
-	mov	keysize,%eax
-	shr	$2,%eax				# 128->4, 192->6, 256->8
-	add	$5,%eax			      # 128->9, 192->11, 256->13
-
-.Laes_loop_initial_\@:
-	MOVADQ	(%r10),\TMP1
-.irpc	index, \i_seq
-	aesenc	\TMP1, %xmm\index
-.endr
-	add	$16,%r10
-	sub	$1,%eax
-	jnz	.Laes_loop_initial_\@
-
-	MOVADQ	(%r10), \TMP1
-.irpc index, \i_seq
-	aesenclast \TMP1, %xmm\index         # Last Round
-.endr
-.irpc index, \i_seq
-	movdqu	   (%arg4 , %r11, 1), \TMP1
-	pxor	   \TMP1, %xmm\index
-	movdqu	   %xmm\index, (%arg3 , %r11, 1)
-	# write back plaintext/ciphertext for num_initial_blocks
-	add	   $16, %r11
-
-.ifc \operation, dec
-	movdqa     \TMP1, %xmm\index
-.endif
-	pshufb	   %xmm14, %xmm\index
-
-		# prepare plaintext/ciphertext for GHASH computation
-.endr
-.endif
-
-        # apply GHASH on num_initial_blocks blocks
-
-.if \i == 5
-        pxor       %xmm5, %xmm6
-	GHASH_MUL  %xmm6, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-        pxor       %xmm6, %xmm7
-	GHASH_MUL  %xmm7, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-        pxor       %xmm7, %xmm8
-	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-.elseif \i == 6
-        pxor       %xmm6, %xmm7
-	GHASH_MUL  %xmm7, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-        pxor       %xmm7, %xmm8
-	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-.elseif \i == 7
-        pxor       %xmm7, %xmm8
-	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-.endif
-	cmp	   $64, %r13
-	jl	.L_initial_blocks_done\@
-	# no need for precomputed values
-/*
-*
-* Precomputations for HashKey parallel with encryption of first 4 blocks.
-* Haskey_i_k holds XORed values of the low and high parts of the Haskey_i
-*/
-	MOVADQ	   ONE(%RIP),\TMP1
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM1
-	pshufb  %xmm14, \XMM1        # perform a 16 byte swap
-
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM2
-	pshufb  %xmm14, \XMM2        # perform a 16 byte swap
-
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM3
-	pshufb %xmm14, \XMM3        # perform a 16 byte swap
-
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM4
-	pshufb %xmm14, \XMM4        # perform a 16 byte swap
-
-	MOVADQ	   0(%arg1),\TMP1
-	pxor	   \TMP1, \XMM1
-	pxor	   \TMP1, \XMM2
-	pxor	   \TMP1, \XMM3
-	pxor	   \TMP1, \XMM4
-.irpc index, 1234 # do 4 rounds
-	movaps 0x10*\index(%arg1), \TMP1
-	aesenc	   \TMP1, \XMM1
-	aesenc	   \TMP1, \XMM2
-	aesenc	   \TMP1, \XMM3
-	aesenc	   \TMP1, \XMM4
-.endr
-.irpc index, 56789 # do next 5 rounds
-	movaps 0x10*\index(%arg1), \TMP1
-	aesenc	   \TMP1, \XMM1
-	aesenc	   \TMP1, \XMM2
-	aesenc	   \TMP1, \XMM3
-	aesenc	   \TMP1, \XMM4
-.endr
-	lea	   0xa0(%arg1),%r10
-	mov	   keysize,%eax
-	shr	   $2,%eax			# 128->4, 192->6, 256->8
-	sub	   $4,%eax			# 128->0, 192->2, 256->4
-	jz	   .Laes_loop_pre_done\@
-
-.Laes_loop_pre_\@:
-	MOVADQ	   (%r10),\TMP2
-.irpc	index, 1234
-	aesenc	   \TMP2, %xmm\index
-.endr
-	add	   $16,%r10
-	sub	   $1,%eax
-	jnz	   .Laes_loop_pre_\@
-
-.Laes_loop_pre_done\@:
-	MOVADQ	   (%r10), \TMP2
-	aesenclast \TMP2, \XMM1
-	aesenclast \TMP2, \XMM2
-	aesenclast \TMP2, \XMM3
-	aesenclast \TMP2, \XMM4
-	movdqu	   16*0(%arg4 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM1
-.ifc \operation, dec
-	movdqu     \XMM1, 16*0(%arg3 , %r11 , 1)
-	movdqa     \TMP1, \XMM1
-.endif
-	movdqu	   16*1(%arg4 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM2
-.ifc \operation, dec
-	movdqu     \XMM2, 16*1(%arg3 , %r11 , 1)
-	movdqa     \TMP1, \XMM2
-.endif
-	movdqu	   16*2(%arg4 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM3
-.ifc \operation, dec
-	movdqu     \XMM3, 16*2(%arg3 , %r11 , 1)
-	movdqa     \TMP1, \XMM3
-.endif
-	movdqu	   16*3(%arg4 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM4
-.ifc \operation, dec
-	movdqu     \XMM4, 16*3(%arg3 , %r11 , 1)
-	movdqa     \TMP1, \XMM4
-.else
-	movdqu     \XMM1, 16*0(%arg3 , %r11 , 1)
-	movdqu     \XMM2, 16*1(%arg3 , %r11 , 1)
-	movdqu     \XMM3, 16*2(%arg3 , %r11 , 1)
-	movdqu     \XMM4, 16*3(%arg3 , %r11 , 1)
-.endif
-
-	add	   $64, %r11
-	pshufb %xmm14, \XMM1 # perform a 16 byte swap
-	pxor	   \XMMDst, \XMM1
-# combine GHASHed value with the corresponding ciphertext
-	pshufb %xmm14, \XMM2 # perform a 16 byte swap
-	pshufb %xmm14, \XMM3 # perform a 16 byte swap
-	pshufb %xmm14, \XMM4 # perform a 16 byte swap
-
-.L_initial_blocks_done\@:
-
-.endm
-
-/*
-* encrypt 4 blocks at a time
-* ghash the 4 previously encrypted ciphertext blocks
-* arg1, %arg3, %arg4 are used as pointers only, not modified
-* %r11 is the data offset value
-*/
-.macro GHASH_4_ENCRYPT_4_PARALLEL_enc TMP1 TMP2 TMP3 TMP4 TMP5 \
-TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
-
-	movdqa	  \XMM1, \XMM5
-	movdqa	  \XMM2, \XMM6
-	movdqa	  \XMM3, \XMM7
-	movdqa	  \XMM4, \XMM8
-
-        movdqa    SHUF_MASK(%rip), %xmm15
-        # multiply TMP5 * HashKey using karatsuba
-
-	movdqa	  \XMM5, \TMP4
-	pshufd	  $78, \XMM5, \TMP6
-	pxor	  \XMM5, \TMP6
-	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqu	  HashKey_4(%arg2), \TMP5
-	pclmulqdq $0x11, \TMP5, \TMP4           # TMP4 = a1*b1
-	movdqa    \XMM0, \XMM1
-	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqa    \XMM0, \XMM2
-	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqa    \XMM0, \XMM3
-	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqa    \XMM0, \XMM4
-	pshufb %xmm15, \XMM1	# perform a 16 byte swap
-	pclmulqdq $0x00, \TMP5, \XMM5           # XMM5 = a0*b0
-	pshufb %xmm15, \XMM2	# perform a 16 byte swap
-	pshufb %xmm15, \XMM3	# perform a 16 byte swap
-	pshufb %xmm15, \XMM4	# perform a 16 byte swap
-
-	pxor	  (%arg1), \XMM1
-	pxor	  (%arg1), \XMM2
-	pxor	  (%arg1), \XMM3
-	pxor	  (%arg1), \XMM4
-	movdqu	  HashKey_4_k(%arg2), \TMP5
-	pclmulqdq $0x00, \TMP5, \TMP6       # TMP6 = (a1+a0)*(b1+b0)
-	movaps 0x10(%arg1), \TMP1
-	aesenc	  \TMP1, \XMM1              # Round 1
-	aesenc	  \TMP1, \XMM2
-	aesenc	  \TMP1, \XMM3
-	aesenc	  \TMP1, \XMM4
-	movaps 0x20(%arg1), \TMP1
-	aesenc	  \TMP1, \XMM1              # Round 2
-	aesenc	  \TMP1, \XMM2
-	aesenc	  \TMP1, \XMM3
-	aesenc	  \TMP1, \XMM4
-	movdqa	  \XMM6, \TMP1
-	pshufd	  $78, \XMM6, \TMP2
-	pxor	  \XMM6, \TMP2
-	movdqu	  HashKey_3(%arg2), \TMP5
-	pclmulqdq $0x11, \TMP5, \TMP1       # TMP1 = a1 * b1
-	movaps 0x30(%arg1), \TMP3
-	aesenc    \TMP3, \XMM1              # Round 3
-	aesenc    \TMP3, \XMM2
-	aesenc    \TMP3, \XMM3
-	aesenc    \TMP3, \XMM4
-	pclmulqdq $0x00, \TMP5, \XMM6       # XMM6 = a0*b0
-	movaps 0x40(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1              # Round 4
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	movdqu	  HashKey_3_k(%arg2), \TMP5
-	pclmulqdq $0x00, \TMP5, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
-	movaps 0x50(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1              # Round 5
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	pxor	  \TMP1, \TMP4
-# accumulate the results in TMP4:XMM5, TMP6 holds the middle part
-	pxor	  \XMM6, \XMM5
-	pxor	  \TMP2, \TMP6
-	movdqa	  \XMM7, \TMP1
-	pshufd	  $78, \XMM7, \TMP2
-	pxor	  \XMM7, \TMP2
-	movdqu	  HashKey_2(%arg2), \TMP5
-
-        # Multiply TMP5 * HashKey using karatsuba
-
-	pclmulqdq $0x11, \TMP5, \TMP1       # TMP1 = a1*b1
-	movaps 0x60(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1              # Round 6
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	pclmulqdq $0x00, \TMP5, \XMM7       # XMM7 = a0*b0
-	movaps 0x70(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1              # Round 7
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	movdqu	  HashKey_2_k(%arg2), \TMP5
-	pclmulqdq $0x00, \TMP5, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
-	movaps 0x80(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1              # Round 8
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	pxor	  \TMP1, \TMP4
-# accumulate the results in TMP4:XMM5, TMP6 holds the middle part
-	pxor	  \XMM7, \XMM5
-	pxor	  \TMP2, \TMP6
-
-        # Multiply XMM8 * HashKey
-        # XMM8 and TMP5 hold the values for the two operands
-
-	movdqa	  \XMM8, \TMP1
-	pshufd	  $78, \XMM8, \TMP2
-	pxor	  \XMM8, \TMP2
-	movdqu	  HashKey(%arg2), \TMP5
-	pclmulqdq $0x11, \TMP5, \TMP1      # TMP1 = a1*b1
-	movaps 0x90(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1             # Round 9
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	pclmulqdq $0x00, \TMP5, \XMM8      # XMM8 = a0*b0
-	lea	  0xa0(%arg1),%r10
-	mov	  keysize,%eax
-	shr	  $2,%eax			# 128->4, 192->6, 256->8
-	sub	  $4,%eax			# 128->0, 192->2, 256->4
-	jz	  .Laes_loop_par_enc_done\@
-
-.Laes_loop_par_enc\@:
-	MOVADQ	  (%r10),\TMP3
-.irpc	index, 1234
-	aesenc	  \TMP3, %xmm\index
-.endr
-	add	  $16,%r10
-	sub	  $1,%eax
-	jnz	  .Laes_loop_par_enc\@
-
-.Laes_loop_par_enc_done\@:
-	MOVADQ	  (%r10), \TMP3
-	aesenclast \TMP3, \XMM1           # Round 10
-	aesenclast \TMP3, \XMM2
-	aesenclast \TMP3, \XMM3
-	aesenclast \TMP3, \XMM4
-	movdqu    HashKey_k(%arg2), \TMP5
-	pclmulqdq $0x00, \TMP5, \TMP2          # TMP2 = (a1+a0)*(b1+b0)
-	movdqu	  (%arg4,%r11,1), \TMP3
-	pxor	  \TMP3, \XMM1                 # Ciphertext/Plaintext XOR EK
-	movdqu	  16(%arg4,%r11,1), \TMP3
-	pxor	  \TMP3, \XMM2                 # Ciphertext/Plaintext XOR EK
-	movdqu	  32(%arg4,%r11,1), \TMP3
-	pxor	  \TMP3, \XMM3                 # Ciphertext/Plaintext XOR EK
-	movdqu	  48(%arg4,%r11,1), \TMP3
-	pxor	  \TMP3, \XMM4                 # Ciphertext/Plaintext XOR EK
-        movdqu    \XMM1, (%arg3,%r11,1)        # Write to the ciphertext buffer
-        movdqu    \XMM2, 16(%arg3,%r11,1)      # Write to the ciphertext buffer
-        movdqu    \XMM3, 32(%arg3,%r11,1)      # Write to the ciphertext buffer
-        movdqu    \XMM4, 48(%arg3,%r11,1)      # Write to the ciphertext buffer
-	pshufb %xmm15, \XMM1        # perform a 16 byte swap
-	pshufb %xmm15, \XMM2	# perform a 16 byte swap
-	pshufb %xmm15, \XMM3	# perform a 16 byte swap
-	pshufb %xmm15, \XMM4	# perform a 16 byte swap
-
-	pxor	  \TMP4, \TMP1
-	pxor	  \XMM8, \XMM5
-	pxor	  \TMP6, \TMP2
-	pxor	  \TMP1, \TMP2
-	pxor	  \XMM5, \TMP2
-	movdqa	  \TMP2, \TMP3
-	pslldq	  $8, \TMP3                    # left shift TMP3 2 DWs
-	psrldq	  $8, \TMP2                    # right shift TMP2 2 DWs
-	pxor	  \TMP3, \XMM5
-	pxor	  \TMP2, \TMP1	  # accumulate the results in TMP1:XMM5
-
-        # first phase of reduction
-
-	movdqa    \XMM5, \TMP2
-	movdqa    \XMM5, \TMP3
-	movdqa    \XMM5, \TMP4
-# move XMM5 into TMP2, TMP3, TMP4 in order to perform shifts independently
-	pslld     $31, \TMP2                   # packed right shift << 31
-	pslld     $30, \TMP3                   # packed right shift << 30
-	pslld     $25, \TMP4                   # packed right shift << 25
-	pxor      \TMP3, \TMP2	               # xor the shifted versions
-	pxor      \TMP4, \TMP2
-	movdqa    \TMP2, \TMP5
-	psrldq    $4, \TMP5                    # right shift T5 1 DW
-	pslldq    $12, \TMP2                   # left shift T2 3 DWs
-	pxor      \TMP2, \XMM5
-
-        # second phase of reduction
-
-	movdqa    \XMM5,\TMP2 # make 3 copies of XMM5 into TMP2, TMP3, TMP4
-	movdqa    \XMM5,\TMP3
-	movdqa    \XMM5,\TMP4
-	psrld     $1, \TMP2                    # packed left shift >>1
-	psrld     $2, \TMP3                    # packed left shift >>2
-	psrld     $7, \TMP4                    # packed left shift >>7
-	pxor      \TMP3,\TMP2		       # xor the shifted versions
-	pxor      \TMP4,\TMP2
-	pxor      \TMP5, \TMP2
-	pxor      \TMP2, \XMM5
-	pxor      \TMP1, \XMM5                 # result is in TMP1
-
-	pxor	  \XMM5, \XMM1
-.endm
-
-/*
-* decrypt 4 blocks at a time
-* ghash the 4 previously decrypted ciphertext blocks
-* arg1, %arg3, %arg4 are used as pointers only, not modified
-* %r11 is the data offset value
-*/
-.macro GHASH_4_ENCRYPT_4_PARALLEL_dec TMP1 TMP2 TMP3 TMP4 TMP5 \
-TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
-
-	movdqa	  \XMM1, \XMM5
-	movdqa	  \XMM2, \XMM6
-	movdqa	  \XMM3, \XMM7
-	movdqa	  \XMM4, \XMM8
-
-        movdqa    SHUF_MASK(%rip), %xmm15
-        # multiply TMP5 * HashKey using karatsuba
-
-	movdqa	  \XMM5, \TMP4
-	pshufd	  $78, \XMM5, \TMP6
-	pxor	  \XMM5, \TMP6
-	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqu	  HashKey_4(%arg2), \TMP5
-	pclmulqdq $0x11, \TMP5, \TMP4           # TMP4 = a1*b1
-	movdqa    \XMM0, \XMM1
-	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqa    \XMM0, \XMM2
-	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqa    \XMM0, \XMM3
-	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqa    \XMM0, \XMM4
-	pshufb %xmm15, \XMM1	# perform a 16 byte swap
-	pclmulqdq $0x00, \TMP5, \XMM5           # XMM5 = a0*b0
-	pshufb %xmm15, \XMM2	# perform a 16 byte swap
-	pshufb %xmm15, \XMM3	# perform a 16 byte swap
-	pshufb %xmm15, \XMM4	# perform a 16 byte swap
-
-	pxor	  (%arg1), \XMM1
-	pxor	  (%arg1), \XMM2
-	pxor	  (%arg1), \XMM3
-	pxor	  (%arg1), \XMM4
-	movdqu	  HashKey_4_k(%arg2), \TMP5
-	pclmulqdq $0x00, \TMP5, \TMP6       # TMP6 = (a1+a0)*(b1+b0)
-	movaps 0x10(%arg1), \TMP1
-	aesenc	  \TMP1, \XMM1              # Round 1
-	aesenc	  \TMP1, \XMM2
-	aesenc	  \TMP1, \XMM3
-	aesenc	  \TMP1, \XMM4
-	movaps 0x20(%arg1), \TMP1
-	aesenc	  \TMP1, \XMM1              # Round 2
-	aesenc	  \TMP1, \XMM2
-	aesenc	  \TMP1, \XMM3
-	aesenc	  \TMP1, \XMM4
-	movdqa	  \XMM6, \TMP1
-	pshufd	  $78, \XMM6, \TMP2
-	pxor	  \XMM6, \TMP2
-	movdqu	  HashKey_3(%arg2), \TMP5
-	pclmulqdq $0x11, \TMP5, \TMP1       # TMP1 = a1 * b1
-	movaps 0x30(%arg1), \TMP3
-	aesenc    \TMP3, \XMM1              # Round 3
-	aesenc    \TMP3, \XMM2
-	aesenc    \TMP3, \XMM3
-	aesenc    \TMP3, \XMM4
-	pclmulqdq $0x00, \TMP5, \XMM6       # XMM6 = a0*b0
-	movaps 0x40(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1              # Round 4
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	movdqu	  HashKey_3_k(%arg2), \TMP5
-	pclmulqdq $0x00, \TMP5, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
-	movaps 0x50(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1              # Round 5
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	pxor	  \TMP1, \TMP4
-# accumulate the results in TMP4:XMM5, TMP6 holds the middle part
-	pxor	  \XMM6, \XMM5
-	pxor	  \TMP2, \TMP6
-	movdqa	  \XMM7, \TMP1
-	pshufd	  $78, \XMM7, \TMP2
-	pxor	  \XMM7, \TMP2
-	movdqu	  HashKey_2(%arg2), \TMP5
-
-        # Multiply TMP5 * HashKey using karatsuba
-
-	pclmulqdq $0x11, \TMP5, \TMP1       # TMP1 = a1*b1
-	movaps 0x60(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1              # Round 6
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	pclmulqdq $0x00, \TMP5, \XMM7       # XMM7 = a0*b0
-	movaps 0x70(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1              # Round 7
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	movdqu	  HashKey_2_k(%arg2), \TMP5
-	pclmulqdq $0x00, \TMP5, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
-	movaps 0x80(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1              # Round 8
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	pxor	  \TMP1, \TMP4
-# accumulate the results in TMP4:XMM5, TMP6 holds the middle part
-	pxor	  \XMM7, \XMM5
-	pxor	  \TMP2, \TMP6
-
-        # Multiply XMM8 * HashKey
-        # XMM8 and TMP5 hold the values for the two operands
-
-	movdqa	  \XMM8, \TMP1
-	pshufd	  $78, \XMM8, \TMP2
-	pxor	  \XMM8, \TMP2
-	movdqu	  HashKey(%arg2), \TMP5
-	pclmulqdq $0x11, \TMP5, \TMP1      # TMP1 = a1*b1
-	movaps 0x90(%arg1), \TMP3
-	aesenc	  \TMP3, \XMM1             # Round 9
-	aesenc	  \TMP3, \XMM2
-	aesenc	  \TMP3, \XMM3
-	aesenc	  \TMP3, \XMM4
-	pclmulqdq $0x00, \TMP5, \XMM8      # XMM8 = a0*b0
-	lea	  0xa0(%arg1),%r10
-	mov	  keysize,%eax
-	shr	  $2,%eax		        # 128->4, 192->6, 256->8
-	sub	  $4,%eax			# 128->0, 192->2, 256->4
-	jz	  .Laes_loop_par_dec_done\@
-
-.Laes_loop_par_dec\@:
-	MOVADQ	  (%r10),\TMP3
-.irpc	index, 1234
-	aesenc	  \TMP3, %xmm\index
-.endr
-	add	  $16,%r10
-	sub	  $1,%eax
-	jnz	  .Laes_loop_par_dec\@
-
-.Laes_loop_par_dec_done\@:
-	MOVADQ	  (%r10), \TMP3
-	aesenclast \TMP3, \XMM1           # last round
-	aesenclast \TMP3, \XMM2
-	aesenclast \TMP3, \XMM3
-	aesenclast \TMP3, \XMM4
-	movdqu    HashKey_k(%arg2), \TMP5
-	pclmulqdq $0x00, \TMP5, \TMP2          # TMP2 = (a1+a0)*(b1+b0)
-	movdqu	  (%arg4,%r11,1), \TMP3
-	pxor	  \TMP3, \XMM1                 # Ciphertext/Plaintext XOR EK
-	movdqu	  \XMM1, (%arg3,%r11,1)        # Write to plaintext buffer
-	movdqa    \TMP3, \XMM1
-	movdqu	  16(%arg4,%r11,1), \TMP3
-	pxor	  \TMP3, \XMM2                 # Ciphertext/Plaintext XOR EK
-	movdqu	  \XMM2, 16(%arg3,%r11,1)      # Write to plaintext buffer
-	movdqa    \TMP3, \XMM2
-	movdqu	  32(%arg4,%r11,1), \TMP3
-	pxor	  \TMP3, \XMM3                 # Ciphertext/Plaintext XOR EK
-	movdqu	  \XMM3, 32(%arg3,%r11,1)      # Write to plaintext buffer
-	movdqa    \TMP3, \XMM3
-	movdqu	  48(%arg4,%r11,1), \TMP3
-	pxor	  \TMP3, \XMM4                 # Ciphertext/Plaintext XOR EK
-	movdqu	  \XMM4, 48(%arg3,%r11,1)      # Write to plaintext buffer
-	movdqa    \TMP3, \XMM4
-	pshufb %xmm15, \XMM1        # perform a 16 byte swap
-	pshufb %xmm15, \XMM2	# perform a 16 byte swap
-	pshufb %xmm15, \XMM3	# perform a 16 byte swap
-	pshufb %xmm15, \XMM4	# perform a 16 byte swap
-
-	pxor	  \TMP4, \TMP1
-	pxor	  \XMM8, \XMM5
-	pxor	  \TMP6, \TMP2
-	pxor	  \TMP1, \TMP2
-	pxor	  \XMM5, \TMP2
-	movdqa	  \TMP2, \TMP3
-	pslldq	  $8, \TMP3                    # left shift TMP3 2 DWs
-	psrldq	  $8, \TMP2                    # right shift TMP2 2 DWs
-	pxor	  \TMP3, \XMM5
-	pxor	  \TMP2, \TMP1	  # accumulate the results in TMP1:XMM5
-
-        # first phase of reduction
-
-	movdqa    \XMM5, \TMP2
-	movdqa    \XMM5, \TMP3
-	movdqa    \XMM5, \TMP4
-# move XMM5 into TMP2, TMP3, TMP4 in order to perform shifts independently
-	pslld     $31, \TMP2                   # packed right shift << 31
-	pslld     $30, \TMP3                   # packed right shift << 30
-	pslld     $25, \TMP4                   # packed right shift << 25
-	pxor      \TMP3, \TMP2	               # xor the shifted versions
-	pxor      \TMP4, \TMP2
-	movdqa    \TMP2, \TMP5
-	psrldq    $4, \TMP5                    # right shift T5 1 DW
-	pslldq    $12, \TMP2                   # left shift T2 3 DWs
-	pxor      \TMP2, \XMM5
-
-        # second phase of reduction
-
-	movdqa    \XMM5,\TMP2 # make 3 copies of XMM5 into TMP2, TMP3, TMP4
-	movdqa    \XMM5,\TMP3
-	movdqa    \XMM5,\TMP4
-	psrld     $1, \TMP2                    # packed left shift >>1
-	psrld     $2, \TMP3                    # packed left shift >>2
-	psrld     $7, \TMP4                    # packed left shift >>7
-	pxor      \TMP3,\TMP2		       # xor the shifted versions
-	pxor      \TMP4,\TMP2
-	pxor      \TMP5, \TMP2
-	pxor      \TMP2, \XMM5
-	pxor      \TMP1, \XMM5                 # result is in TMP1
-
-	pxor	  \XMM5, \XMM1
-.endm
-
-/* GHASH the last 4 ciphertext blocks. */
-.macro	GHASH_LAST_4 TMP1 TMP2 TMP3 TMP4 TMP5 TMP6 \
-TMP7 XMM1 XMM2 XMM3 XMM4 XMMDst
-
-        # Multiply TMP6 * HashKey (using Karatsuba)
-
-	movdqa	  \XMM1, \TMP6
-	pshufd	  $78, \XMM1, \TMP2
-	pxor	  \XMM1, \TMP2
-	movdqu	  HashKey_4(%arg2), \TMP5
-	pclmulqdq $0x11, \TMP5, \TMP6       # TMP6 = a1*b1
-	pclmulqdq $0x00, \TMP5, \XMM1       # XMM1 = a0*b0
-	movdqu	  HashKey_4_k(%arg2), \TMP4
-	pclmulqdq $0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
-	movdqa	  \XMM1, \XMMDst
-	movdqa	  \TMP2, \XMM1              # result in TMP6, XMMDst, XMM1
-
-        # Multiply TMP1 * HashKey (using Karatsuba)
-
-	movdqa	  \XMM2, \TMP1
-	pshufd	  $78, \XMM2, \TMP2
-	pxor	  \XMM2, \TMP2
-	movdqu	  HashKey_3(%arg2), \TMP5
-	pclmulqdq $0x11, \TMP5, \TMP1       # TMP1 = a1*b1
-	pclmulqdq $0x00, \TMP5, \XMM2       # XMM2 = a0*b0
-	movdqu	  HashKey_3_k(%arg2), \TMP4
-	pclmulqdq $0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
-	pxor	  \TMP1, \TMP6
-	pxor	  \XMM2, \XMMDst
-	pxor	  \TMP2, \XMM1
-# results accumulated in TMP6, XMMDst, XMM1
-
-        # Multiply TMP1 * HashKey (using Karatsuba)
-
-	movdqa	  \XMM3, \TMP1
-	pshufd	  $78, \XMM3, \TMP2
-	pxor	  \XMM3, \TMP2
-	movdqu	  HashKey_2(%arg2), \TMP5
-	pclmulqdq $0x11, \TMP5, \TMP1       # TMP1 = a1*b1
-	pclmulqdq $0x00, \TMP5, \XMM3       # XMM3 = a0*b0
-	movdqu	  HashKey_2_k(%arg2), \TMP4
-	pclmulqdq $0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
-	pxor	  \TMP1, \TMP6
-	pxor	  \XMM3, \XMMDst
-	pxor	  \TMP2, \XMM1   # results accumulated in TMP6, XMMDst, XMM1
-
-        # Multiply TMP1 * HashKey (using Karatsuba)
-	movdqa	  \XMM4, \TMP1
-	pshufd	  $78, \XMM4, \TMP2
-	pxor	  \XMM4, \TMP2
-	movdqu	  HashKey(%arg2), \TMP5
-	pclmulqdq $0x11, \TMP5, \TMP1	    # TMP1 = a1*b1
-	pclmulqdq $0x00, \TMP5, \XMM4       # XMM4 = a0*b0
-	movdqu	  HashKey_k(%arg2), \TMP4
-	pclmulqdq $0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
-	pxor	  \TMP1, \TMP6
-	pxor	  \XMM4, \XMMDst
-	pxor	  \XMM1, \TMP2
-	pxor	  \TMP6, \TMP2
-	pxor	  \XMMDst, \TMP2
-	# middle section of the temp results combined as in karatsuba algorithm
-	movdqa	  \TMP2, \TMP4
-	pslldq	  $8, \TMP4                 # left shift TMP4 2 DWs
-	psrldq	  $8, \TMP2                 # right shift TMP2 2 DWs
-	pxor	  \TMP4, \XMMDst
-	pxor	  \TMP2, \TMP6
-# TMP6:XMMDst holds the result of the accumulated carry-less multiplications
-	# first phase of the reduction
-	movdqa    \XMMDst, \TMP2
-	movdqa    \XMMDst, \TMP3
-	movdqa    \XMMDst, \TMP4
-# move XMMDst into TMP2, TMP3, TMP4 in order to perform 3 shifts independently
-	pslld     $31, \TMP2                # packed right shifting << 31
-	pslld     $30, \TMP3                # packed right shifting << 30
-	pslld     $25, \TMP4                # packed right shifting << 25
-	pxor      \TMP3, \TMP2              # xor the shifted versions
-	pxor      \TMP4, \TMP2
-	movdqa    \TMP2, \TMP7
-	psrldq    $4, \TMP7                 # right shift TMP7 1 DW
-	pslldq    $12, \TMP2                # left shift TMP2 3 DWs
-	pxor      \TMP2, \XMMDst
-
-        # second phase of the reduction
-	movdqa    \XMMDst, \TMP2
-	# make 3 copies of XMMDst for doing 3 shift operations
-	movdqa    \XMMDst, \TMP3
-	movdqa    \XMMDst, \TMP4
-	psrld     $1, \TMP2                 # packed left shift >> 1
-	psrld     $2, \TMP3                 # packed left shift >> 2
-	psrld     $7, \TMP4                 # packed left shift >> 7
-	pxor      \TMP3, \TMP2              # xor the shifted versions
-	pxor      \TMP4, \TMP2
-	pxor      \TMP7, \TMP2
-	pxor      \TMP2, \XMMDst
-	pxor      \TMP6, \XMMDst            # reduced result is in XMMDst
-.endm
-
-
-/* Encryption of a single block
-* uses eax & r10
-*/
-
-.macro ENCRYPT_SINGLE_BLOCK XMM0 TMP1
-
-	pxor		(%arg1), \XMM0
-	mov		keysize,%eax
-	shr		$2,%eax			# 128->4, 192->6, 256->8
-	add		$5,%eax			# 128->9, 192->11, 256->13
-	lea		16(%arg1), %r10	  # get first expanded key address
-
-_esb_loop_\@:
-	MOVADQ		(%r10),\TMP1
-	aesenc		\TMP1,\XMM0
-	add		$16,%r10
-	sub		$1,%eax
-	jnz		_esb_loop_\@
-
-	MOVADQ		(%r10),\TMP1
-	aesenclast	\TMP1,\XMM0
-.endm
-
-/*****************************************************************************
-* void aesni_gcm_init(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
-*                     struct gcm_context_data *data,
-*                                         // context data
-*                     u8 *iv,             // Pre-counter block j0: 4 byte salt (from Security Association)
-*                                         // concatenated with 8 byte Initialisation Vector (from IPSec ESP Payload)
-*                                         // concatenated with 0x00000001. 16-byte aligned pointer.
-*                     u8 *hash_subkey,    // H, the Hash sub key input. Data starts on a 16-byte boundary.
-*                     const u8 *aad,      // Additional Authentication Data (AAD)
-*                     u64 aad_len)        // Length of AAD in bytes.
-*/
-SYM_FUNC_START(aesni_gcm_init)
-	FUNC_SAVE
-	GCM_INIT %arg3, %arg4,%arg5, %arg6
-	FUNC_RESTORE
-	RET
-SYM_FUNC_END(aesni_gcm_init)
-
-/*****************************************************************************
-* void aesni_gcm_enc_update(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
-*                    struct gcm_context_data *data,
-*                                        // context data
-*                    u8 *out,            // Ciphertext output. Encrypt in-place is allowed.
-*                    const u8 *in,       // Plaintext input
-*                    u64 plaintext_len,  // Length of data in bytes for encryption.
-*/
-SYM_FUNC_START(aesni_gcm_enc_update)
-	FUNC_SAVE
-	GCM_ENC_DEC enc
-	FUNC_RESTORE
-	RET
-SYM_FUNC_END(aesni_gcm_enc_update)
-
-/*****************************************************************************
-* void aesni_gcm_dec_update(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
-*                    struct gcm_context_data *data,
-*                                        // context data
-*                    u8 *out,            // Ciphertext output. Encrypt in-place is allowed.
-*                    const u8 *in,       // Plaintext input
-*                    u64 plaintext_len,  // Length of data in bytes for encryption.
-*/
-SYM_FUNC_START(aesni_gcm_dec_update)
-	FUNC_SAVE
-	GCM_ENC_DEC dec
-	FUNC_RESTORE
-	RET
-SYM_FUNC_END(aesni_gcm_dec_update)
-
-/*****************************************************************************
-* void aesni_gcm_finalize(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
-*                    struct gcm_context_data *data,
-*                                        // context data
-*                    u8 *auth_tag,       // Authenticated Tag output.
-*                    u64 auth_tag_len);  // Authenticated Tag Length in bytes. Valid values are 16 (most likely),
-*                                        // 12 or 8.
-*/
-SYM_FUNC_START(aesni_gcm_finalize)
-	FUNC_SAVE
-	GCM_COMPLETE %arg3 %arg4
-	FUNC_RESTORE
-	RET
-SYM_FUNC_END(aesni_gcm_finalize)
-
-#endif
-
 SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	pshufd $0b11111111, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
 	pxor %xmm4, %xmm0
 	shufps $0b10001100, %xmm0, %xmm4
diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
deleted file mode 100644
index 8c9749ed0651..000000000000
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ /dev/null
@@ -1,2804 +0,0 @@
-########################################################################
-# Copyright (c) 2013, Intel Corporation
-#
-# This software is available to you under a choice of one of two
-# licenses.  You may choose to be licensed under the terms of the GNU
-# General Public License (GPL) Version 2, available from the file
-# COPYING in the main directory of this source tree, or the
-# OpenIB.org BSD license below:
-#
-# Redistribution and use in source and binary forms, with or without
-# modification, are permitted provided that the following conditions are
-# met:
-#
-# * Redistributions of source code must retain the above copyright
-#   notice, this list of conditions and the following disclaimer.
-#
-# * Redistributions in binary form must reproduce the above copyright
-#   notice, this list of conditions and the following disclaimer in the
-#   documentation and/or other materials provided with the
-#   distribution.
-#
-# * Neither the name of the Intel Corporation nor the names of its
-#   contributors may be used to endorse or promote products derived from
-#   this software without specific prior written permission.
-#
-#
-# THIS SOFTWARE IS PROVIDED BY INTEL CORPORATION ""AS IS"" AND ANY
-# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL INTEL CORPORATION OR
-# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
-# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
-# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES# LOSS OF USE, DATA, OR
-# PROFITS# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
-# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
-# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-########################################################################
-##
-## Authors:
-##	Erdinc Ozturk <erdinc.ozturk@intel.com>
-##	Vinodh Gopal <vinodh.gopal@intel.com>
-##	James Guilford <james.guilford@intel.com>
-##	Tim Chen <tim.c.chen@linux.intel.com>
-##
-## References:
-##       This code was derived and highly optimized from the code described in paper:
-##               Vinodh Gopal et. al. Optimized Galois-Counter-Mode Implementation
-##			on Intel Architecture Processors. August, 2010
-##       The details of the implementation is explained in:
-##               Erdinc Ozturk et. al. Enabling High-Performance Galois-Counter-Mode
-##			on Intel Architecture Processors. October, 2012.
-##
-## Assumptions:
-##
-##
-##
-## iv:
-##       0                   1                   2                   3
-##       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##       |                             Salt  (From the SA)               |
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##       |                     Initialization Vector                     |
-##       |         (This is the sequence number from IPSec header)       |
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##       |                              0x1                              |
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##
-##
-##
-## AAD:
-##       AAD padded to 128 bits with 0
-##       for example, assume AAD is a u32 vector
-##
-##       if AAD is 8 bytes:
-##       AAD[3] = {A0, A1}#
-##       padded AAD in xmm register = {A1 A0 0 0}
-##
-##       0                   1                   2                   3
-##       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##       |                               SPI (A1)                        |
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##       |                     32-bit Sequence Number (A0)               |
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##       |                              0x0                              |
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##
-##                                       AAD Format with 32-bit Sequence Number
-##
-##       if AAD is 12 bytes:
-##       AAD[3] = {A0, A1, A2}#
-##       padded AAD in xmm register = {A2 A1 A0 0}
-##
-##       0                   1                   2                   3
-##       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##       |                               SPI (A2)                        |
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##       |                 64-bit Extended Sequence Number {A1,A0}       |
-##       |                                                               |
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##       |                              0x0                              |
-##       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-##
-##        AAD Format with 64-bit Extended Sequence Number
-##
-##
-## aadLen:
-##       from the definition of the spec, aadLen can only be 8 or 12 bytes.
-##	 The code additionally supports aadLen of length 16 bytes.
-##
-## TLen:
-##       from the definition of the spec, TLen can only be 8, 12 or 16 bytes.
-##
-## poly = x^128 + x^127 + x^126 + x^121 + 1
-## throughout the code, one tab and two tab indentations are used. one tab is
-## for GHASH part, two tabs is for AES part.
-##
-
-#include <linux/linkage.h>
-
-# constants in mergeable sections, linker can reorder and merge
-.section	.rodata.cst16.POLY, "aM", @progbits, 16
-.align 16
-POLY:            .octa     0xC2000000000000000000000000000001
-
-.section	.rodata.cst16.POLY2, "aM", @progbits, 16
-.align 16
-POLY2:           .octa     0xC20000000000000000000001C2000000
-
-.section	.rodata.cst16.TWOONE, "aM", @progbits, 16
-.align 16
-TWOONE:          .octa     0x00000001000000000000000000000001
-
-.section	.rodata.cst16.SHUF_MASK, "aM", @progbits, 16
-.align 16
-SHUF_MASK:       .octa     0x000102030405060708090A0B0C0D0E0F
-
-.section	.rodata.cst16.ONE, "aM", @progbits, 16
-.align 16
-ONE:             .octa     0x00000000000000000000000000000001
-
-.section	.rodata.cst16.ONEf, "aM", @progbits, 16
-.align 16
-ONEf:            .octa     0x01000000000000000000000000000000
-
-# order of these constants should not change.
-# more specifically, ALL_F should follow SHIFT_MASK, and zero should follow ALL_F
-.section	.rodata, "a", @progbits
-.align 16
-SHIFT_MASK:      .octa     0x0f0e0d0c0b0a09080706050403020100
-ALL_F:           .octa     0xffffffffffffffffffffffffffffffff
-                 .octa     0x00000000000000000000000000000000
-
-.text
-
-
-#define AadHash 16*0
-#define AadLen 16*1
-#define InLen (16*1)+8
-#define PBlockEncKey 16*2
-#define OrigIV 16*3
-#define CurCount 16*4
-#define PBlockLen 16*5
-
-HashKey        = 16*6   # store HashKey <<1 mod poly here
-HashKey_2      = 16*7   # store HashKey^2 <<1 mod poly here
-HashKey_3      = 16*8   # store HashKey^3 <<1 mod poly here
-HashKey_4      = 16*9   # store HashKey^4 <<1 mod poly here
-HashKey_5      = 16*10   # store HashKey^5 <<1 mod poly here
-HashKey_6      = 16*11   # store HashKey^6 <<1 mod poly here
-HashKey_7      = 16*12   # store HashKey^7 <<1 mod poly here
-HashKey_8      = 16*13   # store HashKey^8 <<1 mod poly here
-HashKey_k      = 16*14   # store XOR of HashKey <<1 mod poly here (for Karatsuba purposes)
-HashKey_2_k    = 16*15   # store XOR of HashKey^2 <<1 mod poly here (for Karatsuba purposes)
-HashKey_3_k    = 16*16   # store XOR of HashKey^3 <<1 mod poly here (for Karatsuba purposes)
-HashKey_4_k    = 16*17   # store XOR of HashKey^4 <<1 mod poly here (for Karatsuba purposes)
-HashKey_5_k    = 16*18   # store XOR of HashKey^5 <<1 mod poly here (for Karatsuba purposes)
-HashKey_6_k    = 16*19   # store XOR of HashKey^6 <<1 mod poly here (for Karatsuba purposes)
-HashKey_7_k    = 16*20   # store XOR of HashKey^7 <<1 mod poly here (for Karatsuba purposes)
-HashKey_8_k    = 16*21   # store XOR of HashKey^8 <<1 mod poly here (for Karatsuba purposes)
-
-#define arg1 %rdi
-#define arg2 %rsi
-#define arg3 %rdx
-#define arg4 %rcx
-#define arg5 %r8
-#define arg6 %r9
-#define keysize 2*15*16(arg1)
-
-i = 0
-j = 0
-
-out_order = 0
-in_order = 1
-DEC = 0
-ENC = 1
-
-.macro define_reg r n
-reg_\r = %xmm\n
-.endm
-
-.macro setreg
-.altmacro
-define_reg i %i
-define_reg j %j
-.noaltmacro
-.endm
-
-TMP1 =   16*0    # Temporary storage for AAD
-TMP2 =   16*1    # Temporary storage for AES State 2 (State 1 is stored in an XMM register)
-TMP3 =   16*2    # Temporary storage for AES State 3
-TMP4 =   16*3    # Temporary storage for AES State 4
-TMP5 =   16*4    # Temporary storage for AES State 5
-TMP6 =   16*5    # Temporary storage for AES State 6
-TMP7 =   16*6    # Temporary storage for AES State 7
-TMP8 =   16*7    # Temporary storage for AES State 8
-
-VARIABLE_OFFSET = 16*8
-
-################################
-# Utility Macros
-################################
-
-.macro FUNC_SAVE
-        push    %r12
-        push    %r13
-        push    %r15
-
-	push	%rbp
-	mov	%rsp, %rbp
-
-        sub     $VARIABLE_OFFSET, %rsp
-        and     $~63, %rsp                    # align rsp to 64 bytes
-.endm
-
-.macro FUNC_RESTORE
-        mov     %rbp, %rsp
-	pop	%rbp
-
-        pop     %r15
-        pop     %r13
-        pop     %r12
-.endm
-
-# Encryption of a single block
-.macro ENCRYPT_SINGLE_BLOCK REP XMM0
-                vpxor    (arg1), \XMM0, \XMM0
-               i = 1
-               setreg
-.rep \REP
-                vaesenc  16*i(arg1), \XMM0, \XMM0
-               i = (i+1)
-               setreg
-.endr
-                vaesenclast 16*i(arg1), \XMM0, \XMM0
-.endm
-
-# combined for GCM encrypt and decrypt functions
-# clobbering all xmm registers
-# clobbering r10, r11, r12, r13, r15, rax
-.macro  GCM_ENC_DEC INITIAL_BLOCKS GHASH_8_ENCRYPT_8_PARALLEL GHASH_LAST_8 GHASH_MUL ENC_DEC REP
-        vmovdqu AadHash(arg2), %xmm8
-        vmovdqu  HashKey(arg2), %xmm13      # xmm13 = HashKey
-        add arg5, InLen(arg2)
-
-        # initialize the data pointer offset as zero
-        xor     %r11d, %r11d
-
-        PARTIAL_BLOCK \GHASH_MUL, arg3, arg4, arg5, %r11, %xmm8, \ENC_DEC
-        sub %r11, arg5
-
-        mov     arg5, %r13                  # save the number of bytes of plaintext/ciphertext
-        and     $-16, %r13                  # r13 = r13 - (r13 mod 16)
-
-        mov     %r13, %r12
-        shr     $4, %r12
-        and     $7, %r12
-        jz      .L_initial_num_blocks_is_0\@
-
-        cmp     $7, %r12
-        je      .L_initial_num_blocks_is_7\@
-        cmp     $6, %r12
-        je      .L_initial_num_blocks_is_6\@
-        cmp     $5, %r12
-        je      .L_initial_num_blocks_is_5\@
-        cmp     $4, %r12
-        je      .L_initial_num_blocks_is_4\@
-        cmp     $3, %r12
-        je      .L_initial_num_blocks_is_3\@
-        cmp     $2, %r12
-        je      .L_initial_num_blocks_is_2\@
-
-        jmp     .L_initial_num_blocks_is_1\@
-
-.L_initial_num_blocks_is_7\@:
-        \INITIAL_BLOCKS  \REP, 7, %xmm12, %xmm13, %xmm14, %xmm15, %xmm11, %xmm9, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, %xmm10, %xmm0, \ENC_DEC
-        sub     $16*7, %r13
-        jmp     .L_initial_blocks_encrypted\@
-
-.L_initial_num_blocks_is_6\@:
-        \INITIAL_BLOCKS  \REP, 6, %xmm12, %xmm13, %xmm14, %xmm15, %xmm11, %xmm9, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, %xmm10, %xmm0, \ENC_DEC
-        sub     $16*6, %r13
-        jmp     .L_initial_blocks_encrypted\@
-
-.L_initial_num_blocks_is_5\@:
-        \INITIAL_BLOCKS  \REP, 5, %xmm12, %xmm13, %xmm14, %xmm15, %xmm11, %xmm9, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, %xmm10, %xmm0, \ENC_DEC
-        sub     $16*5, %r13
-        jmp     .L_initial_blocks_encrypted\@
-
-.L_initial_num_blocks_is_4\@:
-        \INITIAL_BLOCKS  \REP, 4, %xmm12, %xmm13, %xmm14, %xmm15, %xmm11, %xmm9, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, %xmm10, %xmm0, \ENC_DEC
-        sub     $16*4, %r13
-        jmp     .L_initial_blocks_encrypted\@
-
-.L_initial_num_blocks_is_3\@:
-        \INITIAL_BLOCKS  \REP, 3, %xmm12, %xmm13, %xmm14, %xmm15, %xmm11, %xmm9, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, %xmm10, %xmm0, \ENC_DEC
-        sub     $16*3, %r13
-        jmp     .L_initial_blocks_encrypted\@
-
-.L_initial_num_blocks_is_2\@:
-        \INITIAL_BLOCKS  \REP, 2, %xmm12, %xmm13, %xmm14, %xmm15, %xmm11, %xmm9, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, %xmm10, %xmm0, \ENC_DEC
-        sub     $16*2, %r13
-        jmp     .L_initial_blocks_encrypted\@
-
-.L_initial_num_blocks_is_1\@:
-        \INITIAL_BLOCKS  \REP, 1, %xmm12, %xmm13, %xmm14, %xmm15, %xmm11, %xmm9, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, %xmm10, %xmm0, \ENC_DEC
-        sub     $16*1, %r13
-        jmp     .L_initial_blocks_encrypted\@
-
-.L_initial_num_blocks_is_0\@:
-        \INITIAL_BLOCKS  \REP, 0, %xmm12, %xmm13, %xmm14, %xmm15, %xmm11, %xmm9, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, %xmm10, %xmm0, \ENC_DEC
-
-
-.L_initial_blocks_encrypted\@:
-        test    %r13, %r13
-        je      .L_zero_cipher_left\@
-
-        sub     $128, %r13
-        je      .L_eight_cipher_left\@
-
-
-
-
-        vmovd   %xmm9, %r15d
-        and     $255, %r15d
-        vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
-
-
-.L_encrypt_by_8_new\@:
-        cmp     $(255-8), %r15d
-        jg      .L_encrypt_by_8\@
-
-
-
-        add     $8, %r15b
-        \GHASH_8_ENCRYPT_8_PARALLEL      \REP, %xmm0, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm9, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, %xmm15, out_order, \ENC_DEC
-        add     $128, %r11
-        sub     $128, %r13
-        jne     .L_encrypt_by_8_new\@
-
-        vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
-        jmp     .L_eight_cipher_left\@
-
-.L_encrypt_by_8\@:
-        vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
-        add     $8, %r15b
-        \GHASH_8_ENCRYPT_8_PARALLEL      \REP, %xmm0, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm9, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, %xmm15, in_order, \ENC_DEC
-        vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
-        add     $128, %r11
-        sub     $128, %r13
-        jne     .L_encrypt_by_8_new\@
-
-        vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
-
-
-
-
-.L_eight_cipher_left\@:
-        \GHASH_LAST_8    %xmm0, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm15, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8
-
-
-.L_zero_cipher_left\@:
-        vmovdqu %xmm14, AadHash(arg2)
-        vmovdqu %xmm9, CurCount(arg2)
-
-        # check for 0 length
-        mov     arg5, %r13
-        and     $15, %r13                            # r13 = (arg5 mod 16)
-
-        je      .L_multiple_of_16_bytes\@
-
-        # handle the last <16 Byte block separately
-
-        mov %r13, PBlockLen(arg2)
-
-        vpaddd  ONE(%rip), %xmm9, %xmm9              # INCR CNT to get Yn
-        vmovdqu %xmm9, CurCount(arg2)
-        vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
-
-        ENCRYPT_SINGLE_BLOCK    \REP, %xmm9                # E(K, Yn)
-        vmovdqu %xmm9, PBlockEncKey(arg2)
-
-        cmp $16, arg5
-        jge .L_large_enough_update\@
-
-        lea (arg4,%r11,1), %r10
-        mov %r13, %r12
-
-        READ_PARTIAL_BLOCK %r10 %r12 %xmm1
-
-        lea     SHIFT_MASK+16(%rip), %r12
-        sub     %r13, %r12                           # adjust the shuffle mask pointer to be
-						     # able to shift 16-r13 bytes (r13 is the
-	# number of bytes in plaintext mod 16)
-
-        jmp .L_final_ghash_mul\@
-
-.L_large_enough_update\@:
-        sub $16, %r11
-        add %r13, %r11
-
-        # receive the last <16 Byte block
-        vmovdqu	(arg4, %r11, 1), %xmm1
-
-        sub	%r13, %r11
-        add	$16, %r11
-
-        lea	SHIFT_MASK+16(%rip), %r12
-        # adjust the shuffle mask pointer to be able to shift 16-r13 bytes
-        # (r13 is the number of bytes in plaintext mod 16)
-        sub	%r13, %r12
-        # get the appropriate shuffle mask
-        vmovdqu	(%r12), %xmm2
-        # shift right 16-r13 bytes
-        vpshufb  %xmm2, %xmm1, %xmm1
-
-.L_final_ghash_mul\@:
-        .if  \ENC_DEC ==  DEC
-        vmovdqa %xmm1, %xmm2
-        vpxor   %xmm1, %xmm9, %xmm9                  # Plaintext XOR E(K, Yn)
-        vmovdqu ALL_F-SHIFT_MASK(%r12), %xmm1        # get the appropriate mask to
-						     # mask out top 16-r13 bytes of xmm9
-        vpand   %xmm1, %xmm9, %xmm9                  # mask out top 16-r13 bytes of xmm9
-        vpand   %xmm1, %xmm2, %xmm2
-        vpshufb SHUF_MASK(%rip), %xmm2, %xmm2
-        vpxor   %xmm2, %xmm14, %xmm14
-
-        vmovdqu %xmm14, AadHash(arg2)
-        .else
-        vpxor   %xmm1, %xmm9, %xmm9                  # Plaintext XOR E(K, Yn)
-        vmovdqu ALL_F-SHIFT_MASK(%r12), %xmm1        # get the appropriate mask to
-						     # mask out top 16-r13 bytes of xmm9
-        vpand   %xmm1, %xmm9, %xmm9                  # mask out top 16-r13 bytes of xmm9
-        vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
-        vpxor   %xmm9, %xmm14, %xmm14
-
-        vmovdqu %xmm14, AadHash(arg2)
-        vpshufb SHUF_MASK(%rip), %xmm9, %xmm9        # shuffle xmm9 back to output as ciphertext
-        .endif
-
-
-        #############################
-        # output r13 Bytes
-        vmovq   %xmm9, %rax
-        cmp     $8, %r13
-        jle     .L_less_than_8_bytes_left\@
-
-        mov     %rax, (arg3 , %r11)
-        add     $8, %r11
-        vpsrldq $8, %xmm9, %xmm9
-        vmovq   %xmm9, %rax
-        sub     $8, %r13
-
-.L_less_than_8_bytes_left\@:
-        movb    %al, (arg3 , %r11)
-        add     $1, %r11
-        shr     $8, %rax
-        sub     $1, %r13
-        jne     .L_less_than_8_bytes_left\@
-        #############################
-
-.L_multiple_of_16_bytes\@:
-.endm
-
-
-# GCM_COMPLETE Finishes update of tag of last partial block
-# Output: Authorization Tag (AUTH_TAG)
-# Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
-.macro GCM_COMPLETE GHASH_MUL REP AUTH_TAG AUTH_TAG_LEN
-        vmovdqu AadHash(arg2), %xmm14
-        vmovdqu HashKey(arg2), %xmm13
-
-        mov PBlockLen(arg2), %r12
-        test %r12, %r12
-        je .L_partial_done\@
-
-	#GHASH computation for the last <16 Byte block
-        \GHASH_MUL       %xmm14, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
-
-.L_partial_done\@:
-        mov AadLen(arg2), %r12                          # r12 = aadLen (number of bytes)
-        shl     $3, %r12                             # convert into number of bits
-        vmovd   %r12d, %xmm15                        # len(A) in xmm15
-
-        mov InLen(arg2), %r12
-        shl     $3, %r12                        # len(C) in bits  (*128)
-        vmovq   %r12, %xmm1
-        vpslldq $8, %xmm15, %xmm15                   # xmm15 = len(A)|| 0x0000000000000000
-        vpxor   %xmm1, %xmm15, %xmm15                # xmm15 = len(A)||len(C)
-
-        vpxor   %xmm15, %xmm14, %xmm14
-        \GHASH_MUL       %xmm14, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6    # final GHASH computation
-        vpshufb SHUF_MASK(%rip), %xmm14, %xmm14      # perform a 16Byte swap
-
-        vmovdqu OrigIV(arg2), %xmm9
-
-        ENCRYPT_SINGLE_BLOCK    \REP, %xmm9                # E(K, Y0)
-
-        vpxor   %xmm14, %xmm9, %xmm9
-
-
-
-.L_return_T\@:
-        mov     \AUTH_TAG, %r10              # r10 = authTag
-        mov     \AUTH_TAG_LEN, %r11              # r11 = auth_tag_len
-
-        cmp     $16, %r11
-        je      .L_T_16\@
-
-        cmp     $8, %r11
-        jl      .L_T_4\@
-
-.L_T_8\@:
-        vmovq   %xmm9, %rax
-        mov     %rax, (%r10)
-        add     $8, %r10
-        sub     $8, %r11
-        vpsrldq $8, %xmm9, %xmm9
-        test    %r11, %r11
-        je     .L_return_T_done\@
-.L_T_4\@:
-        vmovd   %xmm9, %eax
-        mov     %eax, (%r10)
-        add     $4, %r10
-        sub     $4, %r11
-        vpsrldq     $4, %xmm9, %xmm9
-        test    %r11, %r11
-        je     .L_return_T_done\@
-.L_T_123\@:
-        vmovd     %xmm9, %eax
-        cmp     $2, %r11
-        jl     .L_T_1\@
-        mov     %ax, (%r10)
-        cmp     $2, %r11
-        je     .L_return_T_done\@
-        add     $2, %r10
-        sar     $16, %eax
-.L_T_1\@:
-        mov     %al, (%r10)
-        jmp     .L_return_T_done\@
-
-.L_T_16\@:
-        vmovdqu %xmm9, (%r10)
-
-.L_return_T_done\@:
-.endm
-
-.macro CALC_AAD_HASH GHASH_MUL AAD AADLEN T1 T2 T3 T4 T5 T6 T7 T8
-
-	mov     \AAD, %r10                      # r10 = AAD
-	mov     \AADLEN, %r12                      # r12 = aadLen
-
-
-	mov     %r12, %r11
-
-	vpxor   \T8, \T8, \T8
-	vpxor   \T7, \T7, \T7
-	cmp     $16, %r11
-	jl      .L_get_AAD_rest8\@
-.L_get_AAD_blocks\@:
-	vmovdqu (%r10), \T7
-	vpshufb SHUF_MASK(%rip), \T7, \T7
-	vpxor   \T7, \T8, \T8
-	\GHASH_MUL       \T8, \T2, \T1, \T3, \T4, \T5, \T6
-	add     $16, %r10
-	sub     $16, %r12
-	sub     $16, %r11
-	cmp     $16, %r11
-	jge     .L_get_AAD_blocks\@
-	vmovdqu \T8, \T7
-	test    %r11, %r11
-	je      .L_get_AAD_done\@
-
-	vpxor   \T7, \T7, \T7
-
-	/* read the last <16B of AAD. since we have at least 4B of
-	data right after the AAD (the ICV, and maybe some CT), we can
-	read 4B/8B blocks safely, and then get rid of the extra stuff */
-.L_get_AAD_rest8\@:
-	cmp     $4, %r11
-	jle     .L_get_AAD_rest4\@
-	movq    (%r10), \T1
-	add     $8, %r10
-	sub     $8, %r11
-	vpslldq $8, \T1, \T1
-	vpsrldq $8, \T7, \T7
-	vpxor   \T1, \T7, \T7
-	jmp     .L_get_AAD_rest8\@
-.L_get_AAD_rest4\@:
-	test    %r11, %r11
-	jle     .L_get_AAD_rest0\@
-	mov     (%r10), %eax
-	movq    %rax, \T1
-	add     $4, %r10
-	sub     $4, %r11
-	vpslldq $12, \T1, \T1
-	vpsrldq $4, \T7, \T7
-	vpxor   \T1, \T7, \T7
-.L_get_AAD_rest0\@:
-	/* finalize: shift out the extra bytes we read, and align
-	left. since pslldq can only shift by an immediate, we use
-	vpshufb and a pair of shuffle masks */
-	leaq	ALL_F(%rip), %r11
-	subq	%r12, %r11
-	vmovdqu	16(%r11), \T1
-	andq	$~3, %r11
-	vpshufb (%r11), \T7, \T7
-	vpand	\T1, \T7, \T7
-.L_get_AAD_rest_final\@:
-	vpshufb SHUF_MASK(%rip), \T7, \T7
-	vpxor   \T8, \T7, \T7
-	\GHASH_MUL       \T7, \T2, \T1, \T3, \T4, \T5, \T6
-
-.L_get_AAD_done\@:
-        vmovdqu \T7, AadHash(arg2)
-.endm
-
-.macro INIT GHASH_MUL PRECOMPUTE
-        mov arg6, %r11
-        mov %r11, AadLen(arg2) # ctx_data.aad_length = aad_length
-        xor %r11d, %r11d
-        mov %r11, InLen(arg2) # ctx_data.in_length = 0
-
-        mov %r11, PBlockLen(arg2) # ctx_data.partial_block_length = 0
-        mov %r11, PBlockEncKey(arg2) # ctx_data.partial_block_enc_key = 0
-        mov arg3, %rax
-        movdqu (%rax), %xmm0
-        movdqu %xmm0, OrigIV(arg2) # ctx_data.orig_IV = iv
-
-        vpshufb SHUF_MASK(%rip), %xmm0, %xmm0
-        movdqu %xmm0, CurCount(arg2) # ctx_data.current_counter = iv
-
-        vmovdqu  (arg4), %xmm6              # xmm6 = HashKey
-
-        vpshufb  SHUF_MASK(%rip), %xmm6, %xmm6
-        ###############  PRECOMPUTATION of HashKey<<1 mod poly from the HashKey
-        vmovdqa  %xmm6, %xmm2
-        vpsllq   $1, %xmm6, %xmm6
-        vpsrlq   $63, %xmm2, %xmm2
-        vmovdqa  %xmm2, %xmm1
-        vpslldq  $8, %xmm2, %xmm2
-        vpsrldq  $8, %xmm1, %xmm1
-        vpor     %xmm2, %xmm6, %xmm6
-        #reduction
-        vpshufd  $0b00100100, %xmm1, %xmm2
-        vpcmpeqd TWOONE(%rip), %xmm2, %xmm2
-        vpand    POLY(%rip), %xmm2, %xmm2
-        vpxor    %xmm2, %xmm6, %xmm6        # xmm6 holds the HashKey<<1 mod poly
-        #######################################################################
-        vmovdqu  %xmm6, HashKey(arg2)       # store HashKey<<1 mod poly
-
-        CALC_AAD_HASH \GHASH_MUL, arg5, arg6, %xmm2, %xmm6, %xmm3, %xmm4, %xmm5, %xmm7, %xmm1, %xmm0
-
-        \PRECOMPUTE  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
-.endm
-
-
-# Reads DLEN bytes starting at DPTR and stores in XMMDst
-# where 0 < DLEN < 16
-# Clobbers %rax, DLEN
-.macro READ_PARTIAL_BLOCK DPTR DLEN XMMDst
-        vpxor \XMMDst, \XMMDst, \XMMDst
-
-        cmp $8, \DLEN
-        jl .L_read_lt8_\@
-        mov (\DPTR), %rax
-        vpinsrq $0, %rax, \XMMDst, \XMMDst
-        sub $8, \DLEN
-        jz .L_done_read_partial_block_\@
-        xor %eax, %eax
-.L_read_next_byte_\@:
-        shl $8, %rax
-        mov 7(\DPTR, \DLEN, 1), %al
-        dec \DLEN
-        jnz .L_read_next_byte_\@
-        vpinsrq $1, %rax, \XMMDst, \XMMDst
-        jmp .L_done_read_partial_block_\@
-.L_read_lt8_\@:
-        xor %eax, %eax
-.L_read_next_byte_lt8_\@:
-        shl $8, %rax
-        mov -1(\DPTR, \DLEN, 1), %al
-        dec \DLEN
-        jnz .L_read_next_byte_lt8_\@
-        vpinsrq $0, %rax, \XMMDst, \XMMDst
-.L_done_read_partial_block_\@:
-.endm
-
-# PARTIAL_BLOCK: Handles encryption/decryption and the tag partial blocks
-# between update calls.
-# Requires the input data be at least 1 byte long due to READ_PARTIAL_BLOCK
-# Outputs encrypted bytes, and updates hash and partial info in gcm_data_context
-# Clobbers rax, r10, r12, r13, xmm0-6, xmm9-13
-.macro PARTIAL_BLOCK GHASH_MUL CYPH_PLAIN_OUT PLAIN_CYPH_IN PLAIN_CYPH_LEN DATA_OFFSET \
-        AAD_HASH ENC_DEC
-        mov 	PBlockLen(arg2), %r13
-        test	%r13, %r13
-        je	.L_partial_block_done_\@	# Leave Macro if no partial blocks
-        # Read in input data without over reading
-        cmp	$16, \PLAIN_CYPH_LEN
-        jl	.L_fewer_than_16_bytes_\@
-        vmovdqu	(\PLAIN_CYPH_IN), %xmm1	# If more than 16 bytes, just fill xmm
-        jmp	.L_data_read_\@
-
-.L_fewer_than_16_bytes_\@:
-        lea	(\PLAIN_CYPH_IN, \DATA_OFFSET, 1), %r10
-        mov	\PLAIN_CYPH_LEN, %r12
-        READ_PARTIAL_BLOCK %r10 %r12 %xmm1
-
-        mov PBlockLen(arg2), %r13
-
-.L_data_read_\@:				# Finished reading in data
-
-        vmovdqu	PBlockEncKey(arg2), %xmm9
-        vmovdqu	HashKey(arg2), %xmm13
-
-        lea	SHIFT_MASK(%rip), %r12
-
-        # adjust the shuffle mask pointer to be able to shift r13 bytes
-        # r16-r13 is the number of bytes in plaintext mod 16)
-        add	%r13, %r12
-        vmovdqu	(%r12), %xmm2		# get the appropriate shuffle mask
-        vpshufb %xmm2, %xmm9, %xmm9		# shift right r13 bytes
-
-.if  \ENC_DEC ==  DEC
-        vmovdqa	%xmm1, %xmm3
-        pxor	%xmm1, %xmm9		# Ciphertext XOR E(K, Yn)
-
-        mov	\PLAIN_CYPH_LEN, %r10
-        add	%r13, %r10
-        # Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
-        sub	$16, %r10
-        # Determine if partial block is not being filled and
-        # shift mask accordingly
-        jge	.L_no_extra_mask_1_\@
-        sub	%r10, %r12
-.L_no_extra_mask_1_\@:
-
-        vmovdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
-        # get the appropriate mask to mask out bottom r13 bytes of xmm9
-        vpand	%xmm1, %xmm9, %xmm9		# mask out bottom r13 bytes of xmm9
-
-        vpand	%xmm1, %xmm3, %xmm3
-        vmovdqa	SHUF_MASK(%rip), %xmm10
-        vpshufb	%xmm10, %xmm3, %xmm3
-        vpshufb	%xmm2, %xmm3, %xmm3
-        vpxor	%xmm3, \AAD_HASH, \AAD_HASH
-
-        test	%r10, %r10
-        jl	.L_partial_incomplete_1_\@
-
-        # GHASH computation for the last <16 Byte block
-        \GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
-        xor	%eax,%eax
-
-        mov	%rax, PBlockLen(arg2)
-        jmp	.L_dec_done_\@
-.L_partial_incomplete_1_\@:
-        add	\PLAIN_CYPH_LEN, PBlockLen(arg2)
-.L_dec_done_\@:
-        vmovdqu	\AAD_HASH, AadHash(arg2)
-.else
-        vpxor	%xmm1, %xmm9, %xmm9			# Plaintext XOR E(K, Yn)
-
-        mov	\PLAIN_CYPH_LEN, %r10
-        add	%r13, %r10
-        # Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
-        sub	$16, %r10
-        # Determine if partial block is not being filled and
-        # shift mask accordingly
-        jge	.L_no_extra_mask_2_\@
-        sub	%r10, %r12
-.L_no_extra_mask_2_\@:
-
-        vmovdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
-        # get the appropriate mask to mask out bottom r13 bytes of xmm9
-        vpand	%xmm1, %xmm9, %xmm9
-
-        vmovdqa	SHUF_MASK(%rip), %xmm1
-        vpshufb %xmm1, %xmm9, %xmm9
-        vpshufb %xmm2, %xmm9, %xmm9
-        vpxor	%xmm9, \AAD_HASH, \AAD_HASH
-
-        test	%r10, %r10
-        jl	.L_partial_incomplete_2_\@
-
-        # GHASH computation for the last <16 Byte block
-        \GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
-        xor	%eax,%eax
-
-        mov	%rax, PBlockLen(arg2)
-        jmp	.L_encode_done_\@
-.L_partial_incomplete_2_\@:
-        add	\PLAIN_CYPH_LEN, PBlockLen(arg2)
-.L_encode_done_\@:
-        vmovdqu	\AAD_HASH, AadHash(arg2)
-
-        vmovdqa	SHUF_MASK(%rip), %xmm10
-        # shuffle xmm9 back to output as ciphertext
-        vpshufb	%xmm10, %xmm9, %xmm9
-        vpshufb	%xmm2, %xmm9, %xmm9
-.endif
-        # output encrypted Bytes
-        test	%r10, %r10
-        jl	.L_partial_fill_\@
-        mov	%r13, %r12
-        mov	$16, %r13
-        # Set r13 to be the number of bytes to write out
-        sub	%r12, %r13
-        jmp	.L_count_set_\@
-.L_partial_fill_\@:
-        mov	\PLAIN_CYPH_LEN, %r13
-.L_count_set_\@:
-        vmovdqa	%xmm9, %xmm0
-        vmovq	%xmm0, %rax
-        cmp	$8, %r13
-        jle	.L_less_than_8_bytes_left_\@
-
-        mov	%rax, (\CYPH_PLAIN_OUT, \DATA_OFFSET, 1)
-        add	$8, \DATA_OFFSET
-        psrldq	$8, %xmm0
-        vmovq	%xmm0, %rax
-        sub	$8, %r13
-.L_less_than_8_bytes_left_\@:
-        movb	%al, (\CYPH_PLAIN_OUT, \DATA_OFFSET, 1)
-        add	$1, \DATA_OFFSET
-        shr	$8, %rax
-        sub	$1, %r13
-        jne	.L_less_than_8_bytes_left_\@
-.L_partial_block_done_\@:
-.endm # PARTIAL_BLOCK
-
-###############################################################################
-# GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
-# Input: A and B (128-bits each, bit-reflected)
-# Output: C = A*B*x mod poly, (i.e. >>1 )
-# To compute GH = GH*HashKey mod poly, give HK = HashKey<<1 mod poly as input
-# GH = GH * HK * x mod poly which is equivalent to GH*HashKey mod poly.
-###############################################################################
-.macro  GHASH_MUL_AVX GH HK T1 T2 T3 T4 T5
-
-        vpshufd         $0b01001110, \GH, \T2
-        vpshufd         $0b01001110, \HK, \T3
-        vpxor           \GH     , \T2, \T2      # T2 = (a1+a0)
-        vpxor           \HK     , \T3, \T3      # T3 = (b1+b0)
-
-        vpclmulqdq      $0x11, \HK, \GH, \T1    # T1 = a1*b1
-        vpclmulqdq      $0x00, \HK, \GH, \GH    # GH = a0*b0
-        vpclmulqdq      $0x00, \T3, \T2, \T2    # T2 = (a1+a0)*(b1+b0)
-        vpxor           \GH, \T2,\T2
-        vpxor           \T1, \T2,\T2            # T2 = a0*b1+a1*b0
-
-        vpslldq         $8, \T2,\T3             # shift-L T3 2 DWs
-        vpsrldq         $8, \T2,\T2             # shift-R T2 2 DWs
-        vpxor           \T3, \GH, \GH
-        vpxor           \T2, \T1, \T1           # <T1:GH> = GH x HK
-
-        #first phase of the reduction
-        vpslld  $31, \GH, \T2                   # packed right shifting << 31
-        vpslld  $30, \GH, \T3                   # packed right shifting shift << 30
-        vpslld  $25, \GH, \T4                   # packed right shifting shift << 25
-
-        vpxor   \T3, \T2, \T2                   # xor the shifted versions
-        vpxor   \T4, \T2, \T2
-
-        vpsrldq $4, \T2, \T5                    # shift-R T5 1 DW
-
-        vpslldq $12, \T2, \T2                   # shift-L T2 3 DWs
-        vpxor   \T2, \GH, \GH                   # first phase of the reduction complete
-
-        #second phase of the reduction
-
-        vpsrld  $1,\GH, \T2                     # packed left shifting >> 1
-        vpsrld  $2,\GH, \T3                     # packed left shifting >> 2
-        vpsrld  $7,\GH, \T4                     # packed left shifting >> 7
-        vpxor   \T3, \T2, \T2                   # xor the shifted versions
-        vpxor   \T4, \T2, \T2
-
-        vpxor   \T5, \T2, \T2
-        vpxor   \T2, \GH, \GH
-        vpxor   \T1, \GH, \GH                   # the result is in GH
-
-
-.endm
-
-.macro PRECOMPUTE_AVX HK T1 T2 T3 T4 T5 T6
-
-        # Haskey_i_k holds XORed values of the low and high parts of the Haskey_i
-        vmovdqa  \HK, \T5
-
-        vpshufd  $0b01001110, \T5, \T1
-        vpxor    \T5, \T1, \T1
-        vmovdqu  \T1, HashKey_k(arg2)
-
-        GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 = HashKey^2<<1 mod poly
-        vmovdqu  \T5, HashKey_2(arg2)                    #  [HashKey_2] = HashKey^2<<1 mod poly
-        vpshufd  $0b01001110, \T5, \T1
-        vpxor    \T5, \T1, \T1
-        vmovdqu  \T1, HashKey_2_k(arg2)
-
-        GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 = HashKey^3<<1 mod poly
-        vmovdqu  \T5, HashKey_3(arg2)
-        vpshufd  $0b01001110, \T5, \T1
-        vpxor    \T5, \T1, \T1
-        vmovdqu  \T1, HashKey_3_k(arg2)
-
-        GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 = HashKey^4<<1 mod poly
-        vmovdqu  \T5, HashKey_4(arg2)
-        vpshufd  $0b01001110, \T5, \T1
-        vpxor    \T5, \T1, \T1
-        vmovdqu  \T1, HashKey_4_k(arg2)
-
-        GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 = HashKey^5<<1 mod poly
-        vmovdqu  \T5, HashKey_5(arg2)
-        vpshufd  $0b01001110, \T5, \T1
-        vpxor    \T5, \T1, \T1
-        vmovdqu  \T1, HashKey_5_k(arg2)
-
-        GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 = HashKey^6<<1 mod poly
-        vmovdqu  \T5, HashKey_6(arg2)
-        vpshufd  $0b01001110, \T5, \T1
-        vpxor    \T5, \T1, \T1
-        vmovdqu  \T1, HashKey_6_k(arg2)
-
-        GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 = HashKey^7<<1 mod poly
-        vmovdqu  \T5, HashKey_7(arg2)
-        vpshufd  $0b01001110, \T5, \T1
-        vpxor    \T5, \T1, \T1
-        vmovdqu  \T1, HashKey_7_k(arg2)
-
-        GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 = HashKey^8<<1 mod poly
-        vmovdqu  \T5, HashKey_8(arg2)
-        vpshufd  $0b01001110, \T5, \T1
-        vpxor    \T5, \T1, \T1
-        vmovdqu  \T1, HashKey_8_k(arg2)
-
-.endm
-
-## if a = number of total plaintext bytes
-## b = floor(a/16)
-## num_initial_blocks = b mod 4#
-## encrypt the initial num_initial_blocks blocks and apply ghash on the ciphertext
-## r10, r11, r12, rax are clobbered
-## arg1, arg2, arg3, arg4 are used as pointers only, not modified
-
-.macro INITIAL_BLOCKS_AVX REP num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC
-	i = (8-\num_initial_blocks)
-	setreg
-        vmovdqu AadHash(arg2), reg_i
-
-	# start AES for num_initial_blocks blocks
-	vmovdqu CurCount(arg2), \CTR
-
-	i = (9-\num_initial_blocks)
-	setreg
-.rep \num_initial_blocks
-                vpaddd  ONE(%rip), \CTR, \CTR		# INCR Y0
-                vmovdqa \CTR, reg_i
-                vpshufb SHUF_MASK(%rip), reg_i, reg_i   # perform a 16Byte swap
-	i = (i+1)
-	setreg
-.endr
-
-	vmovdqa  (arg1), \T_key
-	i = (9-\num_initial_blocks)
-	setreg
-.rep \num_initial_blocks
-                vpxor   \T_key, reg_i, reg_i
-	i = (i+1)
-	setreg
-.endr
-
-       j = 1
-       setreg
-.rep \REP
-       vmovdqa  16*j(arg1), \T_key
-	i = (9-\num_initial_blocks)
-	setreg
-.rep \num_initial_blocks
-        vaesenc \T_key, reg_i, reg_i
-	i = (i+1)
-	setreg
-.endr
-
-       j = (j+1)
-       setreg
-.endr
-
-	vmovdqa  16*j(arg1), \T_key
-	i = (9-\num_initial_blocks)
-	setreg
-.rep \num_initial_blocks
-        vaesenclast      \T_key, reg_i, reg_i
-	i = (i+1)
-	setreg
-.endr
-
-	i = (9-\num_initial_blocks)
-	setreg
-.rep \num_initial_blocks
-                vmovdqu (arg4, %r11), \T1
-                vpxor   \T1, reg_i, reg_i
-                vmovdqu reg_i, (arg3 , %r11)           # write back ciphertext for num_initial_blocks blocks
-                add     $16, %r11
-.if  \ENC_DEC == DEC
-                vmovdqa \T1, reg_i
-.endif
-                vpshufb SHUF_MASK(%rip), reg_i, reg_i  # prepare ciphertext for GHASH computations
-	i = (i+1)
-	setreg
-.endr
-
-
-	i = (8-\num_initial_blocks)
-	j = (9-\num_initial_blocks)
-	setreg
-
-.rep \num_initial_blocks
-        vpxor    reg_i, reg_j, reg_j
-        GHASH_MUL_AVX       reg_j, \T2, \T1, \T3, \T4, \T5, \T6 # apply GHASH on num_initial_blocks blocks
-	i = (i+1)
-	j = (j+1)
-	setreg
-.endr
-        # XMM8 has the combined result here
-
-        vmovdqa  \XMM8, TMP1(%rsp)
-        vmovdqa  \XMM8, \T3
-
-        cmp     $128, %r13
-        jl      .L_initial_blocks_done\@                  # no need for precomputed constants
-
-###############################################################################
-# Haskey_i_k holds XORed values of the low and high parts of the Haskey_i
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM1
-                vpshufb  SHUF_MASK(%rip), \XMM1, \XMM1  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM2
-                vpshufb  SHUF_MASK(%rip), \XMM2, \XMM2  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM3
-                vpshufb  SHUF_MASK(%rip), \XMM3, \XMM3  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM4
-                vpshufb  SHUF_MASK(%rip), \XMM4, \XMM4  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM5
-                vpshufb  SHUF_MASK(%rip), \XMM5, \XMM5  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM6
-                vpshufb  SHUF_MASK(%rip), \XMM6, \XMM6  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM7
-                vpshufb  SHUF_MASK(%rip), \XMM7, \XMM7  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM8
-                vpshufb  SHUF_MASK(%rip), \XMM8, \XMM8  # perform a 16Byte swap
-
-                vmovdqa  (arg1), \T_key
-                vpxor    \T_key, \XMM1, \XMM1
-                vpxor    \T_key, \XMM2, \XMM2
-                vpxor    \T_key, \XMM3, \XMM3
-                vpxor    \T_key, \XMM4, \XMM4
-                vpxor    \T_key, \XMM5, \XMM5
-                vpxor    \T_key, \XMM6, \XMM6
-                vpxor    \T_key, \XMM7, \XMM7
-                vpxor    \T_key, \XMM8, \XMM8
-
-               i = 1
-               setreg
-.rep    \REP       # do REP rounds
-                vmovdqa  16*i(arg1), \T_key
-                vaesenc  \T_key, \XMM1, \XMM1
-                vaesenc  \T_key, \XMM2, \XMM2
-                vaesenc  \T_key, \XMM3, \XMM3
-                vaesenc  \T_key, \XMM4, \XMM4
-                vaesenc  \T_key, \XMM5, \XMM5
-                vaesenc  \T_key, \XMM6, \XMM6
-                vaesenc  \T_key, \XMM7, \XMM7
-                vaesenc  \T_key, \XMM8, \XMM8
-               i = (i+1)
-               setreg
-.endr
-
-                vmovdqa  16*i(arg1), \T_key
-                vaesenclast  \T_key, \XMM1, \XMM1
-                vaesenclast  \T_key, \XMM2, \XMM2
-                vaesenclast  \T_key, \XMM3, \XMM3
-                vaesenclast  \T_key, \XMM4, \XMM4
-                vaesenclast  \T_key, \XMM5, \XMM5
-                vaesenclast  \T_key, \XMM6, \XMM6
-                vaesenclast  \T_key, \XMM7, \XMM7
-                vaesenclast  \T_key, \XMM8, \XMM8
-
-                vmovdqu  (arg4, %r11), \T1
-                vpxor    \T1, \XMM1, \XMM1
-                vmovdqu  \XMM1, (arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM1
-                .endif
-
-                vmovdqu  16*1(arg4, %r11), \T1
-                vpxor    \T1, \XMM2, \XMM2
-                vmovdqu  \XMM2, 16*1(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM2
-                .endif
-
-                vmovdqu  16*2(arg4, %r11), \T1
-                vpxor    \T1, \XMM3, \XMM3
-                vmovdqu  \XMM3, 16*2(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM3
-                .endif
-
-                vmovdqu  16*3(arg4, %r11), \T1
-                vpxor    \T1, \XMM4, \XMM4
-                vmovdqu  \XMM4, 16*3(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM4
-                .endif
-
-                vmovdqu  16*4(arg4, %r11), \T1
-                vpxor    \T1, \XMM5, \XMM5
-                vmovdqu  \XMM5, 16*4(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM5
-                .endif
-
-                vmovdqu  16*5(arg4, %r11), \T1
-                vpxor    \T1, \XMM6, \XMM6
-                vmovdqu  \XMM6, 16*5(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM6
-                .endif
-
-                vmovdqu  16*6(arg4, %r11), \T1
-                vpxor    \T1, \XMM7, \XMM7
-                vmovdqu  \XMM7, 16*6(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM7
-                .endif
-
-                vmovdqu  16*7(arg4, %r11), \T1
-                vpxor    \T1, \XMM8, \XMM8
-                vmovdqu  \XMM8, 16*7(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM8
-                .endif
-
-                add     $128, %r11
-
-                vpshufb  SHUF_MASK(%rip), \XMM1, \XMM1     # perform a 16Byte swap
-                vpxor    TMP1(%rsp), \XMM1, \XMM1          # combine GHASHed value with the corresponding ciphertext
-                vpshufb  SHUF_MASK(%rip), \XMM2, \XMM2     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM3, \XMM3     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM4, \XMM4     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM5, \XMM5     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM6, \XMM6     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM7, \XMM7     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM8, \XMM8     # perform a 16Byte swap
-
-###############################################################################
-
-.L_initial_blocks_done\@:
-
-.endm
-
-# encrypt 8 blocks at a time
-# ghash the 8 previously encrypted ciphertext blocks
-# arg1, arg2, arg3, arg4 are used as pointers only, not modified
-# r11 is the data offset value
-.macro GHASH_8_ENCRYPT_8_PARALLEL_AVX REP T1 T2 T3 T4 T5 T6 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T7 loop_idx ENC_DEC
-
-        vmovdqa \XMM1, \T2
-        vmovdqa \XMM2, TMP2(%rsp)
-        vmovdqa \XMM3, TMP3(%rsp)
-        vmovdqa \XMM4, TMP4(%rsp)
-        vmovdqa \XMM5, TMP5(%rsp)
-        vmovdqa \XMM6, TMP6(%rsp)
-        vmovdqa \XMM7, TMP7(%rsp)
-        vmovdqa \XMM8, TMP8(%rsp)
-
-.if \loop_idx == in_order
-                vpaddd  ONE(%rip), \CTR, \XMM1           # INCR CNT
-                vpaddd  ONE(%rip), \XMM1, \XMM2
-                vpaddd  ONE(%rip), \XMM2, \XMM3
-                vpaddd  ONE(%rip), \XMM3, \XMM4
-                vpaddd  ONE(%rip), \XMM4, \XMM5
-                vpaddd  ONE(%rip), \XMM5, \XMM6
-                vpaddd  ONE(%rip), \XMM6, \XMM7
-                vpaddd  ONE(%rip), \XMM7, \XMM8
-                vmovdqa \XMM8, \CTR
-
-                vpshufb SHUF_MASK(%rip), \XMM1, \XMM1    # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM2, \XMM2    # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM3, \XMM3    # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM4, \XMM4    # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM5, \XMM5    # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM6, \XMM6    # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM7, \XMM7    # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM8, \XMM8    # perform a 16Byte swap
-.else
-                vpaddd  ONEf(%rip), \CTR, \XMM1           # INCR CNT
-                vpaddd  ONEf(%rip), \XMM1, \XMM2
-                vpaddd  ONEf(%rip), \XMM2, \XMM3
-                vpaddd  ONEf(%rip), \XMM3, \XMM4
-                vpaddd  ONEf(%rip), \XMM4, \XMM5
-                vpaddd  ONEf(%rip), \XMM5, \XMM6
-                vpaddd  ONEf(%rip), \XMM6, \XMM7
-                vpaddd  ONEf(%rip), \XMM7, \XMM8
-                vmovdqa \XMM8, \CTR
-.endif
-
-
-        #######################################################################
-
-                vmovdqu (arg1), \T1
-                vpxor   \T1, \XMM1, \XMM1
-                vpxor   \T1, \XMM2, \XMM2
-                vpxor   \T1, \XMM3, \XMM3
-                vpxor   \T1, \XMM4, \XMM4
-                vpxor   \T1, \XMM5, \XMM5
-                vpxor   \T1, \XMM6, \XMM6
-                vpxor   \T1, \XMM7, \XMM7
-                vpxor   \T1, \XMM8, \XMM8
-
-        #######################################################################
-
-
-
-
-
-                vmovdqu 16*1(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-                vmovdqu 16*2(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-
-        #######################################################################
-
-        vmovdqu         HashKey_8(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T2, \T4             # T4 = a1*b1
-        vpclmulqdq      $0x00, \T5, \T2, \T7             # T7 = a0*b0
-
-        vpshufd         $0b01001110, \T2, \T6
-        vpxor           \T2, \T6, \T6
-
-        vmovdqu         HashKey_8_k(arg2), \T5
-        vpclmulqdq      $0x00, \T5, \T6, \T6
-
-                vmovdqu 16*3(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-        vmovdqa         TMP2(%rsp), \T1
-        vmovdqu         HashKey_7(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpshufd         $0b01001110, \T1, \T3
-        vpxor           \T1, \T3, \T3
-        vmovdqu         HashKey_7_k(arg2), \T5
-        vpclmulqdq      $0x10, \T5, \T3, \T3
-        vpxor           \T3, \T6, \T6
-
-                vmovdqu 16*4(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-        #######################################################################
-
-        vmovdqa         TMP3(%rsp), \T1
-        vmovdqu         HashKey_6(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpshufd         $0b01001110, \T1, \T3
-        vpxor           \T1, \T3, \T3
-        vmovdqu         HashKey_6_k(arg2), \T5
-        vpclmulqdq      $0x10, \T5, \T3, \T3
-        vpxor           \T3, \T6, \T6
-
-                vmovdqu 16*5(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-        vmovdqa         TMP4(%rsp), \T1
-        vmovdqu         HashKey_5(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpshufd         $0b01001110, \T1, \T3
-        vpxor           \T1, \T3, \T3
-        vmovdqu         HashKey_5_k(arg2), \T5
-        vpclmulqdq      $0x10, \T5, \T3, \T3
-        vpxor           \T3, \T6, \T6
-
-                vmovdqu 16*6(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-
-        vmovdqa         TMP5(%rsp), \T1
-        vmovdqu         HashKey_4(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpshufd         $0b01001110, \T1, \T3
-        vpxor           \T1, \T3, \T3
-        vmovdqu         HashKey_4_k(arg2), \T5
-        vpclmulqdq      $0x10, \T5, \T3, \T3
-        vpxor           \T3, \T6, \T6
-
-                vmovdqu 16*7(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-        vmovdqa         TMP6(%rsp), \T1
-        vmovdqu         HashKey_3(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpshufd         $0b01001110, \T1, \T3
-        vpxor           \T1, \T3, \T3
-        vmovdqu         HashKey_3_k(arg2), \T5
-        vpclmulqdq      $0x10, \T5, \T3, \T3
-        vpxor           \T3, \T6, \T6
-
-
-                vmovdqu 16*8(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-        vmovdqa         TMP7(%rsp), \T1
-        vmovdqu         HashKey_2(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpshufd         $0b01001110, \T1, \T3
-        vpxor           \T1, \T3, \T3
-        vmovdqu         HashKey_2_k(arg2), \T5
-        vpclmulqdq      $0x10, \T5, \T3, \T3
-        vpxor           \T3, \T6, \T6
-
-        #######################################################################
-
-                vmovdqu 16*9(arg1), \T5
-                vaesenc \T5, \XMM1, \XMM1
-                vaesenc \T5, \XMM2, \XMM2
-                vaesenc \T5, \XMM3, \XMM3
-                vaesenc \T5, \XMM4, \XMM4
-                vaesenc \T5, \XMM5, \XMM5
-                vaesenc \T5, \XMM6, \XMM6
-                vaesenc \T5, \XMM7, \XMM7
-                vaesenc \T5, \XMM8, \XMM8
-
-        vmovdqa         TMP8(%rsp), \T1
-        vmovdqu         HashKey(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpshufd         $0b01001110, \T1, \T3
-        vpxor           \T1, \T3, \T3
-        vmovdqu         HashKey_k(arg2), \T5
-        vpclmulqdq      $0x10, \T5, \T3, \T3
-        vpxor           \T3, \T6, \T6
-
-        vpxor           \T4, \T6, \T6
-        vpxor           \T7, \T6, \T6
-
-                vmovdqu 16*10(arg1), \T5
-
-        i = 11
-        setreg
-.rep (\REP-9)
-
-        vaesenc \T5, \XMM1, \XMM1
-        vaesenc \T5, \XMM2, \XMM2
-        vaesenc \T5, \XMM3, \XMM3
-        vaesenc \T5, \XMM4, \XMM4
-        vaesenc \T5, \XMM5, \XMM5
-        vaesenc \T5, \XMM6, \XMM6
-        vaesenc \T5, \XMM7, \XMM7
-        vaesenc \T5, \XMM8, \XMM8
-
-        vmovdqu 16*i(arg1), \T5
-        i = i + 1
-        setreg
-.endr
-
-	i = 0
-	j = 1
-	setreg
-.rep 8
-		vpxor	16*i(arg4, %r11), \T5, \T2
-                .if \ENC_DEC == ENC
-                vaesenclast     \T2, reg_j, reg_j
-                .else
-                vaesenclast     \T2, reg_j, \T3
-                vmovdqu 16*i(arg4, %r11), reg_j
-                vmovdqu \T3, 16*i(arg3, %r11)
-                .endif
-	i = (i+1)
-	j = (j+1)
-	setreg
-.endr
-	#######################################################################
-
-
-	vpslldq	$8, \T6, \T3				# shift-L T3 2 DWs
-	vpsrldq	$8, \T6, \T6				# shift-R T2 2 DWs
-	vpxor	\T3, \T7, \T7
-	vpxor	\T4, \T6, \T6				# accumulate the results in T6:T7
-
-
-
-	#######################################################################
-	#first phase of the reduction
-	#######################################################################
-        vpslld  $31, \T7, \T2                           # packed right shifting << 31
-        vpslld  $30, \T7, \T3                           # packed right shifting shift << 30
-        vpslld  $25, \T7, \T4                           # packed right shifting shift << 25
-
-        vpxor   \T3, \T2, \T2                           # xor the shifted versions
-        vpxor   \T4, \T2, \T2
-
-        vpsrldq $4, \T2, \T1                            # shift-R T1 1 DW
-
-        vpslldq $12, \T2, \T2                           # shift-L T2 3 DWs
-        vpxor   \T2, \T7, \T7                           # first phase of the reduction complete
-	#######################################################################
-                .if \ENC_DEC == ENC
-		vmovdqu	 \XMM1,	16*0(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM2,	16*1(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM3,	16*2(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM4,	16*3(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM5,	16*4(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM6,	16*5(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM7,	16*6(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM8,	16*7(arg3,%r11)		# Write to the Ciphertext buffer
-                .endif
-
-	#######################################################################
-	#second phase of the reduction
-        vpsrld  $1, \T7, \T2                            # packed left shifting >> 1
-        vpsrld  $2, \T7, \T3                            # packed left shifting >> 2
-        vpsrld  $7, \T7, \T4                            # packed left shifting >> 7
-        vpxor   \T3, \T2, \T2                           # xor the shifted versions
-        vpxor   \T4, \T2, \T2
-
-        vpxor   \T1, \T2, \T2
-        vpxor   \T2, \T7, \T7
-        vpxor   \T7, \T6, \T6                           # the result is in T6
-	#######################################################################
-
-		vpshufb	SHUF_MASK(%rip), \XMM1, \XMM1	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM2, \XMM2	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM3, \XMM3	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM4, \XMM4	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM5, \XMM5	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM6, \XMM6	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM7, \XMM7	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM8, \XMM8	# perform a 16Byte swap
-
-
-	vpxor	\T6, \XMM1, \XMM1
-
-
-
-.endm
-
-
-# GHASH the last 4 ciphertext blocks.
-.macro  GHASH_LAST_8_AVX T1 T2 T3 T4 T5 T6 T7 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8
-
-        ## Karatsuba Method
-
-
-        vpshufd         $0b01001110, \XMM1, \T2
-        vpxor           \XMM1, \T2, \T2
-        vmovdqu         HashKey_8(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \XMM1, \T6
-        vpclmulqdq      $0x00, \T5, \XMM1, \T7
-
-        vmovdqu         HashKey_8_k(arg2), \T3
-        vpclmulqdq      $0x00, \T3, \T2, \XMM1
-
-        ######################
-
-        vpshufd         $0b01001110, \XMM2, \T2
-        vpxor           \XMM2, \T2, \T2
-        vmovdqu         HashKey_7(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \XMM2, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM2, \T4
-        vpxor           \T4, \T7, \T7
-
-        vmovdqu         HashKey_7_k(arg2), \T3
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vpshufd         $0b01001110, \XMM3, \T2
-        vpxor           \XMM3, \T2, \T2
-        vmovdqu         HashKey_6(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \XMM3, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM3, \T4
-        vpxor           \T4, \T7, \T7
-
-        vmovdqu         HashKey_6_k(arg2), \T3
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vpshufd         $0b01001110, \XMM4, \T2
-        vpxor           \XMM4, \T2, \T2
-        vmovdqu         HashKey_5(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \XMM4, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM4, \T4
-        vpxor           \T4, \T7, \T7
-
-        vmovdqu         HashKey_5_k(arg2), \T3
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vpshufd         $0b01001110, \XMM5, \T2
-        vpxor           \XMM5, \T2, \T2
-        vmovdqu         HashKey_4(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \XMM5, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM5, \T4
-        vpxor           \T4, \T7, \T7
-
-        vmovdqu         HashKey_4_k(arg2), \T3
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vpshufd         $0b01001110, \XMM6, \T2
-        vpxor           \XMM6, \T2, \T2
-        vmovdqu         HashKey_3(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \XMM6, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM6, \T4
-        vpxor           \T4, \T7, \T7
-
-        vmovdqu         HashKey_3_k(arg2), \T3
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vpshufd         $0b01001110, \XMM7, \T2
-        vpxor           \XMM7, \T2, \T2
-        vmovdqu         HashKey_2(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \XMM7, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM7, \T4
-        vpxor           \T4, \T7, \T7
-
-        vmovdqu         HashKey_2_k(arg2), \T3
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vpshufd         $0b01001110, \XMM8, \T2
-        vpxor           \XMM8, \T2, \T2
-        vmovdqu         HashKey(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \XMM8, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM8, \T4
-        vpxor           \T4, \T7, \T7
-
-        vmovdqu         HashKey_k(arg2), \T3
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-
-        vpxor           \T2, \XMM1, \XMM1
-        vpxor           \T6, \XMM1, \XMM1
-        vpxor           \T7, \XMM1, \T2
-
-
-
-
-        vpslldq $8, \T2, \T4
-        vpsrldq $8, \T2, \T2
-
-        vpxor   \T4, \T7, \T7
-        vpxor   \T2, \T6, \T6   # <T6:T7> holds the result of
-				# the accumulated carry-less multiplications
-
-        #######################################################################
-        #first phase of the reduction
-        vpslld  $31, \T7, \T2   # packed right shifting << 31
-        vpslld  $30, \T7, \T3   # packed right shifting shift << 30
-        vpslld  $25, \T7, \T4   # packed right shifting shift << 25
-
-        vpxor   \T3, \T2, \T2   # xor the shifted versions
-        vpxor   \T4, \T2, \T2
-
-        vpsrldq $4, \T2, \T1    # shift-R T1 1 DW
-
-        vpslldq $12, \T2, \T2   # shift-L T2 3 DWs
-        vpxor   \T2, \T7, \T7   # first phase of the reduction complete
-        #######################################################################
-
-
-        #second phase of the reduction
-        vpsrld  $1, \T7, \T2    # packed left shifting >> 1
-        vpsrld  $2, \T7, \T3    # packed left shifting >> 2
-        vpsrld  $7, \T7, \T4    # packed left shifting >> 7
-        vpxor   \T3, \T2, \T2   # xor the shifted versions
-        vpxor   \T4, \T2, \T2
-
-        vpxor   \T1, \T2, \T2
-        vpxor   \T2, \T7, \T7
-        vpxor   \T7, \T6, \T6   # the result is in T6
-
-.endm
-
-#############################################################
-#void   aesni_gcm_precomp_avx_gen2
-#        (gcm_data     *my_ctx_data,
-#         gcm_context_data *data,
-#        u8     *hash_subkey# /* H, the Hash sub key input. Data starts on a 16-byte boundary. */
-#        u8      *iv, /* Pre-counter block j0: 4 byte salt
-#			(from Security Association) concatenated with 8 byte
-#			Initialisation Vector (from IPSec ESP Payload)
-#			concatenated with 0x00000001. 16-byte aligned pointer. */
-#        const   u8 *aad, /* Additional Authentication Data (AAD)*/
-#        u64     aad_len) /* Length of AAD in bytes. With RFC4106 this is going to be 8 or 12 Bytes */
-#############################################################
-SYM_FUNC_START(aesni_gcm_init_avx_gen2)
-        FUNC_SAVE
-        INIT GHASH_MUL_AVX, PRECOMPUTE_AVX
-        FUNC_RESTORE
-        RET
-SYM_FUNC_END(aesni_gcm_init_avx_gen2)
-
-###############################################################################
-#void   aesni_gcm_enc_update_avx_gen2(
-#        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
-#        gcm_context_data *data,
-#        u8      *out, /* Ciphertext output. Encrypt in-place is allowed.  */
-#        const   u8 *in, /* Plaintext input */
-#        u64     plaintext_len) /* Length of data in Bytes for encryption. */
-###############################################################################
-SYM_FUNC_START(aesni_gcm_enc_update_avx_gen2)
-        FUNC_SAVE
-        mov     keysize, %eax
-        cmp     $32, %eax
-        je      key_256_enc_update
-        cmp     $16, %eax
-        je      key_128_enc_update
-        # must be 192
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 11
-        FUNC_RESTORE
-        RET
-key_128_enc_update:
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 9
-        FUNC_RESTORE
-        RET
-key_256_enc_update:
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 13
-        FUNC_RESTORE
-        RET
-SYM_FUNC_END(aesni_gcm_enc_update_avx_gen2)
-
-###############################################################################
-#void   aesni_gcm_dec_update_avx_gen2(
-#        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
-#        gcm_context_data *data,
-#        u8      *out, /* Plaintext output. Decrypt in-place is allowed.  */
-#        const   u8 *in, /* Ciphertext input */
-#        u64     plaintext_len) /* Length of data in Bytes for encryption. */
-###############################################################################
-SYM_FUNC_START(aesni_gcm_dec_update_avx_gen2)
-        FUNC_SAVE
-        mov     keysize,%eax
-        cmp     $32, %eax
-        je      key_256_dec_update
-        cmp     $16, %eax
-        je      key_128_dec_update
-        # must be 192
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 11
-        FUNC_RESTORE
-        RET
-key_128_dec_update:
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 9
-        FUNC_RESTORE
-        RET
-key_256_dec_update:
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 13
-        FUNC_RESTORE
-        RET
-SYM_FUNC_END(aesni_gcm_dec_update_avx_gen2)
-
-###############################################################################
-#void   aesni_gcm_finalize_avx_gen2(
-#        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
-#        gcm_context_data *data,
-#        u8      *auth_tag, /* Authenticated Tag output. */
-#        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
-#				Valid values are 16 (most likely), 12 or 8. */
-###############################################################################
-SYM_FUNC_START(aesni_gcm_finalize_avx_gen2)
-        FUNC_SAVE
-        mov	keysize,%eax
-        cmp     $32, %eax
-        je      key_256_finalize
-        cmp     $16, %eax
-        je      key_128_finalize
-        # must be 192
-        GCM_COMPLETE GHASH_MUL_AVX, 11, arg3, arg4
-        FUNC_RESTORE
-        RET
-key_128_finalize:
-        GCM_COMPLETE GHASH_MUL_AVX, 9, arg3, arg4
-        FUNC_RESTORE
-        RET
-key_256_finalize:
-        GCM_COMPLETE GHASH_MUL_AVX, 13, arg3, arg4
-        FUNC_RESTORE
-        RET
-SYM_FUNC_END(aesni_gcm_finalize_avx_gen2)
-
-###############################################################################
-# GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
-# Input: A and B (128-bits each, bit-reflected)
-# Output: C = A*B*x mod poly, (i.e. >>1 )
-# To compute GH = GH*HashKey mod poly, give HK = HashKey<<1 mod poly as input
-# GH = GH * HK * x mod poly which is equivalent to GH*HashKey mod poly.
-###############################################################################
-.macro  GHASH_MUL_AVX2 GH HK T1 T2 T3 T4 T5
-
-        vpclmulqdq      $0x11,\HK,\GH,\T1      # T1 = a1*b1
-        vpclmulqdq      $0x00,\HK,\GH,\T2      # T2 = a0*b0
-        vpclmulqdq      $0x01,\HK,\GH,\T3      # T3 = a1*b0
-        vpclmulqdq      $0x10,\HK,\GH,\GH      # GH = a0*b1
-        vpxor           \T3, \GH, \GH
-
-
-        vpsrldq         $8 , \GH, \T3          # shift-R GH 2 DWs
-        vpslldq         $8 , \GH, \GH          # shift-L GH 2 DWs
-
-        vpxor           \T3, \T1, \T1
-        vpxor           \T2, \GH, \GH
-
-        #######################################################################
-        #first phase of the reduction
-        vmovdqa         POLY2(%rip), \T3
-
-        vpclmulqdq      $0x01, \GH, \T3, \T2
-        vpslldq         $8, \T2, \T2           # shift-L T2 2 DWs
-
-        vpxor           \T2, \GH, \GH          # first phase of the reduction complete
-        #######################################################################
-        #second phase of the reduction
-        vpclmulqdq      $0x00, \GH, \T3, \T2
-        vpsrldq         $4, \T2, \T2           # shift-R T2 1 DW (Shift-R only 1-DW to obtain 2-DWs shift-R)
-
-        vpclmulqdq      $0x10, \GH, \T3, \GH
-        vpslldq         $4, \GH, \GH           # shift-L GH 1 DW (Shift-L 1-DW to obtain result with no shifts)
-
-        vpxor           \T2, \GH, \GH          # second phase of the reduction complete
-        #######################################################################
-        vpxor           \T1, \GH, \GH          # the result is in GH
-
-
-.endm
-
-.macro PRECOMPUTE_AVX2 HK T1 T2 T3 T4 T5 T6
-
-        # Haskey_i_k holds XORed values of the low and high parts of the Haskey_i
-        vmovdqa  \HK, \T5
-        GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 = HashKey^2<<1 mod poly
-        vmovdqu  \T5, HashKey_2(arg2)                       #  [HashKey_2] = HashKey^2<<1 mod poly
-
-        GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 = HashKey^3<<1 mod poly
-        vmovdqu  \T5, HashKey_3(arg2)
-
-        GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 = HashKey^4<<1 mod poly
-        vmovdqu  \T5, HashKey_4(arg2)
-
-        GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 = HashKey^5<<1 mod poly
-        vmovdqu  \T5, HashKey_5(arg2)
-
-        GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 = HashKey^6<<1 mod poly
-        vmovdqu  \T5, HashKey_6(arg2)
-
-        GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 = HashKey^7<<1 mod poly
-        vmovdqu  \T5, HashKey_7(arg2)
-
-        GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 = HashKey^8<<1 mod poly
-        vmovdqu  \T5, HashKey_8(arg2)
-
-.endm
-
-## if a = number of total plaintext bytes
-## b = floor(a/16)
-## num_initial_blocks = b mod 4#
-## encrypt the initial num_initial_blocks blocks and apply ghash on the ciphertext
-## r10, r11, r12, rax are clobbered
-## arg1, arg2, arg3, arg4 are used as pointers only, not modified
-
-.macro INITIAL_BLOCKS_AVX2 REP num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC VER
-	i = (8-\num_initial_blocks)
-	setreg
-	vmovdqu AadHash(arg2), reg_i
-
-	# start AES for num_initial_blocks blocks
-	vmovdqu CurCount(arg2), \CTR
-
-	i = (9-\num_initial_blocks)
-	setreg
-.rep \num_initial_blocks
-                vpaddd  ONE(%rip), \CTR, \CTR   # INCR Y0
-                vmovdqa \CTR, reg_i
-                vpshufb SHUF_MASK(%rip), reg_i, reg_i     # perform a 16Byte swap
-	i = (i+1)
-	setreg
-.endr
-
-	vmovdqa  (arg1), \T_key
-	i = (9-\num_initial_blocks)
-	setreg
-.rep \num_initial_blocks
-                vpxor   \T_key, reg_i, reg_i
-	i = (i+1)
-	setreg
-.endr
-
-	j = 1
-	setreg
-.rep \REP
-	vmovdqa  16*j(arg1), \T_key
-	i = (9-\num_initial_blocks)
-	setreg
-.rep \num_initial_blocks
-        vaesenc \T_key, reg_i, reg_i
-	i = (i+1)
-	setreg
-.endr
-
-	j = (j+1)
-	setreg
-.endr
-
-
-	vmovdqa  16*j(arg1), \T_key
-	i = (9-\num_initial_blocks)
-	setreg
-.rep \num_initial_blocks
-        vaesenclast      \T_key, reg_i, reg_i
-	i = (i+1)
-	setreg
-.endr
-
-	i = (9-\num_initial_blocks)
-	setreg
-.rep \num_initial_blocks
-                vmovdqu (arg4, %r11), \T1
-                vpxor   \T1, reg_i, reg_i
-                vmovdqu reg_i, (arg3 , %r11)           # write back ciphertext for
-						       # num_initial_blocks blocks
-                add     $16, %r11
-.if  \ENC_DEC == DEC
-                vmovdqa \T1, reg_i
-.endif
-                vpshufb SHUF_MASK(%rip), reg_i, reg_i  # prepare ciphertext for GHASH computations
-	i = (i+1)
-	setreg
-.endr
-
-
-	i = (8-\num_initial_blocks)
-	j = (9-\num_initial_blocks)
-	setreg
-
-.rep \num_initial_blocks
-        vpxor    reg_i, reg_j, reg_j
-        GHASH_MUL_AVX2       reg_j, \T2, \T1, \T3, \T4, \T5, \T6  # apply GHASH on num_initial_blocks blocks
-	i = (i+1)
-	j = (j+1)
-	setreg
-.endr
-        # XMM8 has the combined result here
-
-        vmovdqa  \XMM8, TMP1(%rsp)
-        vmovdqa  \XMM8, \T3
-
-        cmp     $128, %r13
-        jl      .L_initial_blocks_done\@                  # no need for precomputed constants
-
-###############################################################################
-# Haskey_i_k holds XORed values of the low and high parts of the Haskey_i
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM1
-                vpshufb  SHUF_MASK(%rip), \XMM1, \XMM1  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM2
-                vpshufb  SHUF_MASK(%rip), \XMM2, \XMM2  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM3
-                vpshufb  SHUF_MASK(%rip), \XMM3, \XMM3  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM4
-                vpshufb  SHUF_MASK(%rip), \XMM4, \XMM4  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM5
-                vpshufb  SHUF_MASK(%rip), \XMM5, \XMM5  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM6
-                vpshufb  SHUF_MASK(%rip), \XMM6, \XMM6  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM7
-                vpshufb  SHUF_MASK(%rip), \XMM7, \XMM7  # perform a 16Byte swap
-
-                vpaddd   ONE(%rip), \CTR, \CTR          # INCR Y0
-                vmovdqa  \CTR, \XMM8
-                vpshufb  SHUF_MASK(%rip), \XMM8, \XMM8  # perform a 16Byte swap
-
-                vmovdqa  (arg1), \T_key
-                vpxor    \T_key, \XMM1, \XMM1
-                vpxor    \T_key, \XMM2, \XMM2
-                vpxor    \T_key, \XMM3, \XMM3
-                vpxor    \T_key, \XMM4, \XMM4
-                vpxor    \T_key, \XMM5, \XMM5
-                vpxor    \T_key, \XMM6, \XMM6
-                vpxor    \T_key, \XMM7, \XMM7
-                vpxor    \T_key, \XMM8, \XMM8
-
-		i = 1
-		setreg
-.rep    \REP       # do REP rounds
-                vmovdqa  16*i(arg1), \T_key
-                vaesenc  \T_key, \XMM1, \XMM1
-                vaesenc  \T_key, \XMM2, \XMM2
-                vaesenc  \T_key, \XMM3, \XMM3
-                vaesenc  \T_key, \XMM4, \XMM4
-                vaesenc  \T_key, \XMM5, \XMM5
-                vaesenc  \T_key, \XMM6, \XMM6
-                vaesenc  \T_key, \XMM7, \XMM7
-                vaesenc  \T_key, \XMM8, \XMM8
-		i = (i+1)
-		setreg
-.endr
-
-
-                vmovdqa  16*i(arg1), \T_key
-                vaesenclast  \T_key, \XMM1, \XMM1
-                vaesenclast  \T_key, \XMM2, \XMM2
-                vaesenclast  \T_key, \XMM3, \XMM3
-                vaesenclast  \T_key, \XMM4, \XMM4
-                vaesenclast  \T_key, \XMM5, \XMM5
-                vaesenclast  \T_key, \XMM6, \XMM6
-                vaesenclast  \T_key, \XMM7, \XMM7
-                vaesenclast  \T_key, \XMM8, \XMM8
-
-                vmovdqu  (arg4, %r11), \T1
-                vpxor    \T1, \XMM1, \XMM1
-                vmovdqu  \XMM1, (arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM1
-                .endif
-
-                vmovdqu  16*1(arg4, %r11), \T1
-                vpxor    \T1, \XMM2, \XMM2
-                vmovdqu  \XMM2, 16*1(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM2
-                .endif
-
-                vmovdqu  16*2(arg4, %r11), \T1
-                vpxor    \T1, \XMM3, \XMM3
-                vmovdqu  \XMM3, 16*2(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM3
-                .endif
-
-                vmovdqu  16*3(arg4, %r11), \T1
-                vpxor    \T1, \XMM4, \XMM4
-                vmovdqu  \XMM4, 16*3(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM4
-                .endif
-
-                vmovdqu  16*4(arg4, %r11), \T1
-                vpxor    \T1, \XMM5, \XMM5
-                vmovdqu  \XMM5, 16*4(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM5
-                .endif
-
-                vmovdqu  16*5(arg4, %r11), \T1
-                vpxor    \T1, \XMM6, \XMM6
-                vmovdqu  \XMM6, 16*5(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM6
-                .endif
-
-                vmovdqu  16*6(arg4, %r11), \T1
-                vpxor    \T1, \XMM7, \XMM7
-                vmovdqu  \XMM7, 16*6(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM7
-                .endif
-
-                vmovdqu  16*7(arg4, %r11), \T1
-                vpxor    \T1, \XMM8, \XMM8
-                vmovdqu  \XMM8, 16*7(arg3 , %r11)
-                .if   \ENC_DEC == DEC
-                vmovdqa  \T1, \XMM8
-                .endif
-
-                add     $128, %r11
-
-                vpshufb  SHUF_MASK(%rip), \XMM1, \XMM1     # perform a 16Byte swap
-                vpxor    TMP1(%rsp), \XMM1, \XMM1          # combine GHASHed value with
-							   # the corresponding ciphertext
-                vpshufb  SHUF_MASK(%rip), \XMM2, \XMM2     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM3, \XMM3     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM4, \XMM4     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM5, \XMM5     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM6, \XMM6     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM7, \XMM7     # perform a 16Byte swap
-                vpshufb  SHUF_MASK(%rip), \XMM8, \XMM8     # perform a 16Byte swap
-
-###############################################################################
-
-.L_initial_blocks_done\@:
-
-
-.endm
-
-
-
-# encrypt 8 blocks at a time
-# ghash the 8 previously encrypted ciphertext blocks
-# arg1, arg2, arg3, arg4 are used as pointers only, not modified
-# r11 is the data offset value
-.macro GHASH_8_ENCRYPT_8_PARALLEL_AVX2 REP T1 T2 T3 T4 T5 T6 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T7 loop_idx ENC_DEC
-
-        vmovdqa \XMM1, \T2
-        vmovdqa \XMM2, TMP2(%rsp)
-        vmovdqa \XMM3, TMP3(%rsp)
-        vmovdqa \XMM4, TMP4(%rsp)
-        vmovdqa \XMM5, TMP5(%rsp)
-        vmovdqa \XMM6, TMP6(%rsp)
-        vmovdqa \XMM7, TMP7(%rsp)
-        vmovdqa \XMM8, TMP8(%rsp)
-
-.if \loop_idx == in_order
-                vpaddd  ONE(%rip), \CTR, \XMM1            # INCR CNT
-                vpaddd  ONE(%rip), \XMM1, \XMM2
-                vpaddd  ONE(%rip), \XMM2, \XMM3
-                vpaddd  ONE(%rip), \XMM3, \XMM4
-                vpaddd  ONE(%rip), \XMM4, \XMM5
-                vpaddd  ONE(%rip), \XMM5, \XMM6
-                vpaddd  ONE(%rip), \XMM6, \XMM7
-                vpaddd  ONE(%rip), \XMM7, \XMM8
-                vmovdqa \XMM8, \CTR
-
-                vpshufb SHUF_MASK(%rip), \XMM1, \XMM1     # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM2, \XMM2     # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM3, \XMM3     # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM4, \XMM4     # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM5, \XMM5     # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM6, \XMM6     # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM7, \XMM7     # perform a 16Byte swap
-                vpshufb SHUF_MASK(%rip), \XMM8, \XMM8     # perform a 16Byte swap
-.else
-                vpaddd  ONEf(%rip), \CTR, \XMM1            # INCR CNT
-                vpaddd  ONEf(%rip), \XMM1, \XMM2
-                vpaddd  ONEf(%rip), \XMM2, \XMM3
-                vpaddd  ONEf(%rip), \XMM3, \XMM4
-                vpaddd  ONEf(%rip), \XMM4, \XMM5
-                vpaddd  ONEf(%rip), \XMM5, \XMM6
-                vpaddd  ONEf(%rip), \XMM6, \XMM7
-                vpaddd  ONEf(%rip), \XMM7, \XMM8
-                vmovdqa \XMM8, \CTR
-.endif
-
-
-        #######################################################################
-
-                vmovdqu (arg1), \T1
-                vpxor   \T1, \XMM1, \XMM1
-                vpxor   \T1, \XMM2, \XMM2
-                vpxor   \T1, \XMM3, \XMM3
-                vpxor   \T1, \XMM4, \XMM4
-                vpxor   \T1, \XMM5, \XMM5
-                vpxor   \T1, \XMM6, \XMM6
-                vpxor   \T1, \XMM7, \XMM7
-                vpxor   \T1, \XMM8, \XMM8
-
-        #######################################################################
-
-
-
-
-
-                vmovdqu 16*1(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-                vmovdqu 16*2(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-
-        #######################################################################
-
-        vmovdqu         HashKey_8(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T2, \T4              # T4 = a1*b1
-        vpclmulqdq      $0x00, \T5, \T2, \T7              # T7 = a0*b0
-        vpclmulqdq      $0x01, \T5, \T2, \T6              # T6 = a1*b0
-        vpclmulqdq      $0x10, \T5, \T2, \T5              # T5 = a0*b1
-        vpxor           \T5, \T6, \T6
-
-                vmovdqu 16*3(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-        vmovdqa         TMP2(%rsp), \T1
-        vmovdqu         HashKey_7(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpclmulqdq      $0x01, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-        vpclmulqdq      $0x10, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-                vmovdqu 16*4(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-        #######################################################################
-
-        vmovdqa         TMP3(%rsp), \T1
-        vmovdqu         HashKey_6(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpclmulqdq      $0x01, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-        vpclmulqdq      $0x10, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-                vmovdqu 16*5(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-        vmovdqa         TMP4(%rsp), \T1
-        vmovdqu         HashKey_5(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpclmulqdq      $0x01, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-        vpclmulqdq      $0x10, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-                vmovdqu 16*6(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-
-        vmovdqa         TMP5(%rsp), \T1
-        vmovdqu         HashKey_4(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpclmulqdq      $0x01, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-        vpclmulqdq      $0x10, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-                vmovdqu 16*7(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-        vmovdqa         TMP6(%rsp), \T1
-        vmovdqu         HashKey_3(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpclmulqdq      $0x01, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-        vpclmulqdq      $0x10, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-                vmovdqu 16*8(arg1), \T1
-                vaesenc \T1, \XMM1, \XMM1
-                vaesenc \T1, \XMM2, \XMM2
-                vaesenc \T1, \XMM3, \XMM3
-                vaesenc \T1, \XMM4, \XMM4
-                vaesenc \T1, \XMM5, \XMM5
-                vaesenc \T1, \XMM6, \XMM6
-                vaesenc \T1, \XMM7, \XMM7
-                vaesenc \T1, \XMM8, \XMM8
-
-        vmovdqa         TMP7(%rsp), \T1
-        vmovdqu         HashKey_2(arg2), \T5
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T4
-
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpclmulqdq      $0x01, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-        vpclmulqdq      $0x10, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-
-        #######################################################################
-
-                vmovdqu 16*9(arg1), \T5
-                vaesenc \T5, \XMM1, \XMM1
-                vaesenc \T5, \XMM2, \XMM2
-                vaesenc \T5, \XMM3, \XMM3
-                vaesenc \T5, \XMM4, \XMM4
-                vaesenc \T5, \XMM5, \XMM5
-                vaesenc \T5, \XMM6, \XMM6
-                vaesenc \T5, \XMM7, \XMM7
-                vaesenc \T5, \XMM8, \XMM8
-
-        vmovdqa         TMP8(%rsp), \T1
-        vmovdqu         HashKey(arg2), \T5
-
-        vpclmulqdq      $0x00, \T5, \T1, \T3
-        vpxor           \T3, \T7, \T7
-
-        vpclmulqdq      $0x01, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-        vpclmulqdq      $0x10, \T5, \T1, \T3
-        vpxor           \T3, \T6, \T6
-
-        vpclmulqdq      $0x11, \T5, \T1, \T3
-        vpxor           \T3, \T4, \T1
-
-
-                vmovdqu 16*10(arg1), \T5
-
-        i = 11
-        setreg
-.rep (\REP-9)
-        vaesenc \T5, \XMM1, \XMM1
-        vaesenc \T5, \XMM2, \XMM2
-        vaesenc \T5, \XMM3, \XMM3
-        vaesenc \T5, \XMM4, \XMM4
-        vaesenc \T5, \XMM5, \XMM5
-        vaesenc \T5, \XMM6, \XMM6
-        vaesenc \T5, \XMM7, \XMM7
-        vaesenc \T5, \XMM8, \XMM8
-
-        vmovdqu 16*i(arg1), \T5
-        i = i + 1
-        setreg
-.endr
-
-	i = 0
-	j = 1
-	setreg
-.rep 8
-		vpxor	16*i(arg4, %r11), \T5, \T2
-                .if \ENC_DEC == ENC
-                vaesenclast     \T2, reg_j, reg_j
-                .else
-                vaesenclast     \T2, reg_j, \T3
-                vmovdqu 16*i(arg4, %r11), reg_j
-                vmovdqu \T3, 16*i(arg3, %r11)
-                .endif
-	i = (i+1)
-	j = (j+1)
-	setreg
-.endr
-	#######################################################################
-
-
-	vpslldq	$8, \T6, \T3				# shift-L T3 2 DWs
-	vpsrldq	$8, \T6, \T6				# shift-R T2 2 DWs
-	vpxor	\T3, \T7, \T7
-	vpxor	\T6, \T1, \T1				# accumulate the results in T1:T7
-
-
-
-	#######################################################################
-	#first phase of the reduction
-	vmovdqa         POLY2(%rip), \T3
-
-	vpclmulqdq	$0x01, \T7, \T3, \T2
-	vpslldq		$8, \T2, \T2			# shift-L xmm2 2 DWs
-
-	vpxor		\T2, \T7, \T7			# first phase of the reduction complete
-	#######################################################################
-                .if \ENC_DEC == ENC
-		vmovdqu	 \XMM1,	16*0(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM2,	16*1(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM3,	16*2(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM4,	16*3(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM5,	16*4(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM6,	16*5(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM7,	16*6(arg3,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM8,	16*7(arg3,%r11)		# Write to the Ciphertext buffer
-                .endif
-
-	#######################################################################
-	#second phase of the reduction
-	vpclmulqdq	$0x00, \T7, \T3, \T2
-	vpsrldq		$4, \T2, \T2			# shift-R xmm2 1 DW (Shift-R only 1-DW to obtain 2-DWs shift-R)
-
-	vpclmulqdq	$0x10, \T7, \T3, \T4
-	vpslldq		$4, \T4, \T4			# shift-L xmm0 1 DW (Shift-L 1-DW to obtain result with no shifts)
-
-	vpxor		\T2, \T4, \T4			# second phase of the reduction complete
-	#######################################################################
-	vpxor		\T4, \T1, \T1			# the result is in T1
-
-		vpshufb	SHUF_MASK(%rip), \XMM1, \XMM1	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM2, \XMM2	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM3, \XMM3	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM4, \XMM4	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM5, \XMM5	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM6, \XMM6	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM7, \XMM7	# perform a 16Byte swap
-		vpshufb	SHUF_MASK(%rip), \XMM8, \XMM8	# perform a 16Byte swap
-
-
-	vpxor	\T1, \XMM1, \XMM1
-
-
-
-.endm
-
-
-# GHASH the last 4 ciphertext blocks.
-.macro  GHASH_LAST_8_AVX2 T1 T2 T3 T4 T5 T6 T7 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8
-
-        ## Karatsuba Method
-
-        vmovdqu         HashKey_8(arg2), \T5
-
-        vpshufd         $0b01001110, \XMM1, \T2
-        vpshufd         $0b01001110, \T5, \T3
-        vpxor           \XMM1, \T2, \T2
-        vpxor           \T5, \T3, \T3
-
-        vpclmulqdq      $0x11, \T5, \XMM1, \T6
-        vpclmulqdq      $0x00, \T5, \XMM1, \T7
-
-        vpclmulqdq      $0x00, \T3, \T2, \XMM1
-
-        ######################
-
-        vmovdqu         HashKey_7(arg2), \T5
-        vpshufd         $0b01001110, \XMM2, \T2
-        vpshufd         $0b01001110, \T5, \T3
-        vpxor           \XMM2, \T2, \T2
-        vpxor           \T5, \T3, \T3
-
-        vpclmulqdq      $0x11, \T5, \XMM2, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM2, \T4
-        vpxor           \T4, \T7, \T7
-
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vmovdqu         HashKey_6(arg2), \T5
-        vpshufd         $0b01001110, \XMM3, \T2
-        vpshufd         $0b01001110, \T5, \T3
-        vpxor           \XMM3, \T2, \T2
-        vpxor           \T5, \T3, \T3
-
-        vpclmulqdq      $0x11, \T5, \XMM3, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM3, \T4
-        vpxor           \T4, \T7, \T7
-
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vmovdqu         HashKey_5(arg2), \T5
-        vpshufd         $0b01001110, \XMM4, \T2
-        vpshufd         $0b01001110, \T5, \T3
-        vpxor           \XMM4, \T2, \T2
-        vpxor           \T5, \T3, \T3
-
-        vpclmulqdq      $0x11, \T5, \XMM4, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM4, \T4
-        vpxor           \T4, \T7, \T7
-
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vmovdqu         HashKey_4(arg2), \T5
-        vpshufd         $0b01001110, \XMM5, \T2
-        vpshufd         $0b01001110, \T5, \T3
-        vpxor           \XMM5, \T2, \T2
-        vpxor           \T5, \T3, \T3
-
-        vpclmulqdq      $0x11, \T5, \XMM5, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM5, \T4
-        vpxor           \T4, \T7, \T7
-
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vmovdqu         HashKey_3(arg2), \T5
-        vpshufd         $0b01001110, \XMM6, \T2
-        vpshufd         $0b01001110, \T5, \T3
-        vpxor           \XMM6, \T2, \T2
-        vpxor           \T5, \T3, \T3
-
-        vpclmulqdq      $0x11, \T5, \XMM6, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM6, \T4
-        vpxor           \T4, \T7, \T7
-
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vmovdqu         HashKey_2(arg2), \T5
-        vpshufd         $0b01001110, \XMM7, \T2
-        vpshufd         $0b01001110, \T5, \T3
-        vpxor           \XMM7, \T2, \T2
-        vpxor           \T5, \T3, \T3
-
-        vpclmulqdq      $0x11, \T5, \XMM7, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM7, \T4
-        vpxor           \T4, \T7, \T7
-
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-
-        vpxor           \T2, \XMM1, \XMM1
-
-        ######################
-
-        vmovdqu         HashKey(arg2), \T5
-        vpshufd         $0b01001110, \XMM8, \T2
-        vpshufd         $0b01001110, \T5, \T3
-        vpxor           \XMM8, \T2, \T2
-        vpxor           \T5, \T3, \T3
-
-        vpclmulqdq      $0x11, \T5, \XMM8, \T4
-        vpxor           \T4, \T6, \T6
-
-        vpclmulqdq      $0x00, \T5, \XMM8, \T4
-        vpxor           \T4, \T7, \T7
-
-        vpclmulqdq      $0x00, \T3, \T2, \T2
-
-        vpxor           \T2, \XMM1, \XMM1
-        vpxor           \T6, \XMM1, \XMM1
-        vpxor           \T7, \XMM1, \T2
-
-
-
-
-        vpslldq $8, \T2, \T4
-        vpsrldq $8, \T2, \T2
-
-        vpxor   \T4, \T7, \T7
-        vpxor   \T2, \T6, \T6                      # <T6:T7> holds the result of the
-						   # accumulated carry-less multiplications
-
-        #######################################################################
-        #first phase of the reduction
-        vmovdqa         POLY2(%rip), \T3
-
-        vpclmulqdq      $0x01, \T7, \T3, \T2
-        vpslldq         $8, \T2, \T2               # shift-L xmm2 2 DWs
-
-        vpxor           \T2, \T7, \T7              # first phase of the reduction complete
-        #######################################################################
-
-
-        #second phase of the reduction
-        vpclmulqdq      $0x00, \T7, \T3, \T2
-        vpsrldq         $4, \T2, \T2               # shift-R T2 1 DW (Shift-R only 1-DW to obtain 2-DWs shift-R)
-
-        vpclmulqdq      $0x10, \T7, \T3, \T4
-        vpslldq         $4, \T4, \T4               # shift-L T4 1 DW (Shift-L 1-DW to obtain result with no shifts)
-
-        vpxor           \T2, \T4, \T4              # second phase of the reduction complete
-        #######################################################################
-        vpxor           \T4, \T6, \T6              # the result is in T6
-.endm
-
-
-
-#############################################################
-#void   aesni_gcm_init_avx_gen4
-#        (gcm_data     *my_ctx_data,
-#         gcm_context_data *data,
-#        u8      *iv, /* Pre-counter block j0: 4 byte salt
-#			(from Security Association) concatenated with 8 byte
-#			Initialisation Vector (from IPSec ESP Payload)
-#			concatenated with 0x00000001. 16-byte aligned pointer. */
-#        u8     *hash_subkey# /* H, the Hash sub key input. Data starts on a 16-byte boundary. */
-#        const   u8 *aad, /* Additional Authentication Data (AAD)*/
-#        u64     aad_len) /* Length of AAD in bytes. With RFC4106 this is going to be 8 or 12 Bytes */
-#############################################################
-SYM_FUNC_START(aesni_gcm_init_avx_gen4)
-        FUNC_SAVE
-        INIT GHASH_MUL_AVX2, PRECOMPUTE_AVX2
-        FUNC_RESTORE
-        RET
-SYM_FUNC_END(aesni_gcm_init_avx_gen4)
-
-###############################################################################
-#void   aesni_gcm_enc_avx_gen4(
-#        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
-#        gcm_context_data *data,
-#        u8      *out, /* Ciphertext output. Encrypt in-place is allowed.  */
-#        const   u8 *in, /* Plaintext input */
-#        u64     plaintext_len) /* Length of data in Bytes for encryption. */
-###############################################################################
-SYM_FUNC_START(aesni_gcm_enc_update_avx_gen4)
-        FUNC_SAVE
-        mov     keysize,%eax
-        cmp     $32, %eax
-        je      key_256_enc_update4
-        cmp     $16, %eax
-        je      key_128_enc_update4
-        # must be 192
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 11
-        FUNC_RESTORE
-	RET
-key_128_enc_update4:
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 9
-        FUNC_RESTORE
-	RET
-key_256_enc_update4:
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 13
-        FUNC_RESTORE
-	RET
-SYM_FUNC_END(aesni_gcm_enc_update_avx_gen4)
-
-###############################################################################
-#void   aesni_gcm_dec_update_avx_gen4(
-#        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
-#        gcm_context_data *data,
-#        u8      *out, /* Plaintext output. Decrypt in-place is allowed.  */
-#        const   u8 *in, /* Ciphertext input */
-#        u64     plaintext_len) /* Length of data in Bytes for encryption. */
-###############################################################################
-SYM_FUNC_START(aesni_gcm_dec_update_avx_gen4)
-        FUNC_SAVE
-        mov     keysize,%eax
-        cmp     $32, %eax
-        je      key_256_dec_update4
-        cmp     $16, %eax
-        je      key_128_dec_update4
-        # must be 192
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 11
-        FUNC_RESTORE
-        RET
-key_128_dec_update4:
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 9
-        FUNC_RESTORE
-        RET
-key_256_dec_update4:
-        GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 13
-        FUNC_RESTORE
-        RET
-SYM_FUNC_END(aesni_gcm_dec_update_avx_gen4)
-
-###############################################################################
-#void   aesni_gcm_finalize_avx_gen4(
-#        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
-#        gcm_context_data *data,
-#        u8      *auth_tag, /* Authenticated Tag output. */
-#        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
-#                              Valid values are 16 (most likely), 12 or 8. */
-###############################################################################
-SYM_FUNC_START(aesni_gcm_finalize_avx_gen4)
-        FUNC_SAVE
-        mov	keysize,%eax
-        cmp     $32, %eax
-        je      key_256_finalize4
-        cmp     $16, %eax
-        je      key_128_finalize4
-        # must be 192
-        GCM_COMPLETE GHASH_MUL_AVX2, 11, arg3, arg4
-        FUNC_RESTORE
-        RET
-key_128_finalize4:
-        GCM_COMPLETE GHASH_MUL_AVX2, 9, arg3, arg4
-        FUNC_RESTORE
-        RET
-key_256_finalize4:
-        GCM_COMPLETE GHASH_MUL_AVX2, 13, arg3, arg4
-        FUNC_RESTORE
-        RET
-SYM_FUNC_END(aesni_gcm_finalize_avx_gen4)
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index c1cc01583103..cd37de5ec404 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -44,45 +44,15 @@
 #define AES_BLOCK_MASK	(~(AES_BLOCK_SIZE - 1))
 #define AESNI_ALIGN_EXTRA ((AESNI_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
 #define CRYPTO_AES_CTX_SIZE (sizeof(struct crypto_aes_ctx) + AESNI_ALIGN_EXTRA)
 #define XTS_AES_CTX_SIZE (sizeof(struct aesni_xts_ctx) + AESNI_ALIGN_EXTRA)
 
-/* This data is stored at the end of the crypto_tfm struct.
- * It's a type of per "session" data storage location.
- * This needs to be 16 byte aligned.
- */
-struct aesni_rfc4106_gcm_ctx {
-	u8 hash_subkey[16] AESNI_ALIGN_ATTR;
-	struct crypto_aes_ctx aes_key_expanded AESNI_ALIGN_ATTR;
-	u8 nonce[4];
-};
-
-struct generic_gcmaes_ctx {
-	u8 hash_subkey[16] AESNI_ALIGN_ATTR;
-	struct crypto_aes_ctx aes_key_expanded AESNI_ALIGN_ATTR;
-};
-
 struct aesni_xts_ctx {
 	struct crypto_aes_ctx tweak_ctx AESNI_ALIGN_ATTR;
 	struct crypto_aes_ctx crypt_ctx AESNI_ALIGN_ATTR;
 };
 
-#define GCM_BLOCK_LEN 16
-
-struct gcm_context_data {
-	/* init, update and finalize context data */
-	u8 aad_hash[GCM_BLOCK_LEN];
-	u64 aad_length;
-	u64 in_length;
-	u8 partial_block_enc_key[GCM_BLOCK_LEN];
-	u8 orig_IV[GCM_BLOCK_LEN];
-	u8 current_counter[GCM_BLOCK_LEN];
-	u64 partial_block_len;
-	u64 unused;
-	u8 hash_keys[GCM_BLOCK_LEN * 16];
-};
-
 static inline void *aes_align_addr(void *addr)
 {
 	if (crypto_tfm_ctx_alignment() >= AESNI_ALIGN)
 		return addr;
 	return PTR_ALIGN(addr, AESNI_ALIGN);
@@ -103,13 +73,10 @@ asmlinkage void aesni_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
 asmlinkage void aesni_cts_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out,
 				  const u8 *in, unsigned int len, u8 *iv);
 asmlinkage void aesni_cts_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
 				  const u8 *in, unsigned int len, u8 *iv);
 
-#define AVX_GEN2_OPTSIZE 640
-#define AVX_GEN4_OPTSIZE 4096
-
 asmlinkage void aesni_xts_enc(const struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len, u8 *iv);
 
 asmlinkage void aesni_xts_dec(const struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len, u8 *iv);
@@ -118,27 +85,10 @@ asmlinkage void aesni_xts_dec(const struct crypto_aes_ctx *ctx, u8 *out,
 
 asmlinkage void aesni_ctr_enc(struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len, u8 *iv);
 DEFINE_STATIC_CALL(aesni_ctr_enc_tfm, aesni_ctr_enc);
 
-/* Scatter / Gather routines, with args similar to above */
-asmlinkage void aesni_gcm_init(void *ctx,
-			       struct gcm_context_data *gdata,
-			       u8 *iv,
-			       u8 *hash_subkey, const u8 *aad,
-			       unsigned long aad_len);
-asmlinkage void aesni_gcm_enc_update(void *ctx,
-				     struct gcm_context_data *gdata, u8 *out,
-				     const u8 *in, unsigned long plaintext_len);
-asmlinkage void aesni_gcm_dec_update(void *ctx,
-				     struct gcm_context_data *gdata, u8 *out,
-				     const u8 *in,
-				     unsigned long ciphertext_len);
-asmlinkage void aesni_gcm_finalize(void *ctx,
-				   struct gcm_context_data *gdata,
-				   u8 *auth_tag, unsigned long auth_tag_len);
-
 asmlinkage void aes_ctr_enc_128_avx_by8(const u8 *in, u8 *iv,
 		void *keys, u8 *out, unsigned int num_bytes);
 asmlinkage void aes_ctr_enc_192_avx_by8(const u8 *in, u8 *iv,
 		void *keys, u8 *out, unsigned int num_bytes);
 asmlinkage void aes_ctr_enc_256_avx_by8(const u8 *in, u8 *iv,
@@ -154,71 +104,10 @@ asmlinkage void aes_xctr_enc_192_avx_by8(const u8 *in, const u8 *iv,
 	unsigned int byte_ctr);
 
 asmlinkage void aes_xctr_enc_256_avx_by8(const u8 *in, const u8 *iv,
 	const void *keys, u8 *out, unsigned int num_bytes,
 	unsigned int byte_ctr);
-
-/*
- * asmlinkage void aesni_gcm_init_avx_gen2()
- * gcm_data *my_ctx_data, context data
- * u8 *hash_subkey,  the Hash sub key input. Data starts on a 16-byte boundary.
- */
-asmlinkage void aesni_gcm_init_avx_gen2(void *my_ctx_data,
-					struct gcm_context_data *gdata,
-					u8 *iv,
-					u8 *hash_subkey,
-					const u8 *aad,
-					unsigned long aad_len);
-
-asmlinkage void aesni_gcm_enc_update_avx_gen2(void *ctx,
-				     struct gcm_context_data *gdata, u8 *out,
-				     const u8 *in, unsigned long plaintext_len);
-asmlinkage void aesni_gcm_dec_update_avx_gen2(void *ctx,
-				     struct gcm_context_data *gdata, u8 *out,
-				     const u8 *in,
-				     unsigned long ciphertext_len);
-asmlinkage void aesni_gcm_finalize_avx_gen2(void *ctx,
-				   struct gcm_context_data *gdata,
-				   u8 *auth_tag, unsigned long auth_tag_len);
-
-/*
- * asmlinkage void aesni_gcm_init_avx_gen4()
- * gcm_data *my_ctx_data, context data
- * u8 *hash_subkey,  the Hash sub key input. Data starts on a 16-byte boundary.
- */
-asmlinkage void aesni_gcm_init_avx_gen4(void *my_ctx_data,
-					struct gcm_context_data *gdata,
-					u8 *iv,
-					u8 *hash_subkey,
-					const u8 *aad,
-					unsigned long aad_len);
-
-asmlinkage void aesni_gcm_enc_update_avx_gen4(void *ctx,
-				     struct gcm_context_data *gdata, u8 *out,
-				     const u8 *in, unsigned long plaintext_len);
-asmlinkage void aesni_gcm_dec_update_avx_gen4(void *ctx,
-				     struct gcm_context_data *gdata, u8 *out,
-				     const u8 *in,
-				     unsigned long ciphertext_len);
-asmlinkage void aesni_gcm_finalize_avx_gen4(void *ctx,
-				   struct gcm_context_data *gdata,
-				   u8 *auth_tag, unsigned long auth_tag_len);
-
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(gcm_use_avx);
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(gcm_use_avx2);
-
-static inline struct
-aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
-{
-	return aes_align_addr(crypto_aead_ctx(tfm));
-}
-
-static inline struct
-generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
-{
-	return aes_align_addr(crypto_aead_ctx(tfm));
-}
 #endif
 
 static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
 {
 	return aes_align_addr(raw_ctx);
@@ -588,284 +477,10 @@ static int xctr_crypt(struct skcipher_request *req)
 		kernel_fpu_end();
 		err = skcipher_walk_done(&walk, nbytes);
 	}
 	return err;
 }
-
-static int aes_gcm_derive_hash_subkey(const struct crypto_aes_ctx *aes_key,
-				      u8 hash_subkey[AES_BLOCK_SIZE])
-{
-	static const u8 zeroes[AES_BLOCK_SIZE];
-
-	aes_encrypt(aes_key, hash_subkey, zeroes);
-	return 0;
-}
-
-static int common_rfc4106_set_key(struct crypto_aead *aead, const u8 *key,
-				  unsigned int key_len)
-{
-	struct aesni_rfc4106_gcm_ctx *ctx = aesni_rfc4106_gcm_ctx_get(aead);
-
-	if (key_len < 4)
-		return -EINVAL;
-
-	/*Account for 4 byte nonce at the end.*/
-	key_len -= 4;
-
-	memcpy(ctx->nonce, key + key_len, sizeof(ctx->nonce));
-
-	return aes_set_key_common(&ctx->aes_key_expanded, key, key_len) ?:
-	       aes_gcm_derive_hash_subkey(&ctx->aes_key_expanded,
-					  ctx->hash_subkey);
-}
-
-/* This is the Integrity Check Value (aka the authentication tag) length and can
- * be 8, 12 or 16 bytes long. */
-static int common_rfc4106_set_authsize(struct crypto_aead *aead,
-				       unsigned int authsize)
-{
-	switch (authsize) {
-	case 8:
-	case 12:
-	case 16:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int generic_gcmaes_set_authsize(struct crypto_aead *tfm,
-				       unsigned int authsize)
-{
-	switch (authsize) {
-	case 4:
-	case 8:
-	case 12:
-	case 13:
-	case 14:
-	case 15:
-	case 16:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int gcmaes_crypt_by_sg(bool enc, struct aead_request *req,
-			      unsigned int assoclen, u8 *hash_subkey,
-			      u8 *iv, void *aes_ctx, u8 *auth_tag,
-			      unsigned long auth_tag_len)
-{
-	u8 databuf[sizeof(struct gcm_context_data) + (AESNI_ALIGN - 8)] __aligned(8);
-	struct gcm_context_data *data = PTR_ALIGN((void *)databuf, AESNI_ALIGN);
-	unsigned long left = req->cryptlen;
-	struct scatter_walk assoc_sg_walk;
-	struct skcipher_walk walk;
-	bool do_avx, do_avx2;
-	u8 *assocmem = NULL;
-	u8 *assoc;
-	int err;
-
-	if (!enc)
-		left -= auth_tag_len;
-
-	do_avx = (left >= AVX_GEN2_OPTSIZE);
-	do_avx2 = (left >= AVX_GEN4_OPTSIZE);
-
-	/* Linearize assoc, if not already linear */
-	if (req->src->length >= assoclen && req->src->length) {
-		scatterwalk_start(&assoc_sg_walk, req->src);
-		assoc = scatterwalk_map(&assoc_sg_walk);
-	} else {
-		gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-			      GFP_KERNEL : GFP_ATOMIC;
-
-		/* assoc can be any length, so must be on heap */
-		assocmem = kmalloc(assoclen, flags);
-		if (unlikely(!assocmem))
-			return -ENOMEM;
-		assoc = assocmem;
-
-		scatterwalk_map_and_copy(assoc, req->src, 0, assoclen, 0);
-	}
-
-	kernel_fpu_begin();
-	if (static_branch_likely(&gcm_use_avx2) && do_avx2)
-		aesni_gcm_init_avx_gen4(aes_ctx, data, iv, hash_subkey, assoc,
-					assoclen);
-	else if (static_branch_likely(&gcm_use_avx) && do_avx)
-		aesni_gcm_init_avx_gen2(aes_ctx, data, iv, hash_subkey, assoc,
-					assoclen);
-	else
-		aesni_gcm_init(aes_ctx, data, iv, hash_subkey, assoc, assoclen);
-	kernel_fpu_end();
-
-	if (!assocmem)
-		scatterwalk_unmap(assoc);
-	else
-		kfree(assocmem);
-
-	err = enc ? skcipher_walk_aead_encrypt(&walk, req, false)
-		  : skcipher_walk_aead_decrypt(&walk, req, false);
-
-	while (walk.nbytes > 0) {
-		kernel_fpu_begin();
-		if (static_branch_likely(&gcm_use_avx2) && do_avx2) {
-			if (enc)
-				aesni_gcm_enc_update_avx_gen4(aes_ctx, data,
-							      walk.dst.virt.addr,
-							      walk.src.virt.addr,
-							      walk.nbytes);
-			else
-				aesni_gcm_dec_update_avx_gen4(aes_ctx, data,
-							      walk.dst.virt.addr,
-							      walk.src.virt.addr,
-							      walk.nbytes);
-		} else if (static_branch_likely(&gcm_use_avx) && do_avx) {
-			if (enc)
-				aesni_gcm_enc_update_avx_gen2(aes_ctx, data,
-							      walk.dst.virt.addr,
-							      walk.src.virt.addr,
-							      walk.nbytes);
-			else
-				aesni_gcm_dec_update_avx_gen2(aes_ctx, data,
-							      walk.dst.virt.addr,
-							      walk.src.virt.addr,
-							      walk.nbytes);
-		} else if (enc) {
-			aesni_gcm_enc_update(aes_ctx, data, walk.dst.virt.addr,
-					     walk.src.virt.addr, walk.nbytes);
-		} else {
-			aesni_gcm_dec_update(aes_ctx, data, walk.dst.virt.addr,
-					     walk.src.virt.addr, walk.nbytes);
-		}
-		kernel_fpu_end();
-
-		err = skcipher_walk_done(&walk, 0);
-	}
-
-	if (err)
-		return err;
-
-	kernel_fpu_begin();
-	if (static_branch_likely(&gcm_use_avx2) && do_avx2)
-		aesni_gcm_finalize_avx_gen4(aes_ctx, data, auth_tag,
-					    auth_tag_len);
-	else if (static_branch_likely(&gcm_use_avx) && do_avx)
-		aesni_gcm_finalize_avx_gen2(aes_ctx, data, auth_tag,
-					    auth_tag_len);
-	else
-		aesni_gcm_finalize(aes_ctx, data, auth_tag, auth_tag_len);
-	kernel_fpu_end();
-
-	return 0;
-}
-
-static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
-			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
-{
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
-	u8 auth_tag[16];
-	int err;
-
-	err = gcmaes_crypt_by_sg(true, req, assoclen, hash_subkey, iv, aes_ctx,
-				 auth_tag, auth_tag_len);
-	if (err)
-		return err;
-
-	scatterwalk_map_and_copy(auth_tag, req->dst,
-				 req->assoclen + req->cryptlen,
-				 auth_tag_len, 1);
-	return 0;
-}
-
-static int gcmaes_decrypt(struct aead_request *req, unsigned int assoclen,
-			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
-{
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
-	u8 auth_tag_msg[16];
-	u8 auth_tag[16];
-	int err;
-
-	err = gcmaes_crypt_by_sg(false, req, assoclen, hash_subkey, iv, aes_ctx,
-				 auth_tag, auth_tag_len);
-	if (err)
-		return err;
-
-	/* Copy out original auth_tag */
-	scatterwalk_map_and_copy(auth_tag_msg, req->src,
-				 req->assoclen + req->cryptlen - auth_tag_len,
-				 auth_tag_len, 0);
-
-	/* Compare generated tag with passed in tag. */
-	if (crypto_memneq(auth_tag_msg, auth_tag, auth_tag_len)) {
-		memzero_explicit(auth_tag, sizeof(auth_tag));
-		return -EBADMSG;
-	}
-	return 0;
-}
-
-static int helper_rfc4106_encrypt(struct aead_request *req)
-{
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct aesni_rfc4106_gcm_ctx *ctx = aesni_rfc4106_gcm_ctx_get(tfm);
-	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
-	unsigned int i;
-	__be32 counter = cpu_to_be32(1);
-
-	/* Assuming we are supporting rfc4106 64-bit extended */
-	/* sequence numbers We need to have the AAD length equal */
-	/* to 16 or 20 bytes */
-	if (unlikely(req->assoclen != 16 && req->assoclen != 20))
-		return -EINVAL;
-
-	/* IV below built */
-	for (i = 0; i < 4; i++)
-		*(iv+i) = ctx->nonce[i];
-	for (i = 0; i < 8; i++)
-		*(iv+4+i) = req->iv[i];
-	*((__be32 *)(iv+12)) = counter;
-
-	return gcmaes_encrypt(req, req->assoclen - 8, ctx->hash_subkey, iv,
-			      aes_ctx);
-}
-
-static int helper_rfc4106_decrypt(struct aead_request *req)
-{
-	__be32 counter = cpu_to_be32(1);
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct aesni_rfc4106_gcm_ctx *ctx = aesni_rfc4106_gcm_ctx_get(tfm);
-	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
-	unsigned int i;
-
-	if (unlikely(req->assoclen != 16 && req->assoclen != 20))
-		return -EINVAL;
-
-	/* Assuming we are supporting rfc4106 64-bit extended */
-	/* sequence numbers We need to have the AAD length */
-	/* equal to 16 or 20 bytes */
-
-	/* IV below built */
-	for (i = 0; i < 4; i++)
-		*(iv+i) = ctx->nonce[i];
-	for (i = 0; i < 8; i++)
-		*(iv+4+i) = req->iv[i];
-	*((__be32 *)(iv+12)) = counter;
-
-	return gcmaes_decrypt(req, req->assoclen - 8, ctx->hash_subkey, iv,
-			      aes_ctx);
-}
 #endif
 
 static int xts_setkey_aesni(struct crypto_skcipher *tfm, const u8 *key,
 			    unsigned int keylen)
 {
@@ -1214,20 +829,55 @@ static struct simd_skcipher_alg *aes_xts_simdalg_##suffix
 DEFINE_XTS_ALG(aesni_avx, "xts-aes-aesni-avx", 500);
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
 DEFINE_XTS_ALG(vaes_avx2, "xts-aes-vaes-avx2", 600);
 DEFINE_XTS_ALG(vaes_avx10_256, "xts-aes-vaes-avx10_256", 700);
 DEFINE_XTS_ALG(vaes_avx10_512, "xts-aes-vaes-avx10_512", 800);
+#endif
 
 /* The common part of the x86_64 AES-GCM key struct */
 struct aes_gcm_key {
 	/* Expanded AES key and the AES key length in bytes */
 	struct crypto_aes_ctx aes_key;
 
 	/* RFC4106 nonce (used only by the rfc4106 algorithms) */
 	u32 rfc4106_nonce;
 };
 
+/* Key struct used by the AES-NI implementations of AES-GCM */
+struct aes_gcm_key_aesni {
+	/*
+	 * Common part of the key.  The assembly code requires 16-byte alignment
+	 * for the round keys; we get this by them being located at the start of
+	 * the struct and the whole struct being 16-byte aligned.
+	 */
+	struct aes_gcm_key base;
+
+	/*
+	 * Powers of the hash key H^8 through H^1.  These are 128-bit values.
+	 * They all have an extra factor of x^-1 and are byte-reversed.  16-byte
+	 * alignment is required by the assembly code.
+	 */
+	u64 h_powers[8][2] __aligned(16);
+
+	/*
+	 * h_powers_xored[i] contains the two 64-bit halves of h_powers[i] XOR'd
+	 * together.  It's used for Karatsuba multiplication.  16-byte alignment
+	 * is required by the assembly code.
+	 */
+	u64 h_powers_xored[8] __aligned(16);
+
+	/*
+	 * H^1 times x^64 (and also the usual extra factor of x^-1).  16-byte
+	 * alignment is required by the assembly code.
+	 */
+	u64 h_times_x64[2] __aligned(16);
+};
+#define AES_GCM_KEY_AESNI(key)	\
+	container_of((key), struct aes_gcm_key_aesni, base)
+#define AES_GCM_KEY_AESNI_SIZE	\
+	(sizeof(struct aes_gcm_key_aesni) + (15 & ~(CRYPTO_MINALIGN - 1)))
+
 /* Key struct used by the VAES + AVX10 implementations of AES-GCM */
 struct aes_gcm_key_avx10 {
 	/*
 	 * Common part of the key.  The assembly code prefers 16-byte alignment
 	 * for the round keys; we get this by them being located at the start of
@@ -1259,18 +909,36 @@ struct aes_gcm_key_avx10 {
  * functions are selected using flags instead of function pointers to avoid
  * indirect calls (which are very expensive on x86) regardless of inlining.
  */
 #define FLAG_RFC4106	BIT(0)
 #define FLAG_ENC	BIT(1)
-#define FLAG_AVX10_512	BIT(2)
+#define FLAG_AVX	BIT(2)
+#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+#  define FLAG_AVX10_256	BIT(3)
+#  define FLAG_AVX10_512	BIT(4)
+#else
+   /*
+    * This should cause all calls to the AVX10 assembly functions to be
+    * optimized out, avoiding the need to ifdef each call individually.
+    */
+#  define FLAG_AVX10_256	0
+#  define FLAG_AVX10_512	0
+#endif
 
 static inline struct aes_gcm_key *
 aes_gcm_key_get(struct crypto_aead *tfm, int flags)
 {
-	return PTR_ALIGN(crypto_aead_ctx(tfm), 64);
+	if (flags & (FLAG_AVX10_256 | FLAG_AVX10_512))
+		return PTR_ALIGN(crypto_aead_ctx(tfm), 64);
+	else
+		return PTR_ALIGN(crypto_aead_ctx(tfm), 16);
 }
 
+asmlinkage void
+aes_gcm_precompute_aesni(struct aes_gcm_key_aesni *key);
+asmlinkage void
+aes_gcm_precompute_aesni_avx(struct aes_gcm_key_aesni *key);
 asmlinkage void
 aes_gcm_precompute_vaes_avx10_256(struct aes_gcm_key_avx10 *key);
 asmlinkage void
 aes_gcm_precompute_vaes_avx10_512(struct aes_gcm_key_avx10 *key);
 
@@ -1281,38 +949,73 @@ static void aes_gcm_precompute(struct aes_gcm_key *key, int flags)
 	 * implementations use the same key format.  Therefore, a single
 	 * function using 256-bit vectors would suffice here.  However, it's
 	 * straightforward to provide a 512-bit one because of how the assembly
 	 * code is structured, and it works nicely because the total size of the
 	 * key powers is a multiple of 512 bits.  So we take advantage of that.
+	 *
+	 * A similar situation applies to the AES-NI implementations.
 	 */
 	if (flags & FLAG_AVX10_512)
 		aes_gcm_precompute_vaes_avx10_512(AES_GCM_KEY_AVX10(key));
-	else
+	else if (flags & FLAG_AVX10_256)
 		aes_gcm_precompute_vaes_avx10_256(AES_GCM_KEY_AVX10(key));
+	else if (flags & FLAG_AVX)
+		aes_gcm_precompute_aesni_avx(AES_GCM_KEY_AESNI(key));
+	else
+		aes_gcm_precompute_aesni(AES_GCM_KEY_AESNI(key));
 }
 
+asmlinkage void
+aes_gcm_aad_update_aesni(const struct aes_gcm_key_aesni *key,
+			 u8 ghash_acc[16], const u8 *aad, int aadlen);
+asmlinkage void
+aes_gcm_aad_update_aesni_avx(const struct aes_gcm_key_aesni *key,
+			     u8 ghash_acc[16], const u8 *aad, int aadlen);
 asmlinkage void
 aes_gcm_aad_update_vaes_avx10(const struct aes_gcm_key_avx10 *key,
 			      u8 ghash_acc[16], const u8 *aad, int aadlen);
 
 static void aes_gcm_aad_update(const struct aes_gcm_key *key, u8 ghash_acc[16],
 			       const u8 *aad, int aadlen, int flags)
 {
-	aes_gcm_aad_update_vaes_avx10(AES_GCM_KEY_AVX10(key), ghash_acc,
-				      aad, aadlen);
+	if (flags & (FLAG_AVX10_256 | FLAG_AVX10_512))
+		aes_gcm_aad_update_vaes_avx10(AES_GCM_KEY_AVX10(key), ghash_acc,
+					      aad, aadlen);
+	else if (flags & FLAG_AVX)
+		aes_gcm_aad_update_aesni_avx(AES_GCM_KEY_AESNI(key), ghash_acc,
+					     aad, aadlen);
+	else
+		aes_gcm_aad_update_aesni(AES_GCM_KEY_AESNI(key), ghash_acc,
+					 aad, aadlen);
 }
 
+asmlinkage void
+aes_gcm_enc_update_aesni(const struct aes_gcm_key_aesni *key,
+			 const u32 le_ctr[4], u8 ghash_acc[16],
+			 const u8 *src, u8 *dst, int datalen);
+asmlinkage void
+aes_gcm_enc_update_aesni_avx(const struct aes_gcm_key_aesni *key,
+			     const u32 le_ctr[4], u8 ghash_acc[16],
+			     const u8 *src, u8 *dst, int datalen);
 asmlinkage void
 aes_gcm_enc_update_vaes_avx10_256(const struct aes_gcm_key_avx10 *key,
 				  const u32 le_ctr[4], u8 ghash_acc[16],
 				  const u8 *src, u8 *dst, int datalen);
 asmlinkage void
 aes_gcm_enc_update_vaes_avx10_512(const struct aes_gcm_key_avx10 *key,
 				  const u32 le_ctr[4], u8 ghash_acc[16],
 				  const u8 *src, u8 *dst, int datalen);
 
 asmlinkage void
+aes_gcm_dec_update_aesni(const struct aes_gcm_key_aesni *key,
+			 const u32 le_ctr[4], u8 ghash_acc[16],
+			 const u8 *src, u8 *dst, int datalen);
+asmlinkage void
+aes_gcm_dec_update_aesni_avx(const struct aes_gcm_key_aesni *key,
+			     const u32 le_ctr[4], u8 ghash_acc[16],
+			     const u8 *src, u8 *dst, int datalen);
+asmlinkage void
 aes_gcm_dec_update_vaes_avx10_256(const struct aes_gcm_key_avx10 *key,
 				  const u32 le_ctr[4], u8 ghash_acc[16],
 				  const u8 *src, u8 *dst, int datalen);
 asmlinkage void
 aes_gcm_dec_update_vaes_avx10_512(const struct aes_gcm_key_avx10 *key,
@@ -1328,26 +1031,49 @@ aes_gcm_update(const struct aes_gcm_key *key,
 	if (flags & FLAG_ENC) {
 		if (flags & FLAG_AVX10_512)
 			aes_gcm_enc_update_vaes_avx10_512(AES_GCM_KEY_AVX10(key),
 							  le_ctr, ghash_acc,
 							  src, dst, datalen);
-		else
+		else if (flags & FLAG_AVX10_256)
 			aes_gcm_enc_update_vaes_avx10_256(AES_GCM_KEY_AVX10(key),
 							  le_ctr, ghash_acc,
 							  src, dst, datalen);
+		else if (flags & FLAG_AVX)
+			aes_gcm_enc_update_aesni_avx(AES_GCM_KEY_AESNI(key),
+						     le_ctr, ghash_acc,
+						     src, dst, datalen);
+		else
+			aes_gcm_enc_update_aesni(AES_GCM_KEY_AESNI(key), le_ctr,
+						 ghash_acc, src, dst, datalen);
 	} else {
 		if (flags & FLAG_AVX10_512)
 			aes_gcm_dec_update_vaes_avx10_512(AES_GCM_KEY_AVX10(key),
 							  le_ctr, ghash_acc,
 							  src, dst, datalen);
-		else
+		else if (flags & FLAG_AVX10_256)
 			aes_gcm_dec_update_vaes_avx10_256(AES_GCM_KEY_AVX10(key),
 							  le_ctr, ghash_acc,
 							  src, dst, datalen);
+		else if (flags & FLAG_AVX)
+			aes_gcm_dec_update_aesni_avx(AES_GCM_KEY_AESNI(key),
+						     le_ctr, ghash_acc,
+						     src, dst, datalen);
+		else
+			aes_gcm_dec_update_aesni(AES_GCM_KEY_AESNI(key),
+						 le_ctr, ghash_acc,
+						 src, dst, datalen);
 	}
 }
 
+asmlinkage void
+aes_gcm_enc_final_aesni(const struct aes_gcm_key_aesni *key,
+			const u32 le_ctr[4], u8 ghash_acc[16],
+			u64 total_aadlen, u64 total_datalen);
+asmlinkage void
+aes_gcm_enc_final_aesni_avx(const struct aes_gcm_key_aesni *key,
+			    const u32 le_ctr[4], u8 ghash_acc[16],
+			    u64 total_aadlen, u64 total_datalen);
 asmlinkage void
 aes_gcm_enc_final_vaes_avx10(const struct aes_gcm_key_avx10 *key,
 			     const u32 le_ctr[4], u8 ghash_acc[16],
 			     u64 total_aadlen, u64 total_datalen);
 
@@ -1355,15 +1081,34 @@ aes_gcm_enc_final_vaes_avx10(const struct aes_gcm_key_avx10 *key,
 static __always_inline void
 aes_gcm_enc_final(const struct aes_gcm_key *key,
 		  const u32 le_ctr[4], u8 ghash_acc[16],
 		  u64 total_aadlen, u64 total_datalen, int flags)
 {
-	aes_gcm_enc_final_vaes_avx10(AES_GCM_KEY_AVX10(key),
-				     le_ctr, ghash_acc,
-				     total_aadlen, total_datalen);
+	if (flags & (FLAG_AVX10_256 | FLAG_AVX10_512))
+		aes_gcm_enc_final_vaes_avx10(AES_GCM_KEY_AVX10(key),
+					     le_ctr, ghash_acc,
+					     total_aadlen, total_datalen);
+	else if (flags & FLAG_AVX)
+		aes_gcm_enc_final_aesni_avx(AES_GCM_KEY_AESNI(key),
+					    le_ctr, ghash_acc,
+					    total_aadlen, total_datalen);
+	else
+		aes_gcm_enc_final_aesni(AES_GCM_KEY_AESNI(key),
+					le_ctr, ghash_acc,
+					total_aadlen, total_datalen);
 }
 
+asmlinkage bool __must_check
+aes_gcm_dec_final_aesni(const struct aes_gcm_key_aesni *key,
+			const u32 le_ctr[4], const u8 ghash_acc[16],
+			u64 total_aadlen, u64 total_datalen,
+			const u8 tag[16], int taglen);
+asmlinkage bool __must_check
+aes_gcm_dec_final_aesni_avx(const struct aes_gcm_key_aesni *key,
+			    const u32 le_ctr[4], const u8 ghash_acc[16],
+			    u64 total_aadlen, u64 total_datalen,
+			    const u8 tag[16], int taglen);
 asmlinkage bool __must_check
 aes_gcm_dec_final_vaes_avx10(const struct aes_gcm_key_avx10 *key,
 			     const u32 le_ctr[4], const u8 ghash_acc[16],
 			     u64 total_aadlen, u64 total_datalen,
 			     const u8 tag[16], int taglen);
@@ -1372,14 +1117,63 @@ aes_gcm_dec_final_vaes_avx10(const struct aes_gcm_key_avx10 *key,
 static __always_inline bool __must_check
 aes_gcm_dec_final(const struct aes_gcm_key *key, const u32 le_ctr[4],
 		  u8 ghash_acc[16], u64 total_aadlen, u64 total_datalen,
 		  u8 tag[16], int taglen, int flags)
 {
-	return aes_gcm_dec_final_vaes_avx10(AES_GCM_KEY_AVX10(key),
-					    le_ctr, ghash_acc,
-					    total_aadlen, total_datalen,
-					    tag, taglen);
+	if (flags & (FLAG_AVX10_256 | FLAG_AVX10_512))
+		return aes_gcm_dec_final_vaes_avx10(AES_GCM_KEY_AVX10(key),
+						    le_ctr, ghash_acc,
+						    total_aadlen, total_datalen,
+						    tag, taglen);
+	else if (flags & FLAG_AVX)
+		return aes_gcm_dec_final_aesni_avx(AES_GCM_KEY_AESNI(key),
+						   le_ctr, ghash_acc,
+						   total_aadlen, total_datalen,
+						   tag, taglen);
+	else
+		return aes_gcm_dec_final_aesni(AES_GCM_KEY_AESNI(key),
+					       le_ctr, ghash_acc,
+					       total_aadlen, total_datalen,
+					       tag, taglen);
+}
+
+/*
+ * This is the Integrity Check Value (aka the authentication tag) length and can
+ * be 8, 12 or 16 bytes long.
+ */
+static int common_rfc4106_set_authsize(struct crypto_aead *aead,
+				       unsigned int authsize)
+{
+	switch (authsize) {
+	case 8:
+	case 12:
+	case 16:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int generic_gcmaes_set_authsize(struct crypto_aead *tfm,
+				       unsigned int authsize)
+{
+	switch (authsize) {
+	case 4:
+	case 8:
+	case 12:
+	case 13:
+	case 14:
+	case 15:
+	case 16:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 /*
  * This is the setkey function for the x86_64 implementations of AES-GCM.  It
  * saves the RFC4106 nonce if applicable, expands the AES key, and precomputes
@@ -1405,10 +1199,15 @@ static int gcm_setkey(struct crypto_aead *tfm, const u8 *raw_key,
 		keylen -= 4;
 		key->rfc4106_nonce = get_unaligned_be32(raw_key + keylen);
 	}
 
 	/* The assembly code assumes the following offsets. */
+	BUILD_BUG_ON(offsetof(struct aes_gcm_key_aesni, base.aes_key.key_enc) != 0);
+	BUILD_BUG_ON(offsetof(struct aes_gcm_key_aesni, base.aes_key.key_length) != 480);
+	BUILD_BUG_ON(offsetof(struct aes_gcm_key_aesni, h_powers) != 496);
+	BUILD_BUG_ON(offsetof(struct aes_gcm_key_aesni, h_powers_xored) != 624);
+	BUILD_BUG_ON(offsetof(struct aes_gcm_key_aesni, h_times_x64) != 688);
 	BUILD_BUG_ON(offsetof(struct aes_gcm_key_avx10, base.aes_key.key_enc) != 0);
 	BUILD_BUG_ON(offsetof(struct aes_gcm_key_avx10, base.aes_key.key_length) != 480);
 	BUILD_BUG_ON(offsetof(struct aes_gcm_key_avx10, h_powers) != 512);
 	BUILD_BUG_ON(offsetof(struct aes_gcm_key_avx10, padding) != 768);
 
@@ -1422,11 +1221,13 @@ static int gcm_setkey(struct crypto_aead *tfm, const u8 *raw_key,
 		kernel_fpu_end();
 	} else {
 		static const u8 x_to_the_minus1[16] __aligned(__alignof__(be128)) = {
 			[0] = 0xc2, [15] = 1
 		};
-		struct aes_gcm_key_avx10 *k = AES_GCM_KEY_AVX10(key);
+		static const u8 x_to_the_63[16] __aligned(__alignof__(be128)) = {
+			[7] = 1,
+		};
 		be128 h1 = {};
 		be128 h;
 		int i;
 
 		err = aes_expandkey(&key->aes_key, raw_key, keylen);
@@ -1439,16 +1240,33 @@ static int gcm_setkey(struct crypto_aead *tfm, const u8 *raw_key,
 		/* Compute H^1 * x^-1 */
 		h = h1;
 		gf128mul_lle(&h, (const be128 *)x_to_the_minus1);
 
 		/* Compute the needed key powers */
-		for (i = ARRAY_SIZE(k->h_powers) - 1; i >= 0; i--) {
-			k->h_powers[i][0] = be64_to_cpu(h.b);
-			k->h_powers[i][1] = be64_to_cpu(h.a);
-			gf128mul_lle(&h, &h1);
+		if (flags & (FLAG_AVX10_256 | FLAG_AVX10_512)) {
+			struct aes_gcm_key_avx10 *k = AES_GCM_KEY_AVX10(key);
+
+			for (i = ARRAY_SIZE(k->h_powers) - 1; i >= 0; i--) {
+				k->h_powers[i][0] = be64_to_cpu(h.b);
+				k->h_powers[i][1] = be64_to_cpu(h.a);
+				gf128mul_lle(&h, &h1);
+			}
+			memset(k->padding, 0, sizeof(k->padding));
+		} else {
+			struct aes_gcm_key_aesni *k = AES_GCM_KEY_AESNI(key);
+
+			for (i = ARRAY_SIZE(k->h_powers) - 1; i >= 0; i--) {
+				k->h_powers[i][0] = be64_to_cpu(h.b);
+				k->h_powers[i][1] = be64_to_cpu(h.a);
+				k->h_powers_xored[i] = k->h_powers[i][0] ^
+						       k->h_powers[i][1];
+				gf128mul_lle(&h, &h1);
+			}
+			gf128mul_lle(&h1, (const be128 *)x_to_the_63);
+			k->h_times_x64[0] = be64_to_cpu(h1.b);
+			k->h_times_x64[1] = be64_to_cpu(h1.a);
 		}
-		memset(k->padding, 0, sizeof(k->padding));
 	}
 	return 0;
 }
 
 /*
@@ -1628,11 +1446,11 @@ gcm_crypt(struct aead_request *req, int flags)
 
 #define DEFINE_GCM_ALGS(suffix, flags, generic_driver_name, rfc_driver_name,   \
 			ctxsize, priority)				       \
 									       \
 static int gcm_setkey_##suffix(struct crypto_aead *tfm, const u8 *raw_key,     \
-			    unsigned int keylen)			       \
+			       unsigned int keylen)			       \
 {									       \
 	return gcm_setkey(tfm, raw_key, keylen, (flags));		       \
 }									       \
 									       \
 static int gcm_encrypt_##suffix(struct aead_request *req)		       \
@@ -1644,11 +1462,11 @@ static int gcm_decrypt_##suffix(struct aead_request *req)		       \
 {									       \
 	return gcm_crypt(req, (flags));					       \
 }									       \
 									       \
 static int rfc4106_setkey_##suffix(struct crypto_aead *tfm, const u8 *raw_key, \
-				unsigned int keylen)			       \
+				   unsigned int keylen)			       \
 {									       \
 	return gcm_setkey(tfm, raw_key, keylen, (flags) | FLAG_RFC4106);       \
 }									       \
 									       \
 static int rfc4106_encrypt_##suffix(struct aead_request *req)		       \
@@ -1697,12 +1515,23 @@ static struct aead_alg aes_gcm_algs_##suffix[] = { {			       \
 	},								       \
 } };									       \
 									       \
 static struct simd_aead_alg *aes_gcm_simdalgs_##suffix[2]		       \
 
+/* aes_gcm_algs_aesni */
+DEFINE_GCM_ALGS(aesni, /* no flags */ 0,
+		"generic-gcm-aesni", "rfc4106-gcm-aesni",
+		AES_GCM_KEY_AESNI_SIZE, 400);
+
+/* aes_gcm_algs_aesni_avx */
+DEFINE_GCM_ALGS(aesni_avx, FLAG_AVX,
+		"generic-gcm-aesni-avx", "rfc4106-gcm-aesni-avx",
+		AES_GCM_KEY_AESNI_SIZE, 500);
+
+#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
 /* aes_gcm_algs_vaes_avx10_256 */
-DEFINE_GCM_ALGS(vaes_avx10_256, 0,
+DEFINE_GCM_ALGS(vaes_avx10_256, FLAG_AVX10_256,
 		"generic-gcm-vaes-avx10_256", "rfc4106-gcm-vaes-avx10_256",
 		AES_GCM_KEY_AVX10_SIZE, 700);
 
 /* aes_gcm_algs_vaes_avx10_512 */
 DEFINE_GCM_ALGS(vaes_avx10_512, FLAG_AVX10_512,
@@ -1738,10 +1567,15 @@ static int __init register_avx_algs(void)
 		return 0;
 	err = simd_register_skciphers_compat(&aes_xts_alg_aesni_avx, 1,
 					     &aes_xts_simdalg_aesni_avx);
 	if (err)
 		return err;
+	err = simd_register_aeads_compat(aes_gcm_algs_aesni_avx,
+					 ARRAY_SIZE(aes_gcm_algs_aesni_avx),
+					 aes_gcm_simdalgs_aesni_avx);
+	if (err)
+		return err;
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
 	if (!boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_VAES) ||
 	    !boot_cpu_has(X86_FEATURE_VPCLMULQDQ) ||
 	    !boot_cpu_has(X86_FEATURE_PCLMULQDQ) ||
@@ -1793,10 +1627,14 @@ static int __init register_avx_algs(void)
 static void unregister_avx_algs(void)
 {
 	if (aes_xts_simdalg_aesni_avx)
 		simd_unregister_skciphers(&aes_xts_alg_aesni_avx, 1,
 					  &aes_xts_simdalg_aesni_avx);
+	if (aes_gcm_simdalgs_aesni_avx[0])
+		simd_unregister_aeads(aes_gcm_algs_aesni_avx,
+				      ARRAY_SIZE(aes_gcm_algs_aesni_avx),
+				      aes_gcm_simdalgs_aesni_avx);
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
 	if (aes_xts_simdalg_vaes_avx2)
 		simd_unregister_skciphers(&aes_xts_alg_vaes_avx2, 1,
 					  &aes_xts_simdalg_vaes_avx2);
 	if (aes_xts_simdalg_vaes_avx10_256)
@@ -1814,104 +1652,23 @@ static void unregister_avx_algs(void)
 				      ARRAY_SIZE(aes_gcm_algs_vaes_avx10_512),
 				      aes_gcm_simdalgs_vaes_avx10_512);
 #endif
 }
 #else /* CONFIG_X86_64 */
+static struct aead_alg aes_gcm_algs_aesni[0];
+static struct simd_aead_alg *aes_gcm_simdalgs_aesni[0];
+
 static int __init register_avx_algs(void)
 {
 	return 0;
 }
 
 static void unregister_avx_algs(void)
 {
 }
 #endif /* !CONFIG_X86_64 */
 
-#ifdef CONFIG_X86_64
-static int generic_gcmaes_set_key(struct crypto_aead *aead, const u8 *key,
-				  unsigned int key_len)
-{
-	struct generic_gcmaes_ctx *ctx = generic_gcmaes_ctx_get(aead);
-
-	return aes_set_key_common(&ctx->aes_key_expanded, key, key_len) ?:
-	       aes_gcm_derive_hash_subkey(&ctx->aes_key_expanded,
-					  ctx->hash_subkey);
-}
-
-static int generic_gcmaes_encrypt(struct aead_request *req)
-{
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct generic_gcmaes_ctx *ctx = generic_gcmaes_ctx_get(tfm);
-	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
-	__be32 counter = cpu_to_be32(1);
-
-	memcpy(iv, req->iv, 12);
-	*((__be32 *)(iv+12)) = counter;
-
-	return gcmaes_encrypt(req, req->assoclen, ctx->hash_subkey, iv,
-			      aes_ctx);
-}
-
-static int generic_gcmaes_decrypt(struct aead_request *req)
-{
-	__be32 counter = cpu_to_be32(1);
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct generic_gcmaes_ctx *ctx = generic_gcmaes_ctx_get(tfm);
-	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
-
-	memcpy(iv, req->iv, 12);
-	*((__be32 *)(iv+12)) = counter;
-
-	return gcmaes_decrypt(req, req->assoclen, ctx->hash_subkey, iv,
-			      aes_ctx);
-}
-
-static struct aead_alg aesni_aeads[] = { {
-	.setkey			= common_rfc4106_set_key,
-	.setauthsize		= common_rfc4106_set_authsize,
-	.encrypt		= helper_rfc4106_encrypt,
-	.decrypt		= helper_rfc4106_decrypt,
-	.ivsize			= GCM_RFC4106_IV_SIZE,
-	.maxauthsize		= 16,
-	.base = {
-		.cra_name		= "__rfc4106(gcm(aes))",
-		.cra_driver_name	= "__rfc4106-gcm-aesni",
-		.cra_priority		= 400,
-		.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.cra_blocksize		= 1,
-		.cra_ctxsize		= sizeof(struct aesni_rfc4106_gcm_ctx),
-		.cra_alignmask		= 0,
-		.cra_module		= THIS_MODULE,
-	},
-}, {
-	.setkey			= generic_gcmaes_set_key,
-	.setauthsize		= generic_gcmaes_set_authsize,
-	.encrypt		= generic_gcmaes_encrypt,
-	.decrypt		= generic_gcmaes_decrypt,
-	.ivsize			= GCM_AES_IV_SIZE,
-	.maxauthsize		= 16,
-	.base = {
-		.cra_name		= "__gcm(aes)",
-		.cra_driver_name	= "__generic-gcm-aesni",
-		.cra_priority		= 400,
-		.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.cra_blocksize		= 1,
-		.cra_ctxsize		= sizeof(struct generic_gcmaes_ctx),
-		.cra_alignmask		= 0,
-		.cra_module		= THIS_MODULE,
-	},
-} };
-#else
-static struct aead_alg aesni_aeads[0];
-#endif
-
-static struct simd_aead_alg *aesni_simd_aeads[ARRAY_SIZE(aesni_aeads)];
-
 static const struct x86_cpu_id aesni_cpu_id[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_AES, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, aesni_cpu_id);
@@ -1921,21 +1678,10 @@ static int __init aesni_init(void)
 	int err;
 
 	if (!x86_match_cpu(aesni_cpu_id))
 		return -ENODEV;
 #ifdef CONFIG_X86_64
-	if (boot_cpu_has(X86_FEATURE_AVX2)) {
-		pr_info("AVX2 version of gcm_enc/dec engaged.\n");
-		static_branch_enable(&gcm_use_avx);
-		static_branch_enable(&gcm_use_avx2);
-	} else
-	if (boot_cpu_has(X86_FEATURE_AVX)) {
-		pr_info("AVX version of gcm_enc/dec engaged.\n");
-		static_branch_enable(&gcm_use_avx);
-	} else {
-		pr_info("SSE version of gcm_enc/dec engaged.\n");
-	}
 	if (boot_cpu_has(X86_FEATURE_AVX)) {
 		/* optimize performance of ctr mode encryption transform */
 		static_call_update(aesni_ctr_enc_tfm, aesni_ctr_enc_avx_tfm);
 		pr_info("AES CTR mode by8 optimization enabled\n");
 	}
@@ -1949,12 +1695,13 @@ static int __init aesni_init(void)
 					     ARRAY_SIZE(aesni_skciphers),
 					     aesni_simd_skciphers);
 	if (err)
 		goto unregister_cipher;
 
-	err = simd_register_aeads_compat(aesni_aeads, ARRAY_SIZE(aesni_aeads),
-					 aesni_simd_aeads);
+	err = simd_register_aeads_compat(aes_gcm_algs_aesni,
+					 ARRAY_SIZE(aes_gcm_algs_aesni),
+					 aes_gcm_simdalgs_aesni);
 	if (err)
 		goto unregister_skciphers;
 
 #ifdef CONFIG_X86_64
 	if (boot_cpu_has(X86_FEATURE_AVX))
@@ -1975,25 +1722,26 @@ static int __init aesni_init(void)
 #ifdef CONFIG_X86_64
 	if (aesni_simd_xctr)
 		simd_unregister_skciphers(&aesni_xctr, 1, &aesni_simd_xctr);
 unregister_aeads:
 #endif /* CONFIG_X86_64 */
-	simd_unregister_aeads(aesni_aeads, ARRAY_SIZE(aesni_aeads),
-				aesni_simd_aeads);
-
+	simd_unregister_aeads(aes_gcm_algs_aesni,
+			      ARRAY_SIZE(aes_gcm_algs_aesni),
+			      aes_gcm_simdalgs_aesni);
 unregister_skciphers:
 	simd_unregister_skciphers(aesni_skciphers, ARRAY_SIZE(aesni_skciphers),
 				  aesni_simd_skciphers);
 unregister_cipher:
 	crypto_unregister_alg(&aesni_cipher_alg);
 	return err;
 }
 
 static void __exit aesni_exit(void)
 {
-	simd_unregister_aeads(aesni_aeads, ARRAY_SIZE(aesni_aeads),
-			      aesni_simd_aeads);
+	simd_unregister_aeads(aes_gcm_algs_aesni,
+			      ARRAY_SIZE(aes_gcm_algs_aesni),
+			      aes_gcm_simdalgs_aesni);
 	simd_unregister_skciphers(aesni_skciphers, ARRAY_SIZE(aesni_skciphers),
 				  aesni_simd_skciphers);
 	crypto_unregister_alg(&aesni_cipher_alg);
 #ifdef CONFIG_X86_64
 	if (boot_cpu_has(X86_FEATURE_AVX))
-- 
2.45.1


