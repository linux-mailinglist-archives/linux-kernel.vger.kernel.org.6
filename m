Return-Path: <linux-kernel+bounces-299202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD97D95D178
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74218B23E46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5A188A26;
	Fri, 23 Aug 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NXNGSSz7"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8918800E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427202; cv=none; b=qGVU7LJ0NrkqXn+IK2n/6ZY3AX7pnDsbdAi/lp44+tmuI4OyKMFiOXjFSq4biy7ZNbKIXsZsPoMePr8Z0lsEY0ckcPwOkY3rEqPI2hecqQuZTCEbs4dFXKHcdc9LG9hfdpQCXxM6bSgbNqgXeiFXeicCit4EvvWt+hKhxSOjj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427202; c=relaxed/simple;
	bh=AS2NxEZemsTzIzZeciU6KQmngp5HFihrC+Vbn+2p35A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoO60z4BhwabjWvtpBmEohRA7hdgPJq8MxnQ6/WrJedBhnqttY8+OV+N3UtZVWu5vVNI3JyeTcFQwq4bO9h0MdM8pLWKALb21Ut4fZVKmF9lxXQCdnrZEpMNf14yATfWNgmFRkIQgx9QYsBXLxb8Je03NRroFN5XGAuBn3RyyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NXNGSSz7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07F8F2D5;
	Fri, 23 Aug 2024 17:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1724427134;
	bh=AS2NxEZemsTzIzZeciU6KQmngp5HFihrC+Vbn+2p35A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXNGSSz7xR1mL1/ZM5QCcqH07zUfhllx4BUtqENbfDxVkIqhVw6ASOw1SBdO9VqsF
	 YDxiQGjT+CvOiGOshVP53uzcE9Gy//2G5e+Ezx5QQTpBBZfX3NO4HMcspu9QI/rt/X
	 S0HfLn7aBVWQCfxox7QD/RDcwnllqdHVJ2DrBtNs=
Date: Fri, 23 Aug 2024 18:33:15 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Arnd Bergmann <arnd@arndb.de>, Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 4/7] staging: vchiq_core: Factor out bulk transfer for
 (no/)callback mode
Message-ID: <20240823153315.GA28317@pendragon.ideasonboard.com>
References: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
 <20240823-to_sent2-v1-4-8bc182a0adaf@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823-to_sent2-v1-4-8bc182a0adaf@ideasonboard.com>

Hi Umang,

Thank you for the patch.

