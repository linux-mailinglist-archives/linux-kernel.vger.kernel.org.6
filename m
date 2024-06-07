Return-Path: <linux-kernel+bounces-206641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A99900C35
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3402428868A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8A13E3FD;
	Fri,  7 Jun 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZVMCjdx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB733EE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787035; cv=none; b=FOR5HjdR/GqDL6eZdiEC3FeetW9g2AjIVzqeOfsJTXrr8v3QJZYZ0cQyoBg7BTdRmqMiKqj79Ex8DWwDZ4yEYdrTulAIj53qn86sWSwWwru0MT+HZdxxnawcQ8qQ9phVKLVxroOMffS0qEYBesKstOfRx1Ts4n5RKX8md3kFJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787035; c=relaxed/simple;
	bh=F7gXLWbA4Bik67yH0wKqJpWvzHp/8MtTamujM5RDzXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjlmeiQ1CY0aSWzxVSyC3QmYJczuU+dbVQ7EgLzEgb1cYR/Ajxxv3UQV5Oz9FcBgM8PRhu3UVI4K8TbAaaCj+dCte3e0Ptv/kEuMxvhUmnF/+tPMttd0SWc10Y1Kgp93R700cjq+MwOtfDg1tb+R6SWGWuRVKEYf+/Ww3DbOjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZVMCjdx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717787031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ySLtKpIcO9sdxhxfDpPVifewSL6UcX3QbzaTEc2AyLA=;
	b=gZVMCjdxN3U3LA92yWBSilPTu5zCYcfjJeCLWE3XWwLwH+Lpu97enaaZe7Z2hdvqBvS0IZ
	8/0xmEEcMjsHsGxiCAA8y2DqG2G9+PCLqHw5EWEKzzYvxLhCnuxHHuEERxS8kBNNFizWlN
	2FnGAHPiCXqlhKSWNSLBzAiFgu5IOJA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-hatxpproNc2ODrwW223umg-1; Fri, 07 Jun 2024 15:03:48 -0400
X-MC-Unique: hatxpproNc2ODrwW223umg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52bb096e9d8so1752862e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 12:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717787026; x=1718391826;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ySLtKpIcO9sdxhxfDpPVifewSL6UcX3QbzaTEc2AyLA=;
        b=vCR/zJUXTJt1I7w1ecR4aGV+RoRSlxFlbS5ctXEsavqDaXpNx40Hp7nseWgZ50DiZk
         eCvn6sqyRL9JTGOf6UP+Q/xKILlt26uKFKGEXiI43W5Q2FdITpJxiW+R61tBwFKBzm9T
         pKLx4yZaceQyOuWlJoVbwyOPNLG9ZhXRy5zh/ZlwQw7V5NsB94uNGTzeW8Li8lr8aPi0
         G5QNMbGVg9jh6enAxIel7Zm5Qm+yp+LMHIcgtw0TWwDEB04+mKSam7M/59PuZzlju/U9
         NWuYOLxASGe8O0mLoZ5cRNByZOgpsBi4BOjpM9l8UtGyn1VcB5CIXyDh2BpcNt5EyBhU
         y7+A==
X-Forwarded-Encrypted: i=1; AJvYcCVyVknbaLBQiNdGVczhj93tMgVPwxo/v5xpkwr3MQpZuOorK6xnJHIPl5GSB3u06JF4kwJ5rIsQU7MZDj8ZKLte5mFa8oBz9JxYBsZv
X-Gm-Message-State: AOJu0Yy9mgM/0uAttiCsfQWJaxliTlEuH8yx7l00I6ZdbbWc6SECgYsJ
	C//UmBPxP5nxQbZ+8kM2wsiaAH9xwUphtJn68JUHfb9iDKVRxX6t6IaW/X5Xir6tCMsNVV+dlrA
	TlUdQG4kIIv9ozgU5f4kV7MZsleXJPBwbafuNZ1n0frH49vdVLuz62yhl4W9n+g==
X-Received: by 2002:a05:6512:108e:b0:52b:8325:6edf with SMTP id 2adb3069b0e04-52bb9f8e818mr2735217e87.33.1717787026599;
        Fri, 07 Jun 2024 12:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvzrfsrptLjrhwYztzM5P2Xgg5TWxTMydZD/gaochgN8KMVrFoyaznO0DdudJiiEcteBdjmw==
