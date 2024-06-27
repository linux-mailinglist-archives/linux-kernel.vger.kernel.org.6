Return-Path: <linux-kernel+bounces-232170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEDB91A462
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322821C20C74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C7146D4D;
	Thu, 27 Jun 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwUolHuQ"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1213F431
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485857; cv=none; b=BSbfxFCGwgcF752BFCQB43NTgsNojdxslIMOaDTWuN1IHRUUR7ESIEbhR4ducWjsskfgfms6J7DUnUqK54UcT5dZbp4KS9olM2sn5KTUdlWsZoEVdAy2+heGb3IWCG5ztw/Yd+a4cOWOm06PiHeyTUmREP6mHhSuu0sOdCQT50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485857; c=relaxed/simple;
	bh=/M+wnG7FpQGgd6bzM9t2TpaND0U3poF8mndXCvU1kq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f522tAHgzvZkJymdz0zZY5beIA07PNbJbqV9PHI4FiZuuXD2Zcv/TbAGrE094uDwiitMuNMoLbl+fTXgClcL8EP3ZZHzr43Rlx2YBrVsB/PJknseb3+BRYPw5nBPzjBMS6NmnjP8k6fmmZpMf5VX8kJmvSvNRwWuGDXsCPziQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwUolHuQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79c0bc8092dso238746185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719485855; x=1720090655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jytiD3F6dVDoVcn3tgOCkYr8qgKU/Kw/DG4oKzaeY4=;
        b=RwUolHuQHcMfUE0qPQSUr62HSAcHxsqZKCHLVEHxjzKzXPJ+wQJOEVkZHvDoOSJXFg
         0U9UKB+Wssuc/8htYuFQnf4A+Bx3Ud1glFpRw0jcG/s26yd+BI6eSsLFNZB7uJlyWdQT
         XV8R/svOJoT+OpNCpbbJ3MDCmXWH9zmsS/8Ar79W/e3KbYCG6UCY2JfoUjTZ8QJEsl3W
         MEU+RjOb3jfr5LFJzZAcy8XxkJKwuwMgvpI4wwM65bu4xjdFq8MH05q9g6p5ysenVmbO
         poN2unO8RCqeI/pJ/Z7Wk9cEiVyJqWlXUmqoE2M8eTonCWp0TZwmGZeeO8J/U+01rPmd
         dS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719485855; x=1720090655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jytiD3F6dVDoVcn3tgOCkYr8qgKU/Kw/DG4oKzaeY4=;
        b=aOMoCglE+CwkkZa4EZflYwVgDCaomuaa4n76twaZtNs5GRdnyHmUAzEp6AzHQ4YF3F
         g1D7/4eNVQp5IKVxIAoixwbpSADUdhh+ovX91X3uIyEgqMsYl5T5iI4rqqUJDiFZlFDK
         mF5mds0vlUNi29djw6Rj4unZjKwQkJsALNeup5WqZh87Z/hCxQYSB31FOcQ1xl6TS/R3
         EOSeTmNHonfIJyZmmMvIvhdpYGPuT1K6tfPRmyxEMQwPuUEfwf95zDKf0DWf9KfO9cnT
         eXNnAxCt4qzKeX9JPfOmbDqC7U2KpKPCjvZLS7+H5M2jVoc+CKh7SRZhXLDbvqp0YDX3
         p9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBR1U/hfW3ijEUcRlp+4IN0eHytmbxzYimL5LBe86MhlU4kUe+96SmqwsvyCpY9FDIBYxcCdkKH1d9VS/+GRq76sqUehqz72nLCQuP
X-Gm-Message-State: AOJu0YwjdNjYfQ51whp7K2acP3HFI6KYTb8X++cY+RlIDhTUjzkYXAOa
	bofhW+43mopfXzg5wBQTK/001NTIA6uzgbddlm0Hh9Ajruzp0pWg
X-Google-Smtp-Source: AGHT+IFRSA2E/3cS18UczoHmhGiJ1yqas1kMncm42FdVDN8CvhCvuezJ9y6/uHNF847ZRU8aorvsYg==
X-Received: by 2002:a05:620a:404d:b0:794:b302:96b5 with SMTP id af79cd13be357-79be0c62f1bmr1704032485a.36.1719485854953;
        Thu, 27 Jun 2024 03:57:34 -0700 (PDT)
