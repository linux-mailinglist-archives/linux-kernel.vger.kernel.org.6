Return-Path: <linux-kernel+bounces-315134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A8C96BE68
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E931C24F01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD941DA101;
	Wed,  4 Sep 2024 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MuZaDfTX"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B161E884
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456321; cv=none; b=nEeowZXG8trPAY1yOG/pdp1fDxBUmkb9MNZiSK8i+XUNIO5hEVgAKRA8Q03/ciQoMvRfZuzcAJ4F/AaLBY4haOSmPdVmGGExQuPADEqQ7yijo6bo9lWuaFFE1+f8jnQixdqPcO9xSgMQmhTJpqzIN36Rcu1HSifXXwdOq0Rk+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456321; c=relaxed/simple;
	bh=H51Ud3CZIyk+NjFn1860hGhDUtqgBzkBz8CLbDVsRPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWXfKPG3uk6m7OScmQGq+u1Rc92vGusYM+C9ygchsEIIiA1vfQNZLzbwsHtHZ165BxBXScT1MusqkKikx12CcEsb7S8xnOiA7RKOf+jBlLXM6ROFOuKnBozHTOxYM2rLe+FQSLBcDiwlEEFF9uKVZT6D9HLfhAb1uIlMbCfoqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MuZaDfTX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20573eb852aso5248215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725456319; x=1726061119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjfNYwgRmFwRyRd2A+1fxkz5SQc6AYOk84bCepgxx8I=;
        b=MuZaDfTX4x7XukJn9CBUUxq5GGQ6fATJiNwB1xc1IMjoCg4K2NfD6I5+sCtgAcYSPF
         czSB4xcxkKLjhfCnCc/wizGGo5yp1JD5gfVNy8Julm5kYVZz8pDvDr0VUInksXSuJHQ6
         orEcgJ7bVGvpt2grr32bShpbc3SCqQYNOPch0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456319; x=1726061119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjfNYwgRmFwRyRd2A+1fxkz5SQc6AYOk84bCepgxx8I=;
        b=NAPoOjvOMcUC1YObyifj1epd1ZYvwInLQ8M8xgz5Ryivn2Kj1/2wgzIDBwhC8JtpQT
         4C7qyOfHWOCAHOwMNKbpyahFIDLOKGs22e5qXRuI0LFYJLg7VGFq8pZalTjETxQN3dS1
         ebcCjj+GnkCYbf6PzasMln+tuYF0SKlTiOG1PVn9WEup++JXiVjiw7EENUVz4MsPZUH2
         TNBnQL6/Dns9CBxVAhbM5CqrzwReKnKy4iGT5QqsC2bkWHp17t8KVbdZR1PhGRjnTiP4
         5SKdKYvr+z8Kw1m7zr4SDyeDlkxkE2jsrMDsU/1tDm5V8hjM8pQULn2Rf35pLOfe/CGO
         nDew==
X-Forwarded-Encrypted: i=1; AJvYcCXN9hiCTOIWZ0TP78poBUMLtGM9uSGLfMDhE2aFu1x6ZjjJTFJ2JHb0aNwybw3tGvaQUV3Wfuuhr+TTnFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2gyhEsMGNXTO6VS9ZD2YLhqlGL3v11VSVfac78hrAEUzcP0Q
	j7eP9odmA2pTL9aKb/2BMG+AcsRn/qkGjxHD6sTKdWJf+A163RhJdYATdc196DAEr9upIxn7pav
	3Mw==
X-Google-Smtp-Source: AGHT+IG8Z6ty2uJavX/X05eo41F80ttboNTYucuMzQ+OVRdZYEfWed8fHP7XGePjyyqABwzDlQZk3w==
X-Received: by 2002:a17:902:e545:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-206b8341fdfmr38379035ad.15.1725456319545;
        Wed, 04 Sep 2024 06:25:19 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4132:a2a2:35bc:acba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea54e7bsm13479215ad.183.2024.09.04.06.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:25:19 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 2/3] zram: rework recompress target selection logic
Date: Wed,  4 Sep 2024 22:24:54 +0900
Message-ID: <20240904132508.2000743-3-senozhatsky@chromium.org>
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
structure which holds 16 groups of slots.  Slots are assigned
to a particular group based on their sizes - the larger the
size of the slot the higher the group index.  This, basically,
sorts slots by size in liner time (we still perform just one
iteration over zram->table slots).  When we select slot for
recompression we always first lookup in higher pp groups (those
that hold the largest slots).  Which achieves the desired
behavior.

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
 drivers/block/zram/zram_drv.c | 180 ++++++++++++++++++++++++++++------
 1 file changed, 152 insertions(+), 28 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c91fdf399d1b..998efe3979f8 100644
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
@@ -1648,6 +1649,115 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 }
 
 #ifdef CONFIG_ZRAM_MULTI_COMP
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
@@ -1655,7 +1765,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
  *
  * Corresponding ZRAM slot should be locked.
  */
-static int zram_recompress(struct zram *zram, u32 index, struct page *page,
+static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 			   u64 *num_recomp_pages, u32 threshold, u32 prio,
 			   u32 prio_max)
 {
@@ -1675,6 +1785,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 		return -EINVAL;
 
 	comp_len_old = zram_get_obj_size(zram, index);
+
 	/*
 	 * Do not recompress objects that are already "small enough".
 	 */
@@ -1798,8 +1909,28 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	return 0;
 }
 
-#define RECOMPRESS_IDLE		(1 << 0)
-#define RECOMPRESS_HUGE		(1 << 1)
+static struct zram_pp_slot *select_slot_for_recompress(struct zram_pp_ctl *ctl)
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
 
 static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
@@ -1807,14 +1938,16 @@ static ssize_t recompress_store(struct device *dev,
 {
 	u32 prio = ZRAM_SECONDARY_COMP, prio_max = ZRAM_MAX_COMPS;
 	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	char *args, *param, *val, *algo = NULL;
 	u64 num_recomp_pages = ULLONG_MAX;
+	struct zram_pp_slot *pps;
+	struct zram_pp_ctl ctl;
 	u32 mode = 0, threshold = 0;
-	unsigned long index;
 	struct page *page;
 	ssize_t ret;
 
+	init_pp_ctl(&ctl);
+
 	args = skip_spaces(buf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
@@ -1907,36 +2040,26 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	scan_slots_for_recompress(zram, mode, &ctl);
+
 	ret = len;
-	for (index = 0; index < nr_pages; index++) {
+	while ((pps = select_slot_for_recompress(&ctl))) {
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
-			goto next;
-
-		if (zram_test_flag(zram, index, ZRAM_WB) ||
-		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
-		    zram_test_flag(zram, index, ZRAM_SAME) ||
-		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+		zram_slot_lock(zram, pps->index);
+		if (!zram_test_flag(zram, pps->index, ZRAM_PP_SLOT))
 			goto next;
 
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
@@ -1948,6 +2071,7 @@ static ssize_t recompress_store(struct device *dev,
 	__free_page(page);
 
 release_init_lock:
+	release_pp_ctl(zram, &ctl);
 	up_read(&zram->init_lock);
 	return ret;
 }
-- 
2.46.0.469.g59c65b2a67-goog