On Fri, Aug 23, 2024 at 08:44:24PM +0530, Umang Jain wrote:
> Factor out bulk transfer for VCHIQ_BULK_MODE_NOCALLBACK and
> VCHIQ_BULK_MODE_CALLBACK mode into a separate dedicated function
> bulk_xfer_callback_interruptible(). It is suffixed by "_interruptible"
> to denote that it can be interrupted and -EAGAIN can be returned. It
> would be up to the users of the function to retry the call in those cases.
> 
> bulk_xfer_callback_interruptible() also takes in 'mode' parameter to
> differentiate between VCHIQ_BULK_MODE_NOCALLBACK and
> VCHIQ_BULK_MODE_CALLBACK, which then is directly passed to
> vchiq_bulk_xfer_queue_msg_interruptible() inside the function.
> 
> Adjust the calls to vchiq-dev.c ioctl interface and vchiq_arm.c
> for the respective bulk transfers.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 15 ++++----
>  .../vc04_services/interface/vchiq_arm/vchiq_core.c | 40 ++++++++++++++++++++++
>  .../vc04_services/interface/vchiq_arm/vchiq_core.h |  6 ++++
>  .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |  6 ++++
>  4 files changed, 60 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index e9b9c76381dc..5210ce8d269e 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -857,10 +857,10 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
>  		switch (mode) {
>  		case VCHIQ_BULK_MODE_NOCALLBACK:
>  		case VCHIQ_BULK_MODE_CALLBACK:
> -			ret = vchiq_bulk_transfer(instance, handle,
> -						  (void *)data, NULL,
> -						  size, userdata, mode,
> -						  VCHIQ_BULK_TRANSMIT);
> +			ret = bulk_xfer_callback_interruptible(instance, handle,
> +							       (void *)data, NULL,
> +							       size, mode, userdata,
> +							       VCHIQ_BULK_TRANSMIT);
>  			break;
>  		case VCHIQ_BULK_MODE_BLOCKING:
>  			ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
> @@ -895,9 +895,10 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
>  		switch (mode) {
>  		case VCHIQ_BULK_MODE_NOCALLBACK:
>  		case VCHIQ_BULK_MODE_CALLBACK:
> -			ret = vchiq_bulk_transfer(instance, handle, data, NULL,
> -						  size, userdata,
> -						  mode, VCHIQ_BULK_RECEIVE);
> +			ret = bulk_xfer_callback_interruptible(instance, handle,
> +							       (void *)data, NULL,
> +							       size, mode, userdata,
> +							       VCHIQ_BULK_RECEIVE);
>  			break;
>  		case VCHIQ_BULK_MODE_BLOCKING:
>  			ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 341a06997848..0606561fd3d0 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -3027,6 +3027,46 @@ bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsigned int h
>  	return status;
>  }
>  
> +int
> +bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned int handle,

Please prefix the name of all functions with an appropriate driver
prefix, especially for functions that are not static.

> +				 void *offset, void __user *uoffset, int size,
> +				 enum vchiq_bulk_mode mode, void *userdata,
> +				 enum vchiq_bulk_dir dir)
> +{
> +	struct vchiq_service *service = find_service_by_handle(instance, handle);
> +	int status = -EINVAL;
> +
> +	if (!service)
> +		goto error_exit;
> +
> +	if (mode != VCHIQ_BULK_MODE_CALLBACK &&
> +	    mode != VCHIQ_BULK_MODE_NOCALLBACK)
> +		goto error_exit;
> +
> +	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
> +		goto error_exit;
> +
> +	if (!offset && !uoffset)
> +		goto error_exit;
> +
> +	if (vchiq_check_service(service))
> +		goto error_exit;
> +
> +	status = vchiq_bulk_xfer_queue_msg_interruptible(service, offset, uoffset,
> +							 size, userdata, mode, dir);
> +	if (status)
> +		goto error_exit;
> +
> +	vchiq_service_put(service);
> +
> +	return 0;
> +
> +error_exit:
> +	if (service)
> +		vchiq_service_put(service);
> +	return status;
> +}
> +
>  /*
>   * This function may be called by kernel threads or user threads.
>   * User threads may receive -EAGAIN to indicate that a signal has been
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index ff3559c3d1ba..8aaf3c9d3dbe 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -479,6 +479,12 @@ bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsigned int h
>  				 void *offset, void __user *uoffset, int size,
>  				 void __user *userdata, enum vchiq_bulk_dir dir);
>  
> +extern int
> +bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned int handle,
> +				 void *offset, void __user *uoffset, int size,
> +				 enum vchiq_bulk_mode mode, void *userdata,
> +				 enum vchiq_bulk_dir dir);
> +
>  extern int
>  vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *offset,
>  		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_mode mode,
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 1bff97ad28fa..7ecfcaa85569 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -336,6 +336,12 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
>  		goto bulk_transfer_handled;
>  	} else {
>  		userdata = args->userdata;
> +
> +		status = bulk_xfer_callback_interruptible(instance, args->handle,
> +							  NULL, args->data, args->size,
> +							  args->mode, userdata, dir);
> +
> +		goto bulk_transfer_handled;
>  	}
>  
>  	status = vchiq_bulk_transfer(instance, args->handle, NULL, args->data, args->size,
> 

-- 
Regards,

Laurent Pinchart

