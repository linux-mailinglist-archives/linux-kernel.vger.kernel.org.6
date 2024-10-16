Return-Path: <linux-kernel+bounces-367593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9006C9A0434
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176DF1F26823
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6809C1C4A28;
	Wed, 16 Oct 2024 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P+o3Xo6r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B671C4A2B;
	Wed, 16 Oct 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067262; cv=none; b=CQATgcWc+3Y3eJVFqRiJdh8QixJ9COS/6rKwyQFjk2ecAkPF1/yFZARyWBtpCr6LmS2GsvFCjuCPEUI1JtsCFYdMOmIf8VKFu9MOVBLoamUCn0pDMNwCnVdqPUuWgCt94Jxp8XU0esL0sau+C3UIR6DxZ4ae5pDbYWht2zpFvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067262; c=relaxed/simple;
	bh=8RD/VOzmlDwwtrSA+gQBG+6osbDmJnW21kPNiXA0F+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIpU1qhbfcF2NPOHBk+auQMR9H/Ea8Y07obkwgOHWZ4OhCz9nbmJ9LHHxiuxnht7JYRwN0Rz3ewtXIYw3GCW4nSC3iwC3je1z5qZJ6ijtCGT0lyBoyFRJz+uWrMGOFvmqPhe6VkY3J0y8bqJ+EQYnMTdHY15euOYZp7Zbf1ljAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P+o3Xo6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EEEC4CEC5;
	Wed, 16 Oct 2024 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729067262;
	bh=8RD/VOzmlDwwtrSA+gQBG+6osbDmJnW21kPNiXA0F+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+o3Xo6rt58y99ocXZmPwF6b0aRHio0aDP6p1EF9OrhoSoSLuhU0tDJdRSqLz2/72
	 bUt10i708fmWOxyfPFWnIoGdY5IPO6re8hqVz46/w2XtOVY8ZjVEIoC1ICAc1EVFdC
	 QsLd5aYoajDJC1uHSVMv6R/cE0x6VafyLlkODM9Q=
Date: Wed, 16 Oct 2024 10:27:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Bin Liu <b-liu@ti.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: musb: Fix hardware lockup on first Rx endpoint
 request
Message-ID: <2024101625-fetal-oboe-1b9a@gregkh>
References: <e905e5d9c3e76786f154a87d54690fe1a90d755a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e905e5d9c3e76786f154a87d54690fe1a90d755a.camel@gmail.com>

