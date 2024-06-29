Return-Path: <linux-kernel+bounces-234905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E091CC42
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED409281987
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D1545022;
	Sat, 29 Jun 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSyuMovX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E843BBCB
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719659443; cv=none; b=QRvKh2RjBNKrTGPBfKhPwHMofVaM9Jd+pnIiFIRlQUcTv/RdJzKaEr3YoyPHHvOLbmu6MDs7dGgaQsjI7duPtS9e2hSGiTYNyi09ViquyRWd/2Usu4VIAy9GkDdITRfkphNx/Q3jQVSTPNpZBki+OXFWd2tGxh3ssrS2u/Lo5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719659443; c=relaxed/simple;
	bh=SGq2hW/NvZoA82j/tEFoRYZkFisE57WjWOUttKoRE0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QR3zDvYc7Hyg+UU7kVG391TQQMyrVw4TSxJJ+/WaYXdvOWJyGL4ynaaD0eo3HywU5Vx6pdJPJJNYuCCk/TDVyeYzoejMZujjiE93LIooK4g/Jad/Q0d3nmaX6ptkbUSz78pjN9XC8+FM1Bg8SpetTCZQmSbQfZXcOfYEB/FOltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSyuMovX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f480624d10so10574195ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719659441; x=1720264241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIIRuBxsg8MoTkqvJ2vYF4yyI+YXFJLITJS/F7oC53Q=;
        b=FSyuMovX0LUNQF8M5W+5BmHaLnA6FI3pYeGPJ4OSVwIFkmvFaMKcxnh3E1mobNFPub
         4S+9wCU7RTpkCaLIYmSFvyR4hmL1zhKgshiDwwkvRqiHmAbLRcqkss9r6QYK7fnlZkK0
         neU4XQRK+pmex5M7xXpJ0lyC+nT8ygJOFnezWRm71O4fCG8D9nVNJ1T86D12tr+I2uwA
         fccj5S14FaF0rxTV4CAIlgPHOqPSSKSanrUU8rk4V/bm1Yb9r9FJicnu09HM767RMuel
         io19XCwqcckVxa0pNR9za+4DrBla1X8f2h9vcRoTU6ICE0Syypgt7+Pp9XXirBlMh5Qy
         M/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719659441; x=1720264241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIIRuBxsg8MoTkqvJ2vYF4yyI+YXFJLITJS/F7oC53Q=;
        b=K5GJei1iZEecsWOgpJDoWibgYLnMzPD3si3fc+F4JZ3HLgzr4WdiHdMixeUgJqDHcy
         qKs8YTKGChvMY62Wlm8DKMAkEU+O9cTnjsen+7QhnAzSho+1z2+oAe6F96T7s+vODPai
         D+HOtD+zeDd75yAuNs6o8+xnvnCkdqBeYuRnTWk36Z+p65NHbKUo00ZRc9kj8+3V+Pqx
         ZLv4mJm2UxGCL+TNSUdOrDNwjKePlSNtQEQnUwtFDCJSK0yr5E6SWZ81+JGXx3sPJ+yJ
         9Hk5XTT4Frtwmo9cUloZOpxL5a5WJjymf9EyXxGYlZwFyyJiLhTSN1I0J4kd66jFgx2O
         cU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9VNdwh06FQXljEPEXw4l/O/8wQUng3iZOzQ9QM7phFoBNiHQKpHgUU7L8m4Qk9WRNNTmUsBDaWnTcp/jh/gyMSj03TRa7E0Rdj6Z0
X-Gm-Message-State: AOJu0YzlUyHaiZjNTlDTljeap5t6ULgYVr+tzoKj6hGEaz32/vRUp97v
	yhMFjWkuc3rw9tLaLnqc9jec9ihSwyLx2LSrxHUIsbBL6N+aXYUd
