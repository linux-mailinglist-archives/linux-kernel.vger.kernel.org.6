Return-Path: <linux-kernel+bounces-512598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DF4A33B58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC75D3A5BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0520E6F3;
	Thu, 13 Feb 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MiXJJNUE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D020CCE3;
	Thu, 13 Feb 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439533; cv=none; b=FrFJVH0/vj11WMyPMKiI69lVr7czsiPIXRs72CYpAvzRNcaxWX2/TP6ege3AAf0bOVvASYOt2Q/yuA1SSCZVZyRbXdoMDZiKi2IiLU07bpnyOVGLPyEi1jmD3iJEDUGopf6rvcFW5vSO7sEAxtmHd37fjfTKkVBjZZCiI+sJte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439533; c=relaxed/simple;
	bh=0zWcTo7NJF9fSVtPaN+XMS58YNRC0oUAa0cekb1aOfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoGzpRtjlcYuWuUvd6bxh2V9d+Cx8DBXGJSaVlkzFbT0ioN2AO+XDP6EHJye6chSzwxPrK8PRKNEAFFK86XEaD4gGp9BR25JedeGaLVCwmxwdgQaFcv2wCO2Fp9vpp2app0HrSsgz1aDTgeBWDN1g5TAv4vSIEQv7n0OONyaxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MiXJJNUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFD8C4CEE8;
	Thu, 13 Feb 2025 09:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739439532;
	bh=0zWcTo7NJF9fSVtPaN+XMS58YNRC0oUAa0cekb1aOfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiXJJNUE2PZpaqwYrgnTicCmFHo4/HXOS8hdhhmLUTnwY1yg0J3+T6MwYJL/mxfK3
	 EYeC8NyezJ5n7m2ZgAICaA6PS3u6FIVBTgOTqWRuY11nwjUx0uuph3Dw8iCWVlHuMy
	 raeM2awePu5+czI0fo4CL26A4T8JFPLCLaozbK7w=
Date: Thu, 13 Feb 2025 10:38:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: 412574090@163.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: Re: [PATCH] usb: fix error while OF and ACPI all config Y
Message-ID: <2025021334-sagging-activism-3dd3@gregkh>
References: <20250213091553.198050-1-412574090@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213091553.198050-1-412574090@163.com>

On Thu, Feb 13, 2025 at 05:15:53PM +0800, 412574090@163.com wrote:
> From: weiyufeng <weiyufeng@kylinos.cn>
> 
> When both OF and ACPI are configured as Y simultaneously，this may
> cause error while install os with usb disk，while reading data from
> the usb disk, the onboard_ hub driver will reinitialize the
> hub, causing system installation exceptions.
> 
> Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> ---
>  drivers/usb/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 6497c4e81e95..94e75e7adcc1 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
>  
>  config USB_ONBOARD_DEV
>  	tristate "Onboard USB device support"
> -	depends on OF
> +	depends on OF && !ACPI
>  	help
>  	  Say Y here if you want to support discrete onboard USB devices
>  	  that don't require an additional control bus for initialization,
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

