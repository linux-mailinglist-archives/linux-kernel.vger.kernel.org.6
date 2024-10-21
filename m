Return-Path: <linux-kernel+bounces-374125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA6F9A645B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803081C2207F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556101E9062;
	Mon, 21 Oct 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/oM4QOE"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D21E0087;
	Mon, 21 Oct 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507220; cv=none; b=B30NV8/64XrwESnIzGiY4NpIlR3/VpOq8ZH5R4tqYyQHOXgssQ7YyGagSiJ6kOmLQcAxX8CBCndkQ2yhIJqpOIRYI6cNp0Outw9JNi1H+vXzoDLoCdHA64gkbG5GXLiJSbRAeCKZhkOVoOjmGk1nWQmgKwFgfCA1m4gtzYZQ1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507220; c=relaxed/simple;
	bh=mVFrJy347WsPGqvhqcH0UEh6N6HS0zGY/NhHSGFn9mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cc+p86GvYxYfqYabiYmnwmcXb7DbTNWuPBl0RpyB4hBPaqfb8jEB2yGMQpiAMjI32aSdtenu5xqqvNNBL5o0VsLkHKHvy6GeFMi6dQTdcNnXgHnMHadwfD5XsjrGaQVJRJsg91cSjLqR0P/KCZr/9sokYAVeC1xbP6xjsbWTF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/oM4QOE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43159c9f617so40454075e9.2;
        Mon, 21 Oct 2024 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729507215; x=1730112015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnbQLQNXgDDzHRa5q+9hDUp0GY0SqbeRkHPHQH6iHt4=;
        b=N/oM4QOEZZGkn8jjNpP/32iXbq52fYniHb7LVzCqiKzcsa+vRC2smCF3OoLE1aTV+S
         7bCKskmSeyHpVvZDTQjGX1CgeZkZLiVDPoXPkodQF6kMtMcf6bEMjEbKTb4LdFzkeZeG
         T9plXom2pXxOQBUNroYZ7LTmnF5H0pxiPJUyvryB15v23v4OYYpOSo3aTQxTD+OBMv38
         GCtnrU8BnILSmmbWOTD9X4L07fm7et6AyByeziFYoVutYBWTKxKwl5RHfQ4HffiRPqZK
         px98972lXWAZzOAnz0Rxjx0mUuKdCWpaq2Hhd6awc7rbF2GI13KW7bghnSRlwL2lUjWv
         AL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507215; x=1730112015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnbQLQNXgDDzHRa5q+9hDUp0GY0SqbeRkHPHQH6iHt4=;
        b=DjmDYxARuGoZedTpAFgEKuVPelEevMGnujPtxNpOuQYaz9CEhVTGTWCc5Dcii76yPk
         z0NpITC5xcMGBB0yl+M7KPa78G/URQxne+MJIZxTbCbW2PR84JscG4YHgGp1tcA0sDbH
         6uys7KT9buI4E//Sb+xlbULKh8KrpmGDvSO0IdLie1cG3ZEdsAINQBWKNvamAFFCvg7I
         f6CDWV8YDrYnJBFNc1/zDoQw8EMjePKImTO8uq96V8D3DHePK710g3x05EnIL6HrBftm
         FRPlEKY4qetKFjaouaD9W2H6g4kPceR/TVrdzGE2Xq9P1cAzQcTOluZ7uUZObERFq9/y
         tSVA==
X-Forwarded-Encrypted: i=1; AJvYcCW55fAmM1cj8WV13KT+iA8q60tZgX3pzVAbBp1+c0s4gI7J6bLop4lHyd1d79D7/xIXjU1/puOIMlsPMfaU@vger.kernel.org, AJvYcCXzA71BmZ0SDF/0hkTO99kw5dxsVbxG6JQMpoGBU58Yzq4lEudzHPuNWUfI8DVgMsF+rvxJAfpfgU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGC7w5MNd4LIvYXJ+2ezJzK5hUbHnZqiYJQq8iwesEBunfhNvA
	jsYGVRhbGjbHBUW6u6alKOoY3nkM7RETSNdewnxOqR07xuBHZ0Z2
