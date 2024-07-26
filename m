Return-Path: <linux-kernel+bounces-263068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2FA93D095
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D891C21192
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A694176AAC;
	Fri, 26 Jul 2024 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyxP2Eii"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D31EF01
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987232; cv=none; b=GAGvUbr5QzzfqWF3xUR3p3bY4gUm1BPEJDFzQeDsIdMM5WZTHEzSS0DNd2Ssiy5L5f0iyDR3P2/uUvhrEZ6X4yWUP32zWFt7KzP2sVutQNRjJ2hRwr6w3ggffGZSGESIJ6XzLpvpHaqpbg6xMBx32fqnLcsN3QIlq7FXnRUNCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987232; c=relaxed/simple;
	bh=PUj5ojexLJ60vx2MwAGXmDubNxRUIGVJzH5fevy9KUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSEflDTctjDj0TPnxDK3cuEu40PCZWYaIA51Cl5/5U7St2iGj7ux0y5UhbJM+ekvBN/GgeyqCfR7IuTUZejcBzTIcf9dKvlnytirusg35E6hKPjXSKxjVxSnuXhR/nkaP8FGxM5ql4FFK7sjAo1PyGNbCYsSw+Wak3BUy2WNyY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyxP2Eii; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so522488b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721987230; x=1722592030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QemnTZhx46SI6yTUVPx+f2+oh78G0V4lHylINHFTYuU=;
        b=jyxP2Eii6yzLpwQfPlNKZora3ha5aS489IEYgHdtL79JUq4vo04a40KPDOKbsZz0yO
         oOoCvF553T4YNtCRbEQqj5RTudL+Sk5370pvxO3FVGHtyXIwW0Kyc4S6doQZPjkmqWFd
         RKhfYthjPjCVr7W+nxwXdqeEawNrD29LLFkS6flTwtiAnzL0hRErPd7shR+nhyKP5xx1
         Jsjzi3RkdHdHTXA9ZCIqFfQS4NhKwkKmGu5wMGd1iUtMYwTujVRhfKqZTYlyEqvGclg9
         XHIWb6dLXPOE1vSLKKHyv396Hiq7F44yxKE0576cLBbGwgy7hryiDlJuHGziExPWV+EH
         yGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721987230; x=1722592030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QemnTZhx46SI6yTUVPx+f2+oh78G0V4lHylINHFTYuU=;
        b=GUQ6LbmwGkxJc4CkO4zw83LOKabJbjAXRtGrRFXcuA3TjZW8iWesQSDQuItG4eZ3N5
         Qrjg4bNUMzPvxDchTLZqsftgga6GBX8f+ahnGM0UX9AR2G0SBXXS7HkM0DOJX9vNxSpC
         d4Gs05Mm+iPbtdjOeCD8r+wQlw2xVOWeysmBXTGRGk7jAvmt7oTi9617NkKtHftXWWoq
         cl6enDzPQMaWsL6pWzgjv9viZeH2GGC5ddW8WoLfZiYtmz4W/ZhrjqxiQ2QLvCQI5XRf
         sFUyvtNELH7QpFehXETviN1zoovemgyl06cDpji82NoJLaODri8Msnb52Feie/mXalIk
         WO7w==
X-Forwarded-Encrypted: i=1; AJvYcCXmSI28SpvVewxGs1SpBMY1d3z8e0vlMnncnSt0idM9F/T3N/ySeqU9UoD39CB6jPQQrPGrBEJ54oCJV/mQbwskDnbkL6j672gRQ6/R
X-Gm-Message-State: AOJu0Ywf2DEpp/77JNevCKHZlMVJCeBFdTsOPYbLLYHZNAtwhzseojaS
	SLvg0iGBPxI6Gw+3ooZ4Miw4/QWts3Il7lJaDITMyzqO3tM1lQQE1xAVeg==
X-Google-Smtp-Source: AGHT+IEuYL/V6q+/Rf3zyV7tTxuHUrsd/jgokfNn9VNFhVU1hmhRuwtOEWzWwCDmdE70qZ7N+f0uTQ==
X-Received: by 2002:a05:6a21:390:b0:1c4:23f0:9665 with SMTP id adf61e73a8af0-1c472aaeb54mr6667769637.29.1721987229972;
        Fri, 26 Jul 2024 02:47:09 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d15e98sm28127455ad.99.2024.07.26.02.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 02:47:09 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: ying.huang@intel.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	yosryahmed@google.com
Subject: [PATCH v5 1/4] mm: swap: introduce swapcache_prepare_nr and swapcache_clear_nr for large folios swap-in
Date: Fri, 26 Jul 2024 21:46:15 +1200
Message-Id: <20240726094618.401593-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726094618.401593-1-21cnbao@gmail.com>
References: <20240726094618.401593-1-21cnbao@gmail.com>
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

To optimize stack usage, we iterate twice in __swap_duplicate_nr(): the
first time to verify that all entries are valid, and the second time to
apply the modifications to the entries.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/swap.h |   9 +++-
 mm/swap.h            |  10 ++++-
 mm/swapfile.c        | 102 ++++++++++++++++++++++++++-----------------
 3 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ba7ea95d1c57..f1b28fd04533 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -480,7 +480,7 @@ extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
-extern int swapcache_prepare(swp_entry_t);
+extern int swapcache_prepare_nr(swp_entry_t entry, int nr);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
@@ -554,7 +554,7 @@ static inline int swap_duplicate(swp_entry_t swp)
 	return 0;
 }
 
-static inline int swapcache_prepare(swp_entry_t swp)
+static inline int swapcache_prepare_nr(swp_entry_t swp, int nr)
 {
 	return 0;
 }
@@ -612,6 +612,11 @@ static inline void swap_free(swp_entry_t entry)
 	swap_free_nr(entry, 1);
 }
 
+static inline int swapcache_prepare(swp_entry_t entry)
+{
+	return swapcache_prepare_nr(entry, 1);
+}
+
 #ifdef CONFIG_MEMCG
 static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 {
diff --git a/mm/swap.h b/mm/swap.h
index baa1fa946b34..81ff7eb0be9c 100644
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
 
@@ -172,4 +172,10 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 	return 0;
 }
 #endif /* CONFIG_SWAP */
+
+static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+	swapcache_clear_nr(si, entry, 1);
+}
+
 #endif /* _MM_SWAP_H */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5f73a8553371..e688e46f1c62 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3363,7 +3363,7 @@ void si_swapinfo(struct sysinfo *val)
 }
 
 /*
- * Verify that a swap entry is valid and increment its swap map count.
+ * Verify that nr swap entries are valid and increment their swap map counts.
  *
  * Returns error code in following case.
  * - success -> 0
@@ -3373,66 +3373,88 @@ void si_swapinfo(struct sysinfo *val)
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
@@ -3459,23 +3481,23 @@ int swap_duplicate(swp_entry_t entry)
 }
 
 /*
- * @entry: swap entry for which we allocate swap cache.
+ * @entry: first swap entry from which we allocate nr swap cache.
  *
- * Called when allocating swap cache for existing swap entry,
+ * Called when allocating swap cache for existing swap entries,
  * This can return error codes. Returns 0 at success.
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
 	unsigned long offset = swp_offset(entry);
 
-	cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
+	cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
 }
 
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
-- 
2.34.1


