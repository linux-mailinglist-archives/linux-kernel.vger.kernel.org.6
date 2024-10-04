Return-Path: <linux-kernel+bounces-349769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E9598FB5F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CBF1F23858
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136D256D;
	Fri,  4 Oct 2024 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMdzorrD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92E1849;
	Fri,  4 Oct 2024 00:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000197; cv=none; b=frM7cjKicrJTyB8l9oP+xE5eVZf/B2JBG7Z3pdIm8ZRroi3UEntVUgXVdLozqfh9D/RbWzVX48mwAcSl6DFIxvXjQi0VFPpDiJTw2Dr4OE8mGhid7+73qC8tjVOsPXsYPmUTD2QHcmqtpj5Ob6ZbkmN3NgVu+GWBZkZosyxHEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000197; c=relaxed/simple;
	bh=SNrvlogFlg3d5o+tg0qQnk7NnFWIl9VQl1VbaDJnDgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDWRWuCevkyrLZHDhiId1G7Sz0Lq5MoriEQcsWvDg6k8llnjcXpiBhEy/CQp+VROGvZm3wxbK6X30i/u/tO2Q3cjp6BgSGEY7urpgzSJCeTyQHoyaOeAAnlS6fl6a6hLz++Mk7uoSJoXNOzh3UOkRM6nRyNJL3Cbeg7cSlPe0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMdzorrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D672AC4CEC5;
	Fri,  4 Oct 2024 00:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728000197;
	bh=SNrvlogFlg3d5o+tg0qQnk7NnFWIl9VQl1VbaDJnDgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMdzorrDPhHDsZkbSRBXh7eDHyOllgtmi71lMaV764yDzF/xTrgCLutg+cydsTuE3
	 N8lG88FyjnhppugZnTjoBtFXkoRShhpQVXnDAeNZJMhVSUrExke7LXNNhhW9jVv3FW
	 tnkJbYrQDj/Kqj0xY3gWcet9cN60KtQq0IYix2MTuYFBy8IKxWbQHQ/kySTqzg6NDc
	 rTzEwawwqizTQt9DKpLrYMQ6LRoLEVP76dJe/wxP5CZrky1uBHg/+0aBsFKZIXDSaw
	 wyiNKmogMLoXeJ4XBhsIrfMHa84CGYeoPjoBn/0aP+g+f/7sQtMJPrkM/jHVKvfGLA
	 aLFDoDy1ZK53w==
Date: Thu, 3 Oct 2024 19:03:16 -0500
From: Rob Herring <robh@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org,
	catalin.marinas@arm.com, saravanak@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
Message-ID: <20241004000316.GA1910499-robh@kernel.org>
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003113840.2972416-1-usamaarif642@gmail.com>

On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
>  __pa() is only intended to be used for linear map addresses and using
> it for initial_boot_params which is in fixmap for arm64 will give an
> incorrect value. Hence stash the physical address when it is known at
> boot time and use it at kexec time instead of converting the virtual
> address using __pa().
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
> ---
>  arch/arm64/kernel/setup.c | 8 ++++++++
>  drivers/of/fdt.c          | 6 ++++++
>  drivers/of/kexec.c        | 8 ++++++--
>  include/linux/of_fdt.h    | 2 ++
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index b22d28ec8028..a4d96f5e2e05 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  	/* Early fixups are done, map the FDT as read-only now */
>  	fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
>  
> +	/*
> +	 * Save dt_phys address so that it can be used later for kexec. This
> +	 * is done as __pa() is only intended to be used for linear map addresses
> +	 * and using it for initial_boot_params which is in fixmap will give an
> +	 * incorrect value.
> +	 */
> +	set_initial_boot_params_pa(dt_phys);

No new arch->dt functions please. If we need to save off the PA, then do 
that when we set initial_boot_params.

Rob

