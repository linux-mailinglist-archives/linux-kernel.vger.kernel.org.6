Return-Path: <linux-kernel+bounces-263038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C198093D019
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320A8B229A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35530177981;
	Fri, 26 Jul 2024 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctYVc4tn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DE6116
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984850; cv=none; b=QytwKt5+a2X1Lr6dM+Cc7LnPdFv60oNI0lx2SJ+jFB6zkUfajaRDWD5wgSrJUTLBCBQ7TorTyaBiMPR65zHN5KXgc2/XawlxUFwNtfdnD94UEXFSDgIJJjlFKMTX62Nt9zoifFS8sYkFyU3cFs7zAz4hM6JcLzaFgBF3QK7C9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984850; c=relaxed/simple;
	bh=lOVSU5zfw4WQm3VsIRaXXBcGT/ITCQMigIosde88sPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCwoZIEpmzrVyMIUnny/S4oVbtJpkcOPG8HrK7kKNl2KKXzpFEyylrxb1wxE7NuY4LErk4JJjYLB+x3Jua4QssldR0V1IKyVD6sEZ/kIbWyIezleQIDULpiz9qk5pOVZ0YugZ1mhcICl/iE9RQbVldvJ2DR1F3XjCi5wuByXZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctYVc4tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38295C32782;
	Fri, 26 Jul 2024 09:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721984850;
	bh=lOVSU5zfw4WQm3VsIRaXXBcGT/ITCQMigIosde88sPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ctYVc4tntsQRH9eLPCGiQszX3QzJM6uGQAbNJDH8/EvlrY1VljTlpoSoL6taXK2z7
	 2Gy60eufCIHFCx+WJpWGHl6OCZuxepnpIqwYEIv5nlzIz8YaWTyUrguVQ4JccQihCF
	 WMBg7cmFZsm0NFfmx/uHOjX0xcHH0RONRu7Uy72FnKjN4MacxazgKy+f8uc+mgVBr7
	 bXieBZlu4trgpX0lt/Wwy0VcHn9TbMatxghmAPx1xuJZA94X62p115Y6cUI9CvPIzC
	 CIEYTcNFWqcvRYabxmNsgwPvvVKckaNOaWQzKo/EcKEmAsqEfCxjLsA7tbXs7XUL31
	 G0hT3yZFpd6bg==
Message-ID: <b3ce08a8-6ab5-4cd7-82ba-9721f1ac16eb@kernel.org>
Date: Fri, 26 Jul 2024 11:07:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] synchronously scan and reclaim empty user PTE
 pages
Content-Language: en-US
To: Qi Zheng <zhengqi.arch@bytedance.com>, david@redhat.com,
 hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <cover.1719570849.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/24 10:46 AM, Qi Zheng wrote:
> Hi all,
> 
> Previously, we tried to use a completely asynchronous method to reclaim empty
> user PTE pages [1]. After discussing with David Hildenbrand, we decided to
> implement synchronous reclaimation in the case of madvise(MADV_DONTNEED) as the
> first step.
> 
> So this series aims to synchronously scan and reclaim empty user PTE pages in
> zap_page_range_single() (madvise(MADV_DONTNEED) etc will invoke this). In
> zap_page_range_single(), mmu_gather is used to perform batch tlb flushing and
> page freeing operations. Therefore, if we want to free the empty PTE page in
> this path, the most natural way is to add it to mmu_gather as well. There are
> two problems that need to be solved here:

Hello,

I would be curious to know to what extent you are planning to pursue this
area, whether it's reclaim of empty page tables synchronously for now and
maybe again asychronously later, or you also plan on exploring reclaim of
non-empty page tables.

The reason is I have a master student interested in this topic, so it would
be good to know for the planning.

Thanks a lot,
Vlastimil

