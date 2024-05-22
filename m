Return-Path: <linux-kernel+bounces-186367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD85E8CC33F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBDDB21657
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035F179AE;
	Wed, 22 May 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9pkbY/o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3AF8F6D;
	Wed, 22 May 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388292; cv=none; b=mvbBumpfLbGi5tKSkTHVEkVE+ygpvWbqEZ8ZJh+n3XSQ0vPRJ1m5ZkT4pCGU8dZopHC5SVljDf7VhFZHkxx+x9jp8qIqlfFEYPLChhLpqxJ7N0uXG0wB3w/dNjPuGTUMw5kdtfANK2SKCb7znLtPKcvWmgAEBrc4Lg1EK+bnbVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388292; c=relaxed/simple;
	bh=caxlHLkLA7Kyl2xhI0wkWw8AtvfOM+yyH8wCjBO9scI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C37/EIN0ROr4gD3SqHp3WwD6dk8RNkssNk0b7lyZIJPl9po+xHNrf23SDUXx1i22jeGVmZcVDuEoolB5KYC/7fOxs49HQPeyZFWLkP2HF7+aA5JO/tQmuTB+E+SsJI8DYP+DiIfLCG8sEu8k95GCnOo3mnouOPS6AL29dTOsKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9pkbY/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88564C2BBFC;
	Wed, 22 May 2024 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388290;
	bh=caxlHLkLA7Kyl2xhI0wkWw8AtvfOM+yyH8wCjBO9scI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9pkbY/oQCevl7mOH3JJXSgFZZOrwY2EaiGTjT8Qvv42x3YKAakriYSPEhSm7/KqX
	 05892MJl4SjdKnQ5Z8EygCt+PzSVMSLX1ThcbkbQy2Thj0ibC6PxwSuS4xeDSYHrYQ
	 2d1HSVKTf4d5DvLDe0hqNcp9+dCb4GCcYr92NOht2cTMFClds7a2SfDhgwPdB9EE7G
	 Mw49zWiygkpLHxgM2eEXsf797PqZb10QM3kAaW6l7R0S7mBde/SbVRXaBh7V6PKhH5
	 YPSxlvClXZXKD1wcVZue7IpXSclgliHTDcvRlCrR7vDdXSUYLZ/zK7+P/djy4uGwAd
	 8gNRRpFg7CiMQ==
Date: Wed, 22 May 2024 09:31:29 -0500
From: Rob Herring <robh@kernel.org>
To: skseofh@gmail.com
Cc: lkp@intel.com, daero_le.lee@samsung.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, rppt@kernel.org,
	saravanak@google.com
Subject: Re: [PATCH v2] of: of_reserved_mem: clean-up reserved memory with
 no-map
Message-ID: <20240522143129.GA3244910-robh@kernel.org>
References: <202405011208.qsZQwChO-lkp@intel.com>
 <20240501132359.488616-1-skseofh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501132359.488616-1-skseofh@gmail.com>

On Wed, May 01, 2024 at 10:23:59PM +0900, skseofh@gmail.com wrote:
> From: Daero Lee <daero_le.lee@samsung.com>
> 
> In early_init_dt_reserve_memory we only add memory w/o no-map flag to
> memblock.reserved. But we need to add memory w/ no-map flag to
> memblock.reserved, because NOMAP and memblock.reserved are semantically
> different.
> 
> Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
> ---
>  drivers/of/of_reserved_mem.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 8236ecae2953..d00a17a9cebc 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -81,6 +81,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
>  static int __init early_init_dt_reserve_memory(phys_addr_t base,
>  					       phys_addr_t size, bool nomap)
>  {
> +	int err = 0;
>  	if (nomap) {
>  		/*
>  		 * If the memory is already reserved (by another region), we
> @@ -91,7 +92,10 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
>  		    memblock_is_region_reserved(base, size))
>  			return -EBUSY;
>  
> -		return memblock_mark_nomap(base, size);
> +
> +		err = memblock_mark_nomap(base, size);

The last time this was touched, it was to make the handling aligned with 
EFI memory map handling. Is that still going to be the case with this 
change? Or does EFI memory map handling have the same issue?

> +		if (err)
> +			return err;
>  	}
>  	return memblock_reserve(base, size);
>  }
> -- 
> 2.25.1
> 

