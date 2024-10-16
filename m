Return-Path: <linux-kernel+bounces-368627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41EA9A1282
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE392863FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141021643D;
	Wed, 16 Oct 2024 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gqus0/cp"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519CB215F4B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106814; cv=none; b=N1vDYRPJzi5nmigm06dQwFGOZ8BDzvEl9DAtQjD3nm/36WxVybuH97Ynmj9YwNJbEqdokGyz0qxwRNrcr7eZnMWnGTZmBChUWpM6Q7f93rhI6YeACDpoBwdYYNWcl+LEfZBhF2S80/cM90iN7r58J91/gD3TmxbsdOvO+i2/7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106814; c=relaxed/simple;
	bh=lU7yWAAiJybdpnowglX57j5xENzlqFKxuNc7Cl9EfYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y6DmG28lVJOr7Mxv+XuUTJODKidfy9cWW7C9MEKcRG1hgO/f6Y/ICcc1H8OAfSvbDhqY579xk1eL9z9reHRqZSRva73nWsqN4NBoB9RzJh17KTuvVhAXfWrChXRCsddeJLTxEZ5iiLoagfWAbNwBkcj6IYgpUr9qPTj+0ILau/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gqus0/cp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so5110237b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729106811; x=1729711611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGIolF66pWve6n1ShGJsOaaV+zUu6iv40Bvj7y+ZUr8=;
        b=Gqus0/cp+aRzjdaQ8hAkHYQpthGRirkbV96BlS1B4PP3tUCYoqPyujUdB8LAKRTnf+
         uDBbeYDdqZNfuRaDsupQaP8VLiNPmm6BlaYvRk7Z/R5b9Y/4UlNnFh/q9TSbK/AMrefu
         KLaQkyEG2dosaj903j3vnznfHYgGOuhbUgJztoSpL3j3bw+MJzTAiDxUNVLCQ82Q9lvP
         s6LbPh/aXnQumrWqov1cGcMzSXhROnJn9285RnZuyN9Ih1YWB0mpGjvEucSqM88xge8F
         C3RFNiPCsNI1annyVZHHIL9wiG+htgs9Qf2GslGHWkU3Ko/aQ/vqZTOMz/rooW71jDHt
         7vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106811; x=1729711611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGIolF66pWve6n1ShGJsOaaV+zUu6iv40Bvj7y+ZUr8=;
        b=TpnwFQ8nDI6PMsgLVPwcz6baVhBgU97AzArBhUp1x4T2UhtD62bGRMHz0tlEJqPvmT
         4PPatCcsJRo4BcOF4Zm3+B381LzXyHmA9O5PCVNKqXhry6FcqOlCEHHfmhPIQVWV+5K3
         wpNosrcsrC1gcH3W81DE2yD0l6Vy6c1yYaiV6NAbVCqvrO271sjSmcv/t2j6ybZW1upT
         x2qEE17hAWoujD7ncUuciXmKCLQDI+Lra+8WhEGLu/ZC6pFhuKp2NBDDEEYBwB7xjwDY
         AAJwqZiD+zpF2topzt4FLpZW6ER/akODm9BmAKOczBy+nDPwJYno0W20j9OFe6kb/Qp8
         FrMg==
X-Gm-Message-State: AOJu0YxUUpMOlxgmjnABOSIiTOAsC08bTHtPjvgih9Vv3pyaL1SQLwL4
	rTYrctDrhfW9VWX27EXZs9IPlgqDaXrETZyjNoI376RmrU0FIEKBrTba4hlcmLNjijkXcw==
X-Google-Smtp-Source: AGHT+IHNzV1aKYVlJS31kxbfRDuLz+NVRfaVfoKx2WEqwPu3Rg1q9JpO+o+FSg6zKZvO/VYq9BGa9rJR
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:9a8b:b0:6db:7b3d:b414 with SMTP id
 00721157ae682-6e3d3bdfabfmr1482747b3.0.1729106811250; Wed, 16 Oct 2024
 12:26:51 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:26:43 +0200
