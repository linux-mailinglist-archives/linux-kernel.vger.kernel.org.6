Return-Path: <linux-kernel+bounces-277545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2960694A2C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E86828707C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D591CB303;
	Wed,  7 Aug 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7l3h44M"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11B1C9EC8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019137; cv=none; b=sH4yUFxwJoyoZ7DVmO1hwFeHLdKussYNwSta89f0mJx6ByFPF1mffsVbt+4bqMWYJHuqZtu4PeIcxleS4/wjuzaiCg7yYhGSLPt3ZGt6xK/VfdzDpg57maMhelOlFonG0XQ4DOS3W9+JeQMOWzlgVi+uJxCqZ24XUm6NAvco5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019137; c=relaxed/simple;
	bh=vFHUEqQ1BbRbYvdkss7zznFtXcpaAU4aiHUJIfCTLw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1aHaLktz7E4yOusD7hW2/NBlbewwjeBkMBdWVkHSUZ4V+PYixm48ArCP0WXIjYvmc+dBCklxtjGBN+gL6pUvNxnCk+//EdwroOR2mGv68ibMOoEGR3s5QLXDth+8mg+Dw3rvvML5/IqPXIylIqSAUnpY7+8MNUPwo3OhpKgGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7l3h44M; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70eb0ae23e4so1222194b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723019134; x=1723623934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdPKEnDMiO3Rq0OJoiXWd7L+WrOyBVW1Yp9rdNsv9MY=;
        b=g7l3h44Mk/3nWFs49xbzCv+fZ31gKdW0BnYSgruxsGZWr21q3QbTXNO+3RnRzSJe/L
         f4kpqKn4zzlUAY+NfJFM4EnEEccNmq5wAIwIJL0W4ZR5De2jniWLuBxtMez7FM0ZjqnF
         CkOQK0RvV+FoWVkQCWWlhTVQR1Po3OJTJu7i9KvcQkRUCOh+zVRHzhPbK23vaQ48G8Vz
         8Fh5xR5SLsaznewdHXxfnYH2nbhRP+C7CEPszRjNZfOfwFc7vqVxtVjmwwdpmJ1naXYH
         2am3sX994ef2RzBAh1f/uIXBRhDH3mge/UZMdyliU5DBoeh2NvydV5OLS0qdn3PuShrc
         wHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723019134; x=1723623934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdPKEnDMiO3Rq0OJoiXWd7L+WrOyBVW1Yp9rdNsv9MY=;
        b=vEH3HlaaVyIO6BZ9xW6snhlDQVYSovxZcZgJoQkZslE4C+sXlmj2sdZGGQbsqN0QPS
         SoO/DsAPx1tsFlUIL7eD6/J//cpgebxEFXfiR7UZUyqiW8P6LpckiqeFlXn1siJes/x6
         XoBRVeLrLDB5sLuSM0++cjZJzYiv78KEIjop6X9IG8iBnIZ9OAPMHDl63eVQ80F84t5g
         83IhG+vbvs1o06Gq+k176Dg0c3fkA0r/P0J7VaqhoUE5z8e4XmpAha/fg2Kzfj66RzMl
         cdO0OQCnpSg9h1HQOUrDYDwRUEl5bO2S4R+AJyWor/4uUzQy7y0ikkXHFIkmgPHAZa0m
         2x1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBgFOJf4d42NBi2WGSVNrqJ1aSzzmbtn/gBWzCPhnzLDXoEreTCAeLKWzOTUOD5kJUbVNEz7kcbYc79pEIZrrivfm/4XTUb/mklH6W
X-Gm-Message-State: AOJu0YwtCKm470qf7I4oFlUPfF7YZT/5amOD/lEHospV7Dqr3XApZpIz
	UTFazPbhwaMG9VHyXPq7CB/4+YLXu6/mgGhaBLoqRiHCy5tr1qLb
X-Google-Smtp-Source: AGHT+IEvoNTIDvwaehPfHv3nbCH9Vy94+618VYT5kTxzOYUtRrps/4mu4t31x/NmGjn8hlWfndnoXA==
X-Received: by 2002:a05:6a00:cc4:b0:70b:1b51:b8af with SMTP id d2e1a72fcca58-7106d02fb2bmr18987093b3a.19.1723019133756;
        Wed, 07 Aug 2024 01:25:33 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed0d457sm7911763b3a.156.2024.08.07.01.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:25:33 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: justinjiang@vivo.com,
	chrisl@kernel.org,
	david@redhat.com,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ying.huang@intel.com
