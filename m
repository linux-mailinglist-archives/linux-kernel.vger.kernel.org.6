Return-Path: <linux-kernel+bounces-308053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F185965694
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EE4B233D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168A81411C8;
	Fri, 30 Aug 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qhdIVpZJ"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ACF481AB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724993539; cv=none; b=LU/7vub00rOzSjZyS+gPh2J/KJwaM2dPrrkRRkKoTuPgJQ3AjlSkMRQ54KcvfBA4TtIVNe+LFkQtPBNfqg0Zi3Z6X3oftDaKvF/ZklR7hwwDYlYuJ6eKdBANA2bVI+jv6kuxaqS+AYEJSUnL4eV48cC/K4w4E6QnyqIv8UNoDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724993539; c=relaxed/simple;
	bh=VHkXmrL05PgK6VcvH9aW/3Qt7DoBg5CNQCekM4KdzTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgTg/mCaC+pmqbWmx9NBeme/L662oB2JAsFd2jE7DX/nhOaHy+FwunuNHh/NGX5KHaodhWVmWbO0ppBW7a5EqmdHToVtUXPkif+qqx/XODNdQ+72+lR7V5JxvMi+i9ae/6IHdvAJv9YvDkIjyuEIuvKiD2oX/iEHcDLZJ9l28YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qhdIVpZJ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8545b4d8-ba21-4607-8217-2b7b02ccb4d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724993533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMq71v6EinFbxfx0sEAOWJnX25pjFl6A1prMKAEx9tU=;
	b=qhdIVpZJtpVjNL1TEjTcj3TCYkdiKWhhs4meEZlEbfpswph8GIVOYLi7cHo3TNskL5kHOo
	+U2ukbhJhoGphKhmbLo04DAHQwoJJP22zk7Mxa8rj0cFMcnxxYWet3YtILRz0GBCNex3Ua
	uvvKNKBkym7HlcufwxBLZNo1igr4G8g=
Date: Fri, 30 Aug 2024 12:52:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
 Nhat Pham <nphamcs@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "yosryahmed@google.com" <yosryahmed@google.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
 <21cnbao@gmail.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
 "Gopal, Vinodh" <vinodh.gopal@intel.com>, Usama Arif <usamaarif642@gmail.com>
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=Pqm3pjOO-ErOTGnNYKwMas4fdiN0bdUcrPHzfKf-Qryw@mail.gmail.com>
 <SJ0PR11MB5678412EE36C10CC0D69D036C9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P3L_uxWs6m9KL_Pqv_LpPpXH4E9gWMT95oi==ZNmqkWQ@mail.gmail.com>
 <SJ0PR11MB5678AEDB9E47BB6267D5885CC9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <SJ0PR11MB5678AEDB9E47BB6267D5885CC9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/8/30 03:38, Sridhar, Kanchana P wrote:
