Return-Path: <linux-kernel+bounces-439126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9354F9EAB24
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5FF168A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0C230D17;
	Tue, 10 Dec 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bS/4yvf5"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0533722ACFA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821035; cv=none; b=JRBZ5/S7SzkQVttUo5g3R4Ug6z+T+npcNGlWyLRfEZ3MiG7huSLAda38qB/0bIphBya8HjPhX4LF4rTeSc5dZVSy3Cl9amij4TroF3BWjTs/A95amwBjsDvfeKvpbHv8zAHmnGQXktd+DBmluXoqjc+4t6sndnKT/noxau18r1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821035; c=relaxed/simple;
	bh=0Ibvd3MQJbPBmh2jlMA7i/paVUYiCrGn+5Od0xyUcEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YijnrJ3+xWOmwetH51TqiAVCo988q9Z4ILJ3MUQmyKen9SrHDDGyUbwCRyGyk0ZlfmEi4SIx9gKTo6IdvlEux5j8f20BUQGZqpuVi5ZuKNLwDumCfZQExmTiqgRloJ4bKCGMJtwFOiUzPHM3mWsNQA8wlMRblby/D4Blz92fpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bS/4yvf5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728e3826211so181124b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733821033; x=1734425833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFnSp90isoQHZnudUudu/E8shqZxJ4KBowfLIz/rby4=;
        b=bS/4yvf5n1+klkZun4AhGB1z45twtEM/hsfnEo7NeGnloycZBoPDRqOCDaw/u3T9Fq
         wPAPeCT2VBotKU6wEThYnG7f/GX5oAQV2F7Xlk8os52XFQ9Zo3d0RnkHZ0SLYRAirBXL
         wiJU3NNoP2I+WK05pXiAIEnhhh1BiLz1pmcM7Rn7+3w/WMpO/eNxAW/IYZWKW7DYBne2
         bNz8GrB5EkLcgSMHSwiRItGyGLGmQO8Jflt/LN7V++cTh+6/MA5g2ObjKMoJyOK3m7X2
         pbe3bd1ofsQGG7bH9E9NY/BR1a0xW0mRBD5JVokT0989N0/oquzHydHUnyNe2G5gESce
         /MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821033; x=1734425833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFnSp90isoQHZnudUudu/E8shqZxJ4KBowfLIz/rby4=;
        b=dvScaDiHczjlCvVHV0lFXcL3+dYCfDoXgAdveiUWyAmIhk2tO+zGrcS7Acb0A1vvO8
         vJRBClDArjm0rQ06E9CrFdNgwyqvB1fjNAIUaOcnYhyeberVL3g+1kVAHL0vYFLkps35
         m1eR3UxVYoMpCDtyj93KyjQJkVQkxnybdUUXiJGJVPQym1y3DFsHBRy/mOHD6NcnZ+v6
         KdgDIYPm4U8W3F63ks7YIAop2ED84sbYOLq1ly6KN8gs7Oph6Lo4cG5zPFnpMK1jtHvr
         22tce/XVktkpm26v5bFGNiMYOg9BhRpd9Sex/XYu2xRzfRWoXFjKQqJehWdMiD/elTyD
         U8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWPDRaHy4k4Wuk5EkqO/MbpAmPGFU9fQAHfq3UH+NK1zNOUiRjyyyXeVWxYsa30gii79Ws9zXh25Oc6QJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HTe2jm8wX0XR2CYalAG0e+feYWp4KQ96whgXrsrNUoZjHWgF
	7tfNcSi6QeFRrhdJKS3v+4w8KH85LggyX37mdwlCKQmAJ7HGFrpyUHsnoLveCA0GzTUFpwoOvFD
	z
X-Gm-Gg: ASbGncvGR/fonZkm5ARQn/5uqh3BklrLgf12h2n4XGdsdsuvl5KrrUK0AJU2L/4VO6G
	8gSqkcD24yIMJjXg5dDNExA9satwuRAJE8PEvir9MHn4TKkPHOwPWZnFBPr+1J0FUb8Bfid8ppQ
	uzVQ5otp8umqVpUU4MCOx9NY9PHW+QfTNocfkiKeksL1BNPuA1IYZ8oR5Dsg9lC5qelRGPq6uVs
	UQetSvR7G8YfCkW5zimFHcJ9S/0fAezVW15bV453QDDx4k9irHlxlFHRlEOhWH6Slonff0V2EUb
	7Qw=
