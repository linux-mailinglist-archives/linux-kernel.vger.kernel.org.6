Return-Path: <linux-kernel+bounces-324398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F7974C00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A981C21EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1F14D6EE;
	Wed, 11 Sep 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mq1Q2dGu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348714A618
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041711; cv=none; b=czibFICQqipghu8UkYgcRfujJwB0WPYyaV8fAnycnXAENVkefd1vHGvYKNAVn0YRRQN8u2ctUXN6UgvWt9e1aHg+e1fSgRKlTxfj2n5JwtyjQd+czgwlbHKJGAnyIS2cJ04wqqVTmJr+a23w4Z4gYRY5IocVv12NlO0Dy7OFY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041711; c=relaxed/simple;
	bh=4LokRDtUC8nTDLjyNXXmw8PThG5ovYKVTg9qzeaQWQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxPbm6UrZrtLyjzQyyYVNeKnj8nquaHPg8UXnWQOQYOZq70o2/gL+bRnomUfB6gtsj0JX7WvlVbPL99DuNaZ8G/jIutLeYHTjkCPbAqtfzTELvVqD6qnFsyilr5xj3SSXkCTn5QzJ0i8gHanVFElO3aCLtp3rrnaaKUtiedrHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mq1Q2dGu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-205909af9b5so51501765ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726041709; x=1726646509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6AI1g9AMxN+gMC88Xf2+2IG4T4Gob9Vc2tmg27NW6g=;
        b=Mq1Q2dGuQcI54in6M5jMbeCrNUFWtZbMIaOz5X2wIubCUBrpRJUMiGW7rbmdiEQjPo
         mk2KjLZj22ry4DcsmdYgPSfwqszRvrU+FmrHg6izXCIOdRsF2DNxFLvUsUxO+N0p1HXn
         +XGzIZ/nhQGPIwkWjAane6r1cRSmbKPejREmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041709; x=1726646509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6AI1g9AMxN+gMC88Xf2+2IG4T4Gob9Vc2tmg27NW6g=;
        b=M3XQIk1HALPZa4KAJZy+jcsxq8X6DsuWsOQiwlxDaAOF+dB4jyfaD4cYBS2jxuBOXS
         VPR3p0pmtyuziGKS2lzkbNTEY0X47kQWUc18DDRuJfe2LS+IXQ/3sU5P54I3nfYGi7ll
         XOfYKfXLMtkyQydAYwmvOyyhMsg+HItUF0VR4R+Wk1vqSv8NuJykhA0ei0lrHnuFm1do
         2OJoFq5m5hAt/SSHU4JOzrJF5549b4czLHxFb0xGS6NTa4wfNUZJjsKnPbg/cw5UbZyK
         oggrg2b3yelxCcUiBge2Oi6+8HDpjGutSfa6ay0K3WGi6qZCpq1kZYlw08YuJwXM3UAn
         +eeQ==
X-Gm-Message-State: AOJu0YxIv83G08mF+hbL3P/+NI6s9i3L6t3WTMF/iijVde9W6aK98zi5
	guy11D+b0C0C1j27xD8WM0+eAsq1ECd3jquUZbHiLj5v5fRFbbhkL5sC3w+ue0kfq6RFXci/Wv8
	Oeg==
X-Google-Smtp-Source: AGHT+IHZaZmbSbzP7H4h6oxkhZTBl+Qal6cW99hdd9Wu2FustGel7H/11G9rSlFLDzv4UxgKt4rIog==
X-Received: by 2002:a17:902:ea04:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-2074c79c496mr54005575ad.56.1726041709172;
        Wed, 11 Sep 2024 01:01:49 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:d828:3442:b431:2762])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e37922sm58737795ad.110.2024.09.11.01.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:01:48 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 4/6] zram: rework writeback target selection strategy
Date: Wed, 11 Sep 2024 17:01:12 +0900
Message-ID: <20240911080130.3766632-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911080130.3766632-1-senozhatsky@chromium.org>
References: <20240911080130.3766632-1-senozhatsky@chromium.org>
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
index 222e2e74f0da..52cfd36769a6 100644
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


