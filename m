Return-Path: <linux-kernel+bounces-399117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E19BFB33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CEE1C20F99
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E783748F;
	Thu,  7 Nov 2024 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAW783bX"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000AD299
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941981; cv=none; b=kBMBqGF2K4a2vtGmU+MBdLVUJAWSujgKqa6CZhAOqzhqjRgWGUYb5CiueCUty5OzZbKAaUDtIELeBnig+zvRecuGmulMLik//ZF3vjYOhmL8LVevrWPlpQob9VkU89McWSS/G93Z/BcQUwChNl6Pec/WQMxX50Stib+JpfU1Ej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941981; c=relaxed/simple;
	bh=ED7f7kCUuc0Z3a7vXr45QhWkCHVC/RjDIXl5WuVsNds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Azn6lRXwEO8mfVC9sxPVOxJd+I1HRUzgC1F0mO7V/+RvUMFOWqxaxq2WUnDCUOtyq8sC3FwCwU6LI2u36AyFB9RKuD6PottFANAzg+t3FACohOeOcVxuVbJBmVKOW9ikjXrhfzqu4FAOxj7ZQRDT3aVEt5shXxxYUp7hGWKU5u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAW783bX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so321523a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 17:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730941979; x=1731546779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7eKRthy0nkvvk1YUqbsHIklnZcvTop5o8zHLQjk8A7k=;
        b=gAW783bXCVe1esNFqAYZy7QIYQaCjmaz/eAw/zEEGSwMKWJRdhS+mCTPsYy8KueOaS
         b/Fdyes0f+TST75cwNQ1Vu/OAk+TOyuYFGRcRRZwuXN5S0UajksTXm7MBKBWErbD64h2
         BTRq4/snOdkiHkJlasW/cP1GsYS8h2J0Oa8tGWwaLuVAzAyVMduuSkSvN4zx/r4AVUze
         i83lz70L6h7u94QldZXsdt0oipZr/Yhm+uM29GXwsAo2+0WsZELaxyPAH7J5ZNk9c4tU
         P5+xTnOPSQ60C+vKvd8d7NB4OIQFF+BBMVBrJ4sjJoreci6v2HUNKEoU9bdwuMytpe5B
         0byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730941979; x=1731546779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eKRthy0nkvvk1YUqbsHIklnZcvTop5o8zHLQjk8A7k=;
        b=fCs2BWw37wcN1UzSZLI1VUe+Tt9d5ZB+TZyPbFGj3VxZi4Or2+ylK4Uq1csFObiAbD
         DgyEF3Gl4AdcQlBevApw7cFORCiMnMB+xVgPjMm289t7gDf8ykW9v13pBz/aJ0QquHiC
         b8uid35Gtm50XY8Fj4sOlAN11Gvg8x6CnVrApbcSchjx2HGEAk6uAjRYP5gJk4x0jifC
         K5Hs5vIxULlq4ai2/tbTe0hsFiN9MNQ05FcReIQInaRxocZCwPZ4n9HRocF01xkT8qt4
         yklRHQ3p0QXd/+H4tX5XfmpEjLX+QRH9TpRZEOwEFGGA7xTQ76EloUM3+GRsdLhV3djm
         SNVg==
X-Gm-Message-State: AOJu0YwaYFYi8mI6xVVwH5R1AB1ljd+avqs8AM7MIvbg3y6qD3BH552l
	k62wCHec/Gh7zPL/Ly/cvqs52gzxZaTtBz94kJpR2lDDD9RyeSTC
X-Google-Smtp-Source: AGHT+IH+szR71evvH85kWFDS4yO0a3/IVnquRsGdrcdkLacKhZHuX3W0ZKEEwt0YS3xvMPjWuHj/uA==
X-Received: by 2002:a17:90b:3906:b0:2e0:80e8:a31a with SMTP id 98e67ed59e1d1-2e9a7668b6emr86660a91.35.1730941979051;
        Wed, 06 Nov 2024 17:12:59 -0800 (PST)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:507e:2219:6f85:3a5f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a62bfb6sm2257550a91.43.2024.11.06.17.12.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Nov 2024 17:12:58 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Hailong Liu <hailong.liu@oppo.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andi Kleen <ak@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Kairui Song <kasong@tencent.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH v4] mm: count zeromap read and set for swapout and swapin
