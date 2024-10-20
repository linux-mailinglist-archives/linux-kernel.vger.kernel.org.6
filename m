Return-Path: <linux-kernel+bounces-373325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E69A554B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789FD1F221FE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E81D194A74;
	Sun, 20 Oct 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQiZLgCD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3746AA7
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729443031; cv=none; b=frUlfn5+NTVAKZ8oAQFtE8q0QGEG+o/YVKBth/6UkgNy83Sq8Uh8pihC/VOoBaUgPSSVsnpaNbI4bJOHW1mxLOdXE7LYybGVCjvzsPTKSFtYK9FQ6EE+HapaDmUlFKyATZi4ce/d8l+jH9z2UpZDXbjO0TzKV2kOjBPQQ/h0M+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729443031; c=relaxed/simple;
	bh=ybbBNj6AlQoOD4EkVltG9KMeNS7ShD0N0BQxewYCj8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgGXRxWQ5fh/dXxCpAOoZil3njou+QvFli+bjzjeE2Fcp4cTOgs2D6J0IEnFnefR9BVYofBM75dXgvQFpQSF0DgkjHkNKoD4OHlRI0Geggo4KBJR93JOqHb6pA0AR5g40bFYoCj7nCaGeCU/9+CQpxnwU4vA5S/g0ETRU8PNfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQiZLgCD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315baec69eso32111635e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729443027; x=1730047827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8iTgZbAl9CHcRrkSEuN0OvULrm4O7ekSlb34b3+QZME=;
        b=mQiZLgCDItLsNcISewqd385mjgpbUVkPp+Lhh3BAb31r5kMcqZlbx4Occ33z5sjQ4g
         RbeJU3Fb6dyLHk2uG78AY4F7gNejEKPrYhXcvQV8tolwhVxHrIPQCqeOmmVMvQPvtvJM
         qvlVpZ3QQhnT43SQivAnM0xMP5Dibxg/pDlYUrxfz9IIPvKmll18FgzgSWSlMBwa2W15
         WINzgDVFlMoLWDj6+vnLLYVCKPRdDKxlXbe3iun17EC9yUPK1ap/kmBHPOiEbjCdwNrb
         pvwqIkRrGdFeywgchAC4k1jZ8yakddZMZMfuzXIC+3YspEKAcOr2wsPQtKk7ClXep77N
         g/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729443027; x=1730047827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iTgZbAl9CHcRrkSEuN0OvULrm4O7ekSlb34b3+QZME=;
        b=o3kfP4W+ICmV1RJUNDWwdvBLmIMIbwHDUTF8ARzx3pkw6QFM0DGwBYEihyIjdqUDhD
         ZkBDtWVD3YwjCA4ecGNcbQMkldz6PeqC2fnV6K1oNjhCS0k55oW/Bvv44qNtVyjksXMm
         4xIrrIcKiaerXcHoaGFon0hwudcxERl+LGiG8mjdEqceh24c3KNt9G2BG0dpDKR18rNh
         s4RNI05xNLB78SV86W0u4v6Me83iZt8nfNngPldopQOKdistACw9YDFrtiytgF5pk57f
         0jrZu+YQKH6q/l3iEo7iLnZwp1kGgP83pyMzSp3jkU7vl3439Uz/WFTGecMrIUeZDh8m
         ti2w==
X-Forwarded-Encrypted: i=1; AJvYcCX1l7AaT/8Fk0ZXa1LQOklRT98uCPyUy+uAH+2YqwwT+1bk9enTNsyTTcO1gj3nRuAihQ7O4sKPM5nzpco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwOt8tA96ARJR9m07TZN7eerprmjTdS1OLeFe+WWAGJN2DfoN
	r9VIx/8Lh1z+Tgi2oRC/wVhLmL7tbikW9EJaCaQAtovtMieXKJRS
X-Google-Smtp-Source: AGHT+IFHo7eXcIyNRU8rM2sV6ZbyXT/IuBDMDCvLVnCw1FpwwcmbPsWxXHBMC00QQB3xo30hgULYPQ==
X-Received: by 2002:a05:600c:4447:b0:431:52f5:f497 with SMTP id 5b1f17b1804b1-4316164204dmr73741705e9.9.1729443026407;
        Sun, 20 Oct 2024 09:50:26 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570a97sm28665205e9.9.2024.10.20.09.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 09:50:26 -0700 (PDT)
Message-ID: <f2f2053f-ec5f-46a4-800d-50a3d2e61bff@gmail.com>
Date: Sun, 20 Oct 2024 17:50:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 6/7] mm: do_swap_page() calls swapin_readahead()
 zswap load batching interface.
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
 Nhat Pham <nphamcs@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "yosryahmed@google.com" <yosryahmed@google.com>,
 "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
 <21cnbao@gmail.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "bfoster@redhat.com" <bfoster@redhat.com>,
 "dchinner@redhat.com" <dchinner@redhat.com>,
 "chrisl@kernel.org" <chrisl@kernel.org>,
 "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
 "Gopal, Vinodh" <vinodh.gopal@intel.com>
