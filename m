Return-Path: <linux-kernel+bounces-540883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48995A4B612
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B91188E397
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149581C84AA;
	Mon,  3 Mar 2025 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K+KMLpaJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B041DE882
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968731; cv=none; b=P6KlUgWT8zPtp8d8sdW7bn9BQAqmSeP402MXeGogRIW8LLoD7AbXe7A3yPwOoDcUYG5jXTnXr2xs5qyOPj2sPojB6R6GywVd8tSN3U2lckTyuq4xBSuhQtklNF8CACo+DAv7LYK4r+Lm4cw7eI95xnDynyJTPGwsZA1LBQnzZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968731; c=relaxed/simple;
	bh=NDKu3Rf24m5hNyNA1vH544UmtsqcvVbbfEpVOZRgTaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoEcZpSyWOQVpm2BIOaM3ss8L/+LWj4lJxeDC7Q3PuEc+yJtkd7GS1EA7Du3kOmpet2VP4iC8/We88P+rdaXXOwBlTLHqBFHRJZYRgvAenLL+sq0rZW9QjhSRryZmyKxn7g9+CVKrxDSgM7TUjbaThja2pAav7smnp9bzxTgEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K+KMLpaJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2234bec7192so48546795ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968728; x=1741573528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kGJl06ulFbB/829XkPkygYoBTQLBZ6+y+IJrZY3g6o=;
        b=K+KMLpaJEd10fiKp166BDRo18oqHxVbJb6lGxWA3EbvKlVj3lCH1ULiaECgONtYRas
         wNqJKIbsIGB0EC5GGqsV2V1wzpUCmm9G7fbIZ4uJTxJRMawffzI9P1diyDKWauCM7FsZ
         oh3xgv8UjzRoIJ9i4KkpdGNPThEe2T5WcAOWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968728; x=1741573528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kGJl06ulFbB/829XkPkygYoBTQLBZ6+y+IJrZY3g6o=;
        b=mWxkRQ62AVodflaDP2/WSA2NDnqnXlQS4U9SEkbrPfeW+iDFUILe12wn2P4JX6dVt3
         3ZcecIe1gBtq1N5BqCBSf9PIFHhP62Q9cxtzd03vTInViqykcjwNLHcfWjdZ20eIH1C2
         9OX5YeJEanto/Tg+Ww+XLNC8csXTA6y8RipXwkrxBSjr0XmaKG3ddiR3oeGInbKWSeQ4
         olFbghTX3LFgAcFu6cqga0saMgKHlyH17jl+1DJjOA447VTKVMchOdcoMFtGSwIo/WTo
         Z/tpr8ftTFFBp20HMV3++RAEYNCKVYAy1+qTgAvqEk2nCgJwdLtElLueAvN21WSXLDzc
         uPBg==
X-Forwarded-Encrypted: i=1; AJvYcCWOK29MQmw7dKXmZ9oY5ooCZX89VY5Tk8o94grRGgvyBUgjZKmswr4Z5Td3W8wHy/1Ux29gjzSKf2jaH40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTOBGJ738ZZ9dp0Gj7RbsePfp5/d1krJmeosijExkMeaDHecH
	xYv25u7sLbcz8HDXmq67DO8jXvKCQJx4hkhQbTP4Gd/vck1Q1+f/vXxcz5xubw==
X-Gm-Gg: ASbGncvRdCfVFQ1+tQdEQiatB4rteeFgJgKaLqIvsQCnemduj+5GcHi45EmFUWVFhXh
	Agrrx/nIII9R3Oe7KGK5kAhSqLQMLNVUQixP/Ey8aQU16RRZydhlTfjOjLXRVMXfvX3PTu50ydi
	S9E5XV5ZhFU4lg9dEU85ZYdfr8uE0JXOuXKlaq0Sx6RtXI1DtDikR17uTcC/6H96KP7m4yAOpTX
	+fkwIZM6ypOO6Vx7mZ/IHJ/6B6DZzuKtEQUnj6GXJIX4rz8lPpou4/ptxMBHrDW20JRVvHE2Pxt
	otyK0RrlT853VbdM9MLCAAwqdmemEHg+XZ6m05oa/dQrVFk=
