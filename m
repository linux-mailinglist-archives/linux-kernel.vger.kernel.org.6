Return-Path: <linux-kernel+bounces-242999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F41892900B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566FC2844C9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3357A18EA8;
	Sat,  6 Jul 2024 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgRYYdmJ"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43941799D;
	Sat,  6 Jul 2024 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720232745; cv=none; b=fjq8eXlFyAntX+dG007t9FpKTeRjStgOU/psQfWp19VsUFFMjtk43+cpAMC4H3eMHGtEnNJfVXmEZ9KOoopPDe2JJrnVUI3g5EWpwHh4Md5W7UaUUnhFCphkixASmBfjgCs3IoDMo1gfxf3kIEj0viRW7iJXpFqkpa8u0JVodNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720232745; c=relaxed/simple;
	bh=MuYY+sgekLMmkU6tu2vBpS+/5oGt9w8n4YIpe9ukXqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngI0C4z1guWl9EVQE+5QRtzCTltmFRt/XK+efWyAxFpxRx+MezAVF11kES1hP3VbF8yJcThZyYvr3+qft3myK4dkUjxKg6alvLyIblBc5+uMs3pEeZNqe2LiN1KZK+J5FJrrjl1xRupslfZ9dLDyLXQnF3otmaSmR9zqxbBCqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgRYYdmJ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9cc681ee0so1096583b6e.0;
        Fri, 05 Jul 2024 19:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720232742; x=1720837542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gbNL02p4FBXJkqp2c2S8rGsyHnbj9iQKIebrJKExW4=;
        b=BgRYYdmJl/cArSeeE2FtkJRfyk67mGPWpGKsIHDZqOw5BNbUSR6g71Gs9e5sIsFekM
         XvadSaAq3Y9yCrGFua9pEvSlJNuKab0wE3GV1yv4SvWAbwykA9Kw9URN1SxLzBpiVf3p
         y6+C6yBgKp/GT+ItcexAWsiispefQWn4JRqny/iWSAHN3OfJ+0JdjQHaH2P/ygxljuP8
         GTvXOTolQOsTmUR7nJAYt5w5w4MByy76Kj2jQtciNeMGmUKGlE1ExjQOF/mNE9K4qPYP
         W/iruFvLJ19kibXocbFm+YrUTBzrXhXmxmUiODRwgXY0fsADf2J/53HOBYaqHwddwQ1H
         lZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720232742; x=1720837542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gbNL02p4FBXJkqp2c2S8rGsyHnbj9iQKIebrJKExW4=;
        b=M4RfqME4VSGNveOndqfF4uaK6om7N1ulKj/W0cQJhGRb8IcFbnFZZ0/jV4wp9nSYen
         +l62/R73IvguGWvCa9qbS9j/Y7NsIGRpV9n5iscBCyesvcGfUJmGmuZSWQHOYQV4lazp
         EUmvUbDaqSgtyxDXIE0AcURimL8ykQkcO3lOwPtw3pPuA9ZiAmq2tAIKji3QD3i98/g0
         TPsDE1boe/1Srq9yFjSMxreBU2IqMzC/e6kUOaeXIfytyRDCkZ8gT5ruHS6Qw/DYNY0l
         OFsyEIOhi2VYegLZ1k+4kUHkhXuhkwEajQ1J7l1c5Uq+m6AlN9L0vcJlVOUZ68qfiMvR
         x3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNukhoj3le5faCk2QJKfD6EEufWKo3SV4zR+Zyr2iTP0xDntiv0MgSwX5Iy+Or6BDoR0cVsXw2JC/PP+GJYeJTk4lhdPUW8d6SfCt/WQboKO36Lq6zYmUnm9LLSmd7wjE3RuRB1CAZ
X-Gm-Message-State: AOJu0YxXABUq35CPLSPEiGeI8PsJ8J1zAPaw2G8BfBNWDNyDtQ7wBsD8
	ghsRdv0Sgykmzd+oIo2DoHNWu9bNbpkvr7uHBCYi9PQ4/GBSPeAW
