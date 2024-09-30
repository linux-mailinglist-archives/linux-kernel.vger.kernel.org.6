Return-Path: <linux-kernel+bounces-343357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17789989A05
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FDC1C20F53
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B0B13BADF;
	Mon, 30 Sep 2024 05:28:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D92383A5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727674117; cv=none; b=CH3t4yrlqcn7fzz/tmp8eBKZpKMAXKiPAT7D3yoLESpW1L+y+mDdruv3+YgZQvXhbv3LIbguKZQIJ4eG9T6Hlc9s7xb3SZDeBGd1gWIYWrrMen9jUPTE6MBJNaUTtF85YadKNZ0A1neepBcjcpbuElfJNuL2XOuW+IrdlMbA0Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727674117; c=relaxed/simple;
	bh=P5nSFtPIi2oEnDfBXjmV8H3nIlGLiXett50b2eHLj/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NU2qZ1+Y55Y9xCg/1plvq2Dt5vDpZXE6PVmyVSZQO8h1+DYeWN4eojxH28zo6vtgZOWGSRxJxle7e+tk1VLhxOCBfSpNP19nzEJr3h02F2sXQIKpZ4tGoVlPsZsVH12jWYdJOoSxxLk5IZWo46irQRXsAilTUjmtnqogv18sjJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4997FEC;
	Sun, 29 Sep 2024 22:28:56 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CD273F587;
	Sun, 29 Sep 2024 22:28:17 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	jack@suse.cz,
	mark.rutland@arm.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	jglisse@google.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v6 0/2] Do not shatter hugezeropage on wp-fault
Date: Mon, 30 Sep 2024 10:58:10 +0530
Message-Id: <20240930052812.2627395-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was observed at [1] and [2] that the current kernel behaviour of
shattering a hugezeropage is inconsistent and suboptimal. For a VMA with
a THP allowable order, when we write-fault on it, the kernel installs a
PMD-mapped THP. On the other hand, if we first get a read fault, we get
a PMD pointing to the hugezeropage; subsequent write will trigger a
write-protection fault, shattering the hugezeropage into one writable
page, and all the other PTEs write-protected. The conclusion being, as
compared to the case of a single write-fault, applications have to suffer
512 extra page faults if they were to use the VMA as such, plus we get
the overhead of khugepaged trying to replace that area with a THP anyway.

Instead, replace the hugezeropage with a THP on wp-fault.

[1]: https://lore.kernel.org/all/3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com/
[2]: https://lore.kernel.org/all/1cfae0c0-96a2-4308-9c62-f7a640520242@arm.com/

The patchset has been rebased on the mm-unstable branch.

v5->v6:
 - More goto ommissions, remove build warning for !CONFIG_NUMA

v4->v5:
 - Directly return VM_FAULT_FALLBACK in case of !folio

v3->v4:
 - Renames: pmd_thp_fault_alloc -> vma_alloc_anon_folio_pmd,
   map_pmd_thp -> map_anon_folio_pmd
 - Instead of passing around, compute haddr at various places, similar
   with gfp flags
 - Pass haddr to update_mmu_cache_pmd() instead of unaligned address
 - Do not pass vmf to map_anon_folio_pmd
 - Do declarations in reverse xmas tree order
 - Drop a new line which was introduced accidentally
 - Call __pmd_thp_fault_success_stats from map_anon_folio_pmd
 - Correctly return NULL from vma_alloc_anon_folio_pmd
 - Initialize pgtable to NULL in __do_huge_pmd_anonymous_page, to
   prevent freeing pgtable when not even allocated
 - Drop if conditions from map_anon_folio_pmd, let the caller handle that

v2->v3:
 - Drop foliop and order parameters, prefix the thp functions with pmd_
 - First allocate THP, then pgtable, not vice-versa
 - Move pgtable_trans_huge_deposit() from map_pmd_thp() to caller
 - Drop exposing functions in include/linux/huge_mm.h
 - Open code do_huge_zero_wp_pmd_locked()
 - Release folio in case of pmd change after taking the lock, or
   check_stable_address_space() returning VM_FAULT_SIGBUS
 - Drop uffd-wp preservation. Looking at page_table_check_pmd_flags(), 
   preserving uffd-wp on a writable entry is invalid. Looking at
   mfill_atomic(), uffd_copy() is a null operation when pmd is marked
   uffd-wp.

v1->v2:
 - Wrap do_huge_zero_wp_pmd_locked() around lock and unlock
 - Call thp_fault_alloc() before do_huge_zero_wp_pmd_locked() to avoid
 - calling sleeping function from spinlock context

Dev Jain (2):
  mm: Abstract THP allocation
  mm: Allocate THP on hugezeropage wp-fault

 mm/huge_memory.c | 139 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 97 insertions(+), 42 deletions(-)

-- 
2.30.2