Date: Thu,  7 Nov 2024 14:12:46 +1300
Message-Id: <20241107011246.59137-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When the proportion of folios from the zeromap is small, missing their
accounting may not significantly impact profiling.  However, it's easy to
construct a scenario where this becomes an issue—for example, allocating
1 GB of memory, writing zeros from userspace, followed by MADV_PAGEOUT,
and then swapping it back in.  In this case, the swap-out and swap-in
counts seem to vanish into a black hole, potentially causing semantic
ambiguity.

On the other hand, Usama reported that zero-filled pages can exceed 10% in
workloads utilizing zswap, while Hailong noted that some app in Android
have more than 6% zero-filled pages.  Before commit 0ca0c24e3211 ("mm:
store zero pages to be swapped out in a bitmap"), both zswap and zRAM
implemented similar optimizations, leading to these optimized-out pages
being counted in either zswap or zRAM counters (with pswpin/pswpout also
increasing for zRAM).  With zeromap functioning prior to both zswap and
zRAM, userspace will no longer detect these swap-out and swap-in actions.

We have three ways to address this:

1. Introduce a dedicated counter specifically for the zeromap.

2. Use pswpin/pswpout accounting, treating the zero map as a standard
   backend.  This approach aligns with zRAM's current handling of
   same-page fills at the device level.  However, it would mean losing the
   optimized-out page counters previously available in zRAM and would not
   align with systems using zswap.  Additionally, as noted by Nhat Pham,
   pswpin/pswpout counters apply only to I/O done directly to the backend
   device.

3. Count zeromap pages under zswap, aligning with system behavior when
   zswap is enabled.  However, this would not be consistent with zRAM, nor
   would it align with systems lacking both zswap and zRAM.

Given the complications with options 2 and 3, this patch selects
option 1.

We can find these counters from /proc/vmstat (counters for the whole
system) and memcg's memory.stat (counters for the interested memcg).

For example:

$ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
swpin_zero 1648
swpout_zero 33536

$ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.stat
swpin_zero 3905
swpout_zero 3985

This patch does not address any specific zeromap bug, but the missing
swpout and swpin counts for zero-filled pages can be highly confusing and
may mislead user-space agents that rely on changes in these counters as
indicators.  Therefore, we add a Fixes tag to encourage the inclusion of
this counter in any kernel versions with zeromap.

Many thanks to Kanchana for the contribution of changing
count_objcg_event() to count_objcg_events() to support large folios[1],
which has now been incorporated into this patch.

[1] https://lkml.kernel.org/r/20241001053222.6944-5-kanchana.p.sridhar@intel.com

Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
Co-developed-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Hailong Liu <hailong.liu@oppo.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 -v4:
 * combine Kanchana's count_objcg_events() change to fix build errors
   on 6.12-rc
 * collect Chengming's and Johannes's reviewed/acked tags, thanks!
 
 Documentation/admin-guide/cgroup-v2.rst |  9 +++++++++
 include/linux/memcontrol.h              | 12 +++++++-----
 include/linux/vm_event_item.h           |  2 ++
 mm/memcontrol.c                         |  4 ++++
 mm/page_io.c                            | 16 ++++++++++++++++
 mm/vmstat.c                             |  2 ++
 mm/zswap.c                              |  6 +++---
 7 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 69af2173555f..6d02168d78be 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1599,6 +1599,15 @@ The following nested keys are defined.
 	  pglazyfreed (npn)
 		Amount of reclaimed lazyfree pages
 
+	  swpin_zero
+		Number of pages swapped into memory and filled with zero, where I/O
+		was optimized out because the page content was detected to be zero
+		during swapout.
+
+	  swpout_zero
+		Number of zero-filled pages swapped out with I/O skipped due to the
+		content being detected as zero.
+
 	  zswpin
 		Number of pages moved in to memory from zswap.
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 34d2da05f2f1..e1b41554a5fb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1760,8 +1760,9 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 
 struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
 
-static inline void count_objcg_event(struct obj_cgroup *objcg,
-				     enum vm_event_item idx)
+static inline void count_objcg_events(struct obj_cgroup *objcg,
+				      enum vm_event_item idx,
+				      unsigned long count)
 {
 	struct mem_cgroup *memcg;
 
@@ -1770,7 +1771,7 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
-	count_memcg_events(memcg, idx, 1);
+	count_memcg_events(memcg, idx, count);
 	rcu_read_unlock();
 }
 
@@ -1825,8 +1826,9 @@ static inline struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
 	return NULL;
 }
 
