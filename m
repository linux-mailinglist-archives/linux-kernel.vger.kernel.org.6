Return-Path: <linux-kernel+bounces-378055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC4E9ACABB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B202838AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755BC1ADFEA;
	Wed, 23 Oct 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBciK6s4"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E9156C72;
	Wed, 23 Oct 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688905; cv=none; b=W/+X6unRU0jKl1DTUEOerrfltNHIaYWMOX2/DgmbbbQAqN7My+aAfyjsk3xZWneIIfK2uDYMTH5Onm3TnLbJrgjDnNbqyE69ZaWWQ9D5/JGAxlbiny+f0rit71JBfE/S5sO+6kYwsrT9Gf6FshZF+Hz19vuQfYNyRMcbJYHYUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688905; c=relaxed/simple;
	bh=n/EBS1cwBQphsvbvOxbtuvBZFCMQgGmDglbL/aimjik=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b+7X5+OGzb4oSODPYTtaHOJk6fk+xpPZ+gQq8zjwUouiT7RG6bNrtj5DPHT6tjpaXrlZGh51YeSV+vkrU5yRUPLV425OQGXWsJQ1Vm70BiW2/zKF4jsXdm2QvDU3TOyOPpZYsy14dWPffGaJbk5P3Gkz5UMosVTUImMVr5OLKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBciK6s4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso983529466b.1;
        Wed, 23 Oct 2024 06:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729688901; x=1730293701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6g/kN3aYrPUUweeIdLICpwUC9hysX6yVasIgSzv6wYA=;
        b=NBciK6s4FquY0OTCSOrGtUkoqlPNe14b2ucoY8YSfGus2GGXDyAQo3GhMVB/lvhLGY
         teF9VdZEG/J/trqGrle+qeF90ewv6Rmpn0sH5RWmBe3lmooc4tL8cfmzwrJ4hwpyOl7h
         A3DOdOzOZvEGGX17aAUSaPZe3j13hDwe03oA5RUVQKTqVuKp0bwKr67ggbBDy0sd9pMo
         x4x/9t5Adksb9r4Cb+NgEfg/fzCIZz+5O/mmm4hJ46WYKL7fVXVDalHPq+Jkar3c/4Wq
         PiKmFUk6ugBQZOFtFwsZMqNyp6Ou4n1DQUCzwVxV6/ElyHRhVwyrFEa+tT083ZyYKNZK
         xNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729688901; x=1730293701;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6g/kN3aYrPUUweeIdLICpwUC9hysX6yVasIgSzv6wYA=;
        b=Ks1mlCXwQrsArlKGAaxiGjBP5DX4Q48VNc21Wi4EW3t7JacanFkrTXHOlF9GoTbUp0
         AsfUKpJoCOOHn2pSdwGLgLA2RlBD7C4UeA3ST+Ipx3KvKxhvdGEm6HZuNw45ZeJk1K4J
         KtKxiSx8jDu5RjLzFLUkeEbv8Tfc4INLTn3mJgnAB7iALbpcj+l+LjFKUxzXICr3veoG
         CPomMMbWdLW0YYxMW/tX/C14F6le/hZpC5ahXtbSm08NsOwrJO3eBTQ0o/wr7MhtND//
         gx/JA0jeysZ+FOnlKk3vNHTcxZGVyQvqpPLteAo3pvOx0P1YA1z+iQgiBE+UwIDrucuX
         WwsA==
X-Forwarded-Encrypted: i=1; AJvYcCXLmHHCcJhaXbrxwGarZLuub0r3kJ8/VX85t9nveLq9Qgslvqd7Hucr/ocbBxo0h1sdyPVs1pnrKrU=@vger.kernel.org, AJvYcCXqrc4pzDmyUPiNCamaR7VVuFBZHlyNIPTF4KO2iEepbz3Us0SMZ1EaHpHbUa9kPnbobYTt87mo164/6GBY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/502t9VE3ZthLEuU5KoySI7jIAmnCi+yo0WjbeiKk4o9mS2L1
	84TGRD16fdHpTWtw4XLoNUYbkQFpUTVeHC+w2+TbdqCfgJ+G7O1Z
