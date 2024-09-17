Return-Path: <linux-kernel+bounces-331253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F83597AA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959A31C22FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A635D8F0;
	Tue, 17 Sep 2024 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ayXVTbQL"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610624B2F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726539040; cv=none; b=WejygIx/t+k/kci6mefPlwF90vq7EdrYzk0MUi9EX3pco2oA79DVwYP805LX5HIn2wdL7J51JoF3hk4HMDa3VzSH4T8IAzph4cOfg3u/7uL1sFz7F1l+WELY0J2UKdXL9gc9spxvoatuX0P58dgJ7m4BXBKwlOUCKKMypJgyUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726539040; c=relaxed/simple;
	bh=1UzoRtPzeopetqWERmEkqhfsk0wJWopivdLtREQqyrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEH5nrmTxaUAsK/48Q3o77dlbJ1HVS7tf1QKOAjkaqYo/LQmey87S90BP1hzboFW52T/lxVVM0Q1R06bQs9ClLDr6rlLVFhIJz/JCcOPrsWaWbdYu3KhvyM8Xz9F4PKOeUAyYLvPYvYXsg4Frq94ejj/HU6lBdnQo+hZzaDh0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ayXVTbQL; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso3492413a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726539038; x=1727143838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBc6EPDKjhft2m2bi15OmMhHi0RMJoaT8lbBvZ0sG/I=;
        b=ayXVTbQLxuWvR9Ys6jvRiKFOa/QF55UsCcGSpwwHFGJC/aO1pnQRsdcAdCNEckDWHQ
         tMiuh1rd8a3FgfDv2RdMFL7d+roMkePJEx8ma3OkUZcnFI/GzVa0dVpBKI5euDcfCV87
         zQKPJiYDSBvEqWNPEizh7qRaZ72gFZZYI0GP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726539038; x=1727143838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBc6EPDKjhft2m2bi15OmMhHi0RMJoaT8lbBvZ0sG/I=;
        b=g3tUJeA+Z835VoD2bwQ3/i5LtpfJ+e2du2iqIlaDAVprHReEN8KF98jExfqNViGWst
         s4H8OoC1mYq7n9z8vqqBAafe9uLVm8gxjzul/VVd1udGXsngGLWARTky8rtGM8y8zFKB
         qL7P+TmI/BYkZcTOwDi/Qua+1clciprWmfbjftefumwzi1R7M0L0DFWnB5C5OPtofE7L
         svno3lt4jNTIR44Ys/hFAIUNDEr41m8oSJzWc4ydGPyIxGWTE7iAssOyyuEyq5aQQdYq
         eJuqEFSRTBJpELwdsA89FTEVt7c7uUTZ1BeBu/lgUoS9kX4jG0Vclb92gc/tNEviDcUo
         HblA==
X-Gm-Message-State: AOJu0Yxe9aGQ3I88Q+RhSmOsFRrkccXwfVCFxl45ZYzwYLGVMuHAgTRv
	URYxwUmhNOlbmiVNpjK1KVnB7XE5QdVihYv01MNFPDl2pd9tbpLG20f4nGhCCQ==
X-Google-Smtp-Source: AGHT+IETYO4Ocoh32I6uhW1JZ1pxZIbZ1lkYt++qfRNt6XtWAGlO4NVcZuS/nmUqg58ToWfiaa0Cig==
X-Received: by 2002:a17:90b:1804:b0:2d4:924:8891 with SMTP id 98e67ed59e1d1-2dba008587emr17222522a91.38.1726539037517;
        Mon, 16 Sep 2024 19:10:37 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:693c:b4a9:5e6e:c397])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd9313fsm6037293a91.44.2024.09.16.19.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 19:10:37 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 4/7] zram: rework writeback target selection strategy
Date: Tue, 17 Sep 2024 11:09:09 +0900
Message-ID: <20240917021020.883356-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240917021020.883356-1-senozhatsky@chromium.org>
References: <20240917021020.883356-1-senozhatsky@chromium.org>
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
2.46.0.662.g92d0881bb0-goog


