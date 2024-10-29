Return-Path: <linux-kernel+bounces-387305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4189B4F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6981F265BE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716501990CD;
	Tue, 29 Oct 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XO3DgkGm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E8198A35
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219066; cv=none; b=KucUFKImYEM8Wa8B4LEX2H3hq7+Og0qySVhXVW9sjj/22mDxrBkriC1em5KvOSE0645zLpt1gTxwlvk+PxQwCWvTv2YzHjrUTYgiPfiOR2+duJojFxfQx6/CfxfdQcWubZc1Pgt+Eu8ThwwrAjopx29PNwjXh1Han5x7XpwQo1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219066; c=relaxed/simple;
	bh=C65qfDDDxCTRTP97/W4uzaYzCBQIJJ/LO3jBSxMCD/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCJ3i4Cj0lfUHzc6MS27vheMXOQQ4OkGMlp9TDRypG7xcVKX24n/0b536qxp+WlJfchMYXa5wxLUruBA3RPihUya9pH9gnklad4JBbRMABoYbgbf9HD4WZV7lGFIXdERh3ob0tzxGu+R01363Nq3Cor7GYwMq8uCxSQRMlHSYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XO3DgkGm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730219063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sBEBhcwFRWdEyrYlXSEyJ0AeIl4d7kyeomTAvUDYmHc=;
	b=XO3DgkGmdQRS1i0jwsdJEwaOcpLqhs0uW2aVov4NFvE3+x3BrOw7pn2vinz/T6tQtiWopn
	LHq0SBDFWAPtR7P16NCmtd96UxfIOxInoNcdKahvnD00E1YBX+3vFIyIS7VFK29p7xzXeo
	My46RDXCDkGMJHfKxsxu1sDMfoSnsn4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-rx-gZuZfNt6DqaA-qm1PGg-1; Tue,
 29 Oct 2024 12:24:19 -0400
X-MC-Unique: rx-gZuZfNt6DqaA-qm1PGg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 440761955D4C;
	Tue, 29 Oct 2024 16:24:17 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.170])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0CAFE19560AA;
	Tue, 29 Oct 2024 16:24:10 +0000 (UTC)
Date: Tue, 29 Oct 2024 13:24:09 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rengarajan S <rengarajan.s@microchip.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for
 FIFO mode
Message-ID: <gdgngas4qc4mv4efghwzi5z7zbg7imvupjcyiskbyedivclwoi@vus4vxbsnqgu>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-2-john.ogness@linutronix.de>
 <Zxug3qF9KUOn4VaM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxug3qF9KUOn4VaM@smile.fi.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Oct 25, 2024 at 04:45:02PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 25, 2024 at 01:03:23PM +0206, John Ogness wrote:
> > After a console has fed a line into TX, it uses wait_for_xmitr()
> > to wait until the data has been sent out before returning to the
> > printk code. However, wait_for_xmitr() will timeout after 10ms,
> 
> printk here is a function reference or module?
> For the latter I would use the filename to be sure it's clear,
> like printk.c. For the former (and it seems you know that)
> we may use printk().
> 
> > regardless if the data has been transmitted or not.
> > 
> > For single bytes, this timeout is sufficient even at very slow
> > baud rates, such as 1200bps. However, when FIFO mode is used,
> > there may be 64 bytes pushed into the FIFO at once. At a baud
> > rate of 115200bps, the 10ms timeout is still sufficient.
> > However, when using lower baud rates (such as 57600bps), the
> > timeout is _not_ sufficient. This causes longer lines to be cut
> > off, resulting in lost and horribly misformatted output on the
> > console.
> > 
> > When using FIFO mode, take the number of bytes into account to
> > determine an appropriate max timeout. Increasing the timeout
> 
> maximum
> (in order not to mix with max() function)
> 
> > does not affect performance since ideally the timeout never
> > occurs.
> 
> ...
> 
> >  /*
> >   *	Wait for transmitter & holding register to empty
> > + *	with timeout
> 
> Can you fix the style while at it?
> 
> >   */
> 
>  /* Wait for transmitter & holding register to empty with timeout */
> 
> ...
> 
> >  static void serial8250_console_fifo_write(struct uart_8250_port *up,
> >  					  const char *s, unsigned int count)
> >  {
> > -	int i;
> >  	const char *end = s + count;
> >  	unsigned int fifosize = up->tx_loadsz;
> > +	unsigned int tx_count = 0;
> >  	bool cr_sent = false;
> > +	unsigned int i;
> >  
> >  	while (s != end) {
> > -		wait_for_lsr(up, UART_LSR_THRE);
> > +		/* Allow timeout for each byte of a possibly full FIFO. */
> 
> Does the one-line comment style in this file use periods? If not, drop,
> otherwise apply it to the above proposal.
> 
> > +		for (i = 0; i < fifosize; i++) {
> > +			if (wait_for_lsr(up, UART_LSR_THRE))
> > +				break;
> > +		}
> 
> > +	}
> > +
> > +	/* Allow timeout for each byte written. */
> > +	for (i = 0; i < tx_count; i++) {
> > +		if (wait_for_lsr(up, UART_LSR_THRE))
> > +			break;
> 
> This effectively repeats the above. Even for the fix case I would still add
> a new helper to deduplicate.

+1

With this fixed, Reviewed-by: Wander Lairson Costa <wander@redhat.com>
> 
> >  	}
> >  }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


