Return-Path: <linux-kernel+bounces-376855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547819AB6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1114328433B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2141CC170;
	Tue, 22 Oct 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLV8LKW/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864D1CC147
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625402; cv=none; b=j8kJqtDf3Dwp7gMoOZwmf7Fu2lKtKoe8izwSZP9zkvtu6pZztOrU3M4s0mmSIeGUmslqPg4Rj+BsR9N+7v4yquDuScLqNVieVPEujNHqIDJVwvwssJf0ft+hzG44sj7CCG3l0GldIoVFXrY0Gt3mfAl0glTVc3+ty8XZrZqMH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625402; c=relaxed/simple;
	bh=S89AjvCf10QAQEB180eARz2dVWIi+LixjhJPB50JqH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZxmwhV5NkrQzIsxhr6I2RcZCpK9f7Veiz2Cn+KS1MwYvQV9fK3oa5FQw5+hJJKZ23YM2dLc6Ag6JCM12UnSkoxDPSxwAKjzL85GVLBmXhw9LkcqPW/gVCIWQcahQvtJmsm523nGnMsvmsKnKcRKuOq4oXc96JKyL7rKcwJB1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLV8LKW/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c6f492d2dso69674285ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625398; x=1730230198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=De6FNmrDX2CsofmiG4+hb8nOrMhL9lIlNsptB1OQpyI=;
        b=jLV8LKW/pzkzN0RWZJjfM+e8YOTCyuZe6EfKXwtV2HgEhg35GLilzYoHd0Vi64nxvt
         1PuMSSGFbaDlKCKfFASD/BBVATt2tH5YzWSHXKUK80UkIYakyziadqUQIAfPmI8+/byW
         bkMNm3NsrbWTqqZClAxEhfaZmvC5BbxAl9WTYY7JTxqrb8PwxzhQ/UScSXn3ItMH9ZOP
         KJh3IMGCvEHLGBd3TDeNS2XYK/jHdniloWl1atb3X4fCM/ljkWOO3xylK7I6c530CtMp
         SepG7af0Ty+zAqKRtVPsIxUlvv+Wz74hEnFy3uHdOtKXm51QMfMblu1+4P9T1UNDgtR3
         LI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625398; x=1730230198;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=De6FNmrDX2CsofmiG4+hb8nOrMhL9lIlNsptB1OQpyI=;
        b=ZM2UQZ92va2e6atViOIyfK4CLHTeIz4x7OU4F+DV7w7gDoKFvyXQMTGI1AmqdsIAje
         BzQagOpCBMtjcOz6hA5GYtzKW99d5m/9KPGsn4NfJFJbpHHouMn09RJ31WoxtBC1t+L3
         CdCqnj7QEMllmLGz+aDk/xW4CCehy4Gg6gxjySfpCuXV9DNUnZMJoUdz7ExfNr3mrZ9F
         COZhoAlNYCu6Vqty7/6cHfkzaX1y4aduBvvHFV9K50eBxdZo/saaO8iYuX4WTS2fG6mM
         2wJQj6BVgTJrjOz2jmzjIDK7cZ+8okYOLwbQZD4Wo5uby1HqmG0tY+26S2b7Z8cA0RTO
         Bcog==
X-Forwarded-Encrypted: i=1; AJvYcCU8VduGJU0HMsR2HPfGaq+RfbNOKlO6/7f8XG8ERKSo7QmWcA4woKov1gTN2cRHE1sG33AIqwpTGuIBgC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiwg5iaCF3ZF7DxhfAzNLwJh5zpXr4vS1IU7XTbFqueHjieao
	JiDlfSrshd5PMDLUslqeKX/hCINto0KSd7Vz9cIGdj7ytURQLqmp
X-Google-Smtp-Source: AGHT+IG648J4NAU1H2vV7qvnmugjAT+R3eqfpZK2sgM9OZGK+vlJTzeCTjXDpzcoLaWx1v4aNcZg4Q==
X-Received: by 2002:a17:903:18e:b0:20b:6918:30b5 with SMTP id d9443c01a7336-20fa9e9f77emr3186585ad.41.1729625398260;
        Tue, 22 Oct 2024 12:29:58 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.29.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:29:57 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 04/13] mm, swap: use cluster lock for HDD
Date: Wed, 23 Oct 2024 03:24:42 +0800
Message-ID: <20241022192451.38138-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022192451.38138-1-ryncsn@gmail.com>
References: <20241022192451.38138-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Cluster lock (ci->lock) was introduce to reduce contention for certain
operations. Using cluster lock for HDD is not helpful as HDD have a poor
performance, so locking isn't the bottleneck. But having different set
of locks for HDD / non-HDD prevents further rework of device lock
(si->lock).

