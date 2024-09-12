Return-Path: <linux-kernel+bounces-326595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BAE976A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6441C20DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A351AD276;
	Thu, 12 Sep 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ni88zy5X"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B1E1A76BC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147645; cv=none; b=kuCPDRiBvAsPpxxbiUCzP7yRGjLdjjJrPY/i86C68PJhghy6AJHghDxOU3MVs3gbiH+9ok8m6aIBrozIc00yO9n1w4U8AZzWVjuzQAeLouF9gwv+cEl8zUlx4u+IupFlLym9G27IBmf71EvKslfhMuzdRvWCpu9dQuAKPWY4Kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147645; c=relaxed/simple;
	bh=SKp5TALWrjoddAtgtEOawZ3CA9lNgLTG3dY5S9J5j8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gauHdzE4OlrYB7DdxmZcscVMkd1nB1PfxJhcpezD11gWkK8ERh7Q9oDdp8dvm8k8lCNalIFcVQZtrAPkW3FH/ANXzHajCQE6hN1MjoycgVe22Ucd/OLBVidnb5aHsB/uWpEexXAl3omMYaD6Bz7OWHrCptMqiADo0nXFfrrHnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ni88zy5X; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1607704a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726147642; x=1726752442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqeUgj6ErA/0VkLAq/aNBVmK+02FrtaSv1xpZgk+v6Y=;
        b=Ni88zy5XyReTWTGx+xL4nsEvYoGHq2NL04pmm1mQztifixb7xdJIiJmoIyKi2RiFJl
         tRkVaUqLWCP9bOPhjN9tnOobp1JnpYRmG0XPmSl0a1s3TbF9xrws7MD9b36R0rJOd7Pw
         LuzLoUyctXuxpCYhTAgIzv1B+y0JWgqU7Zs1iCpw8Te6jVP6dT7JEe/E4+OxIa5dO+/G
         AD6LVt2oOkztAK4hyMQoLFM/sD9DoQTj99mu7GfEY5xK84/z2fyF4YdHRw0EvFDmAsxM
         X+s8C45f4397y/LU8hjT/i6ClRm4YA2HlbWBfMnlM3GrzN4AbznlWVxg45Gn/skndX3p
         519A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726147642; x=1726752442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqeUgj6ErA/0VkLAq/aNBVmK+02FrtaSv1xpZgk+v6Y=;
        b=HQ0vAJb/gDMcm+8ctRxl5QvkgEUG13BtVaGdmXNcw2YH4twuVlEcrpUZ3TzgqOy0Om
         sZki4/M+VEoRF5ST8BNGCB3mpVPI0NCUq4l9oneWPywfNTxUjUSvxme+HNIzzwBK3i+U
         21W0BaRNoHxtdmt7qt3CsU20YQhac2Ght+1URPTyHl5X6NAUoYsTa38jw9SIhNR90HKu
         gPXd+PaRF3CxlXx335QHt56h0fr9uOyhou5lyDeMO8y5PIynDG2s2sipSoxK8glYRk85
         3Aq5pFIGtDFO/ltDytU/4KVxuHyAq6J5mVpXJvVgpUNBiMLpyp7ayBeAM16GgWOnU3z2
         4Ieg==
X-Forwarded-Encrypted: i=1; AJvYcCXFsDvlKXWoCcody7stp6pHVhuVQNSu0AquDfTkNQTX4nJrQL0ejyx1LZybDZQlcofskBcJI6vcdJZam9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvp+TlIZfkuxSfvOiF7NvbItbk1EYgkiJKQVrrZ+3Cz4YiEZT
	BVK1+s1EzZY+dBdlwEACjt2CGbhjazKiROEtHiyVOD2fgGgy0T+sP1VBkIkqPQU=
X-Google-Smtp-Source: AGHT+IHL/2Dnb2T2wKKr6ta2nV2NDDNCTbv5WM5MFh9LweEBN+MbA0Wu78JRqGhojSr7a2lEjAoXLQ==
X-Received: by 2002:a05:6402:3705:b0:5c2:18d2:762a with SMTP id 4fb4d7f45d1cf-5c4015dd294mr10853350a12.8.1726147641695;
        Thu, 12 Sep 2024 06:27:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cdf7sm6539549a12.92.2024.09.12.06.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:27:21 -0700 (PDT)
Date: Thu, 12 Sep 2024 15:27:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Greg KH <gregkh@linuxfoundation.org>, john.ogness@linutronix.de,
	senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
	linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Message-ID: <ZuLsN7yviWQPFUvf@pathway.suse.cz>
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
 <2719346.q0ZmV6gNhb@nerdopolis2>
 <ZsSaQAGj-R5Z9q9N@pathway.suse.cz>
 <2751891.mvXUDI8C0e@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2751891.mvXUDI8C0e@nerdopolis2>

On Thu 2024-09-12 08:29:26, nerdopolis wrote:
> On Tuesday, August 20, 2024 9:29:36 AM EDT Petr Mladek wrote:
> > On Mon 2024-08-19 11:50:39, nerdopolis wrote:
> > > On Monday, August 19, 2024 11:09:35 AM EDT Steven Rostedt wrote:
> > > > On Sun, 18 Aug 2024 10:30:22 -0400
> > > > nerdopolis <bluescreen_avenger@verizon.net> wrote:
> > > > > On Sunday, August 18, 2024 8:33:25 AM EDT nerdopolis wrote:
> > > > > > On Sunday, August 18, 2024 1:12:14 AM EDT Greg KH wrote:  
> > > > > > > On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:  
> > > > > > > > I originally brought this up on linux-serial, but I think it makes more sense
> > > > > > > > that it's part of how printk console device selection works. Without VTs, while
> > > > > > > > most software is able to handle the situation, some userspace programs expect
> > > > > > > > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > > > > > > > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > > > > > > > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > > > > > > > refuses to write log messages to it.
> > > > > > > > 
> > > Would something like this below be more acceptable? I didn't test it yet, but
> > > just the theory. I am thinking that this could have more use to allow a
> > > preferred to be set...
> > > 
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index dddb15f48d59..c1554a789de8 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > >  	initcall_t call;
> > >  	initcall_entry_t *ce;
> > >  
> > > +#ifdef CONFIG_DEFAULT_CONSOLE_HINT_BOOL
> > > +       if (!strstr(boot_command_line, "console="))
> > > +               add_preferred_console(CONFIG_DEFAULT_CONSOLE_HINT, 0, NULL);
> > > +#endif
> > > +
> > >  	/* Setup the default TTY line discipline. */
> > >  	n_tty_init();
> > 
> > This is better. But it does not handle some situations. For example,
> > default console might also by defined by:
> > 
> >    + scpr, see acpi_parse_spcr()
> >    + device tree, see of_console_check()
> >    + netconsole=, it is hidden in init_netconsole()
> > 
> > I tried to handle this another way. The "ttynull" console was
> > added when /dev/console could not be opened in console_on_rootfs(),
> > see the commit 757055ae8dedf5333af17b ("init/console: Use ttynull
> > as a fallback when there is no console").
> > 
> > But it did not work well and we had to revert the change, see
> > the commit a91bd6223ecd46addc71ee6f ("Revert "init/console: Use
> > ttynull as a fallback when there is no console").
> > 
> Out of curiosity, would the upcoming nbcon work fix the race conditions or
> problems that were seen in 757055ae8dedf5333af17b ?

Not really. The nbcon work affects the context and locking used for
flushing of the consoles. It does _not_ affect the registration. And
it does _not_ affect how the consoles are associated with /dev/console.

Best Regards,
Petr

