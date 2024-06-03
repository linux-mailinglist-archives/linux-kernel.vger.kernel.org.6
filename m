Return-Path: <linux-kernel+bounces-198828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B001A8D7E05
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02792B21004
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174858AA5;
	Mon,  3 Jun 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/zb3jTT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F01E49F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405447; cv=none; b=omUnjWTRyWfqExRgN2O0IZarnZNzzK9RAb3pTWPmnsgNg23y+XCEMyK/VOdpcCmqduOTAtH49Yo5fMJ3qgu/EsMy1r8+gfCLt4YeoX/XZrJdyrj4jgLDYy/Lm9bsu0nvyEOaMQkCaVhnzeXGWAwf94vOzraB+SMJiEHMqC6dGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405447; c=relaxed/simple;
	bh=+gp6YwJoAwS/deFrmlfRAFSaPXv732lHbm3yBiieoFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRt92wSOJNOU8FLnsG2M+jSfGrp3mQ8dwCgPp9rjDaHp1pCWbTtsRHLYGEbAFkhcEop5AyKzAR93cofADmmc9yw6PmNwl0PL6O0Pd7YXdeut/y4qwdThLNLsU5Sw3/k+1HZrxgDlxe9aXIcX6ApLEzOQ0s4U/VV6YTd6aYsunoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/zb3jTT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717405445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dvo1xKIETfRGN29RW+D5krHV9Xmab96B9Jg9DXmgfSo=;
	b=X/zb3jTT83kZQiaEh68b2KW1HtdHwy9VzWCV+8OuIeQTQ8uT8RX9RYWhNR6+l9r/VMdDIz
	+c1lF1bpocPi9jD9FHvnHIUfSU0AhO3C01ccnV4c5uUJYgfSTpMCugD+4S30TDUz5i9R9B
	N2EYMutn0J5gkem7V0817OeO/3innEk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-_tjB7SqTO62kUwT5tKl8TQ-1; Mon, 03 Jun 2024 05:03:58 -0400
X-MC-Unique: _tjB7SqTO62kUwT5tKl8TQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35e0e59dcf7so1493225f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405437; x=1718010237;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dvo1xKIETfRGN29RW+D5krHV9Xmab96B9Jg9DXmgfSo=;
        b=aOBsKuszWpKtGcp31KgQaMJ+cmjX4nqEWWzUH693c5Y6OP6fMtdQf5V3WnjPohuBsy
         sYQcsnwbeBlZBw4zOrAg19k3HEIB2uH5aaJRfFNsfkerCP8UIxE2RH2n5BA39VQosT8U
         7d/Rvquu2SAeYtI/Ud5zsbyEGuk8yfDNlYQYVDPe+QMbja7M10VvjZROS67YIv3Nj0Pl
         ybQ07KYuhp9wUQuLcYCD3hqDpMim80E6uOhd7pcsLo9rtwzkCuhy5BJSrjc5X5hRoBKP
         7wSD81spw7OscD6SBnBRhiXCuX3geiY9AuLZcylwc1kk5zeyYaMnJ03jaX89fMbpZL8s
         oT6g==
X-Forwarded-Encrypted: i=1; AJvYcCXqns16NtPhZg73Uy5NHL3tBuaP73yBlrZnRbj5whlRnsnlwVrN1kpb90/i4yzhyjd0jQJrJGtY2Et9F7qV42X3E2YLfdjynfISwRc+
X-Gm-Message-State: AOJu0YwnSxn6f7uryrUNndXlKhbEdhxG/dR/n+bHS9BwP2jAaW2UA3QW
	+7o+jD7zgTTkGut2Ay8LJmy21NvcKkQDTUiNZAjP6x07d8ukIz0I12TeXty7BiyBJi1ccLckiMq
	B/NIoAdz4w30blCoOGngrQ2qa+snvncMm1ZzXIQ3NwjGmvu83jHtcs4hm7nJl0w==
X-Received: by 2002:a5d:4acd:0:b0:355:841:aeaf with SMTP id ffacd0b85a97d-35e0f2852d2mr6135330f8f.33.1717405437221;
        Mon, 03 Jun 2024 02:03:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT+L8H+LoMQh4b3Tj2H6qVj5mHaPgE8EajeFm3e9WCEN4rzn91QqDRLMUSW35R4Awv1Kj8Cw==
