Return-Path: <linux-kernel+bounces-514588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE8DA358EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40091188BFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492072236F2;
	Fri, 14 Feb 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dwd4PlcG"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED661F8908
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521919; cv=none; b=FGhwkapcsJAaL51+5+Sz3ACAumFsUaoAj1gyNX70bbEJ9uKOj9NMTmRxkU/PqMnvYT0rM4hBf0z7nk3OmzkJU6JlFfN0s1w94N1VaJV62x89YU0W6YcVxBU3kzk3KY76e9a3CNMGtq5Li+WuyDmdF82etVklyd3Z7aI7n6yqBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521919; c=relaxed/simple;
	bh=TyQKCiopUg4s2YXlcD6GcdMUrpTrdyRJT00Jtnzxwek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lp3zdqAnBF5cjRdmLnnVlhvaKPb9sL473I9SeHqHwqITRpr7dorV1WeyrMAkmd+xJHa4KsPs2LcWAWYzuBRxFLwDrzUyQACaUR1R0zSvQjMK5n+t1+T2V6dAjUQr7I4MgXalIqWQtz6ZwRcO2CD6zEW3bXewt/QSV9B035qIYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dwd4PlcG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c2a87378so25345995ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739521915; x=1740126715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1N9/dh1gKenUxv/OYzR+uI9tVKa+QsTNdZz3DDWPEPs=;
        b=Dwd4PlcGdrcxorHgafvTU63F3Vk+DNsfQHe8lmcTisVqArbyMUMZbYiXieQgz5KOon
         nHlAZDty4u+HVC1B1n8jpJO2c5HLk7vql7pBb7Iq3Kj0lx3hgDf08Hw78/g4tGAjjasT
         z7KQLmEbjXr3ywTVXlQwbx7XsmB/tchHzl7FaBEJZAAaoE1fgbn71kgPJmis6dqGQjwk
         SxEMtZaIxzaVIdCRxN8S1F3twswOjAtGVHF507sj6VIY1LAr3DT8OwbyOOw/cWEvibxS
         XfCvu1yLnPxQV46/VwQ9UzbOtZEpRRR+9ocKRUL0WjkxPSaJhJDtHCsOahVtz+k/z1u1
         oB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739521915; x=1740126715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1N9/dh1gKenUxv/OYzR+uI9tVKa+QsTNdZz3DDWPEPs=;
        b=RrkgQLeubTzZgDEApf6UaLhKqddc12v8kYBf0lw+anRLB5cSF91JVX3QXWbeFbh64n
         Ge8FgR3592jjBj5d4eiPmFNhjOqBsgWXwFsWNzTan3VWu0hcXyo9j7nsoFZM5wqn3l3S
         WHvU8vu7UrZBVBSR9Guh4n8TvK+NzXjJSbQeKFJAwzPp4724MO/N5AFFk/V10aaOP2wx
         eq88wZn9XzZWpe6SCN72M+dO6GcSKqoLm24ajKF1WKwaBFObp3kJOaXwouyFny26dJoL
         YH7ppeJPK33r0llHov6uX7Uxog0Z7bZT+xqtSTs9Tif8fXd2jCCgqQMNDY8oe/wk7I9S
         wuCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7k/rygHXLNS10EwCSTV8hWksG+NpZL7jyVQR8mVLZlVBMhjMtND0dysd3M0BryKwnl2Dl7nI1xEdrp4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5OE+s36JEsfuTOm40dDQz6+3fu0HBKELxDgaeXs6LeqY+U/mJ
	WtaxbZHsmC8y5L8BedTBOFKbpkFp5ZEBs4eyMLgwk3zdLJmbf55puorNh8WnYyg=
X-Gm-Gg: ASbGnctAU/p3nZRb+DyLRaSU+f1e56QjaQvsm6eT2k1kUt/GroAoBW04q4egp8CLhSc
	UP4gVyZXkOsIDU6qStXY7BrirJypEcvX9IJlTrvx1fxT5gQBxDTAjNrivnatXN1Nw+SFpRDMc88
	LvDj9KirUqE08MEV9UZWd8dKsgPUxqiDBnDndzOyKKsFDARCQeC5QuFPE/gPXYw+BukpWyNP8Xg
	OaM6EkNroMMXBkVCNwy9CL92OKdDNdyn3EyNKyqUvXA64oS06ZPLgA+Y6xorMQ2wtpHa5DQhQtv
	4wWaNLM7e+lLK7z2iiQzfsekfI1yVGPSAF9NhoIn
