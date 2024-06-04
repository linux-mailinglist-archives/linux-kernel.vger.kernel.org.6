Return-Path: <linux-kernel+bounces-200558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67538FB1B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146981C22322
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D540145B04;
	Tue,  4 Jun 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aF3qRNJR"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519D1411E9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502523; cv=none; b=Ibk+bJDFex89UQQB8mycDZoTWS5YBSlz2CdEy2IMXAm74YgP68EOz9LtDJUlz5ONGQiI4osfIPUzwWh3OIodopNZb2gnHkhQK686y1HsAtS2nMeL0f7XXttdCm1tLdzwHI2Oggn9vS5QlUPwK242WOZU3eoRk+WXQCILJWRtPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502523; c=relaxed/simple;
	bh=vtntBnIejSYUixurJH5mLsIFDrhSlkp9RiJD8WK+5Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7YWXyWPE+jBolX2Y6yopfODNjRAQ5uRFph6CmHsP9a4lLXS4/isW4NuhN6R8IUL7kk+hLYPSGx8UAeBjFjkr6FFOU51TjC4GkD/zpIg/JSCecxLzuxtw1U49T6jYuPkYYYVFtal76K2TpRqcnq4krCm5p5Mdd8adrVMsTolkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aF3qRNJR; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717502516; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wyzfS+26xWdhAEKu22Jk/trE6TdLI2JG9ktldvYMwZg=;
	b=aF3qRNJRusm1X4cEiIbOv3j3VWZqymagb0KCp1ZLXPyLAe5yhiFAbAibTqXcp8A9es/lGXj5bcMRC25q/xyH/+Xh8HbEwsho2Nz6qEKDDnr9Smas0oyxtmzwEFRF93lUt/a4Yw8LQNV6LQTUhnzPVSX0rTJLheey9YQB5xyb2OI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W7r2oJB_1717502514;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7r2oJB_1717502514)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 20:01:55 +0800
Message-ID: <c180d2a0-1e34-41f0-bae8-1205d04a5f6b@linux.alibaba.com>
Date: Tue, 4 Jun 2024 20:01:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1717492460-19457-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Cc Johannes, Zi and Vlastimil.

On 2024/6/4 17:14, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> THP-sized allocations") no longer differentiates the migration type
> of pages in THP-sized PCP list, it's possible to get a CMA page from
> the list, in some cases, it's not acceptable, for example, allocating
> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
> 
> The patch forbids allocating non-CMA THP-sized page from THP-sized
> PCP list to avoid the issue above.
> 
> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized allocations")
> Signed-off-by: yangge <yangge1116@126.com>
> ---
>   mm/page_alloc.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2e22ce5..0bdf471 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone *preferred_zone,
>   	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>   
>   	if (likely(pcp_allowed_order(order))) {
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> +						order != HPAGE_PMD_ORDER) {

Seems you will also miss the non-CMA THP from the PCP, so I wonder if we 
can add a migratetype comparison in __rmqueue_pcplist(), and if it's not 
suitable, then fallback to buddy?

> +			page = rmqueue_pcplist(preferred_zone, zone, order,
> +						migratetype, alloc_flags);
> +			if (likely(page))
> +				goto out;
> +		}
> +#else
>   		page = rmqueue_pcplist(preferred_zone, zone, order,
>   				       migratetype, alloc_flags);
>   		if (likely(page))
>   			goto out;
> +#endif
>   	}
>   
>   	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,

