Return-Path: <linux-kernel+bounces-572285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8CA6C8AD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C899F4622EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603DD1EB5DD;
	Sat, 22 Mar 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV8du4YS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF41E98EB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635452; cv=none; b=AC2Y3BvPoTV/HQSdyiDsmEEGJAIm/9S8tGCgED/cphT5jM7zJClqV9GtwaOdywsiHDbamm51kAdv9Hr4Fxzu/dc8C/qBV/L/d0KtzH/6gcTnwFWxaKAOSXZcsjEoAb2LGu0HxHOykVDFm/45Efz/mM8VZTNY+EvEolUw30W4ZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635452; c=relaxed/simple;
	bh=thQWTrjIZZYS/UhShjmRT3f+9I5W5RZ+OaG+tV1AiMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zj+9d4w2kkr9NVMhYaOf5MGT48o4tTQAebfBd8DyFTvotyMHWX74+aeMBbhMuUwp13Cg1HRCOz22j3BGPqp1VIr9KyxzH2jd1Fv7AVd6Pc2YfV/eTTepyvFtriqwGVm37RcBFZggILs2bhtwmf1/7tPhQ+0z4WZJwgLKnok1fAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rV8du4YS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19F4BC4CEE9;
	Sat, 22 Mar 2025 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742635452;
	bh=thQWTrjIZZYS/UhShjmRT3f+9I5W5RZ+OaG+tV1AiMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rV8du4YSr51bvYGhxMqWfPC0ybsGbG/R5cPK/10kCjAdtOyO1kg10cI7UrIra7CNj
	 ZxJd72Ae1sUwdUbKLwiltwPPIEv54/+DiGjbTjNB2pFyQaPgEMHa6zCJVgnZPzUcHC
	 U1Bf1+B8XxIHMArrWv+W+fYVoLNlrhzaXivc5KJ6u651xo3WRJpZGU1d+AeiWm1HEA
	 JAYYQO6t4kWr3+RpNnHvXZ9zoXvTRiyrFr+TRCxxUTnKuXY4NYHzkuRgJeK3mxVgyC
	 DuB1tRAxfbmCuQRf9vqnanyMhyppyYy9py46Cnh/H4C2nCdkv/zrvbYS/Qq2kpY9eZ
	 MKN0HOna6c7eQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098DCC36002;
	Sat, 22 Mar 2025 09:24:12 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Sat, 22 Mar 2025 18:23:12 +0900
Subject: [PATCH v7 1/5] bits: introduce fixed-type GENMASK_U*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-fixed-type-genmasks-v7-1-da380ff1c5b9@wanadoo.fr>
References: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>
In-Reply-To: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>
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
 Jani Nikula <jani.nikula@intel.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6346;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=H6EVGTMFrJBD0BwQz7pCCSuZTsJFcePLWSVIjCdGvXE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOn3Gtde2+1v1nxEf4F+zeI94jPc4968UvMWzmgI477QZ
 H2rUM2po5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwERUbzIy7O3kMXO/Yb1M5cre
 TWe6jk/n/sguLd62K8pt+XdnY583cQz/jPrUQiue7ORie8KhFKY3q2ZCaPrdVx+W/VrrXbu6nN2
 BDwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Add GENMASK_TYPE() which generalizes __GENMASK() to support different
types, and implement fixed-types versions of GENMASK() based on it.
The fixed-type version allows more strict checks to the min/max values
accepted, which is useful for defining registers like implemented by
i915 and xe drivers with their REG_GENMASK*() macros.

The strict checks rely on shift-count-overflow compiler check to fail
the build if a number outside of the range allowed is passed.
Example:

  #define FOO_MASK GENMASK_U32(33, 4)

will generate a warning like:

  include/linux/bits.h:51:27: error: right shift count >= width of type [-Werror=shift-count-overflow]
     51 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
        |                           ^~

While GENMASK_TYPE() is crafted to cover all variants, including the
already existing GENMASK(), GENMASK_ULL() and GENMASK_U128(), for the
moment, only use it for the newly introduced GENMASK_U*(). The
consolidation will be done in a separate change.

