Return-Path: <linux-kernel+bounces-200482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586B78FB0A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7341C20EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917081420D7;
	Tue,  4 Jun 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsUzGGNm"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD181459FB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498804; cv=none; b=pIRyaAeLTL2aJTxlcN56xO6h/z8Df428AdoSthJc7Hj8RtSd4eIkpACNTiaBYTIRV/EXt1YA2+M6Yt17pNXf/lHYk5BKXbesHfhj+bC2SgMsJK5knuP2W4GIhEtcGVEZHd/GG0jpUIT4T1ZkteS9rAwXLByZevhL40ozD5VmdRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498804; c=relaxed/simple;
	bh=z0AMfVX/Vo5LmLCX4IsjL1mH/g5mb8lIUimQDFV8pCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZmA8FbkRiBPqoSJVRgeL9kMSSn6NGoCVYhHxzCSPZn78n5nqzvKfKIOb+aZcxTtdHdVg1+P+r51oaMGY6k/ybHOWCSY79lWk3jBI3TpEI1XETUA0eSw20drixqf5YYXIYqdPUQlG3esZZOkbqHyjdDNedymrz2hNv9bR4yAjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsUzGGNm; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d1d65a471aso3216477b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717498802; x=1718103602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+XY1gPxeVwDTMFWy18KTOJW5+R0TdSJWJS675lM6zM=;
        b=AsUzGGNm2VrdPd5v9MvutZ+M/YIJjFGyuwT9CZIlN95c8ONEm2uaPozOWrYDU/tS3a
         vT9YJJ310DqQffF8OW02U8zy1uRhZai5ZtpWysIK2BhOHtd0c7adxCzu1wbtzVSm3Qit
         5W38hHcqdtFLBPu2Q8mJ9Cci/X0JHvrDsn7pBu8F88/4r4AnoLp/tfO5ZOrX+qu2TtRE
         vJRb7JWz9sVjgToH3uCEUjoECwO4YmoLG69Y5KadTtzXZTMv11X6117RrCEzrPC+/znM
         vxkbwW8VNSeefo1ONz9vQKFtNtaT//cZCahyb/8y0qdVbQ3X8Xknt7bxQFOj4y8BHxXc
         yTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717498802; x=1718103602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+XY1gPxeVwDTMFWy18KTOJW5+R0TdSJWJS675lM6zM=;
        b=wfdIzFNBC+2/rHk8t/6vIpFMfiI92w8HMrC7W3dZNbvUPNkXGAKFVsaHiSqXwO1anm
         gV4LuFPzaQ8NGcR5vBzTgK03ae9eoDYToifiHzQHFYRJG+sP3fpRcceCYOGV9PuSllwL
         jADIfL+5oMeR28UldCC80+YcmNl9FjDW/9rN7ZCxLxVJpOLGh+IICAtWK37WUEGVTIxR
         madp5j9AazxPuV7pXfjK4ibDukjNjF2S3Bn53B0qjxEs1KRe0pEQFGytWZwGfsa67AX8
         pq5ET8bI2bFgQIiM9md7e+CRM0cwlfzXbqVI8PQXeZ+5dfsPSE0E3vhBivZ0L/YewvyX
         X+UA==
X-Forwarded-Encrypted: i=1; AJvYcCVAZFdLNNU+m7fjveXoVd3wsjflat/Fdl5o8c7SkdW/CriTqiX86PJeQndDccvXxg//RqPVG2KIOQXP4RGhszpL6gzEDmcRZuyRXabi
X-Gm-Message-State: AOJu0Yy3MkMIBF/mqXD8kkjSdUTtEoCUpfQVuKlCEa9t8ltncbD1/+5y
	n6dDWVBJxpAqzam0jF30v2PHXjKvZHrE/rKi5mHPJ1/3HYi1zH7x
X-Google-Smtp-Source: AGHT+IGqjDsQMT9+d5i3I+sV8o2xgyHBJns1JSWePTCCOLgtjISL9ZlqehNIwR0a3myq26CqJC/CfQ==
X-Received: by 2002:aca:280a:0:b0:3d1:c62a:3e0d with SMTP id 5614622812f47-3d1e35d0120mr10336000b6e.58.1717498801911;
        Tue, 04 Jun 2024 04:00:01 -0700 (PDT)
Received: from localhost (fwdproxy-nao-005.fbsv.net. [2a03:2880:23ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afbf044967sm18003676d6.124.2024.06.04.04.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 04:00:00 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	willy@infradead.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 2/2] mm: remove code to handle same filled pages
Date: Tue,  4 Jun 2024 11:58:25 +0100
Message-ID: <20240604105950.1134192-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604105950.1134192-1-usamaarif642@gmail.com>
References: <20240604105950.1134192-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With an earlier commit to handle zero-filled pages in vmscan directly,
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


