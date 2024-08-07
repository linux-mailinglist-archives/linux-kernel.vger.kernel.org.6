Return-Path: <linux-kernel+bounces-277163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA91949D63
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6B21C21BF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C4F15B56E;
	Wed,  7 Aug 2024 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRSsPOZS"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636F159598
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722994488; cv=none; b=CbLckFCzAHJsGeBwOhuNiclJodiOPFsegXH8T3vK5XUmy8QnYIMA3vPzzseb9ziZkn+GHtlrhDe9wpNxHyOaMBt+xdsODplQqeACHNhxuFtd/0mixZomTybkJWZSDqAS+5YlIyVlEVJ/OyTuxsmGA5jJSQurX7FPFMDc6afgRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722994488; c=relaxed/simple;
	bh=roDbgKnN4jwF5bZ+MI0OwImeNYhSYwb7VCiHMd9nZ68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmsfn07OWXUMRVOcp7eqWlZMX0ZgGj2UexP0xAQBIdkC0KHEen5bJ32rJV9VA4lzp8iVSEySiZkyJT1X2ysTtyR3j1HUymAW3ASWYIqMY2k4bTqVR16rDfsFjxm7NxMsF0DpWSeh0AYsQyfqGk0kupDiCpTAgzQmg6TcuSVqwVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRSsPOZS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fee6435a34so12732595ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 18:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722994485; x=1723599285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmSjhXOFQYFO7KmqcvsNGpWkpKulwZvFPktcub+aRMA=;
        b=KRSsPOZSjO/N+JJ+DZERy9gCaJ5/Pj0oo1hpKKOZXzsjWKuq9+8PnkSnJUtIFBiDo3
         GX5pHnmCsPuPb+1Rf3tIiArvXLMPpA+UCEx7opDkj18/DRQx3SlTVfJB1o9SM9j1b8CW
         KsRcqr58zMI26mYzqsEI/W3F7jUNEdryV6/hGGuha11SQfnLs98e/dJDYWv035i5X0ob
         DEk2mxDQrQ8Kn7ui+E/vzYORFQNf9GPJ+9LfbkPzjYhM+t5ZciBZur+O8JN/qD14tb69
         FxaYJ448ti1nhG6SXMfH8gVCCydUnnui4K9BLd2YIXdnW2LSycjKBFyfqLC4CbHakXhj
         QBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722994485; x=1723599285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmSjhXOFQYFO7KmqcvsNGpWkpKulwZvFPktcub+aRMA=;
        b=vk5l6wQ36AnfrH5Cm4QFbzfDkfhhKZQjjBj5duO8k6iU6zVkIYxzl4Zq9NzuM1weKB
         sHqVlLgg6eLbjSL7T8AJg8DXhLRMqfsUKKbFqEAm1hzkMm2pFiHos17+++pw3NOuxxrT
         ZRIWtGm2YGPtnbCJqX41IHiMi6O6F/9i4tZ6MxeIclgy0kt93Yocivw3/BFJSfFTE9At
         s+2Mhu+3BTQoTnxC4s2HYSHCpJfYnLihjHs9VRbPIFDExtjxtnOPlnvASP51UNHM9Ydo
         9iWEiGJOmxBdDDAWSTlBvqLGyaK6m164LFDytWB09kYrdJfbBBIqipGQKtoAssligjQW
         /v6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjIM9H5pdJb56b99rD0olK2oB/D+YH/tWiT435q+Fu/LX8yMlBn9G6TIGWfxe3+RWVFqKHnVBEi7ku+mvjvVR7ea+9YPoU7DWCpdcB
X-Gm-Message-State: AOJu0YyCZZQI5oGWzAq1D2FMFzIkTNj80DO0QrOuz93eyYwbPE0arhy1
	7PoUqrJBJKvEcHWfYCyfeHvZ75g11ZVRA+ECgwuLJBhNOUwKnu6u
X-Google-Smtp-Source: AGHT+IFMTS9jExx+YVhXbLvb9JOGGwlgAP4I8XBRzhl0MpBwTpvZJDxb0PL1WizgxCqELJOi2jMH2g==
X-Received: by 2002:a17:903:32ce:b0:1fb:8cab:ccc9 with SMTP id d9443c01a7336-1ff573cca00mr163113095ad.45.1722994484816;
        Tue, 06 Aug 2024 18:34:44 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f21de1sm93829745ad.25.2024.08.06.18.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 18:34:44 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: 21cnbao@gmail.com
Cc: akpm@linux-foundation.org,
	chrisl@kernel.org,
	david@redhat.com,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ying.huang@intel.com
Subject: Re: [PATCH] mm: attempt to batch free swap entries for zap_pte_range()
Date: Wed,  7 Aug 2024 13:34:26 +1200
Message-Id: <20240807013427.103571-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAGsJ_4wjFS9Yr=vb3kPWpfCrxn58AE7VifrwcvAYvMPfsC_KEg@mail.gmail.com>
References: <CAGsJ_4wjFS9Yr=vb3kPWpfCrxn58AE7VifrwcvAYvMPfsC_KEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Aug 7, 2024 at 10:23 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Wed, Aug 7, 2024 at 6:41 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 7 Aug 2024 04:44:44 +0800 Barry Song <21cnbao@gmail.com> wrote:
> >
> > > > > +static bool try_batch_swap_entries_free(struct swap_info_struct *p,
> > > >
> > > > Why call it "p" here and not "si" like in the other code you are touching?
> > >
> > > that is because I found other _free_ functions are all using "p":
> >
> > `p' sucks.  "pointer to something".  It's just lazy.  In this context, "si"
> > has meaning; lots of it.
>
> Agreed. I'll also clean up the existing "p" in those _free_ functions
> while sending
> v2.

well. we are having "p" everywhere. will be a separate patch for this cleanup:

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ea023fc25d08..d130cce3a02d 100644
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

>
> Thanks
> Barry

