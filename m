Return-Path: <linux-kernel+bounces-523397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C367A3D642
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E15F17BA18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC81F12E9;
	Thu, 20 Feb 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cFOWwAL8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EBA1F0E31;
	Thu, 20 Feb 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046541; cv=none; b=XcFKbcUqXp33NFjzG69LiNPc5NWmezLXP0mWZkvnkqA08Fbgy1zIXvbSxOXZTL2JrYNITWo/hABmGE8axKoldo5x3jgLa8BcfA15OQPeiK9g6C1uK9hKaHWu72FLNImpsCMJFZL7oSgyAE1dGunmp5GRlwJO3Z6hgzeNvBw58ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046541; c=relaxed/simple;
	bh=rylNYQvJkCq0zQelkwkvTaCw8K/90clQElFuELEdVbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2ETGjniz30Qc94G5PEvGWDZEK3ef7YZc7I75LhQLtksA8zdqeQkfom9k/Suu4Q1v2hJJQmcq46GodsLnlwXxKl/1O2jd8yogZlf+G/SOQh6d8YpDC03FgbQrI9L647Bc90Iw36eLjNL9va7E9S/d3MYI78ZVvHWOjvBtD2GYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cFOWwAL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F795C4CEE4;
	Thu, 20 Feb 2025 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740046540;
	bh=rylNYQvJkCq0zQelkwkvTaCw8K/90clQElFuELEdVbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFOWwAL8ibHEUsHg4wOijCGLCiHI2lR5YgmnBIMdR8Thwx6Zu9ncJnXVkPic7/5lt
	 lgFCyZbOxSbEHC1qKFQPCOBT2mFDzJq+v9pdqBfq9a8muUEoGfU7JIHC5qAXewn4nV
	 +LufDJuO5aSgWdnsSWuhfdpcJ4cHNsC7MfUKtDyM=
Date: Thu, 20 Feb 2025 11:15:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stern@rowland.harvard.edu, christophe.jaillet@wanadoo.fr,
	mka@chromium.org, make_ruc2021@163.com,
	javier.carrasco@wolfvision.net, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: core: Add error handling in usb_reset_device for
 autoresume failure
Message-ID: <2025022046-clinking-levitate-9fbf@gregkh>
References: <20250220095218.970-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220095218.970-1-vulab@iscas.ac.cn>

On Thu, Feb 20, 2025 at 05:52:18PM +0800, Wentao Liang wrote:
> In usb_reset_device(),  the function continues execution and
> calls usb_autosuspend_device() after usb_autosuspend_device fails.
> 
> To fix this, add error handling for usb_autoresume_device()
> and return the error code immediately. This ensures that
> usb_autosuspend_device() is not called when usb_autoresume_device()
> fails, maintaining device state consistency.
> 
> Fixes: 94fcda1f8ab5 ("usbcore: remove unused argument in autosuspend")
> Cc: stable@vger.kernel.org # 2.6.20+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/usb/core/hub.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 21ac9b464696..f2efdbdd1533 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -6292,7 +6292,9 @@ int usb_reset_device(struct usb_device *udev)
>  	noio_flag = memalloc_noio_save();
>  
>  	/* Prevent autosuspend during the reset */
> -	usb_autoresume_device(udev);

Have you ever seen this function fail?

> +	ret = usb_autoresume_device(udev);
> +	if (ret < 0)

if (ret) please.

Also, how was this tested?  How was it found?

thanks,

greg k-h