X-Google-Smtp-Source: AGHT+IG4hfO9+W1ZHBvjTnfeKOm+a7Sf0EqUAMbzYF/KpdnVWfIbsWJ/48aJWvSGvczeZspKs8IjxA==
X-Received: by 2002:a05:600c:4e12:b0:431:50fa:89c4 with SMTP id 5b1f17b1804b1-43161622aa4mr84207715e9.3.1729507215200;
        Mon, 21 Oct 2024 03:40:15 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a58cc2sm3992400f8f.54.2024.10.21.03.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:40:14 -0700 (PDT)
Message-ID: <5313c721-9cf1-4ecd-ac23-1eeddabd691f@gmail.com>
Date: Mon, 21 Oct 2024 11:40:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 ryan.roberts@arm.com, ying.huang@intel.com, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <CAGsJ_4xweuSwMUBuLSr2eUy69mtQumeDpMZ1g2jFPGq6nFn9fg@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4xweuSwMUBuLSr2eUy69mtQumeDpMZ1g2jFPGq6nFn9fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/10/2024 06:09, Barry Song wrote:
> On Fri, Oct 18, 2024 at 11:50 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> After large folio zswapout support added in [1], this patch adds
>> support for zswapin of large folios to bring it on par with zram.
>> This series makes sure that the benefits of large folios (fewer
>> page faults, batched PTE and rmap manipulation, reduced lru list,
>> TLB coalescing (for arm64 and amd)) are not lost at swap out when
>> using zswap.
>>
>> It builds on top of [2] which added large folio swapin support for
>> zram and provides the same level of large folio swapin support as
>> zram, i.e. only supporting swap count == 1.
>>
>> Patch 1 skips swapcache for swapping in zswap pages, this should improve
>> no readahead swapin performance [3], and also allows us to build on large
>> folio swapin support added in [2], hence is a prerequisite for patch 3.
>>
>> Patch 3 adds support for large folio zswapin. This patch does not add
>> support for hybrid backends (i.e. folios partly present swap and zswap).
>>
>> The main performance benefit comes from maintaining large folios *after*
>> swapin, large folio performance improvements have been mentioned in previous
>> series posted on it [2],[4], so have not added those. Below is a simple
>> microbenchmark to measure the time needed *for* zswpin of 1G memory (along
>> with memory integrity check).
>>
>>                                 |  no mTHP (ms) | 1M mTHP enabled (ms)
>> Base kernel                     |   1165        |    1163
>> Kernel with mTHP zswpin series  |   1203        |     738
> 
> Hi Usama,
> Do you know where this minor regression for non-mTHP comes from?
> As you even have skipped swapcache for small folios in zswap in patch1,
> that part should have some gain? is it because of zswap_present_test()?
> 

Hi Barry,

The microbenchmark does a sequential read of 1G of memory, so it probably
isnt very representative of real world usecases. This also means that
swap_vma_readahead is able to readahead accurately all pages in its window.
With this patch series, if doing 4K swapin, you get 1G/4K calls of fast
do_swap_page. Without this patch, you get 1G/(4K*readahead window) of slow
do_swap_page calls. I had added some prints and I was seeing 8 pages being
readahead in 1 do_swap_page. The larger number of calls causes the slight
regression (eventhough they are quite fast). I think in a realistic scenario,
where readahead window wont be as large, there wont be a regression.
The cost of zswap_present_test in the whole call stack of swapping page is
very low and I think can be ignored.

I think the more interesting thing is what Kanchana pointed out in
https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff@gmail.com/
I am curious, did you see this when testing large folio swapin and compression
at 4K granuality? Its looks like swap thrashing so I think it would be common
between zswap and zram. I dont have larger granuality zswap compression done,
which is why I think there is a regression in time taken. (It could be because
its tested on intel as well).

Thanks,
Usama


