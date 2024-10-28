Return-Path: <linux-kernel+bounces-385927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CADD9B3D31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0372B23607
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6851FA25F;
	Mon, 28 Oct 2024 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9QJSs5B"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937461F8923
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152177; cv=none; b=t0rujEZ/oH7jkwoA8B4fuB35QkhytfPK9Qzg36CeKHkGrP0aFBeZqCiNfVB6wFeLWKdFFu6sgmLgHS/6G+Fu+dtbe82oyJuDHSUQHOybDZ3I2jI2U2prewwRf8Vkt28LQxtD6RaGg5Q2DADRBDkeFB9kAnvG/h2or5HbQ4TjWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152177; c=relaxed/simple;
	bh=EduMrMgbD2nD/2fOiVX3x4kGX+AOQJYRv2f3E4m0Vl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9j4b5fMw+nTDFLW2SmbpExGaRcqMOrxTukCihYjbr0XcWtpMWuVzSEFutHqKHrfksOln3f/aasonagFrj9+BFmTlmxajt1lJi+ZmqVIBPnTHwzVKbhuGDHnjETlcVcuYjDicritUmEJYMc/0Ph9f6gryBwesRS4zbn17H37MsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9QJSs5B; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so3604728f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730152173; x=1730756973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XO3H5j6J/WmlRFSlHkbEU0ETCY9Im5nCuCwAUQ3PVPs=;
        b=i9QJSs5BYnP/lKkknhdrW2WqmmDQiXbec+bYiKZpTxzYTqMijQ4zy9A/2/nCSy9Pay
         BCymTz2uw3uLOu3AJatDLm+j/1f6wgPb8UjpI7TfXNTu22DtKDjErvk4pWC0VR6BlESQ
         kcOMg4QZAqe/8BIf7OScjsFrJ1smkvuQz+3p6IVoeMJdSAacxa4WsutMUpDvRS936IJw
         Ee7zJMr0Yp69LQrkE3A/0YJZuQuORyUUjYhNak0vI/kDOpPsBELcwwQkxyaRz1Sclutv
         ZELbyFanp10qDbevCDR8qVCDctGqFiKA6QcxtD+IVdmwyGZS1lZXROHnN3TtnARSBP9G
         4Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730152173; x=1730756973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XO3H5j6J/WmlRFSlHkbEU0ETCY9Im5nCuCwAUQ3PVPs=;
        b=oF3QbzUFrp7Yl8zrFLVqfkoyjA1XurKF+EyfLoz0PyLCwxPj/sKJUFfYmSfkhcmoB9
         72A3m+1PcvIxiBembCtc5tWm7BriTJ4PysOw4m/HiVd+tHq18Att5deUqYjn4qKFvdFF
         ac4BAs0BLLmHW2/A6rb0axv938jguzCWpbXBVfK0pinmDR7gLx5KqMizyovh+09swjti
         ItqNlV7ifpv0w/nCSFrk/wbvoFdudiUotjqAxeyMvcuxyoMDjeQcuQIt+ffC1T0SX+Kh
         gqnzJDYBHo2l+BJ9dcK1ycN53rZ65WsItEw3JSBGRqP2wSyriCd7A9CsIzvE1jiToeZB
         ooRA==
X-Forwarded-Encrypted: i=1; AJvYcCVk+4DxvLyhx0cPTxhXDh7i+iUAfTCA7nGu2zWXCH1VrP42pcKVlJo+ytpe7cCf6Pbu1qRnPYIeoKTW9aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfqt/tCD6z0a34xEPuDDLEhnqibf0UlTpTm3NigDjpaOCdDRX
	LpT2lcCCMzaKh6IhFCnrDTtacPpNOb1XNYc9n7v7CrEzuguLfrob
X-Google-Smtp-Source: AGHT+IG1MD2qgJ9KIYNW+Q2mPpGwDncXo2JyviNYVmjTUIulUEOs0xx7Bq0d6IRdoe49a1ypOQuNYw==
X-Received: by 2002:adf:ea91:0:b0:37c:d4f8:3f2e with SMTP id ffacd0b85a97d-3806120d60amr7296672f8f.55.1730152172604;
        Mon, 28 Oct 2024 14:49:32 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a3edasm124938175e9.22.2024.10.28.14.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 14:49:32 -0700 (PDT)
