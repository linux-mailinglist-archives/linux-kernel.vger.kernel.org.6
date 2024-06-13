Return-Path: <linux-kernel+bounces-212776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42F906627
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A01D1F23809
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202EA13D24F;
	Thu, 13 Jun 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LGTuxrcn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626AE13C90B;
	Thu, 13 Jun 2024 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265989; cv=none; b=iXmJWgkH+0CnyRrv9uFjFQKt+p+H8Qb+HEJw5ZtxsV8FUttDa3QWd1cFfCqj821KAbPhmuCZbFgmp5wtM70OjGeJ9IWChaYgRrIve17lQqYrDaaRTXaVpZ2NL2JBcV645S9R4aPLwxw43+wYG1KZx64omMu0HGz83E3XA7Z+UCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265989; c=relaxed/simple;
	bh=dRmC8fxGxGymh2AgVLo6sE01C4CxqjhSMs7uPX5cl50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX/5R+ezl0uLT8yjoBpukVPvydn56gtN6ocKcz1mK51wGGSUv+5Sq2w6HR5loA4pp2nVKTpmu7MNPiMoHMIFJz4+AfkGB8OxPt7HG0kjevLFIBUPvmqgL0g8xIs1Qx60zNqKTYt8RXAbodG9EnAhkCc+cQVISnpvXx7MbpuXVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LGTuxrcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97FAC2BBFC;
	Thu, 13 Jun 2024 08:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265989;
	bh=dRmC8fxGxGymh2AgVLo6sE01C4CxqjhSMs7uPX5cl50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGTuxrcnW5OQKSBpMHwWupnu3OWCeC/Bbjwa9S+I/Vtb21XhpDMT7ORzXNAyjNXf0
	 7pfiLx0CnpnzdP6c4lTfbvvSt+ML726WPAATzWby8Mi7bUH7dCGDF55BvzlbJACwHq
	 atrYOIdz7x0NrXHIdL38kt9o+LZSXK/i52Vn4IkY=
Date: Thu, 13 Jun 2024 10:06:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Meng Li <Meng.Li@windriver.com>
Cc: Thinh.Nguyen@synopsys.com, quic_uaggarwa@quicinc.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Message-ID: <2024061313-october-sniff-5b0c@gregkh>
References: <20240613073959.1939608-1-Meng.Li@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613073959.1939608-1-Meng.Li@windriver.com>

On Thu, Jun 13, 2024 at 03:39:59PM +0800, Meng Li wrote:
> When config CONFIG_USB_DWC3_DUAL_ROLE is selected, and trigger system
> to enter suspend status with below command:
> echo mem > /sys/power/state
> There will be a deadlock issue occurring. Because dwc3_gadget_suspend() also
> try to get the lock again when previous invoked dwc3_suspend_common() has
> got the lock . This issue is introduced by commit c7ebd8149ee5 ("usb: dwc3:
> gadget: Fix NULL pointer dereference in dwc3_gadget_suspend") that removes
> the code of checking whether dwc->gadget_driver is NULL or not. It causes the
> following code is executed and deadlock occurs when trying to get the spinlock.
> To fix the deadlock issue, refer to commit 5265397f9442("usb: dwc3: Remove
> DWC3 locking during gadget suspend/resume"), remove lock of otg mode during
> gadget suspend/resume.
> 
> Fixes: 61a348857e86 ("Fix NULL pointer dereference in dwc3_gadget_suspend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/usb/dwc3/core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 7ee61a89520b..9d47c3aa5777 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2250,7 +2250,6 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
>  
>  static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  {
> -	unsigned long	flags;
>  	u32 reg;
>  	int i;
>  
> @@ -2293,9 +2292,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  			break;
>  
>  		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
> -			spin_lock_irqsave(&dwc->lock, flags);
>  			dwc3_gadget_suspend(dwc);
> -			spin_unlock_irqrestore(&dwc->lock, flags);
>  			synchronize_irq(dwc->irq_gadget);
>  		}
>  
> @@ -2312,7 +2309,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  
>  static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  {
> -	unsigned long	flags;
>  	int		ret;
>  	u32		reg;
>  	int		i;
> @@ -2366,9 +2362,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
>  			dwc3_otg_host_init(dwc);
>  		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
> -			spin_lock_irqsave(&dwc->lock, flags);
>  			dwc3_gadget_resume(dwc);
> -			spin_unlock_irqrestore(&dwc->lock, flags);
>  		}
>  
>  		break;
> -- 
> 2.34.1
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