X-Received: by 2002:a05:6512:108e:b0:52b:8325:6edf with SMTP id 2adb3069b0e04-52bb9f8e818mr2735200e87.33.1717787026106;
        Fri, 07 Jun 2024 12:03:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a? (p200300cbc71a220031c44d181bddfb7a.dip0.t-ipconnect.de. [2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d295eesm4523226f8f.7.2024.06.07.12.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 12:03:45 -0700 (PDT)
Message-ID: <eed7539d-1bac-4145-bd89-457adf4a4aba@redhat.com>
Date: Fri, 7 Jun 2024 21:03:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is
 attempted
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com>
 <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
 <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com>
 <CAGsJ_4w_dEyLsPhdJCtRMReXDD116p+U979Yk-8EBu=zx5FWgQ@mail.gmail.com>
 <CAJD7tkYnZCvwUSTAx-N-08b+mVF4yHEdDTbp9oqYrVQXX8M1Cw@mail.gmail.com>
 <CAGsJ_4wAYbofjg99iEr7cEAptH9Ve9WcrSXho8A-Sw54vb8Msw@mail.gmail.com>
 <9374758d-9f81-4e4f-8405-1f972234173e@redhat.com>
 <CAJD7tkZBzSB_6pAZP0n0nq+W=J1XKQGFzZZLzPmSH0apwaqTNg@mail.gmail.com>
 <424c6430-e40d-4a60-8297-438fc33056c9@redhat.com>
 <CAJD7tkbaX-8OQm0JispxWWbuzX+PJrH=HN6yqEjqL2yxRcu=Aw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJD7tkbaX-8OQm0JispxWWbuzX+PJrH=HN6yqEjqL2yxRcu=Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.06.24 20:58, Yosry Ahmed wrote:
> On Fri, Jun 7, 2024 at 11:52 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>>> I have no strong opinion on this one, but likely a VM_WARN_ON would also
>>>> be sufficient to find such issues early during testing. No need to crash
>>>> the machine.
>>>
>>> I thought VM_BUG_ON() was less frowned-upon than BUG_ON(), but after
>>> some digging I found your patches to checkpatch and Linus clearly
>>> stating that it isn't.
>>
>> :) yes.
>>
>> VM_BUG_ON is not particularly helpful IMHO. If you want something to be
>> found early during testing, VM_WARN_ON is good enough.
>>
>> Ever since Fedora stopped enabling CONFIG_DEBUG_VM, VM_* friends are
>> primarily reported during early/development testing only. But maybe some
>> distro out there still sets it.
>>
>>>
>>> How about something like the following (untested), it is the minimal
>>> recovery we can do but should work for a lot of cases, and does
>>> nothing beyond a warning if we can swapin the large folio from disk:
>>>
>>> diff --git a/mm/page_io.c b/mm/page_io.c
>>> index f1a9cfab6e748..8f441dd8e109f 100644
>>> --- a/mm/page_io.c
>>> +++ b/mm/page_io.c
>>> @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct
>>> swap_iocb **plug)
>>>           delayacct_swapin_start();
>>>
>>>           if (zswap_load(folio)) {
>>> -               folio_mark_uptodate(folio);
>>>                   folio_unlock(folio);
>>>           } else if (data_race(sis->flags & SWP_FS_OPS)) {
>>>                   swap_read_folio_fs(folio, plug);
>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>> index 6007252429bb2..cc04db6bb217e 100644
>>> --- a/mm/zswap.c
>>> +++ b/mm/zswap.c
>>> @@ -1557,6 +1557,22 @@ bool zswap_load(struct folio *folio)
>>>
>>>           VM_WARN_ON_ONCE(!folio_test_locked(folio));
>>>
>>> +       /*
>>> +        * Large folios should not be swapped in while zswap is being used, as
>>> +        * they are not properly handled.
>>> +        *
>>> +        * If any of the subpages are in zswap, reading from disk would result
>>> +        * in data corruption, so return true without marking the folio uptodate
>>> +        * so that an IO error is emitted (e.g. do_swap_page() will sigfault).
>>> +        *
>>> +        * Otherwise, return false and read the folio from disk.
>>> +        */
>>> +       if (WARN_ON_ONCE(folio_test_large(folio))) {
>>> +               if (xa_find(tree, &offset, offset +
>>> folio_nr_pages(folio) - 1, 0))
>>> +                       return true;
>>> +               return false;
>>> +       }
>>> +
>>>           /*
>>>            * When reading into the swapcache, invalidate our entry. The
>>>            * swapcache can be the authoritative owner of the page and
>>> @@ -1593,7 +1609,7 @@ bool zswap_load(struct folio *folio)
>>>                   zswap_entry_free(entry);
>>>                   folio_mark_dirty(folio);
>>>           }
>>> -
>>> +       folio_mark_uptodate(folio);
>>>           return true;
>>>    }
>>>
>>> One problem is that even if zswap was never enabled, the warning will
>>> be emitted just if CONFIG_ZSWAP is on. Perhaps we need a variable or
>>> static key if zswap was "ever" enabled.
>>
>> We should use WARN_ON_ONCE() only for things that cannot happen. So if
>> there are cases where this could be triggered today, it would be
>> problematic -- especially if it can be triggered from unprivileged user
>> space. But if we're concerned of other code messing up our invariant in
>> the future (e.g., enabling large folios without taking proper care about
>> zswap etc), we're good to add it.
> 
> Right now I can't see any paths allocating large folios for swapin, so
> I think it cannot happen. Once someone tries adding it, the warning
> will fire if CONFIG_ZSWAP is used, even if zswap is disabled.
> 
> At this point we will have several options:
> - Make large folios swapin depend on !CONFIG_ZSWAP for now.
> - Keep track if zswap was ever enabled and make the warning
> conditional on it. We should also always fallback to order-0 if zswap
> was ever enabled.
> - Properly handle large folio swapin with zswap.
> 
> Does this sound reasonable to you?

Yes, probably easiest is 1) -> 3) or if we don't want to glue it to 
config options 2) -> 3).

-- 
Cheers,

David / dhildenb


