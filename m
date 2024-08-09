Return-Path: <linux-kernel+bounces-281284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05F94D518
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E84286122
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF3E2941B;
	Fri,  9 Aug 2024 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaNg/Se3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E194644E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222475; cv=none; b=jGNu5nNgvd0wnN2Qlg2uVUWfOUFE5PlBFoi/Y8zsUlru+XFHBy/0VrXYonY7y1Mkm+ZAzthG2NuwHEVjkeaUGOPF2yGx3XCv7AqW8jT4XtlUuzVLr8ZSfb4VPlSmOMw/9xyzPLgH9S6a1H0/gDcysfE7L2zIDxwN4BdlPMHPQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222475; c=relaxed/simple;
	bh=BVuRFk0AbyLEtVmf6tp5uUOxolzFmnVN2II3PL2vKBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bT/4qL8CMBhCG3fE5nm0YLFszvpBpIGRDznQumQQXt13gn73taeHImbPz/yFVBtXVP9Ut5eU3aKQy0GZCGZzmgjqW4Ux4NV1Tr+LAYY6JGOal/YR28W/hYjHhWlSGxd/it8hJV/YtsX64EnJomHjmSYI+jqX+Q8LYETUxSydBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaNg/Se3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723222473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xJ1NiQQ3WC7fQThUkGE6314nyICIjsXK+pb24G2wLiM=;
	b=HaNg/Se3viYJeDYQHc+fvh6Y1O9S8KadgnW+Dhyti4L97vsD1sCyntzB/AT0Y2Af8Qv/jZ
	bDpm4ZZhgCiaC7Ht3cl4s66nvMr5BndEZYXXyEdtSdDQWAtSkhoMCT8jIvZ/dj+vaPoYFq
	C25sNBDhZqXiMpMT3teCaBj1M5cPwZw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-po09fzQEOb6h0sffLn8B4A-1; Fri, 09 Aug 2024 12:54:32 -0400
X-MC-Unique: po09fzQEOb6h0sffLn8B4A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36848f30d39so1291786f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222471; x=1723827271;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xJ1NiQQ3WC7fQThUkGE6314nyICIjsXK+pb24G2wLiM=;
        b=BaTlD0fCHWuL/0IUpanXA7IrzzO7wo0oPvxHUqmWpJR15Wbbon2qdox2f8l5oAqPpp
         PMqR/O+U2+5iH75/rZEVPDti0pXKKgMiPz3TjnzdmeBloKozbFMcVtuEFBOaHSx8HcKd
         8QA35QZGYoQTebz9wytqew1K+JHPx4dbLL3tt4MtCJ4xkLHL2GLck/Q/iqr0oLcH2euH
         /B8AYd77JnESOa16WCX5VMJgirvkbIVgIwV+M5xcU4zo922RiDRYU6GSk7X+QwZoFxzG
         uWYm/Vdt5+Wy7KG7rsSKhgFIxZfcEpYU7cl4Rz20lbhGohc4ud1REklVcHHUfWrgXglI
         TLTA==
X-Forwarded-Encrypted: i=1; AJvYcCW8zuYHcGnX8FSsWolE1EVaAmyxaY8uVOFvGuZ1SuyAd08JinpLhyZJJKmT3vJaFl7ClfNc4lbKqiwi4a+2rvOHH+70kxQGiAcMOiCp
X-Gm-Message-State: AOJu0Yw95H41TKdGc+r6zqh4SryUiMwzTzQxiJxe9EpxplXI2YJD/wT9
	NBn2pdYjt8LG74JGIdL/3Xq5Av3V35UT+uyv2fGyQKBSjvJiM6/USHGDUE3rV00PuHfNN0WkRjE
	CHbNuSpr7CMJEC7fKwy2OsTWcbGOHBnFC4EwIj8tiR3iFW9EnkVukQd3PPK4egQ==
X-Received: by 2002:adf:f98d:0:b0:368:667a:3dec with SMTP id ffacd0b85a97d-36d5fc8794cmr1669054f8f.18.1723222470825;
        Fri, 09 Aug 2024 09:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhAPOUhKlN9Xqio8ca2qzNcoa40xiHF+PzNb/raKoKm+RRQfL0QJjkwP4n1hw0w092ycTwEQ==
