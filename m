Return-Path: <linux-kernel+bounces-191739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC268D1378
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2BC1C215BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B801D68F;
	Tue, 28 May 2024 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea3D8alt"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114D2940D;
	Tue, 28 May 2024 04:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870890; cv=none; b=jJj3n9025Ly/8+ED9Rk3if/GXVe/u+eJ2iVd2Ekz6C4vaui4xVy2YgoEikG+4cBS/2Rrn/CBPESkuAp3oOHdeLw8KH39RE2wa3Lpm/akY8IES10VoF9R4649cdcFLdt+2nWMxcBbV+G/qMkSikVO7o1H4CvtWG5ZhGzKH2CmRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870890; c=relaxed/simple;
	bh=Sq6pyFcbELCx5LPO9zDGYL7eEOzI7MRS4T9tymOkNd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISO6OxOmaQhc/2om8pw65tXtVbmKKPC6ShHdoOuvKaQOlq/DM5Wy9qsfsrFMqtIv7Rf9x6HOCr/vjRFx0U25VeB3xCYPCv5FxX56c+p9QG4EmZUY404VU7rs0Gx5R01uHmCUpTez8V7kXlCcjBPd4NJW2FlKd5z/I+Hss+7Xujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea3D8alt; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b96a781b63so184262eaf.1;
        Mon, 27 May 2024 21:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716870888; x=1717475688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5YtUenkWYqRuj/8vIRZQcV5VdqpUv/GG6aiR2ClnWI=;
        b=Ea3D8altVaf6/QDmKzbYcAqz+Jb7F3QzIyQMuSDJIkkrQG3Dz+a8uvlEkJvv+dRR+B
         jGJxCOBTULs+0jVEACf9WHf+YisBnMki/qgvfTD6HKt26/1Ng8EWB5QWoBp7I//9Cl8c
         5NXL5bYNiXjP6CezG1vi+BSGwNYyohCpEg1e50TItL6yBZsiUGCLujrOaUUnnalEsMFO
         F+GBsbIQsXnMGV3rL6Q/4Z/fFHjVhSAvAFRPj3HLqwfffXtc8RaEejyp3PBfpV+wYIPc
         mKfDZuSHhuX8vhlkIOYK9pFzDt0L4qOQJEpmD+IZgsPYZzo5HLZrliwKh2Z7GkCvra63
         RSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716870888; x=1717475688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5YtUenkWYqRuj/8vIRZQcV5VdqpUv/GG6aiR2ClnWI=;
        b=iFMhkjbjggeS5uJ6Z8tX5ty0c+8wdq3OROaEvLa+f2daNv7H5xhxfG+yTlMyVX3JBZ
         IEYwO60qJOXRSdjOl4DC+xAg6JgnGX7SRELkup5O4CrOakQVkFNyo2YoF9TSUL9R71e3
         NmabqT98mdR3mmffclAxlddmU8TUEmo6xdteYJb4/o+hBYAWoxMRkcgsu0HE3v6HxJ5L
         sIEH6YY0ZJw7WqvbPyyuO2FbBuItOQzJVZWIrKd2xNRQL6PVnAVoZK86OiOFPbXUJ4ww
         YMH22LUxJApZqo+X2orFZeqDYLJhw17GC1hXE48/XPklFXxz4mLtjaeYURObjoG5FLHL
         BRNw==
X-Forwarded-Encrypted: i=1; AJvYcCV7++wLpYcvQ3rCkG6YKcSh++Mg2L+kkJNVvDFZLIv6mr/yCeZqkVsX30yU5eSxFVxsvXcITVR1uKEnHGfWfbu1nVWYStFJBZ9RqdGuBFkIOpkO560CUyPQ2h9FNzmZRyQEyTVIvZzo
X-Gm-Message-State: AOJu0YwY5+7I3jC3gQ5CiU8QwbNwoBjZCCn6ZB66YMyV51f+btTfxMa+
	pkrvdKOdfGxhxgHwduWFDrmprlxfqcGRGcVqxGmpHWYo2lXcwuZM
X-Google-Smtp-Source: AGHT+IEA5dpWIDmAdAoZnZYsMSO/exqse9ObdcYrZsrnAfhtP9a2MtPabAeewk8HJFO0ba4xb3Sn6A==
X-Received: by 2002:a05:6871:590:b0:24f:e6a4:991e with SMTP id 586e51a60fabf-24fe6a4d0c3mr6179100fac.6.1716870887574;
        Mon, 27 May 2024 21:34:47 -0700 (PDT)
