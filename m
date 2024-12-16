Return-Path: <linux-kernel+bounces-447830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362879F3797
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D754165B74
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA63205E3B;
	Mon, 16 Dec 2024 17:31:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296DF13B792
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370314; cv=none; b=Y0GfopLpUJTBcnc7GnOPwxEiIe2+A/JE2gam5r5VPSGPHzhRO23ljX0kyFqR3iqEUNlWt4hqBC9/2GFpIieBHitDvc37NlbMZAk6gBxF4NOiAhENsPKD8MXXKQ+z7g5UrbHEu9ZZ6CopTKhKoMWTKdVFfw5N8VcnNhnZCoSx+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370314; c=relaxed/simple;
	bh=MkcgGeC5MJ3wU4xtay9XvQEuOOLy4sipsbSyVZvgTzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQq5QSguUCJQtiRTlB+P3xX6++DQ/jX/7A/9mukIFknqCQdeCjcNCryBd4RU0/g0UD/+LxKpZE17Y5Wyfq3epOEkwrnQoNkl9hbsFfDFISsemYn+gqizLs1J9sP6dB54lJbiMadjLL4k7yWFcDqKmw6Ngi/yrhCC+6N1uWDOvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4DB1106F;
	Mon, 16 Dec 2024 09:32:18 -0800 (PST)
Received: from [10.163.78.212] (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 033863F528;
	Mon, 16 Dec 2024 09:31:39 -0800 (PST)
Message-ID: <6f7fe967-0864-4b96-8426-cd9d6655d207@arm.com>
Date: Mon, 16 Dec 2024 23:01:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/12] khugepaged: Asynchronous mTHP collapse
To: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Nico Pache <npache@redhat.com>
References: <20241216165105.56185-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20241216165105.56185-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+Nico, apologies, forgot to CC you.

On 16/12/24 10:20 pm, Dev Jain wrote:
> This patchset extends khugepaged from collapsing only PMD-sized THPs to
> collapsing anonymous mTHPs.
>
> mTHPs were introduced in the kernel to improve memory management by allocating
> chunks of larger memory, so as to reduce number of page faults, TLB misses (due
> to TLB coalescing), reduce length of LRU lists, etc. However, the mTHP property
> is often lost due to CoW, swap-in/out, and when the kernel just cannot find
> enough physically contiguous memory to allocate on fault. Henceforth, there is a
> need to regain mTHPs in the system asynchronously. This work is an attempt in
> this direction, starting with anonymous folios.
>
> In the fault handler, we select the THP order in a greedy manner; the same has
> been used here, along with the same sysfs interface to control the order of
> collapse. In contrast to PMD-collapse, we (hopefully) get rid of the mmap_write_lock().
>
> ---------------------------------------------------------
> Testing
> ---------------------------------------------------------
>
> The set has been build tested on x86_64.
> For Aarch64,
> 1. mm-selftests: No regressions.
> 2. Analyzing with tools/mm/thpmaps on different userspace programs mapping
>     aligned VMAs of a large size, faulting in basepages/mTHPs (according to sysfs),
>     and then madvise()'ing the VMA, khugepaged is able to 100% collapse the VMAs.
>
> This patchset is rebased on mm-unstable (e7e89af21ffcfd1077ca6d2188de6497db1ad84c).
>
> Some points to be noted:
> 1. Some stats like pages_collapsed for khugepaged have not been extended for mTHP.
>     I'd welcome suggestions on any updation, or addition to the sysfs interface.
> 2. Please see patch 9 for lock handling.
>
> Dev Jain (12):
>    khugepaged: Rename hpage_collapse_scan_pmd() -> ptes()
>    khugepaged: Generalize alloc_charge_folio()
>    khugepaged: Generalize hugepage_vma_revalidate()
>    khugepaged: Generalize __collapse_huge_page_swapin()
>    khugepaged: Generalize __collapse_huge_page_isolate()
>    khugepaged: Generalize __collapse_huge_page_copy_failed()
>    khugepaged: Scan PTEs order-wise
>    khugepaged: Abstract PMD-THP collapse
>    khugepaged: Introduce vma_collapse_anon_folio()
>    khugepaged: Skip PTE range if a larger mTHP is already mapped
>    khugepaged: Enable sysfs to control order of collapse
>    selftests/mm: khugepaged: Enlighten for mTHP collapse
>
>   include/linux/huge_mm.h                 |   2 +
>   mm/huge_memory.c                        |   4 +
>   mm/khugepaged.c                         | 445 +++++++++++++++++-------
>   tools/testing/selftests/mm/khugepaged.c |   5 +-
>   4 files changed, 319 insertions(+), 137 deletions(-)
>

