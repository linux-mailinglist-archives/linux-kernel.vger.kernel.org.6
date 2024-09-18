Return-Path: <linux-kernel+bounces-332488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E6697BA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18CDB265CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6117A586;
	Wed, 18 Sep 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UG5uqqPU"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68684158A36
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653217; cv=none; b=bjZyYAenIMt9T0hciggncmA/PqnQsDCBiKxVRqPa5AdRpguTgNouiWwi3J19TzbLFPBPr6ZA9X2oBOjejcx1UNOZ9s7q1dJKwIb11nbc1xdUX7UsDJt7Rxu7IiABxp+YLeaXCI3lEQMiDY+noBpqomq54xOvbJD+8imdUc1Snf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653217; c=relaxed/simple;
	bh=qX3WYQ6+Vf/oHkvyYC7tQqdcfeK8ooGc7TQuG0J4/8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrjsBs3y9J7ymCt/pTtHlDqEbFrrC4dCmf3At69Db5YwcnU76dJbraYR6CmS62Fkw5ORZlpwa3MqfjZvnI1DXtNRQis910RzgHs6lkHH8r/ygEJRT9T2cCnyJ1JbHyOSmA1uz8q9sVR8ovF0CKI/3Cvjy5Zrnv/vHTPLP+W9ph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UG5uqqPU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53660856a21so4803751e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726653211; x=1727258011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upynp3eGtaZUvy8FwKmWHNrTSvjQZK+dz1216GoCigI=;
        b=UG5uqqPUAAKks/48aphmRg6pW8eGj0PYXA8UNzrGuQSZDFTEKx/4l+DhAZfUSBHUKN
         l05E2ZqqzDHiS/DPiUqxaFNqHl1cbDUOZ1l7ORZ72Y81Pp0BNsSesEK6ZGCDivu6c6y1
         5hhRNfuobukU9dhjxQayGxDsxycpK9S7/XVXmPv2FeMY9E+XhWCeYD7PXHObeTJ2SknF
         k8zq7TPP5yTdnm+8cSt631YXy6jNppLAJFHenmJhqSMSZmBDXMOc6fE3p7QdVydahug3
         XIntAojmfJA+MXFxWzFlZiYSVqI5vN2jegbPyw9nqE4und4kQLSt++/4XDHOd1PhZXon
         qAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726653211; x=1727258011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upynp3eGtaZUvy8FwKmWHNrTSvjQZK+dz1216GoCigI=;
        b=cimnAJcjZAH/rHUA+eMg5km8mkvjFPRLrjHKkAM1Bz/5NdqGA7LyjK3jfq2ewESDIl
         yYhGZJiTprzNWg+35BbIIZ0dxiGmmayxiyddn942cZ/iR0fLYSyEoPw/IYclH9yOETrM
         XripcXgOBHDbtN4/H5r9SQeYmQYxny/6a8NMOxpc/nkcV01ofvfzax6gURjszJ9frF4c
         FlYyxbfPkU+ZW0T6WPlF6bbmxkYkmt1zWmyeY/gzBxmUOPDthA/1mdxYuYZjmCW2DVPQ
         WlzAxw/aDg1E8wGRlHLIoc320cETjGpIMUDWqZXC2h2hPAAEkUX3Nwoh8btBdWKU0s4u
         QM2A==
X-Forwarded-Encrypted: i=1; AJvYcCUwlFmLx5gSvJr6CrTCsyxfiYplNUNWABxyAiD4lT4Kq6O5NkEysJ+9sCiJRbJoFA3FGwf8k7w+x1UJG/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZNRLj5FLyvN1hefpeSM9/4e1rovHpVEt+w+kJ2dg+Cei/syl
	Rbn+2FvxB4pviztiF0Ts/g70bS38rX3XYg6qQ3TcxkBg9dPIgLBrqxvWwafW4gc=
X-Google-Smtp-Source: AGHT+IHpLFVaei2ayXOSJPg4gOV/F1ms9cHgsY6XrAy2tPIaJLJ7WLMBOrHs/jINB0vWDzucU8A1WA==
X-Received: by 2002:a05:6512:6c3:b0:533:4652:983a with SMTP id 2adb3069b0e04-5367fef1846mr10734532e87.35.1726653211318;
        Wed, 18 Sep 2024 02:53:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d19cfsm61744945ad.157.2024.09.18.02.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 02:53:30 -0700 (PDT)
Date: Wed, 18 Sep 2024 11:53:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>, Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>, Udit Kumar <u-kumar1@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH next v2 2/4] serial: 8250: Split out IER from
 rs485_stop_tx()
