Return-Path: <linux-kernel+bounces-299507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE9495D5A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2174B2835AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFFD1925AC;
	Fri, 23 Aug 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBxls8EK"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C48191F7E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439528; cv=none; b=YVT3w0JylElS706AoYZ3sCkKTvC41cdx1rRZ0nLXWR7WffBGfRJk4ypbjNMdxwKc5gjvHYXYhoiS0qg+FBSy9c5Z78XqEW8c5AmsOfM9zFjRXc/lI9djtUeTDgL01zvACtpgvSKLzJn7o7RBnm7BaMOdMgPjGwev6nOhC6SQku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439528; c=relaxed/simple;
	bh=k7zvmltEP8FizGa4I3ElFR+Ejkb9gcDZmvqxuqs7RmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p65rKZ5CNNMH6jp4g2wYKPIDSDpfEZGJ9OOVrkfXBvPzusxZR5C24RzhK9qVBhPDbRzU9vS8TG7wgv13pyM2CxhHxg+iTtrwsnZda/KqL8omWouZDOw8F2BtplvQk51j0rs6rcR2ekcLF8wXFbqF0+L/69NXWgDe5zTV+Zl4WWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBxls8EK; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-498e1e3bee8so791599137.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724439525; x=1725044325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh3UNHRdYk2GVwyEcx3sKj43KmS421jzAbB7K3l/19k=;
        b=nBxls8EKa5nasm4u0otQPjEqjvtA843SdcvUULM+t0qyzoSWGxwjVeAr3dIgqUsGO5
         niwTAHIzAEbiJl971/8piSaxQ79AhbjTNz9s3XOCxwczUdLJ+fkE3DH/qyc8mI/q9+Hy
         q7toTLSXFR+9Rg0QUzgaI3WWFhrrKmRiFoQUhUtAlqYnHljHEg6a9aVXVzapTomBq6Zv
         7gYHqbEz/B/rBifbt2t94h54l2fQzeWtLiT1PZB/22UWEtphQK+TQYANM1wEzCeCcqnF
         /H8l+q3F7QndnEJRUF5OLSAZoWgUnRrgGPWcdYL4uTehRilmXB6wOBvwXNTxg40xRMpU
         wK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439525; x=1725044325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sh3UNHRdYk2GVwyEcx3sKj43KmS421jzAbB7K3l/19k=;
        b=nQUVcljBguMIt9nGFpFtk6vYbmwuxHFTdeLJ5T3b5In+JTL63v4kuC39j6pj9fk30E
         ljjKxJazbY2A62Q9HbPEQzDDYYXbse86aJl34eEHs65/9r0QM9az4FE/DUQV36h41TFA
         XKCrz8OGcpmiLSwAy99rWXm4lpL/dIeKXhc6L4eiE3I5kThUi4zdFfAL5ICtBnAnL16m
         G7y8jqj2QzIiriLLfvsx0L+hYxkOtHp1bTdPkJZNvudiXv5IVelqQmWOHth0AgDg6/YM
         306scS8fFeborZPgOJ47yip2M5ku6Jo8QKcQ+YDmWrV0Bpjy0Dv1+wF8ypKJTpqWJwCH
         55qA==
X-Forwarded-Encrypted: i=1; AJvYcCVfoon8f3e3OwcKPWit2mp8I9zcpUcbL8KBu0VaQJUJ/chOoAX6KiM1REqFAE+qcIe9vNsxl2o0qBQ8z/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNinO6F7SMWTI0qzPMkvYt6ynXLK3nCEw+tmOMxlHo2Ph26hIS
	g9XYVvOEvSVXMoOrjZZ3IHWc3InS2ya0uFD3xO9AmpvvsCpcI725
X-Google-Smtp-Source: AGHT+IGc5hKCXhnGMWTJpltPKy/ZsZOxc6pfK2o5GuoEQCbkG2S+TuJrzCD64NbwWD+lZMa3k9r5yA==
X-Received: by 2002:a05:6102:3e90:b0:498:f017:14a1 with SMTP id ada2fe7eead31-498f46edc07mr4129469137.19.1724439525395;
        Fri, 23 Aug 2024 11:58:45 -0700 (PDT)
