Return-Path: <linux-kernel+bounces-318149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1393696E8F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928251F24FBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2CC537F5;
	Fri,  6 Sep 2024 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHq9ZGdN"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5C84A2F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599118; cv=none; b=ch1NUmo9Qt2HUBQHudPxNfgVvA9wBK1NCoEa0VbScp+VgSgtfwu86dOMwsH6vaZjag8Eeb4Yutt1nl6gJrbj47UzfJJdmUS0b0ndT1WyxAJPGCk4eUu1VMuRw2NRG1L60DI7zHBQrrtjLWbF6XSmfGWoJBWBfPK4iYp2fj/kItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599118; c=relaxed/simple;
	bh=QImJ8qaRyCo+k0QgL0DgOIIwB0AEZezG5UL9Ki3GdBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhO+VKlSBd8W7cdpxGeyGfSVpkEzGodiKKIhv/UqhtHzDgh3vwbcp1kLE3ACx/oHc3EeFXl9/LtdVCnJn22QfI7UicvVOCahE72CyGm+ELoZZiyC8GkzuezGfNT7MXxMapE/Abe1HaDr9wWf2wA8pzYrkvAL4OJvD+VI0QSA3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lHq9ZGdN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-205909af9b5so13213755ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 22:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725599116; x=1726203916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efpeBpzdJwCGbL9UxsrmspisTsqwmCT+5046ZO3ZQyc=;
        b=lHq9ZGdNUWwtAIGCQP9TKS7y1in8vLaNiHZLZzytlciNEbsVpHkBzjWE22I3q7yqtf
         JwTU+5mCXibBClzsHrCqLyrom+/cIIKmIGE2qR212UKihef6Vlitrx/yNIMzImKefMIR
         vcIZC4jJJd1KrJbJHOsub7LpHf/S9dCgXWmbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725599116; x=1726203916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efpeBpzdJwCGbL9UxsrmspisTsqwmCT+5046ZO3ZQyc=;
        b=RYfCeyLFsk+BFeQCU/9aDW7Fihb3YlhZ/zKHYD+nctU5PQlaBBHbEYntPe4dpKXsO5
         k87I8XTM//NRRBJFo2ykTc3VyU1oMXtijHTnMe2HgWQ3jozCCjM0kTq7UPZcFFsQ2il9
         OoSj9q5NqtYSnjkB133g00ZrwMPwhiPNXFqII/k9RhHSCJjH/XnUaf7iUQjbVDVeZ2HX
         0ZJ4+k1GdvBf6DRwwunjiwtifTehjDrDMHW6ZCebpGwf9YiB+xvApc2WSESoYJNaDKT1
         vRZ6iIkRemCMgab+EcqtzAcnIXtVVo/M74RqNerkoAqkQL4ZHNTTOShYE85Kh5T6kTFZ
         uJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWppPOosBTPHSp4Fx+CXPStngedcXNnWF/dWzect+U/mE5V6Ce2i+mP+jBweyyq7BVgAPiqgU0yvwaBowk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZckQVUxDl27sHpN/TqI1nSX71SwXt5jBrYC49jHoj0xYnM8s
	uIQD8zb4+kngJTc4GnpeIqIS4lp2oCA5IqSEtnauiEX43kYi/P1Xt7pa4lQTkg==
X-Google-Smtp-Source: AGHT+IHNQg9uyWFybNP4d643lhm39klwtx51yeO7bDOyGC2mPF46MuyE/7860Tjjd7JLk2j7ZhUN7w==
X-Received: by 2002:a17:902:f54f:b0:1fb:57e7:5bb4 with SMTP id d9443c01a7336-206f05afd72mr13855425ad.37.1725599115773;
        Thu, 05 Sep 2024 22:05:15 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8eb7:9f7e:1b0e:95db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae90f3a2sm36252945ad.38.2024.09.05.22.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 22:05:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 2/3] zram: rework recompress target selection strategy
Date: Fri,  6 Sep 2024 14:04:46 +0900
Message-ID: <20240906050501.2494686-3-senozhatsky@chromium.org>
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
structure which holds 16 pp buckets of slots.  Slots are
assigned to a particular group based on their sizes - the
larger the size of the slot the higher the group index.
This, basically, sorts slots by size in liner time (we still
perform just one iteration over zram->table slots).  When
we select slot for recompression we always first lookup in
higher pp buckets (those that hold the largest slots).
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
... 2826 2861 2829 2989 2713 2583 2698 2685 2748 2617 ...

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 194 +++++++++++++++++++++++++++++-----
 1 file changed, 166 insertions(+), 28 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c91fdf399d1b..ebc3381fb2ac 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -659,8 +659,9 @@ static ssize_t writeback_store(struct device *dev,
 			goto next;
 
 		if (zram_test_flag(zram, index, ZRAM_WB) ||
-				zram_test_flag(zram, index, ZRAM_SAME) ||
-				zram_test_flag(zram, index, ZRAM_UNDER_WB))
+		    zram_test_flag(zram, index, ZRAM_SAME) ||
+		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
+		    zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
 
 		if (mode & IDLE_WRITEBACK &&
@@ -1648,6 +1649,126 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 }
 
 #ifdef CONFIG_ZRAM_MULTI_COMP
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
+		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
+		    zram_test_flag(zram, index, ZRAM_PP_SLOT) ||
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
@@ -1655,7 +1776,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
  *
  * Corresponding ZRAM slot should be locked.
  */
-static int zram_recompress(struct zram *zram, u32 index, struct page *page,
+static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 			   u64 *num_recomp_pages, u32 threshold, u32 prio,
 			   u32 prio_max)
 {
@@ -1675,6 +1796,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 		return -EINVAL;
 
 	comp_len_old = zram_get_obj_size(zram, index);
+
 	/*
 	 * Do not recompress objects that are already "small enough".
 	 */
@@ -1798,8 +1920,28 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	return 0;
 }
 
-#define RECOMPRESS_IDLE		(1 << 0)
-#define RECOMPRESS_HUGE		(1 << 1)
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
 
 static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
@@ -1807,11 +1949,11 @@ static ssize_t recompress_store(struct device *dev,
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
 
@@ -1907,36 +2049,31 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	ctl = init_pp_ctl();
+	if (!ctl) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
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
-			goto next;
-
-		if (mode & RECOMPRESS_HUGE &&
-		    !zram_test_flag(zram, index, ZRAM_HUGE))
+		zram_slot_lock(zram, pps->index);
+		if (!zram_test_flag(zram, pps->index, ZRAM_PP_SLOT))
 			goto next;
 
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
@@ -1948,6 +2085,7 @@ static ssize_t recompress_store(struct device *dev,
 	__free_page(page);
 
 release_init_lock:
+	release_pp_ctl(zram, ctl);
 	up_read(&zram->init_lock);
 	return ret;
 }
-- 
2.46.0.469.g59c65b2a67-goog


