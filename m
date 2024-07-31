Return-Path: <linux-kernel+bounces-268978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558AE942BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6111C214ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECED1AAE3D;
	Wed, 31 Jul 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RzeoUsJ4"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759601A7F9B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421350; cv=none; b=Xg2DSdg3b2Al9ePvHq3me4Nzz3q6IZ9ZnRA4lMumdd8wXcjCUVIBXB9tU/f8fD18rKVjLsuJ8oyppVu9zSXCOrS3zs6xvXgfPg6zOtbSxG/Zx6wjWrgeDmg280y8y/cAYnYqotCUGSTMFFm18OonORHfA8KEocy8aPHe5gY9IOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421350; c=relaxed/simple;
	bh=Q9ociHUAqKywTUlfHPzQF1LeNBZNAYh/Lbh0l/ZXFNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6TI3OfGhSIvtx7eTvfndaBzbnHahvmv/Ey1qvGKr4uq3RTZ5vh0Em3Ijv37jAOn5rnAjWmoYioBR0jeJhcah7C4e8ufTyPlKF0ZB4wgHEkLYo4BjZxEAy0mO0J9gp9OCmjxb245kxg2i05KcFWNETbWcADG6nSPX9P8czq+itg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RzeoUsJ4; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722421339; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9h+g/1oD2W/YdX4QEHKvjvVLn4FL9lC4w/DaudYh6/w=;
	b=RzeoUsJ4ivRrSD366DH9mmPDvuHKPaQQxDe/7Fa+wYs+5FYU2i69zpLhl7jjrAz31R2yA8sfEUpwI9IOYmbn84QLG8fRBCMWFbQZTioWlnmjFUkbgv88lsTJE2TPqkPhc41PBMRMgAkcDVjzNpyjWIms31SavnxsznfvST7uKP4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WBj2509_1722421337;
Received: from 30.97.56.76(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBj2509_1722421337)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 18:22:18 +0800
Message-ID: <ba3e3dfa-d019-4991-9e3a-d73ffa83bb36@linux.alibaba.com>
Date: Wed, 31 Jul 2024 18:22:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than
 MAX_PAGECACHE_ORDER for shmem
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com, gshan@redhat.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xmHY06VAKzXxCFcovPkrR0WOR28jXbaeD5VyUBHWzn_w@mail.gmail.com>
 <c55d7ef7-78aa-4ed6-b897-c3e03a3f3ab7@linux.alibaba.com>
 <87769ae8-b6c6-4454-925d-1864364af9c8@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87769ae8-b6c6-4454-925d-1864364af9c8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/31 17:59, Kefeng Wang wrote:
> 
> 
> On 2024/7/31 16:56, Baolin Wang wrote:
>>
>>
>> On 2024/7/31 14:18, Barry Song wrote:
>>> On Wed, Jul 31, 2024 at 1:46 PM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>> Similar to commit d659b715e94ac ("mm/huge_memory: avoid PMD-size 
>>>> page cache
>>>> if needed"), ARM64 can support 512MB PMD-sized THP when the base 
>>>> page size is
>>>> 64KB, which is larger than the maximum supported page cache size 
>>>> MAX_PAGECACHE_ORDER.
>>>> This is not expected. To fix this issue, use 
>>>> THP_ORDERS_ALL_FILE_DEFAULT for
>>>> shmem to filter allowable huge orders.
>>>>
>>>> Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>
>>> Reviewed-by: Barry Song <baohua@kernel.org>
>>
>> Thanks for reviewing.
>>
>>>
>>>> ---
>>>>   mm/shmem.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index 2faa9daaf54b..a4332a97558c 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -1630,10 +1630,10 @@ unsigned long 
>>>> shmem_allowable_huge_orders(struct inode *inode,
>>>>          unsigned long within_size_orders = 
>>>> READ_ONCE(huge_shmem_orders_within_size);
>>>>          unsigned long vm_flags = vma->vm_flags;
>>>>          /*
>>>> -        * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
>>>> +        * Check all the (large) orders below MAX_PAGECACHE_ORDER + 
>>>> 1 that
>>>>           * are enabled for this vma.
>>>
>>> Nit:
>>> THP_ORDERS_ALL_FILE_DEFAULT should be self-explanatory enough.
>>> I feel we don't need this comment?
>>
>> Sure.
>>
>> Andrew, please help to squash the following changes into this patch. 
>> Thanks.
> 
> Maybe drop unsigned long orders too?
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 6af95f595d6f..8485eb6f2ec4 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1638,11 +1638,6 @@ unsigned long shmem_allowable_huge_orders(struct 
> inode *inode,
>          unsigned long mask = READ_ONCE(huge_shmem_orders_always);
>          unsigned long within_size_orders = 
> READ_ONCE(huge_shmem_orders_within_size);
>          unsigned long vm_flags = vma ? vma->vm_flags : 0;
> -       /*
> -        * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
> -        * are enabled for this vma.
> -        */
> -       unsigned long orders = BIT(PMD_ORDER + 1) - 1;
>          bool global_huge;
>          loff_t i_size;
>          int order;
> @@ -1698,7 +1693,7 @@ unsigned long shmem_allowable_huge_orders(struct 
> inode *inode,
>          if (global_huge)
>                  mask |= READ_ONCE(huge_shmem_orders_inherit);
> 
> -       return orders & mask;
> +       return THP_ORDERS_ALL_FILE_DEFAULT & mask;
>   }

Yes. Good point. Thanks.
(Hope Andrew can help to squash these changes :))