X-Google-Smtp-Source: AGHT+IFb41T8ZR9P2tMkI3jtoD2dTOZAmZnkF6HO/XCXQyGLtbTQ7TAqICB5zCVsGDKDUw1V8nl62Q==
X-Received: by 2002:a17:907:a08:b0:a9a:17f5:79a8 with SMTP id a640c23a62f3a-a9abf84a887mr229560466b.13.1729688900691;
        Wed, 23 Oct 2024 06:08:20 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d63bcsm483257566b.12.2024.10.23.06.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 06:08:20 -0700 (PDT)
Message-ID: <7a14c332-3001-4b9a-ada3-f4d6799be555@gmail.com>
Date: Wed, 23 Oct 2024 14:08:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
From: Usama Arif <usamaarif642@gmail.com>
To: Barry Song <21cnbao@gmail.com>
Cc: senozhatsky@chromium.org, minchan@kernel.org, hanchuanhua@oppo.com,
 v-songbaohua@oppo.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 hannes@cmpxchg.org, david@redhat.com, willy@infradead.org,
 kanchana.p.sridhar@intel.com, yosryahmed@google.com, nphamcs@gmail.com,
 chengming.zhou@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
 riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <CAGsJ_4xweuSwMUBuLSr2eUy69mtQumeDpMZ1g2jFPGq6nFn9fg@mail.gmail.com>
 <5313c721-9cf1-4ecd-ac23-1eeddabd691f@gmail.com>
 <b1c17b5e-acd9-4bef-820e-699768f1426d@gmail.com>
 <CAGsJ_4wykOyJupLhcqkSPe27rdANd=bOJhqxL74vcdZ+T9f==g@mail.gmail.com>
 <eab11780-e671-4d09-86a6-af4cf3589392@gmail.com>
 <CAGsJ_4wWf7QnibY_uU8B=efuEACrvFaJJ=bJTD+9KrxFtfoMmQ@mail.gmail.com>
 <CAGsJ_4w5XLMok4F6Xw7aTAdV6rY9OvCVPM3U+hzFnKyTXBUpOA@mail.gmail.com>
 <4c30cc30-0f7c-4ca7-a933-c8edfadaee5c@gmail.com>
