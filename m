Return-Path: <linux-kernel+bounces-335162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0312997E216
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14438281291
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE11C153;
	Sun, 22 Sep 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g5UkUo3h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622A2F43;
	Sun, 22 Sep 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727016979; cv=none; b=sL7yUxucVR9uZi2tjVlTTbGgRAn4aiTqa1kO8/XyDD33HAOy11NfcmqrFl9Owztf6hc3l0UhWjL+ZmhSi0VVNsiihXb0DDyDMPFo8AsLrzB4PXsXo+gSULkyOFss0uF6+Apq4XyQW7OATI9avz2X2hm97oyvPaXu9xYO4oRiB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727016979; c=relaxed/simple;
	bh=jnI4hgwVNGPPbH4A3vrXV3FEkDFYwLdoEtwEJF07QN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElQGr3PJKXhaKFLLN4Uwk6zuv7HOTjnpt6EKatAhf1dKdOF5ATr0AvU8laNG4g4z2FnGYTdO6ZoZgFz7q0nEFrbjAXBs7gEMcFLjw8LsVNAlmPDqqCisurLnA3wW33rTGSFLoSoVFOjP7QIBvs6dSeO7XxeeBEkEp60UoJGuWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g5UkUo3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4842C4CEC6;
	Sun, 22 Sep 2024 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727016979;
	bh=jnI4hgwVNGPPbH4A3vrXV3FEkDFYwLdoEtwEJF07QN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5UkUo3hKaDhofmDz5RDdJBsZ0XAkb/zqy25AeZZ10oqwatdLd4COnBX92CXxPu3i
	 rEbh0c0XanmLvE2iDOB7M98kVFeqkwn9Z5hZhIEl+sM809ds65uITNb+t3giB8EFSX
	 wFA4tH7uI4Yayxj1mUsq02UYn96mj8MX9LullBgw=
Date: Sun, 22 Sep 2024 16:56:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: amin-amani <didi1364@gmail.com>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: digi_acceleport: Improve readability and
 enhance error handling
Message-ID: <2024092245-theorize-griminess-4101@gregkh>
References: <20240922111701.85965-1-didi1364@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922111701.85965-1-didi1364@gmail.com>

