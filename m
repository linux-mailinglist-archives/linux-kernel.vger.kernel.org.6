Return-Path: <linux-kernel+bounces-186932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641068CCAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188B01F21B83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7208D7E765;
	Thu, 23 May 2024 03:02:47 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4134A34
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716433367; cv=none; b=rhAbOejAETH2guGjubBbTVKfmsextg852DGB1BcAkY7NdGD9VewNpIMQm1raMbmfSBKRqorpU7+foxXQVkqrz4ar/LacaIQUwcmM+yY4WhByPj9Yk164MGw05wnZUV15hvq9beK7Y5fy4yeM6/2W9I7oePbM0Uu40FJ1Oxr+8tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716433367; c=relaxed/simple;
	bh=puZNZp2QdH8s3Zbw8ku3b7fKBDToV2EptNwEa/K/S7k=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZekijpIjUON8+cbbTqNYJdAmfeqVsgibf9D9um4oV4QmEJbYXMYegJM9fxZCfBT5cGgyxCx7b5GP0IPw1ngOy/O0Z7MBQaEZIsoqQDezOFov00BNIsYVPxdjpLgmMr/EqDr/yuQ8NHhaWEJz8IKVCbx+0H1MR/+XfWA6r5way9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VlCYp2DrYz1ltYt;
	Thu, 23 May 2024 10:59:10 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id AD6B41400D3;
	Thu, 23 May 2024 11:02:39 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 11:02:39 +0800
Subject: Re: [PATCH v3 5/5] mm/memory-failure: send SIGBUS in the event of thp
 split fail
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <osalvador@suse.de>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240521235429.2368017-1-jane.chu@oracle.com>
 <20240521235429.2368017-6-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c95a0336-6755-03a4-5c09-273d538e139e@huawei.com>
Date: Thu, 23 May 2024 11:02:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240521235429.2368017-6-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/22 7:54, Jane Chu wrote:
> While handling hwpoison in a THP page, it is possible that
> try_to_split_thp_page() fails. For example, when the THP page has
> been RDMA pinned. At this point, the kernel cannot isolate the
> poisoned THP page, all it could do is to send a SIGBUS to the user
> process with meaningful payload to give user-level recovery a chance.
> 

Thanks for your patch.

> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 794196951a04..a14d56e66902 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1706,7 +1706,12 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>  	return page_action(ps, p, pfn);
>  }
>  
> -static int try_to_split_thp_page(struct page *page)
> +/*
> + * When 'release' is 'false', it means that if thp split has failed,
> + * there is still more to do, hence the page refcount we took earlier
> + * is still needed.
> + */
> +static int try_to_split_thp_page(struct page *page, bool release)
>  {
>  	int ret;
>  
> @@ -1714,7 +1719,7 @@ static int try_to_split_thp_page(struct page *page)
>  	ret = split_huge_page(page);
>  	unlock_page(page);
>  
> -	if (unlikely(ret))
> +	if (ret && release)
>  		put_page(page);

Is "unlikely" still needed?

>  
>  	return ret;
> @@ -2187,6 +2192,24 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  	return rc;
>  }
>  
> +/*
> + * The calling condition is as such: thp split failed, page might have
> + * been RDMA pinned, not much can be done for recovery.
> + * But a SIGBUS should be delivered with vaddr provided so that the user
> + * application has a chance to recover. Also, application processes'
> + * election for MCE early killed will be honored.
> + */
> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
> +				struct folio *folio)
> +{
> +	LIST_HEAD(tokill);
> +
> +	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
> +	kill_procs(&tokill, true, pfn, flags);
> +
> +	return -EHWPOISON;
> +}
> +
>  /**
>   * memory_failure - Handle memory failure of a page.
>   * @pfn: Page Number of the corrupted page
> @@ -2328,8 +2351,10 @@ int memory_failure(unsigned long pfn, int flags)
>  		 * page is a valid handlable page.
>  		 */
>  		folio_set_has_hwpoisoned(folio);
> -		if (try_to_split_thp_page(p) < 0) {
> -			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
> +		if (try_to_split_thp_page(p, false) < 0) {
> +			res = kill_procs_now(p, pfn, flags, folio);

No strong opinion but we might remove the return value of kill_procs_now as
it always return -EHWPOISON? We could simply set res to -EHWPOISON here.

Besides from above possible nits, this patch looks good to me.
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.


