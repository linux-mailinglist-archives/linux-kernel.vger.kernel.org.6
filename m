Return-Path: <linux-kernel+bounces-171727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA68BE7D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DD3B25820
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2AB16C439;
	Tue,  7 May 2024 15:53:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555916ABCE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097196; cv=none; b=sbXG/LzSZPPWRUQpKdU6vU7KTe8Q3wy3+6ObfwgIkg6Ekvy1Y9CYFdPTb7U7+XbrhQM8WLgy7ARrbR0fSlX5wcpTPBBqzkDIYJwHKZ9UnA6nb4DDzNrCJzlnRjLczwYoLpXJVsbCUXXZ7XjWk9Q1zaLtUPomqsWNM5TLXt8k85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097196; c=relaxed/simple;
	bh=vplVfclGHUroCOJb/FVNWktJ8JUSw10nffch/n2bgxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSf+ppQtmioRZqyy4foF9uNcADHdP1AQuyFVp5AMylHCMaVacHrtf1IaDNUKzpnlz+2IBLgw3bvI1wDvUQ2W30sXKfPpJxmiGIRA02gzFvxaLEsmyV5BHxfy5PPMCniPVzjJprdgpFDTlbQvl2BkebdYzDxQvdfCA9bYUgeo+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 817A91063;
	Tue,  7 May 2024 08:53:39 -0700 (PDT)
Received: from [10.1.34.181] (XHFQ2J9959.cambridge.arm.com [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BF1A3F587;
	Tue,  7 May 2024 08:53:12 -0700 (PDT)
Message-ID: <2b403705-a03c-4cfe-8d95-b38dd83fca52@arm.com>
Date: Tue, 7 May 2024 16:53:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
Content-Language: en-GB
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, cl@linux.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ze Zuo <zuoze1@huawei.com>
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
 <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
 <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com>
 <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
 <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com>
 <dea802da-2e5e-4c91-b817-43afdde68958@huawei.com>
 <1dc9a561-55f7-4d65-8b86-8a40fa0e84f9@arm.com>
 <6016c0e9-b567-4205-8368-1f1c76184a28@huawei.com>
 <2c14d9ad-c5a3-4f29-a6eb-633cdf3a5e9e@redhat.com>
 <da24d8bb-3723-48fa-86f4-8b24457d3556@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <da24d8bb-3723-48fa-86f4-8b24457d3556@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 14:53, Kefeng Wang wrote:
> 
> 
> On 2024/5/7 19:13, David Hildenbrand wrote:
>>
>>> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
>>>
>>>> suggest. If you want to try something semi-randomly; it might be useful to rule
>>>> out the arm64 contpte feature. I don't see how that would be interacting
>>>> here if
>>>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disable with
>>>> ARM64_CONTPTE (needs EXPERT) at compile time.
>>> I don't enabled mTHP, so it should be not related about ARM64_CONTPTE,
>>> but will have a try.
> 
> After ARM64_CONTPTE disabled, memory read latency is similar with ARM64_CONTPTE
> enabled(default 6.9-rc7), still larger than align anon reverted.

OK thanks for trying.

Looking at the source for lmbench, its malloc'ing (512M + 8K) up front and using
that for all sizes. That will presumably be considered "large" by malloc and
will be allocated using mmap. So with the patch, it will be 2M aligned. Without
it, it probably won't. I'm still struggling to understand why not aligning it in
virtual space would make it more performant though...

Is it possible to provide the smaps output for at least that 512M+8K block for
both cases? It might give a bit of a clue.

Do you have traditional (PMD-sized) THP enabled? If its enabled and unaligned
then the front of the buffer wouldn't be mapped with THP, but if it is aligned,
it will. That could affect it.

> 
>>
>> cont-pte can get active if we're just lucky when allocating pages in the right
>> order, correct Ryan?
>>


