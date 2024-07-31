Return-Path: <linux-kernel+bounces-268940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE49942B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFB71F22936
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A21AB517;
	Wed, 31 Jul 2024 09:59:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869961AB51E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419970; cv=none; b=S/HoAXeY1jDRiBF/rAQ/ZJWFwySU2kOGsCXaXtRiV0Kjn3LBhzAwB9us/eCUz5/ytew+icFxp9mxbkHijtkaqQXQk2ocwntUbkLBFfaXiNHPNBHkVatfsidO1Vij3CD2ahc1VruLsm3sDvwCVoIsfEOY+aD+5uFiInDCTtVwwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419970; c=relaxed/simple;
	bh=FWJwlUuGg9nY+TDcBs8TDD2fLfTFt4QNJUnbUHCZa2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s8IdE9eR4MTBBy0k2ON0QzY1Yy3Q8sXnuvSKS8ynDHJiI1xs+cckSMpNzr9xHV2FhecBp/I7l+ldbzuahNxmdRkCAjRVTOKbfxNd+uwbmav4ISGNRdYgS+wY3JAQ0dZ4h/5rQRdGGY1mo6JQUhAPfSrx5a6ovmnp1VaugJ3oPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYnW565JyzyPGZ;
	Wed, 31 Jul 2024 17:54:25 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AC1A140156;
	Wed, 31 Jul 2024 17:59:24 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 31 Jul 2024 17:59:23 +0800
Message-ID: <87769ae8-b6c6-4454-925d-1864364af9c8@huawei.com>
Date: Wed, 31 Jul 2024 17:59:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than
 MAX_PAGECACHE_ORDER for shmem
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song
	<21cnbao@gmail.com>
CC: <akpm@linux-foundation.org>, <hughd@google.com>, <willy@infradead.org>,
	<david@redhat.com>, <ryan.roberts@arm.com>, <ziy@nvidia.com>,
	<gshan@redhat.com>, <ioworker0@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xmHY06VAKzXxCFcovPkrR0WOR28jXbaeD5VyUBHWzn_w@mail.gmail.com>
 <c55d7ef7-78aa-4ed6-b897-c3e03a3f3ab7@linux.alibaba.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <c55d7ef7-78aa-4ed6-b897-c3e03a3f3ab7@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/7/31 16:56, Baolin Wang wrote:
> 
> 
> On 2024/7/31 14:18, Barry Song wrote:
>> On Wed, Jul 31, 2024 at 1:46 PM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>> Similar to commit d659b715e94ac ("mm/huge_memory: avoid PMD-size page 
>>> cache
>>> if needed"), ARM64 can support 512MB PMD-sized THP when the base page 
>>> size is
>>> 64KB, which is larger than the maximum supported page cache size 
>>> MAX_PAGECACHE_ORDER.
>>> This is not expected. To fix this issue, use 
>>> THP_ORDERS_ALL_FILE_DEFAULT for
>>> shmem to filter allowable huge orders.
>>>
>>> Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> Reviewed-by: Barry Song <baohua@kernel.org>
> 
> Thanks for reviewing.
> 
>>
>>> ---
>>>   mm/shmem.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 2faa9daaf54b..a4332a97558c 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -1630,10 +1630,10 @@ unsigned long 
>>> shmem_allowable_huge_orders(struct inode *inode,
>>>          unsigned long within_size_orders = 
>>> READ_ONCE(huge_shmem_orders_within_size);
>>>          unsigned long vm_flags = vma->vm_flags;
>>>          /*
>>> -        * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
>>> +        * Check all the (large) orders below MAX_PAGECACHE_ORDER + 1 
>>> that
>>>           * are enabled for this vma.
>>
>> Nit:
>> THP_ORDERS_ALL_FILE_DEFAULT should be self-explanatory enough.
>> I feel we don't need this comment?
> 
> Sure.
> 
> Andrew, please help to squash the following changes into this patch. 
> Thanks.

Maybe drop unsigned long orders too?

diff --git a/mm/shmem.c b/mm/shmem.c
index 6af95f595d6f..8485eb6f2ec4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1638,11 +1638,6 @@ unsigned long shmem_allowable_huge_orders(struct 
inode *inode,
         unsigned long mask = READ_ONCE(huge_shmem_orders_always);
         unsigned long within_size_orders = 
READ_ONCE(huge_shmem_orders_within_size);
         unsigned long vm_flags = vma ? vma->vm_flags : 0;
-       /*
-        * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
-        * are enabled for this vma.
-        */
-       unsigned long orders = BIT(PMD_ORDER + 1) - 1;
         bool global_huge;
         loff_t i_size;
         int order;
@@ -1698,7 +1693,7 @@ unsigned long shmem_allowable_huge_orders(struct 
inode *inode,
         if (global_huge)
                 mask |= READ_ONCE(huge_shmem_orders_inherit);

-       return orders & mask;
+       return THP_ORDERS_ALL_FILE_DEFAULT & mask;
  }

> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 6e9836b1bd1d..432faec21547 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1629,10 +1629,6 @@ unsigned long shmem_allowable_huge_orders(struct 
> inode *inode,
>          unsigned long mask = READ_ONCE(huge_shmem_orders_always);
>          unsigned long within_size_orders = 
> READ_ONCE(huge_shmem_orders_within_size);
>          unsigned long vm_flags = vma->vm_flags;
> -       /*
> -        * Check all the (large) orders below MAX_PAGECACHE_ORDER + 1 that
> -        * are enabled for this vma.
> -        */
>          unsigned long orders = THP_ORDERS_ALL_FILE_DEFAULT;
>          loff_t i_size;
>          int order;
> 

