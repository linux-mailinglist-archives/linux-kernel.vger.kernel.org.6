Return-Path: <linux-kernel+bounces-439778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102EC9EB3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E34F2836BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9981A9B25;
	Tue, 10 Dec 2024 14:49:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7E20326
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842144; cv=none; b=X/nroIGA3Dk4oq0IWwbphipAldVS/ImRHJnrexPACbCrovONbdgPZPu0nz2aDofQmHUW0k1tBcsc14Yz/5MrlJos9mfHJJszFUOt3AsdVfha/Nk8lltwsuC9AAace6kZxPq/kz6ANZQ1dJwwGxyWgc+b28e2xGhZlQQQd9TrNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842144; c=relaxed/simple;
	bh=VzE2yCXjN3mD2r9Rblg3y7LII2D/3zeWOEw+YLi3wIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoNK5OH6NZRTzPJcexJzuQ4yCyjnppFiaYfxiCJ1q/cke5uZhkodIX/9NZLOc+YRarLHVC+zXaKrMfUcFY6BGClLGoPyjeYgx9iH8Zyy+/sga4JO8fZPolw/BcIbDKM4QnYXF8EP+1/4fKBslAM+QCasnY7TOTsQHdYyxvk8ILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 286AF106F;
	Tue, 10 Dec 2024 06:49:25 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE59D3F58B;
	Tue, 10 Dec 2024 06:48:55 -0800 (PST)
Date: Tue, 10 Dec 2024 14:48:48 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64/signal: Silence spurious sparse warning storing
 GCSPR_EL0
Message-ID: <Z1hU0Ii-Sm9NHnhj@J2N7QTR9R3>
References: <20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org>

On Tue, Dec 10, 2024 at 12:42:53AM +0000, Mark Brown wrote:
> We are seeing a false postive sparse warning in gcs_restore_signal()
> 
> arch/arm64/kernel/signal.c:1054:9: sparse: sparse: cast removes address space '__user' of expression

This isn't a false positive; this is a cross-address space cast that
sparse is accurately warning about. That might be *benign*, but the tool
is doing exactly what it is supposed to.

> when storing the final GCSPR_EL0 value back into the register, caused by
> the fact that write_sysreg_s() casts the value it writes to a u64 which
> sparse sees as discarding the __userness of the pointer. The magic for
> handling such situations with sparse is to cast the value to an unsigned
> long which sparse sees as a valid thing to do with __user pointers so add
> such a cast.

As a general note, casting to/from unsigned long or uintptr_t is a
special-case in sparse, and in general you should use __force to cast
across address spaces or to/from bitwise types, e.g.

	some_type *foo = ...;
	some_type __user *user_foo;

	user_foo = (__force some_type __user *)foo;

> While we're at it also remove spurious casts of the gcspr_el0 value as we
> manipulate it which were the result of bitrot as the code was tweaked in
> the long period it was out of tree.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412082005.OBJ0BbWs-lkp@intel.com/
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/signal.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 14ac6fdb872b9672e4b16a097f1b577aae8dec50..83ea7e5fd2b54566c6649b82b8570657a5711dd4 100644
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
> +	write_sysreg_s((unsigned long)(gcspr_el0 + 1), SYS_GCSPR_EL0);

Only one line here wants a __user pointer, so wouldn't it be simpler to
pass 'gcspr_el0' as an integer type, and cast it at the point it's used
as an actual pointer, rather than the other way around?

Then you could also simplify gcs_restore_signal(), etc.

Similarly in map_shadow_stack(), it'd be simpler to treat cap_ptr as an
integer type.

Mark.

>  
>  	return 0;
>  }
> 
> ---
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> change-id: 20241209-arm64-gcs-signal-sparse-53fa9cad67f7
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 
> 