X-Google-Smtp-Source: AGHT+IEugHIYcHEDUOXp58GXQB8o5prMjl8/tvIa3ET7IFiNu4ViKFsWk4lTQ15ZE884fzJ8YzuupA==
X-Received: by 2002:a17:903:198e:b0:220:d272:534d with SMTP id d9443c01a7336-22368f92a4dmr206219935ad.22.1740968727919;
        Sun, 02 Mar 2025 18:25:27 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504dc489sm66538975ad.159.2025.03.02.18.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:27 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v10 11/19] zram: move post-processing target allocation
Date: Mon,  3 Mar 2025 11:03:20 +0900
Message-ID: <20250303022425.285971-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303022425.285971-1-senozhatsky@chromium.org>
References: <20250303022425.285971-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate post-processing target in place_pp_slot().  This
simplifies scan_slots_for_writeback() and scan_slots_for_recompress()
loops because we don't need to track pps pointer state anymore.
Previously we have to explicitly NULL the point if it has been added
to a post-processing bucket or re-use previously allocated pointer
otherwise and make sure we don't leak the memory in the end.

We are also fine doing GFP_NOIO allocation, as post-processing can
be called under memory pressure so we better pick as many slots as
we can as soon as we can and start post-processing them, possibly
saving the memory.  Allocation failure there is not fatal, we will
post-process whatever we put into the buckets on previous
iterations.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 50 +++++++++++++++--------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bb88b63d193b..f6e887f94b71 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -295,15 +295,24 @@ static void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl)
 	kfree(ctl);
 }
 
-static void place_pp_slot(struct zram *zram, struct zram_pp_ctl *ctl,
-			  struct zram_pp_slot *pps)
+static bool place_pp_slot(struct zram *zram, struct zram_pp_ctl *ctl,
+			  u32 index)
 {
-	u32 idx;
+	struct zram_pp_slot *pps;
+	u32 bid;
+
+	pps = kmalloc(sizeof(*pps), GFP_NOIO | __GFP_NOWARN);
+	if (!pps)
+		return false;
 
-	idx = zram_get_obj_size(zram, pps->index) / PP_BUCKET_SIZE_RANGE;
-	list_add(&pps->entry, &ctl->pp_buckets[idx]);
+	INIT_LIST_HEAD(&pps->entry);
+	pps->index = index;
+
+	bid = zram_get_obj_size(zram, pps->index) / PP_BUCKET_SIZE_RANGE;
+	list_add(&pps->entry, &ctl->pp_buckets[bid]);
 
 	zram_set_flag(zram, pps->index, ZRAM_PP_SLOT);
+	return true;
 }
 
 static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
@@ -737,15 +746,8 @@ static int scan_slots_for_writeback(struct zram *zram, u32 mode,
 				    unsigned long index,
 				    struct zram_pp_ctl *ctl)
 {
-	struct zram_pp_slot *pps = NULL;
-
 	for (; nr_pages != 0; index++, nr_pages--) {
-		if (!pps)
-			pps = kmalloc(sizeof(*pps), GFP_KERNEL);
-		if (!pps)
-			return -ENOMEM;
-
-		INIT_LIST_HEAD(&pps->entry);
+		bool ok = true;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
@@ -765,14 +767,13 @@ static int scan_slots_for_writeback(struct zram *zram, u32 mode,
 		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
-		pps->index = index;
-		place_pp_slot(zram, ctl, pps);
-		pps = NULL;
+		ok = place_pp_slot(zram, ctl, index);
 next:
 		zram_slot_unlock(zram, index);
+		if (!ok)
+			break;
 	}
 
-	kfree(pps);
 	return 0;
 }
 
@@ -1827,16 +1828,10 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 				     struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct zram_pp_slot *pps = NULL;
 	unsigned long index;
 
 	for (index = 0; index < nr_pages; index++) {
-		if (!pps)
-			pps = kmalloc(sizeof(*pps), GFP_KERNEL);
-		if (!pps)
-			return -ENOMEM;
-
-		INIT_LIST_HEAD(&pps->entry);
+		bool ok = true;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
@@ -1859,14 +1854,13 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 		if (zram_get_priority(zram, index) + 1 >= prio_max)
 			goto next;
 
-		pps->index = index;
-		place_pp_slot(zram, ctl, pps);
-		pps = NULL;
+		ok = place_pp_slot(zram, ctl, index);
 next:
 		zram_slot_unlock(zram, index);
+		if (!ok)
+			break;
 	}
 
-	kfree(pps);
 	return 0;
 }
 
-- 
2.48.1.711.g2feabab25a-goog


