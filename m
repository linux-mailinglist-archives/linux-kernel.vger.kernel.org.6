Return-Path: <linux-kernel+bounces-399587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270779C0124
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2451C2132B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B512F1E0090;
	Thu,  7 Nov 2024 09:30:50 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5118785B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971850; cv=none; b=Vt8ccYJ8FmnTmkZxxZJCOC8dw0gXKc7B3ihKfXS5QzB1sRorfDMheXPqAA9xQpZjy7O1l9FqiO//3Y+8fgly8ahmoFTfyoSRLA7M2iMomXvXDIwMjcAsQynV5ipPfXt7KoVHCIEQspORbFKkJtaFMRb4tWaRaxVAkaSVn57msJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971850; c=relaxed/simple;
	bh=TE/FjZYR/pBtlZmPji9S9Kbk5gMAhad7ZI3OqmvakB8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PWtiyjTw3r+1dOc5Z33+5fh3Yu0j8zGU8LXWvcpt3/rUpqhahJ8OpTNcdfWruJuO1rj0oA4KcgnHNE13u7vvI3js7bdwkCsP7AmeSkfMkbvaKcuP1ST/c0rYCzSsFB2JyGMxZU37B+Z5DZB/er9cMubs115lJ1vF+suTt78MUYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XkcG55QMNz1SDql;
	Thu,  7 Nov 2024 17:29:01 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 93DC61401F4;
	Thu,  7 Nov 2024 17:30:44 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 17:30:43 +0800
Message-ID: <673991ef-90d0-456f-ae75-8d70bff3ea4d@huawei.com>
Date: Thu, 7 Nov 2024 17:30:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>, <xrivendell7@gmail.com>,
	<wang1315768607@163.com>, <fleischermarius@gmail.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling when fork() fails in
 copy_page_range()
To: <david@redhat.com>, <peterx@redhat.com>
References: <20241029210331.1339581-1-david@redhat.com> <ZyKl_cRRUmZGbp9G@x1n>
 <8c494db6-1def-44ea-84ef-51d0140bddf3@redhat.com>
 <7e860861-c7cb-401f-ac92-61db92fa4d8b@huawei.com>
 <262aa19c-59fe-420a-aeae-0b1866a3e36b@redhat.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <262aa19c-59fe-420a-aeae-0b1866a3e36b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2024/11/7 17:08, David Hildenbrand wrote:
> On 07.11.24 09:43, mawupeng wrote:
>>
>>
>> On 2024/10/31 17:47, David Hildenbrand wrote:
>>> On 30.10.24 22:32, Peter Xu wrote:
>>>> On Tue, Oct 29, 2024 at 10:03:31PM +0100, David Hildenbrand wrote:
>>>>> If track_pfn_copy() fails, we already added the dst VMA to the maple
>>>>> tree. As fork() fails, we'll cleanup the maple tree, and stumble over
>>>>> the dst VMA for which we neither performed any reservation nor copied
>>>>> any page tables.
>>>>>
>>>>> Consequently untrack_pfn() will see VM_PAT and try obtaining the
>>>>> PAT information from the page table -- which fails because the page
>>>>> table was not copied.
>>>>>
>>>>> The easiest fix would be to simply clear the VM_PAT flag of the dst VMA
>>>>> if track_pfn_copy() fails. However, the whole thing is about "simply"
>>>>> clearing the VM_PAT flag is shaky as well: if we passed track_pfn_copy()
>>>>> and performed a reservation, but copying the page tables fails, we'll
>>>>> simply clear the VM_PAT flag, not properly undoing the reservation ...
>>>>> which is also wrong.
>>>>
>>>> David,
>>>>
>>>
>>> Hi Peter,
>>>
>>>> Sorry to not have chance yet reply to your other email..
>>>>
>>>> The only concern I have with the current fix to fork() is.. we started to
>>>> have device drivers providing fault() on PFNMAPs as vfio-pci does, then I
>>>> think it means we could potentially start to hit the same issue even
>>>> without fork(), but as long as the 1st pgtable entry of the PFNMAP range is
>>>> not mapped when the process with VM_PAT vma exit()s, or munmap() the vma.
>>>
>>> As these drivers are not using remap_pfn_range, there is no way they could currently get VM_PAT set.
>>>
>>> So what you describe is independent of the current state we are fixing here, and this fix should sort out the issues with current VM_PAT handling.
>>>
>>> It indeed is an interesting question how to handle reservations when *not* using remap_pfn_range() to cover the whole area.
>>>
>>> remap_pfn_range() handles VM_PAT automatically because it can do it: it knows that the whole range will map consecutive PFNs with the same protection, and we expect not parts of the range suddenly getting unmapped (and any driver that does that is buggy).
>>>
>>> This behavior is, however, not guaranteed to be the case when remap_pfn_range() is *not* called on the whole range.
>>>
>>> For that case (i.e., vfio-pci) I still wonder if the driver shouldn't do the reservation and leave VM_PAT alone.
>>>
>>> In the driver, we'd do the reservation once and not worry about fork() etc ... and we'd undo the reservation once the last relevant VM_PFNMAP VMA is gone or the driver let's go of the device. I assume there are already mechanisms in place to deal with that to some degree, because the driver cannot go away while any VMA still has the VM_PFNMAP mapping -- otherwise something would be seriously messed up.
>>>
>>> Long story short: let's look into not using VM_PAT for that use case.
>>>
>>> Looking at the VM_PAT issues we had over time, not making it more complicated sounds like a very reasonable thing to me :)
>>
>> Hi David,
>>
>> The VM_PAT reservation do seems complicated. It can trigger the same warning in get_pat_info if remap_p4d_range fails:
>>
>> remap_pfn_range
>>    remap_pfn_range_notrack
>>      remap_pfn_range_internal
>>        remap_p4d_range    // page allocation can failed here
>>      zap_page_range_single
>>        unmap_single_vma
>>          untrack_pfn
>>            get_pat_info
>>              WARN_ON_ONCE(1);
>>
>> Any idea on this problem?
> 
> In remap_pfn_range(), if remap_pfn_range_notrack() fails, we call untrack_pfn(), to undo the tracking.
> 
> The problem is that zap_page_range_single() shouldn't do that untrack_pfn() call.
> 
> That should be fixed by Peter's patch:
> 
> https://lore.kernel.org/all/20240712144244.3090089-1-peterx@redhat.com/T/#u

Thank you for your prompt reply.

This do fix this issue.

> 


