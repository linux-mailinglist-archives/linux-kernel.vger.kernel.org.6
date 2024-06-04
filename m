Return-Path: <linux-kernel+bounces-200393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED658FAF74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0453281FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B301448FD;
	Tue,  4 Jun 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpDYzby7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F782D98
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495199; cv=none; b=BhIgB/qIcgetyHco5ZywLfjde0gYclaX0Fbzm1FMttAA5cjOHbaiNQLUqKcTtMDGZVh1l/mS5Plc82+5CJL+BQpFwdZGiMjU9M61J2gjvnUgng7zI3f5FkFWBZsXEZSXg7FO7ZKBp/1WNvjfww55B7qTK3VNrNMc+Mn/1cDQbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495199; c=relaxed/simple;
	bh=VYu2mJliSuKCU5sTwvjS8bLRKwjboMt+368zib0t1Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpdvbPFmkhb5z9di6pJHjcY5wJRQlJlOFbadun5PZsYJXe4BUB3LB/IHckSOH2V/XgtOKRFgZwB4QVeRnPhXQgiB6oHLf1fwVsHBYIAMAUVgtQUxysORYvL4wkoNMIrwlRd8uJXegUGc+/JXfxvEfOd5m3V+1YNC3YwCmkKXmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpDYzby7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717495196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wVoH4P3Cx/h5FCJ6BPkD4KZpIKTJO7+BBiXGstNuXzQ=;
	b=NpDYzby7H7D4+f9EIk5t0uzrukkTITz0txcO3ngQBfQuP86eWvfE7SFHFpzNY+YTgMwmoy
	gYAZ99RQiTpdq9egqeRLJvI9t2mPC5B/RYnQoM+p4Kh7msFRTFb0Bx6bGFxmJrcMKLdElG
	Edr1pW/5kz2ONjhaDVq7mykJ8f7r53E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-4044vRBoPQmj6pxZYb5h9A-1; Tue, 04 Jun 2024 05:59:54 -0400
X-MC-Unique: 4044vRBoPQmj6pxZYb5h9A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4212a3dd9b6so24858155e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717495193; x=1718099993;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wVoH4P3Cx/h5FCJ6BPkD4KZpIKTJO7+BBiXGstNuXzQ=;
        b=Yo/B2DHFX7Q2ZFgtJsCINbjZMuW3kbcxLRAJ7C3OBk2wIShd1N1+q8SHKRS4WuIIUZ
         bepUUNj+5C+l2GReM1FxWNNHqi4UKV7s4Rang/x1RTqUtR2Q73zHo3cNfl4SgRpjVp71
         B2PkBYpGheHsUM6zA01BawGR12mJVzvOyCZcU8pAxk3KJRARlVric/N5/FZkvwMF43kQ
         rOmoVtjeavQrNoWs66JxQUUxWDE/eNQI5vXO7wbRcdTD0woBqqRlr895Ljs0OmX2oX15
         HTsfevsx+EH6bJJtU1rMe/0t1WzrF7nV+bsuG5veSqFIzE0MrTvAG5UTsvVbNu7nNznp
         3Ojw==
X-Forwarded-Encrypted: i=1; AJvYcCUbnnBDQ+w1coG/hgHCHG2rbg3mUzJqp3mGreD5gVLn9NGKc1hSpfrmzzBHY7KRkI87Ue7tEm8kF7m7bnHK6an+KCqNZMQti7N5faJf
X-Gm-Message-State: AOJu0YzRiZ66cJp+BJPQRIFO1J03LF1XfvdllT7AKsCgw5fQ+pppn2Oj
	Ss8QvwFhfqMaF3bGx9CPyI0isrJ0KRe7Wjttu3JjrVjWhQxCqDTkMO+yBGCcADgobsc+w64eCVy
	dRxf7gW7I34J++EsczBnTDobp4oZdTGkO1NLcHCWCDyD2Q7JkxP3g6sAYZW2zgQ==
