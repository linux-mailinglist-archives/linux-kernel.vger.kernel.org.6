Return-Path: <linux-kernel+bounces-258405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824D293878E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31C81F20FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 02:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7CCFC0B;
	Mon, 22 Jul 2024 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iu/3mm69"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C7611E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721616102; cv=none; b=btKectyOpdSsO8upyUZufoaai9G9wzFbpoUbvhqyUbmpG/tnG8l2ngBP5P+OKHFpyIAcNiJP8j8UBz9RimaFBsn+3sb2D9N1iBMleFp8T+hH7avRdPWQDNUNbqvDfSM6Ul72/9SuL5gXfEF8DoPtDBzOG0SzTGlIXp2nhKNbh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721616102; c=relaxed/simple;
	bh=8p1VQJI+7jJHGUbO67r/i1Fs9cPM0O2WEgZJlu2gQQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IR+u0jlTj/2Tivj4w2r19nFnEkwYVrdFLQlRW3aR0fy/a0yrNtp8ViVo43l7/8W4pfAPyxogSXIz3f/YXGi7pRODXbyz5hgq+K2stE/2+RUv70oj1Vfd5/YuoDkTYuHnVmwQhuguNlyKydVHdajsVtIk29X+GI/FgdG2oHmBfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iu/3mm69; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721616089; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MDu4lboHE5IBLMlTXv0+WLMrtUvTsp5YiapPNShBuAk=;
	b=iu/3mm69Pn7dpusP28nHIR6PD4KaD7dUYvbX5o2oahf26Y3rLFHdn6uG1PEL+cC4gLOMUUW4lQKq7AxLJfu6dSThuCSvGk03W0GV1uS36d2AfdIA/U+5ZZCcmsOiYGy83Nup6JWZ/S9yXMysV+yeourrHUH32S+nX/D8uA8A4oQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WAyFM2g_1721616075;
Received: from 30.97.56.74(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAyFM2g_1721616075)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 10:41:28 +0800
Message-ID: <f206ad30-a007-499e-941c-1c4abc0c5eb3@linux.alibaba.com>
Date: Mon, 22 Jul 2024 10:41:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm: shmem: move shmem_huge_global_enabled() into
 shmem_allowable_huge_orders()
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, 21cnbao@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
 <16dad33282617ecb90a3f466b35273b10be68d21.1720755678.git.baolin.wang@linux.alibaba.com>
 <b670b981-bc79-4c8c-8b69-4879300066d4@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <b670b981-bc79-4c8c-8b69-4879300066d4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(Sorry for the late reply due to my vacation.)

On 2024/7/15 21:36, Ryan Roberts wrote:
> On 13/07/2024 14:24, Baolin Wang wrote:
>> Move shmem_huge_global_enabled() into the shmem_allowable_huge_orders() function,
>> so that shmem_allowable_huge_orders() can also help to find the allowable huge
>> orders for tmpfs. Moreover the shmem_huge_global_enabled() can become static.
>>
>> No functional changes.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> one nit below, but either way:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> 
>> ---
>>   include/linux/shmem_fs.h | 12 ++----------
>>   mm/huge_memory.c         | 12 +++---------
>>   mm/shmem.c               | 41 ++++++++++++++++++++++++++--------------
>>   3 files changed, 32 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
>> index 405ee8d3589a..1564d7d3ca61 100644
>> --- a/include/linux/shmem_fs.h
>> +++ b/include/linux/shmem_fs.h
>> @@ -111,21 +111,13 @@ extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
>>   int shmem_unuse(unsigned int type);
>>   
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -extern bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index, bool shmem_huge_force,
>> -				      struct mm_struct *mm, unsigned long vm_flags);
>>   unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   				struct vm_area_struct *vma, pgoff_t index,
>> -				bool global_huge);
>> +				bool shmem_huge_force);
>>   #else
>> -static __always_inline bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>> -						      bool shmem_huge_force, struct mm_struct *mm,
>> -						      unsigned long vm_flags)
>> -{
>> -	return false;
>> -}
>>   static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   				struct vm_area_struct *vma, pgoff_t index,
>> -				bool global_huge)
>> +				bool shmem_huge_force)
>>   {
>>   	return 0;
>>   }
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index cc9bad12be75..f69980b5b5fc 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -151,16 +151,10 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>   	 * Must be done before hugepage flags check since shmem has its
>>   	 * own flags.
>>   	 */
>> -	if (!in_pf && shmem_file(vma->vm_file)) {
>> -		bool global_huge = shmem_huge_global_enabled(file_inode(vma->vm_file),
>> -							     vma->vm_pgoff, !enforce_sysfs,
>> -							     vma->vm_mm, vm_flags);
>> -
>> -		if (!vma_is_anon_shmem(vma))
>> -			return global_huge ? orders : 0;
>> +	if (!in_pf && shmem_file(vma->vm_file))
>>   		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
>> -							vma, vma->vm_pgoff, global_huge);
>> -	}
>> +						   vma, vma->vm_pgoff,
>> +						   !enforce_sysfs);
>>   
>>   	if (!vma_is_anonymous(vma)) {
>>   		/*
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 1445dcd39b6f..4d274f5a17d9 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -581,7 +581,7 @@ static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>>   	}
>>   }
>>   
>> -bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>> +static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>>   		   bool shmem_huge_force, struct mm_struct *mm,
>>   		   unsigned long vm_flags)
>>   {
>> @@ -772,6 +772,13 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>>   {
>>   	return 0;
>>   }
>> +
>> +static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>> +		bool shmem_huge_force, struct mm_struct *mm,
>> +		unsigned long vm_flags)
>> +{
>> +	return false;
>> +}
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>   
>>   /*
>> @@ -1625,27 +1632,39 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   				struct vm_area_struct *vma, pgoff_t index,
>> -				bool global_huge)
>> +				bool shmem_huge_force)
>>   {
>>   	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
>>   	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
>> -	unsigned long vm_flags = vma->vm_flags;
>> +	unsigned long vm_flags = vma ? vma->vm_flags : 0;
>> +	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
> 
> nit: rather than deriving the fault_mm here, I wonder if its cleaner to just
> pass vma to shmem_huge_global_enabled()? shmem_huge_global_enabled() is just
> using it as a guard to access vm_flags, which you can just as easily do by
> testing the vma for non-NULL. And you can access mm flags with vma->vm_mm->flags
> after testing the vma too.

Make sense to me, and will do in next version.

Thanks for reviewing.

