Return-Path: <linux-kernel+bounces-342355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA6988DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 07:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A0B282A6E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 05:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C07E1714B6;
	Sat, 28 Sep 2024 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MvKtild3"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686AC156
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727502235; cv=none; b=M2AB96PpXZ9IwCfJOXZO6/COw2rZ/oiTzMKQ+GVmvcvxVJySTMSud/Jh34sXinmEYWHSQs//VPDU/GjPgK1YPh3GUd9DnRsH3cWx3JULRVmNt2ZBOzPJGoljMmGRH6hbdiaDJoilZIjkC87JJ9waWRI1Ax9i8r9hSikvwlPBi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727502235; c=relaxed/simple;
	bh=6NBNhzcpVWQZ/WDfO5T6EHe+JH4S3hDeePAlpIUSoMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+YxRgUxti7stvgTmI7Qyq6wf6MuBnhoeKQBj5K63VzK/WNsWC4SnwELDZZ+G4q+bMAn400weUTH2fxKaEJFrLgtcgcWb7C6gxzFkStnRUYgEo20n6JXEnOMohuT+/RaJvbhy0EENC3wQ2m6jg3FBehaiosZSoW55W+Dnf3T7tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MvKtild3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c9d403f-188b-4f15-93d7-36224ef31329@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727502231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WM4VZ3i3EB6b7hfc7us+bM3jDNW3II/yBjXBL1dQj8U=;
	b=MvKtild31vJw513FoyxiEwqqwM++Y9ZZTTFAbV2BVnT+rdY+DS1y7npJNl4ikAvxM2YTg/
	WtiSDKDAIooQE4iEWWDZhk/PZc82BO9IFHsbOLFOILv7pW8z2tQ0kZoQykAs1fGHDeo0+e
	kRnkF6bk2HVohv09sDFcBwl/3r6kWzQ=
Date: Sat, 28 Sep 2024 13:43:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 3/8] mm: zswap: Rename zswap_pool_get() to
 zswap_pool_tryget().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, usamaarif642@gmail.com,
 shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
 21cnbao@gmail.com, akpm@linux-foundation.org
Cc: nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-4-kanchana.p.sridhar@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240928021620.8369-4-kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/9/28 10:16, Kanchana P Sridhar wrote:
> Modify the name of the existing zswap_pool_get() to zswap_pool_tryget()
> to be representative of the call it makes to percpu_ref_tryget().
> A subsequent patch will introduce a new zswap_pool_get() that calls
> percpu_ref_get().
> 
> The intent behind this change is for higher level zswap API such as
> zswap_store() to call zswap_pool_tryget() to check upfront if the pool's
> refcount is "0" (which means it could be getting destroyed) and to handle
> this as an error condition. zswap_store() would proceed only if
> zswap_pool_tryget() returns success, and any additional pool refcounts that
> need to be obtained for compressing sub-pages in a large folio could simply
> call zswap_pool_get().
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>   mm/zswap.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index fd7a8c14457a..0f281e50a034 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -403,7 +403,7 @@ static void __zswap_pool_empty(struct percpu_ref *ref)
>   	spin_unlock_bh(&zswap_pools_lock);
>   }
>   
> -static int __must_check zswap_pool_get(struct zswap_pool *pool)
> +static int __must_check zswap_pool_tryget(struct zswap_pool *pool)
>   {
>   	if (!pool)
>   		return 0;
> @@ -441,7 +441,7 @@ static struct zswap_pool *zswap_pool_current_get(void)
>   	rcu_read_lock();
>   
>   	pool = __zswap_pool_current();
> -	if (!zswap_pool_get(pool))
> +	if (!zswap_pool_tryget(pool))
>   		pool = NULL;
>   
>   	rcu_read_unlock();
> @@ -462,7 +462,7 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
>   		if (strcmp(zpool_get_type(pool->zpool), type))
>   			continue;
>   		/* if we can't get it, it's about to be destroyed */
> -		if (!zswap_pool_get(pool))
> +		if (!zswap_pool_tryget(pool))
>   			continue;
>   		return pool;
>   	}

