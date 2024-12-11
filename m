Return-Path: <linux-kernel+bounces-441588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F29ED070
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D965A16C80F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA31D1D0F50;
	Wed, 11 Dec 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bNJWgtxs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEAC1CB9E2;
	Wed, 11 Dec 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932195; cv=none; b=EXAEz9sNTo86S7suTYypO1PpCmYdZuHuudgqs7S9n2Kj9vR0AxIgTpa/DfTKmZNrHUsadKIeAIKM+agrr/uhGuOe+uUVPAUNhxLYWcSnQeLAA6fS5JeT/eEiNpCxiaeiJNTgyDYqfY4NOPwSI9uW5BKHdmyMft71NaTTKQl6Vs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932195; c=relaxed/simple;
	bh=YOJGGRfp8+qF19EtEIelJTodNG+/t3iDdU57j118hgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eh67ikPweIvmmY1jxpLo8V+cq3IJTuL7jEEzBwXbMyFa7+mTjnGeW/PpwqSqYZSoE2M4lxnU1VZWnT9DWYQHMIi8cn27JAf2+hlLk9cr6vtZl9UGmhB68G2qlOiWNoe9xFXLVNEFa0MK7NC5gsbSFnA+hu+LZuCwDOnTdN2ykwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bNJWgtxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C82CC4CED2;
	Wed, 11 Dec 2024 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733932194;
	bh=YOJGGRfp8+qF19EtEIelJTodNG+/t3iDdU57j118hgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNJWgtxsOcTOvXRlyiNqhaS/Z6p+XcqQ4WVRb1CS7fAjvH4Tf4PL25iqXpoA6l8Yy
	 hJ4HXAHLN7DlktaScESt02pHJvlmk3OBr7WoIWaFP8wHsoMEJBMlwbTNpmnXfRNAZU
	 AtSjAOLMOrGlwmZAFGEKCU64Y413a+y8Z53jjc/Y=
Date: Wed, 11 Dec 2024 16:49:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: zaitcev@redhat.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@jeremyfiggins.com
Subject: Re: [PATCH] USB: usblp: return error when setting unsupported
 protocol
Message-ID: <2024121141-bobtail-retiree-5ba6@gregkh>
References: <20241211154244.534745-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211154244.534745-1-jerrysteve1101@gmail.com>

On Wed, Dec 11, 2024 at 11:42:43PM +0800, Jun Yan wrote:
> Fix the regression introduced by commit d8c6edfa3f4e ("USB:
> usblp: don't call usb_set_interface if there's a single alt"),
> which causes that unsupported protocols can also be set via
> ioctl when the num_altsetting of the device is 0.
> 
> Move the check for protocol support to the earlier stage.
> 
> Fixes: d8c6edfa3f4e ("USB: usblp: don't call usb_set_interface if there's a single alt")
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> ---
>  drivers/usb/class/usblp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
> index 5a2e43331064..ff1a941fd2ed 100644
> --- a/drivers/usb/class/usblp.c
> +++ b/drivers/usb/class/usblp.c
> @@ -1337,11 +1337,12 @@ static int usblp_set_protocol(struct usblp *usblp, int protocol)
>  	if (protocol < USBLP_FIRST_PROTOCOL || protocol > USBLP_LAST_PROTOCOL)
>  		return -EINVAL;
>  
> +	alts = usblp->protocol[protocol].alt_setting;
> +	if (alts < 0)
> +		return -EINVAL;
> +
>  	/* Don't unnecessarily set the interface if there's a single alt. */
>  	if (usblp->intf->num_altsetting > 1) {
> -		alts = usblp->protocol[protocol].alt_setting;
> -		if (alts < 0)
> -			return -EINVAL;
>  		r = usb_set_interface(usblp->dev, usblp->ifnum, alts);
>  		if (r < 0) {
>  			printk(KERN_ERR "usblp: can't set desired altsetting %d on interface %d\n",
> -- 
> 2.47.1
> 
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

