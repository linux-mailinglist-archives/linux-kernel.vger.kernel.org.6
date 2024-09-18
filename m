Return-Path: <linux-kernel+bounces-332323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5897B851
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEAE1C20CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBCE149C6D;
	Wed, 18 Sep 2024 07:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y+T8v8k8"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776A139CF2
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726642989; cv=none; b=DKgBl8ouS8u8VDrIU1fHyp/+TgvzYmqoRshjAGi10+JCzVeEm/E+4sXu42cG6zRBR5XoDB6K+M+8OCg251Lr7VvtzdryJQQctfnhxJCBUOfXws6+Exeedb/NiiWdc93oVUf0Bw+jNJXF0CG3TZ1/SFEjyoFPupVr/v4vB54D0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726642989; c=relaxed/simple;
	bh=rgZvjUhIaTCQHeThIhVothHV4tE4ll507y7we9PbrDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izsH1Y5FwwnnT7LUKEnMIR/cKbGEd0zQumvK84pRSS5AY40gHYBtihdKRlX86u1aJDExUtZ15+71jULCdLIXpmFGm324YmiJ3OBe31l5G+9WdG9hUn+DvtErQY/VwPBl4kv40/UEvm2wbIkkeAPQLeVQqWhMxRoFjzJ4rQc/8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y+T8v8k8; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726642984; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+koPlgFoOfcmbQ3ZvwHQOZUll9hUzIHFs1lrXFkXoTY=;
	b=Y+T8v8k8MAqXcG3+Hl5oyH7JMwilQKzntGyfOxOyUhQf2fkTSYwuSYVwBYy1J4fjVuf1mwXf6Soj6xlT5kt5dTsP1UduQJtq6pb3eGnZkfpKuQ27PPRsoQ5yVgc8HnLxdDolRmM55oAwzxXM8SnblNxB53GhtDmYZVEi+4De5Mc=
Received: from 30.74.144.133(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFD8cZj_1726642981)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 15:03:02 +0800
Message-ID: <3f15a44d-cf49-41f4-892b-cb3202603652@linux.alibaba.com>
Date: Wed, 18 Sep 2024 15:03:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: Make pte_range_none() return number of empty
 PTEs
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, baohua@kernel.org,
 hughd@google.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 gshan@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240916110754.1236200-1-dev.jain@arm.com>
 <20240916110754.1236200-2-dev.jain@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240916110754.1236200-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/16 19:07, Dev Jain wrote:
> In preparation for the second patch, make pte_range_none() return
> the number of contiguous empty PTEs.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/memory.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 6469ac99f2f7..8bb1236de93c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4617,16 +4617,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	return ret;
>   }
>   
> -static bool pte_range_none(pte_t *pte, int nr_pages)
> +static int pte_range_none(pte_t *pte, int nr_pages)
>   {
>   	int i;
>   
>   	for (i = 0; i < nr_pages; i++) {
>   		if (!pte_none(ptep_get_lockless(pte + i)))
> -			return false;
> +			return i;
>   	}
>   
> -	return true;
> +	return nr_pages;
>   }
>   
>   static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> @@ -4671,7 +4671,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>   	order = highest_order(orders);
>   	while (orders) {
>   		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -		if (pte_range_none(pte + pte_index(addr), 1 << order))
> +		if (pte_range_none(pte + pte_index(addr), 1 << order) == 1 << order)
>   			break;
>   		order = next_order(&orders, order);
>   	}
> @@ -4787,7 +4787,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   	if (nr_pages == 1 && vmf_pte_changed(vmf)) {
>   		update_mmu_tlb(vma, addr, vmf->pte);
>   		goto release;
> -	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> +	} else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) != nr_pages) {
>   		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>   		goto release;
>   	}
> @@ -5121,7 +5121,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   		update_mmu_tlb(vma, addr, vmf->pte);
>   		ret = VM_FAULT_NOPAGE;
>   		goto unlock;
> -	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> +	} else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) != nr_pages) {
>   		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>   		ret = VM_FAULT_NOPAGE;
>   		goto unlock;

