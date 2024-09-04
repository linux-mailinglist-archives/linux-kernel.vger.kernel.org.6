Return-Path: <linux-kernel+bounces-315135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FDC96BE69
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A75A1F23A26
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EFA1DA63E;
	Wed,  4 Sep 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n6yajirE"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86B21CF7D3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456324; cv=none; b=XGHmthBAbFzs8G2M2Oc+DRgql3OijuL/LphjresPUTlbK5WXzPYg94oB2QtUDpf1xYsYzdVVBODFMgM3Y8Qh1AF2CHYss9lBArJmIyNctnW2kGFc8i33EX2xJTjn55NaNBRRzAyLnCR8D+aip7qsthLaq8TpvcjA20rL5sUdOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456324; c=relaxed/simple;
	bh=wr+/UN933hxfG0zMVwK11X/rvLKg7fjaLJgJGXHA2H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX83AObWy/JDpxS8ZltuFwGpshxf87Szb6KVc40EcplbPG05gst7FDQJTZevb5qf6b9M8S/zK7Za3jwEdzmDFLcNWz4Z2OxAS3B7KaDIQtI86R2vdtd3BIp7/xjjI1ITnoqmhms2jks07iZi7DZN3/zguEwCw6XEqGN55Atc5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n6yajirE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2068bee21d8so7569045ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725456322; x=1726061122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6qxoe3/9WaKoQVJeWn4sgJsVVarYIXJHNnVXrp/W9E=;
        b=n6yajirE1w4snPb3GtvSuSig+yc/iDEp5v7RmVjViTc/ffjVb4cTYlqlIEXLnrPD8H
         5Z33EJKgy5h5v4kIPOu7tXK4GKDW9qR4+KHiSJwKAtnDaaZ2mh5qoJ6opGRdpVhTEhzV
         Siv2uwMDvoLhgPXl7IX/aZk2cTzCrR4wairME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456322; x=1726061122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6qxoe3/9WaKoQVJeWn4sgJsVVarYIXJHNnVXrp/W9E=;
        b=t2Vr8I1eg1M4B6mgAvbyWcq9XXwx40dBlWnWJe8qbSoy0Ddb2KqtPX4idsAIc1H2IA
         1bR60bqhZ9aWGm/gC3OQ9+3G6c94qRi5PMyx9goGWnLCUp7vNIKruUqEqt7H0eVRCBNP
         HwZQE+XY2hnPHevzxLBAAbS7VGTGaIG+1NPCtrT9Mpugcd5rWRruI4P+f97Jb9ZUF7Gy
         38azHgC+0YwmHkbzpLh0nN34zIcPetT3BFFqU2lvXK4bECGbaqUBvCuT+fnrGkcn7nTW
         YKGVuwoOAGzlRj8IdIe9CVuuTCFE1CuD46oytyI6nunj3wQBwU1tChdb9lKELhRhgnng
         32Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWby6cm7lhJkrRdSph4zgwixA6O5FiI5Uw7k2qXgwkiF0dQ4fmwiXyeTmZFjNYPtta6MhgnKMZ/TvvaefQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUOZV134G4W3zwLKd/3Nqry15UFCLOEKYRVOgILWUZLbIGTTT
	IHoJnOjpMQfuEjuPlQX2C7llpHFLNruxVbJMecmXKAYECBViPdRwNXXpngyQNsxdEqneVclE9yZ
	uqg==
X-Google-Smtp-Source: AGHT+IEqaJfa1bx2FH/AFFwIlk2P2dyzO/eROM/s8fgOPSyspj8JJmbnpg/sjA2rPxZTR7VQ6GbESQ==
X-Received: by 2002:a17:902:e5c4:b0:205:43b8:1aa4 with SMTP id d9443c01a7336-20543b81d7amr138950405ad.19.1725456322050;
        Wed, 04 Sep 2024 06:25:22 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4132:a2a2:35bc:acba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea54e7bsm13479215ad.183.2024.09.04.06.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:25:21 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 3/3] zram: rework writeback target selection logic
Date: Wed,  4 Sep 2024 22:24:55 +0900
Message-ID: <20240904132508.2000743-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240904132508.2000743-1-senozhatsky@chromium.org>
References: <20240904132508.2000743-1-senozhatsky@chromium.org>
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
because then each writeback will relase the largest amount
of memory.

This patch applies the same solution and strategy as for
recompression target selection: pp control (post-process)
with 16 groups of candidate pp slots. Slots are assigned to
pp groups based on sizes - the larger the slot the higher the
group index.  This gives us sorted by size lists of candidate
slots (in linear time), so that among candidate slots we always
select the largest ones first.

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
 drivers/block/zram/zram_drv.c | 232 ++++++++++++++++++++++------------
 1 file changed, 151 insertions(+), 81 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 998efe3979f8..a384939b2501 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -183,6 +183,69 @@ static void zram_accessed(struct zram *zram, u32 index)
 #endif
 }
 