Subject: [PATCH v2 1/2] mm: rename instances of swap_info_struct to meaningful 'si'
Date: Wed,  7 Aug 2024 20:25:07 +1200
Message-Id: <20240807082508.358322-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807082508.358322-1-21cnbao@gmail.com>
References: <20240807082508.358322-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

"P" means "pointer to something", rename it to a more meaningful
identifier - "si".
We also have a case with the name "sis", rename it to "si" as
well.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/swapfile.c | 334 +++++++++++++++++++++++++-------------------------
 1 file changed, 167 insertions(+), 167 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ea023fc25d08..35cb58373493 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -532,7 +532,7 @@ static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *
  * added to free cluster list and its usage counter will be increased by 1.
  * Only used for initialization.
  */
-static void inc_cluster_info_page(struct swap_info_struct *p,
+static void inc_cluster_info_page(struct swap_info_struct *si,
 	struct swap_cluster_info *cluster_info, unsigned long page_nr)
 {
 	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
@@ -553,28 +553,28 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
  * which means no page in the cluster is in use, we can optionally discard
  * the cluster and add it to free cluster list.
  */
-static void dec_cluster_info_page(struct swap_info_struct *p,
+static void dec_cluster_info_page(struct swap_info_struct *si,
 				  struct swap_cluster_info *ci, int nr_pages)
 {
-	if (!p->cluster_info)
+	if (!si->cluster_info)
 		return;
 
 	VM_BUG_ON(ci->count < nr_pages);
 	VM_BUG_ON(cluster_is_free(ci));
-	lockdep_assert_held(&p->lock);
+	lockdep_assert_held(&si->lock);
 	lockdep_assert_held(&ci->lock);
 	ci->count -= nr_pages;
 
 	if (!ci->count) {
-		free_cluster(p, ci);
+		free_cluster(si, ci);
 		return;
 	}
 
 	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
 		VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
 		if (ci->flags & CLUSTER_FLAG_FRAG)
-			p->frag_cluster_nr[ci->order]--;
-		list_move_tail(&ci->list, &p->nonfull_clusters[ci->order]);
+			si->frag_cluster_nr[ci->order]--;
+		list_move_tail(&ci->list, &si->nonfull_clusters[ci->order]);
 		ci->flags = CLUSTER_FLAG_NONFULL;
 	}
 }
@@ -872,19 +872,19 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	return found;
 }
 
-static void __del_from_avail_list(struct swap_info_struct *p)
+static void __del_from_avail_list(struct swap_info_struct *si)
 {
 	int nid;
 
-	assert_spin_locked(&p->lock);
+	assert_spin_locked(&si->lock);
 	for_each_node(nid)
-		plist_del(&p->avail_lists[nid], &swap_avail_heads[nid]);
+		plist_del(&si->avail_lists[nid], &swap_avail_heads[nid]);
 }
 
-static void del_from_avail_list(struct swap_info_struct *p)
+static void del_from_avail_list(struct swap_info_struct *si)
 {
 	spin_lock(&swap_avail_lock);
-	__del_from_avail_list(p);
+	__del_from_avail_list(si);
 	spin_unlock(&swap_avail_lock);
 }
 
@@ -905,13 +905,13 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 	}
 }
 
-static void add_to_avail_list(struct swap_info_struct *p)
+static void add_to_avail_list(struct swap_info_struct *si)
 {
 	int nid;
 
 	spin_lock(&swap_avail_lock);
 	for_each_node(nid)
-		plist_add(&p->avail_lists[nid], &swap_avail_heads[nid]);
+		plist_add(&si->avail_lists[nid], &swap_avail_heads[nid]);
 	spin_unlock(&swap_avail_lock);
 }
 
