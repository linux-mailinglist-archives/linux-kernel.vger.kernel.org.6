Return-Path: <linux-kernel+bounces-235674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947BE91D838
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0F9B22DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92384A9B0;
	Mon,  1 Jul 2024 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AkbzC9wa"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449B63B9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816478; cv=none; b=pPc2xMi/Z9fS2hte9K6hYU26weB/6tiT64bX6txoAcfMcJs0oicEt5xDZReyBJHSyem+4iL9NqzVgVz1EyGAIlmSdriP1XECSypQyFczayth3npNvMZMt1yADvkzl+f8rA5pErineaRPoe/y3hxZLS4ldHzGkXzo7dZf3GJs2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816478; c=relaxed/simple;
	bh=s+xqfLRT4KlqC1jZjJVzpERQH1RNC7MMyhfmyaAEhjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFx4p6AVYLe5z3LJ54Bo8BDyJSXDl+jZitjEa/0L5nx8gKMdp3xrUMQCBsFUg0gGgYdxWHY15wfjsaPIbh1rT9luJwzCKlNjJt4Oo99UngFmYx4Nps40NQqqAvKAAv4kTrkfKy9XM6Kbz1M34CeMjJkprw/PGAE5LPORIDhbMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AkbzC9wa; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719816468; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Tv+yLIfmdzLl29R0nyvxyY3onm0/k7/t4uet1fUaQvM=;
	b=AkbzC9waBjAn115FZcpaRxnrhES2S9YwQN6HtgCdYgZCBNR2LF1LIE/iJp2lxmZVGjfJMa/1fRV4nV71GpAX1M9tVCnzvo5WQRzS4MaoQ2z7MkUeQN+PIuw+yY5x3wdcsRfPLSzHTFSQMvItFoUgQolb8kJxhx+ec3DWYvO3sLo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W9avhwJ_1719816466;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9avhwJ_1719816466)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 14:47:47 +0800
Message-ID: <b2e6fac2-7c23-4a92-8d89-ff29b8566967@linux.alibaba.com>
Date: Mon, 1 Jul 2024 14:47:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
To: Bang Li <libang.li@antgroup.com>, hughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, ryan.roberts@arm.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <21cnbao@gmail.com>
References: <20240628104926.34209-1-libang.li@antgroup.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240628104926.34209-1-libang.li@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

CC Barry.

On 2024/6/28 18:49, Bang Li wrote:
> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
> anonymous shmem"), we can configure different policies through
> the multi-size THP sysfs interface for anonymous shmem. But
> currently "THPeligible" indicates only whether the mapping is
> eligible for allocating THP-pages as well as the THP is PMD
> mappable or not for anonymous shmem, we need to support semantics
> for mTHP with anonymous shmem similar to those for mTHP with
> anonymous memory.

I did not see a consensus that "THP*" related statistics should contain 
mTHP in previous discussion [1].

In addition, if we all agree that "THPeligible" should include mTHP 
statistics, you should update the corresponding documentation to keep 
consistency.

[1] 
https://lore.kernel.org/linux-mm/202406262300.iAURISyJ-lkp@intel.com/T/#md7a77056110cebcc2a9b3cd7e4a8d682667f6ba5

> Signed-off-by: Bang Li <libang.li@antgroup.com>
> ---
>   fs/proc/task_mmu.c      | 10 +++++++---
>   include/linux/huge_mm.h | 11 +++++++++++
>   mm/shmem.c              |  9 +--------
>   3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 93fb2c61b154..09b5db356886 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>   {
>   	struct vm_area_struct *vma = v;
>   	struct mem_size_stats mss = {};
> +	bool thp_eligible;
>   
>   	smap_gather_stats(vma, &mss, 0);
>   
> @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void *v)
>   
>   	__show_smap(m, &mss, false);
>   
> -	seq_printf(m, "THPeligible:    %8u\n",
> -		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
> -			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
> +	thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
> +						TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL);
> +	if (vma_is_anon_shmem(vma))
> +		thp_eligible = !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
> +							vma, vma->vm_pgoff, thp_eligible);
> +	seq_printf(m, "THPeligible:    %8u\n", thp_eligible);
>   
>   	if (arch_pkeys_enabled())
>   		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 212cca384d7e..f87136f38aa1 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -267,6 +267,10 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>   	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>   }
>   
> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge);
> +
>   struct thpsize {
>   	struct kobject kobj;
>   	struct list_head node;
> @@ -460,6 +464,13 @@ static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>   	return 0;
>   }
>   
> +static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge)
> +{
> +	return 0;
> +}
> +
>   #define transparent_hugepage_flags 0UL
>   
>   #define thp_get_unmapped_area	NULL
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d495c0701a83..aa85df9c662a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1622,7 +1622,7 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>   }
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>   				struct vm_area_struct *vma, pgoff_t index,
>   				bool global_huge)
>   {
> @@ -1707,13 +1707,6 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
>   	return orders;
>   }
>   #else
> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
> -				struct vm_area_struct *vma, pgoff_t index,
> -				bool global_huge)
> -{
> -	return 0;
> -}
> -
>   static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
>   					   struct address_space *mapping, pgoff_t index,
>   					   unsigned long orders)

