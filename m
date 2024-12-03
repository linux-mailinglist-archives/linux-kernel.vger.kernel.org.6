Return-Path: <linux-kernel+bounces-428631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2339E1194
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8D22832A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C0B13AD38;
	Tue,  3 Dec 2024 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pQbtSUJ3"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD8A59
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195211; cv=none; b=sHdXf5SzUyaMvwxRFoRup7oGSKajx2eJiXX8s56fwjlNKRKGi8F+zogq+xvpam3xPu9qL9vBPd0XtpKMa7OmgM4IGngHPXZ3Y+2QA45kcCpfwsdi+g7ldgFPYZziwkUWBFE4espcCtWeQUkfWLSZKADoWdbAXIZkChqjhDkxrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195211; c=relaxed/simple;
	bh=QIwXUEBI/ZjPLYBYPkWBrH3cp+R1rApUFoRfUUvZ1ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeVBhj2eH6l+QNdkEwKElpOiW5HKrwQ5IwgLBX0rx6CVtP0LxzYRVDCBdWyJiG1ul/DZq1vMgoCqBsU0pp1fcR+LxUC5cqr2nyLmzXCyik39s58/hV5NRaE9QoNrb071apFfUUHSLR6nm1kv4+Ia9I26cO5YSAaDNk7loUbg2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pQbtSUJ3; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <045a786d-7b13-4127-82ce-57510565bd15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733195203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql37HxuYXrMwWUt9td8nUPZc9h8pa2tYvbPHU5U5GXQ=;
	b=pQbtSUJ3RATHdLHqKQ/RravvKlIMY+bcfBz8ppmM1dL286zdwBjwM7CqOuWXR3DrlsWIl4
	1TkmeifThxghLbxorDCU75K/YhS2yRKHCK7cWOGzUcY9Y0IbqLZU+yVe1aITRTX+FYzUxj
	oEXmgPeZcFKh/74scf3H1mkXfeAO2yU=
Date: Tue, 3 Dec 2024 11:06:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications for
 batching.
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
 Yosry Ahmed <yosryahmed@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "nphamcs@gmail.com" <nphamcs@gmail.com>,
 "usamaarif642@gmail.com" <usamaarif642@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
 "Gopal, Vinodh" <vinodh.gopal@intel.com>
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-3-kanchana.p.sridhar@intel.com>
 <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
 <CAJD7tkbPSQguHegkzN65==GHuNN9_RPm1FonnF8Bi=BsQDhxng@mail.gmail.com>
 <SJ0PR11MB56781233ABFE772C5991AB01C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <SJ0PR11MB56781233ABFE772C5991AB01C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/12/3 09:01, Sridhar, Kanchana P wrote:
> Hi Chengming, Yosry,
> 
>> -----Original Message-----
>> From: Yosry Ahmed <yosryahmed@google.com>
>> Sent: Monday, December 2, 2024 11:33 AM
>> To: Chengming Zhou <chengming.zhou@linux.dev>
>> Cc: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; linux-
>> kernel@vger.kernel.org; linux-mm@kvack.org; hannes@cmpxchg.org;
>> nphamcs@gmail.com; usamaarif642@gmail.com; ryan.roberts@arm.com;
>> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
>> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
>> Subject: Re: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications
>> for batching.
>>
>> On Wed, Nov 27, 2024 at 11:00 PM Chengming Zhou
>> <chengming.zhou@linux.dev> wrote:
>>>
>>> On 2024/11/28 06:53, Kanchana P Sridhar wrote:
>>>> In order to set up zswap_store_pages() to enable a clean batching
>>>> implementation in [1], this patch implements the following changes:
>>>>
>>>> 1) Addition of zswap_alloc_entries() which will allocate zswap entries for
>>>>      all pages in the specified range for the folio, upfront. If this fails,
>>>>      we return an error status to zswap_store().
>>>>
>>>> 2) Addition of zswap_compress_pages() that calls zswap_compress() for
>> each
>>>>      page, and returns false if any zswap_compress() fails, so
>>>>      zswap_store_page() can cleanup resources allocated and return an
>> error
>>>>      status to zswap_store().
>>>>
>>>> 3) A "store_pages_failed" label that is a catch-all for all failure points
>>>>      in zswap_store_pages(). This facilitates cleaner error handling within
>>>>      zswap_store_pages(), which will become important for IAA compress
>>>>      batching in [1].
>>>>
>>>> [1]: https://patchwork.kernel.org/project/linux-mm/list/?series=911935
>>>>
>>>> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
>>>> ---
>>>>    mm/zswap.c | 93 +++++++++++++++++++++++++++++++++++++++++----
>> ---------
>>>>    1 file changed, 71 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>>> index b09d1023e775..db80c66e2205 100644
>>>> --- a/mm/zswap.c
>>>> +++ b/mm/zswap.c
>>>> @@ -1409,9 +1409,56 @@ static void shrink_worker(struct work_struct
>> *w)
>>>>    * main API
>>>>    **********************************/
>>>>
>>>> +static bool zswap_compress_pages(struct page *pages[],
>>>> +                              struct zswap_entry *entries[],
>>>> +                              u8 nr_pages,
>>>> +                              struct zswap_pool *pool)
>>>> +{
>>>> +     u8 i;
>>>> +
>>>> +     for (i = 0; i < nr_pages; ++i) {
>>>> +             if (!zswap_compress(pages[i], entries[i], pool))
>>>> +                     return false;
>>>> +     }
>>>> +
>>>> +     return true;
>>>> +}
>>>
>>> How about introducing a `zswap_compress_folio()` interface which
>>> can be used by `zswap_store()`?
>>> ```
>>> zswap_store()
>>>          nr_pages = folio_nr_pages(folio)
>>>
>>>          entries = zswap_alloc_entries(nr_pages)
>>>
>>>          ret = zswap_compress_folio(folio, entries, pool)
>>>
>>>          // store entries into xarray and LRU list
>>> ```
>>>
>>> And this version `zswap_compress_folio()` is very simple for now:
>>> ```
>>> zswap_compress_folio()
>>>          nr_pages = folio_nr_pages(folio)
>>>
>>>          for (index = 0; index < nr_pages; ++index) {
>>>                  struct page *page = folio_page(folio, index);
>>>
>>>                  if (!zswap_compress(page, &entries[index], pool))
>>>                          return false;
>>>          }
>>>
>>>          return true;
>>> ```
>>> This can be easily extended to support your "batched" version.
>>>
>>> Then the old `zswap_store_page()` could be removed.
>>>
>>> The good point is simplicity, that we don't need to slice folio
>>> into multiple batches, then repeat the common operations for each
>>> batch, like preparing entries, storing into xarray and LRU list...
>>
>> +1
> 
> Thanks for the code review comments. One question though: would
> it make sense to trade-off the memory footprint cost with the code
> simplification? For instance, lets say we want to store a 64k folio.
> We would allocate memory for 16 zswap entries, and lets say one of
> the compressions fails, we would deallocate memory for all 16 zswap
> entries. Could this lead to zswap_entry kmem_cache starvation and
> subsequent zswap_store() failures in multiple processes scenarios?

Ah, I get your consideration. But it's the unlikely case, right?

If the case you mentioned above happens a lot, I think yes, we should
optimize its memory footprint to avoid allocation and deallocation.

On the other hand, we should consider a folio would be compressed
successfully in most cases. So we have to allocate all entries
eventually.

Based on your consideration, I think your way is ok too, although
I think the patch 2/2 should be dropped, since it hides pages loop
in smaller functions, as Yosry mentioned too.

> 
> In other words, allocating entries in smaller batches -- more specifically,
> only the compress batchsize -- seems to strike a balance in terms of
> memory footprint, while mitigating the starvation aspect, and possibly
> also helping latency (allocating a large # of zswap entries and potentially
> deallocating, could impact latency).

If we consider the likely case (compress successfully), the whole
latency should be better, right? Since we can bulk allocate all
entries at first, and bulk insert to xarray and LRU at last.

> 
> If we agree with the merits of processing a large folio in smaller batches:
> this in turn requires we store the smaller batches of entries in the
> xarray/LRU before moving to the next batch. Which means all the
> zswap_store() ops need to be done for a batch before moving to the next
> batch.
> 

Both way is ok for me based on your memory footprint consideration
above.

Thanks.