-static inline void count_objcg_event(struct obj_cgroup *objcg,
-				     enum vm_event_item idx)
+static inline void count_objcg_events(struct obj_cgroup *objcg,
+				      enum vm_event_item idx,
+				      unsigned long count)
 {
 }
 
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index aed952d04132..f70d0958095c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -134,6 +134,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
+		SWPIN_ZERO,
+		SWPOUT_ZERO,
 #ifdef CONFIG_KSM
 		KSM_SWPIN_COPY,
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 06df2af97415..53db98d2c4a1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -431,6 +431,10 @@ static const unsigned int memcg_vm_event_stat[] = {
 	PGDEACTIVATE,
 	PGLAZYFREE,
 	PGLAZYFREED,
+#ifdef CONFIG_SWAP
+	SWPIN_ZERO,
+	SWPOUT_ZERO,
+#endif
 #ifdef CONFIG_ZSWAP
 	ZSWPIN,
 	ZSWPOUT,
diff --git a/mm/page_io.c b/mm/page_io.c
index 69536a2b3c13..01749b99fb54 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -204,7 +204,9 @@ static bool is_folio_zero_filled(struct folio *folio)
 
 static void swap_zeromap_folio_set(struct folio *folio)
 {
+	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	int nr_pages = folio_nr_pages(folio);
 	swp_entry_t entry;
 	unsigned int i;
 
@@ -212,6 +214,12 @@ static void swap_zeromap_folio_set(struct folio *folio)
 		entry = page_swap_entry(folio_page(folio, i));
 		set_bit(swp_offset(entry), sis->zeromap);
 	}
+
+	count_vm_events(SWPOUT_ZERO, nr_pages);
+	if (objcg) {
+		count_objcg_events(objcg, SWPOUT_ZERO, nr_pages);
+		obj_cgroup_put(objcg);
+	}
 }
 
 static void swap_zeromap_folio_clear(struct folio *folio)
@@ -503,6 +511,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 static bool swap_read_folio_zeromap(struct folio *folio)
 {
 	int nr_pages = folio_nr_pages(folio);
+	struct obj_cgroup *objcg;
 	bool is_zeromap;
 
 	/*
@@ -517,6 +526,13 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 	if (!is_zeromap)
 		return false;
 
+	objcg = get_obj_cgroup_from_folio(folio);
+	count_vm_events(SWPIN_ZERO, nr_pages);
+	if (objcg) {
+		count_objcg_events(objcg, SWPIN_ZERO, nr_pages);
+		obj_cgroup_put(objcg);
+	}
+
 	folio_zero_range(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
 	return true;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b5a4cea423e1..ac6a5aa34eab 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1415,6 +1415,8 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_SWAP
 	"swap_ra",
 	"swap_ra_hit",
+	"swpin_zero",
+	"swpout_zero",
 #ifdef CONFIG_KSM
 	"ksm_swpin_copy",
 #endif
diff --git a/mm/zswap.c b/mm/zswap.c
index 162013952074..0030ce8fecfc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1053,7 +1053,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
-		count_objcg_event(entry->objcg, ZSWPWB);
+		count_objcg_events(entry->objcg, ZSWPWB, 1);
 
 	zswap_entry_free(entry);
 
@@ -1483,7 +1483,7 @@ bool zswap_store(struct folio *folio)
 
 	if (objcg) {
 		obj_cgroup_charge_zswap(objcg, entry->length);
-		count_objcg_event(objcg, ZSWPOUT);
+		count_objcg_events(objcg, ZSWPOUT, 1);
 	}
 
 	/*
@@ -1577,7 +1577,7 @@ bool zswap_load(struct folio *folio)
 
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
-		count_objcg_event(entry->objcg, ZSWPIN);
+		count_objcg_events(entry->objcg, ZSWPIN, 1);
 
 	if (swapcache) {
 		zswap_entry_free(entry);
-- 
2.34.1


