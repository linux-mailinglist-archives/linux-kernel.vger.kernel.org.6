Return-Path: <linux-kernel+bounces-409695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F929C902E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D2281138
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83117D358;
	Thu, 14 Nov 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XuSh+hJ3"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4085674E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603116; cv=none; b=gr2apg2qM1cUfV0kjrCsMiEa+6DghWAce9mRgwnkvhcueKTkF6ulps+tPLml12z1aqgfoB37yrA/mPHDDRZAKgBTqbkgi5xY53IPBfNCD2KY3ANGaiM8Ojo1McZ7QjKULgrkSo/nmtgJiC/ZWR5xzNMBJO75KlQxzmf0rk4xBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603116; c=relaxed/simple;
	bh=NszP7TXqWj2S/e1y5AGoZZXxdUD7VRLHgXHhDIJdk/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty914fEV+mTz1MpQVQD6gTuBpMyseyXYL8KISQOL0zCNDBc/X8srL3gO+a5uW/kn7qj6QzUxGreNtC2MhKtSrzD3G0JeynEHXpQqHMBTQOND+PWx7nCcj58sW39xB9tyNdchD20CZX6vW1sbe3Vka8Z9XAvpEEMhVCd0JsKKkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XuSh+hJ3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53da5a27771so916639e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731603112; x=1732207912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4wPxzflWKzXhO1nuki36dNsr0Nxtgqzfwxp448aaNk=;
        b=XuSh+hJ3BGbYUeccL2/nKRSJ1Adx7uZJDUUGV0wE4hFTIaN/VGzdG2rBxs7i7eNFLd
         XThv9YlTTgm3NkT4ArrSvMb7hBwy2kctE9X6BxT9bdlGfZkszXYfw7+f/uWVBvpW8Xua
         BFP/8aDsUpVUpUcdf2t2gxwsp5/QmT4jgOgY8M14eOc65dt8/GfE8mq1JT8XA89+Ravc
         Rq43UiEB9Ry+UtVw/RQucEkVjplQ133D4tXgRsJ5kH9y9SClTSvSAKj1hq99uS1U+J3O
         HA/G0lPqTup3wFQxGEXoewfOuciKD941JnJC4hk0VDuC8wkK1m1Sr1HxJQeM+837PnBO
         6Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603112; x=1732207912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4wPxzflWKzXhO1nuki36dNsr0Nxtgqzfwxp448aaNk=;
        b=Os9d9S0hhNrjmx+pxSEr9bVZjSPXqoPJB2e54nfXhejMdo/dB/OPlCN68yLpSDZmwL
         BuB9fLA31CbS6/eREf8PkFNgJLIOWQWqM1MuT1tsKYakuGaZ5LlRhLYtnDCayXczVm9Y
         vUWm7DBE4M+nSAL4iwrumVa9wE/VT5T0j9AGrNNePwijZqhLDSFhneAaIjawMFEIurDt
         IuLiY1gIo/sfiDdbiqeMFyOavgWTiJjOt8nCGOF5pmdUrinkUPQ5B8aKu31wxgIb0JaS
         YbeJ5nG5GHJmJnltR/nD2Di06fGBJNMmaM6e5LtMNlJTHuQzlckkhqBfPRACOywbg9Na
         +4+g==
X-Gm-Message-State: AOJu0Yx5GY42ZFUuBmXsCtwV9Y6Bs3/+GTHYnBpPwl8JAa5csif4E1G2
	hZNKsH5Ifit5iQT/mnOjjAcQjKLsAKDEwN55sNjlkYn8GPRC1oN0Sk6CmXxyvgE=
X-Google-Smtp-Source: AGHT+IEMRk4K0IqzRtS7aXdMxOPTIt1tDe0rMCW0UzLZAOSPvPDT+yjHwx6FIDbxBGBgADbKY/PlSQ==
X-Received: by 2002:a05:6512:224e:b0:53d:a2e2:5877 with SMTP id 2adb3069b0e04-53da5c28cabmr1499944e87.5.1731603112347;
        Thu, 14 Nov 2024 08:51:52 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab806e1sm26954855e9.20.2024.11.14.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:51:51 -0800 (PST)
Date: Thu, 14 Nov 2024 17:51:49 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 03/11] printk: console: Implement core per-console
 loglevel infrastructure
Message-ID: <ZzYqpTwVnB61kXuM@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <28d8dff56bc15b2a41f0d2035701ccb11df22610.1730133890.git.chris@chrisdown.name>
 <Zy4368zf-sJyyzja@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy4368zf-sJyyzja@pathway.suse.cz>

On Fri 2024-11-08 17:10:31, Petr Mladek wrote:
> On Mon 2024-10-28 16:45:37, Chris Down wrote:
> > Consoles can have vastly different latencies and throughputs. For
> > example, writing a message to the serial console can take on the order
> > of tens of milliseconds to get the UART to successfully write a message.
> > While this might be fine for a single, one-off message, this can cause
> > significant application-level stalls in situations where the kernel
> > writes large amounts of information to the console.
> > 
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -101,11 +102,25 @@ __setup("sysrq_always_enabled", sysrq_always_enabled_setup);
> >  static void sysrq_handle_loglevel(u8 key)
> >  {
> >  	u8 loglevel = key - '0';
> > +	int cookie;
> > +	int warned = 0;
> > +	struct console *con;
> >  
> >  	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
> >  	pr_info("Loglevel set to %u\n", loglevel);
> >  	console_loglevel = loglevel;
> > +
> > +	cookie = console_srcu_read_lock();
> > +	for_each_console_srcu(con) {
> > +		if (!warned && per_console_loglevel_is_set(con)) {
> > +			warned = 1;
> > +			pr_warn("Overriding per-console loglevel from sysrq\n");

It just came to my mind. We could use pr_warn_once() and get rid
of the @warned variable. It is slightly less optimal. But this
is a slow path and the code would be easier.

> > +		}
> > +		WRITE_ONCE(con->level, -1);
> > +	}
> > +	console_srcu_read_unlock(cookie);
> >  }
> > +
> 

Best Regards,
Petr