This commit just changed all lock_cluster_or_swap_info to lock_cluster,
which is a safe and straight conversion since cluster info is always
allocated now, also removed all cluster_info related checks.

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 107 ++++++++++++++++----------------------------------
 1 file changed, 34 insertions(+), 73 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ffdf7eedecb5..f8e70bb5f1d7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -58,10 +58,9 @@ static void swap_entry_range_free(struct swap_info_struct *si, swp_entry_t entry
 static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 			     unsigned int nr_entries);
 static bool folio_swapcache_freeable(struct folio *folio);
-static struct swap_cluster_info *lock_cluster_or_swap_info(
-		struct swap_info_struct *si, unsigned long offset);
-static void unlock_cluster_or_swap_info(struct swap_info_struct *si,
-					struct swap_cluster_info *ci);
+static struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
+					      unsigned long offset);
+static void unlock_cluster(struct swap_cluster_info *ci);
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
@@ -222,9 +221,9 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	 * swap_map is HAS_CACHE only, which means the slots have no page table
 	 * reference or pending writeback, and can't be allocated to others.
 	 */
-	ci = lock_cluster_or_swap_info(si, offset);
+	ci = lock_cluster(si, offset);
 	need_reclaim = swap_is_has_cache(si, offset, nr_pages);
-	unlock_cluster_or_swap_info(si, ci);
+	unlock_cluster(ci);
 	if (!need_reclaim)
 		goto out_unlock;
 
@@ -404,45 +403,15 @@ static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si
 {
 	struct swap_cluster_info *ci;
 
-	ci = si->cluster_info;
-	if (ci) {
-		ci += offset / SWAPFILE_CLUSTER;
-		spin_lock(&ci->lock);
-	}
-	return ci;
-}
-
-static inline void unlock_cluster(struct swap_cluster_info *ci)
-{
-	if (ci)
-		spin_unlock(&ci->lock);
-}
-
-/*
- * Determine the locking method in use for this device.  Return
- * swap_cluster_info if SSD-style cluster-based locking is in place.
- */
-static inline struct swap_cluster_info *lock_cluster_or_swap_info(
-		struct swap_info_struct *si, unsigned long offset)
-{
-	struct swap_cluster_info *ci;
-
-	/* Try to use fine-grained SSD-style locking if available: */
-	ci = lock_cluster(si, offset);
-	/* Otherwise, fall back to traditional, coarse locking: */
-	if (!ci)
-		spin_lock(&si->lock);
+	ci = &si->cluster_info[offset / SWAPFILE_CLUSTER];
+	spin_lock(&ci->lock);
 
 	return ci;
 }
 
-static inline void unlock_cluster_or_swap_info(struct swap_info_struct *si,
-					       struct swap_cluster_info *ci)
+static inline void unlock_cluster(struct swap_cluster_info *ci)
 {
-	if (ci)
-		unlock_cluster(ci);
-	else
-		spin_unlock(&si->lock);
+	spin_unlock(&ci->lock);
 }
 
 /* Add a cluster to discard list and schedule it to do discard */
