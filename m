Return-Path: <linux-kernel+bounces-227341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16DF914FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B081282467
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2317BB1B;
	Mon, 24 Jun 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BW33TQUy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C20514D294;
	Mon, 24 Jun 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238878; cv=none; b=EUZg33I/2qEstAyKZMVtC+KblK1ZmzRig2I9vA37a4OiE4e9hrvTGCJXrMASUkikS7KeKWbjZLlBlGR5Qv2jXKVjiHiTx/QRzdviaXqm9g1eS6UT3aFE+AlouotGojHXtslYee8Q+1gzkuo+l6FmEfEcBV2g4JWfh5pVJar4Xlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238878; c=relaxed/simple;
	bh=Pjqrb8+wFHR1mGeMA625VXKLN5bcap7zHfFbkRKORj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmPXjn3DgzuFm48aM2aBVVMDLEeQqVUunHCKlmXYjrKqnFGX0nwoMSYHlsN4MNC0Fu2tacEaxBKxV52Csz3qgmj8VEPfyIlrXcgxEr2OcnqRQF0CRhkSjh7ZKmMVMM3q7znVZ3JPcUb1483bK2ekT8e4Gf3R/+NoL+jE/TRitDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BW33TQUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9769EC4AF0C;
	Mon, 24 Jun 2024 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719238876;
	bh=Pjqrb8+wFHR1mGeMA625VXKLN5bcap7zHfFbkRKORj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BW33TQUyWAv0krdvhK3ThO1kHwVz1Ijn+D89YF5vkpPsMtJqcJtqMFIIQnQ7ifqOV
	 vkj9JFgWkLZwm/GiHUdz4L1QukNeI6GDvuL72rEgUYr/Rxz41/0fFQTzsl7eT23krn
	 4+bM7aQoqB6MfhbBucAgLAuZJG5QAJS1Inv4Mvqo=
Date: Mon, 24 Jun 2024 16:21:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: neal_liu@aspeedtech.com, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
Message-ID: <2024062400-yearning-curfew-3c9d@gregkh>
References: <20240624015314.2249128-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624015314.2249128-1-make24@iscas.ac.cn>

On Mon, Jun 24, 2024 at 09:53:13AM +0800, Ma Ke wrote:
> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.
> 
> Found by static analysis.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index 3916c8e2ba01..d972ef4644bc 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1009,6 +1009,8 @@ static void ast_udc_getstatus(struct ast_udc_dev *udc)
>  		break;
>  	case USB_RECIP_ENDPOINT:
>  		epnum = crq.wIndex & USB_ENDPOINT_NUMBER_MASK;
> +		if (epnum >= AST_UDC_NUM_ENDPOINTS)
> +			goto stall;
>  		status = udc->ep[epnum].stopped;
>  		break;
>  	default:
> -- 
> 2.25.1
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

