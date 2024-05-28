Return-Path: <linux-kernel+bounces-191867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567408D154A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118A7284CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520EF7350C;
	Tue, 28 May 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kk8WqHsC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997C73164;
	Tue, 28 May 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716881020; cv=none; b=IpSgT9n8T3dljXp0r1SN9GzsIyhljjvf2UbFr0XKtAqmexEsWNkTHyWfdeWeCgQNb1DlLiVxRDBHmpgjz0AvhubJJdkec42sxVoo+P2FPOPWYIB5q76S+zFq09qhxAlIXMI2XMVwO+5UwxF7+xQ3CEsVTE2j3SCc+SvLRUHiDHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716881020; c=relaxed/simple;
	bh=y2/xIiY0kMyywK46Mg6C+FvZjawBDRSpFbyPSwcto/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq8an+kU4BrmsfO75l9d6XN6p5icz1AOTWBL8qptgczZVF7i4VzcrI7osHIkuit7Qj9pd7rXm64oIX4foW2jz2RQmL/DvQtQoOyNiWunjqobdj9EYYyQ8OZjCXgAECu6bA0QOmhgoDrqElWcs7ks5mDi5oztDbknABQResAFVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kk8WqHsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC3CC3277B;
	Tue, 28 May 2024 07:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716881020;
	bh=y2/xIiY0kMyywK46Mg6C+FvZjawBDRSpFbyPSwcto/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kk8WqHsC1b2VixVADEac+bviuAUjI2eAh6tJjog1WIuN+opFv/cjAAO0fqhowxNvw
	 xrBaJAVXK1ZfnLw5HSHcuHjQReis/Vbnp6+nXCvwQBTY5hckY83RjRwzeG3hKjao69
	 RgzmW0Oqg2GWoWNvquW4zTZcJkaCs0bLST4jnAdY=
Date: Tue, 28 May 2024 09:23:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daehwan Jung <dh10.jung@samsung.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	"open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH] usb: host: Add a quirk for writing ERST in high-low order
Message-ID: <2024052814-exponent-domestic-6da2@gregkh>
References: <CGME20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc@epcas2p4.samsung.com>
 <1716875836-186791-1-git-send-email-dh10.jung@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716875836-186791-1-git-send-email-dh10.jung@samsung.com>

On Tue, May 28, 2024 at 02:57:16PM +0900, Daehwan Jung wrote:
> [Synopsys]- The host controller was design to support ERST setting
> during the RUN state. But since there is a limitation in controller
> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> It is supported when the ERSTBA is programmed in 64bit,
> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
> 
> [Synopsys]- The internal initialization of event ring fetches
> the "Event Ring Segment Table Entry" based on the indication of
> ERSTBA_LO written.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/host/xhci-mem.c | 5 ++++-
>  drivers/usb/host/xhci.h     | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 3100219..ef768e6 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
>  	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
>  	erst_base &= ERST_BASE_RSVDP;
>  	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
> -	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> +	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
> +		hi_lo_writeq(erst_base, &ir->ir_set->erst_base);
> +	else
> +		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
>  
>  	/* Set the event ring dequeue address of this interrupter */
>  	xhci_set_hc_event_deq(xhci, ir);
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 3041515..8664dd1 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -17,6 +17,7 @@
>  #include <linux/kernel.h>
>  #include <linux/usb/hcd.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/io-64-nonatomic-hi-lo.h>
>  
>  /* Code sharing between pci-quirks and xhci hcd */
>  #include	"xhci-ext-caps.h"
> @@ -1627,6 +1628,7 @@ struct xhci_hcd {
>  #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
>  #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
>  #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
> +#define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
>  
>  	unsigned int		num_active_eps;
>  	unsigned int		limit_active_eps;
> -- 
> 2.7.4
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

