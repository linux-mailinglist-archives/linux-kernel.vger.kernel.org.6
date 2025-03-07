Return-Path: <linux-kernel+bounces-551589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DD6A56E45
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A86168EB1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E56823ED76;
	Fri,  7 Mar 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irkfk3fo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3621C9EA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366178; cv=none; b=ShB8sBGn774NeYpAS70LZJcoMECwW6lJGYwWj8oT3Pa9UVE6RLwRfQY27rc7xrvNYYcRLWcOOYTbN4iDRJFC6mL4UCclaE0D4Mit/tU5h7qrPbfK5+xflyA+lg9F2V1Bjx4Wl0EwILufD/oQZkrjNQVUDbtnuaCOuw1necIv3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366178; c=relaxed/simple;
	bh=Q4BW6m7lWaeVfdgp8Z3USQ24lkjz5EPetWtVSyRuuVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fxPN5c6je6Qg4euhwFlkxWVop9Oxyd9oYjS3iYzuMOmI3oY6PT2G8JMXUADJfaBaiTSzPM19e4gw3rJZafZOXTlfvZFjh6il7oDiJswDMcaplSJn1VzYyEhQXenfF5xTiihSjqhSD5P0JBCx3qPbFavcS5mkdokdspz7NfhYf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irkfk3fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 126D6C4CEE9;
	Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741366178;
	bh=Q4BW6m7lWaeVfdgp8Z3USQ24lkjz5EPetWtVSyRuuVU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=irkfk3foConColgrehyu9mVHl7UGXSlbrXJcbQRYgv4CcHbOrvUVPlV/M45ICg4gV
	 33N1M20DUmDRrxSAxnDtNn169ki5zGan78LSz3YkW02svu0N/Ai1gf49xcvkEYImUW
	 bEkk933oB5Qx26HUf5ItVKnfPSx92t0TOrUnGgF6vW1Z8A5QdvPX/qw5Ra4UxH87CZ
	 EjBLGZW8Q42afYffk+ENvOwCyhIDXphzAoLZWXnpi/E+5wmgCQsCBknU+vtuknldng
	 TPPSbKlgsILw4G2elUo9Osa7bEicA365arl+1YgjcC8HaA11OlJ9mLQvGNqs1aQYr1
	 EP7fZK668Hstw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034DBC19F32;
	Fri,  7 Mar 2025 16:49:38 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Sat, 08 Mar 2025 01:48:50 +0900
Subject: [PATCH v6 3/7] bits: introduce fixed-type BIT_U*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-fixed-type-genmasks-v6-3-f59315e73c29@wanadoo.fr>
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
 Jani Nikula <jani.nikula@intel.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3128;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=nEtYcKfJWM3L1iBMC0SwSrEs4W3su9UARZZPxnH1q7g=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOmnlfsq1i/+KbvJqbBH/GqdzMJ7PFb/L0k+7ju94uHBD
 cxH5myV6yhlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRwrcM/8xay3w+nnW5FH+D
 t0teYPc0xdoXLGw56yel94boP38fa83IsLDh6BotaaPq6+Uq+7csrfn5evMap409vTLnfyU812p
 K4AEA
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
index b690611c769be61ab2b5ced43c8302ba5693308b..b234ef0394f133c8f11388fb6a4a5448d8ba9994 100644
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
 
 /*

-- 
2.45.3