@@ -1291,22 +1291,22 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 
 static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 {
-	struct swap_info_struct *p;
+	struct swap_info_struct *si;
 	unsigned long offset;
 
 	if (!entry.val)
 		goto out;
-	p = swp_swap_info(entry);
-	if (!p)
+	si = swp_swap_info(entry);
+	if (!si)
 		goto bad_nofile;
-	if (data_race(!(p->flags & SWP_USED)))
+	if (data_race(!(si->flags & SWP_USED)))
 		goto bad_device;
 	offset = swp_offset(entry);
-	if (offset >= p->max)
+	if (offset >= si->max)
 		goto bad_offset;
-	if (data_race(!p->swap_map[swp_offset(entry)]))
+	if (data_race(!si->swap_map[swp_offset(entry)]))
 		goto bad_free;
-	return p;
+	return si;
 
 bad_free:
 	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
@@ -1339,14 +1339,14 @@ static struct swap_info_struct *swap_info_get_cont(swp_entry_t entry,
 	return p;
 }
 
-static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
+static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
 					      unsigned long offset,
 					      unsigned char usage)
 {
 	unsigned char count;
 	unsigned char has_cache;
 
-	count = p->swap_map[offset];
+	count = si->swap_map[offset];
 
 	has_cache = count & SWAP_HAS_CACHE;
 	count &= ~SWAP_HAS_CACHE;
@@ -1362,7 +1362,7 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
 		count = 0;
 	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
 		if (count == COUNT_CONTINUED) {
-			if (swap_count_continued(p, offset, count))
+			if (swap_count_continued(si, offset, count))
 				count = SWAP_MAP_MAX | COUNT_CONTINUED;
 			else
 				count = SWAP_MAP_MAX;
@@ -1372,9 +1372,9 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
 
 	usage = count | has_cache;
 	if (usage)
-		WRITE_ONCE(p->swap_map[offset], usage);
+		WRITE_ONCE(si->swap_map[offset], usage);
 	else
-		WRITE_ONCE(p->swap_map[offset], SWAP_HAS_CACHE);
+		WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
 
 	return usage;
 }
@@ -1453,16 +1453,16 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
-static unsigned char __swap_entry_free(struct swap_info_struct *p,
+static unsigned char __swap_entry_free(struct swap_info_struct *si,
 				       swp_entry_t entry)
 {
 	struct swap_cluster_info *ci;
 	unsigned long offset = swp_offset(entry);
 	unsigned char usage;
 
-	ci = lock_cluster_or_swap_info(p, offset);
-	usage = __swap_entry_free_locked(p, offset, 1);
-	unlock_cluster_or_swap_info(p, ci);
+	ci = lock_cluster_or_swap_info(si, offset);
+	usage = __swap_entry_free_locked(si, offset, 1);
+	unlock_cluster_or_swap_info(si, ci);
 	if (!usage)
 		free_swap_slot(entry);
 
@@ -1473,27 +1473,27 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
  * Drop the last HAS_CACHE flag of swap entries, caller have to
  * ensure all entries belong to the same cgroup.
  */
-static void swap_entry_range_free(struct swap_info_struct *p, swp_entry_t entry,
+static void swap_entry_range_free(struct swap_info_struct *si, swp_entry_t entry,
 				  unsigned int nr_pages)
 {
 	unsigned long offset = swp_offset(entry);
-	unsigned char *map = p->swap_map + offset;
+	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
 	struct swap_cluster_info *ci;
 
-	ci = lock_cluster(p, offset);
+	ci = lock_cluster(si, offset);
 	do {
 		VM_BUG_ON(*map != SWAP_HAS_CACHE);
 		*map = 0;
 	} while (++map < map_end);
-	dec_cluster_info_page(p, ci, nr_pages);
+	dec_cluster_info_page(si, ci, nr_pages);
 	unlock_cluster(ci);
 
 	mem_cgroup_uncharge_swap(entry, nr_pages);
-	swap_range_free(p, offset, nr_pages);
+	swap_range_free(si, offset, nr_pages);
 }
 
-static void cluster_swap_free_nr(struct swap_info_struct *sis,
+static void cluster_swap_free_nr(struct swap_info_struct *si,
 		unsigned long offset, int nr_pages,
 		unsigned char usage)
 {
@@ -1501,26 +1501,26 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
 	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
 	int i, nr;
 
-	ci = lock_cluster_or_swap_info(sis, offset);
+	ci = lock_cluster_or_swap_info(si, offset);
 	while (nr_pages) {
 		nr = min(BITS_PER_LONG, nr_pages);
 		for (i = 0; i < nr; i++) {
-			if (!__swap_entry_free_locked(sis, offset + i, usage))
+			if (!__swap_entry_free_locked(si, offset + i, usage))
 				bitmap_set(to_free, i, 1);
 		}
 		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
-			unlock_cluster_or_swap_info(sis, ci);
+			unlock_cluster_or_swap_info(si, ci);
 			for_each_set_bit(i, to_free, BITS_PER_LONG)
-				free_swap_slot(swp_entry(sis->type, offset + i));
+				free_swap_slot(swp_entry(si->type, offset + i));
 			if (nr == nr_pages)
 				return;
 			bitmap_clear(to_free, 0, BITS_PER_LONG);
-			ci = lock_cluster_or_swap_info(sis, offset);
+			ci = lock_cluster_or_swap_info(si, offset);
 		}
 		offset += nr;
 		nr_pages -= nr;
 	}
-	unlock_cluster_or_swap_info(sis, ci);
+	unlock_cluster_or_swap_info(si, ci);
 }
 
 /*
@@ -1646,28 +1646,28 @@ int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
 int swp_swapcount(swp_entry_t entry)
 {
 	int count, tmp_count, n;
-	struct swap_info_struct *p;
+	struct swap_info_struct *si;
 	struct swap_cluster_info *ci;
 	struct page *page;
 	pgoff_t offset;
 	unsigned char *map;
 
-	p = _swap_info_get(entry);
-	if (!p)
+	si = _swap_info_get(entry);
+	if (!si)
 		return 0;
 
 	offset = swp_offset(entry);
 
-	ci = lock_cluster_or_swap_info(p, offset);
+	ci = lock_cluster_or_swap_info(si, offset);
 
-	count = swap_count(p->swap_map[offset]);
+	count = swap_count(si->swap_map[offset]);
 	if (!(count & COUNT_CONTINUED))
 		goto out;
 
 	count &= ~COUNT_CONTINUED;
 	n = SWAP_MAP_MAX + 1;
 
-	page = vmalloc_to_page(p->swap_map + offset);
+	page = vmalloc_to_page(si->swap_map + offset);
 	offset &= ~PAGE_MASK;
 	VM_BUG_ON(page_private(page) != SWP_CONTINUED);
 
@@ -1681,7 +1681,7 @@ int swp_swapcount(swp_entry_t entry)
 		n *= (SWAP_CONT_MAX + 1);
 	} while (tmp_count & COUNT_CONTINUED);
 out:
-	unlock_cluster_or_swap_info(p, ci);
+	unlock_cluster_or_swap_info(si, ci);
 	return count;
 }
 
@@ -2542,52 +2542,52 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 	return generic_swapfile_activate(sis, swap_file, span);
 }
 
-static int swap_node(struct swap_info_struct *p)
+static int swap_node(struct swap_info_struct *si)
 {
 	struct block_device *bdev;
 
-	if (p->bdev)
-		bdev = p->bdev;
+	if (si->bdev)
+		bdev = si->bdev;
 	else
-		bdev = p->swap_file->f_inode->i_sb->s_bdev;
+		bdev = si->swap_file->f_inode->i_sb->s_bdev;
 
 	return bdev ? bdev->bd_disk->node_id : NUMA_NO_NODE;
 }
 
-static void setup_swap_info(struct swap_info_struct *p, int prio,
+static void setup_swap_info(struct swap_info_struct *si, int prio,
 			    unsigned char *swap_map,
 			    struct swap_cluster_info *cluster_info)
 {
 	int i;
 
 	if (prio >= 0)
-		p->prio = prio;
+		si->prio = prio;
 	else
-		p->prio = --least_priority;
+		si->prio = --least_priority;
 	/*
 	 * the plist prio is negated because plist ordering is
 	 * low-to-high, while swap ordering is high-to-low
 	 */
-	p->list.prio = -p->prio;
+	si->list.prio = -si->prio;
 	for_each_node(i) {
-		if (p->prio >= 0)
-			p->avail_lists[i].prio = -p->prio;
+		if (si->prio >= 0)
+			si->avail_lists[i].prio = -si->prio;
 		else {
-			if (swap_node(p) == i)
-				p->avail_lists[i].prio = 1;
+			if (swap_node(si) == i)
+				si->avail_lists[i].prio = 1;
 			else
-				p->avail_lists[i].prio = -p->prio;
+				si->avail_lists[i].prio = -si->prio;
 		}
 	}
-	p->swap_map = swap_map;
-	p->cluster_info = cluster_info;
+	si->swap_map = swap_map;
+	si->cluster_info = cluster_info;
 }
 
-static void _enable_swap_info(struct swap_info_struct *p)
+static void _enable_swap_info(struct swap_info_struct *si)
 {
-	p->flags |= SWP_WRITEOK;
-	atomic_long_add(p->pages, &nr_swap_pages);
-	total_swap_pages += p->pages;
+	si->flags |= SWP_WRITEOK;
+	atomic_long_add(si->pages, &nr_swap_pages);
+	total_swap_pages += si->pages;
 
 	assert_spin_locked(&swap_lock);
 	/*
@@ -2600,40 +2600,40 @@ static void _enable_swap_info(struct swap_info_struct *p)
 	 * which allocates swap pages from the highest available priority
 	 * swap_info_struct.
 	 */
-	plist_add(&p->list, &swap_active_head);
+	plist_add(&si->list, &swap_active_head);
 
 	/* add to available list iff swap device is not full */
-	if (p->highest_bit)
-		add_to_avail_list(p);
+	if (si->highest_bit)
+		add_to_avail_list(si);
 }
 
-static void enable_swap_info(struct swap_info_struct *p, int prio,
+static void enable_swap_info(struct swap_info_struct *si, int prio,
 				unsigned char *swap_map,
 				struct swap_cluster_info *cluster_info)
 {
 	spin_lock(&swap_lock);
-	spin_lock(&p->lock);
-	setup_swap_info(p, prio, swap_map, cluster_info);
-	spin_unlock(&p->lock);
+	spin_lock(&si->lock);
+	setup_swap_info(si, prio, swap_map, cluster_info);
+	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
 	/*
 	 * Finished initializing swap device, now it's safe to reference it.
 	 */
-	percpu_ref_resurrect(&p->users);
+	percpu_ref_resurrect(&si->users);
 	spin_lock(&swap_lock);
-	spin_lock(&p->lock);
-	_enable_swap_info(p);
-	spin_unlock(&p->lock);
+	spin_lock(&si->lock);
+	_enable_swap_info(si);
+	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
 }
 
-static void reinsert_swap_info(struct swap_info_struct *p)
+static void reinsert_swap_info(struct swap_info_struct *si)
 {
 	spin_lock(&swap_lock);
-	spin_lock(&p->lock);
-	setup_swap_info(p, p->prio, p->swap_map, p->cluster_info);
-	_enable_swap_info(p);
-	spin_unlock(&p->lock);
+	spin_lock(&si->lock);
+	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info);
+	_enable_swap_info(si);
+	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
 }
 
@@ -3019,20 +3019,20 @@ static struct swap_info_struct *alloc_swap_info(void)
 	return p;
 }
 
-static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
+static int claim_swapfile(struct swap_info_struct *si, struct inode *inode)
 {
 	if (S_ISBLK(inode->i_mode)) {
-		p->bdev = I_BDEV(inode);
+		si->bdev = I_BDEV(inode);
 		/*
 		 * Zoned block devices contain zones that have a sequential
 		 * write only restriction.  Hence zoned block devices are not
 		 * suitable for swapping.  Disallow them here.
 		 */
-		if (bdev_is_zoned(p->bdev))
+		if (bdev_is_zoned(si->bdev))
 			return -EINVAL;
-		p->flags |= SWP_BLKDEV;
+		si->flags |= SWP_BLKDEV;
 	} else if (S_ISREG(inode->i_mode)) {
-		p->bdev = inode->i_sb->s_bdev;
+		si->bdev = inode->i_sb->s_bdev;
 	}
 
 	return 0;
@@ -3067,7 +3067,7 @@ __weak unsigned long arch_max_swapfile_size(void)
 	return generic_max_swapfile_size();
 }
 
-static unsigned long read_swap_header(struct swap_info_struct *p,
+static unsigned long read_swap_header(struct swap_info_struct *si,
 					union swap_header *swap_header,
 					struct inode *inode)
 {
@@ -3098,9 +3098,9 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
 		return 0;
 	}
 
-	p->lowest_bit  = 1;
-	p->cluster_next = 1;
-	p->cluster_nr = 0;
+	si->lowest_bit  = 1;
+	si->cluster_next = 1;
+	si->cluster_nr = 0;
 
 	maxpages = swapfile_maximum_size;
 	last_page = swap_header->info.last_page;
@@ -3118,7 +3118,7 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
 		if ((unsigned int)maxpages == 0)
 			maxpages = UINT_MAX;
 	}
-	p->highest_bit = maxpages - 1;
+	si->highest_bit = maxpages - 1;
 
 	if (!maxpages)
 		return 0;
@@ -3142,7 +3142,7 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
 #define SWAP_CLUSTER_COLS						\
 	max_t(unsigned int, SWAP_CLUSTER_INFO_COLS, SWAP_CLUSTER_SPACE_COLS)
 
-static int setup_swap_map_and_extents(struct swap_info_struct *p,
+static int setup_swap_map_and_extents(struct swap_info_struct *si,
 					union swap_header *swap_header,
 					unsigned char *swap_map,
 					struct swap_cluster_info *cluster_info,
@@ -3153,19 +3153,19 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 	unsigned int nr_good_pages;
 	int nr_extents;
 	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
-	unsigned long col = p->cluster_next / SWAPFILE_CLUSTER % SWAP_CLUSTER_COLS;
+	unsigned long col = si->cluster_next / SWAPFILE_CLUSTER % SWAP_CLUSTER_COLS;
 	unsigned long i, idx;
 
 	nr_good_pages = maxpages - 1;	/* omit header page */
 
-	INIT_LIST_HEAD(&p->free_clusters);
-	INIT_LIST_HEAD(&p->full_clusters);
-	INIT_LIST_HEAD(&p->discard_clusters);
+	INIT_LIST_HEAD(&si->free_clusters);
+	INIT_LIST_HEAD(&si->full_clusters);
+	INIT_LIST_HEAD(&si->discard_clusters);
 
 	for (i = 0; i < SWAP_NR_ORDERS; i++) {
-		INIT_LIST_HEAD(&p->nonfull_clusters[i]);
-		INIT_LIST_HEAD(&p->frag_clusters[i]);
-		p->frag_cluster_nr[i] = 0;
+		INIT_LIST_HEAD(&si->nonfull_clusters[i]);
+		INIT_LIST_HEAD(&si->frag_clusters[i]);
+		si->frag_cluster_nr[i] = 0;
 	}
 
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
@@ -3179,13 +3179,13 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 			 * Haven't marked the cluster free yet, no list
 			 * operation involved
 			 */
-			inc_cluster_info_page(p, cluster_info, page_nr);
+			inc_cluster_info_page(si, cluster_info, page_nr);
 		}
 	}
 
 	/* Haven't marked the cluster free yet, no list operation involved */
 	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++)
-		inc_cluster_info_page(p, cluster_info, i);
+		inc_cluster_info_page(si, cluster_info, i);
 
 	if (nr_good_pages) {
 		swap_map[0] = SWAP_MAP_BAD;
@@ -3193,13 +3193,13 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 		 * Not mark the cluster free yet, no list
 		 * operation involved
 		 */
-		inc_cluster_info_page(p, cluster_info, 0);
-		p->max = maxpages;
-		p->pages = nr_good_pages;
-		nr_extents = setup_swap_extents(p, span);
+		inc_cluster_info_page(si, cluster_info, 0);
+		si->max = maxpages;
+		si->pages = nr_good_pages;
+		nr_extents = setup_swap_extents(si, span);
 		if (nr_extents < 0)
 			return nr_extents;
-		nr_good_pages = p->pages;
+		nr_good_pages = si->pages;
 	}
 	if (!nr_good_pages) {
 		pr_warn("Empty swap-file\n");
@@ -3223,11 +3223,11 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 				continue;
 			if (ci->count) {
 				ci->flags = CLUSTER_FLAG_NONFULL;
-				list_add_tail(&ci->list, &p->nonfull_clusters[0]);
+				list_add_tail(&ci->list, &si->nonfull_clusters[0]);
 				continue;
 			}
 			ci->flags = CLUSTER_FLAG_FREE;
-			list_add_tail(&ci->list, &p->free_clusters);
+			list_add_tail(&ci->list, &si->free_clusters);
 		}
 	}
 	return nr_extents;
