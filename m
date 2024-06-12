Return-Path: <linux-kernel+bounces-211511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B629052DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E4D1C2343C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7817BB28;
	Wed, 12 Jun 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nejc/pxA"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69922176244
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196478; cv=none; b=OF9HvH1Mxvs5lVSBuk94RWmOwL11zyEnKtyUIgEksM0UZ7TYTmNvUXfpcJ8Od7N01sE5oPlr2/YIps1HnOEzJuADF7GucFG2CS7SlRJSYS+yZyvQXOg7rd+0Ih7q8AmtUOadjjoePG8ROBq72AqPn6gJmAropjItnfES18zLPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196478; c=relaxed/simple;
	bh=HefF2syNjxvt876eLES/u8vyCE/hTUTrXSNifQKmNQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oi4ZC9vftxIcvJQap814IpEfF3NEKdoQrbV8dcYHWiq/0jmZdv31KBXXLwOKdmpLqkkmKB0wv34XBnHA/cVJbqmTjV2lDP4q19hWLTc2gEUa5zoJBwX25uxTZkSQs3RaVCOQ04vWWFWJFtkAHSTDtH37+Okz9jiB5VMdJ0iLm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nejc/pxA; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-627e3368394so75241897b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718196475; x=1718801275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U09nDqdyDjm09ov5OxqAlgrZTEnMx+ri6277Ej4J+SE=;
        b=nejc/pxAwXHvYEOjiFQeH3aTHsitaRNvp97HwVMc06DtBrYMURQUgWMIh4myLitL49
         kjYkzlrywBnbYwwgQDgGp1tU2QzOVaZAOmZmMK2BpZ8lcDg2dKOFmhKFH4WFAc4hKXSN
         7rIobZGfxHZE+gcYQhCasfdsO36Wp2BYC/OQJRToApdX12L4LyOyatQle1Cw/hFDPVpX
         njCKJiYDaFuLLrpiqiSQXYV80io6r+aupfSiV3/fTE0SeZU3ibAUYnaiW6w2RsIDVmXQ
         tuK/ua/Ol9sydCwNYP/23pulN1A8hu2t8xWsxPw9JYOexYJsDmGv1mERFYudwPiJYBb4
         QeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196475; x=1718801275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U09nDqdyDjm09ov5OxqAlgrZTEnMx+ri6277Ej4J+SE=;
        b=qxnjK1e3ceX3HxO+GLgOdisl+ZUocvSvvjLLW6aXzSgn3M/LZ5zRsdr0lt1348vQJ0
         h1T7nGKh451LsA5qHLYSbmUWMgQalUI/hNALSTotttQEuqgHmZZn019lrtc0okcsei2r
         1QTIeIc6FPJqPnU5YlpciorPvn1VVA4Yyt/qYnapQ/95vjj3ZHNa3B2+OKNu+rFQOZXA
         oI1KWa0IQy6kkgUGNqPWtpEV9eUgxm3+SiEFjNbA3P5wuagmfqFpzbwIprKhmmvZc8yX
         WW0xNy8JQMQEx/TiHZTOjjOGQCOq3Whse4jxi5X5822kFNtZ5//Tdy70gQ8g4SogpJ8w
         j82w==
X-Forwarded-Encrypted: i=1; AJvYcCWDGwD3zS+fSQ3/WwpQX4IgWzRZDpHvCljHlZ4Fdb4YFPy+SZqjzdcOURgAwEuXLy+Nw9Q0DQXzrQO6s6MlqW1ZO6tR0se9qP6IWlAU
X-Gm-Message-State: AOJu0YxLh/bI2HbPC4Splxv0ZdaGVgtZUJpo3+Uv3SBpN/TGrQfc3s4w
	c7ZL7NAeRxRKvF5MtarlEeBggChXbMg3YFES7Sm5+xUSRu9E0Jf6
X-Google-Smtp-Source: AGHT+IGkQ17HzT2wzOFm9lZ1MUlnx3fVT0qSwDvdVstx+8uIKcOGNUUnfvL0eYxQuIWJ1sfFl/Gqdw==
X-Received: by 2002:a81:8491:0:b0:630:3061:c22 with SMTP id 00721157ae682-63030610d9fmr7911287b3.20.1718196475331;
        Wed, 12 Jun 2024 05:47:55 -0700 (PDT)
Received: from localhost (fwdproxy-ash-008.fbsv.net. [2a03:2880:20ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b07ed90264sm30056906d6.13.2024.06.12.05.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:47:54 -0700 (PDT)
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
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 2/2] mm: remove code to handle same filled pages
Date: Wed, 12 Jun 2024 13:43:36 +0100
Message-ID: <20240612124750.2220726-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612124750.2220726-1-usamaarif642@gmail.com>
References: <20240612124750.2220726-1-usamaarif642@gmail.com>
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
---
 mm/zswap.c | 86 +++++-------------------------------------------------
 1 file changed, 8 insertions(+), 78 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b9b35ef86d9b..ca8df9c99abf 100644
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
@@ -182,11 +180,9 @@ static struct shrinker *zswap_shrinker;
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
@@ -194,10 +190,7 @@ struct zswap_entry {
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
@@ -814,13 +807,9 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
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
@@ -1262,11 +1251,6 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
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
@@ -1370,42 +1354,6 @@ static void shrink_worker(struct work_struct *w)
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
@@ -1417,7 +1365,6 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
-	unsigned long value;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1450,13 +1397,6 @@ bool zswap_store(struct folio *folio)
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
@@ -1474,7 +1414,6 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_compress(folio, entry))
 		goto put_pool;
 
-store_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
 
@@ -1522,13 +1461,9 @@ bool zswap_store(struct folio *folio)
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
@@ -1577,10 +1512,7 @@ bool zswap_load(struct folio *folio)
 	if (!entry)
 		return false;
 
-	if (entry->length)
-		zswap_decompress(entry, folio);
-	else
-		zswap_fill_folio(folio, entry->value);
+	zswap_decompress(entry, folio);
 
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
@@ -1682,8 +1614,6 @@ static int zswap_debugfs_init(void)
 			    zswap_debugfs_root, NULL, &total_size_fops);
 	debugfs_create_atomic_t("stored_pages", 0444,
 				zswap_debugfs_root, &zswap_stored_pages);
-	debugfs_create_atomic_t("same_filled_pages", 0444,
-				zswap_debugfs_root, &zswap_same_filled_pages);
 
 	return 0;
 }
-- 
2.43.0


