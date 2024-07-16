Return-Path: <linux-kernel+bounces-253855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB29327E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157AC1F23639
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841A619CD18;
	Tue, 16 Jul 2024 13:59:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715D19B59E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138363; cv=none; b=NoX/MTxT8ebBginrUKmNZjO99+YcjIwc/s7OjkKCQ5SCwjVxQHo2Rmn91OcToUrhz0ZF5tP/GvcSkffZUUCiYtrQvzZRv9A5IaUYSKo9vDpGUiybxZ78XP/RQcRXyan8wqG3hNsVsupbj2jq154yoZsRmHv0tQuPizXrh1iDj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138363; c=relaxed/simple;
	bh=yyX7PWPHicisMhpnA1yestKoyro22csgS91ghFcJ/mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrhV9QqTa5cV/8Xenhwt3zNhmdpG/gsgaRwZUjwSwjF50mPNdz7GatCEkZroW9Imq+O+wq3nMnqHjr3NugbAXwEMAQInP4pWp7wWmlrDFgV47+fhuz8KYRCNmnP71yOcPCwUzE/X3WfzjP1ksIxYfUUIpxlfpQZKGsMl1beokt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F31B106F;
	Tue, 16 Jul 2024 06:59:46 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 660803F762;
	Tue, 16 Jul 2024 06:59:19 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Gavin Shan <gshan@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/3] mm: mTHP stats for pagecache folio allocations
Date: Tue, 16 Jul 2024 14:59:06 +0100
Message-ID: <20240716135907.4047689-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716135907.4047689-1-ryan.roberts@arm.com>
References: <20240716135907.4047689-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose 3 new mTHP stats for file (pagecache) folio allocations:

  /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_alloc
  /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback
  /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback_charge

This will provide some insight on the sizes of large folios being
allocated for file-backed memory, and how often allocation is failing.

All non-order-0 (and most order-0) folio allocations are currently done
through filemap_alloc_folio(), and folios are charged in a subsequent
call to filemap_add_folio(). So count file_fallback when allocation
fails in filemap_alloc_folio() and count file_alloc or
file_fallback_charge in filemap_add_folio(), based on whether charging
succeeded or not. There are some users of filemap_add_folio() that
allocate their own order-0 folio by other means, so we would not count
an allocation failure in this case, but we also don't care about order-0
allocations. This approach feels like it should be good enough and
doesn't require any (impractically large) refactoring.

The existing mTHP stats interface is reused to provide consistency to
users. And because we are reusing the same interface, we can reuse the
same infrastructure on the kernel side.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 13 +++++++++++++
 include/linux/huge_mm.h                    |  3 +++
 include/linux/pagemap.h                    | 16 ++++++++++++++--
 mm/filemap.c                               |  6 ++++--
 mm/huge_memory.c                           |  7 +++++++
 5 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 058485daf186..d4857e457add 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -512,6 +512,19 @@ shmem_fallback_charge
 	falls back to using small pages even though the allocation was
 	successful.
 
+file_alloc
+	is incremented every time a file huge page is successfully
+	allocated.
+
+file_fallback
+	is incremented if a file huge page is attempted to be allocated
+	but fails and instead falls back to using small pages.
+
+file_fallback_charge
+	is incremented if a file huge page cannot be charged and instead
+	falls back to using small pages even though the allocation was
+	successful.
+
 split
 	is incremented every time a huge page is successfully split into
 	smaller orders. This can happen for a variety of reasons but a
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b8c63c3e967f..4f9109fcdded 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -123,6 +123,9 @@ enum mthp_stat_item {
 	MTHP_STAT_SHMEM_ALLOC,
 	MTHP_STAT_SHMEM_FALLBACK,
 	MTHP_STAT_SHMEM_FALLBACK_CHARGE,
+	MTHP_STAT_FILE_ALLOC,
+	MTHP_STAT_FILE_FALLBACK,
+	MTHP_STAT_FILE_FALLBACK_CHARGE,
 	MTHP_STAT_SPLIT,
 	MTHP_STAT_SPLIT_FAILED,
 	MTHP_STAT_SPLIT_DEFERRED,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 6e2f72d03176..95a147b5d117 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -562,14 +562,26 @@ static inline void *detach_page_private(struct page *page)
 }
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
+struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
 #else
-static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+static inline struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 {
 	return folio_alloc_noprof(gfp, order);
 }
 #endif
 
+static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+{
+	struct folio *folio;
+
+	folio = __filemap_alloc_folio_noprof(gfp, order);
+
+	if (!folio)
+		count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
+
+	return folio;
+}
+
 #define filemap_alloc_folio(...)				\
 	alloc_hooks(filemap_alloc_folio_noprof(__VA_ARGS__))
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 53d5d0410b51..131d514fca29 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -963,6 +963,8 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 	int ret;
 
 	ret = mem_cgroup_charge(folio, NULL, gfp);
+	count_mthp_stat(folio_order(folio),
+		ret ? MTHP_STAT_FILE_FALLBACK_CHARGE : MTHP_STAT_FILE_ALLOC);
 	if (ret)
 		return ret;
 
@@ -990,7 +992,7 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 {
 	int n;
 	struct folio *folio;
@@ -1007,7 +1009,7 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 	}
 	return folio_alloc_noprof(gfp, order);
 }
-EXPORT_SYMBOL(filemap_alloc_folio_noprof);
+EXPORT_SYMBOL(__filemap_alloc_folio_noprof);
 #endif
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 578ac212c172..26d558e3e80f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -608,7 +608,14 @@ static struct attribute_group anon_stats_attr_grp = {
 	.attrs = anon_stats_attrs,
 };
 
+DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
+DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
+
 static struct attribute *file_stats_attrs[] = {
+	&file_alloc_attr.attr,
+	&file_fallback_attr.attr,
+	&file_fallback_charge_attr.attr,
 #ifdef CONFIG_SHMEM
 	&shmem_alloc_attr.attr,
 	&shmem_fallback_attr.attr,
-- 
2.43.0


