Return-Path: <linux-kernel+bounces-227040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193691478F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9561C2327A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E051369B1;
	Mon, 24 Jun 2024 10:35:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0840125D6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225335; cv=none; b=nwdxbZ6/7MjBe2XDtNqSz4Pgbg0N5TOWGIM/Milq7d6r4M9qqJ436GlVdgsHZVfb52Ueh1bIDZfLohiA9FzbS/vgElEnOkYinyfY9T/oDDXYi91PmhP6BaqYuL16E8UYCukie7C2lm3l25pDwZ8Ub2ObXFIADToZkNkjGR8u3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225335; c=relaxed/simple;
	bh=d0K8dOVII7738DkrY/EkAzZKhtXR5IalGFob4/TD2DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfTapK+/vwurvFOSq9kUfbPdJZmGn4nLskTcZCHLwZRusEHsJPkBg4LSqvUt/yJr6rfXBWH0m3WIj0v0YVt/B4Z5uE2V0wqVUZve6DHmI1ted3Ws/RvPkNDmluKESniacR4fwt7IsfOcEi5OFJB5Bz6ox6DyC8yjjlFaPXVPl6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB862DA7;
	Mon, 24 Jun 2024 03:35:56 -0700 (PDT)
Received: from [10.57.74.104] (unknown [10.57.74.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52B1C3F766;
	Mon, 24 Jun 2024 03:35:30 -0700 (PDT)
Message-ID: <76876c5f-f769-43f1-ad53-a4af288af467@arm.com>
Date: Mon, 24 Jun 2024 11:35:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
 david@redhat.com, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com,
 ying.huang@intel.com
References: <20240622071231.576056-1-21cnbao@gmail.com>
 <557d7f05-6ba9-482d-b3fb-29eb72cdf09c@arm.com>
 <CAGsJ_4zQ0vjX1UM62o0Wsgh9XYW0SGv2cyG5gUpbP_+Tx3WZLg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zQ0vjX1UM62o0Wsgh9XYW0SGv2cyG5gUpbP_+Tx3WZLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/06/2024 09:42, Barry Song wrote:
> On Mon, Jun 24, 2024 at 8:26 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 22/06/2024 08:12, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> -v2:
>>>  * add swap-in which can either be aligned or not aligned, by "-a";
>>>    Ying;
>>>  * move the program to tools/mm; Ryan;
>>>  * try to simulate the scenarios swap is full. Chris;
>>>
>>> -v1:
>>>  https://lore.kernel.org/linux-mm/20240620002648.75204-1-21cnbao@gmail.com/
>>>
>>> I tested Ryan's RFC patchset[1] and Chris's v3[2] using this v2 tool:
>>> [1] https://lore.kernel.org/linux-mm/20240618232648.4090299-1-ryan.roberts@arm.com/
>>> [2] https://lore.kernel.org/linux-mm/20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org/
>>>
>>> Obviously, we're rarely hitting 100% even in the worst case without "-a" and with
>>> "-s," which is good news!
>>> If swapin is aligned w/ "-a" and w/o "-s", both Chris's and Ryan's patches show
>>> a low fallback ratio though Chris's has the numbers above 0% but Ryan's are 0%
>>> (value A).
>>>
>>> The bad news is that unaligned swapin can significantly increase the fallback ratio,
>>> reaching up to 85% for Ryan's patch and 95% for Chris's patchset without "-s." Both
>>> approaches approach 100% without "-a" and with "-s" (value B).
>>>
>>> I believe real workloads should yield a value between A and B. Without "-a," and
>>> lacking large folios swap-in, this tool randomly swaps in small folios without
>>> considering spatial locality, which is a factor present in real workloads. This
>>> typically results in values higher than A and lower than B.
>>>
>>> Based on the below results, I believe that:
>>
>> Thanks for putting this together and providing such detailed results!
>>
>>> 1. We truly require large folio swap-in to achieve comparable results with
>>> aligned swap-in(based on the result w/o and w/ "-a")
>>
>> I certainly agree that as long as we require a high order swap entry to be
>> contiguous in the backing store then it looks like we are going to need large
>> folio swap-in to prevent enormous fragmentation. I guess Chris's proposed layer
>> of indirection to allow pages to be scattered in the backing store would also
>> solve the problem? Although, I'm not sure this would work well for zRam?
> 
> The challenge is that we also want to take advantage of improving zsmalloc
> to save compressed multi-pages. However, it seems quite impossible for
> zsmalloc to achieve this for a mTHP is scattered but not put together in
> zRAM.

Yes understood. I finally got around to watching the lsfmm videos; I believe the
suggested solution with a fs-like approach would be to let the fs handle the
compression, which means compressing extents? So even with that approach,
presumably its still valuable to be able to allocate the biggest extents possible.

> 
>>
>> Perhaps another way of looking at this is that we are doing a bad job of
>> selecting when to use an mTHP and when not to use one in the first place;
>> ideally the workload would access the data across the entire mTHP with high
>> temporal locality? In that case, we would expect the whole mTHP to be swapped in
>> even with the current page-by-page approach. Figuring out this "auto sizing"
>> seems like an incredibly complex problem to solve though.
> 
> The good news is that this is exactly what we're implementing in our products,
> and it has been deployed on millions of phones.
> 
>   *  Allocate mTHP and swap in the entire mTHP  in do_swap_page();
>   *  If mTHP allocation fails, allocate 16 pages to swap-in in do_swap_page();

I think we were talking cross-purposes here. What I meant was that in an ideal
world we would only allocate a (64K) mTHP for a page fault if we had confidence
(via some heuristic) that the virtual 64K area was likely to always be accessed
together, else just allocate a small folio. i.e. choose the folio size to cover
a single object from user space's PoV. That would have the side effect that a
page-by-page swap-in approach (the current approach in mainline) would still
effectively result in swapping in the whole folio and therefore reduce
fragementation in the swap file. (Or thinking about it slightly differently, it
would give us confidence to always swap-in a large folio at a time, because we
know its all highly likely to get used in the near future).

I suspect this is a moot point though, because divinging a suitable heuristic
with low overhead is basically impossible.

> 
> To be honest, we haven't noticed a visible increase in memory footprint. This is
> likely because Android's anonymous memory exhibits good spatial locality, and
> 64KiB strikes a good balance—neither too large nor too small.

Indeed.

> 
> The bad news is that I haven't found a way to convince the community this
> is universally correct.

I think we will want to be pragmatic and at least implement an option (sysfs?)
to swap-in a large folio up to a certain size; These test results clearly show
the value. And I believe you have real-world data for Android that shows the
same thing.

Just to creep the scope of this thread slightly, after watching yours and Yu
Zhou's presentations around TAO, IIUC, even with TAO enabled, 64K folio
allocation fallback is still above 50%? I still believe that once the Android
filesystems are converted to use large folios that number will improve
substantially; especially if the page cache can be convinced to only allocate
64K folios (with 4K fallback). At that point you're predominantly using 64K
folios so intuitively there will be less fragmentation.

But allocations by the page cache today start at 16K and increment by 2 orders
for every new readahead IIRC. So we end up with lots of large folio sizes, and
presumably the potential for lots of fallbacks.

All of this is just to suggest that we may end up wanting controls to specify
which folio sizes the page cache can attempt to use. At that point, adding
similar controls for swap-in doesn't feel unreasonable to me.

Just my 2 cents!

> 
>>
>>> 2. We need a method to prevent small folios from scattering indiscriminately
>>> (based on the result "-a -s")
>>
>> I'm confused by this statement; as I undersand it, both my and Chris's patches
>> already try to do this. Certainly for mine, when searching for order-0 space, I
>> search the non-full order-0 clusters first (just like for other orders).
>> Although for order-0 I will still fallback to searching any cluster if no space
>> is found in an order-0 cluster. What more can we do?
>>
>> When run against your v1 of the tool with "-s" (v1 always implicily behaves as
>> if "-a" is specified, right?) my patch gives 0% fallback. So what's the
>> difference in v2 that causes higher fallback rate? Possibly just that
>> MEMSIZE_SMALLFOLIO has grown by 3MB so that the total memory matches the swap
>> size (64M)?
> 
> Exactly. From my understanding, we've reached a point where small folios are
> struggling to find swap slots. Note that I always swap out mTHP before swapping
> out small folios. Additionally, I have already swapped in 1MB small
> folios before
> swapping out, which means zRAM has 1MB-4KB of redundant space available
> for mTHP to swap out.
> 
>>
>> Thanks,
>> Ryan
>>
>>>
>>> *
>>> *  Test results on Ryan's patchset:
>>> *
>>>
>>> 1. w/ -a
>>> ./thp_swap_allocator_test -a
>>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 4: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> ...
>>> Iteration 100: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: 0.00%
>>>
>>> 2. w/o -a
>>> ./thp_swap_allocator_test
>>>
>>> Iteration 1: swpout inc: 208, swpout fallback inc: 25, Fallback percentage: 10.73%
>>> Iteration 2: swpout inc: 118, swpout fallback inc: 114, Fallback percentage: 49.14%
>>> Iteration 3: swpout inc: 63, swpout fallback inc: 163, Fallback percentage: 72.12%
>>> Iteration 4: swpout inc: 45, swpout fallback inc: 178, Fallback percentage: 79.82%
>>> Iteration 5: swpout inc: 42, swpout fallback inc: 184, Fallback percentage: 81.42%
>>> Iteration 6: swpout inc: 31, swpout fallback inc: 193, Fallback percentage: 86.16%
>>> Iteration 7: swpout inc: 27, swpout fallback inc: 201, Fallback percentage: 88.16%
>>> Iteration 8: swpout inc: 30, swpout fallback inc: 198, Fallback percentage: 86.84%
>>> Iteration 9: swpout inc: 32, swpout fallback inc: 194, Fallback percentage: 85.84%
>>> ...
>>> Iteration 91: swpout inc: 26, swpout fallback inc: 194, Fallback percentage: 88.18%
>>> Iteration 92: swpout inc: 35, swpout fallback inc: 196, Fallback percentage: 84.85%
>>> Iteration 93: swpout inc: 33, swpout fallback inc: 191, Fallback percentage: 85.27%
>>> Iteration 94: swpout inc: 26, swpout fallback inc: 193, Fallback percentage: 88.13%
>>> Iteration 95: swpout inc: 39, swpout fallback inc: 189, Fallback percentage: 82.89%
>>> Iteration 96: swpout inc: 28, swpout fallback inc: 196, Fallback percentage: 87.50%
>>> Iteration 97: swpout inc: 25, swpout fallback inc: 194, Fallback percentage: 88.58%
>>> Iteration 98: swpout inc: 31, swpout fallback inc: 196, Fallback percentage: 86.34%
>>> Iteration 99: swpout inc: 32, swpout fallback inc: 202, Fallback percentage: 86.32%
>>> Iteration 100: swpout inc: 33, swpout fallback inc: 195, Fallback percentage: 85.53%
>>>
>>> 3. w/ -a and -s
>>> ./thp_swap_allocator_test -a -s
>>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 2: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 4: swpout inc: 220, swpout fallback inc: 6, Fallback percentage: 2.65%
>>> Iteration 5: swpout inc: 206, swpout fallback inc: 16, Fallback percentage: 7.21%
>>> Iteration 6: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 7: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 8: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 9: swpout inc: 217, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 10: swpout inc: 224, swpout fallback inc: 3, Fallback percentage: 1.32%
>>> Iteration 11: swpout inc: 211, swpout fallback inc: 12, Fallback percentage: 5.38%
>>> Iteration 12: swpout inc: 200, swpout fallback inc: 32, Fallback percentage: 13.79%
>>> Iteration 13: swpout inc: 189, swpout fallback inc: 29, Fallback percentage: 13.30%
>>> Iteration 14: swpout inc: 195, swpout fallback inc: 31, Fallback percentage: 13.72%
>>> Iteration 15: swpout inc: 198, swpout fallback inc: 27, Fallback percentage: 12.00%
>>> Iteration 16: swpout inc: 201, swpout fallback inc: 17, Fallback percentage: 7.80%
>>> Iteration 17: swpout inc: 206, swpout fallback inc: 6, Fallback percentage: 2.83%
>>> Iteration 18: swpout inc: 220, swpout fallback inc: 14, Fallback percentage: 5.98%
>>> Iteration 19: swpout inc: 181, swpout fallback inc: 45, Fallback percentage: 19.91%
>>> Iteration 20: swpout inc: 223, swpout fallback inc: 8, Fallback percentage: 3.46%
>>> Iteration 21: swpout inc: 214, swpout fallback inc: 14, Fallback percentage: 6.14%
>>> Iteration 22: swpout inc: 195, swpout fallback inc: 31, Fallback percentage: 13.72%
>>> Iteration 23: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 24: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 25: swpout inc: 214, swpout fallback inc: 1, Fallback percentage: 0.47%
>>> Iteration 26: swpout inc: 229, swpout fallback inc: 1, Fallback percentage: 0.43%
>>> Iteration 27: swpout inc: 214, swpout fallback inc: 5, Fallback percentage: 2.28%
>>> Iteration 28: swpout inc: 211, swpout fallback inc: 15, Fallback percentage: 6.64%
>>> Iteration 29: swpout inc: 188, swpout fallback inc: 40, Fallback percentage: 17.54%
>>> Iteration 30: swpout inc: 207, swpout fallback inc: 18, Fallback percentage: 8.00%
>>> Iteration 31: swpout inc: 215, swpout fallback inc: 10, Fallback percentage: 4.44%
>>> Iteration 32: swpout inc: 202, swpout fallback inc: 22, Fallback percentage: 9.82%
>>> Iteration 33: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 34: swpout inc: 218, swpout fallback inc: 10, Fallback percentage: 4.39%
>>> Iteration 35: swpout inc: 203, swpout fallback inc: 30, Fallback percentage: 12.88%
>>> Iteration 36: swpout inc: 214, swpout fallback inc: 14, Fallback percentage: 6.14%
>>> Iteration 37: swpout inc: 211, swpout fallback inc: 14, Fallback percentage: 6.22%
>>> Iteration 38: swpout inc: 193, swpout fallback inc: 28, Fallback percentage: 12.67%
>>> Iteration 39: swpout inc: 210, swpout fallback inc: 20, Fallback percentage: 8.70%
>>> Iteration 40: swpout inc: 223, swpout fallback inc: 5, Fallback percentage: 2.19%
>>> Iteration 41: swpout inc: 224, swpout fallback inc: 7, Fallback percentage: 3.03%
>>> Iteration 42: swpout inc: 200, swpout fallback inc: 23, Fallback percentage: 10.31%
>>> Iteration 43: swpout inc: 217, swpout fallback inc: 5, Fallback percentage: 2.25%
>>> Iteration 44: swpout inc: 206, swpout fallback inc: 18, Fallback percentage: 8.04%
>>> Iteration 45: swpout inc: 210, swpout fallback inc: 11, Fallback percentage: 4.98%
>>> Iteration 46: swpout inc: 204, swpout fallback inc: 19, Fallback percentage: 8.52%
>>> Iteration 47: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 48: swpout inc: 219, swpout fallback inc: 2, Fallback percentage: 0.90%
>>> Iteration 49: swpout inc: 212, swpout fallback inc: 6, Fallback percentage: 2.75%
>>> Iteration 50: swpout inc: 207, swpout fallback inc: 15, Fallback percentage: 6.76%
>>> Iteration 51: swpout inc: 190, swpout fallback inc: 36, Fallback percentage: 15.93%
>>> Iteration 52: swpout inc: 212, swpout fallback inc: 17, Fallback percentage: 7.42%
>>> Iteration 53: swpout inc: 179, swpout fallback inc: 43, Fallback percentage: 19.37%
>>> Iteration 54: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 55: swpout inc: 224, swpout fallback inc: 2, Fallback percentage: 0.88%
>>> Iteration 56: swpout inc: 220, swpout fallback inc: 8, Fallback percentage: 3.51%
>>> Iteration 57: swpout inc: 203, swpout fallback inc: 25, Fallback percentage: 10.96%
>>> Iteration 58: swpout inc: 213, swpout fallback inc: 6, Fallback percentage: 2.74%
>>> Iteration 59: swpout inc: 207, swpout fallback inc: 18, Fallback percentage: 8.00%
>>> Iteration 60: swpout inc: 216, swpout fallback inc: 14, Fallback percentage: 6.09%
>>> Iteration 61: swpout inc: 183, swpout fallback inc: 34, Fallback percentage: 15.67%
>>> Iteration 62: swpout inc: 184, swpout fallback inc: 39, Fallback percentage: 17.49%
>>> Iteration 63: swpout inc: 184, swpout fallback inc: 39, Fallback percentage: 17.49%
>>> Iteration 64: swpout inc: 210, swpout fallback inc: 15, Fallback percentage: 6.67%
>>> Iteration 65: swpout inc: 178, swpout fallback inc: 48, Fallback percentage: 21.24%
>>> Iteration 66: swpout inc: 188, swpout fallback inc: 30, Fallback percentage: 13.76%
>>> Iteration 67: swpout inc: 193, swpout fallback inc: 29, Fallback percentage: 13.06%
>>> Iteration 68: swpout inc: 202, swpout fallback inc: 22, Fallback percentage: 9.82%
>>> Iteration 69: swpout inc: 213, swpout fallback inc: 5, Fallback percentage: 2.29%
>>> Iteration 70: swpout inc: 204, swpout fallback inc: 15, Fallback percentage: 6.85%
>>> Iteration 71: swpout inc: 180, swpout fallback inc: 45, Fallback percentage: 20.00%
>>> Iteration 72: swpout inc: 210, swpout fallback inc: 21, Fallback percentage: 9.09%
>>> Iteration 73: swpout inc: 216, swpout fallback inc: 7, Fallback percentage: 3.14%
>>> Iteration 74: swpout inc: 209, swpout fallback inc: 19, Fallback percentage: 8.33%
>>> Iteration 75: swpout inc: 222, swpout fallback inc: 7, Fallback percentage: 3.06%
>>> Iteration 76: swpout inc: 212, swpout fallback inc: 14, Fallback percentage: 6.19%
>>> Iteration 77: swpout inc: 188, swpout fallback inc: 41, Fallback percentage: 17.90%
>>> Iteration 78: swpout inc: 198, swpout fallback inc: 17, Fallback percentage: 7.91%
>>> Iteration 79: swpout inc: 209, swpout fallback inc: 16, Fallback percentage: 7.11%
>>> Iteration 80: swpout inc: 182, swpout fallback inc: 41, Fallback percentage: 18.39%
>>> Iteration 81: swpout inc: 217, swpout fallback inc: 1, Fallback percentage: 0.46%
>>> Iteration 82: swpout inc: 225, swpout fallback inc: 3, Fallback percentage: 1.32%
>>> Iteration 83: swpout inc: 222, swpout fallback inc: 8, Fallback percentage: 3.48%
>>> Iteration 84: swpout inc: 201, swpout fallback inc: 21, Fallback percentage: 9.46%
>>> Iteration 85: swpout inc: 211, swpout fallback inc: 3, Fallback percentage: 1.40%
>>> Iteration 86: swpout inc: 209, swpout fallback inc: 14, Fallback percentage: 6.28%
>>> Iteration 87: swpout inc: 181, swpout fallback inc: 42, Fallback percentage: 18.83%
>>> Iteration 88: swpout inc: 223, swpout fallback inc: 4, Fallback percentage: 1.76%
>>> Iteration 89: swpout inc: 214, swpout fallback inc: 14, Fallback percentage: 6.14%
>>> Iteration 90: swpout inc: 192, swpout fallback inc: 33, Fallback percentage: 14.67%
>>> Iteration 91: swpout inc: 184, swpout fallback inc: 31, Fallback percentage: 14.42%
>>> Iteration 92: swpout inc: 201, swpout fallback inc: 32, Fallback percentage: 13.73%
>>> Iteration 93: swpout inc: 181, swpout fallback inc: 40, Fallback percentage: 18.10%
>>> Iteration 94: swpout inc: 211, swpout fallback inc: 14, Fallback percentage: 6.22%
>>> Iteration 95: swpout inc: 198, swpout fallback inc: 25, Fallback percentage: 11.21%
>>> Iteration 96: swpout inc: 205, swpout fallback inc: 22, Fallback percentage: 9.69%
>>> Iteration 97: swpout inc: 218, swpout fallback inc: 12, Fallback percentage: 5.22%
>>> Iteration 98: swpout inc: 203, swpout fallback inc: 25, Fallback percentage: 10.96%
>>> Iteration 99: swpout inc: 218, swpout fallback inc: 12, Fallback percentage: 5.22%
>>> Iteration 100: swpout inc: 195, swpout fallback inc: 34, Fallback percentage: 14.85%
>>>
>>> 4. w/o -a and w/ -s
>>> thp_swap_allocator_test  -s
>>> Iteration 1: swpout inc: 173, swpout fallback inc: 60, Fallback percentage: 25.75%
>>> Iteration 2: swpout inc: 85, swpout fallback inc: 147, Fallback percentage: 63.36%
>>> Iteration 3: swpout inc: 39, swpout fallback inc: 195, Fallback percentage: 83.33%
>>> Iteration 4: swpout inc: 13, swpout fallback inc: 220, Fallback percentage: 94.42%
>>> Iteration 5: swpout inc: 10, swpout fallback inc: 215, Fallback percentage: 95.56%
>>> Iteration 6: swpout inc: 9, swpout fallback inc: 219, Fallback percentage: 96.05%
>>> Iteration 7: swpout inc: 6, swpout fallback inc: 217, Fallback percentage: 97.31%
>>> Iteration 8: swpout inc: 6, swpout fallback inc: 215, Fallback percentage: 97.29%
>>> Iteration 9: swpout inc: 0, swpout fallback inc: 225, Fallback percentage: 100.00%
>>> Iteration 10: swpout inc: 1, swpout fallback inc: 229, Fallback percentage: 99.57%
>>> Iteration 11: swpout inc: 2, swpout fallback inc: 216, Fallback percentage: 99.08%
>>> Iteration 12: swpout inc: 2, swpout fallback inc: 229, Fallback percentage: 99.13%
>>> Iteration 13: swpout inc: 4, swpout fallback inc: 211, Fallback percentage: 98.14%
>>> Iteration 14: swpout inc: 1, swpout fallback inc: 221, Fallback percentage: 99.55%
>>> Iteration 15: swpout inc: 2, swpout fallback inc: 223, Fallback percentage: 99.11%
>>> Iteration 16: swpout inc: 3, swpout fallback inc: 224, Fallback percentage: 98.68%
>>> Iteration 17: swpout inc: 2, swpout fallback inc: 231, Fallback percentage: 99.14%
>>> ...
>>>
>>> *
>>> *  Test results on Chris's v3 patchset:
>>> *
>>> 1. w/ -a
>>> ./thp_swap_allocator_test -a
>>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 4: swpout inc: 217, swpout fallback inc: 5, Fallback percentage: 2.25%
>>> Iteration 5: swpout inc: 215, swpout fallback inc: 12, Fallback percentage: 5.29%
>>> Iteration 6: swpout inc: 213, swpout fallback inc: 14, Fallback percentage: 6.17%
>>> Iteration 7: swpout inc: 207, swpout fallback inc: 15, Fallback percentage: 6.76%
>>> Iteration 8: swpout inc: 193, swpout fallback inc: 33, Fallback percentage: 14.60%
>>> Iteration 9: swpout inc: 214, swpout fallback inc: 13, Fallback percentage: 5.73%
>>> Iteration 10: swpout inc: 199, swpout fallback inc: 25, Fallback percentage: 11.16%
>>> Iteration 11: swpout inc: 208, swpout fallback inc: 14, Fallback percentage: 6.31%
>>> Iteration 12: swpout inc: 203, swpout fallback inc: 31, Fallback percentage: 13.25%
>>> Iteration 13: swpout inc: 192, swpout fallback inc: 25, Fallback percentage: 11.52%
>>> Iteration 14: swpout inc: 193, swpout fallback inc: 36, Fallback percentage: 15.72%
>>> Iteration 15: swpout inc: 188, swpout fallback inc: 33, Fallback percentage: 14.93%
>>> ...
>>>
>>> It seems Chris's approach can be negatively affected even by aligned swapin,
>>> having a low fallback ratio but not 0% while Ryan's patchset hasn't this
>>> issue.
>>>
>>> 2. w/o -a
>>> ./thp_swap_allocator_test
>>> Iteration 1: swpout inc: 209, swpout fallback inc: 24, Fallback percentage: 10.30%
>>> Iteration 2: swpout inc: 100, swpout fallback inc: 132, Fallback percentage: 56.90%
>>> Iteration 3: swpout inc: 43, swpout fallback inc: 183, Fallback percentage: 80.97%
>>> Iteration 4: swpout inc: 30, swpout fallback inc: 193, Fallback percentage: 86.55%
>>> Iteration 5: swpout inc: 21, swpout fallback inc: 205, Fallback percentage: 90.71%
>>> Iteration 6: swpout inc: 10, swpout fallback inc: 214, Fallback percentage: 95.54%
>>> Iteration 7: swpout inc: 16, swpout fallback inc: 212, Fallback percentage: 92.98%
>>> Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback percentage: 96.05%
>>> Iteration 9: swpout inc: 6, swpout fallback inc: 220, Fallback percentage: 97.35%
>>> Iteration 10: swpout inc: 7, swpout fallback inc: 221, Fallback percentage: 96.93%
>>> Iteration 11: swpout inc: 7, swpout fallback inc: 222, Fallback percentage: 96.94%
>>> Iteration 12: swpout inc: 8, swpout fallback inc: 212, Fallback percentage: 96.36%
>>> ..
>>>
>>> Ryan's fallback ratio(around 85%) seems to be a little better while both are much
>>> worse than "-a".
>>>
>>> 3. w/ -a and -s
>>> ./thp_swap_allocator_test -a -s
>>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
>>> Iteration 2: swpout inc: 213, swpout fallback inc: 5, Fallback percentage: 2.29%
>>> Iteration 3: swpout inc: 215, swpout fallback inc: 7, Fallback percentage: 3.15%
>>> Iteration 4: swpout inc: 210, swpout fallback inc: 16, Fallback percentage: 7.08%
>>> Iteration 5: swpout inc: 212, swpout fallback inc: 10, Fallback percentage: 4.50%
>>> Iteration 6: swpout inc: 215, swpout fallback inc: 18, Fallback percentage: 7.73%
>>> Iteration 7: swpout inc: 181, swpout fallback inc: 43, Fallback percentage: 19.20%
>>> Iteration 8: swpout inc: 173, swpout fallback inc: 55, Fallback percentage: 24.12%
>>> Iteration 9: swpout inc: 163, swpout fallback inc: 54, Fallback percentage: 24.88%
>>> Iteration 10: swpout inc: 168, swpout fallback inc: 59, Fallback percentage: 25.99%
>>> Iteration 11: swpout inc: 154, swpout fallback inc: 69, Fallback percentage: 30.94%
>>> Iteration 12: swpout inc: 166, swpout fallback inc: 66, Fallback percentage: 28.45%
>>> Iteration 13: swpout inc: 165, swpout fallback inc: 53, Fallback percentage: 24.31%
>>> Iteration 14: swpout inc: 158, swpout fallback inc: 68, Fallback percentage: 30.09%
>>> Iteration 15: swpout inc: 168, swpout fallback inc: 57, Fallback percentage: 25.33%
>>> Iteration 16: swpout inc: 165, swpout fallback inc: 53, Fallback percentage: 24.31%
>>> Iteration 17: swpout inc: 163, swpout fallback inc: 49, Fallback percentage: 23.11%
>>> Iteration 18: swpout inc: 172, swpout fallback inc: 62, Fallback percentage: 26.50%
>>> Iteration 19: swpout inc: 183, swpout fallback inc: 43, Fallback percentage: 19.03%
>>> Iteration 20: swpout inc: 158, swpout fallback inc: 73, Fallback percentage: 31.60%
>>> Iteration 21: swpout inc: 147, swpout fallback inc: 81, Fallback percentage: 35.53%
>>> Iteration 22: swpout inc: 140, swpout fallback inc: 86, Fallback percentage: 38.05%
>>> Iteration 23: swpout inc: 144, swpout fallback inc: 79, Fallback percentage: 35.43%
>>> Iteration 24: swpout inc: 132, swpout fallback inc: 101, Fallback percentage: 43.35%
>>> Iteration 25: swpout inc: 133, swpout fallback inc: 82, Fallback percentage: 38.14%
>>> Iteration 26: swpout inc: 152, swpout fallback inc: 78, Fallback percentage: 33.91%
>>> Iteration 27: swpout inc: 138, swpout fallback inc: 81, Fallback percentage: 36.99%
>>> Iteration 28: swpout inc: 152, swpout fallback inc: 74, Fallback percentage: 32.74%
>>> Iteration 29: swpout inc: 153, swpout fallback inc: 75, Fallback percentage: 32.89%
>>> Iteration 30: swpout inc: 151, swpout fallback inc: 74, Fallback percentage: 32.89%
>>> ...
>>>
>>> Chris's approach appears to be more susceptible to negative effects from
>>> small folios.
>>>
>>> 4. w/o -a and w/ -s
>>> ./thp_swap_allocator_test -s
>>> Iteration 1: swpout inc: 183, swpout fallback inc: 50, Fallback percentage: 21.46%
>>> Iteration 2: swpout inc: 75, swpout fallback inc: 157, Fallback percentage: 67.67%
>>> Iteration 3: swpout inc: 33, swpout fallback inc: 201, Fallback percentage: 85.90%
>>> Iteration 4: swpout inc: 11, swpout fallback inc: 222, Fallback percentage: 95.28%
>>> Iteration 5: swpout inc: 10, swpout fallback inc: 215, Fallback percentage: 95.56%
>>> Iteration 6: swpout inc: 7, swpout fallback inc: 221, Fallback percentage: 96.93%
>>> Iteration 7: swpout inc: 2, swpout fallback inc: 221, Fallback percentage: 99.10%
>>> Iteration 8: swpout inc: 4, swpout fallback inc: 217, Fallback percentage: 98.19%
>>> Iteration 9: swpout inc: 0, swpout fallback inc: 225, Fallback percentage: 100.00%
>>> Iteration 10: swpout inc: 3, swpout fallback inc: 227, Fallback percentage: 98.70%
>>> Iteration 11: swpout inc: 1, swpout fallback inc: 217, Fallback percentage: 99.54%
>>> Iteration 12: swpout inc: 2, swpout fallback inc: 229, Fallback percentage: 99.13%
>>> Iteration 13: swpout inc: 1, swpout fallback inc: 214, Fallback percentage: 99.53%
>>> Iteration 14: swpout inc: 2, swpout fallback inc: 220, Fallback percentage: 99.10%
>>> Iteration 15: swpout inc: 1, swpout fallback inc: 224, Fallback percentage: 99.56%
>>> Iteration 16: swpout inc: 3, swpout fallback inc: 224, Fallback percentage: 98.68%
>>> ...
>>>
>>> Barry Song (1):
>>>   tools/mm: Introduce a tool to assess swap entry allocation for
>>>     thp_swapout
>>>
>>>  tools/mm/Makefile                  |   2 +-
>>>  tools/mm/thp_swap_allocator_test.c | 233 +++++++++++++++++++++++++++++
>>>  2 files changed, 234 insertions(+), 1 deletion(-)
>>>  create mode 100644 tools/mm/thp_swap_allocator_test.c
>>>
>>
> 
> Thanks
> Barry


