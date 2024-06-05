Return-Path: <linux-kernel+bounces-202657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B58FD024
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B24B2E487
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B11ABE32;
	Wed,  5 Jun 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEJDXxV+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A91ABCC4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591841; cv=none; b=Lf51x0GdINVR8Mch3jlsb+4QmoFbnerc5HRlvJctHUBfE3ljkGFbEVHmnoyihPC8KiuDuiKPNMHz6JQs2iBORb6+BKx1FR3WsYJ7gYcA4WpyYxOFNT/eZWB6rLZvni5KjDXFcGQhkgGgsXT5Tx0tty+/b3F2L7GmYc0Q3i0Y6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591841; c=relaxed/simple;
	bh=NR91YbkrZD5tgS5UwVgm/IFMBAPLtFT0wIiFBkHadkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8n6wkam07qYn3uWZUEba84SUsiEOThbMgF/N43OEAvnn9hBfGu1FoZ9xQLjEDkBrDKvxud1KnJCVqU3cErcQWAQlwWD77M+aBXbeLGZIIlIPP01bwB03E0om0MXqOe3hC1A94jibtOKHzFkqFvQFhJNOLgwQADZTCscbkBJg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEJDXxV+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717591838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PuxAL789RdBmZPxzYCXZptlU1uC5w4dK0wOLCatII94=;
	b=VEJDXxV+mSTuOyv5JgIyk6qT7IMGvz/JPnxbcccvhYGJGkMIBD0PMBVMz6odOFL2MogFoS
	PyEXFgN4eqMyZH5HmLgRWbImPUgmc35t2zd950mNyxs+1Z5TFL7xEWy4Q4DjRGPUUPi4tT
	ukF3B5+RvTAPxBKc3nUpmrBjdQWVzZQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-WTmNXPY8MTeY6CtEI9oVWg-1; Wed, 05 Jun 2024 08:50:36 -0400
X-MC-Unique: WTmNXPY8MTeY6CtEI9oVWg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35e114d0befso1554580f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717591826; x=1718196626;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PuxAL789RdBmZPxzYCXZptlU1uC5w4dK0wOLCatII94=;
        b=wyGyiUXOSsQXaF2d713DtMCqnk4VHMM05JUCFhx2yDNkH1GpO47OZqMcOHKkrWLW5U
         OIj+VVYZTMrH0HPTlWAApAOkLQ+9lCwfO+1cjiV17mrZ1gg6+8yFigUDK0t0kaMRc8p8
         lpR5LFQZXlSzbGj/uUy+HoAU/9bsMEsqB6/S1ox+C88rVCNpOVTbfh8en7m+mWcEQVPc
         lO0vSvcdVd/6BNubw9WanBEWulObdzNbeGXSZZpHUfVXaUCyvxdTL+tYsUlzAYaYYEdM
         CMlHTRx1nbrlZT8UHlMc+VZuQu8j/yrYb/oP8LrdsXFaFNGUL1CQ2xpEve59pLKlnbcI
         2uLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXMPLv4J0edgTy1PNNf02qOVR+PF0ok9Iz0eWyHcClkC/rWmHgClkFygonEEn093OUTEUWoKynQHWz1L71OYqex2Cebir2FCT+PKja
X-Gm-Message-State: AOJu0YwBUjxAl/rsX90jg9Nnlnvn+GET2NPMmy1HlOXilxXAAZrzJW7b
	JFdyFO7j41ZCNW4lMQYlDt/xbbnWU+lCB8y6AZ2PpPcCqRucQ/88bzsmAWhK4uYw86X6YPx6NTj
	Tq5LjZAN/KFgul3JESOwm3RjLX51qzDCAxrQyX/ofrLCivIgj2vguoHGWVHkYcA==
X-Received: by 2002:a5d:5412:0:b0:34c:ab55:bf1 with SMTP id ffacd0b85a97d-35e84062da5mr1742426f8f.2.1717591826250;
        Wed, 05 Jun 2024 05:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwPy9E70vS6iwYgL0RmNslYOdBi/ET7zW0ZZnceEEMQcsQRFnn/RH8GG2X9Gvswt6jgXkYHw==
X-Received: by 2002:a5d:5412:0:b0:34c:ab55:bf1 with SMTP id ffacd0b85a97d-35e84062da5mr1742410f8f.2.1717591825807;
        Wed, 05 Jun 2024 05:50:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e57474921sm9832558f8f.80.2024.06.05.05.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 05:50:25 -0700 (PDT)
Message-ID: <ede2a2ad-1046-4967-a930-692cfa829c7b@redhat.com>
Date: Wed, 5 Jun 2024 14:50:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] mm/vmscan: avoid split lazyfree THP during
 shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, sj@kernel.org, baolin.wang@linux.alibaba.com,
 maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240521040244.48760-1-ioworker0@gmail.com>
 <20240521040244.48760-4-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240521040244.48760-4-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.24 06:02, Lance Yang wrote:
