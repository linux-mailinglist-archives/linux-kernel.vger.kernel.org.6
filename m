Return-Path: <linux-kernel+bounces-394815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED69BB44D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D02C1F24990
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096611B6CFF;
	Mon,  4 Nov 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d60U2+qB"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF921B6CE2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722408; cv=none; b=Tx5gaTLl0AgOIRlVmWruinD8+fBFWfdra7a7o5z26sGvKkH7quX8WydYNkJZ455ecDm5v/Q6Kf9+1rFVlMpmCfMaETOPob3kAo0u3aceg4ZH1xlLTL0JtuxozQPtlZ+Lib6a1hyNR89jae9NZ9yAtROXxVo6aQfbIoAyOUYRMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722408; c=relaxed/simple;
	bh=bW4fWPSQpMD46o+ViPF/dX8EbYjK1xzM+VKw3kA6Cxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rV2XzEA33IIIUCNZYZOt+JHLd2zd2hFMgafC0vleJ+7vSN/Fg+z8CWU0V7YbJRojfWssV730khA6gTWXCHBkMEhlN1dooD9SH9AVlQFpsvBvDD0Vcvkk7FxcuY646487mj9wgMpJcAb9FfQM1EESnYEOtGsrmo1X0+ngYIkwocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d60U2+qB; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso60329761fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730722404; x=1731327204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOJk7OfXsT+Xw5K8e1e2bLMEk9P7tYgMnLJCrbfvplY=;
        b=d60U2+qBXzoSFSmPUnMap4Z6+V4q1/FX3hUB7Zeo8YtUmG4UWWeROVzyayShgZlD+5
         kKMd4khixNSXDyVQ7wXSv3FTPntu0A7Uoi2k/onf1B+fc7YMVcO0D19PGXsa+VEmfjx5
         KaxqbWK/2dh+javNYDh0XJnq1x3a5DFcLx49h9w9iQdf/YnZL4HJY6gSKfo0laS0ECeY
         apIGY+JxbS7NDLwczKPD3gw4dQOS1m1vi1CiLHpqPH4ZkrRc86Gm3f1dybkAbSMEB/6a
         DF5w9pWxIT9BDGB7VYoCaIisJpUvcZPTOfgkPvenSp0s20VKCXEiV+SgAuuWx2R4D/F0
         QKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730722404; x=1731327204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOJk7OfXsT+Xw5K8e1e2bLMEk9P7tYgMnLJCrbfvplY=;
        b=mMXq9ZTJ3Szo/cg3IidMiG3c3DF1PhOlvFOgop4E57j0UDJrv2OFP96TulNplaWksr
         6XMRXnrW9SoBo6aJr/BbsPDNw/7au/9ZJ0gXFa7l+5uKC4TmMos6du4owEdGs+mgk2IU
         LIXsOfZy5AOV1tj9mYk/ycK/8Kv0B7QVuoTuQQnEBkNlSXgJjepqHKGeNRbB1LCGjwsc
         HOCR9aErMrwDH5BFQXBrvik5JbDYUAo7fXtFjD07Qw28naYmdijg6vT+MPw0yqUCh1UT
         nee5BAF3//GZpywlXAXKwmDp/593GWw/j7nvzoKDqmP76HIMV6ZpNfH+vfyFmCOMhxlM
         ALVA==
X-Forwarded-Encrypted: i=1; AJvYcCU+NRGAot4LMOdllnDtwFNyF4IS1h8/Utp0d7F+leIS1HVDnacfmaPpTZPZxBQE1yy7wmPX4kqPlE2xSzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTsY1TmAjvdXgYHak37FKEC8naezFebZgC2JpmKoUjcfVyqob
	Py576qSZCZNPkSIR3+17gUOFJzKCqEFDwRvBlWcxDuu+y0q7kOnW