X-Google-Smtp-Source: AGHT+IEm7hpJxWUrO+4pHoriMk4Pq9rnFJ3uJllIplvLoEm52TyWCtZ/2L3QtpFAoWc3zaPgZlkb2A==
X-Received: by 2002:a05:6808:158b:b0:3d5:6595:7b41 with SMTP id 5614622812f47-3d914c50384mr7403679b6e.5.1720232742555;
        Fri, 05 Jul 2024 19:25:42 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b15417a7bsm971274b3a.205.2024.07.05.19.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 19:25:42 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] mm: zswap: proactive shrinking before pool size limit is hit
Date: Sat,  6 Jul 2024 02:25:19 +0000
Message-ID: <20240706022523.1104080-4-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706022523.1104080-1-flintglass@gmail.com>
References: <20240706022523.1104080-1-flintglass@gmail.com>
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
threshold between 100% and accept_thr_percent, instead of the max pool
size.  The pool size will be controlled between 90% to 91% for the
default accept_thr_percent=90.  Since the current global shrinker
continues to shrink until accept_thr_percent, we do not need to maintain
the hysteresis variable tracking the pool limit overage in
zswap_store().

Before this patch, zswap rejected pages while the shrinker is running
without incrementing zswap_pool_limit_hit counter. It could be a reason
why zswap writethrough new pages before writeback old pages.  With this
patch, zswap accepts new pages while shrinking, and zswap increments
the counter when and only when zswap rejects pages by the max pool size.

Now, reclaims smaller than the proactive shrinking amount finish
instantly and trigger background shrinking.  Admins can check if new
pages are buffered by zswap by monitoring the pool_limit_hit counter.

The name of sysfs tunable accept_thr_percent is unchanged as it is still
the stop condition of the shrinker.
The respective documentation is updated to describe the new behavior.

Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 Documentation/admin-guide/mm/zswap.rst | 17 ++++----
 mm/zswap.c                             | 54 ++++++++++++++++----------
 2 files changed, 42 insertions(+), 29 deletions(-)

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
index f092932e652b..24acbab44e7a 100644
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
@@ -488,6 +489,20 @@ static unsigned long zswap_accept_thr_pages(void)
 	return zswap_max_pages() * zswap_accept_thr_percent / 100;
 }
 
+/*
+ * Returns threshold to start proactive global shrinking.
+ */
+static inline unsigned long zswap_shrink_start_pages(void)
+{
+	/*
+	 * Shrinker will evict pages to the accept threshold.
+	 * We add 1% to not schedule shrinker too frequently
+	 * for small swapout.
+	 */
+	return zswap_max_pages() *
+		min(100, zswap_accept_thr_percent + 1) / 100;
+}
+
 unsigned long zswap_total_pages(void)
 {
 	struct zswap_pool *pool;
@@ -505,21 +520,6 @@ unsigned long zswap_total_pages(void)
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
@@ -1489,6 +1489,8 @@ bool zswap_store(struct folio *folio)
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	unsigned long value;
+	unsigned long cur_pages;
+	bool need_global_shrink = false;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1511,8 +1513,17 @@ bool zswap_store(struct folio *folio)
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
+	if (cur_pages >= zswap_shrink_start_pages())
+		queue_work(shrink_wq, &zswap_shrink_work);
 
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
@@ -1555,6 +1566,9 @@ bool zswap_store(struct folio *folio)
 
 		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
 		zswap_reject_alloc_fail++;
+
+		/* reduce entry in array */
+		need_global_shrink = true;
 		goto store_failed;
 	}
 
@@ -1604,7 +1618,7 @@ bool zswap_store(struct folio *folio)
 	zswap_entry_cache_free(entry);
 reject:
 	obj_cgroup_put(objcg);
-	if (zswap_pool_reached_full)
+	if (need_global_shrink)
 		queue_work(shrink_wq, &zswap_shrink_work);
 check_old:
 	/*
-- 
2.43.0


