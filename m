Return-Path: <linux-kernel+bounces-214740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B7C90895D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACAA1C26F67
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A8194153;
	Fri, 14 Jun 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD+IEc3W"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978919308A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359754; cv=none; b=Xn+p1XXDqbW2nVqNAdX0oTZl1KydUma3o6y0zl9mz5y7BjMXJyv+57ZGH1VG4xm2Py87VrNxonLYkJZy4xoYhKsC/qXqpOFnez6Ckcl2uMjHwXBD/fqBne+lXMsewvdRB4DFVoDLIyJ7Z4spMGRs2Bm35fhH96W3DulanGe1F64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359754; c=relaxed/simple;
	bh=EIfDIo1KyLwMz8ZfNtfaXYH0IGyvCXi7NcTQhonIcZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmawHcYTM1yqf63YPkUVar9Zelmx/pzWysQ8QX+Yk4m+1T+duqJSV43JJAniSBGvQaaQmAW7Z/EYjRXuAgO9+VczPIqo4D0spwv8bKYUTjCcKx92hfwcPVVPrm7jUonnS0fosql15yYW6H6PLqist8Kk/f390z4kj7RIRoYyeU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nD+IEc3W; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-797dcb558ebso121034785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718359751; x=1718964551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EHezwSo6IEpdsNk9twdnn0QxPVkx1ShUAN5bWtyw3s=;
        b=nD+IEc3W+xD05ggs8pB/P37hRIVgd68+1AuqcdcQspS80noUVru2MuQGcy1pXGRQED
         yeVTMEZNEc4GBfAaH0jFu/0Q+aZtMZ9L8Q6wEOfUJj0n8OPT0pM0BGAt4vlme+E6ZJ6q
         gPPta3mBvseN73uOTBENP6PL0q964Q2d8PRCI7yVrhHKCMv8ItWxjvv2G44ROP0D5Z28
         GL7v3TKMNL33OtjaS11Ahd83lSOGdueArTS4UjlAc8JFjZ2yGtNdasb/GghZHF11rBtd
         O8gAiad+Mh1nEV0/z1vyRJaFuDS6L4NxMhVjmPJPuRvy8BbWom7IlORsKYGSFMd3n0GO
         pd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718359751; x=1718964551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EHezwSo6IEpdsNk9twdnn0QxPVkx1ShUAN5bWtyw3s=;
        b=bnav54SP7Z6pVRSX7WTL2uMxluKZJRLc5i+y0ushgjSpaa96GfL4f6fBAbFrWcchBj
         uqbLq8dl7ZrRPf8wncZu92N4eYLsdFJZMHJQta3RsDMpLNEYOo0deVG7LsFdUGqIpleL
         9KXOlgIqPw90yjMc6cD+3tSxl2m9Dbv6V7Ys/ezPD/jfaJ9v3JJZLubfYeflKVSZEeXT
         y8MLi2AUOxbTxHGkhYhOUldHayRBlinsUrj0Ahhwh/mCA8d0yZnaGSc9SfP9baM0ZTAp
         bzEAzjZVVZUm3L+K5V2TxLLQMgwN6xvQMrnfornxxO0vMxws1d9PoqAqAsaXNYn7KiWl
         kVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVtYZW6h8nnPAMAHmr8mBTtU7FJVLGOovc+kaodzok+rw8YvtcsTESnXCdk4PAEf7IkM7xpk+MvV4zBmSYn+0lHArzn60eH/lbZ6on
X-Gm-Message-State: AOJu0YwDRDliRFsQb8yNMc4YI9CA8e2Pzv75T1l8UtF8ZebtOFxRBggl
	K0hxWHhqUrszDtSVk+pMNl1ySkCsmGZvAuEsc5DD2dLyiz93G1JO
X-Google-Smtp-Source: AGHT+IFJEvCuMkaEjbOYT08iEZ5+NTEUu3Vx5zj5E25wX7sKr7Vg2rxYQdpasbTkSVE2OkRKgL3q4g==
X-Received: by 2002:a05:620a:444d:b0:795:4df4:d4f6 with SMTP id af79cd13be357-798d243b29fmr254496485a.46.1718359751276;
        Fri, 14 Jun 2024 03:09:11 -0700 (PDT)
Received: from localhost (fwdproxy-ash-002.fbsv.net. [2a03:2880:20ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fcc0b9sm14201161cf.65.2024.06.14.03.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:09:10 -0700 (PDT)
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
Subject: [PATCH v5 2/2] mm: remove code to handle same filled pages
Date: Fri, 14 Jun 2024 11:07:06 +0100
Message-ID: <20240614100902.3469724-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614100902.3469724-1-usamaarif642@gmail.com>
References: <20240614100902.3469724-1-usamaarif642@gmail.com>
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