+#if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
+struct zram_pp_slot {
+	unsigned long		index;
+	struct list_head	entry;
+};
+
+#define NUM_PP_GROUPS		17
+
+struct zram_pp_ctl {
+	struct list_head slots[NUM_PP_GROUPS];
+};
+
+static void init_pp_ctl(struct zram_pp_ctl *ctl)
+{
+	u32 idx;
+
+	for (idx = 0; idx < NUM_PP_GROUPS; idx++)
+		INIT_LIST_HEAD(&ctl->slots[idx]);
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
+	for (idx = 0; idx < NUM_PP_GROUPS; idx++) {
+		while (!list_empty(&ctl->slots[idx])) {
+			struct zram_pp_slot *pps;
+
+			pps = list_first_entry(&ctl->slots[idx],
+					       struct zram_pp_slot,
+					       entry);
+			list_del_init(&pps->entry);
+			release_pp_slot(zram, pps);
+		}
+	}
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
+	diff = PAGE_SIZE / (NUM_PP_GROUPS - 1);
+	idx = zram_get_obj_size(zram, pps->index) / diff;
+	list_add(&pps->entry, &ctl->slots[idx]);
+
+	zram_set_flag(zram, pps->index, ZRAM_PP_SLOT);
+}
+#endif
+
 static inline void update_used_max(struct zram *zram,
 					const unsigned long pages)
 {
@@ -587,11 +650,82 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
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
+static struct zram_pp_slot *select_slot_for_writeback(struct zram_pp_ctl *ctl)
+{
+	struct zram_pp_slot *pps = NULL;
+	s32 idx = NUM_PP_GROUPS - 1;
+
+	/*
+	 * Select PP-slots starting from the highest group, which should
+	 * give us the best candidate for recompression.
+	 */
+	while(idx > 0) {
+		pps = list_first_entry_or_null(&ctl->slots[idx],
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
+
 static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	struct zram_pp_slot *pps;
+	struct zram_pp_ctl ctl;
 	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
@@ -600,6 +734,8 @@ static ssize_t writeback_store(struct device *dev,
 	int mode, err;
 	unsigned long blk_idx = 0;
 
+	init_pp_ctl(&ctl);
+
 	if (sysfs_streq(buf, "idle"))
 		mode = IDLE_WRITEBACK;
 	else if (sysfs_streq(buf, "huge"))
@@ -637,11 +773,14 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	for (; nr_pages != 0; index++, nr_pages--) {
+	scan_slots_for_writeback(zram, mode, nr_pages, index, &ctl);
+
+	while ((pps = select_slot_for_writeback(&ctl))) {
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			spin_unlock(&zram->wb_limit_lock);
 			ret = -EIO;
+			release_pp_slot(zram, pps);
 			break;
 		}
 		spin_unlock(&zram->wb_limit_lock);
@@ -650,30 +789,15 @@ static ssize_t writeback_store(struct device *dev,
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
+		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-
-		if (zram_test_flag(zram, index, ZRAM_WB) ||
-		    zram_test_flag(zram, index, ZRAM_SAME) ||
-		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
-		    zram_test_flag(zram, index, ZRAM_PP_SLOT))
-			goto next;
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
@@ -682,11 +806,14 @@ static ssize_t writeback_store(struct device *dev,
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
 
@@ -705,6 +832,8 @@ static ssize_t writeback_store(struct device *dev,
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			zram_slot_unlock(zram, index);
+
+			release_pp_slot(zram, pps);
 			/*
 			 * BIO errors are not fatal, we continue and simply
 			 * attempt to writeback the remaining objects (pages).
@@ -729,7 +858,7 @@ static ssize_t writeback_store(struct device *dev,
 		 */
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index) ||
-			  !zram_test_flag(zram, index, ZRAM_IDLE)) {
+		    !zram_test_flag(zram, index, ZRAM_IDLE)) {
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			goto next;
@@ -747,12 +876,14 @@ static ssize_t writeback_store(struct device *dev,
 		spin_unlock(&zram->wb_limit_lock);
 next:
 		zram_slot_unlock(zram, index);
+		release_pp_slot(zram, pps);
 	}
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
 	__free_page(page);
 release_init_lock:
+	release_pp_ctl(zram, &ctl);
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1649,67 +1780,6 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 }
 
 #ifdef CONFIG_ZRAM_MULTI_COMP
-struct zram_pp_slot {
-	unsigned long		index;
-	struct list_head	entry;
-};
-
-#define NUM_PP_GROUPS		17
-
-struct zram_pp_ctl {
-	struct list_head slots[NUM_PP_GROUPS];
-};
-
-static void init_pp_ctl(struct zram_pp_ctl *ctl)
-{
-	u32 idx;
-
-	for (idx = 0; idx < NUM_PP_GROUPS; idx++)
-		INIT_LIST_HEAD(&ctl->slots[idx]);
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
-	for (idx = 0; idx < NUM_PP_GROUPS; idx++) {
-		while (!list_empty(&ctl->slots[idx])) {
-			struct zram_pp_slot *pps;
-
-			pps = list_first_entry(&ctl->slots[idx],
-					       struct zram_pp_slot,
-					       entry);
-			list_del_init(&pps->entry);
-			release_pp_slot(zram, pps);
-		}
-	}
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
-	diff = PAGE_SIZE / (NUM_PP_GROUPS - 1);
-	idx = zram_get_obj_size(zram, pps->index) / diff;
-	list_add(&pps->entry, &ctl->slots[idx]);
-
-	zram_set_flag(zram, pps->index, ZRAM_PP_SLOT);
-}
-
 #define RECOMPRESS_IDLE		(1 << 0)
 #define RECOMPRESS_HUGE		(1 << 1)
 
-- 
2.46.0.469.g59c65b2a67-goog


