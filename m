Return-Path: <linux-kernel+bounces-298033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48095C0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8682843AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9F41D175A;
	Thu, 22 Aug 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USzjoBIZ"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866D1D0DF2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366439; cv=none; b=jDkpUDobwKKk0SvfuYJoaQcvyFBMM0NY+AIQ0MX86kZRXLXltleq1w8BEsS7IH7Y26YXYkGDEWVb7OsijAqjsRjFcmj+/fG/G0JUD5fcjEAJSfa1M6bAQUz+yMuk9b7VDmJePMVTU/cD/EoZ+tB9/gLdv57Rm2PBDBXVG8Uw1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366439; c=relaxed/simple;
	bh=hfx7lDeh7rbc+yzqn/Yf5Tiat7eRY0a4RbC8sRqawR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbyQ0q+Q63aSU0sgOZJis32FTtwHIEOXHT+semu0vUAhcibRz/U+qiBKO0huSQv7TVUREk5Ye1/DsvmQbZtdzPWNyj3/28+2LtBAARC/HhZeToC333ZoxYDeiOye8g2BV17UNWnNzuQJXsIvHM250/4I5IiUWGb4gjenSHDgegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USzjoBIZ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70945a007f0so1074345a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724366437; x=1724971237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve8ZCh8PCPvV2efG9h3uLLekR5A9SRZ7fqOdixfPViI=;
        b=USzjoBIZLcOEesR+wcZOaVzdNA0eKTBNIJCz1zZnXlMrGhkuzHg2niNJ39B7Mp5tb6
         ntrTKdKCBFHtEmn+SqHGkB6ywbsK6UIhCKfum4jSOoNIEHA6Rj08IKRZCCmQ6vhK6+HT
         M4OPKhckMUxzI2OQslKeVpc8gUSd6eAgJbgfkWSSwOUBM/Ei8Uk82KMJE6YO4/cHE6sS
         IIK+szlaWLDN/Ht62KLbYORex+4BnHVHjM+w7JGbPlLQSEAf50/rk3QDAdSLvw0Qhv7C
         +t+oesl//mANasASAjaN6eKut4GaUkekn0JqCdNVHJpB4U2ko0mTFnFmPYacVLGF41jm
         k1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366437; x=1724971237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve8ZCh8PCPvV2efG9h3uLLekR5A9SRZ7fqOdixfPViI=;
        b=jFU3346AesIIq4LbFBBHM1K5H3FFsx6t20M69Zjida8Tmfqpn0Ro1uzsohwjaecyGB
         s9wh1qFCibSAx8rldNZqBl9wat0AahTVELHpbxIsjvDfN/MeBJEW6PebAQAyFSb0oXLj
         bp9JJLNvxvoopH4MTGSD4flZ2b819yQErf+9HJA/1gVQBSSrFm9KdS2E52Ie/XmNx+O9
         l/6JR0JMtqcWN2j7icb/+KFAxKI/zUkSuHUh24HCLIcb8q5UU5EKM9Hchj2TI2hIrdxL
         ECq/wedCb9mx2xFlqqCwroOjt+9bcVcaAMw3oq5dFBJKHklKbWXCFeUWD3yxZJOvs7pt
         iusw==
X-Forwarded-Encrypted: i=1; AJvYcCW8rLrh5mbQIlaAs9T3oJjeXH4cbJBygAvxVZh9PidOKjcNuAMd2pTVtaU3KufXMqIZUX5KHONrb63DkXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVD/6wriaLtyQcP6Jp+8OXBy7WcXwtvrjLGt7ovSEU/mBkzbe
	eK2Cd5i3coaz4TVP8AF2uF4ljMt4i+8QdUmd3XSNxOjgrvwAVhhD
X-Google-Smtp-Source: AGHT+IHEGh03zz8rdlIrdwZ9xm21Ww4yPfyKxp1Z6t9DNAg6uNvWD8bxaHrYmFhbSUY1uYyv9lMlqQ==
X-Received: by 2002:a05:6808:4a:b0:3db:26fa:b470 with SMTP id 5614622812f47-3de2a88cc31mr307677b6e.30.1724366436986;
        Thu, 22 Aug 2024 15:40:36 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:427:337e:a4f:8e74])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acabccasm1609912a12.27.2024.08.22.15.40.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Aug 2024 15:40:36 -0700 (PDT)
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
	yuanshuai@oppo.com,
	ziy@nvidia.com,
	usamaarif642@gmail.com
Subject: [PATCH v3 1/2] mm: collect the number of anon large folios
Date: Fri, 23 Aug 2024 10:40:14 +1200
Message-Id: <20240822224015.93186-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240822224015.93186-1-21cnbao@gmail.com>
References: <20240822224015.93186-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Anon large folios come from three places:
1. new allocated large folios in page faults, they will call
   folio_add_new_anon_rmap() for rmap;
2. a large folio is split into multiple lower-order large folios;
3. a large folio is migrated to a new large folio.

In all above three counts, we increase nr_anon by 1;

Anon large folios might go either because of be split or be put
to free, in these cases, we reduce the count by 1.

Folios added to the swap cache without an anonymous mapping won't
be counted. This aligns with the AnonPages statistics in /proc/meminfo.
However, folios that have been fully unmapped but not yet freed are
counted. Unlike AnonPages, this can help identify anonymous memory
leaks, such as when an anon folio is still pinned after being unmapped.

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


