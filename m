Return-Path: <linux-kernel+bounces-572287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1104AA6C8A7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58EE3BE448
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9651EB1B3;
	Sat, 22 Mar 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC9H9dOW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F901E9907
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635452; cv=none; b=cNUExipW1SVC4Z3dgrXTDDWx2hxV1bfgkH3CIO4SpfZukZAiiuWr2E85/wjx/urWrhDdoTDBYcksUQG+I8PL3ryJLqQSsT/vSOezhHB+NGcG+uC+bf2utXurbnji83hkAVg8s+CJvru4p4fUgGmARwWDqJZp/bvnaUkMfBzAWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635452; c=relaxed/simple;
	bh=mgLIRy68HbDGD6UF+REEjw60ogvUejiteW3EXN74qAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVypJvlNLpYg91DcBo8WHdVJs4QNOhMI5c0npx9kzoVvW1OSS2wkJZD5zGEuUw1vZJ228NZmoVXF21ZdZ4+eRkazRknoxM4Mnpr8CvVZlTVemP07WwB+q2j1NukzIfb32p88LKtuTAeiQE6X1Ze6xlg0XM/ptRLTSxlXgAu/bxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC9H9dOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F0AAC4CEEC;
	Sat, 22 Mar 2025 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742635452;
	bh=mgLIRy68HbDGD6UF+REEjw60ogvUejiteW3EXN74qAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AC9H9dOWO2FOzwdE6+Qjxzuhag+ODBMUGWPM9epQqZ1TelUn4k+yo6rhtzwKCZuCN
	 uvDYViUOpZ8LTtUi9/5lZUuIoNLF5kHH1lzTuV/7+mknBVx9pvZDI56ESpvXiWUD9U
	 Du4bVvyBBrga/yxICVGF6Z3vnYHMVua7W93yQXGHqB79xUF5z1BCYCPN+8wnWvVMll
	 fAksYIYb+uB6GzlONDtqGKoQ5dKJ7Rz6JcoOryQw8xegFJ1+87jFIB3OU2J+dJXN5W
	 N0oG2UmwFoRx7USY9MCCDohT9+9vwPBzxdF7psL1vQ9wD8EuJqlTocYN95XHyp5ijY
	 ymGHz0SQ3043A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4453DC36002;
	Sat, 22 Mar 2025 09:24:12 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Sat, 22 Mar 2025 18:23:15 +0900
Subject: [PATCH v7 4/5] test_bits: add tests for GENMASK_U*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-fixed-type-genmasks-v7-4-da380ff1c5b9@wanadoo.fr>
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
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2278;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=uXmPSUMb6I24+A4UZIIzKbnGyB2R8aAlshU2V9V9BKo=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOn3Grc2H4w82urEpfmP56rm/wOCB9+JWYRx2EpElVi+T
 9f7a7uso5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwEQqJjAybKhsnXE9u1rOKdPW
 5vTUtc09KTrX7pxxK9NlVLd/JdpVwMhwpF8n5ODRHtbNv18aZlvIJ77h62ZgS1l8YorflwvSLrv
 ZAA==
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Lucas De Marchi <lucas.demarchi@intel.com>

Add some additional tests in lib/test_bits.c to cover the
expected/non-expected values of the fixed-type GENMASK_U*() macros.

Also check that the result value matches the expected type. Since
those are known at build time, use static_assert() instead of normal
kunit tests.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

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
 lib/test_bits.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index c7b38d91e1f16d42b7ca92e62fbd6c19b37e76a0..f443476f3265c463c1219b13c1ef9663d238d58b 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
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



