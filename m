Return-Path: <linux-kernel+bounces-376465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E85879AB1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50933B2167B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FB1A303E;
	Tue, 22 Oct 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWa2w6PJ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3219D881;
	Tue, 22 Oct 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610797; cv=none; b=GJdNfRHPrjNl8T1FZSddjmDgVv/QSSnxnieS+EAsom9dlgc2YfiPP98+8N0SN5fvYxx9gTyivy99hPXAghQ7BTx7EPbXjc37USP5iKqug4z8fMpmfDFDhlfv8xaWh+BPTPT5h1gls0FslKaLpNYAomm5P9L4vPQ5c8IyheKviLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610797; c=relaxed/simple;
	bh=NDAtJMFX1jZkcLXmiRKufpyfO/jwsbOX9qMQavwEWq8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LtPQ+DHio750mMcpKat4sblE54YqWeboG/x0HKk0a9Tsek6zwCZc9Y1u61G8ZWMeU43T+/KjZix26MXZkC1xkggcUuQk3VVvV/EJzMlbe7CO3wFkGhhGtPmzJjLAnJ3U+8SQW8kyVKQeJNEjS9yW1RCtztmEG2ZopTo+aEyJIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWa2w6PJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so5535461f8f.2;
        Tue, 22 Oct 2024 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729610793; x=1730215593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYNNrpOIYVX0dlsGXwbH7XgSdu1ERfXvh3x7QQBxaZY=;
        b=AWa2w6PJ57ogSx6Kr1YswC5VgqJCJNFaYzj3je6LIU0pH0ea39uo+h8MqPqfXL3t7H
         SQ7dRZ09ciNGRstTw/lwcwPfIqi23ArT9ykYvUgTmWwVRt4KFj6q0iNzwMDYOHGlji38
         qzH4O/08IdCw6B/4TAYOUA8av3LrLX1NWLh5IQe69AvK2R8CbZyH6AdJ8tDRUJithkcL
         pdr9qEHHtlhag6Fqe0FGLVDX84TDrt0Ybu45x9ODtT8ZR3gcZz5NAKK9g7PJngSv0uos
         mPnEAQrvcbf1fDgDAJkMS9/MrkpFdgz9lGyrYW2fJ4MQwTH58df3KL1V/x4AgV5GAjm0
         6oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610793; x=1730215593;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYNNrpOIYVX0dlsGXwbH7XgSdu1ERfXvh3x7QQBxaZY=;
        b=CgNBf9gvhX303dEzWRZvlkxTgVRZgVY6lXdTEJTDYuvpTpZ1cYXDhv1m3ne3tQ8bfI
         Mq4wSwjV1KS7jUBZt/KO7ulPXi9X8wIYTTqEzuINI9p5+3nzH8rFXPdjXnsAHcgKXGak
         gbIwPwtPtxpAVb2xaB+lvR26HMR4a6MIe1jloprn/Z979kWUKwwOMIOejc8XEQHiwA0e
         SCD2bONhsWd2i4On7GQXETiLTEaZ+lwUSWAwy+3MpOJNpC3pydDZtkNiLTGWz32ENhSp
         SpX5qbkGEwofEdWjRmZy/jzX3/YigiAZYNMxO0m/DYpsQUX4/O6uEzQwjGk4f63Xj9mn
         lczw==
X-Forwarded-Encrypted: i=1; AJvYcCU6PtQkSdkT7nHNP/k+iht7+0+lgskPVU9cGv7wxp7PPhWqwcBwUiR5PcuDB/3cHmzfNb4NLkUKi1I=@vger.kernel.org, AJvYcCWGfh0k4dLqS/XQ3l9rNTXE6DyKQSz9qV3o2t0Sic5XXamxk9B3hkEvoQWm2BKGHaCXwGinkCOEUqw++P/W@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuZU+2GItx6lToJQanyr5CBtA3586hn4MJzW9d4jz5iDslYWA
	IcvpzmarYOWGrOuomQd5ZchoqhGzqRxvdAJM59M4oqOHVkfyfpdX
