Return-Path: <linux-kernel+bounces-303662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1B6961337
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AFB1C22B68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0641C93AF;
	Tue, 27 Aug 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eaheeqm4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1B18030
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773712; cv=none; b=YRfv294aLURBP8cGGuUWQK+bBp6aOBMOttNAg42vE6Bq+mETACRXf4BmyyUGz8jTV2X8kuMigmAX6G5XCL7bHqhilQavtX4S+vhxJYWMR0w313wTI0dFRGsWDWSPL1IwkfLwlU9J4A/pKskfku1wquK6uCHVZFHQETCEEYDXoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773712; c=relaxed/simple;
	bh=Vp0AZ+t6kr8pqTpizz6K99uV7tEk4ZOh+ZvuVD4rOKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwJ7x8Jku9lD+p4qeCyFweCPjOY0biQL9tBbob7ehRqc3ctIUZUm5DFoK/bnsfzV1Er/Fs7Ofx2KA7vtANW60zmpBt+r+CK1DRib7HsPYOZ43UUFDfus//Sr3DBA8adB03hWSJoqsHZ4mHzQ9FdqhF1b6yxxZ+9hiW06lnMRo8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eaheeqm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D56C567F1;
	Tue, 27 Aug 2024 15:48:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eaheeqm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724773710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nhRiHmsP1t2/YPpWHGZbuqpWC7k4mUdfGGkxiGcHZ4=;
	b=eaheeqm4Le+i/vktlEe4tws/hI09jrpwlKI5MWFgY5eW4Mq6ywtyInWnznSG2upZLZM7DF
	vCVKlx7R/9wc5tbHbUWnw1UJqQy8IFkbBDMoNxw6hv09qMdVJn+dMplJRNv1xK4Vcszktd
	42tRsNGppJ/G3ZVbDgvIZr/74Rbi7oE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 313edcc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 15:48:29 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] random: vDSO: move prototype of arch chacha function to vdso/getrandom.h
Date: Tue, 27 Aug 2024 17:47:54 +0200
Message-ID: <20240827154822.3330270-1-Jason@zx2c4.com>
In-Reply-To: <20240827151828.3326600-1-Jason@zx2c4.com>
References: <20240827151828.3326600-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having the prototype for __arch_chacha20_blocks_nostack in
arch/x86/include/asm/vdso/getrandom.h meant that the prototype and large
doc comment were cloned by every architecture, which has been causing
unnecessary churn. Instead move it into include/vdso/getrandom.h, where
it can be shared by all archs implementing it.

As a side bonus, this then lets us use that prototype in the
vdso_test_chacha self test, to ensure that it matches the source, and
indeed doing so turned up some inconsistencies, which are rectified
here.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/include/asm/vdso/getrandom.h           | 13 -------------
 include/vdso/getrandom.h                        | 13 +++++++++++++
 tools/testing/selftests/vDSO/vdso_test_chacha.c | 10 +++++++---
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
index b96e674cafde..ff5334ad32a0 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -37,19 +37,6 @@ static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void
 	return &__vdso_rng_data;
 }
 
-/**
- * __arch_chacha20_blocks_nostack - Generate ChaCha20 stream without using the stack.
- * @dst_bytes:	Destination buffer to hold @nblocks * 64 bytes of output.
- * @key:	32-byte input key.
- * @counter:	8-byte counter, read on input and updated on return.
- * @nblocks:	Number of blocks to generate.
- *
- * Generates a given positive number of blocks of ChaCha20 output with nonce=0, and does not write
- * to any stack or memory outside of the parameters passed to it, in order to mitigate stack data
- * leaking into forked child processes.
- */
-extern void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
index a8b7c14b0ae0..4cf02e678f5e 100644
--- a/include/vdso/getrandom.h
+++ b/include/vdso/getrandom.h
@@ -43,4 +43,17 @@ struct vgetrandom_state {
 	bool 			in_use;
 };
 
+/**
+ * __arch_chacha20_blocks_nostack - Generate ChaCha20 stream without using the stack.
+ * @dst_bytes:	Destination buffer to hold @nblocks * 64 bytes of output.
+ * @key:	32-byte input key.
+ * @counter:	8-byte counter, read on input and updated on return.
+ * @nblocks:	Number of blocks to generate.
+ *
+ * Generates a given positive number of blocks of ChaCha20 output with nonce=0, and does not write
+ * to any stack or memory outside of the parameters passed to it, in order to mitigate stack data
+ * leaking into forked child processes.
+ */
+extern void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);
+
 #endif /* _VDSO_GETRANDOM_H */
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index e38f44e5f803..ca5639d02969 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -7,16 +7,20 @@
 #include <sys/random.h>
 #include <string.h>
 #include <stdint.h>
+#include <stdbool.h>
 #include "../kselftest.h"
 
-extern void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint8_t *key, uint32_t *counter, size_t nblocks);
+typedef uint8_t u8;
+typedef uint32_t u32;
+typedef uint64_t u64;
+#include <vdso/getrandom.h>
 
 int main(int argc, char *argv[])
 {
 	enum { TRIALS = 1000, BLOCKS = 128, BLOCK_SIZE = 64 };
 	static const uint8_t nonce[8] = { 0 };
 	uint32_t counter[2];
-	uint8_t key[32];
+	uint32_t key[8];
 	uint8_t output1[BLOCK_SIZE * BLOCKS], output2[BLOCK_SIZE * BLOCKS];
 
 	ksft_print_header();
@@ -27,7 +31,7 @@ int main(int argc, char *argv[])
 			printf("getrandom() failed!\n");
 			return KSFT_SKIP;
 		}
-		crypto_stream_chacha20(output1, sizeof(output1), nonce, key);
+		crypto_stream_chacha20(output1, sizeof(output1), nonce, (uint8_t *)key);
 		for (unsigned int split = 0; split < BLOCKS; ++split) {
 			memset(output2, 'X', sizeof(output2));
 			memset(counter, 0, sizeof(counter));
-- 
2.46.0


