Return-Path: <linux-kernel+bounces-548812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65070A5499F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537451898876
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CD9228CB2;
	Thu,  6 Mar 2025 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQzloN7R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F12206AF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260667; cv=none; b=KPvku1ct1SLBSAYdTmwqSBwOwSMuw9wic0As1pWeAnZffNbqAUe8keJ4Yd0xguRDQyPzPMs3yVUAjaYOYhea+0S1mLcKWzOxnZignOet7Nqotv56MNjq3IXi7yhnQXCLKjYKKyuXpGFgrKr3TDPeakyFYZcdTEQdUohb+8S3slY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260667; c=relaxed/simple;
	bh=pDmrzDU20/2O05q82pXiNPKQkEOP+Qzt7hv6/3Ro+HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYCJYVdFM7NeCLdqzebVig7Msla7Nmdi1dasyl7YpR7cLbsUb7ypZeKZLTfJJgM6h6BlCI19h31RDIYdYCo3SqMdZtJHimDPLATlp9wis4O3HihRPBe0NMGrpyQJ/GnjD0/bjJD2/4XO8eS81Y1WI7D2w5svVfDbb7v4EOA37cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQzloN7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54FCEC4CEF1;
	Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260667;
	bh=pDmrzDU20/2O05q82pXiNPKQkEOP+Qzt7hv6/3Ro+HM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pQzloN7R01qzZ/7kV3qHQk/soXZjavz24fKLTN8yvmE1rbXB2yb0UMmht02P93gNQ
	 spWbz4i8XIp8hGodtBGXmyUXYBtBfpPBraLAYaslEC76dRwDaVoYlDTXfmUjT3wl/p
	 tKC/NbazRkSdBVPO6yMxPu7GwnunfXMPX0uFrDbmIyvP5IeT1/acxh9aOYRyASm0kH
	 MsqbrmloKr0oGMgHziDDvva66Y+vPHBgF/od38/YrtEGVFADYp5Sk0euI538HiFbCB
	 lkoPD5TimmDJAR5SVkdZ6bqHe0eY2nUi3Uayag6LsHJC4kT8vGIaSreWEizjew7kl/
	 icA2E/oUNHK8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C4C282EC;
	Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Thu, 06 Mar 2025 20:29:55 +0900
Subject: [PATCH v5 4/7] drm/i915: Convert REG_GENMASK*() to fixed-width
 GENMASK_U*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-fixed-type-genmasks-v5-4-b443e9dcba63@wanadoo.fr>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
In-Reply-To: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jani Nikula <jani.nikula@intel.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5436;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=aRv3WLMg0/dkoqaHRape7ppQLtc8oZBcS1sIh8+3EdA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkn23Nf/rjy5+mf0ISc8jVpGcK3Z/daf+l/peRn6fjsr
 n7Seo3AjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABP5O4Hhn8mFU0neVWmGugV6
 u82fTPa5teXd7QcLVu+buTjqk/TrAheGf3qWj41FPfqKrqysOFfa7+R2ceV1h/19Xz7s4rx0Q94
 ogB0A
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Lucas De Marchi <lucas.demarchi@intel.com>

Now that include/linux/bits.h implements fixed-width GENMASK_U*(), use
them to implement the i915/xe specific macros. Converting each driver
to use the generic macros are left for later, when/if other
driver-specific macros are also generalized.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

  v4 -> v5:

    - Add braket to macro names in patch description,
      e.g. 'REG_GENMASK*' -> 'REG_GENMASK*()'

  v3 -> v4:

    - Remove the prefixes in macro parameters,
      e.g. 'REG_GENMASK(__high, __low)' -> 'REG_GENMASK(high, low)'
---
 drivers/gpu/drm/i915/i915_reg_defs.h | 108 ++++-------------------------------
 1 file changed, 11 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_reg_defs.h b/drivers/gpu/drm/i915/i915_reg_defs.h
