Return-Path: <linux-kernel+bounces-320175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECB8970700
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD5E1F219CE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F4C15A873;
	Sun,  8 Sep 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h1sh07l0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95673158D8F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795768; cv=none; b=AqWOlPWUywAu+aIcGhu4xUHRZk6aaQLmDd1ouy/HzkrbEnTtaAT3eHoVjoAKSYyWxkr3SbLK7CTjbxZdqwquDWu9yRTMzpZF6T2/c/XOUDdgbHIJ6J4pGSuc8nnA5ZBcVeE20585hp18MiY7xERV5oAXmKOB/QWlxCjGcJ7opA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795768; c=relaxed/simple;
	bh=uB2P6UdqMe2nA8UbgN/fT//xtZdaOt0IJFABGdRXRq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9hgbiDIMynNWyExHU8UsM2sSdp2erqaFmAyfyeag7rvAGmB1tRp/ftDbkfB6DY5iwZV14YPQKTgQrALPIDFADPBYZhOARGSGSbAHoPtdmkIqivx2oAx0PYPzdjYo7dpjOrL3xnuGhh2TERQdwqEyF7jugqLBb2C1b+LG4hYUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h1sh07l0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718d606726cso1574000b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725795766; x=1726400566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TkuowECJ5u49hZzXfADAw0z+4PgfCTTtJrp7ALFdMU=;
        b=h1sh07l0yUqRYZxf4eJ6TtcAUQpgKJiDdJbycd5iwI1Wmg1QsQYvVSMD+7fDDLolxt
         5K+2KftRWvtKA5Oo8ABsbJjAvyjUcNAVKrqZsjPOSdVCdI6fayTtL/ng8s8XjAkUD7RQ
         Ku+npI6T6WoDToHGYsTH5khJfEflpzpBYQKzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795766; x=1726400566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TkuowECJ5u49hZzXfADAw0z+4PgfCTTtJrp7ALFdMU=;
        b=UA1aWoOoFbRmWAnb6yVsSC+SuGgzQSIN+KCfwo9S8SoBQOHQhNmNxChv27F6ez0qb7
         yj/L2e01CZEP2QREPHVq9NEBA+ifZ5yW62ebLjNnaQJ5N/T8+F5jJbRNIZbSHj4i9ka4
         mAfI3kHQOTxqtUDjpFJrmkEgcC+kehTNQYJ0cRSe+fdsUlBeqCXIKieXbLNitrANGab0
         Yp6eqkvydSRYb9bmo4bPTDu1arrPynJOkcPVENK91SGUu59LCH3j+0oQdIK7MpxofQjF
         qwowhxzmDrQuq8EASQxd935LNWjBUC7E9uWJhWm9lspl7MC5K3UOebHi1PSuDIsHtJHd
         GiNg==
X-Forwarded-Encrypted: i=1; AJvYcCW8fVWcTFWymeh3x8rSXaP9qUbcfYeFHldypLIk5b3bSwhseqQGPJ5wKgEyO3N2SIdRB18acU+zuEX3Kt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoR3P5Rj6aabCiO7yl6sPT3ea2V5ifk+bCdOL8rP1nCa/YggoM
	ZvNExoy1TYtbsDs5nliIs/+6Qk4ao3ZixzJi5DRmI5LhiDUVdP7bcZwaUxCvVg==
X-Google-Smtp-Source: AGHT+IEg5WmRyNMnxMybT5B3YUy42OkXfObdvnmTOJP2nrr4O5qM0PIP4wOHo8+mFs0N3QC0XY61sA==
X-Received: by 2002:a05:6a21:392:b0:1cc:e55b:6892 with SMTP id adf61e73a8af0-1cf1d1ed9a9mr8176596637.47.1725795765799;
        Sun, 08 Sep 2024 04:42:45 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5879:695a:4656:45ff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823cf3a2esm1923029a12.24.2024.09.08.04.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:42:45 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 3/3] zram: rework writeback target selection strategy
Date: Sun,  8 Sep 2024 20:42:03 +0900
Message-ID: <20240908114223.3024872-4-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 88 +++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 026e527ab17d..d0da6bb4be79 100644
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
@@ -682,11 +682,59 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
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
+		    zram_test_flag(zram, index, ZRAM_PP_SLOT) ||
+		    zram_test_flag(zram, index, ZRAM_UNDER_WB))
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
@@ -732,11 +780,19 @@ static ssize_t writeback_store(struct device *dev,
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
@@ -745,30 +801,15 @@ static ssize_t writeback_store(struct device *dev,
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
-		    zram_test_flag(zram, index, ZRAM_PP_SLOT) ||
-		    zram_test_flag(zram, index, ZRAM_UNDER_WB))
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
@@ -777,11 +818,14 @@ static ssize_t writeback_store(struct device *dev,
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
 
@@ -800,6 +844,8 @@ static ssize_t writeback_store(struct device *dev,
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			zram_slot_unlock(zram, index);
+
+			release_pp_slot(zram, pps);
 			/*
 			 * BIO errors are not fatal, we continue and simply
 			 * attempt to writeback the remaining objects (pages).
@@ -842,12 +888,14 @@ static ssize_t writeback_store(struct device *dev,
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
-- 
2.46.0.469.g59c65b2a67-goog


