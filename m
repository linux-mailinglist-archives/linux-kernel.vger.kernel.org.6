Return-Path: <linux-kernel+bounces-241947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F09281A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F91B2838AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115814375D;
	Fri,  5 Jul 2024 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I+C+35P3"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAAF1C6A0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159369; cv=none; b=WNBhCZhoz0FVi2iXY+eGEmZd/bCd5WxKvTsobkcpwh+CpIavY10e02pxP8UtJqWrFGyNZRSFbuDIUWi0HMRPQEBv+Zh95LLhAo2tKA+MNE7c4G/7L1OZryyuiyFvPrMa8HjBmocPnJ3aZMQ7YLh9+TmJRVujYyR1EitQAG6BRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159369; c=relaxed/simple;
	bh=hkJl98EoDT03A3Kwqz/YdDle0+Uy2XmHYz7diK/3Fu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gotyHHSYra/7KikRw9ShekM125TEXIUpno7vxZI5Qwb5Zj+VSRLy+UzHoQYqlH+Mnblou1KgJg5yBurUusMxwjO2/6FkXNHVXsAy8tZqujqyvxQF3hANUOCnLOCFQEWq1VIntw8/suzmWefAAuTmIKW+inPeiQQMxMj1eVic5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I+C+35P3; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720159358; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l0XBmP+QWTCsjcPW7DyKmrEN7J5UoybSmB6fGTi8/zc=;
	b=I+C+35P3Xy7FNkeOL6Iqksf8nrnT2MtEgvgN8gNeCu86Hkt+4IKbu/tPX35ZX7VKJvL/tb14vRbCmMd0vE3NnMDjN7nGF57ycDbWwxzzyn0kVwgITFlVwZqYFjGVvvz5yHam+shRlmIP4lXWuV+PvSkEur2dciDmAg3oKf2OwMI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W9tspwK_1720159355;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9tspwK_1720159355)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 14:02:36 +0800
Message-ID: <1d795623-8da9-420a-af50-f6308ed5a283@linux.alibaba.com>
Date: Fri, 5 Jul 2024 14:02:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: thp: support "THPeligible" semantics for mTHP with
 anonymous shmem
To: Bang Li <libang.li@antgroup.com>, hughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, ryan.roberts@arm.com, wangkefeng.wang@huawei.com,
 ioworker0@gmail.com, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240705032309.24933-1-libang.li@antgroup.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240705032309.24933-1-libang.li@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/5 11:23, Bang Li wrote:
> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
> anonymous shmem"), we can configure different policies through
> the multi-size THP sysfs interface for anonymous shmem. But
> currently "THPeligible" indicates only whether the mapping is
> eligible for allocating THP-pages as well as the THP is PMD
> mappable or not for anonymous shmem, we need to support semantics
> for mTHP with anonymous shmem similar to those for mTHP with
> anonymous memory.
> 
> Signed-off-by: Bang Li <libang.li@antgroup.com>

So far, it looks good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> Changes since v2 [2]:
>   - Move shmem_allowable_huge_orders() to shmem_fs.h (per Baolin)
>   - clean up these coding style issues (per Ryan)
> 
> Changes since v1 [1]:
>   - Put anonymous shmem mthp related logic into
>     thp_vma_allowable_orders() (per David)
> 
> [1] https://lore.kernel.org/linux-mm/20240628104926.34209-1-libang.li@antgroup.com/
> [2] https://lore.kernel.org/linux-mm/20240702023401.41553-1-libang.li@antgroup.com/
> 
>   include/linux/shmem_fs.h |  9 +++++++++
>   mm/huge_memory.c         | 13 +++++++++----
>   mm/shmem.c               |  9 +--------
>   3 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 3fb18f7eb73e..1d06b1e5408a 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -113,12 +113,21 @@ int shmem_unuse(unsigned int type);
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
>   			  struct mm_struct *mm, unsigned long vm_flags);
> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge);
>   #else
>   static __always_inline bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
>   					  struct mm_struct *mm, unsigned long vm_flags)
>   {
>   	return false;
>   }
> +static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge)
> +{
> +	return 0;
> +}
>   #endif
>   
>   #ifdef CONFIG_SHMEM
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5cbd838e96e6..0985bd75a624 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -151,10 +151,15 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>   	 * Must be done before hugepage flags check since shmem has its
>   	 * own flags.
>   	 */
> -	if (!in_pf && shmem_file(vma->vm_file))
> -		return shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
> -				     !enforce_sysfs, vma->vm_mm, vm_flags)
> -			? orders : 0;
> +	if (!in_pf && shmem_file(vma->vm_file)) {
> +		bool global_huge = shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
> +							!enforce_sysfs, vma->vm_mm, vm_flags);
> +
> +		if (!vma_is_anon_shmem(vma))
> +			return global_huge ? orders : 0;
> +		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
> +							vma, vma->vm_pgoff, global_huge);
> +	}
>   
>   	if (!vma_is_anonymous(vma)) {
>   		/*
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f24177e9d5cc..921d59c3d669 100644
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

