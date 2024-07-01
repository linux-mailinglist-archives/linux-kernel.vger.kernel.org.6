Return-Path: <linux-kernel+bounces-235804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5D091D9E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024C31F211C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC28249A;
	Mon,  1 Jul 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="B7k/XCZv"
Received: from out0-209.mail.aliyun.com (out0-209.mail.aliyun.com [140.205.0.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123C1804A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822277; cv=none; b=LlcU5EiwPZc9ozbX9qnrjfJ6FEDpJZDgIN12jyhsKbguU8htt5d2la74Ry74vQzmnWzO1iu6lYPlZNn6gopq82nCmGZw48MYwvEplN+9CPafTSUn9mGxfuSw0nn8tCHh8n38o7/zA7TSFCuLSiGj7VGMOTe5KTyOHhhXqcsY58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822277; c=relaxed/simple;
	bh=h/ysissWJ3fdVPDH35GDl3waQLbtD2L181Ml+HYur60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwrLwm0iBL/Ea79+5HVDuddebAhT5BDWbE6lajq9k9SsP+34lf/temEzossamktnON+vuVPg2bYi2NcMLJroHwzqjOYQHI9Uec+hpn+RZX4JqLoE6s5VcgnO5xcNwrdZsTpLyzaUQesp/FUE3WqiIzk//9Bv1NXq6SGuE/eSYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=B7k/XCZv; arc=none smtp.client-ip=140.205.0.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719822264; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DDMQAn41L6SWm47GL1Pl/XtVoTBg9GDb/pxF+UO/8oc=;
	b=B7k/XCZv2Bgko6+2duBPdHDW+DhG805cKcdlmTrzOm8TIvrnSvRLRGLyKE/KHsTki7VzD7mhGOik07Rmy87us/J118cKfTGe0yGkQbAcbtTtTONBtvpHXa7DoZbzOOT6/B45g7M6Syniqebj50oy2EC7GpnMOI5/MwNrVzxpWRY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068194251;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---.YE7WgG6_1719822263;
Received: from 30.13.185.168(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YE7WgG6_1719822263)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 16:24:24 +0800
Message-ID: <21c698a4-f6b5-4afd-9f6c-72de08adad10@antgroup.com>
Date: Mon, 01 Jul 2024 16:24:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
To: David Hildenbrand <david@redhat.com>, hughd@google.com,
 akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <1bf214bb-86a7-4f73-a839-39a4b37bc04a@redhat.com>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <1bf214bb-86a7-4f73-a839-39a4b37bc04a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

Thanks for you review!

On 2024/7/1 14:57, David Hildenbrand wrote:
> On 28.06.24 12:49, Bang Li wrote:
>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>> anonymous shmem"), we can configure different policies through
>> the multi-size THP sysfs interface for anonymous shmem. But
>> currently "THPeligible" indicates only whether the mapping is
>> eligible for allocating THP-pages as well as the THP is PMD
>> mappable or not for anonymous shmem, we need to support semantics
>> for mTHP with anonymous shmem similar to those for mTHP with
>> anonymous memory.
>>
>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>> ---
>>   fs/proc/task_mmu.c      | 10 +++++++---
>>   include/linux/huge_mm.h | 11 +++++++++++
>>   mm/shmem.c              |  9 +--------
>>   3 files changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 93fb2c61b154..09b5db356886 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>>   {
>>       struct vm_area_struct *vma = v;
>>       struct mem_size_stats mss = {};
>> +    bool thp_eligible;
>>       smap_gather_stats(vma, &mss, 0);
>> @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void *v)
>>       __show_smap(m, &mss, false);
>> -    seq_printf(m, "THPeligible:    %8u\n",
>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
>> +    thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL);
>> +    if (vma_is_anon_shmem(vma))
>> +        thp_eligible = 
>> !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
>> +                            vma, vma->vm_pgoff, thp_eligible);
> 
> I would have thought the correct fix is to return the correct result 
> from thp_vma_allowable_orders().
> 

Agreed. I'll try to reimplement this in thp_vma_allowable_orders().

Thanks again for the review!
Bang