X-Google-Smtp-Source: AGHT+IGXH4UOpaNAL2bKJQfbp2WCujv53QfRJkPyL4TvZ29D2BiL6+TPMsoLsnKiJWukCbYfWCz0eQ==
X-Received: by 2002:a05:6000:90:b0:37d:5296:4b37 with SMTP id ffacd0b85a97d-37eab2e2fbbmr13509354f8f.24.1729610792916;
        Tue, 22 Oct 2024 08:26:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:996c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edb6asm352566366b.49.2024.10.22.08.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:26:32 -0700 (PDT)
Message-ID: <b1c17b5e-acd9-4bef-820e-699768f1426d@gmail.com>
Date: Tue, 22 Oct 2024 16:26:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
From: Usama Arif <usamaarif642@gmail.com>
To: Barry Song <21cnbao@gmail.com>, senozhatsky@chromium.org,
 minchan@kernel.org, hanchuanhua@oppo.com, v-songbaohua@oppo.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 ryan.roberts@arm.com, ying.huang@intel.com, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <CAGsJ_4xweuSwMUBuLSr2eUy69mtQumeDpMZ1g2jFPGq6nFn9fg@mail.gmail.com>
 <5313c721-9cf1-4ecd-ac23-1eeddabd691f@gmail.com>
Content-Language: en-US
In-Reply-To: <5313c721-9cf1-4ecd-ac23-1eeddabd691f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/10/2024 11:40, Usama Arif wrote:
> 
> 
> On 21/10/2024 06:09, Barry Song wrote:
>> On Fri, Oct 18, 2024 at 11:50 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>> After large folio zswapout support added in [1], this patch adds
>>> support for zswapin of large folios to bring it on par with zram.
>>> This series makes sure that the benefits of large folios (fewer
>>> page faults, batched PTE and rmap manipulation, reduced lru list,
>>> TLB coalescing (for arm64 and amd)) are not lost at swap out when
>>> using zswap.
>>>
>>> It builds on top of [2] which added large folio swapin support for
>>> zram and provides the same level of large folio swapin support as
>>> zram, i.e. only supporting swap count == 1.
>>>
>>> Patch 1 skips swapcache for swapping in zswap pages, this should improve
>>> no readahead swapin performance [3], and also allows us to build on large
>>> folio swapin support added in [2], hence is a prerequisite for patch 3.
>>>
>>> Patch 3 adds support for large folio zswapin. This patch does not add
>>> support for hybrid backends (i.e. folios partly present swap and zswap).
>>>
>>> The main performance benefit comes from maintaining large folios *after*
>>> swapin, large folio performance improvements have been mentioned in previous
>>> series posted on it [2],[4], so have not added those. Below is a simple
>>> microbenchmark to measure the time needed *for* zswpin of 1G memory (along
>>> with memory integrity check).
>>>
>>>                                 |  no mTHP (ms) | 1M mTHP enabled (ms)
>>> Base kernel                     |   1165        |    1163
>>> Kernel with mTHP zswpin series  |   1203        |     738
>>
>> Hi Usama,
>> Do you know where this minor regression for non-mTHP comes from?
>> As you even have skipped swapcache for small folios in zswap in patch1,
>> that part should have some gain? is it because of zswap_present_test()?
>>
> 
> Hi Barry,
> 
> The microbenchmark does a sequential read of 1G of memory, so it probably
> isnt very representative of real world usecases. This also means that
> swap_vma_readahead is able to readahead accurately all pages in its window.
> With this patch series, if doing 4K swapin, you get 1G/4K calls of fast
> do_swap_page. Without this patch, you get 1G/(4K*readahead window) of slow
> do_swap_page calls. I had added some prints and I was seeing 8 pages being
> readahead in 1 do_swap_page. The larger number of calls causes the slight
> regression (eventhough they are quite fast). I think in a realistic scenario,
> where readahead window wont be as large, there wont be a regression.
> The cost of zswap_present_test in the whole call stack of swapping page is
> very low and I think can be ignored.
> 
> I think the more interesting thing is what Kanchana pointed out in
> https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff@gmail.com/
> I am curious, did you see this when testing large folio swapin and compression
> at 4K granuality? Its looks like swap thrashing so I think it would be common
> between zswap and zram. I dont have larger granuality zswap compression done,
> which is why I think there is a regression in time taken. (It could be because
> its tested on intel as well).
> 
> Thanks,
> Usama
> 

Hi,

