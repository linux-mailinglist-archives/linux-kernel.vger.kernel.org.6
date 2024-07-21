Return-Path: <linux-kernel+bounces-258198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4389384E2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E14B2136B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FC16087B;
	Sun, 21 Jul 2024 13:49:09 +0000 (UTC)
Received: from mailscanner08.zoner.fi (mailscanner08.zoner.fi [5.44.246.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23A4414
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569748; cv=none; b=FMjQLncUHdal9yTlwiIKWrdiJZTDptV2gaAdU1BQdXAqUhx2Y1jGhRxeiOOGAGw7SPKNQKiV7aXf5wKsHKeYf/b0zzbxU5/J0kL3mUGUkwaZFWgBwtszNPf7vzOrtQRzwky8FRTgSl4ztSEn9hhez+p0PubKIZ2MQGbeUvAENBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569748; c=relaxed/simple;
	bh=6Z2Wv7AzcZNtJE1z4dXo4cbQ2fjxi+ZKfRvNCpHgMrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+pFwGaWzAmKSNexgu0lrxkY0sD70xau8+umpzTgbW9kIuvhtLEALCU9/As1UhRgLt8Rzzpfpb3V3Q6osR17suvaGcoHQZtUaYxvt9fFGjeHN6PBI9xLRU7eUNwp8wBhcc0z5z5l9blaQu2ekTypMoKGRXXKaFuWQU1tcAJsaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner08.zoner.fi (Postfix) with ESMTPS id D161920F85;
	Sun, 21 Jul 2024 16:37:14 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkR-00000001SmU-1qEE;
	Sun, 21 Jul 2024 16:37:14 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Joel Stanley <joel@jms.id.au>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 09/16] xz: Cleanup CRC32 edits from 2018
Date: Sun, 21 Jul 2024 16:36:24 +0300
Message-ID: <20240721133633.47721-10-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721133633.47721-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 2018, a dependency on <linux/crc32poly.h> was added to avoid
duplicating the same constant in multiple files. Two months later it
was found to be a bad idea and the definition of CRC32_POLY_LE macro
was moved into xz_private.h to avoid including <linux/crc32poly.h>.

xz_private.h is a wrong place for it too. Revert back to the upstream
version which has the poly in xz_crc32_init() in xz_crc32.c.

Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
Fixes: 242cdad873a7 ("lib/xz: Put CRC32_POLY_LE in xz_private.h")
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 lib/xz/xz_crc32.c   | 2 +-
 lib/xz/xz_private.h | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 30b8a27110b1..effdf34ec48d 100644
--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -28,7 +28,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
 
 XZ_EXTERN void xz_crc32_init(void)
 {
-	const uint32_t poly = CRC32_POLY_LE;
+	const uint32_t poly = 0xEDB88320;
 
 	uint32_t i;
 	uint32_t j;
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index 2412a5d54801..811add814ae4 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -104,10 +104,6 @@
 #	endif
 #endif
 
-#ifndef CRC32_POLY_LE
-#define CRC32_POLY_LE 0xedb88320
-#endif
-
 /*
  * Allocate memory for LZMA2 decoder. xz_dec_lzma2_reset() must be used
  * before calling xz_dec_lzma2_run().
-- 
2.45.2


