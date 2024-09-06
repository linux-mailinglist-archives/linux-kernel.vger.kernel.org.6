Return-Path: <linux-kernel+bounces-318150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27F096E8F9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730DAB20E3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7FC1332A1;
	Fri,  6 Sep 2024 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lNabrX9D"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926D61FD8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599120; cv=none; b=Anru85vOdPUgHGcgQPcVh8XAaAvxR9XrhbXXZPevRY5kPPfOQKUh/SQSlyYppPQzSblP+5bbR05Y9VEa0ANqFm9Fm8LZ3QHGdzZZictEEamNQ8dpIExNn6EPVKVVsOMbK5iBYNTbzYusoEZ0dm/mGmyGyDppmNPtJksGH1biuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599120; c=relaxed/simple;
	bh=v4IGPLNJvc1Ay7DLnshN2zwzZvTfTklCdSU3eoXwyb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6S/mjkVNrxWBppzs4i1d4fcTxW1DCkYCdLm6nGV4e9bKhxN27/6bzy4pKqC3GtrSdp7WZqIHp/iJM9IFPl4n60Tui7JqWhSEbxfswbrLOYzsbamGH+KHKCOCY6HgZDakKcIm85VBrn+iptFPT2qtlp1f3kYUcq6d9lM4XXd+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lNabrX9D; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-715cc93694fso1417320b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 22:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725599118; x=1726203918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xiA0k0rhRcqQGp1KmtwBmBlr4bWDi9h3zRWo5zbjP8=;
        b=lNabrX9DwP1nfbtLrv1V5CB2NyU5qQ2LiWG6duREOZoIwuPC4K/hgsy0yMC5GrwiT2
         mT1QUEA5VsbBseFmnY4c6NWGo3gqjXLY9eiY7ISglTGpObhtnRzH++F0eKsJvls/8Far
         gqYY4GuWU5BU6ZJnK7M1ftTflhyCuMhev68Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725599118; x=1726203918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xiA0k0rhRcqQGp1KmtwBmBlr4bWDi9h3zRWo5zbjP8=;
        b=tjvEx0qhq8y9GKGmET5jEvLQnvEpTMMcLDxcGNZAb2nnv20UMqjmdok3sxyi0zjNEB
         UE8Ozk4mKY+hYhPglZBUxJgXGnvcG607KUekQ3IM3Qw82h8UbbzK5ODXhO/PnajwcRa5
         4xpnAYQZiWTrZ4US5nHKOyLXIXLZ+jWCLABZwKG2hZ49J2DaGS8tMKxgvLUrW4qFSVju
         +jOG6WpXgAh7pr0JsmzkL+fujJREF/ccCIpTy8FBA5n0nyYUUJDwZJRQ1WdrF7DxtlD8
         muln8aqKqP97UEOM/0r9BAbDKiPtpcCvyUDYatBXMxTDnKrlDK8L7WTi9awULXPcztfz
         nRPg==
X-Forwarded-Encrypted: i=1; AJvYcCXBoZIxr4rk0RGg0BO9i0x/bcNDW1sj4uHu2yVEJCvdPSJgte5v9AyemkE4VymiBE2e7aUPGfPSj+n7QMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzanqFSe50bg1u4e2HJmbdgU55DUnqzP7Pl4s/q/nqoaeUaeYb3
	XYzwBu4Wxzt4dcmBpx1ef2bxLuGr/JC/vhzBeaQWNbfja0Vcab37S22rMrR9r41lj9gUIw4zr7N
	30Q==
X-Google-Smtp-Source: AGHT+IEi/pMSWqpi8dTjzJ08aPHJrwUNlBt3eTne0jS5jQpnFGPgh9UjTn/QHiv0KpmmZtf4hAsdsA==
X-Received: by 2002:a05:6a21:10f:b0:1ca:e446:c16d with SMTP id adf61e73a8af0-1cf1d0ad8b1mr1134563637.16.1725599117957;
        Thu, 05 Sep 2024 22:05:17 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8eb7:9f7e:1b0e:95db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae90f3a2sm36252945ad.38.2024.09.05.22.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 22:05:17 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 3/3] zram: rework writeback target selection strategy
