Return-Path: <linux-kernel+bounces-232169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85391A461
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732A91C20C59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD920143898;
	Thu, 27 Jun 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVorP/dY"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A113E8B9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485856; cv=none; b=VPPvtW50ihlzAJ/JKO4DxvOxvXMeEaejN0YpSyuyzrcD4781kB3a4HOAGBZH/AFoayGaebG7n2K24sZhKKEWNuoMuU0HjLUkakxjZ8yoHdUSPVl2fY7K40L5aEku2L2csPkoU74vy8CcEEyAnhZsipEv5Vp7IvvWuLxPNOS+i2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485856; c=relaxed/simple;
	bh=mIlS4otReTXqtFx0zqLhNK3zdBqkJJXBOv/2ceD2DS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEJiztU/qFyfGpnRUGB4jNZEKhVqur9VAArhfybr47dhVeOhB+j1eQm7aF12qQW5WAqZKcJUNxX/8iZ6SiYcJzVYvqEfITSlZDsxGjZSFMakVLBmM8149AzV126zMc7SFY1Hb6dYwtXCpvYvh72v/y/ALybKNy1VogrGD4c/TgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVorP/dY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44637e13866so7603541cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719485854; x=1720090654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkzTW/11bPuGoCkFDaajiq8WxKpIkXClRk/0ynrGzvk=;
        b=QVorP/dYycrK5qzk0KkJ754N/SKBin03Y9dLG7f4hicoCUn++/JUwGexw3mmclpUe3
         GhAU0/QnHZe95b/nryZH0fD/XLIONVuiKggV9O4UXF7Qqm+4KDgaeSRfBM6SXKy9mQY5
         xwJYe/QX+h2lzXmyGQfZbLMcLHodAMwwDGbRPLS6nwLHsS9NlLBt1RB7ik9M0NfhDB2t
         h/3HwzqBl0+R2UMSdlntOl2bhSbjXzf40iroJ1jj3EPCcoLdd0SQAvqL+LPlB8ZxoV6c
         tPrdfYQI5onsLJc0XXU7DWOaa/FR4ZqYJW6Y3+lcXKpdvyoWiV1mW09ZsphCpDykX8uU
         y6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719485854; x=1720090654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkzTW/11bPuGoCkFDaajiq8WxKpIkXClRk/0ynrGzvk=;
        b=stgwseYO3ClatOpuOQoajri4KwmMMoBFOXDi8hx3QKtY5vGI3CQCFxn8bRKMNIcwAZ
         5Ewqs+fUXqfaBXJDnvGcM39ezVyCV6bwQPRTB5lhGYBVSj/8AgJfRAXUyNQxn64kbYOp
         St8SNrcDboEYGI4xmnzr48Rn9FGo9yHdD5c0c3FsCOL9e2kTJdMboKWZHVitqX00Hirb
         UD6o7SiB124d5c9LBVqJ0X3ql2KeyjsEnyjrQ4aR7c9G6DHMAIohilsgZlkjkZC2Cpxp
         BwWvQb166OT2J60dsZwCK4Gg49vs+QtkdfN60WumD+eJ7wcJ0rfgGXvzCIi9g1og1CxY
         EtTA==
X-Forwarded-Encrypted: i=1; AJvYcCU+RWZRePeH77P+lVWNyRGsHDo45qGGQ18YdAp9j+NTbk+Qarh0XUDZZvDOI5fSvwKVe8G9bviijU0K9rCNr1pbyd4G1pu62ofHKkRz
X-Gm-Message-State: AOJu0YyBFvRZjUbKXfvt5dGdbpRIz0oF/VkjYFKcJvvGvylPPgEplHbN
	kFPQ2BjZJjKaH1GvBcfWuqjUwD09IzKSA5kwoDntuPm6n0jmhht8
X-Google-Smtp-Source: AGHT+IG1BjfEOxsFo5R+ptwaWh5pstieIxvFw0KT+PkhQXtF7aARv9WfbDIto8OWrrisoVsji9V5dA==
X-Received: by 2002:a05:622a:15d3:b0:445:5ae:ba84 with SMTP id d75a77b69052e-44505aec008mr64953341cf.15.1719485853832;
        Thu, 27 Jun 2024 03:57:33 -0700 (PDT)
Received: from localhost (fwdproxy-ash-004.fbsv.net. [2a03:2880:20ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44641eb4699sm4796381cf.38.2024.06.27.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:57:33 -0700 (PDT)
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
Subject: [PATCH v7 1/2] mm: store zero pages to be swapped out in a bitmap
Date: Thu, 27 Jun 2024 11:55:29 +0100
Message-ID: <20240627105730.3110705-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627105730.3110705-1-usamaarif642@gmail.com>
References: <20240627105730.3110705-1-usamaarif642@gmail.com>
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
---
 include/linux/swap.h |   1 +
 mm/page_io.c         | 113 ++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        |  20 ++++++++
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3df75d62a835..ed03d421febd 100644
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
index 6c1c1828bb88..480b8f221d90 100644
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
 		folio_unlock(folio);
 		return 0;
@@ -424,6 +513,26 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
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
@@ -514,7 +623,9 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	}
 	delayacct_swapin_start();
 
-	if (zswap_load(folio)) {
+	if (swap_read_folio_zeromap(folio)) {
+		folio_unlock(folio);
+	} else if (zswap_load(folio)) {
 		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9c6d8e557c0f..028d33f3a76d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -747,6 +747,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
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
@@ -2635,6 +2643,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	vfree(swap_map);
+	kvfree(p->zeromap);
 	kvfree(cluster_info);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
@@ -3161,6 +3170,17 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	/*
+	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
+	 * be above MAX_PAGE_ORDER incase of a large swap file.
+	 */
+	p->zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(unsigned long),
+				    GFP_KERNEL | __GFP_ZERO);
+	if (!p->zeromap) {
+		error = -ENOMEM;
+		goto bad_swap_unlock_inode;
+	}
+
 	if (p->bdev && bdev_stable_writes(p->bdev))
 		p->flags |= SWP_STABLE_WRITES;
 
-- 
2.43.0