@@ -3235,7 +3235,7 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 
 SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 {
-	struct swap_info_struct *p;
+	struct swap_info_struct *si;
 	struct filename *name;
 	struct file *swap_file = NULL;
 	struct address_space *mapping;
@@ -3261,11 +3261,11 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (!swap_avail_heads)
 		return -ENOMEM;
 
-	p = alloc_swap_info();
-	if (IS_ERR(p))
-		return PTR_ERR(p);
+	si = alloc_swap_info();
+	if (IS_ERR(si))
+		return PTR_ERR(si);
 
-	INIT_WORK(&p->discard_work, swap_discard_work);
+	INIT_WORK(&si->discard_work, swap_discard_work);
 
 	name = getname(specialfile);
 	if (IS_ERR(name)) {
@@ -3280,12 +3280,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap;
 	}
 
-	p->swap_file = swap_file;
+	si->swap_file = swap_file;
 	mapping = swap_file->f_mapping;
 	dentry = swap_file->f_path.dentry;
 	inode = mapping->host;
 
-	error = claim_swapfile(p, inode);
+	error = claim_swapfile(si, inode);
 	if (unlikely(error))
 		goto bad_swap;
 
@@ -3313,7 +3313,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	}
 	swap_header = kmap(page);
 
-	maxpages = read_swap_header(p, swap_header, inode);
+	maxpages = read_swap_header(si, swap_header, inode);
 	if (unlikely(!maxpages)) {
 		error = -EINVAL;
 		goto bad_swap_unlock_inode;
@@ -3326,19 +3326,19 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
-	if (p->bdev && bdev_stable_writes(p->bdev))
-		p->flags |= SWP_STABLE_WRITES;
+	if (si->bdev && bdev_stable_writes(si->bdev))
+		si->flags |= SWP_STABLE_WRITES;
 
-	if (p->bdev && bdev_synchronous(p->bdev))
-		p->flags |= SWP_SYNCHRONOUS_IO;
+	if (si->bdev && bdev_synchronous(si->bdev))
+		si->flags |= SWP_SYNCHRONOUS_IO;
 
-	if (p->bdev && bdev_nonrot(p->bdev)) {
+	if (si->bdev && bdev_nonrot(si->bdev)) {
 		int cpu, i;
 		unsigned long ci, nr_cluster;
 
-		p->flags |= SWP_SOLIDSTATE;
-		p->cluster_next_cpu = alloc_percpu(unsigned int);
-		if (!p->cluster_next_cpu) {
+		si->flags |= SWP_SOLIDSTATE;
+		si->cluster_next_cpu = alloc_percpu(unsigned int);
+		if (!si->cluster_next_cpu) {
 			error = -ENOMEM;
 			goto bad_swap_unlock_inode;
 		}
@@ -3347,8 +3347,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		 * SSD
 		 */
 		for_each_possible_cpu(cpu) {
-			per_cpu(*p->cluster_next_cpu, cpu) =
-				get_random_u32_inclusive(1, p->highest_bit);
+			per_cpu(*si->cluster_next_cpu, cpu) =
+				get_random_u32_inclusive(1, si->highest_bit);
 		}
 		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 
@@ -3362,15 +3362,15 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		for (ci = 0; ci < nr_cluster; ci++)
 			spin_lock_init(&((cluster_info + ci)->lock));
 
-		p->percpu_cluster = alloc_percpu(struct percpu_cluster);
-		if (!p->percpu_cluster) {
+		si->percpu_cluster = alloc_percpu(struct percpu_cluster);
+		if (!si->percpu_cluster) {
 			error = -ENOMEM;
 			goto bad_swap_unlock_inode;
 		}
 		for_each_possible_cpu(cpu) {
 			struct percpu_cluster *cluster;
 
-			cluster = per_cpu_ptr(p->percpu_cluster, cpu);
+			cluster = per_cpu_ptr(si->percpu_cluster, cpu);
 			for (i = 0; i < SWAP_NR_ORDERS; i++)
 				cluster->next[i] = SWAP_NEXT_INVALID;
 		}
@@ -3379,11 +3379,11 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		inced_nr_rotate_swap = true;
 	}
 
-	error = swap_cgroup_swapon(p->type, maxpages);
+	error = swap_cgroup_swapon(si->type, maxpages);
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	nr_extents = setup_swap_map_and_extents(p, swap_header, swap_map,
+	nr_extents = setup_swap_map_and_extents(si, swap_header, swap_map,
 		cluster_info, maxpages, &span);
 	if (unlikely(nr_extents < 0)) {
 		error = nr_extents;
@@ -3391,14 +3391,14 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	}
 
 	if ((swap_flags & SWAP_FLAG_DISCARD) &&
-	    p->bdev && bdev_max_discard_sectors(p->bdev)) {
+	    si->bdev && bdev_max_discard_sectors(si->bdev)) {
 		/*
 		 * When discard is enabled for swap with no particular
 		 * policy flagged, we set all swap discard flags here in
 		 * order to sustain backward compatibility with older
 		 * swapon(8) releases.
 		 */
-		p->flags |= (SWP_DISCARDABLE | SWP_AREA_DISCARD |
+		si->flags |= (SWP_DISCARDABLE | SWP_AREA_DISCARD |
 			     SWP_PAGE_DISCARD);
 
 		/*
@@ -3408,24 +3408,24 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		 * Now it's time to adjust the p->flags accordingly.
 		 */
 		if (swap_flags & SWAP_FLAG_DISCARD_ONCE)
-			p->flags &= ~SWP_PAGE_DISCARD;
+			si->flags &= ~SWP_PAGE_DISCARD;
 		else if (swap_flags & SWAP_FLAG_DISCARD_PAGES)
-			p->flags &= ~SWP_AREA_DISCARD;
+			si->flags &= ~SWP_AREA_DISCARD;
 
 		/* issue a swapon-time discard if it's still required */
-		if (p->flags & SWP_AREA_DISCARD) {
-			int err = discard_swap(p);
+		if (si->flags & SWP_AREA_DISCARD) {
+			int err = discard_swap(si);
 			if (unlikely(err))
 				pr_err("swapon: discard_swap(%p): %d\n",
-					p, err);
+					si, err);
 		}
 	}
 
-	error = init_swap_address_space(p->type, maxpages);
+	error = init_swap_address_space(si->type, maxpages);
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	error = zswap_swapon(p->type, maxpages);
+	error = zswap_swapon(si->type, maxpages);
 	if (error)
 		goto free_swap_address_space;
 
@@ -3445,15 +3445,15 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio =
 		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
-	enable_swap_info(p, prio, swap_map, cluster_info);
+	enable_swap_info(si, prio, swap_map, cluster_info);
 
 	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
-		K(p->pages), name->name, p->prio, nr_extents,
+		K(si->pages), name->name, si->prio, nr_extents,
 		K((unsigned long long)span),
-		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
-		(p->flags & SWP_DISCARDABLE) ? "D" : "",
-		(p->flags & SWP_AREA_DISCARD) ? "s" : "",
-		(p->flags & SWP_PAGE_DISCARD) ? "c" : "");
+		(si->flags & SWP_SOLIDSTATE) ? "SS" : "",
+		(si->flags & SWP_DISCARDABLE) ? "D" : "",
+		(si->flags & SWP_AREA_DISCARD) ? "s" : "",
+		(si->flags & SWP_PAGE_DISCARD) ? "c" : "");
 
 	mutex_unlock(&swapon_mutex);
 	atomic_inc(&proc_poll_event);
@@ -3462,22 +3462,22 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	error = 0;
 	goto out;
 free_swap_zswap:
-	zswap_swapoff(p->type);
+	zswap_swapoff(si->type);
 free_swap_address_space:
-	exit_swap_address_space(p->type);
+	exit_swap_address_space(si->type);
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
-	free_percpu(p->percpu_cluster);
-	p->percpu_cluster = NULL;
-	free_percpu(p->cluster_next_cpu);
-	p->cluster_next_cpu = NULL;
+	free_percpu(si->percpu_cluster);
+	si->percpu_cluster = NULL;
+	free_percpu(si->cluster_next_cpu);
+	si->cluster_next_cpu = NULL;
 	inode = NULL;
-	destroy_swap_extents(p);
-	swap_cgroup_swapoff(p->type);
+	destroy_swap_extents(si);
+	swap_cgroup_swapoff(si->type);
 	spin_lock(&swap_lock);
-	p->swap_file = NULL;
-	p->flags = 0;
+	si->swap_file = NULL;
+	si->flags = 0;
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
 	kvfree(cluster_info);
@@ -3529,23 +3529,23 @@ void si_swapinfo(struct sysinfo *val)
  */
 static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 {
-	struct swap_info_struct *p;
+	struct swap_info_struct *si;
 	struct swap_cluster_info *ci;
 	unsigned long offset;
 	unsigned char count;
 	unsigned char has_cache;
 	int err, i;
 
-	p = swp_swap_info(entry);
+	si = swp_swap_info(entry);
 
 	offset = swp_offset(entry);
 	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
 	VM_WARN_ON(usage == 1 && nr > 1);
-	ci = lock_cluster_or_swap_info(p, offset);
+	ci = lock_cluster_or_swap_info(si, offset);
 
 	err = 0;
 	for (i = 0; i < nr; i++) {
-		count = p->swap_map[offset + i];
+		count = si->swap_map[offset + i];
 
 		/*
 		 * swapin_readahead() doesn't check if a swap entry is valid, so the
@@ -3573,7 +3573,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	}
 
 	for (i = 0; i < nr; i++) {
-		count = p->swap_map[offset + i];
+		count = si->swap_map[offset + i];
 		has_cache = count & SWAP_HAS_CACHE;
 		count &= ~SWAP_HAS_CACHE;
 
@@ -3581,7 +3581,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 			has_cache = SWAP_HAS_CACHE;
 		else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
 			count += usage;
-		else if (swap_count_continued(p, offset + i, count))
+		else if (swap_count_continued(si, offset + i, count))
 			count = COUNT_CONTINUED;
 		else {
 			/*
@@ -3592,11 +3592,11 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 			goto unlock_out;
 		}
 
-		WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
+		WRITE_ONCE(si->swap_map[offset + i], count | has_cache);
 	}
 
 unlock_out:
-	unlock_cluster_or_swap_info(p, ci);
+	unlock_cluster_or_swap_info(si, ci);
 	return err;
 }
 
-- 
2.34.1


