Return-Path: <linux-kernel+bounces-376856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D99AB6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD671C232F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151361CB520;
	Tue, 22 Oct 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4b7tqmk"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47081CC162
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625404; cv=none; b=P+L6VBCOx1F5NSJuG67JKXx1UMAaBm8/xrcvK8vh4gQtLtH6qdPCJOyyuSjiHgZNHat/TCvY5jGbhxNNPQ947T/iuchC08NA+S786RoA7rQ1m2RMFMU4DKfH1sI2Wlf4+jS5aoUDRX3MJCfAVw3RJE64x6EEMUqAn+qPGFVMLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625404; c=relaxed/simple;
	bh=diIKEzgOcmPu++XnqSivwukR8rpsW2YLUCoOGB0c1z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEqsvwJoVVCnjDsmSYXiwgTDplwO/8X4u7VCEDHeFKHp9ywDWbaj3w9zWk6YnR0az411We6sCq9h6zOwZBDJJi7F/moROeamzpsGxhULZeeHNusrBfXxDQC60LzsgjEHTsNF4hq0r7OXBtn1msuYDEDKSnWPHTK7QeF1Z7omLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4b7tqmk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c6f492d2dso69674935ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625402; x=1730230202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XKHLsBzhzCnbiPIqKsShhAk0UHdn03icCPe/yHcoGTQ=;
        b=J4b7tqmkMX+Nq1hTDfXKSdOQWCy2QY1Co1AiVYlSA3H6AqUdPkt/soZaFcVybIgZCQ
         28krwVVQcpJrGZVyAJU70387UnpW8OwJNQP4SA+AUalDqQCjFDE7Pey7jvXc6U3D+gV8
         r+27CWkLbVBNi04RHD1oKbvMcC2dSY6GJHAZZ+rBXFgIKnWE+C0Tw6/EPsa6tTwfvPfT
         ShY0Od8C+/t47ohzHstibqo+6MD2e8Qw3iAQ3+wClvJrwQA0aa9AZXuUpXWpDULghHuQ
         o5Y6XlTy5NyA8YTiArNYbGU4crZtKSfuGtxkknhhHBYA/XLUPpaVThk1JyjJqLjVN6K+
         P/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625402; x=1730230202;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKHLsBzhzCnbiPIqKsShhAk0UHdn03icCPe/yHcoGTQ=;
        b=EVZXr7yCbkiHSKS64ji/mJpVvx4/O5Vswx3PPwf9Uo2aQeT802PE8Kz/sQoKUkQ1i7
         7H6VoulwIAucYqfNbJgHrwi2KONOQLeap497jLwWLbQh2JLWJ0rIUVVTuVx6fujuXL7M
         J2XLG6woti5KY7j3ec8k3kbY84h0cBVtM2dPqzDeQCmjVGFgyJxtcr8J4jtwXlp4zv8y
         AeDFk6PgE+jd/vReL4drO7Vg/KNJ/yfsc2xmmRTZVPskb2YM+IqBnhUXzmQuYg1R7/X7
         iCsTwFSgNRNs4bDV5qEQJlQxfvFlHQFZ2vvAz+jO12CP3gh18QnD3VJHFX/fFa7Gj4Y/
         UCUg==
X-Forwarded-Encrypted: i=1; AJvYcCVnsIt4+AR3fFIAY1b9xwSI04IRjaFGlOEOjCDY008X5z9Z4Hu8dtRs1m0lVqKaQ+8QqGyc7eDd6aNHjhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoI3lhLY88dgeywnIrmvygG0H8Hlr65f3ZXIIwmk/jAxBrEn32
	QsB/yKYbiSZlfMcOszdXawt/oi0RaDHyFwuKKL9ZPmB5/mkVxi2y
X-Google-Smtp-Source: AGHT+IH5d48HG7yM1vsiLoHlHuj/5dQGaeruEyz0B4KacEW852FH1mXkSs1tEGlqkW7GrlSz5sKaZA==
X-Received: by 2002:a17:902:ec82:b0:20b:4875:2c51 with SMTP id d9443c01a7336-20fa9e5c6f7mr2808315ad.27.1729625401890;
        Tue, 22 Oct 2024 12:30:01 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.29.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:30:01 -0700 (PDT)
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
Subject: [PATCH 05/13] mm, swap: clean up device availability check
Date: Wed, 23 Oct 2024 03:24:43 +0800
Message-ID: <20241022192451.38138-6-ryncsn@gmail.com>
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

Remove highest_bit and lowest_bit. After HDD allocation path is removed,
only purpose of these two fields is to judge if the device is full or
not, which can be done by checking inuse_pages instead.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 fs/btrfs/inode.c     |  1 -
 fs/iomap/swapfile.c  |  1 -
 include/linux/swap.h |  2 --
 mm/page_io.c         |  1 -
 mm/swapfile.c        | 38 ++++++++------------------------------
 5 files changed, 8 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5618ca02934a..aba9c0d58998 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10023,7 +10023,6 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	*span = bsi.highest_ppage - bsi.lowest_ppage + 1;
 	sis->max = bsi.nr_pages;
 	sis->pages = bsi.nr_pages - 1;
-	sis->highest_bit = bsi.nr_pages - 1;
 	return bsi.nr_extents;
 }
 #else
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 5fc0ac36dee3..b90d0eda9e51 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -189,7 +189,6 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 	*pagespan = 1 + isi.highest_ppage - isi.lowest_ppage;
 	sis->max = isi.nr_pages;
 	sis->pages = isi.nr_pages - 1;
