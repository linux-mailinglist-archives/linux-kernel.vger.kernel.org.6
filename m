Return-Path: <linux-kernel+bounces-447761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F38D9F36C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CACD1883406
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311A1207E0F;
	Mon, 16 Dec 2024 16:51:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3517207DF1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367896; cv=none; b=tdIOZQ6I20+bIeFUwLv2TdUKqFAdQxbKiHvVonwnKNbRO+2JLaIO/tDg8TEd3LPsQbkZg+k2lOe+rgbRIL1DW3F9u1ogiLbQ3s0D17LVW6pnXylgPJ518d2xRyMdPbUNRHpgpHlUoWkMzgXNH5/dzKfHkpI5I0bLSsQTVCgdQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367896; c=relaxed/simple;
	bh=g6ZQq7eDITlJn1e4+rpx8Q6bih9FAPQ2Cx+namBTPOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VS8KsHAQ3cCI0iaCO/tmLp38u83Yk1hXXOgnttYp4KeOHOBJXU25OjitnHpva9spWp6lS4G/SNeq3xNlGhiURey8NFmsEgVmfoE+24L4sq6BkLfemfkfBXEg/ljwm2R0Q2dP/7qvlTwpz2qxAdLMNS5ClwKMrn0V90PaC3wfG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BD9C106F;
	Mon, 16 Dec 2024 08:52:02 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 087AD3F528;
	Mon, 16 Dec 2024 08:51:22 -0800 (PST)
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
	srivatsa@csail.mit.edu,
	haowenchao22@gmail.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	jglisse@google.com,
	surenb@google.com,
	vishal.moola@gmail.com,
	zokeefe@google.com,
	zhengqi.arch@bytedance.com,
	jhubbard@nvidia.com,
	21cnbao@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [RFC PATCH 00/12] khugepaged: Asynchronous mTHP collapse
Date: Mon, 16 Dec 2024 22:20:53 +0530
Message-Id: <20241216165105.56185-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset extends khugepaged from collapsing only PMD-sized THPs to
collapsing anonymous mTHPs.

mTHPs were introduced in the kernel to improve memory management by allocating
chunks of larger memory, so as to reduce number of page faults, TLB misses (due
to TLB coalescing), reduce length of LRU lists, etc. However, the mTHP property
is often lost due to CoW, swap-in/out, and when the kernel just cannot find
enough physically contiguous memory to allocate on fault. Henceforth, there is a
need to regain mTHPs in the system asynchronously. This work is an attempt in
this direction, starting with anonymous folios.

In the fault handler, we select the THP order in a greedy manner; the same has
been used here, along with the same sysfs interface to control the order of
collapse. In contrast to PMD-collapse, we (hopefully) get rid of the mmap_write_lock().

---------------------------------------------------------
Testing
---------------------------------------------------------

The set has been build tested on x86_64.
For Aarch64,
1. mm-selftests: No regressions.
2. Analyzing with tools/mm/thpmaps on different userspace programs mapping
   aligned VMAs of a large size, faulting in basepages/mTHPs (according to sysfs),
   and then madvise()'ing the VMA, khugepaged is able to 100% collapse the VMAs.

This patchset is rebased on mm-unstable (e7e89af21ffcfd1077ca6d2188de6497db1ad84c).

Some points to be noted:
1. Some stats like pages_collapsed for khugepaged have not been extended for mTHP.
   I'd welcome suggestions on any updation, or addition to the sysfs interface.
2. Please see patch 9 for lock handling.

Dev Jain (12):
  khugepaged: Rename hpage_collapse_scan_pmd() -> ptes()
  khugepaged: Generalize alloc_charge_folio()
  khugepaged: Generalize hugepage_vma_revalidate()
  khugepaged: Generalize __collapse_huge_page_swapin()
  khugepaged: Generalize __collapse_huge_page_isolate()
  khugepaged: Generalize __collapse_huge_page_copy_failed()
  khugepaged: Scan PTEs order-wise
  khugepaged: Abstract PMD-THP collapse
  khugepaged: Introduce vma_collapse_anon_folio()
  khugepaged: Skip PTE range if a larger mTHP is already mapped
  khugepaged: Enable sysfs to control order of collapse
  selftests/mm: khugepaged: Enlighten for mTHP collapse

 include/linux/huge_mm.h                 |   2 +
 mm/huge_memory.c                        |   4 +
 mm/khugepaged.c                         | 445 +++++++++++++++++-------
 tools/testing/selftests/mm/khugepaged.c |   5 +-
 4 files changed, 319 insertions(+), 137 deletions(-)

-- 
2.30.2


