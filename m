Return-Path: <linux-kernel+bounces-318870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4CB96F464
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06251F24B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AEA1CCB53;
	Fri,  6 Sep 2024 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CMBNxYFA"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F521A2C39
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626245; cv=none; b=THj2Yd8TlbZNoQIlH/QCYcxSh92G9IXRZrEm1bzYTZN04WjP8ChJ5otomh7oRXVOPBHII5rplMtoLSBblMaIr5ScugRAQA7UsBgE9eNwH2MPIRjSDyvn06RLw/mKPpb4sklJkqys1pJXj6cjzr2QXzZ4Dqt6V4c/Lr6MOq1hCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626245; c=relaxed/simple;
	bh=NJe/rIXJ+NT4IVv2bVq31vlJmHI1mWgRJANW7wsGAM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh1vgReugpzm/RNrJ2I/G9e5XNLpo4oNLC2NG7MVMqisi2XGHyIOrsxIfNzihjPchRzYbRzVYwkWU0BgpLVd+lyprnGs4IBbF2faJQ8FOjDBeldV0vxoHCZVO5Bkb5zyrwzTQKkv0z0yejuiL6M3fj/s6PDxGc7+zrHeerparmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CMBNxYFA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53438aa64a4so2084953e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725626242; x=1726231042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/Ay4ffTsg800t8woUNwG83byxvnL8SX0SnXJSfh5LU=;
        b=CMBNxYFAP2y4sBKRTLRE8s9Pd1bI8IcMFRJxLUhuyz5WAEYizHAQHXc0KCOl3roDJ/
         BZBzned7yyELEsGakeRZh0XdC3Ga27fkLwyTa7hFezgDTlnna23zMHz59sdvHa1DkmB+
         AuvsDV2HRlxygLF26rWaJ1CmO/Bs8X/s+SOp7SA2joiczmdhdNcsUywhHLsjAr5nMZ+b
         ueASkvKAqiHdeV+rHGxqh5IHbEbdmH++Zf6h3vvOzAj+JDs/D0GZj9KwJ1/OoByU0tqq
         T0A3Dum1erUgvztfKBoyf28xIg9DURPkoPLmQRnOjxkA1YdWoLi8l/Pa878YqOCv72Rk
         Vo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725626242; x=1726231042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/Ay4ffTsg800t8woUNwG83byxvnL8SX0SnXJSfh5LU=;
        b=JSTXWxm5TXRlAZtdWHbD52FGUVYrh7nquruit3J7Ky0qLQ0+RCO5D90MZehZOPnIXI
         WdVK1qb3M67G5/iiupI9yLJdsZgvqAHfUY0Ixt3Ay5iPk/qTHCB969ic5HSMYV4xSo29
         QRx6SVcf3oeG35wTCCYh+M6AHd4bKeG1K0f9KT8xep+6bK2WKqkRDkVTORNXl93GWI04
         cu629/swHrbd5aqIFYBProtJOtzUoPakmBXj/Er8+YFDPGQRRW0prlK+WZM61dGQOrB+
         6SAKZtYvXtH8skEOag8cL7pV0oQfKMdcVeRDhLdOAfk2t47LAulyoj0/9akJ/nDV6xg8
         1QCA==
X-Forwarded-Encrypted: i=1; AJvYcCUCWRrf7v4u6N2J51ZM2zj6CnveGkpRhEHVx9MNGy3UtBimx1bjdTPChHNOITM5kbfr4b37mTDCyzCSeuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR6yv11AbClX5kg2mh9gm0GsDpPhBX3Z15caAzkkgrPoOBk+an
	Tn9Uivupgnx3SZotz1meHrAKm4LfHbKC2hLaIZq8gpbxsKfw10hY/fc6UxQH7+s=
X-Google-Smtp-Source: AGHT+IEvbn3cfcZhjtaT6x4x5o1bTg0s4aL5vUCAn7oA67W0cAj0BmjIXro40QGz4peUaca1k/L7Tg==
X-Received: by 2002:a05:6512:31ce:b0:52c:e3ad:3fbf with SMTP id 2adb3069b0e04-536587fbb36mr1457304e87.42.1725626241399;
        Fri, 06 Sep 2024 05:37:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6af28c70sm231088866b.154.2024.09.06.05.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:37:21 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:37:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
