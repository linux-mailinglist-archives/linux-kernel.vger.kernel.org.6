Return-Path: <linux-kernel+bounces-378471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD059AD116
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DD21F216AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C251CBE93;
	Wed, 23 Oct 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHX0rQLR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8831CACF8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701313; cv=none; b=ENT8jtLNYWS1yGhHqE4zXml6qFwbPabFvbmrzBbia+WXKHSlfiRE7ixXpMnrcWu/ZD5pkcsQF/uU011DoECLXYu+OQBsUCzXfUOQKPjFN1FuKDmG7br4oGIv7j2VFWywqrAqEW67XMJll7g1gjIbXQnGsdiPWSDs38xwJRmZpL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701313; c=relaxed/simple;
	bh=+M/rAGDzkw0biZcT2fJ8w/xWO2sn3tGipKuINKaFsRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anEdndBdAceIXdUEhyFbUd/X5EthG96+lVEKDlgKKTFX/4nyUUm7Yz5lbSHu1I7wOJKbQIfDGUS+9MtV5IA2ddPj2Pm+ZQsi1Puh9EVwEc0dbudUGHfyJqjY8uUGOgbJ7EnqX8bcp9iBHRUYyGUGixayEWhwlYWyZFLsZk9NBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHX0rQLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0174C4CEC6;
	Wed, 23 Oct 2024 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729701313;
	bh=+M/rAGDzkw0biZcT2fJ8w/xWO2sn3tGipKuINKaFsRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHX0rQLREZcmtw0dTxYhLwGuWXFVOoHu5bIknTnXaqSQQAPq1hvZkmtBlhvFLdRwY
	 ltq3BR7E3IDrXMz7yY2mJ2GImFUt8nbJLJorY/VKaKzjw2+h/p0cEQC7s0ocLyNOOy
	 7uDPK/dOXV0Jo8Gfl7j166UvWT/GEX5iMagBrvlJGzDLaKOjgrBDln04BkRSeigj/n
	 ZNnnb7s1sP34o8ofDpmvWwxtmKU1tW32YwfC/5t7IK+mTB0snDihlLCkDAINhVo6vw
	 nfwk7tloeWpY7g95JaBd5vFtxLzyGjyK3ANGDGBAz71E+Y6n8rS94UEYfbY7fldhuk
	 9NtGP8zixMk3w==
Date: Wed, 23 Oct 2024 17:35:08 +0100
From: Will Deacon <will@kernel.org>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, patches@amperecomputing.com,
	cl@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, adamli@os.amperecomputing.com
Subject: Re: [PATCH] arm64: set "rodata=on" as default
Message-ID: <20241023163507.GC29251@willie-the-truck>
References: <20241021053948.5848-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021053948.5848-1-shijie@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Oct 21, 2024 at 01:39:48PM +0800, Huang Shijie wrote:
> From Documentation/admin-guide/kernel-parameters.txt, we know that:
>  rodata=	[KNL,EARLY]
> 	on	Mark read-only kernel memory as read-only (default).
> 	off	Leave read-only kernel memory writable for debugging.
> 	full	Mark read-only kernel memory and aliases as read-only
> 		[arm64]
> 
> So the "rodata=on" is the default.
> 
> But the current code does not follow the document, it makes "rodata=full"
> as the default.
> 
> After patch
>   commit acfa60dbe038 ("arm64: mm: Fix "rodata=on" when CONFIG_RODATA_FULL_DEFAULT_ENABLED=y")
> the "rodata=on" can works fine now.
> 
> The "rodata=on" can provide us more block mappings and contiguous hits
> to map the linear region which minimize the TLB footprint. And the
> linear aliases of pages belonging to read-only mappings in vmalloc
> region are also marked as read-only now.
> 
> This patch disables RODATA_FULL_DEFAULT_ENABLED by default,
> so the default value:
>      rodata_full=false, rodata_enabled=true
> then the default behavior follows the "rodata=on".
> And we can get better performance with the "rodata=on" as the default
> too.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  arch/arm64/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fd9df6dcc593..6f30f749156e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1649,7 +1649,6 @@ config MITIGATE_SPECTRE_BRANCH_HISTORY
>  
>  config RODATA_FULL_DEFAULT_ENABLED
>  	bool "Apply r/o permissions of VM areas also to their linear aliases"
> -	default y
>  	help
>  	  Apply read-only attributes of VM areas to the linear alias of
>  	  the backing pages as well. This prevents code or read-only data

I think this is the wrong approach.

The "full" behaviour on arm64 is equivalent to the "on" behaviour on x86
so the more consistent change to make would be:

  - Make our "on" behaviour be what is currently done by "full"
  - Remove RODATA_FULL_DEFAULT_ENABLED
  - Introduce a new option (e.g. "rodata=noalias") which would match the
    current "on" behaviour
  - Update (simplify) the documentation

That way, the default behaviour and the "on"/"off" options follow the
x86 behaviour and expert users can fine-tune the security/performance
trade-off using the "noalias" option.

Will

