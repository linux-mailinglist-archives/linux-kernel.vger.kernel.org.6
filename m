Return-Path: <linux-kernel+bounces-229097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17054916AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D6B258CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29516D4F6;
	Tue, 25 Jun 2024 14:46:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4C16EC08
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326762; cv=none; b=Soc1zuxV+gK/EzCGYV9gg6CY/207G1AwCjr5DCywoW6Cc980o9r/XqqmRgHJ46ZY/j2pdKgDLX3/eU9fTEWSOedbUVQ57ufPpOPegKZUHTpSW0mKjsPXV8X3tahYs4cAyyMD8dU7q/6KuBbKCnHcrzvO/S2IvCCmyz95bSXVQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326762; c=relaxed/simple;
	bh=iOLjYYvI730HAzLOyq5czCRUlADggSHfg7r1FOsen0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiDAimb+9SzNIvhOIk0pKvDNEAV2Qq59kK8PQa6f1kWNDBSZwTzi0Sge3Wkbn+WHMbtzl7L902gGFaFlPRhHwWabjGRD6zgV7ad3PfglQvlQgl4ZrZAJj6dpCK4Uf3mzAvQ1N4EtNxdntRRbfVHOa08V7O/Lvwb3t4zL8V4OA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CD45339;
	Tue, 25 Jun 2024 07:46:24 -0700 (PDT)
Received: from [10.1.39.170] (XHFQ2J9959.cambridge.arm.com [10.1.39.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF0363F73B;
	Tue, 25 Jun 2024 07:45:55 -0700 (PDT)
Message-ID: <de83daf9-e899-4415-bf85-5e7d69f9693e@arm.com>
Date: Tue, 25 Jun 2024 15:45:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/18] arm64/mm: Automatically fold contpte mappings
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Yin, Fengwei" <fengwei.yin@intel.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215103205.2607016-19-ryan.roberts@arm.com>
 <1285eb59-fcc3-4db8-9dd9-e7c4d82b1be0@huawei.com>
 <8d57ed0d-fdd0-4fc6-b9f1-a6ac11ce93ce@arm.com>
 <018b5e83-789e-480f-82c8-a64515cdd14a@huawei.com>
 <b75aa60d-e058-4b5c-877a-9c0cd295e96f@linux.alibaba.com>
 <b6b485ee-7af0-42b8-b0ca-5a75f76a69e2@arm.com>
 <43a5986a-52ea-4090-9333-90af137a4735@linux.alibaba.com>
 <306874fe-9bc1-4dec-a856-0125e4541971@arm.com>
 <ZnrAzjm5Fqg0d1CL@casper.infradead.org>
 <dbeb71ca-8aba-4aed-9123-c4d07c3da004@arm.com>
 <ZnrO4clYoEH_67Ur@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZnrO4clYoEH_67Ur@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2024 15:06, Matthew Wilcox wrote:
> On Tue, Jun 25, 2024 at 02:41:18PM +0100, Ryan Roberts wrote:
>> On 25/06/2024 14:06, Matthew Wilcox wrote:
>>> On Tue, Jun 25, 2024 at 01:41:02PM +0100, Ryan Roberts wrote:
>>>> On 25/06/2024 13:37, Baolin Wang wrote:
>>>>
>>>> [...]
>>>>
>>>>>>> For other filesystems, like ext4, I did not found the logic to determin what
>>>>>>> size of folio to allocate in writable mmap() path
>>>>>>
>>>>>> Yes I'd be keen to understand this to. When I was doing contpte, page cache
>>>>>> would only allocate large folios for readahead. So that's why I wouldn't have
>>>>>
>>>>> You mean non-large folios, right?
>>>>
>>>> No I mean that at the time I wrote contpte, the policy was to allocate an
>>>> order-0 folio for any writes that missed in the page cache, and allocate large
>>>> folios only when doing readahead from storage into page cache. The test that is
>>>> regressing is doing writes.
>>>
>>> mmap() faults also use readahead.
>>>
>>> filemap_fault():
>>>
>>>         folio = filemap_get_folio(mapping, index);
>>>         if (likely(!IS_ERR(folio))) {
>>>                 if (!(vmf->flags & FAULT_FLAG_TRIED))
>>>                         fpin = do_async_mmap_readahead(vmf, folio);
>>> which does:
>>>         if (folio_test_readahead(folio)) {
>>>                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>>>                 page_cache_async_ra(&ractl, folio, ra->ra_pages);
>>>
>>> which has been there in one form or another since 2007 (3ea89ee86a82).
>>
>> OK sounds like I'm probably misremembering something I read on LWN... You're
>> saying that its been the case for a while that if we take a write fault for a
>> portion of a file, then we will still end up taking the readahead path and
>> allocating a large folio (filesystem permitting)? Does that apply in the case
>> where the file has never been touched but only ftruncate'd, as is happening in
>> this test? There is obviously no need for IO in that case, but have we always
>> taken a path where a large folio may be allocated for it? I thought that bit was
>> newer for some reason.
> 
> The pagecache doesn't know whether the file contains data or holes.
> It allocates folios and then invites the filesystem to fill them; the
> filesystem checks its data structures and then either issues reads if
> there's data on media or calls memset if the records indicate there's
> a hole.
> 
> Whether it chooses to allocate large folios or not is going to depend
> on the access pattern; a sequential write pattern will use large folios
> and a random write pattern won't.
> 
> Now, I've oversimplified things a bit by talking about filemap_fault.
> Before we call filemap_fault, we call filemap_map_pages() which looks
> for any suitable folios in the page cache between start and end, and
> maps those.

OK that all makes sense, thanks. I guess it just means I don't have an excuse
for the perf regression. :)