Date: Fri,  6 Sep 2024 14:04:47 +0900
Message-ID: <20240906050501.2494686-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240906050501.2494686-1-senozhatsky@chromium.org>
References: <20240906050501.2494686-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writeback suffers from the same problem as recompression
did before - target slot selection for writeback is just
a simple iteration over zram->table entries (stored pages)
which selects suboptimal targets for writeback.  This is
especially problematic for writeback, because we uncompress
objects before writeback so each of them takes 4K out of
limited writeback storage.  For example, when we take a
48 bytes slot and store it as a 4K object to writeback device
we only save 48 bytes of memory (release from zsmalloc pool).
We naturally want to pick the largest objects for writeback,
because then each writeback will release the largest amount
of memory.

This patch applies the same solution and strategy as for
recompression target selection: pp control (post-process)
with 16 buckets of candidate pp slots.  Slots are assigned to
pp buckets based on sizes - the larger the slot the higher the
group index.  This gives us sorted by size lists of candidate
slots (in linear time), so that among post-processing candidate
slots we always select the largest ones first and maximize
the memory saving.

TEST
====

A very simple demonstration: zram is configured with a writeback
device. A limited writeback (wb_limit 2500 pages) is performed
then, with a log of sizes of slots that were written back.
You can see that patched zram selects slots for recompression in
significantly different manner, which leads to higher memory
savings (see column #2 of mm_stat output).

BASE
----

*** initial state of zram device
/sys/block/zram0/mm_stat
1750327296 619765836 631902208        0 631902208        1        0    34278    34278

*** writeback idle wb_limit 2500
/sys/block/zram0/mm_stat
1750327296 617622333 631578624        0 631902208        1        0    34278    34278

Sizes of selected objects for writeback:
... 193 349 46 46 46 46 852 1002 543 162 107 49 34 34 34 ...

PATCHED
-------

*** initial state of zram device
/sys/block/zram0/mm_stat
1750319104 619760957 631992320        0 631992320        1        0    34278    34278

*** writeback idle wb_limit 2500
/sys/block/zram0/mm_stat
1750319104 612672056 626135040        0 631992320        1        0    34278    34278

Sizes of selected objects for writeback:
... 3680 3614 3694 3667 3553 3537 3342 3362 ...

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 280 ++++++++++++++++++++--------------
 1 file changed, 165 insertions(+), 115 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ebc3381fb2ac..b269b564c490 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -183,6 +183,103 @@ static void zram_accessed(struct zram *zram, u32 index)
 #endif
 }
 
