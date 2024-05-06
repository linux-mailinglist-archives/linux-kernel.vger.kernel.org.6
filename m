Return-Path: <linux-kernel+bounces-169452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576658BC8DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADAA282255
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17E0142E94;
	Mon,  6 May 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KgTsJZdP"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B2142E76
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982349; cv=none; b=hKe77uPYgPf9BWUVunaViuRBXQwNWuQlNBO5dCpX+tXsY73qTJKqTOPOeUAN879GbWt98pC1OmnC1voRhsDPaWtnKVEup2j71bw35qSghXgdI64f1HEMgbfGJk6R+Sxh/tQ4Gfd7OQEowpw71T20Ac0g+Vw8bmQt4hzVui2/95k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982349; c=relaxed/simple;
	bh=fkmGnp5H4sYk5AcEucbfVYS4PjNz7ma3EYQ0ecKZnDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1pIKuS8eKOcaZYezOUe+ZZ2B1BE84XvarMNMbIeeIaBy17mK4SHZW8NIdsUaQTa8TR2+lq4BdaPv+mvshGoTQXMDVqLiQAfOAK3QfkXYJ1qC9L5ZGOWjyLBDtatAUxvyMbQJguHXRBE2PlFScvRDGERJ/EzFQ/iVnaIFi3Y6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KgTsJZdP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec4b2400b6so11067965ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982347; x=1715587147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eIYrOQ3BkMXJCk6zuaDE2ECawMW63bMTlaOVOjCrZU=;
        b=KgTsJZdPOGCHNeKMRY/ASsztQuJA1aHxZewpKIpaBMEVQZ1Hm6lxgvK24JJZrSxOIW
         L0pEPc6ulksi6lrBLU49vCe2e87GK9ZggRWa6c1S/Xqmnjzec9ZcqKHx5vFUa0/mgRoG
         9rJN4wsRT/yU2pVjGYU//JDekkVQ2yNxVQLik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982347; x=1715587147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eIYrOQ3BkMXJCk6zuaDE2ECawMW63bMTlaOVOjCrZU=;
        b=UBJnsAw4+HHzEIPO/bGjEw8K9i0fH3FFm3QAgEiUM0XwSzgjW9M6IuHeP0jlf1t6IF
         LXQH1MRRRj2/uk1+rqGtM/imRzZHZH8OGSrOADMkCgs0HY4ZeAeIY7ImwGh8Fq6wka3n
         xASMMHGixsNFWNOrDa/bdpGlOcfcpeFHmS25xyopE72cQmcjzUPpbvetQhAf95eK+hUJ
         e3tSE3KiqgKaF5LDMWVT9VVK0XbrtCQbePLNbHR0U8a532rKSwHpQ9JU1QGbN2A0xT6H
         hDgUmj90kcVSHOBft4ChQ4BUW2ASoKLeiizQk4m8k5YdYO2byT/Z2dApv8hg6gHSg4NK
         rl0A==
X-Gm-Message-State: AOJu0YxO0eYGovIoys4ESMuKg0VGHUR3831VwK6tPV74XeewbKLj1+TV
	lDWvOng8aZmB3hr4vlo6VOU8/NVQHlOiYbRcIvgEsxnEGtZ0p/l0DUDGgP5qaQ==
X-Google-Smtp-Source: AGHT+IGhUbnM5L19HjkMQe7zz6msC494kghrBWv74m5MtSoX20PhtNuMEWFgOVS6HchTjkbJ745/Dw==
X-Received: by 2002:a17:902:ea06:b0:1ec:28e4:691f with SMTP id s6-20020a170902ea0600b001ec28e4691fmr10804968plg.63.1714982346998;
        Mon, 06 May 2024 00:59:06 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:59:06 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 09/17] zram: check that backends array has at least one backend
Date: Mon,  6 May 2024 16:58:22 +0900
Message-ID: <20240506075834.302472-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that backends array has anything apart from the
sentinel NULL value.

We also select LZO_BACKEND if none backends were selected.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig | 19 +++++++++++++------
 drivers/block/zram/zcomp.c |  8 ++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 1e0e7e5910b8..6aea609b795c 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -14,12 +14,6 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
-config ZRAM_BACKEND_LZO
-	bool "lzo and lzo-rle compression support"
-	depends on ZRAM
-	select LZO_COMPRESS
-	select LZO_DECOMPRESS
-
 config ZRAM_BACKEND_LZ4
 	bool "lz4 compression support"
 	depends on ZRAM
@@ -50,6 +44,19 @@ config ZRAM_BACKEND_842
 	select 842_COMPRESS
 	select 842_DECOMPRESS
 
+config ZRAM_BACKEND_FORCE_LZO
+	depends on ZRAM
+	def_bool !ZRAM_BACKEND_LZ4 && !ZRAM_BACKEND_LZ4HC && \
+		!ZRAM_BACKEND_ZSTD && !ZRAM_BACKEND_DEFLATE && \
+		!ZRAM_BACKEND_842
+
+config ZRAM_BACKEND_LZO
+	bool "lzo and lzo-rle compression support" if !ZRAM_BACKEND_FORCE_LZO
+	depends on ZRAM
+	default ZRAM_BACKEND_FORCE_LZO
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 2a38126f4da3..d49791f724e9 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -209,6 +209,14 @@ struct zcomp *zcomp_create(const char *alg)
 	struct zcomp *comp;
 	int error;
 
+	/*
+	 * The backends array has a sentinel NULL value, so the minimum
+	 * size is 1. In order to be valid the array, apart from the
+	 * sentinel NULL element, should have at least one compression
+	 * backend selected.
+	 */
+	BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
+
 	comp = kzalloc(sizeof(struct zcomp), GFP_KERNEL);
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


