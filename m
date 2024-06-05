Return-Path: <linux-kernel+bounces-202632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8804A8FCEF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1248C1F2A001
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12DB1A01C9;
	Wed,  5 Jun 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B15RnFdj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49A1A01BB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591580; cv=none; b=DApCkGkYzk9/UbWMengSO4/inWiHUMtEGv0yFCYfluvEUASycROrUjzfdkwsmssLNvirUQ+f4dL9u8StX+L1UrhRxA1qckgCQxxiOX0hPaECQAmrsiyH30RB/jvtYrq2qOp9cqxa3fKe+mjiLkiWGaEplzLfYI0MkcTA6c3y7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591580; c=relaxed/simple;
	bh=kDUETpSBAWsF9j0EnGxGEOMh3sd+k5taRZdlC2W5Oew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3ZWjzSw2ijqSVs5tvsFIdUDkMmL0CzkBJps0yje5SP4y0ceeuK4L/mX2Rx+dzGVfCZ2elby5ntDhiBYnnkv+r0USVBMWAj///xi+teZxEfFKc3KJYqZ75jfuj68JgUYB2BKCOowmyI5s9PW66EYI28XDRe1bNSawdZiEDKKQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B15RnFdj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717591578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VyHoStZqSfdBy+2Shj9AhCmSSEwdABGvBZ2EWf4zWmk=;
	b=B15RnFdjoUkwVQWmtZlrmPS30NkEcWzpyJhvC1s0WqSMV+YU545DG1ULMVa/Ils9v1ueDR
	hyy3mQ95p2TdeBuB2jViM+bEqldyGhPZF0WHZHup8nEE/vYnBlKnZkVnF17njhkx+l5Vpc
	FJy3O3JoaqCR36aEPO94LbGfW/ASs+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-kfvgHlRdOAivHsPEKJZIBQ-1; Wed, 05 Jun 2024 08:46:15 -0400
X-MC-Unique: kfvgHlRdOAivHsPEKJZIBQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4212a3ddb6bso43711675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717591574; x=1718196374;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VyHoStZqSfdBy+2Shj9AhCmSSEwdABGvBZ2EWf4zWmk=;
        b=OcJEki/BAV6anmUoSyc4lp5nJIaum1XbA6dr12NWQGQIbb59iyHppgRzdZzLOvYWOD
         bEx/J83D8uPF5dnSvIWwkUGiNWCjXMKQEfdqPQdUg5MK2/E0zErpCQ1+pawQkGSljEAH
         Y2iXDrQW1jpDyGfv1lRk/QovjqQv62jvdWwgGEHiWH7Wxy1rMOVlYGP+ry3fJlaevDP/
         2/OwjBCqzqpp6wK3n1U73ku79pUyOi4FDs7ip/9G5P1+naquixWwlQZFkopVwsaDyPJn
         Bf33cbndBinCraFnsE8YdwyJFJwTVHuQbZfYZldWd1gRbO++dz+UllQu+8GCh9wXdiey
         qP5w==
X-Forwarded-Encrypted: i=1; AJvYcCW0zqhNjSM8j8g7C7XGkyVdioEwbLfY85iS2lb1VYBkaYykg+m647fUH/aUu2fatutirbsrzsKcPdLhpYbF1uo6x+0TiskPhMaclL2C
X-Gm-Message-State: AOJu0YwS/LQGPc5HVjO60rU5BDpu5qfy9C0YNvkXa2Sglnz34TWIQ8oJ
	Rx10MpcqB89UZI+qsJBbGb9gWxvbMiYkRImRZm+zA+CTjt/Rv2VJOPe0ZbSj4Z0+2RX25KS0gWQ
	mLdvw0zNyEOP8f8fnl1Kgprwaasz4uccG27GFjHOi4tc4W/wFwSqb8TrwhIkvKA==
X-Received: by 2002:a05:600c:1da7:b0:420:fb99:ed02 with SMTP id 5b1f17b1804b1-421562cff37mr19118565e9.6.1717591574634;
        Wed, 05 Jun 2024 05:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAUUXUZ9zpr3NnCgXBiYoowM25vzGrezs+WUrDR8FtJQdSeRWt8ZUzZYjO15IoEPVTCrrSGQ==
X-Received: by 2002:a05:600c:1da7:b0:420:fb99:ed02 with SMTP id 5b1f17b1804b1-421562cff37mr19118185e9.6.1717591574153;
        Wed, 05 Jun 2024 05:46:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148f66sm22162595e9.32.2024.06.05.05.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 05:46:13 -0700 (PDT)
Message-ID: <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com>
Date: Wed, 5 Jun 2024 14:46:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, sj@kernel.org, baolin.wang@linux.alibaba.com,
 maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240521040244.48760-1-ioworker0@gmail.com>
 <20240521040244.48760-3-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240521040244.48760-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.05.24 06:02, Lance Yang wrote:
> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> folios, start the pagewalk first, then call split_huge_pmd_address() to
> split the folio.
> 
> Since TTU_SPLIT_HUGE_PMD will no longer perform immediately, we might
> encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range during
> the page walk. It’s probably necessary to mlock this THP to prevent it from
> being picked up during page reclaim.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---

[...] again, sorry for the late review.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index ddffa30c79fb..08a93347f283 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   	if (flags & TTU_SYNC)
>   		pvmw.flags = PVMW_SYNC;
>   
> -	if (flags & TTU_SPLIT_HUGE_PMD)
> -		split_huge_pmd_address(vma, address, false, folio);
> -
>   	/*
>   	 * For THP, we have to assume the worse case ie pmd for invalidation.
>   	 * For hugetlb, it could be much worse if we need to do pud
> @@ -1668,20 +1665,35 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   	mmu_notifier_invalidate_range_start(&range);
>   
>   	while (page_vma_mapped_walk(&pvmw)) {
> -		/* Unexpected PMD-mapped THP? */
> -		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> -
>   		/*
>   		 * If the folio is in an mlock()d vma, we must not swap it out.
>   		 */
>   		if (!(flags & TTU_IGNORE_MLOCK) &&
>   		    (vma->vm_flags & VM_LOCKED)) {
>   			/* Restore the mlock which got missed */
> -			if (!folio_test_large(folio))
> +			if (!folio_test_large(folio) ||
> +			    (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
>   				mlock_vma_folio(folio, vma);

Can you elaborate why you think this would be required? If we would have 
performed the  split_huge_pmd_address() beforehand, we would still be 
left with a large folio, no?

>   			goto walk_done_err;
>   		}
>   
> +		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> +			/*
> +			 * We temporarily have to drop the PTL and start once
> +			 * again from that now-PTE-mapped page table.
> +			 */
> +			split_huge_pmd_locked(vma, range.start, pvmw.pmd, false,
> +					      folio);

Using range.start here is a bit weird. Wouldn't this be pvmw.address? 
[did not check]

> +			pvmw.pmd = NULL;
> +			spin_unlock(pvmw.ptl);
> +			pvmw.ptl = NULL;


Would we want a

page_vma_mapped_walk_restart() that is exactly for that purpose?

> +			flags &= ~TTU_SPLIT_HUGE_PMD;
> +			continue;
> +		}
> +
> +		/* Unexpected PMD-mapped THP? */
> +		VM_BUG_ON_FOLIO(!pvmw.pte, folio);

-- 
Cheers,

David / dhildenb


