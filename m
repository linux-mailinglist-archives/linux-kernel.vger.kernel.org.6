Return-Path: <linux-kernel+bounces-326067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EC5976218
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43923B217C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70B18BB91;
	Thu, 12 Sep 2024 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DWj4fNhr"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6E18DF62
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124673; cv=none; b=fYzh2Ilff25LtoP9IY80VzoF3uGdWfBjSRh5xJ63QMVCI7ptRH6xhjf+vZeWKJMeDITCEga2mMfi+2g+7ApEPwVJ1JyyYPA5MgC+gHD3sbMiXwAxI4POa+dmlNe1gJEJhv3/HTMrSF1ONeQ7iyXj6S87EA8vfr6GzRAD8O/ajQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124673; c=relaxed/simple;
	bh=BO28K1tejO2J8iIccf1acOz7SJT41KgUnTvtCvkdYbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz4fLgvpdF/XBgiiICYCwsHVPI11Tv7w3347HI4OXlenuivXRLAnseKaI2eWkGhjJA0sMXbMt7gj7iC1YuOoAXpkURMU+ZL7swYSlF8QcvaOg3msQhS1G2oFfjuLSJYtg5BSX9j66HgL+4joGOQsCRgBDiQ393UkWqJkTlU0GqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DWj4fNhr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso608309a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726124671; x=1726729471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOqqiFl7+PSHLNk87BV7Qg9ZI8tpG2YDnz3wr/rQglc=;
        b=DWj4fNhrtANFNQG+wM6T+uSaTnsGV5SztjwhyEiWbYXqRUTtAKzvgW20SJ/CFpbEXT
         Xg6DvWOTJIM7WPHi5yj8xr6nq4S9CSBFdWZbEwR5TGxfSXXMlUBkbcAxpBrJ3/JPxQX/
         CHmfPQ4uCL1EpEWrI0h81g02aIseJ5bSyBjCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726124671; x=1726729471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOqqiFl7+PSHLNk87BV7Qg9ZI8tpG2YDnz3wr/rQglc=;
        b=T1lCbpebaOUdsl5JeQGm+pQtVNEmmLvneSGRcv41z6ipaiAfwo2jIJNDz4NkGhGP/3
         YmZdbMqBomVKCIifAEuv/DnII04JsQLVGIw1K7nebf6hpvxBVAyFQJH0sTRgl4e4ctEC
         x/y5FhHk7qZN8O329ceUESAyztl57QwgO5VPX1Z9gTU87UkMOgdXQSZUnnvPvM+t6Fd6
         RveWBJLYrqRNQ9d4diB4J+Qm5XTBpg4GpQwOqbHr16xN0LmXPByqAOn9Mh+WyM1IQvdd
         T782DOT8W+FHB7JdOj3bkf6i6ec1lp2s7PSycPEdDvBZhNSzKXV2mTBZRoiZjpEJHpQh
         zYHg==
X-Gm-Message-State: AOJu0Yy2/VXQO6jqhJZR3KDA6sGfIHFcuJqmvimegqbRK56e4yEjqGj1
	Nc2LnZueF0j/aZdU+OFxVIeAS31YQVYj3nzb3HhLGaZWWUoXzd10LCvkENwq9/1VWVjaUM27p+S
	Dfw==
X-Google-Smtp-Source: AGHT+IHgHHJJpvWkXs+lLUw6m3794dcKU0lYPZPpF8x2WWIgyhnyYBGEV/+2pMGcMkUcGk0f30KHjw==
X-Received: by 2002:a05:6a20:7b07:b0:1cf:d746:22d0 with SMTP id adf61e73a8af0-1cfd7463553mr842276637.1.1726124671131;
        Thu, 12 Sep 2024 00:04:31 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:2fb2:d683:de5d:c3cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5a23sm1101543a12.31.2024.09.12.00.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:04:30 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 3/6] zram: rework recompress target selection strategy
