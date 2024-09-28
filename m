Return-Path: <linux-kernel+bounces-342354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA28D988DE8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 07:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38EC1F21C3A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 05:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF821714B6;
	Sat, 28 Sep 2024 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aNeeuCbi"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50361C156
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727502134; cv=none; b=ZqlKN+PY86QZcH8AIUFl/292rS0ZXpG9IHU1OgVpEMCBzhMo01KPfKC4hySDhmUPlQQl+RB7IOsxWUmcuk8o0vo7WNohTKSSHUmNfbWx4Xb0Uv8r2iND2sdyrS9Yj+D0M3bTXcy8OdMJKN2sq2sAF23vaXEhUCtT710UOXfgKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727502134; c=relaxed/simple;
	bh=z+4Yi4IJS/et8dd5TUSkKowC8/0Fcd8iXAi6DsAloY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1UZN0hgU0KEqIbhdAlIK9pHlvjzwICfv9T9IYhO7SeaWnpjN0HbeZZU5/kjGCMpUL8G09keTILzKhurKsMUhl1G1idiOgJPXJjH9SPgjdGPh9ykX4UZ59+WT7uYjO7Nne6k8XbmdQUIvkv16vDsv8AVkqrt+adPp2L/307E8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aNeeuCbi; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <30d0d552-d296-48de-8e49-dc1d3c733131@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727502128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FyavcNvp8cx3hxPaHac4eX/KSEDHBck84c6tqVegF0=;
	b=aNeeuCbi2NCUNT27dq7w9mSV6yFP+e9F2hlHy5GWvIcYaKe/b0SKJhA60VLD6d871y7RKU
	12MLCQ/Lic1/m4jz98RpwCMyo5jINQ6xvhPBcImj+WS5NBwTCST6gRxKeh5TMMMq5yxC1l
	nK9j+PcCTfYvGBlPsnNMZJmKyqkzep0=
Date: Sat, 28 Sep 2024 13:41:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 2/8] mm: zswap: Modify zswap_compress() to accept a
 page instead of a folio.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, usamaarif642@gmail.com,
 shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
 21cnbao@gmail.com, akpm@linux-foundation.org
Cc: nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-3-kanchana.p.sridhar@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240928021620.8369-3-kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/9/28 10:16, Kanchana P Sridhar wrote:
> For zswap_store() to be able to store a large folio by compressing it
> one page at a time, zswap_compress() needs to accept a page as input.
> This will allow us to iterate through each page in the folio in
> zswap_store(), compress it and store it in the zpool.
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>   mm/zswap.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index efad4e941e44..fd7a8c14457a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -875,7 +875,7 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
>   	return 0;
>   }
>   
> -static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
> +static bool zswap_compress(struct page *page, struct zswap_entry *entry)
>   {
>   	struct crypto_acomp_ctx *acomp_ctx;
>   	struct scatterlist input, output;
> @@ -893,7 +893,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
>   
>   	dst = acomp_ctx->buffer;
>   	sg_init_table(&input, 1);
> -	sg_set_folio(&input, folio, PAGE_SIZE, 0);
> +	sg_set_page(&input, page, PAGE_SIZE, 0);
>   
>   	/*
>   	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
> @@ -1456,7 +1456,7 @@ bool zswap_store(struct folio *folio)
>   		mem_cgroup_put(memcg);
>   	}
>   
> -	if (!zswap_compress(folio, entry))
> +	if (!zswap_compress(&folio->page, entry))
>   		goto put_pool;
>   
>   	entry->swpentry = swp;

