Return-Path: <linux-kernel+bounces-265180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604A93EDA2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61573B20C75
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FACA83CC8;
	Mon, 29 Jul 2024 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YEtLxo+r"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3E2119
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722235630; cv=none; b=Smrz4mwF/xvx23UF2WQIIgcqseAn77HOUidBK2BLoyCW5qPjz/4Euc7unWBO/5+fTrMldHz6+F93wSblnCbH+0V8MKr0upyk0s61apWnuDrV/oeXyvIYy+pMJq3t66M4hjzUvd2Vr4A3dsDQzHi3uAUlQdgqrirL8UeGZ3Ohnio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722235630; c=relaxed/simple;
	bh=DXW2wcix2Hw7Kylpnsj7fEB8KI55y8VX8F5/CX3dBOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRj7+JPRtkEgWTjX0Z5z0B8Q05qCSbUIX3M7AdBfUCpkb7aWnoQxxIDtLfASA1/YxOTHz+dKqbrJEVH2R2B0/7wJ3GNMaUPfOoyFzIw0mIg5FyqcwKqViK/dVTwty89FABJNH3Xue1LH6fzy4yOYhRyyrlOjS8bdGh9rKItMDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YEtLxo+r; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d92b27767eso147378b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 23:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722235627; x=1722840427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3TSuWFPLqLXatPXQN0V7tpJFNJ3XCu8cL+90r5ZF1Xw=;
        b=YEtLxo+rCLKuWNmmRi37E0kZXmLE2GmNcqBDSmhqRxLuTztgGq2mR+7Y5V0Ot32wNC
         ulJ1ZpCafPC8LA7kgoSb76LpMG3W2nxXxY6HwVMdGdNPnZUPHAkZDKB/aTY/sSgUzcQz
         B8eXuxyWYlcxizip98KanJVvjpebAw8h1BjkVTGMauv9HT1VfmUWnG470nE7501G0uyT
         zRHwhW2GMa1SXmndlu99av5kFobAe8CVw4jRHS2a5L2pvi3oIrJDSxLItb+vjoXu5HCu
         E0to2g/hMgqqkkhVhf7m/CWOzRDKYQr5MKFPJkmm/tb3YRwhKMbWRgaa2KV5qlPtWoBG
         2sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722235627; x=1722840427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TSuWFPLqLXatPXQN0V7tpJFNJ3XCu8cL+90r5ZF1Xw=;
        b=ds1X+k8ynhs5shrFTjEZY3OT0VsbYKIDwEu8D/GckLFKzH10FMZSj4eRuXSmdANySO
         ZUOo15QtCRgZjF+s6x29EBVomrreT3T2uCgXuwD278veKu0+P3jL0Q7H+QI3c2d3brrt
         zFsypuamGwbQOlT9/OdIoh1b3deE3bMUV9sF+038b+cgv4+24zW7U6BV1v5QHbtxhUuo
         xlgen17/M7UAN9w2cDeX3oJpeF28pcgA/fAYdcRO1iy2OuNt+YYLyjtLtbuY2vjRlDYr
         bKyJY21dOO8NhMqyqyzvfI5e05mEAh+aSfpLhicYVJDHTWmk9zX8uVOKdE6zgmwCh8gW
         trXA==
X-Forwarded-Encrypted: i=1; AJvYcCVQomr9/Idm4jMZmsOo0AHW+vtNrOBDqwqIcyFNbrpBd4iXNzpTn1pFVoZ5REy+UZ1nb3JAo5wMP/mdQ3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE9bAC/1oxZSksc9oB+MxuL0MSSDn/A6o+umi0RVBxpkGqYlEn
	5FJfyvCazfGcDyaIBNl7SiahlhnLM8tlBrrORAXv5m907Cnen0CrSAfgIZiT/rY=
X-Google-Smtp-Source: AGHT+IF/tqrHcnt39eBxI5LZVdaWObkXyetyF18xAok06itu3FbLaPNsW77SrSeITKx+k1Yp3Pawpw==
X-Received: by 2002:a05:6808:1929:b0:3db:2eb9:addd with SMTP id 5614622812f47-3db2eb9b431mr2972640b6e.4.1722235626925;
        Sun, 28 Jul 2024 23:47:06 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8849608sm5553445a12.48.2024.07.28.23.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 23:47:06 -0700 (PDT)
Message-ID: <288c35d9-47d5-405d-b921-4f4c59eb3920@bytedance.com>
Date: Mon, 29 Jul 2024 14:46:59 +0800
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
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
 <b3ce08a8-6ab5-4cd7-82ba-9721f1ac16eb@kernel.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <b3ce08a8-6ab5-4cd7-82ba-9721f1ac16eb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vlastimil,