Received: from cbuild.srv.usb0.net (uw2.srv.usb0.net. [185.197.30.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d57b9sm5620036b3a.193.2024.05.27.21.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:34:47 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: flintglass@gmail.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: zswap: proactive shrinking before pool size limit is hit
Date: Tue, 28 May 2024 04:34:04 +0000
Message-ID: <20240528043404.39327-5-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528043404.39327-2-flintglass@gmail.com>
References: <20240528043404.39327-2-flintglass@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements proactive shrinking of zswap pool before the max
pool size limit is reached. This also changes zswap to accept new pages
while the shrinker is running.

To prevent zswap from rejecting new pages and incurring latency when
zswap is full, this patch queues the global shrinker by a pool usage
threshold at the middle of 100% and accept_thr_percent, instead of the
max pool size.  The pool size will be controlled between 90% to 95% for
the default accept_thr_percent=90.  Since the current global shrinker
continues to shrink until accept_thr_percent, we do not need to maintain
the hysteresis variable tracking the pool limit overage in
zswap_store().

Before this patch, zswap rejected pages while the shrinker is running
without incrementing zswap_pool_limit_hit counter. It could be a reason
why zswap writethrough new pages before writeback old pages.  With this
patch, zswap accepts new pages while shrinking, and zswap increments
the counter when and only when zswap rejects pages by the max pool size.

The name of sysfs tunable accept_thr_percent is unchanged as it is still
the stop condition of the shrinker.
The respective documentation is updated to describe the new behavior.

Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 Documentation/admin-guide/mm/zswap.rst | 17 +++++----
 mm/zswap.c                             | 49 +++++++++++++++-----------
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 3598dcd7dbe7..a1d8f167a27a 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -111,18 +111,17 @@ checked if it is a same-value filled page before compressing it. If true, the
 compressed length of the page is set to zero and the pattern or same-filled
 value is stored.
 
-To prevent zswap from shrinking pool when zswap is full and there's a high
-pressure on swap (this will result in flipping pages in and out zswap pool
-without any real benefit but with a performance drop for the system), a
-special parameter has been introduced to implement a sort of hysteresis to
-refuse taking pages into zswap pool until it has sufficient space if the limit
-has been hit. To set the threshold at which zswap would start accepting pages
-again after it became full, use the sysfs ``accept_threshold_percent``
-attribute, e. g.::
+To prevent zswap from rejecting new pages and incurring latency when zswap is
+full, zswap initiates a worker called global shrinker that proactively evicts
+some pages from the pool to swap devices while the pool is reaching the limit.
+The global shrinker continues to evict pages until there is sufficient space to
+accept new pages. To control how many pages should remain in the pool, use the
+sysfs ``accept_threshold_percent`` attribute as a percentage of the max pool
+size, e. g.::
 
 	echo 80 > /sys/module/zswap/parameters/accept_threshold_percent
 
-Setting this parameter to 100 will disable the hysteresis.
+Setting this parameter to 100 will disable the proactive shrinking.
 
 Some users cannot tolerate the swapping that comes with zswap store failures
 and zswap writebacks. Swapping can be disabled entirely (without disabling
diff --git a/mm/zswap.c b/mm/zswap.c
index 08a6f5a6bf62..0186224be8fc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -71,8 +71,6 @@ static u64 zswap_reject_kmemcache_fail;
 
 /* Shrinker work queue */
 static struct workqueue_struct *shrink_wq;
-/* Pool limit was hit, we need to calm down */
-static bool zswap_pool_reached_full;
 
 /*********************************
 * tunables
@@ -118,7 +116,10 @@ module_param_cb(zpool, &zswap_zpool_param_ops, &zswap_zpool_type, 0644);
 static unsigned int zswap_max_pool_percent = 20;
 module_param_named(max_pool_percent, zswap_max_pool_percent, uint, 0644);
 
-/* The threshold for accepting new pages after the max_pool_percent was hit */
+/*
+ * The percentage of pool size that the global shrinker keeps in memory.
+ * It does not protect old pages from the dynamic shrinker.
+ */
 static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
 module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
 		   uint, 0644);
@@ -487,6 +488,14 @@ static unsigned long zswap_accept_thr_pages(void)
 	return zswap_max_pages() * zswap_accept_thr_percent / 100;
 }
 
+/*
+ * Returns threshold to start proactive global shrinking.
+ */
+static inline unsigned long zswap_shrink_start_pages(void)
+{
+	return zswap_max_pages() * (100 - (100 - zswap_accept_thr_percent)/2) / 100;
+}
+
 unsigned long zswap_total_pages(void)
 {
 	struct zswap_pool *pool;
@@ -504,21 +513,6 @@ unsigned long zswap_total_pages(void)
 	return total;
 }
 
-static bool zswap_check_limits(void)
-{
-	unsigned long cur_pages = zswap_total_pages();
-	unsigned long max_pages = zswap_max_pages();
-
-	if (cur_pages >= max_pages) {
-		zswap_pool_limit_hit++;
-		zswap_pool_reached_full = true;
-	} else if (zswap_pool_reached_full &&
-		   cur_pages <= zswap_accept_thr_pages()) {
-			zswap_pool_reached_full = false;
-	}
-	return zswap_pool_reached_full;
-}
-
 /*********************************
 * param callbacks
 **********************************/
@@ -1475,6 +1469,8 @@ bool zswap_store(struct folio *folio)
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	unsigned long value;
+	unsigned long cur_pages;
+	bool need_global_shrink = false;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1497,8 +1493,18 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	if (zswap_check_limits())
+	cur_pages = zswap_total_pages();
+
+	if (cur_pages >= zswap_max_pages()) {
+		zswap_pool_limit_hit++;
+		need_global_shrink = true;
 		goto reject;
+	}
+
+	/* schedule shrink for incoming pages */
+	if (cur_pages >= zswap_shrink_start_pages()
+			&& !work_pending(&zswap_shrink_work))
+		queue_work(shrink_wq, &zswap_shrink_work);
 
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
@@ -1541,6 +1547,9 @@ bool zswap_store(struct folio *folio)
 
 		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
 		zswap_reject_alloc_fail++;
+
+		/* reduce entry in array */
+		need_global_shrink = true;
 		goto store_failed;
 	}
 
@@ -1590,7 +1599,7 @@ bool zswap_store(struct folio *folio)
 	zswap_entry_cache_free(entry);
 reject:
 	obj_cgroup_put(objcg);
-	if (zswap_pool_reached_full)
+	if (need_global_shrink && !work_pending(&zswap_shrink_work))
 		queue_work(shrink_wq, &zswap_shrink_work);
 check_old:
 	/*
-- 
2.43.0


