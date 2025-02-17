Return-Path: <linux-kernel+bounces-517777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98D0A3858C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2B0188B7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6AF21CC68;
	Mon, 17 Feb 2025 14:08:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A44A21CA07
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801302; cv=none; b=MlP/wtPUTCIwUIrpmiBuJL9LBvSybPrfR7qnqCCTEGHE9eLwKEr6Dfew0uur1UmSDtw1kQajesY/9kenAWweLdk9fT1hCk3ujw3fFd5y/CMZJUPe10rwcrmRKxOZsCqs0X17agq/7Kp5fbWVI98vIqN9IBDmNhjXiKRnNlVy0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801302; c=relaxed/simple;
	bh=2qXjVOl4HDDiz4VDJMUzzabTXR6wHMlSiitQXVqGbTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdGbM10/LMUnaHR8TP8ciZfKW6x2ce2PjRhRF8nLkE1AXAVP+xtlyaw7jDshMFmUvP6NbKTfG35kSj2B4nZlkF9/Kmp6B6l88fUi9gmZaDwPtod3dV3GRenovrglUayUWQB26y4pbWbKGGmnCiqZ1+o0hvsxJ+vkeLyh5WJr40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F03A1E5E;
	Mon, 17 Feb 2025 06:08:39 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E6C53F6A8;
	Mon, 17 Feb 2025 06:08:17 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/14] Perf improvements for hugetlb and vmalloc on arm64
Date: Mon, 17 Feb 2025 14:07:52 +0000
Message-ID: <20250217140809.1702789-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series contains some perf improvements for hugetlb and vmalloc on arm64,
and is split out from v1 of a wider series at [1]. Although some of these
patches are core-mm, advice from Andrew was to go via the arm64 tree. Hopefully
I can get some ACKs from mm folks.

The 2 key performance improvements are 1) enabling the use of contpte-mapped
blocks in the vmalloc space when appropriate (which reduces TLB pressure). There
were already hooks for this (used by powerpc) but they required some tidying and
extending for arm64. And 2) batching up barriers when modifying the vmalloc
address space for upto 30% reduction in time taken in vmalloc().

vmalloc() performance was measured using the test_vmalloc.ko module. Tested on
Apple M2 and Ampere Altra. Each test had loop count set to 500000 and the whole
test was repeated 10 times. (perf results are against v1).

legend:
  - p: nr_pages (pages to allocate)
  - h: use_huge (vmalloc() vs vmalloc_huge())
  - (I): statistically significant improvement (95% CI does not overlap)
  - (R): statistically significant regression (95% CI does not overlap)
  - mearements are times; smaller is better

+--------------------------------------------------+-------------+-------------+
| Benchmark                                        |             |             |
|   Result Class                                   |    Apple M2 | Ampere Alta |
+==================================================+=============+=============+
| micromm/vmalloc                                  |             |             |
|   fix_align_alloc_test: p:1, h:0 (usec)          | (I) -12.93% |  (I) -7.89% |
|   fix_size_alloc_test: p:1, h:0 (usec)           |   (R) 4.00% |       1.40% |
|   fix_size_alloc_test: p:1, h:1 (usec)           |   (R) 5.28% |       1.46% |
|   fix_size_alloc_test: p:2, h:0 (usec)           |  (I) -3.04% |      -1.11% |
|   fix_size_alloc_test: p:2, h:1 (usec)           |      -3.24% |      -2.86% |
|   fix_size_alloc_test: p:4, h:0 (usec)           | (I) -11.77% |  (I) -4.48% |
|   fix_size_alloc_test: p:4, h:1 (usec)           |  (I) -9.19% |  (I) -4.45% |
|   fix_size_alloc_test: p:8, h:0 (usec)           | (I) -19.79% | (I) -11.63% |
|   fix_size_alloc_test: p:8, h:1 (usec)           | (I) -19.40% | (I) -11.11% |
|   fix_size_alloc_test: p:16, h:0 (usec)          | (I) -24.89% | (I) -15.26% |
|   fix_size_alloc_test: p:16, h:1 (usec)          | (I) -11.61% |   (R) 6.00% |
|   fix_size_alloc_test: p:32, h:0 (usec)          | (I) -26.54% | (I) -18.80% |
|   fix_size_alloc_test: p:32, h:1 (usec)          | (I) -15.42% |   (R) 5.82% |
|   fix_size_alloc_test: p:64, h:0 (usec)          | (I) -30.25% | (I) -20.80% |
|   fix_size_alloc_test: p:64, h:1 (usec)          | (I) -16.98% |   (R) 6.54% |
|   fix_size_alloc_test: p:128, h:0 (usec)         | (I) -32.56% | (I) -21.79% |
|   fix_size_alloc_test: p:128, h:1 (usec)         | (I) -18.39% |   (R) 5.91% |
|   fix_size_alloc_test: p:256, h:0 (usec)         | (I) -33.33% | (I) -22.22% |
|   fix_size_alloc_test: p:256, h:1 (usec)         | (I) -18.82% |   (R) 5.79% |
|   fix_size_alloc_test: p:512, h:0 (usec)         | (I) -33.27% | (I) -22.23% |
|   fix_size_alloc_test: p:512, h:1 (usec)         |       0.86% |      -0.71% |
|   full_fit_alloc_test: p:1, h:0 (usec)           |       2.49% |      -0.62% |
|   kvfree_rcu_1_arg_vmalloc_test: p:1, h:0 (usec) |       1.79% |      -1.25% |
|   kvfree_rcu_2_arg_vmalloc_test: p:1, h:0 (usec) |      -0.32% |       0.61% |
|   long_busy_list_alloc_test: p:1, h:0 (usec)     | (I) -31.06% | (I) -19.62% |
|   pcpu_alloc_test: p:1, h:0 (usec)               |       0.06% |       0.47% |
|   random_size_align_alloc_test: p:1, h:0 (usec)  | (I) -14.94% |  (I) -8.68% |
|   random_size_alloc_test: p:1, h:0 (usec)        | (I) -30.22% | (I) -19.59% |
|   vm_map_ram_test: p:1, h:0 (usec)               |       2.65% |   (R) 7.22% |
+--------------------------------------------------+-------------+-------------+

