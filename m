Return-Path: <linux-kernel+bounces-211510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C6C9052DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484CC1C22657
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2469817B4E5;
	Wed, 12 Jun 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO2ywnDv"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE3176256
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196477; cv=none; b=L39d6LWhOfT3d/mpcjM8X/pnSsKAqslx/EFS3D+ncdb3vAgPMUu9eoWHZ/JAu4w9p5Q8GsyDrRYHA4T/qrv9QlWsMS+zeL8z/8mn3NpWizMJNhkOJCHJjFcFU6Q/rPYjgb5Lqp6swKQ3L7qYS03DmpTj5fUCvlLBsmSzhFTBDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196477; c=relaxed/simple;
	bh=gitYfoxKBKX3SHFNxHblEiolXRlKgPqtoJcmsOdNG9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5erE8cOMVEGav1x7JemOsHRfTZJgzdF8I9C1oMuUlXY9Hk8YHoFJUrz3cLHomkWRaNzWECid1J+LmljRMXNfUpf0Dv40KU0SIWs9oZUPkMog19DKB//vaxgimYYQD2sNE2ONuZj8SADh9o3ruYHy4zl5PMYUBw2Of/YmL++hUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO2ywnDv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-440530cadc7so12661881cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718196474; x=1718801274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA/i9kGTfJC6xvqtw7O5uORmvK7ZuPAipxeerdrc6dg=;
        b=kO2ywnDv18tSNOdq3xBQBIbd2X+8PMSj1/+oQapThorRTDyup+Zq7TcNJXKcwXQacJ
         y1iS6G2fhAgGnlVoEiA5HkHphp8ayu9wqgQwDyt6syLwUuZeUDWDcanyqqWHOcY8UCVH
         55dVjJ/aT9AqGN2fWVhVV4F9nxE4niR5ALC/xZBjTXDnkHpB+2zJi2vXyv1wv+/AUguR
         5AbXhK55woz2zMuNCh8gSmOh4RQdEKsOvrl+5G0IfV5R3SHszhPNR/WUG0KSAG7SanRe
         jMJaYROJgXcG5Qh0c1zN5ON+zPH6AG2xejSOR8pkp/BWnow5Qnz5BE+iLcpoozcxhgiF
         NUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196474; x=1718801274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YA/i9kGTfJC6xvqtw7O5uORmvK7ZuPAipxeerdrc6dg=;
        b=JNGI6zTe1mvrd7b3UFhur1EwVaQZEXJNC9qksFi/J+uJTAnL/SkMub1y+nm5R+aCfG
         WqhsDqne2B6qdmuT2x1xK7Kx4xK/ksgccGzB6o2hmcfXCS5msc2d8x+5hYxVaaO9bvAj
         lt4z36cWZ7vae/jAwr+/D/h/pQJo1Lsylf0KuyboirlZS+GFg/yqBuRHZcM/c6e9xAdF
         oLa62fa3fej0xqK2JpILKS+C8j+0sItDD2kIj4pLWXQ0gP/f17DHLEBhdMskEslpAZhB
         rVfrcQ6VBLlJn7UQ7a614oI2QBl3sjX/SEsTGmc2+CuFfXSsX9lJYzte7oCppN0p0+KI
         KXUw==
X-Forwarded-Encrypted: i=1; AJvYcCUO9bxWYTxR3PnkQNTT1Nviyfp7vh7OarlCssM++PtwOO9txzJr9x85yo8GyaHrjOZHj4HcZ6W2E1Cu3LULbOa6OvRsQGLv5O2y1/Wj
X-Gm-Message-State: AOJu0YzWGLWiu1k+Xgej/nZdVamUUDlxojGIXpoFp0hTBfqRdHtaohOW
	OJD2eFO59U2OsIJ4+D9C0b8VrrGuGQ4A4qQ28jwrSOfHbMHrJYrt
X-Google-Smtp-Source: AGHT+IE1CPP/v/4tI/OK9eS0gZXEc9/e7Fh8lfMD02Ajhy/Np6G3I/hIvWhzZWbp9Vcv211/Yhk2Iw==
X-Received: by 2002:ac8:5841:0:b0:440:5c2c:4cdb with SMTP id d75a77b69052e-4415abad660mr15732401cf.2.1718196474067;
        Wed, 12 Jun 2024 05:47:54 -0700 (PDT)
