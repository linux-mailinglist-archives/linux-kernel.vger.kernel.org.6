Return-Path: <linux-kernel+bounces-247377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189B92CE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A591C222FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DDC18FA12;
	Wed, 10 Jul 2024 09:55:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44858288F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605324; cv=none; b=uvU2QXv5tGxYK37sz9hfqGVm5BFr7sLcEVj1HbUJfcky3ei4FsyuLx6fAVMnCiNO/SJoE7C5fDIV8RzmCyVSAFsQvwQTab1rPTOs+df0Q0sO0wDvMBJvznI9f3Fc//BD45PL5/ChOuwbmpBth9q6Dsj/R9Q05ipJgZ8ZLApdK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605324; c=relaxed/simple;
	bh=SyZ5lGyIh0HgdU2By0DQ8mW3X4tQoMZ5FH1A5u+11is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saTZZSqFxL+mcGDs+Or+/myjUChEaMokB2cB5jCUyGfVl1Q8DlTsKT7KGRBkCGHIbFS5n+UdOuI0kJECR5v1ckAp60TeTbJAlnKjdvX+8tJ9qRHvd8vJo/xrrHHQ7K5XnLa0WtjnKQ9JNcJz0NEte4ul5/OzA9M/AYM0z0ct0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B185106F;
	Wed, 10 Jul 2024 02:55:40 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B3D03F762;
	Wed, 10 Jul 2024 02:55:12 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm: shmem: Rename mTHP shmem counters
Date: Wed, 10 Jul 2024 10:55:01 +0100
Message-ID: <20240710095503.3193901-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy PMD-sized THP counters at /proc/vmstat include
thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
rather confusingly refer to shmem THP and do not include any other types
of file pages. This is inconsistent since in most other places in the
kernel, THP counters are explicitly separated for anon, shmem and file
flavours. However, we are stuck with it since it constitutes a user ABI.

Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
anonymous shmem") added equivalent mTHP stats for shmem, keeping the
same "file_" prefix in the names. But in future, we may want to add
extra stats to cover actual file pages, at which point, it would all
become very confusing.

So let's take the opportunity to rename these new counters "shmem_"
before the change makes it upstream and the ABI becomes immutable. While
we are at it, let's improve the documentation for the legacy counters to
make it clear that they count shmem pages only.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lance Yang <ioworker0@gmail.com>
---

Hi All,

Applies on top of yesterday's mm-unstable (2073cda629a4) and tested with mm
selftests; no regressions observed.

The backstory here is that I'd like to introduce some counters for regular file
folio allocations to observe how often large folio allocation succeeds, but
these shmem counters are named "file" which is going to make things confusing.
So hoping to solve that before commit 66f44583f9b6 ("mm: shmem: add mTHP
counters for anonymous shmem") goes upstream (it is currently in mm-stable).

Changes since v1 [1]
====================
  - Updated documentation for existing legacy "file_" counters to make it clear
    they only count shmem pages.

[1] https://lore.kernel.org/linux-mm/20240708112445.2690631-1-ryan.roberts@arm.com/

Thanks,
Ryan

 Documentation/admin-guide/mm/transhuge.rst | 29 ++++++++++++----------
 include/linux/huge_mm.h                    |  6 ++---
 mm/huge_memory.c                           | 12 ++++-----
 mm/shmem.c                                 |  8 +++---
 4 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 747c811ee8f1..3528daa1f239 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -412,20 +412,23 @@ thp_collapse_alloc_failed
 	the allocation.

 thp_file_alloc
-	is incremented every time a file huge page is successfully
-	allocated.
+	is incremented every time a shmem huge page is successfully
+	allocated (Note that despite being named after "file", the counter
+	measures only shmem).

 thp_file_fallback
-	is incremented if a file huge page is attempted to be allocated
-	but fails and instead falls back to using small pages.
+	is incremented if a shmem huge page is attempted to be allocated
+	but fails and instead falls back to using small pages. (Note that
+	despite being named after "file", the counter measures only shmem).

 thp_file_fallback_charge
-	is incremented if a file huge page cannot be charged and instead
+	is incremented if a shmem huge page cannot be charged and instead
 	falls back to using small pages even though the allocation was
-	successful.
+	successful. (Note that despite being named after "file", the
+	counter measures only shmem).

 thp_file_mapped
-	is incremented every time a file huge page is mapped into
+	is incremented every time a file or shmem huge page is mapped into
 	user address space.

 thp_split_page
@@ -496,16 +499,16 @@ swpout_fallback
 	Usually because failed to allocate some continuous swap space
 	for the huge page.

-file_alloc
-	is incremented every time a file huge page is successfully
+shmem_alloc
+	is incremented every time a shmem huge page is successfully
 	allocated.

-file_fallback
-	is incremented if a file huge page is attempted to be allocated
+shmem_fallback
+	is incremented if a shmem huge page is attempted to be allocated
 	but fails and instead falls back to using small pages.

-file_fallback_charge
-	is incremented if a file huge page cannot be charged and instead
+shmem_fallback_charge
+	is incremented if a shmem huge page cannot be charged and instead
 	falls back to using small pages even though the allocation was
 	successful.

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index acb6ac24a07e..cff002be83eb 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -269,9 +269,9 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
-	MTHP_STAT_FILE_ALLOC,
-	MTHP_STAT_FILE_FALLBACK,
-	MTHP_STAT_FILE_FALLBACK_CHARGE,
+	MTHP_STAT_SHMEM_ALLOC,
+	MTHP_STAT_SHMEM_FALLBACK,
+	MTHP_STAT_SHMEM_FALLBACK_CHARGE,
 	MTHP_STAT_SPLIT,
 	MTHP_STAT_SPLIT_FAILED,
 	MTHP_STAT_SPLIT_DEFERRED,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9ec64aa2be94..f9696c94e211 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -568,9 +568,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
-DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
-DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
-DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
+DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
@@ -581,9 +581,9 @@ static struct attribute *stats_attrs[] = {
 	&anon_fault_fallback_charge_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
-	&file_alloc_attr.attr,
-	&file_fallback_attr.attr,
-	&file_fallback_charge_attr.attr,
+	&shmem_alloc_attr.attr,
+	&shmem_fallback_attr.attr,
+	&shmem_fallback_charge_attr.attr,
 	&split_attr.attr,
 	&split_failed_attr.attr,
 	&split_deferred_attr.attr,
diff --git a/mm/shmem.c b/mm/shmem.c
index 921d59c3d669..f24dfbd387ba 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1777,7 +1777,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
+			count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
 #endif
 			order = next_order(&suitable_orders, order);
 		}
@@ -1804,8 +1804,8 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 				count_vm_event(THP_FILE_FALLBACK_CHARGE);
 			}
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK);
-			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK_CHARGE);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK_CHARGE);
 #endif
 		}
 		goto unlock;
@@ -2181,7 +2181,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 			if (folio_test_pmd_mappable(folio))
 				count_vm_event(THP_FILE_ALLOC);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_ALLOC);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_ALLOC);
 #endif
 			goto alloced;
 		}
--
2.43.0


