Return-Path: <linux-kernel+bounces-282422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A095894E3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5AEB21DF8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E31662FE;
	Sun, 11 Aug 2024 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9s5q37g"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFA1804F
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416605; cv=none; b=XGqXmxN1RGJpV0wBORWiUYqQIrWCTzmbgC3mt1jJVZZADTp4oKP2ceZ2E+myQkRmhjM9BcxXQ86q6znm7gDhM8JNvSK86cKfv/O+3Om47Vo983jZTVZpiykdwYquqX/uRp4hogE1fWgSWWd1kL6DDu7ImMS9LU2P05LR0XmcRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416605; c=relaxed/simple;
	bh=2pPva7HvUcC/0qEXisegrQmNfAAKFLjsualhQmyQLO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTh5GQWNRmcxxiG5wLQ0mdii6OMdkYHx8Nz80wNRD9qzk+wNqNFrkalo2PIIDTCXlIcfMhjaZSWfeBcookgAvW5LaD0vLcDSLh9hWrICoYd23UGwlM41PjDOdRsLyTWTqe015LlCg6r/WXoveegyMaop5+jeniHvLtltqYwXYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9s5q37g; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5e97b8adbso2028544eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723416603; x=1724021403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEgDKE4ERpo3w8nI4WSUoZx58a4oMDZtRCwQ+K3zmag=;
        b=A9s5q37gTahyjw8AbyHNaMbGEFT0AYlR4uszKojiiSOrhhD3hV1YLj4bt3s7yafItw
         juD8ldiFkmK2ofFYb2pGavMOiEaWY+VTunc4+Q7HYfoNkjW0Gbix5GczdHa4thNST3sN
         m33mTwwBIqVErxwW3vyJCeoXGrGoX8O/mrDnnVmh14m1G+nVOFeOuFqwsM4i43aBO4CC
         FyBstOFYhRrlDQM2EFhb/kH+CoIbjQ90pBy2tJ2Wl/bsp7QEKQetN1YkXdpLR3tfTbH6
         kwOcmrNBWwHexVTqI0ntxuFHkc+87X91QK2jrmw4jZwQbTMKgwZO5Iuy4QWcRord+1aX
         Ms6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416603; x=1724021403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEgDKE4ERpo3w8nI4WSUoZx58a4oMDZtRCwQ+K3zmag=;
        b=QW48HcM46d/1ml4UUmlfYm//Wk3g2S8Uz384JrqKiPrVNKVZOUQRNDPixBEQMECnMD
         1Y8RF7ej41hBaCnG1gPYRQOHrWmaz4QUVZlpQSC11eYgoZN9wy8MmUelmvI9kaWr+dJt
         dML48E/psUJToR8p+WRWQDHlHyA9qOEqH1D8qgbu+wC2PCPc2+jb+JsSRePdu1Phfizh
         1mnX7ga5Exc7hrqO82NhTf84GFfj+MmQm5BrZOL7KGWluA/+nlTS7E902mCuuxwbiuNR
         o+oR6GJS141dEnDwykW/pUvugd/ARPbkcoJ65mqdnMeOawb4TUBLS4uyiMAiItNlOKpg
         lPKg==
X-Forwarded-Encrypted: i=1; AJvYcCWn7Z+9h6tYS3gzbdIXa6WA0tqtari7l2sBgqDsFL1GUd6lrFem+dPpTU22VvAkFVuei8xJaGUrOn2I2y2+VVrXNEBfvqQ1/qzSYjTL
X-Gm-Message-State: AOJu0YwjA3zc+yF+q4VSkYTvJrzXOOvuA4sbGUgjBKU7Gho2I7240Jow
	tkJ+h0tmg/p6/cuJQCvgLFmPepfqGNLE4cBQo541krO5PSeJt1Pb
X-Google-Smtp-Source: AGHT+IE9ZC8p2j6VQW0lR0KF1Vkmg+7U5zG9HQ83zY+w5vCE3eQKU6K5sDiWTcNZ91l2hRRlI6QHmQ==
X-Received: by 2002:a05:6358:280d:b0:1ac:1499:34ab with SMTP id e5c5f4694b2df-1b176f838a2mr1070001055d.14.1723416602917;
        Sun, 11 Aug 2024 15:50:02 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5874ddcsm2822993b3a.28.2024.08.11.15.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 15:50:02 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	ioworker0@gmail.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ziy@nvidia.com,
	yuanshuai@oppo.com
Subject: [PATCH v2 1/2] mm: collect the number of anon large folios
Date: Mon, 12 Aug 2024 10:49:39 +1200
Message-Id: <20240811224940.39876-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811224940.39876-1-21cnbao@gmail.com>
References: <20240811224940.39876-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Anon large folios come from three places:
1. new allocated large folios in PF, they will call folio_add_new_anon_rmap()
for rmap;
2. a large folio is split into multiple lower-order large folios;
3. a large folio is migrated to a new large folio.

