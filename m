Return-Path: <linux-kernel+bounces-219104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8F90C9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD951C231C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A80E1586C0;
	Tue, 18 Jun 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkbND8/E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4242157A61
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708676; cv=none; b=O9lu6mO2HCg0XksYzjBNE/+HvBepVI0xco6SrGss9R33umVB7BRqpsEmVICmnKRR78zsQhuD3uQXwlfqLQB3IOUSc5Am4KJbK6L/fpZ+vNSOHs7fqS7xPDjS9yZCFOp0gZ0NGLlOw600tOL4vn1YgoyuTqdZSfSENIsMH4fge8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708676; c=relaxed/simple;
	bh=NY46nA/XWYixeSE6/TIdJ0Mru4j2agru9bQrVnYDEZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gljh4UKjLIwvDvYF75h7AsyoEobAeA+deINTZ0K0wQNh+b39eO7LZMQJeAd7JMJR7EqO70cEuxsEhNW4Yra8zxaPQaAhb7BZt0YvxDTYdSrg+aZ3yhS7F18W5flvVdBzyWnncG/1cB0CZkCiSePEkaBU8gaEnaQbICdurI5HKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkbND8/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9E1C4AF1D;
	Tue, 18 Jun 2024 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718708676;
	bh=NY46nA/XWYixeSE6/TIdJ0Mru4j2agru9bQrVnYDEZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkbND8/ENHkB+4ngD5QwaTxyG1rFJw4MP4C5E+HOS97H/Ct/x9rh+g2yudcs7Ptf2
	 IGiZ6yQgB4URmFoTOkOD0jSg+pRXh5kv4kg8nGoJ6b5KDVxeEtizWihsyEoOnG6bHn
	 9NEnrBD1GZBABcyvrf+BuTlg3nrP88hBYt/zc86SKnCRqN6K+ypY44bNgqo09E14zo
	 RGghIT+rO8S7xZ8JnQIs1AZJM6+dn99w5jxr0L0jIyEBLESuNAy3uLzfHD3559/K6M
	 tcRxfMT7DqtjxkKRIS9YifzD+twtbjRG8Tw4i9MepHz7qNL8VXgan9tKvwFQwbSVXT
	 PY1ABvFXT/Fgw==
Date: Tue, 18 Jun 2024 14:02:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: James Gowans <jgowans@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Alex Graf <graf@amazon.de>
Subject: Re: [PATCH] memblocks: Move late alloc warning down to phys alloc
Message-ID: <ZnFpPCSTAUj90FJF@kernel.org>
References: <20240614133016.134150-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614133016.134150-1-jgowans@amazon.com>

On Fri, Jun 14, 2024 at 03:30:16PM +0200, James Gowans wrote:
> Subject: [PATCH] memblocks: Move late alloc warning down to phys alloc

Nit: memblock

> If a driver/subsystem tries to do an allocation after memblocks have
> been freed and the memory handed to the buddy allocator, it will not
> actually be legal to use that allocation - the buddy allocator owns the
> memory. This is handled by the memblocks function which does allocations
> and returns virtual addresses by printing a warning and doing a kmalloc
> instead. However, the physical allocation function does not to do this
> check - callers of the physical alloc function are unprotected against
> mis-use.

Did you see such misuse or this is a theoretical issue?
 
> Improve the error catching here by moving the check into the physical
> allocation function which is used by the virtual addr allocation
> function.
> 
> Signed-off-by: James Gowans <jgowans@amazon.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alex Graf <graf@amazon.de>
> ---
>  mm/memblock.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index d09136e040d3..dd4f237dc1fc 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1457,6 +1457,17 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  		align = SMP_CACHE_BYTES;
>  	}
>  
> +	/*
> +	 * Detect any accidental use of these APIs after slab is ready, as at
> +	 * this moment memblock may be deinitialized already and its
> +	 * internal data may be destroyed (after execution of memblock_free_all)
> +	 */
> +	if (WARN_ON_ONCE(slab_is_available())) {
> +		void *vaddr = kzalloc_node(size, GFP_NOWAIT, nid);
> +
> +		return vaddr ? virt_to_phys(vaddr) : 0;
> +	}

I'd move this before alignment check.

> +
>  again:
>  	found = memblock_find_in_range_node(size, align, start, end, nid,
>  					    flags);
> @@ -1576,13 +1587,6 @@ static void * __init memblock_alloc_internal(
>  {
>  	phys_addr_t alloc;
>  
> -	/*
> -	 * Detect any accidental use of these APIs after slab is ready, as at
> -	 * this moment memblock may be deinitialized already and its
> -	 * internal data may be destroyed (after execution of memblock_free_all)
> -	 */
> -	if (WARN_ON_ONCE(slab_is_available()))
> -		return kzalloc_node(size, GFP_NOWAIT, nid);
>  
>  	if (max_addr > memblock.current_limit)
>  		max_addr = memblock.current_limit;
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