Received: from localhost (fwdproxy-ash-012.fbsv.net. [2a03:2880:20ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c8ba5b1sm43902985a.108.2024.06.27.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:57:34 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	david@redhat.com,
	ying.huang@intel.com,
	hughd@google.com,
	willy@infradead.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v7 2/2] mm: remove code to handle same filled pages
Date: Thu, 27 Jun 2024 11:55:30 +0100
Message-ID: <20240627105730.3110705-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627105730.3110705-1-usamaarif642@gmail.com>
References: <20240627105730.3110705-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With an earlier commit to handle zero-filled pages in swap directly,
and with only 1% of the same-filled pages being non-zero, zswap no
longer needs to handle same-filled pages and can just work on compressed
pages.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/zswap.c | 86 +++++-------------------------------------------------
 1 file changed, 8 insertions(+), 78 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a546c01602aa..e25a6808c2ed 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -44,8 +44,6 @@
 **********************************/
 /* The number of compressed pages currently stored in zswap */
 atomic_t zswap_stored_pages = ATOMIC_INIT(0);
-/* The number of same-value filled pages currently stored in zswap */
-static atomic_t zswap_same_filled_pages = ATOMIC_INIT(0);
 
 /*
  * The statistics below are not protected from concurrent access for
@@ -188,11 +186,9 @@ static struct shrinker *zswap_shrinker;
  *
  * swpentry - associated swap entry, the offset indexes into the red-black tree
  * length - the length in bytes of the compressed page data.  Needed during
- *          decompression. For a same value filled page length is 0, and both
- *          pool and lru are invalid and must be ignored.
+ *          decompression.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
- * value - value of the same-value filled pages which have same content
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
  */
@@ -200,10 +196,7 @@ struct zswap_entry {
 	swp_entry_t swpentry;
 	unsigned int length;
 	struct zswap_pool *pool;
-	union {
-		unsigned long handle;
-		unsigned long value;
-	};
+	unsigned long handle;
 	struct obj_cgroup *objcg;
 	struct list_head lru;
 };
@@ -820,13 +813,9 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
  */
 static void zswap_entry_free(struct zswap_entry *entry)
 {
-	if (!entry->length)
-		atomic_dec(&zswap_same_filled_pages);
-	else {
-		zswap_lru_del(&zswap_list_lru, entry);
-		zpool_free(zswap_find_zpool(entry), entry->handle);
-		zswap_pool_put(entry->pool);
-	}
+	zswap_lru_del(&zswap_list_lru, entry);
+	zpool_free(zswap_find_zpool(entry), entry->handle);
+	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
 		obj_cgroup_put(entry->objcg);
@@ -1268,11 +1257,6 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	 * This ensures that the better zswap compresses memory, the fewer
 	 * pages we will evict to swap (as it will otherwise incur IO for
 	 * relatively small memory saving).
-	 *
-	 * The memory saving factor calculated here takes same-filled pages into
-	 * account, but those are not freeable since they almost occupy no
-	 * space. Hence, we may scale nr_freeable down a little bit more than we
-	 * should if we have a lot of same-filled pages.
 	 */
 	return mult_frac(nr_freeable, nr_backing, nr_stored);
 }
@@ -1376,42 +1360,6 @@ static void shrink_worker(struct work_struct *w)
 	} while (zswap_total_pages() > thr);
 }
 
-/*********************************
-* same-filled functions
-**********************************/
-static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
-{
-	unsigned long *data;
-	unsigned long val;
-	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
-	bool ret = false;
-
-	data = kmap_local_folio(folio, 0);
-	val = data[0];
-
-	if (val != data[last_pos])
-		goto out;
-
-	for (pos = 1; pos < last_pos; pos++) {
-		if (val != data[pos])
-			goto out;
-	}
-
-	*value = val;
-	ret = true;
-out:
-	kunmap_local(data);
-	return ret;
-}
-
-static void zswap_fill_folio(struct folio *folio, unsigned long value)
-{
-	unsigned long *data = kmap_local_folio(folio, 0);
-
-	memset_l(data, value, PAGE_SIZE / sizeof(unsigned long));
-	kunmap_local(data);
-}
-
 /*********************************
 * main API
 **********************************/
@@ -1423,7 +1371,6 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
-	unsigned long value;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1456,13 +1403,6 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_is_folio_same_filled(folio, &value)) {
-		entry->length = 0;
-		entry->value = value;
-		atomic_inc(&zswap_same_filled_pages);
-		goto store_entry;
-	}
-
 	/* if entry is successfully added, it keeps the reference */
 	entry->pool = zswap_pool_current_get();
 	if (!entry->pool)
@@ -1480,7 +1420,6 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_compress(folio, entry))
 		goto put_pool;
 
-store_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
 
@@ -1528,13 +1467,9 @@ bool zswap_store(struct folio *folio)
 	return true;
 
 store_failed:
-	if (!entry->length)
-		atomic_dec(&zswap_same_filled_pages);
-	else {
-		zpool_free(zswap_find_zpool(entry), entry->handle);
+	zpool_free(zswap_find_zpool(entry), entry->handle);
 put_pool:
-		zswap_pool_put(entry->pool);
-	}
+	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
 reject:
@@ -1597,10 +1532,7 @@ bool zswap_load(struct folio *folio)
 	if (!entry)
 		return false;
 
-	if (entry->length)
-		zswap_decompress(entry, folio);
-	else
-		zswap_fill_folio(folio, entry->value);
+	zswap_decompress(entry, folio);
 
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
@@ -1703,8 +1635,6 @@ static int zswap_debugfs_init(void)
 			    zswap_debugfs_root, NULL, &total_size_fops);
 	debugfs_create_atomic_t("stored_pages", 0444,
 				zswap_debugfs_root, &zswap_stored_pages);
-	debugfs_create_atomic_t("same_filled_pages", 0444,
-				zswap_debugfs_root, &zswap_same_filled_pages);
 
 	return 0;
 }
-- 
2.43.0


