Return-Path: <linux-kernel+bounces-340108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9EE986EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AB71F229B9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EA51A4B9A;
	Thu, 26 Sep 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0mkr27mG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20E143C4C;
	Thu, 26 Sep 2024 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338811; cv=none; b=oCf2MN7CcrsFnIObBKeM4j8sz/zxaQP7X2cadBuPK3EygeqXpt6HwafdXfxjc8MngP0F4g67BWhnGzOZo9mECCKbTv70YWxm6uc8D1Lfu2Ar8JOAY5MRsM5h1OIkC23LpBj9NsQ6pxly5IL5reOfP1SgmlI3XJCHdo8Ig6SRx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338811; c=relaxed/simple;
	bh=SSArUtZW+e4M0Yj2qXbYhvCyNE4EueOXvXx6gijkGgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RErPU8mx7MkNozlUbfFk6p+/Dqmv8O19DYFtGSO7bGFxop+KLs4n8yV5RbkiFoTahHL2av16joFVcd0kmiS13DdpMFy1cJ7J0tsJ3tXu4KfnwO5raL27lCxgpDIYPHzqshl541oTaI/4FOuTQmSOLkb+bST5/OMDMOS59Jbjgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0mkr27mG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BE9C4CEC5;
	Thu, 26 Sep 2024 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727338810;
	bh=SSArUtZW+e4M0Yj2qXbYhvCyNE4EueOXvXx6gijkGgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0mkr27mGb7rUKaOkgOYv5LlkC533WO+v9eS29JU95NjNLiOVCIm2vubkQCbRhIse7
	 RL7T4n/pPDKvFIVetHG2mYOa1KQIXWY1HOG4nYDDjgjH9B7vaJc3O/cesAkikGIS6E
	 cKJGuYYPiE7jHuCv65If+xN2Cxem1E4zOkCJGX+4=
Date: Thu, 26 Sep 2024 10:20:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: hbuczynski <hubert.buczynski94@gmail.com>
Cc: balbi@kernel.org, quic_prashk@quicinc.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"hubert.buczynski" <Hubert.Buczynski.ext@feig.de>
Subject: Re: [PATCH] usb: gadget: u_serial: fix null-ptr-deref in gs_start_io
Message-ID: <2024092617-confined-liqueur-f4fa@gregkh>
References: <20240926064910.17429-1-hubert.buczynski94@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240926064910.17429-1-hubert.buczynski94@gmail.com>

On Thu, Sep 26, 2024 at 08:49:10AM +0200, hbuczynski wrote:
> From: "hubert.buczynski" <Hubert.Buczynski.ext@feig.de>

Please put your name here, not an email alias, same for the
signed-off-by line.

> The commit "5a444bea usb: gadget: u_serial: Set start_delayed during
> suspend" caused invocation of the gs_start_io in the gserial_resume.
> The gs_start_io doesn't check the ptr of the 'port.tty'. As a result, the
> tty_wakeup function is passed on to the NULL ptr causing kernel panic.
> 
> There is a deterministic scenario leading to the kernel error:
> 1. Set the device in peripheral OTG mode.
> 2. Attach the USB cable to the host.
> 3. Do not take any action on the host side.
> 4. Send data to the host, for example:
> $ echo "hello\n" > /dev/ttyGS0
> 5. Disconnect the USB cable.
> 6. Connect the USB cable and the kernel panic should be visible.
> 
> Fragment of the kernel panic log message:
> 
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: P O 5.15.166 #88
> Hardware name: STM32 hDevice Tree Support)
> PC is at tty_wakeup+0x8/0x5c
> LR is at gs_start_io+0x90/0xdc
> pc : [<c0623f74>]    lr : [<c083eeac>]    psr: 60010193
> sp : c1001da0  ip : c32e6944  fp : 80000000
> r10: c32e6934  r9 : c32e6928  r8 : c32e68ec
> r7 : c32e68e0  r6 : c2be6c40  r5 : 00000000  r4 : 00000000
> r3 : 00000000  r2 : 00000000  r1 : 60010193  r0 : 00000000
> Flags: nZC»  IRQs off  FIQs on  Mode SVC_32  ISA ARM Segment none
> Control: 10c5387d  Table: c3ac406a  DAC: 00000051
> Register r0 information: NULL pointer
> Register r1 information: non-paged memory
> Register r2 information: NULL pointer
> Register r3 information: NULL pointer
> Register r4 information: NULL pointer
> Register r5 information: NULL pointer
> [<c0623f74>] (tty_wakeup) from [<c083eeac>] (gs_start_io+0x90/0xdc)
> [<c083eeac>] (gs_start_io) from [<c083f0c0>](gserial_resume+0x6c/0xd4)
> [<c083f0c0>] (gserial_resume) from [<c082a35c>] (composite_resume+0x70/0x10c)
> [<c082a35c>] (composite_resume) from [<c082d668>] (configfs_composite_resume+0x54/0x64)
> [<c082d668>] (configfs_composite_resume) from [<c07c26c4>] (dwc2_handle_wakeup_detected_intr+0x15c/0x2e8)
> [<c07c26c4>] (dwc2_handle_wakeup_detected_intr) from [<c07c2c74>] (dwc2_handle_common_intr+0x424/0x630)
> [<c07c2c74>] (dwc2_handle_common_intr) from [<c0190168>] (__handle_irq_event_percpu+0x50/0x250)
> [<c0190168>] (__handle_irq_event_percpu) from [<c0190440>] (handle_irq_event+0x58/0xc4)
> [<c0190440>] (handle_irq_event) from [<c0194f9c>] (handle_fasteoi_irq+0x9c/0x204)
> [<c0194f9c>] (handle_fasteoi_irq) from [<c018fb2c>] (handle_domain_irq+0x58/0x74)
> [<c018fb2c>] (handle_domain_irq) from [<c0101328>] (gic_handle_irq+0x7c/0x90)
> [<c0101328>] (gic_handle_irq) from [<c0100b7c>] (__irq_svc+0x5c/0x90)
> 
> If the device sends data and does not receive msg from the host then the
> field port->read_started contains a positive value. After disconnecting
> the cable, gserial_suspend() is invoked and the port->start_delayed is set
> to true. Connecting the cable again causes invocation of the
> gserial_resume().
> The callstack after connecting the cable looks like the following:
> gserial_resume()
>   --> gs_start_io()
>     --> tty_wakeup() - with NULL argument
> 
> Fixes: 5a444bea37e2 ("usb: gadget: u_serial: Set start_delayed during suspend")
> 
> Signed-off-by: hubert.buczynski <Hubert.Buczynski.ext@feig.de>
> ---
>  drivers/usb/gadget/function/u_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 5111fcc0cac3..384f219fe01d 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -564,7 +564,7 @@ static int gs_start_io(struct gs_port *port)
>  	port->n_read = 0;
>  	started = gs_start_rx(port);
>  
> -	if (started) {
> +	if (started && port->port.tty) {
>  		gs_start_tx(port);

What ensures that port.tty does not change right after you check it
here?  Hasn't this been discussed a lot already in the archives?

thanks,

greg k-h

