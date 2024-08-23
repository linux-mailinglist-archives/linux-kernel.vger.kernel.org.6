Return-Path: <linux-kernel+bounces-299522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29695D5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DA9283C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104EF192B63;
	Fri, 23 Aug 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqYdlb0t"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633231922F8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439952; cv=none; b=ksRn4rTbAWCcVWxiFc4Z9XTWACQgrZw4sLHpd69pBkv5Pb+VPMCQFCQ4YjfJKPEqsu55mUF++8JDKQOW4hAz/VTxZ2j8/pkeGSffmocEMJM+e/hR5hhpIVa3P4nvHtWrosDOeaiX88Qo2+u4Ev5a5ClPO355zZOvXrtC94GXUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439952; c=relaxed/simple;
	bh=4WcXynEz0+i6ixsIVhC2fUIHR6r8/g52R5NBK/cUdLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHn53XIWaCJFpePvyBNzW68m/oh5Rqw4EOkTzdYh++QoENmjzzKVFhKAfCW6oDJUj9rgMahbCCivAVXYg74idsbweJdcav/SautCUy2sN+BRPy/0Ru2LQXsdbW4tYzx2gqZbvRcwJeWFV6oG63nTkSdhIsBZFQ0FOL0XFuPFJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqYdlb0t; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1df0a9281so140094685a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724439949; x=1725044749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXz1WqDOSOf0lx3PDODMvA3lWYB2E2RmwkpOqwgzHOw=;
        b=DqYdlb0tk6g9EnY+X/jLqN7X0m/telmcsBy30hJLBeeUdYmKqBPBP6SblBlrAD7Zh3
         XVDRk76pft7YnbXcolVW0SAlV1XlTFxyuPlyVzaQqOIyZSXTTe+JhrL+/tVAwO0fJU4L
         dnNb97db7cUfaoBMrN/2YMAv03MEE+hQr0Dp/38gCFX7h7nhydMRqjY0D//k4Trraw9x
         Bq8eGMf9R6mlQHHZuKFq4bt+ggNXDhNZBcl5k1kVKQCpPVWB9pU+a1xt1lL+CJFNM9PW
         kTlIiKmjBw2KtQzKZPuycjZLaR3Zhl82DCZkX2m9XMt9DcEcNp3mjDdV/UgzCd+tyh6+
         xMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439949; x=1725044749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXz1WqDOSOf0lx3PDODMvA3lWYB2E2RmwkpOqwgzHOw=;
        b=CVd1QMeQCSphRhAeewKiDiQbkMnHCUUbhB6JxJra1f71Sous3YUsy4QhodUdMalXwK
         CYEV0Wn3EX1fwdyFxih/HLr8CVCtEhtWkp8CuC+c5If58VfyxutlF3DyX2CwvLpMi6MC
         Wb1m9XyGFgUrCfoCmATeHRpZ2KWz9B0KC03wYY3gdkgiefqIzzCjQZTK9ZUd0+Y5hnq6
         rEmJsj8bOVlS/QiRGHrRbN5uI+Gl0M5D3ZbhpBRFOEudqHoE+6w01Bvz4AImw/fIEzSk
         OwvvZ2RmbKoZgStPHA7RPnuM00qakR6p5QRg5K+uBJk6E4Sec3NtN5JB22Loa3mslqgc
         1lqw==
X-Forwarded-Encrypted: i=1; AJvYcCWsODNVlXWX5l6YhDM/hphsUBOusMxnn8+hMqdR/INBBhNlVv/t87IB3mtfYh62jxhe9byptiHvsHKuPaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+h1RAfcP740ROI5gm4P0+cwERbsGUEU5CADtBUDaMtnr3nUXe
	LHqdY7NcxcO/J3R7+qD2LT19EtYB9U+LLO8tduAaTGGUFwyxK146
