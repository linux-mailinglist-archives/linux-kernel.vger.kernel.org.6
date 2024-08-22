Return-Path: <linux-kernel+bounces-297069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B69395B297
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705471C21688
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B708D181334;
	Thu, 22 Aug 2024 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dkDDp1oz"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF916F8E5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321125; cv=none; b=ZIvz4iroD4Vh/BUatMvXyf0bCnSDGF6bdaw+1wU3erYhYiyswJo4cI/Ri+ALY+Xq9cLJ0ujMLDQ8+mkxg1AgwyQ2WdIO24rG85WWyJojA6PhPeEq5cwR1+o3chOm+XzQ4RJxyzgWc9wO5erJoGHVtxK1VPa6nAq+D/4Yl/fn5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321125; c=relaxed/simple;
	bh=AqOSFVoKPParxnmT7WF221Z1Ip1REBiC8PrGUOHP5vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGc5f46q1brE2GBbh035ER3rAAI6tUdic9qGoGrbcRlwFBJkKJQyq2mdryyvZlgydJdIWrdNkVZjHAMUTFyT9RVPx66Rz45csB5Rcd8SozA3DHqrQ7QEQ3QbssCW7No4pdLAEFcI5SLJjcbUGoVzc/da6h+yXnpbkVjcbmD6Ljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dkDDp1oz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a869332c2c2so61384766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724321122; x=1724925922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VsRlx36JSyjICqgc+aUAvgwW16JZKgE9Yu8s3izwD3U=;
        b=dkDDp1ozGxvMfWcFI6Z8SmO41xJoi3YPUPsigc+kILryaiIkmOWFjsVHLMEiAHuGYW
         O5KW5dVMLVxV60HaXSw2jUFkGn2qm+s2tcHhj0TZ7meORhTgc1WDJLSj9lxABk1VRrDt
         8EK2I2lNJsuhRrEw4i83b2QwwBfysXNMeFETrY83z47vyDehZJxl3J6mW2B+x4EPgi5E
         kuqORTGKpYjOV0gCJSorU9BfTs7km+DOU7mlEuuQR7LOB5nj+dKKnW6GVnlr7AfEswYi
         pCjKGzMnPbQjdyTNytoGWCMp6mfjA8PHWeFRimnJc+J820E4/sLF3onPtShLuKXbLchG
         zZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724321122; x=1724925922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsRlx36JSyjICqgc+aUAvgwW16JZKgE9Yu8s3izwD3U=;
        b=eEjuTfn9e32Ci75FsxmvvvphP0ySQMxlFh3oeE7+iWgozh8nn0ySeNCfZw0C8QH4+I
         aUQ8VSOqvejFTHMBoL61aYOCHgapOUZ/ZEDdfozFd5noBtQGCIxMrSMP0W0iiIHXr69I
         4VVUiEGxzHHb6U5Tgje/BOfP1+sW3z3YjWUOn8++RCfX8zfCvdzC3rgDo8+mVpbj8cxO
         /XkXwr3jkodanPnxCtVlHkG1SfpVu3+obeoN7DyJjaZvEi+XxRDlYKMzHUNSfCn48HEi
         55pfYURR2Bs0BWdztnVFlkSDAolQ/3ZHXXKI6RemOSzPvFNhXDu3/41DcntxOAVhpEbx
         hEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0FPEQyoZZmMkqsadqjqaMLEz+BRXtylnVWef/kap9tSJ1bbshjQXsHXKx5TBgOe1oudcPzgyeZu35QG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiVD6pMg9CFrZ75GKqOjgu8SgsyKxAxbsouM/rouoFXFqP8Gd1
	RUsqDIBhxaPJjwx7g5JAUPKWHOG8vXXfdoRsZ9IUNbxWNwjhOPaXmtrKjT7Yf6k=
X-Google-Smtp-Source: AGHT+IFf0/TfRn1dVTDMHRyeniY/BWcdE5p/lEJgK1hbqEWNBZ3MreGTUcv92qqLG54gU4SR/KmMYA==
X-Received: by 2002:a17:906:d54b:b0:a77:db39:cc04 with SMTP id a640c23a62f3a-a868a61ebd1mr188730566b.11.1724321121490;
        Thu, 22 Aug 2024 03:05:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f22018csm98471966b.11.2024.08.22.03.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:05:21 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:05:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Greg KH <gregkh@linuxfoundation.org>, john.ogness@linutronix.de,
	senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
	linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Message-ID: <ZscNX79dnXUjeTc4@pathway.suse.cz>
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
 <2719346.q0ZmV6gNhb@nerdopolis2>
 <ZsSaQAGj-R5Z9q9N@pathway.suse.cz>
 <5322439.6fTUFtlzNn@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5322439.6fTUFtlzNn@nerdopolis2>

