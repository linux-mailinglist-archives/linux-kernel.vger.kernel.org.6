Return-Path: <linux-kernel+bounces-240647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4B992705E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731481F24B6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1681A0AFD;
	Thu,  4 Jul 2024 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E9tF0cyR"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE0FBF6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077399; cv=none; b=DQfZYERjEmhj3RZq2no/uHfTvFOkGxEgMYCtKUDRML13oIbKwrAbRFgrRgBj/ECJtpqH1O091aBndOuxBmbOlSu336YSIg6maojHh3eGt7SHw61H5sNS7TorNTwieigBfhHvRhDvxYg7lgtF6E77kdnwr7Z0Q5ICtdwdwDiEIBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077399; c=relaxed/simple;
	bh=LjsrTi2z4CRnVuzdIQm+l232jl550YGPl6TpAJ00+q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqM2WzKZowA627kVDdEjMZUtjH2/P+5xoGEEKb2WRnVPaWcnjp17kUp3WH/m17xhytAbfieL1QmgG+6wRBr/I66556qq08wNjuv3y2xdfnMaujigmqCW0N7MghnVf/2FdAoXQNkYoI4vslcPV/bqu8QHehMx9CzXPaSUC9CNsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E9tF0cyR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-75ebcd9d586so7583a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720077396; x=1720682196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvyZAWnNNxx/fwTfnUe4tHKME28aoZVHnncLaVmTBU4=;
        b=E9tF0cyRazVYn0OjCTxHNfTJ8YPBAMyY/2t39a6/ZnNkpRG2xLEinhwVZBdKFHEZJV
         gZ6GNaOHSI3OcwxsOluSuedeXSTFChJ60BaZRxEAHKv3mgURpdW38MZx5C2NNXSPxfZe
         Aig4DsJFwxL6olFRdS2mWiM4GX71mVyGIRG0O1e/PnZgKMqTxqCrDYreg6wCTAQZcV05
         PvFVobbgysXG75P0ry4tdVLdRWIEZft9eqlsNkqP6Olni6RpMMhZxER3+Ka894wNAJQv
         rY/KVz9ez0r/Fjv36KkfnWQxeLX/H6buvBZBK1e9LTytydbb7z1H+FhdO3LInYKtrZrq
         SNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720077396; x=1720682196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvyZAWnNNxx/fwTfnUe4tHKME28aoZVHnncLaVmTBU4=;
        b=F7A5hOnBQWppS9apteg6AxxKBB+y34neym6ZJmTr0egfwfJQdCm92Lc8n2CHam85qj
         TY7pnhxahovxtU+43H7vy73VPjIMX9ABRGYJ57q+GWZPoVCqa2nfJ4Q0LDt6dLIEmU42
         IXzYslHiXJuDE6VIs4mrtwAfoIM7vnamxNFfISa8vB0c/r724rPrdBZP1OLSvpHfBql1
         o8lEh1Ak6ZChtAShIaI/jbeR5Z4T4jbV/V7XRydfaKe5GEQrTZevR8JqD/7DcXNsWYMs
         bmeV7MhF/eyNeHn1YM2lbgODYLu6aaTBgq260PzEGlISl4m2OXEBRhAdchlq1PUNVmvB
         +v8w==
X-Forwarded-Encrypted: i=1; AJvYcCXIovgtsxwtBuvTx2C07yCor+YFEBHsI5Unp3XhNdUB5k3m2nLizDr4Zl1fjf4ZdP607sWYHiWNfSF4s0QgUI5+aw6ozYLVKxOCdwql
X-Gm-Message-State: AOJu0YyXzO4c64kwroQEQmEJg5hT/npVPepBbYeqnsgUoKVqA8M61EHv
	jkxVpC3UgCwwbZL0k1k00KwcXB/q4HDL5M1JTKaaMW6lfvEVUeEJ7c8r1mMYyXE=
X-Google-Smtp-Source: AGHT+IHPhEdFOtrGOq2so3f8fczbnDBB6HPj0uqaZE26HNY2schGIgbSlQBBjMxKmLniz35MD8p+4Q==
X-Received: by 2002:a17:902:e74c:b0:1f8:6e3f:9e7 with SMTP id d9443c01a7336-1fb33e18421mr8824975ad.1.1720077396279;
        Thu, 04 Jul 2024 00:16:36 -0700 (PDT)
Received: from [10.255.188.228] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599c44sm115243885ad.273.2024.07.04.00.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 00:16:35 -0700 (PDT)
Message-ID: <e7a8ddb2-52b5-4267-859b-e212644440b1@bytedance.com>
Date: Thu, 4 Jul 2024 15:16:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] synchronously scan and reclaim empty user PTE
 pages
To: the arch/x86 maintainers <x86@kernel.org>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1719570849.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Add the x86 mailing list that I forgot to CC before.

On 2024/7/1 16:46, Qi Zheng wrote:
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
>   arch/x86/include/asm/tlb.h                 |  23 ++++
>   arch/x86/kernel/paravirt.c                 |   7 ++
>   arch/x86/mm/pgtable.c                      |  15 ++-
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
>   mm/khugepaged.c                            |  24 +++-
>   mm/memory.c                                |  21 ++--
>   mm/migrate_device.c                        |   2 +-
>   mm/mmu_gather.c                            |   2 +-
>   mm/mprotect.c                              |   8 +-
>   mm/mremap.c                                |   4 +-
>   mm/page_vma_mapped.c                       |   2 +-
>   mm/pgtable-generic.c                       |  21 ++--
>   mm/pt_reclaim.c                            | 131 +++++++++++++++++++++
>   mm/userfaultfd.c                           |  10 +-
>   mm/vmscan.c                                |   2 +-
>   29 files changed, 307 insertions(+), 51 deletions(-)
>   create mode 100644 mm/pt_reclaim.c
> 

