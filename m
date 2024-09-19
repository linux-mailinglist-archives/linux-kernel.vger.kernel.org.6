Return-Path: <linux-kernel+bounces-333727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F9B97CCFD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57ADC1F2376A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC271A0B16;
	Thu, 19 Sep 2024 17:21:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED0B191F74
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766498; cv=none; b=fznQjsDJibClJ3r5DnWV5pXcjDnn6nlL+2/Mhmhd9O++Q2BIsKWkAn3XAy58jpHqJxYdylZEDemhRxqBWJ5PgMMPsNHcEG0OEG712YKuaJQnfXaqlRcVsab/7dIBRsZCq9SIaANt+OHdreqM3TOQx/xGyVaYqERH3NsVyl4nPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766498; c=relaxed/simple;
	bh=qoohf4dir+QD12ffCqFIrKxEQRUDj/58wKWXJA/Jt2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsDCXKYSNBULowFfoMPXFua0henVUWNHXyfvZu6SEKYcgzy9ngmAmpVza1D66CPthsZXE4ikqirGpO5gMgA4Us9e6oUhUoUn+oq2cZuK8B+07iWftuLZ/P9arM9jFoX2za6ZRI8l68LINv4cAWdY/lsD9OEcltzgXR74f/U4uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F8B51007;
	Thu, 19 Sep 2024 10:22:04 -0700 (PDT)
