Return-Path: <linux-kernel+bounces-551590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68862A56E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9378C169316
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B38241694;
	Fri,  7 Mar 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5duZbF7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819BF23C8CF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366178; cv=none; b=WB4gTedJaj0g4ouwwBlZ/C3qopbWI1I9dx81Q45cWFA4TfzklkogsgBONbttYZXtTtvybpeiizb6cbKpa2GFBjcKMeRBHHKqUpBHq3IKnQF1c4027F3A6xux2cFucczKl4fWRlku2O4izl8pVuXTmn40gh+dNH/bMXsBew8hW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366178; c=relaxed/simple;
	bh=xHN1wO8JIBs8dMNmj2V57Qxs0leYUAeta41GH32VPwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYVglAaqhvXg9DwBn4clkB2H0lK8i4c99lN8dJOqustNL1BiC6YbbZakZtZguofL2srNq48K3xq7jGzhxMifN+QY0UwzIVRNIydXL5Z8ucO6q+8AeD9qe9VhARBsC8Z1jgbj9EOtw4gFMRESRcH+BGsYVfT3dGWQbtXrKX9qi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5duZbF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4488CC4CEEB;
	Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741366178;
	bh=xHN1wO8JIBs8dMNmj2V57Qxs0leYUAeta41GH32VPwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c5duZbF7hKLqE7lOXMf+ayDrkGeg/aTo6o3pcgA6dx/Glh5c8Py6fCrdPbPyrZ6ZC
	 pFQAiPfA+QK7WLsW3uFwVnTJwFli/cKMo9tYTnLKDiQx12UAKg1zbMQygCa0unLctC
	 YEuqeiZHJMIclrxFaRCZniknjxeslar4VSvIYFQ2aqN9jx4WRiE66NtrC00lcXZvw8
	 aqlscA5dAw83GbCGzAOqLXiowVBO22aU78BViF5t523B2YBAMEohwXCfEs5GscZlxM
	 IWgMnAcWpnc2NfAVcmxNR6JZVtOgxgK1kgOgUAS/DpjDMwv2rO8IaWo5Uve3aipvnu
	 NxmrlAVmCwvPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B163C19F32;
	Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Sat, 08 Mar 2025 01:48:52 +0900
Subject: [PATCH v6 5/7] test_bits: add tests for __GENMASK() and
 __GENMASK_ULL()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-fixed-type-genmasks-v6-5-f59315e73c29@wanadoo.fr>
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
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=Xu4Eq0mDLfrGXDRUnNVBdzOqH0fc/yYOLQ/094sdOiE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOmnlSfnJi37d59l98GqGt/JV2SkWCpPLb+s6bzprURa/
 O+OVOY9HaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACaiXcnIsK8n+96MEyc6epR2
 LGqTSFh59p+18hHzr6L7X+7MSVxxvIWR4bvzbBenOywtZSrdMWkr5M1jqx/uF5wbKt2c8WDNnTN
 sXAA=
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

It would be good to have a small assembly test case for GENMASK*() in
case somebody decides to unify both in the future. However, I lack
expertise in assembly to do so. Instead add a FIXME message to
highlight the absence of the asm unit test.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

  v5 -> v6:

    - Add a FIXME message to highlight the absence of the asm
      GENMASK*() unit tests.

  v4 -> v5:

    - No changes.

  v3 -> v4:

    - New patch.
---
 lib/test_bits.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index c7b38d91e1f16d42b7ca92e62fbd6c19b37e76a0..b0c29b01fb30cbcc759ac1e7106457b18bcd73a0 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -6,6 +6,23 @@
 #include <kunit/test.h>
 #include <linux/bits.h>
 
+/* FIXME: add a test case written in asm for GENMASK() and GENMASK_ULL() */
+
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
 
 static void genmask_test(struct kunit *test)
 {
@@ -93,6 +110,8 @@ static void genmask_input_check_test(struct kunit *test)
 
 
 static struct kunit_case bits_test_cases[] = {
+	KUNIT_CASE(__genmask_test),
+	KUNIT_CASE(__genmask_ull_test),
 	KUNIT_CASE(genmask_test),
 	KUNIT_CASE(genmask_ull_test),
 	KUNIT_CASE(genmask_u128_test),

-- 
2.45.3



