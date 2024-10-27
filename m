Return-Path: <linux-kernel+bounces-383418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C22B9B1B78
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BCA1F21B6C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 00:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349EBA32;
	Sun, 27 Oct 2024 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPzfZQxC"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C587370
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729988099; cv=none; b=TBa4+VZgj4n/MjQtv4dMlIzqGzY/4g5bY7wAAPKh7M/8A73UlTFXM1/lBJA//0HRo/3lYp2BqYU5lRWHlQ7QyU2ZNt2tVwS6BoIC79myEmq3xHacMe2mWP+qCJCWvgC5Em9FLeu4pDzLnhnrJAH7c36d9bjskTTxVXGS/74fky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729988099; c=relaxed/simple;
	bh=Qebe6qIEejZGpfb0cLvX/1TEreZk3TCSfh/eas2RoUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dEz9P/2vz2AdIe25KzkUvOGmQNhHjvlt+l6gOmCrNrxXg2i8wlVD4vCD7N7anbi2vnLjNKQtO7YKIM0NaPhvb5CKDYC4gBj/KeaUYlHUKoQrBV6IGPUERHNoFLJIvAIsix6tXiOaUhn3+6ZjEzGQEnVmX7M8yYCciwXdMDK7QwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPzfZQxC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso2201082a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729988096; x=1730592896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5lRAXHFRLFd0vpK1cnRAmUO0Dqv8gr3TyFM9dVBaf5c=;
        b=JPzfZQxCrJE0+voX7nxoak3tIsqhBwfncEkflmKVps3pDjdLUlGj3UmIaVv9P4g+7Z
         lCaP4abEJ6eUKUAFATvosSmH8ZPGu6IMYQ4wk5oMjCtrS7O3PhByxbTOeNxk98CUfG1F
         IFwIAjESmKQRIGkoGofj5LVQ90hb7Tv0j5zUrF1PqunYgveDiWdFOREnY2wKKmzotJnj
         gZHX5hRTF0YgBaSJ+58CJeyWnY4pfYE8kOOaygS7Gge4B7oZA4ccRHIrM1aDQcse7TxV
         jTZBLYph1EffPQZKA1W+ivtRbnOn6gX6W2sLAY8u/SilViTDljo7SOMZLUhRML8yIgVr
         gc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729988096; x=1730592896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lRAXHFRLFd0vpK1cnRAmUO0Dqv8gr3TyFM9dVBaf5c=;
        b=Ipd+JQPIELLfJM/GduNlhp9/d6/Jo+WMvhLBCZBtdmYbyYnT61NnvOkAGtopnZYRg/
         8K2BbZLq4C7U3SYibdhXCrie+DAR9iz5Z4qwySdGGesuI1CZqnJHeawuXTTJNmt2Z2L8
         9zyfwv9dACkrwbg+jKDtU53lYWAthcoV8Diq+n2W+gRPP2DPVQYnKWMElVpcWs1z81Ej
         /WorLbuBYbKX08Xi6CWst53U7b6HihvZMdqy5+xiHC1MHG5Pmx7zB+ApeyQzoRtvnCcY
         BPuAgFb4qO5Gb0VgcV1FK90jgo1xaiQRKN49f5wGm36rlJ5Wpql/ASWA4qt6+kateVjk
         cyIw==
X-Gm-Message-State: AOJu0Yxjo02X0PcWrmkGpRZe1aFNvnC4wJXuWPDdWLxpbRp0enxKGf68
	pKo5TfsXzVySYUvfb+BGoUb3qfv2jbv7pF/JRk9bymsnSN2JOVLe
X-Google-Smtp-Source: AGHT+IFGZXIVzbT5sX9oh59YUYepkGPnrURlx/98KjLh4QkGzKlRlP/uf/8IQZEaXEIL+6pxa0xxaw==
X-Received: by 2002:a05:6a21:4d8b:b0:1cf:3a52:6ad6 with SMTP id adf61e73a8af0-1d9a8401be8mr5589116637.24.1729988096115;
        Sat, 26 Oct 2024 17:14:56 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:dd3b:f946:8c2b:40fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931abesm3274425b3a.73.2024.10.26.17.14.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Oct 2024 17:14:55 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Usama Arif <usamaarif642@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Kairui Song <kasong@tencent.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH RFC] mm: mitigate large folios usage and swap thrashing for nearly full memcg
Date: Sun, 27 Oct 2024 13:14:44 +1300
Message-Id: <20241027001444.3233-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

In a memcg where mTHP is always utilized, even at full capacity, it
might not be the best option. Consider a system that uses only small
folios: after each reclamation, a process has at least SWAP_CLUSTER_MAX
of buffer space before it can initiate the next reclamation. However,
large folios can quickly fill this space, rapidly bringing the memcg
back to full capacity, even though some portions of the large folios
may not be immediately needed and used by the process.

Usama and Kanchana identified a regression when building the kernel in
a memcg with memory.max set to a small value while enabling large
folio swap-in support on zswap[1].

The issue arises from an edge case where the memory cgroup remains
nearly full most of the time. Consequently, bringing in mTHP can
quickly cause a memcg overflow, triggering a swap-out. The subsequent
swap-in then recreates the overflow, resulting in a repetitive cycle.

We need a mechanism to stop the cup from overflowing continuously.
One potential solution is to slow the filling process when we identify
that the cup is nearly full.

Usama reported an improvement when we mitigate mTHP swap-in as the
memcg approaches full capacity[2]:

int mem_cgroup_swapin_charge_folio(...)
{
	...
	if (folio_test_large(folio) &&
	    mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio)))
		ret = -ENOMEM;
	else
		ret = charge_memcg(folio, memcg, gfp);
	...
}

