Return-Path: <linux-kernel+bounces-568033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD3A68D32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C169188D478
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54EF2561DE;
	Wed, 19 Mar 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="RIvRaYIT"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A1212B3B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388653; cv=none; b=E3mEh4Bwx0j8gnobNtDPlH+F9qyo/IKaPerGC3Kh9/kTwgL6Di5pxY5MgpScY8bXBaW3KWqCK+S4HyzJbJBTv9sxb8NjgGSP0tWsTXPWB9IPg1/8VHoYKF/9tNxDniOv6/3OixfM8+SLCCs0jvJcpwAqccsuZdGIywVpJqeXf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388653; c=relaxed/simple;
	bh=Vgu9QpLQ8NzMteKcw39Ik0lHKvd7kXEza/zrlY12YHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOIIHPKTe7zA5uqcgm8kJbSOC4ESOaOzy3yy2wsqI0HYeBcHoD0kRSgKcNzK9pUTYIlVF1nY8tVNFocWMdLk2ntvkJgd7HxGYAdd2G4qk9+N6Q+XwQD8ElYfG4cDuyp9EHutcGqFJoXCc+bdp4ssEw5g3c2iKJ0AiRbGzKOO09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=RIvRaYIT; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
Date: Wed, 19 Mar 2025 23:50:04 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1742388644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQUJuu8RR3480H+KUDZsaepfSJB1QqD/N+g3TCs245U=;
	b=RIvRaYITSHqAnUwm2pI83P1Gp0Mo4KjsiJq7hq4+E6mFDS34mM8Jqppr5FGugruST0Bgkq
	2227YIq1TyUavT4FSCCUklUzfunP/aTz3wwNiBTANEH0G7XrL9WpA/eRmWPSyxy1nV6Ji7
	U7Abh6PTWacCKv3qOjIqTLGJIbig0I23NBlpqMfGYsyVuS4lYLtLegsOPmIipyrsLIf+LV
	2x1OqqDBBD3eceTyF1aPxBoxK1TPpOu7MJtrRGGJhE6HM17imnUfqTwvdb/u6hO7Geiozw
	+fCEhwmxb9Gjo1ST/7u2xxmtfKSKfREtdHQ+jDZh+Z72jWuAVPjh3eLPBLyXkg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ch341: Clear interrupt register after each
 interrupt
Message-ID: <Z9q9fD0Gi4WxjFkT@titan>
References: <20250319-ch341-v1-1-9f33f051fc6a@jookia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-ch341-v1-1-9f33f051fc6a@jookia.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 01:52:20AM +1100, John Watts wrote:
> The CH340 adapter I have won't send interrupts unless you clear the
> 0x2727 register after each interrupt. The Windows driver does this but
> neither the mainline Linux or OEM Linux driver do this.
> 
> Without this fix the device status flags for hardware flow control are
> never updated.
> 
> As far as I can tell there is not a register to configure this
> behaviour, this seems to be a hardware quirk. The chip reports an
> identical version, vendor and product to a working chip. It's possible
> this is a clone chip only tested against Windows.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
> This fixes hardware flow control flags like RTS and CTS not updating on
> a specific (fake?) CH340 chip I have.
> 
> John Paul Morrison reported an issue that sounds similar to this one in
> 2022:
> https://lore.kernel.org/all/YlP1poVgy0bAP3MN@hovoldconsulting.com/T/

After a lot more testing it looks like this isn't the correct way to fix
this issue: Status changes will still be dropped if they trigger two
interrupts in quick succession as I don't poll the status. This is
something that can happen fairly easily with a null modem cable that
connects DTR to DSR+DCD.

The only proper fix here is to put modem status updates in to its own
worker that is triggered when we suspect the modem status is out of
date. It would clear interrupts then read the status properly.

John.

