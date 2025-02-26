Return-Path: <linux-kernel+bounces-534223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5A6A46457
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA017A2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B92236F4;
	Wed, 26 Feb 2025 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TUIq6S9W"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E635968
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582955; cv=none; b=WDjyStRLqxRotRJJYEclH0efZ1SaRrIxoSeFeMyGOC4mHybrHFa8w14N39iBt0VkWdQ2ZB5mmeUO/Jcv50lh/cXiOEC3nFnA2B5Df+7S5trL/z+h6TXqjTybNsxYFWUwWlM59o1QXoMNo7S+HJQKC5dUo5OBVnBJ6VuhwUpkCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582955; c=relaxed/simple;
	bh=q7cK5SPdbuZlj47rJmvZSLSrN2XrClfeUVtgm8V16Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uzb9tG+H4VAJEkto6/SAoIAyBqeUKixbl9GcgZsCuFP6fKEP4M7YfooNqzTfu3l8kkdBoarLlmN0Es5j5bRic0IdOpG7YwDCzMao3eEft2l8bOth2SxeDsGlr7pAbjWnFRPy3eL+S6o/qWsv9AxsaV6WaVSXdEAGQy3FyL/7VdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TUIq6S9W; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 15:15:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740582951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6MaTWCXdufan1Q+mAXcn5rxDeHl7k5+QDzGK91XsNI=;
	b=TUIq6S9W2bLCSf8d/SOPkgtJ3Tm7sT4BDirXHJheDDjh7trduImrx/eJYO/2PMuQI4mzh0
	IfN/RUb3qFsERsINDoe/+lLT330hEsCkEYPMz+3fn62dC9QoIgif+fl7XTP1Zo+bCDCWQB
	1hxFMitzDD3HOiEF/6hp2xtHCPTlLbU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sun YangKai <sunk67188@gmail.com>
Cc: nphamcs@gmail.com, Johannes Weiner <hannes@cmpxchg.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	"open list:ZSWAP COMPRESSED SWAP CACHING" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: zswap: use ATOMIC_LONG_INIT to initialize
 zswap_stored_pages
Message-ID: <Z78wI0z_0LHVm_WK@google.com>
References: <20250226124141.22218-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124141.22218-1-sunk67188@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 08:41:39PM +0800, Sun YangKai wrote:
> This is currently the only atomic_long_t variable initialized by
> ATOMIC_INIT macro found in the kernel by using
> `grep -r atomic_long_t | grep ATOMIC_INIT`
> 
> This was introduced in 6e1fa55, in which we modified

We use the first 12 characters in the SHA1 to minimize collisions (same
in 'Fixes' below), so both should be 6e1fa555ec77.

> the type of zswap_stored_pages to atomic_long_t,
> but didn't change the initialization.
> 
> Fixes: 6e1fa55 ("mm: zswap: modify zswap_stored_pages to be atomic_long_t")
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  mm/zswap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index ac9d299e7d0c..23365e76a3ce 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -43,7 +43,7 @@
>  * statistics
>  **********************************/
>  /* The number of compressed pages currently stored in zswap */
> -atomic_long_t zswap_stored_pages = ATOMIC_INIT(0);
> +atomic_long_t zswap_stored_pages = ATOMIC_LONG_INIT(0);
>  
>  /*
>   * The statistics below are not protected from concurrent access for
> -- 
> 2.48.1
> 

