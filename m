Return-Path: <linux-kernel+bounces-333607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 180C997CB44
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8118285DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E57B190477;
	Thu, 19 Sep 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V5gxiNxS"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F21E522
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758132; cv=none; b=ispPWZVhM3oRJ/pNFEN7ftvOTFY8KLZw9IKMTk9A05RyjY/bJYli6HrzLtZaoNp1xOOhvpofi/ro7eLiFIW0iIMn7I+xEps0s36eoWOJsjvlAIDtlAcEAfXvipeAaUkSbEzGehqi2hVzNDPVJmhnimNlvn637kXrKvltVXtfSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758132; c=relaxed/simple;
	bh=YpUk7QNqAoJUkAbDvBnTy3VZp3BINGaqpAaOyQTJMqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWM8og3aDP0xv4u7mXHNT4Kecq4rbyDLDMssvsKEJ2G9slPBxsUcesySMaWlsOerVwAAzJIfHMcrxdOOH8Dyfbi9YAv5lakI19Oi+wKAQ9E93B1rCFU0whkwdMlnTw4k6nq5oS/mL+Bwh5jaSJl992Z2oOD+ehlkeeuw0I6Zmlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V5gxiNxS; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so1187146e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726758129; x=1727362929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCm2GzzK+q+0wa6+stISbobtFnZrzd/LjiQZU2jYSWs=;
        b=V5gxiNxSUp0+xSFLz7LiQtg8HtpnxGvBDU6aE60/CbhUQJGbC9PJxvG0fhFf8xX5RR
         4vDdyE78H9xK1yBV1Cz2duZ2j6h1OXFbsFS+/Dc8GiH4gcdKBts4b/JGdBaSSWWgzOdp
         Hra/oo8hbgMwbPuVT9D2Ygj5H2oXluxgJ0Kaa950UNyHYTwpzS/1ST1RvoaQyGo25Tl0
         wKY0xLkPSzUi3331n7tA+odUTQS66VnjN6NoPFOaHsxd32iQA1uHvu+r6EX6FE6FejwM
         2JLFATCDfa4eibeq3ywoAfmSOuEpdrnMfGyLq4m2ygTskI9nPeoKWdn2n9SXGxgpysRN
         cINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726758129; x=1727362929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCm2GzzK+q+0wa6+stISbobtFnZrzd/LjiQZU2jYSWs=;
        b=aVbHgFmCgAuC7cHIz32ZfrtkhF0yBdUK9flUAlI/27uoX7UK5Jr0/mneHMn3oJ5v0+
         jLTBKthc4iC7eb+pbI2oC7M6rMjiB+GgzlAMSRM28BMic6T06xlIuxedwHhSjE0iaXAr
         RTxlajTonjRFpdRkoY8lNdcoKzRdNdJUT8ud4Yfo8PyqGzz42mhF7lYGFpCe3orQWsX0
         OzM/ipMXSRiysfIOK7RrMw2Sba5tp/eVlvVty0G7QJY92qndOeGTsk8+h0kObLVXGWzH
         gp89V3v53BR75WEpSrjdjJv+5pdLBbEZQtnBadUyzCPNd6OKfLploeHo/7nggRP97H+Q
         z8TA==
X-Forwarded-Encrypted: i=1; AJvYcCVqNs59QlzospFn0Atc8/1f9GHWUSXhH0yjCxbGswoBY4i3Av20aP0qiInwGm/tZbSVW7+kjD5J6TDafT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1FQD8bo355jkcqw2dBAWeyfheSF+Y/pM8/Dk4aDZArTU2F40r
	jHOjXJufme3TA8ca8z0Il8/yl6pq7WyI6rwvrW6WCPrnt0UKy4BWgJsop5WSPhE=
X-Google-Smtp-Source: AGHT+IFRQsoIHdcvjt2JIpniZeK8k6MPo4O04rrl7ltLpXb2c258J/bIcA534MWSbuTQYrLAiz5l1Q==
X-Received: by 2002:a05:6512:3b0e:b0:52e:9fe0:bee4 with SMTP id 2adb3069b0e04-53678fb731bmr14420533e87.9.1726758128411;
        Thu, 19 Sep 2024 08:02:08 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef978besm1958074a91.57.2024.09.19.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 08:02:06 -0700 (PDT)
Date: Thu, 19 Sep 2024 17:01:49 +0200
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
	Sunil V L <sunilvl@ventanamicro.com>, Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH next v2 1/4] serial: 8250: Split out IER from
 rs485_start_tx()