On 2024/7/26 17:07, Vlastimil Babka (SUSE) wrote:
> On 7/1/24 10:46 AM, Qi Zheng wrote:
>> Hi all,
>>
>> Previously, we tried to use a completely asynchronous method to reclaim empty
>> user PTE pages [1]. After discussing with David Hildenbrand, we decided to
>> implement synchronous reclaimation in the case of madvise(MADV_DONTNEED) as the
>> first step.
>>
>> So this series aims to synchronously scan and reclaim empty user PTE pages in
>> zap_page_range_single() (madvise(MADV_DONTNEED) etc will invoke this). In
>> zap_page_range_single(), mmu_gather is used to perform batch tlb flushing and
>> page freeing operations. Therefore, if we want to free the empty PTE page in
>> this path, the most natural way is to add it to mmu_gather as well. There are
>> two problems that need to be solved here:
> 
> Hello,

Thank you for your attention to this patch series!

> 
> I would be curious to know to what extent you are planning to pursue this
> area, whether it's reclaim of empty page tables synchronously for now and
> maybe again asychronously later, or you also plan on exploring reclaim of
> non-empty page tables.

As I discussed with David Hildenbrand, I am currently planning to
implement synchronous empty user page table reclamation first for the
following reasons:

1. It covers most of the known cases.
2. As a first step, it helps verify the lock protection scheme, tlb 
flushing, and other infrastructure.

Later, I plan to implement asynchronous reclamation for MADV_FREE and
other situations. The initial idea is to mark vma first, then add the
corresponding mm to a global linked list, and then perform asynchronous
scanning and reclamation in the memory reclamation process.

For exploring reclaim of non-empty page tables, no plan yet. But I have
another plan, which is to remove the page table from the protection of 
the mmap lock:

1. free all levels of page table pages by RCU, not just PTE pages, but
    also pmd, pud, etc.
2. similar to pte_offset_map/pte_unmap, add
    [pmd|pud]_offset_map/[pmd|pud]_unmap, and make them all contain
    rcu_read_lock/rcu_read_unlcok, and make them accept failure.

In this way, we no longer need the mmap lcok. For readers, such as page
table wallers, we are already in the critical section of RCU. For
writers, we only need to hold the page table lock.

But there is a difficulty here, that is, the RCU critical section is not
allowed to sleep, but it is possible to sleep in the callback function
of .pmd_entry, such as mmu_notifier_invalidate_range_start().

Use SRCU instead? Not sure.

> 
> The reason is I have a master student interested in this topic, so it would
> be good to know for the planning.

This is great, comments and suggestions are welcome!

Thanks,
Qi