So there are some nice improvements but also some regressions to explain:

First fix_size_alloc_test with h:1 and p:16,32,64,128,256 regress by ~6% on
Altra. The regression is actually introduced by enabling contpte-mapped 64K
blocks in these tests, and that regression is reduced (from about 8% if memory
serves) by doing the barrier batching. I don't have a definite conclusion on the
root cause, but I've ruled out the differences in the mapping paths in vmalloc.
I strongly believe this is likely due to the difference in the allocation path;
64K blocks are not cached per-cpu so we have to go all the way to the buddy. I'm
not sure why this doesn't show up on M2 though. Regardless, I'm going to assert
that it's better to choose 16x reduction in TLB pressure vs 6% on the vmalloc
allocation call duration.

Next we have ~4% regression on M2 when vmalloc'ing a single page. (h is
irrelevant because a single page is too small for contpte). I assume this is
because there is some minor overhead in the barrier deferral mechanism and we
are not getting to amortize it over multiple pages here. But I would assume
vmalloc'ing 1 page is uncommon because it doesn't buy you anything over
kmalloc?

Changes since v1 [1]
====================
- Split out the fixes into their own series
- Added Rbs from Anshuman - Thanks!
- Added patch to clean up the methods by which huge_pte size is determined
- Added "#ifndef __PAGETABLE_PMD_FOLDED" around PUD_SIZE in
  flush_hugetlb_tlb_range()
- Renamed ___set_ptes() -> set_ptes_anysz()
- Renamed ___ptep_get_and_clear() -> ptep_get_and_clear_anysz()
- Fixed typos in commit logs
- Refactored pXd_valid_not_user() for better reuse
- Removed TIF_KMAP_UPDATE_PENDING after concluding that single flag is sufficent
- Concluded the extra isb() in __switch_to() is not required
- Only call arch_update_kernel_mappings_[begin|end]() for kernel mappings

Thanks to Anshuman for the review!

Applies on top of my fixes series at [2], which applies on top of v6.14-rc3. All
mm selftests run and pass.

[1] https://lore.kernel.org/all/20250205151003.88959-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/all/20250217140419.1702389-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (14):
  arm64: hugetlb: Cleanup huge_pte size discovery mechanisms
  arm64: hugetlb: Refine tlb maintenance scope
  mm/page_table_check: Batch-check pmds/puds just like ptes
  arm64/mm: Refactor __set_ptes() and __ptep_get_and_clear()
  arm64: hugetlb: Use set_ptes_anysz() and ptep_get_and_clear_anysz()
  arm64/mm: Hoist barriers out of set_ptes_anysz() loop
  arm64/mm: Avoid barriers for invalid or userspace mappings
  mm/vmalloc: Warn on improper use of vunmap_range()
  mm/vmalloc: Gracefully unmap huge ptes
  arm64/mm: Support huge pte-mapped pages in vmap
  mm/vmalloc: Batch arch_sync_kernel_mappings() more efficiently
  mm: Generalize arch_sync_kernel_mappings()
  mm: Only call arch_update_kernel_mappings_[begin|end]() for kernel
    mappings
  arm64/mm: Batch barriers when updating kernel mappings

 arch/arm64/include/asm/hugetlb.h     |  29 ++--
 arch/arm64/include/asm/pgtable.h     | 207 +++++++++++++++++++--------
 arch/arm64/include/asm/thread_info.h |   1 +
 arch/arm64/include/asm/vmalloc.h     |  46 ++++++
 arch/arm64/kernel/process.c          |   9 +-
 arch/arm64/mm/hugetlbpage.c          |  72 ++++------
 include/linux/page_table_check.h     |  30 ++--
 include/linux/pgtable.h              |  24 +---
 include/linux/pgtable_modmask.h      |  32 +++++
 include/linux/vmalloc.h              |  55 +++++++
 mm/memory.c                          |   7 +-
 mm/page_table_check.c                |  34 +++--
 mm/vmalloc.c                         |  93 +++++++-----
 13 files changed, 434 insertions(+), 205 deletions(-)
 create mode 100644 include/linux/pgtable_modmask.h

--
2.43.0


