Return-Path: <linux-kernel+bounces-253516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9B932262
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F921C21E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2019580A;
	Tue, 16 Jul 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRaPdirG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC24613CF8E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120627; cv=none; b=hfRQUDt4ppuJsqG4Gwln6gfQvtFHkk/pTYlJRsl9GzIyDYCw1M312i9GojrK9dqGgXYEJpIn7tSruc0dPxfDa2oepMFd3TUyKzPU/PYpvln7N5ujLE+PIdA3VCA9vKvpijQnalrsionqPMTwGq4GyKlD0iKnf5OF0dXoDJ5Sji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120627; c=relaxed/simple;
	bh=WLvG7TDoZgSPTVJtRaG4qJAjESBmc1ezOZFKUVFYglQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkbuqALHU0EW14npDUTQHhZSxjCaQl0lxQ7bgAZqompgsShDOvXE/o9H/5LdTs+J+1iyrLiBMtFlI7oteoaQv2QHIQ/sRfPFXDl4enesDPU+iFmwqc3dVBhdnvQ2BafLUyGUWej1FH44Jw1ItnUOu5Ai2zn/XjfcvkabTJDdSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRaPdirG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA1CC116B1;
	Tue, 16 Jul 2024 09:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721120627;
	bh=WLvG7TDoZgSPTVJtRaG4qJAjESBmc1ezOZFKUVFYglQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRaPdirG6dxamn9A22WvSrURGKXNehc48KK0wWbcOrNF0SQx07XZEbPMWLaw801H6
	 c3ezIGQ6WkyOtsgvZpej5pKT03zA1pCp/fgYkxjcig6EJ3Ic4tpEnGVJS6oI3HeeDr
	 fTrgDQJeiZC0AyeMk2JGarmryQ7Rzf0QwZHEzxLeyBjMtDO4pbEV0Oi2diCQ+bpJpM
	 aNIDUwSg6fuL/9WUzxA6GVSOCklEgqwYHuKc2uqZRDI0cPyf/sFyn5f7BJP8lSLaio
	 9BArglq8zSoFmzCMzRWKzGKowk2tMVv3TbYDYUZkhOagpzjlxK/b68OA9/i0wyxiRn
	 qaYJGmTjyz5iA==
Date: Tue, 16 Jul 2024 10:03:42 +0100
From: Will Deacon <will@kernel.org>
To: Chanho Min <chanho.min@lge.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Gunho Lee <gunho.lee@lge.com>
Subject: Re: [PATCH] arm64: set MITIGATE_SPECTRE_BRANCH_HISTORY to n by
 default
Message-ID: <20240716090342.GB19348@willie-the-truck>
References: <20240716085136.4160-1-chanho.min@lge.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716085136.4160-1-chanho.min@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 16, 2024 at 05:51:36PM +0900, Chanho Min wrote:
> lmbench shows 25% performance regression after MITIGATE_SPECTRE_BRANCH_HISTORY
> is enabled. This performance drop may be more significant than mitigating
> the spectre-BHB. This patch changes this security option to disable by default
> and makes it selectable.
> 
> - lat_syscall result with MITIGATE_SPECTRE_BRANCH_HISTORY enabled (cortex-a78)
> write call      0.2777  0.2810  0.2824  0.280367
> read call       0.3435  0.3452  0.3443  0.344333
> 
> - lat_syscall result with MITIGATE_SPECTRE_BRANCH_HISTORY disabled (cortex-a78)
> write call      0.2101  0.2117  0.2116  0.2111
> read call       0.2732  0.2744  0.2763  0.274633

It's sad, but it's not surprising. Mitigations rarely make things faster.

> Signed-off-by: Chanho Min <chanho.min@lge.com>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5d91259ee7b5..be76f425c060 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1626,7 +1626,7 @@ config UNMAP_KERNEL_AT_EL0
>  
>  config MITIGATE_SPECTRE_BRANCH_HISTORY
>  	bool "Mitigate Spectre style attacks against branch history" if EXPERT
> -	default y
> +	default n
>  	help
>  	  Speculation attacks against some high-performance processors can
>  	  make use of branch history to influence future speculation.
> -- 
> 2.17.1

It's better to be safe than sorry, so I think it's right to default
this to 'y'. The mitigation can be disabled on the kernel command-line,
e.g. using the "nospectre_bhb" option.

Will

