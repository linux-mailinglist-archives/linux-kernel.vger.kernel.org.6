Return-Path: <linux-kernel+bounces-306571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A9A9640A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B721C244BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08F418DF6E;
	Thu, 29 Aug 2024 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1C0mPFB6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6C18990C;
	Thu, 29 Aug 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925278; cv=none; b=Ph1kcKIdiXLh8zGOQ3ItpG25JQs4NYVq0uY6RDc37jl4nPKxGewOqqvPoVzZLsXlMkc1SXYvThKyu9kfZP1l8IjTQZoRMY8tbHfyjoPso0QCf580cWJIdNf8IaJZsBNawFQdGDIJGMuY4q4mKuony9N6x0i/CHbVgaU/5hYFmLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925278; c=relaxed/simple;
	bh=r0rYo5Cb1TYlRbByxd0FLOjj81gHy0gDDxkdJo2MVOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtSJ6WrEPRw47WsOoeXxWo6yl/UvvaVk1kw2A7gETPelSsfBALsNPwQUEMXFA/W6q9toe1+198eYN0bgk8ozUbrkkH8VRo0f9qF68ew61ZL/flgXulTrGY++2z6/8LDwwC8AD9OnWmSNvBcbB27nRIc4G17JOtYZPIIH3iFrA5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1C0mPFB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4751CC4CEC1;
	Thu, 29 Aug 2024 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724925277;
	bh=r0rYo5Cb1TYlRbByxd0FLOjj81gHy0gDDxkdJo2MVOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1C0mPFB6P1AEVd4YpJwqQ8XlYqVxruUWgdIao85/3ke5pGGCi8u4MbDKhPYe1i7jH
	 80ISS/xjSgXiiPHYmE7K8KB/yyqhLESF9+15pAy1NX8T3BMu3ixIiuEH1w3dc1vZOm
	 n4nChHy+SnbKxxfnz0opuiWQY7FVbxIhVHyCv+Jk=
Date: Thu, 29 Aug 2024 11:54:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: sm750fb: fix checkpatch warning architecture
 specific defines should be avoided
Message-ID: <2024082959-luminous-quirk-83cb@gregkh>
References: <20240827193634.3291-4-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827193634.3291-4-riyandhiman14@gmail.com>

On Wed, Aug 28, 2024 at 01:06:37AM +0530, Riyan Dhiman wrote:
> Abstract out x86-specific code in ddk750_init_hw() to improve
> portability and adhere to kernel coding standards. Replaces
> architecture-specific defines with CONFIG_X86 checks.
> 
> Fixes checkpatch warning:
> - CHECK: architecture specific defines should be avoided.
> 
> Changes made:
> - Create a new function sm750le_set_graphic_mode to encapsulate architecture
> specifc behaviour.
> - Using CONFIG_X86 instead of i386 and x86.
> - Added placeholder for non-x86 architectures in sm750le_set_graphic_mode
> function.
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index 02860d3ec365..23196070bceb 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -210,6 +210,17 @@ unsigned int ddk750_get_vm_size(void)
>  	return data;
>  }
>  
> +static void sm750le_set_graphic_mode(void)
> +{
> +#ifdef CONFIG_X86
> +	outb_p(0x88, 0x3d4);
> +	outb_p(0x06, 0x3d5);
> +#else
> +	/* Implement an alternative method for non-x86 architectures */
> +	/* This might involve memory-mapped I/O or other chip-specific methods */
> +#endif
> +}
> +
>  int ddk750_init_hw(struct initchip_param *p_init_param)
>  {
>  	unsigned int reg;
> @@ -229,11 +240,7 @@ int ddk750_init_hw(struct initchip_param *p_init_param)
>  		reg |= (VGA_CONFIGURATION_PLL | VGA_CONFIGURATION_MODE);
>  		poke32(VGA_CONFIGURATION, reg);
>  	} else {
> -#if defined(__i386__) || defined(__x86_64__)
> -		/* set graphic mode via IO method */
> -		outb_p(0x88, 0x3d4);
> -		outb_p(0x06, 0x3d5);
> -#endif
> +		sm750le_set_graphic_mode();

This really doesn't change much, right?  I think the existing code is
fine, it's ok to ignore checkpatch here.

thanks,

greg k-h

