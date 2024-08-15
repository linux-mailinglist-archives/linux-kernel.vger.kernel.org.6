Return-Path: <linux-kernel+bounces-288114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFFC9535BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79591B26865
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A001A01CB;
	Thu, 15 Aug 2024 14:41:00 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B41A00EC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732859; cv=none; b=duu5rryydAGRnm7/MNe1fb9aBCIwjDEUkggcX6RIt4s45EVo+Pd8fcUxzYYufPdAYDEGaBV1XVBGQ9RdW++mQmthsYQLVplrdLpjO6WC1Gdp6B4+5kP5ADgssqthYlcN15w7ayC4O/iTJUVffz6NnwRS9ie7Jh9eLH5IiwA96pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732859; c=relaxed/simple;
	bh=Z8Ci4B33S4Of5MZbBVTn4FekWSzm5eG/tF6KeDmLPrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BBLeReqN0fCoyx3EDUzvQVt/8G/L2zw2ZoagRCaqSBRUN/PqEOzYEjw0mmMYAGEUIjC3+HnQDVoOieUVH8PSmPv9xgCEP9SHW27KErLdd4zsZ0VzfcnIf0QvJp7tgQSzLX56u4dFBiFPVvSqu5w8Zq/O0SRI/AfebDm8H9t84qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wl7570YPHz1HG8l;
	Thu, 15 Aug 2024 22:37:47 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id B53FA1A016C;
	Thu, 15 Aug 2024 22:40:52 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Aug 2024 22:40:52 +0800
Message-ID: <6d19d790-92d2-40f9-9797-cc08bf3921fe@huawei.com>
Date: Thu, 15 Aug 2024 22:40:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v1 2/3] mm/cma: add cma_alloc_folio()
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240811212129.3074314-1-yuzhao@google.com>
 <20240811212129.3074314-3-yuzhao@google.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240811212129.3074314-3-yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/8/12 5:21, Yu Zhao wrote:
> With alloc_contig_range() and free_contig_range() supporting large
> folios, CMA can allocate and free large folios too, by
> cma_alloc_folio() and cma_release().
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>   include/linux/cma.h |  1 +
>   mm/cma.c            | 47 ++++++++++++++++++++++++++++++---------------
>   2 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 9db877506ea8..086553fbda73 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -46,6 +46,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>   					struct cma **res_cma);
>   extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
>   			      bool no_warn);
> +extern struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
>   extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
>   extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
>   
> diff --git a/mm/cma.c b/mm/cma.c
> index 95d6950e177b..46feb06db8e7 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -403,18 +403,8 @@ static void cma_debug_show_areas(struct cma *cma)
>   	spin_unlock_irq(&cma->lock);
>   }
>   
> -/**
> - * cma_alloc() - allocate pages from contiguous area
> - * @cma:   Contiguous memory region for which the allocation is performed.
> - * @count: Requested number of pages.
> - * @align: Requested alignment of pages (in PAGE_SIZE order).
> - * @no_warn: Avoid printing message about failed allocation
> - *
> - * This function allocates part of contiguous memory on specific
> - * contiguous memory area.
> - */
> -struct page *cma_alloc(struct cma *cma, unsigned long count,
> -		       unsigned int align, bool no_warn)
> +static struct page *__cma_alloc(struct cma *cma, unsigned long count,
> +				unsigned int align, gfp_t gfp)
>   {
>   	unsigned long mask, offset;
>   	unsigned long pfn = -1;
> @@ -463,8 +453,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>   
>   		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>   		mutex_lock(&cma_mutex);
> -		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> -				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
> +		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
>   		mutex_unlock(&cma_mutex);
>   		if (ret == 0) {
>   			page = pfn_to_page(pfn);
> @@ -494,7 +483,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>   			page_kasan_tag_reset(nth_page(page, i));
>   	}
>   
> -	if (ret && !no_warn) {
> +	if (ret && !(gfp & __GFP_NOWARN)) {
>   		pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu pages, ret: %d\n",
>   				   __func__, cma->name, count, ret);
>   		cma_debug_show_areas(cma);
> @@ -513,6 +502,34 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>   	return page;
>   }
>   
> +/**
> + * cma_alloc() - allocate pages from contiguous area
> + * @cma:   Contiguous memory region for which the allocation is performed.
> + * @count: Requested number of pages.
> + * @align: Requested alignment of pages (in PAGE_SIZE order).
> + * @no_warn: Avoid printing message about failed allocation
> + *
> + * This function allocates part of contiguous memory on specific
> + * contiguous memory area.
> + */
> +struct page *cma_alloc(struct cma *cma, unsigned long count,
> +		       unsigned int align, bool no_warn)
> +{
> +	return __cma_alloc(cma, count, align, GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
> +}
> +
> +struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
> +{
> +	struct page *page;
> +
> +	if (WARN_ON(order && !(gfp | __GFP_COMP)))
> +		return NULL;
> +
> +	page = __cma_alloc(cma, 1 << order, order, gfp);
> +
> +	return page ? page_folio(page) : NULL;

We don't set large_rmappable for cma alloc folio, which is not consistent
with  other folio allocation, eg  folio_alloc/folio_alloc_mpol(),
there is no issue for HugeTLB folio, and for HugeTLB folio must without
large_rmappable, but once we use it for mTHP/THP, it need some extra
handle, maybe we set large_rmappable here, and clear it in
init_new_hugetlb_folio()?

> +}
> +
>   bool cma_pages_valid(struct cma *cma, const struct page *pages,
>   		     unsigned long count)
>   {