Received: from localhost (fwdproxy-ash-115.fbsv.net. [2a03:2880:20ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d643b9sm21266556d6.66.2024.08.23.11.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:58:44 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
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
	Usama Arif <usamaarif642@gmail.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v8 1/2] mm: store zero pages to be swapped out in a bitmap
Date: Fri, 23 Aug 2024 19:57:34 +0100
Message-ID: <20240823185838.939977-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823185838.939977-1-usamaarif642@gmail.com>
References: <20240823185838.939977-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Approximately 10-20% of pages to be swapped out are zero pages [1].
Rather than reading/writing these pages to flash resulting
in increased I/O and flash wear, a bitmap can be used to mark these
pages as zero at write time, and the pages can be filled at
read time if the bit corresponding to the page is set.
With this patch, NVMe writes in Meta server fleet decreased
by almost 10% with conventional swap setup (zswap disabled).

[1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/swap.h |   1 +
 mm/page_io.c         | 118 ++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        |  38 ++++++++++++--
 3 files changed, 151 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 248db1dd7812..ca533b478c21 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -296,6 +296,7 @@ struct swap_info_struct {
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
+	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
 	struct list_head full_clusters; /* full clusters list */
diff --git a/mm/page_io.c b/mm/page_io.c
index a00e2f615118..b6f1519d63b0 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -172,6 +172,80 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 	goto out;
 }
 
+static bool is_folio_zero_filled(struct folio *folio)
+{
+	unsigned int pos, last_pos;
+	unsigned long *data;
+	unsigned int i;
+
+	last_pos = PAGE_SIZE / sizeof(*data) - 1;
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		data = kmap_local_folio(folio, i * PAGE_SIZE);
+		/*
+		 * Check last word first, incase the page is zero-filled at
+		 * the start and has non-zero data at the end, which is common
+		 * in real-world workloads.
+		 */
+		if (data[last_pos]) {
+			kunmap_local(data);
+			return false;
+		}
+		for (pos = 0; pos < last_pos; pos++) {
+			if (data[pos]) {
+				kunmap_local(data);
+				return false;
+			}
+		}
+		kunmap_local(data);
+	}
+
+	return true;
+}
+
+static void swap_zeromap_folio_set(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_entry_t entry;
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		entry = page_swap_entry(folio_page(folio, i));
+		set_bit(swp_offset(entry), sis->zeromap);
+	}
+}
+
+static void swap_zeromap_folio_clear(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_entry_t entry;
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		entry = page_swap_entry(folio_page(folio, i));
+		clear_bit(swp_offset(entry), sis->zeromap);
+	}
+}
+
+/*
+ * Return the index of the first subpage which is not zero-filled
+ * according to swap_info_struct->zeromap.
+ * If all pages are zero-filled according to zeromap, it will return
+ * folio_nr_pages(folio).
+ */
+static unsigned int swap_zeromap_folio_test(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_entry_t entry;
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		entry = page_swap_entry(folio_page(folio, i));
+		if (!test_bit(swp_offset(entry), sis->zeromap))
+			return i;
+	}
+	return i;
+}
+
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -195,6 +269,25 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_unlock(folio);
 		return ret;
 	}
+
+	/*
+	 * Use a bitmap (zeromap) to avoid doing IO for zero-filled pages.
+	 * The bits in zeromap are protected by the locked swapcache folio
+	 * and atomic updates are used to protect against read-modify-write
+	 * corruption due to other zero swap entries seeing concurrent updates.
+	 */
+	if (is_folio_zero_filled(folio)) {
+		swap_zeromap_folio_set(folio);
+		folio_unlock(folio);
+		return 0;
+	} else {
+		/*
+		 * Clear bits this folio occupies in the zeromap to prevent
+		 * zero data being read in from any previous zero writes that
+		 * occupied the same swap entries.
+		 */
+		swap_zeromap_folio_clear(folio);
+	}
 	if (zswap_store(folio)) {
 		folio_unlock(folio);
 		return 0;
@@ -427,6 +520,26 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 	mempool_free(sio, sio_pool);
 }
 
+static bool swap_read_folio_zeromap(struct folio *folio)
+{
+	unsigned int idx = swap_zeromap_folio_test(folio);
+
+	if (idx == 0)
+		return false;
+
+	/*
+	 * Swapping in a large folio that is partially in the zeromap is not
+	 * currently handled. Return true without marking the folio uptodate so
+	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
+	 */
+	if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
+		return true;
+
+	folio_zero_range(folio, 0, folio_size(folio));
+	folio_mark_uptodate(folio);
+	return true;
+}
+
 static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
