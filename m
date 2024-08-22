Return-Path: <linux-kernel+bounces-297063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8930B95B284
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5C61C218E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06517B401;
	Thu, 22 Aug 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoOO4DF7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65416A943
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320921; cv=none; b=jM2jCG8Yt1tnZ1fyVagSIdAQ6CkpdGtfbZaSwyZPOW3JaAMwj2jj5QOD1QM4g+vUHRoywtu3HOiMHuBsiCAZaaG8LjTeA3m9/2c8zgMaycDs4uWm+gSIgWOGdCXzklt4ozL8gpCdlQczkfogwJjvgYVirBBiffqMgPPh5JXBK8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320921; c=relaxed/simple;
	bh=vEdCnRnno0vWuz7vnJZvxu2P8Gi8RFAMBEVX4tHx4xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBd+ZDBlo8KhP85R7Zs9wrvlcHdLDoWvjGX+zQPy0+Sg39lew4MxLVgcDbbmNPC0WCNBo/d47Z+fvnGVL3eNi0hyUPllhcZtRztXJFNvKQn7LDdSUpXiIdoZto/UoLxmuDNrlPdgoY6RkcZoykMH6Q/9we/6miE5OeKR4jEFXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoOO4DF7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724320917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=13En5gmTuN6FvQrKVmyKbIK539fzYRzBhXf4JRw5Lig=;
	b=QoOO4DF7s6pcAsM9qUq5FyhNDqEQSV21Zwa/mCRULFf4q6QQ75WK4ci2kp5JwztWOkIw15
	NElzdChvDJyvrqOtgxYWBZJFMipReQFe3DwGw1bJiMhyJInwLZx6wXM9ajk/Qsx4QutzS0
	d6+ep1B3ApTUQdNuaBQJsjA7kbDVq6Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-Dtoyb5P9PZmTsiuPS05q_w-1; Thu, 22 Aug 2024 06:01:56 -0400
X-MC-Unique: Dtoyb5P9PZmTsiuPS05q_w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280f233115so4768955e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320915; x=1724925715;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=13En5gmTuN6FvQrKVmyKbIK539fzYRzBhXf4JRw5Lig=;
        b=Zv4zPGL3kYLh7rYkmcQ73GZL43El1i2ftCn82ywi3+2rYnUfQm0ylMgWRqS/5PUa2o
         0sqnpPNicCqerRFvsVi0FJnRPPPeOW5gzmEb2tCf+wv/l7fmZqGKQzuplAAW3VrN2ODU
         KieSZB90Lx5F1K1DR/7C/7VIVhFCq6CSIWq1Y2OdrCvZ7gegbB4Rmfb3ylj55pW8O4ir
         rFEPFBFzOFwX7D/BXR7Xc5DF+R8vXcEwDZU7Xof0qyuyaIqC2xAEnviwG4Zik3SKeV5S
         mzApsA4lI70bgxX8r184QxIFfOge5lDdz92ZaZA+f1lkLej+j1IQhmEqwwE9ucRXjFhw
         u0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUU/qXugC2SD/8JJdHujgkcsdV2wA8+4TWId7Ae/5YVM+iw7dVw74P+D7eRNDzh17J1xGezcCCjjP4UBI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/65gv+BrMYToireZExVWmlVR1ZtOYekNvR5A7EihumPp61AR
	5nrzd9ztHCssjbNDng9Vv5ucSXhEsnsoKKnMKya8DCHRoEpfKqIMZfXXUEKZhXKbEZnVXoQk51p
	W2dPfNW47tMYNWAH73ZDJd8Cimd6LC1oSoKAHYxiQWO1bsSWtZJyFi8SmiD52Xw==
X-Received: by 2002:a05:600c:4e8f:b0:426:59ad:bbb3 with SMTP id 5b1f17b1804b1-42ac564ef4bmr9888535e9.32.1724320915165;
        Thu, 22 Aug 2024 03:01:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpfNb/Wc390EZaDJX2SGK8sR9llOfNBaHSC+dSTXhbMcu05vt+04rPZUXA/GyDYq77pQEZvg==
