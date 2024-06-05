Return-Path: <linux-kernel+bounces-202775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBA8FD0EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F83B23629
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED81A291;
	Wed,  5 Jun 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="appRF2fc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9033F23D7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597715; cv=none; b=T4OFZVKxA3lVdbLnTZ2uac5JwYSmYOdbpg4ePkF4zkEGPAJhh8n1BwvA3oZJDqL5vYzq/WZ329V/A1aTM8FncNuZEIqixAXFDJstOmSxKo+gMTfy7A5aOuMH3NTqU96g8rdNsyWKBrRwQnGQsq/ypmvoBDYXVJDQcTnQmybiY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597715; c=relaxed/simple;
	bh=EaZvYQvVZkBz1AWXg8gJrDVB+l8duL3OTHuUpo+PzCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/ZmTdyeuC0MlXhwkBUaXW/j7u3nl1aFNW4FlmUSzf/lvZDJV32z0u7xGGyDaBEtbkYVplfWxFMdoDc6rnuM9KiJrV7bp0h0fKI+V9xDTR7a7ZoskVhfsvVD13kXocnNakUvxisZRvgq0WKwaIAU2y7qQ2BTfDSdYC2VTa0yWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=appRF2fc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717597712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VxIffXnjUYvHBO052LXyySGWsjqpIrP39OP6YN4p2SI=;
	b=appRF2fcFPVojfJMShWEVFeyMggRZ+sChYuG+1OR06zz+Aq99rgHRuMP+sP9WUOoaZ4Jaz
	fXAtcq525SAJ+rn5tTOaMBaBkTcawddz5fciM1AXfUuLq5Xbr6BeqOQ8ZihuAfPxEwJ89y
	HHY/MuTMnrO9lw9zCaPAQsgyIBFqprE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-NnfuarQwMHePbU2ESzLIJw-1; Wed, 05 Jun 2024 10:28:30 -0400
X-MC-Unique: NnfuarQwMHePbU2ESzLIJw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dcf7d4014so3611733f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717597709; x=1718202509;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VxIffXnjUYvHBO052LXyySGWsjqpIrP39OP6YN4p2SI=;
        b=SZXMeVJxNTA//sD6HIj0zleVqDYN+ezoxjMWhup/nj2DO/pfdDTE1LmfClK2qmZYzo
         DsBogJytof6h3VJ8j/N1c9F0eKrbSKxjeqPRhngqyQgAO5TX9PLJyWQrEzixGvJ2pQwf
         o+ImajjISn7GUJKHVaGePznHkRKKYNsr7UZoB7B6umvc02pnkgFGQEqiPg6eO9cBnXFT
         lZPa5g+8iYEbCmtG7zLbP+i8kXvs1Uo042YdG4H5JVI4uqXkwnZwoKGfheFiVsV/T+T+
         N36LUZS/mhos/N3cg+qj6HBkUwXZkZIXcOO8YEt9Z7gxFWuy43MPgl/Ln/x4Csxkpktr
         OYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTZ+N/LR76kCNBpF4t85iMlTNE5UzIXa25mY96jdxxN3Sc1qF3TIFYQsfkc7lTXhi7nJVishrI+8hoVXrQuD1NqkCJqnY1PK3pE4SN
X-Gm-Message-State: AOJu0YxLbMBvvoZkKRgdnS8EqQ3/BDl23+hGtO3rSjjELvR5AdWg6D07
	B+L4gUz2khuVylOlKLtqiqbOb64vjn9vrR2k8rK9XXS+zK8V6ZmKao/QrgaiO9+Wobf+JX5yx5P
	myEezaQ7eA+ZjuMLfdhGuvEJjLPiqmm7b1SzeqzELissu+NzCKhn9ojG2h9hr8w==
X-Received: by 2002:a5d:56cf:0:b0:357:e715:f52b with SMTP id ffacd0b85a97d-35e84070f49mr1879672f8f.20.1717597709035;
        Wed, 05 Jun 2024 07:28:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhbqtvPOCCdKJSv46h65rz+enYr0CQoR+/VdaCKU4/I53blN8X0B/qGtkis1jQrRM44WPP5A==
