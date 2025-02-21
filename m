Return-Path: <linux-kernel+bounces-525632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA0FA3F28C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E315C700846
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2A82080FB;
	Fri, 21 Feb 2025 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vU5DB26Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD8207E1A;
	Fri, 21 Feb 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135185; cv=none; b=bM4sAQ6K41OJfnF8BUhl47RNN4FuUU/Wxg85d5YDqo4Kc9TJdFm/wmAjvk70bvIQo3OeRjBB32GTbN/cc1oJ3asuBgy8YSRoAEpYeknfz4waNqQs4iGi41BxWHttmO2GIGxeX1BVaYk2n4tqGJigv0DGQycjX+7phjOEkw9C1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135185; c=relaxed/simple;
	bh=ufpR1Z4H9TVwVTNUILXf2+amecfAuuE+k/9g3eWjpg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN5QdnKLmb7zTSLFO/TG3TpA2QKrhMTV19y2hO+ULLSeIIgt8Q5hbKo+G23rCunenqcrDlZXSxfBxcRu2CEQG+mpDsNVFlf0j/MPWUjY2jDkWBdHCpP69LP0CKx894WzT35Ov5t0ua0urMZQGJ/N02K4VPtdxdAtZfLHoEylbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vU5DB26Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5A7C4CED6;
	Fri, 21 Feb 2025 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740135184;
	bh=ufpR1Z4H9TVwVTNUILXf2+amecfAuuE+k/9g3eWjpg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vU5DB26QL8qs89mxe6DjMiVhcwTw+2MtCEgW81lDtX9imv6ay8jhnH4XmXvmTAYaA
	 4LYqNgX9b8CExx0jwJW4k8933LRYigZspUvRVH5JuJHKl0xfHgsR+Gb7g5qQaOnTwt
	 HwIUzZ1YUJksMidSgfJ52DTTu4ed5RFWVKqKehAY=
Date: Fri, 21 Feb 2025 11:53:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Akshay Gujar <Akshay.Gujar@harman.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	naveen.v@harman.com, sankarkumar.krishnasamy@harman.com
Subject: Re: [PATCH] usb: core: notify unrecognized usb device
Message-ID: <2025022131-silo-impeach-3f24@gregkh>
References: <20250221102949.1135849-1-Akshay.Gujar@harman.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221102949.1135849-1-Akshay.Gujar@harman.com>

On Fri, Feb 21, 2025 at 10:29:49AM +0000, Akshay Gujar wrote:
> Description: To send uevent for unrecognized device connected on system.

Odd format here, have you read the documentation of the kernel process
in how to write a changelog?  I recommend a quick glance at the section
"The canonical patch format" in the kernel file,
Documentation/process/submitting-patches.rst for details.

> As per the usb compliance, USB-IF enforces a "no silent failure" rule.
> This means that an implementation of USB must not appear broken to the
> consumer. In configurations where the consumer's expectations are not
> met, either the peripheral or host must provide appropriate and useful
> feedback to the consumer regarding the problem.
> 
> Link: https://compliance.usb.org/index.asp?UpdateFile=Embedded%20Host&Format=Standard#10

Odd, many Linux devices have passed usb-if testing since 2005 when this
was made a "rule", how did that happen?  What recently changed to
suddenly require this be a kernel issue?

And does usb-if even matter these days?  You do know what they think
about Linux overall, right (hint, they kicked us out from
participating...) so why should we follow their "requirements" when they
do not allow us to even participate or provide feedback when they create
them?

> Signed-off-by: Akshay Gujar <Akshay.Gujar@harman.com>
> ---
>  drivers/usb/core/hub.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index c3f839637..d00129b59 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5343,6 +5343,26 @@ static int descriptors_changed(struct usb_device *udev,
>  	return changed;
>  }
>  
> +static void unrecognized_usb_device_notify(struct usb_port *port_dev)
> +{
> +	char *envp[2] = { NULL, NULL };
> +	struct device *hub_dev;
> +
> +	hub_dev = port_dev->dev.parent;
> +
> +	if (!hub_dev)
> +		return;

How can this be true?

> +
> +	envp[0] = kasprintf(GFP_KERNEL, "UNRECOGNIZED_USB_DEVICE_ON_PORT=%s",
> +				kobject_name(&port_dev->dev.kobj));

Hint, if a driver ever starts calling into kobject or sysfs functions,
usually something is wrong.  This should just use dev_name(), right?

> +	if (!envp[0])
> +		return;
> +
> +	kobject_uevent_env(&hub_dev->kobj, KOBJ_CHANGE, envp);

Where is this new uevent documented?  What userspace tool will see this
and do something about it?  How was this tested?

> +
> +	kfree(envp[0]);
> +}
> +
>  static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
>  		u16 portchange)
>  {
> @@ -5569,9 +5589,11 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
>  	if (hub->hdev->parent ||
>  			!hcd->driver->port_handed_over ||
>  			!(hcd->driver->port_handed_over)(hcd, port1)) {
> -		if (status != -ENOTCONN && status != -ENODEV)
> +		if (status != -ENOTCONN && status != -ENODEV) {
>  			dev_err(&port_dev->dev,
>  					"unable to enumerate USB device\n");
> +			unrecognized_usb_device_notify(port_dev);

This is only if a hub acts up with talking to a device, it does not mean
the device was not supported at all.  So this isn't going to meet the
standard that you describe above.  Userspace is really the only thing
that can know if a device is "supported" or not, not the kernel.

thanks,

greg k-h

