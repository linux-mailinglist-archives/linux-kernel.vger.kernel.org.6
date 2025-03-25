Return-Path: <linux-kernel+bounces-575695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FC1A705EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75C17A448E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290725DCE9;
	Tue, 25 Mar 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/mVVA9v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3442A9D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918449; cv=none; b=YOzIwvnzEU2bwd+hbw/cWkVveDSyZevaO/7vS3Q29OAeYDM1ueP+CmstJ4rGC6P5wjbRHW78FZE78jtDVp8nrkSf+b009HisMehzz9fQmXNUaJ3mbIebbaJZOdZTdKr8ID1cCdcrFGm+wTei9Ya4+zvS0WsMImUUKsICq8duzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918449; c=relaxed/simple;
	bh=0MgHXb0J9A/vlPO8SY2whMNKBj8R4Rsvop50Z26NQ3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jGkX9CXsGLoE2kXKQaIQcLQu/B4q+G7U5PM8RxcgDYsgO9Oa5CDhJwogFEsxiZdP+uU6F4678ecKnguxHerlO+bZInEx6TP9TQsLox8zWASXW97KxvsFpu1+AbtDgDqUM5Fqx3n1dukTnYyf9sljC23yZOATeeDYcxd5ORlkx+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/mVVA9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14F53C4CEEF;
	Tue, 25 Mar 2025 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742918449;
	bh=0MgHXb0J9A/vlPO8SY2whMNKBj8R4Rsvop50Z26NQ3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A/mVVA9v2v9buK38So11Q5AI7ibZq1R0Tl0Uz/3/QHGulUg8i0K5CTZP1WRUYXDZT
	 s67seeJl5A/re5LH+E2Ac6+gLmLvKX+hF7n+rK5TtyqRE4/DtuSEWkzm6/PRGFDjhs
	 qgbm4SgDv5Z4w9+KdB6zQSFf0ajE3v0r/uUk+N6Os/0WAzqq6KGg1z1tZ0C/Z2MN6i
	 Gnw9iKzQBZA1I1VB0wDYdy3yplQRHGPEGkKcGk/Zs1Y0pR2d4rSUBieIIMMXMR/tXO
	 M7uvznwt4dsGVeMPpCExydESfMt48UNYovI6nG2bRo6/QvxWtClMVdD/7+hsMm2VId
	 1BP8hhJfyL0QQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC22C3600B;
	Tue, 25 Mar 2025 16:00:49 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Wed, 26 Mar 2025 01:00:00 +0900
Subject: [PATCH v8 5/6] test_bits: add tests for GENMASK_U*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-fixed-type-genmasks-v8-5-24afed16ca00@wanadoo.fr>
References: <20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr>
In-Reply-To: <20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr>
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
 Catalin Marinas <catalin.marinas@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=Nb/G0eCNCNsy7H+SqFg3vz5WdbZbgtEPSfg4VSWoDLg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOmPLmuZWLx5XdtmddnzTrXHjbsRirLftRcHlV3ve82Ze
 PtK2PkLHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACaSsIaR4UTMnxXpZsEWv/zz
 O2U9jNom2c1a/K0zImnWe8t21YI39xj+52aEnPt9+sn5rB87ZMrPrgwo6FvdGd7VIdcZ4f990uc
 YVgA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Lucas De Marchi <lucas.demarchi@intel.com>

Add some additional tests in lib/tests/test_bits.c to cover the
expected/non-expected values of the fixed-type GENMASK_U*() macros.

Also check that the result value matches the expected type. Since
those are known at build time, use static_assert() instead of normal
kunit tests.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

  v7 -> v8:

    - In commit db6fe4d61ece ("lib: Move KUnit tests into tests/
      subdirectory"), lib/test_bits.c was moved to
      lib/tests/test_bits.c. Adjust the patch descrption accordingly.

  v6 -> v7:
  v5 -> v6:

    - No changes.

  v4 -> v5:

    - Revert v4 change. GENMASK_U8()/GENMASK_U16() are now back to
      u8/u16.

  v3 -> v4:

    - Adjust the type of GENMASK_U8()/GENMASK_U16() from u8/u16 to
      unsigned int.

    - Reorder the tests to match the order in which the macros are
      declared in bits.h.
---
 lib/tests/test_bits.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/tests/test_bits.c b/lib/tests/test_bits.c
index c7b38d91e1f16d42b7ca92e62fbd6c19b37e76a0..f443476f3265c463c1219b13c1ef9663d238d58b 100644
--- a/lib/tests/test_bits.c
+++ b/lib/tests/test_bits.c
@@ -5,6 +5,16 @@
 
 #include <kunit/test.h>
 #include <linux/bits.h>
+#include <linux/types.h>
+
+#define assert_type(t, x) _Generic(x, t: x, default: 0)
+
+static_assert(assert_type(unsigned long, GENMASK(31, 0)) == U32_MAX);
+static_assert(assert_type(unsigned long long, GENMASK_ULL(63, 0)) == U64_MAX);
+static_assert(assert_type(u8, GENMASK_U8(7, 0)) == U8_MAX);
+static_assert(assert_type(u16, GENMASK_U16(15, 0)) == U16_MAX);
+static_assert(assert_type(u32, GENMASK_U32(31, 0)) == U32_MAX);
+static_assert(assert_type(u64, GENMASK_U64(63, 0)) == U64_MAX);
 
 
 static void genmask_test(struct kunit *test)
@@ -14,11 +24,21 @@ static void genmask_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 6ul, GENMASK(2, 1));
 	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, GENMASK(31, 0));
 
+	KUNIT_EXPECT_EQ(test, 1u, GENMASK_U8(0, 0));
+	KUNIT_EXPECT_EQ(test, 3u, GENMASK_U16(1, 0));
+	KUNIT_EXPECT_EQ(test, 0x10000, GENMASK_U32(16, 16));
+
 #ifdef TEST_GENMASK_FAILURES
 	/* these should fail compilation */
 	GENMASK(0, 1);
 	GENMASK(0, 10);
 	GENMASK(9, 10);
+
+	GENMASK_U32(0, 31);
+	GENMASK_U64(64, 0);
+	GENMASK_U32(32, 0);
+	GENMASK_U16(16, 0);
+	GENMASK_U8(8, 0);
 #endif
 
 

-- 
2.48.1