X-Received: by 2002:a5d:56cf:0:b0:357:e715:f52b with SMTP id ffacd0b85a97d-35e84070f49mr1879644f8f.20.1717597708568;
        Wed, 05 Jun 2024 07:28:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04cafb8sm14635656f8f.37.2024.06.05.07.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:28:28 -0700 (PDT)
Message-ID: <d319f00e-9dfb-43b1-ae81-a2e2afdf36c4@redhat.com>
Date: Wed, 5 Jun 2024 16:28:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240521040244.48760-1-ioworker0@gmail.com>
 <20240521040244.48760-3-ioworker0@gmail.com>
 <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com>
 <CAK1f24kwf4gDwK=8X4z1bM9-H6_M9QKy6-ko9pTUZij-W=40wg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24kwf4gDwK=8X4z1bM9-H6_M9QKy6-ko9pTUZij-W=40wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.06.24 16:20, Lance Yang wrote:
> Hi David,
> 
> On Wed, Jun 5, 2024 at 8:46 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 21.05.24 06:02, Lance Yang wrote:
>>> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
>>> folios, start the pagewalk first, then call split_huge_pmd_address() to
>>> split the folio.
>>>
>>> Since TTU_SPLIT_HUGE_PMD will no longer perform immediately, we might
>>> encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range during
>>> the page walk. It’s probably necessary to mlock this THP to prevent it from
>>> being picked up during page reclaim.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>> ---
>>
>> [...] again, sorry for the late review.
> 
> No worries at all, thanks for taking time to review!
> 
>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index ddffa30c79fb..08a93347f283 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>        if (flags & TTU_SYNC)
>>>                pvmw.flags = PVMW_SYNC;
>>>
>>> -     if (flags & TTU_SPLIT_HUGE_PMD)
>>> -             split_huge_pmd_address(vma, address, false, folio);
>>> -
>>>        /*
>>>         * For THP, we have to assume the worse case ie pmd for invalidation.
>>>         * For hugetlb, it could be much worse if we need to do pud
>>> @@ -1668,20 +1665,35 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>        mmu_notifier_invalidate_range_start(&range);
>>>
>>>        while (page_vma_mapped_walk(&pvmw)) {
>>> -             /* Unexpected PMD-mapped THP? */
>>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>> -
>>>                /*
>>>                 * If the folio is in an mlock()d vma, we must not swap it out.
>>>                 */
>>>                if (!(flags & TTU_IGNORE_MLOCK) &&
>>>                    (vma->vm_flags & VM_LOCKED)) {
>>>                        /* Restore the mlock which got missed */
>>> -                     if (!folio_test_large(folio))
>>> +                     if (!folio_test_large(folio) ||
>>> +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
>>>                                mlock_vma_folio(folio, vma);
>>
>> Can you elaborate why you think this would be required? If we would have
>> performed the  split_huge_pmd_address() beforehand, we would still be
>> left with a large folio, no?
> 
> Yep, there would still be a large folio, but it wouldn't be PMD-mapped.
> 
> After Weifeng's series[1], the kernel supports mlock for PTE-mapped large
> folio, but there are a few scenarios where we don't mlock a large folio, such
> as when it crosses a VM_LOCKed VMA boundary.
> 
>   -                     if (!folio_test_large(folio))
>   +                     if (!folio_test_large(folio) ||
>   +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
> 
> And this check is just future-proofing and likely unnecessary. If encountering a
> PMD-mapped THP missing the mlock for some reason, we can mlock this
> THP to prevent it from being picked up during page reclaim, since it is fully
> mapped and doesn't cross the VMA boundary, IIUC.
> 
> What do you think?
> I would appreciate any suggestions regarding this check ;)

Reading this patch only, I wonder if this change makes sense in the 
context here.

Before this patch, we would have PTE-mapped the PMD-mapped THP before 
reaching this call and skipped it due to "!folio_test_large(folio)".

After this patch, we either

a) PTE-remap the THP after this check, but retry and end-up here again, 
whereby we would skip it due to "!folio_test_large(folio)".

b) Discard the PMD-mapped THP due to lazyfree directly. Can that 
co-exist with mlock and what would be the problem here with mlock?


So if the check is required in this patch, we really have to understand 
why. If not, we should better drop it from this patch.

At least my opinion, still struggling to understand why it would be 
required (I have 0 knowledge about mlock interaction with large folios :) ).

-- 
Cheers,

David / dhildenb