> 1. Now, if CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, mmu_gather will free
>    page table pages by semi RCU:
> 
>    - batch table freeing: asynchronous free by RCU
>    - single table freeing: IPI + synchronous free
> 
>    But this is not enough to free the empty PTE page table pages in paths other
>    that munmap and exit_mmap path, because IPI cannot be synchronized with
>    rcu_read_lock() in pte_offset_map{_lock}(). So we should let single table
>    also be freed by RCU like batch table freeing.
> 
> 2. When we use mmu_gather to batch flush tlb and free PTE pages, the TLB is not
>    flushed before pmd lock is unlocked. This may result in the following two
>    situations:
> 
>    1) Userland can trigger page fault and fill a huge page, which will cause
>       the existence of small size TLB and huge TLB for the same address.
> 
>    2) Userland can also trigger page fault and fill a PTE page, which will
>       cause the existence of two small size TLBs, but the PTE page they map
>       are different.
> 
>    For case 1), according to Intel's TLB Application note (317080), some CPUs of
>    x86 do not allow it:
> 
>    ```
>    If software modifies the paging structures so that the page size used for a
>    4-KByte range of linear addresses changes, the TLBs may subsequently contain
>    both ordinary and large-page translations for the address range.12 A reference
>    to a linear address in the address range may use either translation. Which of
>    the two translations is used may vary from one execution to another and the
>    choice may be implementation-specific.
> 
>    Software wishing to prevent this uncertainty should not write to a paging-
>    structure entry in a way that would change, for any linear address, both the
>    page size and either the page frame or attributes. It can instead use the
>    following algorithm: first mark the relevant paging-structure entry (e.g.,
>    PDE) not present; then invalidate any translations for the affected linear
>    addresses (see Section 5.2); and then modify the relevant paging-structure
>    entry to mark it present and establish translation(s) for the new page size.
>    ```
> 
>    We can also learn more information from the comments above pmdp_invalidate()
>    in __split_huge_pmd_locked().
> 
>    For case 2), we can see from the comments above ptep_clear_flush() in
>    wp_page_copy() that this situation is also not allowed. Even without
>    this patch series, madvise(MADV_DONTNEED) can also cause this situation:
> 
>            CPU 0                         CPU 1
> 
>    madvise (MADV_DONTNEED)
>    -->  clear pte entry
>         pte_unmap_unlock
>                                       touch and tlb miss
> 				      --> set pte entry 
>         mmu_gather flush tlb
> 
>    But strangely, I didn't see any relevant fix code, maybe I missed something,
>    or is this guaranteed by userland?
> 
>    Anyway, this series defines the following two functions to be implemented by
>    the architecture. If the architecture does not allow the above two situations,
>    then define these two functions to flush the tlb before set_pmd_at().
> 
>    - arch_flush_tlb_before_set_huge_page
>    - arch_flush_tlb_before_set_pte_page
> 
> As a first step, we supported this feature on x86_64 and selectd the newly
> introduced CONFIG_ARCH_SUPPORTS_PT_RECLAIM.
> 
> In order to reduce overhead, we only handle the cases with a high probability
> of generating empty PTE pages, and other cases will be filtered out, such as:
> 
>  - hugetlb vma (unsuitable)
>  - userfaultfd_wp vma (may reinstall the pte entry)
>  - writable private file mapping case (COW-ed anon page is not zapped)
>  - etc
> 
> For userfaultfd_wp and writable private file mapping cases (and MADV_FREE case,
> of course), consider scanning and freeing empty PTE pages asynchronously in
> the future.
> 
> This series is based on next-20240627.
> 
> Comments and suggestions are welcome!
> 
> Thanks,
> Qi
> 
> [1]. https://lore.kernel.org/lkml/cover.1718267194.git.zhengqi.arch@bytedance.com/
> 
> Qi Zheng (7):
>   mm: pgtable: make pte_offset_map_nolock() return pmdval
>   mm: introduce CONFIG_PT_RECLAIM
>   mm: pass address information to pmd_install()
>   mm: pgtable: try to reclaim empty PTE pages in zap_page_range_single()
>   x86: mm: free page table pages by RCU instead of semi RCU
>   x86: mm: define arch_flush_tlb_before_set_huge_page
>   x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
> 
>  Documentation/mm/split_page_table_lock.rst |   3 +-
>  arch/arm/mm/fault-armv.c                   |   2 +-
>  arch/powerpc/mm/pgtable.c                  |   2 +-
>  arch/x86/Kconfig                           |   1 +
>  arch/x86/include/asm/pgtable.h             |   6 +
>  arch/x86/include/asm/tlb.h                 |  23 ++++
>  arch/x86/kernel/paravirt.c                 |   7 ++
>  arch/x86/mm/pgtable.c                      |  15 ++-
>  include/linux/hugetlb.h                    |   2 +-
>  include/linux/mm.h                         |  13 +-
>  include/linux/pgtable.h                    |  14 +++
>  mm/Kconfig                                 |  14 +++
>  mm/Makefile                                |   1 +
>  mm/debug_vm_pgtable.c                      |   2 +-
>  mm/filemap.c                               |   4 +-
>  mm/gup.c                                   |   2 +-
>  mm/huge_memory.c                           |   3 +
>  mm/internal.h                              |  17 ++-
>  mm/khugepaged.c                            |  24 +++-
>  mm/memory.c                                |  21 ++--
>  mm/migrate_device.c                        |   2 +-
>  mm/mmu_gather.c                            |   2 +-
>  mm/mprotect.c                              |   8 +-
>  mm/mremap.c                                |   4 +-
>  mm/page_vma_mapped.c                       |   2 +-
>  mm/pgtable-generic.c                       |  21 ++--
>  mm/pt_reclaim.c                            | 131 +++++++++++++++++++++
>  mm/userfaultfd.c                           |  10 +-
>  mm/vmscan.c                                |   2 +-
>  29 files changed, 307 insertions(+), 51 deletions(-)
>  create mode 100644 mm/pt_reclaim.c
> 


