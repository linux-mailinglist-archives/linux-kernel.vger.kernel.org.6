Return-Path: <linux-kernel+bounces-378532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6113A9AD1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C1B288985
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4CC20ADD2;
	Wed, 23 Oct 2024 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izuM5Gn8"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF420A5CE;
	Wed, 23 Oct 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702263; cv=none; b=VATNBNHxWaZXkEJ/bcnDkjoT+QG9g174AxVcjxCXENKyaYoKrmjaUwG54LdzudKVwk+Xx+akuAuxCFPJaqliTL90m5g/9vDoD0Q6jj0geZ+1yeGttglEQ70/DxxLm+w74iJv0eugSCi3hdXyAMdqoBR4oqI1WbYxNDpJFCzFowQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702263; c=relaxed/simple;
	bh=o8smPrm0k+K1ynji2qeUJzsd+NRTrZLYLUoIFJt8Kso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nh5QvRbc6uJFNNjQ7DJpP/Hkhyg5IiH56ZkrjN3rSP5dJsCEgu612dLKgeDG0VjiTZpw+7BBEovgjUPsWpN7ukiOS+aSo7fiQfPUT7bx94W/F6HqjLKGNaN+hCVSHDUbC+Scw+ks6amUZfVrhIcxV/m6/sDARXG+US+1JdCB6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izuM5Gn8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso942162366b.2;
        Wed, 23 Oct 2024 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729702260; x=1730307060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxfn5b79k6me2s/9AvmRP7791ZkTsUdHbmXJ22J7PRo=;
        b=izuM5Gn8aarw7mToPw7O9ZO1runrsP1cGLxSzFeUN3XpCfkMgG3ZvLw8Y9it272mhr
         zNviDEMXPVRqumU0NOdl7OjOWWyIzEGc80G5JIqfSSBm1E1piaCefMvoF2burd4fnsyA
         ixHseZaHxrDZ1HELHBc3bWEt5UM0HLpwU43tYpouHJF+ioqTks3VfPH+rr7tf9am3t94
         8HlLJsd+1AOSv/OaaLynf6sBGSpZgELid6pHBOo0DtWxFWK8kKZMiegqn3nOO5JQXvou
         RLGDINKCDudRM5xXFwxIb9bPUUN/PRd8lN7anh4O4cAzMp8Y8ikkGvJ924yht7qOTGG2
         EdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702260; x=1730307060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxfn5b79k6me2s/9AvmRP7791ZkTsUdHbmXJ22J7PRo=;
        b=memoxK+aP9luXgBNwQRiaZwdnrSsGYkuMaXoDPbNpoLbw2k/KKcSb69lrARKqcmlqK
         H0U+R4u/esPeS/Yng1RSehjguU9QAsopx6CwrvYgqPfadYFcZ24suTuGujQVqJfVjK2U
         SnZsP5JzYVvEASZFEOj517M690jvVttAOQ6QXyloIjyvKOjFvGVJSyerJAMhHB8eu5oz
         /7hfrBuSUMy3zJFFBAzg/kxCqtXNuw8KHoiGnJAMETYjLYpN5noC5KRbPz9WbTdnKIhh
         FHhmXU3rNd/vmxjDl7DGfYMDvuPY2H8mbGGrI5VsCFm1hVou49WtsBn1nTjONzzYApYS
         754w==
X-Forwarded-Encrypted: i=1; AJvYcCXblIKg/GpVrY9tRsGLicpexi4WYR+Z4IxhVDg4cUMSNco7NdoxuPDT059S0unFELs89nRE56VA8BvdinwE@vger.kernel.org, AJvYcCXw/Sx2LzMFk9dKSaPOQgamBI304r6nOAPnfs2LUhQoiZxH6KHJSkC5EbL4jm6HrzJjCZUQSj/BxL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLyBIfOo2qtlj/er/ZjF8tKv3mReOP+eWAQdFmaAVk80Ssl1Y/
	S9HBIN+jbdj7zSaVdVSkLeCrpWrXs9LXr+5YWJdMrPc14GVmyd4M
X-Google-Smtp-Source: AGHT+IEhrLLD5HvyIKyLI5g3e1IdyncoU1fUcI0auVC3YW7OsZscRMICc8NmT8AQ5o2gGWB19MmZHQ==
X-Received: by 2002:a17:906:7310:b0:a9a:6bd:95dc with SMTP id a640c23a62f3a-a9abf92f667mr312077066b.46.1729702259873;
        Wed, 23 Oct 2024 09:50:59 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6333sm506568266b.10.2024.10.23.09.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 09:50:59 -0700 (PDT)
