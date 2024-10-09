Return-Path: <linux-kernel+bounces-357029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83339996A9D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D303328981D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14B196C86;
	Wed,  9 Oct 2024 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OzRA5rmr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094291990DC;
	Wed,  9 Oct 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477847; cv=none; b=rgX4h1GoaXMXJtiasJXHbYX6KJeQGo4QqelbamdZg0VrGaX34k0o4Y+i2Pn7WxPRQ6ueP2hPV3ijU0NbA6iUD86gHhJDQ7ot1nOuwC377QczhQ1whQXnb0EkUIMgfqpaMnu8o3UkVS9o5gzHnUmZxewlS4LwGHyuikxm8U9a0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477847; c=relaxed/simple;
	bh=wFYuyt9To9IclCi28xRLUhh0EhmLXvdTmFGdhpypMOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnXFHq0qIVbDkOnt0xvsPpCL8ywvuDxf6k1oJaqyGmfgAv9Ha3hmQv2IumN1M+BJIuYsVOatvs5C9LNYbeSBAHPZd/WMKFW/fScQrPqVNg8KlDbQ4jt5w6iyZQRZ20XVCHTg2+y18cvsxJge8eC3VWjnH/CKjJqeNKYVpWGq37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OzRA5rmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA321C4CECD;
	Wed,  9 Oct 2024 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728477846;
	bh=wFYuyt9To9IclCi28xRLUhh0EhmLXvdTmFGdhpypMOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzRA5rmrB6OQxuFf/JL058gW6cezttmCH71A9xUwAyQLr9+JgJwcp9piNCqy9wLlD
	 kjg0VokzAVUURBKq3xIKnJaFUN1pxsFIGI9Raj0P9WnXzhMnFp3p77FAnprHV+u/40
	 NbTgDkB+bHy5mVRngpQ4KoNdyuAR3WAnQCkCf9xc=
Date: Wed, 9 Oct 2024 14:44:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: Thinh.Nguyen@synopsys.com, mathias.nyman@intel.com,
	stern@rowland.harvard.edu, elder@kernel.org, oneukum@suse.com,
	yajun.deng@linux.dev, dianders@chromium.org, kekrby@gmail.com,
	perex@perex.cz, tiwai@suse.com, tj@kernel.org,
	stanley_chang@realtek.com, andreyknvl@gmail.com,
	christophe.jaillet@wanadoo.fr, quic_jjohnson@quicinc.com,
	ricardo@marliere.net, grundler@chromium.org, niko.mauno@vaisala.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, badhri@google.com,
	albertccwang@google.com, quic_wcheng@quicinc.com,
	pumahsu@google.com
Subject: Re: [PATCH v4 3/5] usb: add apis for sideband uasge tracking
Message-ID: <2024100941-limping-dislodge-5c74@gregkh>
References: <20241009054429.3970438-1-guanyulin@google.com>
 <20241009054429.3970438-4-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009054429.3970438-4-guanyulin@google.com>

On Wed, Oct 09, 2024 at 05:42:57AM +0000, Guan-Yu Lin wrote:
> Introduce sb_usage_count and corresponding apis to track sideband usage
> on each usb_device. A sideband refers to the co-processor that accesses
> the usb_device via shared control on the same USB host controller. To
> optimize power usage, it's essential to monitor whether ther sideband is
> actively using the usb_device. This information is vital when
> determining if a usb_device can be safely suspended during system power
> state transitions.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---
>  drivers/usb/core/driver.c | 54 +++++++++++++++++++++++++++++++++++++++
>  include/linux/usb.h       | 13 ++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 0c3f12daac79..c1ba5ed15214 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1673,6 +1673,60 @@ void usb_disable_autosuspend(struct usb_device *udev)
>  }
>  EXPORT_SYMBOL_GPL(usb_disable_autosuspend);
>  
> +/**
> + * usb_sideband_get - notify usb driver there's a new active sideband
> + * @udev: the usb_device which has an active sideband
> + *
> + * An active sideband indicates that another entity is currently using the usb
> + * device. Notify the usb device by increasing the sb_usage_count. This allows
> + * usb driver to adjust power management policy based on sideband activities.
> + */
> +void usb_sideband_get(struct usb_device *udev)
> +{
> +	struct usb_device *parent = udev;
> +
> +	do {
> +		atomic_inc(&parent->sb_usage_count);

As this is a reference count, use refcount_t please.

> +		parent = parent->parent;
> +	} while (parent);

Woah, walking up the device chain?  That should not be needed, or if so,
then each device's "usage count" is pointless.

> +}
> +EXPORT_SYMBOL_GPL(usb_sideband_get);
> +
> +/**
> + * usb_sideband_put - notify usb driver there's a sideband deactivated
> + * @udev: the usb_device which has a sideband deactivated
> + *
> + * The inverse operation of usb_sideband_get, which notifies the usb device by
> + * decreasing the sb_usage_count. This allows usb driver to adjust power
> + * management policy based on sideband activities.
> + */
> +void usb_sideband_put(struct usb_device *udev)
> +{
> +	struct usb_device *parent = udev;
> +
> +	do {
> +		atomic_dec(&parent->sb_usage_count);
> +		parent = parent->parent;
> +	} while (parent);
> +}
> +EXPORT_SYMBOL_GPL(usb_sideband_put);
> +
> +/**
> + * usb_sideband_check - check sideband activities on the host controller
> + * @udev: the usb_device which has a sideband deactivated
> + *
> + * Check if there are any sideband activity on the USB device right now. This
> + * information could be used for power management or other forms or resource
> + * management.
> + *
> + * Returns true on any active sideband existence, false otherwise
> + */
> +bool usb_sideband_check(struct usb_device *udev)
> +{
> +	return !!atomic_read(&udev->sb_usage_count);

And what happens if it changes right after you make this call?  This
feels racy and broken.

> +}
> +EXPORT_SYMBOL_GPL(usb_sideband_check);
> +
>  /**
>   * usb_autosuspend_device - delayed autosuspend of a USB device and its interfaces
>   * @udev: the usb_device to autosuspend
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 672d8fc2abdb..5b9fea378960 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -645,6 +645,7 @@ struct usb3_lpm_parameters {
>   *	parent->hub_delay + wHubDelay + tTPTransmissionDelay (40ns)
>   *	Will be used as wValue for SetIsochDelay requests.
>   * @use_generic_driver: ask driver core to reprobe using the generic driver.
> + * @sb_usage_count: number of active sideband accessing this usb device.
>   *
>   * Notes:
>   * Usbcore drivers should not set usbdev->state directly.  Instead use
> @@ -731,6 +732,8 @@ struct usb_device {
>  
>  	u16 hub_delay;
>  	unsigned use_generic_driver:1;
> +
> +	atomic_t sb_usage_count;

Why is this on the device and not the interface that is bound to the
driver that is doing this work?

thanks,

greg k-h

