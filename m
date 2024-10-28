Return-Path: <linux-kernel+bounces-385199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53C9B33E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7D4282344
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DB91DE2A7;
	Mon, 28 Oct 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukWBd9Ny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15991DE2A1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126605; cv=none; b=BpIXKMCBQtYZJIczuho1sHuSg/vMEzPgSqzKKt1lYeE46xIbJ5YBtm8x93XQBui3ex8r5HwqGYmjdext30DnMv33mBNJnC8QdShYp20nZlbrJ8IVrFoce5wJQ/hWnZmM5WpEBhnk6WfeG3D1p8ogf0AbtipSR8cAkHVvP0r3Nyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126605; c=relaxed/simple;
	bh=LLw6rtm3xObAOtcw0EBxdlEoBK22y7ghA8CXAj+UVoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLLBrTvWirtnUm9ZLPFH1zFNVx8LV1lZ6WRzDNJAo954bEli5X3xKU7v1kQybtj0ZSkpRvt7feU2hLgcopNArRqW1UbpmlJ82OiiCPnB5Co/ZK/8sFUX7WTZv85kuxHQ8WKFC3bD7tnMA+rItqkuINy9OYCKRG/Vag/+lqBTyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukWBd9Ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59972C4CECD;
	Mon, 28 Oct 2024 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730126605;
	bh=LLw6rtm3xObAOtcw0EBxdlEoBK22y7ghA8CXAj+UVoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ukWBd9NyZSQpUKXgbPo/Idj6rFOjB6/8MTKn26QV2sWtwBkY/+mLLVJJcwrEIXKXt
	 U1ux0Qr5DKLGh0Ew8vBHPfsXhbZqP9Cb7VI4oQhh/E+UKqNDwBmpH2nJoMvlaFBclk
	 AJeP4dAUUQojKV5AnzEkXPK4uhRTqI3QE+DtF0B5OpEN1sVeISMZUR/7qapA7aIITX
	 DQt6WCbBpx9CLebHbENvpyMIFvnGY/urFx/Wlr6kAehwsbM7Vnx9tpKh1dlWHPjxse
	 3vT+CERepl6G9RSDkjTQao+6EyfcJX7ydewCpQktnry8K+mQuFXIpdeCyTTIfKdb5s
	 OleP0oryI2Edg==
Date: Mon, 28 Oct 2024 16:39:33 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Song Liu <song@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: hide execmem_vmap() on !MMU
Message-ID: <Zx-iJZznoi_RhLWO@kernel.org>
References: <20241028141818.622917-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028141818.622917-1-arnd@kernel.org>

On Mon, Oct 28, 2024 at 02:18:09PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added function fails to link on nommu kernels, but is also
> not needed there:
> 
> ld.lld-20: error: undefined symbol: __get_vm_area_node
> >>> referenced by execmem.c
> >>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a
> >>> referenced by execmem.c
> >>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a
> 
> Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as needed")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/execmem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 5c0f9f2d6f83..b04cfece7356 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -368,6 +368,7 @@ void execmem_free(void *ptr)
>  		vfree(ptr);
>  }
>  
> +#ifdef CONFIG_MMU
>  struct vm_struct *execmem_vmap(size_t size)
>  {
>  	struct execmem_range *range = &execmem_info->ranges[EXECMEM_MODULE_DATA];
> @@ -383,6 +384,7 @@ struct vm_struct *execmem_vmap(size_t size)
>  
>  	return area;
>  }
> +#endif

Nit: there is already #ifdef CONFIG_MMU block in execmem.c, better to move
execmem_vmap() there

Other than that
  
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  void *execmem_update_copy(void *dst, const void *src, size_t size)
>  {
> -- 
> 2.39.5
> 

-- 
Sincerely yours,
Mike.

