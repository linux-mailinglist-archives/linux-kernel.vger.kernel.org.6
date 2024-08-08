Return-Path: <linux-kernel+bounces-278780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE2794B4C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE77B283C0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538B58F40;
	Thu,  8 Aug 2024 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B8Nvs/uJ"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC07464
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723082184; cv=none; b=fph5Rg4P9ZH1VwYoFumC/dWaJukq7VFjwvoAIveuiKKrt4sqPSuxZRoZPfE02vIAqveHAMOK/RE9CCRvQ5CQ3QhDW8wkQLIZzEbbfdwQRN13cdj8OBUeqzMAjpGgJozHdNL4g/iDuwT7RSPLFUi9F+KCi+wMMOW9gNNvyrS0FAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723082184; c=relaxed/simple;
	bh=Jl5AE7eWHPNftDuDCdtI+HGv2YpbyomCA0oXwuOoC+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiczdk4A/1aLhI0bcMxO/KXSdm1n2ZlGzQj/YEno17Eg/P6RXQtvfbWhkUojHwurz52T9IvRTLgLYXvHpKrliK4+idpCL+Pa+tTHxUBJAiIJLHgasOontWuoXbLC0SVSK3OOkjB7CMhiLX4quSghYGtU+TWjhpEyHHEEw5U2Jog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B8Nvs/uJ; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723082173; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oecPYL3fL7pp34DrAzQQyS0X+m+ukmlTCik5Pv4T+bM=;
	b=B8Nvs/uJWEFA3LSI+NCRi8D8oX4zPZquriax1u9PdSlNGRuaVQRQBCQWD1Y/iJGF1ZF8PiCCMsVLNoDyYV6/FEmO5/kgH7uO5dKHRtH26o1YRy4FzesaYJL/rgDxb95iPztsbIcNkCAHDtc2hHz1h28V7I+JYGvqPb+J1WPwBN4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WCKWazT_1723082170;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCKWazT_1723082170)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 09:56:11 +0800
Message-ID: <98cb8158-2087-4100-9789-1a45c0c04fc4@linux.alibaba.com>
Date: Thu, 8 Aug 2024 09:56:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] mm: shmem: add large folio support to the write
 and fallocate paths
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "david@redhat.com" <david@redhat.com>, "21cnbao@gmail.com"
 <21cnbao@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "ziy@nvidia.com" <ziy@nvidia.com>, "ioworker0@gmail.com"
 <ioworker0@gmail.com>, Pankaj Raghav <p.raghav@samsung.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1721720891.git.baolin.wang@linux.alibaba.com>
 <CGME20240724070423eucas1p1c2a306d0b44f73476b83ede2bd05e57a@eucas1p1.samsung.com>
 <05a31373ee1aa40a6a85d4897324a400686e2fb1.1721720891.git.baolin.wang@linux.alibaba.com>
 <ur7tze5f7m3gfokrbux4iqlt3opbxaxtnimiqfwj7cvnppnepc@qisd76x2a5jh>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ur7tze5f7m3gfokrbux4iqlt3opbxaxtnimiqfwj7cvnppnepc@qisd76x2a5jh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/5 02:46, Daniel Gomez wrote:
