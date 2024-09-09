Return-Path: <linux-kernel+bounces-321498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F65B971B51
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37EDB228BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8E1B9B4D;
	Mon,  9 Sep 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgzewRXa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457117837E;
	Mon,  9 Sep 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889371; cv=none; b=qCTOwr+8GpWICAXYRORcgrqpJrvR3AMowfPRWT3/xXaKi8ja00G1B7OahgKaT0yix916hqNtIS+bzurMPAWAUlEsDYarCK60K9yn/otFwoN+2c6+g1l6DmVAF+AuCb7EtP/yMCXxAheiLzU0Q01C9BIdnl3VW5ySZC7wKfrqU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889371; c=relaxed/simple;
	bh=1hEFgXjyHg+9bqsPRbgYga/Fi1zEn8b81S/wo0XuZJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLx3F0D0yH0Rf2QfIir5iG02EcnAdD3zj/+QvVsx62+lsFWR1Sx1Bd3T1NuR6OmN9EGJADAatDsk7a6afs/pyOzBNFuiwRBXrBNdj7hEvgr5T5wY/50B5E2YtizvpAZ8WSx+fc8Hx0bW/RVcJzvlbuVJR1EotXr7IdccqijfuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgzewRXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A8EC4CEC5;
	Mon,  9 Sep 2024 13:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725889370;
	bh=1hEFgXjyHg+9bqsPRbgYga/Fi1zEn8b81S/wo0XuZJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgzewRXaY3nnJE5z+/F6Ju6idhr5S6DN59OK4hYUXZNgIFVvd7PMvWsIrutHi1tzy
	 YoFgbEFnu9iRquEkUKgfoW+4cSgr2Q8P8LHIJLdkH8+xX7X20K6lx1B0PcuIwU03VD
	 O4zlqlpdaC9uycXfKNGglQ5U0rzhvc/q3KLUuYFP4rKXXPuT/BzFTQz3neP4tc+fsd
	 +OWHbJeVV2kWI3xsM8uNo9uZdjfv4KQRfZePQYdwrQ060426iRjeAKe8IDY23gSvxR
	 G72/12qaVvLrLtk3WDIo1m7OeKn8ZSb64zgHJHXJCXusS4sWVODSTXxgMO4E/hLIxp
	 O1zuuzTPBItwQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1snefb-000000003P5-1Cat;
	Mon, 09 Sep 2024 15:43:08 +0200
Date: Mon, 9 Sep 2024 15:43:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: pl2303: account for deficits of clones
Message-ID: <Zt77a-LpTSgyVx57@hovoldconsulting.com>
References: <a07922bd-4550-41d8-a7cd-8943baf6f8fb@siemens.com>
 <Zt7q-5kk5SPgE7P4@hovoldconsulting.com>
 <5ed9df75-c45b-44fd-8eb1-3cc9c6b0001e@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed9df75-c45b-44fd-8eb1-3cc9c6b0001e@siemens.com>

On Mon, Sep 09, 2024 at 02:52:25PM +0200, Jan Kiszka wrote:
> On 09.09.24 14:32, Johan Hovold wrote:
> > On Sun, Sep 01, 2024 at 11:11:29PM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> There are apparently incomplete clones of the HXD type chip in use.
> >> Those return -EPIPE on GET_LINE_REQUEST and BREAK_REQUEST. Avoid
> >> flooding the kernel log with those errors. Rather use the
> >> line_settings cache for GET_LINE_REQUEST and signal missing support by
> >> returning -ENOTTY from pl2303_set_break.
> > 
> > This looks mostly fine to me, but could you please try to make these
> > changes only apply to the clones or, since those probably cannot be
> > detected reliably, HXD?
> > 
> 
> OK. Is there a way to switch between dev_err and dev_dbg without
> duplicating the line?

Perhaps, did you check? But I think we should go with adding a flag and
suppressing the known broken calls completely post probe.
 
> > What is the 'lsusb -v' for these devices?
> 
> Bus 001 Device 019: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial
> Port / Mobile Action MA-8910P
> Couldn't open device, some information will be missing
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x067b Prolific Technology, Inc.
>   idProduct          0x2303 PL2303 Serial Port / Mobile Action MA-8910P
>   bcdDevice            4.00

So this would be detected as an HXD by the current driver. Not sure what
else could be used except possibly the product string and the fact that
these requests fail to determine if it's a legit HXD.

> >> @@ -731,12 +731,13 @@ static int pl2303_get_line_request(struct usb_serial_port *port,
> >>  				GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
> >>  				0, 0, buf, 7, 100);
> >>  	if (ret != 7) {
> >> -		dev_err(&port->dev, "%s - failed: %d\n", __func__, ret);
> >> +		struct pl2303_private *priv = usb_get_serial_port_data(port);
> >>  
> >> -		if (ret >= 0)
> >> -			ret = -EIO;
> >> +		dev_dbg(&port->dev, "%s - failed, falling back on cache: %d\n",
> >> +			__func__, ret);
> >> +		memcpy(buf, priv->line_settings, 7);
> >>  
> >> -		return ret;
> >> +		return 0;
> >>  	}
> > 
> > Looking at the driver, it seems like we could move the only call to this
> > function to probe, and perhaps then an error message for cloned devices
> 
> Nope, this is called on every pl2303_set_termios, thus is even under
> user control.

What do you mean by "nope"? I'm saying that it looks like it may be
possible to move this call to probe() given how it is used currently.

Or you can just add an additional call to probe() without the dev_err()
and use that for clone detection.

> > is not such a big deal. But even that could be suppressed based on the
> > type.
> > 
> > Or we could use this call failing to flag the device as a likely clone
> > and use that flag to also skip break signalling completely.
> 
> Oh, you meant the function below? But that is also in user hands (as well).
> 
> Flagging after the first call is theoretically possible - but is it
> worth the related effort? I doubt that a bit.

I'm saying that we can issue the get_line_settings request during
probe() (for HXD) and if it fails, we treat the device as a clone and
skip the requests that are not supported completely.

Johan