X-Google-Smtp-Source: AGHT+IFKs7aDMWR5bYmRZraqFa5M5X+Gd4nCdqEynWIk2yfgXDEdIi5TtwnA+VsCByPQsjSqfCK3eg==
X-Received: by 2002:a05:651c:2123:b0:2fa:c0c2:d311 with SMTP id 38308e7fff4ca-2fedb794b2dmr86293771fa.5.1730722404011;
        Mon, 04 Nov 2024 04:13:24 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:76d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56641249sm545170566b.156.2024.11.04.04.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 04:13:23 -0800 (PST)
Message-ID: <3f684183-c6df-4f2f-9e33-91ce43c791eb@gmail.com>
Date: Mon, 4 Nov 2024 12:13:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: "Huang, Ying" <ying.huang@intel.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>,
 Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
References: <20241027001444.3233-1-21cnbao@gmail.com>
 <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
 <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
 <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com>
 <CAJD7tkZ60ROeHek92jgO0z7LsEfgPbfXN9naUC5j7QjRQxpoKw@mail.gmail.com>
 <852211c6-0b55-4bdd-8799-90e1f0c002c1@gmail.com>
 <CAJD7tkaXL_vMsgYET9yjYQW5pM2c60fD_7r_z4vkMPcqferS8A@mail.gmail.com>
 <c76635d7-f382-433a-8900-72bca644cdaa@gmail.com>
 <CAJD7tkYSRCjtEwP=o_n_ZhdfO8nga-z-a=RirvcKL7AYO76XJw@mail.gmail.com>
 <20241031153830.GA799903@cmpxchg.org>
 <87a5ef8ppq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <87a5ef8ppq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/11/2024 06:42, Huang, Ying wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> 
>> On Wed, Oct 30, 2024 at 02:18:09PM -0700, Yosry Ahmed wrote:
>>> On Wed, Oct 30, 2024 at 2:13 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>> On 30/10/2024 21:01, Yosry Ahmed wrote:
>>>>> On Wed, Oct 30, 2024 at 1:25 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>> I am not sure that the approach we are trying in this patch is the right way:
>>>>>>>> - This patch makes it a memcg issue, but you could have memcg disabled and
>>>>>>>> then the mitigation being tried here wont apply.
>>>>>>>
>>>>>>> Is the problem reproducible without memcg? I imagine only if the
>>>>>>> entire system is under memory pressure. I guess we would want the same
>>>>>>> "mitigation" either way.
>>>>>>>
>>>>>> What would be a good open source benchmark/workload to test without limiting memory
>>>>>> in memcg?
>>>>>> For the kernel build test, I can only get zswap activity to happen if I build
>>>>>> in cgroup and limit memory.max.
>>>>>
>>>>> You mean a benchmark that puts the entire system under memory
>>>>> pressure? I am not sure, it ultimately depends on the size of memory
>>>>> you have, among other factors.
>>>>>
>>>>> What if you run the kernel build test in a VM? Then you can limit is
>>>>> size like a memcg, although you'd probably need to leave more room
>>>>> because the entire guest OS will also subject to the same limit.
>>>>>
>>>>
>>>> I had tried this, but the variance in time/zswap numbers was very high.
>>>> Much higher than the AMD numbers I posted in reply to Barry. So found
>>>> it very difficult to make comparison.
>>>
>>> Hmm yeah maybe more factors come into play with global memory
>>> pressure. I am honestly not sure how to test this scenario, and I
>>> suspect variance will be high anyway.
>>>
>>> We can just try to use whatever technique we use for the memcg limit
>>> though, if possible, right?
>>
>> You can boot a physical machine with mem=1G on the commandline, which
>> restricts the physical range of memory that will be initialized.
>> Double check /proc/meminfo after boot, because part of that physical
>> range might not be usable RAM.
>>
>> I do this quite often to test physical memory pressure with workloads
>> that don't scale up easily, like kernel builds.
>>
>>>>>>>> - Instead of this being a large folio swapin issue, is it more of a readahead
>>>>>>>> issue? If we zswap (without the large folio swapin series) and change the window
>>>>>>>> to 1 in swap_vma_readahead, we might see an improvement in linux kernel build time
>>>>>>>> when cgroup memory is limited as readahead would probably cause swap thrashing as
>>>>>>>> well.
>>
>> +1
>>
>> I also think there is too much focus on cgroup alone. The bigger issue
>> seems to be how much optimistic volume we swap in when we're under
>> pressure already. This applies to large folios and readahead; global
>> memory availability and cgroup limits.
> 
> The current swap readahead logic is something like,
> 
> 1. try readahead some pages for sequential access pattern, mark them as
>    readahead
> 
> 2. if these readahead pages get accessed before swapped out again,
>    increase 'hits' counter
> 
> 3. for next swap in, try readahead 'hits' pages and clear 'hits'.
> 
> So, if there's heavy memory pressure, the readaheaded pages will not be
> accessed before being swapped out again (in 2 above), the readahead
> pages will be minimal.
> 
> IMHO, mTHP swap-in is kind of swap readahead in effect.  That is, in
> addition to the pages accessed are swapped in, the adjacent pages are
> swapped in (swap readahead) too.  If these readahead pages are not
> accessed before swapped out again, system runs into more severe
> thrashing.  This is because we lack the swap readahead window scaling
> mechanism as above.  And, this is why I suggested to combine the swap
> readahead mechanism and mTHP swap-in by default before.  That is, when
> kernel swaps in a page, it checks current swap readahead window, and
> decides mTHP order according to window size.  So, if there are heavy
> memory pressure, so that the nearby pages will not be accessed before
> being swapped out again, the mTHP swap-in order can be adjusted
> automatically.

