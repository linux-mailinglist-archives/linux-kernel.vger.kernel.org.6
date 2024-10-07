Return-Path: <linux-kernel+bounces-352745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9319923A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D2128299E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 04:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC5813D53B;
	Mon,  7 Oct 2024 04:38:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564411339A4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 04:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275905; cv=none; b=hmj4jOvVqvMcNu48E65sMZbUoW98oppgo4uvRrNN9tfeBbOmxiysNViRpme6WOGnnMkMnDFV0+M9XVzkzQbKADxbWbMqe5Jf1U7DJ/xlDQNEsheVxDWPaeny/VyTdgLA3sy6qCuObVIcyEEbAXhzZrf7DvpoAOvDFLTyFOYIJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275905; c=relaxed/simple;
	bh=7spHXMiPTiTq9OAUqdd9QH8MrgXTR+/ZavwmuQccwsw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GVKtJr9RwwS8YgxHf9EEvR4LM6rQtAKRp0qr09syNjY6B5jDiE5SYlLZbvwRKa2gd8lsU9BMa+5/JPemla0Uwz/j6ITQswwuqba8NFbtjp8JMB/HzdGiPDeqBMeNta0dhzrfnORPPHd54D8qXvNdS2/TOIxBNuaeEmxYuuZkQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05090FEC;
	Sun,  6 Oct 2024 21:38:52 -0700 (PDT)
Received: from [10.162.40.20] (e116581.arm.com [10.162.40.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5AD13F640;
	Sun,  6 Oct 2024 21:38:13 -0700 (PDT)
Message-ID: <29f94c69-ca62-48cf-a69b-797e89284540@arm.com>
Date: Mon, 7 Oct 2024 10:08:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH v6 1/2] mm: Abstract THP allocation
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240930052812.2627395-1-dev.jain@arm.com>
 <20240930052812.2627395-2-dev.jain@arm.com>
 <7c563924-47ea-42d1-82dc-3597151998a3@redhat.com>
Content-Language: en-US
In-Reply-To: <7c563924-47ea-42d1-82dc-3597151998a3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/30/24 14:15, David Hildenbrand wrote:
> On 30.09.24 07:28, Dev Jain wrote:
>> In preparation for the second patch, abstract away the THP allocation
>> logic present in the create_huge_pmd() path, which corresponds to the
>> faulting case when no page is present.
>>
>> There should be no functional change as a result of applying this patch,
>> except that, as David notes at [1], a PMD-aligned address should
>> be passed to update_mmu_cache_pmd().
>>
>> [1]: 
>> https://lore.kernel.org/all/ddd3fcd2-48b3-4170-bcaa-2fe66e093f43@redhat.com/
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/huge_memory.c | 98 ++++++++++++++++++++++++++++--------------------
>>   1 file changed, 57 insertions(+), 41 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 4e34b7f89daf..e3bcdbc9baa2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1148,47 +1148,81 @@ unsigned long thp_get_unmapped_area(struct 
>> file *filp, unsigned long addr,
>>   }
>>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>   -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>> -            struct page *page, gfp_t gfp)
>> +static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct 
>> *vma,
>> +                          unsigned long addr)
>
> Just a nit as I am skimming over this once more:
>
> We try to make any new code / code we touch to use a 2-tab
> indentation for the second parameter line.
>
> E.g.,
>
> static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>         unsigned long addr)
> {

Ah sorry, didn't know about this. I used to align it with the function 
parameter opening bracket.
>
>