References: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
 <20241018064805.336490-7-kanchana.p.sridhar@intel.com>
 <71bcbd3f-a8bd-4014-aabe-081006cc62f8@redhat.com>
 <169e5cb6-701a-474c-a703-60daee8b4d3f@gmail.com>
 <CAKEwX=NVUkjDgxvsr1g3o_2dWGjEF91_+q==MQE8VQc8o5vwtQ@mail.gmail.com>
 <SJ0PR11MB5678A864244B09FDE4D914EEC9402@SJ0PR11MB5678.namprd11.prod.outlook.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <SJ0PR11MB5678A864244B09FDE4D914EEC9402@SJ0PR11MB5678.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/10/2024 22:59, Sridhar, Kanchana P wrote:
> Hi Usama, Nhat,
> 
>> -----Original Message-----
>> From: Nhat Pham <nphamcs@gmail.com>
>> Sent: Friday, October 18, 2024 10:21 AM
>> To: Usama Arif <usamaarif642@gmail.com>
>> Cc: David Hildenbrand <david@redhat.com>; Sridhar, Kanchana P
>> <kanchana.p.sridhar@intel.com>; linux-kernel@vger.kernel.org; linux-
>> mm@kvack.org; hannes@cmpxchg.org; yosryahmed@google.com;
>> chengming.zhou@linux.dev; ryan.roberts@arm.com; Huang, Ying
>> <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
>> hughd@google.com; willy@infradead.org; bfoster@redhat.com;
>> dchinner@redhat.com; chrisl@kernel.org; Feghali, Wajdi K
>> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
>> Subject: Re: [RFC PATCH v1 6/7] mm: do_swap_page() calls
>> swapin_readahead() zswap load batching interface.
>>
>> On Fri, Oct 18, 2024 at 4:04 AM Usama Arif <usamaarif642@gmail.com>
>> wrote:
>>>
>>>
>>> On 18/10/2024 08:26, David Hildenbrand wrote:
>>>> On 18.10.24 08:48, Kanchana P Sridhar wrote:
>>>>> This patch invokes the swapin_readahead() based batching interface to
>>>>> prefetch a batch of 4K folios for zswap load with batch decompressions
>>>>> in parallel using IAA hardware. swapin_readahead() prefetches folios
>> based
>>>>> on vm.page-cluster and the usefulness of prior prefetches to the
>>>>> workload. As folios are created in the swapcache and the readahead
>> code
>>>>> calls swap_read_folio() with a "zswap_batch" and a "non_zswap_batch",
>> the
>>>>> respective folio_batches get populated with the folios to be read.
>>>>>
>>>>> Finally, the swapin_readahead() procedures will call the newly added
>>>>> process_ra_batch_of_same_type() which:
>>>>>
>>>>>   1) Reads all the non_zswap_batch folios sequentially by calling
>>>>>      swap_read_folio().
>>>>>   2) Calls swap_read_zswap_batch_unplug() with the zswap_batch which
>> calls
>>>>>      zswap_finish_load_batch() that finally decompresses each
>>>>>      SWAP_CRYPTO_SUB_BATCH_SIZE sub-batch (i.e. upto 8 pages in a
>> prefetch
>>>>>      batch of say, 32 folios) in parallel with IAA.
>>>>>
>>>>> Within do_swap_page(), we try to benefit from batch decompressions in
>> both
>>>>> these scenarios:
>>>>>
>>>>>   1) single-mapped, SWP_SYNCHRONOUS_IO:
>>>>>        We call swapin_readahead() with "single_mapped_path = true". This
>> is
>>>>>        done only in the !zswap_never_enabled() case.
>>>>>   2) Shared and/or non-SWP_SYNCHRONOUS_IO folios:
>>>>>        We call swapin_readahead() with "single_mapped_path = false".
>>>>>
>>>>> This will place folios in the swapcache: a design choice that handles
>> cases
>>>>> where a folio that is "single-mapped" in process 1 could be prefetched in
>>>>> process 2; and handles highly contended server scenarios with stability.
>>>>> There are checks added at the end of do_swap_page(), after the folio has
>>>>> been successfully loaded, to detect if the single-mapped swapcache folio
>> is
>>>>> still single-mapped, and if so, folio_free_swap() is called on the folio.
>>>>>
>>>>> Within the swapin_readahead() functions, if single_mapped_path is true,
>> and
>>>>> either the platform does not have IAA, or, if the platform has IAA and the
>>>>> user selects a software compressor for zswap (details of sysfs knob
>>>>> follow), readahead/batching are skipped and the folio is loaded using
>>>>> zswap_load().
>>>>>
>>>>> A new swap parameter "singlemapped_ra_enabled" (false by default) is
>> added
>>>>> for platforms that have IAA, zswap_load_batching_enabled() is true, and
>> we
>>>>> want to give the user the option to run experiments with IAA and with
>>>>> software compressors for zswap (swap device is
>> SWP_SYNCHRONOUS_IO):
>>>>>
>>>>> For IAA:
>>>>>   echo true > /sys/kernel/mm/swap/singlemapped_ra_enabled
>>>>>
>>>>> For software compressors:
>>>>>   echo false > /sys/kernel/mm/swap/singlemapped_ra_enabled
>>>>>
>>>>> If "singlemapped_ra_enabled" is set to false, swapin_readahead() will
>> skip
>>>>> prefetching folios in the "single-mapped SWP_SYNCHRONOUS_IO"
>> do_swap_page()
>>>>> path.
>>>>>
>>>>> Thanks Ying Huang for the really helpful brainstorming discussions on the
>>>>> swap_read_folio() plug design.
>>>>>
>>>>> Suggested-by: Ying Huang <ying.huang@intel.com>
>>>>> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
>>>>> ---
>>>>>   mm/memory.c     | 187 +++++++++++++++++++++++++++++++++++++--
>> ---------
>>>>>   mm/shmem.c      |   2 +-
>>>>>   mm/swap.h       |  12 ++--
>>>>>   mm/swap_state.c | 157 ++++++++++++++++++++++++++++++++++++--
>> --
>>>>>   mm/swapfile.c   |   2 +-
>>>>>   5 files changed, 299 insertions(+), 61 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index b5745b9ffdf7..9655b85fc243 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -3924,6 +3924,42 @@ static vm_fault_t
>> remove_device_exclusive_entry(struct vm_fault *vmf)
>>>>>       return 0;
>>>>>   }
>>>>>   +/*
>>>>> + * swapin readahead based batching interface for zswap batched loads
>> using IAA:
>>>>> + *
>>>>> + * Should only be called for and if the faulting swap entry in
>> do_swap_page
>>>>> + * is single-mapped and SWP_SYNCHRONOUS_IO.
>>>>> + *
>>>>> + * Detect if the folio is in the swapcache, is still mapped to only this
>>>>> + * process, and further, there are no additional references to this folio
>>>>> + * (for e.g. if another process simultaneously readahead this swap entry
>>>>> + * while this process was handling the page-fault, and got a pointer to
>> the
>>>>> + * folio allocated by this process in the swapcache), besides the
>> references
>>>>> + * that were obtained within __read_swap_cache_async() by this
>> process that is
>>>>> + * faulting in this single-mapped swap entry.
>>>>> + */
>>>>
>>>> How is this supposed to work for large folios?
>>>>
>>>
>>> Hi,
>>>
>>> I was looking at zswapin large folio support and have posted a RFC in [1].
>>> I got bogged down with some prod stuff, so wasn't able to send it earlier.
>>>
>>> It looks quite different, and I think simpler from this series, so might be
>>> a good comparison.
>>>
>>> [1] https://lore.kernel.org/all/20241018105026.2521366-1-
>> usamaarif642@gmail.com/
>>>
>>> Thanks,
>>> Usama
>>
>> I agree.
>>
>> I think the lower hanging fruit here is to build upon Usama's patch.
>> Kanchana, do you think we can just use the new batch decompressing
>> infrastructure, and apply it to Usama's large folio zswap loading?
>>
>> I'm not denying the readahead idea outright, but that seems much more
>> complicated. There are questions regarding the benefits of
>> readahead-ing when apply to zswap in the first place - IIUC, zram
>> circumvents that logic in several cases, and zswap shares many
>> characteristics with zram (fast, synchronous compression devices).
>>
>> So let's reap the low hanging fruits first, get the wins as well as
>> stress test the new infrastructure. Then we can discuss the readahead
>> idea later?
> 
> Thanks Usama for publishing the zswap large folios swapin series, and
> thanks Nhat for your suggestions.  Sure, I can look into integrating the
> new batch decompressing infrastructure with Usama's large folio zswap
> loading.
> 
> However, I think we need to get clarity on a bigger question: does it
> make sense to swapin large folios? Some important considerations
> would be:
> 
> 1) What are the tradeoffs in memory footprint cost of swapping in a
>     large folio?

