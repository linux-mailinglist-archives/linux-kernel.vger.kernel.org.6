Return-Path: <linux-kernel+bounces-385829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E969B3C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5FF1F23D35
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD431DFE38;
	Mon, 28 Oct 2024 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JctjHeIH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B118E74D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148684; cv=none; b=gZ3cuYk2Rf3rwdLNi++Abi2TkbjXWwBcJ2uTd1CjLJrQMRFAPhsu10GMNw2wXPLGnoHEzOoe6zPCtW3XbNWsJnPCbwUrDcAOH5A4lkTwpDMpgLwwb3grO7XcVmdwCxuy4GLaGoPuFbdq+6F9X1LkKHFVP6l7dmDojjU/77lN29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148684; c=relaxed/simple;
	bh=rvVHbGNIGhfaxjSgfA5GQLGPNCxMSnGU8XiuBqeByIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWUARNq/wjhR0uB/OAgHgRVv+XyLYWSwqXvwcYeCnQo0PiClv8mHXDvf+qCYJUgt4PmqejaFMot3Nn7a84HDdp+8K4XDpyi8XKQQ6S1syc9CeNj0uqX/0nkzWQ7x98uBkPVeqBIAAdYNSitxxUmWHKBd0wN5S9k0yVRWP5tvnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JctjHeIH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so49605995e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730148681; x=1730753481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHXlbXtup6m7s/te+MX8GjiwOo8k3bhse/14tGb+nrg=;
        b=JctjHeIHUrrBWHYQsumr7CsN4YLrcC1KHQybarEiU8ryw/pUunqbBTfuM/OpgLxuC6
         Wpnnl70hLiu6DtZ/dTRdBLzua7ACSNeGzwOP2lxsl8NdK0jdXkFdLyLLo6PLfOG+eOgN
         jQa+SM/IouIEM8lklIkr182C6/ZJEHWdx7XEfVap4RMSrbMX3pP7a8u695PecGDfpXMZ
         cY701CITlc+c8VIFEVhUMIiLJHsS/38k+dOyUqMspESMEyJbgpLuny/n7wy+2VRTVWjq
         uE/swSOu6eVaFGjoTIZBe4L4joRbIf6huzDk7FYQMLDdw9ZdVBPyezPhVz+CcIA4fimh
         YhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148681; x=1730753481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHXlbXtup6m7s/te+MX8GjiwOo8k3bhse/14tGb+nrg=;
        b=FdBVQjeJ01ApOtSZT+VUpp+tTLJbqBzVHqzqJfsPSvM0wA40SG76IB08oY1tAXWl3p
         vFcTZrV3LdW884YzQttTgig0U3ABIL4AbvzXETIGK9B1iiXDmuW5uzEub5NWBFSThntY
         MjpmkjgeCK0na90zum1ufjFT3NXJw2XwvOre78tWmiKuRl2oAlh2nzhtAUwXNBy07xFn
         0cjxFgoTG3d+TiKdEs4hdgkT3Kp8kOctw17E89hjlb8Tbop7JxoYI7W8FsCjiVibei1L
         d0k5tFAxCvMqtGjUBD2t6TgbORKRZteOOpasGS3+Gg8Q0tb0EHsi1czU50qnRWG2fOfI
         48LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzHiV9Yk1i1xIyGNWplvtBRpSRKgtVSr28wwv/Ac7+PieCeduXl73r67qfnET//pfCxfdHWD93GSGDxEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1r0FtVwktWkwrxCWVo4M0uWpgz+BmbpXZOXYkm3tAmdfhbIXu
	q1rFU+Gk4Y4S4iFwsIr+7938FE47ZQY/Svh46AHyznW/U3DudM0iVwt75Q==
X-Google-Smtp-Source: AGHT+IHnD4xFnI/N9uQW6KYyRVhqpIL2q427+H12phCUrAMGFlJ7IG9Nez9zeX0T+gWoI+k0m7lbhQ==
X-Received: by 2002:a05:600c:354c:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-4319ab8dfeemr82605525e9.0.1730148680411;
        Mon, 28 Oct 2024 13:51:20 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b712cbsm10562317f8f.77.2024.10.28.13.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 13:51:20 -0700 (PDT)
