Return-Path: <linux-kernel+bounces-296875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F01E795B013
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3DBB229FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9C16DEAC;
	Thu, 22 Aug 2024 08:21:50 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629005674E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314910; cv=none; b=oFm0VaAIIbLRioHYm+2Lh8lcGCttfayar5izawA8Lt2dz3scOz00zTLLgu2I5Q0rdu/vQjbzbqdpZe9cTHXMFh75wClClqhMvXuiQ759/9GAZcj3WSeLVh8bc2LaAQcpWEB8G1I29hCpPyBayyH5eYWaox/tbNkaHJ+tKIckW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314910; c=relaxed/simple;
	bh=U55Nd1Ck+yVVapGZEqszEXXrXIWME40t+n3Z40SNmFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UEGPB1my8Oqmq6Rps2P+uNHhe5ai8uMtNJjeMvlLyJjCn1gHx3XmnFz6eBA34Oqdo5iqfBwvMRLnRCW0wYVMiZrgHCW6weFsLWvhmt/6GZAPPRUeW5oBCXxgwRwlx7PcV/9DMStMijJ5/oJ3WRfT+6zIvNIg8WP48va7Rl66e5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WqGPD3pZ2z13kGf;
	Thu, 22 Aug 2024 16:21:04 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id A915C1800D3;
	Thu, 22 Aug 2024 16:21:44 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 16:21:44 +0800
Message-ID: <2d418463-1458-5361-86c4-a07908fc114d@huawei.com>
Date: Thu, 22 Aug 2024 16:21:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
From: Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <20240814035451.773331-2-yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500003.china.huawei.com (7.185.36.200)

On 2024/8/14 11:54, Yu Zhao wrote:
> Support __GFP_COMP in alloc_contig_range(). When the flag is set, upon
> success the function returns a large folio prepared by
> prep_new_page(), rather than a range of order-0 pages prepared by
> split_free_pages() (which is renamed from split_map_pages()).
> 
> alloc_contig_range() can be used to allocate folios larger than
> MAX_PAGE_ORDER, e.g., gigantic hugeTLB folios. So on the free path,
> free_one_page() needs to handle that by split_large_buddy().
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/gfp.h |  23 +++++++++
>  mm/compaction.c     |  41 ++--------------
>  mm/page_alloc.c     | 111 +++++++++++++++++++++++++++++++-------------
>  3 files changed, 108 insertions(+), 67 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index f53f76e0b17e..59266df56aeb 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -446,4 +446,27 @@ extern struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_
>  #endif
>  void free_contig_range(unsigned long pfn, unsigned long nr_pages);
>  
> +#ifdef CONFIG_CONTIG_ALLOC
> +static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
> +							int nid, nodemask_t *node)
> +{
> +	struct page *page;
> +
> +	if (WARN_ON(!order || !(gfp | __GFP_COMP)))

It doesn't seem right, it should be !(gfp & __GFP_COMP).

Best Regards,
Yu