Date: Thu, 12 Sep 2024 16:02:18 +0900
Message-ID: <20240912070413.4179924-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240912070413.4179924-1-senozhatsky@chromium.org>
References: <20240912070413.4179924-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Target slot selection for recompression is just a simple
iteration over zram->table entries (stored pages) from
slot 0 to max slot.  Given that zram->table slots are
written in random order and are not sorted by size, a
simple iteration over slots selects suboptimal targets
for recompression.  This is not a problem if we recompress
every single zram->table slot, but we never do that in
reality.  In reality we limit the number of slots we
can recompress (via max_pages parameter) and hence proper
slot selection becomes very important.  The strategy is
quite simple, suppose we have two candidate slots for
recompression, one of size 48 bytes and one of size 2800
bytes, and we can recompress only one, then it certainly
makes more sense to pick 2800 entry for recompression.
Because even if we manage to compress 48 bytes objects
even further the savings are going to be very small.
Potential savings after good re-compression of 2800 bytes
objects are much higher.

This patch reworks slot selection and introduces the
strategy described above: among candidate slots always
select the biggest ones first.

For that the patch introduces zram_pp_ctl (post-processing)
structure which holds NUM_PP_BUCKETS pp buckets of slots.
Slots are assigned to a particular group based on their
sizes - the larger the size of the slot the higher the group
index. This, basically, sorts slots by size in liner time
(we still perform just one iteration over zram->table slots).
When we select slot for recompression we always first lookup
in higher pp buckets (those that hold the largest slots).
Which achieves the desired behavior.

TEST
====

A very simple demonstration: zram is configured with zstd, and
zstd with dict as a recompression stream.  A limited (max 4096
pages) recompression is performed then, with a log of sizes of
slots that were recompressed.  You can see that patched zram
selects slots for recompression in significantly different
manner, which leads to higher memory savings (see column #2 of
mm_stat output).

BASE
----

*** initial state of zram device
/sys/block/zram0/mm_stat
1750994944 504491413 514203648        0 514203648        1        0    34204    34204

*** recompress idle max_pages=4096
/sys/block/zram0/mm_stat
1750994944 504262229 514953216        0 514203648        1        0    34204    34204

Sizes of selected objects for recompression:
... 45 58 24 226 91 40 24 24 24 424 2104 93 2078 2078 2078 959 154 ...

PATCHED
-------

*** initial state of zram device
/sys/block/zram0/mm_stat
1750982656 504492801 514170880        0 514170880        1        0    34204    34204

*** recompress idle max_pages=4096
/sys/block/zram0/mm_stat
1750982656 503716710 517586944        0 514170880        1        0    34204    34204

Sizes of selected objects for recompression:
... 3680 3694 3667 3590 3614 3553 3537 3548 3550 3542 3543 3537 ...

Note, pp-slots are not strictly sorted, there is a PP_BUCKET_SIZE_RANGE
variation of sizes within particular bucket.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 187 +++++++++++++++++++++++++++++-----
 1 file changed, 160 insertions(+), 27 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 37622268104e..6688f70b2140 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -184,6 +184,99 @@ static void zram_accessed(struct zram *zram, u32 index)
 #endif
 }
 
+#ifdef CONFIG_ZRAM_MULTI_COMP
+struct zram_pp_slot {
+	unsigned long		index;
+	struct list_head	entry;
+};
+
+/*
+ * A post-processing bucket is, essentially, a size class, this defines
+ * the range (in bytes) of pp-slots sizes in particular bucket.
+ */
+#define PP_BUCKET_SIZE_RANGE	64
+#define NUM_PP_BUCKETS		((PAGE_SIZE / PP_BUCKET_SIZE_RANGE) + 1)
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
+	list_del_init(&pps->entry);
+
+	zram_slot_lock(zram, pps->index);
+	zram_clear_flag(zram, pps->index, ZRAM_PP_SLOT);
+	zram_slot_unlock(zram, pps->index);
+
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
+	u32 idx;
+
+	idx = zram_get_obj_size(zram, pps->index) / PP_BUCKET_SIZE_RANGE;
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
+	/* The higher the bucket id the more optimal slot post-processing is */
+	while (idx > 0) {
+		pps = list_first_entry_or_null(&ctl->pp_buckets[idx],
+					       struct zram_pp_slot,
+					       entry);
+		if (pps)
+			break;
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
@@ -1657,6 +1750,52 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 }
 
 #ifdef CONFIG_ZRAM_MULTI_COMP
