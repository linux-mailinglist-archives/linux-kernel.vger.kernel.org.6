Return-Path: <linux-kernel+bounces-448510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8489F4119
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D696A188DD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A0535B9;
	Tue, 17 Dec 2024 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QIIuC9Tl"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261E2595
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403911; cv=none; b=ZkdVphK9Le6YGWHxemj2gTteoNi1l+25hcxOW2LzWTDK/EQCMIuu9yf4m3jS2v3dipjSxWTOhi1YqF1MUMNKzevWh9cNqyY2URAgODX9q2Gv8zkEmzxfz9TsvoPrymnLRa3zLAqfNl+kyDXs/nGygyIJ1qp7ZJjPzLikP02qFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403911; c=relaxed/simple;
	bh=BjPAL3o1bFmpjHLaBlKLVPJ8xsSSHk+xGxAWj7TA5Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mywC97CgenP08FsUpnqrWqTQM8zJU/aHuYy8pyS7pfSggKB+7VuXk5nvN9LYzMKXfOGja6+8uT7Qf7Tyw1NRhGw7dwkr4FyLnBz3r6G1LOdPxGQk9LoSGY25vNqAkaRk/nYXbVOKP+HwRMuQH8pYTLwRfZt/QLZbPt4ZvsFPHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QIIuC9Tl; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734403901; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6+AbRz3z1VSoEC8PXrO9NCuOsYnUk9B7GC5+ubFBSgQ=;
	b=QIIuC9TlRwbR4AnLla+WQS1alLqgXf0m2mmPo9TyUmkp7TVtgkf2dIZc4NpKVefurJhv3jaTEBths7wXNUPKvvBVt36ORDXKK7FD3lasUGAClMspciK6N8ZTyOkFLP2xP7PgFJZs+MEy3e9QWSHB0mwA8YvoEnRXhm6Eh4QXrCE=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WLgxklw_1734403897 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 10:51:39 +0800
Message-ID: <53073c25-a5c4-4292-832d-10e13cd53aa5@linux.alibaba.com>
Date: Tue, 17 Dec 2024 10:51:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/12] khugepaged: Generalize alloc_charge_folio()
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-3-dev.jain@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241216165105.56185-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/17 00:50, Dev Jain wrote:
> Pass order to alloc_charge_folio() and update mTHP statistics.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   include/linux/huge_mm.h |  2 ++
>   mm/huge_memory.c        |  4 ++++
>   mm/khugepaged.c         | 13 +++++++++----
>   3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 93e509b6c00e..8b6d0fed99b3 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -119,6 +119,8 @@ enum mthp_stat_item {
>   	MTHP_STAT_ANON_FAULT_ALLOC,
>   	MTHP_STAT_ANON_FAULT_FALLBACK,
>   	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_ANON_COLLAPSE_ALLOC,
> +	MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED,
>   	MTHP_STAT_ZSWPOUT,
>   	MTHP_STAT_SWPIN,
>   	MTHP_STAT_SWPIN_FALLBACK,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2da5520bfe24..2e582fad4c77 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -615,6 +615,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>   DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(anon_collapse_alloc, MTHP_STAT_ANON_COLLAPSE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(anon_collapse_alloc_failed, MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);
>   DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>   DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>   DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> @@ -636,6 +638,8 @@ static struct attribute *anon_stats_attrs[] = {
>   	&anon_fault_alloc_attr.attr,
>   	&anon_fault_fallback_attr.attr,
>   	&anon_fault_fallback_charge_attr.attr,
> +	&anon_collapse_alloc_attr.attr,
> +	&anon_collapse_alloc_failed_attr.attr,
>   #ifndef CONFIG_SHMEM
>   	&zswpout_attr.attr,
>   	&swpin_attr.attr,
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 95643e6e5f31..02cd424b8e48 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1073,21 +1073,26 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   }
>   
>   static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
> -			      struct collapse_control *cc)
> +			      int order, struct collapse_control *cc)
>   {
>   	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>   		     GFP_TRANSHUGE);
>   	int node = hpage_collapse_find_target_node(cc);
>   	struct folio *folio;
>   
> -	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
> +	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>   	if (!folio) {
>   		*foliop = NULL;
>   		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		if (order != HPAGE_PMD_ORDER)
> +			count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);
>   		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>   	}
>   
>   	count_vm_event(THP_COLLAPSE_ALLOC);
> +	if (order != HPAGE_PMD_ORDER)
> +		count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC);

File collapse will also call alloc_charge_folio() to allocate THP, so 
using term '_ANON_' is not suitable for both anon and file collapse.

