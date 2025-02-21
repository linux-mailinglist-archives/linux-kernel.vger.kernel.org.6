Return-Path: <linux-kernel+bounces-526750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A83A402B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C92019C0436
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FBC254B0A;
	Fri, 21 Feb 2025 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FVGBSNDm"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2A4254AFC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177054; cv=none; b=rAcuf50xVPZyDXRwLNYtgut3/muHL4Oxg4MsvBxmd5jbNrvdVRKwqrzJ/jqr5ntRzil9bCI9Z0EdAFESYPA3vuiGpQ3cXcB4m70DS2ltmn9m2PZ7Oa17i5GZQ8PtN7jD08UUyLCnHjeyXtl3J4UCSeZnj68+jTxMgXDwQTt4Jks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177054; c=relaxed/simple;
	bh=4khijAOcY/3GliQajeY7WZZuyMgcFBvfMYAxniNcP0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCt9i/Io6hUabE7rW0a5izrRQI6/nR6FiRwvb/a+GYkhTlBUgXSMzMb4mQ6M2OPixJc6vm98kbLTb5a909HTUVISz3WMhGXIIWrBCvObHC6sy5vVQNoIyfT/+afhpN/uRvfJvxyBKmY1C+lV0+UMXMHv/37UMhEO6vRTij/BQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FVGBSNDm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fcff77ff9bso631273a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177052; x=1740781852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8ADKywr3WoOFpGXL6UuUKwoYnHNcDBvl5iV/2gcJVI=;
        b=FVGBSNDmrbPezUckmi5P6gviAdJbNSEDFQq1n8wEgNxts6GEQFksEz0zKK5onhwF+M
         lETi+Wuer8C1X3IsvHE79NK5JgGYbVL8AhrWiEKlYqmu29X0gPWNsEsTPlHt+lwsHZlO
         M7I/oOZkNj4oGSnSRIaA6NbKcOYg0jWGZGgHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177052; x=1740781852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8ADKywr3WoOFpGXL6UuUKwoYnHNcDBvl5iV/2gcJVI=;
        b=j2fINtXLHMj693P0aylLr/Mpuvm4rs5bPt/KQvXP6fcOmzfE2kXfwWnp6nZFIR8+0d
         xy9WHqC5TKoXQSegGGrTJ62BGbZptTJd1csjThL5X3v4I4lxjH7ORsmhAyJQSpq6tKct
         8cnPN5ZhAbfkf/yk/j+TPpxf0kkZgeURhIcCv4Z6yRViMDSNuAPCfKXL43hkxNro37Q2
         CEhsEp/AUj+rtJtA7tPNvsdiizjDytncI7R9V3eYVnigmzjHyfi+ZhkV/aRlWj8W6ys2
         n25gA8ti74YF0YRyQ5Y+kVEguFQcUsqlT6vODbOEpz6LuyWdi2LI3YiYg1BDkeFqGSlr
         Jrew==
X-Forwarded-Encrypted: i=1; AJvYcCWtPa0milDIr+0m0//GHfK9rqlJutFp6lVpphuF2ghHFmgm873AFLK3E+kESrLGxCNxB7QIAPiuzk9InC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfsXTbAhlHyMfFX9UtRuESyI2sD6NQOZLMIxSOVQ8ZI1VLdJG
	mQBQTXUR/uoabJ5zirr8EZqnRr17n/l/9vUqWvcwsQnNWQQh8LH1N8bGa2Tjwg==
X-Gm-Gg: ASbGnctHrqK5j1yweDxEee31HwnAUBqJj4l5ux2e9XxXqHRn28ypLMhgzcbL4FeKoJR
	HVhuM6GefDqZmauAr7948r++pf8gxvzCnaPHA5If+sgviHG0r/nCEy8b35odlNtxktXBdYslCz3
	5J3oM9DAEv0mcy6KiQsSkaVyCEFowOm4xNMhNHPfz6J4TZb6KZqrI/Ds4JyFHUhBcs5GO7dBC5z
	/BBFUYe89kXfOHu6ouY2KEp1HifKg1e3+HzswV1kChgjSGH3PNTeRGuSqlT18S1JFiIyZ/pFbQp
	x9IkycvWEbo6IGNQneS/H50YKfM=
X-Google-Smtp-Source: AGHT+IFoSRURobpKbzExYiuyv2t2GitVExUur5YjtZeJcx2+K102Tu8eedtNsSQzkCzjNm/j9ms6AA==
X-Received: by 2002:a17:90a:da87:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2fce78c7871mr7538085a91.19.1740177051891;
        Fri, 21 Feb 2025 14:30:51 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb05f8b8sm1961471a91.26.2025.02.21.14.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:30:51 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v8 08/17] zram: filter out recomp targets based on priority
Date: Sat, 22 Feb 2025 07:25:39 +0900
Message-ID: <20250221222958.2225035-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221222958.2225035-1-senozhatsky@chromium.org>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do no select for post processing slots that are already
compressed with same or higher priority compression
algorithm.

This should save some memory, as previously we would still
put those entries into corresponding post-processing buckets
and filter them out later in recompress_slot().

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b32b959046af..92908495c904 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1827,7 +1827,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 #define RECOMPRESS_IDLE		(1 << 0)
 #define RECOMPRESS_HUGE		(1 << 1)
 
-static int scan_slots_for_recompress(struct zram *zram, u32 mode,
+static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 				     struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
@@ -1859,6 +1859,10 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode,
 		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
+		/* Already compressed with same of higher priority */
+		if (zram_get_priority(zram, index) + 1 >= prio_max)
+			goto next;
+
 		pps->index = index;
 		place_pp_slot(zram, ctl, pps);
 		pps = NULL;
@@ -1915,6 +1919,16 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	zram_clear_flag(zram, index, ZRAM_IDLE);
 
 	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
+
+	prio = max(prio, zram_get_priority(zram, index) + 1);
+	/*
+	 * Recompression slots scan should not select slots that are
+	 * already compressed with a higher priority algorithm, but
+	 * just in case
+	 */
+	if (prio >= prio_max)
+		return 0;
+
 	/*
 	 * Iterate the secondary comp algorithms list (in order of priority)
 	 * and try to recompress the page.
@@ -1923,13 +1937,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (!zram->comps[prio])
 			continue;
 
-		/*
-		 * Skip if the object is already re-compressed with a higher
-		 * priority algorithm (or same algorithm).
-		 */
-		if (prio <= zram_get_priority(zram, index))
-			continue;
-
 		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
@@ -2154,7 +2161,7 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	scan_slots_for_recompress(zram, mode, ctl);
+	scan_slots_for_recompress(zram, mode, prio_max, ctl);
 
 	ret = len;
 	while ((pps = select_pp_slot(ctl))) {
-- 
2.48.1.601.g30ceb7b040-goog


