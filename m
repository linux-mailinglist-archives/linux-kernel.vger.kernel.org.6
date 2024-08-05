Return-Path: <linux-kernel+bounces-274707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3972947BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6093A283A92
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602DC159583;
	Mon,  5 Aug 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LlXL75ba"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438D1E49F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863672; cv=none; b=X56FrTPmfRmTkqJ3eVAByTnpW9ybtQ2a/FvtNh8mDhYiD4UOPFPviv+wHjVjVlERZOEaLG14o4o5AYSncwr8mOxsXUILzQSxNmu4kaSQ2216NcNrNcLdTRdAECOniF8MYgqgaFz5AAqR6ZbBCHPxHpYX/ePMpBHil28spRCtzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863672; c=relaxed/simple;
	bh=TSrDntWAQOVZ3MzKzGijeX8u7O5SVZGOi1C24nOJTzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oosl24yMlPXfYCwJrFzurVCXL+yGDsxdyju4GQZv9zbuiP4bj954Dm2QCE2jeL0jPmvnKXtcewwY3jQ9SJwXSNtHDrqDh6gfAWLJ4nBK/jNnyk7EaOQeKoB9DjJCvE+QUDALsnHfsQu/87opLqhPMUFUzgPatwvIBHNe7m+0frQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LlXL75ba; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cd46049d2bso1781937a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722863669; x=1723468469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBDKu/3d5EeJGhBTyFb0VU/Q7KKBy8S9Jlsd5i+OeeY=;
        b=LlXL75badgOMp/Ve+DeB8ywIQLimEavHkIOcxajp5s8cXyUtvivYJL1C43B9N+x+mf
         lBCg0xcU/gxsxGcDN2FsSe3HyqdUuXed7/tfcI1NuaI/7t7buwAdMz9ABGWeySZhD16a
         Fyq3gZmMJIScITN5ell+XM0HvGF/PlDtFjoYa11lFHSdNpLEWJXMt8PDAn+m7c3wqQvq
         kebBCz7cIb+/c2C08o+YpsyYM+9DqNHIP1ZuyDVecvTlJi68ynrVsgu2JmxjKeGas7I1
         wYxuEj/Yfd9+Bb6zpopVGWYepWS4+XU31a9HC/3TUDKhFeoknWIMgNXz4whwFNOG5Zxr
         YByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722863669; x=1723468469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBDKu/3d5EeJGhBTyFb0VU/Q7KKBy8S9Jlsd5i+OeeY=;
        b=WIqB/hjxBRD3FKxl0MCwILLZ/7JXpuHnGn/eTIB1Y8VNrdVx5KGI84dvu3Wj7/XMGb
         qBPoqelz3Z3suohqeGcFQ6X3AQwdhY1/kVcq1KdTrNApzQ+tl8Z1fDtVQHO9+mKnsMHO
         a0EZA+Naxn4xvJI2Hz+iDsn8cfeVCD4xJ8MSCkFGP2AbsMoyQKhueErqS2cNSHYhZYGW
         TF/kiwV3IdIirF/3CvMxAnCvZrqG3c5BEdsfGQmr+ZPD8x/3KJ7nVVmgUHhRCYnF5l4c
         yC7pgwQ9Pv4TdrZ0ampIHLWiINnfFZFCoOWl2Ze1XaZ9l2769Y9gGX6mY46Y7/kIN+Df
         +o8A==
X-Forwarded-Encrypted: i=1; AJvYcCWffP7dcjTI5h//XdOM3q8GZ6Zxwcj8HCLX0SsdiUwzW2EaF5vEKbXTrUqxekbctoHzoMfFJOYWg5jLqdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU5+LGEnb1Fb7bH2cJxgeJwOOHOS8n2m0zWyKRUpx3euCXhiNz
	jBxNLIlcXj78qVn6by5vcPo5hvbHWPmpLLWGCICVLZjvZA1R9cczW5XczRZTQuI=
X-Google-Smtp-Source: AGHT+IE6jROMIMs6StIxQgcHSl1DsQ6hKW5lBhCvbUY9/JbzNuIJLxoEeXj4DiX2VakT2Eh6xmDCuw==
X-Received: by 2002:a17:90b:1bcd:b0:2cb:4382:6690 with SMTP id 98e67ed59e1d1-2cff95b63dbmr7919286a91.6.1722863669355;
        Mon, 05 Aug 2024 06:14:29 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb091a99sm7122257a91.21.2024.08.05.06.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 06:14:28 -0700 (PDT)
Message-ID: <5505cdd3-b716-4ba5-98b4-9b2a4f06a432@bytedance.com>
Date: Mon, 5 Aug 2024 21:14:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] synchronously scan and reclaim empty user PTE
 pages
Content-Language: en-US
To: the arch/x86 maintainers <x86@kernel.org>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1722861064.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Add the x86 mailing list.

