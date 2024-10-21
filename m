Return-Path: <linux-kernel+bounces-374387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B3A9A69BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF200B24EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D82E1EF939;
	Mon, 21 Oct 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NdQribRR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B01D1F7A;
	Mon, 21 Oct 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515696; cv=none; b=tHqbq0LGEu5BQmRpzljrJ0IKHfsmdhoR4Z5eLIokOxqMaI+Jx3MusqDC+Ayf8YsSpGu69SjDOgQxfE38HkBjTJOvOupktvefQXYRegugVDah242qR7IWyclDWI0kT8CNGKdGE5xpm1Z08eQ96JkzSpXxmQDCkhJ0LEE+bK4qlu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515696; c=relaxed/simple;
	bh=/zZKXJvBLxmmovl1avbBtZ7Tib3327F/k874Mk0+vRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCs/Ir3EEOYZYmd92gJQ3mqbRTQ6hKJzstbBELULihFGCdqadUzZpP20KrWf2iSTxlyCHUTumzmoV3MAGBCab5+0gaCMRvlLeZ1p3u0TqzIiWMCfbfM+T+jDQ9oP3kHh9hUgEaYOKW9TOwX+uyszgV601TYSkiORBYAgKL812mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NdQribRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163CCC4CEC3;
	Mon, 21 Oct 2024 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729515696;
	bh=/zZKXJvBLxmmovl1avbBtZ7Tib3327F/k874Mk0+vRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdQribRRV6FIZenUZi4cl1qaM8HnvSG4h90qan7X/wQch0Gwp64R0gLfkSbQDgTjO
	 7ypn/x+1S0CGBfTzm2c9w8QGKkmdRNg6el4wRn5WYW5UOr8J+w76773VmzXb6GSk8k
	 weVfzpdG0mPJrmWTRjAdbt0Kk8rTZAhGqKz6j1cI=
Date: Mon, 21 Oct 2024 15:01:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: huanglei814 <huanglei814@163.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>
Subject: Re: [PATCH] usb: core: adds support for PM control of specific USB
 dev skip suspend.
Message-ID: <2024102137-senate-yarn-34ed@gregkh>
References: <20241021124741.6014-1-huanglei814@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021124741.6014-1-huanglei814@163.com>

On Mon, Oct 21, 2024 at 08:47:41PM +0800, huanglei814 wrote:
> From: huanglei <huanglei@kylinos.cn>
> 
> All USB devices are brought into suspend power state after system suspend.
> It is desirable for some specific manufacturers buses to keep their devices
> in normal state even after system suspend.

Why is it desireable to do that?  Why can't you just do so from
userspace today?

What hardware requires this?

> Signed-off-by: huanglei <huanglei@kylinos.cn>
> ---
>  drivers/usb/core/Kconfig     | 12 ++++++++++++
>  drivers/usb/core/driver.c    | 14 ++++++++++++++
>  drivers/usb/host/xhci-plat.c |  7 +++++++
>  include/linux/usb.h          |  9 +++++++++
>  4 files changed, 42 insertions(+)
> 
> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> index 58e3ca7e4793..fe178c90d167 100644
> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -143,3 +143,15 @@ config USB_DEFAULT_AUTHORIZATION_MODE
>  	  ACPI selecting value 2 is analogous to selecting value 0.
>  
>  	  If unsure, keep the default value.
> +
> +config USB_SKIP_SUSPEND
> +	bool "Vendor USB support skip suspend"
> +	depends on USB
> +	default n

No need for this line, 'n' is the default.

> +	help
> +	  Select this the associate USB devices will skip suspend when pm control.
> +
> +	  This option adds support skip suspend for PM control of USB devices
> +	  in specific manufacturers platforms.
> +
> +	  If unsure, keep the default value.
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 0c3f12daac79..05fe921f8297 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1583,6 +1583,15 @@ int usb_suspend(struct device *dev, pm_message_t msg)
>  	struct usb_device	*udev = to_usb_device(dev);
>  	int r;
>  
> +#ifdef CONFIG_USB_SKIP_SUSPEND
> +	if (udev->bus->skip_suspend && (msg.event == PM_EVENT_SUSPEND)) {
> +		if (udev->state != USB_STATE_SUSPENDED)
> +			dev_err(dev, "abort suspend\n");
> +
> +		return 0;
> +	}
> +#endif

Please do not put #ifdef lines in .c files if at all possible.

> +
>  	unbind_no_pm_drivers_interfaces(udev);
>  
>  	/* From now on we are sure all drivers support suspend/resume
> @@ -1619,6 +1628,11 @@ int usb_resume(struct device *dev, pm_message_t msg)
>  	struct usb_device	*udev = to_usb_device(dev);
>  	int			status;
>  
> +#ifdef CONFIG_USB_SKIP_SUSPEND
> +	if (udev->bus->skip_suspend && (msg.event == PM_EVENT_RESUME))
> +		return 0;
> +#endif
> +
>  	/* For all calls, take the device back to full power and
>  	 * tell the PM core in case it was autosuspended previously.
>  	 * Unbind the interfaces that will need rebinding later,
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index ecaa75718e59..8cbc666ab5c6 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -265,6 +265,13 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
>  		if (device_property_read_bool(tmpdev, "xhci-skip-phy-init-quirk"))
>  			xhci->quirks |= XHCI_SKIP_PHY_INIT;
>  
> +#ifdef CONFIG_USB_SKIP_SUSPEND
> +		if (device_property_read_bool(tmpdev, "usb-skip-suspend")) {
> +			hcd_to_bus(hcd)->skip_suspend = true;
> +			hcd_to_bus(xhci->shared_hcd)->skip_suspend = true;
> +		}
> +#endif

Why are you only doing this for xhci platform drivers?


> +
>  		device_property_read_u32(tmpdev, "imod-interval-ns",
>  					 &xhci->imod_interval);
>  	}
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 672d8fc2abdb..5f88850fc42d 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -487,6 +487,15 @@ struct usb_bus {
>  	struct mon_bus *mon_bus;	/* non-null when associated */
>  	int monitored;			/* non-zero when monitored */
>  #endif
> +
> +#ifdef CONFIG_USB_SKIP_SUSPEND
> +	unsigned int skip_suspend;	/* All USB devices are brought into suspend
> +					 * power state after system suspend. It is
> +					 * desirable for some specific manufacturers
> +					 * buses to keep their devices in normal
> +					 * state even after system suspend.
> +					 */

Shouldn't this be a boolean?

thanks,

greg k-h

