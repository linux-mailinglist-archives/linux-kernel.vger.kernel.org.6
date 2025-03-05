Return-Path: <linux-kernel+bounces-546843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B85EA4FF72
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7234E3A2AC0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D33924C065;
	Wed,  5 Mar 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcMe3Ctl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD97248863
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179664; cv=none; b=YZhBNWJuJErRvwNKgiTxSoxeiQsRhVE3n51iRw1fQd5MLKvlxXUjMhmtrb1dx5oYeiuR/Hf6H4UVR+bzHCnbaHajvBQte1N6ZKt1+L+Mwke9/W4Jd4hhq9jknef/gOg92aAYvimP3uISCbdKziKlrS8OuCLzqT8zKa+SEvcFFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179664; c=relaxed/simple;
	bh=sFDR7+WgjzOmZyYCSPlYKb32BfQtReRlh5+ZY4DqA44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxHmPTZ/k57/7pUm+R1qbcTvtzQnpO1zALizNM5fVRptHzVGmMvhpSN+T0YrY+VszTFSSYQzL80eGghwscme5wkQBgZwYZ0k7ulvOqL/E9wf4ArrmLDKVMNygSbqDDV6mNz3JBBVd7nsKgEcVdHGxu/qEw7x1JJ2teaN61nQkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcMe3Ctl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9271C4CEEB;
	Wed,  5 Mar 2025 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741179663;
	bh=sFDR7+WgjzOmZyYCSPlYKb32BfQtReRlh5+ZY4DqA44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kcMe3CtlvQnMolzSNqtS/L/9mQBV3cxkJ3ZhC3RJSwqZcaEPk8fMF1lH3YfJPyT+H
	 AkHl5eT8FNj3OXMIpk4CBOMWkN2UoglIJ4itEm1Dyd112z/2QhRAaV7+Aq+9oQaO8n
	 grlU0Fe3jvH1i65Xlshufn2c1Zcr+sviH5YWXBt7kB01UKi9k5tCPGWwRwRaV7T5KK
	 Odb+FZjldn0Okxcj4/kCQPJZJ7KSyInRRwKMyvwcLJSNqj/6JZOzfYk4B6QfKtLwzo
	 4w6SRw8TJ+KrYxkDl829FrWDMBF/hSdtu3wl40em8CHpAsXjIDdx9xMpoHgbEjoa0P
	 0K+Z/gUC3drfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0B3C282EC;
	Wed,  5 Mar 2025 13:01:03 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Wed, 05 Mar 2025 22:00:20 +0900
Subject: [PATCH v4 8/8] test_bits: add tests for fixed-type BIT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-fixed-type-genmasks-v4-8-1873dcdf6723@wanadoo.fr>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
In-Reply-To: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=0up3uFESGy3X95xnLn4wawoX+zEk4W6rPzSDoRogONM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOknvLnbrFb2/uWTiXxxiKelgVuB/1Bj79+Qksmtweq5U
 ZtjJ23uKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMJFd3xgZXvMzMBya4yV9OIC9
 b7bGwd/2IlcOnjIVb5j4Y637ik9mQBXnHqX5CYqk2T6bffkdm1/YSdOTftnrDwVoh2283qRxgYs
 TAA==
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Add some additional tests in lib/test_bits.c to cover the expected
results of the BIT_U*() macros.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 lib/test_bits.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index c3a40995a2577322252371eb10ada0c33fb5d9b4..641001a04f21bc3b788ae05c6d2eaaba9052e463 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -9,6 +9,16 @@
 
 #define assert_type(t, x) _Generic(x, t: x, default: 0)
 
+static_assert(assert_type(unsigned int, BIT_U8(0)) == 1u);
+static_assert(assert_type(unsigned int, BIT_U16(0)) == 1u);
+static_assert(assert_type(u32, BIT_U32(0)) == 1u);
+static_assert(assert_type(u64, BIT_U64(0)) == 1ull);
+
+static_assert(assert_type(unsigned int, BIT_U8(7)) == 0x80u);
+static_assert(assert_type(unsigned int, BIT_U16(15)) == 0x8000u);
+static_assert(assert_type(u32, BIT_U32(31)) == 0x80000000u);
+static_assert(assert_type(u64, BIT_U64(63)) == 0x8000000000000000ull);
+
 static_assert(assert_type(unsigned long, GENMASK(31, 0)) == U32_MAX);
 static_assert(assert_type(unsigned long long, GENMASK_ULL(63, 0)) == U64_MAX);
 static_assert(assert_type(unsigned int, GENMASK_U8(7, 0)) == U8_MAX);

-- 
2.45.3



