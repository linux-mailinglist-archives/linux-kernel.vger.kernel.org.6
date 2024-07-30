Return-Path: <linux-kernel+bounces-266904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39354940943
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD0E1C222C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E77919048F;
	Tue, 30 Jul 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqV6obWX"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C85710F7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323661; cv=none; b=VStnYgjIA/2hL2XP4gh2/cnjZ01RASdj+mFXxyshruN8hW+fogvE3AeRqPD10jc48M19XbWmx+wcdTvA+mSge+hBI47FkHbt31SH28Qfp25LG99JQ2VMFqP1ZcqkJmY+jnrpLmcfVDjFWZgcX+FcTtHRpbzelwxPieDPAfA1fYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323661; c=relaxed/simple;
	bh=tOYa3BAa3s3UUa80u5OzrF+Gnrz/WT5QSTu557hACvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZgrOXdD+QgXJfaeoiGuB67aaupS57ks4hsPW/+7VCnJC/FgTPGg4+xrBHFpl64NUCcbyekvCNq8Uq4vNKcckpNJ4a9f6FXEwMo2UatVd4XotyOE9GVSUcVqyCF/kg039OeIcZLzNUG1vvBDr0x7UAy7vcPEbsxxXx/BN6YoAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqV6obWX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-710437d0affso2692030a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722323659; x=1722928459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQpazpiL2+G6+cUit2O/uKGCRhu7hXvuY55j9nmwkok=;
        b=KqV6obWXAALH+L1VIrwovf1w8LC0eoc+KeAI5EyHGbOD/pBMeu3uIsLhubSdw/oUwW
         BwWqr5I3KgUTwNnV7U5wwwjnEhft7m4WgIw8/5cOetpN1bkxk7JpErmV21Pdp9O1wmQ0
         mn69M9pDlIDb6Z1kJbMettO+uwh7fs7pTDcD/UIgXKz7v7NOn8ldRgseFun7HHtXNJuV
         E+yhPk4yAJIjONHTtybXKzRvq8Zeo7lhqQrRk5RCJvd6wcrMFhVfOBW3IY/TxrAJwCow
         1SX0HazrNOS1LQExNazjrr+t5mK8X24zsAD76hV5lc+on4RSJHoEgFAdMzo7thFv+lV/
         16og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722323659; x=1722928459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQpazpiL2+G6+cUit2O/uKGCRhu7hXvuY55j9nmwkok=;
        b=fXORCgOHwgGh+Nk10vkFIjXld+0YW+3PG84vU55h4qs2XstJbIJZpMTW1w57JHw1Q+
         rzHZaWLAdFTvnljiuOF2GHw00Sr2b87R317LsFTcEf5ZUalmPP2SQdYm6PNhDzc0wGzg
         ueWD+WXu0GRKgq+b1h3LPMyvMBZtYkMcoLoJtS0YayrbzOg4Ob3RacjsC46aOkTARYcn
         FXg5ys2P65p+pb4iTAUxCcbmoDkL+5k/qIud2lIpNRAIWVkOhP4unPoAxDHxAvS/hfFX
         0gp8Vah4e6L1i56d9XGtlDSvItb2j+Dx2Y6grC8xAZwWMxhvndFO1HUZJLY22unVFWDV
         YpRg==
X-Forwarded-Encrypted: i=1; AJvYcCVA/ICD3ERUhV6uIh7//l7r1tWQCNqFPRIOEINVLrRDe1ny01W37to8ncqQH/IcBU0ONIBBko+ZF+iz3k8wfazFg+6HA8lfApCPMi4t
X-Gm-Message-State: AOJu0YywLYox698Z4r/i6jjcmGR+ftRTZ9p3k9NZRqo3X8vANZsfgh25
	yEDuidgk9iVrYUTk+FgoBomAd9jeMKiobAJ01Vk05GNRW8vEZeRyfp/rNXVE
X-Google-Smtp-Source: AGHT+IHR2F/7cQC2eRe07LF6FoMylryQEtNYGOLQZT983NzYLofRYEI2eSotTa1j3Z1dqT2SWoxLsg==
X-Received: by 2002:a05:6a21:8cc8:b0:1c0:f5ea:d447 with SMTP id adf61e73a8af0-1c4a130cd94mr9351287637.31.1722323658755;
        Tue, 30 Jul 2024 00:14:18 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28de71a1sm9736452a91.41.2024.07.30.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:14:18 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
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
	ying.huang@intel.com,
	yosryahmed@google.com
