Return-Path: <linux-kernel+bounces-382552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 824279B0FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADB4B230CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A85120F3F6;
	Fri, 25 Oct 2024 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bf1PDzEX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF0D20C319
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887708; cv=none; b=Aq+gIoQ9lnpxdKo6TaQc+XZ+93HVjfTJKcAips84yU+hfsX1agGCoGbZNgApjjwbbcZcu/kdhh6xOhRVERLtR/y56k1RyFqqY6xByON8ailEB8hGEJZDGe3rBAl6bfBWTQTzMLCFCuvZjyDNZNi9Kky1fE6qOhQGvnAOEQaEE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887708; c=relaxed/simple;
	bh=z3zkx4p+Cic+ogUQwpafUEstfpmBvoP+lZ9dGe+9d1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIdEps8a+5OD57nGjOg1lQa9ZxDRmoE1/nx1WSTTf3JGaQ+WTM9F/Mwslt5aLPedRQRIx15wdBLrx19claAo62cZPehy2rWkukVs8/B2KkbVa6q/jp6IU7m/Iel03cCWAXYwahaxCM+84V9fUvt/G2+0U4u43fZr046odTYh5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bf1PDzEX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729887704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hmWrcQHrubijNgrM9wcac0zcqNDx1DJ/kwEtlOjPgl0=;
	b=Bf1PDzEXsNGMl+7mYfBocfbwIrXWgIMszDk7vuBIxuYdB5D8fMKJX7mtofLyvLVmZvA4pM
	WywlDVKhIFScCUXkpIUEWxJI+JZg7viMLPEJdwjmS7Ja9ZORAfahGs/fcqltqhTMdjySts
	4RpvUIxJ3vSQnmHafuu8baE8Wq+0mzs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-KUBbe29XOJ2a9BypEHM1dQ-1; Fri, 25 Oct 2024 16:21:43 -0400
X-MC-Unique: KUBbe29XOJ2a9BypEHM1dQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4314f1e0f2bso16838005e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729887702; x=1730492502;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hmWrcQHrubijNgrM9wcac0zcqNDx1DJ/kwEtlOjPgl0=;
        b=v3WtPGiUV919aNKa3yScAsNzquCQ2ehkDRAa7hI21vWhqySPgQbEIF6OHePbVOeY27
         on7EUXk6b6ZhCC8x1l/25GDOsfl+WWjo752f9/iJIa98S2X4vuGvefhqrpcHRk374bKm
         yCWD28sr3J6oypQIxZQLUj8AxZ0KptpyQVQfZxSxJ162JG2Sq8qemrsgVaZ6kP/NP7Mp
         bLzNW2FQzOlE/fL9tS9C+Sfpo9Cm/7V7STrpYUcR7Dl0KTnfa2+9y4aS7k12nMu/SVSR
         P2ZUI5zkvyANPIi/BQhIdes1SPJKy8tEx4d6mDvz2XTMlXNGxX39tUN3Dlu7luYsqwU+
         GwWw==
X-Forwarded-Encrypted: i=1; AJvYcCX9sIw028tbCO1LAPPip10tiyffMnRWETzGc7O6nkJV5/7SO317qQI2bqZDRYp6zmmX4lP84RE22V8UlRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx67VNHdgkmRFFW63AIpDodw0IYli44kFpwpKa9A7QQFf766NBr
	jZc671B96A6bpJTN9jjZFSTli6RYBiabW63OrhlSgFC+RMBcddaUCqg8OT00IZeY2Ddl/babmlN
	BL1OqcaWE9IShf5rP8G2CFDBUIneGkD/tOvaee310DKcoMBZHj6Ag5DCvWEOesw==
X-Received: by 2002:a05:600c:1549:b0:42f:8fcd:486c with SMTP id 5b1f17b1804b1-4319ad368e9mr2619975e9.33.1729887702154;
        Fri, 25 Oct 2024 13:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjbnvAVlxjKP31jhI5Ajyw0uuqVffbfOd63N2W36Mf/XLghH9Cw7ZLJelowlHanECV71TPrg==
X-Received: by 2002:a05:600c:1549:b0:42f:8fcd:486c with SMTP id 5b1f17b1804b1-4319ad368e9mr2619785e9.33.1729887701689;
        Fri, 25 Oct 2024 13:21:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:d800:499c:485a:c734:f290? (p200300cbc70dd800499c485ac734f290.dip0.t-ipconnect.de. [2003:cb:c70d:d800:499c:485a:c734:f290])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b57b472sm59534015e9.43.2024.10.25.13.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 13:21:40 -0700 (PDT)
Message-ID: <cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com>
Date: Fri, 25 Oct 2024 22:21:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: Daniel Gomez <d@kruces.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 hughd@google.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
 <D51IU4N746MI.FDS6C7GYO4RP@samsung.com>
 <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com>
 <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com>
 <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com>
 <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com>
 <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the late reply!

