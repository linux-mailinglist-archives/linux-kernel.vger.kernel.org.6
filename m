Return-Path: <linux-kernel+bounces-294031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EE29587F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0933283449
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547319047D;
	Tue, 20 Aug 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JIPrfBJm"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DA19007D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160582; cv=none; b=qHrgit01ZE/kmPsud9egvc+8OxSE+qk0eJsVu1vUf5Yncxz0n3aInql6yMEhFM1U3w8M31XaVxCRVq5++1mFPV8nqBrKHkxA819BVOs4HLxeYrn/nECEye9zctfcF6PEDs6uwzHWco1OYoIa054jIKW+d5yyfQzyQlsad0jBNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160582; c=relaxed/simple;
	bh=oeMrnyuPZYnuMX4Kh5e0uax9OEYU+TNj17RoDLMKsOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZ3QJW/v/LX4RzQrhnfSVz+Thwa2RUfcIiunXuTEssBt+GMg61ajO8oY/Eys5gTddvJUk/ts7D8G7NhcCj5eHyW6Xs01uS8aDDTPI27RDp/xiQr4/XtsmbKDLRgrbDPd+RzXsxRIsvTWnEOaC3aoYmJfpweKfQqwS0LfxQN1SYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JIPrfBJm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so4335368a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724160578; x=1724765378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MuATrAArfoLLHLE27/kG/FByeL8XiRyb7xfQEC4vr5U=;
        b=JIPrfBJmv6CRlzFawbT7WkSOd53CmIWb7+QhfIrHWqsf9zPPevScuF7Sxgpg81iZXD
         7nfyeNxRwt4RsnUGflGeI7queMllQteMPU/kDoDFewZOakbddnRuXVkjfmOe9QE+kPkW
         URN5ne4TYR+PEBdNPLIw8+P2ijAkHE1tv+WwfoLDCzWg3bjeulkpyNwPQiuBrcRHPyNu
         nMo1jK/qLVjRBvzn3ARdDCAqtRsgbhlfhworBCDjJPsO1HKGllcwQt/YBBVUzuH6+/L9
         7eEQI4Juigc7iWWcIB1AInIts9Js2p7cROs5JnBG4EZ7Kh9cStyyBCi/W4HeTQj8FtPh
         UA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724160578; x=1724765378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuATrAArfoLLHLE27/kG/FByeL8XiRyb7xfQEC4vr5U=;
        b=UuvqL830kI80e+e6+UaINZIcaBeifm0Ha+wUtSaOSfi2nXzGLfy4AOc/1FqJ9SHWwI
         4eBBffle2kXpv7ISXEHGP+wZpr5mnEB5OBBJ3pjO4rPhnMxV3NdWC/vNy6fcn9ozV665
         9Gv3gK3vxIXTjpKVULGn6Vfj/UYJwl4aMjYPichElkMdA0tw4khlFgINtSTTlCsxvNmA
         AeCQQfuMFQ63+TznmFctajneLPtmVRjG20eafVVGAh2dCFLuv45ZTdKUW7Q9EkASe56K
         TpMJNDNax4Xti2nWB1pSdtFAlnTlbdTjSRqXyveovmu/53cVcIcSQKREGsgX5oHn8Ko1
         bZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCX40BHen5TfY789RXYm0B/gPNgo5ZNS73SsR6xF3bgErBxI5IVdN7sXBbWYDM+FKTeopEeZli6rT5TQzaWF0qq2I0gNlQXh9TQV2usJ
X-Gm-Message-State: AOJu0Yx87NiqDstTiBI9xOzxBBXrhDsZQxAYOnMBMb5cyTryKFXc+HHE
	iof1Ow3GZLnueuMQiCjNMlxxbYfzg3XGy3ZVjgQI0NRSTlvIGjonROlphgsvPXSI6w+bVgAZCvt
	w
X-Google-Smtp-Source: AGHT+IFXz070Bk+qbnkTtQHKv2/98xG1/MWrrgigTATYIWH0eBj4ObLk9TM79+4FwW87aGC3nJBb/A==
X-Received: by 2002:a50:8d86:0:b0:5be:9d95:390f with SMTP id 4fb4d7f45d1cf-5beca529a27mr7565103a12.11.1724160578264;
        Tue, 20 Aug 2024 06:29:38 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe29b2sm6795939a12.4.2024.08.20.06.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 06:29:38 -0700 (PDT)
