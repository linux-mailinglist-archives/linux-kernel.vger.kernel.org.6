Return-Path: <linux-kernel+bounces-548815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44308A549A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617FF3AA7BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4199229B07;
	Thu,  6 Mar 2025 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFkaI+1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41332222C1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260667; cv=none; b=drZJaJezzCncKGxAEnhGQhSqyQTO3k58iCXNE/vrvwG6v7wnfnGJIJJWTKtLg//sbcnHxQ39CB1gXiHPABlr5sZZJe92DycWYZqrkzEhOvfVBE+31CHBemWbpozkbv8Pwgl9cfNvYmyPXMrcZAQEvWFUkeW/O61gAxVvLfJE0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260667; c=relaxed/simple;
	bh=JScz0TMKAGSf8jK8FVCMAWHGLNQQuW9+1Mg0FeL7qBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKbg/WTTwlbwNPZXbmazNq7eOphhbX6SndWjKMr/MSnTDyiCuRxbe9O940PTqlaNu6pHex2V+1eGQbl4XmCfiAPbEvuXJe73wr07mMSG0cVY+loiGaVXG56g7aYeNOMWIlXnLZ2AQZltXTKaBMLGMWn8WuWwFviVHObvuXA9khg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFkaI+1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6762FC4CEF0;
	Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260667;
	bh=JScz0TMKAGSf8jK8FVCMAWHGLNQQuW9+1Mg0FeL7qBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sFkaI+1w2EcYJKPVl99w8WW9YASl8+GXSifRMXa4dRXIELseOPmiJHDMeoFPSr0Rf
	 5UEJMgf7sBi7tQvkGltMLhSTtPNF6eWQHdB+0QGe09lOmLbxJTgkgQiDUckSp+u1FE
	 IITcM7MRD9Mc5VtHCXfp2rhFTNFztxlAgDV12F5PhdYW3enGXAGI5dYZhyitJzo1CK
	 86Mos14UGKdzHsW9DzV7nOBFWEschhOrmCeyzDsgLGqfu841jCy1S9VP8pvSHADRMx
	 kf7oS/RKNPxs0g0HbumordWqaOA9drXg6zKKKOlsin5BjF1lsck41GEWWQQLfaV+tA
	 bt0LVBsZ2BtfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4CBC282D1;
	Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Thu, 06 Mar 2025 20:29:56 +0900
Subject: [PATCH v5 5/7] test_bits: add tests for __GENMASK() and
 __GENMASK_ULL()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-fixed-type-genmasks-v5-5-b443e9dcba63@wanadoo.fr>
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
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=lN5M+jT7BPUL1L2f+TXlK22h8uB9+ou65Ns8DPPWhbE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkn2wuKWgILYv0TgmSDHq5d2ROlIS1iW8G85Oysze+5B
 KzCJhd0lLIwiHExyIopsiwr5+RW6Cj0Djv01xJmDisTyBAGLk4BmMi8KIZ/RkZCkUkHex50vdS/
 pHHvhtL7pw1z7v0NYtjD58rOPjNmD8M/6+e7+Lb8+c587ubvXZG2K3tslPunN87pybGe6f9b6P1
 vTgA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The definitions of GENMASK() and GENMASK_ULL() do not depend any more
on __GENMASK() and __GENMASK_ULL(). Duplicate the existing unit tests
so that __GENMASK{,ULL}() is still covered.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 lib/test_bits.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index c7b38d91e1f16d42b7ca92e62fbd6c19b37e76a0..dc93ded9fdb201e0d44b3c1cd71e233fd62258a5 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -7,6 +7,22 @@
 #include <linux/bits.h>
 
 
+static void __genmask_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1ul, __GENMASK(0, 0));
+	KUNIT_EXPECT_EQ(test, 3ul, __GENMASK(1, 0));
+	KUNIT_EXPECT_EQ(test, 6ul, __GENMASK(2, 1));
+	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, __GENMASK(31, 0));
+}
+
+static void __genmask_ull_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1ull, __GENMASK_ULL(0, 0));
+	KUNIT_EXPECT_EQ(test, 3ull, __GENMASK_ULL(1, 0));
+	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, __GENMASK_ULL(39, 21));
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, __GENMASK_ULL(63, 0));
+}
+
 static void genmask_test(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
@@ -93,6 +109,8 @@ static void genmask_input_check_test(struct kunit *test)
 
 
 static struct kunit_case bits_test_cases[] = {
+	KUNIT_CASE(__genmask_test),
+	KUNIT_CASE(__genmask_ull_test),
 	KUNIT_CASE(genmask_test),
 	KUNIT_CASE(genmask_ull_test),
 	KUNIT_CASE(genmask_u128_test),

-- 
2.45.3



