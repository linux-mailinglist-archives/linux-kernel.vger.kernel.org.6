Return-Path: <linux-kernel+bounces-346900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C198CAA2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A97FB2092F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A757567D;
	Wed,  2 Oct 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqFEy/aF"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E4138E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832046; cv=none; b=mCJStKMKU7awg3cHkAwJS0qjQMMUbuu3ZJGRCkqBenGwTy06kHQpyEPSmhDgIxglc+n6R5W5biNJAE1/YkQYqCupg2biM+gE6yuWjq3ezEEDEIgQ1vBMEgQfJObmQ647gfBhzJnsWfPHPbobGFYneZavxUOiM+Q5/5bTZQDi8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832046; c=relaxed/simple;
	bh=bXZIiUrlpD3XJjThiTWMwsfq77OBHBWfJ9PuXHtYi6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEVrxnezBy4Kp6Nz2d9bQPW0nPW/NMWyTeOKaBNqLrYA4fv30+rBss2e5MQlrUskrZbWdnJDVM9ZgM2NXW1BPaX+G8OPCTnMZ7OpXZXNoVEOakX595AJGe2e1mWrNlJ6y5BH51+WNQFid6KSf7T484jPJbQ2MtD0OXT3Ul9e7Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqFEy/aF; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ddd138e0d0so55868467b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 18:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727832044; x=1728436844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utFR9zmlqHgm/5JvxynF3o1HACmZNmPmIIYRg2mm7i0=;
        b=hqFEy/aFUO3tZXbZdpkqR1bT1OxBkGobotWKm3LI09BJd0fFXMzoXBGji/+EAfeEYs
         L8jnWJgC2O065A3mG44fSC40NyzOKb70pgRPOkTNdmVSNUNe06Hz5sdrjdDceVSFTcXm
         xmxRGNywJesZc+D6M08hX3Uysbz7Bg8SUhtMaLBD6m6ljJm9Jiihi4OAy9h5r5BwRqJt
         CWH9rpEHOD2GUZEqqarSTt/M6QJ7ToWUkHq88DIVNjsr/N4VAKYfmvsEm0V/mPnE+R2u
         GqOXtHxBC4F2OcFGEmvyL251AGugn6o12wAMMk9QTm5RyGONbC0jQnTcJ8YWjAXWM4+B
         /R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727832044; x=1728436844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utFR9zmlqHgm/5JvxynF3o1HACmZNmPmIIYRg2mm7i0=;
        b=T51Rk4nL1p+9r7EoItsbvRKQNUdGGhoZny0X1jzzwtviocK7qEq3Jbq0QHGjUO7H/b
         tYFhjSDLwaejMUgvYnkE+ewsE+Mz18efESwbqDhYFTCjkvN3iiYXQkwT5Xj/OUH668CD
         DoCig9+FkZl/x3UvtN5CK2JM58FzzLeK2kHMVttC5D67yOLrdI5yOcH92T9BRIlG5FPk
         x8BrojbPuKCcHT+uSoiD3aoybIB9T5X1MFhohlxAOPT1avuXqRRoRvIg10YNIjt4frNw
         1lN5WMW3TGrqLMZjAVNSyaviJr2+ZxoBULtHT38cVKKG0OupD0vADUk4qslJ/9+aRbHX
         HHjA==
X-Forwarded-Encrypted: i=1; AJvYcCVOH4oqai5Ly5xodkSawFkDwDX5v4j5h3GlwQ3HlwWcG2loc2XMm8fZj6AGIiTeEjkXhMVOrWpJRksu1V4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5IjV4fTnsHQVK01SghuSj6qvB55uQwMd6DHgutG179+aRZOB
	1zMVQNxX9ZuwgSBcYkhOkXBXOpcpl0A82b3y3Jos802s8WGQO/3V
X-Google-Smtp-Source: AGHT+IHtucbPLaNpcrLB+B6VLBX8j1Ni5DiJX6AZ+B2nx3ZvFau3S4sggAqq8GnraKziEGfIygLpSQ==
X-Received: by 2002:a05:690c:2a41:b0:6db:db51:c02d with SMTP id 00721157ae682-6e2a2e088demr14041587b3.25.1727832043859;
        Tue, 01 Oct 2024 18:20:43 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24536992dsm22244397b3.96.2024.10.01.18.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:20:43 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	hughd@google.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	willy@infradead.org,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	chengming.zhou@linux.dev,
	v-songbaohua@oppo.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