Subject: [PATCH 1/1] mm: swap: add nr argument in swapcache_prepare and swapcache_clear to support large folios
Date: Tue, 30 Jul 2024 19:13:39 +1200
Message-Id: <20240730071339.107447-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730071339.107447-1-21cnbao@gmail.com>
References: <20240730071339.107447-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Right now, swapcache_prepare() and swapcache_clear() supports one entry
only, to support large folios, we need to handle multiple swap entries.

To optimize stack usage, we iterate twice in __swap_duplicate(): the
first time to verify that all entries are valid, and the second time
to apply the modifications to the entries.

Currently, we're using nr=1 for the existing users.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/swap.h |   4 +-
 mm/memory.c          |   6 +--
 mm/swap.h            |   5 ++-
 mm/swap_state.c      |   2 +-
 mm/swapfile.c        | 101 +++++++++++++++++++++++++------------------
 5 files changed, 68 insertions(+), 50 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ba7ea95d1c57..5b920fa2315b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -480,7 +480,7 @@ extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
-extern int swapcache_prepare(swp_entry_t);
+extern int swapcache_prepare(swp_entry_t entry, int nr);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
@@ -554,7 +554,7 @@ static inline int swap_duplicate(swp_entry_t swp)
 	return 0;
 }
 
-static inline int swapcache_prepare(swp_entry_t swp)
+static inline int swapcache_prepare(swp_entry_t swp, int nr)
 {
 	return 0;
 }
diff --git a/mm/memory.c b/mm/memory.c
index 833d2cad6eb2..b8675617a5e3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4081,7 +4081,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 * reusing the same entry. It's undetectable as
 			 * pte_same() returns true due to entry reuse.
 			 */
-			if (swapcache_prepare(entry)) {
+			if (swapcache_prepare(entry, 1)) {
 				/* Relax a bit to prevent rapid repeated page faults */
 				schedule_timeout_uninterruptible(1);
 				goto out;
@@ -4387,7 +4387,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
 	if (need_clear_cache)
-		swapcache_clear(si, entry);
+		swapcache_clear(si, entry, 1);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4403,7 +4403,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_put(swapcache);
 	}
 	if (need_clear_cache)
-		swapcache_clear(si, entry);
+		swapcache_clear(si, entry, 1);
 	if (si)
 		put_swap_device(si);
 	return ret;
diff --git a/mm/swap.h b/mm/swap.h
index baa1fa946b34..7c6330561d84 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -59,7 +59,7 @@ void __delete_from_swap_cache(struct folio *folio,
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
@@ -120,7 +120,7 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 	return 0;
 }
 
-static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
 {
 }
 
@@ -172,4 +172,5 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 	return 0;
 }
 #endif /* CONFIG_SWAP */
+
 #endif /* _MM_SWAP_H */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index a1726e49a5eb..b06f2a054f5a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -477,7 +477,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		/*
 		 * Swap entry may have been freed since our caller observed it.
 		 */
-		err = swapcache_prepare(entry);
+		err = swapcache_prepare(entry, 1);
 		if (!err)
 			break;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5f73a8553371..757d38a86f56 100644
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
@@ -3373,60 +3373,77 @@ void si_swapinfo(struct sysinfo *val)
  * - swap-cache reference is requested but the entry is not used. -> ENOENT
  * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
  */
-static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
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
@@ -3439,7 +3456,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
  */
 void swap_shmem_alloc(swp_entry_t entry)
 {
-	__swap_duplicate(entry, SWAP_MAP_SHMEM);
+	__swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
 }
 
 /*
@@ -3453,29 +3470,29 @@ int swap_duplicate(swp_entry_t entry)
 {
 	int err = 0;
 
-	while (!err && __swap_duplicate(entry, 1) == -ENOMEM)
+	while (!err && __swap_duplicate(entry, 1, 1) == -ENOMEM)
 		err = add_swap_count_continuation(entry, GFP_ATOMIC);
 	return err;
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
+int swapcache_prepare(swp_entry_t entry, int nr)
 {
-	return __swap_duplicate(entry, SWAP_HAS_CACHE);
+	return __swap_duplicate(entry, SWAP_HAS_CACHE, nr);
 }
 
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
 {
 	unsigned long offset = swp_offset(entry);
 
-	cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
+	cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
 }
 
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
-- 
2.34.1


