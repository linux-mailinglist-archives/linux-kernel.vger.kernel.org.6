Return-Path: <linux-kernel+bounces-297296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415295B5CC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FF71C234B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B662B1C9DFA;
	Thu, 22 Aug 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="KdWdiHiF"
Received: from sonic307-1.consmr.mail.bf2.yahoo.com (sonic307-1.consmr.mail.bf2.yahoo.com [74.6.134.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BA1C9429
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331565; cv=none; b=SLq+Wm64ce7YPO5aRTewiOMfBYycuFmywi/xdXR4ji/pF0mr9AKxHJ7BpDJLMtsol8XRQMk2F62Ghi7AtR4xOvQwLfk4IpsM9DHRvhz8aSoVM/ZWcwsz3KP0HXDx5l3XhBZXZd8wehr4H38Li954I76H6I7g1/D2tC6GUKDQq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331565; c=relaxed/simple;
	bh=W1/gaaM1uh+vreW0GAAgGkJZj5pUhUXHFr97ujN+17Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULTFtT0VRzQ8/XO80Vqbuq0kAZz1O1i9af7lVh5qBMLAyDdcyLlvCxmnXwfovJ8YDPob5fH5+1XPh39+dxO6Ny6KqZqiSKqlc0frPmODPmtRtGWiMiDde+TUx8kCW5ISRY8sF1WD/RMYTNwlrfamsN5I7K8mmeWC7jjvX5TM4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=KdWdiHiF; arc=none smtp.client-ip=74.6.134.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1724331555; bh=J7NjTm1fKuthES4Z8xX1BOmbYk+dnNJpm3rQeI1xqQU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KdWdiHiF49qF34s15vNh+39eyRrrfz2dc/LPuDRX3W+FH2iSSCa/98pnpZqav5O25BhvuvdaBI7eCkjX8/pT/BMPz8cr4H6E63c2q0xt00hta8/6202/gpYG6oZjF2WERWyR0HtFyMX4E8chc1aQeooZhYDiX9B7HEn39UEF3MqfA8iYGZ0sP/4ZBNH8JATe6uFYNTVlM67fcCg3Q3P/sHhtErbXGi79JzIncHBnRs4G7ywbd4izdbTm0ZsTrwVPDSrEvfHTKyNT8SNkqZET0gCcpdg04TodkCYA5fW3X3vecjJ65kYoWScNi75wtL3L0qNu/wk1EkBb6JAXbJZQ+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724331555; bh=/DIevzRwUWutvDooKgWPizmPU7bYy8n4jlG79tqmk82=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=p4HgtHSYYQ6dC7Qys7RWJQYbc5d+KfRJCklZIJIkirWCgHE0YVIED1+8534aJH1feLJcmNg2mJZ7W/Q0NSUDjGxJ1nDZEHiY4EPesjYnRQjRpM30zMrScu36PNi4ROFlf+hck1oV4O/7SDOMV1Be7kZ1U2yO+dh2RS79jOcHSqr2bgv9/X8zFJTiMkMrE9Vp7AiBHAEnxbfQ/uCsZvcfQA935tR9D3HOKPPJXH/ZUOQZ/wUWElnCg3ItVfCszmYhRibtSjZ6oE+3ZctvFOq9TBvyyQvRzL/iRurJcdhy3GvFpvq+FLqFqS343irexPI9Vg0U1WuIgrlf4AKVmvVHQQ==
X-YMail-OSG: Jhbe9JYVM1mPXa6iZ64iHFjGpvj0ET0VJBeuoGS0zT4qzOgPefliZdmj.loQOna
 IeStE2W32zpMvtS_4IH8CyhNdQS6UW4Gpwz7BjVldXs8P4ALQYbHCGX2AYZsElX1SoqbkPPOeJrw
 f_vKXkvhz7GZKSIkagNOH6lF6Ge.TPebyDYRYyijRFzNWYi0LthkFjsFDRr8BBGZI9oXZa8Mx3bs
 Qk4BrdE.BIKARsfZKtZcg7_dbi73MxwITCWpJWC_X8Bc6RV24h_R9UJdJZjcEzqNaE905n4IaDWb
 N50DVVkbQZ35VYSHaXPZoBZzhaCo8ZXnPpeM4eZ4LUqITqTpLDQZOq2j5lGC0bs.L.FUpYFCqBao
 RuNLMh_3ssDSlkOE2bI7E964lcS5kLzcggm.3JKCGv9z.hfQ1iPxgOq1KkC0TpbGpzUHuP5U4Gjy
 Gt7qzrsPXVAQmT4rGyLIrqd7hhPNQ73n0qiqdFQl7YtfB4fZdWAqLWxp2xFxCvIlvH.U47LbkU23
 CDfPHf6Rdz3Ehe4VAWrztRIVCmHbCoqT0LKmtZqpn9.0JPjcKP_wUoQFxVLLAUQnB8lxyNeeNnkQ
 acNVAesc8j6x4Ha3krMo.xe8i.j_0UQeCV8WfyHjSqBt6ZWKM2XqaursKSKzu3KxZ34fZv2DOpmI
 lEJyr7SHTQwKux22jf5x6eHY5H_PaQtv5IYGRhUwCyg1CBkbqRUi7PhFIgvnIYtVhnaBzao5xAeD
 sbWv4lsMVHh5obegQDkQnd.TJKgUaVwaP9yYxC0E02BDTFAuLs3LOK.NEPJbjWzBC2SErKBeAKX2
 cjkFQiCJnNmVWHLjIf4xA0VpynGP4hHl_EuL40pIeSG_y0zt6rcSbkl2F3E50mkGI3x4Sw7L_hb7
 ukAx9akJBRe7kj3_JEsK1L8BRJ1HUHCeVkdjyNU4.B.Fv091j5TGOj3uhu_FG_7gnQyYAsmqc1IO
 3DBXbbYNGpPhpcovQQo6KePPloWWLrfLO.Og6o8F.l._YVTwhxTEYg8GfdzBNaBT1lR_VeEDtoKt
 Zh3GRbf6IlIbuaX2HQ8jkXttia1u3DWX7w6TRRBNbW4HUTmwBcGDChqqY8i93Ys.tnq_dES_a9NY
 grsi47BIrgT84EyC_qVBrMpCAc_20LKv08RRaZINFLLHPqYjjn61b2mGTdw6OBCjXs6fm3yNhUnM
 gXqz34b3lUg00F14.BGW2Osb6fZyzNpjHVilh7FaVDVREXpSAoKUQ6SeJZJbiAoBs6eINNxGXIuv
 35.E_2bMHfRb3Xf8ZcWGtJGDS.81h_zNeqXs.xlKy7rBfoAnPVuUJJHzebG1C1pd2RflNCl_lv2a
 vPu8_E6vxtmt0cW1BxuGlf_4obr2ERUmOEQz_5fVAVIeEPxnep6aeH3TSyEm1xfv2cgOPwM3Ew2y
 jvQgQb2IH.5VW1iQDl60QoCHuw7e4pZRUHM..lsLYq3GCqQeHDRrjhWkijdbfhN9HPU62hKnLZ8T
 457LypxtCp.goBKZY1pr9YpAByj7OdaMRDwcJvf2UpHZx2jAtkLpBn5omAtcUcHE_bH.wlOLj7J3
 E0JbMbAoZhokjqAQ15S27eGSrbxorMIhIR4pMaMGCN9xBySBD6juCdJVDEamI7XVW4KXoEQ6dS6u
 jLfdGl.wfQb0oUwsEtXaAzFxXZhUX9Ez1nE.iq6ScjJSydZd4aEvXgGUEH3FiUnVYJXdjPw5krKC
 c5p20_5NBR2G9nGksx1.faBFWbZc0eco750N8qd79ec_RxOG2lHoRyNWcc9n1emfn86LmcbU1StA
 3H084jWhhO3MCz6EZkFZ2oh2N2OtLJOxa_fuge6caXZQwS1ms517JDIUJFhoNkGD5DRrm_kRCs1o
 LDSxaplViIg1sAbvgPZ4n43RRi54xGgAShNCewwEgmhVW79f6vG2KhvKst7ukZ.ZqxHw9OnfmHXw
 zzHpnPvl2WvewSISn8LRNBoDDPDN_t03Y9BezibZqSmzIk61IRWUx04ggc6z_U.CHpKZ95i2EX3z
 0wGE49a41Zg4iurPoKpuAZZDaZyZNw8sVW7S8usCxTEom0ePpe5iZuE5NYA1xyyl1jEcxOu2RWqK
 u80cshchlNMcSaK5Go6HxcdbSzvs66I9ApNWzX3bVztbAvEt3kOCUKZzkTbv3DIbxzZ_QXyImSCe
 74gVjr3uA2zCuxyBtGJB8CLrfBzYElGBqcMUoyLjAjjVL.NLlnlHceiThzFqfKDaR7JoShgbsB5T
 aldkAR4WYO.DE8LHsmBJpT9YgHy2bv3x3yb2cTJ1moI4totsVowlm3IllZfWZUy6P5x.MRdO_PIT
 dssZU
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 7df2cf60-4876-418d-8617-7d7bab85020f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 22 Aug 2024 12:59:15 +0000
Received: by hermes--production-bf1-774ddfff8-7v5k6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e9fb1b2638dabd063f9193fcd161555d;
          Thu, 22 Aug 2024 12:49:06 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Greg KH <gregkh@linuxfoundation.org>, john.ogness@linutronix.de,
 senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
 linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Thu, 22 Aug 2024 08:49:05 -0400
Message-ID: <3085227.687JKscXgg@nerdopolis2>
In-Reply-To: <ZscNX79dnXUjeTc4@pathway.suse.cz>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <5322439.6fTUFtlzNn@nerdopolis2>
 <ZscNX79dnXUjeTc4@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Thursday, August 22, 2024 6:05:19 AM EDT Petr Mladek wrote:
> On Wed 2024-08-21 13:12:03, nerdopolis wrote:
> > On Tuesday, August 20, 2024 9:29:36 AM EDT Petr Mladek wrote:
> > > On Mon 2024-08-19 11:50:39, nerdopolis wrote:
> > > > On Monday, August 19, 2024 11:09:35 AM EDT Steven Rostedt wrote:
> > > > > On Sun, 18 Aug 2024 10:30:22 -0400
> > > > > nerdopolis <bluescreen_avenger@verizon.net> wrote:
> > > > > 
> > > > > > On Sunday, August 18, 2024 8:33:25 AM EDT nerdopolis wrote:
> > > > > > > On Sunday, August 18, 2024 1:12:14 AM EDT Greg KH wrote:  
> > > > > > > > On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:  
> > > > > > > > > Hi
> > > > > > > > > 
> > > > > > > > > I originally brought this up on linux-serial, but I think it makes more sense
> > > > > > > > > that it's part of how printk console device selection works. Without VTs, while
> > > > > > > > > most software is able to handle the situation, some userspace programs expect
> > > > > > > > > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > > > > > > > > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > > > > > > > > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > > > > > > > > refuses to write log messages to it.
> > > > > > > > > 
> > > > > > > > > There doesn't seem to be a mailing list for printk, so I had to use
> > > > > > > > > get_maintainer.pl. Hopefully this is correct
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > After some grepping and guessing and testing, and playing around Something like
> > > > > > > > > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > > > > > > > > index a45d423ad10f..f94a4632aab0 100644
> > > > > > > > > --- a/drivers/tty/Kconfig
> > > > > > > > > +++ b/drivers/tty/Kconfig
> > > > > > > > > @@ -384,9 +384,12 @@ config NULL_TTY
> > > > > > > > >  
> > > > > > > > >           In order to use this driver, you should redirect the console to this
> > > > > > > > >           TTY, or boot the kernel with console=ttynull.
> > > > > > > > > -
> > > > > > > > >           If unsure, say N.
> > > > > > > > >  
> > > > > > > > > +config NULL_TTY_CONSOLE
> > > > > > > > > +        bool "Supports /dev/ttynull as a console automatically"
> > > > > > > > > +        depends on NULL_TTY && !VT_CONSOLE
> > > > > > > > > +
> > > > > > > > >  config VCC
> > > > > > > > >         tristate "Sun Virtual Console Concentrator"
> > > > > > > > >         depends on SUN_LDOMS
> > > > > > > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > > > > > > index dddb15f48d59..c1554a789de8 100644
> > > > > > > > > --- a/kernel/printk/printk.c
> > > > > > > > > +++ b/kernel/printk/printk.c
> > > > > > > > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > > > > > > > >         initcall_t call;
> > > > > > > > >         initcall_entry_t *ce;
> > > > > > > > >  
> > > > > > > > > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > > > > > > > > +       if (!strstr(boot_command_line, "console="))
> > > > > > > > > +               add_preferred_console("ttynull", 0, NULL);
> > > > > > > > > +#endif
> > > > > > > > > +
> > > > > > > > >         /* Setup the default TTY line discipline. */
> > > > > > > > >         n_tty_init();
> > > > > > > > >  
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> > > > > > > > > redundant, it is optional, so that it doesn't cause any changes to
> > > > > > > > > configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
> > > > > > > > > and for bootloader configs, it won't change any behavior if the kernel command
> > > > > > > > > line has a console device specified  
> > > > > > > > 
> > > > > > > > What is wrong with just setting the kernel command line for this
> > > > > > > > instead?
> > > > > > > >   
> > > > > > > When they eventually start shipping kernels without VTs, they will then have to
> > > > > > > include a script in their upgrade process that runs
> > > > > > > 
> > > > > > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"nomodeset /g" /etc/default/grub  
> > > > > > Ugh, I meant
> > > > > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"console=ttynull /g" /etc/default/grub
> > > > > > sorry
> > > > > 
> > > > > If you can modify the kernel .config for this, can you just update:
> > > > > 
> > > > >   CONFIG_CMDLINE_BOOL=y
> > > > >   CONFIG_CMDLINE="console=ttynull"
> > > > > 
> > > > > ?
> > > > > 
> > > > That could work, I think. I'll have to see how that works when a different
> > > > console= is specified on the command line from the bootloader though, I am
> > > > thinking that if console=ttyS0 is then manually specified by a user, there will
> > > > be two devices in /proc/consoles (ttyS0 on top of ttynull), but I admit I don't
> > > > know if there are actual ramifications of that, or not...
> > > 
> > > I guess that it would register both consoles in this case.
> > > 
> > > > I am not sure if real distributions would want this to be the answer I guess I
> > > > will have to see if any others are using CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE,
> > > > although this gives me an idea..
> > > > 
> > > > Would something like this below be more acceptable? I didn't test it yet, but
> > > > just the theory. I am thinking that this could have more use to allow a
> > > > preferred to be set...
> > > > 
> > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > index dddb15f48d59..c1554a789de8 100644
> > > > --- a/kernel/printk/printk.c
> > > > +++ b/kernel/printk/printk.c
> > > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > > >  	initcall_t call;
> > > >  	initcall_entry_t *ce;
> > > >  
> > > > +#ifdef CONFIG_DEFAULT_CONSOLE_HINT_BOOL
> > > > +       if (!strstr(boot_command_line, "console="))
> > > > +               add_preferred_console(CONFIG_DEFAULT_CONSOLE_HINT, 0, NULL);
> > > > +#endif
> > > > +
> > > >  	/* Setup the default TTY line discipline. */
> > > >  	n_tty_init();
> > > 
> > > This is better. But it does not handle some situations. For example,
> > > default console might also by defined by:
> > > 
> > >    + scpr, see acpi_parse_spcr()
> > >    + device tree, see of_console_check()
> > >    + netconsole=, it is hidden in init_netconsole()
> > > 
> > > I tried to handle this another way. The "ttynull" console was
> > > added when /dev/console could not be opened in console_on_rootfs(),
> > > see the commit 757055ae8dedf5333af17b ("init/console: Use ttynull
> > > as a fallback when there is no console").
> > > 
> > > But it did not work well and we had to revert the change, see
> > > the commit a91bd6223ecd46addc71ee6f ("Revert "init/console: Use
> > > ttynull as a fallback when there is no console").
> > > 
> > > Another idea:
> > > 
> > > 1. We could use the same trick as netconsole. I mean to use:
> > > 
> > > 	ttynull_console.flags |= CON_ENABLED;
> > > 
> > >    to force register_console() to register the console even
> > >    when it is not defined in the list of preferred consoles.
> > > 
> > >    It is a kind of hack. But it looks cleaner that adding
> > >    ttynull console into the list of preferred consoles.
> > > 
> > > 
> > > 2. We need to decide whether the fallback to ttynull console
> > >    is needed as late as possible. It should be done after
> > >    all other drivers call register_console().
> > > 
> > >    I would do it in late_initcall_sync().
> > > 
> > > 
> > > 3. We need to detect when the fallback is needed. The check
> > >    of /dev/console does not work, see
> > >    the commit a91bd6223ecd46addc71ee6f ("Revert "init/console: Use
> > >    ttynull as a fallback when there is no console").
> > > 
> > >    A solution might be to check if @console_list is empty.
> > > 
> > > 
> > > Something like (not even compile tested):
> > > 
> > > diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> > > index 6b2f7208b564..7cd7ba2ec33c 100644
> > > --- a/drivers/tty/ttynull.c
> > > +++ b/drivers/tty/ttynull.c
> > > @@ -59,6 +59,16 @@ static struct console ttynull_console = {
> > >  	.device = ttynull_device,
> > >  };
> > >  
> > > +void __init register_ttynull_console_force(void)
> > > +{
> > > +	if (!ttynull_driver)
> > > +		return;
> > > +
> > > +	/* Force registration by setting the CON_ENABLED flag. */
> > > +	ttynull_console.flags |= CON_ENABLED;
> > > +	register_console(&ttynull_console);
> > > +}
> > > +
> > >  static int __init ttynull_init(void)
> > >  {
> > >  	struct tty_driver *driver;
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index 054c0e7784fd..004612e6fc7f 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -3857,6 +3857,25 @@ static int __init printk_late_init(void)
> > >  }
> > >  late_initcall(printk_late_init);
> > >  
> > > +static int __init console_fallback(void)
> > > +{
> > > +	bool need_fallback = false;
> > > +
> > > +	console_list_lock();
> > > +	/*
> > > +	 * Make sure that there is a console which can be associated
> > > +	 * with /dev/console
> > > +	 */
> > > +	if (hlist_empty(&console_list))
> > > +		need_fallback = true;
> > > +
> > > +	console_list_unlock();
> > > +
> > > +	if (need_fallback)
> > > +		register_ttynull_console_force();
> > > +}
> > > +late_initcall_sync(console_fallback);
> > > +
> > >  #if defined CONFIG_PRINTK
> > >  /* If @con is specified, only wait for that console. Otherwise wait for all. */
> > >  static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
> > > 
> > > 
> > I got it to compile with
> > 
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -513,9 +513,12 @@ extern int braille_register_console(struct console *, int index,
> >  extern int braille_unregister_console(struct console *);
> >  #ifdef CONFIG_TTY
> >  extern void console_sysfs_notify(void);
> > +extern void register_ttynull_console_force(void);
> >  #else
> >  static inline void console_sysfs_notify(void)
> >  { }
> > +static inline void register_ttynull_console_force(void)
> > +{ }
> >  #endif
> >  extern bool console_suspend_enabled;
> >  
> > and throwing a "return 0;" in console_fallback()
> > 
> > Seems like at least on x86 though, when I tested (CONFIG_VT_CONSOLE disabled),
> > the console is still ttyS0, even if I add "-serial none" to the QEMU VM.
> > 
> > 
> > 
> > I saw 757055ae8dedf5333af17b, but I feel like the intent is different, if I am
> > understanding that correctly, which I very well could not be, to me it looks
> > like it is using ttynull as a _last_ resort when all else fails, but x86 always
> > seems to have /dev/ttyS0's, unless I make changes before the serial consoles
> > are used.
> > 
> > My concerns are more about the distributions that have had /dev/console work
> > no matter what because of CONFIG_VT_CONSOLE. isatty() always returns true 
> > against /dev/console when enabled. When it is disabled, /dev/ttyS0 wins and now
> > software like systemd that logs there is now at the mercy of how /dev/ttyS0 is
> > physically connected or not for it to be able to log successfully.
> 
> I see. I have misunderstood the original problem.
> 
> Hmm, historically, the kernel tries to enable any available console by
> default. It makes some sense. One would expect that when there is a
> device than the user should be able to access it and see the messages there.
> 
> If I get it correctly, you suggest to do not register serial port
> when it is not physically connected. It makes some sense.
> 
Hmm, now that might work, and is a good idea...
> But I think that this should be implemented on the serial console layer.
> It should not call register_console() when the port is not connected.
> 
> Plus, it would need the above patch which would register
> ttynull_console driver as the final fallback. Otherwise, /dev/console
> would not be backed by any device. Or we could update console_device()
> to return the ttynull_driver as a fallback when there is no console
> registered.
> 
> > One of my _other_ ideas was to in setup_arch() in arch/x86/kernel/setup.c add
> > the "add_preferred_console("ttynull", 0, NULL);" when CONFIG_NULL_TTY_CONSOLE
> > is enabled right above where it calls vgacon_register_screen() for this reason.
> > 
> > It worked, but it probably was not correct either...
> 
> IMHO, this is not acceptable for a generic kernel. The kernel should
> try show the messages whenever possible. It should not ignore serial
> consoles when they are available.
> 
Makes sense, on many desktop distros, the logging was not going to physical
hardware because of CONFIG_VT_CONSOLE being enabled, but I understand there are
many different types of embedded devices though.

Which is why my first thought was a new CONFIG_NULL_TTY_CONSOLE option that
would be disabled by default, but when _enabled_ (Trading CONFIG_VT_CONSOLE for
it), the behaviour could be the same on the serial ports,at least on x86, when it adds ttynull as a preferred console...

like:
#if defined(CONFIG_NULL_TTY_CONSOLE)
	if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
		add_preferred_console("ttynull", 0, NULL);
#endif

in arch/x86/kernel/setup.c to mimic I _think_ about where the VT console would
have been registered, and in the same conditions...

(this would only work in x86 though...)
> Also I am sure that the kernel is used on devices which only
> have a serial console. Such a change would cause regression
> there.
> 
> Best Regards,
> Petr
> 