+#define RECOMPRESS_IDLE		(1 << 0)
+#define RECOMPRESS_HUGE		(1 << 1)
+
+static int scan_slots_for_recompress(struct zram *zram, u32 mode,
+				     struct zram_pp_ctl *ctl)
+{
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	struct zram_pp_slot *pps = NULL;
+	unsigned long index;
+
+	for (index = 0; index < nr_pages; index++) {
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
+		if (mode & RECOMPRESS_IDLE &&
+		    !zram_test_flag(zram, index, ZRAM_IDLE))
+			goto next;
+
+		if (mode & RECOMPRESS_HUGE &&
+		    !zram_test_flag(zram, index, ZRAM_HUGE))
+			goto next;
+
+		if (zram_test_flag(zram, index, ZRAM_WB) ||
+		    zram_test_flag(zram, index, ZRAM_SAME) ||
+		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
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
 /*
  * This function will decompress (unless it's ZRAM_HUGE) the page and then
  * attempt to compress it using provided compression algorithm priority
@@ -1664,7 +1803,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
  *
  * Corresponding ZRAM slot should be locked.
  */
-static int zram_recompress(struct zram *zram, u32 index, struct page *page,
+static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 			   u64 *num_recomp_pages, u32 threshold, u32 prio,
 			   u32 prio_max)
 {
@@ -1807,20 +1946,17 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	return 0;
 }
 
-#define RECOMPRESS_IDLE		(1 << 0)
-#define RECOMPRESS_HUGE		(1 << 1)
-
 static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t len)
 {
 	u32 prio = ZRAM_SECONDARY_COMP, prio_max = ZRAM_MAX_COMPS;
 	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	char *args, *param, *val, *algo = NULL;
 	u64 num_recomp_pages = ULLONG_MAX;
+	struct zram_pp_ctl *ctl = NULL;
+	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
-	unsigned long index;
 	struct page *page;
 	ssize_t ret;
 
@@ -1922,36 +2058,32 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	ctl = init_pp_ctl();
+	if (!ctl) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
+
+	scan_slots_for_recompress(zram, mode, ctl);
+
 	ret = len;
-	for (index = 0; index < nr_pages; index++) {
+	while ((pps = select_pp_slot(ctl))) {
 		int err = 0;
 
 		if (!num_recomp_pages)
 			break;
 
-		zram_slot_lock(zram, index);
-
-		if (!zram_allocated(zram, index))
-			goto next;
-
-		if (mode & RECOMPRESS_IDLE &&
-		    !zram_test_flag(zram, index, ZRAM_IDLE))
+		zram_slot_lock(zram, pps->index);
+		if (!zram_test_flag(zram, pps->index, ZRAM_PP_SLOT))
 			goto next;
 
-		if (mode & RECOMPRESS_HUGE &&
-		    !zram_test_flag(zram, index, ZRAM_HUGE))
-			goto next;
-
-		if (zram_test_flag(zram, index, ZRAM_WB) ||
-		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
-		    zram_test_flag(zram, index, ZRAM_SAME) ||
-		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
-			goto next;
-
-		err = zram_recompress(zram, index, page, &num_recomp_pages,
-				      threshold, prio, prio_max);
+		err = recompress_slot(zram, pps->index, page,
+				      &num_recomp_pages, threshold,
+				      prio, prio_max);
 next:
-		zram_slot_unlock(zram, index);
+		zram_slot_unlock(zram, pps->index);
+		release_pp_slot(zram, pps);
+
 		if (err) {
 			ret = err;
 			break;
@@ -1963,6 +2095,7 @@ static ssize_t recompress_store(struct device *dev,
 	__free_page(page);
 
 release_init_lock:
+	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
 	return ret;
-- 
2.46.0.598.g6f2099f65c-goog


