Return-Path: <linux-kernel+bounces-445153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE66E9F1209
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED79281714
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6BA1E3DD3;
	Fri, 13 Dec 2024 16:26:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CA16C684
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107203; cv=none; b=AYIsgeywYXz755hbCsgHQ0u9jrXJib3+YPRGLL2GA/VXoPNG0xESj53234W2LSqKXaHhJj/Wbocz2gFikj63mkf5RpbN1+7d/Y5kLIVD5BMGV+iMwsKU0AYPu0oWsDfB/cLvikoiZJnLuoaYTmgAw0s0hI0G+XOr265rUs0Gsg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107203; c=relaxed/simple;
	bh=WSzUeZEX+vbwTOwABDiQ8myBW2GiekoAD8zNpChJlBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uInpPUxPEFiBndblae+4gz5t0L+3wHalnj15yvG6fF3i2lsVevllHHzNvxGKCAPXz6F7oMqeU/WgOFBafGfJb748ozY9mYa+gBzFIMEucR+XBmUbDVHxDxNQ+iWXQM3bTPTGXkJuwPruE22ZZBwY9zBqa7cZa64opMF7YQ9zN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AEFC4CED0;
	Fri, 13 Dec 2024 16:26:41 +0000 (UTC)
Date: Fri, 13 Dec 2024 16:26:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] arm64/signal: Silence sparse warning storing GCSPR_EL0
Message-ID: <Z1xgQGNZzR6h0Uly@arm.com>
References: <20241211-arm64-gcs-signal-sparse-v2-1-c22f37216135@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-arm64-gcs-signal-sparse-v2-1-c22f37216135@kernel.org>

On Wed, Dec 11, 2024 at 01:00:35AM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 14ac6fdb872b9672e4b16a097f1b577aae8dec50..08d51fabdb9d47c848f14c9b25d6be04f109c2ee 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -39,7 +39,7 @@
>  #ifdef CONFIG_ARM64_GCS
>  #define GCS_SIGNAL_CAP(addr) (((unsigned long)addr) & GCS_CAP_ADDR_MASK)
>  
> -static bool gcs_signal_cap_valid(u64 addr, u64 val)
> +static bool gcs_signal_cap_valid(unsigned long __user *addr, u64 val)
>  {
>  	return val == GCS_SIGNAL_CAP(addr);
>  }

Another personal preference - addresses should be (unsigned long),
pointer to be accessed (... __user *). But we could even scrap this
function, there's a single caller to a one-line function.

> @@ -1094,15 +1094,15 @@ static int gcs_restore_signal(void)
>  	/*
>  	 * Check that the cap is the actual GCS before replacing it.
>  	 */
> -	if (!gcs_signal_cap_valid((u64)gcspr_el0, cap))
> +	if (!gcs_signal_cap_valid(gcspr_el0, cap))
>  		return -EINVAL;
>  
>  	/* Invalidate the token to prevent reuse */
> -	put_user_gcs(0, (__user void*)gcspr_el0, &ret);
> +	put_user_gcs(0, gcspr_el0, &ret);
>  	if (ret != 0)
>  		return -EFAULT;
>  
> -	write_sysreg_s(gcspr_el0 + 1, SYS_GCSPR_EL0);
> +	write_sysreg_s((__force u64)(gcspr_el0 + 1), SYS_GCSPR_EL0);
>  
>  	return 0;
>  }

Looking through the code, do we have a similar problem in
gcs_signal_entry()? Or do we rely on sparse ignoring (unsigned long)
casts?

Whichever way we go, I think we should have consistency between these
two functions.

-- 
Catalin