Message-ID: <27d04537-ebda-4462-b008-878390d4b211@gmail.com>
Date: Wed, 23 Oct 2024 17:50:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
To: Zi Yan <ziy@nvidia.com>, yuzhao@google.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 david@redhat.com, npache@redhat.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, ryncsn@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Shuang Zhai <zhais@google.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
 <20240830100438.3623486-3-usamaarif642@gmail.com>
 <4B7449C4-D2B8-4285-973C-97178C09CE7E@nvidia.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <4B7449C4-D2B8-4285-973C-97178C09CE7E@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/10/2024 17:21, Zi Yan wrote:
> On 30 Aug 2024, at 6:03, Usama Arif wrote:
> 
>> From: Yu Zhao <yuzhao@google.com>
>>
>> Here being unused means containing only zeros and inaccessible to
>> userspace. When splitting an isolated thp under reclaim or migration,
>> the unused subpages can be mapped to the shared zeropage, hence saving
>> memory. This is particularly helpful when the internal
>> fragmentation of a thp is high, i.e. it has many untouched subpages.
>>
>> This is also a prerequisite for THP low utilization shrinker which will
>> be introduced in later patches, where underutilized THPs are split, and
>> the zero-filled pages are freed saving memory.
>>
>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>> Tested-by: Shuang Zhai <zhais@google.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  include/linux/rmap.h |  7 ++++-
>>  mm/huge_memory.c     |  8 ++---
>>  mm/migrate.c         | 72 ++++++++++++++++++++++++++++++++++++++------
>>  mm/migrate_device.c  |  4 +--
>>  4 files changed, 75 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 91b5935e8485..d5e93e44322e 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -745,7 +745,12 @@ int folio_mkclean(struct folio *);
>>  int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
>>  		      struct vm_area_struct *vma);
>>
>> -void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
>> +enum rmp_flags {
>> +	RMP_LOCKED		= 1 << 0,
>> +	RMP_USE_SHARED_ZEROPAGE	= 1 << 1,
>> +};
>> +
>> +void remove_migration_ptes(struct folio *src, struct folio *dst, int flags);
>>
>>  /*
>>   * rmap_walk_control: To control rmap traversing for specific needs
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0c48806ccb9a..af60684e7c70 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3020,7 +3020,7 @@ bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
>>  	return false;
>>  }
>>
>> -static void remap_page(struct folio *folio, unsigned long nr)
>> +static void remap_page(struct folio *folio, unsigned long nr, int flags)
>>  {
>>  	int i = 0;
>>
>> @@ -3028,7 +3028,7 @@ static void remap_page(struct folio *folio, unsigned long nr)
>>  	if (!folio_test_anon(folio))
>>  		return;
>>  	for (;;) {
>> -		remove_migration_ptes(folio, folio, true);
>> +		remove_migration_ptes(folio, folio, RMP_LOCKED | flags);
>>  		i += folio_nr_pages(folio);
>>  		if (i >= nr)
>>  			break;
>> @@ -3240,7 +3240,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>
>>  	if (nr_dropped)
>>  		shmem_uncharge(folio->mapping->host, nr_dropped);
>> -	remap_page(folio, nr);
>> +	remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : 0);
>>
>>  	/*
>>  	 * set page to its compound_head when split to non order-0 pages, so
>> @@ -3542,7 +3542,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>  		if (mapping)
>>  			xas_unlock(&xas);
>>  		local_irq_enable();
>> -		remap_page(folio, folio_nr_pages(folio));
>> +		remap_page(folio, folio_nr_pages(folio), 0);
>>  		ret = -EAGAIN;
>>  	}
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 6f9c62c746be..d039863e014b 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -204,13 +204,57 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
>>  	return true;
>>  }
>>
>> +static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>> +					  struct folio *folio,
>> +					  unsigned long idx)
>> +{
>> +	struct page *page = folio_page(folio, idx);
>> +	bool contains_data;
>> +	pte_t newpte;
>> +	void *addr;
>> +
>> +	VM_BUG_ON_PAGE(PageCompound(page), page);
> 
> This should be:
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e950fd62607f..7ffdbe078aa7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -206,7 +206,8 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>         pte_t newpte;
>         void *addr;
> 
> -       VM_BUG_ON_PAGE(PageCompound(page), page);
> +       if (PageCompound(page))
> +               return false;
>         VM_BUG_ON_PAGE(!PageAnon(page), page);
>         VM_BUG_ON_PAGE(!PageLocked(page), page);
>         VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
> 
> Otherwise, splitting anonymous large folios to non order-0 ones just
> triggers this BUG_ON.
> 

That makes sense, would you like to send the fix?

Adding Yu Zhao to "To" incase he has any objections.

Thanks,
Usama

>> +	VM_BUG_ON_PAGE(!PageAnon(page), page);
>> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
>> +	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
>> +
>> +	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
>> +	    mm_forbids_zeropage(pvmw->vma->vm_mm))
>> +		return false;
>> +
>> +	/*
>> +	 * The pmd entry mapping the old thp was flushed and the pte mapping
>> +	 * this subpage has been non present. If the subpage is only zero-filled
>> +	 * then map it to the shared zeropage.
>> +	 */
>> +	addr = kmap_local_page(page);
>> +	contains_data = memchr_inv(addr, 0, PAGE_SIZE);
>> +	kunmap_local(addr);
>> +
>> +	if (contains_data)
>> +		return false;
>> +
>> +	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>> +					pvmw->vma->vm_page_prot));
>> +	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>> +
>> +	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
>> +	return true;
>> +}
>> +
>> +struct rmap_walk_arg {
>> +	struct folio *folio;
>> +	bool map_unused_to_zeropage;
>> +};
>> +
>>  /*
>>   * Restore a potential migration pte to a working pte entry
>>   */
>>  static bool remove_migration_pte(struct folio *folio,
>> -		struct vm_area_struct *vma, unsigned long addr, void *old)
>> +		struct vm_area_struct *vma, unsigned long addr, void *arg)
>>  {
>> -	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
>> +	struct rmap_walk_arg *rmap_walk_arg = arg;
>> +	DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->folio, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
>>
>>  	while (page_vma_mapped_walk(&pvmw)) {
>>  		rmap_t rmap_flags = RMAP_NONE;
>> @@ -234,6 +278,9 @@ static bool remove_migration_pte(struct folio *folio,
>>  			continue;
>>  		}
>>  #endif
>> +		if (rmap_walk_arg->map_unused_to_zeropage &&
>> +		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
>> +			continue;
>>
>>  		folio_get(folio);
>>  		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
>> @@ -312,14 +359,21 @@ static bool remove_migration_pte(struct folio *folio,
>>   * Get rid of all migration entries and replace them by
>>   * references to the indicated page.
>>   */
>> -void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
>> +void remove_migration_ptes(struct folio *src, struct folio *dst, int flags)
>>  {
>> +	struct rmap_walk_arg rmap_walk_arg = {
>> +		.folio = src,
>> +		.map_unused_to_zeropage = flags & RMP_USE_SHARED_ZEROPAGE,
>> +	};
>> +
>>  	struct rmap_walk_control rwc = {
>>  		.rmap_one = remove_migration_pte,
>> -		.arg = src,
>> +		.arg = &rmap_walk_arg,
>>  	};
>>
>> -	if (locked)
>> +	VM_BUG_ON_FOLIO((flags & RMP_USE_SHARED_ZEROPAGE) && (src != dst), src);
>> +
>> +	if (flags & RMP_LOCKED)
>>  		rmap_walk_locked(dst, &rwc);
>>  	else
>>  		rmap_walk(dst, &rwc);
>> @@ -934,7 +988,7 @@ static int writeout(struct address_space *mapping, struct folio *folio)
>>  	 * At this point we know that the migration attempt cannot
>>  	 * be successful.
>>  	 */
>> -	remove_migration_ptes(folio, folio, false);
>> +	remove_migration_ptes(folio, folio, 0);
>>
>>  	rc = mapping->a_ops->writepage(&folio->page, &wbc);
>>
>> @@ -1098,7 +1152,7 @@ static void migrate_folio_undo_src(struct folio *src,
>>  				   struct list_head *ret)
>>  {
>>  	if (page_was_mapped)
>> -		remove_migration_ptes(src, src, false);
>> +		remove_migration_ptes(src, src, 0);
>>  	/* Drop an anon_vma reference if we took one */
>>  	if (anon_vma)
>>  		put_anon_vma(anon_vma);
>> @@ -1336,7 +1390,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>>  		lru_add_drain();
>>
>>  	if (old_page_state & PAGE_WAS_MAPPED)
>> -		remove_migration_ptes(src, dst, false);
>> +		remove_migration_ptes(src, dst, 0);
>>
>>  out_unlock_both:
>>  	folio_unlock(dst);
>> @@ -1474,7 +1528,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>>
>>  	if (page_was_mapped)
>>  		remove_migration_ptes(src,
>> -			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
>> +			rc == MIGRATEPAGE_SUCCESS ? dst : src, 0);
>>
>>  unlock_put_anon:
>>  	folio_unlock(dst);
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 8d687de88a03..9cf26592ac93 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -424,7 +424,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
>>  			continue;
>>
>>  		folio = page_folio(page);
>> -		remove_migration_ptes(folio, folio, false);
>> +		remove_migration_ptes(folio, folio, 0);
>>
>>  		src_pfns[i] = 0;
>>  		folio_unlock(folio);
>> @@ -840,7 +840,7 @@ void migrate_device_finalize(unsigned long *src_pfns,
>>  			dst = src;
>>  		}
>>
>> -		remove_migration_ptes(src, dst, false);
>> +		remove_migration_ptes(src, dst, 0);
>>  		folio_unlock(src);
>>
>>  		if (folio_is_zone_device(src))
>> -- 
>> 2.43.5
> 
> Best Regards,
> Yan, Zi


