Return-Path: <linux-kernel+bounces-228967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B0891692E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0F31F2A390
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF481607A4;
	Tue, 25 Jun 2024 13:41:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA92158A00
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322886; cv=none; b=BPrXAQB1EMf+FAOkQnqBzuJOK5C3uBR9hKmKJIybVXbnik4GKF9nnNj3kMPezAOY0tjKNnqrId1uTLJAtM0BUBMt9T/dR1Ex//cseobWp+WYjQEfn0yJyPy391PD5vItDWZyTtzptSSPQdwLtwM+lLzai+PhzEJcXX+UkHBiL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322886; c=relaxed/simple;
	bh=TSH2WLrRsgUfgo4fyf3Ry+HIYwLPrJq6fGwMV5rVQ2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHgnLv2gxVD9oiTlnDGCzhYxaSTIiYtsTHwwQp/VJJpOsGG8ODa5acMEBw6RJxK46WPu8C8e9zcrg3bM1GvnIz80+dZ+UqyOuWxgra09rJquoiliwF03P7SYYJb9orelR39dWye+ax15GtD+TjWcKNUVK2XobcLbx805HajkYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FE35339;
	Tue, 25 Jun 2024 06:41:48 -0700 (PDT)
Received: from [10.1.39.170] (XHFQ2J9959.cambridge.arm.com [10.1.39.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 367FF3F73B;
	Tue, 25 Jun 2024 06:41:20 -0700 (PDT)
Message-ID: <dbeb71ca-8aba-4aed-9123-c4d07c3da004@arm.com>
Date: Tue, 25 Jun 2024 14:41:18 +0100
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
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-19-ryan.roberts@arm.com>
 <1285eb59-fcc3-4db8-9dd9-e7c4d82b1be0@huawei.com>
 <8d57ed0d-fdd0-4fc6-b9f1-a6ac11ce93ce@arm.com>
 <018b5e83-789e-480f-82c8-a64515cdd14a@huawei.com>
 <b75aa60d-e058-4b5c-877a-9c0cd295e96f@linux.alibaba.com>
 <b6b485ee-7af0-42b8-b0ca-5a75f76a69e2@arm.com>
 <43a5986a-52ea-4090-9333-90af137a4735@linux.alibaba.com>
 <306874fe-9bc1-4dec-a856-0125e4541971@arm.com>
 <ZnrAzjm5Fqg0d1CL@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZnrAzjm5Fqg0d1CL@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2024 14:06, Matthew Wilcox wrote:
> On Tue, Jun 25, 2024 at 01:41:02PM +0100, Ryan Roberts wrote:
>> On 25/06/2024 13:37, Baolin Wang wrote:
>>
>> [...]
>>
>>>>> For other filesystems, like ext4, I did not found the logic to determin what
>>>>> size of folio to allocate in writable mmap() path
>>>>
>>>> Yes I'd be keen to understand this to. When I was doing contpte, page cache
>>>> would only allocate large folios for readahead. So that's why I wouldn't have
>>>
>>> You mean non-large folios, right?
>>
>> No I mean that at the time I wrote contpte, the policy was to allocate an
>> order-0 folio for any writes that missed in the page cache, and allocate large
>> folios only when doing readahead from storage into page cache. The test that is
>> regressing is doing writes.
> 
> mmap() faults also use readahead.
> 
> filemap_fault():
> 
>         folio = filemap_get_folio(mapping, index);
>         if (likely(!IS_ERR(folio))) {
>                 if (!(vmf->flags & FAULT_FLAG_TRIED))
>                         fpin = do_async_mmap_readahead(vmf, folio);
> which does:
>         if (folio_test_readahead(folio)) {
>                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>                 page_cache_async_ra(&ractl, folio, ra->ra_pages);
> 
> which has been there in one form or another since 2007 (3ea89ee86a82).

OK sounds like I'm probably misremembering something I read on LWN... You're
saying that its been the case for a while that if we take a write fault for a
portion of a file, then we will still end up taking the readahead path and
allocating a large folio (filesystem permitting)? Does that apply in the case
where the file has never been touched but only ftruncate'd, as is happening in
this test? There is obviously no need for IO in that case, but have we always
taken a path where a large folio may be allocated for it? I thought that bit was
newer for some reason.