In-Reply-To: <20241016192640.406255-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016192640.406255-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=12481; i=ardb@kernel.org;
 h=from:subject; bh=oxJANoEIRp6mRDmNidGH6IClKcl2m0FZDw/V7/xvh+c=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV1AuPj2EcYezciKtzdzT7IcutkX/3RB796vnU8fJybMV
 IkUm+7VUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYSt4bhn76a2l7v/P3FK1bd
 msd9YJdh+l+veVF7DHO5M6akp0SnRjEy9LFFnkj0qFxaXXHEo5G7i/nCQrsf3wsueapd7t3sXfm SDQA=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241016192640.406255-6-ardb+git@google.com>
Subject: [PATCH v2 2/2] arm64/crc32: Implement 4-way interleave using PMULL
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, will@kernel.org, catalin.marinas@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that kernel mode NEON no longer disables preemption, using FP/SIMD
in library code which is not obviously part of the crypto subsystem is
no longer problematic, as it will no longer incur unexpected latencies.

So accelerate the CRC-32 library code on arm64 to use a 4-way
interleave, using PMULL instructions to implement the folding.

On Apple M2, this results in a speedup of 2 - 2.8x when using input
sizes of 1k - 8k. For smaller sizes, the overhead of preserving and
restoring the FP/SIMD register file may not be worth it, so 1k is used
as a threshold for choosing this code path.

The coefficient tables were generated using code provided by Eric. [0]