+#if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
+struct zram_pp_slot {
+	unsigned long		index;
+	struct list_head	entry;
+};
+
+#define NUM_PP_BUCKETS		17
+
+struct zram_pp_ctl {
+	struct list_head	pp_buckets[NUM_PP_BUCKETS];
+};
+
+static struct zram_pp_ctl *init_pp_ctl(void)
+{
+	struct zram_pp_ctl *ctl;
+	u32 idx;
+
+	ctl = kmalloc(sizeof(*ctl), GFP_KERNEL);
+	if (!ctl)
+		return NULL;
+
+	for (idx = 0; idx < NUM_PP_BUCKETS; idx++)
+		INIT_LIST_HEAD(&ctl->pp_buckets[idx]);
+	return ctl;
+}
+
+static void release_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
+{
+	zram_slot_lock(zram, pps->index);
+	if (zram_test_flag(zram, pps->index, ZRAM_PP_SLOT))
+		zram_clear_flag(zram, pps->index, ZRAM_PP_SLOT);
+	zram_slot_unlock(zram, pps->index);
+	kfree(pps);
+}
+
+static void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl)
+{
+	u32 idx;
+
+	if (!ctl)
+		return;
+
+	for (idx = 0; idx < NUM_PP_BUCKETS; idx++) {
+		while (!list_empty(&ctl->pp_buckets[idx])) {
+			struct zram_pp_slot *pps;
+
+			pps = list_first_entry(&ctl->pp_buckets[idx],
+					       struct zram_pp_slot,
+					       entry);
+			list_del_init(&pps->entry);
+			release_pp_slot(zram, pps);
+		}
+	}
+
+	kfree(ctl);
+}
+
+static void place_pp_slot(struct zram *zram, struct zram_pp_ctl *ctl,
+			  struct zram_pp_slot *pps)
+{
+	s32 diff, idx;
+
+	/*
+	 * On 4K system this keeps PP slot groups 256 bytes apart. The
+	 * higher the group IDX the larger the slot size.
+	 */
+	diff = PAGE_SIZE / (NUM_PP_BUCKETS - 1);
+	idx = zram_get_obj_size(zram, pps->index) / diff;
+	list_add(&pps->entry, &ctl->pp_buckets[idx]);
+
+	zram_set_flag(zram, pps->index, ZRAM_PP_SLOT);
+}
+
+static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
+{
+	struct zram_pp_slot *pps = NULL;
+	s32 idx = NUM_PP_BUCKETS - 1;
+
+	/*
+	 * Select PP-slots starting from the highest group, which should
+	 * give us the best candidate for recompression.
+	 */
+	while (idx > 0) {
+		pps = list_first_entry_or_null(&ctl->pp_buckets[idx],
+					       struct zram_pp_slot,
+					       entry);
+		if (pps) {
+			list_del_init(&pps->entry);
+			break;
+		}
+
+		idx--;
+	}
+	return pps;
+}
+#endif
+
 static inline void update_used_max(struct zram *zram,
 					const unsigned long pages)
 {
@@ -587,11 +684,59 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 #define IDLE_WRITEBACK			(1<<1)
 #define INCOMPRESSIBLE_WRITEBACK	(1<<2)
 
+static int scan_slots_for_writeback(struct zram *zram, u32 mode,
+				    unsigned long nr_pages,
+				    unsigned long index,
+				    struct zram_pp_ctl *ctl)
+{
+	struct zram_pp_slot *pps = NULL;
+
+	for (; nr_pages != 0; index++, nr_pages--) {
+		if (!pps)
+			pps = kmalloc(sizeof(*pps), GFP_KERNEL);
+		if (!pps)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&pps->entry);
+
+		zram_slot_lock(zram, index);
+		if (!zram_allocated(zram, index))
+			goto next;
+
+		if (zram_test_flag(zram, index, ZRAM_WB) ||
+		    zram_test_flag(zram, index, ZRAM_SAME) ||
+		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
+		    zram_test_flag(zram, index, ZRAM_PP_SLOT))
+			goto next;
+
+		if (mode & IDLE_WRITEBACK &&
+		    !zram_test_flag(zram, index, ZRAM_IDLE))
+			goto next;
+		if (mode & HUGE_WRITEBACK &&
+		    !zram_test_flag(zram, index, ZRAM_HUGE))
+			goto next;
+		if (mode & INCOMPRESSIBLE_WRITEBACK &&
+		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+			goto next;
+
+		pps->index = index;
+		place_pp_slot(zram, ctl, pps);
+		pps = NULL;
+next:
+		zram_slot_unlock(zram, index);
+	}
+
+	kfree(pps);
+	return 0;
+}
+
 static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	struct zram_pp_ctl *ctl = NULL;
+	struct zram_pp_slot *pps;
 	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
@@ -637,11 +782,19 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	for (; nr_pages != 0; index++, nr_pages--) {
+	ctl = init_pp_ctl();
+	if (!ctl) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
+	scan_slots_for_writeback(zram, mode, nr_pages, index, ctl);
+
+	while ((pps = select_pp_slot(ctl))) {
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			spin_unlock(&zram->wb_limit_lock);
 			ret = -EIO;
+			release_pp_slot(zram, pps);
 			break;
 		}
 		spin_unlock(&zram->wb_limit_lock);
@@ -650,30 +803,15 @@ static ssize_t writeback_store(struct device *dev,
 			blk_idx = alloc_block_bdev(zram);
 			if (!blk_idx) {
 				ret = -ENOSPC;
+				release_pp_slot(zram, pps);
 				break;
 			}
 		}
 
+		index = pps->index;
 		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index))
