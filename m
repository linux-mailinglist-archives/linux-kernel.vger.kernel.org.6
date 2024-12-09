Return-Path: <linux-kernel+bounces-437824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0279E9937
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA351282583
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889C71B043D;
	Mon,  9 Dec 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw7LGS7P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730E35972
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755476; cv=none; b=eYiiq1A10Juk/2uxMjPEcX0COwXfv2SE0uf8Yc5IDiA1MFb3cqgYI+kUxHdYQ34W1CyVcCGEazpi+vu96P9Hbw4LCO8J70GfKQ7MdHWoJryUbbkIH6uRey8c8DOuOdTGkBIvdg1ULgnDBYNO4vSMYo590lIeyihlk9HDDTJ8840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755476; c=relaxed/simple;
	bh=POzevi/sJR16lnIZCSJAVx3hMA4/ae08fxgLzwtMwrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i57dLQ3zWYu+ylBAJGsN+YWo9qwINNkKm3cIRhNrM7HD4DD6qAYHh9hw19yy3nBwSdZrAPoeIMu7od/nrf8x5twM263P1E3Y3qdf17VjPGOfXurLlzzLGLVeJxlJXJ0bkSGUTl228bnoenLuw1ddp8u8NyDHxSc9VOAf3NbHfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fw7LGS7P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733755473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5CbBUgvwO9PF2a6CtW8LBTEhmt4KZFC1qy1+8e37Py8=;
	b=Fw7LGS7Pist8RvrHlmoiSH9exv8NdJ8IPQQzmmiuFGRjBOzUiRRGmSFhzCjn3jXjK1uyL1
	L75LaCnSv7Ge7JCSTvonrhoHCbvkiVQdNYqSc+lD6xyT5XNwV6TohzURDl6wpnOxhIG5od
	qr1vZRSfSrsI8ho5vS1fJYtBhKjNz8Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-iDevHNEYOEuBko7Drv-TNg-1; Mon, 09 Dec 2024 09:44:32 -0500
X-MC-Unique: iDevHNEYOEuBko7Drv-TNg-1
X-Mimecast-MFC-AGG-ID: iDevHNEYOEuBko7Drv-TNg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f40667e5so8745335e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755471; x=1734360271;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CbBUgvwO9PF2a6CtW8LBTEhmt4KZFC1qy1+8e37Py8=;
        b=Mnc36JSfhCAtpAXA+CbcpFiWyI2+NJ1dISnmc0s9ScIMMyCyTl+e33WK1ojt58ZgLp
         T97DIXD1DXxX5MXqcg9gLefm7rkRLBKRIwScFTO00wKRNIzphMR6ujOuZlw2RssKOCMe
         MwOrfwl0ixtaIsxmanW5L9knLVse5ta0ixecOwsC5zbiXCxV5+vMC5nZJ8mljrPN4SbP
         Y+Tmx6YlusQ+Xn4+SQaSMPuQ1kvWJYlfZcSpsBueVuKp13CB1maDszwsW9zjgN0eJEnP
         IP2RatURS3+QRp0zR1OU2dgJAzyBMlfH4TEzSe6hOdFVZtxFL+FhpmW6pfxwm+PCV0IF
         z5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzdVG5fPBDzdrAk7DyviX/zEkn3j+tCNKsOIVheSyg36+dsAkL5qS6uJJF6qpxoZShQEIQznUL68lLWBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRt3dMbeLCbHXwmCE2Uxr6RuHGD5boqcZodvTnOo9rJBe18HeL
	IypI1ggq3jWwMp4cR3ZlCryiZmzkAwElbSr9AJjdUblRdRSgdRXrJs5FCVoyZnxBZh8bKlXhfgy
	LNltM9tbNDay1SE4KE6o6TtyRUWiFlYSDOjfJ2hQ1Oas6R/XvaP2Nq9rMxb6deA==
X-Gm-Gg: ASbGnctAqYrNhvTBZzrdZir9dsgfIYL4gPWxUwlglDN9IdzqjzdkC+rKZ58szWD5dFu
	X3GNXXabQtvr0pc+3ICip7fA6A7gQGP38vqJxapE0Um1n+JqOIZOWu159vlUJOVj9EeZ77NYEvB
	wtBm3vuMRWFIxUbvxJ2zPTm80NQptijzUhZrxYFaPnL0BoMhkIYLc75lObLz76DUReyguODrHAZ
	YtyLP30bfCFoADYPEyJzHQhtDCJ/VGPMI7qCQt1niMxLgqEcXo2Of91cSyyV/U6aIlXIO61BZ4O
	D/w9erVf