@@ -517,7 +630,10 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	}
 	delayacct_swapin_start();
 
-	if (zswap_load(folio)) {
+	if (swap_read_folio_zeromap(folio)) {
+		folio_unlock(folio);
+		goto finish;
+	} else if (zswap_load(folio)) {
 		folio_unlock(folio);
 		goto finish;
 	}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index aff73a3d0ead..1cfb7c63cdcc 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -940,6 +940,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	unsigned long begin = offset;
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
+	unsigned int i;
+
+	/*
+	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
+	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
+	 */
+	for (i = 0; i < nr_entries; i++)
+		clear_bit(offset + i, si->zeromap);
 
 	if (offset < si->lowest_bit)
 		si->lowest_bit = offset;
@@ -2607,7 +2615,8 @@ static int swap_node(struct swap_info_struct *si)
 
 static void setup_swap_info(struct swap_info_struct *si, int prio,
 			    unsigned char *swap_map,
-			    struct swap_cluster_info *cluster_info)
+			    struct swap_cluster_info *cluster_info,
+			    unsigned long *zeromap)
 {
 	int i;
 
@@ -2632,6 +2641,7 @@ static void setup_swap_info(struct swap_info_struct *si, int prio,
 	}
 	si->swap_map = swap_map;
 	si->cluster_info = cluster_info;
+	si->zeromap = zeromap;
 }
 
 static void _enable_swap_info(struct swap_info_struct *si)
@@ -2660,11 +2670,12 @@ static void _enable_swap_info(struct swap_info_struct *si)
 
 static void enable_swap_info(struct swap_info_struct *si, int prio,
 				unsigned char *swap_map,
-				struct swap_cluster_info *cluster_info)
+				struct swap_cluster_info *cluster_info,
+				unsigned long *zeromap)
 {
 	spin_lock(&swap_lock);
 	spin_lock(&si->lock);
-	setup_swap_info(si, prio, swap_map, cluster_info);
+	setup_swap_info(si, prio, swap_map, cluster_info, zeromap);
 	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
 	/*
@@ -2682,7 +2693,7 @@ static void reinsert_swap_info(struct swap_info_struct *si)
 {
 	spin_lock(&swap_lock);
 	spin_lock(&si->lock);
-	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info);
+	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info, si->zeromap);
 	_enable_swap_info(si);
 	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
@@ -2707,6 +2718,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
 	unsigned char *swap_map;
+	unsigned long *zeromap;
 	struct swap_cluster_info *cluster_info;
 	struct file *swap_file, *victim;
 	struct address_space *mapping;
@@ -2829,6 +2841,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->max = 0;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
+	zeromap = p->zeromap;
+	p->zeromap = NULL;
 	cluster_info = p->cluster_info;
 	p->cluster_info = NULL;
 	spin_unlock(&p->lock);
@@ -2841,6 +2855,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	vfree(swap_map);
+	kvfree(zeromap);
 	kvfree(cluster_info);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
@@ -3338,6 +3353,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	sector_t span;
 	unsigned long maxpages;
 	unsigned char *swap_map = NULL;
+	unsigned long *zeromap = NULL;
 	struct swap_cluster_info *cluster_info = NULL;
 	struct page *page = NULL;
 	struct inode *inode = NULL;
@@ -3428,6 +3444,17 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	/*
+	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
+	 * be above MAX_PAGE_ORDER incase of a large swap file.
+	 */
+	zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
+				    GFP_KERNEL | __GFP_ZERO);
+	if (!zeromap) {
+		error = -ENOMEM;
+		goto bad_swap_unlock_inode;
+	}
+
 	if (si->bdev && bdev_stable_writes(si->bdev))
 		si->flags |= SWP_STABLE_WRITES;
 
@@ -3503,7 +3530,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio =
 		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
-	enable_swap_info(si, prio, swap_map, cluster_info);
+	enable_swap_info(si, prio, swap_map, cluster_info, zeromap);
 
 	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
 		K(si->pages), name->name, si->prio, nr_extents,
@@ -3538,6 +3565,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	si->flags = 0;
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
+	kvfree(zeromap);
 	kvfree(cluster_info);
 	if (inced_nr_rotate_swap)
 		atomic_dec(&nr_rotate_swap);
-- 
2.43.5


