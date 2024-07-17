Return-Path: <linux-kernel+bounces-255076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAA2933B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759351F2136D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CE717F369;
	Wed, 17 Jul 2024 10:45:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA921878
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213154; cv=none; b=KbeVfR90/c4gScvj48lx2yTqVeKg/NnhtmXMNAsCjoG3s0+qoXRg2mg069I3MtU6MqKLbGSq5vtm2mE4I2E3874h9vsq1d1vdcIIx61/u+DHAJ2A8svp1ON7lB36zRjEgKnNpGSQbvM5RubhWak/dfLF0hL05ap4D450uDfz054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213154; c=relaxed/simple;
	bh=K2TiyeTbQ8jjRpZu8tjaXsaFV/Js7/uMUNOmXI67Pds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEMCMXHbYnjwCNM5hqTngMRzvYF0J5iox/uwlc6DlfKJcxqvwKoCLbd2bB7YCCy2YMG29SWxHxzRPyT3qLqjArnRjOhdasUb1wxwpRUatGYYK6f7qMSWyF30kNkBJnd/OgiIXGCx6hH3ccVp3L7B1eJK47UB1LkkT20Y4G5JeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E32851063;
	Wed, 17 Jul 2024 03:46:16 -0700 (PDT)
Received: from [10.57.77.222] (unknown [10.57.77.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C557F3F73F;
	Wed, 17 Jul 2024 03:45:49 -0700 (PDT)
Message-ID: <99b33a29-e97a-4932-8d7a-85bc01885d18@arm.com>
Date: Wed, 17 Jul 2024 11:45:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Control folio sizes used for page cache memory
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>,
 Pankaj Raghav <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
 <eb2d8027-6347-4cc5-b1f6-6e79dc9a02ef@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <eb2d8027-6347-4cc5-b1f6-6e79dc9a02ef@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2024 11:31, David Hildenbrand wrote:
> On 17.07.24 09:12, Ryan Roberts wrote:
>> Hi All,
>>
>> This series is an RFC that adds sysfs and kernel cmdline controls to configure
>> the set of allowed large folio sizes that can be used when allocating
>> file-memory for the page cache. As part of the control mechanism, it provides
>> for a special-case "preferred folio size for executable mappings" marker.
>>
>> I'm trying to solve 2 separate problems with this series:
>>
>> 1. Reduce pressure in iTLB and improve performance on arm64: This is a modified
>> approach for the change at [1]. Instead of hardcoding the preferred executable
>> folio size into the arch, user space can now select it. This decouples the arch
>> code and also makes the mechanism more generic; it can be bypassed (the default)
>> or any folio size can be set. For my use case, 64K is preferred, but I've also
>> heard from Willy of a use case where putting all text into 2M PMD-sized folios
>> is preferred. This approach avoids the need for synchonous MADV_COLLAPSE (and
>> therefore faulting in all text ahead of time) to achieve that.
>>
>> 2. Reduce memory fragmentation in systems under high memory pressure (e.g.
>> Android): The theory goes that if all folios are 64K, then failure to allocate a
>> 64K folio should become unlikely. But if the page cache is allocating lots of
>> different orders, with most allocations having an order below 64K (as is the
>> case today) then ability to allocate 64K folios diminishes. By providing control
>> over the allowed set of folio sizes, we can tune to avoid crucial 64K folio
>> allocation failure. Additionally I've heard (second hand) of the need to disable
>> large folios in the page cache entirely due to latency concerns in some
>> settings. These controls allow all of this without kernel changes.
>>
>> The value of (1) is clear and the performance improvements are documented in
>> patch 2. I don't yet have any data demonstrating the theory for (2) since I
>> can't reproduce the setup that Barry had at [2]. But my view is that by adding
>> these controls we will enable the community to explore further, in the same way
>> that the anon mTHP controls helped harden the understanding for anonymous
>> memory.
>>
>> ---
> 
> How would this interact with other requirements we get from the filesystem (for
> example, because of the device) [1].
> 
> Assuming a device has a filesystem has a min order of X, but we disable anything
>>= X, how would we combine that configuration/information?

Currently order-0 is implicitly the "always-on" fallback order. My thinking was
that with [1], the specified min order just becomes that "always-on" fallback order.

Today:

  orders = file_orders_always() | BIT(0);

Tomorrow:

  orders = (file_orders_always() & ~(BIT(min_order) - 1)) | BIT(min_order);

That does mean that in this case, a user-disabled order could still be used. So
the controls are really hints rather than definitive commands.


> 
> 
> [1]
> https://lore.kernel.org/all/20240715094457.452836-2-kernel@pankajraghav.com/T/#u
> 