Content-Language: en-US
In-Reply-To: <4c30cc30-0f7c-4ca7-a933-c8edfadaee5c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/10/2024 11:48, Usama Arif wrote:
> 
> 
> On 23/10/2024 11:26, Barry Song wrote:
>> On Wed, Oct 23, 2024 at 11:07 AM Barry Song <21cnbao@gmail.com> wrote:
>>>
>>> On Wed, Oct 23, 2024 at 10:17 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 22/10/2024 21:46, Barry Song wrote:
>>>>> On Wed, Oct 23, 2024 at 4:26 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 21/10/2024 11:40, Usama Arif wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 21/10/2024 06:09, Barry Song wrote:
>>>>>>>> On Fri, Oct 18, 2024 at 11:50 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> After large folio zswapout support added in [1], this patch adds
>>>>>>>>> support for zswapin of large folios to bring it on par with zram.
>>>>>>>>> This series makes sure that the benefits of large folios (fewer
>>>>>>>>> page faults, batched PTE and rmap manipulation, reduced lru list,
>>>>>>>>> TLB coalescing (for arm64 and amd)) are not lost at swap out when
>>>>>>>>> using zswap.
>>>>>>>>>
>>>>>>>>> It builds on top of [2] which added large folio swapin support for
>>>>>>>>> zram and provides the same level of large folio swapin support as
>>>>>>>>> zram, i.e. only supporting swap count == 1.
>>>>>>>>>
>>>>>>>>> Patch 1 skips swapcache for swapping in zswap pages, this should improve
>>>>>>>>> no readahead swapin performance [3], and also allows us to build on large
>>>>>>>>> folio swapin support added in [2], hence is a prerequisite for patch 3.
>>>>>>>>>
>>>>>>>>> Patch 3 adds support for large folio zswapin. This patch does not add
>>>>>>>>> support for hybrid backends (i.e. folios partly present swap and zswap).
>>>>>>>>>
>>>>>>>>> The main performance benefit comes from maintaining large folios *after*
>>>>>>>>> swapin, large folio performance improvements have been mentioned in previous
>>>>>>>>> series posted on it [2],[4], so have not added those. Below is a simple
>>>>>>>>> microbenchmark to measure the time needed *for* zswpin of 1G memory (along
>>>>>>>>> with memory integrity check).
>>>>>>>>>
>>>>>>>>>                                 |  no mTHP (ms) | 1M mTHP enabled (ms)
>>>>>>>>> Base kernel                     |   1165        |    1163
>>>>>>>>> Kernel with mTHP zswpin series  |   1203        |     738
>>>>>>>>
>>>>>>>> Hi Usama,
>>>>>>>> Do you know where this minor regression for non-mTHP comes from?
>>>>>>>> As you even have skipped swapcache for small folios in zswap in patch1,
>>>>>>>> that part should have some gain? is it because of zswap_present_test()?
>>>>>>>>
>>>>>>>
>>>>>>> Hi Barry,
>>>>>>>
>>>>>>> The microbenchmark does a sequential read of 1G of memory, so it probably
>>>>>>> isnt very representative of real world usecases. This also means that
>>>>>>> swap_vma_readahead is able to readahead accurately all pages in its window.
>>>>>>> With this patch series, if doing 4K swapin, you get 1G/4K calls of fast
>>>>>>> do_swap_page. Without this patch, you get 1G/(4K*readahead window) of slow
>>>>>>> do_swap_page calls. I had added some prints and I was seeing 8 pages being
>>>>>>> readahead in 1 do_swap_page. The larger number of calls causes the slight
>>>>>>> regression (eventhough they are quite fast). I think in a realistic scenario,
>>>>>>> where readahead window wont be as large, there wont be a regression.
>>>>>>> The cost of zswap_present_test in the whole call stack of swapping page is
>>>>>>> very low and I think can be ignored.
>>>>>>>
>>>>>>> I think the more interesting thing is what Kanchana pointed out in
>>>>>>> https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff@gmail.com/
>>>>>>> I am curious, did you see this when testing large folio swapin and compression
>>>>>>> at 4K granuality? Its looks like swap thrashing so I think it would be common
>>>>>>> between zswap and zram. I dont have larger granuality zswap compression done,
>>>>>>> which is why I think there is a regression in time taken. (It could be because
>>>>>>> its tested on intel as well).
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Usama
>>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> So I have been doing some benchmarking after Kanchana pointed out a performance
>>>>>> regression in [1] of swapping in large folio. I would love to get thoughts from
>>>>>> zram folks on this, as thats where large folio swapin was first added [2].
>>>>>> As far as I can see, the current support in zram is doing large folio swapin
>>>>>> at 4K granuality. The large granuality compression in [3] which was posted
>>>>>> in March is not merged, so I am currently comparing upstream zram with this series.
>>>>>>
>>>>>> With the microbenchmark below of timing 1G swapin, there was a very large improvement
>>>>>> in performance by using this series. I think similar numbers would be seen in zram.
>>>>>
>>>>> Imagine running several apps on a phone and switching
>>>>> between them: A → B → C → D → E … → A → B … The app
>>>>> currently on the screen retains its memory, while the ones
>>>>> sent to the background are swapped out. When we bring
>>>>> those apps back to the foreground, their memory is restored.
>>>>> This behavior is quite similar to what you're seeing with
>>>>> your microbenchmark.
>>>>>
>>>>
>>>> Hi Barry,
>>>>
>>>> Thanks for explaining this! Do you know if there is some open source benchmark
>>>> we could use to show an improvement in app switching with large folios?
>>>>
>>>
>>> I’m fairly certain the Android team has this benchmark, but it’s not
>>> open source.
>>>
>>> A straightforward way to simulate this is to use a script that
>>> cyclically launches multiple applications, such as Chrome, Firefox,
>>> Office, PDF, and others.
>>>
>>> for example:
>>>
>>> launch chrome;
>>> launch firefox;
>>> launch youtube;
>>> ....
>>> launch chrome;
>>> launch firefox;
>>> ....
>>>
>>> On Android, we have "Android activity manager 'am' command" to do that.
>>> https://gist.github.com/tsohr/5711945
>>>
>>> Not quite sure if other windows managers have similar tools.
>>>
>>>> Also I guess swap thrashing can happen when apps are brought back to foreground?
>>>>
>>>
>>> Typically, the foreground app doesn't experience much swapping,
>>> as it is the most recently or frequently used. However, this may
>>> not hold for very low-end phones, where memory is significantly
>>> less than the app's working set. For instance, we can't expect a
>>> good user experience when playing a large game that requires 8GB
>>> of memory on a 4GB phone! :-)
>>> And for low-end phones, we never even enable mTHP.
>>>
>>>>>>
>>>>>> But when doing kernel build test, Kanchana saw a regression in [1]. I believe
>>>>>> its because of swap thrashing (causing large zswap activity), due to larger page swapin.
>>>>>> The part of the code that decides large folio swapin is the same between zswap and zram,
>>>>>> so I believe this would be observed in zram as well.
>>>>>
>>>>> Is this an extreme case where the workload's working set far
>>>>> exceeds the available memory by memcg limitation? I doubt mTHP
>>>>> would provide any real benefit from the start if the workload is bound to
>>>>> experience swap thrashing. What if we disable mTHP entirely?
>>>>>
>>>>
>>>> I would agree, this is an extreme case. I wanted (z)swap activity to happen so limited
>>>> memory.max to 4G.
>>>>
>>>> mTHP is beneficial in kernel test benchmarking going from no mTHP to 16K:
>>>>
>>>> ARM make defconfig; time make -j$(nproc) Image, cgroup memory.max=4G
>>>> metric         no mTHP         16K mTHP=always
>>>> real           1m0.613s         0m52.008s
>>>> user           25m23.028s       25m19.488s
>>>> sys            25m45.466s       18m11.640s
>>>> zswpin         1911194          3108438
>>>> zswpout        6880815          9374628
>>>> pgfault        120430166        48976658
>>>> pgmajfault     1580674          2327086
>>>>
>>>>
>>>
>>> Interesting! We never use a phone to build the Linux kernel, but
>>> let me see if I can find some other machines to reproduce your data.
>>
>> Hi Usama,
>>
>> I suspect the regression occurs because you're running an edge case
>> where the memory cgroup stays nearly full most of the time (this isn't
>> an inherent issue with large folio swap-in). As a result, swapping in
>> mTHP quickly triggers a memcg overflow, causing a swap-out. The
>> next swap-in then recreates the overflow, leading to a repeating
>> cycle.
>>
> 
> Yes, agreed! Looking at the swap counters, I think this is what is going
> on as well.
> 
>> We need a way to stop the cup from repeatedly filling to the brim and
>> overflowing. While not a definitive fix, the following change might help
>> improve the situation:
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>
>> index 17af08367c68..f2fa0eeb2d9a 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>>
>> @@ -4559,7 +4559,10 @@ int mem_cgroup_swapin_charge_folio(struct folio
>> *folio, struct mm_struct *mm,
>>                 memcg = get_mem_cgroup_from_mm(mm);
>>         rcu_read_unlock();
>>
>> -       ret = charge_memcg(folio, memcg, gfp);
>> +       if (folio_test_large(folio) && mem_cgroup_margin(memcg) <
>> MEMCG_CHARGE_BATCH)
>> +               ret = -ENOMEM;
>> +       else
>> +               ret = charge_memcg(folio, memcg, gfp);
>>
>>         css_put(&memcg->css);
>>         return ret;
>> }
>>
> 
> The diff makes sense to me. Let me test later today and get back to you.
> 
> Thanks!
> 
>> Please confirm if it makes the kernel build with memcg limitation
>> faster. If so, let's
>> work together to figure out an official patch :-) The above code hasn't consider
>> the parent memcg's overflow, so not an ideal fix.
>>

