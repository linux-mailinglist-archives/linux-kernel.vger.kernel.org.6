Return-Path: <linux-kernel+bounces-312709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5A0969A1F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52305B24A48
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EBB1B9835;
	Tue,  3 Sep 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FBiIxbEA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245F81A0BD1;
	Tue,  3 Sep 2024 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359176; cv=none; b=AI7ftoJBIZWBOUiE7Tb5swpLBK4Jz7ilFGBGiG7cyZc0ZYIoFmHiIDjlsYWueDB19aXV01FiuxrGErbFpg9izHSGKTp7WTosok+sM7XGa9e6MZCVrS4nisBokuQRvgP5Eu2OvsoPcdvx8rR6g9xkU87BhIewB7ZETTEag2vZJAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359176; c=relaxed/simple;
	bh=KFfEcd9sdOhQ4aHFnW8EF3qln14oCQyW4WEyjUQlYZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f11dcQHDsJ/h0pzCPRGT39YqsctfPtw8VDxqub2NfDzgNiT3zED0n63+XNiwx2S9cj7r+0Sx0WotL6EJvg99ssA3xOUIc8oCZTfDx9YGnzu8FW/RoW9YG4S7vVL4WPXwuC7/xFPenao8v3DrSgIdNYZmAMGS1m7Uw8wc4UnZ01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FBiIxbEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D650C4CEC4;
	Tue,  3 Sep 2024 10:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725359175;
	bh=KFfEcd9sdOhQ4aHFnW8EF3qln14oCQyW4WEyjUQlYZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBiIxbEA8IZiHv/uMiO3cZUWEA4Cu+eB5sV6BSbQEhWXk2HXLWgkjYxfm7WdxWYv1
	 +bw+IPmKeL6yqE6jgQ5Kij65f+aZZEdArXO6RpmxDAH5kAxvH/Ps8jQL6wICqXNnKo
	 kEc35pajVzR75umBCUD+h4y3NJJLzHIKSsZ6EGWk=
Date: Tue, 3 Sep 2024 12:00:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tomas Marek <tomas.marek@elrest.cz>
Cc: hminas@synopsys.com, Arthur.Petrosyan@synopsys.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	oleg.karfich@wago.com
Subject: Re: [PATCH] usb: dwc2: drd: fix clock gating on USB role switch
Message-ID: <2024090336-unpaid-freckled-4b94@gregkh>
References: <20240903094156.6516-1-tomas.marek@elrest.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903094156.6516-1-tomas.marek@elrest.cz>

On Tue, Sep 03, 2024 at 11:41:56AM +0200, Tomas Marek wrote:
> The dwc2_handle_usb_suspend_intr() function disables gadget clocks in USB
> peripheral mode when no other power-down mode is available (introduced by
> commit 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.")).
> However, the dwc2_drd_role_sw_set() USB role update handler attempts to
> read DWC2 registers if the USB role has changed while the USB is in suspend
> mode (when the clocks are gated). This causes the system to hang.
> 
> Release gadget clocks before handling the USB role update.
> 
> Fixes: 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.")
> 
> Signed-off-by: Tomas Marek <tomas.marek@elrest.cz>
> ---
>  drivers/usb/dwc2/drd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
> index a8605b02115b..ccb33cd1f04b 100644
> --- a/drivers/usb/dwc2/drd.c
> +++ b/drivers/usb/dwc2/drd.c
> @@ -127,6 +127,18 @@ static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
>  			role = USB_ROLE_DEVICE;
>  	}
>  
> +#if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
> +	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
> +	if (dwc2_is_device_mode(hsotg)) {
> +		if (hsotg->lx_state == DWC2_L2) {
> +			if (hsotg->params.power_down ==
> +			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended &&
> +			    !hsotg->params.no_clock_gating)
> +				dwc2_gadget_exit_clock_gating(hsotg, 0);
> +		}
> +	}
> +#endif
> +
>  	if (role == USB_ROLE_HOST) {
>  		already = dwc2_ovr_avalid(hsotg, true);
>  	} else if (role == USB_ROLE_DEVICE) {
> -- 
> 2.25.1
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

