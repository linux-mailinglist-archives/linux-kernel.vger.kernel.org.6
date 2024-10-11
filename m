Return-Path: <linux-kernel+bounces-361915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45F899AEDA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A969285777
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A061E202D;
	Fri, 11 Oct 2024 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BUKvH4Wk"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109131D4336
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687119; cv=none; b=b7cma9aPMhnkODdqnUDrGadxgsMuKWyHS2KOt4cBmh0eLqJDiJVWjaCIksdf6mxN+mDo6HgWGgbrsf1WoVcm1zwtrYGrLC3JGujYQn05PmOqZiMhpoh3dQUuip0MVLB9W2UXq8Bb5+YvWk4dXaq1HdA3v3XjzDP1H6SwoVxF+8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687119; c=relaxed/simple;
	bh=63jiYAGcCh0vfz9wv0RvXcM2kuWT4MiMFXFNqEpeAtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MYRQbn72jhVA5O5AGahyXy7cl/vRoNAhi6E+cbGxWq4jM7msqg0sfSFGzcX0gY9mx2vMdTl9B/M0uGJy3Z8iPD2UuMEnKCHAok8RpnIo2PSPnkVRXWktdAsIjbVvXB5v0dUDSxS3M4h21zSbXICayreqhNnvtuZBDOep1WE/e98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BUKvH4Wk; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b4663e40so7172425ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728687117; x=1729291917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+g2R8+y2Vp1pRoEQz2j1RTxSmpsdQ8fV1Oo/wOgeSc=;
        b=BUKvH4Wk+LIzTGqCgNu6LjER8JjWV4S3e4EgI24up9OEpZoEDdadysgwKnDnKl5fdF
         59fk4hsF/yCbMheBH2wXD21zACCb126nf0n50N0/m5Fkby+YRgFmUMfAgMXOVKxjDOI1
         7N475dp19z4TMzkHSw3SZXNHunT8T90RRFLIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728687117; x=1729291917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+g2R8+y2Vp1pRoEQz2j1RTxSmpsdQ8fV1Oo/wOgeSc=;
        b=T9boXBUqejbTDquzZ6Pq+FaiV5UsprHoC/FC86YFjeUWHKXyrJAbZctgQHR0C60Bu2
         SSyqXJ0Xcx9QvXJWX4oWIkZbPy17f3h6Wr/IEkN33lbtQB8U+baYBe+y3wPDHqgaYiJW
         dirhN19taO96OeCPZWqIF3ZIDL+D+wdeg3XqPommMo4NZUhDpIMhqHRr3iGI80PU3TiN
         lDlphp1jPPNFtLGIFrGBt2g9ASQhM7OdIPGjDCCPwpKOJVyHsrNeSuJS5TrHjpMvVmZZ
         63wEWfyMpyvOmvGRJqf+OCyhia0BKhjVrfkculuVQLkVIhvwVd9HqkdX0AQWyUjZKZbU
         5Gfw==
X-Forwarded-Encrypted: i=1; AJvYcCXTjKP15Zzc7bxvG8LGjslxnlc7Rnz/BxXmB7wB2/wsUSN+SNw14lJvpC1oKLtgD8dDxLBN1yGIJpog1Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvqgEreTjAjLUJkPG5UOv4Vj7Ad2nd2O2dvH+IgV3z7earye5z
	KE/Prkm19Cz7lIvecsDuUTbZ7IbJccLNAk/TiDRiOmtKQnMV2poqNJatCdywFDk=
X-Google-Smtp-Source: AGHT+IE3lzFYLfTLcw/5dVqRswmYJUk7EAC3/a9HeDC4UPhdw/rq4eausYFCXGoQeLyCmV5DuN9eVw==
X-Received: by 2002:a92:cdad:0:b0:3a1:a20f:c09c with SMTP id e9e14a558f8ab-3a3bce0b1e1mr8904925ab.22.1728687117122;
        Fri, 11 Oct 2024 15:51:57 -0700 (PDT)
Received: from shuah-tx13.internal ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afde8e5esm9063025ab.80.2024.10.11.15.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:51:56 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	sidhartha.kumar@oracle.com,
	lorenzo.stoakes@oracle.com
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	zhangpeng.00@bytedance.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools: fix -Wunused-result in linux.c
Date: Fri, 11 Oct 2024 16:51:55 -0600
Message-Id: <20241011225155.27607-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following -Wunused-result warnings on posix_memalign()
return values and add error handling.

./shared/linux.c:100:25: warning: ignoring return value of ‘posix_memalign’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  100 |          posix_memalign(&p, cachep->align, cachep->size);
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../shared/linux.c: In function ‘kmem_cache_alloc_bulk’:
../shared/linux.c:198:33: warning: ignoring return value of ‘posix_memalign’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  198 |          posix_memalign(&p[i], cachep->align,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  199 |                                cachep->size);
      |                                ~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/shared/linux.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
index 17263696b5d8..66dbb362385f 100644
--- a/tools/testing/shared/linux.c
+++ b/tools/testing/shared/linux.c
@@ -96,10 +96,13 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 		p = node;
 	} else {
 		pthread_mutex_unlock(&cachep->lock);
-		if (cachep->align)
-			posix_memalign(&p, cachep->align, cachep->size);
-		else
+		if (cachep->align) {
+			if (posix_memalign(&p, cachep->align, cachep->size) < 0)
+				return NULL;
+		} else {
 			p = malloc(cachep->size);
+		}
+
 		if (cachep->ctor)
 			cachep->ctor(p);
 		else if (gfp & __GFP_ZERO)
@@ -195,8 +198,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 			}
 
 			if (cachep->align) {
-				posix_memalign(&p[i], cachep->align,
-					       cachep->size);
+				if (posix_memalign(&p[i], cachep->align,
+					       cachep->size) < 0)
+					break;
 			} else {
 				p[i] = malloc(cachep->size);
 				if (!p[i])
-- 
2.40.1


