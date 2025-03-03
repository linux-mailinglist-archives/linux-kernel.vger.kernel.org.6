Return-Path: <linux-kernel+bounces-540881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DE6A4B610
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7C1188EBF6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710FC1DB958;
	Mon,  3 Mar 2025 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DAJrhxB9"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850519CD07
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968720; cv=none; b=NEc6SREPHxUrDqlbDjXB4XGVpe0KFW2rlVbp4c43RndWcnvziUoH5fLvJ/39lu7ZhzkewOO4ly7+zwRGOmq1dubQQqNgTtf/90V8ANDfz3IVzH7P274tjHdN5IWJnIs0lp8b3XC/RrcGCowoDnl4DsQDkvuOJyScc+5TesCBA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968720; c=relaxed/simple;
	bh=eBUSVGGrh1XSgDzgF0DRhjlLomM6rB+SwQkemEOuOno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzwca3OgBRQ/GpQH+Zyn+/UnVWFNPzeYAd0Wn2fEunHXMEnUlyhcxyAzJaHgimiYNsdQithnZ9atCku7nDWwLwsF3FowKFvVYbjMW+m9Qdz38uNdH/Q+uc7zL+4JHDsiusQ84i/XHDnZlke81eYkQT7hPOV3TKBwr0uBFjWOHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DAJrhxB9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22355618fd9so63391275ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968718; x=1741573518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTrj6AIBGg3fen5fqcQqiq+dr13fIgG4uK8Ep+QAN48=;
        b=DAJrhxB9lgMm8nG6qS92LV88CKydbKKooIMnBQtlgLDgV2JFforERRHJDk7a7q/M/j
         RTBeRx0CNGmCNlRILMv4MdVUBlHKWPLXnDGVl5c/0xCOzdrvm/7CmqL/T0jc0X1OX062
         ee4CokoRXTPqiH6KGFRnWK1LMYOJp5m7RERQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968718; x=1741573518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTrj6AIBGg3fen5fqcQqiq+dr13fIgG4uK8Ep+QAN48=;
        b=SmakPFp3S2dVK4lWfYv2Zty4tI7DUCn8nvCBO3VUvHMiQBmaaB0a/luvjKAdOjNFCn
         kh1k6++ct3Zm2++32pR8wyWEuq6Rk47yYs1KxORQeuNPLeiGPGdMv0VP/leVxzX1Fw7w
         rOGDwDjuD4sOpklp3ZFV5oz5C2TuvG33vfP6+EK1c2DKtZcMLrO4AR/9cjuIF7FYvdf5
         +MkA9VRSvo7K+ZsehKSA72ZUtJtG8OvA/OcT70m61/nLViJ90SesF4ICQLDkOGYhyjC0
         jj4XB3irGVRFYCA4AKqmpUsKCNrUFl+wFr+HCFu9rhGa4Y7VrYUd/M5lgKxStOs5TPwj
         UJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGEk7QFQtboGmT/4ebs/4+nFohOQoqlkgwzfO/BHZJ7JL7e9dgkboToCkz4xDzl6LwVJU4PhBwv34q4d4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5tvpgfOd2O+Mj4mVB7Ejpi3Dz1uNjUBmzPYfUkkhwVX8+c6n
	X1WFeaS6kr9ciogbsE30SOJb14bxm5ZbHE8ZYA948ygHo0SaTOzroEYJa8qAyQ==
X-Gm-Gg: ASbGnctwqRGibp8VIPBRXJrJnGlQz0IG+1G/ZaJQPyQf37S2fKE0vCMFEdtwWlGAnyy
	4b0JTNd2sgSZ8J7x2CKh/fw0gBBRgdSMgin9RRRuSnKkNBJoBUig/LiG9YhBdm7CyUp1V3NaQjQ
	u6cvvHAIosavqzirf9zkhl9XLCfCkcdUuADWwSS8TMzkbsaqYHegmnEb3DO5nrg8is4i5w4wrNJ
	L05w/9XcuyB8UQNh2u0VzgMze4yszNoyfvCqqSqajbHPeAoWWaHQrNk8tr5WVHtOEoyuDMDhOTy
	uuYNn9g3HAANIDXl9lJbxjaEI+4r7bQVctr7KI+EfkHcIzA=
X-Google-Smtp-Source: AGHT+IH8tkcTWEOl7teGtIH3prNMr9e6TjPXzSkEQyQdyulF5O353ekND1QrhJUZq9VyBdS7SHU/9A==
X-Received: by 2002:a05:6a00:4f96:b0:736:51ab:7ae1 with SMTP id d2e1a72fcca58-73651ab7b97mr3452819b3a.16.1740968718515;
        Sun, 02 Mar 2025 18:25:18 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7363f62117asm2509047b3a.57.2025.03.02.18.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:18 -0800 (PST)
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
Subject: [PATCH v10 09/19] zram: filter out recomp targets based on priority
Date: Mon,  3 Mar 2025 11:03:18 +0900
Message-ID: <20250303022425.285971-10-senozhatsky@chromium.org>
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

Do no select for post processing slots that are already
compressed with same or higher priority compression
algorithm.

This should save some memory, as previously we would still
put those entries into corresponding post-processing buckets
and filter them out later in recompress_slot().

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 776c31606eec..6dee885bef9b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1823,7 +1823,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 #define RECOMPRESS_IDLE		(1 << 0)
 #define RECOMPRESS_HUGE		(1 << 1)
 
-static int scan_slots_for_recompress(struct zram *zram, u32 mode,
+static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 				     struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
@@ -1855,6 +1855,10 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode,
 		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
+		/* Already compressed with same of higher priority */
+		if (zram_get_priority(zram, index) + 1 >= prio_max)
+			goto next;
+
 		pps->index = index;
 		place_pp_slot(zram, ctl, pps);
 		pps = NULL;
@@ -1911,6 +1915,16 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	zram_clear_flag(zram, index, ZRAM_IDLE);
 
 	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
+
+	prio = max(prio, zram_get_priority(zram, index) + 1);
+	/*
+	 * Recompression slots scan should not select slots that are
+	 * already compressed with a higher priority algorithm, but
+	 * just in case
+	 */
+	if (prio >= prio_max)
+		return 0;
+
 	/*
 	 * Iterate the secondary comp algorithms list (in order of priority)
 	 * and try to recompress the page.
@@ -1919,13 +1933,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (!zram->comps[prio])
 			continue;
 
-		/*
-		 * Skip if the object is already re-compressed with a higher
-		 * priority algorithm (or same algorithm).
-		 */
-		if (prio <= zram_get_priority(zram, index))
-			continue;
-
 		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
@@ -2150,7 +2157,7 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	scan_slots_for_recompress(zram, mode, ctl);
+	scan_slots_for_recompress(zram, mode, prio_max, ctl);
 
 	ret = len;
 	while ((pps = select_pp_slot(ctl))) {
-- 
2.48.1.711.g2feabab25a-goog


