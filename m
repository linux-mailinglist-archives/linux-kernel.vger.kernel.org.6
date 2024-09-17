Return-Path: <linux-kernel+bounces-331256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3190B97AA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E6B1C27596
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC1F3C482;
	Tue, 17 Sep 2024 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dQHUZN0+"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801B136351
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726539046; cv=none; b=MQf8mk89oVUeynj+FFsc/bZtatw0/b+9A1DxBXCHdi0i3Gsfc0GNjYZL592CI3InlsBxBwrAccC/k7rn/mGfuamXB7JhAC8TUY/59KlstxJ9uedoajy4MVF2/VQV6W3HJr9h0lSAu/OthnXatZR8KBBZrovn3b9LKCH4/RHqH3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726539046; c=relaxed/simple;
	bh=q4Xj0yUTh7FBoCT9cnIh139VqB03+wo1CTmdLv5xp7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWyo9dRT+U/lqw18PgexvTmcGLPwMX43aHYf4PfLLJMZVf/+kZXROUYnjpoMawXCm1H2RBJII9NReizaYjbfM+uSSqD7j0PEDvgKdl9q6+xgVJQELklhcmpGIuXuJXUcN+l20Mgtw+FJ8Wkytu2iFjltZhXlS60coisK/WkCjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dQHUZN0+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d87a1f0791so2672760a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726539044; x=1727143844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNimCjKQs/wejmpMYdUz38JPWuuYnJKQPKUcavQwiVg=;
        b=dQHUZN0+i5R4Mc5C68rdV27wkFVN99rLbHiUHZWQe7xPqP7Jt6rRsK4yeclVR003Wn
         HjYE2wu/UMIUvJzclYXgzW2tPQF2puxisThYGiwqZPhyMv209PWde4pDYoVSyaCPJSQa
         h6wtdjZmwff+z0lyE2hj0BQi8kZHxx8zHEyAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726539044; x=1727143844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNimCjKQs/wejmpMYdUz38JPWuuYnJKQPKUcavQwiVg=;
        b=XyBF9cfUtpYhaeWqDLyXzP+sis7kNo8FU0jw4Z+VUqPB0Bn8rP6orQaoFo+kMKtRkX
         xY52PJ/MVp0nfMjucqqRW/gjdH88gyLju6COgDkso1He3X7Ea4Yg4bhByW05+s3eh5xe
         nX81suLShhyDsFFJRT2G1VZcJOElrkRrv3c0edujPQmoEQyOkCexOXdq0XNUI+4Ev0/h
         WqB0IsG9KzC2qnnV1gghcfRh0G8ltlwraqkFpFNkCAsbk9SJGYMOX8yRFEoeuqUbWd4S
         4tWtyPr0fZiFt637EFReLQX1A3D6BNwwbrWcey3r6Eph0NoQhEwyK4/xdUD4l+Xm9s0t
         Up+g==
X-Gm-Message-State: AOJu0YwP5V1IYepGpqSJMyE9pXaljTt2Cf8mcKFTbr7lWD/2YMSOennv
	oo+Xrag0BcBoH/iDWzESH+D8RANF9VIL6TQw2e0PvDzWnbE2JKSgXuB7Qxl6Bg==
X-Google-Smtp-Source: AGHT+IHBYNBS+pXL9JgW1C5lPmU6MOzTHbb3cQsnM6y1w47vPQHBI+WwJNz8c/aIkMYhnRLoxhs+GQ==
X-Received: by 2002:a17:90a:c395:b0:2d3:caeb:a9ad with SMTP id 98e67ed59e1d1-2dbb9f34e80mr15912452a91.31.1726539044166;
        Mon, 16 Sep 2024 19:10:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:693c:b4a9:5e6e:c397])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd9313fsm6037293a91.44.2024.09.16.19.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 19:10:43 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 7/7] zram: remove UNDER_WB and simplify writeback
Date: Tue, 17 Sep 2024 11:09:12 +0900
Message-ID: <20240917021020.883356-8-senozhatsky@chromium.org>
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