X-Received: by 2002:a05:600c:4e8f:b0:426:59ad:bbb3 with SMTP id 5b1f17b1804b1-42ac564ef4bmr9888125e9.32.1724320914175;
        Thu, 22 Aug 2024 03:01:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:2b00:f928:47d8:c9be:9d87? (p200300cbc70f2b00f92847d8c9be9d87.dip0.t-ipconnect.de. [2003:cb:c70f:2b00:f928:47d8:c9be:9d87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefeaa45sm55581955e9.39.2024.08.22.03.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 03:01:53 -0700 (PDT)
Message-ID: <a7d537df-7899-42fc-b9ef-66733105abbe@redhat.com>
Date: Thu, 22 Aug 2024 12:01:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: collect the number of anon large folios
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 ziy@nvidia.com, yuanshuai@oppo.com
References: <20240811224940.39876-1-21cnbao@gmail.com>
 <20240811224940.39876-2-21cnbao@gmail.com>
 <3572ae2e-2141-4a70-99da-850b2e7ade41@redhat.com>
 <CAGsJ_4w9gg=z6KgAZ4Tur+t-ZhpXdvmq4A5tOQiUZLeuPFSupg@mail.gmail.com>
 <CAGsJ_4yqf4KNvsg1P47cAz+bniZFVcUWPkdjYTqji91CgnrrfQ@mail.gmail.com>
 <954f80c8-5bc3-44f5-a361-32073cbbd764@redhat.com>
 <CAGsJ_4wyj7U2z_XnbgEsavEkpkNO8=kVfMesxhtNbcQ=H3dzXw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wyj7U2z_XnbgEsavEkpkNO8=kVfMesxhtNbcQ=H3dzXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.08.24 11:21, Barry Song wrote:
> On Thu, Aug 22, 2024 at 8:59 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 22.08.24 10:44, Barry Song wrote:
>>> On Thu, Aug 22, 2024 at 12:52 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> On Thu, Aug 22, 2024 at 5:34 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 12.08.24 00:49, Barry Song wrote:
>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>
>>>>>> Anon large folios come from three places:
>>>>>> 1. new allocated large folios in PF, they will call folio_add_new_anon_rmap()
>>>>>> for rmap;
>>>>>> 2. a large folio is split into multiple lower-order large folios;
>>>>>> 3. a large folio is migrated to a new large folio.
>>>>>>
>>>>>> In all above three counts, we increase nr_anon by 1;
>>>>>>
>>>>>> Anon large folios might go either because of be split or be put
>>>>>> to free, in these cases, we reduce the count by 1.
>>>>>>
>>>>>> Folios that have been added to the swap cache but have not yet received
>>>>>> an anon mapping won't be counted. This is consistent with the AnonPages
>>>>>> statistics in /proc/meminfo.
>>>>>
>>>>> Thinking out loud, I wonder if we want to have something like that for
>>>>> any anon folios (including small ones).
>>>>>
>>>>> Assume we longterm-pinned an anon folio and unmapped/zapped it. It would
>>>>> be quite interesting to see that these are actually anon pages still
>>>>> consuming memory. Same with memory leaks, when an anon folio doesn't get
>>>>> freed for some reason.
>>>>>
>>>>> The whole "AnonPages" counter thingy is just confusing, it only counts
>>>>> what's currently mapped ... so we'd want something different.
>>>>>
>>>>> But it's okay to start with large folios only, there we have a new
>>>>> interface without that legacy stuff :)
>>>>
>>>> We have two options to do this:
>>>> 1. add a new separate nr_anon_unmapped interface which
>>>> counts unmapped anon memory only
>>>> 2. let the nr_anon count both mapped and unmapped anon
>>>> folios.
>>>>
>>>> I would assume 1 is clearer as right now AnonPages have been
>>>> there for years. and counting all mapped and unmapped together,
>>>> we are still lacking an approach to find out anon memory leak
>>>> problem you mentioned.
>>>>
>>>> We are right now comparing nr_anon(including mapped folios only)
>>>> with AnonPages to get the distribution of different folio sizes in
>>>> performance profiling.
>>>>
>>>> unmapped_nr_anon should be normally always quite small. otherwise,
>>>> something must be wrong.
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>>> ---
>>>>>>     Documentation/admin-guide/mm/transhuge.rst |  5 +++++
>>>>>>     include/linux/huge_mm.h                    | 15 +++++++++++++--
>>>>>>     mm/huge_memory.c                           | 13 ++++++++++---
>>>>>>     mm/migrate.c                               |  4 ++++
>>>>>>     mm/page_alloc.c                            |  5 ++++-
>>>>>>     mm/rmap.c                                  |  1 +
>>>>>>     6 files changed, 37 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>>>>> index 058485daf186..9fdfb46e4560 100644
>>>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>>>> @@ -527,6 +527,11 @@ split_deferred
>>>>>>             it would free up some memory. Pages on split queue are going to
>>>>>>             be split under memory pressure, if splitting is possible.
>>>>>>
>>>>>> +nr_anon
>>>>>> +       the number of anon huge pages we have in the whole system.
>>>>>
>>>>> "transparent ..." otherwise people might confuse it with anon hugetlb
>>>>> "huge pages" ... :)
>>>>>
>>>>> I briefly tried coming up with a better name than "nr_anon" but failed.
>>>>>
>>>>>
>>>>
>>>> if we might have unmapped_anon counter later, maybe rename it to
>>>> nr_anon_mapped? and the new interface we will have in the future
>>>> might be nr_anon_unmapped?
>>
>> We really shouldn't be using the mapped/unmapped terminology here ... we
>> allocated pages and turned them into anonymous folios. At some point we
>> free them. That's the lifecycle.
>>
>>>
>>> On second thought, this might be incorrect as well. Concepts like 'anon',
>>> 'shmem', and 'file' refer to states after mapping. If an 'anon' has been
>>> unmapped but is still pinned and not yet freed, it isn't technically an
>>> 'anon' anymore?
>>
>> It's just not mapped, and cannot get mapped, anymore. In the memdesc
>> world, we'd be freeing the "struct anon" or "struct folio" once the last
>> refcount goes to 0, not once (e.g., temporarily during a failed
>> migration?) unmapped.
>>
>> The important part to me would be: this is memory that was allocated for
>> anonymous memory, and it's still around for some reason and not getting
>> freed. Usually, we would expect anon memory to get freed fairly quickly
>> once unmapped. Except when there are long-term pinnings or other types
>> of memory leaks.
>>
>> You could happily continue using these anon pages via vmsplice() or
>> similar, even thought he original page table mapping was torn down.
>>
>>>
>>> On the other hand, implementing nr_anon_unmapped could be extremely
>>> tricky. I have no idea how to implement it as we are losing those mapping
>>> flags.
>>
>> folio_mapcount() can tell you efficiently whether a folio is mapped or
>> not -- and that information will stay for all eternity as long as we
>> have any mapcounts :) . It cannot tell "how many" pages of a large folio
>> are mapped, but at least "is any page of this large folio mapped".
> 
> Exactly. AnonPages decreases by -1 when removed from the rmap,
> whereas nr_anon decreases by -1 when an anon folio is freed. So,
> I would assume nr_anon includes those pinned and unmapped anon
> folios but AnonPages doesn't.