> ---
>  drivers/usb/serial/ch341.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
> index d10e4c4848a0ab9073c4c93638a8796ab61ce3a6..8edbac18146cebd0ff7b9cfaca6853a2c5f047df 100644
> --- a/drivers/usb/serial/ch341.c
> +++ b/drivers/usb/serial/ch341.c
> @@ -63,6 +63,7 @@
>  #define CH341_REG_DIVISOR      0x13
>  #define CH341_REG_LCR          0x18
>  #define CH341_REG_LCR2         0x25
> +#define CH341_REG_INTERRUPT    0x2727
>  
>  #define CH341_NBREAK_BITS      0x01
>  
> @@ -102,6 +103,9 @@ struct ch341_private {
>  	u8 version;
>  
>  	unsigned long break_end;
> +
> +	struct work_struct interrupt_work;
> +	struct usb_serial_port *port;
>  };
>  
>  static void ch341_set_termios(struct tty_struct *tty,
> @@ -306,6 +310,32 @@ static int ch341_get_status(struct usb_device *dev, struct ch341_private *priv)
>  	return 0;
>  }
>  
> +static int ch341_clear_interrupt(struct usb_device *dev)
> +{
> +	int r;
> +
> +	r = ch341_control_out(dev, CH341_REQ_WRITE_REG,
> +			CH341_REG_INTERRUPT, 0);
> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
> +static void ch341_interrupt_work(struct work_struct *work)
> +{
> +	struct ch341_private *priv =
> +		container_of(work, struct ch341_private, interrupt_work);
> +	struct usb_serial_port *port = priv->port;
> +	int ret;
> +
> +	ret = ch341_clear_interrupt(port->serial->dev);
> +	if (ret < 0) {
> +		dev_err_once(&port->dev, "failed to clear interrupt: %d\n",
> +			ret);
> +	}
> +}
> +
>  /* -------------------------------------------------------------------------- */
>  
>  static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
> @@ -399,6 +429,9 @@ static int ch341_port_probe(struct usb_serial_port *port)
>  	if (r < 0)
>  		goto error;
>  
> +	INIT_WORK(&priv->interrupt_work, ch341_interrupt_work);
> +	priv->port = port;
> +
>  	return 0;
>  
>  error:	kfree(priv);
> @@ -438,8 +471,10 @@ static void ch341_dtr_rts(struct usb_serial_port *port, int on)
>  
>  static void ch341_close(struct usb_serial_port *port)
>  {
> +	struct ch341_private *priv = usb_get_serial_port_data(port);
>  	usb_serial_generic_close(port);
>  	usb_kill_urb(port->interrupt_in_urb);
> +	flush_work(&priv->interrupt_work);
>  }
>  
>  
> @@ -466,6 +501,12 @@ static int ch341_open(struct tty_struct *tty, struct usb_serial_port *port)
>  		goto err_kill_interrupt_urb;
>  	}
>  
> +	r = ch341_clear_interrupt(port->serial->dev);
> +	if (r < 0) {
> +		dev_err(&port->dev, "failed to clear interrupt: %d\n", r);
> +		goto err_kill_interrupt_urb;
> +	}
> +
>  	r = usb_serial_generic_open(tty, port);
>  	if (r)
>  		goto err_kill_interrupt_urb;
> @@ -474,6 +515,7 @@ static int ch341_open(struct tty_struct *tty, struct usb_serial_port *port)
>  
>  err_kill_interrupt_urb:
>  	usb_kill_urb(port->interrupt_in_urb);
> +	flush_work(&priv->interrupt_work);
>  
>  	return r;
>  }
> @@ -747,6 +789,7 @@ static void ch341_update_status(struct usb_serial_port *port,
>  static void ch341_read_int_callback(struct urb *urb)
>  {
>  	struct usb_serial_port *port = urb->context;
> +	struct ch341_private *priv = usb_get_serial_port_data(port);
>  	unsigned char *data = urb->transfer_buffer;
>  	unsigned int len = urb->actual_length;
>  	int status;
> @@ -770,6 +813,8 @@ static void ch341_read_int_callback(struct urb *urb)
>  
>  	usb_serial_debug_data(&port->dev, __func__, len, data);
>  	ch341_update_status(port, data, len);
> +	schedule_work(&priv->interrupt_work);
> +
>  exit:
>  	status = usb_submit_urb(urb, GFP_ATOMIC);
>  	if (status) {
> @@ -830,6 +875,12 @@ static int ch341_reset_resume(struct usb_serial *serial)
>  			dev_err(&port->dev, "failed to read modem status: %d\n",
>  				ret);
>  		}
> +
> +		ret = ch341_clear_interrupt(port->serial->dev);
> +		if (ret < 0) {
> +			dev_err(&port->dev, "failed to clear interrupt: %d\n",
> +				ret);
> +		}
>  	}
>  
>  	return usb_serial_generic_resume(serial);
> 
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250319-ch341-aab9934f1c72
> 
> Best regards,
> -- 
> John Watts <contact@jookia.org>
> 

