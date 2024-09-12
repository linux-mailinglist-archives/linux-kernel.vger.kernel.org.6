Return-Path: <linux-kernel+bounces-326068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB42C976219
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CB41F23D83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93418E349;
	Thu, 12 Sep 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dHNkcg95"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE0818C920
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124676; cv=none; b=Hrzkv76vaQxnOny9DotXEyyL4iLxA3DHRAdDojizx53ygN9PCpKR1ZZRvU3wL7kG/Ima1emdkesIbjL3eXvjNhox4RvKuBd+cd2KdosG6oYSE2P0ZrDS8GR0BQ/2VKxIjLsJ4pwQ3YEcm9U+sLWds7wtQbMMj+xaPtqa9OBCmW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124676; c=relaxed/simple;
	bh=JRLRXgyQqo6xYv+WAjtOW/iCMpNcasMB/RXY7828h68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmdJ7AHUAxgK1JjIRGzymIUYRcB9Fv0iAlDfNQQzhcoUbLMj6ZhC4iSrUSXl26gkDQ+nTCi8j7fuLiNH2P3H6Xdcgo2aiArHWSDzWvluo/3XWl5PcLWdoeVD94A1BalNa5XJz/rQmJByhomNB4Np0QONAhg1ZgBbhYsH+9htQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dHNkcg95; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2054e22ce3fso7034165ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726124673; x=1726729473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUUG9N1lEhl3OV7ZgcZTdELGeL30tImYKIZa/xNBV7o=;
        b=dHNkcg95HIg9ylgNLF8WmTxt4iFJYJi1ZMfwEIAvx+V6PP4f9KnXaPgqDXbN5i7ZxG
         u1QRkLuRNjMe1NzkDMqYYphwEKy0mYcWC/i9FUB2K4lKP4MoI/yPkPD8I3tJlxd+hncJ
         Sq/Cp1Tz6L+jFl5rUprTmQZKhkwz+N4aGjbHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726124673; x=1726729473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUUG9N1lEhl3OV7ZgcZTdELGeL30tImYKIZa/xNBV7o=;
        b=QIgXSMH6rlznpHKLreNSemIMndcGeZTlVA1Ymz6BfxHvEIkTSXA9wZKBrzZcvtpTAv
         LAVtyN8qAC0Aqp24dT/jPDDM9JNflLbX0YdX0cIGyd0/wcygpN4b3HKbjbiKZti7oW5Z
         jVKIV090I18f7AqGtWVYkSyomuEuNQzF32C+EvJxlaRwtDNc3nKR0LpbN3L/olpzo3HH
         llN3JxYT3hORlYjY7BO5M4YVdjsMw/YQuYrDkqhGaAkCRlgwESoR+74SI/0BvThWz15A
         TCKb/4DXRAKtepeuBxVTVXMSZZsJUftSRiCQwr7T9da2PGJfsIBScnHy8iIl5jv/XpZX
         OXgg==
X-Gm-Message-State: AOJu0YykSjJvvIyfzSBVsCGpTLuDdgQ08R0H1UAwKAqhONcWmBnW8uzt
	3SjlKG7wQ2awbwLOwYw0tFu7wNI+EklvsbPDGc8Cd4VWIa6g1IPWc9j+zliw3Q==
X-Google-Smtp-Source: AGHT+IGHKU6bIxwpDal5Gc9HvLXRfjOUaJyo/V427lSJ+H6KcbsvLVA6//YtNRJ1bvmOCDlAce7MTw==
X-Received: by 2002:a05:6a20:b598:b0:1cf:2858:be5b with SMTP id adf61e73a8af0-1cf764c44b1mr1946403637.50.1726124673386;
        Thu, 12 Sep 2024 00:04:33 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:2fb2:d683:de5d:c3cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5a23sm1101543a12.31.2024.09.12.00.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:04:33 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 4/6] zram: rework writeback target selection strategy
Date: Thu, 12 Sep 2024 16:02:19 +0900
Message-ID: <20240912070413.4179924-5-senozhatsky@chromium.org>
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
... 3667 3580 3581 3580 3581 3581 3581 3231 3211 3203 3231 3246 ...

Note, pp-slots are not strictly sorted, there is a PP_BUCKET_SIZE_RANGE
variation of sizes within particular bucket.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 83 +++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6688f70b2140..8ba994a5f30e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -184,7 +184,7 @@ static void zram_accessed(struct zram *zram, u32 index)
 #endif
 }
 
-#ifdef CONFIG_ZRAM_MULTI_COMP
+#if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
 struct zram_pp_slot {
 	unsigned long		index;
 	struct list_head	entry;
@@ -681,11 +681,57 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
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
+		    zram_test_flag(zram, index, ZRAM_SAME))
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
@@ -737,7 +783,15 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	for (; nr_pages != 0; index++, nr_pages--) {
+	ctl = init_pp_ctl();
+	if (!ctl) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
+
+	scan_slots_for_writeback(zram, mode, nr_pages, index, ctl);
+
+	while ((pps = select_pp_slot(ctl))) {
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			spin_unlock(&zram->wb_limit_lock);
@@ -754,25 +808,10 @@ static ssize_t writeback_store(struct device *dev,
 			}
 		}
 
+		index = pps->index;
 		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index))
-			goto next;
-
-		if (zram_test_flag(zram, index, ZRAM_WB) ||
-				zram_test_flag(zram, index, ZRAM_SAME) ||
-				zram_test_flag(zram, index, ZRAM_UNDER_WB))
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
+		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-
 		/*
 		 * Clearing ZRAM_UNDER_WB is duty of caller.
 		 * IOW, zram_free_page never clear it.
@@ -786,6 +825,8 @@ static ssize_t writeback_store(struct device *dev,
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			zram_slot_unlock(zram, index);
+
+			release_pp_slot(zram, pps);
 			continue;
 		}
 
@@ -804,6 +845,8 @@ static ssize_t writeback_store(struct device *dev,
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			zram_slot_unlock(zram, index);
+
+			release_pp_slot(zram, pps);
 			/*
 			 * BIO errors are not fatal, we continue and simply
 			 * attempt to writeback the remaining objects (pages).
@@ -846,12 +889,14 @@ static ssize_t writeback_store(struct device *dev,
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
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
 
-- 
2.46.0.598.g6f2099f65c-goog


