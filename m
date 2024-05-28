Return-Path: <linux-kernel+bounces-191872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7278D155E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5AD9B23632
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66858745C2;
	Tue, 28 May 2024 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M10WnakR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186173474;
	Tue, 28 May 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716881432; cv=none; b=iTflqCtuy/5H76X63JuJ/TJR7FS51Ffkq8zr59ludZ2P+vgV5XwqPqWdOw14YFgVpvncIJZK2DnC4I1XfVOAaJ5BqV0vZ8YzsyOLW1vRdbfBsGOJqc8EAY13RGFNvywdGexBElGNjKnl6YYi1luJ6cFA2ESv9Fdv1m+H+XQZPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716881432; c=relaxed/simple;
	bh=wky2UOR7xT77sN2zh228jjq+dgKG+IguwbF01IlPNt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4Yuu7APRCooz7OZczHPm/TM+NvFQaGlFbpRQ+CCUaRUrKjNO9pR8nEn3Vr+2m+m0CoY/woM7cuIgihhOvILWqgEZlTqc53SmmLZAJm4vS4CiImYEmkAMpc2iHUXCiAVkJsDrSExcj3rV90zZ3tZyPwGCPlMDqSxNmcukaVo9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M10WnakR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17811C32781;
	Tue, 28 May 2024 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716881431;
	bh=wky2UOR7xT77sN2zh228jjq+dgKG+IguwbF01IlPNt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M10WnakRct4rLxx8cafbzbhZ40GauBojJSLPUPVB0AWMDlIbImOUlyfDXXQWQfdHz
	 FwRFWnTAg5ty/psPkSan6316VAYZkOgzZYZt9t4mI1TPNgpfuE6b2u+DabVT/1j9rJ
	 Ce3eE58GB2dPEp8GsFSUWUczN1jQUQUadW5vGh9I=
Date: Tue, 28 May 2024 09:30:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daehwan Jung <dh10.jung@samsung.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	"open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH] usb: host: Add a quirk for writing ERST in high-low order
Message-ID: <2024052838-fifth-liver-fb4e@gregkh>
References: <CGME20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc@epcas2p4.samsung.com>
 <1716875836-186791-1-git-send-email-dh10.jung@samsung.com>
 <2024052814-exponent-domestic-6da2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052814-exponent-domestic-6da2@gregkh>

On Tue, May 28, 2024 at 09:23:43AM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 28, 2024 at 02:57:16PM +0900, Daehwan Jung wrote:
> > [Synopsys]- The host controller was design to support ERST setting
> > during the RUN state. But since there is a limitation in controller
> > in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> > It is supported when the ERSTBA is programmed in 64bit,
> > or in 32 bit mode ERSTBA_HI before ERSTBA_LO
> > 
> > [Synopsys]- The internal initialization of event ring fetches
> > the "Event Ring Segment Table Entry" based on the indication of
> > ERSTBA_LO written.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/host/xhci-mem.c | 5 ++++-
> >  drivers/usb/host/xhci.h     | 2 ++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> > index 3100219..ef768e6 100644
> > --- a/drivers/usb/host/xhci-mem.c
> > +++ b/drivers/usb/host/xhci-mem.c
> > @@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
> >  	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
> >  	erst_base &= ERST_BASE_RSVDP;
> >  	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
> > -	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> > +	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
> > +		hi_lo_writeq(erst_base, &ir->ir_set->erst_base);
> > +	else
> > +		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> >  
> >  	/* Set the event ring dequeue address of this interrupter */
> >  	xhci_set_hc_event_deq(xhci, ir);
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index 3041515..8664dd1 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -17,6 +17,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/usb/hcd.h>
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/io-64-nonatomic-hi-lo.h>

Why not put this in the .c file?

> >  /* Code sharing between pci-quirks and xhci hcd */
> >  #include	"xhci-ext-caps.h"
> > @@ -1627,6 +1628,7 @@ struct xhci_hcd {
> >  #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
> >  #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
> >  #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
> > +#define XHCI_WRITE_64_HI_LO	BIT_ULL(47)

Note, you define this, and check it, but it is never set, so this patch
is useless on its own and so we can not accept it as-is at all.

How was this tested?

thanks,

greg k-h