Message-ID: <ZuqjCN18dSUDEa0d@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913140538.221708-3-john.ogness@linutronix.de>

On Fri 2024-09-13 16:11:36, John Ogness wrote:
> Move IER handling out of rs485_stop_tx() callback and into a new
> wrapper serial8250_rs485_stop_tx(). Replace all callback call sites
> with wrapper, except for the console write() callback, where it is
> inappropriate to modify IER.

It would be great to provide more details:

  + why it is done (IER modification requires port lock?)

  + why it is suddenly safe to call serial8250_em485_handle_stop_tx()
    without holding &p->port.lock


> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -558,7 +558,7 @@ static int serial8250_em485_init(struct uart_8250_port *p)
>  
>  deassert_rts:
>  	if (p->em485->tx_stopped)
> -		p->rs485_stop_tx(p);
> +		serial8250_rs485_stop_tx(p);

This would keep the same functionality only when

	p->rs485_stop_tx == serial8250_em485_stop_tx

Is it always the case?
Is it OK when it is not the case?

For example, serial8250_em485_init() is involved in bcm2835aux driver
probe which uses another rs485_stop_tx() callback, see below.

>  
>  	return 0;
>  }
> @@ -1397,16 +1396,29 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
>  	/*
>  	 * Empty the RX FIFO, we are not interested in anything
>  	 * received during the half-duplex transmission.
> -	 * Enable previously disabled RX interrupts.
>  	 */
> -	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> +	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
>  		serial8250_clear_and_reinit_fifos(p);
> +}
> +EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
> +
> +/**
> + * serial8250_rs485_stop_tx() - stop rs485 transmission, restore RX interrupts
> + * @p: uart 8250 port
> + */
> +void serial8250_rs485_stop_tx(struct uart_8250_port *p)
> +{
> +	/* Port locked to synchronize UART_IER access against the console. */
> +	lockdep_assert_held_once(&p->port.lock);
> +
> +	p->rs485_stop_tx(p);
>  
> +	/* Enable previously disabled RX interrupts. */
> +	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
>  		p->ier |= UART_IER_RLSI | UART_IER_RDI;
>  		serial_port_out(&p->port, UART_IER, p->ier);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
>  
>  static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
>  {
> @@ -1418,7 +1430,7 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
>  	serial8250_rpm_get(p);
>  	uart_port_lock_irqsave(&p->port, &flags);
>  	if (em485->active_timer == &em485->stop_tx_timer) {
> -		p->rs485_stop_tx(p);
> +		serial8250_rs485_stop_tx(p);

This causes that UART_IER is manipulated for all p->rs485_stop_tx()
callbacks. Is that correct, please?

For example, it seems serial8250_em485_handle_stop_tx() might be used
also by bcm2835aux driver. It set by:

static int serial8250_em485_init(struct uart_8250_port *p)
{
	[...]
	p->em485->stop_tx_timer.function = &serial8250_em485_handle_stop_tx;
	[...]
}

which is called via

int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
			    struct serial_rs485 *rs485)
{
	[...]
	if (rs485->flags & SER_RS485_ENABLED)
		return serial8250_em485_init(up);
	[...]
}

which is set by:

static int bcm2835aux_serial_probe(struct platform_device *pdev)
{
	[...]
	up.port.rs485_config = serial8250_em485_config;		<--------
	[...]
	up.rs485_stop_tx = bcm2835aux_rs485_stop_tx;
	[...]
}

But this same _probe() call sets

	up.rs485_stop_tx = bcm2835aux_rs485_stop_tx;

which does not manipulate UART_IER.

>  		em485->active_timer = NULL;
>  		em485->tx_stopped = true;
>  	}
> @@ -1450,7 +1462,7 @@ static void __stop_tx_rs485(struct uart_8250_port *p, u64 stop_delay)
>  		em485->active_timer = &em485->stop_tx_timer;
>  		hrtimer_start(&em485->stop_tx_timer, ns_to_ktime(stop_delay), HRTIMER_MODE_REL);
>  	} else {
> -		p->rs485_stop_tx(p);
> +		serial8250_rs485_stop_tx(p);

I can't find easily whether serial8250_em485_stop_tx() is always set
as p->rs485_stop_tx callback here. I would expect that it might be
another callback. It is a callback after all.

Is it always safe?

>  		em485->active_timer = NULL;
>  		em485->tx_stopped = true;
>  	}

Best Regards,
Petr

