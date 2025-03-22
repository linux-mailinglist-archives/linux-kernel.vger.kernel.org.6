Return-Path: <linux-kernel+bounces-572284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734DA6C8A2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302C71894F7E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339421EB191;
	Sat, 22 Mar 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd5MlcD+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA51E8824
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635452; cv=none; b=Tm5R7K2+WGS/X3Wh81+r/uN132RTufHZ1gmS1idJoK2ZsV656wcPwgiSaopk18Q5bpUbzOKtouYA54Zmrob6DJSW8PNIjqaoR86tZxFK7yYETXJQ/LJ7DHlN2RMiWYX2iTu0wB4sgBHSf+YYq/WpX9A1IzDst1UkN+BEjQu12Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635452; c=relaxed/simple;
	bh=r7/kAIbpuUNIVWfqjbIFfMMmceVzEGLhRu2RfzE+4ds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gf88byC9Twr0Ycgxf9m+/RCjRUzworu4cGVqKYDXW5O4BDdH+DmKKmezqUr++acNDJIp1E+xVczz/1l3fxrkwDmEt4CI19YlPY9ibbAPSw8XLmqxhULSwNdzHxiWbA3Nt24FEJJ8Qml4XmC3tJzpJWpf/3ANa7fRgC+6gsnpSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd5MlcD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B4D0C4CEED;
	Sat, 22 Mar 2025 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742635452;
	bh=r7/kAIbpuUNIVWfqjbIFfMMmceVzEGLhRu2RfzE+4ds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jd5MlcD+kPJfYsQoS5xC6uf4EJHlNdC52KgiL0XmIkQFd95gnGVPo29rKSOcubyxm
	 tIuFL3phEIhCzq6bqTK2I+xY5rr309uHSjWuu252nxsqNRpCkgqUae6DSOl/ld8A5k
	 5MiTIX1X8Pe6rP5Xe511W2cjLhpCIX4SO98PmZVvG6NWb4+y6QuEbXHnD9+rYPic0Z
	 TCIeYV6/x+5TZLziDiYYtbF1/cr659p2lnvOJvoYfXUWUmkK0XzLuw95pZ1VwlFl2A
	 lQaPI1crBsY12I8y7HQoitDYhtSpomm9CI1i/6i5aR7QOLsl6uECzeVTVGNhX/BndV
	 mcs09zbsgPpfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E589C3600A;
	Sat, 22 Mar 2025 09:24:12 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Sat, 22 Mar 2025 18:23:13 +0900
Subject: [PATCH v7 2/5] bits: introduce fixed-type BIT_U*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-fixed-type-genmasks-v7-2-da380ff1c5b9@wanadoo.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2923;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=hpEfnITaKjmdzH0/1slBvC3WWgMpxke62t7YdWZOf60=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOn3Gjf8MbFxzq29fc7v3bfsTNefh4IW8W3fKrRONjfyc
 fyq9MrYjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABP5Vc3I0GTzYGK4cuOJ++Yz
 9jwSCXN+t3Mb5zP5/4a+n2LTt3PZvGFkmBcpeX0OY1/GAksJ6Vl3RfouhL/83ti+Mvz4M041jiX
 lPAA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Lucas De Marchi <lucas.demarchi@intel.com>

Implement fixed-type BIT_U*() to help drivers add stricter checks,
like it was done for GENMASK_U*().

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

  v6 -> v7:
  v5 -> v6:

    - No changes.

  v4 -> v5:

    - Rename GENMASK_t() to GENMASK_TYPE().

    - Use tab indentations instead of single space to separate the
      macro name from its body.

    - Add a global comment at the beginning of the file to explain why
      GENMASK_U*() and BIT_U*() are not available in asm.

    - Add a new BIT_TYPE() helper function, similar to GENMASK_TYPE().

    - Remove the unsigned int cast for the U8 and U16 variants. Move
      the cast to BIT_TYPE().

    - Rename the argument from BIT_U*(b) to BIT_U*(nr) for consistency
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
 include/linux/bits.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index beb3ee2f1bc74a9346dd72eb06c722a9bc536051..6a942ea9ab380d3bd0e521916caa1d59db8031c0 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -24,7 +24,7 @@
 /*
  * Missing asm support
  *
- * GENMASK_U*() depend on BITS_PER_TYPE() which relies on sizeof(),
+ * GENMASK_U*() and BIT_U*() depend on BITS_PER_TYPE() which relies on sizeof(),
  * something not available in asm. Nevertheless, fixed width integers is a C
  * concept. Assembly code can rely on the long and long long versions instead.
  */
@@ -55,6 +55,24 @@
 #define GENMASK_U32(h, l)	GENMASK_TYPE(u32, h, l)
 #define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
 
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
 
 /*

-- 
2.48.1