X-Received: by 2002:adf:f98d:0:b0:368:667a:3dec with SMTP id ffacd0b85a97d-36d5fc8794cmr1669027f8f.18.1723222470283;
        Fri, 09 Aug 2024 09:54:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27156c8asm5782490f8f.24.2024.08.09.09.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:54:29 -0700 (PDT)
Message-ID: <f79bbfc9-bb4c-4da4-9902-2e73817dd135@redhat.com>
Date: Fri, 9 Aug 2024 18:54:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] mm: pgtable: make pte_offset_map_nolock()
 return pmdval
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <d101b185eb55438b18faa2029e4303b7453bd5f5.1722861064.git.zhengqi.arch@bytedance.com>
 <0e8e0503-5796-4b61-bb5b-249e285f5d21@redhat.com>
 <39281a4d-d896-46fd-80a5-8cd547d1625f@bytedance.com>
 <0f467510-a0d0-4a98-8517-43813fa4c131@redhat.com>
 <f6c05526-5ac9-4597-9e80-099ea22fa0ae@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f6c05526-5ac9-4597-9e80-099ea22fa0ae@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.08.24 05:08, Qi Zheng wrote:
> Hi David,
> 
> On 2024/8/6 22:16, David Hildenbrand wrote:
>> On 06.08.24 04:40, Qi Zheng wrote:
>>> Hi David,
>>>
>>> On 2024/8/5 22:43, David Hildenbrand wrote:
>>>> On 05.08.24 14:55, Qi Zheng wrote:
>>>>> Make pte_offset_map_nolock() return pmdval so that we can recheck the
>>>>> *pmd once the lock is taken. This is a preparation for freeing empty
>>>>> PTE pages, no functional changes are expected.
>>>>
>>>> Skimming the patches, only patch #4 updates one of the callsites
>>>> (collapse_pte_mapped_thp).
>>>
>>> In addition, retract_page_tables() and reclaim_pgtables_pmd_entry()
>>> also used the pmdval returned by pte_offset_map_nolock().
>>
>> Right, and I am questioning if only touching these two is sufficient,
>> and how we can make it clearer when someone actually has to recheck the
>> PMD.
>>
>>>
>>>>
>>>> Wouldn't we have to recheck if the PMD val changed in more cases after
>>>> taking the PTL?
>>>>
>>>> If not, would it make sense to have a separate function that returns the
>>>> pmdval and we won't have to update each and every callsite?
>>>
>>> pte_offset_map_nolock() had already obtained the pmdval previously, just
>>> hadn't returned it. And updating those callsite is simple, so I think
>>> there may not be a need to add a separate function.
>>
>> Let me ask this way: why is retract_page_tables() and
>> reclaim_pgtables_pmd_entry() different to the other ones, and how would
>> someone using pte_offset_map_nolock() know what's to do here?
> 
> If we acuqire the PTL (PTE or PMD lock) after calling
> pte_offset_map_nolock(), it means we may be modifying the corresponding
> pte or pmd entry. In that case, we need to perform a pmd_same() check
> after holding the PTL, just like in pte_offset_map_lock(), to prevent
> the possibility of the PTE page being reclaimed at that time.

Okay, what I thought.

> 
> If we call pte_offset_map_nolock() and do not need to acquire the PTL
> afterwards, it means we are only reading the PTE page. In this case, the
> rcu_read_lock() in pte_offset_map_nolock() will ensure that the PTE page
> cannot be reclaimed.
> 
>>
>> IIUC, we must check the PMDVAL after taking the PTL in case
>>
>> (a) we want to modify the page table to turn pte_none() entries to
>>       !pte_none(). Because it could be that the page table was removed and
>>       now is all pte_none()
>>
>> (b) we want to remove the page table ourselves and want to check if it
>>       has already been removed.
>>
>> Is that it?
> 
> Yes.
> 
>>
>> So my thinking is if another function variant can make that clearer.
> 
> OK, how about naming it pte_offset_map_before_lock?

That's the issue with some of the code: for example in 
filemap_fault_recheck_pte_none() we'll call pte_offset_map_nolock() and 
conditionally take the PTL. But we won't be modifying the pages tables.

Maybe something like:

pte_offset_map_readonly_nolock()

and

pte_offset_map_maywrite_nolock()

The latter would require you to pass the PMD pointer such that you have 
to really mess up to ignore what to do with it (check PMD same or not 
check PMD same if you really know what you are douing).

The first would not take a PMD pointer at all, because there is no need to.

-- 
Cheers,

David / dhildenb