Date: Tue, 20 Aug 2024 15:29:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Greg KH <gregkh@linuxfoundation.org>, john.ogness@linutronix.de,
	senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
	linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Message-ID: <ZsSaQAGj-R5Z9q9N@pathway.suse.cz>
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
 <1947584.IobQ9Gjlxr@nerdopolis2>
 <20240819110935.2a7c6241@gandalf.local.home>
 <2719346.q0ZmV6gNhb@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2719346.q0ZmV6gNhb@nerdopolis2>

On Mon 2024-08-19 11:50:39, nerdopolis wrote:
> On Monday, August 19, 2024 11:09:35 AM EDT Steven Rostedt wrote:
> > On Sun, 18 Aug 2024 10:30:22 -0400
> > nerdopolis <bluescreen_avenger@verizon.net> wrote:
> > 
> > > On Sunday, August 18, 2024 8:33:25 AM EDT nerdopolis wrote:
> > > > On Sunday, August 18, 2024 1:12:14 AM EDT Greg KH wrote:  
> > > > > On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:  
> > > > > > Hi
> > > > > > 
> > > > > > I originally brought this up on linux-serial, but I think it makes more sense
> > > > > > that it's part of how printk console device selection works. Without VTs, while
> > > > > > most software is able to handle the situation, some userspace programs expect
> > > > > > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > > > > > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > > > > > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > > > > > refuses to write log messages to it.
> > > > > > 
> > > > > > There doesn't seem to be a mailing list for printk, so I had to use
> > > > > > get_maintainer.pl. Hopefully this is correct
> > > > > > 
> > > > > > 
> > > > > > After some grepping and guessing and testing, and playing around Something like
> > > > > > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > > > > > index a45d423ad10f..f94a4632aab0 100644
> > > > > > --- a/drivers/tty/Kconfig
> > > > > > +++ b/drivers/tty/Kconfig
> > > > > > @@ -384,9 +384,12 @@ config NULL_TTY
> > > > > >  
> > > > > >           In order to use this driver, you should redirect the console to this
> > > > > >           TTY, or boot the kernel with console=ttynull.
> > > > > > -
> > > > > >           If unsure, say N.
> > > > > >  
> > > > > > +config NULL_TTY_CONSOLE
> > > > > > +        bool "Supports /dev/ttynull as a console automatically"
> > > > > > +        depends on NULL_TTY && !VT_CONSOLE
> > > > > > +
> > > > > >  config VCC
> > > > > >         tristate "Sun Virtual Console Concentrator"
> > > > > >         depends on SUN_LDOMS
> > > > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > > > index dddb15f48d59..c1554a789de8 100644
> > > > > > --- a/kernel/printk/printk.c
> > > > > > +++ b/kernel/printk/printk.c
> > > > > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > > > > >         initcall_t call;
> > > > > >         initcall_entry_t *ce;
> > > > > >  
> > > > > > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > > > > > +       if (!strstr(boot_command_line, "console="))
> > > > > > +               add_preferred_console("ttynull", 0, NULL);
> > > > > > +#endif
> > > > > > +
> > > > > >         /* Setup the default TTY line discipline. */
> > > > > >         n_tty_init();
> > > > > >  
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> > > > > > redundant, it is optional, so that it doesn't cause any changes to
> > > > > > configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
> > > > > > and for bootloader configs, it won't change any behavior if the kernel command
> > > > > > line has a console device specified  
> > > > > 
> > > > > What is wrong with just setting the kernel command line for this
> > > > > instead?
> > > > >   
> > > > When they eventually start shipping kernels without VTs, they will then have to
> > > > include a script in their upgrade process that runs
> > > > 
> > > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"nomodeset /g" /etc/default/grub  
> > > Ugh, I meant
> > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"console=ttynull /g" /etc/default/grub
> > > sorry
> > 
> > If you can modify the kernel .config for this, can you just update:
> > 
> >   CONFIG_CMDLINE_BOOL=y
> >   CONFIG_CMDLINE="console=ttynull"
> > 
> > ?
> > 
> That could work, I think. I'll have to see how that works when a different
> console= is specified on the command line from the bootloader though, I am
> thinking that if console=ttyS0 is then manually specified by a user, there will
> be two devices in /proc/consoles (ttyS0 on top of ttynull), but I admit I don't
> know if there are actual ramifications of that, or not...

