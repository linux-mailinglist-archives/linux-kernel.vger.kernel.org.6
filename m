Return-Path: <linux-kernel+bounces-320182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA897070F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C212B21881
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDB015C141;
	Sun,  8 Sep 2024 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HgKNbhCH"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F115B57B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795956; cv=none; b=ZAd0mbAixuCdJKLk5syGYDT7FSI64fjID4/J6g/3KI8VOH34VVzPJPi8URat2rCv4SZLMvW0hMD3VQrVbl7qhwTC5Htv/Gn4gE5gPMTCglszTCxLyu2NKm4dcKnEftSNhO63OBtvQAh+zz0PXe+jmRQrGcL/aa9bfin5aowtZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795956; c=relaxed/simple;
	bh=uB2P6UdqMe2nA8UbgN/fT//xtZdaOt0IJFABGdRXRq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYEGj6XQlLYPppOvXZNzkh0u80Z1BZxfTyPZGk7ZbUK+ZZ+sLWb/00rK3j78E9nFN0q5855Gj2xFQ8FOdDptt92lV9Ce7k6VJ0UCSa7iHa6n9z8PCZT29oEXGfzQbUUTx4Qd9uiWtIutYtrl8fNiwVC2eCmn8KfbOQ3ADy4RbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HgKNbhCH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d5119d6fedso1843502a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725795954; x=1726400754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TkuowECJ5u49hZzXfADAw0z+4PgfCTTtJrp7ALFdMU=;
        b=HgKNbhCHZ+41rEFecSLReLZjiNVVqmvteF7W0HQoTHfKMFpH6HYyod/nBePpbuQyIK
         O1Ds7Fm/+GO2dizCgRFE+04xZwq/mIn/1nwK/guJT365r65A077jSp2s7bU3T/WSCVaH
         vz/gG6ruCvuogfbdYn0WlA5nojt0UpOwnzAe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795954; x=1726400754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TkuowECJ5u49hZzXfADAw0z+4PgfCTTtJrp7ALFdMU=;
        b=e9BOpyH685AlUrbkkvFM4ZghoFZBRTt0KeT7hpi/6/CKtCIjTQG/+qTkubo/MvTlM7
         X61SJ1AgjgtQRMNy2M5BTcaEmfvxD1ZYtkhzuwBPvVWJ35RHlGqhmXpGw0k+Jcyt/rT8
         bWHYzzXxeeYtEeM4J2HNSDneOcNAxCa5tUITDpEzF1h2v3v+rxDpbm3yHrdzHn/rMAS5
         YlPVtGtUKYIlMde1aTN1+1WRqXnywGAO2sr3XcO1Wc9I4ateeNp98vMqNd4cXmOxaOjy
         DVy6LiekAJIsQgz4YXdOIlMBKhW1cgnPcY+HsqbuWpIEk0ZGlV194ZJf7CSvIGvPINZL
         yQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuFe3nzSFTzYkGMPay6wSWgIEB/35TFqp3AieAiMBqT+8/4bYjd0XUnbF4tlR/RTI5HqAceVjEGoTFUt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQFV7+rjY9MfWUHsiCHwZahO5FR6USEGbBwpzsoCYGkT0jYAq
	r9lSAs2xqJgGPijdGxxeawJOV2Ko11RRXwhx5ScDYFEqbQW9Tg0PwvI1BuQn7EMxyb11DS70HCS
	XPw==
X-Google-Smtp-Source: AGHT+IE8XsxAXi0cTjPyhLmz7O05gh6buTnRETpN0O8/1b0sz2HAGnJL0Z3N6hiHvNKkWD7zzpKumw==
X-Received: by 2002:a17:902:d4cb:b0:206:a027:8acd with SMTP id d9443c01a7336-206b7ce74f6mr239947625ad.2.1725795954011;
        Sun, 08 Sep 2024 04:45:54 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5879:695a:4656:45ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1f3f6sm19087065ad.226.2024.09.08.04.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:45:53 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 3/3] zram: rework writeback target selection strategy
Date: Sun,  8 Sep 2024 20:45:13 +0900
Message-ID: <20240908114541.3025351-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240908114541.3025351-1-senozhatsky@chromium.org>
References: <20240908114541.3025351-1-senozhatsky@chromium.org>
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


