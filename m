Return-Path: <linux-kernel+bounces-432793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F3B9E5067
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395C8283F42
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E91D5173;
	Thu,  5 Dec 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iJWb9GOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F01D5150;
	Thu,  5 Dec 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388990; cv=none; b=NV1t3SgeX5GaadZ5oym9PI9AbUCu21a5GH1jQISzGVFMyM0jDyak9o2Dd/+TEnNAQMgaQiLcKq1k6smbixhZ59uTKaSZT8r5dUPNqjji1Ix6C5YvnkZL5/7kck4a8M1OgWRbV/T7GL4DrSe5jHBGcmKAuUWHQ1c242VHZ+5BELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388990; c=relaxed/simple;
	bh=WbhOFiAQcFbAUW1WS9HyIrjOzvS8a7+UjXpfyEyiFJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAfdUA/NIruCVBYvAsCRhxI+CYIKGa84C87aNhZ5rDCoPP//+7CVQ1DI5KGXvLEZUnO9hzY382wChpjg/1FF5W1uLQX2bi/aba5KUrmezaY5d1/heEADP7IQTzuOU/afoskfm2gPQ6mIxxcX3cpK7tPzm8gaP7pH8TKtrhhIcmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iJWb9GOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C23C4CED1;
	Thu,  5 Dec 2024 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733388990;
	bh=WbhOFiAQcFbAUW1WS9HyIrjOzvS8a7+UjXpfyEyiFJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJWb9GObaYmDV+vEVTJnI9d5gROXRRNJjN3tNfZ32cgbjI5/0QmMQvNI5wMpw86cz
	 DBymRo5l4wLfm8CIJ4tl1aEvimB1zV+lUsvuqMCB/ioo8MnW33Jth4S7/G8Ht2ZHO3
	 Hpvtl8/rqKbDrdpLr63p/RFaQrjH+Jmnn3ElxHOg=
Date: Thu, 5 Dec 2024 09:56:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wayne Chang <waynec@nvidia.com>
Subject: Re: [PATCH] USB: core: Disable LPM only for non-suspended ports
Message-ID: <2024120519-acorn-cope-af94@gregkh>
References: <20241205084205.39773-1-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205084205.39773-1-kaihengf@nvidia.com>

On Thu, Dec 05, 2024 at 04:42:05PM +0800, Kai-Heng Feng wrote:
> There's USB error when tegra board is shutting down:
> [  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
> [  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
> [  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
> [  186.157172] tegra-xusb 3610000.usb: xHCI host controller not responding, assume dead
> [  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
> [  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for evaluate context command
> 
> The issue is caused by disabling LPM on already suspended ports.
> 
> For USB2 LPM, the LPM is already disabled during port suspend. For USB3
> LPM, port won't transit to U1/U2 when it's already suspended in U3,
> hence disabling LPM is only needed for ports that are not suspended.
> 
> Cc: Wayne Chang <waynec@nvidia.com>
> Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
>  drivers/usb/core/port.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index e7da2fca11a4..d50b9e004e76 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -452,10 +452,11 @@ static int usb_port_runtime_suspend(struct device *dev)
>  static void usb_port_shutdown(struct device *dev)
>  {
>  	struct usb_port *port_dev = to_usb_port(dev);
> +	struct usb_device *udev = port_dev->child;
>  
> -	if (port_dev->child) {
> -		usb_disable_usb2_hardware_lpm(port_dev->child);
> -		usb_unlocked_disable_lpm(port_dev->child);
> +	if (udev && !pm_runtime_suspended(&udev->dev)) {
> +		usb_disable_usb2_hardware_lpm(udev);
> +		usb_unlocked_disable_lpm(udev);
>  	}
>  }
>  
> -- 
> 2.47.0
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

