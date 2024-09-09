Return-Path: <linux-kernel+bounces-321363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D47971962
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D9E1F2384D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622A1B78E2;
	Mon,  9 Sep 2024 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a78sDkVY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8641DFF0;
	Mon,  9 Sep 2024 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885162; cv=none; b=HWiqhjrzLYKRf+HhZOmAJc4l/GzW4qHSyvbNUbasq4hRz66hh34PhLEsP2Is7dvyOzKj2G+dxIaeKbuhgMZgiN4Zu8ENJ5c9CMMVR1mS1hZ3uHiFumwKowYub4TBjQ3nHMhARg4DCs1ruUrtzSoUFFoMdNvlJuKFoX0UmeYQNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885162; c=relaxed/simple;
	bh=MNxJppAPsE+Xe5YVRAFxO+fktSUiHO0Kg0zOQEvY35M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgQWP9moTM8Gnb78+AVHqMjmE4InADnYqUS8UQxO/EBGbi2B0ngdZ/sqEnQQ/XFya0nCScF7QWcLo2PzPjVrXbVLzTgPk1ZmoxZ4djjo5QMElkntjC8WEeoFy+FQDsaEWGFTT+mTxz1J0tdmnaGCtZIBWCp+LBQBfJ/4cc97tp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a78sDkVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D006C4CEC5;
	Mon,  9 Sep 2024 12:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725885162;
	bh=MNxJppAPsE+Xe5YVRAFxO+fktSUiHO0Kg0zOQEvY35M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a78sDkVYh11C5QY5KAlW15ljRMy6bSy92pGuCEzZ3tCuPMY+6MzjzwklkGlFx+Tzp
	 XUucl1Z6tDXwMQzeMEpj/1ffkw8NFB8Hj8Pvop06/Iz21goCo5+d7fPN7+yk+9FNQc
	 cFVBupEvRFYb22477epkNAJALyu16koqNiAB3vlV1R8mBcwy2rcy98yH5eR+6axZSw
	 TqFv3+mvSl7WO8sMMIPYwmOmGI9FxDEwahkHi8yV4C3u/ixLhTq7CUGqsaRMkTcb+2
	 zjMeOOiXCsmUBqmcBZVgKZR7HeDl4Zsw3KsTo0K8R5PQYJNlCdJDteJwlwi7G4KL9b
	 JLCtFqIHtB7Yg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sndZj-0000000023H-1vJ3;
	Mon, 09 Sep 2024 14:32:59 +0200
Date: Mon, 9 Sep 2024 14:32:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: pl2303: account for deficits of clones
Message-ID: <Zt7q-5kk5SPgE7P4@hovoldconsulting.com>
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

This looks mostly fine to me, but could you please try to make these
changes only apply to the clones or, since those probably cannot be
detected reliably, HXD?

What is the 'lsusb -v' for these devices?
 
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
>  
> -		return ret;
> +		return 0;
>  	}

Looking at the driver, it seems like we could move the only call to this
function to probe, and perhaps then an error message for cloned devices
is not such a big deal. But even that could be suppressed based on the
type.

Or we could use this call failing to flag the device as a likely clone
and use that flag to also skip break signalling completely.

>  	dev_dbg(&port->dev, "%s - %7ph\n", __func__, buf);
> @@ -1078,8 +1079,8 @@ static int pl2303_set_break(struct usb_serial_port *port, bool enable)
>  				 BREAK_REQUEST, BREAK_REQUEST_TYPE, state,
>  				 0, NULL, 0, 100);
>  	if (result) {
> -		dev_err(&port->dev, "error sending break = %d\n", result);
> -		return result;
> +		dev_dbg(&port->dev, "error sending break = %d\n", result);
> +		return -ENOTTY;
>  	}

And similar here, the log level could depend on the type, unless the
function should just bail out early for clones.

>  
>  	return 0;

Johan

