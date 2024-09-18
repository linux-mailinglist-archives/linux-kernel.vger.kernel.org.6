Return-Path: <linux-kernel+bounces-332735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D95297BE05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC76DB21D98
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F1F1BA29F;
	Wed, 18 Sep 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eQkXdcE3"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9931BA860
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670129; cv=none; b=jZEFoZJqZHqQvEjA+YtN8NMAn3Ad/jwFV+ZZ5P1ok4YaT6uVEnRRaLxZ0LwG5TrCa1FPXDjRPuEbJP4LaQOHvn74xriQAQRabYr/67xVISiiwLXKyYZpy4LHTBphh4UMS6eLCakRXNJzXRkvZOIJi0XZGJ2+tEcFjEGWGV7EJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670129; c=relaxed/simple;
	bh=Ay+HrD1U7gCOdtyoRDLMIy84T6NPlt3wxZQ2IMheLC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwTW50ohkv1lBTs8TpLJKHBkfKZfCMqeXKfXVR2RSn/qUNerGeFhKz3uKeNZa7a6H+TXFfmIAIrP6/V9ZEpmn3dUctx+2CUnOUISchfGwm3G0YQjKMatnFVlU1rQY9dl1vWitjScSAKfMR1biV7KyiMLlhV+ybWo34qeFaNa7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eQkXdcE3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374b25263a3so3822410f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726670126; x=1727274926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmoWLs24cnVaWXLmT+HH7OmGEkpBuNmVOEdaXXFSoks=;
        b=eQkXdcE3aFKuJiN3iQq6vUmECj+UhJ1FtJp3bz0uc8ixiqf3SD25sLjei5POZJt+SB
         tAE/vtZpwAXIDazRbzYiJfO7zhUZaNdgc7r+S3CyGTVddN5BbedcHeXy5BRC8Zu3rGkc
         zWndxNLT5ETA4eMaToZytGc8ZUnYqom0e7EvlQMlTxwzxgvnlPMAfulaGnFpI3alQRmG
         ZuQVSI2Bg4VhrkCJ36xtzxTCu8WAAF/etXZwLvpuTM+6gz7w7705QUdU/UK/BY69la8d
         u69h37Z31ojgKFEoPo7++RYgAXGXeqM+7zBWj07Tm01fz3xqdeDEefMRiG5kYbC6yrGt
         ah3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726670126; x=1727274926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmoWLs24cnVaWXLmT+HH7OmGEkpBuNmVOEdaXXFSoks=;
        b=hUPkwQ3rwSf4Ug8ckO1GmwS96njitoftaD78wZCrja6KA43d+E06puubZkabdTOr/b
         3O/iof+zoXWaj7kKtrJ5Tvg1ZHKZLlaX6xLzQOsESUPw+ZpoypP+UIT1cfRlXBGE0PoM
         j0LYLAcHqVCDpPDtnzxeVmLLIxpqdBxXNAsW1p9PnCdQZeMIqXSVSoPUxmsJvPE9IOA0
         pVxhhETOama4KvX/frpZqIAJSPCHVVTH6Zfo7OOf1khCVuk64+dPVSx82N6358C+fXh6
         rqO8tLeNBBH8AqEdbccb4akThOxES8/Zm/GqLhLs31KOCtMBONwky/i1sIFSAGJpr9TV
         1Ncg==
X-Forwarded-Encrypted: i=1; AJvYcCXxLeS++sXyBxPCyGwE8JyeDiZhW11bpGPEBSLMmW+1RWcfbasRZLatTs6pPWY+KXJsLGkDkjL0ZoWNQ48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcd51H9lvsyOBnpERbsN8WNfWtk0sp/Q7ps/J4EsOlxKg7Ehw
	ivCWKz2M5MHS+QkCM0KTLHcG1IEthwYevwFMFT6ykpeGtNCHyT7Wuenix9JxSag=
X-Google-Smtp-Source: AGHT+IFXq7ryoBRISzYC/luCMTra800LK1Q0ulrxjKR2eL9Sikxbp8be2rLj2CtQmPohz6KdgJ1jkQ==
X-Received: by 2002:a5d:5103:0:b0:374:cb3e:3472 with SMTP id ffacd0b85a97d-378d625363fmr9173067f8f.49.1726670125682;
        Wed, 18 Sep 2024 07:35:25 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a9cab5sm6803470b3a.5.2024.09.18.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 07:35:25 -0700 (PDT)
Date: Wed, 18 Sep 2024 16:35:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH next v2 3/4] serial: 8250: Switch to nbcon console
Message-ID: <ZurlGqIdCbeSjYDj@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-4-john.ogness@linutronix.de>
 <ZurG8YMmBmVVxttj@pathway.suse.cz>
 <ZurdNw6lRYwClbuf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZurdNw6lRYwClbuf@smile.fi.intel.com>

On Wed 2024-09-18 17:01:27, Andy Shevchenko wrote:
> On Wed, Sep 18, 2024 at 02:26:25PM +0200, Petr Mladek wrote:
> > On Fri 2024-09-13 16:11:37, John Ogness wrote:
> > > Implement the necessary callbacks to switch the 8250 console driver
> > > to perform as an nbcon console.
> > > 
> > > Add implementations for the nbcon console callbacks (write_atomic,
> > > write_thread, device_lock, device_unlock) and add CON_NBCON to the
> > > initial flags.
> > > 
> > > All register access in the callbacks are within unsafe sections.
> > > The write_thread() callback allows safe handover/takeover per byte.
> > > The write_atomic() callback allows safe handover/takeover per
> > > printk record and adds a preceding newline if it took over mid-line.
> > > 
> > > For the write_atomic() case, a new irq_work is used to defer modem
> > > control since it may be a context that does not allow waking up
> > > tasks.
> > 
> > It would be fair to mention that it does not longer support fifo in
> > the 8250 driver. It basically reverted the commit 8f3631f0f6eb42e5
> > ("serial/8250: Use fifo in 8250 console driver").
> > 
> > It is not usable in write_thread() because it would not allow
> > a safe takeover between emitting particular characters.
> > 
> > It might still be used in write_atomic() but it is probably not
> > worth it. This callback is used "only" in emergency and panic
> > situations.
> 
> This is unfortunate. It will drop down the efficiency of printing.

The FIFO mode has been added by the commit 8f3631f0f6eb42e5
("serial/8250: Use fifo in 8250 console driver"). The interesting
parts are:

<paste>
  While investigating a bug in the RHEL kernel, I noticed that the serial
  console throughput is way below the configured speed of 115200 bps in
  a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
  I got 2.5KB/s.

  In another machine, I measured a throughput of 11.5KB/s, with the serial
  controller taking between 80-90us to send each byte. That matches the
  expected throughput for a configuration of 115200 bps.

  This patch changes the serial8250_console_write to use the 16550 fifo
  if available. In my benchmarks I got around 25% improvement in the slow
  machine, and no performance penalty in the fast machine.
</paste>

I would translate it:

The FIFO mode helped with some buggy serial console. But it helped to gain
only small portion of the expected speed. The commit message does not
mention any gain with the normally working system.

It has been added in 2022. It was considered only because of a
"broken" system. Nobody cared enough before.

> I think it should be done differently, i.e. the takeover the code
> has to drop FIFO (IIRC it's easy to achieve by disabling it or so)
> and switch to printing the panic/emergency message. But still at
> some baud rate speeds draining the FIFO to the other end may be
> not a bad idea as it takes a few dozens of microseconds.

Sure. it is doable. But I am not convinced that it is really worth it.

Best Regards,
Petr