On Sat, Oct 05, 2024 at 03:19:10PM +0200, Hubert Wiśniewski wrote:
> There is a possibility that a request's callback could be invoked from
> usb_ep_queue() (call trace below, supplemented with missing calls):
> 
> req->complete from usb_gadget_giveback_request
> 	(drivers/usb/gadget/udc/core.c:999)
> usb_gadget_giveback_request from musb_g_giveback
> 	(drivers/usb/musb/musb_gadget.c:147)
> musb_g_giveback from rxstate
> 	(drivers/usb/musb/musb_gadget.c:784)
> rxstate from musb_ep_restart
> 	(drivers/usb/musb/musb_gadget.c:1169)
> musb_ep_restart from musb_ep_restart_resume_work
> 	(drivers/usb/musb/musb_gadget.c:1176)
> musb_ep_restart_resume_work from musb_queue_resume_work
> 	(drivers/usb/musb/musb_core.c:2279)
> musb_queue_resume_work from musb_gadget_queue
> 	(drivers/usb/musb/musb_gadget.c:1241)
> musb_gadget_queue from usb_ep_queue
> 	(drivers/usb/gadget/udc/core.c:300)
> 
> According to the docstring of usb_ep_queue(), this should not happen:
> 
> "Note that @req's ->complete() callback must never be called from within
> usb_ep_queue() as that can create deadlock situations."
> 
> In fact, a hardware lockup might occur in the following sequence:
> 
> 1. The gadget is initialized using musb_gadget_enable().
> 2. Meanwhile, a packet arrives, and the RXPKTRDY flag is set, raising an
>    interrupt.
> 3. If IRQs are enabled, the interrupt is handled, but musb_g_rx() finds an
>    empty queue (next_request() returns NULL). The interrupt flag has
>    already been cleared by the glue layer handler, but the RXPKTRDY flag
>    remains set.
> 4. The first request is enqueued using usb_ep_queue(), leading to the call
>    of req->complete(), as shown in the call trace above.
> 5. If the callback enables IRQs and another packet is waiting, step (3)
>    repeats. The request queue is empty because usb_g_giveback() removes the
>    request before invoking the callback.
> 6. The endpoint remains locked up, as the interrupt triggered by hardware
>    setting the RXPKTRDY flag has been handled, but the flag itself remains
>    set.
> 
> For this scenario to occur, it is only necessary for IRQs to be enabled at
> some point during the complete callback. This happens with the USB Ethernet
> gadget, whose rx_complete() callback calls netif_rx(). If called in the
> task context, netif_rx() disables the bottom halves (BHs). When the BHs are
> re-enabled, IRQs are also enabled to allow soft IRQs to be processed. The
> gadget itself is initialized at module load (or at boot if built-in), but
> the first request is enqueued when the network interface is brought up,
> triggering rx_complete() in the task context via ioctl(). If a packet
> arrives while the interface is down, it can prevent the interface from
> receiving any further packets from the USB host.
> 
> The situation is quite complicated with many parties involved. This
> particular issue can be resolved in several possible ways:
> 
> 1. Ensure that callbacks never enable IRQs. This would be difficult to
>    enforce, as discovering how netif_rx() interacts with interrupts was
>    already quite challenging and u_ether is not the only function driver.
>    Similar "bugs" could be hidden in other drivers as well.
> 2. Disable MUSB interrupts in musb_g_giveback() before calling the callback
>    and re-enable them afterwars (by calling musb_{dis,en}able_interrupts(),
>    for example). This would ensure that MUSB interrupts are not handled
>    during the callback, even if IRQs are enabled. In fact, it would allow
>    IRQs to be enabled when releasing the lock. However, this feels like an
>    inelegant hack.
> 3. Modify the interrupt handler to clear the RXPKTRDY flag if the request
>    queue is empty. While this approach also feels like a hack, it wastes
>    CPU time by attempting to handle incoming packets when the software is
>    not ready to process them.
> 4. Flush the Rx FIFO instead of calling rxstate() in musb_ep_restart().
>    This ensures that the hardware can receive packets when there is at
>    least one request in the queue. Once IRQs are enabled, the interrupt
>    handler will be able to correctly process the next incoming packet
>    (eventually calling rxstate()). This approach may cause one or two
>    packets to be dropped (two if double buffering is enabled), but this
>    seems to be a minor issue, as packet loss can occur when the software is
>    not yet ready to process them. Additionally, this solution makes the
>    gadget driver compliant with the rule mentioned in the docstring of
>    usb_ep_queue().
> 
> There may be additional solutions, but from these four, the last one has
> been chosen as it seems to be the most appropriate, as it addresses the
> "bad" behavior of the driver.
> 
> Signed-off-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
> ---
>  drivers/usb/musb/musb_gadget.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index bdf13911a1e5..c6076df0d50c 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1161,12 +1161,19 @@ void musb_free_request(struct usb_ep *ep, struct usb_request *req)
>   */
>  void musb_ep_restart(struct musb *musb, struct musb_request *req)
>  {
> +	u16 csr;
> +	void __iomem *epio = req->ep->hw_ep->regs;
> +
>  	trace_musb_req_start(req);
>  	musb_ep_select(musb->mregs, req->epnum);
> -	if (req->tx)
> +	if (req->tx) {
>  		txstate(musb, req);
> -	else
> -		rxstate(musb, req);
> +	} else {
> +		csr = musb_readw(epio, MUSB_RXCSR);
> +		csr |= MUSB_RXCSR_FLUSHFIFO | MUSB_RXCSR_P_WZC_BITS;
> +		musb_writew(epio, MUSB_RXCSR, csr);
> +		musb_writew(epio, MUSB_RXCSR, csr);
> +	}
>  }
>  
>  static int musb_ep_restart_resume_work(struct musb *musb, void *data)
> 
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> -- 
> 2.30.2
> 
> 

What commit id does this fix?

thanks,

greg k-h

