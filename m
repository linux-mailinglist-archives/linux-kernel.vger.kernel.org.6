Return-Path: <linux-kernel+bounces-295960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B295A3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACE81F2176E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B41B2524;
	Wed, 21 Aug 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="doDS/THu"
Received: from sonic315-13.consmr.mail.bf2.yahoo.com (sonic315-13.consmr.mail.bf2.yahoo.com [74.6.134.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008FB1B2518
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260338; cv=none; b=CQY/baOVRkIOubKzMIalNF7ovwEMVqqOPS9/rBJtxTbvl7r/RRyHcNI9GhRiqF7bDPa8gB3SV7yk3qdFKDrAlVIf/OCAcoWeCuz8EVuYrqZ6Owd5q/tZFAacZl0/7ev5cHne3e+tggmBY5vOUTKagKryycQPJyr2uMabGJdcREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260338; c=relaxed/simple;
	bh=o0ERveFMkm8d409NhAuxYi5SN+LxgxjulHU5dDflW/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMvahllQHIC7UCGedWFVG5E2XsUmK1VfOzaArZAWwf5osTyG/XxD6eOHg9f+2cPdpR1jKFLBAR9LOVr7stKEiYc7Kom10eQLrmknktjNKx4RtwygRQMEdKY1p59/KFxY42mm472xqqB3ChOZLPHAlDBZGsQCQ4/BLPzF3pn1lP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=doDS/THu; arc=none smtp.client-ip=74.6.134.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1724260329; bh=rQhBLuJeOeA63TMnSO2gZqrfEeQaKxNkr6U4sEXq44g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=doDS/THuVH9rvO2mlcibLqBR0caY0s3Tmfju5XAGiAJHB0p77jCRmPGqH9tfiQD0TuxJY2tGz/3TVWQxVtJKeKKgedcGVqdXimy2diEBBgSPFkoAKb51mLfFuAPXpuISpXLI7h29iHZ1nSir81ySH1Gq3+E69EE8NUT4mGyGpYRU2qe1meiDLDZcAuB32uWmsV69kCb7O8jM70NwKaO+nWcIIOBU3YpHy0qAUub5Sb43mmdq67eFarrtJyIUKYFq6pJ7B0ilFzxUfZGObEqVkAGgavZ3Gi63LCkM5NO3ZrwQKJ2GbReltrrBUZy5w2H8NQGOMOZWKKnUtFa569XZgQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724260329; bh=U/MzYDK/40rOEIlqic8XQc4/bZ1ebNv0ispy5Lbvjuj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YYyDkAmP2gDVUVdMxncoT1w7FP1AfjRNU5vATyvebMeR5Bl/S5fD7o5xMWF/WLQaEfBjsJbcvW/I5m/GdujLYIsid3W45a/GwuTfJZCZxmQdKNgW6+RIXV0Hv9ufrMke1bppx92OiRZ9KCQVyUn0KezdGMMVSuX0T7QvFqUjb31nMdbBpYzDmExcI3SrYwo6HUu10r63fLbiJocHsPcyJv9RBV/P2nBlsZIZRckcr5ZingdGdBMn03jq7vlxYLLx0tcnXFAz+ipWmO/u6MW7lYvISg/TEEuqdPM/JGHrTpYFIt5srGTqpxoU5pJtXTnsKuxxlWWB7R2zZwAqb6v2TQ==
X-YMail-OSG: 1f6aQp0VM1m9oJXEcrkBDRKUvI62BetWSmDILpRMXW8y_yKmaRF7gzHvmBq97ez
 2euOQD2Jm4yk0xqSzOAHkDK2R3g8vyvqrbdd9ZBjV6sgXTS8aKN5S5DttDRvqtuIljdL1rUCIwRe
 qmhsT.pl66lwJML_AC5vMfdm0FzuNBNplZ.Dau7CgU3S05XkhjlHTlawSaTuCw7_N4w6QZnDPuXO
 VwjqSyphQyqMN0CIONTejv80ZnlR1YU2P3oFXzxtW1OGUIWSlo_FKz6XDn4hucmcUloGOMWyvGO8
 36pEmqKoHAxeato5cxKPnFul8obDQ_nYDgRWT.6FMsYYWiW.A8x.Uw_L3QijTkjsHySFsiv8SMUM
 zTUPOwoBlli3Li3ikuX3_Jq0AdxfILFQGBIxQp7PsJm9XK8uQYXbxr0dRcvouYab5TnMNwujp6dK
 fEiupZLHrbzbuILgfPJ25Ie7PoBMo0Zq_mUF4ZnP4w0iiDJrqqCpOU9KyG5w.qJOunXbJLrPIHtq
 QFOlSlGLt4aPq1pHkxlPFohfs7KsUtcsSASAggOdoYJ1KyKd2so3MKOXiBYWRPUYRdiQEEZ78w1m
 .FvgtGLSS8ItAyBRGKFn_wQgQMesqFRWeZlRe69LmjV8FOKdnPdZuO0aK2AI7SKM8hfPi3lP1l9e
 e6oTCkj_zNz4vF89.xo8pNTWa9.Dayj7YWsORntsOuO5B5.4yPamH_T29mYBgTVJuUni2XUlvPjO
 1Rlcs1qycEQH7xwjEWOdXokegWLiz.5Dma0VkldhSMWY2TVghSwj6zxXOPDNKtO3UZdCzGAZmr9J
 CZhDf955pq9I6IhkudLa2M9aFqqknq_Y_Yyo0JUHeIMa7AjBaAdEA2jePXbLNmPzHQmox8iVl_II
 wuOOaz_4F2QLQTRg7zAwR9Jl9sBRGHPHfLswkNEI1elk8cmfQN5wVsW8oJ9iuY.bC1AQ_sPrjxt7
 q7dCuRFsrbQhj8uD1bpg23C8Jc.ltWBns884TdEkng0QEs91LkHJyds1nRyUJAVVGd1of86e780D
 SkbJXVWH3wB2Wulj8oyKm78LO3nduGjBzcUHVTIVCc.t0mLTx19bVSnfro3CCIG_dwjZWJ86LtUO
 UN_ra6FN_PHOq1F0kg4I.7Cp6v8VE5n.5ejQpB6vVPw5v.rXX.CGAkV04uVZulHRXh2jsmhkg7Xn
 Wjx4KfevNyjItFPR53JbO2PiQiIlFDnuAZlIhW0dR7sGOw2GH_ID642y4mt8vIN4_NNZsc.Bo6fw
 67prxb8eStMLIUdtUbv4xyGxqJXVcGtO5W4Zr8jrXAmbcAixMwsg_ntlXpewAaYNEOqIBGjw8kIV
 zeUT3F_IxEy9KmLNDtCS638kL1AL6oU_7P.YPjyQM1GNLwRRAYU3ijDttUYHpssQhU3x_BX.l0X.
 oswv0Rw471fXMtkn_7fE6vx725JxP_t5ZB0cc6D6EgGaDGjGAqPo2G10OeAIEHSBILCDlngu03ZT
 5FEeV9VKzf.siyQBIATqnEY8W2aeR2RFyPRBBdZCop2rF.8iVTtA4Pqs8L4Qj.fRnSfVUaFqxxO6
 dkstbO3Vj_wk_jK8rfz.XaeaCOVqeHRg0iIIZ6VrmZPubBRiRyQuPCZvlW1WXMVuKtqUsV.7fu81
 vQOtNhIZzfOPJ0bOLYG_ck5Tw0ilWtcAfh5HGVrS2KZ_prnPb5D59B3.lZDx68MfWsNOh0g8AwyS
 .5Tk8qpZCmgcmQ.P72TptQZ6_pl.NycgvImXeipceIXJmo3INTzCDbPeA5vGdAJaqJyzIjIqkcSd
 EJxVTU0FLQ40hxhA.2ihXyXEzV2A8LNCQNFIkPJFDKa6GjkdHp.2L0n_AnSR6B2InJWyVh8p0VXg
 esSZlTX3gnP9qjGHtE7WBw2UFxDhPiEiBDMJ43AIjQ1qo6rXz3LxFcLZ6cX9pH30j31_8JJtC6iw
 GI0AixPOp8lEL2MkAG9Wj4H18oLK6uGblo4lBQ5c7L4GywSX12TSdOVe9vieaLQfZJr3o53SbHcV
 n6WhBJWaULs2Q81ktUHBTvwCyQ92bYT3EazQyZlocrg7cx6V52Gv9VbAKLgAlspiWs9XbUzfSWZb
 PuEVO69_U0qolGAiWinabOYm7ptO9jPd8QhQ52JcVCMc209WM2zDKjzQLBYyX5IFZortce7PBtiH
 LT5S.gKXssAM_Dg6uZF226xxCkdFc6k_xZmcSRrx0byWLYHx0tAn5FqjG2NckmG6EDuMERfuBike
 aVfcZo_vJX1Z17Lp.Y42WrL8RSTJf.R0MyS2Q26y6adKpBJl.etsJn_N9DXhd7VVOkGlGhzVs
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 65aea4d3-6d35-40c6-b2de-1931490e8bdc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Wed, 21 Aug 2024 17:12:09 +0000
Received: by hermes--production-bf1-774ddfff8-p9cwr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9fe58d1fa90c3de38467eb7ec416cf52;
          Wed, 21 Aug 2024 17:12:04 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Greg KH <gregkh@linuxfoundation.org>, john.ogness@linutronix.de,
 senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
 linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Wed, 21 Aug 2024 13:12:03 -0400
Message-ID: <5322439.6fTUFtlzNn@nerdopolis2>
In-Reply-To: <ZsSaQAGj-R5Z9q9N@pathway.suse.cz>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <2719346.q0ZmV6gNhb@nerdopolis2>
 <ZsSaQAGj-R5Z9q9N@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Tuesday, August 20, 2024 9:29:36 AM EDT Petr Mladek wrote:
> On Mon 2024-08-19 11:50:39, nerdopolis wrote:
> > On Monday, August 19, 2024 11:09:35 AM EDT Steven Rostedt wrote:
> > > On Sun, 18 Aug 2024 10:30:22 -0400
> > > nerdopolis <bluescreen_avenger@verizon.net> wrote:
> > > 
> > > > On Sunday, August 18, 2024 8:33:25 AM EDT nerdopolis wrote:
> > > > > On Sunday, August 18, 2024 1:12:14 AM EDT Greg KH wrote:  
> > > > > > On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:  
> > > > > > > Hi
> > > > > > > 
> > > > > > > I originally brought this up on linux-serial, but I think it makes more sense
> > > > > > > that it's part of how printk console device selection works. Without VTs, while
> > > > > > > most software is able to handle the situation, some userspace programs expect
> > > > > > > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > > > > > > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > > > > > > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > > > > > > refuses to write log messages to it.
> > > > > > > 
> > > > > > > There doesn't seem to be a mailing list for printk, so I had to use
> > > > > > > get_maintainer.pl. Hopefully this is correct
> > > > > > > 
> > > > > > > 
> > > > > > > After some grepping and guessing and testing, and playing around Something like
> > > > > > > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > > > > > > index a45d423ad10f..f94a4632aab0 100644
> > > > > > > --- a/drivers/tty/Kconfig
> > > > > > > +++ b/drivers/tty/Kconfig
> > > > > > > @@ -384,9 +384,12 @@ config NULL_TTY
> > > > > > >  
> > > > > > >           In order to use this driver, you should redirect the console to this
> > > > > > >           TTY, or boot the kernel with console=ttynull.
> > > > > > > -
> > > > > > >           If unsure, say N.
> > > > > > >  
> > > > > > > +config NULL_TTY_CONSOLE
> > > > > > > +        bool "Supports /dev/ttynull as a console automatically"
> > > > > > > +        depends on NULL_TTY && !VT_CONSOLE
> > > > > > > +
> > > > > > >  config VCC
> > > > > > >         tristate "Sun Virtual Console Concentrator"
> > > > > > >         depends on SUN_LDOMS
> > > > > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > > > > index dddb15f48d59..c1554a789de8 100644
> > > > > > > --- a/kernel/printk/printk.c
> > > > > > > +++ b/kernel/printk/printk.c
> > > > > > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > > > > > >         initcall_t call;
> > > > > > >         initcall_entry_t *ce;
> > > > > > >  
> > > > > > > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > > > > > > +       if (!strstr(boot_command_line, "console="))
> > > > > > > +               add_preferred_console("ttynull", 0, NULL);
> > > > > > > +#endif
> > > > > > > +
> > > > > > >         /* Setup the default TTY line discipline. */
> > > > > > >         n_tty_init();
> > > > > > >  
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> > > > > > > redundant, it is optional, so that it doesn't cause any changes to
> > > > > > > configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
> > > > > > > and for bootloader configs, it won't change any behavior if the kernel command
> > > > > > > line has a console device specified  
> > > > > > 
> > > > > > What is wrong with just setting the kernel command line for this
> > > > > > instead?
> > > > > >   
> > > > > When they eventually start shipping kernels without VTs, they will then have to
> > > > > include a script in their upgrade process that runs
> > > > > 
> > > > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"nomodeset /g" /etc/default/grub  
> > > > Ugh, I meant
> > > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"console=ttynull /g" /etc/default/grub
> > > > sorry
> > > 
> > > If you can modify the kernel .config for this, can you just update:
> > > 
> > >   CONFIG_CMDLINE_BOOL=y
> > >   CONFIG_CMDLINE="console=ttynull"
> > > 
> > > ?
> > > 
> > That could work, I think. I'll have to see how that works when a different
> > console= is specified on the command line from the bootloader though, I am
> > thinking that if console=ttyS0 is then manually specified by a user, there will
> > be two devices in /proc/consoles (ttyS0 on top of ttynull), but I admit I don't
> > know if there are actual ramifications of that, or not...
> 
> I guess that it would register both consoles in this case.
> 
> > I am not sure if real distributions would want this to be the answer I guess I
> > will have to see if any others are using CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE,
> > although this gives me an idea..
> > 
> > Would something like this below be more acceptable? I didn't test it yet, but
> > just the theory. I am thinking that this could have more use to allow a
> > preferred to be set...
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index dddb15f48d59..c1554a789de8 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> >  	initcall_t call;
> >  	initcall_entry_t *ce;
> >  
> > +#ifdef CONFIG_DEFAULT_CONSOLE_HINT_BOOL
> > +       if (!strstr(boot_command_line, "console="))
> > +               add_preferred_console(CONFIG_DEFAULT_CONSOLE_HINT, 0, NULL);
> > +#endif
> > +
> >  	/* Setup the default TTY line discipline. */
> >  	n_tty_init();
> 
> This is better. But it does not handle some situations. For example,
> default console might also by defined by:
> 
>    + scpr, see acpi_parse_spcr()
>    + device tree, see of_console_check()
>    + netconsole=, it is hidden in init_netconsole()
> 
> I tried to handle this another way. The "ttynull" console was
> added when /dev/console could not be opened in console_on_rootfs(),
> see the commit 757055ae8dedf5333af17b ("init/console: Use ttynull
> as a fallback when there is no console").
> 
> But it did not work well and we had to revert the change, see
> the commit a91bd6223ecd46addc71ee6f ("Revert "init/console: Use
> ttynull as a fallback when there is no console").
> 
> Another idea:
> 
> 1. We could use the same trick as netconsole. I mean to use:
> 
> 	ttynull_console.flags |= CON_ENABLED;
> 
>    to force register_console() to register the console even
>    when it is not defined in the list of preferred consoles.
> 
>    It is a kind of hack. But it looks cleaner that adding
>    ttynull console into the list of preferred consoles.
> 
> 
> 2. We need to decide whether the fallback to ttynull console
>    is needed as late as possible. It should be done after
>    all other drivers call register_console().
> 
>    I would do it in late_initcall_sync().
> 
> 
> 3. We need to detect when the fallback is needed. The check
>    of /dev/console does not work, see
>    the commit a91bd6223ecd46addc71ee6f ("Revert "init/console: Use
>    ttynull as a fallback when there is no console").
> 
>    A solution might be to check if @console_list is empty.
> 
> 
> Something like (not even compile tested):
> 
> diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> index 6b2f7208b564..7cd7ba2ec33c 100644
> --- a/drivers/tty/ttynull.c
> +++ b/drivers/tty/ttynull.c
> @@ -59,6 +59,16 @@ static struct console ttynull_console = {
>  	.device = ttynull_device,
>  };
>  
> +void __init register_ttynull_console_force(void)
> +{
> +	if (!ttynull_driver)
> +		return;
> +
> +	/* Force registration by setting the CON_ENABLED flag. */
> +	ttynull_console.flags |= CON_ENABLED;
> +	register_console(&ttynull_console);
> +}
> +
>  static int __init ttynull_init(void)
>  {
>  	struct tty_driver *driver;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 054c0e7784fd..004612e6fc7f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3857,6 +3857,25 @@ static int __init printk_late_init(void)
>  }
>  late_initcall(printk_late_init);
>  
> +static int __init console_fallback(void)
> +{
> +	bool need_fallback = false;
> +
> +	console_list_lock();
> +	/*
> +	 * Make sure that there is a console which can be associated
> +	 * with /dev/console
> +	 */
> +	if (hlist_empty(&console_list))
> +		need_fallback = true;
> +
> +	console_list_unlock();
> +
> +	if (need_fallback)
> +		register_ttynull_console_force();
> +}
> +late_initcall_sync(console_fallback);
> +
>  #if defined CONFIG_PRINTK
>  /* If @con is specified, only wait for that console. Otherwise wait for all. */
>  static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
> 
> 
I got it to compile with

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -513,9 +513,12 @@ extern int braille_register_console(struct console *, int index,
 extern int braille_unregister_console(struct console *);
 #ifdef CONFIG_TTY
 extern void console_sysfs_notify(void);
+extern void register_ttynull_console_force(void);
 #else
 static inline void console_sysfs_notify(void)
 { }
+static inline void register_ttynull_console_force(void)
+{ }
 #endif
 extern bool console_suspend_enabled;
 
and throwing a "return 0;" in console_fallback()

Seems like at least on x86 though, when I tested (CONFIG_VT_CONSOLE disabled),
the console is still ttyS0, even if I add "-serial none" to the QEMU VM.



I saw 757055ae8dedf5333af17b, but I feel like the intent is different, if I am
understanding that correctly, which I very well could not be, to me it looks
like it is using ttynull as a _last_ resort when all else fails, but x86 always
seems to have /dev/ttyS0's, unless I make changes before the serial consoles
are used.


My concerns are more about the distributions that have had /dev/console work
no matter what because of CONFIG_VT_CONSOLE. isatty() always returns true 
against /dev/console when enabled. When it is disabled, /dev/ttyS0 wins and now
software like systemd that logs there is now at the mercy of how /dev/ttyS0 is
physically connected or not for it to be able to log successfully.



One of my _other_ ideas was to in setup_arch() in arch/x86/kernel/setup.c add
the "add_preferred_console("ttynull", 0, NULL);" when CONFIG_NULL_TTY_CONSOLE
is enabled right above where it calls vgacon_register_screen() for this reason.

It worked, but it probably was not correct either...
> 
> The above code would need some love to compile without
> CONFIG_NULL_TTY.
> 
> Also it still might break some system/configuration where the default
> console driver calls register_console() later.
> 
> We might need to update the check in register_console() and
> call try_enable_default_console() even when ttynull console
> is already registered as a fallback. We might even want
> to unregister the ttynull console in this case.
> 
> Best Regards,
> Petr
> 