I would say the pros and cons of swapping in a large folio are the same as
the pros and cons of large folios in general.
As mentioned in my cover letter and the series that introduced large folios
you get fewer page faults, batched PTE and rmap manipulation, reduced lru list,
TLB coalescing (for arm64 and AMD) at the cost of higher memory usage and
fragmentation.

The other thing is that the series I wrote is hopefully just a start.
As shown by Barry in the case of zram in 
https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/
there is a significant improvement in CPU utilization and compression
ratios when compressing at large granularity. Hopefully we can
try and do something similar for zswap. Not sure how that would look
for zswap as I haven't started looking at that yet.

> 2) If we decide to let the user determine this by say, an option that
>      determines the swapin granularity (e.g. no more than 32k at a time),
>      how does this constrain compression and zpool storage granularity?
> 
Right now whether or not zswapin happens is determined using
/sys/kernel/mm/transparent_hugepage/hugepages-*kB/enabled
I assume when the someone sets some of these to always, they know that
their workload works best with those page sizes, so they would want folios
to be swapped in and used at that size as well?

There might be some merit in adding something like
/sys/kernel/mm/transparent_hugepage/hugepages-*kB/swapin_enabled,
as you might start thrashing swap if you are for e.g. swapping
in 1M folios and there isn't enough memory for it, which causes
you to swapout another folio in its place.

