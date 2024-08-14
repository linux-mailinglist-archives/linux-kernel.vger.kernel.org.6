Return-Path: <linux-kernel+bounces-286240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 976F1951875
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35C61C21DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9C81AD9CA;
	Wed, 14 Aug 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1/DwH8Z"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6560B96;
	Wed, 14 Aug 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630420; cv=none; b=m3mj6hWcgp6KCqG4YUTuO9TSNHzB426FPitdXhGPhPkvNPaf5FFCpFSb7RheJoNl/MRRGRrJF4ifBBEJFNp88wCOKMVQ/EAkWMWBWEmrl4l4jdkcUrUeZmOsiYE1VjKG33GsM1eLcbInkigkYnFD17mOlksxfVLozqJ+18t5hBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630420; c=relaxed/simple;
	bh=lyasvveaahQXFkvsDSLd+2mRVTa+efgek9lk70n/R30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sw+KpdL+8QxM5C/yxBO4MBZ86Swp4ogmJVAt62afvnjJUS3UFvMzuuPIbWCc8TmNafnnsjCegDWuhZ31Wo3Zv96q+XM3hX2GNTiQoPoSOVyyiYUDru2xVktpmHnTP+hLxhIxfiK7GfPNOB5Jbb94W28KQj61v6SzaHzPuj9C0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1/DwH8Z; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so6782588a12.3;
        Wed, 14 Aug 2024 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723630417; x=1724235217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNd+he0K68SRIocWwyWopuqY7557TQ2wksIvC7bmzlM=;
        b=I1/DwH8Zjl7Taz9QV6v0cMVAtkH9avfRzVumlfxpHPuat8mY89YZVGGcYG6s5M0UpM
         Ue4XC+6xSL106D5yQOTJBNIYsc6LmBFJwDADd2NRTwCSErVf7Xjf3tfHIi+g1E7IJWFh
         Qxy+kYOJTLZMS2lPa3cmsyuOv4UUHaAhWpWverF3tZYnmmr4N4XEfr4VQX8tb7Td1Iwg
         LRo3hPXkLh1+z7+YcmHx8uF+v/rxQgCjPP+j0jb8UZGuSC11rEHP9DPo7t2CH2WbiBbu
         B3lULnA5JCPPuGCiZmX7CJvOhAeivGPPAlgB8/2mLe4lK513Oco2iFna60crI0wpmM6R
         lJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723630417; x=1724235217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNd+he0K68SRIocWwyWopuqY7557TQ2wksIvC7bmzlM=;
        b=Hoo+N+410qJC0+VHx3YNzpKMF0bbukb2YnUHyw2T7EknQnXYd7KELOGCMU2hiWHtmf
         EEDqfi6C4iQ2Tx0WNzGyyCoFrfZeJKwEHLJuBfZlAER3WMpCpkZAffIskKVm76zznmvd
         rXpDzPVOMZR33IFAo+aZcR51h2jjXZ3wKnHOLIKHl0zfhliy+pO6DDfLvVioGeSYs2nW
         AYQp091c7vmNFJ5Wu+/1vPAq49ClUBBG8P5zAgD2wq5r0AumvPZ9qD112og/kXNazmhE
         THHFQHOoyMEcQ9IPMJBxysvKrSVGWvYdF1kILi5CfWu0OwV7pYHXDY6vFsPT+xThWFiy
         MygQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD2X5EuSoeaV6aHfNafhy9xZaLxqDe0IMmia8CLjKuECRiHTJHi8CdR9p6EHTnUuOqvOqpd0OT//50axQN0Fqu1SqBEXIJYEiX6r0KNf5lts0pTmi0uOfq4qH7Gx0Ch/DNlOnBoD6T
X-Gm-Message-State: AOJu0Yw074kN56sfLOI/cICJv/ZYSPnAW+lefBRFtueq0M9qZ71HCVBe
	OkizeuSF76QDYmTXHBn2QjvbozQIY7nsDUhDBiKrVAkkl54tCpFw
X-Google-Smtp-Source: AGHT+IE0MyzO6aVdPYX+yPRmrPe85J2EQIBeNQ271y8eY3Wwo+A8u80lRS+O5ZJaQs020YDAO5oEqw==
X-Received: by 2002:a05:6402:5112:b0:5a1:1b3f:fbf5 with SMTP id 4fb4d7f45d1cf-5bea1c77673mr1806201a12.12.1723630416758;
        Wed, 14 Aug 2024 03:13:36 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:61b7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a696dsm3755173a12.50.2024.08.14.03.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:13:36 -0700 (PDT)