Message-ID: <cba36cb0-66c7-45c1-97c3-a96ea48a6cf0@gmail.com>
Date: Mon, 28 Oct 2024 20:51:19 +0000
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4yBkry-rw75AciT8OiYWrw+=D0okcxiyXzzNrz=QJxiBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/10/2024 20:42, Barry Song wrote:
> On Tue, Oct 29, 2024 at 4:00 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 28/10/2024 19:54, Barry Song wrote:
>>> On Tue, Oct 29, 2024 at 1:20 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 28/10/2024 17:08, Yosry Ahmed wrote:
>>>>> On Mon, Oct 28, 2024 at 10:00 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 28/10/2024 16:33, Nhat Pham wrote:
>>>>>>> On Mon, Oct 28, 2024 at 5:23 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>>
>>>>>>>> I wonder if instead of having counters, it might be better to keep track
>>>>>>>> of the number of zeropages currently stored in zeromap, similar to how
>>>>>>>> zswap_same_filled_pages did it. It will be more complicated then this
>>>>>>>> patch, but would give more insight of the current state of the system.
>>>>>>>>
>>>>>>>> Joshua (in CC) was going to have a look at that.
>>>>>>>
>>>>>>> I don't think one can substitute for the other.
>>>>>>
>>>>>> Yes agreed, they have separate uses and provide different information, but
>>>>>> maybe wasteful to have both types of counters? They are counters so maybe
>>>>>> dont consume too much resources but I think we should still think about
>>>>>> it..
>>>>>
>>>>> Not for or against here, but I would say that statement is debatable
>>>>> at best for memcg stats :)
>>>>>
>>>>> Each new counter consumes 2 longs per-memcg per-CPU (see
>>>>> memcg_vmstats_percpu), about 16 bytes, which is not a lot but it can
>>>>> quickly add up with a large number of CPUs/memcgs/stats.
>>>>>
>>>>> Also, when flushing the stats we iterate all of them to propagate
>>>>> updates from per-CPU counters. This is already a slowpath so adding
>>>>> one stat is not a big deal, but again because we iterate all stats on
>>>>> multiple CPUs (and sometimes on each node as well), the overall flush
>>>>> latency becomes a concern sometimes.
>>>>>
>>>>> All of that is not to say we shouldn't add more memcg stats, but we
>>>>> have to be mindful of the resources.
>>>>
>>>> Yes agreed! Plus the cost of incrementing similar counters (which ofcourse is
>>>> also not much).
>>>>
>>>> Not trying to block this patch in anyway. Just think its a good point
>>>> to discuss here if we are ok with both types of counters. If its too wasteful
>>>> then which one we should have.
>>>
>>> Hi Usama,
>>> my point is that with all the below three counters:
>>> 1. PSWPIN/PSWPOUT
>>> 2. ZSWPIN/ZSWPOUT
>>> 3. SWAPIN_SKIP/SWAPOUT_SKIP or (ZEROSWPIN, ZEROSWPOUT what ever)
>>>
>>> Shouldn't we have been able to determine the portion of zeromap
>>> swap indirectly?
>>>
>>
>> Hmm, I might be wrong, but I would have thought no?
>>
>> What if you swapout a zero folio, but then discard it?
>> zeromap_swpout would be incremented, but zeromap_swapin would not.
> 
> I understand. It looks like we have two issues to tackle:
> 1. We shouldn't let zeromap swap in or out anything that vanishes into
> a black hole
> 2. We want to find out how much I/O/memory has been saved due to zeromap so far
> 
> From my perspective, issue 1 requires a "fix", while issue 2 is more
> of an optimization.

Hmm I dont understand why point 1 would be an issue.

If its discarded thats fine as far as I can see.

As a reference, memory.stat.zswapped != memory.stat.zswapout - memory.stat.zswapin.
Because zswapped would take into account swapped out anon memory freed, MADV_FREE,
shmem truncate, etc as Yosry said about zeromap, But zswapout and zswapin dont.


> 
> I consider issue 1 to be more critical because, after observing a phone
> running for some time, I've been able to roughly estimate the portion
> zeromap can
> help save using only PSWPOUT, ZSWPOUT, and SWAPOUT_SKIP, even without a
> SWPIN counter. However, I agree that issue 2 still holds significant value
> as a separate patch.
> 
> Thanks
> Barry


