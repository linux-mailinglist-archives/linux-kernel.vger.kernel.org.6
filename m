Return-Path: <linux-kernel+bounces-168904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9598BBF89
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 09:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870821C20C12
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 07:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F85CAC;
	Sun,  5 May 2024 07:00:34 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37D2901
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714892433; cv=none; b=MmKDYeuHaoenBkbJjzue6i5ohkRPzlt33mtrwTGPnzvwQ1VSYt3meroVh429uo/0awht9yjK/bI+i/4HrhbOFDhLaxvpmG2Hl5+EeAHxmTPua/PEEiQ7N4d+IjGPuLLnq6iDKCW9gmRzCqr2cu28XpFDBRoU3JDIrj10JG0NgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714892433; c=relaxed/simple;
	bh=Ti0NDrKYBP9Uy6IPNOgqqiIxHOwl6ehcRPGqiyLSeMI=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OXCMfhcapwbWwF1RrUzvLlmIZiJLb44pRJelgMX6iQP8VtWDKW7iTOsd0UIeiw5cKBEK+hXUtVxwcvADaHX6LwburKDFO9apvfknRplHKjcyn9H/ags478EQAH+JbDFy6WUnt/7aP7A/LDIajO6beWIGqGHc952pdoQ8rwv25E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VXFl32tWdzcdSC;
	Sun,  5 May 2024 14:59:11 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 10DC318007A;
	Sun,  5 May 2024 15:00:21 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 15:00:20 +0800
Subject: Re: [PATCH 3/3] mm/memory-failure: send SIGBUS in the event of thp
 split fail
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-4-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <038cffc0-e027-b518-460f-40099819c588@huawei.com>
Date: Sun, 5 May 2024 15:00:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240501232458.3919593-4-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/2 7:24, Jane Chu wrote:
> When handle hwpoison in a GUP longterm pin'ed thp page,
> try_to_split_thp_page() will fail. And at this point, there is little else
> the kernel could do except sending a SIGBUS to the user process, thus
> give it a chance to recover.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Thanks for your patch. Some comments below.

> ---
>  mm/memory-failure.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 7fcf182abb96..67f4d24a98e7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2168,6 +2168,37 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  	return rc;
>  }
>  
> +/*
> + * The calling condition is as such: thp split failed, page might have
> + * been GUP longterm pinned, not much can be done for recovery.
> + * But a SIGBUS should be delivered with vaddr provided so that the user
> + * application has a chance to recover. Also, application processes'
> + * election for MCE early killed will be honored.
> + */
> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
> +			struct page *hpage)
> +{
> +	struct folio *folio = page_folio(hpage);
> +	LIST_HEAD(tokill);
> +	int res = -EHWPOISON;
> +
> +	/* deal with user pages only */
> +	if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
> +		res = -EBUSY;
> +	if (!(PageLRU(hpage) || PageHuge(p)))
> +		res = -EBUSY;

Above checks seems unneeded. We already know it's thp?

> +
> +	if (res == -EHWPOISON) {
> +		collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
> +		kill_procs(&tokill, true, pfn, flags);
> +	}
> +
> +	if (flags & MF_COUNT_INCREASED)
> +		put_page(p);

This if block is broken. put_page() has been done when try_to_split_thp_page() fails?

> +

action_result is missing?

> +	return res;
> +}
> +
>  /**
>   * memory_failure - Handle memory failure of a page.
>   * @pfn: Page Number of the corrupted page
> @@ -2297,6 +2328,11 @@ int memory_failure(unsigned long pfn, int flags)
>  		 */
>  		SetPageHasHWPoisoned(hpage);
>  		if (try_to_split_thp_page(p) < 0) {

Should hwpoison_filter() be called in this case?

> +			if (flags & MF_ACTION_REQUIRED) {
> +				pr_err("%#lx: thp split failed\n", pfn);
> +				res = kill_procs_now(p, pfn, flags, hpage);

Can we use hwpoison_user_mappings() directly here?

Thanks.
.

> +				goto unlock_mutex;
> +			}
>  			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
>  			goto unlock_mutex;
>  		}
> 


