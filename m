Return-Path: <linux-kernel+bounces-216226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91198909CE2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 11:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394FB281874
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFF118629E;
	Sun, 16 Jun 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWyrYZ0k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F08F54
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718531926; cv=none; b=I9CREhWCtR69pBj3Umh5P7CZi/Uu2tfiXFdqDkz2IFb7kl8tbPchOdef4FOtuOzeEGYpJSdChKeglRhX20LjdXadosAlM2c0HvpFCBGg0Z1lr96F8Lfi3QXRPrflw+0JIXnC5zEZlabP3FKp8e/YUq6W2ZwBSlnTZphShYPAPr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718531926; c=relaxed/simple;
	bh=DejFUb5PkXNfmRFEK/KK+kGZeHnMceNJrm8Hw3xMm9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNjlR3d/pQzYjpjRIfzqZHlWRbPOVnNqzUoVwpIRVW4l7apC9kcYqjlVt4QS5O85AxU6oO6nEzHT5h4CYNhckm+KZq+praKZlqaiAjbWXymXmJJuUX4I5vSFPMwt7ycXNaZ0C1eLncS0+AIkjJxh5Nw35R/M05K3O4jRFDBrEME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWyrYZ0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF61C2BBFC;
	Sun, 16 Jun 2024 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718531926;
	bh=DejFUb5PkXNfmRFEK/KK+kGZeHnMceNJrm8Hw3xMm9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWyrYZ0kVHOJzAbxGTW5SqKWGNPRFCawZ8ILmfcmyxkBfOPvGjTlpQgCspkqVF+vv
	 V42ml2xvAOgy8wY7kGyCJPfi4sS2YIEqVvQmCeNDag1QqJ4z9+T4Isiu2rUhQUTZQN
	 7ohr3mPWFbpuuHQPXinQIUy8qXwC1b2FYHx7ZG+Q=
Date: Sun, 16 Jun 2024 11:58:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, andriy.shevchenko@linux.intel.com, brgl@bgdev.pl,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] devres: Fix devm_krealloc() allocating memory with
 wrong size
Message-ID: <2024061634-stack-plop-6aff@gregkh>
References: <1718531655-29761-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718531655-29761-1-git-send-email-quic_zijuhu@quicinc.com>

On Sun, Jun 16, 2024 at 05:54:15PM +0800, Zijun Hu wrote:
> Kernel API devm_krealloc() calls alloc_dr() with wrong argument
> @total_new_size, and it will cause more memory to be allocated
> than required, fixed by using @new_size as alloc_dr()'s argument.
> 
> Fixes: f82485722e5d ("devres: provide devm_krealloc()")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/devres.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 3df0025d12aa..1cf87ddf1f55 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -898,7 +898,7 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
>  	 * taking the lock as most probably the caller uses GFP_KERNEL.
>  	 */
>  	new_dr = alloc_dr(devm_kmalloc_release,
> -			  total_new_size, gfp, dev_to_node(dev));
> +			  new_size, gfp, dev_to_node(dev));
>  	if (!new_dr)
>  		return NULL;
>  
> -- 
> 2.7.4
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

