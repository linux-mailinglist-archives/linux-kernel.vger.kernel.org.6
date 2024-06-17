Return-Path: <linux-kernel+bounces-218080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6167790B90D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEF31C23C72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A819883C;
	Mon, 17 Jun 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaooIooy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF6B197A82
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647490; cv=none; b=WJnelV2Xg19Zlcxr9yCAncb98M/YM9/uahRrt3NqwPcoRl5j857BQndKSJM+m7e5ZAtycpT5amvXYyTGW8DJQ2NKjyiz3KlaKCnkX9G28ckPKYMf8lVU0QaGVmQDw+KT7Y5d8v1jSImlUrKcqOgFt+YZ3kJOtBwKJEin2IY2nos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647490; c=relaxed/simple;
	bh=5/JB+OS6WRWQzWyboiPV25nWCCwjVovwoC7BWreutEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oh3wsIXyirUVzerYyL9a8ZsUQhnb4MDX/MABNbuKVHd24axa1Ha9994UYy14v1j4e2m1T5etL3kLz2RVPPDGvd+z6CxWwqVjG16dyyT9/AcQiu7LCG6sY4rpz5J7qBLeaTKRjDF1siJnhugLBL6lmemeKnWte+W7eilMh8f34js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AaooIooy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718647487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jY3Xb5s8rFz1UDo3bTNwBZ7TIGoZf5MeznzB06zzjNQ=;
	b=AaooIooyPbNPBTsoXrp1DKoaiMo1kuW7KeYJbbKpwAlu5Vto9JBDoHaI9K6DOsIaen0Hvp
	8NMvX0RsnaBClWsxglW1NlkuKTo2WQdFfhax5H/YJu+457fvOxu6c0ZB/b2RhiFcZxrlRZ
	H5Uas4QsWjHoGaut8870Ga9v1HhrzFs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-f_QQD_DSPq2bOu4jY_fwIw-1; Mon, 17 Jun 2024 14:04:46 -0400
X-MC-Unique: f_QQD_DSPq2bOu4jY_fwIw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1f358e59so2387601f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647485; x=1719252285;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jY3Xb5s8rFz1UDo3bTNwBZ7TIGoZf5MeznzB06zzjNQ=;
        b=EhqgAuuUH9tPr474xncz452Lser5SJ4Fi8vQZ7rJmiTujEo0FW3rnJeLjhGb0inQuS
         1dcoXFEGwa34aoNOgaFSKPx7qOJ075tRohtZ4FdDj0Iv4BuI9nkw6qajHG/Xg+ttmMYa
         XiG3gT0S/tJxrzixU7JgEHEapolOYA6BWm2y/3cYfmWjzDDjPaFOgPREe6aWKjlVY88v
         2VAfQab7LEPRuIDkdf0w4kUqUNERbeL9Koqif/WgAOPnnnf/SOFLh7f5YK5Oj88h5jgL
         r6StCoKEtfn0QgaWnuC2ypiKYRwzEbHNjsZ+GgLy6YwSJZiuMmrqTWOGPg6j41waBaS+
         CKfg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Tm3Y45LLKWFTfnld8Xm9zAA4v0iqQquot+UYDzhbrfK/9KftMUMH2UG7PBYiH+OhJCwAV/oj36C2grk1KOnslW1DVuoxmIoTPVFo
X-Gm-Message-State: AOJu0YxgTWVZxnPxqQx+3Wr57z6ZaulS3tvKPb5MfQ42gJOgiy8YlWM5
	yaGHFwpp+6gug85CUX/EIlv90I5TQ7mr6IjsMLMLbibEusCyLgQsrbR0g3enVhapKIMWDf9QRF9
	eswNyYIvvnwpkWoutJZZWUPMYTJCC0oxVIT838UFLKfkf9F+aeZ3NHRXxxXxOpw==
X-Received: by 2002:adf:facd:0:b0:360:d15f:e650 with SMTP id ffacd0b85a97d-360d15fe6c4mr113525f8f.0.1718647485165;
        Mon, 17 Jun 2024 11:04:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFnzyM9g4wwMJYzoEtrpD1HPxSPOKwCd5HlC0jDAAy+dAr4o5+IvQO2i2okK8Ry5UcEbTgkA==
