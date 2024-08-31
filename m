Return-Path: <linux-kernel+bounces-309844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FF19670FF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05FE283EFB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31C17BB3E;
	Sat, 31 Aug 2024 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXd9CpfY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A116EBEC
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102180; cv=none; b=nNJnudLfI3dD4Mv010+IX5Plgdnn+bzrNNdPVsGKAHh/qTnBNJugbeJ1392SfWC6SyExKzAr973NetgAvpxVSjESfoi/FVaGxmhqn1PUa7OZjZ/QBD6U9XOnyWnv12IbSBL/sr2thCaOrv2aC44X3dCqGO3b1v58+xPrfs6+XaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102180; c=relaxed/simple;
	bh=iPmV2YkbOPIVZzvqccKw8Xew6fRmHtiR7nqCy/SnXR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOu5XnruT5/kc0uwy75FPlN+rxKYb+A9bhA+sbKYfnxClXPVNARiba+N/RMHQMC62rGYBx7JjF48lQ5S4ZOFWKc0kQo1XwTcj5RfNgFl4L2dAJR9djT+CIT/hxwsevZXRXZhzfNJLnHtpZ4sDCT0m2h7ss/gqOPvWokNgOQszhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXd9CpfY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725102177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qDoL98Pt8qskSfE3fZxfS0+mDTtFmmEmKu1HOObEw2Y=;
	b=VXd9CpfYwTMwxKxx6n9dat2Dp33mbLoT/JM9nRVTAb2nkF7MnR8ZtwqG5WIh0sipReQHQE
	PABhFwDKS2oNyXrMTLmrrIPbYuWELXWkFfk98UrD27lWjd3rIHcr/esLm/Xs4NTiClzgxJ
	CCEgpaj4YiE2ncktXN5I+/OOaEabGQM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-6lWNymU-NZmObb8y8D-IHA-1; Sat, 31 Aug 2024 07:02:54 -0400
X-MC-Unique: 6lWNymU-NZmObb8y8D-IHA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374aef640a4so862166f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 04:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725102174; x=1725706974;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDoL98Pt8qskSfE3fZxfS0+mDTtFmmEmKu1HOObEw2Y=;
        b=pVmxtXcvuOelprp4ZZgQXN5cttBVxEkQTtGctaRM7ZJCUPHauYgBXuhqbRoIAanJxp
         +N2otjC7aT+4bYPjHd7J7lhwh5enp+MTX++vBEZHMPVrom2Xfz/FrrTluzlhkbYHLGUq
         yhoSoq7fX1/p9OHx8hRo6NeUHWCxX7vJClOMljZ+cgLKFfsWaLPESZyELtApO8E2FjNE
         AeKWdvTAXl4dgjkpdB5B7B0JZqESqw0X4EkjUA7p1vOz5Pa/6GtySlQKkexKEmxYmIln
         0hDEcKYpAtwtTLWJm0nXRy/Zrt+lwzVZoIlkr+UT8gis2mlSBhepgKh1PdyDh+hMYv8W
         KWPA==
X-Forwarded-Encrypted: i=1; AJvYcCWIbk1iC/MBmDw3kvnn+SMyljuFxXugsiBzK3WvniO0mHiRn6O6dpnJl7ls5KqBEN5rak/HTu5A7LgrXqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzdi+4yv5igyROyqGL9fi5uiSlgy+1yGdYhEPgSr6zAa9y2il
	VcBhn9R2yqSMkSMO+YT+Zk8ltdCPEzSyYz1WgEvE1Glmt69oiIHhnXGUP1nbvQsgKFi6URAGWKV
	eLkyzeunu6x+GdleRgxtaEgNnYrSvqqlwih0uZj5mKmiZjmXZmQq/pIamjcs0CA==
X-Received: by 2002:a05:6000:4388:b0:374:b9d0:f2c3 with SMTP id ffacd0b85a97d-374b9d0f45dmr1945678f8f.17.1725102173631;
        Sat, 31 Aug 2024 04:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0RHMGFj1+wi6NLafOUAoA0j2+BSSmSuALFG2vM0OID7Mbr6eIdMImFmR4xaTs5J7J/bHv1A==