X-Google-Smtp-Source: AGHT+IG6qDn8EOGdMtx+wBwudZlM8Ulw9rvzL2rVxiK7pncEZX4lJDneiLE4Y/g+u+PcPoP0vLfGKQ==
X-Received: by 2002:a17:902:d506:b0:1f7:1706:25ba with SMTP id d9443c01a7336-1fadbc84427mr5112845ad.15.1719659440685;
        Sat, 29 Jun 2024 04:10:40 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596920sm30068975ad.268.2024.06.29.04.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 04:10:40 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	surenb@google.com,
	kaleshsingh@google.com,
	hughd@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	baolin.wang@linux.alibaba.com,
	shakeel.butt@linux.dev,
	senozhatsky@chromium.org,
	minchan@kernel.org
Subject: [PATCH RFC v4 1/2] mm: swap: introduce swapcache_prepare_nr and swapcache_clear_nr for large folios swap-in
Date: Sat, 29 Jun 2024 23:10:09 +1200
Message-Id: <20240629111010.230484-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240629111010.230484-1-21cnbao@gmail.com>
References: <20240629111010.230484-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache") supports
one entry only, to support large folio swap-in, we need to handle multiple
swap entries.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/swap.h |   4 +-
 mm/swap.h            |   4 +-
 mm/swapfile.c        | 114 +++++++++++++++++++++++++------------------
 3 files changed, 70 insertions(+), 52 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index e473fe6cfb7a..c0f4f2073ca6 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -481,7 +481,7 @@ extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
-extern int swapcache_prepare(swp_entry_t);
+extern int swapcache_prepare_nr(swp_entry_t entry, int nr);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
@@ -555,7 +555,7 @@ static inline int swap_duplicate(swp_entry_t swp)
 	return 0;
 }
 
-static inline int swapcache_prepare(swp_entry_t swp)
+static inline int swapcache_prepare_nr(swp_entry_t swp, int nr)
 {
 	return 0;
 }
diff --git a/mm/swap.h b/mm/swap.h
index baa1fa946b34..b96b1157441f 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -59,7 +59,7 @@ void __delete_from_swap_cache(struct folio *folio,
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
+void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, int nr);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
@@ -120,7 +120,7 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 	return 0;
 }
 
