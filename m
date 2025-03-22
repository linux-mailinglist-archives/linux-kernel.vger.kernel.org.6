Return-Path: <linux-kernel+bounces-572375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB00A6C9AB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D6E7ACCFC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89101F91F6;
	Sat, 22 Mar 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8Ef38CD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E631EE7D9
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640108; cv=none; b=S7NDJuEx+akpzKMwRnDN0CGskwPhiSSL+UdU9SORSdEFY1Txak99spRCYRIc54Lb+kRMNQwv7eBRxzHfND3Jv89bhDJfIgWnyvsk7cqbimtnPJ6CthOAYyEm4lzH+PFGecnalVHwlvkjj3kn+kkBgfG1QNt+mywp75DYfttU71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640108; c=relaxed/simple;
	bh=uH/uSKbQo5Ulfbukq6OwZ7LUE3RydYgx6jERrQzGCPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GAQtQ4DCv615XzZP1Qhiki7SrWLg7guLBc0mF3J77anKn09NQvKu6t4TmcBYD07DrlScILC4IXbI/lMqgC1ArQ8BxySYvV3hTRtOXdfHIuqGImtjRjQ0McQ7r01JUAbgoZ43huwKIi7wkL/uVay8ws8Xt2HDg1GfCMtBag7TLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8Ef38CD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D245DC4CEEC;
	Sat, 22 Mar 2025 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742640107;
	bh=uH/uSKbQo5Ulfbukq6OwZ7LUE3RydYgx6jERrQzGCPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p8Ef38CDIdE+MPcTBcTq/zSMiUA1+au+sZeRqrzrJ+IQGAVSdyabptJx+ED6BHu9p
	 GfqoTRXiqiuLRUL0z32YohtKPhlmlo7a3YVBo8B2q2MeiE+vrDD1AS4GY3Xd/XUNjS
	 lwEzmG2bChkiKrxvqO79yUOfzymncJW5T7vys05NXsLRxPJNlcZBMWbQ2z8a2BBj6l
	 bBtf1DPyO7ENNgavvU41NpfS7GFAya66LaqJ2mSWnIB8J6LD/uEJWWKz8SpqIquQqO
	 72DXFSJEMN2rdiWY+FFzkftqBRep+AXj5HAeg6FEp8Ar9eRclEcjznPKJwbBl9zZIf
	 JTgcA6X8jdWew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B495BC36002;
	Sat, 22 Mar 2025 10:41:47 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Sat, 22 Mar 2025 19:39:36 +0900
Subject: [PATCH 1/3] bits: split the definition of the asm and non-asm
 GENMASK*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-consolidate-genmask-v1-1-54bfd36c5643@wanadoo.fr>
References: <20250322-consolidate-genmask-v1-0-54bfd36c5643@wanadoo.fr>
In-Reply-To: <20250322-consolidate-genmask-v1-0-54bfd36c5643@wanadoo.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2469;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=PiGTrL0JYiV7znHV7ko5sq4U1vR9pY0pmQ4QX0K2Tvw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOn3Jt/conAk8iNv4onX2b6BbG57S8yLlx6/6D3r815jw
 dc5u1+GdJSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZiIwjNGhn9chpPuGJWUl1iu
 r3h3+1z0UlGJjy1N73ZNUDuzbrfhYUmG/4EZUsc2nFI3ZL54Lbxjn/HJxOLAzJ8ia6IbBV7rf/7
 9mwMA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

In an upcoming change, the non-asm GENMASK*() will all be unified to
depend on GENMASK_TYPE() which indirectly depend on sizeof(), something
not available in asm.

Instead of adding further complexity to GENMASK_TYPE() to make it work
for both asm and non asm, just split the definition of the two variants.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
This patch previously belonged to this series:

  bits: Fixed-type GENMASK_U*() and BIT_U*()
  Link: https://lore.kernel.org/r/20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr

Below changelog also contains the history from the previous series.

Changelog:

  v6 (previous series) -> v1 (new series):

    - Do not rephrase the comment saying that BUILD_BUG_ON() is not
      available in asm code. Leave it as it is.

    - Add Lucas reviewed-by tag.

  v5 -> v6:

    - Restore the comment saying that BUILD_BUG_ON() is not available in asm
      code.

  v4 -> v5:

    - Use tab indentations instead of single space to separate the
      macro name from its body.

  v3 -> v4:

    - New patch in the series
---
 include/linux/bits.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 6a942ea9ab380d3bd0e521916caa1d59db8031c0..9dd2d244c1f37fde995ed65c1eed879bb2a994a8 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -35,6 +35,11 @@
 
 #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
 
+#define GENMASK(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
+#define GENMASK_ULL(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
+
 /*
  * Generate a mask for the specified type @t. Additional checks are made to
  * guarantee the value returned fits in that type, relying on
@@ -79,15 +84,11 @@
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
  * disable the input check if that is the case.
  */
-#define GENMASK_INPUT_CHECK(h, l) 0
+#define GENMASK(h, l)		__GENMASK(h, l)
+#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
 
 #endif /* !defined(__ASSEMBLY__) */
 
-#define GENMASK(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
-#define GENMASK_ULL(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
-
 #if !defined(__ASSEMBLY__)
 /*
  * Missing asm support

-- 
2.48.1