I guess that it would register both consoles in this case.

> I am not sure if real distributions would want this to be the answer I guess I
> will have to see if any others are using CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE,
> although this gives me an idea..
> 
> Would something like this below be more acceptable? I didn't test it yet, but
> just the theory. I am thinking that this could have more use to allow a
> preferred to be set...
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index dddb15f48d59..c1554a789de8 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3712,6 +3712,11 @@ void __init console_init(void)
>  	initcall_t call;
>  	initcall_entry_t *ce;
>  
> +#ifdef CONFIG_DEFAULT_CONSOLE_HINT_BOOL
> +       if (!strstr(boot_command_line, "console="))
> +               add_preferred_console(CONFIG_DEFAULT_CONSOLE_HINT, 0, NULL);
> +#endif
> +
>  	/* Setup the default TTY line discipline. */
>  	n_tty_init();

This is better. But it does not handle some situations. For example,
default console might also by defined by:

   + scpr, see acpi_parse_spcr()
   + device tree, see of_console_check()
   + netconsole=, it is hidden in init_netconsole()

I tried to handle this another way. The "ttynull" console was
added when /dev/console could not be opened in console_on_rootfs(),
see the commit 757055ae8dedf5333af17b ("init/console: Use ttynull
as a fallback when there is no console").

But it did not work well and we had to revert the change, see
the commit a91bd6223ecd46addc71ee6f ("Revert "init/console: Use
ttynull as a fallback when there is no console").

Another idea:

1. We could use the same trick as netconsole. I mean to use:

	ttynull_console.flags |= CON_ENABLED;

   to force register_console() to register the console even
   when it is not defined in the list of preferred consoles.

   It is a kind of hack. But it looks cleaner that adding
   ttynull console into the list of preferred consoles.


2. We need to decide whether the fallback to ttynull console
   is needed as late as possible. It should be done after
   all other drivers call register_console().

   I would do it in late_initcall_sync().


3. We need to detect when the fallback is needed. The check
   of /dev/console does not work, see
   the commit a91bd6223ecd46addc71ee6f ("Revert "init/console: Use
   ttynull as a fallback when there is no console").

   A solution might be to check if @console_list is empty.


Something like (not even compile tested):

diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 6b2f7208b564..7cd7ba2ec33c 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -59,6 +59,16 @@ static struct console ttynull_console = {
 	.device = ttynull_device,
 };
 
+void __init register_ttynull_console_force(void)
+{
+	if (!ttynull_driver)
+		return;
+
+	/* Force registration by setting the CON_ENABLED flag. */
+	ttynull_console.flags |= CON_ENABLED;
+	register_console(&ttynull_console);
+}
+
 static int __init ttynull_init(void)
 {
 	struct tty_driver *driver;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 054c0e7784fd..004612e6fc7f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3857,6 +3857,25 @@ static int __init printk_late_init(void)
 }
 late_initcall(printk_late_init);
 
+static int __init console_fallback(void)
+{
+	bool need_fallback = false;
+
+	console_list_lock();
+	/*
+	 * Make sure that there is a console which can be associated
+	 * with /dev/console
+	 */
+	if (hlist_empty(&console_list))
+		need_fallback = true;
+
+	console_list_unlock();
+
+	if (need_fallback)
+		register_ttynull_console_force();
+}
+late_initcall_sync(console_fallback);
+
 #if defined CONFIG_PRINTK
 /* If @con is specified, only wait for that console. Otherwise wait for all. */
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)



The above code would need some love to compile without
CONFIG_NULL_TTY.

Also it still might break some system/configuration where the default
console driver calls register_console() later.

We might need to update the check in register_console() and
call try_enable_default_console() even when ttynull console
is already registered as a fallback. We might even want
to unregister the ttynull console in this case.

Best Regards,
Petr