Right, note how internally it is called "NR_ANON_MAPPED", but we ended 
up calling it "AnonPages". But that's rather a legacy interface we 
cannot change (fix) that easily. At least not without a config option.

At some point it might indeed be interesting to have "nr_anon_mapped", 
here, but that would correspond to "is any part of this large folio 
mapped". For debugging purposes in the future, that might be indeed 
interesting.

"nr_anon": anon allocations (until freed -> +1)
"nr_anon_mapped": anon allocations that are mapped (any part mapped -> +1)
"nr_anon_partially_mapped": anon allocations that was detected to be 
partially mapped at some point -> +1

If a folio is in the swapcache, I would still want to see that it is an 
anon allocation lurking around in the system. Like we do with pagecache 
pages. *There* we do have the difference between "allocated" and 
"mapped" already.

So likely, calling it "nr_anon" here, and tracking it on an allocation 
level, is good enough for now and future proof.

> 
> If there's a significant amount of 'leaked' anon, we should consider
> having a separate counter for them. For instance, if nr_anon is
> 100,000 and pinned/unmapped pages account for 50%, then nr_anon
> alone doesn’t effectively reflect the system's state.

Right, but if you stare at the system you could tell that a significant 
amount of memory is still getting consumed through existing/previous 
anon mappings. Depends on how valuable that distinction really is.

-- 
Cheers,

David / dhildenb


