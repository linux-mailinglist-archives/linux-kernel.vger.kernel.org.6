Return-Path: <linux-kernel+bounces-345463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC898B697
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5F41F212FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDC91BE222;
	Tue,  1 Oct 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIMN1muB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240D1BD023
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770292; cv=none; b=Hb4WrHfZ8x8BY8BIgLfWqGzIxPpbTzmvwUWc0qoJ0kOGy1itsWy6IG8MdpP12cYp9YbV2qVqAkL7ZfIn8Q4o+BT044Yj2TZdn4d85CRI8O9cJrIXMZ1CLiy6h+NWWoSG0NMHqIuH3gnQsYA0QByPZciu+ziuM3o9Mww5nLx4m0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770292; c=relaxed/simple;
	bh=hYPoCmqYVOsA4MSW7XrikRkk5GBP8028e7wOQylmFbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzZwijlgk7CJlJtXBJtverG4yPrPkVP3schJQjSBSVhK7NFn1V03sap3VqLAW5T1t0rRJLmuJZPGIAN6JOL9Kkr1RcT6Qr5jWSpc3DKyPI/GlJN3jiK/KITTBG6e3rJcoUQ3GoF8xQDOgrmGwUDXF4BlHP753r7kuikkK7yJUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIMN1muB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E033C4CECD;
	Tue,  1 Oct 2024 08:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727770292;
	bh=hYPoCmqYVOsA4MSW7XrikRkk5GBP8028e7wOQylmFbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIMN1muBV6m/cicun+vVeJ3Anxk04puuWU8sJXtTnQMAc/TnrXLFXFezrJlOaqBWW
	 h7vjhyEWdx0mu/1ATEm5YwsaKP3j8GD3p/Y3X/MARfWLsCGXlDdEJ0QxnaxMdkAYc0
	 KwKjm71jVapE2+PFMkUAwjPqe9Gk4cG5q9XZVxpNBtu3diyFldRMxYLRqPELLqxmm4
	 6Xrj2IbVV6tb7nr3dA3sr+09twXgCdrvLi2sHDC+AoCU6bYbiyFY1iDggpNRUV/E/b
	 zIY54P3GnIGdWFIyphrx7O8SKDWsY4Q9dEcB/kDheNalcSVG0vYQ+os+uzXPT/DPtO
	 WINE+xgTbzbTw==
Date: Tue, 1 Oct 2024 11:08:14 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Patrick Roy <roypat@amazon.co.uk>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, graf@amazon.com, jgowans@amazon.com
Subject: Re: [PATCH] secretmem: disable memfd_secret() if arch cannot set
 direct map
Message-ID: <Zvut7i6d5ijl1nEH@kernel.org>
References: <20241001080056.784735-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001080056.784735-1-roypat@amazon.co.uk>

On Tue, Oct 01, 2024 at 09:00:41AM +0100, Patrick Roy wrote:
> Return -ENOSYS from memfd_secret() syscall if !can_set_direct_map().
> This is the case for example on some arm64 configurations, where marking
> 4k PTEs in the direct map not present can only be done if the direct map
> is set up at 4k granularity in the first place (as ARM's
> break-before-make semantics do not easily allow breaking apart
> large/gigantic pages).
> 
> More precisely, on arm64 systems with !can_set_direct_map(),
> set_direct_map_invalid_noflush() is a no-op, however it returns success
> (0) instead of an error. This means that memfd_secret will seemingly
> "work" (e.g. syscall succeeds, you can mmap the fd and fault in pages),
> but it does not actually achieve its goal of removing its memory from
> the direct map.
> 
> Note that with this patch, memfd_secret() will start erroring on systems
> where can_set_direct_map() returns false (arm64 with
> CONFIG_RODATA_FULL_DEFAULT_ENABLED=n, CONFIG_DEBUG_PAGEALLOC=n and
> CONFIG_KFENCE=n), but that still seems better than the current silent
> failure. Since CONFIG_RODATA_FULL_DEFAULT_ENABLED defaults to 'y', most
> arm64 systems actually have a working memfd_secret() and aren't be
> affected.
> 
> From going through the iterations of the original memfd_secret patch
> series, it seems that disabling the syscall in these scenarios was the
> intended behavior [1] (preferred over having
> set_direct_map_invalid_noflush return an error as that would result in
> SIGBUSes at page-fault time), however the check for it got dropped
> between v16 [2] and v17 [3], when secretmem moved away from CMA
> allocations.
> 
> [1]: https://lore.kernel.org/lkml/20201124164930.GK8537@kernel.org/
> [2]: https://lore.kernel.org/lkml/20210121122723.3446-11-rppt@kernel.org/#t
> [3]: https://lore.kernel.org/lkml/20201125092208.12544-10-rppt@kernel.org/
> 
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/secretmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 3afb5ad701e14..399552814fd0f 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -238,7 +238,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>  	/* make sure local flags do not confict with global fcntl.h */
>  	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
>  
> -	if (!secretmem_enable)
> +	if (!secretmem_enable || !can_set_direct_map())
>  		return -ENOSYS;
>  
>  	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
> @@ -280,7 +280,7 @@ static struct file_system_type secretmem_fs = {
>  
>  static int __init secretmem_init(void)
>  {
> -	if (!secretmem_enable)
> +	if (!secretmem_enable || !can_set_direct_map())
>  		return 0;
>  
>  	secretmem_mnt = kern_mount(&secretmem_fs);
> 
> base-commit: abf2050f51fdca0fd146388f83cddd95a57a008d
> -- 
> 2.46.2
> 

-- 
Sincerely yours,
Mike.