Message-ID: <Ztr3f8M2FaT2Rz1c@pathway.suse.cz>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <20240905134719.142554-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905134719.142554-2-john.ogness@linutronix.de>

On Thu 2024-09-05 15:53:18, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks (write_atomic,
> write_thread, device_lock, device_unlock) and add CON_NBCON to the
> initial flags.
> 
> The legacy code is kept in order to easily switch back to legacy mode
> by defining USE_SERIAL_8250_LEGACY_CONSOLE.
> 
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -388,6 +388,7 @@ void __init serial8250_register_ports(struct uart_driver *drv, struct device *de
>  
>  #ifdef CONFIG_SERIAL_8250_CONSOLE
>  
> +#ifdef USE_SERIAL_8250_LEGACY_CONSOLE

Just for record. I agree that it is better to simply remove the
obsolete legacy code.

Or maybe, we would need to keep it for the rs485 consoles, see below.

>  static void univ8250_console_write(struct console *co, const char *s,
>  				   unsigned int count)
>  {
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -546,6 +546,13 @@ static int serial8250_em485_init(struct uart_8250_port *p)
>  	if (!p->em485)
>  		return -ENOMEM;
>  
> +#ifndef USE_SERIAL_8250_LEGACY_CONSOLE
> +	if (uart_console(&p->port)) {
> +		dev_warn(p->port.dev, "no atomic printing for rs485 consoles\n");
> +		p->port.cons->write_atomic = NULL;
> +	}

Wait! This makes the rs485 consoles much less usable for debugging.
They might have troubles to see the emergency and panic messages.
Or do I miss anything, please?

Is this acceptable? Why?
Why is this limitation exactly needed?

Is is because the following code is not safe enough for the write_atomic
variant when it is guarded only by the nbcon context ownership?

void serial8250_console_write_thread(struct uart_8250_port *up,
				     struct nbcon_write_context *wctxt)
{
[...]
	if (em485) {
		if (em485->tx_stopped)
			up->rs485_start_tx(up);
		mdelay(port->rs485.delay_rts_before_send);
	}
[...]
	if (em485) {
		mdelay(port->rs485.delay_rts_after_send);
		if (em485->tx_stopped)
			up->rs485_stop_tx(up);
	}
[...]

Would it break even the nbcon console context it taken over the safe
way? Or only by "unsafe" takeover?

IMHO, we should risk the "unsafe" takeover. We still would be
in a better situation than the legacy code which ignores
the port->lock during panic() all the time (after bust_

> +#endif
> +
>  	hrtimer_init(&p->em485->stop_tx_timer, CLOCK_MONOTONIC,
>  		     HRTIMER_MODE_REL);
>  	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
> @@ -3269,6 +3285,11 @@ static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
>  
>  	wait_for_xmitr(up, UART_LSR_THRE);
>  	serial_port_out(port, UART_TX, ch);
> +
> +	if (ch == '\n')
> +		up->console_newline_needed = false;
> +	else
> +		up->console_newline_needed = true;

I might be just dumb but this code confused me. I missed that the
variable was actually set after printing the character. I inverted
the logic in my head and it did not make sense.

I vote for adding a comment. Or better make the code more
straightforward by renaming the variable and inverting the logic:

	if (ch == '\n')
		up->console_line_ended = true;
	else
		up->console_line_ended = false;

>  }
>  
>  /*
> @@ -3421,6 +3443,125 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  	if (locked)
>  		uart_port_unlock_irqrestore(port, flags);
>  }
> +#else
> +void serial8250_console_write_thread(struct uart_8250_port *up,
> +				     struct nbcon_write_context *wctxt)
> +{
> +	struct uart_8250_em485 *em485 = up->em485;
> +	struct uart_port *port = &up->port;
> +	unsigned int ier;
> +
> +	touch_nmi_watchdog();

This should not be needed in the write_thread() variant because
it allows to schedule after emitting one record.

> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
> +

The rest looks good.

Best Regards,
Petr