X-Received: by 2002:a05:6000:4388:b0:374:b9d0:f2c3 with SMTP id ffacd0b85a97d-374b9d0f45dmr1945661f8f.17.1725102172644;
        Sat, 31 Aug 2024 04:02:52 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6ee6.dip0.t-ipconnect.de. [91.12.110.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c15705easm889193f8f.33.2024.08.31.04.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 04:02:52 -0700 (PDT)
Message-ID: <a0e654ac-dd69-4186-b1bd-3470a32e06d9@redhat.com>
Date: Sat, 31 Aug 2024 13:02:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: entirely reuse the whole anon mTHP in do_wp_page
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Chuanhua Han <hanchuanhua@oppo.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kalesh Singh <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>
References: <20240831092339.66085-1-21cnbao@gmail.com>
 <d0b826c1-8577-46f8-8e4c-ca2b72554819@redhat.com>
 <CAGsJ_4ynOeOaRb3=xBc1uETn9oLTkSpZGoEYGpTeJ1F4uqB7bA@mail.gmail.com>
 <b7853f0f-7044-4c49-931c-c61900229b19@redhat.com>
 <CAGsJ_4wwg-f32e=xSHn+Rxv5k7H6VXhUu3+v_ZOShL_mGn2Xew@mail.gmail.com>
 <36933711-ae0f-468c-93bd-d6a67d974c9d@redhat.com>
 <CAGsJ_4wzqK7Typyg1Nx9NCw5A5-1CjVp8LMR3CeGJNJ_UDKAQQ@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wzqK7Typyg1Nx9NCw5A5-1CjVp8LMR3CeGJNJ_UDKAQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31.08.24 12:49, Barry Song wrote:
> On Sat, Aug 31, 2024 at 10:29 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 31.08.24 12:21, Barry Song wrote:
>>> On Sat, Aug 31, 2024 at 10:07 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 31.08.24 11:55, Barry Song wrote:
>>>>> On Sat, Aug 31, 2024 at 9:44 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>> On 31.08.24 11:23, Barry Song wrote:
>>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>>
>>>>>>> On a physical phone, it's sometimes observed that deferred_split
>>>>>>> mTHPs account for over 15% of the total mTHPs. Profiling by Chuanhua
>>>>>>> indicates that the majority of these originate from the typical fork
>>>>>>> scenario.
>>>>>>> When the child process either execs or exits, the parent process should
>>>>>>> ideally be able to reuse the entire mTHP. However, the current kernel
>>>>>>> lacks this capability and instead places the mTHP into split_deferred,
>>>>>>> performing a CoW (Copy-on-Write) on just a single subpage of the mTHP.
>>>>>>>
>>>>>>>      main()
>>>>>>>      {
>>>>>>>      #define SIZE 1024 * 1024UL
>>>>>>>              void *p = malloc(SIZE);
>>>>>>>              memset(p, 0x11, SIZE);
>>>>>>>              if (fork() == 0)
>>>>>>>                      exec(....);
>>>>>>>             /*
>>>>>>>           * this will trigger cow one subpage from
>>>>>>>           * mTHP and put mTHP into split_deferred
>>>>>>>           * list
>>>>>>>           */
>>>>>>>          *(int *)(p + 10) = 10;
>>>>>>>          printf("done\n");
>>>>>>>          while(1);
>>>>>>>      }
>>>>>>>
>>>>>>> This leads to two significant issues:
>>>>>>>
>>>>>>> * Memory Waste: Before the mTHP is fully split by the shrinker,
>>>>>>> it wastes memory. In extreme cases, such as with a 64KB mTHP,
>>>>>>> the memory usage could be 64KB + 60KB until the last subpage
>>>>>>> is written, at which point the mTHP is freed.
>>>>>>>
>>>>>>> * Fragmentation and Performance Loss: It destroys large folios
>>>>>>> (negating the performance benefits of CONT-PTE) and fragments memory.
>>>>>>>
>>>>>>> To address this, we should aim to reuse the entire mTHP in such cases.
>>>>>>>
>>>>>>> Hi David,
>>>>>>>
>>>>>>> I’ve renamed wp_page_reuse() to wp_folio_reuse() and added an
>>>>>>> entirely_reuse argument because I’m not sure if there are still cases
>>>>>>> where we reuse a subpage within an mTHP. For now, I’m setting
>>>>>>> entirely_reuse to true only for the newly supported case, while all
>>>>>>> other cases still get false. Please let me know if this is incorrect—if
>>>>>>> we don’t reuse subpages at all, we could remove the argument.
>>>>>>
>>>>>> See [1] I sent out this week, that is able to reuse even without
>>>>>> scanning page tables. If we find the the folio is exclusive we could try
>>>>>> processing surrounding PTEs that map the same folio.
>>>>>>
>>>>>> [1] https://lkml.kernel.org/r/20240829165627.2256514-1-david@redhat.com
>>>>>
>>>>> Great! It looks like I missed your patch again. Since you've implemented this
>>>>> in a better way, I’d prefer to use your patchset.
>>>>
>>>> I wouldn't say better, just more universally. And while taking care of
>>>> properly sync'ing the mapcount vs. refcount :P
>>>>
>>>>>
>>>>> I’m curious about how you're handling ptep_set_access_flags_nr() or similar
>>>>> things because I couldn’t find the related code in your patch 10/17:
>>>>>
>>>>> [PATCH v1 10/17] mm: COW reuse support for PTE-mapped THP with CONFIG_MM_ID
>>>>>
>>>>> Am I missing something?
>>>>
>>>> The idea is to keep individual write faults as fast as possible. So the
>>>> patch set keeps it simple and only reuses a single PTE at a time,
>>>> setting that one PAE and mapping it writable.
>>>
>>> I got your point, thanks! as anyway the mTHP has been exclusive,
>>> so the following nr-1 minor page faults will set their particular PTE
>>> to writable one by one.
>>
>> Yes, assuming you would get these page faults, and assuming you would
>> get them in the near future.
>>
>>>
>>>>
>>>> As the patch states, it might be reasonable to optimize some cases,
>>>> maybe also only on some architectures. For example to fault-around and
>>>> map the other ones writable as well. It might not always be desirable
>>>> though, especially not for larger folios.
>>>
>>> as anyway, the mTHP has been entirely exclusive, setting all PTEs
>>> directly to writable should help reduce nr - 1 minor page faults and
>>> ideally help reduce CONTPTE unfold and fold?
>>
>> Yes, doing that on CONTPTE granularity would very likely make sense. For
>> anything bigger than that, I am not sure.
>>
>> Assuming we have a 1M folio mapped by PTEs. Trying to fault-around in
>> aligned CONTPTE granularity likely makes sense. Bigger than that, I am
>> not convinced.
>>
> 
> I see. maybe we can have something like:
> 
> static bool pte_fault_around_estimate(int nr)
> {
>         if (nr / arch_batched_ptes_nr() < 16)
>               return true;
> 
>         return false;
> }
> 
> if (pte_fault_around_estimate(folio_nr_pages(folio)))
>         set all ptes;
> 
> for arm64, arch_batched_ptes_nr()  == 16. for
> arch without cont-pte or similar things,
> arch_batched_ptes_nr()  == 1.

Yes, something like that would be my take.

After we know that we can reuse the large folio, we'll try scanning 
starting from the aligned PTE. If we find that we can batch, we'll batch 
that part. Otherwise we'll simply fallback to a single one.

Handling batching across VMAs is a bit harder. We might be able to 
batch, or might not ... We could have the CONT_PTE bit set across VMAs, 
but might not necessarily be able to batch (e.g., some VMAs are read-only).

> 
> Just some rough ideas; all the naming might be quite messy.
> 
> at least, we won't lose the benefit of reduced TLB miss
> before all nr_pages are written for aarch64 :-)
> 
>>>
>>> What is the downside to doing that? I also don't think mapping them
>>> all together will waste memory?
>>
>> No, it's all about increasing the latency of individual write faults.
>>
> 
> i see, i assume it won't be worse than the current case where we have to
> allocate small folios and copy? and folio allocation can even further incur
> direct reclamation?

Yes, it would certainly better than what we currently have. Almost 
everything would likely be better than what we currently have. :)

-- 
Cheers,

David / dhildenb