> Ultimately, I feel the bigger question is about memory utilization cost
> of large folio swapin. The swapin_readahead() based approach tries to
> use the prefetch-usefulness characteristics of the workload to improve
> the efficiency of multiple 4k folios by using strategies like parallel
> decompression, to strike some balance in memory utilization vs.
> efficiency.
> 
> Usama, I downloaded your patch-series and tried to understand this
> better, and wanted to share the data.
> 
> I ran the kernel compilation "allmodconfig" with zstd, page-cluster=0,
> and 16k/32k/64k large folios enabled to "always":
> 
> 16k/32k/64k folios: kernel compilation with zstd:
>  =================================================
> 
>  ------------------------------------------------------------------------------
>                         mm-unstable-10-16-2024    + zswap large folios swapin
>                                                                        series
>  ------------------------------------------------------------------------------
>  zswap compressor                         zstd                           zstd
>  vm.page-cluster                             0                              0
>  ------------------------------------------------------------------------------
>  real_sec                               772.53                         870.61
>  user_sec                            15,780.29                      15,836.71
>  sys_sec                              5,353.20                       6,185.02
>  Max_Res_Set_Size_KB                 1,873,348                      1,873,004
>                                                                              
>  ------------------------------------------------------------------------------
>  memcg_high                                  0                              0
>  memcg_swap_fail                             0                              0
>  zswpout                            93,811,916                    111,663,872
>  zswpin                             27,150,029                     54,730,678
>  pswpout                                    64                             59
>  pswpin                                     78                             53
>  thp_swpout                                  0                              0
>  thp_swpout_fallback                         0                              0
>  16kB-mthp_swpout_fallback                   0                              0
>  32kB-mthp_swpout_fallback                   0                              0
>  64kB-mthp_swpout_fallback               5,470                              0
>  pgmajfault                         29,019,256                     16,615,820
>  swap_ra                                     0                              0
>  swap_ra_hit                             3,004                          3,614
>  ZSWPOUT-16kB                        1,324,160                      2,252,747
>  ZSWPOUT-32kB                          730,534                      1,356,640
>  ZSWPOUT-64kB                        3,039,760                      3,955,034
>  ZSWPIN-16kB                                                        1,496,916
>  ZSWPIN-32kB                                                        1,131,176
>  ZSWPIN-64kB                                                        1,866,884
>  SWPOUT-16kB                                 0                              0
>  SWPOUT-32kB                                 0                              0
>  SWPOUT-64kB                                 4                              3
>  ------------------------------------------------------------------------------
> 
> It does appear like there is considerably higher swapout and swapin
> activity as a result of swapping in large folios, which does end up
> impacting performance.

Thanks for having a look!
I had only tested with the microbenchmark for time taken to zswapin that I included in
my coverletter.
In general I expected zswap activity to go up as you are more likely to experience
memory pressure when swapping in large folios, but in return get lower pagefaults
and the advantage of lower TLB pressure in AMD and arm64.

Thanks for the test, those number look quite extreme! I think there is a lot of swap
thrashing. 
I am assuming you are testing on an intel machine, where you don't get the advantage
of lower TLB misses of large folios, I will try and get an AMD machine which has
TLB coalescing or an ARM server with CONT_PTE to see if the numbers get better.

Maybe it might be better for large folio zswapin to be considered along with
larger granuality compression to get all the benefits of large folios (and
hopefully better numbers.) I think that was the approach taken for zram as well.

> 
> I would appreciate thoughts on understanding the usefulness of
> swapping in large folios, with the considerations outlined earlier/other
> factors.
> 
> Thanks,
> Kanchana


