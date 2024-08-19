Return-Path: <linux-kernel+bounces-292356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05AF956E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207DAB25991
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4644D175D46;
	Mon, 19 Aug 2024 15:09:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE59F178395
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080152; cv=none; b=oTC2XXiDgttEacJHLrGTqr/CgKCAnxk8B4jjYTEUAgvVUVTgIXQPOm0GPZnkp/7B0FacNqkebsUGIsyZeArpu7ZeIBZkBiK8yvP4IRpqujtR+Mbf3F1iFw0VWI+GCVz1zarp1bOpkd2ZwJYoC3Mu1dAHhDBaW0d4eBtO2OQUjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080152; c=relaxed/simple;
	bh=XFOujQKSzwVfFtiiwajNzvexEYb/1eeuV57KWoFZE3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2DBOwVuT10KvG+A7hssgTMwCTjAkCFw9HgkNDf80jumsVFq7Lo21Q58LMY77CwnMyZlX6bu6ksBDuoETVhCnSrDSK3cj87IaJhvGr6ZAd80Anvlbtux/wUwnqVGHZY7dareWWPAsmr/7hCCOaYPl0BGlkbcHHaJIOKNFKdrp1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3406EC32782;
	Mon, 19 Aug 2024 15:09:11 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:09:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, pmladek@suse.com,
 john.ogness@linutronix.de, senozhatsky@chromium.org, tglx@linutronix.de,
 tony@atomide.com, linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Message-ID: <20240819110935.2a7c6241@gandalf.local.home>
In-Reply-To: <1947584.IobQ9Gjlxr@nerdopolis2>
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
	<2024081824-leggings-omission-562a@gregkh>
	<3669532.hdfAi7Kttb@nerdopolis2>
	<1947584.IobQ9Gjlxr@nerdopolis2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 10:30:22 -0400
nerdopolis <bluescreen_avenger@verizon.net> wrote:

> On Sunday, August 18, 2024 8:33:25 AM EDT nerdopolis wrote:
> > On Sunday, August 18, 2024 1:12:14 AM EDT Greg KH wrote:  
> > > On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:  
> > > > Hi
> > > > 
> > > > I originally brought this up on linux-serial, but I think it makes more sense
> > > > that it's part of how printk console device selection works. Without VTs, while
> > > > most software is able to handle the situation, some userspace programs expect
> > > > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > > > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > > > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > > > refuses to write log messages to it.
> > > > 
> > > > There doesn't seem to be a mailing list for printk, so I had to use
> > > > get_maintainer.pl. Hopefully this is correct
> > > > 
> > > > 
> > > > After some grepping and guessing and testing, and playing around Something like
> > > > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > > > index a45d423ad10f..f94a4632aab0 100644
> > > > --- a/drivers/tty/Kconfig
> > > > +++ b/drivers/tty/Kconfig
> > > > @@ -384,9 +384,12 @@ config NULL_TTY
> > > >  
> > > >           In order to use this driver, you should redirect the console to this
> > > >           TTY, or boot the kernel with console=ttynull.
> > > > -
> > > >           If unsure, say N.
> > > >  
> > > > +config NULL_TTY_CONSOLE
> > > > +        bool "Supports /dev/ttynull as a console automatically"
> > > > +        depends on NULL_TTY && !VT_CONSOLE
> > > > +
> > > >  config VCC
> > > >         tristate "Sun Virtual Console Concentrator"
> > > >         depends on SUN_LDOMS
> > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > index dddb15f48d59..c1554a789de8 100644
> > > > --- a/kernel/printk/printk.c
> > > > +++ b/kernel/printk/printk.c
> > > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > > >         initcall_t call;
> > > >         initcall_entry_t *ce;
> > > >  
> > > > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > > > +       if (!strstr(boot_command_line, "console="))
> > > > +               add_preferred_console("ttynull", 0, NULL);
> > > > +#endif
> > > > +
> > > >         /* Setup the default TTY line discipline. */
> > > >         n_tty_init();
> > > >  
> > > > 
> > > > 
> > > > 
> > > > seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> > > > redundant, it is optional, so that it doesn't cause any changes to
> > > > configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
> > > > and for bootloader configs, it won't change any behavior if the kernel command
> > > > line has a console device specified  
> > > 
> > > What is wrong with just setting the kernel command line for this
> > > instead?
> > >   
> > When they eventually start shipping kernels without VTs, they will then have to
> > include a script in their upgrade process that runs
> > 
> > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"nomodeset /g" /etc/default/grub  
> Ugh, I meant
> sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"console=ttynull /g" /etc/default/grub
> sorry

If you can modify the kernel .config for this, can you just update:

  CONFIG_CMDLINE_BOOL=y
  CONFIG_CMDLINE="console=ttynull"

?

There's also bootconfig, that allows you to append command lines to the
kernel image. See CONFIG_BOOT_CONFIG and Documentation/admin-guide/bootconfig.rst

-- Steve

