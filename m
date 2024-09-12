Return-Path: <linux-kernel+bounces-326561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989F2976A03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047BDB20F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D721A76BC;
	Thu, 12 Sep 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="fhQ3s1fJ"
Received: from sonic315-13.consmr.mail.bf2.yahoo.com (sonic315-13.consmr.mail.bf2.yahoo.com [74.6.134.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D2210FB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146602; cv=none; b=TDMzp4kcU77yqfJ4+HbWBJmtAZ/IGMm3ax3EQ6ny6RmRGQuDW7UbXy1q99sNFNYVCE+Ol+B5iHBgGp9M0INIepLguVE+sfWATGayyanS4/LXiI74v7AAW8XS1Gae7VZUZyxZbKMnWe2IuzmsLKQDMvZzxbvekquPZjaFfFOPD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146602; c=relaxed/simple;
	bh=MGBinUaF5SfY3pAau0khMF4N0GQQ7g7gnHyQ0Z7/Ow4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDMx9dN1/+1QNcmnf7RmfCzXtdLwuojhlWddc1lXcZH08HMw3UOK1OVEmuL80S6gIQ9DNyHmlmRk9vdu3WAfKH93jiJZReo7h5lvotUvoKGtaR8rfGOcwZSwEtUoqI4kIHy0nxO+eTn0pY7sM67iSHNtvSwMupdC8Rw8IUdDMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=fhQ3s1fJ; arc=none smtp.client-ip=74.6.134.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1726146599; bh=7L/eHBpNmOuEWjFv4GT3lH8ka0MLePgF7mxghea+XRU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fhQ3s1fJcjeicf8+So3wPCoQI92TIldCxKsDmqW8jx/mJtTUfbh2yj419O1UYaH0ZSNNVGIVSrkHIY2HWyHtfdFCLhNRslRjnlb4Ahytrsrpr5SLXYCSAO8CqjohLg/ToCsl43gPuX03pWpnpU7uwaW42i6Nc1NDln5mqUkw1CR3y4eUGeAIW9Gm99G362QxN5ES7sCzNDxbjojc5u4PX1RR5+V5Tz8Njf9LVxmUTu0Jjgs54xv637Uq0UE7Mo/DKypwiD4FBAhchOxqQY4b79TSbeqX3V6hALLF4yRymCQ1DZs180XV4H7G2il96EfjMG+lpF9hqR884PFhZShPFA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726146599; bh=mSZlkb0IVDR8mRliClxbZzO7mjc3aGXS0kZjLNJlYDR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=W2/BQpJFm9Pm8sOpCJER0903y+4gDjAL465kKrF+RKGBqmkQCIXjJF5En13Y7eJeMh3BA3j9KZtiDB06FM3Wq2IHcoaJ7De+ilN9ek2+zwLthfPgz4DDhFcUWmk4bXcb2KnhKpoYkkqxILM2ZwAJTMMrRUNQGmOZGbp5OPNWijhiHDop4Z/tNeVgLwY/i1+NWXcGeXvt9PpEEmKRFsKdGIwpKB3ZoULDLwf5+IekV/dra5MlulHBjkdGvrSS/hCZee1HWLuduEwUxQ7Po4eGwfE5HsHe87+IlEYBhKbU0+g4wBvePJ6RW1Ue9J/gBToyfLWFAyKZmSE7f8CTQzQ+6g==
X-YMail-OSG: j4NTCXcVM1nC4E4AXiT3_vRYdYrKiPUmdzMegwti2t4PF4R70p5uZFJSPK8zsEP
 jrFvUqT0L37726ItByY_JwURuGiFMe_y.M3oHieEhf_i9dVhUJ2kt_NNPEXGDPYP0X263_T8SJKz
 aAqsK6nu4i434Oj_NRntuQ5Xeknr.pzX0wSz0evC7DCvhaNghbMgyH8.kHBe2Rk9Ihx9SG02V3US
 11Sg.OdRsrlHH_.bwOwEqSZikFSSCNVr306691q6boW0z_.FyLL3QHuxwFgkcA9U8xPELgZL9xmU
 mLQg9AkULCmFw47jw_J4ELyc7mFzWPEbtiQ97rnLsSmDuy0ObOMXTMw9bkIuFxPVY5DwInB6RdGI
 JDx2iq1R73mjWxBpTWYKAPM2lyKSCptlQp3bLJNw9tIFDGJpQryQ3CWuzFUJpQ58Hpi6Lv8mefu0
 WeuYVsro2vtifLOL78n7RixdO3UZWxBeXQ368H0Ggxg_htTkc5JRpflKVNExelAJdhUtIRvcdyBS
 r8Nx6uE8Vi.OouYv36NvWmCBnvWtq.gqEjrr1Ff_mJogWMRSy5rfB26Hf97nxqiNxe22jFiv2swn
 9W3sE2NzLZuT7w7kxjM0hBRv5M1w_K_6UpU9peOCwI61GeddUdzKYUVwxSvzGFePHctoN5fWcRdL
 VlLiE0XmJw6LGJatMQw9XVOPlgK43mtEcLmlZcns14dfkxAQoAdLX6Jh8OXIa5IvjIFz_yj1vkF.
 2iL0fbZC.w8Yo8nM0ci7BHKJnKYmPv6hvExZJ6uCx07rflGzVy8gFphnAkumOHsrp5UXeYL0wsLV
 ob1t7eRcYry3Tpph7MuKvJFuSuj9pkOguNjvr_xU9mTL2ToBftYbAgTWIxJMQC7S5Qzxea6.6Iu.
 GoD84gGadGT5Hs3Lw3FoxqaBob_TaaGFrNM39hslQAw2jHGfP9ZwqaUL3Tl0SygtVPaOq6Tlx89N
 Tt7_uT4PkPTGl76fLMFCDEK8XYoITdiSmuR4zKpIhoN.z0TzW195vWSJyjk_qoW8QvGx_pxmVb3A
 xvjBxwHp5c42YUoVDfcF1hCW4KUbsJZkE1bBdKDOtGBMdbEhhTpRm3bA_5ljFJ71SX.3Nh31Mlhg
 5D2P71uXjlzG9gJ4WnWzsQReiApev6poRqcVeq0hSaVJYvnWdToXAzTTmUEUinvR3q74hlkLRQ0l
 Nja9PRuB3B9qH4uFdWu99dZLzuLHpp6tRdQL1bL2nhE7VBeMAlNWkqt7Nmf1Sf0vTIfE3sStI8WT
 b2OYAEUzvNmoiFzXfNzGTRyou8a1XTDQ84N0Ibwy.heMt6pQFgczukgzgnInFqQbxN4oyMJF2GwB
 x4m1P0MixBABQ947LnvtqQf9FgQOC6nKiR7SROEMxnhm8k26sWV2FQPhs6DZrejKGSLaT4sDdCRU
 yZcebrdCgApRjJBO06Nszg0mae71NDJPVHYV5JfuPZMhjtsvGAd7c0GvAwZmJkxWT3Eij.qdMeNa
 xFMYI.fT0dSlsUeuoqmoe7F2FR5ei6bOuuxwkyACRUwlRk3oVq7oVRNCq1S8V7ezFcqn.8cm4ofc
 rHAFtqKwXg0JIexMF7qTawA6l9yGjX603zNPFskSScxtDWSo9VXxmf4YxoQkvEiIL2F_HK7bmxJG
 rLB8991gQePDpgueWpSWY9Jf6lLfG8l9XE_Gaq_z1rGDLkQguZ5GddT4uJ_cJxNJ1028YOTETbmQ
 EnrP.1srR5_wRuSY21KM7hfQ7TFpn_lhOOXPGCE5XPx61yDCjKjq59EDO5kO3cNJ89htrSJpHAmU
 dkyFooG_I3fQD_zrWxXIvPR_2XKUyc2NkrInXZjclD7sMSso33MZiPgTtMw9N5eFk1JvGe3ejSdB
 6y4wF7GECY7b8eRUvVrdvBEHNi9gzXs63k7DWvrHClYgK0nyGMWnLsrd.7TP.8ARl1xSWa1l1o.I
 dnTg3d8rrKSMHc8bFhBQQyE.zptUZW5zbGaOYXlXJN8AOXPvNLhvxve2lpltiDwyVOkwFafVW7.t
 uZHCEgBOTe9NfS4qIkrces6ZpRaV5_vnzLy9QvtTIb2IFzv75h425kAC2xIsGjO9bY1FkMxtyzB8
 EuHfk1YXTDRcALLLn0Ke7yWa.pDhEQQHNNzBQRpKzePeitMDQwuBkMoRofYVibJ_LxbIXIdo_3Cu
 8Iiz4d0fOLkGLVPidq4L9Ncw.zC30hik_2F4u9QE8sDTnyU10Qd357gdLwDY0Rtqp6NaeUODxQy.
 4VBSKBv5wwgxuhfPTlOm_aQLas4K5PbnPuxQnBYl.JrTI9IUsFJK9qlMW9XOBgGzz45JR
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 5adef0da-6b51-4742-b02e-2ca27fe8456f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Thu, 12 Sep 2024 13:09:59 +0000
Received: by hermes--production-bf1-774ddfff8-5fpvh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 09fd10d20d38cea38c55d03d0759fc0e;
          Thu, 12 Sep 2024 12:29:27 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Greg KH <gregkh@linuxfoundation.org>, john.ogness@linutronix.de,
 senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
 linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Thu, 12 Sep 2024 08:29:26 -0400
Message-ID: <2751891.mvXUDI8C0e@nerdopolis2>
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
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

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
Out of curiosity, would the upcoming nbcon work fix the race conditions or
problems that were seen in 757055ae8dedf5333af17b ?
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