-static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+static inline void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, int nr)
 {
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f7224bc1320c..8f60dd10fdef 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1352,7 +1352,8 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 }
 
 static void cluster_swap_free_nr(struct swap_info_struct *sis,
-		unsigned long offset, int nr_pages)
+		unsigned long offset, int nr_pages,
+		unsigned char usage)
 {
 	struct swap_cluster_info *ci;
 	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
@@ -1362,7 +1363,7 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
 	while (nr_pages) {
 		nr = min(BITS_PER_LONG, nr_pages);
 		for (i = 0; i < nr; i++) {
-			if (!__swap_entry_free_locked(sis, offset + i, 1))
+			if (!__swap_entry_free_locked(sis, offset + i, usage))
 				bitmap_set(to_free, i, 1);
 		}
 		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
@@ -1396,7 +1397,7 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 
 	while (nr_pages) {
 		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-		cluster_swap_free_nr(sis, offset, nr);
+		cluster_swap_free_nr(sis, offset, nr, 1);
 		offset += nr;
 		nr_pages -= nr;
 	}
@@ -3382,7 +3383,7 @@ void si_swapinfo(struct sysinfo *val)
 }
 
 /*
- * Verify that a swap entry is valid and increment its swap map count.
+ * Verify that nr swap entries are valid and increment their swap map counts.
  *
  * Returns error code in following case.
  * - success -> 0
@@ -3392,66 +3393,88 @@ void si_swapinfo(struct sysinfo *val)
  * - swap-cache reference is requested but the entry is not used. -> ENOENT
  * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
  */
-static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+static int __swap_duplicate_nr(swp_entry_t entry, unsigned char usage, int nr)
 {
 	struct swap_info_struct *p;
 	struct swap_cluster_info *ci;
 	unsigned long offset;
 	unsigned char count;
 	unsigned char has_cache;
-	int err;
+	int err, i;
 
 	p = swp_swap_info(entry);
 
 	offset = swp_offset(entry);
+	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
 	ci = lock_cluster_or_swap_info(p, offset);
 
-	count = p->swap_map[offset];
+	err = 0;
+	for (i = 0; i < nr; i++) {
+		count = p->swap_map[offset + i];
 
-	/*
-	 * swapin_readahead() doesn't check if a swap entry is valid, so the
-	 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
-	 */
-	if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
-		err = -ENOENT;
-		goto unlock_out;
-	}
+		/*
+		 * swapin_readahead() doesn't check if a swap entry is valid, so the
+		 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
+		 */
+		if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
+			err = -ENOENT;
+			goto unlock_out;
+		}
 
-	has_cache = count & SWAP_HAS_CACHE;
-	count &= ~SWAP_HAS_CACHE;
-	err = 0;
+		has_cache = count & SWAP_HAS_CACHE;
+		count &= ~SWAP_HAS_CACHE;
 
-	if (usage == SWAP_HAS_CACHE) {
+		if (usage == SWAP_HAS_CACHE) {
+			/* set SWAP_HAS_CACHE if there is no cache and entry is used */
+			if (!has_cache && count)
+				continue;
+			else if (has_cache)		/* someone else added cache */
+				err = -EEXIST;
+			else				/* no users remaining */
+				err = -ENOENT;
 
-		/* set SWAP_HAS_CACHE if there is no cache and entry is used */
-		if (!has_cache && count)
-			has_cache = SWAP_HAS_CACHE;
-		else if (has_cache)		/* someone else added cache */
-			err = -EEXIST;
-		else				/* no users remaining */
-			err = -ENOENT;
+		} else if (count || has_cache) {
 
-	} else if (count || has_cache) {
+			if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
+				continue;
+			else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
+				err = -EINVAL;
+			else if (swap_count_continued(p, offset + i, count))
+				continue;
+			else
+				err = -ENOMEM;
+		} else
+			err = -ENOENT;			/* unused swap entry */
 
-		if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
+		if (err)
+			goto unlock_out;
+	}
+
+	for (i = 0; i < nr; i++) {
+		count = p->swap_map[offset + i];
+		has_cache = count & SWAP_HAS_CACHE;
+		count &= ~SWAP_HAS_CACHE;
+
+		if (usage == SWAP_HAS_CACHE)
+			has_cache = SWAP_HAS_CACHE;
+		else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
 			count += usage;
-		else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
-			err = -EINVAL;
-		else if (swap_count_continued(p, offset, count))
-			count = COUNT_CONTINUED;
 		else
-			err = -ENOMEM;
-	} else
-		err = -ENOENT;			/* unused swap entry */
+			count = COUNT_CONTINUED;
 
-	if (!err)
-		WRITE_ONCE(p->swap_map[offset], count | has_cache);
+		WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
+	}
 
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
 	return err;
 }
 
+static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+{
+	return __swap_duplicate_nr(entry, usage, 1);
+}
+
 /*
  * Help swapoff by noting that swap entry belongs to shmem/tmpfs
  * (in which case its reference count is never incremented).
@@ -3485,22 +3508,17 @@ int swap_duplicate(swp_entry_t entry)
  * -EEXIST means there is a swap cache.
  * Note: return code is different from swap_duplicate().
  */
-int swapcache_prepare(swp_entry_t entry)
+int swapcache_prepare_nr(swp_entry_t entry, int nr)
 {
-	return __swap_duplicate(entry, SWAP_HAS_CACHE);
+	return __swap_duplicate_nr(entry, SWAP_HAS_CACHE, nr);
 }
 
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, int nr)
 {
-	struct swap_cluster_info *ci;
-	unsigned long offset = swp_offset(entry);
-	unsigned char usage;
+	pgoff_t offset = swp_offset(entry);
 
-	ci = lock_cluster_or_swap_info(si, offset);
-	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
-	unlock_cluster_or_swap_info(si, ci);
-	if (!usage)
-		free_swap_slot(entry);
+	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
+	cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
 }
 
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
-- 
2.34.1