>>
>> The time measured was pretty consistent between runs (~1-2% variation).
>> There is 36% improvement in zswapin time with 1M folios. The percentage
>> improvement is likely to be more if the memcmp is removed.
>>
>> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
>> index 40de679248b8..77068c577c86 100644
>> --- a/tools/testing/selftests/cgroup/test_zswap.c
>> +++ b/tools/testing/selftests/cgroup/test_zswap.c
>> @@ -9,6 +9,8 @@
>>  #include <string.h>
>>  #include <sys/wait.h>
>>  #include <sys/mman.h>
>> +#include <sys/time.h>
>> +#include <malloc.h>
>>
>>  #include "../kselftest.h"
>>  #include "cgroup_util.h"
>> @@ -407,6 +409,74 @@ static int test_zswap_writeback_disabled(const char *root)
>>         return test_zswap_writeback(root, false);
>>  }
>>
>> +static int zswapin_perf(const char *cgroup, void *arg)
>> +{
>> +       long pagesize = sysconf(_SC_PAGESIZE);
>> +       size_t memsize = MB(1*1024);
>> +       char buf[pagesize];
>> +       int ret = -1;
>> +       char *mem;
>> +       struct timeval start, end;
>> +
>> +       mem = (char *)memalign(2*1024*1024, memsize);
>> +       if (!mem)
>> +               return ret;
>> +
>> +       /*
>> +        * Fill half of each page with increasing data, and keep other
>> +        * half empty, this will result in data that is still compressible
>> +        * and ends up in zswap, with material zswap usage.
>> +        */
>> +       for (int i = 0; i < pagesize; i++)
>> +               buf[i] = i < pagesize/2 ? (char) i : 0;
>> +
>> +       for (int i = 0; i < memsize; i += pagesize)
>> +               memcpy(&mem[i], buf, pagesize);
>> +
>> +       /* Try and reclaim allocated memory */
>> +       if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
>> +               ksft_print_msg("Failed to reclaim all of the requested memory\n");
>> +               goto out;
>> +       }
>> +
>> +       gettimeofday(&start, NULL);
>> +       /* zswpin */
>> +       for (int i = 0; i < memsize; i += pagesize) {
>> +               if (memcmp(&mem[i], buf, pagesize)) {
>> +                       ksft_print_msg("invalid memory\n");
>> +                       goto out;
>> +               }
>> +       }
>> +       gettimeofday(&end, NULL);
>> +       printf ("zswapin took %fms to run.\n", (end.tv_sec - start.tv_sec)*1000 + (double)(end.tv_usec - start.tv_usec) / 1000);
>> +       ret = 0;
>> +out:
>> +       free(mem);
>> +       return ret;
>> +}
>> +
>> +static int test_zswapin_perf(const char *root)
>> +{
>> +       int ret = KSFT_FAIL;
>> +       char *test_group;
>> +
>> +       test_group = cg_name(root, "zswapin_perf_test");
>> +       if (!test_group)
>> +               goto out;
>> +       if (cg_create(test_group))
>> +               goto out;
>> +
>> +       if (cg_run(test_group, zswapin_perf, NULL))
>> +               goto out;
>> +
>> +       ret = KSFT_PASS;
>> +out:
>> +       cg_destroy(test_group);
>> +       free(test_group);
>> +       return ret;
>> +}
>> +
>>  /*
>>   * When trying to store a memcg page in zswap, if the memcg hits its memory
>>   * limit in zswap, writeback should affect only the zswapped pages of that
>> @@ -584,6 +654,7 @@ struct zswap_test {
>>         T(test_zswapin),
>>         T(test_zswap_writeback_enabled),
>>         T(test_zswap_writeback_disabled),
>> +       T(test_zswapin_perf),
>>         T(test_no_kmem_bypass),
>>         T(test_no_invasive_cgroup_shrink),
>>  };
>>
>> [1] https://lore.kernel.org/all/20241001053222.6944-1-kanchana.p.sridhar@intel.com/
>> [2] https://lore.kernel.org/all/20240821074541.516249-1-hanchuanhua@oppo.com/
>> [3] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minchan@kernel.org/T/#u
>> [4] https://lwn.net/Articles/955575/
>>
>> Usama Arif (4):
>>   mm/zswap: skip swapcache for swapping in zswap pages
>>   mm/zswap: modify zswap_decompress to accept page instead of folio
>>   mm/zswap: add support for large folio zswapin
>>   mm/zswap: count successful large folio zswap loads
>>
>>  Documentation/admin-guide/mm/transhuge.rst |   3 +
>>  include/linux/huge_mm.h                    |   1 +
>>  include/linux/zswap.h                      |   6 ++
>>  mm/huge_memory.c                           |   3 +
>>  mm/memory.c                                |  16 +--
>>  mm/page_io.c                               |   2 +-
>>  mm/zswap.c                                 | 120 ++++++++++++++-------
>>  7 files changed, 99 insertions(+), 52 deletions(-)
>>
>> --
>> 2.43.5
>>
> 
> Thanks
> barry


