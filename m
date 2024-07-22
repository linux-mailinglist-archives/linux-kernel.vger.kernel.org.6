Return-Path: <linux-kernel+bounces-258730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A7938C32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1138A281C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2582616C87C;
	Mon, 22 Jul 2024 09:43:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A2916C687
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641413; cv=none; b=lcWJmQkz82h+X0gz7Mr4QUJLc6mBIm38FqJdqIZaDKEjUzVd7GyXN4JaEOzapurVePdMbGvmI3mUPQOpOcHrmfQChlO7BiwEVDB34LHKYNSlpCSMXshybW3R7MXgmrpYzfivtBtIrS/MzG7gObU9QqFwC4B39cN6zb1TGv21J+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641413; c=relaxed/simple;
	bh=zmOLu1E4W3NhbzhRDkpuIpgeqAW8umOych0YMmxCo/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1YQhp/bmlweElR6hRW9xFz4vZ3C34gJnq7unO7iDnvj7ARRGRhuw455y+nsjOkyyPRzZDWQ5xOGCAiSiBfU89WkzW0yEEyJxlOjB2J+DHbIsQS9iu83jWJOZVlVVP8WW3aoYFAwkRIId3ZN0EdQ0gISmghSPrXK8c746PX8BmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA2691007;
	Mon, 22 Jul 2024 02:43:55 -0700 (PDT)
Received: from [10.1.27.165] (XHFQ2J9959.cambridge.arm.com [10.1.27.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB65A3F766;
	Mon, 22 Jul 2024 02:43:28 -0700 (PDT)
Message-ID: <2950ddfa-32a5-4987-9c05-05ce86a53e17@arm.com>
Date: Mon, 22 Jul 2024 10:43:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Control folio sizes used for page cache memory
Content-Language: en-GB
To: Daniel Gomez <da.gomez@samsung.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>,
 Pankaj Raghav <kernel@pankajraghav.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
 <eb2d8027-6347-4cc5-b1f6-6e79dc9a02ef@redhat.com>
 <CGME20240717104555eucas1p25498323e279fcc42702329d0df60e48a@eucas1p2.samsung.com>
 <99b33a29-e97a-4932-8d7a-85bc01885d18@arm.com>
 <joisx5udw4tebjykvcs2s75qxzkugr2rlyvngzmml5xhm7jnvu@o4nvt7g735oj>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <joisx5udw4tebjykvcs2s75qxzkugr2rlyvngzmml5xhm7jnvu@o4nvt7g735oj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 10:35, Daniel Gomez wrote:
> On Wed, Jul 17, 2024 at 11:45:48AM GMT, Ryan Roberts wrote:
>> On 17/07/2024 11:31, David Hildenbrand wrote:
>>> On 17.07.24 09:12, Ryan Roberts wrote:
>>>> Hi All,
>>>>
>>>> This series is an RFC that adds sysfs and kernel cmdline controls to configure
>>>> the set of allowed large folio sizes that can be used when allocating
>>>> file-memory for the page cache. As part of the control mechanism, it provides
>>>> for a special-case "preferred folio size for executable mappings" marker.
>>>>
>>>> I'm trying to solve 2 separate problems with this series:
>>>>
>>>> 1. Reduce pressure in iTLB and improve performance on arm64: This is a modified
>>>> approach for the change at [1]. Instead of hardcoding the preferred executable
>>>> folio size into the arch, user space can now select it. This decouples the arch
>>>> code and also makes the mechanism more generic; it can be bypassed (the default)
>>>> or any folio size can be set. For my use case, 64K is preferred, but I've also
>>>> heard from Willy of a use case where putting all text into 2M PMD-sized folios
>>>> is preferred. This approach avoids the need for synchonous MADV_COLLAPSE (and
>>>> therefore faulting in all text ahead of time) to achieve that.
>>>>
>>>> 2. Reduce memory fragmentation in systems under high memory pressure (e.g.
>>>> Android): The theory goes that if all folios are 64K, then failure to allocate a
>>>> 64K folio should become unlikely. But if the page cache is allocating lots of
>>>> different orders, with most allocations having an order below 64K (as is the
>>>> case today) then ability to allocate 64K folios diminishes. By providing control
>>>> over the allowed set of folio sizes, we can tune to avoid crucial 64K folio
>>>> allocation failure. Additionally I've heard (second hand) of the need to disable
>>>> large folios in the page cache entirely due to latency concerns in some
>>>> settings. These controls allow all of this without kernel changes.
>>>>
>>>> The value of (1) is clear and the performance improvements are documented in
>>>> patch 2. I don't yet have any data demonstrating the theory for (2) since I
>>>> can't reproduce the setup that Barry had at [2]. But my view is that by adding
>>>> these controls we will enable the community to explore further, in the same way
>>>> that the anon mTHP controls helped harden the understanding for anonymous
>>>> memory.
>>>>
>>>> ---
>>>
>>> How would this interact with other requirements we get from the filesystem (for
>>> example, because of the device) [1].
>>>
>>> Assuming a device has a filesystem has a min order of X, but we disable anything
>>>> = X, how would we combine that configuration/information?
>>
>> Currently order-0 is implicitly the "always-on" fallback order. My thinking was
>> that with [1], the specified min order just becomes that "always-on" fallback order.
>>
>> Today:
>>
>>   orders = file_orders_always() | BIT(0);
>>
>> Tomorrow:
>>
>>   orders = (file_orders_always() & ~(BIT(min_order) - 1)) | BIT(min_order);
>>
>> That does mean that in this case, a user-disabled order could still be used. So
>> the controls are really hints rather than definitive commands.
> 
> In the scenario where a min order is not enabled in hugepages-<size>kB/
> file_enabled, will the user still be allowed to automatically mkfs/mount with
> blocksize=min_order, and will sysfs reflect this? Or, since it's a hint, will it
> remain hidden but still allow mkfs/mount to proceed?

My proposal is that the controls are hints, and they would not block mounting a
file system.

As an example, the user may set
`/sys/kernel/mm/transparent_hugepage/hugepages-16kB/file_enable` to `never`. In
this case the kernel would never pick a 16K folio to back a file who's minimum
folio size is not 16K. If the file's minimum folio size is 16K then it would
still allocate that folio size in the fallback case, after trying any
appropriate bigger folio sizes that are set to `always`.

Thanks,
Ryan

> 
>>
>>
>>>
>>>
>>> [1]
>>> https://lore.kernel.org/all/20240715094457.452836-2-kernel@pankajraghav.com/T/#u
>>>