In all above three counts, we increase nr_anon by 1;

Anon large folios might go either because of be split or be put
to free, in these cases, we reduce the count by 1.

Folios that have been added to the swap cache but have not yet received
an anon mapping won't be counted. This is consistent with the AnonPages
statistics in /proc/meminfo.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  5 +++++
 include/linux/huge_mm.h                    | 15 +++++++++++++--
 mm/huge_memory.c                           | 13 ++++++++++---
 mm/migrate.c                               |  4 ++++
 mm/page_alloc.c                            |  5 ++++-
 mm/rmap.c                                  |  1 +
 6 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 058485daf186..9fdfb46e4560 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -527,6 +527,11 @@ split_deferred
         it would free up some memory. Pages on split queue are going to
         be split under memory pressure, if splitting is possible.
 
+nr_anon
+       the number of anon huge pages we have in the whole system.
+       These huge pages could be entirely mapped or have partially
+       unmapped/unused subpages.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4c32058cacfe..2ee2971e4e10 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -126,6 +126,7 @@ enum mthp_stat_item {
 	MTHP_STAT_SPLIT,
 	MTHP_STAT_SPLIT_FAILED,
 	MTHP_STAT_SPLIT_DEFERRED,
+	MTHP_STAT_NR_ANON,
 	__MTHP_STAT_COUNT
 };
 
@@ -136,14 +137,24 @@ struct mthp_stat {
 
 DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
 
-static inline void count_mthp_stat(int order, enum mthp_stat_item item)
+static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
 {
 	if (order <= 0 || order > PMD_ORDER)
 		return;
 
-	this_cpu_inc(mthp_stats.stats[order][item]);
+	this_cpu_add(mthp_stats.stats[order][item], delta);
+}
+
+static inline void count_mthp_stat(int order, enum mthp_stat_item item)
+{
+	mod_mthp_stat(order, item, 1);
 }
+
 #else
+static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
+{
+}
+
 static inline void count_mthp_stat(int order, enum mthp_stat_item item)
 {
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d90d6e94a800..afb911789df8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -596,6 +596,7 @@ DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
+DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
 
 static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -608,6 +609,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&split_attr.attr,
 	&split_failed_attr.attr,
 	&split_deferred_attr.attr,
+	&nr_anon_attr.attr,
 	NULL,
 };
 
@@ -3216,8 +3218,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	/* reset xarray order to new order after split */
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
-	struct anon_vma *anon_vma = NULL;
+	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
+	struct anon_vma *anon_vma = NULL;
 	int order = folio_order(folio);
 	int extra_pins, ret;
 	pgoff_t end;
@@ -3229,7 +3232,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
-	if (folio_test_anon(folio)) {
+	if (is_anon) {
 		/* order-1 is not supported for anonymous THP. */
 		if (new_order == 1) {
 			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
@@ -3269,7 +3272,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (folio_test_writeback(folio))
 		return -EBUSY;
 
-	if (folio_test_anon(folio)) {
+	if (is_anon) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
 		 * prevent the anon_vma disappearing so we first we take a
@@ -3382,6 +3385,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			}
 		}
 
+		if (is_anon) {
+			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
+		}
 		__split_huge_page(page, list, end, new_order);
 		ret = 0;
 	} else {
diff --git a/mm/migrate.c b/mm/migrate.c
index 7e1267042a56..bde573ec2af8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -423,6 +423,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		/* No turning back from here */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
+		if (folio_test_anon(folio) && folio_test_large(folio))
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 		if (folio_test_swapbacked(folio))
 			__folio_set_swapbacked(newfolio);
 
@@ -447,6 +449,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	 */
 	newfolio->index = folio->index;
 	newfolio->mapping = folio->mapping;
+	if (folio_test_anon(folio) && folio_test_large(folio))
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 	folio_ref_add(newfolio, nr); /* add cache reference */
 	if (folio_test_swapbacked(folio)) {
 		__folio_set_swapbacked(newfolio);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 84a7154fde93..382c364d3efa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1084,8 +1084,11 @@ __always_inline bool free_pages_prepare(struct page *page,
 			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
 	}
-	if (PageMappingFlags(page))
+	if (PageMappingFlags(page)) {
+		if (PageAnon(page) && compound)
+			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		page->mapping = NULL;
+	}
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
 			bad++;
diff --git a/mm/rmap.c b/mm/rmap.c
index a6b9cd0b2b18..b7609920704c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	}
 
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
+	mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 }
 
 static __always_inline void __folio_add_file_rmap(struct folio *folio,
-- 
2.34.1