Received: from [10.57.82.79] (unknown [10.57.82.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECB5A3F64C;
	Thu, 19 Sep 2024 10:21:30 -0700 (PDT)
Message-ID: <c6224621-74b2-465c-a0fe-b1aa9f69b1e9@arm.com>
Date: Thu, 19 Sep 2024 19:21:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Control folio sizes used for page cache memory
Content-Language: en-GB
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>,
 Pankaj Raghav <kernel@pankajraghav.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
 <480f34d0-a943-40da-9c69-2353fe311cf7@arm.com>
 <CAGsJ_4z8kh4Pn-TUrVq6FALR1J5j4fpvQkef2xPFYPWdWfXdxA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4z8kh4Pn-TUrVq6FALR1J5j4fpvQkef2xPFYPWdWfXdxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/09/2024 09:20, Barry Song wrote:
> On Thu, Aug 8, 2024 at 10:27 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 17/07/2024 08:12, Ryan Roberts wrote:
>>> Hi All,
>>>
>>> This series is an RFC that adds sysfs and kernel cmdline controls to configure
>>> the set of allowed large folio sizes that can be used when allocating
>>> file-memory for the page cache. As part of the control mechanism, it provides
>>> for a special-case "preferred folio size for executable mappings" marker.
>>>
>>> I'm trying to solve 2 separate problems with this series:
>>>
>>> 1. Reduce pressure in iTLB and improve performance on arm64: This is a modified
>>> approach for the change at [1]. Instead of hardcoding the preferred executable
>>> folio size into the arch, user space can now select it. This decouples the arch
>>> code and also makes the mechanism more generic; it can be bypassed (the default)
>>> or any folio size can be set. For my use case, 64K is preferred, but I've also
>>> heard from Willy of a use case where putting all text into 2M PMD-sized folios
>>> is preferred. This approach avoids the need for synchonous MADV_COLLAPSE (and
>>> therefore faulting in all text ahead of time) to achieve that.
>>
>> Just a polite bump on this; I'd really like to get something like this merged to
>> help reduce iTLB pressure. We had a discussion at the THP Cabal meeting a few
>> weeks back without solid conclusion. I haven't heard any concrete objections
>> yet, but also only a luke-warm reception. How can I move this forwards?
> 
> Hi Ryan,
> 
> These requirements seem to apply to anon, swap, pagecache, and shmem to
> some extent. While the swapin_enabled knob was rejected, the shmem_enabled
> option is already in place.
> 
> I wonder if it's possible to use the existing 'enabled' setting across
> all cases, as
> from an architectural perspective with cont-pte, pagecache may not differ from
> anon. The demand for reducing page faults, LRU overhead, etc., also seems
> quite similar.
> 
> I imagine that once Android's file systems support mTHP, we’ll uniformly enable
> 64KB for anon, swap, shmem, and page cache. It should then be sufficient to
> enable all of them using a single knob:
> '/sys/kernel/mm/transparent_hugepage/hugepages-xxkB/enabled'.
> 
> Is there anything that makes pagecache and shmem significantly different
> from anon? In my Android case, they all seem the same. However, I assume
> there might be other use cases where differentiating them is necessary?

For anon vs shmem, we were just following the precedent set by the legacy PMD
controls, which separated them. I vaguely recall David explaining why there are
separate controls but don't recall the exact reason; I beleive there was some
use case where anon THP made sense, but shmem THP was problematic for some
reason. Note too, that the controls expose different options; anon has {always
never, madvise}, shmem has {always, never, advise (no m; it applies to fadvise
too), within_size, force, deny}. So I guess if the extra shmem options are
important then it makes sense to have a separate control.

For pagecache vs anon, I'm not sure it makes sense to tie these to the same
control. We have readahead information to help us make an educated guess at the
folio size we should use (currently we start at order-2 and increase by 2 orders
every time we hit the readahead marker) and it's much easier to drop pagecache
folios under memory pressure. So by default, I think most/all orders would be
enabled for pagecahce. But for anon, things are harder. In the common case,
likely we only want 2M when madvised, and 64K always (and possibly 16K always).

Talking with Willy today, his preference is to not expose any controls for
pagecache at all, and let the architecture hint the preferred folio size for
code - basically how I did it at [1] - linked in the original post. This is very
simple and exposes no user controls so could be easily modified over time as we
get more data.

Trouble is nobody seemed willing to R-b the first approach. So perhaps we're
stuck waiting for Android's FSs to support large folios so we can start
benchmarking the real-world gains?

Thanks,
Ryan

> 
>>
>> Thanks,
>> Ryan
>>
>>
>>>
>>> 2. Reduce memory fragmentation in systems under high memory pressure (e.g.
>>> Android): The theory goes that if all folios are 64K, then failure to allocate a
>>> 64K folio should become unlikely. But if the page cache is allocating lots of
>>> different orders, with most allocations having an order below 64K (as is the
>>> case today) then ability to allocate 64K folios diminishes. By providing control
>>> over the allowed set of folio sizes, we can tune to avoid crucial 64K folio
>>> allocation failure. Additionally I've heard (second hand) of the need to disable
>>> large folios in the page cache entirely due to latency concerns in some
>>> settings. These controls allow all of this without kernel changes.
>>>
>>> The value of (1) is clear and the performance improvements are documented in
>>> patch 2. I don't yet have any data demonstrating the theory for (2) since I
>>> can't reproduce the setup that Barry had at [2]. But my view is that by adding
>>> these controls we will enable the community to explore further, in the same way
>>> that the anon mTHP controls helped harden the understanding for anonymous
>>> memory.
>>>
>>> ---
>>> This series depends on the "mTHP allocation stats for file-backed memory" series
>>> at [3], which itself applies on top of yesterday's mm-unstable (650b6752c8a3). All
>>> mm selftests have been run; no regressions were observed.
>>>
>>> [1] https://lore.kernel.org/linux-mm/20240215154059.2863126-1-ryan.roberts@arm.com/
>>> [2] https://www.youtube.com/watch?v=ht7eGWqwmNs&list=PLbzoR-pLrL6oj1rVTXLnV7cOuetvjKn9q&index=4
>>> [3] https://lore.kernel.org/linux-mm/20240716135907.4047689-1-ryan.roberts@arm.com/
>>>
>>> Thanks,
>>> Ryan
>>>
>>> Ryan Roberts (4):
>>>   mm: mTHP user controls to configure pagecache large folio sizes
>>>   mm: Introduce "always+exec" for mTHP file_enabled control
>>>   mm: Override mTHP "enabled" defaults at kernel cmdline
>>>   mm: Override mTHP "file_enabled" defaults at kernel cmdline
>>>
>>>  .../admin-guide/kernel-parameters.txt         |  16 ++
>>>  Documentation/admin-guide/mm/transhuge.rst    |  66 +++++++-
>>>  include/linux/huge_mm.h                       |  61 ++++---
>>>  mm/filemap.c                                  |  26 ++-
>>>  mm/huge_memory.c                              | 158 +++++++++++++++++-
>>>  mm/readahead.c                                |  43 ++++-
>>>  6 files changed, 329 insertions(+), 41 deletions(-)
>>>
>>> --
>>> 2.43.0
>>>
>>
> 
> Thanks
> Barry