> On Wed, Jul 24, 2024 at 03:03:59PM GMT, Baolin Wang wrote:
>> From: Daniel Gomez <da.gomez@samsung.com>
>>
>> Add large folio support for shmem write and fallocate paths matching the
>> same high order preference mechanism used in the iomap buffered IO path
>> as used in __filemap_get_folio().
>>
>> Add shmem_mapping_size_order() to get a hint for the order of the folio
>> based on the file size which takes care of the mapping requirements.
>>
>> Swap does not support high order folios for now, so make it order-0 in
>> case swap is enabled.
>>
>> If the top level huge page (controlled by '/sys/kernel/mm/transparent_hugepage/shmem_enabled')
>> is enabled, we just allow PMD sized THP to keep interface backward
>> compatibility.
>>
>> Co-developed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/shmem_fs.h |  4 +--
>>   mm/huge_memory.c         |  2 +-
>>   mm/shmem.c               | 57 ++++++++++++++++++++++++++++++++++++----
>>   3 files changed, 55 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
>> index 34beaca2f853..fb0771218f1b 100644
>> --- a/include/linux/shmem_fs.h
>> +++ b/include/linux/shmem_fs.h
>> @@ -113,11 +113,11 @@ int shmem_unuse(unsigned int type);
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   				struct vm_area_struct *vma, pgoff_t index,
>> -				bool shmem_huge_force);
>> +				bool shmem_huge_force, size_t len);
>>   #else
>>   static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   				struct vm_area_struct *vma, pgoff_t index,
>> -				bool shmem_huge_force)
>> +				bool shmem_huge_force, size_t len)
>>   {
>>   	return 0;
>>   }
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index e555fcdd19d4..a8fc3b9e4034 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -162,7 +162,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>   	if (!in_pf && shmem_file(vma->vm_file))
>>   		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>   						   vma, vma->vm_pgoff,
>> -						   !enforce_sysfs);
>> +						   !enforce_sysfs, PAGE_SIZE);
>>   
>>   	if (!vma_is_anonymous(vma)) {
>>   		/*
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 92ed09527682..cc0c1b790267 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1630,10 +1630,47 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>>   	return result;
>>   }
>>   
>> +/**
>> + * shmem_mapping_size_order - Get maximum folio order for the given file size.
>> + * @mapping: Target address_space.
>> + * @index: The page index.
>> + * @size: The suggested size of the folio to create.
>> + *
>> + * This returns a high order for folios (when supported) based on the file size
>> + * which the mapping currently allows at the given index. The index is relevant
>> + * due to alignment considerations the mapping might have. The returned order
>> + * may be less than the size passed.
>> + *
>> + * Like __filemap_get_folio order calculation.
>> + *
>> + * Return: The order.
>> + */
>> +static inline unsigned int
>> +shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
>> +			 size_t size, struct shmem_sb_info *sbinfo)
>> +{
>> +	unsigned int order = ilog2(size);
>> +
>> +	if ((order <= PAGE_SHIFT) ||
>> +	    (!mapping_large_folio_support(mapping) || !sbinfo->noswap))
>> +		return 0;
>> +
>> +	order -= PAGE_SHIFT;
>> +
>> +	/* If we're not aligned, allocate a smaller folio */
>> +	if (index & ((1UL << order) - 1))
>> +		order = __ffs(index);
>> +
>> +	order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
>> +
>> +	/* Order-1 not supported due to THP dependency */
>> +	return (order == 1) ? 0 : order;
>> +}
> 
> I have an updated version of shmem_mapping_size_order() that I didn't posted but
> uses get_order() instead as suggested in [1]:
> 
> [1] https://lore.kernel.org/all/ZT7rd3CSr+VnKj7v@casper.infradead.org/
> 
> /**
>   * shmem_mapping_size_order - Get maximum folio order for the given file size.
>   * @mapping: Target address_space.
>   * @index: The page index.
>   * @size: The suggested size of the folio to create.
>   *
>   * This returns a high order for folios (when supported) based on the file size
>   * which the mapping currently allows at the given index. The index is relevant
>   * due to alignment considerations the mapping might have. The returned order
>   * may be less than the size passed.
>   *
>   * Like __filemap_get_folio order calculation.
>   *
>   * Return: The order.
>   */
> static inline unsigned int
> shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
>                          size_t size)
>   * Return: The order.
>   */
> static inline unsigned int
> shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
>                          size_t size)
> {
>         unsigned int order = get_order(max_t(size_t, size, PAGE_SIZE));
> 
>         if (!mapping_large_folio_support(mapping))
>                 return 0;
> 
>         /* If we're not aligned, allocate a smaller folio */
>         if (index & ((1UL << order) - 1))
>                 order = __ffs(index);
> 
>         return min_t(size_t, order, MAX_PAGECACHE_ORDER);
> }
> 
> order-1 is already supported by commit [2], so I've removed that condition as
> well.
> 
> [2] 8897277acfef7f70fdecc054073bea2542fc7a1b ("mm: support order-1 folios in the
> page cache").

Great. Thanks Daniel.
I will include your new version if there are no obvious objections to 
this patchset.