On Sun, Sep 22, 2024 at 02:47:01PM +0330, amin-amani wrote:
> From: "A.Amani" <didi1364@gmail.com>
> 
> - Improved coding style to adhere to kernel standards as suggested by
>   checkpatch.pl.
> - Indented case statements for baud rate and word size to improve code
>   readability.
> - Separated null checks for port, serial, and private data for clearer
>   error handling.
> - Improved error messages to better indicate which specific data (port,
>   serial, or private) is null.
> - No functional changes, only structural improvements and clearer
>   debugging output.
> 
> Signed-off-by: A.Amani <didi1364@gmail.com>
> ---
>  drivers/usb/serial/digi_acceleport.c | 105 +++++++++++++++++++--------
>  1 file changed, 73 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
> index d1dea3850576..da707967a0c4 100644
> --- a/drivers/usb/serial/digi_acceleport.c
> +++ b/drivers/usb/serial/digi_acceleport.c
> @@ -685,25 +685,44 @@ static void digi_set_termios(struct tty_struct *tty,
>  		}
>  		switch (baud) {
>  		/* drop DTR and RTS on transition to B0 */
> -		case 0: digi_set_modem_signals(port, 0, 1); break;
> -		case 50: arg = DIGI_BAUD_50; break;
> -		case 75: arg = DIGI_BAUD_75; break;
> -		case 110: arg = DIGI_BAUD_110; break;
> -		case 150: arg = DIGI_BAUD_150; break;
> -		case 200: arg = DIGI_BAUD_200; break;
> -		case 300: arg = DIGI_BAUD_300; break;
> -		case 600: arg = DIGI_BAUD_600; break;
> -		case 1200: arg = DIGI_BAUD_1200; break;
> -		case 1800: arg = DIGI_BAUD_1800; break;
> -		case 2400: arg = DIGI_BAUD_2400; break;
> -		case 4800: arg = DIGI_BAUD_4800; break;
> -		case 9600: arg = DIGI_BAUD_9600; break;
> -		case 19200: arg = DIGI_BAUD_19200; break;
> -		case 38400: arg = DIGI_BAUD_38400; break;
> -		case 57600: arg = DIGI_BAUD_57600; break;
> -		case 115200: arg = DIGI_BAUD_115200; break;
> -		case 230400: arg = DIGI_BAUD_230400; break;
> -		case 460800: arg = DIGI_BAUD_460800; break;
> +		case 0:
> +			digi_set_modem_signals(port, 0, 1); break;
> +		case 50:
> +			arg = DIGI_BAUD_50; break;
> +		case 75:
> +			arg = DIGI_BAUD_75; break;
> +		case 110:
> +			arg = DIGI_BAUD_110; break;
> +		case 150:
> +			arg = DIGI_BAUD_150; break;
> +		case 200:
> +			arg = DIGI_BAUD_200; break;
> +		case 300:
> +			arg = DIGI_BAUD_300; break;
> +		case 600:
> +			arg = DIGI_BAUD_600; break;
> +		case 1200:
> +			arg = DIGI_BAUD_1200; break;
> +		case 1800:
> +			arg = DIGI_BAUD_1800; break;
> +		case 2400:
> +			arg = DIGI_BAUD_2400; break;
> +		case 4800:
> +			arg = DIGI_BAUD_4800; break;
> +		case 9600:
> +			arg = DIGI_BAUD_9600; break;
> +		case 19200:
> +			arg = DIGI_BAUD_19200; break;
> +		case 38400:
> +			arg = DIGI_BAUD_38400; break;
> +		case 57600:
> +			arg = DIGI_BAUD_57600; break;
> +		case 115200:
> +			arg = DIGI_BAUD_115200; break;
> +		case 230400:
> +			arg = DIGI_BAUD_230400; break;
> +		case 460800:
> +			arg = DIGI_BAUD_460800; break;
>  		default:
>  			arg = DIGI_BAUD_9600;
>  			baud = 9600;
> @@ -737,10 +756,14 @@ static void digi_set_termios(struct tty_struct *tty,
>  	if ((cflag & CSIZE) != (old_cflag & CSIZE)) {
>  		arg = -1;
>  		switch (cflag & CSIZE) {
> -		case CS5: arg = DIGI_WORD_SIZE_5; break;
> -		case CS6: arg = DIGI_WORD_SIZE_6; break;
> -		case CS7: arg = DIGI_WORD_SIZE_7; break;
> -		case CS8: arg = DIGI_WORD_SIZE_8; break;
> +		case CS5:
> +			arg = DIGI_WORD_SIZE_5; break;
> +		case CS6:
> +			arg = DIGI_WORD_SIZE_6; break;
> +		case CS7:
> +			arg = DIGI_WORD_SIZE_7; break;
> +		case CS8:
> +			arg = DIGI_WORD_SIZE_8; break;
>  		default:
>  			dev_dbg(dev,
>  				"digi_set_termios: can't handle word size %d\n",
> @@ -967,16 +990,30 @@ static void digi_write_bulk_callback(struct urb *urb)
>  	int status = urb->status;
>  	bool wakeup;
>  
> -	/* port and serial sanity check */
> -	if (port == NULL || (priv = usb_get_serial_port_data(port)) == NULL) {
> -		pr_err("%s: port or port->private is NULL, status=%d\n",
> +	/* port sanity check */
> +	if (port == NULL) {
> +		pr_err("%s: port is NULL, status=%d\n",
> +			__func__, status);
> +		return;
> +	}
> +	/* serial sanity check */
> +	priv = usb_get_serial_port_data(port);
> +	if (priv == NULL) {
> +		pr_err("%s: port->private is NULL, status=%d\n",
>  			__func__, status);
>  		return;
>  	}
>  	serial = port->serial;
> -	if (serial == NULL || (serial_priv = usb_get_serial_data(serial)) == NULL) {
> +	if (serial == NULL) {
>  		dev_err(&port->dev,
> -			"%s: serial or serial->private is NULL, status=%d\n",
> +			"%s: serial  is NULL, status=%d\n",
> +			__func__, status);
> +		return;
> +	}
> +	serial_priv = usb_get_serial_data(serial);
> +	if (serial_priv == NULL) {
> +		dev_err(&port->dev,
> +			"%s: serial->private is NULL, status=%d\n",
>  			__func__, status);
>  		return;
>  	}
> @@ -1309,13 +1346,17 @@ static void digi_read_bulk_callback(struct urb *urb)
>  			__func__, status);
>  		return;
>  	}
> -	if (port->serial == NULL ||
> -		(serial_priv = usb_get_serial_data(port->serial)) == NULL) {
> -		dev_err(&port->dev, "%s: serial is bad or serial->private "
> +	if (port->serial == NULL) {
> +		dev_err(&port->dev, "%s: serial is bad,"
> +			" status=%d\n", __func__, status);
> +		return;
> +	}
> +	serial_priv = usb_get_serial_data(port->serial);
> +	if (serial_priv == NULL) {
> +		dev_err(&port->dev, "%s:serial->private "
>  			"is NULL, status=%d\n", __func__, status);
>  		return;
>  	}
> -
>  	/* do not resubmit urb if it has any status error */
>  	if (status) {
>  		dev_err(&port->dev,
> -- 
> 2.34.1
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