X-Received: by 2002:a05:600c:1394:b0:420:1f0f:fe19 with SMTP id 5b1f17b1804b1-4212e049fdbmr118883795e9.13.1717495193456;
        Tue, 04 Jun 2024 02:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLZrrQvWpKUrJIVpbe90XU6b2mEVhg92J/BPG89PnNAeQfvJxmsrWp7Di85+n69Yq/auVq5g==
X-Received: by 2002:a05:600c:1394:b0:420:1f0f:fe19 with SMTP id 5b1f17b1804b1-4212e049fdbmr118883565e9.13.1717495192988;
        Tue, 04 Jun 2024 02:59:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127069305sm178112235e9.22.2024.06.04.02.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 02:59:52 -0700 (PDT)
Message-ID: <8e10beae-b3cd-4f5a-8e50-3f6dfe75ba9f@redhat.com>
Date: Tue, 4 Jun 2024 11:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <CGME20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a@eucas1p2.samsung.com>
 <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
 <vlkkfcyumveggkddb6d44f55gtx4qonoiijxyofa63mtmkuofv@uf4nbw3r5ysh>
 <f0618bca-119b-417a-a19d-699084476f88@redhat.com>
 <zz23hukm6kpguehfsxmzdtam34bj2opt63oesspwsikw57bpqy@eftgscqy3bly>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <zz23hukm6kpguehfsxmzdtam34bj2opt63oesspwsikw57bpqy@eftgscqy3bly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[...]

>>> How can we use per-block tracking for reclaiming memory and what changes would
>>> be needed? Or is per-block really a non-viable option?
>>
>> The interesting thing is: with mTHP toggles it is opt-in -- like for
>> PMD-sized THP with shmem_enabled -- and we don't have to be that concerned
>> about this problem right now.
> 
> Without respecting the size when allocating large folios, mTHP toggles would
> over allocate. My proposal added earlier to this thread is to combine the 2
> to avoid that case. Otherwise, shouldn't we try to find a solution for the
> reclaiming path?

I think at some point we'll really have to do a better job at reclaiming 
(either memory-overallocation, PUNCHHOLE that couldn't split, but maybe 
also pages that are now all-zero again and could be reclaimed again).

> 
>>
>>>
>>> Clearly, if per-block is viable option, shmem_fault() bug would required to be
>>> fixed first. Any ideas on how to make it reproducible?
>>>
>>> The alternatives discussed where sub-page refcounting and zeropage scanning.
>>
>> Yeah, I don't think sub-page refcounting is a feasible (and certainly not
>> desired ;) ) option in the folio world.
>>
>>> The first one is not possible (IIUC) because of a refactor years back that
>>> simplified the code and also requires extra complexity. The second option would
>>> require additional overhead as we would involve scanning.
>>
>> We'll likely need something similar (scanning, tracking?) for anonymous
>> memory as well. There was a proposal for a THP shrinker some time ago, that
>> would solve part of the problem.
> 
> It's good to know we have the same problem in different places. I'm more
> inclined to keep the information rather than adding an extra overhead. Unless
> the complexity is really overwhelming. Considering the concerns here, not sure
> how much should we try merging with iomap as per Ritesh's suggestion.

As raised in the meeting, I do see value in maintaining the information; 
but I also see why Hugh and Kirill think this might be unwarranted 
complexity in shmem.c. Meaning: we might be able to achieve something 
similar without it, and we don't have to solve the problem right now to 
benefit from large folios.

> 
> The THP shrinker, could you please confirm if it is this following thread?
> 
> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/

Yes, although there was no follow up so far. Possibly, because in the 
current khugepaged approach, there will be a constant back-and-forth 
between khugepaged collapsing memory (and wasting memory in the default 
setting), and the THP shrinker reclaiming memory; doesn't sound quite 
effective :) That needs more thought IMHO.

[...]