AMD 16K+32K THP=always
metric         mm-unstable      mm-unstable + large folio zswapin series    mm-unstable + large folio zswapin + no swap thrashing fix
real           1m23.038s        1m23.050s                                   1m22.704s
user           53m57.210s       53m53.437s                                  53m52.577s
sys            7m24.592s        7m48.843s                                   7m22.519s
zswpin         612070           999244                                      815934
zswpout        2226403          2347979                                     2054980
pgfault        20667366         20481728                                    20478690
pgmajfault     385887           269117                                      309702

AMD 16K+32K+64K THP=always
metric         mm-unstable      mm-unstable + large folio zswapin series   mm-unstable + large folio zswapin + no swap thrashing fix
real           1m22.975s        1m23.266s                                  1m22.549s
user           53m51.302s       53m51.069s                                 53m46.471s
sys            7m40.168s        7m57.104s                                  7m25.012s
zswpin         676492           1258573                                    1225703
zswpout        2449839          2714767                                    2899178
pgfault        17540746         17296555                                   17234663
pgmajfault     429629           307495                                     287859

I wonder if we can extend the mitigation to do_anonymous_page() as
well. Without hardware like AMD and ARM with hardware TLB coalescing
or CONT-PTE, I conducted a quick test on my Intel i9 workstation with
10 cores and 2 threads. I enabled one 12 GiB zRAM while running kernel
builds in a memcg with memory.max set to 1 GiB.

$ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
$ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-32kB/enabled
$ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled
$ echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled

$ time systemd-run --scope -p MemoryMax=1G make ARCH=arm64 \
CROSS_COMPILE=aarch64-linux-gnu- Image -10 1>/dev/null 2>/dev/null

            disable-mTHP-swapin  mm-unstable  with-this-patch
Real:            6m54.595s      7m4.832s       6m45.811s
User:            66m42.795s     66m59.984s     67m21.150s
Sys:             12m7.092s      15m18.153s     12m52.644s
pswpin:          4262327        11723248       5918690
pswpout:         14883774       19574347       14026942
64k-swpout:      624447         889384         480039
32k-swpout:      115473         242288         73874
16k-swpout:      158203         294672         109142
64k-swpin:       0              495869         159061
32k-swpin:       0              219977         56158
16k-swpin:       0              223501         81445

I need Usama's assistance to identify a suitable patch, as I lack
access to hardware such as AMD machines and ARM servers with TLB
optimization.

[1] https://lore.kernel.org/all/b1c17b5e-acd9-4bef-820e-699768f1426d@gmail.com/
[2] https://lore.kernel.org/all/7a14c332-3001-4b9a-ada3-f4d6799be555@gmail.com/

Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/memcontrol.h |  9 ++++++++
 mm/memcontrol.c            | 45 ++++++++++++++++++++++++++++++++++++++
 mm/memory.c                | 17 ++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 524006313b0d..8bcc8f4af39f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -697,6 +697,9 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 		long nr_pages);
 
+int mem_cgroup_precharge_large_folio(struct mm_struct *mm,
+				swp_entry_t *entry);
+
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 
@@ -1201,6 +1204,12 @@ static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg,
 	return 0;
 }
 
+static inline int mem_cgroup_precharge_large_folio(struct mm_struct *mm,
+		swp_entry_t *entry)
+{
+	return 0;
+}
+
 static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 17af08367c68..f3d92b93ea6d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4530,6 +4530,51 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 	return 0;
 }
 
+static inline bool mem_cgroup_has_margin(struct mem_cgroup *memcg)
+{
+	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
+		if (mem_cgroup_margin(memcg) < HPAGE_PMD_NR)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * mem_cgroup_swapin_precharge_large_folio: Precharge large folios.
+ *
+ * @mm: mm context of the victim
+ * @entry: swap entry for which the folio will be allocated
+ *
+ * If we are arriving the edge of an almost full memcg, return error so that
+ * swap-in and anon faults can quickly fall back to small folios to avoid swap
+ * thrashing.
+ *
+ * Returns 0 on success, an error code on failure.
+ */
+int mem_cgroup_precharge_large_folio(struct mm_struct *mm, swp_entry_t *entry)
+{
+	struct mem_cgroup *memcg = NULL;
+	unsigned short id;
+	bool has_margin;
+
+	if (mem_cgroup_disabled())
+		return 0;
+
+	rcu_read_lock();
+	if (entry) {
+		id = lookup_swap_cgroup_id(*entry);
+		memcg = mem_cgroup_from_id(id);
+	}
+	if (!memcg || !css_tryget_online(&memcg->css))
+		memcg = get_mem_cgroup_from_mm(mm);
+	has_margin = mem_cgroup_has_margin(memcg);
+	rcu_read_unlock();
+
+	css_put(&memcg->css);
+	return has_margin ? 0 : -ENOMEM;
+}
+
 /**
  * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
  * @folio: folio to charge.
diff --git a/mm/memory.c b/mm/memory.c
index 0f614523b9f4..96368ba0e8a6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4168,6 +4168,16 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 
 	pte_unmap_unlock(pte, ptl);
 
+	if (!orders)
+		goto fallback;
+
+	/*
+	 * Avoid swapping in large folios when memcg is nearly full, as it
+	 * may quickly trigger additional swap-out and swap-in cycles.
+	 */
+	if (mem_cgroup_precharge_large_folio(vma->vm_mm, &entry))
+		goto fallback;
+
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
@@ -4707,6 +4717,13 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	if (!orders)
 		goto fallback;
 
+	/*
+	 * When memcg is nearly full, large folios can rapidly fill
+	 * the margin and trigger new reclamation
+	 */
+	if (mem_cgroup_precharge_large_folio(vma->vm_mm, NULL))
+		goto fallback;
+
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
-- 
2.34.1


