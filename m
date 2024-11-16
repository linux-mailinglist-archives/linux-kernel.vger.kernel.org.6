Return-Path: <linux-kernel+bounces-411638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1F99CFD30
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C3C1F228BC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E5A192B75;
	Sat, 16 Nov 2024 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xf9uzds6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7619146E;
	Sat, 16 Nov 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731744362; cv=none; b=ncByz6OZ05jep/F7IVsNGPvKvJt9aH7+b8Rn0DaVOePM1LWyb/P/WjLj3zfiFD+v4yGcuAfJof38UmPi30PEMqCKwrCDRqWFgo/zwDZTooY9LWZLt4CJINaC4rBROfyEGX3G++J31TBZnx9gF2v0+U6wvrO19OCCNPS7dTegFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731744362; c=relaxed/simple;
	bh=bQ/rmffOm2v/gX5o6y6qAx3LH5jlMVgs8emLepbSxaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hunzief3qxtb9rc6dwYsor9ayylHKchb7xmv4ww0uttzzU8mrl061XtMSXNZ7N9ooeAJHNCLb+NiyOm4pDrITQh8dFt+jAfjM8rb3U99YId2PLFdL0xyLEZBc3oDFF2/YoFx9RRZtQ+Ddhe1kn4THi+SveLREFaBP/4URkwfjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xf9uzds6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B116C4CEC3;
	Sat, 16 Nov 2024 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731744361;
	bh=bQ/rmffOm2v/gX5o6y6qAx3LH5jlMVgs8emLepbSxaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xf9uzds67a2eJp61+uQC+qqZv1QVVn0+RSAOWiwwWjYIF1EhHjWsN1AZMDM6SdxzX
	 SBjeQf6v6VK8J+BtJbjKxXFd9I0z8UEowkx1QIVUJ2uUlrULO8kAICykISe5GBxgzv
	 5bqQHEy62GZjD5G2b+q9acu9nehbEeh5ftB1XUFI=
Date: Sat, 16 Nov 2024 09:05:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Thinh.Nguyen@synopsys.com, michal.simek@amd.com,
	robert.hancock@calian.com, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, Neal Frager <neal.frager@amd.com>
Subject: Re: [PATCH] usb: dwc3: xilinx: make sure pipe clock is deselected in
 usb2 only mode
Message-ID: <2024111625-afraid-pencil-b567@gregkh>
References: <1731695460-1814409-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1731695460-1814409-1-git-send-email-radhey.shyam.pandey@amd.com>

On Sat, Nov 16, 2024 at 12:01:00AM +0530, Radhey Shyam Pandey wrote:
> From: Neal Frager <neal.frager@amd.com>
> 
> When the USB3 PHY is not defined in the Linux device tree, there could
> still be a case where there is a USB3 PHY is active on the board and
> enabled by the first stage bootloader.  If serdes clock is being used
> then the USB will fail to enumerate devices in 2.0 only mode.
> 
> To solve this, make sure that the PIPE clock is deselected whenever the
> USB3 PHY is not defined and guarantees that the USB2 only mode will work
> in all cases.
> 
> Fixes: 9678f3361afc ("usb: dwc3: xilinx: Skip resets and USB3 register settings for USB2.0 mode")
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  drivers/usb/dwc3/dwc3-xilinx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
> index e3738e1610db..a33a42ba0249 100644
> --- a/drivers/usb/dwc3/dwc3-xilinx.c
> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> @@ -121,8 +121,11 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>  	 * in use but the usb3-phy entry is missing from the device tree.
>  	 * Therefore, skip these operations in this case.
>  	 */
> -	if (!priv_data->usb3_phy)
> +	if (!priv_data->usb3_phy) {
> +		/* Deselect the PIPE Clock Select bit in FPD PIPE Clock register */
> +		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
>  		goto skip_usb3_phy;
> +	}
>  
>  	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
>  	if (IS_ERR(crst)) {
> 
> base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
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