Message-ID: <03d4c776-4b2e-4f3d-94f0-9b716bfd74d2@gmail.com>
Date: Mon, 28 Oct 2024 21:49:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andi Kleen <ak@linux.intel.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
References: <20241027011959.9226-1-21cnbao@gmail.com>
 <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com>
 <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
 <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com>
 <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
 <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com>
 <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
 <882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com>
 <CAGsJ_4yBkry-rw75AciT8OiYWrw+=D0okcxiyXzzNrz=QJxiBA@mail.gmail.com>
 <cba36cb0-66c7-45c1-97c3-a96ea48a6cf0@gmail.com>
 <CAGsJ_4wXO2Hjs0HZBGsGegBAeE8YxJbCF6ZXQQ6ZnVxgR82AuQ@mail.gmail.com>
 <228c428d-d116-4be1-9d0d-0591667b7ccb@gmail.com>
 <CAGsJ_4zLNA-1+3j4snNLiujT3NLcmKEVFA4+eD1Sk1bOkqAGYw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4zLNA-1+3j4snNLiujT3NLcmKEVFA4+eD1Sk1bOkqAGYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/10/2024 21:40, Barry Song wrote:
> On Tue, Oct 29, 2024 at 5:24 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 28/10/2024 21:15, Barry Song wrote:
>>> On Tue, Oct 29, 2024 at 4:51 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 28/10/2024 20:42, Barry Song wrote:
>>>>> On Tue, Oct 29, 2024 at 4:00 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 28/10/2024 19:54, Barry Song wrote:
>>>>>>> On Tue, Oct 29, 2024 at 1:20 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 28/10/2024 17:08, Yosry Ahmed wrote:
>>>>>>>>> On Mon, Oct 28, 2024 at 10:00 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 28/10/2024 16:33, Nhat Pham wrote:
>>>>>>>>>>> On Mon, Oct 28, 2024 at 5:23 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> I wonder if instead of having counters, it might be better to keep track
>>>>>>>>>>>> of the number of zeropages currently stored in zeromap, similar to how
>>>>>>>>>>>> zswap_same_filled_pages did it. It will be more complicated then this
>>>>>>>>>>>> patch, but would give more insight of the current state of the system.
>>>>>>>>>>>>
>>>>>>>>>>>> Joshua (in CC) was going to have a look at that.
>>>>>>>>>>>
>>>>>>>>>>> I don't think one can substitute for the other.
>>>>>>>>>>
>>>>>>>>>> Yes agreed, they have separate uses and provide different information, but
>>>>>>>>>> maybe wasteful to have both types of counters? They are counters so maybe
>>>>>>>>>> dont consume too much resources but I think we should still think about
>>>>>>>>>> it..
>>>>>>>>>
>>>>>>>>> Not for or against here, but I would say that statement is debatable
>>>>>>>>> at best for memcg stats :)
>>>>>>>>>
>>>>>>>>> Each new counter consumes 2 longs per-memcg per-CPU (see
>>>>>>>>> memcg_vmstats_percpu), about 16 bytes, which is not a lot but it can
>>>>>>>>> quickly add up with a large number of CPUs/memcgs/stats.
>>>>>>>>>
>>>>>>>>> Also, when flushing the stats we iterate all of them to propagate
>>>>>>>>> updates from per-CPU counters. This is already a slowpath so adding
>>>>>>>>> one stat is not a big deal, but again because we iterate all stats on
>>>>>>>>> multiple CPUs (and sometimes on each node as well), the overall flush
>>>>>>>>> latency becomes a concern sometimes.
>>>>>>>>>
>>>>>>>>> All of that is not to say we shouldn't add more memcg stats, but we
>>>>>>>>> have to be mindful of the resources.
>>>>>>>>
>>>>>>>> Yes agreed! Plus the cost of incrementing similar counters (which ofcourse is
>>>>>>>> also not much).
>>>>>>>>
>>>>>>>> Not trying to block this patch in anyway. Just think its a good point
>>>>>>>> to discuss here if we are ok with both types of counters. If its too wasteful
>>>>>>>> then which one we should have.
>>>>>>>
>>>>>>> Hi Usama,
>>>>>>> my point is that with all the below three counters:
>>>>>>> 1. PSWPIN/PSWPOUT
>>>>>>> 2. ZSWPIN/ZSWPOUT
>>>>>>> 3. SWAPIN_SKIP/SWAPOUT_SKIP or (ZEROSWPIN, ZEROSWPOUT what ever)
>>>>>>>
>>>>>>> Shouldn't we have been able to determine the portion of zeromap
>>>>>>> swap indirectly?
>>>>>>>
>>>>>>
>>>>>> Hmm, I might be wrong, but I would have thought no?
>>>>>>
>>>>>> What if you swapout a zero folio, but then discard it?
>>>>>> zeromap_swpout would be incremented, but zeromap_swapin would not.
>>>>>
>>>>> I understand. It looks like we have two issues to tackle:
>>>>> 1. We shouldn't let zeromap swap in or out anything that vanishes into
>>>>> a black hole
>>>>> 2. We want to find out how much I/O/memory has been saved due to zeromap so far
>>>>>
>>>>> From my perspective, issue 1 requires a "fix", while issue 2 is more
>>>>> of an optimization.
>>>>
>>>> Hmm I dont understand why point 1 would be an issue.
>>>>
>>>> If its discarded thats fine as far as I can see.
>>>
>>> it is fine to you and probably me who knows zeromap as well :-) but
>>> any userspace code
>>> as below might be entirely confused:
>>>
>>> p = malloc(1G);
>>> write p to 0; or write part of p to 0
>>> madv_pageout(p, 1g)
>>> read p to swapin.
>>>
>>> The entire procedure used to involve 1GB of swap out and 1GB of swap in by any
>>> means. Now, it has recorded 0 swaps counted.
>>>
>>> I don't expect userspace is as smart as you :-)
>>>
>> Ah I completely agree, we need to account for it in some metric. I probably
>> misunderstood when you said "We shouldn't let zeromap swap in or out anything that
>> vanishes into a black hole", by we should not have the zeromap optimization for those
>> cases. What I guess you meant is we need to account for it in some metric.
>>
>>>>
>>>> As a reference, memory.stat.zswapped != memory.stat.zswapout - memory.stat.zswapin.
>>>> Because zswapped would take into account swapped out anon memory freed, MADV_FREE,
>>>> shmem truncate, etc as Yosry said about zeromap, But zswapout and zswapin dont.
>>>
>>> I understand. However, I believe what we really need to focus on is
>>> this: if we’ve
>>> swapped out, for instance, 100GB in the past hour, how much of that 100GB is
>>> zero? This information can help us assess the proportion of zero data in the
>>> workload, along with the potential benefits that zeromap can provide for memory,
>>> I/O space, or read/write operations. Additionally, having the second count
>>> can enhance accuracy when considering MADV_DONTNEED, FREE, TRUNCATE,
>>> and so on.
>>>
>> Yes completely agree!
>>
>> I think we can look into adding all three metrics, zeromap_swapped, zeromap_swpout,
>> zeromap_swpin (or whatever name works).
> 
> It's great to reach an agreement. Let me work on some patches for it.