Co-developed-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

  v6 -> v7:

    - Fix grammar in comment: 'GENMASK_U*() depends' -> 'GENMASK_U*()
      depend'.

    - Fix typo in comment: 'Nethertheless' -> 'Nevertheless'

    - Do an artificial early line wrap in comment so that the next
      patch only has a one line diff change.

    - Re-wrap the comments to the 80th column.

    - The patch changed a lot since Yury first version: put myself as
      main author and Yury as Co-developer.

    - Add a new paragraph to the patch description to explain that
      consolidation will be done later.

  v5 -> v6:

    - No changes.

  v4 -> v5:

    - Rename GENMASK_t() to GENMASK_TYPE().

    - Fix typo in patch description.

    - Use tab indentations instead of single space to separate the
      macro name from its body.

    - s/__GENMASK_U*()/GENMASK_U*()/g in the comment.

    - Add a tag to credit myself as Co-developer. Keep Yury as the
      main author.

    - Modify GENMASK_TYPE() to match the changes made to __GENMASK()
      in: https://github.com/norov/linux/commit/1e7933a575ed

    - Replace (t)~_ULL(0) with type_max(t). This is OK because
      GENMASK_TYPE() is not available in asm.

    - linux/const.h and asm/bitsperlong.h are not used anymore. Remove
      them.

    - Apply GENMASK_TYPE() to GENMASK_U128().

    - Remove the unsigned int cast for the U8 and U16 variants. Cast
      to the target type instead. Do that cast directly in
      GENMASK_TYPE().

  v3 -> v4:

    - The v3 is one year old. Meanwhile people started using
      __GENMASK() directly. So instead of generalizing __GENMASK() to
      support different types, add a new GENMASK_t().

    - replace ~0ULL by ~_ULL(0). Otherwise, GENMASK_t() would fail in
      asm code.

    - Make GENMASK_U8() and GENMASK_U16() return an unsigned int. In
      v3, due to the integer promotion rules, these were returning a
      signed integer. By casting these to unsigned int, at least the
      signedness is kept.
---
 include/linux/bitops.h |  1 -
 include/linux/bits.h   | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index c1cb53cf2f0f8662ed3e324578f74330e63f935d..9be2d50da09a417966b3d11c84092bb2f4cd0bef 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -8,7 +8,6 @@
 
 #include <uapi/linux/kernel.h>
 
-#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 14fd0ca9a6cd17339dd2f69e449558312a8a001b..beb3ee2f1bc74a9346dd72eb06c722a9bc536051 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -12,6 +12,7 @@
 #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 
 /*
  * Create a contiguous bitmask starting at bit position @l and ending at
@@ -19,16 +20,50 @@
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
 #if !defined(__ASSEMBLY__)
+
+/*
+ * Missing asm support
+ *
+ * GENMASK_U*() depend on BITS_PER_TYPE() which relies on sizeof(),
+ * something not available in asm. Nevertheless, fixed width integers is a C
+ * concept. Assembly code can rely on the long and long long versions instead.
+ */
+
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
+#include <linux/overflow.h>
+
 #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
-#else
+
+/*
+ * Generate a mask for the specified type @t. Additional checks are made to
+ * guarantee the value returned fits in that type, relying on
+ * shift-count-overflow compiler check to detect incompatible arguments.
+ * For example, all these create build errors or warnings:
+ *
+ * - GENMASK(15, 20): wrong argument order
+ * - GENMASK(72, 15): doesn't fit unsigned long
+ * - GENMASK_U32(33, 15): doesn't fit in a u32
+ */
+#define GENMASK_TYPE(t, h, l)					\
+	((t)(GENMASK_INPUT_CHECK(h, l) +			\
+	     (type_max(t) << (l) &				\
+	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
+
+#define GENMASK_U8(h, l)	GENMASK_TYPE(u8, h, l)
+#define GENMASK_U16(h, l)	GENMASK_TYPE(u16, h, l)
+#define GENMASK_U32(h, l)	GENMASK_TYPE(u32, h, l)
+#define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
+
+#else /* defined(__ASSEMBLY__) */
+
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
  * disable the input check if that is the case.
  */
 #define GENMASK_INPUT_CHECK(h, l) 0
-#endif
+
+#endif /* !defined(__ASSEMBLY__) */
 
 #define GENMASK(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))

-- 
2.48.1