Thanks Barry, I think this fixes the regression, and even gives an improvement!
I think the below might be better to do:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c098fd7f5c5e..0a1ec55cc079 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
                memcg = get_mem_cgroup_from_mm(mm);
        rcu_read_unlock();
 
-       ret = charge_memcg(folio, memcg, gfp);
+       if (folio_test_large(folio) &&
+           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio)))
+               ret = -ENOMEM;
+       else
+               ret = charge_memcg(folio, memcg, gfp);
 
        css_put(&memcg->css);
        return ret;


AMD 16K+32K THP=always
metric         mm-unstable      mm-unstable + large folio zswapin series    mm-unstable + large folio zswapin + no swap thrashing fix
real           1m23.038s        1m23.050s                                   1m22.704s
user           53m57.210s       53m53.437s                                  53m52.577s
sys            7m24.592s        7m48.843s                                   7m22.519s
zswpin         612070           999244                                      815934
zswpout        2226403          2347979                                     2054980
pgfault        20667366         20481728                                    20478690
pgmajfault     385887           269117                                      309702

AMD 16K+32K+64K THP=always
metric         mm-unstable      mm-unstable + large folio zswapin series   mm-unstable + large folio zswapin + no swap thrashing fix
real           1m22.975s        1m23.266s                                  1m22.549s
user           53m51.302s       53m51.069s                                 53m46.471s
sys            7m40.168s        7m57.104s                                  7m25.012s
zswpin         676492           1258573                                    1225703
zswpout        2449839          2714767                                    2899178
pgfault        17540746         17296555                                   17234663
pgmajfault     429629           307495                                     287859

