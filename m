Return-Path: <linux-kernel+bounces-223838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648BA911912
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0180283640
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D086AE3;
	Fri, 21 Jun 2024 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VoW4T/Wm"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047C29A5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718941158; cv=none; b=ht8iUMQbshPvVcAAvyxlifTb40+t7pQjgxJovs7xfjWm0WrS7JKZgfRpCiVhwoLKf4cXSmWOHzOpgnrR3kjTMyrJkRQDMBVXef8g7YOCEP3R9+BwMLVZzWV0vG1+J5kGfIdxAzd7AhuK76mJ3AW4yqrcDXgPsviqg8aZ91FaH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718941158; c=relaxed/simple;
	bh=JsSR1xBwj1gkY4SqWbJVApmJVPD1laD4eNL1OJuerMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcA/fdLxc7FIExZky3lu+iQ6zul2vKD08Y7aIm/Yl2r/vXKgDSt78WKKn+aQYzb87zl28imdq+Y7rHDt/Nj900jwYFpLhOFGR66eOAegIwOND8WFtV29Fyep1Z8GL/OE7WXDTj9ocIeu0cCmhebXOkG65jv1QZ7ccWejC2Y5LV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VoW4T/Wm; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718941152; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WMQicdjofrQpjTY14SHJsetHY5HbBnIjFn+Mnq60DqI=;
	b=VoW4T/Wm2iqhhhC9Qcdh/zu1CrxAb45VUFuS8iapyc0njfZ6dBQSQ1/qJr/WMfM4RrV7nnCOmmKFmMYAw+6kbuWoZUvzWhz6LCumoh7ST6woX/O7sFXMrhmWYRSXwyzTpng6NuWYix3ZMtuYhF85rAsvAq5VREj6rNAPNQHSQXo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W8upPoS_1718941150;
Received: from 192.168.43.81(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8upPoS_1718941150)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 11:39:11 +0800
Message-ID: <b7892d90-a31a-497f-b8a3-928b5f0ad84d@linux.alibaba.com>
Date: Fri, 21 Jun 2024 11:39:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/migrate: make migrate_misplaced_folio() return
 0 on success
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-2-david@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240620212935.656243-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/21 05:29, David Hildenbrand wrote:
> Let's just return 0 on success, which is less confusing.
> 
> ... especially because we got it wrong in the migrate.h stub where we
> have "return -EAGAIN; /* can't migrate now */" instead of "return 0;".
> Likely this wrong return value doesn't currently matter, but it
> certainly adds confusion.
> 
> We'll add migrate_misplaced_folio_prepare() next, where we want to use
> the same "return 0 on success" approach, so let's just clean this up
LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/huge_memory.c | 5 ++---
>   mm/memory.c      | 2 +-
>   mm/migrate.c     | 4 ++--
>   3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0fffaa58a47a..fc27dabcd8e3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1652,7 +1652,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>   	int nid = NUMA_NO_NODE;
>   	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
> -	bool migrated = false, writable = false;
> +	bool writable = false;
>   	int flags = 0;
>   
>   	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> @@ -1696,8 +1696,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	spin_unlock(vmf->ptl);
>   	writable = false;
>   
> -	migrated = migrate_misplaced_folio(folio, vma, target_nid);
> -	if (migrated) {
> +	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>   		flags |= TNF_MIGRATED;
>   		nid = target_nid;
>   	} else {
> diff --git a/mm/memory.c b/mm/memory.c
> index 00728ea95583..118660de5bcc 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5354,7 +5354,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   	ignore_writable = true;
>   
>   	/* Migrate to the requested node */
> -	if (migrate_misplaced_folio(folio, vma, target_nid)) {
> +	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>   		nid = target_nid;
>   		flags |= TNF_MIGRATED;
>   	} else {
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 781979567f64..0307b54879a0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2629,11 +2629,11 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   					    nr_succeeded);
>   	}
>   	BUG_ON(!list_empty(&migratepages));
> -	return isolated;
> +	return isolated ? 0 : -EAGAIN;
>   
>   out:
>   	folio_put(folio);
> -	return 0;
> +	return -EAGAIN;
>   }
>   #endif /* CONFIG_NUMA_BALANCING */
>   #endif /* CONFIG_NUMA */