Thanks!

> 
> By the way, I recently had an idea: if we can conduct the zeromap check
> earlier - for example - before allocating swap slots and pageout(), could
> we completely eliminate swap slot occupation and allocation/release
> for zeromap data? For example, we could use a special swap
> entry value in the PTE to indicate zero content and directly fill it with
> zeros when swapping back. We've observed that swap slot allocation and
> freeing can consume a lot of CPU and slow down functions like
> zap_pte_range and swap-in. If we can entirely skip these steps, it
> could improve performance. However, I'm uncertain about the benefits we
> would gain if we only have 1-2% zeromap data.

If I remember correctly this was one of the ideas floated around in the
initial version of the zeromap series, but it was evaluated as a lot more
complicated to do than what the current zeromap code looks like. But I
think its definitely worth looking into!
 
> 
> I'm just putting this idea out there to see if you're interested in moving
> forward with it. :-)
> 
>>
>>>>
>>>>
>>>>>
>>>>> I consider issue 1 to be more critical because, after observing a phone
>>>>> running for some time, I've been able to roughly estimate the portion
>>>>> zeromap can
>>>>> help save using only PSWPOUT, ZSWPOUT, and SWAPOUT_SKIP, even without a
>>>>> SWPIN counter. However, I agree that issue 2 still holds significant value
>>>>> as a separate patch.
>>>>>
>>>
> 
> Thanks
> Barry


