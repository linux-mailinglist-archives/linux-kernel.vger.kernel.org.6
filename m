Return-Path: <linux-kernel+bounces-296854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5699495AFD2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D49281CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A0C16D9AF;
	Thu, 22 Aug 2024 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wNANmtRL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82019470;
	Thu, 22 Aug 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313767; cv=none; b=taCyMxXg5lSX6Fu3tiurjcsRqGt+Ugg5IQfAH+IR0CzK7HUMZ/Oe5xLb826TALPO4uQAlma73dQguILUY8Q70ele8PMDnKuRKVcSaGiPfKQyMhhPI6/zqfdzJt9aJnFLEM2ymyiO79yqb60pEzR2HoNOV/qsEEM1CZMc6paJmes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313767; c=relaxed/simple;
	bh=RkefZNrQirlUY7AaUT07nuSkCcS3AOBxotcAP12aurM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSJKzQmaOl3+kTdh/0BbOguZmXLLAmpnVNt8/3lWOHcHweZQOxoUQvDST/3w5P4UUugyh2m14NjvdXnYfcptrciKQsom05Ni0s1FG68xDC78tSe3wTY+FbOKVi5l4n5hgmm/ieMhyqCziSkma1xelguCxrhwQcHzTUVol7vhuO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wNANmtRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90AAC4AF09;
	Thu, 22 Aug 2024 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724313767;
	bh=RkefZNrQirlUY7AaUT07nuSkCcS3AOBxotcAP12aurM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wNANmtRL0kgxdvVBwmJ9I4shPJN8feQ28XYLkei1beJv3t3HEeyea+QccTgkuDf5j
	 vePCUzuHbgc5G9SyJmKMYwWjUaS+uwKicUmY14S7F4KnOf5yEw3c143pIi7cOQ2gkp
	 Cmf540TDZNLPlXYHDDf0lPqJ+AznccpxvKLQu6sw=
Date: Thu, 22 Aug 2024 16:02:44 +0800
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: Prashanth K <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v6] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Message-ID: <2024082251-grief-profanity-b0da@gregkh>
References: <TYUPR06MB62171A7BF25AB6963CBA07FED28F2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB62171A7BF25AB6963CBA07FED28F2@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Thu, Aug 22, 2024 at 02:34:11AM +0000, 胡连勤 wrote:
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Considering that in some extreme cases, when the unbind operation
> is being executed, gserial_disconnect has already cleared gser->ioport,
> and the controller has not stopped & pullup 0, sys.usb.config is reset
> and the bind operation will be re-executed, calling gs_read_complete,
> which will result in accessing gser->iport, resulting in a null pointer
> dereference, add a null pointer check to prevent this situation.
> 
> Added a static spinlock to prevent gser->ioport from becoming
> null after the newly added check.
> 
> Unable to handle kernel NULL pointer dereference at
> virtual address 00000000000001a8
> pc : gs_read_complete+0x58/0x240
> lr : usb_gadget_giveback_request+0x40/0x160
> sp : ffffffc00f1539c0
> x29: ffffffc00f1539c0 x28: ffffff8002a30000 x27: 0000000000000000
> x26: ffffff8002a30000 x25: 0000000000000000 x24: ffffff8002a30000
> x23: ffffff8002ff9a70 x22: ffffff898e7a7b00 x21: ffffff803c9af9d8
> x20: ffffff898e7a7b00 x19: 00000000000001a8 x18: ffffffc0099fd098
> x17: 0000000000001000 x16: 0000000080000000 x15: 0000000ac1200000
> x14: 0000000000000003 x13: 000000000000d5e8 x12: 0000000355c314ac
> x11: 0000000000000015 x10: 0000000000000012 x9 : 0000000000000008
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffffff887cd12000
> x5 : 0000000000000002 x4 : ffffffc00f9b07f0 x3 : ffffffc00f1538d0
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000000001a8
> Call trace:
> gs_read_complete+0x58/0x240
> usb_gadget_giveback_request+0x40/0x160
> dwc3_remove_requests+0x170/0x484
> dwc3_ep0_out_start+0xb0/0x1d4
> __dwc3_gadget_start+0x25c/0x720
> kretprobe_trampoline.cfi_jt+0x0/0x8
> kretprobe_trampoline.cfi_jt+0x0/0x8
> udc_bind_to_driver+0x1d8/0x300
> usb_gadget_probe_driver+0xa8/0x1dc
> gadget_dev_desc_UDC_store+0x13c/0x188
> configfs_write_iter+0x160/0x1f4
> vfs_write+0x2d0/0x40c
> ksys_write+0x7c/0xf0
> __arm64_sys_write+0x20/0x30
> invoke_syscall+0x60/0x150
> el0_svc_common+0x8c/0xf8
> do_el0_svc+0x28/0xa0
> el0_svc+0x24/0x84
> el0t_64_sync_handler+0x88/0xec
> el0t_64_sync+0x1b4/0x1b8
> Code: aa1f03e1 aa1303e0 52800022 2a0103e8 (88e87e62)
> ---[ end trace 938847327a739172 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> 
> Fixes: c1dca562be8a ("usb gadget: split out serial core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
> v6:
>   - Update the commit text
>   - Add the Fixes tag
>   - CC stable kernel
>   - Add serial_port_lock protection when checking port pointer
>   - Optimize code comments
>   - Delete log printing

You need to list ALL of the versions here, I seem to have missed v4 and
v5 somewhere so I don't know what changed there.



> ---
>  drivers/usb/gadget/function/u_serial.c | 33 ++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index b394105e55d6..e43d8065f7ec 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -452,20 +452,43 @@ static void gs_rx_push(struct work_struct *work)
>  
>  static void gs_read_complete(struct usb_ep *ep, struct usb_request *req)
>  {
> -	struct gs_port	*port = ep->driver_data;
> +	struct gs_port	*port;
> +	unsigned long  flags;
> +
> +	spin_lock_irqsave(&serial_port_lock, flags);
> +	port = ep->driver_data;
> +
> +	/* When port is NULL, return to avoid panic. */

This comment is not needed, it's obvious that you check before
dereference.

BUT you can mention that you are trying to check with the race somewhere
else, right?  Please do that, and document here where that race is at
that you are doing this extra locking for.

> +	if (!port) {
> +		spin_unlock_irqrestore(&serial_port_lock, flags);
> +		return;
> +	}
>  
> -	/* Queue all received data until the tty layer is ready for it. */
>  	spin_lock(&port->port_lock);
> +	spin_unlock(&serial_port_lock);

nested spinlocks, why?  Did you run this with lockdep enabled to verify
you aren't hitting a different bug now?

And why is one irqsave and one not?  That feels odd, it might be right,
but you need to document here why the difference.

> +
> +	/* Queue all received data until the tty layer is ready for it. */
>  	list_add_tail(&req->list, &port->read_queue);
>  	schedule_delayed_work(&port->push, 0);
> -	spin_unlock(&port->port_lock);
> +	spin_unlock_irqrestore(&port->port_lock, flags);
>  }
>  
>  static void gs_write_complete(struct usb_ep *ep, struct usb_request *req)
>  {
> -	struct gs_port	*port = ep->driver_data;
> +	struct gs_port	*port;
> +	unsigned long  flags;
> +
> +	spin_lock_irqsave(&serial_port_lock, flags);
> +	port = ep->driver_data;
> +
> +	/* When port is NULL, return to avoid panic. */

Same comments as above.

thanks,

greg k-h