X-Received: by 2002:adf:facd:0:b0:360:d15f:e650 with SMTP id ffacd0b85a97d-360d15fe6c4mr113490f8f.0.1718647484667;
        Mon, 17 Jun 2024 11:04:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:2200:95d8:cbf4:fffd:7f81? (p200300cbc740220095d8cbf4fffd7f81.dip0.t-ipconnect.de. [2003:cb:c740:2200:95d8:cbf4:fffd:7f81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3609aa60a59sm1739171f8f.84.2024.06.17.11.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 11:04:44 -0700 (PDT)
Message-ID: <e7c0aff1-b690-4926-9a34-4e32c9f3faaa@redhat.com>
Date: Mon, 17 Jun 2024 20:04:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] mm/vmscan: avoid split lazyfree THP during
 shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, sj@kernel.org, baolin.wang@linux.alibaba.com,
 maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240614015138.31461-1-ioworker0@gmail.com>
 <20240614015138.31461-4-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240614015138.31461-4-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for taking so long to review ... getting there. Mostly nits.

> @@ -497,6 +499,13 @@ static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
>   					 unsigned long address, pmd_t *pmd,
>   					 bool freeze, struct folio *folio) {}
>   
> +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
> +					 unsigned long addr, pmd_t *pmdp,
> +					 struct folio *folio)
> +{
> +	return false;
> +}
> +
>   #define split_huge_pud(__vma, __pmd, __address)	\
>   	do { } while (0)
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e766d3f3a302..425374ae06ed 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2688,6 +2688,82 @@ static void unmap_folio(struct folio *folio)
>   	try_to_unmap_flush();
>   }
>   
> +static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
> +					    unsigned long addr, pmd_t *pmdp,
> +					    struct folio *folio)
> +{
> +	VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);

I would drop these (that's exactly what the single caller checks). In 
any case don't place them above the variable declaration ;)

> +
> +	struct mm_struct *mm = vma->vm_mm;
> +	int ref_count, map_count;
> +	pmd_t orig_pmd = *pmdp;
> +	struct page *page;
> +
> +	if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
> +		return false;
> +
> +	page = pmd_page(orig_pmd);
> +	if (unlikely(page_folio(page) != folio))
> +		return false;

I'm curious, how could that happen? And how could it happen that we have 
!pmd_trans_huge() ? Didn't rmap walking code make sure that this PMD 
maps the folio already, and we are holding the PTL?

> +
> +	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
> +		return false;
> +
> +	orig_pmd = pmdp_huge_clear_flush(vma, addr, pmdp);
> +
> +	/*
> +	 * Syncing against concurrent GUP-fast:
> +	 * - clear PMD; barrier; read refcount
> +	 * - inc refcount; barrier; read PMD
> +	 */
> +	smp_mb();
> +
> +	ref_count = folio_ref_count(folio);
> +	map_count = folio_mapcount(folio);
> +
> +	/*
> +	 * Order reads for folio refcount and dirty flag
> +	 * (see comments in __remove_mapping()).
> +	 */
> +	smp_rmb();
> +
> +	/*
> +	 * If the folio or its PMD is redirtied at this point, or if there
> +	 * are unexpected references, we will give up to discard this folio
> +	 * and remap it.
> +	 *
> +	 * The only folio refs must be one from isolation plus the rmap(s).
> +	 */
> +	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd) ||
> +	    ref_count != map_count + 1) {
> +		set_pmd_at(mm, addr, pmdp, orig_pmd);
> +		return false;
> +	}
> +
> +	folio_remove_rmap_pmd(folio, page, vma);
> +	zap_deposited_table(mm, pmdp);
> +	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> +	if (vma->vm_flags & VM_LOCKED)
> +		mlock_drain_local();
> +	folio_put(folio);
> +
> +	return true;
> +}
> +
> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
> +			   pmd_t *pmdp, struct folio *folio)
> +{
> +	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> +	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> +	VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
> +
> +	if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> +		return __discard_anon_folio_pmd_locked(vma, addr, pmdp, folio);
> +
> +	return false;
> +}
> +
>   static void remap_page(struct folio *folio, unsigned long nr)
>   {
>   	int i = 0;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index dacf24bc82f0..7d97806f74cd 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1678,16 +1678,23 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			goto walk_abort;
>   		}
>   
> -		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> -			/*
> -			 * We temporarily have to drop the PTL and start once
> -			 * again from that now-PTE-mapped page table.
> -			 */
> -			split_huge_pmd_locked(vma, pvmw.address, pvmw.pmd,
> -					      false, folio);
> -			flags &= ~TTU_SPLIT_HUGE_PMD;
> -			page_vma_mapped_walk_restart(&pvmw);
> -			continue;
> +		if (!pvmw.pte) {
> +			if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd,
> +						  folio))
> +				goto walk_done;
> +
> +			if (flags & TTU_SPLIT_HUGE_PMD) {
> +				/*
> +				 * We temporarily have to drop the PTL and start
> +				 * once again from that now-PTE-mapped page
> +				 * table.

Nit: it's not a PTE-mapped page table.

Maybe

"... restart so we can process the PTE-mapped THP."



>   		}
>   
>   		/* Unexpected PMD-mapped THP? */

Nothing else jumped at me :)

-- 
Cheers,

David / dhildenb