X-Received: by 2002:a5d:4acd:0:b0:355:841:aeaf with SMTP id ffacd0b85a97d-35e0f2852d2mr6135302f8f.33.1717405436768;
        Mon, 03 Jun 2024 02:03:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:3d00:918f:ce94:4280:80f0? (p200300cbc7313d00918fce94428080f0.dip0.t-ipconnect.de. [2003:cb:c731:3d00:918f:ce94:4280:80f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0667366sm8134698f8f.111.2024.06.03.02.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:03:56 -0700 (PDT)
Message-ID: <a82a7441-3a70-40b6-a765-c91f47bb728c@redhat.com>
Date: Mon, 3 Jun 2024 11:03:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/mlock: implement folio_mlock_step() using
 folio_pte_batch()
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, ziy@nvidia.com,
 fengwei.yin@intel.com, ying.huang@intel.com, libang.li@antgroup.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240603033118.76457-1-ioworker0@gmail.com>
 <CAGsJ_4wxPk+bk9UM+PvA3x=LJG+mWmTD3e2HSEsS83X3vMWTJQ@mail.gmail.com>
 <c925eae9-5c7e-47d2-bab3-708edec88990@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c925eae9-5c7e-47d2-bab3-708edec88990@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.06.24 10:58, Baolin Wang wrote:
> 
> 
> On 2024/6/3 12:14, Barry Song wrote:
>> On Mon, Jun 3, 2024 at 3:31 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>
>>> Let's make folio_mlock_step() simply a wrapper around folio_pte_batch(),
>>> which will greatly reduce the cost of ptep_get() when scanning a range of
>>> contptes.
>>>
>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>> ---
>>>    mm/mlock.c | 23 ++++++-----------------
>>>    1 file changed, 6 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>> index 30b51cdea89d..1ae6232d38cf 100644
>>> --- a/mm/mlock.c
>>> +++ b/mm/mlock.c
>>> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
>>>    static inline unsigned int folio_mlock_step(struct folio *folio,
>>>                   pte_t *pte, unsigned long addr, unsigned long end)
>>>    {
>>> -       unsigned int count, i, nr = folio_nr_pages(folio);
>>> -       unsigned long pfn = folio_pfn(folio);
>>> -       pte_t ptent = ptep_get(pte);
>>> -
>>> -       if (!folio_test_large(folio))
>>> +       if (likely(!folio_test_large(folio)))
>>>                   return 1;
>>>
>>> -       count = pfn + nr - pte_pfn(ptent);
>>> -       count = min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT);
>>> -
>>> -       for (i = 0; i < count; i++, pte++) {
>>> -               pte_t entry = ptep_get(pte);
>>> -
>>> -               if (!pte_present(entry))
>>> -                       break;
>>> -               if (pte_pfn(entry) - pfn >= nr)
>>> -                       break;
>>> -       }
>>> +       const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>> +       int max_nr = (end - addr) / PAGE_SIZE;
>>> +       pte_t ptent = ptep_get(pte);
>>>
>>> -       return i;
>>> +       return folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags, NULL,
>>> +                              NULL, NULL);
>>>    }
>>
>> what about a minimum change as below?
>> index 30b51cdea89d..e8b98f84fbd2 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
>>    static inline unsigned int folio_mlock_step(struct folio *folio,
>>                   pte_t *pte, unsigned long addr, unsigned long end)
>>    {
>> -       unsigned int count, i, nr = folio_nr_pages(folio);
>> -       unsigned long pfn = folio_pfn(folio);
>> +       unsigned int count = (end - addr) >> PAGE_SHIFT;
>>           pte_t ptent = ptep_get(pte);
>> +       const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>
>>           if (!folio_test_large(folio))
>>                   return 1;
>>
>> -       count = pfn + nr - pte_pfn(ptent);
>> -       count = min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT);
>> -
>> -       for (i = 0; i < count; i++, pte++) {
>> -               pte_t entry = ptep_get(pte);
>> -
>> -               if (!pte_present(entry))
>> -                       break;
>> -               if (pte_pfn(entry) - pfn >= nr)
>> -                       break;
>> -       }
>> -
>> -       return i;
>> +       return folio_pte_batch(folio, addr, pte, ptent, count, fpb_flags, NULL,
>> +                              NULL, NULL);
>>    }
> 
> LGTM.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