X-Google-Smtp-Source: AGHT+IEhwn7lM7hxG2M1TcDab9WPLMFqlkMGDnOLCQZBUX3EAIfYlifkwgbzBQClAPED9zWgSj7OsA==
X-Received: by 2002:a05:6a00:174b:b0:727:3c8f:3707 with SMTP id d2e1a72fcca58-7273c8f3efemr6672464b3a.23.1733821033070;
        Tue, 10 Dec 2024 00:57:13 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725df1e6776sm4547382b3a.170.2024.12.10.00.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 00:57:12 -0800 (PST)
Message-ID: <53fb3b26-4a28-48a2-8403-a9b8d2fe6c24@bytedance.com>
Date: Tue, 10 Dec 2024 16:57:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] synchronously scan and reclaim empty user PTE
 pages
Content-Language: en-US
To: akpm@linux-foundation.org
Cc: david@redhat.com, jannh@google.com, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

I have sent patch[1][2][3] to fix recently reported issues:

[1]. 
https://lore.kernel.org/lkml/20241210084156.89877-1-zhengqi.arch@bytedance.com/
(Fix warning, need to be folded into [PATCH v4 02/11])

[2]. 
https://lore.kernel.org/lkml/20241206112348.51570-1-zhengqi.arch@bytedance.com/
(Fix uninitialized symbol, need to be folded into [PATCH v4 09/11])

[3]. 
https://lore.kernel.org/lkml/20241210084431.91414-1-zhengqi.arch@bytedance.com/
(fix UAF, need to be placed before [PATCH v4 11/11])

If you need me to re-post a complete v5, please let me know.

Thanks,
Qi