We now have only one active post-processing at any time, so
we don't have same race conditions that we had before.  If
slot selected for post-processing gets freed or freed and
reallocated it loses its PP_SLOT flag and there is no way
for such a slot to gain PP_SLOT flag again until current
post-processing terminates.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 53 +++++++++++------------------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8f01dc1fc796..69458f8afe7a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -390,10 +390,7 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 
 	for (index = 0; index < nr_pages; index++) {
 		/*
-		 * Do not mark ZRAM_UNDER_WB slot as ZRAM_IDLE to close race.
-		 * See the comment in writeback_store.
-		 *
-		 * Also do not mark ZRAM_SAME slots as ZRAM_IDLE, because no
+		 * Do not mark ZRAM_SAME slots as ZRAM_IDLE, because no
 		 * post-processing (recompress, writeback) happens to the
 		 * ZRAM_SAME slot.
 		 *
@@ -402,7 +399,6 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index) ||
 		    zram_test_flag(zram, index, ZRAM_WB) ||
-		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
 		    zram_test_flag(zram, index, ZRAM_SAME)) {
 			zram_slot_unlock(zram, index);
 			continue;
@@ -821,22 +817,17 @@ static ssize_t writeback_store(struct device *dev,
 
 		index = pps->index;
 		zram_slot_lock(zram, index);
-		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
-			goto next;
 		/*
-		 * Clearing ZRAM_UNDER_WB is duty of caller.
-		 * IOW, zram_free_page never clear it.
+		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
+		 * slots can change in the meantime. If slots are accessed or
+		 * freed they lose ZRAM_PP_SLOT flag and hence we don't
+		 * post-process them.
 		 */
-		zram_set_flag(zram, index, ZRAM_UNDER_WB);
-		/* Need for hugepage writeback racing */
-		zram_set_flag(zram, index, ZRAM_IDLE);
+		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
+			goto next;
 		zram_slot_unlock(zram, index);
-		if (zram_read_page(zram, page, index, NULL)) {
-			zram_slot_lock(zram, index);
-			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-			zram_clear_flag(zram, index, ZRAM_IDLE);
-			zram_slot_unlock(zram, index);
 
+		if (zram_read_page(zram, page, index, NULL)) {
 			release_pp_slot(zram, pps);
 			continue;
 		}
@@ -852,11 +843,6 @@ static ssize_t writeback_store(struct device *dev,
 		 */
 		err = submit_bio_wait(&bio);
 		if (err) {
-			zram_slot_lock(zram, index);
-			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-			zram_clear_flag(zram, index, ZRAM_IDLE);
-			zram_slot_unlock(zram, index);
-
 			release_pp_slot(zram, pps);
 			/*
 			 * BIO errors are not fatal, we continue and simply
@@ -871,25 +857,19 @@ static ssize_t writeback_store(struct device *dev,
 		}
 
 		atomic64_inc(&zram->stats.bd_writes);
+		zram_slot_lock(zram, index);
 		/*
-		 * We released zram_slot_lock so need to check if the slot was
-		 * changed. If there is freeing for the slot, we can catch it
-		 * easily by zram_allocated.
-		 * A subtle case is the slot is freed/reallocated/marked as
-		 * ZRAM_IDLE again. To close the race, idle_store doesn't
-		 * mark ZRAM_IDLE once it found the slot was ZRAM_UNDER_WB.
-		 * Thus, we could close the race by checking ZRAM_IDLE bit.
+		 * Same as above, we release slot lock during writeback so
+		 * slot can change under us: slot_free() or slot_free() and
+		 * reallocation (zram_write_page()). In both cases slot loses
+		 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
+		 * ZRAM_PP_SLOT on such slots until current post-processing
+		 * finishes.
 		 */
-		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index) ||
-			  !zram_test_flag(zram, index, ZRAM_IDLE)) {
-			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-			zram_clear_flag(zram, index, ZRAM_IDLE);
+		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-		}
 
 		zram_free_page(zram, index);
-		zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 		zram_set_flag(zram, index, ZRAM_WB);
 		zram_set_element(zram, index, blk_idx);
 		blk_idx = 0;
@@ -1538,7 +1518,6 @@ static void zram_free_page(struct zram *zram, size_t index)
 	atomic64_dec(&zram->stats.pages_stored);
 	zram_set_handle(zram, index, 0);
 	zram_set_obj_size(zram, index, 0);
-	WARN_ON_ONCE(zram->table[index].flags & ~(1UL << ZRAM_UNDER_WB));
 }
 
 /*
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 73a9d47d76ba..134be414e210 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -47,7 +47,6 @@
 enum zram_pageflags {
 	ZRAM_SAME = ZRAM_FLAG_SHIFT,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
-	ZRAM_UNDER_WB,	/* page is under writeback */
 	ZRAM_PP_SLOT,	/* Selected for post-processing */
 	ZRAM_HUGE,	/* Incompressible page */
 	ZRAM_IDLE,	/* not accessed page since last idle marking */
-- 
2.46.0.662.g92d0881bb0-goog


