Return-Path: <linux-kernel+bounces-543002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79103A4D064
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB5316D1EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D8043AA9;
	Tue,  4 Mar 2025 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zrvda/Qj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2D2AEF1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049238; cv=none; b=D298dZMt+jrB1jJUuwoLxTxtA8Xq/OYD4rycVlqznjKqBYIgszftaHTBwUyWswZYZc0koDXdtd+N2EpmHPib66xCvtvEFgpmusmFzrrLijt3kUIrOR2aaA0oprC7a6sX2SZN8ea3yvDvW8k/c9EQxCgxRFwl0NZFHC4JV91zk9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049238; c=relaxed/simple;
	bh=76/XWDwZVHvJ8/uhNZJfs1uJ4fJJCpM1IBiy8YtPoDc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u6qax/DdUsgmE6aREE9Gr5na+v2/tO/ETEBz+LI0YPkXkXCqbKSdu4qEV2X0NXYTzOaF8jnYtrTeRVdXjbq9+tZVKYMuHFH5xLLibHJqG24kNnwdBVFNDyEeVxW9vBTRBCasxtYiHfF8lhqrIGUqxIj6JmA7nCDBF9djvB8lgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zrvda/Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4259DC4CEE4;
	Tue,  4 Mar 2025 00:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741049237;
	bh=76/XWDwZVHvJ8/uhNZJfs1uJ4fJJCpM1IBiy8YtPoDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zrvda/QjpPuS9xFpjoOhceLjGVlk5T/cG+UzBELZuiUgQWtHCt13x60up1sQVimL2
	 EFzSlWNBQwWZI/0gFDPpOcudMxMeYFbM9/eqkPQaMXSzR3ViF3nCW/bkyvo6mu3E1s
	 3O4n2GlRRsKAu6xV30o1SnK/LHPq+9YPFO2aUMTM=
Date: Mon, 3 Mar 2025 16:47:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Liu Ye <liuye@kylinos.cn>
Cc: urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Move free_vm_area(area) from the
 __vmalloc_area_node function to the __vmalloc_node_range_noprof function
Message-Id: <20250303164716.a98b1e3ceb27a264b57a56d7@linux-foundation.org>
In-Reply-To: <20250303015702.319416-1-liuye@kylinos.cn>
References: <20250303015702.319416-1-liuye@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Mar 2025 09:57:02 +0800 Liu Ye <liuye@kylinos.cn> wrote:

> Moved free_vm_area from the __vmalloc_area_node function to the
> __vmalloc_node_range_noprof function so that allocation and freeing
> of the area can be paired in one function for better readability.
> 
> ...
>
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3651,7 +3651,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to allocated page array size %lu",
>  			nr_small_pages * PAGE_SIZE, array_size);
> -		free_vm_area(area);
>  		return NULL;
>  	}
>  
> @@ -3844,8 +3843,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  
>  	/* Allocate physical pages and map them into vmalloc space. */
>  	ret = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
> -	if (!ret)
> +	if (!ret) {
> +		free_vm_area(area);
>  		goto fail;
> +	}
>  
>  	/*
>  	 * Mark the pages as accessible, now that they are mapped.

yes, nicer to free it at the level where it was allocated.