This is a good idea to do, but I think the issue is that readahead
is a folio flag and not a page flag, so only works when folio size is 1.

In the swapin_readahead swapcache path, the current implementation decides
the ra_window based on hits, which is incremented in swap_cache_get_folio
if it has not been gotten from swapcache before.
The problem would be that we need information on how many distinct pages in
a large folio that has been swapped in have been accessed to decide the
hits/window size, which I don't think is possible. As once the entire large
folio has been swapped in, we won't get a fault.


> 
>> It happens to manifest with THP in cgroups because that's what you
>> guys are testing. But IMO, any solution to this problem should
>> consider the wider scope.
>>
>>>>>>> I think large folio swapin would make the problem worse anyway. I am
>>>>>>> also not sure if the readahead window adjusts on memory pressure or
>>>>>>> not.
>>>>>>>
>>>>>> readahead window doesnt look at memory pressure. So maybe the same thing is being
>>>>>> seen here as there would be in swapin_readahead?
>>>>>
>>>>> Maybe readahead is not as aggressive in general as large folio
>>>>> swapins? Looking at swap_vma_ra_win(), it seems like the maximum order
>>>>> of the window is the smaller of page_cluster (2 or 3) and
>>>>> SWAP_RA_ORDER_CEILING (5).
>>>> Yes, I was seeing 8 pages swapin (order 3) when testing. So might
>>>> be similar to enabling 32K mTHP?
>>>
>>> Not quite.
>>
>> Actually, I would expect it to be...
> 
> Me too.
> 
>>>>> Also readahead will swapin 4k folios AFAICT, so we don't need a
>>>>> contiguous allocation like large folio swapin. So that could be
>>>>> another factor why readahead may not reproduce the problem.
>>>
>>> Because of this ^.
>>
>> ...this matters for the physical allocation, which might require more
>> reclaim and compaction to produce the 32k. But an earlier version of
>> Barry's patch did the cgroup margin fallback after the THP was already
>> physically allocated, and it still helped.
>>
>> So the issue in this test scenario seems to be mostly about cgroup
>> volume. And then 8 4k charges should be equivalent to a singular 32k
>> charge when it comes to cgroup pressure.
> 
> --
> Best Regards,
> Huang, Ying