> Hi Nhat,
> 
>> -----Original Message-----
>> From: Nhat Pham <nphamcs@gmail.com>
>> Sent: Thursday, August 29, 2024 10:11 AM
>> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
>> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
>> hannes@cmpxchg.org; yosryahmed@google.com; ryan.roberts@arm.com;
>> Huang, Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
>> foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
>> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>;
>> Usama Arif <usamaarif642@gmail.com>; Chengming Zhou
>> <chengming.zhou@linux.dev>
>> Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
>>
>> On Wed, Aug 28, 2024 at 5:06 PM Sridhar, Kanchana P
>> <kanchana.p.sridhar@intel.com> wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Nhat Pham <nphamcs@gmail.com>
>>>> Sent: Wednesday, August 28, 2024 2:35 PM
>>>> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
>>>> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
>>>> hannes@cmpxchg.org; yosryahmed@google.com;
>> ryan.roberts@arm.com;
>>>> Huang, Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
>>>> foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
>>>> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
>>>> Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
>>>>
>>>> On Wed, Aug 28, 2024 at 2:35 AM Kanchana P Sridhar
>>>> <kanchana.p.sridhar@intel.com> wrote:
>>>>>
>>>>> Hi All,
>>>>>
>>>>> This patch-series enables zswap_store() to accept and store mTHP
>>>>> folios. The most significant contribution in this series is from the
>>>>> earlier RFC submitted by Ryan Roberts [1]. Ryan's original RFC has been
>>>>> migrated to v6.11-rc3 in patch 2/4 of this series.
>>>>>
>>>>> [1]: [RFC PATCH v1] mm: zswap: Store large folios without splitting
>>>>>       https://lore.kernel.org/linux-mm/20231019110543.3284654-1-
>>>> ryan.roberts@arm.com/T/#u
>>>>>
>>>>> Additionally, there is an attempt to modularize some of the functionality
>>>>> in zswap_store(), to make it more amenable to supporting any-order
>>>>> mTHPs. For instance, the function zswap_store_entry() stores a
>>>> zswap_entry
>>>>> in the xarray. Likewise, zswap_delete_stored_offsets() can be used to
>>>>> delete all offsets corresponding to a higher order folio stored in zswap.
>>>>>
>>>>
>>>> Will this have any conflict with mTHP swap work? Especially with mTHP
>>>> swap-in and zswap writeback.
>>>>
>>>> My understanding is from zswap's perspective, the large folio is
>>>> broken apart into independent subpages, correct? What happens when
>> we
>>>> have partially written back mTHP (i.e some subpages are in zswap
>>>> still, whereas others are written back to swap). Would this
>>>> automatically prevent mTHP swapin?
>>>
>>> That is a good point. To begin with, this patch-series would make the default
>>> behavior for mTHP swapout/storage and swapin for ZSWAP to be on par
>> with
>>> ZRAM. From zswap's perspective, imo this is a significant step forward
>> towards
>>> realizing cold memory storage with mTHP folios. However, it is only a
>> starting
>>> point that makes the behavior uniform across zswap/zram. Initially,
>> workloads
>>> would see a one-time benefit with reclaim being able to swapout mTHP
>>> folios without splitting, to zswap. If the mTHPs were cold memory, then we
>>> would have derived latency gains towards memory savings (with zswap).
>>>
>>> However, if the mTHP were part of "not so cold" memory, this would result
>>> in a one-way mTHP conversion to 4K folios. Depending on workloads and
>> their
>>> access patterns, we could either see individual 4K folios being swapped in,
>>> or entire chunks if not the entire (original) mTHP needing to be swapped in.
>>>
>>> It should be noted that this is more of a performance vs. cold memory
>>> preservation trade-off that needs to drive mTHP reclaim, storage, swapin
>> and
>>> writeback policy. Different workloads could require different policies.
>> However,
>>> even though this patch is only a starting point, it is still functionally correct
>>> by being equivalent to zram-mTHP, and compatible with the rest of mm and
>>> swap as far as mTHP. Another important functionality/data consistency
>> decision
>>> I made in this patch series is error handling during zswap_store() of mTHP:
>>> in case of any errors, all swap offsets for the mTHP are deleted from the
>>> zswap xarray/zpool, since we know that the mTHP will now have to be
>> stored
>>> in the backing swap device. IOW, an mTHP is either entirely stored in zswap,
>>> or entirely not stored in zswap.
>>>
>>> To answer your question, we would need to come up with what the
>> semantics
>>> would need to be for zswap zpool storage granularity, swapin granularity,
>>> readahead granularity and writeback wrt mTHP and how the overall swap
>>> sub-system needs to "preserve" mTHP vs. splitting mTHP into 4K/lower-
>> order
>>> folios during swapout. Once we have a good understanding of these policies,
>>> we could implement them in zswap. Alternately, develop an abstraction that
>> is
>>> one level above zswap/zram and makes things easier and shareable
>> between
>>> zswap and zram. By this, I mean fundamental assumptions such as
>> consecutive
>>> swap offsets (for instance). To some extent, this implies that an mTHP as a
>>> swap entity is defined by consecutiveness of swap offsets. Maybe the policy
>>> to keep mTHPs in the system over extended duration might be to assemble
>>> them dynamically based on swapin_readahead() decisions (which is based
>> on
>>> workload access patterns). In other words, mTHPs could be a useful
>> abstraction
>>> that can be static or even dynamic based on working set characteristics, and
>>> cold memory preservation. This is quite a complex topic imho.
>>>
>>> As we know, Barry Song and Chuanhua Han have started the discussion on
>>> this in their zram mTHP swapin series [1].
>>
>> Yeah I'm a bit more concerned with the correctness aspect. As long as
>> it's not buggy, then we can implement mTHP zswapout first, and force
>> individual subpage (z)swapin for now (since we cannot control
>> writeback from writing individual subpages).
> 
> Absolutely, this sounds like the way to go!
> 
>>
>> We can discuss strategy to harmonize mTHP, zswap (with writeback) as
>> we go along.
> 
> Sounds great :)
> 
>>
>> BTW, I think we're not cc-ing Chengming? Is the get_maintainers script
>> not working properly... Let me manually add him in - please include
>> him in future submission and responses, as he is also a zswap reviewer
>> :)
> 
> I think when I ran get_maintainers.pl, I was in v6.10. For sure, will include
> Chengming in future submissions and responses :)

Maybe a little late for the party, will take a look ASAP.
It's an interesting and great work.

Thanks!

> 
>>
>> Also cc-ing Usama who is interested in this work.
> 
> Sounds great.
> 
> Thanks,
> Kanchana
> 
>>
>>>
>>> [1] https://lore.kernel.org/all/20240821074541.516249-3-
>> hanchuanhua@oppo.com/T/#u
>>>
>>> Thanks,
>>> Kanchana