-	sis->highest_bit = isi.nr_pages - 1;
 	return isi.nr_extents;
 }
 EXPORT_SYMBOL_GPL(iomap_swapfile_activate);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3a71198a6957..c0d49dad7a4b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -305,8 +305,6 @@ struct swap_info_struct {
 	struct list_head frag_clusters[SWAP_NR_ORDERS];
 					/* list of cluster that are fragmented or contented */
 	unsigned int frag_cluster_nr[SWAP_NR_ORDERS];
-	unsigned int lowest_bit;	/* index of first free in swap_map */
-	unsigned int highest_bit;	/* index of last free in swap_map */
 	unsigned int pages;		/* total of usable pages of swap */
 	unsigned int inuse_pages;	/* number of those currently in use */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
diff --git a/mm/page_io.c b/mm/page_io.c
index a28d28b6b3ce..c8a25203bcf4 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -163,7 +163,6 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 		page_no = 1;	/* force Empty message */
 	sis->max = page_no;
 	sis->pages = page_no - 1;
-	sis->highest_bit = page_no - 1;
 out:
 	return ret;
 bad_bmap:
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f8e70bb5f1d7..e620b41c3120 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -55,7 +55,7 @@ static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 static void free_swap_count_continuations(struct swap_info_struct *);
 static void swap_entry_range_free(struct swap_info_struct *si, swp_entry_t entry,
 				  unsigned int nr_pages);
-static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
+static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries);
 static bool folio_swapcache_freeable(struct folio *folio);
 static struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
@@ -647,7 +647,7 @@ static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 	}
 
 	memset(si->swap_map + start, usage, nr_pages);
-	swap_range_alloc(si, start, nr_pages);
+	swap_range_alloc(si, nr_pages);
 	ci->count += nr_pages;
 
 	if (ci->count == SWAPFILE_CLUSTER) {
@@ -876,19 +876,11 @@ static void del_from_avail_list(struct swap_info_struct *si)
 	spin_unlock(&swap_avail_lock);
 }
 
-static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
+static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries)
 {
-	unsigned int end = offset + nr_entries - 1;
-
-	if (offset == si->lowest_bit)
-		si->lowest_bit += nr_entries;
-	if (end == si->highest_bit)
-		WRITE_ONCE(si->highest_bit, si->highest_bit - nr_entries);
 	WRITE_ONCE(si->inuse_pages, si->inuse_pages + nr_entries);
 	if (si->inuse_pages == si->pages) {
-		si->lowest_bit = si->max;
-		si->highest_bit = 0;
 		del_from_avail_list(si);
 
 		if (vm_swap_full())
@@ -921,15 +913,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	for (i = 0; i < nr_entries; i++)
 		clear_bit(offset + i, si->zeromap);
 
-	if (offset < si->lowest_bit)
-		si->lowest_bit = offset;
-	if (end > si->highest_bit) {
-		bool was_full = !si->highest_bit;
-
-		WRITE_ONCE(si->highest_bit, end);
-		if (was_full && (si->flags & SWP_WRITEOK))
-			add_to_avail_list(si);
-	}
+	if (si->inuse_pages == si->pages)
+		add_to_avail_list(si);
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
 			si->bdev->bd_disk->fops->swap_slot_free_notify;
@@ -1035,15 +1020,12 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
 		spin_lock(&si->lock);
-		if (!si->highest_bit || !(si->flags & SWP_WRITEOK)) {
+		if ((si->inuse_pages == si->pages) || !(si->flags & SWP_WRITEOK)) {
 			spin_lock(&swap_avail_lock);
 			if (plist_node_empty(&si->avail_lists[node])) {
 				spin_unlock(&si->lock);
 				goto nextsi;
 			}
-			WARN(!si->highest_bit,
-			     "swap_info %d in list but !highest_bit\n",
-			     si->type);
 			WARN(!(si->flags & SWP_WRITEOK),
 			     "swap_info %d in list but !SWP_WRITEOK\n",
 			     si->type);
@@ -2425,8 +2407,8 @@ static void _enable_swap_info(struct swap_info_struct *si)
 	 */
 	plist_add(&si->list, &swap_active_head);
 
-	/* add to available list iff swap device is not full */
-	if (si->highest_bit)
+	/* add to available list if swap device is not full */
+	if (si->inuse_pages < si->pages)
 		add_to_avail_list(si);
 }
 
@@ -2590,7 +2572,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	drain_mmlist();
 
 	/* wait for anyone still in scan_swap_map_slots */
-	p->highest_bit = 0;		/* cuts scans short */
 	while (p->flags >= SWP_SCANNING) {
 		spin_unlock(&p->lock);
 		spin_unlock(&swap_lock);
@@ -2925,8 +2906,6 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
 		return 0;
 	}
 
-	si->lowest_bit  = 1;
-
 	maxpages = swapfile_maximum_size;
 	last_page = swap_header->info.last_page;
 	if (!last_page) {
@@ -2943,7 +2922,6 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
 		if ((unsigned int)maxpages == 0)
 			maxpages = UINT_MAX;
 	}
-	si->highest_bit = maxpages - 1;
 
 	if (!maxpages)
 		return 0;
-- 
2.47.0


