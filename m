Return-Path: <linux-kernel+bounces-572377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47A4A6C9BB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D418F1B804AB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE01FA15E;
	Sat, 22 Mar 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvwKSfYo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F7A1F755B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640108; cv=none; b=fNGXdxs+Hnp6bOiy8oTQZRdHcpBIJ175BE1aR8lmhmKM7LepitCkSix5JknVW5CnRCiONypkfI9kPmytfbId9E97R1CAirkPcsuVmudrHHKG7ErqukKEpYjqzrnxd4MqIVLZqLx2xxUgvyaqYRkeTSV3kt8paFTeHoDd3OS36Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640108; c=relaxed/simple;
	bh=RT9QLdoAmCbyTGbwXgyoV1/SmvkO4Mq/zJcbRJh6PMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DD9qHNvjOOe+B8dZUMEIOTQOFTplkJRaGPKceIMiJYp2ODI2DJ3hshSbxedERFyJazJh4qO3Lq16oX+3mfYvdmBDZO4zHYQfz/6samUPbBpGX3N69U65IV3rIlBI/9BujzXrN9R7pPhuVn4gswPvT18Ek8h3vDDTE+OMoJTt1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvwKSfYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7CA1C4CEE9;
	Sat, 22 Mar 2025 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742640108;
	bh=RT9QLdoAmCbyTGbwXgyoV1/SmvkO4Mq/zJcbRJh6PMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DvwKSfYoUyjnnubn2yasJWHKNH4ZUX8lJJ97TBS7pTfxLM+qnrTVPFUf+NWXb50Tr
	 Tpv5bxE///L7VNQ9wJ9kUZxVaJXpb0GBRGkJrDMFM1e9Q8JjO6NVkumE89+yrgsAr2
	 YsfgZgEAeKnT4soSWqFDKMi4m+TDpcSUs05kXU5QLbaRiLcLW3AtGKpiRD2jK/dNKZ
	 AK389mRS7HHUIK9XzYiWjw/vEB9wmg4WtMQ8glap9ZI7z0bLZbknFs2oP4pL1Yzum9
	 YG8PFo3UV+hdoYGeVq0MErgIVmiyrRxyjC+HLPFW3bY4Rldh1TNPcp2OtY7iAuhsuz
	 tttO0zvkUYknA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB2FC3600A;
	Sat, 22 Mar 2025 10:41:47 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Sat, 22 Mar 2025 19:39:37 +0900
Subject: [PATCH 2/3] bits: unify the non-asm GENMASK*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-consolidate-genmask-v1-2-54bfd36c5643@wanadoo.fr>
References: <20250322-consolidate-genmask-v1-0-54bfd36c5643@wanadoo.fr>
In-Reply-To: <20250322-consolidate-genmask-v1-0-54bfd36c5643@wanadoo.fr>
To: Yury Norov <yury.norov@gmail.com>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>, 
 David Laight <David.Laight@ACULAB.COM>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=BGowEq4gWbAVzD7qLQ3lau/i5GwxnLHfhp35jXzU/nw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOn3Jj80Lememfugk5HxUjqrWPKdCbtv3yzYP79jQv3D3
 9vmpbpu7ChlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRd6EM/yz0rRdMda5WW6Ny
 QbUqofz9F/3tS8tsPUXcdYVylBl49jAyHNz4ouF2msycn1sfetQ5aE/xkl0x99HNwqnTpoSye8m
 F8gEA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The newly introduced GENMASK_TYPE() macro can also be used to generate
the pre-existing non-asm GENMASK*() variants.

Apply GENMASK_TYPE() to GENMASK(), GENMASK_ULL() and GENMASK_U128().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/bits.h | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 9dd2d244c1f37fde995ed65c1eed879bb2a994a8..025c9cb994b148f8d2e50e69be929d356c6c4322 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -2,10 +2,8 @@
 #ifndef __LINUX_BITS_H
 #define __LINUX_BITS_H
 
-#include <linux/const.h>
 #include <vdso/bits.h>
 #include <uapi/linux/bits.h>
-#include <asm/bitsperlong.h>
 
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
@@ -35,11 +33,6 @@
 
 #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
 
-#define GENMASK(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
-#define GENMASK_ULL(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
-
 /*
  * Generate a mask for the specified type @t. Additional checks are made to
  * guarantee the value returned fits in that type, relying on
@@ -55,10 +48,14 @@
 	     (type_max(t) << (l) &				\
 	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
 
+#define GENMASK(h, l)		GENMASK_TYPE(unsigned long, h, l)
+#define GENMASK_ULL(h, l)	GENMASK_TYPE(unsigned long long, h, l)
+
 #define GENMASK_U8(h, l)	GENMASK_TYPE(u8, h, l)
 #define GENMASK_U16(h, l)	GENMASK_TYPE(u16, h, l)
 #define GENMASK_U32(h, l)	GENMASK_TYPE(u32, h, l)
 #define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
+#define GENMASK_U128(h, l)	GENMASK_TYPE(u128, h, l)
 
 /*
  * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
@@ -89,19 +86,4 @@
 
 #endif /* !defined(__ASSEMBLY__) */
 
-#if !defined(__ASSEMBLY__)
-/*
- * Missing asm support
- *
- * __GENMASK_U128() depends on _BIT128() which would not work
- * in the asm code, as it shifts an 'unsigned __int128' data
- * type instead of direct representation of 128 bit constants
- * such as long and unsigned long. The fundamental problem is
- * that a 128 bit constant will get silently truncated by the
- * gcc compiler.
- */
-#define GENMASK_U128(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
-#endif
-
 #endif	/* __LINUX_BITS_H */

-- 
2.48.1



