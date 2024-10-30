Return-Path: <linux-kernel+bounces-389570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7FC9B6E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C89C282DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66073213EE0;
	Wed, 30 Oct 2024 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0UwxzAr"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BDA2144CA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322801; cv=none; b=BJddLjA3Rww+pM64CMpH4UbwDwzVLDN3MVirCSt9RzkPUrvc3S4IK2zbzF1DjcgUnw7PyW6u8nHm//Wiea+x72HCyornDOuPcObH5/C+fNdeGXs1Ox6mmGEqM4DLu2H1NJrGKHZdEATYtIiLgqJ2uTgHYtWsNr8fBGshGHKhz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322801; c=relaxed/simple;
	bh=DjyDI+UI0R8UdaclDn6fDWKPLSaW47YLU9L9iELf6rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iToHurtrpJ93sqIxRqnlLKj7yvvfvInK1DkjjsNfnrlcmdnHyGeBlnAhKSVuOLC7N2T7I0IBW6f6eicuov4CQx3gCU5Y8cn27je6z2iVhHIzmC8Y8xWor4WVf8lGAfEPatOUJkX6qSn551/XMfCmmMb8JI/Ei6nqpO5dYcbkty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0UwxzAr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43155afca99so8831585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730322797; x=1730927597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKeGul/SDsN92Pb5au+3ekIaxkpI//pN1FvsRpcKQm8=;
        b=C0UwxzArVrDbuNZGkjeLZhaDnhOdLcSD4jCggOdjIvL9Pd0+R6TO6/9v6hAPidmYZx
         l3vvvGIlsQwjk5Ni8q7gg6eP5RTpAxVsZ8bQXxX+w/ilhTWUx2npQ15fTOZA8NnAOAcz
         QlpMlJ6Y5HEOPBfVG0Pva/I1ZeoBol1UllE/P0y57F2DMY+Fs32g2MeKasW+Z0eaH8vw
         Ao/Mpy7evAHl5wOpAFFo8AxPi64QWP+YoguIxHDVpeCRJl+oAi4J7S4ek7QaBU10xsBb
         rz2GoFK/zaaGXwrDInu2S8UPSEaNB/BzTUjWBkhXE6IfLY+Vu/HJuBSyZe37707OKZT3
         izXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730322797; x=1730927597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKeGul/SDsN92Pb5au+3ekIaxkpI//pN1FvsRpcKQm8=;
        b=Jjk4r8NZA1bvFeMng2yiDkX+6iadR/J8/nODRxz8aRLES9vinzZIrwstH1SXnAmfNE
         j942fNs+bgaYXw/fIRuJYfweqzIH9PK2haJmj5cwVTNNNfkjH3SxYhrOcBxU5VRSOdeO
         12nZ3gSfDK+yMH4xEg9QzwhqDwsz8uAPQWJdVIvBOrLo+GQPKtI2i9wWyig7vKjjqvTk
         9XQoAGFGDDYcUXYgEsusYMj3wNjPcUaKIW1ivbY+HiuyRTYTco4Mxb7XMKsAd7IfnTIW
         lVUjK4ibqMgNbmpBJHpYtuzck+85p0AGElBPHckcyQ+t+u1FoH3S3RkgH9gI4L5H/f7P
         tsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA6u65RHxYeBMlSww0UMVwY7TWI85NSBPSkhxCNGUMukIxwFw18Q5VMVOxJ3Ndz5hTpBOT78IJUBvYFfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXgTwqsKfYiDh+Hom3QTbxUp4C+yqxRqTUWx9rkf93gjs+RjY
	2w59GBxXWfUePufw4AMK9VB09Yv+GqpzSkaWg4KRBEXI9/Pb9YPr
X-Google-Smtp-Source: AGHT+IGWn1XwDEoeEIROjeVkfQWLW+GPMZvxP5fY7z850DOOVJ5adUnyA6yGIVW4DrvSn1gA8NC3Xg==
X-Received: by 2002:a05:600c:1d20:b0:431:4a82:97f2 with SMTP id 5b1f17b1804b1-4327da87536mr929165e9.6.1730322797293;
        Wed, 30 Oct 2024 14:13:17 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7387sm106489f8f.51.2024.10.30.14.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 14:13:17 -0700 (PDT)
Message-ID: <c76635d7-f382-433a-8900-72bca644cdaa@gmail.com>
Date: Wed, 30 Oct 2024 21:13:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>,
 Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
References: <20241027001444.3233-1-21cnbao@gmail.com>
 <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
 <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
 <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com>
 <CAJD7tkZ60ROeHek92jgO0z7LsEfgPbfXN9naUC5j7QjRQxpoKw@mail.gmail.com>
 <852211c6-0b55-4bdd-8799-90e1f0c002c1@gmail.com>
 <CAJD7tkaXL_vMsgYET9yjYQW5pM2c60fD_7r_z4vkMPcqferS8A@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkaXL_vMsgYET9yjYQW5pM2c60fD_7r_z4vkMPcqferS8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/10/2024 21:01, Yosry Ahmed wrote:
> On Wed, Oct 30, 2024 at 1:25 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 30/10/2024 19:51, Yosry Ahmed wrote:
>>> [..]
>>>>> My second point about the mitigation is as follows: For a system (or
>>>>> memcg) under severe memory pressure, especially one without hardware TLB
>>>>> optimization, is enabling mTHP always the right choice? Since mTHP operates at
>>>>> a larger granularity, some internal fragmentation is unavoidable, regardless
>>>>> of optimization. Could the mitigation code help in automatically tuning
>>>>> this fragmentation?
>>>>>
>>>>
>>>> I agree with the point that enabling mTHP always is not the right thing to do
>>>> on all platforms. I also think it might be the case that enabling mTHP
>>>> might be a good thing for some workloads, but enabling mTHP swapin along with
>>>> it might not.
>>>>
>>>> As you said when you have apps switching between foreground and background
>>>> in android, it probably makes sense to have large folio swapping, as you
>>>> want to bringin all the pages from background app as quickly as possible.
>>>> And also all the TLB optimizations and smaller lru overhead you get after
>>>> you have brought in all the pages.
>>>> Linux kernel build test doesnt really get to benefit from the TLB optimization
>>>> and smaller lru overhead, as probably the pages are very short lived. So I
>>>> think it doesnt show the benefit of large folio swapin properly and
>>>> large folio swapin should probably be disabled for this kind of workload,
>>>> eventhough mTHP should be enabled.
>>>>
>>>> I am not sure that the approach we are trying in this patch is the right way:
>>>> - This patch makes it a memcg issue, but you could have memcg disabled and
>>>> then the mitigation being tried here wont apply.
>>>
>>> Is the problem reproducible without memcg? I imagine only if the
>>> entire system is under memory pressure. I guess we would want the same
>>> "mitigation" either way.
>>>
>> What would be a good open source benchmark/workload to test without limiting memory
>> in memcg?
>> For the kernel build test, I can only get zswap activity to happen if I build
>> in cgroup and limit memory.max.
> 
> You mean a benchmark that puts the entire system under memory
> pressure? I am not sure, it ultimately depends on the size of memory
> you have, among other factors.
> 
> What if you run the kernel build test in a VM? Then you can limit is
> size like a memcg, although you'd probably need to leave more room
> because the entire guest OS will also subject to the same limit.
> 

I had tried this, but the variance in time/zswap numbers was very high.
Much higher than the AMD numbers I posted in reply to Barry. So found
it very difficult to make comparison.

>>
>> I can just run zswap large folio zswapin in production and see, but that will take me a few
>> days. tbh, running in prod is a much better test, and if there isn't any sort of thrashing,
>> then maybe its not really an issue? I believe Barry doesnt see an issue in android
>> phones (but please correct me if I am wrong), and if there isnt an issue in Meta
>> production as well, its a good data point for servers as well. And maybe
>> kernel build in 4G memcg is not a good test.
> 
> If there is a regression in the kernel build, this means some
> workloads may be affected, even if Meta's prod isn't. I understand
> that the benchmark is not very representative of real world workloads,
> but in this instance I think the thrashing problem surfaced by the
> benchmark is real.
> 
>>
>>>> - Instead of this being a large folio swapin issue, is it more of a readahead
>>>> issue? If we zswap (without the large folio swapin series) and change the window
>>>> to 1 in swap_vma_readahead, we might see an improvement in linux kernel build time
>>>> when cgroup memory is limited as readahead would probably cause swap thrashing as
>>>> well.
>>>
>>> I think large folio swapin would make the problem worse anyway. I am
>>> also not sure if the readahead window adjusts on memory pressure or
>>> not.
>>>
>> readahead window doesnt look at memory pressure. So maybe the same thing is being
>> seen here as there would be in swapin_readahead?
> 
> Maybe readahead is not as aggressive in general as large folio
> swapins? Looking at swap_vma_ra_win(), it seems like the maximum order
> of the window is the smaller of page_cluster (2 or 3) and
> SWAP_RA_ORDER_CEILING (5).
Yes, I was seeing 8 pages swapin (order 3) when testing. So might
be similar to enabling 32K mTHP?

> 
> Also readahead will swapin 4k folios AFAICT, so we don't need a
> contiguous allocation like large folio swapin. So that could be
> another factor why readahead may not reproduce the problem.
> 
>> Maybe if we check kernel build test
>> performance in 4G memcg with below diff, it might get better?
> 
> I think you can use the page_cluster tunable to do this at runtime.
> 
>>
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index 4669f29cf555..9e196e1e6885 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -809,7 +809,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>>         pgoff_t ilx;
>>         bool page_allocated;
>>
>> -       win = swap_vma_ra_win(vmf, &start, &end);
>> +       win = 1;
>>         if (win == 1)
>>                 goto skip;
>>