>>>>> IMHO, as I discussed with Kirill, we still need maintain compatibility
>>>>> with the 'huge=' mount option. This means that if 'huge=never' is set
>>>>> for tmpfs, huge page allocation will still be prohibited (which can
>>>>> address Hugh's request?). However, if 'huge=' is not set, we can
>>>>> allocate large folios based on the write size.
> 
> So, in order to make tmpfs behave like other filesystems, we need to
> allocate large folios by default. Not setting 'huge=' is the same as
> setting it to 'huge=never' as per documentation. But 'huge=' is meant to
> control THP, not large folios, so it should not have a conflict here, or
> else, what case are you thinking?

I think we really have to move away from "huge/thp == PMD", that's a 
historical artifact. Everything else will simply be inconsistent and 
confusing in the future -- and I don't see any real need for that. For 
anonymous memory and anon shmem we managed the transition. (there is a 
longer writeup from me about this topic, so I won't go into detail).


I think I raised this in the past, but tmpfs/shmem is just like any 
other file system .. except it sometimes really isn't and behaves much 
more like (swappable) anonymous memory. (or mlocked files)

There are many systems out there that run without swap enabled, or with 
extremely minimal swap (IIRC until recently kubernetes was completely 
incompatible with swapping). Swap can even be disabled today for shmem 
using a mount option.

That's a big difference to all other file systems where you are 
guaranteed to have backend storage where you can simply evict under 
memory pressure (might temporarily fail, of course).

I *think* that's the reason why we have the "huge=" parameter that also 
controls the THP allocations during page faults (IOW possible memory 
over-allocation). Maybe also because it was a new feature, and we only 
had a single THP size.

There is, of course also the "fallocate() might not free up memory if 
there is an unexpected reference on the page because splitting it will 
fail" problem, that even exists when not over-allocating memory in the 
first place ...


So ...I don't think tmpfs behaves like other file system in some cases. 
And I don't think ignoring these points is a good idea.

Fortunately I don't maintain that code :)


If we don't want to go with the shmem_enabled toggles, we should 
probably still extend the documentation to cover "all THP sizes", like 
we did elsewhere.

huge=never: no THPs of any size
huge=always: THPs of any size (fault/write/etc)
huge=fadvise: like "always" but only with fadvise/madvise
huge=within_size: like "fadvise" but respect i_size

We could think about adding a "nowaste" extension and try make it the 
default.

For example

"huge=always:nowaste: THPs of any size as long as we don't over-allocate 
memory (write)"

The sysfs toggles have their beauty as well and could be useful (I'm 
pretty sure they will be useful :) ):

"huge=always;sysfs": THPs of any size (fault/write/etc) as configured in 
sysfs.

Too many options here to explore, too little time I have to spend on 
this. Just to throw out some ideas.

What I can really suggest is not making this one of the remaining 
interfaces where "huge" means "PMD-sized" once other sizes exist.

> 
>>>>
>>>> I consider allocating large folios in shmem/tmpfs on the write path less
>>>> controversial than allocating them on the page fault path -- especially
>>>> as long as we stay within the size to-be-written.
>>>>
>>>> I think in RHEL THP on shmem/tmpfs are disabled as default (e.g.,
>>>> shmem_enabled=never). Maybe because of some rather undesired
>>>> side-effects (maybe some are historical?): I recall issues with VMs with
>>>> THP+ memory ballooning, as we cannot reclaim pages of folios if
>>>> splitting fails). I assume most of these problematic use cases don't use
>>>> tmpfs as an ordinary file system (write()/read()), but mmap() the whole
>>>> thing.
>>>>
>>>> Sadly, I don't find any information about shmem/tmpfs + THP in the RHEL
>>>> documentation; most documentation is only concerned about anon THP.
>>>> Which makes me conclude that they are not suggested as of now.
>>>>
>>>> I see more issues with allocating them on the page fault path and not
>>>> having a way to disable it -- compared to allocating them on the write()
>>>> path.
>>>
>>> I may not understand your issues. IIUC, you can disable allocating huge
>>> pages on the page fault path by using the 'huge=never' mount option or
>>> setting shmem_enabled=deny. No?
>>
>> That's what I am saying: if there is some way to disable it that will
>> keep working, great.
> 
> I agree. That aligns with what I recall Hugh requested. However, I
> believe if that is the way to go, we shouldn't limit it to tmpfs.
> Otherwise, why should tmpfs be prevented from allocating large folios if
> other filesystems in the system are allowed to allocate them?

See above. On systems without/little swap you might not want them for 
shmem/tmpfs, but would happily use them elsewhere.

The "write() won't waste memory" case is really interesting, the 
"fallocate cannot free the memory" still exists. A shrinker might help.

-- 
Cheers,

David / dhildenb


