Return-Path: <linux-kernel+bounces-317909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7397B96E550
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63A2B21636
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4671AD9E4;
	Thu,  5 Sep 2024 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XVMkW2S2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAF1AB52C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573131; cv=none; b=OD2SwtGtulh0uVO7c8pZ+k55mGXcWt6zz3vJAzDK5lTXsCuWp/MFuNR+3k9Cggx/GgbnEZ3ZsQXPStaWfNt+KEGS6h4Fc7CPBIUG9DlCVsmzetwMcIKeFirJZCMkqvme+gQWC1T+Xedv2LD653KG8vVEkm5pkrL7B/+No7kkroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573131; c=relaxed/simple;
	bh=nsVttku8Ehjht7aRVWo/nNmZgVfMucfOC9yPnXrjKYg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HFr6wtUBSxdbpEsypHLRpHgsJRLYOygkxLuZgo7Sx918Pso2k5w7ESvk+HgEY6aSaxQTwdtxmNKn0Ps+kEbYviegLfP/wiUjKAFDo8KhoII2f2xmkmWfOooi8RMrDa0fbjtqde6nAYCY1ZrtCn/gJkB0RqBOojUz/Q+6VwZ3Dug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XVMkW2S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67938C4CEC3;
	Thu,  5 Sep 2024 21:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725573130;
	bh=nsVttku8Ehjht7aRVWo/nNmZgVfMucfOC9yPnXrjKYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XVMkW2S2G2B2+XskqoX3BbRlSWeauWdPo9CZhkSGv+KMPW3WXbL/pF0LGsu0jHhYz
	 6osraO+B38LYPRsaDIS2zCXYoFCoqSMZ+hJxgqQu5yZbqbtrhRIuuGDgX2pOc+me2T
	 iTc3iY6pL3MCZyloqZ0JK50F9BCAMQI/nArSGc9U=
Date: Thu, 5 Sep 2024 14:52:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use unique zsmalloc caches names
Message-Id: <20240905145209.641c8f127ba353832a1be778@linux-foundation.org>
In-Reply-To: <20240905064736.2250735-1-senozhatsky@chromium.org>
References: <20240905064736.2250735-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 15:47:23 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Each zsmalloc pool maintains several named kmem-caches for
> zs_handle-s and  zspage-s.  On a system with multiple zsmalloc
> pools and CONFIG_DEBUG_VM this triggers kmem_cache_sanity_check():
> 
>   kmem_cache of name 'zspage' already exists
>   WARNING: at mm/slab_common.c:108 do_kmem_cache_create_usercopy+0xb5/0x310
>   ...
> 
>   kmem_cache of name 'zs_handle' already exists
>   WARNING: at mm/slab_common.c:108 do_kmem_cache_create_usercopy+0xb5/0x310
>   ...

This is old code.  Did something recently change to trigger this warning?

> We provide zram device name when init its zsmalloc pool, so we can
> use that same name for zsmalloc caches and, hence, create unique
> names that can easily be linked to zram device that has created
> them.
> 
> So instead of having this
> 
> cat /proc/slabinfo
> slabinfo - version: 2.1
> zspage                46     46    ...
> zs_handle            128    128    ...
> zspage             34270  34270    ...
> zs_handle          34816  34816    ...
> zspage                 0      0    ...
> zs_handle              0      0    ...
> 
> We now have this
> 
> cat /proc/slabinfo
> slabinfo - version: 2.1
> zspage-zram2          46     46    ...
> zs_handle-zram2      128    128    ...
> zspage-zram0       34270  34270    ...
> zs_handle-zram0    34816  34816    ...
> zspage-zram1           0      0    ...
> zs_handle-zram1        0      0    ...
> 
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -293,13 +293,17 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
>  
>  static int create_cache(struct zs_pool *pool)
>  {
> -	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
> -					0, 0, NULL);
> +	char name[32];
> +
> +	snprintf(name, sizeof(name), "zs_handle-%s", pool->name);

Always scary seeing code making such assumptions about it arguments in
this fashion.  Can we use kasprintf() and sleep well at night?


> +	pool->handle_cachep = kmem_cache_create(name, ZS_HANDLE_SIZE,
> +						0, 0, NULL);
>  	if (!pool->handle_cachep)
>  		return 1;
>  
> -	pool->zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
> -					0, 0, NULL);
> +	snprintf(name, sizeof(name), "zspage-%s", pool->name);
> +	pool->zspage_cachep = kmem_cache_create(name, sizeof(struct zspage),
> +						0, 0, NULL);
>  	if (!pool->zspage_cachep) {
>  		kmem_cache_destroy(pool->handle_cachep);
>  		pool->handle_cachep = NULL;

I guess we want to backport this into earlier kernels?  If so, what
would be a suitable Fixes:?

