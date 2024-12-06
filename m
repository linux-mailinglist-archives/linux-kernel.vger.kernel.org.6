Return-Path: <linux-kernel+bounces-434212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD59E6359
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9076B1884F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A9F13AD2A;
	Fri,  6 Dec 2024 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="we8OCAfq"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7722F855
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733448173; cv=none; b=ijvaeLoOoOg66qDdF+2DdRioGtT+q1fq3pzm0Fihh2nPKaLJTpKCa1IxGlBXMy2+V0/UZcLO69lmZ+4vLqjh7uwXFnWpJTAFCmf9z0iO2Kr6TB61onCMq6i6lrpU1zmK09YcaN2biDCXkj8TNUbr8joF0sPGIQdnUGWG7q6t5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733448173; c=relaxed/simple;
	bh=wh73udQT1QPuCops5d+jhXm/KXU1xPZP0IvKqWujOE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1buqR2KiUghmUZgmeAbCd9sufJFQtkt0T2ISAugFIMLpJ71r09yqTm6/pFGXezsb2Ot53Xutduwq4iSAoayOYD6uJF3Oy2EF5C5Pw8/wfCwtbaxuezBw2A3kp84RO+HeQIKwjW1p9y7wYqP0OYZjL6witF09vNC5TAsHw4ftY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=we8OCAfq; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733448168; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WFnC8RHk6kOTFK2JQOqDh20DsGWdHfd8ksIujar0mQU=;
	b=we8OCAfqSIYY951al8Xk2Y4E9Yt0UQH7pYzGUaDk65GE3KOM5qE907jqZxFMTBMheG7+uPzUVMxXJtHKmy4kQLtn5DJKGvVsTxFv3UZZsujgjLc2Segxg8fVqjYU4NFTYcSqCtBCTJ56BNxLO2xTr25EgAzBSj8BWC7qKdxSBe4=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKudkJO_1733448166 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Dec 2024 09:22:47 +0800
Message-ID: <8137952d-b310-4c42-aec3-8906e7301921@linux.alibaba.com>
Date: Fri, 6 Dec 2024 09:22:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix] mm: shmem: fix ShmemHugePages at swapout
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <5ba477c8-a569-70b5-923e-09ab221af45b@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5ba477c8-a569-70b5-923e-09ab221af45b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/5 14:50, Hugh Dickins wrote:
> /proc/meminfo ShmemHugePages has been showing overlarge amounts (more
> than Shmem) after swapping out THPs: we forgot to update NR_SHMEM_THPS.
> 
> Add shmem_update_stats(), to avoid repetition, and risk of making that
> mistake again: the call from shmem_delete_from_page_cache() is the bugfix;
> the call from shmem_replace_folio() is reassuring, but not really a bugfix
> (replace corrects misplaced swapin readahead, but huge swapin readahead
> would be a mistake).
> 
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org

Indeed. Thanks for fixing.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/shmem.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ccb9629a0f70..f6fb053ac50d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -787,6 +787,14 @@ static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>   }
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>   
> +static void shmem_update_stats(struct folio *folio, int nr_pages)
> +{
> +	if (folio_test_pmd_mappable(folio))
> +		__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr_pages);
> +	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
> +	__lruvec_stat_mod_folio(folio, NR_SHMEM, nr_pages);
> +}
> +
>   /*
>    * Somewhat like filemap_add_folio, but error if expected item has gone.
>    */
> @@ -821,10 +829,7 @@ static int shmem_add_to_page_cache(struct folio *folio,
>   		xas_store(&xas, folio);
>   		if (xas_error(&xas))
>   			goto unlock;
> -		if (folio_test_pmd_mappable(folio))
> -			__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr);
> -		__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
> -		__lruvec_stat_mod_folio(folio, NR_SHMEM, nr);
> +		shmem_update_stats(folio, nr);
>   		mapping->nrpages += nr;
>   unlock:
>   		xas_unlock_irq(&xas);
> @@ -852,8 +857,7 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
>   	error = shmem_replace_entry(mapping, folio->index, folio, radswap);
>   	folio->mapping = NULL;
>   	mapping->nrpages -= nr;
> -	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
> -	__lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
> +	shmem_update_stats(folio, -nr);
>   	xa_unlock_irq(&mapping->i_pages);
>   	folio_put_refs(folio, nr);
>   	BUG_ON(error);
> @@ -1969,10 +1973,8 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>   	}
>   	if (!error) {
>   		mem_cgroup_replace_folio(old, new);
> -		__lruvec_stat_mod_folio(new, NR_FILE_PAGES, nr_pages);
> -		__lruvec_stat_mod_folio(new, NR_SHMEM, nr_pages);
> -		__lruvec_stat_mod_folio(old, NR_FILE_PAGES, -nr_pages);
> -		__lruvec_stat_mod_folio(old, NR_SHMEM, -nr_pages);
> +		shmem_update_stats(new, nr_pages);
> +		shmem_update_stats(old, -nr_pages);
>   	}
>   	xa_unlock_irq(&swap_mapping->i_pages);
>   