X-Google-Smtp-Source: AGHT+IE9Bd7WW/rU0Ll51OR3EAyq5JreQRHH8kzeghLjMl8faLxlPdzbZDil5qdNrBwCfKa0NMZlZA==
X-Received: by 2002:a05:6214:3f83:b0:6c1:6b23:dc9 with SMTP id 6a1803df08f44-6c16dcbd32cmr35351236d6.37.1724439949011;
        Fri, 23 Aug 2024 12:05:49 -0700 (PDT)
Received: from localhost (fwdproxy-ash-018.fbsv.net. [2a03:2880:20ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c1c6sm21607346d6.46.2024.08.23.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:05:48 -0700 (PDT)
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
Subject: [RESEND v8 2/2] mm: remove code to handle same filled pages
Date: Fri, 23 Aug 2024 20:04:40 +0100
Message-ID: <20240823190545.979059-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823190545.979059-1-usamaarif642@gmail.com>
References: <20240823190545.979059-1-usamaarif642@gmail.com>
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

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/zswap.c | 85 +++++-------------------------------------------------
 1 file changed, 8 insertions(+), 77 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index df66ab102d27..449914ea9919 100644
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
@@ -185,8 +183,7 @@ static struct shrinker *zswap_shrinker;
  *
  * swpentry - associated swap entry, the offset indexes into the red-black tree
  * length - the length in bytes of the compressed page data.  Needed during
- *          decompression. For a same value filled page length is 0, and both
- *          pool and lru are invalid and must be ignored.
+ *          decompression.
  * referenced - true if the entry recently entered the zswap pool. Unset by the
  *              writeback logic. The entry is only reclaimed by the writeback
  *              logic if referenced is unset. See comments in the shrinker
@@ -202,10 +199,7 @@ struct zswap_entry {
 	unsigned int length;
 	bool referenced;
 	struct zswap_pool *pool;
-	union {
-		unsigned long handle;
-		unsigned long value;
-	};
+	unsigned long handle;
 	struct obj_cgroup *objcg;
 	struct list_head lru;
 };
@@ -801,13 +795,9 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
  */
 static void zswap_entry_free(struct zswap_entry *entry)
 {
-	if (!entry->length)
-		atomic_dec(&zswap_same_filled_pages);
-	else {
-		zswap_lru_del(&zswap_list_lru, entry);
-		zpool_free(entry->pool->zpool, entry->handle);
-		zswap_pool_put(entry->pool);
-	}
+	zswap_lru_del(&zswap_list_lru, entry);
+	zpool_free(entry->pool->zpool, entry->handle);
+	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
 		obj_cgroup_put(entry->objcg);
@@ -1277,11 +1267,6 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
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
@@ -1416,42 +1401,6 @@ static void shrink_worker(struct work_struct *w)
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
@@ -1463,7 +1412,6 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
-	unsigned long value;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1496,13 +1444,6 @@ bool zswap_store(struct folio *folio)
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
@@ -1520,7 +1461,6 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_compress(folio, entry))
 		goto put_pool;
 
-store_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
 	entry->referenced = true;
@@ -1569,13 +1509,9 @@ bool zswap_store(struct folio *folio)
 	return true;
 
 store_failed:
-	if (!entry->length)
-		atomic_dec(&zswap_same_filled_pages);
-	else {
-		zpool_free(entry->pool->zpool, entry->handle);
+	zpool_free(entry->pool->zpool, entry->handle);
 put_pool:
-		zswap_pool_put(entry->pool);
-	}
+	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
 reject:
@@ -1638,10 +1574,7 @@ bool zswap_load(struct folio *folio)
 	if (!entry)
 		return false;
 
-	if (entry->length)
-		zswap_decompress(entry, folio);
-	else
-		zswap_fill_folio(folio, entry->value);
+	zswap_decompress(entry, folio);
 
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
@@ -1744,8 +1677,6 @@ static int zswap_debugfs_init(void)
 			    zswap_debugfs_root, NULL, &total_size_fops);
 	debugfs_create_atomic_t("stored_pages", 0444,
 				zswap_debugfs_root, &zswap_stored_pages);
-	debugfs_create_atomic_t("same_filled_pages", 0444,
-				zswap_debugfs_root, &zswap_same_filled_pages);
 
 	return 0;
 }
-- 
2.43.5


