Return-Path: <linux-kernel+bounces-551588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D9A56E49
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C81189817E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F323F262;
	Fri,  7 Mar 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYfy6tC+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD421C162
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366178; cv=none; b=j4lY5vGi50h8k2oOhAF/VhCy89vkICJpfp0obuYPF9MDhz/MVzR492MUM8anAEF1fWyFTyIhErs/6jnQR+dhjXZvx4VhNlaG/LgAE1PgopmeFz6V1Ra6mV5QTJ+tEfiWpIr+9yf/BAtsMjS8iE29aCwJls/2bIquF6aCV1FGyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366178; c=relaxed/simple;
	bh=3zKerw+xf/udcMkOec1vA/suDV000JAl4RHUmIao5AU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMGlQV2LprhoB0QgcLwZJ0M82wsap93bwzW/1ECxYxqbE3AkgY0Km+V1rH5UCfhsQV7R5iip/+icfmp9MD1jm3vCQF8fxdWlB5rKuLDpgIFv7/M0ORV1wjgBc8DlYp7Ky+v5xO12y0faLfh1b3kDjz6RXuxDtKtPc0ihWE4MiTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYfy6tC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A888C4CEE8;
	Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741366178;
	bh=3zKerw+xf/udcMkOec1vA/suDV000JAl4RHUmIao5AU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BYfy6tC+qk7FNvnm3/TA8h/eX2zW9F5AXEdKvVVfHDgOZ+lII1FNFKc1w6/V6sG9m
	 JIbvQlf4/0chMrzoGZ17x+52fcHh8GWpgelFzWfn4wQ/NKnxRQMs/zKdojFBCeqk+j
	 PrY/LpuqOvZj42KYesFcWG3yTsFxzHudQzxazSfklB/R4h2mafQYplLmXjYUdV0XDN
	 N10i092SJuwT9wDqAAVY3v8i6uTqQIVoP2EoV0MmxX8TCa60CWqJd1l9T8DEMDFBQW
	 gE/ZQ6Vs7w5F0HZ4GMfj7aLKdb4sckmC+znnVIHuAh8pDITFOfKxKdLhcPTY7PqGho
	 TcgNgqmJumR/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11335C28B23;
	Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Sat, 08 Mar 2025 01:48:51 +0900
Subject: [PATCH v6 4/7] drm/i915: Convert REG_GENMASK*() to fixed-width
 GENMASK_U*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-fixed-type-genmasks-v6-4-f59315e73c29@wanadoo.fr>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
In-Reply-To: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5472;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=lkeOgx/QWbsgnQ119CFfyqfh9hkq3NjKg3QYd/j7I4w=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOmnlSduzRO6PXFRxNULQXYa09ivmt79G/h1U8p+B57AY
 rdl32eUdZSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZiIZwnDfw/dGxfDch+qf9Fa
 e2X/+/52wVX/mELWdKvUGDCvaFRxOMrwTz3rZpO2jJPkqa8rr4Yu8n/FM6XnWmjNa6bM6Ks/7h3
 w5gIA
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

  v5 -> v6:

    - No changes.

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
+/*
+ * Wrappers over the generic BIT_* and GENMASK_* implementations,
+ * for compatibility reasons with previous implementation
  */
-#define REG_BIT(__n)							\
-	((u32)(BIT(__n) +						\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&		\
-				 ((__n) < 0 || (__n) > 31))))
+#define REG_GENMASK(high, low)		GENMASK_U32(high, low)
+#define REG_GENMASK64(high, low)	GENMASK_U64(high, low)
+#define REG_GENMASK16(high, low)	GENMASK_U16(high, low)
+#define REG_GENMASK8(high, low)		GENMASK_U8(high, low)
 
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
- */
-#define REG_GENMASK64(__high, __low)					\
-	((u64)(GENMASK_ULL(__high, __low) +				\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&		\
-				 __is_constexpr(__low) &&		\
-				 ((__low) < 0 || (__high) > 63 || (__low) > (__high)))))
-
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