Date: Tue,  1 Oct 2024 18:20:42 -0700
Message-ID: <20241002012042.2753174-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002012042.2753174-1-nphamcs@gmail.com>
References: <20241002012042.2753174-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SWAP_MAP_SHMEM state was introduced in the commit aaa468653b4a
("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if a swap entry
belongs to shmem during swapoff.

However, swapoff has since been rewritten in the commit b56a2d8af914
("mm: rid swapoff of quadratic complexity"). Now having swap count ==
SWAP_MAP_SHMEM value is basically the same as having swap count == 1,
and swap_shmem_alloc() behaves analogously to swap_duplicate(). The only
difference of note is that swap_shmem_alloc() does not check for
-ENOMEM returned from __swap_duplicate(), but it is OK because shmem
never re-duplicates any swap entry it owns. This will stil be safe if we
use (batched) swap_duplicate() instead.

This commit adds swap_duplicate_nr(), the batched variant of
swap_duplicate(), and removes the SWAP_MAP_SHMEM state and the
associated swap_shmem_alloc() helper to simplify the state machine (both
mentally and in terms of actual code). We will also have an extra
state/special value that can be repurposed (for swap entries that never
gets re-duplicated).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 16 ++++++++--------
 mm/shmem.c           |  2 +-
 mm/swapfile.c        | 41 +++++++++++++++++++++--------------------
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ca533b478c21..017f3c03ff7a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -232,7 +232,6 @@ enum {
 /* Special value in first swap_map */
 #define SWAP_MAP_MAX	0x3e	/* Max count */
 #define SWAP_MAP_BAD	0x3f	/* Note page is bad */
-#define SWAP_MAP_SHMEM	0xbf	/* Owned by shmem/tmpfs */
 
 /* Special value in each swap_map continuation */
 #define SWAP_CONT_MAX	0x7f	/* Max count */
@@ -482,8 +481,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
 extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t, int);
-extern int swap_duplicate(swp_entry_t);
+extern int swap_duplicate_nr(swp_entry_t, int);
 extern int swapcache_prepare(swp_entry_t entry, int nr);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
@@ -549,11 +547,7 @@ static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
-{
-}
-
-static inline int swap_duplicate(swp_entry_t swp)
+static inline int swap_duplicate_nr(swp_entry_t swp, int nr)
 {
 	return 0;
 }
@@ -606,6 +600,12 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 }
 #endif /* CONFIG_SWAP */
 
+static inline int swap_duplicate(swp_entry_t entry)
+{
+	return swap_duplicate_nr(entry, 1);
+}
+
+
 static inline void free_swap_and_cache(swp_entry_t entry)
 {
 	free_swap_and_cache_nr(entry, 1);
diff --git a/mm/shmem.c b/mm/shmem.c
index 0613421e09e7..e3f72f99be32 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1561,7 +1561,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
 			NULL) == 0) {
 		shmem_recalc_inode(inode, 0, nr_pages);
-		swap_shmem_alloc(swap, nr_pages);
+		swap_duplicate_nr(swap, nr_pages);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(swap));
 
 		mutex_unlock(&shmem_swaplist_mutex);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0cded32414a1..9bb94e618914 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1381,12 +1381,6 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
 	if (usage == SWAP_HAS_CACHE) {
 		VM_BUG_ON(!has_cache);
 		has_cache = 0;
-	} else if (count == SWAP_MAP_SHMEM) {
-		/*
-		 * Or we could insist on shmem.c using a special
-		 * swap_shmem_free() and free_shmem_swap_and_cache()...
-		 */
-		count = 0;
 	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
 		if (count == COUNT_CONTINUED) {
 			if (swap_count_continued(si, offset, count))
@@ -3626,7 +3620,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 
 	offset = swp_offset(entry);
 	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-	VM_WARN_ON(usage == 1 && nr > 1);
 	ci = lock_cluster_or_swap_info(si, offset);
 
 	err = 0;
@@ -3652,6 +3645,13 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 				err = -EEXIST;
 		} else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
 			err = -EINVAL;
+		} else {
+			/*
+			 * The only swap_duplicate_nr() caller that passes nr > 1 is shmem,
+			 * who never re-duplicates any swap entry it owns. So this should
+			 * not happen.
+			 */
+			VM_WARN_ON(nr > 1 && (count & ~COUNT_CONTINUED) == SWAP_MAP_MAX);
 		}
 
 		if (err)
@@ -3686,27 +3686,28 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	return err;
 }
 
-/*
- * Help swapoff by noting that swap entry belongs to shmem/tmpfs
- * (in which case its reference count is never incremented).
- */
-void swap_shmem_alloc(swp_entry_t entry, int nr)
-{
-	__swap_duplicate(entry, SWAP_MAP_SHMEM, nr);
-}
-
-/*
- * Increase reference count of swap entry by 1.
+/**
+ * swap_duplicate_nr() - Increase reference count of nr contiguous swap entries
+ *                       by 1.
+ *
+ * @entry: first swap entry from which we want to increase the refcount.
+ * @nr: Number of entries in range.
+ *
  * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
  * but could not be atomically allocated.  Returns 0, just as if it succeeded,
  * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
  * might occur if a page table entry has got corrupted.
+ *
+ * Note that we are currently not handling the case where nr > 1 and we need to
+ * add swap count continuation. This is OK, because no such user exists - shmem
+ * is the only user that can pass nr > 1, and it never re-duplicates any swap
+ * entry it owns.
  */
-int swap_duplicate(swp_entry_t entry)
+int swap_duplicate_nr(swp_entry_t entry, int nr)
 {
 	int err = 0;
 
-	while (!err && __swap_duplicate(entry, 1, 1) == -ENOMEM)
+	while (!err && __swap_duplicate(entry, 1, nr) == -ENOMEM)
 		err = add_swap_count_continuation(entry, GFP_ATOMIC);
 	return err;
 }
-- 
2.43.5

