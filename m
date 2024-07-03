Return-Path: <linux-kernel+bounces-239004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF59254B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D20C28A954
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FEE137767;
	Wed,  3 Jul 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="bZMv3fhO"
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6551E4502F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991921; cv=none; b=iNNNl8R2P296v0U04yF6o6fVDrnKC6RxGsWG0gzRrwiAzA+4AWNJKMxh78NwjMAimQtD6VoN50ES/lfd8ksuPz+88YNSw2Fqpj1PEXAEDVsr1D6I7kf1rVO+C/OPcsgbGXPjab43/qei7O9dpAwTQLqtc3hhij7WGW2P71fY6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991921; c=relaxed/simple;
	bh=S63FyCEoP/hh8X9LPoLUHrYKp3JWPHJWSURm+YaQ3BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxXUnb3nXb7AfbRTcgLO7qe4YqVcSXrdQUWz1jkO9OtyiFzBxN5IYg3a+4zn175ELYV1qpSZWQnGAjyGW7y1tVg+ITfnSPNTAIa9nJ/d/VuKfeM5DF0p6K5PpQUfgkLXfkO+3EkM8nKmhVnCdX1fwqOAVZ0upkqk3VaVuXiOCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=bZMv3fhO; arc=none smtp.client-ip=140.205.0.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719991915; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=r1F4Tww59q1R5bRgyxjFQoWwXm2ayMMPEgBvkY/J2bE=;
	b=bZMv3fhOemNRPCAhfdVUB1gKP/SotoicP/xdM7Jdh5vl61mHcmfnQV0DKnxAowSncXUnatvx/RHoKLAKSkp96Zai/bNG5Jq44+Wh22ldnwMwnMVH2MKKEVf78h9hFqojAWFAX6CWlBfhD0sLEwue+cKgYAiZ7PtvzLmHqBcqk9U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068221070;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.YGDw6A8_1719991913;
Received: from 30.230.88.238(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YGDw6A8_1719991913)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 15:31:54 +0800
Message-ID: <c0cbe1c6-1009-4dba-acd1-5b8a1bb1141c@antgroup.com>
Date: Wed, 03 Jul 2024 15:31:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: thp: support "THPeligible" semantics for mTHP with
 anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>, ughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, ryan.roberts@arm.com, wangkefeng.wang@huawei.com,
 ioworker0@gmail.com, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240702023401.41553-1-libang.li@antgroup.com>
 <6f383c8c-b125-4374-bf21-67b6cc3edcbe@linux.alibaba.com>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <6f383c8c-b125-4374-bf21-67b6cc3edcbe@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baolin,

On 2024/7/2 14:14, Baolin Wang wrote:
> 
> 
> On 2024/7/2 10:34, Bang Li wrote:
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
>> Changes since v1 [1]:
>>   - Put anonymous shmem mthp related logic into
>>     thp_vma_allowable_orders() (per David)
>>
>> [1] 
>> https://lore.kernel.org/linux-mm/20240628104926.34209-1-libang.li@antgroup.com/
>> ---
>>   include/linux/huge_mm.h | 11 +++++++++++
>>   mm/huge_memory.c        | 13 +++++++++----
>>   mm/shmem.c              |  9 +--------
>>   3 files changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 212cca384d7e..f87136f38aa1 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -267,6 +267,10 @@ unsigned long thp_vma_allowable_orders(struct 
>> vm_area_struct *vma,
>>       return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, 
>> orders);
>>   }
>> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>> +                struct vm_area_struct *vma, pgoff_t index,
>> +                bool global_huge);
>> +
>>   struct thpsize {
>>       struct kobject kobj;
>>       struct list_head node;
>> @@ -460,6 +464,13 @@ static inline unsigned long 
>> thp_vma_allowable_orders(struct vm_area_struct *vma,
>>       return 0;
>>   }
>> +static inline unsigned long shmem_allowable_huge_orders(struct inode 
>> *inode,
>> +                struct vm_area_struct *vma, pgoff_t index,
>> +                bool global_huge)
>> +{
>> +    return 0;
>> +}
> 
> This function should be placed in the ‘shmem_fs.h’ header file, just 
> like shmem_is_huge().

Looks more reasonable，thank you for your review.

Thanks,
Bang