X-Received: by 2002:a05:6000:178e:b0:385:e1a8:e2a1 with SMTP id ffacd0b85a97d-386453d2830mr645633f8f.3.1733755470939;
        Mon, 09 Dec 2024 06:44:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYNF1nXizPyJ4CmmmTmUlpFe31fC62Fm81HOC0AiOSanO+UFM5T9A+s/Oi03hYC4PikjUgZw==
X-Received: by 2002:a05:6000:178e:b0:385:e1a8:e2a1 with SMTP id ffacd0b85a97d-386453d2830mr645610f8f.3.1733755470508;
        Mon, 09 Dec 2024 06:44:30 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862e3fe716sm10052540f8f.7.2024.12.09.06.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:44:29 -0800 (PST)
Message-ID: <9ee8d6a9-12ef-4393-96db-40c3fd35387f@redhat.com>
Date: Mon, 9 Dec 2024 15:44:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
To: Jann Horn <jannh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
 <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
 <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.12.24 15:38, Jann Horn wrote:
> On Mon, Dec 9, 2024 at 3:11 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>> On Mon, Dec 09, 2024 at 03:00:08PM +0100, David Hildenbrand wrote:
>>> On 09.12.24 14:25, Vlastimil Babka wrote:
>>>> On 12/9/24 10:16, David Hildenbrand wrote:
>>>>> On 06.12.24 20:16, Lorenzo Stoakes wrote:
>>>>>> There are a number of means of interacting with VMA operations within mm,
>>>>>> and we have on occasion not been made aware of impactful changes due to
>>>>>> these sitting in different files, most recently in [0].
>>>>>>
>>>>>> Correct this by bringing all VMA operations under the same section in
>>>>>> MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
>>>>>> with VMA as there needn't be two entries as they amount to the same thing.
>>>>>>
>>>>>> [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
>>>>>>
>>>>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>>> ---
>>>>>>     MAINTAINERS | 19 +++++++------------
>>>>>>     1 file changed, 7 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 1e930c7a58b1..95db20c26f5f 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -15060,18 +15060,6 @@ F:     tools/mm/
>>>>>>     F:   tools/testing/selftests/mm/
>>>>>>     N:   include/linux/page[-_]*
>>>>>>
>>>>>> -MEMORY MAPPING
>>>>>> -M:     Andrew Morton <akpm@linux-foundation.org>
>>>>>> -M:     Liam R. Howlett <Liam.Howlett@oracle.com>
>>>>>> -M:     Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>>> -R:     Vlastimil Babka <vbabka@suse.cz>
>>>>>> -R:     Jann Horn <jannh@google.com>
>>>>>> -L:     linux-mm@kvack.org
>>>>>> -S:     Maintained
>>>>>> -W:     http://www.linux-mm.org
>>>>>> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>>>> -F:     mm/mmap.c
>>>>>> -
>>>>>>     MEMORY TECHNOLOGY DEVICES (MTD)
>>>>>>     M:   Miquel Raynal <miquel.raynal@bootlin.com>
>>>>>>     M:   Richard Weinberger <richard@nod.at>
>>>>>> @@ -25028,6 +25016,13 @@ L:     linux-mm@kvack.org
>>>>>>     S:   Maintained
>>>>>>     W:   https://www.linux-mm.org
>>>>>>     T:   git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>>>> +F:     mm/madvise.c
>>>>>> +F:     mm/mlock.c
>>>>>> +F:     mm/mmap.c
>>>>>> +F:     mm/mprotect.c
>>>>>> +F:     mm/mremap.c
>>>>>> +F:     mm/mseal.c
>>>>>> +F:     mm/msync.c
>>>>>
>>>>> Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that
>>>>> the real "magic" they perform is in page table handling and not
>>>>> primarily VMA handling (yes, both do VMA changes, but they are the
>>>>> "easy" part ;) ).
>>>>
>>>> I'd think that moving vma files into MEMORY MAPPING (and not the other way)
>>>> would result in a better overal name, that would be a better fit for the
>>>> newly added files too?
>>>
>>> Maybe. I think vma.c should likely have a different set of maintainers than
>>> madvise.c and mprotect.c. (again, the magic is in page table modifications)
>>
>> The bulk of the logic in mremap.c is related to page tables so by this
>> logic then, that is out too, right?
> 
> FWIW, I think technically you can have multiple entries in MAINTAINERS
> that cover the same file, maybe that would make sense for files that
> belong to multiple parts of the kernel?

I was asking myself the same question. But then ...

> Or maybe I'm making things too
> complicated and it'd be simpler to have some kind of more generic
> "core MM for userspace mappings" entry or such.

... this sound cleaner than having files as part of every section with 
which they partially overlap.

-- 
Cheers,

David / dhildenb


