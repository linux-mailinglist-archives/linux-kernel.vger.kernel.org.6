Return-Path: <linux-kernel+bounces-303621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B5961163
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A764C1C2361B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F481CDA2D;
	Tue, 27 Aug 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XTGitt2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B111C86FF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771915; cv=none; b=Lnnh5oqGqh91EVyHs160rbX/2arcTexOw4zNNvz6yurcBQYmcGd/Ni1i0tPSLHTPvuRPBIbn9pBrhjuq57EWW3AXdLqosiEqLe3xhCPAvqTwZJz2SvAkIbqhhNGMGNeyMAgbXl91FqNbEpwr2YBzOubD+7AYCwd1nqlDpkrQF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771915; c=relaxed/simple;
	bh=Yv55Q80dgBfXwGExZvm06WJVWCqxuG7C2rvibWOT2Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCtoW4eJrcJ08MxxyHQKB5o1smZiLhdaOsGiYMHmMh+CfYKkv5geuAFYtsHjqsCb7z14eCPKbGAIQIpFf5ZBhZZ6nPF1K64PDkH2RCN2cx2RM0qUtwbhkmzqvrXZqpow95M6VywveGsFAvMsHNLKVNgVkke+p3ShWFP4GRCoZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=XTGitt2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF7CC61067;
	Tue, 27 Aug 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XTGitt2p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724771912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AiIcPsTqGFpqGkdiqATMdRBSY5bUvLzY5hzFdeaTg64=;
	b=XTGitt2p7KhF5tO3NqBBWB7SVANbgzsQJdc53LzK0JoLVFMPsHj2LnM6PhIQ23wxMugQkC
	x2153GhmyOe76ifpErBfazs+UDwRXfXexaxPR1NudixrvzKEW/E/iUb4bhpvV6eMuPbSeF
	6TFDQiOiM016zGDSuWTqXWDnMrNF48M=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 410c3c6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 15:18:32 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: vDSO: move prototype of arch chacha function to vdso/getrandom.h
Date: Tue, 27 Aug 2024 17:18:20 +0200
Message-ID: <20240827151828.3326600-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9o35OwD574x2TyAfp=iRfWD95pvi561+Q=2aAWRORofKg@mail.gmail.com>
References: <CAHmME9o35OwD574x2TyAfp=iRfWD95pvi561+Q=2aAWRORofKg@mail.gmail.com>
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

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/include/asm/vdso/getrandom.h | 13 -------------
 include/vdso/getrandom.h              | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

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
-- 
2.46.0