X-Google-Smtp-Source: AGHT+IFish6SuWBlkvc7bmWP37Y6+7Yh+XXEUSCWODRR3jA2THJeF+j5+UDYBR8TSK0wMeZq/qTgUg==
X-Received: by 2002:a17:902:ec83:b0:220:ce37:e31f with SMTP id d9443c01a7336-220ce37e53fmr85586195ad.17.1739521915507;
        Fri, 14 Feb 2025 00:31:55 -0800 (PST)
Received: from [10.84.150.121] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9757365sm4588023a91.0.2025.02.14.00.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 00:31:55 -0800 (PST)
Message-ID: <c2ae16f5-9ce7-4616-be76-c777d3fa16c6@bytedance.com>
Date: Fri, 14 Feb 2025 16:31:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: pgtable: fix NULL pointer dereference issue
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: linux@armlinux.org.uk, ezra@easyb.ch, hughd@google.com,
 ryan.roberts@arm.com, akpm@linux-foundation.org, muchun.song@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Ezra Buehler
 <ezra.buehler@husqvarnagroup.com>, stable@vger.kernel.org
References: <20250214030349.45524-1-zhengqi.arch@bytedance.com>
 <f15bd993-20de-41ae-8631-9ce557cd9d20@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <f15bd993-20de-41ae-8631-9ce557cd9d20@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/14 16:11, David Hildenbrand wrote:
