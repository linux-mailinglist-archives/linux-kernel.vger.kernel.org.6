Return-Path: <linux-kernel+bounces-299814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE74C95DA4E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1651F23545
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01835CB8;
	Sat, 24 Aug 2024 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RftW/CRR"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18692B65C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724461511; cv=none; b=XlpyHazxSCtdip3ylRVT/GJfr/ZjvHmaRARwfjclD+OMncMihZOfRmHIqqNfcfUhbcp5o/9LkUaGblWRIPl19TuoF3e0yq/vqhxULO75NosTM/32qVT0vsubkg3Yg6CvWSxGyUtbTtLINCibsu4U+3fp4HNGKcPbSuQDIkdTKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724461511; c=relaxed/simple;
	bh=43zuqb8hkOJJT+puKuDdXVztZqx9pQmQdWCuJmqfG/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kap1nHoz2mO7oyi0hEenKJPB47Xz35Ofiwbd5ngHEodwLzum9EMXPwvg7/OtaKhld+AGjE81Kz9DVVGplsgyIpsVFgzoaDHs2rp3LmTb/5v/vKkk5Ew7JmJFCOiVE85TkknU65FgrV2T8Sc4ovQ21eJ0sIdou8dR4mbh1oOxJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RftW/CRR; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70945a007f0so2107694a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724461509; x=1725066309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/o1HIzXNMob30fXF5zmCRt2n3hoqmCYtF+NPffM/eQ=;
        b=RftW/CRRCIZSH74rQbns4ZT/vWrsSStVk0pYv3kQ8gC7Yn4oZPTrvKRJ/XbqPRXmZ2
         AXQ4Ylsdr2d1Qu5EWQR7NvA1MDQIE+cskGb4vt3Inss5h1y+BksHztrGgcbYZSXO5cNE
         s6Xuk+QI58QAwAj+XFoKs0xmIZTZmS78O4L+tzA0VQZz+/5q/Om3f420+9QOSaOqRGr5
         rslUjUrWZbwPXcTTz1eT/6c7eOCOh7Gg67sKxu36Mu4WZGlkCp2X8EDmRr1pLuN4PByP
         SURNoCkFepN3lSgjEmhmboVuhC7iBPtqNX7QWYJ/e8C6DccbdO3gLN/7s5Dzc5oN0nrI
         QhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724461509; x=1725066309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/o1HIzXNMob30fXF5zmCRt2n3hoqmCYtF+NPffM/eQ=;
        b=ms7J1owThDqu4PTRnC8eVupVNYYmh4QFzKyXUj1pzMnTDU9e0c9a25kRpksegzhsh6
         4xIyv6d02XH0hiOhZ28zV2bsgYRo9Evgu12IAv6aePpT7CRE5XUybwxLUP2nGjJegjSm
         MMIR8ntU6TWlD/qskriVdz5OnBKrPyfzeoFeZmlB7DABVEF0xDNevuUpdXKKqjTPZCNI
         RTTTsShNVzMUDcvK/kZVdR2ONXiCsc5sDSYyMT+OXefBZya3ACt5ooPVoiGwBrPnKE5x
         GOTJEkcCShKK8a7SrWmR99VWTVTq8LvYRU8s7YijgU2QaHzwxturAZde+DBwsvgI2fsv
         P0rg==
X-Forwarded-Encrypted: i=1; AJvYcCWwrQN7wegKBQgKtEh8b8k/dR5z8r8LAryG59ya+Pktd+OXnry4udJw4iNRn7pl7L/8LeLcIR2iTXhFHpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6HL79muaa0q15XvN5GYEYvroXTKQXWpVpzyueD7DnXde1kjl
	+iNmrhvUVk2PH3cKjwZiY5N8GNBC868Hv3Uf0nlLrEYQjqXbw+rJ
X-Google-Smtp-Source: AGHT+IHSjqtgJC33yaq8apeRF8rlt8GA3MppGd4QfCOxrURvtmHnsAtQ/+hq9+EVB/CoETVjurGJLg==
X-Received: by 2002:a05:6808:18a2:b0:3d9:303a:fc6d with SMTP id 5614622812f47-3de2a8d41a7mr5142441b6e.41.1724461509124;
        Fri, 23 Aug 2024 18:05:09 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:8d8:dd4b:c921:b282])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad56c9fsm3274064a12.64.2024.08.23.18.05.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Aug 2024 18:05:08 -0700 (PDT)
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
	usamaarif642@gmail.com,
	v-songbaohua@oppo.com,
	yuanshuai@oppo.com,
	ziy@nvidia.com