Received: from localhost (fwdproxy-ash-001.fbsv.net. [2a03:2880:20ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4406107ebf1sm33834781cf.95.2024.06.12.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:47:53 -0700 (PDT)
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
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
Date: Wed, 12 Jun 2024 13:43:35 +0100
Message-ID: <20240612124750.2220726-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612124750.2220726-1-usamaarif642@gmail.com>
References: <20240612124750.2220726-1-usamaarif642@gmail.com>
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
---
 include/linux/swap.h |   1 +
 mm/page_io.c         | 114 ++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        |  24 ++++++++-
 3 files changed, 136 insertions(+), 3 deletions(-)

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
index a360857cf75d..39fc3919ce15 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -172,6 +172,88 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 	goto out;
 }
 
+static bool is_folio_page_zero_filled(struct folio *folio, int i)
+{
+	unsigned long *data;
+	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
+	bool ret = false;
+
+	data = kmap_local_folio(folio, i * PAGE_SIZE);
+	if (data[last_pos])
+		goto out;
+	for (pos = 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
+		if (data[pos])
+			goto out;
+	}
+	ret = true;
+out:
+	kunmap_local(data);
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
+static void folio_zero_fill(struct folio *folio)
+{
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++)
+		clear_highpage(folio_page(folio, i));
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
@@ -195,6 +277,13 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_unlock(folio);
 		return ret;
 	}
+
+	if (is_folio_zero_filled(folio)) {
+		swap_zeromap_folio_set(folio);
+		folio_unlock(folio);
+		return 0;
+	}
+	swap_zeromap_folio_clear(folio);
 	if (zswap_store(folio)) {
 		folio_start_writeback(folio);
 		folio_unlock(folio);
@@ -426,6 +515,26 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
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
+	folio_zero_fill(folio);
+	folio_mark_uptodate(folio);
+	return true;
+}
+
 static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
@@ -515,8 +624,9 @@ void swap_read_folio(struct folio *folio, bool synchronous,
 		psi_memstall_enter(&pflags);
 	}
 	delayacct_swapin_start();
-
-	if (zswap_load(folio)) {
+	if (swap_read_folio_zeromap(folio)) {
+		folio_unlock(folio);
+	} else if (zswap_load(folio)) {
 		folio_mark_uptodate(folio);
 		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f1e559e216bd..48d8dca0b94b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -453,6 +453,8 @@ static unsigned int cluster_list_del_first(struct swap_cluster_list *list,
 static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 		unsigned int idx)
 {
+	unsigned int i;
+
 	/*
 	 * If scan_swap_map_slots() can't find a free cluster, it will check
 	 * si->swap_map directly. To make sure the discarding cluster isn't
@@ -461,6 +463,13 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 	 */
 	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
 			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
+	/*
+	 * zeromap can see updates from concurrent swap_writepage() and swap_read_folio()
+	 * call on other slots, hence use atomic clear_bit for zeromap instead of the
+	 * non-atomic bitmap_clear.
+	 */
+	for (i = 0; i < SWAPFILE_CLUSTER; i++)
+		clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
 
 	cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
 
@@ -482,7 +491,7 @@ static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
 static void swap_do_scheduled_discard(struct swap_info_struct *si)
 {
 	struct swap_cluster_info *info, *ci;
-	unsigned int idx;
+	unsigned int idx, i;
 
 	info = si->cluster_info;
 
@@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
 		__free_cluster(si, idx);
 		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
 				0, SWAPFILE_CLUSTER);
+		for (i = 0; i < SWAPFILE_CLUSTER; i++)
+			clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
 		unlock_cluster(ci);
 	}
 }
@@ -1059,9 +1070,12 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 {
 	unsigned long offset = idx * SWAPFILE_CLUSTER;
 	struct swap_cluster_info *ci;
+	unsigned int i;
 
 	ci = lock_cluster(si, offset);
 	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
+	for (i = 0; i < SWAPFILE_CLUSTER; i++)
+		clear_bit(offset + i, si->zeromap);
 	cluster_set_count_flag(ci, 0, 0);
 	free_cluster(si, idx);
 	unlock_cluster(ci);
@@ -1336,6 +1350,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 	count = p->swap_map[offset];
 	VM_BUG_ON(count != SWAP_HAS_CACHE);
 	p->swap_map[offset] = 0;
+	clear_bit(offset, p->zeromap);
 	dec_cluster_info_page(p, p->cluster_info, offset);
 	unlock_cluster(ci);
 
@@ -2597,6 +2612,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	vfree(swap_map);
+	bitmap_free(p->zeromap);
 	kvfree(cluster_info);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
@@ -3123,6 +3139,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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