> 
> Thanks a lot,
> Vlastimil
> 
>> 1. Now, if CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, mmu_gather will free
>>     page table pages by semi RCU:
>>
>>     - batch table freeing: asynchronous free by RCU
>>     - single table freeing: IPI + synchronous free
>>
>>     But this is not enough to free the empty PTE page table pages in paths other
>>     that munmap and exit_mmap path, because IPI cannot be synchronized with
>>     rcu_read_lock() in pte_offset_map{_lock}(). So we should let single table
>>     also be freed by RCU like batch table freeing.
>>
>> 2. When we use mmu_gather to batch flush tlb and free PTE pages, the TLB is not
>>     flushed before pmd lock is unlocked. This may result in the following two
>>     situations:
>>
>>     1) Userland can trigger page fault and fill a huge page, which will cause
>>        the existence of small size TLB and huge TLB for the same address.
>>
>>     2) Userland can also trigger page fault and fill a PTE page, which will
>>        cause the existence of two small size TLBs, but the PTE page they map
>>        are different.
>>
>>     For case 1), according to Intel's TLB Application note (317080), some CPUs of
>>     x86 do not allow it:
>>
>>     ```
>>     If software modifies the paging structures so that the page size used for a
>>     4-KByte range of linear addresses changes, the TLBs may subsequently contain
>>     both ordinary and large-page translations for the address range.12 A reference
>>     to a linear address in the address range may use either translation. Which of
>>     the two translations is used may vary from one execution to another and the
>>     choice may be implementation-specific.
>>
>>     Software wishing to prevent this uncertainty should not write to a paging-
>>     structure entry in a way that would change, for any linear address, both the
>>     page size and either the page frame or attributes. It can instead use the
>>     following algorithm: first mark the relevant paging-structure entry (e.g.,
>>     PDE) not present; then invalidate any translations for the affected linear
>>     addresses (see Section 5.2); and then modify the relevant paging-structure
>>     entry to mark it present and establish translation(s) for the new page size.
>>     ```
>>
>>     We can also learn more information from the comments above pmdp_invalidate()
>>     in __split_huge_pmd_locked().
>>
>>     For case 2), we can see from the comments above ptep_clear_flush() in
>>     wp_page_copy() that this situation is also not allowed. Even without
>>     this patch series, madvise(MADV_DONTNEED) can also cause this situation:
>>
>>             CPU 0                         CPU 1
>>
>>     madvise (MADV_DONTNEED)
>>     -->  clear pte entry
>>          pte_unmap_unlock
>>                                        touch and tlb miss
>> 				      --> set pte entry
>>          mmu_gather flush tlb
>>
>>     But strangely, I didn't see any relevant fix code, maybe I missed something,
>>     or is this guaranteed by userland?
>>
>>     Anyway, this series defines the following two functions to be implemented by
>>     the architecture. If the architecture does not allow the above two situations,
>>     then define these two functions to flush the tlb before set_pmd_at().
>>
>>     - arch_flush_tlb_before_set_huge_page
>>     - arch_flush_tlb_before_set_pte_page
>>
>> As a first step, we supported this feature on x86_64 and selectd the newly
>> introduced CONFIG_ARCH_SUPPORTS_PT_RECLAIM.
>>
>> In order to reduce overhead, we only handle the cases with a high probability
>> of generating empty PTE pages, and other cases will be filtered out, such as:
>>
>>   - hugetlb vma (unsuitable)
>>   - userfaultfd_wp vma (may reinstall the pte entry)
>>   - writable private file mapping case (COW-ed anon page is not zapped)
>>   - etc
>>
>> For userfaultfd_wp and writable private file mapping cases (and MADV_FREE case,
>> of course), consider scanning and freeing empty PTE pages asynchronously in
>> the future.
>>
>> This series is based on next-20240627.
>>
>> Comments and suggestions are welcome!
>>
>> Thanks,
>> Qi
>>
>> [1]. https://lore.kernel.org/lkml/cover.1718267194.git.zhengqi.arch@bytedance.com/
>>
>> Qi Zheng (7):
>>    mm: pgtable: make pte_offset_map_nolock() return pmdval
>>    mm: introduce CONFIG_PT_RECLAIM
>>    mm: pass address information to pmd_install()
>>    mm: pgtable: try to reclaim empty PTE pages in zap_page_range_single()
>>    x86: mm: free page table pages by RCU instead of semi RCU
>>    x86: mm: define arch_flush_tlb_before_set_huge_page
>>    x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
>>
>>   Documentation/mm/split_page_table_lock.rst |   3 +-
>>   arch/arm/mm/fault-armv.c                   |   2 +-
>>   arch/powerpc/mm/pgtable.c                  |   2 +-
>>   arch/x86/Kconfig                           |   1 +
>>   arch/x86/include/asm/pgtable.h             |   6 +
>>   arch/x86/include/asm/tlb.h                 |  23 ++++
>>   arch/x86/kernel/paravirt.c                 |   7 ++
>>   arch/x86/mm/pgtable.c                      |  15 ++-
>>   include/linux/hugetlb.h                    |   2 +-
>>   include/linux/mm.h                         |  13 +-
>>   include/linux/pgtable.h                    |  14 +++
>>   mm/Kconfig                                 |  14 +++
>>   mm/Makefile                                |   1 +
>>   mm/debug_vm_pgtable.c                      |   2 +-
>>   mm/filemap.c                               |   4 +-
>>   mm/gup.c                                   |   2 +-
>>   mm/huge_memory.c                           |   3 +
>>   mm/internal.h                              |  17 ++-
>>   mm/khugepaged.c                            |  24 +++-
>>   mm/memory.c                                |  21 ++--
>>   mm/migrate_device.c                        |   2 +-
>>   mm/mmu_gather.c                            |   2 +-
>>   mm/mprotect.c                              |   8 +-
>>   mm/mremap.c                                |   4 +-
>>   mm/page_vma_mapped.c                       |   2 +-
>>   mm/pgtable-generic.c                       |  21 ++--
>>   mm/pt_reclaim.c                            | 131 +++++++++++++++++++++
>>   mm/userfaultfd.c                           |  10 +-
>>   mm/vmscan.c                                |   2 +-
>>   29 files changed, 307 insertions(+), 51 deletions(-)
>>   create mode 100644 mm/pt_reclaim.c
>>
> 

