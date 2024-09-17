Return-Path: <linux-kernel+bounces-331255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204C97AA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC46B28C48C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE58374D1;
	Tue, 17 Sep 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vz3oF84g"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C527D07D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726539044; cv=none; b=iGDq/O2AwSt6WyCw/iOheV9qKzwd7jHM1gy6h9eRuR5AaEFhYC2zxbiZMIlIWWnbGEGI/TJJ0ANX42GT7dNKRLpQNuBdrFwXobBOqLOj2XwBSRwArgeTTo8mp2iJPOAyq9FOsV+mxctRBMJ4INm0xOzOJ6uFZQTc3pKQ6qME7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726539044; c=relaxed/simple;
	bh=dO8Y8eFzKLlosbzRPB9JxoQ9y9QTo7ZYeJE0bQVxokk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqOc9lpJvNYKfDDsB/jXVQXJ+zbWlTipwlu7cNm935lWUY2EqrCMrjyV1HXiAys3XBllt7LVb9eFgi5TSjrC0XLAn60IBgWTM78duA5ISd6nAjKJ8oEcQKUhCXR29vcNulMPDqTWAn9LIXzTmNJRltDfEBFyWHu8MJebtE+/cmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vz3oF84g; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so4264242a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726539042; x=1727143842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSqaX/BBQLqSgKJc8ElPkCPMmmR5Y/UU2/UCsSZ/N4c=;
        b=Vz3oF84gRn0P194qVTilS+Hd0nsUo7vK/KgA1p7bq4NYM2WESoMnaenbmCjLKJDBkT
         XdkTpVIS8BlcbAG8eJPJQ28AQtOImvqtlJxZJD/QD9HgUUA5RlKkJJNgX8w8LiIIqr/g
         7j6F+lwQiZqycTcQJxXE5tP8+6roXNfnxEg7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726539042; x=1727143842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSqaX/BBQLqSgKJc8ElPkCPMmmR5Y/UU2/UCsSZ/N4c=;
        b=Ii6+krKIypmTwopb+ccJcmVFONgGDYxRZYyBypYEVtzey/SbyJReHzjCGtOhEvqxbb
         5ERPsVuxBU2AwPvFb8a9DqbgT7hLR6m/e7/OP77B47+7T5n50U3mBhS/Q8atIEfhGbzp
         hhsgsgk3ieUsIXmmt6eFQKq63uahkthTci7iE3kH0KWN2q6vc0FoUU3H4iQrr4Uf2BVl
         cylwARpydI5LQzunbnzOWQuti23yzHQur1GlreOlMFdRI3VbV2NCLrUvcxvCEJkEn2+l
         eH4Ld3O7wkBP4jizZHocLMBN5igHe58OjjRmI3v8L07XoDdx3FvY1GKSR5bAdRihaVZp
         cZmQ==
X-Gm-Message-State: AOJu0YzsJUztPP7LqIsc1NpfkQlfQdw/pBysKRBDK9fmK6L1TlAFfmiA
	RHRDDxNle0pAB/u9m63vWLBPjSdJMVQgl1RRlD73jQrPzvyXeM0ODNJw4wtznA==
X-Google-Smtp-Source: AGHT+IHvC+WDY6c3wdTTvUiPZig/zEMgFN8r/TTkevae4wokGJbRhTrWTypT3PUk2Jy6eciiBW6Mhw==
X-Received: by 2002:a17:90a:fa45:b0:2d8:bbf7:bb7b with SMTP id 98e67ed59e1d1-2dba00681d6mr20980912a91.30.1726539042064;
        Mon, 16 Sep 2024 19:10:42 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:693c:b4a9:5e6e:c397])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd9313fsm6037293a91.44.2024.09.16.19.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 19:10:41 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 6/7] zram: reshuffle zram_free_page() flags operations
Date: Tue, 17 Sep 2024 11:09:11 +0900
Message-ID: <20240917021020.883356-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240917021020.883356-1-senozhatsky@chromium.org>
References: <20240917021020.883356-1-senozhatsky@chromium.org>
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
index e48e2deec685..8f01dc1fc796 100644
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
+	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
+	zram_set_priority(zram, index, 0);
 
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
2.46.0.662.g92d0881bb0-goog


