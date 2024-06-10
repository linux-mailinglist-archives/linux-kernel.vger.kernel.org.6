Return-Path: <linux-kernel+bounces-208143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805690216C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5EC9B24130
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1391680035;
	Mon, 10 Jun 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZpHlgAu"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1917F498
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021909; cv=none; b=ain6KACvMP4LLUxn/wOxc79K9TEys5n7lXXGv/inKxYsh/I1dEfGzalYoz0YApr8pouD5fmX18Vv1B577kOtlsphugCziLIXkUh8HdWWrbidyhagsD/qe/WtgseSb7X8B4yZuPj1fvr7bvzgbZhGiavrdr0j4B1vTRZdeSkrB2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021909; c=relaxed/simple;
	bh=9+X5chMM78ZCXcGy2haYPPGQLERHdK5PIRCndYkt8Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBbT2G9dWeSnTZAPKwAhwdy/+3ihm0WRjnZOhug+C+aCp70TSFwXxDBf5YAA4ZgkGKYVq+GfDbLjkRKqhxytNIb+wt0oK+GU7OdRfgDOM9DdE+QaKsmCUkt9yAbULLXrZ9zhSsQEofZquQU4kCnYnyE6JzGpcgh4jsjTizU4UQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZpHlgAu; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b072522bd5so8012836d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718021905; x=1718626705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enp1TRQZwGsuV9i2AxeXdZVfnUfEdxfgu+pXvPIz5hY=;
        b=KZpHlgAu5lfw0WfGhR0zDkZIBjLgvOo8zIhFjKA7yJqlBEpa8ZBbLsViKHp0k96PtY
         jXlQ+kvSaScgmXlN2KKlEaJHUlvFE73xDpzScXHkl56dC1sOLg/7oUBz5CK4oeRNY5+O
         fJQYMS9+dEQYVAAvdCL/slkgvx6I7O8nC2LYUbNSvIT3A6xF2WWHnVTfoxzBtHkf/sPW
         qtt/K3SHiV+rSwdvIY2CknSAwuI3ltJfTNuc8U7pitR3py4QYI4fATjYM1bHD7D4G1MN
         nG5BMbNmkJEyiArGSgaUnWprmJsclKCV619UTt8bpArRR/YEHvDWofu5sqwPo+NMia53
         AA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718021905; x=1718626705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enp1TRQZwGsuV9i2AxeXdZVfnUfEdxfgu+pXvPIz5hY=;
        b=LnYkjuACLxvVDO5NbhiMeyo3QKem8at+kjadJvFnEg81TvsTCJHy3a3J9sbYLwXpel
         AOPYHyNr14VC7p2jXzxCTaERA7BDmMmCYJn/poQqLgWkEafQQ/sOEQeOou5slpCjGhZA
         u6ihWZoD5Xb4SvqKD5+9dMeWWuIiSU4JBEvPcE+OJzNA/agabs8RtN7roMJvZDgclv0s
         huTq+o9fiDev7fwGHjSlGZt5yFmW9vr/fyv/9qzIoEyi/sP0olBaLcSxbtPT3cL/6+xw
         7LZtSOGz3VDoczdgqsc8VZKsTCWscfb7e6NojUcNtHKTfShOY4g/FDsLBg3f9Rn4r16X
         HB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWx7OQjegta1LMYcUNpO+ZICKl/tZAsyj/ATBs4I7F6GcGjE31kJi5rs44t2CgJZPYq1XRGJT4xviMEcyUDa3VTSgXznv49LZFkMcsj
X-Gm-Message-State: AOJu0YzhwJz04JCWcPQflQjmKqdzAbvn0MSBwW+hWCp5jGAkvSnxH6Tc
	gc/n1ksYNW0qa7E3caMChDQT635gXDjKIlHL182b3fBtqfpVP6HldAEQeuKfTVz8uQ==
X-Google-Smtp-Source: AGHT+IER/6/Ev/fin7kHekd/wvr1haZ/PJS9r0VJYzapmkP25Xc4EV0tD+B/2Rh4HpReLXXohs1EQQ==
X-Received: by 2002:a05:6214:5990:b0:6b0:7206:e7a4 with SMTP id 6a1803df08f44-6b07206ebd7mr69801746d6.3.1718021905323;
        Mon, 10 Jun 2024 05:18:25 -0700 (PDT)
Received: from localhost (fwdproxy-ash-000.fbsv.net. [2a03:2880:20ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0683044dbsm27042936d6.75.2024.06.10.05.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:18:24 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
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
Subject: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
Date: Mon, 10 Jun 2024 13:15:59 +0100
Message-ID: <20240610121820.328876-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610121820.328876-1-usamaarif642@gmail.com>
References: <20240610121820.328876-1-usamaarif642@gmail.com>
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
 mm/page_io.c         | 92 +++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        | 21 +++++++++-
 3 files changed, 111 insertions(+), 3 deletions(-)

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
index a360857cf75d..2cac1e11fb85 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -172,6 +172,82 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
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
@@ -195,6 +271,15 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
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
+	swap_zeromap_folio_clear(folio);
 	if (zswap_store(folio)) {
 		folio_start_writeback(folio);
 		folio_unlock(folio);
@@ -515,8 +600,11 @@ void swap_read_folio(struct folio *folio, bool synchronous,
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
index f1e559e216bd..90451174fe34 100644
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
@@ -1336,6 +1347,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 	count = p->swap_map[offset];
 	VM_BUG_ON(count != SWAP_HAS_CACHE);
 	p->swap_map[offset] = 0;
+	clear_bit(offset, p->zeromap);
 	dec_cluster_info_page(p, p->cluster_info, offset);
 	unlock_cluster(ci);
 
@@ -2597,6 +2609,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	vfree(swap_map);
+	bitmap_free(p->zeromap);
 	kvfree(cluster_info);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
@@ -3123,6 +3136,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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