On 2024/12/4 19:09, Qi Zheng wrote:
> Changes in v4:
>   - update the process_addrs.rst in [PATCH v4 01/11]
>     (suggested by Lorenzo Stoakes)
>   - fix [PATCH v3 4/9] and move it after [PATCH v3 5/9]
>     (pointed by David Hildenbrand)
>   - change to use any_skipped instead of rechecking pte_none() to detect empty
>     user PTE pages (suggested by David Hildenbrand)
>   - rebase onto the next-20241203
> 
> Changes in v3:
>   - recheck pmd state instead of pmd_same() in retract_page_tables()
>     (suggested by Jann Horn)
>   - recheck dst_pmd entry in move_pages_pte() (pointed by Jann Horn)
>   - introduce new skip_none_ptes() (suggested by David Hildenbrand)
>   - minor changes in [PATCH v2 5/7]
>   - remove tlb_remove_table_sync_one() if CONFIG_PT_RECLAIM is enabled.
>   - use put_page() instead of free_page_and_swap_cache() in
>     __tlb_remove_table_one_rcu() (pointed by Jann Horn)
>   - collect the Reviewed-bys and Acked-bys
>   - rebase onto the next-20241112
> 
> Changes in v2:
>   - fix [PATCH v1 1/7] (Jann Horn)
>   - reset force_flush and force_break to false in [PATCH v1 2/7] (Jann Horn)
>   - introduce zap_nonpresent_ptes() and do_zap_pte_range()
>   - check pte_none() instead of can_reclaim_pt after the processing of PTEs
>     (remove [PATCH v1 3/7] and [PATCH v1 4/7])
>   - reorder patches
>   - rebase onto the next-20241031
> 
> Changes in v1:
>   - replace [RFC PATCH 1/7] with a separate serise (already merge into mm-unstable):
>     https://lore.kernel.org/lkml/cover.1727332572.git.zhengqi.arch@bytedance.com/
>     (suggested by David Hildenbrand)
>   - squash [RFC PATCH 2/7] into [RFC PATCH 4/7]
>     (suggested by David Hildenbrand)
>   - change to scan and reclaim empty user PTE pages in zap_pte_range()
>     (suggested by David Hildenbrand)
>   - sent a separate RFC patch to track the tlb flushing issue, and remove
>     that part form this series ([RFC PATCH 3/7] and [RFC PATCH 6/7]).
>     link: https://lore.kernel.org/lkml/20240815120715.14516-1-zhengqi.arch@bytedance.com/
>   - add [PATCH v1 1/7] into this series
>   - drop RFC tag
>   - rebase onto the next-20241011
> 
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
> So this series aims to synchronously free the empty PTE pages in
> madvise(MADV_DONTNEED) case. We will detect and free empty PTE pages in
> zap_pte_range(), and will add zap_details.reclaim_pt to exclude cases other than
> madvise(MADV_DONTNEED).
> 
> In zap_pte_range(), mmu_gather is used to perform batch tlb flushing and page
> freeing operations. Therefore, if we want to free the empty PTE page in this
> path, the most natural way is to add it to mmu_gather as well. Now, if
> CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, mmu_gather will free page table
> pages by semi RCU:
> 
>   - batch table freeing: asynchronous free by RCU
>   - single table freeing: IPI + synchronous free
> 
> But this is not enough to free the empty PTE page table pages in paths other
> that munmap and exit_mmap path, because IPI cannot be synchronized with
> rcu_read_lock() in pte_offset_map{_lock}(). So we should let single table also
> be freed by RCU like batch table freeing.
> 
> As a first step, we supported this feature on x86_64 and selectd the newly
> introduced CONFIG_ARCH_SUPPORTS_PT_RECLAIM.
> 
> For other cases such as madvise(MADV_FREE), consider scanning and freeing empty
> PTE pages asynchronously in the future.
> 
> This series is based on next-20241112 (which contains the series [2]).
> 
> Note: issues related to TLB flushing are not new to this series and are tracked
>        in the separate RFC patch [3]. And more context please refer to this
>        thread [4].
> 
> Comments and suggestions are welcome!
> 
> Thanks,
> Qi
> 
> [1]. https://lore.kernel.org/lkml/cover.1718267194.git.zhengqi.arch@bytedance.com/
> [2]. https://lore.kernel.org/lkml/cover.1727332572.git.zhengqi.arch@bytedance.com/
> [3]. https://lore.kernel.org/lkml/20240815120715.14516-1-zhengqi.arch@bytedance.com/
> [4]. https://lore.kernel.org/lkml/6f38cb19-9847-4f70-bbe7-06881bb016be@bytedance.com/
> 
> Qi Zheng (11):
>    mm: khugepaged: recheck pmd state in retract_page_tables()
>    mm: userfaultfd: recheck dst_pmd entry in move_pages_pte()
>    mm: introduce zap_nonpresent_ptes()
>    mm: introduce do_zap_pte_range()
>    mm: skip over all consecutive none ptes in do_zap_pte_range()
>    mm: zap_install_uffd_wp_if_needed: return whether uffd-wp pte has been
>      re-installed
>    mm: do_zap_pte_range: return any_skipped information to the caller
>    mm: make zap_pte_range() handle full within-PMD range
>    mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)
>    x86: mm: free page table pages by RCU instead of semi RCU
>    x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
> 
>   Documentation/mm/process_addrs.rst |   4 +
>   arch/x86/Kconfig                   |   1 +
>   arch/x86/include/asm/tlb.h         |  20 +++
>   arch/x86/kernel/paravirt.c         |   7 +
>   arch/x86/mm/pgtable.c              |  10 +-
>   include/linux/mm.h                 |   1 +
>   include/linux/mm_inline.h          |  11 +-
>   include/linux/mm_types.h           |   4 +-
>   mm/Kconfig                         |  15 ++
>   mm/Makefile                        |   1 +
>   mm/internal.h                      |  19 +++
>   mm/khugepaged.c                    |  45 +++--
>   mm/madvise.c                       |   7 +-
>   mm/memory.c                        | 253 ++++++++++++++++++-----------
>   mm/mmu_gather.c                    |   9 +-
>   mm/pt_reclaim.c                    |  71 ++++++++
>   mm/userfaultfd.c                   |  51 ++++--
>   17 files changed, 397 insertions(+), 132 deletions(-)
>   create mode 100644 mm/pt_reclaim.c
> 

