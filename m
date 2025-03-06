Return-Path: <linux-kernel+bounces-549129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A1CA54DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8D7188C6CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F525157A48;
	Thu,  6 Mar 2025 14:32:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED90770838
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271541; cv=none; b=qRdeWACyu0CGfzQtcH3LdpS0pLFRK8S6q0A+zRPxwtDMBWcH2D4CoCUa3Vnd4De1N/utGgpA7TqI1QFl7rLlQHn0l/NTNnRQihVNKN6FvY6ld7zSIXWNHvudjKMKY8D31yDZoL+V8WsOzbuthQ8X9P3thXj8IMtUbGJb4DfoDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271541; c=relaxed/simple;
	bh=bvRYrESQozQuBg+nLAANd6YOQE1kUedumejwd8e9Tnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2lSP1+InmqMq5waYNi8gdMIcxdZRsV44l1oImdAf0KJAPfQpNui6aYq5BmGs3Z/PjG+FGX4k/nuyRaZqkJt8CDzaelBu3PpfLXyGEVK/ifwXDjuiuZGgcfINqva5fEH/SHCUF3DnuxCLnTnB5bohvw0GZGH1oP4WyuZa50n04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 046631007;
	Thu,  6 Mar 2025 06:32:32 -0800 (PST)
Received: from [10.174.36.159] (unknown [10.174.36.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F61F3F66E;
	Thu,  6 Mar 2025 06:32:13 -0800 (PST)
Message-ID: <c8eb5701-47ad-4cca-b123-31a5a978f801@arm.com>
Date: Thu, 6 Mar 2025 20:02:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vma: Do not register private-anon mappings with
 khugepaged during mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
 jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ryan.roberts@arm.com, anshuman.khandual@arm.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, david@redhat.com, willy@infradead.org,
 hughd@google.com, ziy@nvidia.com
References: <20250306063037.16299-1-dev.jain@arm.com>
 <67f0916e-9825-4105-b044-a16c0e82e736@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <67f0916e-9825-4105-b044-a16c0e82e736@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/25 1:48 pm, Lorenzo Stoakes wrote:
> On Thu, Mar 06, 2025 at 12:00:37PM +0530, Dev Jain wrote:
>> We already are registering private-anon VMAs with khugepaged during fault
>> time, in do_huge_pmd_anonymous_page(). Commit "register suitable readonly
>> file vmas for khugepaged" moved the khugepaged registration logic from
>> shmem_mmap to the generic mmap path. Make this logic specific for non-anon
>> mappings.
> 
> This does sound reasonable, thanks! Though does need to be expanded as
> Andrew says for user-visible effects just to be crystal clear.

Sure.

> 
>>
>> Fixes: 613bec092fe7 ("mm: mmap: register suitable readonly file vmas for khugepaged")
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/vma.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vma.c b/mm/vma.c
>> index af1d549b179c..730a26bf14a5 100644
>> --- a/mm/vma.c
>> +++ b/mm/vma.c
>> @@ -2377,7 +2377,8 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>>   	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
>>   	 * call covers the non-merge case.
>>   	 */
>> -	khugepaged_enter_vma(vma, map->flags);
>> +	if (!vma_is_anonymous(vma))
>> +		khugepaged_enter_vma(vma, map->flags);
> 
> This really needs a comment :) as a Joe Bloggs coder coming to this my
> immediate thought would be 'huh? Why?'
> 
> Something like:
> 
> 	/* Just added so khugepaged has nothing to do. We call again on fault. */
> 
> Would be great.
> 
> Thanks!

Sure.

BTW does this patch merit a CC:stable? I am not aware of the general 
practice but I am not sure if this is a *serious bug*, as per 
submitting-patches.rst.

> 
> 
>>   	ksm_add_vma(vma);
>>   	*vmap = vma;
>>   	return 0;
>> --
>> 2.30.2
>>