-			goto next;
-
-		if (zram_test_flag(zram, index, ZRAM_WB) ||
-		    zram_test_flag(zram, index, ZRAM_SAME) ||
-		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
-		    zram_test_flag(zram, index, ZRAM_PP_SLOT))
+		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-
-		if (mode & IDLE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_IDLE))
-			goto next;
-		if (mode & HUGE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_HUGE))
-			goto next;
-		if (mode & INCOMPRESSIBLE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
-			goto next;
-
 		/*
 		 * Clearing ZRAM_UNDER_WB is duty of caller.
 		 * IOW, zram_free_page never clear it.
@@ -682,11 +820,14 @@ static ssize_t writeback_store(struct device *dev,
 		/* Need for hugepage writeback racing */
 		zram_set_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
+
 		if (zram_read_page(zram, page, index, NULL)) {
 			zram_slot_lock(zram, index);
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			zram_slot_unlock(zram, index);
+
+			release_pp_slot(zram, pps);
 			continue;
 		}
 
@@ -705,6 +846,8 @@ static ssize_t writeback_store(struct device *dev,
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			zram_slot_unlock(zram, index);
+
+			release_pp_slot(zram, pps);
 			/*
 			 * BIO errors are not fatal, we continue and simply
 			 * attempt to writeback the remaining objects (pages).
@@ -729,7 +872,7 @@ static ssize_t writeback_store(struct device *dev,
 		 */
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index) ||
-			  !zram_test_flag(zram, index, ZRAM_IDLE)) {
+		    !zram_test_flag(zram, index, ZRAM_IDLE)) {
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			goto next;
@@ -747,12 +890,14 @@ static ssize_t writeback_store(struct device *dev,
 		spin_unlock(&zram->wb_limit_lock);
 next:
 		zram_slot_unlock(zram, index);
+		release_pp_slot(zram, pps);
 	}
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
 	__free_page(page);
 release_init_lock:
+	release_pp_ctl(zram, ctl);
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1649,78 +1794,6 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 }
 
 #ifdef CONFIG_ZRAM_MULTI_COMP
-struct zram_pp_slot {
-	unsigned long		index;
-	struct list_head	entry;
-};
-
-#define NUM_PP_BUCKETS		17
-
-struct zram_pp_ctl {
-	struct list_head	pp_buckets[NUM_PP_BUCKETS];
-};
-
-static struct zram_pp_ctl *init_pp_ctl(void)
-{
-	struct zram_pp_ctl *ctl;
-	u32 idx;
-
-	ctl = kmalloc(sizeof(*ctl), GFP_KERNEL);
-	if (!ctl)
-		return NULL;
-
-	for (idx = 0; idx < NUM_PP_BUCKETS; idx++)
-		INIT_LIST_HEAD(&ctl->pp_buckets[idx]);
-	return ctl;
-}
-
-static void release_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
-{
-	zram_slot_lock(zram, pps->index);
-	if (zram_test_flag(zram, pps->index, ZRAM_PP_SLOT))
-		zram_clear_flag(zram, pps->index, ZRAM_PP_SLOT);
-	zram_slot_unlock(zram, pps->index);
-	kfree(pps);
-}
-
-static void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl)
-{
-	u32 idx;
-
-	if (!ctl)
-		return;
-
-	for (idx = 0; idx < NUM_PP_BUCKETS; idx++) {
-		while (!list_empty(&ctl->pp_buckets[idx])) {
-			struct zram_pp_slot *pps;
-
-			pps = list_first_entry(&ctl->pp_buckets[idx],
-					       struct zram_pp_slot,
-					       entry);
-			list_del_init(&pps->entry);
-			release_pp_slot(zram, pps);
-		}
-	}
-
-	kfree(ctl);
-}
-
-static void place_pp_slot(struct zram *zram, struct zram_pp_ctl *ctl,
-			  struct zram_pp_slot *pps)
-{
-	s32 diff, idx;
-
-	/*
-	 * On 4K system this keeps PP slot groups 256 bytes apart. The
-	 * higher the group IDX the larger the slot size.
-	 */
-	diff = PAGE_SIZE / (NUM_PP_BUCKETS - 1);
-	idx = zram_get_obj_size(zram, pps->index) / diff;
-	list_add(&pps->entry, &ctl->pp_buckets[idx]);
-
-	zram_set_flag(zram, pps->index, ZRAM_PP_SLOT);
-}
-
 #define RECOMPRESS_IDLE		(1 << 0)
 #define RECOMPRESS_HUGE		(1 << 1)
 
@@ -1920,29 +1993,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	return 0;
 }
 
-static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
-{
-	struct zram_pp_slot *pps = NULL;
-	s32 idx = NUM_PP_BUCKETS - 1;
-
-	/*
-	 * Select PP-slots starting from the highest group, which should
-	 * give us the best candidate for recompression.
-	 */
-	while (idx > 0) {
-		pps = list_first_entry_or_null(&ctl->pp_buckets[idx],
-					       struct zram_pp_slot,
-					       entry);
-		if (pps) {
-			list_del_init(&pps->entry);
-			break;
-		}
-
-		idx--;
-	}
-	return pps;
-}
-
 static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t len)
-- 
2.46.0.469.g59c65b2a67-goog