>>>> To optimize FALLOC_FL_PUNCH_HOLE for the cases where splitting+freeing
>>>> is not possible at fallcoate() time, detecting zeropages later and
>>>> retrying to split+free might be an option, without per-block tracking.
>>>
>>>>
>>>> (2) mTHP controls
>>>>
>>>> As a default, we should not be using large folios / mTHP for any shmem, just
>>>> like we did with THP via shmem_enabled. This is what this series currently
>>>> does, and is aprt of the whole mTHP user-space interface design.
>>>
>>> That was clear for me too. But what is the reason we want to boot in 'safe
>>> mode'? What are the implications of not respecing that?
>>
>> [...]
>>
>>>
>>> As I understood from the call, mTHP with sysctl knobs is preferred over
>>> optimistic falloc/write allocation? But is still unclear to me why the former
>>> is preferred.
>>
>> I think Hugh's point was that this should be an opt-in feature, just like
>> PMD-sized THP started out, and still is, an opt-in feature.
> 
> I'd be keen to understand the use case for this. Even the current THP controls
> we have in tmpfs. I guess these are just scenarios with no swap involved?
> Are these use cases the same for both tmpfs and shmem anon mm?

Systems without swap are one case I think. The other reason for a toggle 
in the past was to be able to disable it to troubleshoot issues (Hugh 
mentioned in the meeting about unlocking new code paths in shmem.c only 
with a toggle).

Staring at my Fedora system:

$ cat /sys/kernel/mm/transparent_hugepage/shmem_enabled
always within_size advise [never] deny force

Maybe because it uses tmpfs to mount /tmp (interesting article on 
lwn.net about that) and people are concerned about the side-effects 
(that can currently waste memory, or result in more reclaim work being 
required when exceeding file sizes).

For VMs, I know that shmem+THP with memory ballooning is problematic and 
not really recommended.

[...]

>>>
>>>>
>>>> Also, we should properly fallback within the configured sizes, and not jump
>>>> "over" configured sizes. Unless there is a good reason.
>>>>
>>>> (3) khugepaged
>>>>
>>>> khugepaged needs to handle larger folios properly as well. Until fixed,
>>>> using smaller THP sizes as fallback might prohibit collapsing a PMD-sized
>>>> THP later. But really, khugepaged needs to be fixed to handle that.
>>>>
>>>> (4) force/disable
>>>>
>>>> These settings are rather testing artifacts from the old ages. We should not
>>>> add them to the per-size toggles. We might "inherit" it from the global one,
>>>> though.
>>>>
>>>> "within_size" might have value, and especially for consistency, we should
>>>> have them per size.
>>>>
>>>>
>>>>
>>>> So, this series only tackles anonymous shmem, which is a good starting
>>>> point. Ideally, we'd get support for other shmem (especially during fault
>>>> time) soon afterwards, because we won't be adding separate toggles for that
>>>> from the interface POV, and having inconsistent behavior between kernel
>>>> versions would be a bit unfortunate.
>>>>
>>>>
>>>> @Baolin, this series likely does not consider (4) yet. And I suggest we have
>>>> to take a lot of the "anonymous thp" terminology out of this series,
>>>> especially when it comes to documentation.
>>>>
>>>> @Daniel, Pankaj, what are your plans regarding that? It would be great if we
>>>> could get an understanding on the next steps on !anon shmem.
>>>
>>> I realize I've raised so many questions, but it's essential for us to grasp the
>>> mm concerns and usage scenarios. This understanding will provide clarity on the
>>> direction regarding folios for !anon shmem.
>>
>> If I understood correctly, Hugh had strong feelings against not respecting
>> mTHP toggles for shmem. Without per-block tracking, I agree with that.
> 
> My understanding was the same. But I have this follow-up question: should
> we respect mTHP toggles without considering mapping constraints (size and
> index)? Or perhaps we should use within_size where we can fit this intermediate
> approach, as long as mTHP granularity is respected?

Likely we should do exactly the same as we would do with the existing 
PMD-sized THPs.

I recall in the meeting that we discussed that always vs. within_size 
seems to have some value, and that we should respect that setting like 
we did for PMD-sized THP.

Which other mapping constraints could we have?

-- 
Cheers,

David / dhildenb