@@ -558,9 +527,6 @@ static void inc_cluster_info_page(struct swap_info_struct *si,
 	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
 	struct swap_cluster_info *ci;
 
-	if (!cluster_info)
-		return;
-
 	ci = cluster_info + idx;
 	ci->count++;
 
@@ -576,9 +542,6 @@ static void inc_cluster_info_page(struct swap_info_struct *si,
 static void dec_cluster_info_page(struct swap_info_struct *si,
 				  struct swap_cluster_info *ci, int nr_pages)
 {
-	if (!si->cluster_info)
-		return;
-
 	VM_BUG_ON(ci->count < nr_pages);
 	VM_BUG_ON(cluster_is_free(ci));
 	lockdep_assert_held(&si->lock);
@@ -995,8 +958,6 @@ static int cluster_alloc_swap(struct swap_info_struct *si,
 {
 	int n_ret = 0;
 
-	VM_BUG_ON(!si->cluster_info);
-
 	while (n_ret < nr) {
 		unsigned long offset = cluster_alloc_swap_entry(si, order, usage);
 
@@ -1036,10 +997,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		}
 
 		/*
-		 * Swapfile is not block device or not using clusters so unable
+		 * Swapfile is not block device so unable
 		 * to allocate large entries.
 		 */
-		if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
+		if (!(si->flags & SWP_BLKDEV))
 			return 0;
 	}
 
@@ -1279,9 +1240,9 @@ static unsigned char __swap_entry_free(struct swap_info_struct *si,
 	unsigned long offset = swp_offset(entry);
 	unsigned char usage;
 
-	ci = lock_cluster_or_swap_info(si, offset);
+	ci = lock_cluster(si, offset);
 	usage = __swap_entry_free_locked(si, offset, 1);
-	unlock_cluster_or_swap_info(si, ci);
+	unlock_cluster(ci);
 	if (!usage)
 		free_swap_slot(entry);
 
@@ -1304,14 +1265,14 @@ static bool __swap_entries_free(struct swap_info_struct *si,
 	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
 		goto fallback;
 
-	ci = lock_cluster_or_swap_info(si, offset);
+	ci = lock_cluster(si, offset);
 	if (!swap_is_last_map(si, offset, nr, &has_cache)) {
-		unlock_cluster_or_swap_info(si, ci);
+		unlock_cluster(ci);
 		goto fallback;
 	}
 	for (i = 0; i < nr; i++)
 		WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
-	unlock_cluster_or_swap_info(si, ci);
+	unlock_cluster(ci);
 
 	if (!has_cache) {
 		for (i = 0; i < nr; i++)
@@ -1367,7 +1328,7 @@ static void cluster_swap_free_nr(struct swap_info_struct *si,
 	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
 	int i, nr;
 
-	ci = lock_cluster_or_swap_info(si, offset);
+	ci = lock_cluster(si, offset);
 	while (nr_pages) {
 		nr = min(BITS_PER_LONG, nr_pages);
 		for (i = 0; i < nr; i++) {
@@ -1375,18 +1336,18 @@ static void cluster_swap_free_nr(struct swap_info_struct *si,
 				bitmap_set(to_free, i, 1);
 		}
 		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
-			unlock_cluster_or_swap_info(si, ci);
+			unlock_cluster(ci);
 			for_each_set_bit(i, to_free, BITS_PER_LONG)
 				free_swap_slot(swp_entry(si->type, offset + i));
 			if (nr == nr_pages)
 				return;
 			bitmap_clear(to_free, 0, BITS_PER_LONG);
-			ci = lock_cluster_or_swap_info(si, offset);
+			ci = lock_cluster(si, offset);
 		}
 		offset += nr;
 		nr_pages -= nr;
 	}
-	unlock_cluster_or_swap_info(si, ci);
+	unlock_cluster(ci);
 }
 
 /*
@@ -1425,9 +1386,9 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	if (!si)
 		return;
 
-	ci = lock_cluster_or_swap_info(si, offset);
+	ci = lock_cluster(si, offset);
 	if (size > 1 && swap_is_has_cache(si, offset, size)) {
-		unlock_cluster_or_swap_info(si, ci);
+		unlock_cluster(ci);
 		spin_lock(&si->lock);
 		swap_entry_range_free(si, entry, size);
 		spin_unlock(&si->lock);
@@ -1435,14 +1396,14 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	}
 	for (int i = 0; i < size; i++, entry.val++) {
 		if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE)) {
-			unlock_cluster_or_swap_info(si, ci);
+			unlock_cluster(ci);
 			free_swap_slot(entry);
 			if (i == size - 1)
 				return;
-			lock_cluster_or_swap_info(si, offset);
+			lock_cluster(si, offset);
 		}
 	}
-	unlock_cluster_or_swap_info(si, ci);
+	unlock_cluster(ci);
 }
 
 static int swp_entry_cmp(const void *ent1, const void *ent2)
@@ -1506,9 +1467,9 @@ int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
 	struct swap_cluster_info *ci;
 	int count;
 
-	ci = lock_cluster_or_swap_info(si, offset);
+	ci = lock_cluster(si, offset);
 	count = swap_count(si->swap_map[offset]);
-	unlock_cluster_or_swap_info(si, ci);
+	unlock_cluster(ci);
 	return count;
 }
 
@@ -1531,7 +1492,7 @@ int swp_swapcount(swp_entry_t entry)
 
 	offset = swp_offset(entry);
 
-	ci = lock_cluster_or_swap_info(si, offset);
+	ci = lock_cluster(si, offset);
 
 	count = swap_count(si->swap_map[offset]);
 	if (!(count & COUNT_CONTINUED))
@@ -1554,7 +1515,7 @@ int swp_swapcount(swp_entry_t entry)
 		n *= (SWAP_CONT_MAX + 1);
 	} while (tmp_count & COUNT_CONTINUED);
 out:
-	unlock_cluster_or_swap_info(si, ci);
+	unlock_cluster(ci);
 	return count;
 }
 
@@ -1569,8 +1530,8 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 	int i;
 	bool ret = false;
 
-	ci = lock_cluster_or_swap_info(si, offset);
-	if (!ci || nr_pages == 1) {
+	ci = lock_cluster(si, offset);
+	if (nr_pages == 1) {
 		if (swap_count(map[roffset]))
 			ret = true;
 		goto unlock_out;
@@ -1582,7 +1543,7 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 		}
 	}
 unlock_out:
-	unlock_cluster_or_swap_info(si, ci);
+	unlock_cluster(ci);
 	return ret;
 }
 
@@ -3412,7 +3373,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	offset = swp_offset(entry);
 	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
 	VM_WARN_ON(usage == 1 && nr > 1);
-	ci = lock_cluster_or_swap_info(si, offset);
+	ci = lock_cluster(si, offset);
 
 	err = 0;
 	for (i = 0; i < nr; i++) {
@@ -3467,7 +3428,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	}
 
 unlock_out:
-	unlock_cluster_or_swap_info(si, ci);
+	unlock_cluster(ci);
 	return err;
 }
 
-- 
2.47.0