Subject: [PATCH v4 1/2] mm: count the number of anonymous THPs per size
Date: Sat, 24 Aug 2024 13:04:40 +1200
Message-Id: <20240824010441.21308-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240824010441.21308-1-21cnbao@gmail.com>
References: <20240824010441.21308-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Let's track for each anonymous THP size, how many of them are currently
allocated. We'll track the complete lifespan of an anon THP, starting
when it becomes an anon THP ("large anon folio") (->mapping gets set),
until it gets freed (->mapping gets cleared).

Introduce a new "nr_anon" counter per THP size and adjust the
corresponding counter in the following cases:
* We allocate a new THP and call folio_add_new_anon_rmap() to map
   it the first time and turn it into an anon THP.
* We split an anon THP into multiple smaller ones.
* We migrate an anon THP, when we prepare the destination.
* We free an anon THP back to the buddy.

Note that AnonPages in /proc/meminfo currently tracks the total number
of *mapped* anonymous *pages*, and therefore has slightly different
semantics. In the future, we might also want to track "nr_anon_mapped"
for each THP size, which might be helpful when comparing it to the
number of allocated anon THPs (long-term pinning, stuck in swapcache,
memory leaks, ...).

Further note that for now, we only track anon THPs after they got their
->mapping set, for example via folio_add_new_anon_rmap(). If we would
allocate some in the swapcache, they will only show up in the statistics
for now after they have been mapped to user space the first time, where
we call folio_add_new_anon_rmap().

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  5 +++++
 include/linux/huge_mm.h                    | 15 +++++++++++++--
 mm/huge_memory.c                           | 13 ++++++++++---
 mm/migrate.c                               |  4 ++++
 mm/page_alloc.c                            |  5 ++++-
 mm/rmap.c                                  |  1 +
 6 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 79435c537e21..b78f2148b242 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -551,6 +551,11 @@ split_deferred
         it would free up some memory. Pages on split queue are going to
         be split under memory pressure, if splitting is possible.
 
+nr_anon
+       the number of transparent anon huge pages we have in the whole system.
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
index 513e7c87efee..26ad75fcda62 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -597,6 +597,7 @@ DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
+DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
 
 static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -609,6 +610,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&split_attr.attr,
 	&split_failed_attr.attr,
 	&split_deferred_attr.attr,
+	&nr_anon_attr.attr,
 	NULL,
 };
 
@@ -3314,8 +3316,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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
@@ -3327,7 +3330,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
-	if (folio_test_anon(folio)) {
+	if (is_anon) {
 		/* order-1 is not supported for anonymous THP. */
 		if (new_order == 1) {
 			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
@@ -3367,7 +3370,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (folio_test_writeback(folio))
 		return -EBUSY;
 
-	if (folio_test_anon(folio)) {
+	if (is_anon) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
 		 * prevent the anon_vma disappearing so we first we take a
@@ -3480,6 +3483,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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
index 4f55f4930fe8..3cc8555de6d6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -450,6 +450,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		/* No turning back from here */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
+		if (folio_test_anon(folio) && folio_test_large(folio))
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 		if (folio_test_swapbacked(folio))
 			__folio_set_swapbacked(newfolio);
 
@@ -474,6 +476,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	 */
 	newfolio->index = folio->index;
 	newfolio->mapping = folio->mapping;
+	if (folio_test_anon(folio) && folio_test_large(folio))
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 	folio_ref_add(newfolio, nr); /* add cache reference */
 	if (folio_test_swapbacked(folio)) {
 		__folio_set_swapbacked(newfolio);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8a67d760b71a..7dcb0713eb57 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1084,8 +1084,11 @@ __always_inline bool free_pages_prepare(struct page *page,
 			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
 	}
-	if (PageMappingFlags(page))
+	if (PageMappingFlags(page)) {
+		if (PageAnon(page))
+			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		page->mapping = NULL;
+	}
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
 			bad++;
diff --git a/mm/rmap.c b/mm/rmap.c
index 1103a536e474..78529cf0fd66 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	}
 
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
+	mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 }
 
 static __always_inline void __folio_add_file_rmap(struct folio *folio,
-- 
2.39.3 (Apple Git-146)