On 2024/8/5 20:55, Qi Zheng wrote:
> Changes in RFC v2:
>   - fix compilation errors in [RFC PATCH 5/7] and [RFC PATCH 7/7] reproted by
>     kernel test robot
>   - use pte_offset_map_nolock() + pmd_same() instead of check_pmd_still_valid()
>     in retract_page_tables() (in [RFC PATCH 4/7])
>   - rebase onto the next-20240805
> 
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
> 
> 1. Now, if CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, mmu_gather will free
>     page table pages by semi RCU:
> 
>     - batch table freeing: asynchronous free by RCU
>     - single table freeing: IPI + synchronous free
> 
>     But this is not enough to free the empty PTE page table pages in paths other
>     that munmap and exit_mmap path, because IPI cannot be synchronized with
>     rcu_read_lock() in pte_offset_map{_lock}(). So we should let single table
>     also be freed by RCU like batch table freeing.
> 
> 2. When we use mmu_gather to batch flush tlb and free PTE pages, the TLB is not
>     flushed before pmd lock is unlocked. This may result in the following two
>     situations:
> 
>     1) Userland can trigger page fault and fill a huge page, which will cause
>        the existence of small size TLB and huge TLB for the same address.
> 
>     2) Userland can also trigger page fault and fill a PTE page, which will
>        cause the existence of two small size TLBs, but the PTE page they map
>        are different.
> 
>     For case 1), according to Intel's TLB Application note (317080), some CPUs of
>     x86 do not allow it:
> 
>     ```
>     If software modifies the paging structures so that the page size used for a
>     4-KByte range of linear addresses changes, the TLBs may subsequently contain
>     both ordinary and large-page translations for the address range.12 A reference
>     to a linear address in the address range may use either translation. Which of
>     the two translations is used may vary from one execution to another and the
>     choice may be implementation-specific.
> 
>     Software wishing to prevent this uncertainty should not write to a paging-
>     structure entry in a way that would change, for any linear address, both the
>     page size and either the page frame or attributes. It can instead use the
>     following algorithm: first mark the relevant paging-structure entry (e.g.,
>     PDE) not present; then invalidate any translations for the affected linear
>     addresses (see Section 5.2); and then modify the relevant paging-structure
>     entry to mark it present and establish translation(s) for the new page size.
>     ```
> 
>     We can also learn more information from the comments above pmdp_invalidate()
>     in __split_huge_pmd_locked().
> 
>     For case 2), we can see from the comments above ptep_clear_flush() in
>     wp_page_copy() that this situation is also not allowed. Even without
>     this patch series, madvise(MADV_DONTNEED) can also cause this situation:
> 
>             CPU 0                         CPU 1
> 
>     madvise (MADV_DONTNEED)
>     -->  clear pte entry
>          pte_unmap_unlock
>                                        touch and tlb miss
> 				      --> set pte entry
>          mmu_gather flush tlb
> 
>     But strangely, I didn't see any relevant fix code, maybe I missed something,
>     or is this guaranteed by userland?
> 
>     Anyway, this series defines the following two functions to be implemented by
>     the architecture. If the architecture does not allow the above two situations,
>     then define these two functions to flush the tlb before set_pmd_at().
> 
>     - arch_flush_tlb_before_set_huge_page
>     - arch_flush_tlb_before_set_pte_page
> 
> As a first step, we supported this feature on x86_64 and selectd the newly
> introduced CONFIG_ARCH_SUPPORTS_PT_RECLAIM.
> 
> In order to reduce overhead, we only handle the cases with a high probability
> of generating empty PTE pages, and other cases will be filtered out, such as:
> 
>   - hugetlb vma (unsuitable)
>   - userfaultfd_wp vma (may reinstall the pte entry)
>   - writable private file mapping case (COW-ed anon page is not zapped)
>   - etc
> 
> For userfaultfd_wp and writable private file mapping cases (and MADV_FREE case,
> of course), consider scanning and freeing empty PTE pages asynchronously in
> the future.
> 
> This series is based on next-20240805.
> 
> Comments and suggestions are welcome!
> 
> Thanks,
> Qi
> 
> [1]. https://lore.kernel.org/lkml/cover.1718267194.git.zhengqi.arch@bytedance.com/
> 
> Qi Zheng (7):
>    mm: pgtable: make pte_offset_map_nolock() return pmdval
>    mm: introduce CONFIG_PT_RECLAIM
>    mm: pass address information to pmd_install()
>    mm: pgtable: try to reclaim empty PTE pages in zap_page_range_single()
>    x86: mm: free page table pages by RCU instead of semi RCU
>    x86: mm: define arch_flush_tlb_before_set_huge_page
>    x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
> 
>   Documentation/mm/split_page_table_lock.rst |   3 +-
>   arch/arm/mm/fault-armv.c                   |   2 +-
>   arch/powerpc/mm/pgtable.c                  |   2 +-
>   arch/x86/Kconfig                           |   1 +
>   arch/x86/include/asm/pgtable.h             |   6 +
>   arch/x86/include/asm/tlb.h                 |  19 +++
>   arch/x86/kernel/paravirt.c                 |   7 ++
>   arch/x86/mm/pgtable.c                      |  23 +++-
>   include/linux/hugetlb.h                    |   2 +-
>   include/linux/mm.h                         |  13 +-
>   include/linux/pgtable.h                    |  14 +++
>   mm/Kconfig                                 |  14 +++
>   mm/Makefile                                |   1 +
>   mm/debug_vm_pgtable.c                      |   2 +-
>   mm/filemap.c                               |   4 +-
>   mm/gup.c                                   |   2 +-
>   mm/huge_memory.c                           |   3 +
>   mm/internal.h                              |  17 ++-
>   mm/khugepaged.c                            |  32 +++--
>   mm/memory.c                                |  21 ++--
>   mm/migrate_device.c                        |   2 +-
>   mm/mmu_gather.c                            |   9 +-
>   mm/mprotect.c                              |   8 +-
>   mm/mremap.c                                |   4 +-
>   mm/page_vma_mapped.c                       |   2 +-
>   mm/pgtable-generic.c                       |  21 ++--
>   mm/pt_reclaim.c                            | 131 +++++++++++++++++++++
>   mm/userfaultfd.c                           |  10 +-
>   mm/vmscan.c                                |   2 +-
>   29 files changed, 321 insertions(+), 56 deletions(-)
>   create mode 100644 mm/pt_reclaim.c
> 

