Return-Path: <linux-kernel+bounces-207108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05C901274
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919751C21739
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BEC17BB1F;
	Sat,  8 Jun 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmK+Nmx+"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779831E888;
	Sat,  8 Jun 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717862014; cv=none; b=tf16ugce+O1PBYH4eCzXZ5MBv8mneXkAZPryvs06l0evfzIgLv9y5qLbrOas55chna6Abf8eH+QgIXHJDurM6FILPaUqbnv/piMKHFG5p99ney1l7VcR42dvWp0X14Vs5N/GfXHbx5PfbOOS0v6QXQ8NVVz0Nz5P7i35l7CmrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717862014; c=relaxed/simple;
	bh=Snco5oqloL4GXcU+40C9q1nAQ6XQ+70U2BqTJl7GweE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vvf2W7o0e50xpBwtRWNq8nG0aSwFPtsQluM85q4+sHjOv8MHX6lOoYhPVu1gO6EPwQ58DL8KPxkY+hDJr96AKmMc6s5mBHk3qlInSSOnKWiNcgOeF0i50bfkpgD/W+fEGICcIT7OWPhLSu1GpNBDFwmmH+xtfVfguN/YMKUxuGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmK+Nmx+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-703ed15b273so2494599b3a.1;
        Sat, 08 Jun 2024 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717862012; x=1718466812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrIr32TNVXDKH7oG1xumlOKq/cguM0V8sG+9FXVj9vY=;
        b=UmK+Nmx+x+eWQwNR3vc4pir6nM8Bm5id1m8cKxsO2NpiMA/U6kFUWdj9RQgLVHOB0F
         79CJn5ogSuL88/cI3iniNjSUYIftue4EmWwWVN+Hh8mpfG1w6GhawpA3WNVUvlb6v9Q7
         i2R95D6Oil7zD15L3MYiSWKz+QCZMQSNOFJwZ4ay10ZuI63r2KhR/mfEp1L8qq7bHkHe
         YtsHkngcbH6CXbfcwLxeg3xgb2Ha5e8IswYTfuytcQYiYhWATeK9zifRIb8DMf+gCh1J
         yzZ2KK+in/MzvHSPr36T1gqDgatVMAglrx5uAkrTmROzEsuDj0T+J38sV8zMSRMDvttv
         q4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717862012; x=1718466812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrIr32TNVXDKH7oG1xumlOKq/cguM0V8sG+9FXVj9vY=;
        b=Z2hAL2t/j2GVFF6iN30Suo4Q5Ir3cTBBcJ2yVhR838cxnWSEFuBb5oBMMk1Go5pkBo
         RffgivYUQH1MDdeJ0wBzvfKNCzlHnqwTTf8Mhe+9wU06Pr+RjWsvCvaLYct60H90pYY0
         hy9NcGq/VwtK6CoaG3BZ5M0g3glNgtw9V41PD5XWj9sMTzc+12Z0SSZdy1QZiJlvFepx
         rXTfAAuhH4r/nGqBhGXY0eFHoLbS5ZrymHYhZxBvVXewxYm48m8G2H5rbtxrpgwkaTCe
         QRIDZVnhWIENidOZkZaaTmfmX0X379qmJS2yBdZedemlfYxwRdeYoQ2R5rXiX/0gcWC1
         vaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHiUoTjxFpp8OoklnmRA8pTyLDaex/msPtvpjeyACAaEcU0SguM2l2TGcFK8g08+oFPtuWkzdLpf9Tb0bz3JY1uZuBQ+vOM0nEAMgtrCljkuDeSS0zzIJlBUEFWJD9ZfLT+XUPay4G
X-Gm-Message-State: AOJu0YzC0kGDXYs1qPLryVY/bDO1Yo8VJwy/QaJ5pnx7yjRXz5glXgyW
	wxBKBsizwNljsPM/pUy55MmmBK4nRYWLFtiJgJuZMi/FPAGffSgw
X-Google-Smtp-Source: AGHT+IEteUQgfUsrWSdHev4f9MAtLQvgT4O27ZIatD/ynyxVmEqXJoDhlhnvAnSdhI3u3ENtRXai/Q==
X-Received: by 2002:a05:6a20:43a2:b0:1b4:2a8:629 with SMTP id adf61e73a8af0-1b402a8081dmr4737912637.53.1717862011509;
        Sat, 08 Jun 2024 08:53:31 -0700 (PDT)
Received: from cbuild.srv.usb0.net (uw2.srv.usb0.net. [185.197.30.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4d9d8fsm4335209b3a.149.2024.06.08.08.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 08:53:31 -0700 (PDT)
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
Subject: [PATCH v1 3/3] mm: zswap: proactive shrinking before pool size limit is hit
Date: Sat,  8 Jun 2024 15:53:10 +0000
Message-ID: <20240608155316.451600-4-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240608155316.451600-1-flintglass@gmail.com>
References: <20240608155316.451600-1-flintglass@gmail.com>
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
index 1a90f434f247..e957bfdeaf70 100644
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
@@ -539,6 +540,20 @@ static unsigned long zswap_accept_thr_pages(void)
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
@@ -556,21 +571,6 @@ unsigned long zswap_total_pages(void)
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
@@ -1577,6 +1577,8 @@ bool zswap_store(struct folio *folio)
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	unsigned long value;
+	unsigned long cur_pages;
+	bool need_global_shrink = false;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1599,8 +1601,17 @@ bool zswap_store(struct folio *folio)
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
@@ -1643,6 +1654,9 @@ bool zswap_store(struct folio *folio)
 
 		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
 		zswap_reject_alloc_fail++;
+
+		/* reduce entry in array */
+		need_global_shrink = true;
 		goto store_failed;
 	}
 
@@ -1692,7 +1706,7 @@ bool zswap_store(struct folio *folio)
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


