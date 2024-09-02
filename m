Return-Path: <linux-kernel+bounces-310616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3E967F22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DE21C218BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925AB1552E1;
	Mon,  2 Sep 2024 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HCoMZWQh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59E76048;
	Mon,  2 Sep 2024 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257219; cv=none; b=qKZxTWPVWzjIyiiD1V1EFB2t7bs9WQIgZZIvAQCZn3Euejii6Fq3HN9W1qnv6YDRg+cmzUZLzGM2LEWVzfO9rAUmzwEkXube6PxcaiCWq20NO+WKZb8UVrljGRw5ENZO2iNQ96LXo0fa4cEDqZeRrQVHXdz0ZZeMnfrLSKmVwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257219; c=relaxed/simple;
	bh=4xHw3RWoXX0ZLhLJOCY0yD5ZVOLA3CCx54tGGES5+FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIxS8f2ybszC4X4T/uRu3v3dq9Wlrlp0QsP+EFjVGVwj4qtk5WEnpGYErD7kv0YocqBtsiTyWRngIbOgywcdgjscQ/DawVqW4T33Bb58sEjaoYFD21Sk/fczpLLSUmw4Wfi/VxYkwKf8/wJqqrK+6lcu7gxMX0B78Put767f0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HCoMZWQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC70C4CEC2;
	Mon,  2 Sep 2024 06:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725257219;
	bh=4xHw3RWoXX0ZLhLJOCY0yD5ZVOLA3CCx54tGGES5+FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCoMZWQhb1uPQ5BwvCBIpubFKmzYNANEGbLu2SMlcmxQk4p0InOkeZ8Gbqkb9Hf1i
	 0ES0SaEL4z34Bui/JMwWI0K+u8+n4dvNC/1+T8dKHwlq1H7MV2hHBscZl84ES0nHsa
	 /+WAElRHuYbOxSZYPzJRBnx4D/dRgqQKjwtcboNc=
Date: Mon, 2 Sep 2024 08:06:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: pl2303: account for deficits of clones
Message-ID: <2024090203-challenge-paper-e1fe@gregkh>
References: <a07922bd-4550-41d8-a7cd-8943baf6f8fb@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07922bd-4550-41d8-a7cd-8943baf6f8fb@siemens.com>

On Sun, Sep 01, 2024 at 11:11:29PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> There are apparently incomplete clones of the HXD type chip in use.
> Those return -EPIPE on GET_LINE_REQUEST and BREAK_REQUEST. Avoid
> flooding the kernel log with those errors. Rather use the
> line_settings cache for GET_LINE_REQUEST and signal missing support by
> returning -ENOTTY from pl2303_set_break.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/usb/serial/pl2303.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> index d93f5d584557..04cafa819390 100644
> --- a/drivers/usb/serial/pl2303.c
> +++ b/drivers/usb/serial/pl2303.c
> @@ -731,12 +731,13 @@ static int pl2303_get_line_request(struct usb_serial_port *port,
>  				GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
>  				0, 0, buf, 7, 100);
>  	if (ret != 7) {
> -		dev_err(&port->dev, "%s - failed: %d\n", __func__, ret);
> +		struct pl2303_private *priv = usb_get_serial_port_data(port);
>  
> -		if (ret >= 0)
> -			ret = -EIO;
> +		dev_dbg(&port->dev, "%s - failed, falling back on cache: %d\n",
> +			__func__, ret);
> +		memcpy(buf, priv->line_settings, 7);

Ugh, how is this device working in other operating systems?

>  
> -		return ret;
> +		return 0;
>  	}
>  
>  	dev_dbg(&port->dev, "%s - %7ph\n", __func__, buf);
> @@ -1078,8 +1079,8 @@ static int pl2303_set_break(struct usb_serial_port *port, bool enable)
>  				 BREAK_REQUEST, BREAK_REQUEST_TYPE, state,
>  				 0, NULL, 0, 100);
>  	if (result) {
> -		dev_err(&port->dev, "error sending break = %d\n", result);
> -		return result;
> +		dev_dbg(&port->dev, "error sending break = %d\n", result);
> +		return -ENOTTY;

Are you sure that ENOTTY is correct here?  Why not just send back
-EINVAL or something like that telling userspace that this is not
allowed for this device?

thanks,

greg k-h