So I have been doing some benchmarking after Kanchana pointed out a performance
regression in [1] of swapping in large folio. I would love to get thoughts from
zram folks on this, as thats where large folio swapin was first added [2].
As far as I can see, the current support in zram is doing large folio swapin
at 4K granuality. The large granuality compression in [3] which was posted
in March is not merged, so I am currently comparing upstream zram with this series. 

With the microbenchmark below of timing 1G swapin, there was a very large improvement
in performance by using this series. I think similar numbers would be seen in zram.

But when doing kernel build test, Kanchana saw a regression in [1]. I believe
its because of swap thrashing (causing large zswap activity), due to larger page swapin.
The part of the code that decides large folio swapin is the same between zswap and zram,
so I believe this would be observed in zram as well.

My initial thought was this might be because its intel, where you dont have the advantage
of TLB coalescing, so tested on AMD and ARM, but the regression is there on AMD
and ARM as well, though a bit less (have added the numbers below).

The numbers show that the zswap activity increases and page faults decrease.
Overall this does result in sys time increasing and real time slightly increases,
likely because the cost of increased zswap activity is more than the benefit of
lower page faults.
I can see in [3] that pagefaults reduced in zram as well.

Large folio swapin shows good numbers in microbenchmarks that just target reduce page
faults and sequential swapin only, but not in kernel build test. Is a similar regression
observed with zram when enabling large folio swapin on kernel build test? Maybe large
folio swapin makes more sense on workloads where mappings are kept for a longer time?


Kernel build numbers in cgroup with memory.max=4G to trigger zswap
Command for AMD: make defconfig; time make -j$(nproc) bzImage
Command for ARM: make defconfig; time make -j$(nproc) Image


AMD 16K+32K THP=always
metric         mm-unstable      mm-unstable + large folio zswapin series
real           1m23.038s        1m23.050s
user           53m57.210s       53m53.437s
sys            7m24.592s        7m48.843s
zswpin         612070           999244
zswpout        2226403          2347979
pgfault        20667366         20481728
pgmajfault     385887           269117

AMD 16K+32K+64K THP=always
metric         mm-unstable      mm-unstable + large folio zswapin series
real           1m22.975s        1m23.266s
user           53m51.302s       53m51.069s
sys            7m40.168s        7m57.104s
zswpin         676492           1258573
zswpout        2449839          2714767
pgfault        17540746         17296555
pgmajfault     429629           307495
--------------------------
ARM 16K+32K THP=always
metric         mm-unstable      mm-unstable + large folio zswapin series
real           0m51.168s        0m52.086s
user           25m14.715s       25m15.765s
sys            17m18.856s       18m8.031s
zswpin         3904129          7339245
zswpout        11171295         13473461
pgfault        37313345         36011338
pgmajfault     2726253          1932642


ARM 16K+32K+64K THP=always
metric         mm-unstable      mm-unstable + large folio zswapin series
real           0m52.017s        0m53.828s
user           25m2.742s        25m0.046s
sys            18m24.525s       20m26.207s
zswpin         4853571          8908664
zswpout        12297199         15768764
pgfault        32158152         30425519
pgmajfault     3320717          2237015


Thanks!
Usama


[1] https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff@gmail.com/
[2] https://lore.kernel.org/all/20240821074541.516249-3-hanchuanhua@oppo.com/
[3] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/

