Return-Path: <linux-kernel+bounces-551591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A1A56E4D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E2C1898579
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBEB241691;
	Fri,  7 Mar 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAIIQp9g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560B23E25A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366178; cv=none; b=LS/V7AhlGb45WQBkgcKq6+4GfvsM9HdN5Xw1iGHedQsDt3YOnOUBI2wzK2EZAisw8dbHhFp7iFaojpOl01BbE+4McTGo8xjncH25EsuDXUeiv3Rjq7PKUPHjN6+me7ItGeeqIU0Lwgc2vmDkCyW8iLzVhJLgiRduCRHW+G3bNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366178; c=relaxed/simple;
	bh=40sefDO3ErWdymEjyIPiUMmoQgDhxbnjHW9ZvkfKYfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnveRpGlWhnCAEnu58HhOU7cZNEZfKCIVPaovqaN/lbfPziOHK5jtg4IxpY8H+TmMl5SWBNGtJ/c3/+Fu9Z2Or1UQNoFgVN6vNz5MMx7zpqQXG8NqRYFdvxWLOYhRELg2GSCV8WguXKZ+FXQkgblcav5SVX4IrGlpEih8WuJmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAIIQp9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 671BBC4CEEC;
	Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741366178;
	bh=40sefDO3ErWdymEjyIPiUMmoQgDhxbnjHW9ZvkfKYfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SAIIQp9gkoMDx9l9b7kkLiIegQSTwEIOIE5sbnccSoClgpLNlk7mmUB4PBBN/RxVR
	 qg3GKEJ/ek2jSOe2f0DkEAO7NwuFT/ys2UsRYUusGmP2nDeBtgF/tWz1Wz81ALK1/u
	 AfPmui7HLzUW8CY3mZ/MOCcNW1B1U68LVV3c4sOLwsXVXcmYU2iI5iaOIphuH0uDa1
	 yzsgBDJk3ci6R3JXyXxZbMOLzXOmA4YGeobMWEAoVS9NX1YOzF9XHbTakySVMYLBLn
	 Q4Xp7wP8YvCIimLUQLxUFjfoZdbHeOFHL+rpYv7009hCEjhTerp3b9AYBWLQm4v4Lq
	 /YIYWRSFNIDZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8BAC19F32;
	Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Sat, 08 Mar 2025 01:48:54 +0900
Subject: [PATCH v6 7/7] test_bits: add tests for BIT_U*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-fixed-type-genmasks-v6-7-f59315e73c29@wanadoo.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=ICSy7DSYe3wHM8cbD8PtyLiEgBieXZJqpYz/Vpj4sZM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOmnledszz72Ttn4QdrmR3oPxVZEB1d21Nv/ja1gmhpxK
 UjFqfFORykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInMes3wV/h2xjVDyfyj07tM
 Y3i/TN5q8yrEI2LOpeqPTVO/JJwLqmdk2FQ3S3b6//OuvL3Wt392VHbut8heay/TV9X7nTn9+i1
 5DgA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Add some additional tests in lib/test_bits.c to cover the expected
results of the fixed type BIT_U*() macros.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

  v5 -> v6:

    - No changes.

  v4 -> v5:

    - BIT_U8()/BIT_U16() are now back to u8/u16.

  v3 -> v4:

    - New patch.
---
 lib/test_bits.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index 87112d1895194da33c0ffdf0a6fe6df43ce6b1e7..ab88e50d2edfa2b011f07d50460ac8ea6ff99923 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -9,6 +9,16 @@
 
 #define assert_type(t, x) _Generic(x, t: x, default: 0)
 
+static_assert(assert_type(u8, BIT_U8(0)) == 1u);
+static_assert(assert_type(u16, BIT_U16(0)) == 1u);
+static_assert(assert_type(u32, BIT_U32(0)) == 1u);
+static_assert(assert_type(u64, BIT_U64(0)) == 1ull);
+
+static_assert(assert_type(u8, BIT_U8(7)) == 0x80u);
+static_assert(assert_type(u16, BIT_U16(15)) == 0x8000u);
+static_assert(assert_type(u32, BIT_U32(31)) == 0x80000000u);
+static_assert(assert_type(u64, BIT_U64(63)) == 0x8000000000000000ull);
+
 static_assert(assert_type(unsigned long, GENMASK(31, 0)) == U32_MAX);
 static_assert(assert_type(unsigned long long, GENMASK_ULL(63, 0)) == U64_MAX);
 static_assert(assert_type(u8, GENMASK_U8(7, 0)) == U8_MAX);

-- 
2.45.3



