Return-Path: <linux-kernel+bounces-420438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EEE9D7AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 05:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CA3B2253B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 04:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1390185954;
	Mon, 25 Nov 2024 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnFtx5tz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465F156F5D;
	Mon, 25 Nov 2024 04:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732507970; cv=none; b=l13x/AILC1+/MEFK3Ike5t/W8JlxbcWC+Ak8cJTrHYy1WoDPip522Z6PK75GpjgMCo9AmBUamQzYN3QA+2cL0D3w0QnKhkVkQoTU+RcDv+DUAljOJ/9bkRiK6qNRMLvOaqOlOEljd6cVgbYxy/jn+/mVaMtdqwUrAgjC/4FK7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732507970; c=relaxed/simple;
	bh=Im0exUZQfnAWeYCHy4KFp6kY8DqEkpJ4gHD7VgIxHhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcbgEZfMz1KK4b/sScuhNltsAInyB0/5WI0qpaA3W60q6KyWiwwUCUfPxc4MKOmO52n2oHM4QUNZ5L+YaK8bRhb6YRcVbXB4I61zP9Y49m8TlJC1aOrKStsZKiGQQhHayL8+UG7wnaldEnELfSrJfke+LSStaM2qgvdnRZGSZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnFtx5tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E19C4CEE4;
	Mon, 25 Nov 2024 04:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732507970;
	bh=Im0exUZQfnAWeYCHy4KFp6kY8DqEkpJ4gHD7VgIxHhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RnFtx5tzOnJoFKt8Ii9puP18+iDvpDwwprL0cSNvV6GQIdJOsytF1Vz1mzFjZDKcN
	 zZMyV7oDL6qfSk+I1yNiGycUnLRkAaxSC0rOx3mf6sBT0ylcW21i7vydL62tPZ7r9v
	 22F5Wi+E93hV87ew4cS4qg6Uux8RNuj/Fbl4cdoy5zBNHfrGnQBJRz17h34nvd3n4k
	 uTgwDoctpuEcgwfv8iaR+ycQZKu8UD/I/WSAgJaRmHT4/n7/2IZza8Ui87WKV3e13A
	 +rzpwjoAC6kkSvmAG+v2Vd+n46Q4PUxo4ilyaoyva5NfFNMeu5Kn068Er68mSfDdWb
	 DrCKGmWI6/M1g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6/6] x86/crc32: implement crc32_be using new template
Date: Sun, 24 Nov 2024 20:11:29 -0800
Message-ID: <20241125041129.192999-7-ebiggers@kernel.org>
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

crc32_be was previously unoptimized on x86.  Optimize it using the new
template.  This improves performance by over 25x in some cases.

Benchmark results on AMD Ryzen 9 9950X (Zen 5) using crc_kunit:

	Length     Before        After
	------     ------        -----
	     1     389 MB/s      325 MB/s
	    16    2845 MB/s     2911 MB/s
	    64    3012 MB/s     6513 MB/s
	   127    2567 MB/s     9057 MB/s
	   128    3048 MB/s    11589 MB/s
	   200    3070 MB/s    14042 MB/s
	   256    3067 MB/s    20454 MB/s
	   511    2938 MB/s    26245 MB/s
	   512    3081 MB/s    36926 MB/s
	  1024    3090 MB/s    61914 MB/s
	  3173    3065 MB/s    76201 MB/s
	  4096    3084 MB/s    82547 MB/s
	 16384    3084 MB/s    89333 MB/s

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/lib/crc-pclmul-consts.h | 49 +++++++++++++++++++++++++++++++-
 arch/x86/lib/crc32-glue.c        |  4 +++
 arch/x86/lib/crc32-pclmul.S      |  1 +
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/crc-pclmul-consts.h b/arch/x86/lib/crc-pclmul-consts.h
index c3ca689eae3b8..f8af6e9278c83 100644
--- a/arch/x86/lib/crc-pclmul-consts.h
+++ b/arch/x86/lib/crc-pclmul-consts.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * CRC constants generated by:
  *
- *	./scripts/crc/gen-crc-consts.py x86_pclmul crc16_msb_0x8bb7,crc32_lsb_0xedb88320
+ *	./scripts/crc/gen-crc-consts.py x86_pclmul crc16_msb_0x8bb7,crc32_lsb_0xedb88320,crc32_msb_0x04c11db7
  *
  * Do not edit manually.
  */
 
 /*
@@ -97,5 +97,52 @@ static const struct {
 		0xb4e5b025f7011641,	/* floor(x^95 / G(x)) */
 		0x1db710641,	/* G(x) */
 	},
 	.extract_crc_mask = {0, 0xffffffff},
 };
