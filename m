Return-Path: <linux-kernel+bounces-195257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5018D4999
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307521C22344
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A0017D347;
	Thu, 30 May 2024 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMvcM5WP"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A1176ADD
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064507; cv=none; b=D+hCFYUAmvtYHbQeoYcqfXvI7RCkCvVkDFh7qvih/SKiYaMBloEoTgMzdQMjjmwSG3ivGGR1z9YrEuRCa+QvJOZFFIKILwIf/Gc0ajQQBtoea0UBPsJtdNpsi/Pjk4klszMZdqixeAHLhvxJcGdAAgTWC+sacm/4TDjuYRQWcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064507; c=relaxed/simple;
	bh=F+OGsN0Vk5KwJaBSUrp5JmBtGHDQki/mImXGQEw45w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adoa48cz4og65Tvdlvr2wMHZdaNOda/N24nuL7b1bDq0E++QOyz6C8Ox6p+mo5TAduD+90G0yx1m/hoL0DBx9SVe7UnYYP/6BhA1xTjkUcazeWgnm4ynXHLto6bLgiloDjqQk2jniPjTLSOnKiJQqyJIHCQLCqDt1Mf9Uq7Sb8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMvcM5WP; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfa65af5367so283082276.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717064505; x=1717669305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv2ZaVw6OgZTxb8YIYWTp0HwSOfDS6TRl5l+DF4nA8U=;
        b=GMvcM5WPKqoPw0lEXWpD/c3fgPR+8FvHJNAC1kQ0ajfPhr/71ji6ixr9zEmqQTU2E4
         mpMep4GgpVlGYGcVWjrCTtFzPiFkPdhJTf24UlmwGv1RazEpT/2hXXMHMY3bWnymZiWw
         86gQEQ1G/Hmk0+MKPaArtCFOcw5PA8T2n+9Dqlmwrr2LiqRZXr/nvUNnP73uuyI2RFny
         fbPEYpKHdyObmNSPD0LXcWYnM7IHIREmbCf9jzZ7QcqKgQD53ZTYVlXmGVT7laZNLj21
         I7ErLgDiaTduo5TWp4vjc2X+glw6bubN19c90qegNtULv46tuc0JPauyRE8KBuhbM3aQ
         Gt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717064505; x=1717669305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uv2ZaVw6OgZTxb8YIYWTp0HwSOfDS6TRl5l+DF4nA8U=;
        b=OSOwtPc1vpuInvPIfecXT48875kCgGMgUIHKqQncgXP0N6AcaVnjmBy6BqZ6+B93F6
         fYu+mGo3idPlI4QEOpf4hZbrLbItLpCFlIqaO+WLRaF0BXVvWnVcizub4xBBIK3ZzP+6
         wsVryYn+M/gV3smnSItvuq6fUT1+LUgiDQVgI/y2jC8EwLew9SIiXdWGK35H3mIaFQka
         h7on54Ljl7183TGdg7DcJCdLjfEogadX080GjpYjvKsl3buEoOOn9TxZdqGnezN7vLoM
         0JIG8q+kfGKSqVsIzzVeNJY09C7Gv68T+INBPqaV+HdIcczWt79k6wtG2mvujFaFOpFM
         Zd/g==
X-Forwarded-Encrypted: i=1; AJvYcCVIVpBLxyIgqhcun3KCZv3A7Jn18+EEFGc3to9ricshHjLuTBrLhSLCxEKL4lWrFpED24zkOQmPNJi9hbvD9CYlbt3yu15eaLib3Qbt
X-Gm-Message-State: AOJu0YzlcR95Zkw+Tv1/4qjtWlLCCY9d778+Ud7gaxQCsMyHeFwyKsHp
	cyoxVlYGn5uwnvhTaoo3Cx43LMyCzZnIfMO48UQpQ34zj9K/JlG/
X-Google-Smtp-Source: AGHT+IG2E/LBvRU71yDXoonabPkGi2UQCArX8XpUUuRFH+o0Gt0qc8K+S8vP/fgQu4t2rbZd7Wnm1g==
X-Received: by 2002:a25:8389:0:b0:de5:5a6f:a52a with SMTP id 3f1490d57ef6-dfa5a5f219emr2032469276.26.1717064504809;
        Thu, 30 May 2024 03:21:44 -0700 (PDT)