Message-ID: <Zuw83ZyzeKxA6RmE@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-2-john.ogness@linutronix.de>
 <ZumWuketXcGQNw49@pathway.suse.cz>
 <84ldzproiy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ldzproiy.fsf@jogness.linutronix.de>

On Wed 2024-09-18 17:10:53, John Ogness wrote:
> On 2024-09-17, Petr Mladek <pmladek@suse.com> wrote:
> > Sigh, I am trying to review this patch but I am not familiar with the
> > code. Feel free to ignore me when the questions are completely off.
> 
> I appreciate you researching where the code came from. I made my changes
> based on what I see the code doing now.
> 
> >> --- a/drivers/tty/serial/8250/8250_port.c
> >> +++ b/drivers/tty/serial/8250/8250_port.c
> >>  void serial8250_em485_start_tx(struct uart_8250_port *up)
> >>  {
> >>  	unsigned char mcr = serial8250_in_MCR(up);
> >>  
> >> +	/*
> >> +	 * Some chips set the UART_LSR_DR bit even when UART_IER_RDI is
> >> +	 * disabled, so explicitly mask it.
> >> +	 */
> >>  	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
> >> -		serial8250_stop_rx(&up->port);
> >> +		up->port.read_status_mask &= ~UART_LSR_DR;
> >
> > This change is related to disabling UART_IER_RDI but we do not longer
> > disable it in this code path.
> 
> Correct. It will be disabled in the new wrapper
> serial8250_em485_start_tx(). For the console write() callback, RDI is
> already being disabled (IER is cleared). It will not use the wrapper.
> 
> > Why do we need to do it here, please?
> 
> Because the console write() callback also needs to clear LSR_DR. That
> part of the callback needs to stay.
> 
> > Why is it needed only in the em485-specific path, please?
> 
> Only RS485 deals with controlling TX/RX directions.
> 
> > On one hand, the comment talks about UART_LSR_DR and UART_IER_RDI
> > so seems to be relater.
> 
> I do not know if the LSR_DR modify is strictly necessary. I am just
> preserving the existing behavior (and related comment). The disabling of
> IER_RDI will still happen (via wrapper or explicitly as in the console
> write() callback).
> 
> >>  static bool start_tx_rs485(struct uart_port *port)
> >>  {
> >> @@ -1585,7 +1600,7 @@ static bool start_tx_rs485(struct uart_port *port)
> >>  	if (em485->tx_stopped) {
> >>  		em485->tx_stopped = false;
> >>  
> >> -		up->rs485_start_tx(up);
> >> +		serial8250_rs485_start_tx(up);
> >
> > If I get this correctly then this keeps the existing behavior when
> >
> >     up->rs485_start_tx == serial8250_em485_start_tx
> 
> Correct.
> 
> > Is this always the case, please?
> 
> Yes.
> 
> > Can start_tx_rs485() be called for the 8250_bcm2835aux.c driver?
> 
> Yes.

IMHO, the answer "Yes" to both last questions can't be valid.
The 8250_bcm2835aux driver does:

static int bcm2835aux_serial_probe(struct platform_device *pdev)
{
	[...]
	up.rs485_start_tx = bcm2835aux_rs485_start_tx;
	[...]
}

As a result, the 1st "Yes" was not correct:

	up->rs485_start_tx != serial8250_em485_start_tx

and this patch would change the behavior for the 8250_bcm2835aux driver.
Before, start_tx_rs485() called directly:

	up->rs485_start_tx(up);

Newly, it would call:

	void serial8250_rs485_start_tx(struct uart_8250_port *up)
	{
		if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
			serial8250_stop_rx(&up->port);

		up->rs485_start_tx(up);
	}

It means that it could call serial8250_stop_rx() even when it was not
called by the original code.

And SER_RS485_RX_DURING_TX seems to be checked even in
drivers/tty/serial/8250/8250_bcm2835aux.c. So, it looks like it
might be (un)set even for this driver.

Or is this code path prevented in start_tx_rs485()? I mean that
em485->tx_stopped could never be true for the 8250_bcm2835aux
driver?

But I see

	static int bcm2835aux_serial_probe(struct platform_device *pdev)
	{
		[...]
		up.port.rs485_config = serial8250_em485_config;
		up.port.rs485_supported = serial8250_em485_supported;
		[...]
	}

=> It looks like even bcm2835aux driver could have the em485 thing.
   But it obviously wanted to something special in
   up->rs485_start_tx().

It looks to me that the change might either cause regression.
Or it would deserve a comment unless the validity is obvious for people
familiar with the code.

Best Regards,
Petr