+
+/*
+ * CRC folding constants generated for most-significant-bit-first CRC-32 using
+ * G(x) = x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 +
+ *        x^5 + x^4 + x^2 + x + 1
+ */
+static const struct {
+	u8 bswap_mask[16];
+	u64 fold_across_2048_bits_consts[2];
+	u64 fold_across_1024_bits_consts[2];
+	u64 fold_across_512_bits_consts[2];
+	u64 fold_across_256_bits_consts[2];
+	u64 fold_across_128_bits_consts[2];
+	u8 shuf_table[48];
+	u64 barrett_reduction_consts[2];
+} crc32_msb_0x04c11db7_consts __cacheline_aligned __maybe_unused = {
+	.bswap_mask = {15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
+	.fold_across_2048_bits_consts = {
+		0x88fe2237,	/* x^(2048+0) mod G(x) */
+		0xcbcf3bcb,	/* x^(2048+64) mod G(x) */
+	},
+	.fold_across_1024_bits_consts = {
+		0x567fddeb,	/* x^(1024+0) mod G(x) */
+		0x10bd4d7c,	/* x^(1024+64) mod G(x) */
+	},
+	.fold_across_512_bits_consts = {
+		0xe6228b11,	/* x^(512+0) mod G(x) */
+		0x8833794c,	/* x^(512+64) mod G(x) */
+	},
+	.fold_across_256_bits_consts = {
+		0x75be46b7,	/* x^(256+0) mod G(x) */
+		0x569700e5,	/* x^(256+64) mod G(x) */
+	},
+	.fold_across_128_bits_consts = {
+		0xe8a45605,	/* x^(128+0) mod G(x) */
+		0xc5b9cd4c,	/* x^(128+64) mod G(x) */
+	},
+	.shuf_table = {
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+		 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+	},
+	.barrett_reduction_consts = {
+		0x04d101df481b4e5a,	/* floor(x^96 / G(x)) - x^64 */
+		0x104c11db7,	/* G(x) */
+	},
+};
diff --git a/arch/x86/lib/crc32-glue.c b/arch/x86/lib/crc32-glue.c
index afcdeee429664..326261e503b42 100644
--- a/arch/x86/lib/crc32-glue.c
+++ b/arch/x86/lib/crc32-glue.c
@@ -18,10 +18,11 @@
 
 static DEFINE_STATIC_KEY_FALSE(have_crc32);
 static DEFINE_STATIC_KEY_FALSE(have_pclmulqdq);
 
 DECLARE_CRC_PCLMUL_FUNCS(crc32_lsb, u32);
+DECLARE_CRC_PCLMUL_FUNCS(crc32_msb, u32);
 
 u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 {
 	CRC_PCLMUL(crc, p, len, crc32_lsb, crc32_lsb_0xedb88320_consts,
 		   have_pclmulqdq, IS_ENABLED(CONFIG_CRC32_SLICEBY8));
@@ -69,10 +70,12 @@ u32 crc32c_le_arch(u32 crc, const u8 *p, size_t len)
 }
 EXPORT_SYMBOL(crc32c_le_arch);
 
 u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
 {
+	CRC_PCLMUL(crc, p, len, crc32_msb, crc32_msb_0x04c11db7_consts,
+		   have_pclmulqdq, IS_ENABLED(CONFIG_CRC32_SLICEBY8));
 	return crc32_be_base(crc, p, len);
 }
 EXPORT_SYMBOL(crc32_be_arch);
 
 static int __init crc32_x86_init(void)
@@ -80,10 +83,11 @@ static int __init crc32_x86_init(void)
 	if (boot_cpu_has(X86_FEATURE_XMM4_2))
 		static_branch_enable(&have_crc32);
 	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
 		static_branch_enable(&have_pclmulqdq);
 		INIT_CRC_PCLMUL(crc32_lsb);
+		INIT_CRC_PCLMUL(crc32_msb);
 	}
 	return 0;
 }
 arch_initcall(crc32_x86_init);
 
diff --git a/arch/x86/lib/crc32-pclmul.S b/arch/x86/lib/crc32-pclmul.S
index cf07d571ae864..d562944211d4d 100644
--- a/arch/x86/lib/crc32-pclmul.S
+++ b/arch/x86/lib/crc32-pclmul.S
@@ -2,5 +2,6 @@
 // Copyright 2024 Google LLC
 
 #include "crc-pclmul-template.S"
 
 DEFINE_CRC_PCLMUL_FUNCS(crc32_lsb, /* bits= */ 32, /* lsb= */ 1)
+DEFINE_CRC_PCLMUL_FUNCS(crc32_msb, /* bits= */ 32, /* lsb= */ 0)
-- 
2.47.0


