Return-Path: <linux-kernel+bounces-408065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5E9C79F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AAB1F25512
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453FF20262B;
	Wed, 13 Nov 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RQSJskoS"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED22022F2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519030; cv=none; b=kjGxxoyYK7+zgiKFHBj2WNPUlU+7Ok2IiKOojxLhd3QSn18IrX2StzVp02CD5DrNpAIlH/1hV2z6GcDYoMpcc+9v9Rzntt3BTbC40s+i2TB+JnWgk0JZPhcvrlphQj6FFeXhBhCGUvq1OQx8B6Pi4EfJQaofUO+C8hxmaz+BJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519030; c=relaxed/simple;
	bh=nrZjwb8ESlnn4C2ZxVImi8EXVuHo0CSJaid/noqaCNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOhyv8PBNPSOf9dXgcxRTSeUm7YFeFLSLdexOwK9JWWx7K7AZVGTVGAZaPkJT3pE3eMIwi0OgaYxEJbysQlrtOaVnlV+dhEZ8lSaON61Ugba2TgY6B+D5QzILsrOT+dOLtff+9rrX5bSItSrO/t2CksoqmyJBodQL+3+KB/Z4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RQSJskoS; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BHBhtnfvcYmvZBHC6tExJW; Wed, 13 Nov 2024 18:30:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731519021;
	bh=9CRME5J/urcdMtjEP4gMVqmlBR0mekaJXIiTy7MX7B0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RQSJskoSQVPj0LUmZl+s12mThNzx+iapYWBMfymoxB7Z4RdgcS8Dt0aTq3Qe25CCT
	 tQk+WfmefdONvNoNE2omqYhsPEYya+NTAJRxNotHwgE5TstAt/p9BfS0XmHfgkNoUx
	 tPPH7NIDfMqLjwVcANmLuZiakAsr/lMGAAUvHwWULfx50MiHbzBuvD/gPo9MmuDNdA
	 PG73KnIXvgHSg2GhwVdccfNWvrmgNn+mbQf7Gcv2TqT5h3BzNlUsh9mArfQqk2GaUM
	 nDG9rjxLXO8VF/aVuRZ3Hrj+tq/B3WO1fGB6Mz2B3FTUZOMBZaDdtkJY7ENG05QLic
	 c239oZ3Y1ewPg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 13 Nov 2024 18:30:21 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 2/2] linux/bits.h: simplify GENMASK_INPUT_CHECK()
Date: Thu, 14 Nov 2024 02:18:33 +0900
Message-ID: <20241113172939.747686-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=nrZjwb8ESlnn4C2ZxVImi8EXVuHo0CSJaid/noqaCNU=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkmjziOxwTc5XsyS8nm3YE1ug8kN4k2c973mCqx62yws Sjv+XMPO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEzk1k1Ghv8/p4SU5367sGzf vs/tDq0TWpsCAwOyCiVMFUJ+rFWeE8XIsH5vaU3MQ+3ZJ2dfed7XYt0xPYH72MaVfeIT7zW7h9/ x5AIA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

In GENMASK_INPUT_CHECK(),

  __builtin_choose_expr(__is_constexpr((l) > (h)), (l) > (h), 0)

is the exact expansion of:

  const_true((l) > (h))

Apply const_true() to simplify GENMASK_INPUT_CHECK().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
This change passes the unit tests from CONFIG_BITS_TEST, including the
extra negative tests provided under #ifdef TEST_GENMASK_FAILURES [1].

[1] commit 6d511020e13d ("lib/test_bits.c: add tests of GENMASK")
Link: https://git.kernel.org/torvalds/c/6d511020e13d
---
 include/linux/bits.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 60044b608817..61a75d3f294b 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -20,9 +20,8 @@
  */
 #if !defined(__ASSEMBLY__)
 #include <linux/build_bug.h>
-#define GENMASK_INPUT_CHECK(h, l) \
-	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__is_constexpr((l) > (h)), (l) > (h), 0)))
+#include <linux/compiler.h>
+#define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.45.2


