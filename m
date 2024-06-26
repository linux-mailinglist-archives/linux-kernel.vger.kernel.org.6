Return-Path: <linux-kernel+bounces-230052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B09177D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD72283BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FD713D255;
	Wed, 26 Jun 2024 05:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9QIlV0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DD13AD28
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378308; cv=none; b=dy4yJND9gAUTkxEdGUYJ57eahSgtGbvuWR9HKHBYVNI7iishEVfj2lli06dMBOhoy92pkEe57WDQod+3vkEHqGq0+5GEvNrdn9L24DF32fqryXuCG3+XVgBtxz+LdsLCQHLDntBXmW28VP1zUSgnF7uKHJJYhwoE3DLoHA/Xavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378308; c=relaxed/simple;
	bh=ZgawbklMa0mTB5ICZcmT/KCFPnybBd1Xaek6KxkvUbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUYRgGXFBYSfPzjmsPu2LqQPzwxuRobbqLt8h1Uv057UYroKggJrP0sjBJpRftKJS9VRZUl1mZHz7Y2qyrcXoMzzuslUQFrDWZ4qubdirVigyPqIgVoyiyF6HYHXVRJY0ays4yE7LY7BnBmO9A3tNNE+ZCSPQecR2ycGsy+YHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9QIlV0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E53C2BD10;
	Wed, 26 Jun 2024 05:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719378308;
	bh=ZgawbklMa0mTB5ICZcmT/KCFPnybBd1Xaek6KxkvUbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9QIlV0/SC7HxMudJw6Ky0kIVQSVXvyKMQjeg2ZwMYeym6As/VTEnofLKm/Q+gGWv
	 Mqa9qwGs5iBk/RLOIclzSkeLL4j4U4OcOQcPutH1hKjMcKeFd3bXeUNTckccLTeFfH
	 h81j0xm2ONnSt9F4d8HvoajM66BIharie8NS8Sj3FNyHhTLeVCoIdeX2KUIS0EwPxO
	 a5dKCk87HBXQ/Q+gESk6dyiBTDsCbKxOTPDqABWREcihu331rYNRmgR/uF3CZ5y8NJ
	 2nk2d5fjxqLM/Dros0WrDYEhqKILl9J4PRni5Na3Lod5pk05XPwqdsTFH6mqhd4eM5
	 z+I6V9OJVmULQ==
Date: Wed, 26 Jun 2024 08:02:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Guanshun Liu <lgs156412@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memblock: export memblock_free() to free reserved
 memory.
Message-ID: <Znug8e2cUzuA9qGu@kernel.org>
References: <20240625121652.1189095-1-lgs156412@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625121652.1189095-1-lgs156412@gmail.com>

On Tue, Jun 25, 2024 at 08:16:52PM +0800, Guanshun Liu wrote:
> On architectures that support the preservation of memblock metadata
> after __init, allow drivers to call memblock_free() to free a
> reservation configured in dts. This is a hack to support the

"This is a hack" implies that it's not a proper solution, right?

And anyway, memblock_free() will not actually free the memory after __init.

> freeing of bootsplash reservations passed to Linux by the bootloader.
> 
> Signed-off-by: Guanshun Liu <lgs156412@gmail.com>
> ---
>  mm/memblock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 6d18485571b4..20e7f81fc076 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -848,6 +848,9 @@ void __init_memblock memblock_free(void *ptr, size_t size)
>  	if (ptr)
>  		memblock_phys_free(__pa(ptr), size);
>  }
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
> +EXPORT_SYMBOL_GPL(memblock_free);
> +#endif
>  
>  /**
>   * memblock_phys_free - free boot memory block
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

