Return-Path: <linux-kernel+bounces-195258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9488D499A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BE91F24310
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A57517D36F;
	Thu, 30 May 2024 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFmAxhTm"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F117D354
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064509; cv=none; b=SrbEuBL9MCAVyj9Y1NkgULYLfKXSqwXISIF6ubYlw+6jljOdnVnTrZcxgd7tGLNvet0kDAShjfSmwm++jnCHL5VwgLwtSlKdhWcwgLPuykxDlQ8llk8jHKm/2+eyAzpZkDqVWsfXY+oAHSZxhyxpxA4roHTM1OV6d8MIiIoXnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064509; c=relaxed/simple;
	bh=FzOjSWF8jC9Mn0zbpKpMbjI6I3RxJXwXykNKxdZDtBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhIbR+LYfVpLs6Q0nSivQ87H74zl/F24ZFexmFOqYgwlPTqA4kkCEMnpE2uzUhyAnVVUbnihZzVRTM+5YlT/9dr2q4WDqlgOruBIVGQ3RWljB8jcROdTRq6hH3y5KZ0/XzhipMOJWj4SrroNqmcC/YuEPjSA3h4JRmLekzHJthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFmAxhTm; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ae1471db80so1578656d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717064507; x=1717669307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8d6cDNDU6GShGq9eK0Fgxfj+4gyetgt78E216drysY=;
        b=AFmAxhTmSf7YR267Abr1OeOI4xIqpXgJWSYkQpNoN1nW5fVWdiYwopqgwSPxCscteu
         hHVKDypjvXEp/5m1zR7nPOLDN1QnQukRCchEDw4lCFwn1V7sQalnvClMY3Q/OwAvGKbe
         P1QwBt2K639CAbqtmndGM0s00DyVlXCHQekuMxERKV74nzxTyV1FGy6z12P9TKcYRzyb
         bFFtwHY3YBkeWJPG2FKnePG8dlvW1MlZAXFo1vcPb+YW/fIsWZpn0m7GlyfsKgCrlLjD
         ZnBdwCA38hF7Leh/oWjZ0gIsvBRShG6MicBf7cy3yOmu0+9sSx7zmwmA/98c+IoJkgj2
         hJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717064507; x=1717669307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8d6cDNDU6GShGq9eK0Fgxfj+4gyetgt78E216drysY=;
        b=p16nJOMO0lwKusocO3dv8QoFNkNAMq64SMOTKA0FsnYVvr+lOHUS9It9iu525b+Fd7
         bFKxDqkH0JfwfFCZfvwaQXkpkdZ2SvvDQ/6yYtQVDXG9e9bCFlkl0qtcitRxBRQ0QiYS
         5afABHsEuiGru0b4NJrAcMtFXTOmY/q2j80LlXC2MukwDa+S2+0rCc90LtWa6OxTWjlV
         Yz2Pshxf6mAWnITl5tGuRel+W+apyRM27aE9obzaX6Nz/eUsfrfAOiLpEvb4+QZl1blx
         IoY5fTWZ7ctENPOrF69mF9f4hR4yDBgHwBDCE3FhiXYRW9TeguZomTQv9zZMrWDujROI
         koOg==
X-Forwarded-Encrypted: i=1; AJvYcCWAsKiZVdO/r3vBy9cWWwVu4dj4KCn6+0wVF+RXrSR63sjB8LtiF0RXcXLF+vFCskpej7GxR74X2PK2iK39iGByiWKqibQgS/gNcjiH
X-Gm-Message-State: AOJu0YxKC2YfnKa013kQHpUFzSiKbDxVrQyKhxK4D4nYyOe32q52CBYy
	6KCS+XSIDQOModPqIpCJIAnPhRPsLBjSyZuNCo+SXPyUR/V6MjX9
X-Google-Smtp-Source: AGHT+IF6BgR0E1H6Yi7Z0olWyUfqvRPLWZXsZcDuztfZzFojo07FrRO9l8l3SwT6pG7Yaa1MM+8V+g==
X-Received: by 2002:a05:6214:4189:b0:6ab:6ddc:4ba1 with SMTP id 6a1803df08f44-6ae0ccd3deamr16187306d6.60.1717064506651;
        Thu, 30 May 2024 03:21:46 -0700 (PDT)
Received: from localhost (fwdproxy-nao-008.fbsv.net. [2a03:2880:23ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae12306f5bsm3351556d6.118.2024.05.30.03.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:21:46 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 2/2] mm: remove code to handle same filled pages
Date: Thu, 30 May 2024 11:19:08 +0100
Message-ID: <20240530102126.357438-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530102126.357438-1-usamaarif642@gmail.com>
References: <20240530102126.357438-1-usamaarif642@gmail.com>
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
 mm/zswap.c | 79 +++++-------------------------------------------------
 1 file changed, 7 insertions(+), 72 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b9b35ef86d9b..50c8d402516f 100644
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
@@ -1450,13 +1398,6 @@ bool zswap_store(struct folio *folio)
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
@@ -1522,13 +1463,9 @@ bool zswap_store(struct folio *folio)
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
@@ -1682,8 +1619,6 @@ static int zswap_debugfs_init(void)
 			    zswap_debugfs_root, NULL, &total_size_fops);
 	debugfs_create_atomic_t("stored_pages", 0444,
 				zswap_debugfs_root, &zswap_stored_pages);
-	debugfs_create_atomic_t("same_filled_pages", 0444,
-				zswap_debugfs_root, &zswap_same_filled_pages);
 
 	return 0;
 }
-- 
2.43.0


