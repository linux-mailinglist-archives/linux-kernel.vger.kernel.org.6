Return-Path: <linux-kernel+bounces-320174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A09706FF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C871C2107C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07240158203;
	Sun,  8 Sep 2024 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HuZrwqYi"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834B15855F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795766; cv=none; b=u/HHF8aMqUPjKBR+Ht6q0ynf4YamMOZp79vOnWfEbWUTmDoAMlayTzC+qnLpHrogxGWr4GclSDIQPYcKPg6YbHlcmlU5EDu0NhWPZ/bIxwTrV0MDH+VQjuIRrI6y+yHEnuyyqlfd1e0WWAERZ9A78oGr1J9c+akKMg7b3Bzo7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795766; c=relaxed/simple;
	bh=tp6rTqQQAU4Ay9dSuWGPEHR6UMPSKC8Go5EZXmOpigE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbEoE1tOXrzX1L+QIYFke/+0+CXsGTMg6KmUm9rzLW+7zg58wXTyqs++uT113tnJo/wwAgw7UYtn6Y2Kt2pG6klrYN/PUpTbodsM99jOyvyFwanTcIsmztpvlECSzT2+oKV1U2DnxhbKi253bzSJLhfT8TqiZ/V6OJDRWGgCXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HuZrwqYi; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3df0a54623dso2147562b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725795763; x=1726400563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AspJWuawxjaqHf9bHwYmf6t2nWc/qRKC7B2AVEtY0Qo=;
        b=HuZrwqYitvOlhr0iHvA5RfG9qEcnHLHkA73U9o53UtZh13ese054AIr+IRrdPztXbx
         2jg3XLdKr3le3YdE07MZZgKUAlrvCFzodwF7OAFOK2Fq+ebl2lvdYQU7TOPTFOom+tBs
         CQshDO6PS+Zt1vYjoBLMiYnzhxvLknSuHDH9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795763; x=1726400563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AspJWuawxjaqHf9bHwYmf6t2nWc/qRKC7B2AVEtY0Qo=;
        b=PIyK15GMx3qQCXVQHXlu5dZZ8dGUBrmtbdmmzBIFUcuRkSDQj67JDKHtOUoVNKiVPq
         /2JG3iQbU7+KJrf9j48wlvfTAkrR3tvdCOuMvtCTHS+WfbDG/hZSKkh6Bcf/fcJZzkA3
         4XBjB85KxmJNgpQdYxrYUk+auC3nX8KBlDhYuPHRqyvMw9qPujrvvQFxVFsBRSaaF+k1
         iYVFWX1ZOIu+6iDFILxaE0COJVio883OmGw9J5LHd9lD9Rer54cRLDNbo6gRFHLXavP+
         2oa/iR+6nXYYKcBiRe7JnqjlxTy8WZMPfPhEo/DDRVf5goq5beaIgtF4CfCJxPeAoggn
         5EEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRi2J1OLvebL8mE9rxsmc6KEXWBaRt/wVEx83Qv/TxeZnIOHZuU1QEIkzzzgaxl33IUEFfaFK/IkoPb3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkodp6BV+C+KisOKFOuwHnllid+82c1rD6T1s6Zsfiev3opj0+
	TK1AKENGugCBIZ8/NW0n/eOO1+j76hbfn3ZuweFGqhYtj1xfilIc5Eq3Ei3AMg==
X-Google-Smtp-Source: AGHT+IFHMMtxoKuQmQBP5V6iLmMSspKYeLjyOIpV57Jvx6sPrcz/dLnOiPKr/Qbrwhf/28Du3VUmQw==
X-Received: by 2002:a05:6808:3c4b:b0:3d6:5791:a378 with SMTP id 5614622812f47-3e029ce5904mr8745490b6e.17.1725795763353;
        Sun, 08 Sep 2024 04:42:43 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5879:695a:4656:45ff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823cf3a2esm1923029a12.24.2024.09.08.04.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:42:42 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 2/3] zram: rework recompress target selection strategy
Date: Sun,  8 Sep 2024 20:42:02 +0900
Message-ID: <20240908114223.3024872-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240908114223.3024872-1-senozhatsky@chromium.org>
References: <20240908114223.3024872-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 191 +++++++++++++++++++++++++++++-----
 1 file changed, 163 insertions(+), 28 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a14aef6bf634..026e527ab17d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -184,6 +184,100 @@ static void zram_accessed(struct zram *zram, u32 index)
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
@@ -1650,6 +1744,54 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
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
@@ -1657,7 +1799,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
  *
  * Corresponding ZRAM slot should be locked.
  */
-static int zram_recompress(struct zram *zram, u32 index, struct page *page,
+static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 			   u64 *num_recomp_pages, u32 threshold, u32 prio,
 			   u32 prio_max)
 {
@@ -1677,6 +1819,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 		return -EINVAL;
 
 	comp_len_old = zram_get_obj_size(zram, index);
+
 	/*
 	 * Do not recompress objects that are already "small enough".
 	 */
@@ -1800,20 +1943,17 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
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
 
@@ -1909,37 +2049,31 @@ static ssize_t recompress_store(struct device *dev,
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
-		    zram_test_flag(zram, index, ZRAM_PP_SLOT) ||
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
@@ -1951,6 +2085,7 @@ static ssize_t recompress_store(struct device *dev,
 	__free_page(page);
 
 release_init_lock:
+	release_pp_ctl(zram, ctl);
 	up_read(&zram->init_lock);
 	return ret;
 }
-- 
2.46.0.469.g59c65b2a67-goog


