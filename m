Return-Path: <linux-kernel+bounces-324400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB28974C02
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BB51F253FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C13153565;
	Wed, 11 Sep 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iCTgCMd/"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A214F10F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041715; cv=none; b=tfvTrtvthEn/wVmH8vOaCfrqNmS0ubgOBUIeHm1C33mYEe1ZwvFhyJkzxcEQIfHOx6I/FBOhuRpWjtMUlcIPFhePSqoA0vk1N5ITtefm+78050RJYXQNntm4F7g8Q7x8X79amPpCd2RjUhvM4+4EEuI4tCZzwhYQI2YJXohEJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041715; c=relaxed/simple;
	bh=+9oLPzwFmt7zWv2BKmL5l8ncYG/9nKsygYhoxabtxq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/KIPqc+P+VOkWfR8izjR7uFgIEAVJ1Cg2/JtgEch0Cp8O90/ldyh2f0YT7BIqAdpu2UqMJLDVo+rO+ZzfVez4DDwwjFTvi/y1Md2szeJNop8Dl4YcYXEB6cx+3TRbsO7s8gzECdWo02+sQQ5aaHgkTmrerIQ1WBiN/65ievGwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iCTgCMd/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2053616fa36so19458175ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726041714; x=1726646514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N472WaAGva/om+EmpOL8/0tMAMdGDFbzXUB7x5LuZYc=;
        b=iCTgCMd/mLt1uDU3xWLawNuv15AcksAK+OO/X2gBmKEVB0ncFhXYtOUcR9f9RB7ZtV
         U0pt7+9L8CJRjA3HQyQG7qXwPVHhNf89igFqprxfiMizNAd+aNYlfaB12gQgCh48+lJL
         f2Wi95YDbQINeWafiSVfxtjxomR8Cuuczv7Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041714; x=1726646514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N472WaAGva/om+EmpOL8/0tMAMdGDFbzXUB7x5LuZYc=;
        b=A2hZunS7Yo/jk26aaLNAGHAR5X/9jHMkqq/CDWY0RH3LNX0BOtrHu5Lca2ucZQN3tZ
         EXpscmPdfvUoDDYhWzszQTuUlhJkEB68u4M0wGqcssN57Z7r9Gsepsc8FoJ8AoyJXPND
         YjKnuuD/xqCiZdpCXcE2XEzw/yArs+8ga+3/PEkdLNJ9QkfGbxEHQ79uo23KrSZ98lNo
         naIkmcrNBYkXu85eajYL5DTLLcEZfZjWLKqOWNFHzbdIUnd4ao0E8VgKWF2RhzqHl56Z
         mZCCQuCljqISP7NV9AAi0lkGgM+OIXS5R5MB2Mh5uiRa3SYfYdJpvAZyMmoC79d5GtxK
         D7UQ==
X-Gm-Message-State: AOJu0YyW9vTdf5uDASxG7hXIa+f48pijKtmmMSQFD4DPofZXdyf7364y
	EhgZjt+S7wlmWOPlV6h55P/M/3GQkqQXmTgVbn+3kSwj0nUkf5M14ojtLeoSrQ==
X-Google-Smtp-Source: AGHT+IGHbMEPbCVtVRtVcnKyQtuM5pm2H1cCaakAItz+OaoQAJQjImfcc+jE52/MBJUCg9Eq+nMoaA==
X-Received: by 2002:a17:902:e548:b0:205:8b84:d5ff with SMTP id d9443c01a7336-207521a5bd3mr24291325ad.26.1726041713657;
        Wed, 11 Sep 2024 01:01:53 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:d828:3442:b431:2762])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e37922sm58737795ad.110.2024.09.11.01.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:01:53 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 6/6] zram: reshuffle zram_free_page() flags operations
Date: Wed, 11 Sep 2024 17:01:14 +0900
Message-ID: <20240911080130.3766632-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911080130.3766632-1-senozhatsky@chromium.org>
References: <20240911080130.3766632-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop some redundant zram_test_flag() calls and re-order
zram_clear_flag() calls.  Plus two small trivial coding
style fixes.  No functional changes.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index dab5f306af32..d54502457925 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1499,20 +1499,17 @@ static void zram_free_page(struct zram *zram, size_t index)
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].ac_time = 0;
 #endif
-	if (zram_test_flag(zram, index, ZRAM_IDLE))
-		zram_clear_flag(zram, index, ZRAM_IDLE);
+
+	zram_clear_flag(zram, index, ZRAM_IDLE);
+	zram_clear_flag(zram, index, ZRAM_INCOMPRESSIBLE);
+	zram_set_priority(zram, index, 0);
+	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
 
 	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
 		zram_clear_flag(zram, index, ZRAM_HUGE);
 		atomic64_dec(&zram->stats.huge_pages);
 	}
 
-	if (zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
-		zram_clear_flag(zram, index, ZRAM_INCOMPRESSIBLE);
-
-	zram_set_priority(zram, index, 0);
-	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
-
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
 		free_block_bdev(zram, zram_get_element(zram, index));
@@ -1536,13 +1533,12 @@ static void zram_free_page(struct zram *zram, size_t index)
 	zs_free(zram->mem_pool, handle);
 
 	atomic64_sub(zram_get_obj_size(zram, index),
-			&zram->stats.compr_data_size);
+		     &zram->stats.compr_data_size);
 out:
 	atomic64_dec(&zram->stats.pages_stored);
 	zram_set_handle(zram, index, 0);
 	zram_set_obj_size(zram, index, 0);
-	WARN_ON_ONCE(zram->table[index].flags &
-		~(1UL << ZRAM_UNDER_WB));
+	WARN_ON_ONCE(zram->table[index].flags & ~(1UL << ZRAM_UNDER_WB));
 }
 
 /*
-- 
2.46.0.598.g6f2099f65c-goog