> On 14.02.25 04:03, Qi Zheng wrote:
>> When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
>> parameter is NULL, which will cause a NULL pointer dereference issue in
>> adjust_pte():
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 
>> 00000030 when read
>> Hardware name: Atmel AT91SAM9
>> PC is at update_mmu_cache_range+0x1e0/0x278
>> LR is at pte_offset_map_rw_nolock+0x18/0x2c
>> Call trace:
>>   update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
>>   remove_migration_pte from rmap_walk_file+0xcc/0x130
>>   rmap_walk_file from remove_migration_ptes+0x90/0xa4
>>   remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
>>   migrate_pages_batch from migrate_pages+0x188/0x488
>>   migrate_pages from compact_zone+0x56c/0x954
>>   compact_zone from compact_node+0x90/0xf0
>>   compact_node from kcompactd+0x1d4/0x204
>>   kcompactd from kthread+0x120/0x12c
>>   kthread from ret_from_fork+0x14/0x38
>> Exception stack(0xc0d8bfb0 to 0xc0d8bff8)
>>
>> To fix it, do not rely on whether 'ptl' is equal to decide whether to 
>> hold
>> the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
>> enabled. In addition, if two vmas map to the same PTE page, there is no
>> need to hold the pte lock again, otherwise a deadlock will occur. Just 
>> add
>> the need_lock parameter to let adjust_pte() know this information.
>>
>> Reported-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
>> Closes: 
>> https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFTzVVEQ1BO0cLkHEQ@mail.gmail.com/
>> Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> Changes in v2:
>>   - change Ezra's email address (Ezra Buehler)
>>   - some cleanups (David Hildenbrand)
>>
>>   arch/arm/mm/fault-armv.c | 38 ++++++++++++++++++++++++++------------
>>   1 file changed, 26 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
>> index 2bec87c3327d2..ea4c4e15f0d31 100644
>> --- a/arch/arm/mm/fault-armv.c
>> +++ b/arch/arm/mm/fault-armv.c
>> @@ -62,7 +62,7 @@ static int do_adjust_pte(struct vm_area_struct *vma, 
>> unsigned long address,
>>   }
>>   static int adjust_pte(struct vm_area_struct *vma, unsigned long 
>> address,
>> -              unsigned long pfn, struct vm_fault *vmf)
>> +              unsigned long pfn, bool need_lock)
>>   {
>>       spinlock_t *ptl;
>>       pgd_t *pgd;
>> @@ -99,12 +99,11 @@ static int adjust_pte(struct vm_area_struct *vma, 
>> unsigned long address,
>>       if (!pte)
>>           return 0;
>> -    /*
>> -     * If we are using split PTE locks, then we need to take the page
>> -     * lock here.  Otherwise we are using shared mm->page_table_lock
>> -     * which is already locked, thus cannot take it.
>> -     */
>> -    if (ptl != vmf->ptl) {
>> +    if (need_lock) {
>> +        /*
>> +         * Use nested version here to indicate that we are already
>> +         * holding one similar spinlock.
>> +         */
>>           spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>           if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
>>               pte_unmap_unlock(pte, ptl);
>> @@ -114,7 +113,7 @@ static int adjust_pte(struct vm_area_struct *vma, 
>> unsigned long address,
>>       ret = do_adjust_pte(vma, address, pfn, pte);
>> -    if (ptl != vmf->ptl)
>> +    if (need_lock)
>>           spin_unlock(ptl);
>>       pte_unmap(pte);
>> @@ -123,16 +122,18 @@ static int adjust_pte(struct vm_area_struct 
>> *vma, unsigned long address,
>>   static void
>>   make_coherent(struct address_space *mapping, struct vm_area_struct 
>> *vma,
>> -          unsigned long addr, pte_t *ptep, unsigned long pfn,
>> -          struct vm_fault *vmf)
>> +          unsigned long addr, pte_t *ptep, unsigned long pfn)
>>   {
>>       struct mm_struct *mm = vma->vm_mm;
>>       struct vm_area_struct *mpnt;
>>       unsigned long offset;
>> +    unsigned long pmd_start_addr, pmd_end_addr;
> 
> Nit: reverse christmas tree would make us put this line at the very top.
> 
> Maybe do the initialization directly:
> 
> const unsigned long pmd_start_addr = ALIGN_DOWN(addr, PMD_SIZE);
> const unsigned long pmd_end_addr = pmd_start_addr + PMD_SIZE;

Agree, will do.

> 
>>       pgoff_t pgoff;
>>       int aliases = 0;
>>       pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
>> +    pmd_start_addr = ALIGN_DOWN(addr, PMD_SIZE);
>> +    pmd_end_addr = pmd_start_addr + PMD_SIZE;
>>       /*
>>        * If we have any shared mappings that are in the same mm
>> @@ -141,6 +142,14 @@ make_coherent(struct address_space *mapping, 
>> struct vm_area_struct *vma,
>>        */
>>       flush_dcache_mmap_lock(mapping);
>>       vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
>> +        /*
>> +         * If we are using split PTE locks, then we need to take the pte
>> +         * lock. Otherwise we are using shared mm->page_table_lock which
>> +         * is already locked, thus cannot take it.
>> +         */
>> +        bool need_lock = IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS);
>> +        unsigned long mpnt_addr;
>> +
>>           /*
>>            * If this VMA is not in our MM, we can ignore it.
>>            * Note that we intentionally mask out the VMA
>> @@ -151,7 +160,12 @@ make_coherent(struct address_space *mapping, 
>> struct vm_area_struct *vma,
>>           if (!(mpnt->vm_flags & VM_MAYSHARE))
>>               continue;
>>           offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
>> -        aliases += adjust_pte(mpnt, mpnt->vm_start + offset, pfn, vmf);
>> +        mpnt_addr = mpnt->vm_start + offset;
>> +
>> +        /* Avoid deadlocks by not grabbing the same PTE lock again. */
>> +        if (mpnt_addr >= pmd_start_addr && mpnt_addr < pmd_end_addr)
>> +            need_lock = false;
>> +        aliases += adjust_pte(mpnt, mpnt_addr, pfn, need_lock);
>>       }
>>       flush_dcache_mmap_unlock(mapping);
>>       if (aliases)
>> @@ -194,7 +208,7 @@ void update_mmu_cache_range(struct vm_fault *vmf, 
>> struct vm_area_struct *vma,
>>           __flush_dcache_folio(mapping, folio);
>>       if (mapping) {
>>           if (cache_is_vivt())
>> -            make_coherent(mapping, vma, addr, ptep, pfn, vmf);
>> +            make_coherent(mapping, vma, addr, ptep, pfn);
>>           else if (vma->vm_flags & VM_EXEC)
>>               __flush_icache_all();
>>       }
> 
> 
> Apart from that LGTM. Hoping it will work :)

+1

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

> 