On Wed 2024-08-21 13:12:03, nerdopolis wrote:
> On Tuesday, August 20, 2024 9:29:36 AM EDT Petr Mladek wrote:
> > On Mon 2024-08-19 11:50:39, nerdopolis wrote:
> > > On Monday, August 19, 2024 11:09:35 AM EDT Steven Rostedt wrote:
> > > > On Sun, 18 Aug 2024 10:30:22 -0400
> > > > nerdopolis <bluescreen_avenger@verizon.net> wrote:
> > > > 
> > > > > On Sunday, August 18, 2024 8:33:25 AM EDT nerdopolis wrote:
> > > > > > On Sunday, August 18, 2024 1:12:14 AM EDT Greg KH wrote:  
> > > > > > > On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:  
> > > > > > > > Hi
> > > > > > > > 
> > > > > > > > I originally brought this up on linux-serial, but I think it makes more sense
> > > > > > > > that it's part of how printk console device selection works. Without VTs, while
> > > > > > > > most software is able to handle the situation, some userspace programs expect
> > > > > > > > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > > > > > > > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > > > > > > > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > > > > > > > refuses to write log messages to it.
> > > > > > > > 
> > > > > > > > There doesn't seem to be a mailing list for printk, so I had to use
> > > > > > > > get_maintainer.pl. Hopefully this is correct
> > > > > > > > 
> > > > > > > > 
> > > > > > > > After some grepping and guessing and testing, and playing around Something like
> > > > > > > > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > > > > > > > index a45d423ad10f..f94a4632aab0 100644
> > > > > > > > --- a/drivers/tty/Kconfig
> > > > > > > > +++ b/drivers/tty/Kconfig
> > > > > > > > @@ -384,9 +384,12 @@ config NULL_TTY
> > > > > > > >  
> > > > > > > >           In order to use this driver, you should redirect the console to this
> > > > > > > >           TTY, or boot the kernel with console=ttynull.
> > > > > > > > -
> > > > > > > >           If unsure, say N.
> > > > > > > >  
> > > > > > > > +config NULL_TTY_CONSOLE
> > > > > > > > +        bool "Supports /dev/ttynull as a console automatically"
> > > > > > > > +        depends on NULL_TTY && !VT_CONSOLE
> > > > > > > > +
> > > > > > > >  config VCC
> > > > > > > >         tristate "Sun Virtual Console Concentrator"
> > > > > > > >         depends on SUN_LDOMS
> > > > > > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > > > > > index dddb15f48d59..c1554a789de8 100644
> > > > > > > > --- a/kernel/printk/printk.c
> > > > > > > > +++ b/kernel/printk/printk.c
> > > > > > > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > > > > > > >         initcall_t call;
> > > > > > > >         initcall_entry_t *ce;
> > > > > > > >  
> > > > > > > > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > > > > > > > +       if (!strstr(boot_command_line, "console="))
> > > > > > > > +               add_preferred_console("ttynull", 0, NULL);
> > > > > > > > +#endif
> > > > > > > > +
> > > > > > > >         /* Setup the default TTY line discipline. */
> > > > > > > >         n_tty_init();
> > > > > > > >  
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> > > > > > > > redundant, it is optional, so that it doesn't cause any changes to
> > > > > > > > configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
> > > > > > > > and for bootloader configs, it won't change any behavior if the kernel command
> > > > > > > > line has a console device specified  
> > > > > > > 
> > > > > > > What is wrong with just setting the kernel command line for this
> > > > > > > instead?
> > > > > > >   
> > > > > > When they eventually start shipping kernels without VTs, they will then have to
> > > > > > include a script in their upgrade process that runs
> > > > > > 
> > > > > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"nomodeset /g" /etc/default/grub  
> > > > > Ugh, I meant
> > > > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"console=ttynull /g" /etc/default/grub
> > > > > sorry
> > > > 
> > > > If you can modify the kernel .config for this, can you just update:
> > > > 
> > > >   CONFIG_CMDLINE_BOOL=y
> > > >   CONFIG_CMDLINE="console=ttynull"
> > > > 
> > > > ?
> > > > 
> > > That could work, I think. I'll have to see how that works when a different
> > > console= is specified on the command line from the bootloader though, I am
> > > thinking that if console=ttyS0 is then manually specified by a user, there will
> > > be two devices in /proc/consoles (ttyS0 on top of ttynull), but I admit I don't
> > > know if there are actual ramifications of that, or not...
> > 
> > I guess that it would register both consoles in this case.
> > 
> > > I am not sure if real distributions would want this to be the answer I guess I
> > > will have to see if any others are using CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE,
> > > although this gives me an idea..
> > > 
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
> > Another idea:
> > 
> > 1. We could use the same trick as netconsole. I mean to use:
> > 
> > 	ttynull_console.flags |= CON_ENABLED;
> > 
> >    to force register_console() to register the console even
> >    when it is not defined in the list of preferred consoles.
> > 
> >    It is a kind of hack. But it looks cleaner that adding
> >    ttynull console into the list of preferred consoles.
> > 
> > 
> > 2. We need to decide whether the fallback to ttynull console
> >    is needed as late as possible. It should be done after
> >    all other drivers call register_console().
> > 
> >    I would do it in late_initcall_sync().
> > 
> > 
> > 3. We need to detect when the fallback is needed. The check
> >    of /dev/console does not work, see
> >    the commit a91bd6223ecd46addc71ee6f ("Revert "init/console: Use
> >    ttynull as a fallback when there is no console").
> > 
> >    A solution might be to check if @console_list is empty.
> > 
> > 
> > Something like (not even compile tested):
> > 
> > diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> > index 6b2f7208b564..7cd7ba2ec33c 100644
> > --- a/drivers/tty/ttynull.c
> > +++ b/drivers/tty/ttynull.c
> > @@ -59,6 +59,16 @@ static struct console ttynull_console = {
> >  	.device = ttynull_device,
> >  };
> >  
> > +void __init register_ttynull_console_force(void)
> > +{
> > +	if (!ttynull_driver)
> > +		return;
> > +
> > +	/* Force registration by setting the CON_ENABLED flag. */
> > +	ttynull_console.flags |= CON_ENABLED;
> > +	register_console(&ttynull_console);
> > +}
> > +
> >  static int __init ttynull_init(void)
> >  {
> >  	struct tty_driver *driver;
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 054c0e7784fd..004612e6fc7f 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3857,6 +3857,25 @@ static int __init printk_late_init(void)
> >  }
> >  late_initcall(printk_late_init);
> >  
> > +static int __init console_fallback(void)
> > +{
> > +	bool need_fallback = false;
> > +
> > +	console_list_lock();
> > +	/*
> > +	 * Make sure that there is a console which can be associated
> > +	 * with /dev/console
> > +	 */
> > +	if (hlist_empty(&console_list))
> > +		need_fallback = true;
> > +
> > +	console_list_unlock();
> > +
> > +	if (need_fallback)
> > +		register_ttynull_console_force();
> > +}
> > +late_initcall_sync(console_fallback);
> > +
> >  #if defined CONFIG_PRINTK
> >  /* If @con is specified, only wait for that console. Otherwise wait for all. */
> >  static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
> > 
> > 
> I got it to compile with
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -513,9 +513,12 @@ extern int braille_register_console(struct console *, int index,
>  extern int braille_unregister_console(struct console *);
>  #ifdef CONFIG_TTY
>  extern void console_sysfs_notify(void);
> +extern void register_ttynull_console_force(void);
>  #else
>  static inline void console_sysfs_notify(void)
>  { }
> +static inline void register_ttynull_console_force(void)
> +{ }
>  #endif
>  extern bool console_suspend_enabled;
>  
> and throwing a "return 0;" in console_fallback()
> 
> Seems like at least on x86 though, when I tested (CONFIG_VT_CONSOLE disabled),
> the console is still ttyS0, even if I add "-serial none" to the QEMU VM.
> 
> 
> 
> I saw 757055ae8dedf5333af17b, but I feel like the intent is different, if I am
> understanding that correctly, which I very well could not be, to me it looks
> like it is using ttynull as a _last_ resort when all else fails, but x86 always
> seems to have /dev/ttyS0's, unless I make changes before the serial consoles
> are used.
> 
> My concerns are more about the distributions that have had /dev/console work
> no matter what because of CONFIG_VT_CONSOLE. isatty() always returns true 
> against /dev/console when enabled. When it is disabled, /dev/ttyS0 wins and now
> software like systemd that logs there is now at the mercy of how /dev/ttyS0 is
> physically connected or not for it to be able to log successfully.

I see. I have misunderstood the original problem.

Hmm, historically, the kernel tries to enable any available console by
default. It makes some sense. One would expect that when there is a
device than the user should be able to access it and see the messages there.

If I get it correctly, you suggest to do not register serial port
when it is not physically connected. It makes some sense.

But I think that this should be implemented on the serial console layer.
It should not call register_console() when the port is not connected.

Plus, it would need the above patch which would register
ttynull_console driver as the final fallback. Otherwise, /dev/console
would not be backed by any device. Or we could update console_device()
to return the ttynull_driver as a fallback when there is no console
registered.

> One of my _other_ ideas was to in setup_arch() in arch/x86/kernel/setup.c add
> the "add_preferred_console("ttynull", 0, NULL);" when CONFIG_NULL_TTY_CONSOLE
> is enabled right above where it calls vgacon_register_screen() for this reason.
> 
> It worked, but it probably was not correct either...

IMHO, this is not acceptable for a generic kernel. The kernel should
try show the messages whenever possible. It should not ignore serial
consoles when they are available.

Also I am sure that the kernel is used on devices which only
have a serial console. Such a change would cause regression
there.

Best Regards,
Petr