[0] https://github.com/ebiggers/libdeflate/blob/master/scripts/gen_crc32_multipliers.c

Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/lib/Makefile     |   2 +-
 arch/arm64/lib/crc32-4way.S | 242 ++++++++++++++++++++
 arch/arm64/lib/crc32-glue.c |  48 ++++
 3 files changed, 291 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 8e882f479d98..52f3d3e302f7 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -13,7 +13,7 @@ endif
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
-obj-$(CONFIG_CRC32) += crc32.o crc32-glue.o
+obj-$(CONFIG_CRC32) += crc32.o crc32-glue.o crc32-4way.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
diff --git a/arch/arm64/lib/crc32-4way.S b/arch/arm64/lib/crc32-4way.S
new file mode 100644
index 000000000000..08907729d016
--- /dev/null
+++ b/arch/arm64/lib/crc32-4way.S
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2024 Google LLC
+// Author: Ard Biesheuvel <ardb@google.com>
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+	in	.req	x1
+	len	.req	x2
+
+	.macro	nop, reg0, reg1
+	.endm
+
+	/*
+	 * w0: input CRC at entry, output CRC at exit
+	 * x1: pointer to input buffer
+	 * x2: length of input in bytes
+	 */
+	.macro	crc4way, insn, table, rev=nop, rbit=nop
+	lsr	len, len, #6		// len := # of 64-byte blocks
+
+	/* Process up to 64 blocks of 64 bytes at a time */
+.La\@:	mov	x3, #64
+	cmp	len, #64
+	csel	x3, x3, len, hi		// x3 := max(len, 64)
+	sub	len, len, x3
+
+	/* Divide the input into 4 contiguous blocks */
+	add	x4, x3, x3, lsl #1	// x4 :=  3 * x3
+	add	x7, in, x3, lsl #4	// x7 := in + 16 * x3
+	add	x8, in, x3, lsl #5	// x8 := in + 32 * x3
+	add	x9, in, x4, lsl #4	// x9 := in + 16 * x4
+
+	/* Load the folding coefficients from the lookup table */
+	adr_l	x5, \table - 12		// entry 0 omitted
+	add	x5, x5, x4, lsl #2	// x5 += 12 * x3
+	ldp	s0, s1, [x5]
+	ldr	s2, [x5, #8]
+
+	/* Zero init partial CRCs for this iteration */
+	mov	w4, #0
+	mov	w5, #0
+	mov	w6, #0
+	b	.Lc\@
+
+.Lb\@:	\insn	w6, w6, x17
+.Lc\@:	sub	x3, x3, #1
+	ldp	x10, x11, [in], #16
+	ldp	x12, x13, [x7], #16
+	ldp	x14, x15, [x8], #16
+	ldp	x16, x17, [x9], #16
+
+	\rev	x10, x10
+	\rev	x11, x11
+	\rev	x12, x12
+	\rev	x13, x13
+	\rev	x14, x14
+	\rev	x15, x15
+	\rev	x16, x16
+	\rev	x17, x17
+
+	\rbit	x10, x10
+	\rbit	x11, x11
+	\rbit	x12, x12
+	\rbit	x13, x13
+	\rbit	x14, x14
+	\rbit	x15, x15
+	\rbit	x16, x16
+	\rbit	x17, x17
+
+	/* Apply the CRC transform to 4 16-byte blocks in parallel */
+	\insn	w0, w0, x10
+	\insn	w4, w4, x12
+	\insn	w5, w5, x14
+	\insn	w6, w6, x16
+	\insn	w0, w0, x11
+	\insn	w4, w4, x13
+	\insn	w5, w5, x15
+	cbnz	x3, .Lb\@
+
+	/* Combine the 4 partial results into w0 */
+	mov	v3.d[0], x0
+	mov	v4.d[0], x4
+	mov	v5.d[0], x5
+	pmull	v0.1q, v0.1d, v3.1d
+	pmull	v1.1q, v1.1d, v4.1d
+	pmull	v2.1q, v2.1d, v5.1d
+	eor	v0.8b, v0.8b, v1.8b
+	eor	v0.8b, v0.8b, v2.8b
+	mov	x5, v0.d[0]
+	eor	x5, x5, x17
+	\insn	w0, w6, x5
+
+	mov	in, x9
+	cbnz	len, .La\@
+	ret
+	.endm
+
+	.cpu	generic+crc+crypto
+SYM_FUNC_START(crc32c_le_arm64_4way)
+	crc4way	crc32cx, .L0 CPU_BE(, rev)
+SYM_FUNC_END(crc32c_le_arm64_4way)
+
+SYM_FUNC_START(crc32_le_arm64_4way)
+	crc4way	crc32x, .L1 CPU_BE(, rev)
+SYM_FUNC_END(crc32_le_arm64_4way)
+
+SYM_FUNC_START(crc32_be_arm64_4way)
+	crc4way	crc32x, .L1 CPU_LE(, rev), rbit=rbit
+SYM_FUNC_END(crc32_be_arm64_4way)
+
+	.section .rodata, "a", %progbits
+	.align	6
+.L0:	.long	0xddc0152b, 0xba4fc28e, 0x493c7d27
+	.long	0x0715ce53, 0x9e4addf8, 0xba4fc28e
+	.long	0xc96cfdc0, 0x0715ce53, 0xddc0152b
+	.long	0xab7aff2a, 0x0d3b6092, 0x9e4addf8
+	.long	0x299847d5, 0x878a92a7, 0x39d3b296
+	.long	0xb6dd949b, 0xab7aff2a, 0x0715ce53
+	.long	0xa60ce07b, 0x83348832, 0x47db8317
+	.long	0xd270f1a2, 0xb9e02b86, 0x0d3b6092
+	.long	0x65863b64, 0xb6dd949b, 0xc96cfdc0
+	.long	0xb3e32c28, 0xbac2fd7b, 0x878a92a7
+	.long	0xf285651c, 0xce7f39f4, 0xdaece73e
+	.long	0x271d9844, 0xd270f1a2, 0xab7aff2a
+	.long	0x6cb08e5c, 0x2b3cac5d, 0x2162d385
+	.long	0xcec3662e, 0x1b03397f, 0x83348832
+	.long	0x8227bb8a, 0xb3e32c28, 0x299847d5
+	.long	0xd7a4825c, 0xdd7e3b0c, 0xb9e02b86
+	.long	0xf6076544, 0x10746f3c, 0x18b33a4e
+	.long	0x98d8d9cb, 0x271d9844, 0xb6dd949b
+	.long	0x57a3d037, 0x93a5f730, 0x78d9ccb7
+	.long	0x3771e98f, 0x6b749fb2, 0xbac2fd7b
+	.long	0xe0ac139e, 0xcec3662e, 0xa60ce07b
+	.long	0x6f345e45, 0xe6fc4e6a, 0xce7f39f4
+	.long	0xa2b73df1, 0xb0cd4768, 0x61d82e56
+	.long	0x86d8e4d2, 0xd7a4825c, 0xd270f1a2
+	.long	0xa90fd27a, 0x0167d312, 0xc619809d
+	.long	0xca6ef3ac, 0x26f6a60a, 0x2b3cac5d
+	.long	0x4597456a, 0x98d8d9cb, 0x65863b64
+	.long	0xc9c8b782, 0x68bce87a, 0x1b03397f
+	.long	0x62ec6c6d, 0x6956fc3b, 0xebb883bd
+	.long	0x2342001e, 0x3771e98f, 0xb3e32c28
+	.long	0xe8b6368b, 0x2178513a, 0x064f7f26
+	.long	0x9ef68d35, 0x170076fa, 0xdd7e3b0c
+	.long	0x0b0bf8ca, 0x6f345e45, 0xf285651c
+	.long	0x02ee03b2, 0xff0dba97, 0x10746f3c
+	.long	0x135c83fd, 0xf872e54c, 0xc7a68855
+	.long	0x00bcf5f6, 0x86d8e4d2, 0x271d9844
+	.long	0x58ca5f00, 0x5bb8f1bc, 0x8e766a0c
+	.long	0xded288f8, 0xb3af077a, 0x93a5f730
+	.long	0x37170390, 0xca6ef3ac, 0x6cb08e5c
+	.long	0xf48642e9, 0xdd66cbbb, 0x6b749fb2
+	.long	0xb25b29f2, 0xe9e28eb4, 0x1393e203
+	.long	0x45cddf4e, 0xc9c8b782, 0xcec3662e
+	.long	0xdfd94fb2, 0x93e106a4, 0x96c515bb
+	.long	0x021ac5ef, 0xd813b325, 0xe6fc4e6a
+	.long	0x8e1450f7, 0x2342001e, 0x8227bb8a
+	.long	0xe0cdcf86, 0x6d9a4957, 0xb0cd4768
+	.long	0x613eee91, 0xd2c3ed1a, 0x39c7ff35
+	.long	0xbedc6ba1, 0x9ef68d35, 0xd7a4825c
+	.long	0x0cd1526a, 0xf2271e60, 0x0ab3844b
+	.long	0xd6c3a807, 0x2664fd8b, 0x0167d312
+	.long	0x1d31175f, 0x02ee03b2, 0xf6076544
+	.long	0x4be7fd90, 0x363bd6b3, 0x26f6a60a
+	.long	0x6eeed1c9, 0x5fabe670, 0xa741c1bf
+	.long	0xb3a6da94, 0x00bcf5f6, 0x98d8d9cb
+	.long	0x2e7d11a7, 0x17f27698, 0x49c3cc9c
+	.long	0x889774e1, 0xaa7c7ad5, 0x68bce87a
+	.long	0x8a074012, 0xded288f8, 0x57a3d037
+	.long	0xbd0bb25f, 0x6d390dec, 0x6956fc3b
+	.long	0x3be3c09b, 0x6353c1cc, 0x42d98888
+	.long	0x465a4eee, 0xf48642e9, 0x3771e98f
+	.long	0x2e5f3c8c, 0xdd35bc8d, 0xb42ae3d9
+	.long	0xa52f58ec, 0x9a5ede41, 0x2178513a
+	.long	0x47972100, 0x45cddf4e, 0xe0ac139e
+	.long	0x359674f7, 0xa51b6135, 0x170076fa
+
+.L1:	.long	0xaf449247, 0x81256527, 0xccaa009e
+	.long	0x57c54819, 0x1d9513d7, 0x81256527
+	.long	0x3f41287a, 0x57c54819, 0xaf449247
+	.long	0xf5e48c85, 0x910eeec1, 0x1d9513d7
+	.long	0x1f0c2cdd, 0x9026d5b1, 0xae0b5394
+	.long	0x71d54a59, 0xf5e48c85, 0x57c54819
+	.long	0x1c63267b, 0xfe807bbd, 0x0cbec0ed
+	.long	0xd31343ea, 0xe95c1271, 0x910eeec1
+	.long	0xf9d9c7ee, 0x71d54a59, 0x3f41287a
+	.long	0x9ee62949, 0xcec97417, 0x9026d5b1
+	.long	0xa55d1514, 0xf183c71b, 0xd1df2327
+	.long	0x21aa2b26, 0xd31343ea, 0xf5e48c85
+	.long	0x9d842b80, 0xeea395c4, 0x3c656ced
+	.long	0xd8110ff1, 0xcd669a40, 0xfe807bbd
+	.long	0x3f9e9356, 0x9ee62949, 0x1f0c2cdd
+	.long	0x1d6708a0, 0x0c30f51d, 0xe95c1271
+	.long	0xef82aa68, 0xdb3935ea, 0xb918a347
+	.long	0xd14bcc9b, 0x21aa2b26, 0x71d54a59
+	.long	0x99cce860, 0x356d209f, 0xff6f2fc2
+	.long	0xd8af8e46, 0xc352f6de, 0xcec97417
+	.long	0xf1996890, 0xd8110ff1, 0x1c63267b
+	.long	0x631bc508, 0xe95c7216, 0xf183c71b
+	.long	0x8511c306, 0x8e031a19, 0x9b9bdbd0
+	.long	0xdb3839f3, 0x1d6708a0, 0xd31343ea
+	.long	0x7a92fffb, 0xf7003835, 0x4470ac44
+	.long	0x6ce68f2a, 0x00eba0c8, 0xeea395c4
+	.long	0x4caaa263, 0xd14bcc9b, 0xf9d9c7ee
+	.long	0xb46f7cff, 0x9a1b53c8, 0xcd669a40
+	.long	0x60290934, 0x81b6f443, 0x6d40f445
+	.long	0x8e976a7d, 0xd8af8e46, 0x9ee62949
+	.long	0xdcf5088a, 0x9dbdc100, 0x145575d5
+	.long	0x1753ab84, 0xbbf2f6d6, 0x0c30f51d
+	.long	0x255b139e, 0x631bc508, 0xa55d1514
+	.long	0xd784eaa8, 0xce26786c, 0xdb3935ea
+	.long	0x6d2c864a, 0x8068c345, 0x2586d334
+	.long	0x02072e24, 0xdb3839f3, 0x21aa2b26
+	.long	0x06689b0a, 0x5efd72f5, 0xe0575528
+	.long	0x1e52f5ea, 0x4117915b, 0x356d209f
+	.long	0x1d3d1db6, 0x6ce68f2a, 0x9d842b80
+	.long	0x3796455c, 0xb8e0e4a8, 0xc352f6de
+	.long	0xdf3a4eb3, 0xc55a2330, 0xb84ffa9c
+	.long	0x28ae0976, 0xb46f7cff, 0xd8110ff1
+	.long	0x9764bc8d, 0xd7e7a22c, 0x712510f0
+	.long	0x13a13e18, 0x3e9a43cd, 0xe95c7216
+	.long	0xb8ee242e, 0x8e976a7d, 0x3f9e9356
+	.long	0x0c540e7b, 0x753c81ff, 0x8e031a19
+	.long	0x9924c781, 0xb9220208, 0x3edcde65
+	.long	0x3954de39, 0x1753ab84, 0x1d6708a0
+	.long	0xf32238b5, 0xbec81497, 0x9e70b943
+	.long	0xbbd2cd2c, 0x0925d861, 0xf7003835
+	.long	0xcc401304, 0xd784eaa8, 0xef82aa68
+	.long	0x4987e684, 0x6044fbb0, 0x00eba0c8
+	.long	0x3aa11427, 0x18fe3b4a, 0x87441142
+	.long	0x297aad60, 0x02072e24, 0xd14bcc9b
+	.long	0xf60c5e51, 0x6ef6f487, 0x5b7fdd0a
+	.long	0x632d78c5, 0x3fc33de4, 0x9a1b53c8
+	.long	0x25b8822a, 0x1e52f5ea, 0x99cce860
+	.long	0xd4fc84bc, 0x1af62fb8, 0x81b6f443
+	.long	0x5690aa32, 0xa91fdefb, 0x688a110e
+	.long	0x1357a093, 0x3796455c, 0xd8af8e46
+	.long	0x798fdd33, 0xaaa18a37, 0x357b9517
+	.long	0xc2815395, 0x54d42691, 0x9dbdc100
+	.long	0x21cfc0f7, 0x28ae0976, 0xf1996890
+	.long	0xa0decef3, 0x7b4aa8b7, 0xbbf2f6d6
diff --git a/arch/arm64/lib/crc32-glue.c b/arch/arm64/lib/crc32-glue.c
index 0b51761d4b75..295ae3e6b997 100644
--- a/arch/arm64/lib/crc32-glue.c
+++ b/arch/arm64/lib/crc32-glue.c
@@ -4,16 +4,40 @@
 #include <linux/linkage.h>
 
 #include <asm/alternative.h>
+#include <asm/cpufeature.h>
+#include <asm/neon.h>
+#include <asm/simd.h>
+
+#include <crypto/internal/simd.h>
+
+// The minimum input length to consider the 4-way interleaved code path
+static const size_t min_len = 1024;
 
 asmlinkage u32 crc32_le_arm64(u32 crc, unsigned char const *p, size_t len);
 asmlinkage u32 crc32c_le_arm64(u32 crc, unsigned char const *p, size_t len);
 asmlinkage u32 crc32_be_arm64(u32 crc, unsigned char const *p, size_t len);
 
+asmlinkage u32 crc32_le_arm64_4way(u32 crc, unsigned char const *p, size_t len);
+asmlinkage u32 crc32c_le_arm64_4way(u32 crc, unsigned char const *p, size_t len);
+asmlinkage u32 crc32_be_arm64_4way(u32 crc, unsigned char const *p, size_t len);
+
 u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
 	if (!alternative_has_cap_likely(ARM64_HAS_CRC32))
 		return crc32_le_base(crc, p, len);
 
+	if (len >= min_len && cpu_have_named_feature(PMULL) && crypto_simd_usable()) {
+		kernel_neon_begin();
+		crc = crc32_le_arm64_4way(crc, p, len);
+		kernel_neon_end();
+
+		p += round_down(len, 64);
+		len %= 64;
+
+		if (!len)
+			return crc;
+	}
+
 	return crc32_le_arm64(crc, p, len);
 }
 
@@ -22,6 +46,18 @@ u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
 	if (!alternative_has_cap_likely(ARM64_HAS_CRC32))
 		return __crc32c_le_base(crc, p, len);
 
+	if (len >= min_len && cpu_have_named_feature(PMULL) && crypto_simd_usable()) {
+		kernel_neon_begin();
+		crc = crc32c_le_arm64_4way(crc, p, len);
+		kernel_neon_end();
+
+		p += round_down(len, 64);
+		len %= 64;
+
+		if (!len)
+			return crc;
+	}
+
 	return crc32c_le_arm64(crc, p, len);
 }
 
@@ -30,5 +66,17 @@ u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
 	if (!alternative_has_cap_likely(ARM64_HAS_CRC32))
 		return crc32_be_base(crc, p, len);
 
+	if (len >= min_len && cpu_have_named_feature(PMULL) && crypto_simd_usable()) {
+		kernel_neon_begin();
+		crc = crc32_be_arm64_4way(crc, p, len);
+		kernel_neon_end();
+
+		p += round_down(len, 64);
+		len %= 64;
+
+		if (!len)
+			return crc;
+	}
+
 	return crc32_be_arm64(crc, p, len);
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