index e251bcc0c89f5710125bc70f07851b2cb978c89c..39e5ed9511174b8757b9201bff735fa362651b34 100644
--- a/drivers/gpu/drm/i915/i915_reg_defs.h
+++ b/drivers/gpu/drm/i915/i915_reg_defs.h
@@ -9,76 +9,19 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 
-/**
- * REG_BIT() - Prepare a u32 bit value
- * @__n: 0-based bit number
- *
- * Local wrapper for BIT() to force u32, with compile time checks.
- *
- * @return: Value with bit @__n set.
- */
-#define REG_BIT(__n)							\
-	((u32)(BIT(__n) +						\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&		\
-				 ((__n) < 0 || (__n) > 31))))
-
-/**
- * REG_BIT8() - Prepare a u8 bit value
- * @__n: 0-based bit number
- *
- * Local wrapper for BIT() to force u8, with compile time checks.
- *
- * @return: Value with bit @__n set.
- */
-#define REG_BIT8(__n)                                                   \
-	((u8)(BIT(__n) +                                                \
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&         \
-				 ((__n) < 0 || (__n) > 7))))
-
-/**
- * REG_GENMASK() - Prepare a continuous u32 bitmask
- * @__high: 0-based high bit
- * @__low: 0-based low bit
- *
- * Local wrapper for GENMASK() to force u32, with compile time checks.
- *
- * @return: Continuous bitmask from @__high to @__low, inclusive.
- */
-#define REG_GENMASK(__high, __low)					\
-	((u32)(GENMASK(__high, __low) +					\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&	\
-				 __is_constexpr(__low) &&		\
-				 ((__low) < 0 || (__high) > 31 || (__low) > (__high)))))
-
-/**
- * REG_GENMASK64() - Prepare a continuous u64 bitmask
- * @__high: 0-based high bit
- * @__low: 0-based low bit
- *
- * Local wrapper for GENMASK_ULL() to force u64, with compile time checks.
- *
- * @return: Continuous bitmask from @__high to @__low, inclusive.
+/*
+ * Wrappers over the generic BIT_* and GENMASK_* implementations,
+ * for compatibility reasons with previous implementation
  */
-#define REG_GENMASK64(__high, __low)					\
-	((u64)(GENMASK_ULL(__high, __low) +				\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&		\
-				 __is_constexpr(__low) &&		\
-				 ((__low) < 0 || (__high) > 63 || (__low) > (__high)))))
+#define REG_GENMASK(high, low)		GENMASK_U32(high, low)
+#define REG_GENMASK64(high, low)	GENMASK_U64(high, low)
+#define REG_GENMASK16(high, low)	GENMASK_U16(high, low)
+#define REG_GENMASK8(high, low)		GENMASK_U8(high, low)
 
-/**
- * REG_GENMASK8() - Prepare a continuous u8 bitmask
- * @__high: 0-based high bit
- * @__low: 0-based low bit
- *
- * Local wrapper for GENMASK() to force u8, with compile time checks.
- *
- * @return: Continuous bitmask from @__high to @__low, inclusive.
- */
-#define REG_GENMASK8(__high, __low)                                     \
-	((u8)(GENMASK(__high, __low) +                                  \
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&      \
-				 __is_constexpr(__low) &&               \
-				 ((__low) < 0 || (__high) > 7 || (__low) > (__high)))))
+#define REG_BIT(n)			BIT_U32(n)
+#define REG_BIT64(n)			BIT_U64(n)
+#define REG_BIT16(n)			BIT_U16(n)
+#define REG_BIT8(n)			BIT_U8(n)
 
 /*
  * Local integer constant expression version of is_power_of_2().
@@ -143,35 +86,6 @@
  */
 #define REG_FIELD_GET64(__mask, __val)	((u64)FIELD_GET(__mask, __val))
 
-/**
- * REG_BIT16() - Prepare a u16 bit value
- * @__n: 0-based bit number
- *
- * Local wrapper for BIT() to force u16, with compile time
- * checks.
- *
- * @return: Value with bit @__n set.
- */
-#define REG_BIT16(__n)                                                   \
-	((u16)(BIT(__n) +                                                \
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&         \
-				 ((__n) < 0 || (__n) > 15))))
-
-/**
- * REG_GENMASK16() - Prepare a continuous u8 bitmask
- * @__high: 0-based high bit
- * @__low: 0-based low bit
- *
- * Local wrapper for GENMASK() to force u16, with compile time
- * checks.
- *
- * @return: Continuous bitmask from @__high to @__low, inclusive.
- */
-#define REG_GENMASK16(__high, __low)                                     \
-	((u16)(GENMASK(__high, __low) +                                  \
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&      \
-				 __is_constexpr(__low) &&               \
-				 ((__low) < 0 || (__high) > 15 || (__low) > (__high)))))
 
 /**
  * REG_FIELD_PREP16() - Prepare a u16 bitfield value

-- 
2.45.3



