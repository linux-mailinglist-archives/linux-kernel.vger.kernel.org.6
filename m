Return-Path: <linux-kernel+bounces-368158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8BD9A0C15
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9631BB24933
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D820CCE5;
	Wed, 16 Oct 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vkjpa3ap"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1220C01B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087105; cv=none; b=DJNGuEM4qggH/zHgeIHZ9feqxSFQJaN6a6TDR2d2+f9sjffdBd4PEFyq1wVyF+ogw8ovXEBNsjoI997BU55VxcFI/M9Ys9Ge/Aiv/rWH4RmPtfWEHR1TMLujHmW+xHoG4vuP4FGlbNa68gDQlyW+buQ/pIU8XERNFP3+I6oa6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087105; c=relaxed/simple;
	bh=2+ctzkGnAxQmdeSUV2qiIQ5vOtZ5qd+I6LvsLkpEq5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXQUo3SwmzSG16MsU1zH37duyfDQh8HF/Llzt2zuNfohLgRTV0jiYgomADqfP0LJwdflVkntnpWcLQChxY06zZUq2uiwdrtxYW0qIAjAz37RdmkCf2uDHWItMv+Bc0C2yWR7M1qRiOxSZm0LTobUsIC5Bg9/iXV9I9MvJqeawEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vkjpa3ap; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729087099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kRCWkMbnvtxR+mnuDRQF7cbwFjedLcE7MM32iRSxMAc=;
	b=Vkjpa3apawBSlqhO/F4VyqP7HXn/sYf3PEChHcymglw0MkIluklAiZMr6Cf5MdkEgc5lUW
	j/efkOq3bT4nRDrsvMp5PaOI4ARE13gkZqJxAgPLRCir+Y6ckQNCZJCm9z4oIWLDD5Uj8+
	qyi+OHZtofWqbV0BE1dOQhGpyMAFHPc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: drbg - Use str_true_false() and str_enabled_disabled() helpers
Date: Wed, 16 Oct 2024 15:57:28 +0200
Message-ID: <20241016135727.76180-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the helper functions str_true_false()
and str_enabled_disabled().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/drbg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 3addce90930c..c323f40bed4f 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -101,6 +101,7 @@
 #include <crypto/internal/cipher.h>
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
+#include <linux/string_choices.h>
 
 /***************************************************************
  * Backend cipher definitions available to DRBG
@@ -1412,7 +1413,7 @@ static int drbg_generate(struct drbg_state *drbg,
 	if (drbg->pr || drbg->seeded == DRBG_SEED_STATE_UNSEEDED) {
 		pr_devel("DRBG: reseeding before generation (prediction "
 			 "resistance: %s, state %s)\n",
-			 drbg->pr ? "true" : "false",
+			 str_true_false(drbg->pr),
 			 (drbg->seeded ==  DRBG_SEED_STATE_FULL ?
 			  "seeded" : "unseeded"));
 		/* 9.3.1 steps 7.1 through 7.3 */
@@ -1562,7 +1563,7 @@ static int drbg_instantiate(struct drbg_state *drbg, struct drbg_string *pers,
 	bool reseed = true;
 
 	pr_devel("DRBG: Initializing DRBG core %d with prediction resistance "
-		 "%s\n", coreref, pr ? "enabled" : "disabled");
+		 "%s\n", coreref, str_enabled_disabled(pr));
 	mutex_lock(&drbg->drbg_mutex);
 
 	/* 9.1 step 1 is implicit with the selected DRBG type */
-- 
2.47.0