> 
>>>
>>> The time measured was pretty consistent between runs (~1-2% variation).
>>> There is 36% improvement in zswapin time with 1M folios. The percentage
>>> improvement is likely to be more if the memcmp is removed.
>>>
>>> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
>>> index 40de679248b8..77068c577c86 100644
>>> --- a/tools/testing/selftests/cgroup/test_zswap.c
>>> +++ b/tools/testing/selftests/cgroup/test_zswap.c
>>> @@ -9,6 +9,8 @@
>>>  #include <string.h>
>>>  #include <sys/wait.h>
>>>  #include <sys/mman.h>
>>> +#include <sys/time.h>
>>> +#include <malloc.h>
>>>
>>>  #include "../kselftest.h"
>>>  #include "cgroup_util.h"
>>> @@ -407,6 +409,74 @@ static int test_zswap_writeback_disabled(const char *root)
>>>         return test_zswap_writeback(root, false);
>>>  }
>>>
>>> +static int zswapin_perf(const char *cgroup, void *arg)
>>> +{
>>> +       long pagesize = sysconf(_SC_PAGESIZE);
>>> +       size_t memsize = MB(1*1024);
>>> +       char buf[pagesize];
>>> +       int ret = -1;
>>> +       char *mem;
>>> +       struct timeval start, end;
>>> +
>>> +       mem = (char *)memalign(2*1024*1024, memsize);
>>> +       if (!mem)
>>> +               return ret;
>>> +
>>> +       /*
>>> +        * Fill half of each page with increasing data, and keep other
>>> +        * half empty, this will result in data that is still compressible
>>> +        * and ends up in zswap, with material zswap usage.
>>> +        */
>>> +       for (int i = 0; i < pagesize; i++)
>>> +               buf[i] = i < pagesize/2 ? (char) i : 0;
>>> +
>>> +       for (int i = 0; i < memsize; i += pagesize)
>>> +               memcpy(&mem[i], buf, pagesize);
>>> +
>>> +       /* Try and reclaim allocated memory */
>>> +       if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
>>> +               ksft_print_msg("Failed to reclaim all of the requested memory\n");
>>> +               goto out;
>>> +       }
>>> +
>>> +       gettimeofday(&start, NULL);
>>> +       /* zswpin */
>>> +       for (int i = 0; i < memsize; i += pagesize) {
>>> +               if (memcmp(&mem[i], buf, pagesize)) {
>>> +                       ksft_print_msg("invalid memory\n");
>>> +                       goto out;
>>> +               }
>>> +       }
>>> +       gettimeofday(&end, NULL);
>>> +       printf ("zswapin took %fms to run.\n", (end.tv_sec - start.tv_sec)*1000 + (double)(end.tv_usec - start.tv_usec) / 1000);
>>> +       ret = 0;
>>> +out:
>>> +       free(mem);
>>> +       return ret;
>>> +}
>>> +
>>> +static int test_zswapin_perf(const char *root)
>>> +{
>>> +       int ret = KSFT_FAIL;
>>> +       char *test_group;
>>> +
>>> +       test_group = cg_name(root, "zswapin_perf_test");
>>> +       if (!test_group)
>>> +               goto out;
>>> +       if (cg_create(test_group))
>>> +               goto out;
>>> +
>>> +       if (cg_run(test_group, zswapin_perf, NULL))
>>> +               goto out;
>>> +
>>> +       ret = KSFT_PASS;
>>> +out:
>>> +       cg_destroy(test_group);
>>> +       free(test_group);
>>> +       return ret;
>>> +}
>>> +
>>>  /*
>>>   * When trying to store a memcg page in zswap, if the memcg hits its memory
>>>   * limit in zswap, writeback should affect only the zswapped pages of that
>>> @@ -584,6 +654,7 @@ struct zswap_test {
>>>         T(test_zswapin),
>>>         T(test_zswap_writeback_enabled),
>>>         T(test_zswap_writeback_disabled),
>>> +       T(test_zswapin_perf),
>>>         T(test_no_kmem_bypass),
>>>         T(test_no_invasive_cgroup_shrink),
>>>  };
>>>
>>> [1] https://lore.kernel.org/all/20241001053222.6944-1-kanchana.p.sridhar@intel.com/
>>> [2] https://lore.kernel.org/all/20240821074541.516249-1-hanchuanhua@oppo.com/
>>> [3] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minchan@kernel.org/T/#u
>>> [4] https://lwn.net/Articles/955575/
>>>
>>> Usama Arif (4):
>>>   mm/zswap: skip swapcache for swapping in zswap pages
>>>   mm/zswap: modify zswap_decompress to accept page instead of folio
>>>   mm/zswap: add support for large folio zswapin
>>>   mm/zswap: count successful large folio zswap loads
>>>
>>>  Documentation/admin-guide/mm/transhuge.rst |   3 +
>>>  include/linux/huge_mm.h                    |   1 +
>>>  include/linux/zswap.h                      |   6 ++
>>>  mm/huge_memory.c                           |   3 +
>>>  mm/memory.c                                |  16 +--
>>>  mm/page_io.c                               |   2 +-
>>>  mm/zswap.c                                 | 120 ++++++++++++++-------
>>>  7 files changed, 99 insertions(+), 52 deletions(-)
>>>
>>> --
>>> 2.43.5
>>>
>>
>> Thanks
>> barry
> 


