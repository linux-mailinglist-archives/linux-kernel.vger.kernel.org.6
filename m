Return-Path: <linux-kernel+bounces-354526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 049AC993EA4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691401F25634
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36B713D246;
	Tue,  8 Oct 2024 06:18:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30B52594
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368294; cv=none; b=F/ktR3vGstHkbBzgwPcmjjR5/9ZF8+J9jPG99sdPh258oJq2cuF3rR3VkWXMV/qkDSLYAWvU4KuC9ucNm5mrQj4q0yYx9ULlL7jPIV4rtCFGTo+UzKskYEkWYuVrHT/OYAPOHeZRNSirgrveBxk4G3Cpe/qkntpjr/SwyX7azIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368294; c=relaxed/simple;
	bh=lLJEZzSPa5k+vcMLGYeyZSCwR+KNhiUwfri4OTy6Jdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EHS0K7x1HVKBVq5TbPyPvWD93Y3K+fDzmgkK0U5itF+EztwxqQAPSi3sWWxJWOducLHhbqptCG3e4orVc68vEmT8mveHxD7cDuoSa2B+2fHH0BegkAGXZd6xNCZrQdoLdUQ5RzKFtF1uvtjU6HoCILpvnbhY83O0tdF2s8dXVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 175A7DA7;
	Mon,  7 Oct 2024 23:18:36 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 77E8F3F73F;
	Mon,  7 Oct 2024 23:17:57 -0700 (PDT)
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
Subject: [PATCH v7 0/2] Do not shatter hugezeropage on wp-fault
Date: Tue,  8 Oct 2024 11:47:44 +0530
Message-Id: <20241008061746.285961-1-dev.jain@arm.com>
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

v6->v7: Align function parameters in the second line by two tabs

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