Received: from localhost (fwdproxy-nao-002.fbsv.net. [2a03:2880:23ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae24d5ea8dsm1524366d6.65.2024.05.30.03.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:21:44 -0700 (PDT)
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
Subject: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap
Date: Thu, 30 May 2024 11:19:07 +0100
Message-ID: <20240530102126.357438-2-usamaarif642@gmail.com>
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

Approximately 10-20% of pages to be swapped out are zero pages [1].
Rather than reading/writing these pages to flash resulting
in increased I/O and flash wear, a bitmap can be used to mark these
pages as zero at write time, and the pages can be filled at
read time if the bit corresponding to the page is set.
With this patch, NVMe writes in Meta server fleet decreased
by almost 10% with conventional swap setup (zswap disabled).

[1]https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/swap.h |  1 +
 mm/page_io.c         | 86 ++++++++++++++++++++++++++++++++++++++++++--
 mm/swapfile.c        | 10 ++++++
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a11c75e897ec..e88563978441 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -299,6 +299,7 @@ struct swap_info_struct {
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
+	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct swap_cluster_list free_clusters; /* free clusters list */
 	unsigned int lowest_bit;	/* index of first free in swap_map */
diff --git a/mm/page_io.c b/mm/page_io.c
index a360857cf75d..ab043b4ad577 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -172,6 +172,77 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 	goto out;
 }
 
+static bool is_folio_page_zero_filled(struct folio *folio, int i)
+{
+	unsigned long *page;
+	unsigned int pos;
+	bool ret = false;
+
+	page = kmap_local_folio(folio, i * PAGE_SIZE);
+	for (pos = 0; pos < PAGE_SIZE / sizeof(*page); pos++) {
+		if (page[pos] != 0)
+			goto out;
+	}
+	ret = true;
+out:
+	kunmap_local(page);
+	return ret;
+}
+
+static bool is_folio_zero_filled(struct folio *folio)
+{
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		if (!is_folio_page_zero_filled(folio, i))
+			return false;
+	}
+	return true;
+}
+
+static void folio_page_zero_fill(struct folio *folio, int i)
+{
+	unsigned long *page;
+
+	page = kmap_local_folio(folio, i * PAGE_SIZE);
+	memset_l(page, 0, PAGE_SIZE / sizeof(unsigned long));
+	kunmap_local(page);
+}
+
+static void folio_zero_fill(struct folio *folio)
+{
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++)
+		folio_page_zero_fill(folio, i);
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
+		bitmap_set(sis->zeromap, swp_offset(entry), 1);
+	}
+}
+
+static bool swap_zeromap_folio_test(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_entry_t entry;
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		entry = page_swap_entry(folio_page(folio, i));
+		if (!test_bit(swp_offset(entry), sis->zeromap))
+			return false;
+	}
+	return true;
+}
+
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -195,6 +266,14 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_unlock(folio);
 		return ret;
 	}
+
+	if (is_folio_zero_filled(folio)) {
+		swap_zeromap_folio_set(folio);
+		folio_start_writeback(folio);
+		folio_unlock(folio);
+		folio_end_writeback(folio);
+		return 0;
+	}
 	if (zswap_store(folio)) {
 		folio_start_writeback(folio);
 		folio_unlock(folio);
@@ -515,8 +594,11 @@ void swap_read_folio(struct folio *folio, bool synchronous,
 		psi_memstall_enter(&pflags);
 	}
 	delayacct_swapin_start();
-
-	if (zswap_load(folio)) {
+	if (swap_zeromap_folio_test(folio)) {
+		folio_zero_fill(folio);
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+	} else if (zswap_load(folio)) {
 		folio_mark_uptodate(folio);
 		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f1e559e216bd..3f00a1cce5ba 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -461,6 +461,7 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 	 */
 	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
 			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
+	bitmap_clear(si->zeromap, idx * SWAPFILE_CLUSTER, SWAPFILE_CLUSTER);
 
 	cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
 
@@ -498,6 +499,7 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
 		__free_cluster(si, idx);
 		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
 				0, SWAPFILE_CLUSTER);
+		bitmap_clear(si->zeromap, idx * SWAPFILE_CLUSTER, SWAPFILE_CLUSTER);
 		unlock_cluster(ci);
 	}
 }
@@ -1336,6 +1338,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 	count = p->swap_map[offset];
 	VM_BUG_ON(count != SWAP_HAS_CACHE);
 	p->swap_map[offset] = 0;
+	bitmap_clear(p->zeromap, offset, 1);
 	dec_cluster_info_page(p, p->cluster_info, offset);
 	unlock_cluster(ci);
 
@@ -2597,6 +2600,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	vfree(swap_map);
+	bitmap_free(p->zeromap);
 	kvfree(cluster_info);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
@@ -3123,6 +3127,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
+	if (!p->zeromap) {
+		error = -ENOMEM;
+		goto bad_swap_unlock_inode;
+	}
+
 	if (p->bdev && bdev_stable_writes(p->bdev))
 		p->flags |= SWP_STABLE_WRITES;
 
-- 
2.43.0


