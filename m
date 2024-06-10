Return-Path: <linux-kernel+bounces-208144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C3890216D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383A42810D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6511C8005B;
	Mon, 10 Jun 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZRQm/7n"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE5F7F7DA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021909; cv=none; b=ACtz/+D7FZazM9ozlZYgbqhi4ltwauxcFUUCHWWkXr7kxlGpQPEuL/Xvunfvy+EAwBW60da1zY55NuKXl9ZfCjRxXQm/4GyLM5/r9EKBOO6frwQ2yGwQItrjVDb0x4i3ZtKHOirse6WASgmYGxiJXc33JDINLLbqvXtfLG3zSHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021909; c=relaxed/simple;
	bh=HefF2syNjxvt876eLES/u8vyCE/hTUTrXSNifQKmNQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRp/AjZzgmQaHYOdqX23T+3FuIxIdbf66bukkYJdgC3UfJ02iTcVYsdJyGoMYb6O9OSe+4QgLXc2f1XR8arWM6dILUsDHlXCYPlJn81BaH2sw+XFRyPzz7KeZ9hx/yyFtHc+IVmUUnheWuPnCOT3zIBF7w09ATboNHfOp3Nk+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZRQm/7n; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4411fc45fbcso1184341cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718021907; x=1718626707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U09nDqdyDjm09ov5OxqAlgrZTEnMx+ri6277Ej4J+SE=;
        b=nZRQm/7nt71FoS2ge5XSDBaCXCUmnfAb0iFG/IyNIBECcTt/0Q79OzCncMLI8rv1Lj
         9NcIU4Yh5vJL9HQr3+N+b0GfWf25Jsg1TXW7XfFQ7mU1MQi8IFfEdQRWQmmoUm1He4Zt
         ZS0Rv4YOHXLvMKEykQMrzAhwKg5OQ1krAUogID54mr7jOhm2O0y+4HyWsl1tWhIG5WUv
         0Whg8LH/R8fZj485dC33TjtToDlZAb7CbuxxETbby+IiS8u1rBJ/XQ0LjmMZDSgNlXBd
         0uXt1I4BDn/0BnxC+fLMblCgamcIs55vWdK0lraRQ0PTX0WGMdW1ujSvjoU5GWg+ZuhL
         zicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718021907; x=1718626707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U09nDqdyDjm09ov5OxqAlgrZTEnMx+ri6277Ej4J+SE=;
        b=mJnbkP+xIwutTKGbtzVO/DScI6ZWccAb0yVwvrQzBDzSAK3BTNMMly21JnRYQyzBHT
         p7vO1ruEaWCSDf8AE8mjMJXuVgBEVhGdZofuk/vjajqpfgrLskS1R7RrzRGKo42Ol0i6
         LJQNE2lFwv07GqfsHQvEnwlw4az9v5Yu7P+lw/+biwAhSJISI/K48VQoV0Fy8NI6qg6l
         QkbhQPp53iUq4SMFP+6uyzgYOBUJSPjyo8Vw0eoEY9RNFlRcn1WJsnHIi0Njjcica++j
         cT1VnRcQRaI9K8hojrjdYhFhNjFFZJyFbt43ki6O9y08i1sGS+1b8ACwnrSEL4z/cEBo
         aczQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMOjteIRyYWcnD0Z6xb3CGE4B7CGMZkhDe8vvxPwRifDZ7LSaStoS1txQMxsBXEYXLIEyWDdgpyY4xDfuPWVUSTBtd22x2XGNdFP8I
X-Gm-Message-State: AOJu0YxgA56E/oEUPk+uGPMQQ34w7AGU+dyOHXOwEnNDDnDVt38cBQ/b
	5+LNrtRFZqCS9XWj4mUFnPhaAo8wDz7aYQD5xgBW1pXvKY3RZsDV
X-Google-Smtp-Source: AGHT+IHQjlqF6rwlkFyoaljIk9O9zBO+WkkXZoER6nk04i+5Kfvv4yHDqz5cR5JdPILe0xHkL/rhfQ==
X-Received: by 2002:a05:622a:4c:b0:440:5fa0:5f2b with SMTP id d75a77b69052e-4405fa060c0mr59056201cf.44.1718021906662;
        Mon, 10 Jun 2024 05:18:26 -0700 (PDT)
Received: from localhost (fwdproxy-ash-117.fbsv.net. [2a03:2880:20ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440c9fed96asm9816111cf.17.2024.06.10.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:18:26 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
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
Subject: [PATCH v3 2/2] mm: remove code to handle same filled pages
Date: Mon, 10 Jun 2024 13:16:00 +0100
Message-ID: <20240610121820.328876-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610121820.328876-1-usamaarif642@gmail.com>
References: <20240610121820.328876-1-usamaarif642@gmail.com>
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