Message-ID: <e73c801a-8f36-44d8-a267-dd993aeccf35@gmail.com>
Date: Wed, 14 Aug 2024 11:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] mm: split underutilized THPs
To: Andi Kleen <ak@linux.intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <87y150mj6f.fsf@linux.intel.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <87y150mj6f.fsf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/08/2024 18:22, Andi Kleen wrote:
> Usama Arif <usamaarif642@gmail.com> writes:
>>
>> This patch-series is an attempt to mitigate the issue of running out of
>> memory when THP is always enabled. During runtime whenever a THP is being
>> faulted in or collapsed by khugepaged, the THP is added to a list.
>> Whenever memory reclaim happens, the kernel runs the deferred_split
>> shrinker which goes through the list and checks if the THP was underutilized,
>> i.e. how many of the base 4K pages of the entire THP were zero-filled.
> 
> Sometimes when writing a benchmark I fill things with zero explictly
> to avoid faults later. For example if you want to measure memory
> read bandwidth you need to fault the pages first, but that fault
> pattern may well be zero.
> 
> With your patch if there is memory pressure there are two effects:
> 
> - If things are remapped to the zero page the benchmark
> reading memory may give unrealistically good results because
> what is thinks is a big memory area is actually only backed
> by a single page.
> 
> - If I expect to write I may end up with an unexpected zeropage->real
> memory fault if the pages got remapped. 
> 
> I expect such patterns can happen without benchmarking too.
> I could see it being a problem for latency sensitive applications.
> 
> Now you could argue that this all should only happen under memory
> pressure and when that happens things may be slow anyways and your
> patch will still be an improvement.
> 
> Maybe that's true but there might be still corner cases
> which are negatively impacted by this. I don't have a good solution
> other than a tunable, but I expect it will cause problems for someone.
> 

There are currently 2 knobs to control behaviour of THP low utilization shrinker introduced in this series.

/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none:
The current default value for this is HPAGE_PMD_NR - 1 (511 for x86). If set to 511, the shrinker will immediately remove the folio from the deferred_list (Please see first if statement in thp_underutilized in Patch 5) and split is not attempted. Not a single page is checked at this point and there is no memory accesses done to impact performance.
If someone sets its to 510, it will exit as soon as a single page containing non-zero data is encountered (the else part in thp_underutilized).

/sys/kernel/mm/transparent_hugepage/thp_low_util_shrinker:
Introduced in patch 6, if someone really doesn't want to enable the shrinker, then they can set this to false. The folio will not be added to the _deferred_list at fault or collapse time, and it will be as if these patches didn't exist. Personally, I don't think its absolutely necessary to have this, but I added it incase someone comes up with some corner case.

For the first effect you mentioned, with the default behaviour of the patches with max_ptes_none set to 511, there will be no splitting of THPs, so you will get the same performance as without the series. 
If there is some benchmark that allocates all of the system memory with zeropages, causing shrinker to run and if someone has changed max_ptes_none and if they have kept thp_low_util_shrinker enabled and if all the benchmark does is read those pages, thus giving good memory results, then that benchmark is not really useful and the good results it gives is not unrealistic but a result of these patches. The stress example I have in the cover letter is an example. With these patches you can run stress or any other benchmark that behaves like this and still run other applications at the same time that consume memory, so the improvement is not unrealistic.

For the second effect of memory faults affecting latency sensitive applications, if THP is always enabled, and such applications are running out of memory resulting in shrinker to run, then a higher priority should be to have memory to run (which the shrinker will provide) rather than stalling for memory creating memory pressure which will result in latency spikes and possibly OOM killer being invoked killing the application.

I think we should focus on real world applications for which I have posted numbers in the cover letter and not tailor this for some benchmarks. If there is some real world low latency application where you could show these patches causing an issue, I would be happy to look into it. But again, with the default max_ptes_none of 511, it wouldn't.
 

> The other problem I have with your patch is that it may cause the kernel
> to pollute CPU caches in the background, which again will cause noise in
> the system. Instead of plain memchr_inv, you should probably use some
> primitive to bypass caches or use a NTA prefetch hint at least.
> 

A few points on this:
- the page is checked in 2 places, at shrink time and at split time, so having the page in cache is useful and needed.
- there is stuff like this already done in the kernel when there is memory pressure, for e.g. at swap time [1]. Its not memchr_inv, but doing the exact same thing as memchr_inv.
- At the time the shrinker runs, one of the highest priority of the kernel/system is to get free memory. We should not try to make this slower by messing around with caches.

I think the current behaviour in the patches is good because of the above points. But also I don't think there is a standard way of doing NTA prefetch across all architectures, x86 prefetch does it [1], but arm prefetch [2] does pld1keep, i.e. keep the data in L1 cache which is the opposite of what NTA prefetch is intended doing. 

[1] https://elixir.bootlin.com/linux/v6.10.4/source/mm/zswap.c#L1390
[2] https://elixir.bootlin.com/linux/v6.10.4/source/arch/x86/include/asm/processor.h#L614
[3] https://elixir.bootlin.com/linux/v6.10.4/source/arch/arm64/include/asm/processor.h#L360

