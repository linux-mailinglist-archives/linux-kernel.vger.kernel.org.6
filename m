Return-Path: <linux-kernel+bounces-548808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB841A5499E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CC23A996D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED5822759C;
	Thu,  6 Mar 2025 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlAN6RXQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88254221F32
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260667; cv=none; b=JJDLSMuknGUT/u7s3MOvhpHHvFvBpAN6/VqkcShhh4OlWn348y+7CycZ+5fB6NyQQA6HAYrZSrCX0u6/YUNacGZfQyqBC/hwP/3wwd3VaB+QGrYQNOE2RPVcLBIBOHFiccm1iALTkuOMJF1cjVR3lE8sZJ2aaBkGLo41qZHy9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260667; c=relaxed/simple;
	bh=/Sta3iqF1dXXKt2nK0mi+OceXY7o1WvSBllV43dPYwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4y72XuLELXXD75QyY0pReprsJrWdvbNn/DmxTqJ1gVKYtDMrEUdjcYhcMGeWK4WnDvrupdmqDRrmiIjFnoDkhqbxxeiGhyB4hJpbiqNYoCnwbmbPzRRtsk5cpoZiuAXwcsj8kQ8u2SIlVZGQ1ceW5t8nK0dvBKu/yiizgcqp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlAN6RXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44459C4CEEC;
	Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260667;
	bh=/Sta3iqF1dXXKt2nK0mi+OceXY7o1WvSBllV43dPYwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YlAN6RXQcJxVCTLJb0+5X1LylSSDok8RZb8B9+7h+d/wnmXMW6W+9GwQbkreK2ky+
	 uDI53/xtpjb8FEv65zLVEDtYio7H+HnVm0O5S1MGqwY7HGotbRp7bJq2VcHFuAeYI+
	 12NNh3yGzgYu5mt9+xu8Tkb+82fKYeiGmka4rj511Xkq6dEvgUXYvhTPP+sgTucgiT
	 TW3YvC4ctVL8bCwyJ+OpwFFLLcMhDGoaWCZAyk8Rzn+XXgstVCTwfw9ro1sD1Hcwmd
	 /WidApsg+eK7vimmvTm3CcCPP64rSDkoBFpCE97JLJwq6msvt0zcFZzrB3SmGLS4aS
	 BJ+95NCHpR6Dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA6EC282D1;
	Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Thu, 06 Mar 2025 20:29:54 +0900
Subject: [PATCH v5 3/7] bits: introduce fixed-type BIT_U*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-fixed-type-genmasks-v5-3-b443e9dcba63@wanadoo.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=/aH+fGg36Lo9Rl+YyRZ1Ip9fOrVONt1J6ojSjr5THkA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkn27PuLgnIWnpISCc95NZegW2f/9r/fhPBuGSKzX6OB
 cuaBTZP7ShlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjARD39Ghu/7OxTMDJJYNje9
 nKJ9oX3Tek/uqBWL1N2n7hM4595xPpDhf4XZjzUMr9pWzJ22+7tq370d98UdJld96WC1ODo5zuT
 If3YA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Lucas De Marchi <lucas.demarchi@intel.com>

Implement fixed-type BIT_U*() to help drivers add stricter checks,
like was done for GENMASK_U*().

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

  v4 -> v5:

    - Rename GENMASK_t() to GENMASK_TYPE().

    - Use tab indentations instead of single space to separate the
      macro name from its body.

    - Add a global comment at the beginning of the file to explain why
      GENMASK_U*() and BIT_U*() are not available in asm.

    - Add a new BIT_TYPE() helper function, similar to GENMASK_TYPE().

    - Remove the unsigned int cast for the U8 and U16 variants. Move
      the cast to BIT_TYPE().

    - Rename the argument from BIT_U*(b) to BIT_U=(nr) for consistency
      with vdso/bits.h.

  v3 -> v4:

    - Use const_true() to simplify BIT_INPUT_CHECK().

    - Make BIT_U8() and BIT_U16() return an unsigned int instead of a
      u8 and u16. Because of the integer promotion rules in C, an u8
      or an u16 would become a signed integer as soon as these are
      used in any expression. By casting these to unsigned ints, at
      least the signedness is kept.

    - Put the cast next to the BIT() macro.

    - In BIT_U64(): use BIT_ULL() instead of BIT().
---
 include/linux/bits.h | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 74219521a56e2639ccff7fdc899d6805ee355a0c..f95e7815cb18636cc47ac17ef66d1bd6668e6819 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -22,10 +22,10 @@
 /*
  * Missing asm support
  *
- * GENMASK_U*() depends on BITS_PER_TYPE() which relies on sizeof(),
- * something not available in asm. Nethertheless, fixed width integers
- * is a C concept. Assembly code can rely on the long and long long
- * versions instead.
+ * GENMASK_U*() and BIT_U*() depend on BITS_PER_TYPE() which relies on
+ * sizeof(), something not available in asm. Nethertheless, fixed
+ * width integers is a C concept. Assembly code can rely on the long
+ * and long long versions instead.
  */
 
 #include <linux/build_bug.h>
@@ -58,6 +58,24 @@
 #define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
 #define GENMASK_U128(h, l)	GENMASK_TYPE(u128, h, l)
 
+/*
+ * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
+ * following examples generate compiler warnings due to shift-count-overflow:
+ *
+ * - BIT_U8(8)
+ * - BIT_U32(-1)
+ * - BIT_U32(40)
+ */
+#define BIT_INPUT_CHECK(type, nr) \
+	BUILD_BUG_ON_ZERO(const_true((nr) >= BITS_PER_TYPE(type)))
+
+#define BIT_TYPE(type, nr) ((type)(BIT_INPUT_CHECK(type, nr) + BIT_ULL(nr)))
+
+#define BIT_U8(nr)	BIT_TYPE(u8, nr)
+#define BIT_U16(nr)	BIT_TYPE(u16, nr)
+#define BIT_U32(nr)	BIT_TYPE(u32, nr)
+#define BIT_U64(nr)	BIT_TYPE(u64, nr)
+
 #else /* defined(__ASSEMBLY__) */
 
 #define GENMASK(h, l)		__GENMASK(h, l)

-- 
2.45.3



