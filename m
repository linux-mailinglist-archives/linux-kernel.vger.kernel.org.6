Return-Path: <linux-kernel+bounces-548814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C08A549A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683C218988CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A464922A1CF;
	Thu,  6 Mar 2025 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6Z/LqDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D42222CE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260667; cv=none; b=VdfK3W8aOiTxtdAjfeF4DDjJmmVhm1OqRYI1G0n3hswFlPM7qyMSm5G0ZuTNAMf0sP0iliGfTf6DKDthmt1UqiNyMVWL9PyIPJeM6UvV7i36DK5D2TyeKy14Is/kquPkQituoGrC/zI7slGamlD6gxD8l62CFohQ25AaeOFBi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260667; c=relaxed/simple;
	bh=nswRbJg0534axjb88dgcnucQYVhi1rNjBxDjWoz+4sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UraH4OwgAqlQVmVXGhMLXpyQqnxc6zLAGqLzpFNe3bVZNkc4oJ5A6vSGAw9NjhB7Pu8b/m/lnKH2/bOpuWIrr/PsmLS2rYkGwfzmspa0Ahh85RLFPbUV0U7WW1jlO9SVYlO+Is36YrxSoJree4FFHvGC9jFj5SR6IiRGedY+N00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6Z/LqDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B4FCC4CEF4;
	Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260667;
	bh=nswRbJg0534axjb88dgcnucQYVhi1rNjBxDjWoz+4sg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J6Z/LqDYN1zcrETwYMJoohVrou0m7VbhYwy09KG8AvYcgjT5n3PFlZbGOUgkDSSb4
	 fkDzkrnWeMy5EyiLPma6ETmgdMmoB66RMWNNINCc8CEePoc2tTLMF0rL8ZaZsJqv8V
	 Pqsaa3rLxMZR8lRuzklVIU/H4eNZDOMb36zU9fdPfkxtd2RD2WYiZMIMsDo3s9Vszd
	 knYZyno8fGDo/2j2ZKjYN23DfDheOp3jE4crSzMAEurp8wypFOYXZ5iWRpWt8pxS9H
	 G/uRiRQOT4jNHDXnq4pvq02d2bmIOTCVVzRhMnDbSPd+89S+hwdvgGzd85LOSOBIx+
	 4GRf+/mm9zI9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8142FC282D1;
	Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Thu, 06 Mar 2025 20:29:58 +0900
Subject: [PATCH v5 7/7] test_bits: add tests for BIT_U*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-fixed-type-genmasks-v5-7-b443e9dcba63@wanadoo.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=asAoSxIsd+6NgC+TDV5wEh4nM1LYuph2VqJY5OZYYVA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkn28uit0fOchL91THp8/2pV/2ZatYHPC/pu5WoLLzuq
 OS5RrXZHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZiEsvwV9Lq43bev36PTq/U
 28S76/Gz+Uf49G+sKPm5gDdLReyIUSrD/6T3j8zWV5iXfJwUN/2L1OH+B9t1fn1z3v9/13sNT/n
 Ms5wA
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
Changelog

  v4 -> v5:

    - BIT_U8()/BIT_U16() are now back to u8/u16.

  v3 -> v4:

    - New patch.
---
 lib/test_bits.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index 91968227687bb11b7d1361b153c27eb851c6c1c2..72984fae7b815031bb6eb2892c772ffcc409cf78 100644
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