> When the user no longer requires the pages, they would use
> madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
> typically would not re-write to that memory again.
> 
> During memory reclaim, if we detect that the large folio and its PMD are
> both still marked as clean and there are no unexpected references
> (such as GUP), so we can just discard the memory lazily, improving the
> efficiency of memory reclamation in this case.
> 
> On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
> mem_cgroup_force_empty() results in the following runtimes in seconds
> (shorter is better):
> 
> --------------------------------------------
> |     Old       |      New       |  Change  |
> --------------------------------------------
> |   0.683426    |    0.049197    |  -92.80% |
> --------------------------------------------
> 
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   include/linux/huge_mm.h |  9 +++++
>   mm/huge_memory.c        | 80 +++++++++++++++++++++++++++++++++++++++++
>   mm/rmap.c               | 41 ++++++++++++++-------
>   3 files changed, 117 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 9fcb0b0b6ed1..cfd7ec2b6d0a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
>   
>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>   			   pmd_t *pmd, bool freeze, struct folio *folio);
> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
> +			   pmd_t *pmdp, struct folio *folio);
>   
>   #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>   
> @@ -478,6 +480,13 @@ static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
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
> index 425272c6c50b..4793ffa912ca 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2687,6 +2687,86 @@ static void unmap_folio(struct folio *folio)
>   	try_to_unmap_flush();
>   }
>   
> +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,

Can we move towards folio terminology?

__discard_anon_folio_pmd_locked() or sth like that?

> +				       unsigned long addr, pmd_t *pmdp,
> +				       struct folio *folio)
> +{
> +	VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
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
> +
> +	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd)) {
> +		folio_set_swapbacked(folio);
> +		return false;
> +	}
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
> +	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
> +		folio_set_swapbacked(folio);
> +
> +	if (folio_test_swapbacked(folio) || ref_count != map_count + 1) {
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
> +		return __discard_trans_pmd_locked(vma, addr, pmdp, folio);
> +
> +	return false;
> +}
> +
>   static void remap_page(struct folio *folio, unsigned long nr)
>   {
>   	int i = 0;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 08a93347f283..249d6e305bec 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1630,6 +1630,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   	enum ttu_flags flags = (enum ttu_flags)(long)arg;
>   	unsigned long pfn;
>   	unsigned long hsz = 0;
> +	bool pmd_mapped = false;
>   
>   	/*
>   	 * When racing against e.g. zap_pte_range() on another cpu,
> @@ -1677,18 +1678,26 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			goto walk_done_err;
>   		}
>   
> -		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> -			/*
> -			 * We temporarily have to drop the PTL and start once
> -			 * again from that now-PTE-mapped page table.
> -			 */
> -			split_huge_pmd_locked(vma, range.start, pvmw.pmd, false,
> -					      folio);
> -			pvmw.pmd = NULL;
> -			spin_unlock(pvmw.ptl);
> -			pvmw.ptl = NULL;
> -			flags &= ~TTU_SPLIT_HUGE_PMD;
> -			continue;
> +		if (!pvmw.pte) {
> +			pmd_mapped = true;
> +			if (unmap_huge_pmd_locked(vma, range.start, pvmw.pmd,
> +						  folio))
> +				goto walk_done;
> +
> +			if (flags & TTU_SPLIT_HUGE_PMD) {
> +				/*
> +				 * We temporarily have to drop the PTL and start
> +				 * once again from that now-PTE-mapped page
> +				 * table.
> +				 */
> +				split_huge_pmd_locked(vma, range.start,
> +						      pvmw.pmd, false, folio);
> +				pvmw.pmd = NULL;
> +				spin_unlock(pvmw.ptl);
> +				pvmw.ptl = NULL;
> +				flags &= ~TTU_SPLIT_HUGE_PMD;
> +				continue;
> +			}
>   		}
>   
>   		/* Unexpected PMD-mapped THP? */
> @@ -1816,7 +1825,13 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			 */
>   			if (unlikely(folio_test_swapbacked(folio) !=
>   					folio_test_swapcache(folio))) {
> -				WARN_ON_ONCE(1);
> +				/*
> +				 * unmap_huge_pmd_locked() will unmark a
> +				 * PMD-mapped folio as lazyfree if the folio or
> +				 * its PMD was redirtied.
> +				 */
> +				if (!pmd_mapped)

Isn't that simply "pvmw.pte" ?

Also,

WARN_ON_ONCE(!pmd_mapped);

> +					WARN_ON_ONCE(1);
>   				goto walk_done_err;
>   			}
>   

-- 
Cheers,

David / dhildenb