>>>
>>>>
>>>>
>>>>>>
>>>>>> My initial thought was this might be because its intel, where you dont have the advantage
>>>>>> of TLB coalescing, so tested on AMD and ARM, but the regression is there on AMD
>>>>>> and ARM as well, though a bit less (have added the numbers below).
>>>>>>
>>>>>> The numbers show that the zswap activity increases and page faults decrease.
>>>>>> Overall this does result in sys time increasing and real time slightly increases,
>>>>>> likely because the cost of increased zswap activity is more than the benefit of
>>>>>> lower page faults.
>>>>>> I can see in [3] that pagefaults reduced in zram as well.
>>>>>>
>>>>>> Large folio swapin shows good numbers in microbenchmarks that just target reduce page
>>>>>> faults and sequential swapin only, but not in kernel build test. Is a similar regression
>>>>>> observed with zram when enabling large folio swapin on kernel build test? Maybe large
>>>>>> folio swapin makes more sense on workloads where mappings are kept for a longer time?
>>>>>>
>>>>>
>>>>> I suspect this is because mTHP doesn't always benefit workloads
>>>>> when available memory is quite limited compared to the working set.
>>>>> In that case, mTHP swap-in might introduce more features that
>>>>> exacerbate the problem. We used to have an extra control "swapin_enabled"
>>>>> for swap-in, but it never gained much traction:
>>>>> https://lore.kernel.org/linux-mm/20240726094618.401593-5-21cnbao@gmail.com/
>>>>> We can reconsider whether to include the knob, but if it's better
>>>>> to disable mTHP entirely for these cases, we can still adhere to
>>>>> the policy of "enabled".
>>>>>
>>>> Yes I think this makes sense to have. The only thing is, its too many knobs!
>>>> I personally think its already difficult to decide upto which mTHP size we
>>>> should enable (and I think this changes per workload). But if we add swapin_enabled
>>>> on top of that it can make things more difficult.
>>>>
>>>>> Using large block compression and decompression in zRAM will
>>>>> significantly reduce CPU usage, likely making the issue unnoticeable.
>>>>> However, the default minimum size for large block support is currently
>>>>> set to 64KB(ZSMALLOC_MULTI_PAGES_ORDER = 4).
>>>>>
>>>>
>>>> I saw that the patch was sent in March, and there werent any updates after?
>>>> Maybe I can try and cherry-pick that and see if we can develop large
>>>> granularity compression for zswap.
>>>
>>> will provide an updated version next week.
>>>
>>>>
>>>>>>
>>>>>> Kernel build numbers in cgroup with memory.max=4G to trigger zswap
>>>>>> Command for AMD: make defconfig; time make -j$(nproc) bzImage
>>>>>> Command for ARM: make defconfig; time make -j$(nproc) Image
>>>>>>
>>>>>>
>>>>>> AMD 16K+32K THP=always
>>>>>> metric         mm-unstable      mm-unstable + large folio zswapin series
>>>>>> real           1m23.038s        1m23.050s
>>>>>> user           53m57.210s       53m53.437s
>>>>>> sys            7m24.592s        7m48.843s
>>>>>> zswpin         612070           999244
>>>>>> zswpout        2226403          2347979
>>>>>> pgfault        20667366         20481728
>>>>>> pgmajfault     385887           269117
>>>>>>
>>>>>> AMD 16K+32K+64K THP=always
>>>>>> metric         mm-unstable      mm-unstable + large folio zswapin series
>>>>>> real           1m22.975s        1m23.266s
>>>>>> user           53m51.302s       53m51.069s
>>>>>> sys            7m40.168s        7m57.104s
>>>>>> zswpin         676492           1258573
>>>>>> zswpout        2449839          2714767
>>>>>> pgfault        17540746         17296555
>>>>>> pgmajfault     429629           307495
>>>>>> --------------------------
>>>>>> ARM 16K+32K THP=always
>>>>>> metric         mm-unstable      mm-unstable + large folio zswapin series
>>>>>> real           0m51.168s        0m52.086s
>>>>>> user           25m14.715s       25m15.765s
>>>>>> sys            17m18.856s       18m8.031s
>>>>>> zswpin         3904129          7339245
>>>>>> zswpout        11171295         13473461
>>>>>> pgfault        37313345         36011338
>>>>>> pgmajfault     2726253          1932642
>>>>>>
>>>>>>
>>>>>> ARM 16K+32K+64K THP=always
>>>>>> metric         mm-unstable      mm-unstable + large folio zswapin series
>>>>>> real           0m52.017s        0m53.828s
>>>>>> user           25m2.742s        25m0.046s
>>>>>> sys            18m24.525s       20m26.207s
>>>>>> zswpin         4853571          8908664
>>>>>> zswpout        12297199         15768764
>>>>>> pgfault        32158152         30425519
>>>>>> pgmajfault     3320717          2237015
>>>>>>
>>>>>>
>>>>>> Thanks!
>>>>>> Usama
>>>>>>
>>>>>>
>>>>>> [1] https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff@gmail.com/
>>>>>> [2] https://lore.kernel.org/all/20240821074541.516249-3-hanchuanhua@oppo.com/
>>>>>> [3] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/
>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>> The time measured was pretty consistent between runs (~1-2% variation).
>>>>>>>>> There is 36% improvement in zswapin time with 1M folios. The percentage
>>>>>>>>> improvement is likely to be more if the memcmp is removed.
>>>>>>>>>
>>>>>>>>> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
>>>>>>>>> index 40de679248b8..77068c577c86 100644
>>>>>>>>> --- a/tools/testing/selftests/cgroup/test_zswap.c
>>>>>>>>> +++ b/tools/testing/selftests/cgroup/test_zswap.c
>>>>>>>>> @@ -9,6 +9,8 @@
>>>>>>>>>  #include <string.h>
>>>>>>>>>  #include <sys/wait.h>
>>>>>>>>>  #include <sys/mman.h>
>>>>>>>>> +#include <sys/time.h>
>>>>>>>>> +#include <malloc.h>
>>>>>>>>>
>>>>>>>>>  #include "../kselftest.h"
>>>>>>>>>  #include "cgroup_util.h"
>>>>>>>>> @@ -407,6 +409,74 @@ static int test_zswap_writeback_disabled(const char *root)
>>>>>>>>>         return test_zswap_writeback(root, false);
>>>>>>>>>  }
>>>>>>>>>
>>>>>>>>> +static int zswapin_perf(const char *cgroup, void *arg)
>>>>>>>>> +{
>>>>>>>>> +       long pagesize = sysconf(_SC_PAGESIZE);
>>>>>>>>> +       size_t memsize = MB(1*1024);
>>>>>>>>> +       char buf[pagesize];
>>>>>>>>> +       int ret = -1;
>>>>>>>>> +       char *mem;
>>>>>>>>> +       struct timeval start, end;
>>>>>>>>> +
>>>>>>>>> +       mem = (char *)memalign(2*1024*1024, memsize);
>>>>>>>>> +       if (!mem)
>>>>>>>>> +               return ret;
>>>>>>>>> +
>>>>>>>>> +       /*
>>>>>>>>> +        * Fill half of each page with increasing data, and keep other
>>>>>>>>> +        * half empty, this will result in data that is still compressible
>>>>>>>>> +        * and ends up in zswap, with material zswap usage.
>>>>>>>>> +        */
>>>>>>>>> +       for (int i = 0; i < pagesize; i++)
>>>>>>>>> +               buf[i] = i < pagesize/2 ? (char) i : 0;
>>>>>>>>> +
>>>>>>>>> +       for (int i = 0; i < memsize; i += pagesize)
>>>>>>>>> +               memcpy(&mem[i], buf, pagesize);
>>>>>>>>> +
>>>>>>>>> +       /* Try and reclaim allocated memory */
>>>>>>>>> +       if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
>>>>>>>>> +               ksft_print_msg("Failed to reclaim all of the requested memory\n");
>>>>>>>>> +               goto out;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       gettimeofday(&start, NULL);
>>>>>>>>> +       /* zswpin */
>>>>>>>>> +       for (int i = 0; i < memsize; i += pagesize) {
>>>>>>>>> +               if (memcmp(&mem[i], buf, pagesize)) {
>>>>>>>>> +                       ksft_print_msg("invalid memory\n");
>>>>>>>>> +                       goto out;
>>>>>>>>> +               }
>>>>>>>>> +       }
>>>>>>>>> +       gettimeofday(&end, NULL);
>>>>>>>>> +       printf ("zswapin took %fms to run.\n", (end.tv_sec - start.tv_sec)*1000 + (double)(end.tv_usec - start.tv_usec) / 1000);
>>>>>>>>> +       ret = 0;
>>>>>>>>> +out:
>>>>>>>>> +       free(mem);
>>>>>>>>> +       return ret;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int test_zswapin_perf(const char *root)
>>>>>>>>> +{
>>>>>>>>> +       int ret = KSFT_FAIL;
>>>>>>>>> +       char *test_group;
>>>>>>>>> +
>>>>>>>>> +       test_group = cg_name(root, "zswapin_perf_test");
>>>>>>>>> +       if (!test_group)
>>>>>>>>> +               goto out;
>>>>>>>>> +       if (cg_create(test_group))
>>>>>>>>> +               goto out;
>>>>>>>>> +
>>>>>>>>> +       if (cg_run(test_group, zswapin_perf, NULL))
>>>>>>>>> +               goto out;
>>>>>>>>> +
>>>>>>>>> +       ret = KSFT_PASS;
>>>>>>>>> +out:
>>>>>>>>> +       cg_destroy(test_group);
>>>>>>>>> +       free(test_group);
>>>>>>>>> +       return ret;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>  /*
>>>>>>>>>   * When trying to store a memcg page in zswap, if the memcg hits its memory
>>>>>>>>>   * limit in zswap, writeback should affect only the zswapped pages of that
>>>>>>>>> @@ -584,6 +654,7 @@ struct zswap_test {
>>>>>>>>>         T(test_zswapin),
>>>>>>>>>         T(test_zswap_writeback_enabled),
>>>>>>>>>         T(test_zswap_writeback_disabled),
>>>>>>>>> +       T(test_zswapin_perf),
>>>>>>>>>         T(test_no_kmem_bypass),
>>>>>>>>>         T(test_no_invasive_cgroup_shrink),
>>>>>>>>>  };
>>>>>>>>>
>>>>>>>>> [1] https://lore.kernel.org/all/20241001053222.6944-1-kanchana.p.sridhar@intel.com/
>>>>>>>>> [2] https://lore.kernel.org/all/20240821074541.516249-1-hanchuanhua@oppo.com/
>>>>>>>>> [3] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minchan@kernel.org/T/#u
>>>>>>>>> [4] https://lwn.net/Articles/955575/
>>>>>>>>>
>>>>>>>>> Usama Arif (4):
>>>>>>>>>   mm/zswap: skip swapcache for swapping in zswap pages
>>>>>>>>>   mm/zswap: modify zswap_decompress to accept page instead of folio
>>>>>>>>>   mm/zswap: add support for large folio zswapin
>>>>>>>>>   mm/zswap: count successful large folio zswap loads
>>>>>>>>>
>>>>>>>>>  Documentation/admin-guide/mm/transhuge.rst |   3 +
>>>>>>>>>  include/linux/huge_mm.h                    |   1 +
>>>>>>>>>  include/linux/zswap.h                      |   6 ++
>>>>>>>>>  mm/huge_memory.c                           |   3 +
>>>>>>>>>  mm/memory.c                                |  16 +--
>>>>>>>>>  mm/page_io.c                               |   2 +-
>>>>>>>>>  mm/zswap.c                                 | 120 ++++++++++++++-------
>>>>>>>>>  7 files changed, 99 insertions(+), 52 deletions(-)
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> 2.43.5
>>>>>>>>>
>>>>>>>>
>>>>>
>>>
>>
>> Thanks
>> Barry
> 


