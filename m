Return-Path: <linux-kernel+bounces-363673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C8699C57D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6691F228AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53AF158870;
	Mon, 14 Oct 2024 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xlnaw9yB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98215534B;
	Mon, 14 Oct 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897708; cv=none; b=sUnJJ2959y8eUBaKOOnzELAI9Bkf/osSFyamyfb2xjjL+dl/DFP/ciidUFeLGxP016pJ2ESsASkUeprzgQ1VmY5s6xDfmxiLAA0gjj8I+DBFAzSH8VGPOvdrs+uJBPRKkB4ff53YbG1X6JgQc0SCQIfu1kwAsYcQk9EK23dmmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897708; c=relaxed/simple;
	bh=AN0bb3Rg8bGlAKwyQat5svfN/yPRf8imdA3o/pMSdfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Felx6kZiYpKNBkLcIEuIjTwqXpSlk/gbqOphjkzx2dxVNuS8L4+glZl7Y1h7++tvVDHZmSkRA5GtU1GW6670Z5EE3LAr+utPQgWxCUICQzeE8f94h1690/WNk1gBpJKQPpUlKTN8wyF8AFLVzUE4dM2evc6uKbIq8pCJCLQwU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xlnaw9yB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D860DC4CEC3;
	Mon, 14 Oct 2024 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728897707;
	bh=AN0bb3Rg8bGlAKwyQat5svfN/yPRf8imdA3o/pMSdfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xlnaw9yB/8mQBlpV7fqOGAPzkU12psMr03psuiyFpIrDP9du0aMtgEr28Po8LiDfK
	 6lSx2LBa9H/72WHiNq/NeV395qGfRtjycvtxw6VZP/ixyR35zbYg9IRTAcR0U7/wLD
	 0a/pk2ZIoom/hFwa17QZBIpOALPCvFCnh/J/fPnU=
Date: Mon, 14 Oct 2024 11:21:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: Thinh.Nguyen@synopsys.com, mathias.nyman@intel.com,
	stern@rowland.harvard.edu, yajun.deng@linux.dev,
	sumit.garg@linaro.org, kekrby@gmail.com, oneukum@suse.com,
	dianders@chromium.org, perex@perex.cz, tiwai@suse.com,
	niko.mauno@vaisala.com, andreyknvl@gmail.com,
	christophe.jaillet@wanadoo.fr, tj@kernel.org,
	stanley_chang@realtek.com, quic_jjohnson@quicinc.com,
	ricardo@marliere.net, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	badhri@google.com, albertccwang@google.com, quic_wcheng@quicinc.com,
	pumahsu@google.com
Subject: Re: [PATCH v5 5/5] usb: host: enable sideband transfer during system
 sleep
Message-ID: <2024101432-dollar-untrue-d366@gregkh>
References: <20241014085816.1401364-1-guanyulin@google.com>
 <20241014085816.1401364-6-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014085816.1401364-6-guanyulin@google.com>

On Mon, Oct 14, 2024 at 08:50:29AM +0000, Guan-Yu Lin wrote:
> Sharing a USB controller with another entity via xhci-sideband driver
> creates power management complexities. To prevent the USB controller
> from being inadvertently deactivated while in use by the other entity, a
> usage-count based mechanism is implemented. This allows the system to
> manage power effectively, ensuring the controller remains available
> whenever needed.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---
>  drivers/usb/core/driver.c         | 10 ++++++++++
>  drivers/usb/core/hcd.c            |  1 +
>  drivers/usb/core/usb.c            |  1 +
>  drivers/usb/dwc3/core.c           | 13 +++++++++++++
>  drivers/usb/dwc3/core.h           |  8 ++++++++
>  drivers/usb/host/xhci-plat.c      | 10 ++++++++++
>  drivers/usb/host/xhci-plat.h      |  7 +++++++
>  sound/usb/qcom/qc_audio_offload.c |  3 +++
>  8 files changed, 53 insertions(+)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index e713cf9b3dd2..eb85cbb1a2ff 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1583,6 +1583,11 @@ int usb_suspend(struct device *dev, pm_message_t msg)
>  	struct usb_device	*udev = to_usb_device(dev);
>  	int r;
>  
> +	if (msg.event == PM_EVENT_SUSPEND && usb_sideband_check(udev)) {
> +		dev_dbg(dev, "device accessed via sideband\n");
> +		return 0;
> +	}

What prevents the check from changing state right after you call this?

> +
>  	unbind_no_pm_drivers_interfaces(udev);
>  
>  	/* From now on we are sure all drivers support suspend/resume
> @@ -1619,6 +1624,11 @@ int usb_resume(struct device *dev, pm_message_t msg)
>  	struct usb_device	*udev = to_usb_device(dev);
>  	int			status;
>  
> +	if (msg.event == PM_EVENT_RESUME && usb_sideband_check(udev)) {
> +		dev_dbg(dev, "device accessed via sideband\n");
> +		return 0;
> +	}

Same here, what's keeping the state from changing?


> +
>  	/* For all calls, take the device back to full power and
>  	 * tell the PM core in case it was autosuspended previously.
>  	 * Unbind the interfaces that will need rebinding later,
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 1ff7d901fede..9876b3940281 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2593,6 +2593,7 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
>  	timer_setup(&hcd->rh_timer, rh_timer_func, 0);
>  #ifdef CONFIG_PM
>  	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
> +	refcount_set(&hcd->sb_usage_count, 0);
>  #endif
>  
>  	INIT_WORK(&hcd->died_work, hcd_died_work);
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 0b4685aad2d5..d315d066a56b 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -671,6 +671,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
>  	dev->state = USB_STATE_ATTACHED;
>  	dev->lpm_disable_count = 1;
>  	atomic_set(&dev->urbnum, 0);
> +	refcount_set(&dev->sb_usage_count, 0);
>  
>  	INIT_LIST_HEAD(&dev->ep0.urb_list);
>  	dev->ep0.desc.bLength = USB_DT_ENDPOINT_SIZE;
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 2fdafbcbe44c..18c743ce5ac5 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2550,8 +2550,15 @@ static int dwc3_runtime_idle(struct device *dev)
>  static int dwc3_suspend(struct device *dev)
>  {
>  	struct dwc3	*dwc = dev_get_drvdata(dev);
> +	struct platform_device *xhci = dwc->xhci;
>  	int		ret;
>  
> +	if (xhci && xhci_sideband_check(xhci->dev.driver_data)) {

What could go wrong with poking into a random device structure's private
data that you don't know the type of?  :(

> +		dev_dbg(dev, "device accessed via sideband\n");
> +		return 0;

I predict, that if this all does get implemented, we're going to have a
lot of confusion of "why will my devices not go into suspend?"
questions, right?

How does userspace know if a device is controlled by a sideband path or
not?  Is there some sysfs link somewhere, and does any tool show it
anyway?

thanks,

greg k-h

