Return-Path: <linux-kernel+bounces-368291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C429A0DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7204B24800
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4110C20E027;
	Wed, 16 Oct 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TkEKjMZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4D20E01D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091575; cv=none; b=Ez5FAuY/j5CfCfMKkopV/sSPczIwqKQ7tW6zBZ4MM3pKWkD6rY0ho0j1vFhM8TVhy0PGvX9me1ynCYulpZkIV6uvRDwkwwjvOtR4THw8mbZZdiVe5gYwpQ30cWr11VuVXoe+oeDZypM+/yNWpIPzMntxQyj8Jvg1lIIvbATsq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091575; c=relaxed/simple;
	bh=KIOhExd4pXdkJ32FDr6kgRy+v68Kz95tFwaj7mxBHa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzQctk59y0YLnUKS7RfDibItm/qBmC3tDl//hn+J1blYcb8VeszormSTq+OBjNKt3823l5X8YbAfpnXXlA8eTK6vP5GG2+oxqXzLPmHmfPE2q5fR2PxCa4l2+i2xtnrQM8ooANh2QzRP+nBgCwxaE6l/bj/ef1KhAZAdH6Oi9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TkEKjMZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC25DC4CEC5;
	Wed, 16 Oct 2024 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729091575;
	bh=KIOhExd4pXdkJ32FDr6kgRy+v68Kz95tFwaj7mxBHa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkEKjMZxT7XUTUoQx/ASdZRnN6kDRGjWNgS1jW/n7mnXlA+fUTXZIssHNI6gbPizY
	 QQg1DCIkFh8UBiNDn/5j1BX+jQFDcPi0VXf9zZw25H3FHwH7gDg4xH0n/kDRnLLDRa
	 JCaXjsIu+MV16dcz/Ionu3DCiUB1X9hPZd4CuLxU=
Date: Wed, 16 Oct 2024 17:12:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, dakr@redhat.com,
	rafael@kernel.org, amadeuszx.slawinski@linux.intel.com,
	cezary.rojewski@intel.com, wangweiyang2@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] firmware_loader: Fix possible resource leak in
 fw_log_firmware_info()
Message-ID: <2024101634-zoologist-smog-1c64@gregkh>
References: <20241016110335.3677924-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016110335.3677924-1-cuigaosheng1@huawei.com>

On Wed, Oct 16, 2024 at 07:03:35PM +0800, Gaosheng Cui wrote:
> The alg instance should be released under the exception path, otherwise
> there may be resource leak here.
> 
> To mitigate this, free the alg instance with crypto_free_shash when kmalloc
> fails.
> 
> Fixes: 02fe26f25325 ("firmware_loader: Add debug message with checksum for FW file")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/base/firmware_loader/main.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 324a9a3c087a..c6664a787969 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -829,19 +829,18 @@ static void fw_log_firmware_info(const struct firmware *fw, const char *name, st
>  	shash->tfm = alg;
>  
>  	if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
> -		goto out_shash;
> +		goto out_free;
>  
>  	for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
>  		sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
>  	outbuf[SHA256_BLOCK_SIZE] = 0;
>  	dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
>  
> -out_shash:
> -	crypto_free_shash(alg);
>  out_free:
>  	kfree(shash);
>  	kfree(outbuf);
>  	kfree(sha256buf);
> +	crypto_free_shash(alg);
>  }
>  #else
>  static void fw_log_firmware_info(const struct firmware *fw, const char *name,
> -- 
> 2.25.1
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

