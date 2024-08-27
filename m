Return-Path: <linux-kernel+bounces-303431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E49960BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B551C2301B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AEA1C4ECD;
	Tue, 27 Aug 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="WJJBNo/K"
Received: from sonic308-1.consmr.mail.bf2.yahoo.com (sonic308-1.consmr.mail.bf2.yahoo.com [74.6.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0121C462B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765055; cv=none; b=luKCzIRls03uMnd0ECWsV4eOoNKjTDsyxRZ8GIUXPgjp3VprVUm0jCPy6SuXgxmsxeqHSsGvs/VW4mrigXiUZYwVzSmoIVBdIpMW/wrTtrLvpPOA7XY73IdENWEvJb0Yok0ThZk2iEftmn/+tBgRbOD0TJNkZI1oLeshzG8vIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765055; c=relaxed/simple;
	bh=inWKsZbjWC2dqToXv2tkLCfk1UjjkCQ2DJcFr2VZ5tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQPcEo8253+GXDQG61FsjaL+4dnZpYC4pY+iKenAeo43zJCHbVoibZVtIRFCNUnp4tNfTWjAa/mG0UvTmjSS9sklCTsge6kUfLNp8aidzPo4cGiYmfbVkgsYCSwWRlJQ0mvimApqSZFm+U/wyvQND68S22fiem9Awq0FRwiCq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=WJJBNo/K; arc=none smtp.client-ip=74.6.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1724765052; bh=kDldLf2PkHB0kQCuqC1vJPl4Lh4cUUi9hA1G6SKIC9U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WJJBNo/KQL0VnY1sk58dlMdWlssGeStMx/imdS5B6x28vMrLM7BH4pl812pGnFqDOdvPMOG1mFLPXpulsCr4vLrpwBGBI087OdZbubzdpU0S41FKZqz4Mg7PIJN5kcsnA/bl4uZ0+3stlTIG5DI++aFhMAPRLxK9rgOgLqTvyT7QvJYhDOEs1EcwYVwSHA2Mr1blYLg5zvcTFUHw63iFOKxAyw86OsIiMmgUngLxrdtXEoyHPQCMFLeuS3102zMnac/y9QAAAEyNIrQu/VnUcx6zxJsyxiCa3r9v5qHO3Z5Cf/NTeUyWN5q02d4x9VPoFxz07/ryk2p4NeUN0saRnw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724765052; bh=QeAzBTwbBJcsgPEnZOiXGNN9Jcn9Sk+IoKisd4LJ220=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AZNPsjUMm53aVmZ5BNUfYt4wrLA7OWVYK1sq6K0jA2sGWIYykcJlBEItsdW3P1p4BOzZjG4+cuYDV40YjF1Mc5k3x9xVbavsfp8q5PDvY379AbGZyqU5EruO8na8j1snP1AU5eb5uCh8jPM9tbnjOXf/wKZnk7xpGPwdZFzk7Fa/ONFsvY73EC+nT/h/YYvKjJRKpdU2x8jSe+glm0rsQ/na/0FGqQJzpjhCKVGHtCTdhDEBuufWF4vsxQg7egIU/lcVTTilxTbNj8LEcu39KstrO1qs/r+W+uNQKXCfZJdYAW0vGhyG/4hwatmyxNSeUdmMHJUzyiYrXIxvwidpOw==
X-YMail-OSG: 9cVK0foVM1mGiBDY2usrzmxDhddWcu5bFf4PlNEVSDA7O9_CCp8TBCDHE5ECZNq
 kK_ncXN2Mc53c6NkwZjC2yvlMA51baeNYTo22atOc.t3UDhdhGiiK4t8EK4t05lV8iQz5IrAMf4y
 uptskn0rnfxL2zK5BJnpgfGw0ROe5fMzDpa.60PTds5J3wMFTGF1TUJhP7J3ury9oUFDW4ooFfqB
 VCEhQuVv2C6GSMobZlmRScUhrTHDMavQeGHpZTMoZPPkw8p9aWaDwtPe4sN6eixgVnDFyVeYQRUt
 W.zaXBFAAcfzGqdYmOe.e0Ab2koUnytE9iFS13XlIZc4zrosFt1lBlFWb5XC75.zA.hSxN3ui4vN
 FALlUHmNN.K8RGK17QbldgUYKJygz7NISJIx2G0V_clBCD9nzieh6NGSIbgxZHO_Tp3dPWrpMYvZ
 qXKSv0L8MG3h5985tXwL5fLXtbOtg5iBvHbUHXUt1BFscH_PzLYHm9uPBBANl4KcWeRMKp1xA_ZP
 OTO2rXN4kME4iQME24HNNBHpGylunrOHEJX4BAWc_e1gf2227g0mZ4PPKbOCWcQWhhVWwWpfhRyK
 hd8TtbOdZhPbJ2PUuPLfZ.TKdbhiNvO4JKS9Crlfhof6iAkz7xJn0BWybywmcedlwANgvdtw_b3A
 XLFHIDK0vX6B1ogxaFGbGNgPV1OWyNYAFjWoj3BNg4YUJ9_cBGv35tdmTthkBYzh135.zpuOJ7aF
 eEz2IxThcz6flKw6bOwHBuYaAFviM_Z0utGjYEE95UF689..GH27N_nbJI6SZTPUvhcM1Y95aNVv
 AL30dIuc6zHov1F8ssoc5o4OtNKcbLDb7zNlyooemj3mgiu.gTuSfqqoVazBZbpa.az7s0G0IakJ
 h4Rjy6bpgIal7iSWN4cScYp9hUHUjoT0VDCX1E3QA049nlX6b8FB6OItJHxa9wpqCDLux5CdSUaD
 CrACs_sfNKW1uOLdSHrPmu30txP8Cgy21eibQM5ny.ctiVkSw90aM7kfbVldO_izzI6oE7LB7eRu
 gxBdtF3er4.lyIp9vWvGt3Wf1_J23sUXGUHxvAWElmJ0PT.7KdQH4BtlQHDZODISNmTi.6kPFOon
 cgMSpUNQ5RvFWg0McwY7NDY8U.XRjAvnzUIuKbR...di1dZFRtkiT6s7BAjF_oVzH1ysx_U5nnXX
 EzzzT2oXlmdbMIrV0SjrAk2gy1C1j.Gw6.Rl90FQ5TmR97URX.AjTE7wRApOn_rPrAo6FOjufiv0
 3spUflBFQDZgndNtiVG9ypyq2a71k5hFW8Dn2iHR7x0e3us4GWEhrmP0mxH.kpZT7V..Ku8jXtGs
 oGJzpE4K6_dtxfMo3njqyrRbjYeFTPZIvOTaTeYMAdTuTRP.s1d5eSR28DXv5SCHmj0LkCY6Vlsx
 0bTvekQ1pjvs3MTNjeqe8BNR2rSVp.J2RIlh4q1i_POn.ysWhe9uY4zaB1V_7CZ4ESth8P0q7O1_
 BZoCrbM5X9yKXKWpMHfmcHK9YwDPCQAYOO53KS2qdtCdty07Yc_3Tma4dO_Qk5pSbajZpo_FAGT3
 GifSzgGG4xIil6ORxVTbVeWwkzVpJX3npgDXpLjEZnhAut6omId5revKszTnBO.Mh9eUJLBJ1vd1
 vpL4qMT7KHm6FocjUMpwvHnxZdFvvIzQ9p.jqReIxQp_vUljyS5.Zn_vGSihEKNTkDgyHgFQTbjH
 EbGcWPpeJzaeRGmU3KLZRUCsyMENi2WRfoASq51w15B6udXiSBVovorK72l.3UDrO24pMUzLCHQ.
 eLrp4qw0_W5Ca3bTPIj.yAxf37VbMY8i7i3geOVQ3_LawgjwV_kd4iXiloQUVjjjKRwjiizBJqMs
 TrXqi828CJYNDG6bGy05H3Rk8ERRUue.S1l8o67UYfnqan77JJ69Gli5_vUP9m2kCzTUjSZaJUsH
 clzlv9b5uf_zxT64Xnbz_D3AmR1yPxWczFEr0pPG0gR.JZc4F8kRp4sAEDurAmB7tS20Jyp7k1rm
 ry.ebgoe03LJWwpkQdiVrCCsgjZ4Co4BrFy6xq65UOr4fUe2_4WjPxRynRdukuMEsLlpDfsrHMZZ
 WZbZXSPmNHqoBG_nucG2T1kI4_cxrXpkp0xhHklDTSC2l8J2SEmu.RFgjcfKUu2_l5qRks7DD68H
 UMiJnzRJ21LB6E2JrfZTaoEk5ZAfg8q5liHDFiROg4OXk9mxIAqhQlPKWbNOTGWy4NhN4AhLv_Dq
 jKBGsa9oNodOcCKvVcc.g1IfP7WM7usNXFXvI5zmfV.qHJpxYTCeQEq6p5msndL5pcPQJZOiIBNg
 -
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 4b3a3c90-1132-44fb-9f01-0a7369196ddd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Tue, 27 Aug 2024 13:24:12 +0000
Received: by hermes--production-bf1-774ddfff8-fbg4f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 51341f57ae2097c0a506fc1bc62cd8b7;
          Tue, 27 Aug 2024 12:53:50 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Greg KH <gregkh@linuxfoundation.org>, john.ogness@linutronix.de,
 senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
 linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Tue, 27 Aug 2024 08:53:49 -0400
Message-ID: <1877609.QCnGb9OGeP@nerdopolis2>
In-Reply-To: <3085227.687JKscXgg@nerdopolis2>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <ZscNX79dnXUjeTc4@pathway.suse.cz>
 <3085227.687JKscXgg@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Thursday, August 22, 2024 8:49:05 AM EDT nerdopolis wrote:
> On Thursday, August 22, 2024 6:05:19 AM EDT Petr Mladek wrote:
> > On Wed 2024-08-21 13:12:03, nerdopolis wrote:
> > > On Tuesday, August 20, 2024 9:29:36 AM EDT Petr Mladek wrote:
> > > > On Mon 2024-08-19 11:50:39, nerdopolis wrote:
> > > > > On Monday, August 19, 2024 11:09:35 AM EDT Steven Rostedt wrote:
> > > > > > On Sun, 18 Aug 2024 10:30:22 -0400
> > > > > > nerdopolis <bluescreen_avenger@verizon.net> wrote:
> > > > > > 
> > > > > > > On Sunday, August 18, 2024 8:33:25 AM EDT nerdopolis wrote:
> > > > > > > > On Sunday, August 18, 2024 1:12:14 AM EDT Greg KH wrote:  
> > > > > > > > > On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:  
> > > > > > > > > > Hi
> > > > > > > > > > 
> > > > > > > > > > I originally brought this up on linux-serial, but I think it makes more sense
> > > > > > > > > > that it's part of how printk console device selection works. Without VTs, while
> > > > > > > > > > most software is able to handle the situation, some userspace programs expect
> > > > > > > > > > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > > > > > > > > > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > > > > > > > > > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > > > > > > > > > refuses to write log messages to it.
> > > > > > > > > > 
> > > > > > > > > > There doesn't seem to be a mailing list for printk, so I had to use
> > > > > > > > > > get_maintainer.pl. Hopefully this is correct
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > After some grepping and guessing and testing, and playing around Something like
> > > > > > > > > > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > > > > > > > > > index a45d423ad10f..f94a4632aab0 100644
> > > > > > > > > > --- a/drivers/tty/Kconfig
> > > > > > > > > > +++ b/drivers/tty/Kconfig
> > > > > > > > > > @@ -384,9 +384,12 @@ config NULL_TTY
> > > > > > > > > >  
> > > > > > > > > >           In order to use this driver, you should redirect the console to this
> > > > > > > > > >           TTY, or boot the kernel with console=ttynull.
> > > > > > > > > > -
> > > > > > > > > >           If unsure, say N.
> > > > > > > > > >  
> > > > > > > > > > +config NULL_TTY_CONSOLE
> > > > > > > > > > +        bool "Supports /dev/ttynull as a console automatically"
> > > > > > > > > > +        depends on NULL_TTY && !VT_CONSOLE
> > > > > > > > > > +
> > > > > > > > > >  config VCC
> > > > > > > > > >         tristate "Sun Virtual Console Concentrator"
> > > > > > > > > >         depends on SUN_LDOMS
> > > > > > > > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > > > > > > > index dddb15f48d59..c1554a789de8 100644
> > > > > > > > > > --- a/kernel/printk/printk.c
> > > > > > > > > > +++ b/kernel/printk/printk.c
> > > > > > > > > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > > > > > > > > >         initcall_t call;
> > > > > > > > > >         initcall_entry_t *ce;
> > > > > > > > > >  
> > > > > > > > > > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > > > > > > > > > +       if (!strstr(boot_command_line, "console="))
> > > > > > > > > > +               add_preferred_console("ttynull", 0, NULL);
> > > > > > > > > > +#endif
> > > > > > > > > > +
> > > > > > > > > >         /* Setup the default TTY line discipline. */
> > > > > > > > > >         n_tty_init();
> > > > > > > > > >  
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> > > > > > > > > > redundant, it is optional, so that it doesn't cause any changes to
> > > > > > > > > > configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
> > > > > > > > > > and for bootloader configs, it won't change any behavior if the kernel command
> > > > > > > > > > line has a console device specified  
> > > > > > > > > 
> > > > > > > > > What is wrong with just setting the kernel command line for this
> > > > > > > > > instead?
> > > > > > > > >   
> > > > > > > > When they eventually start shipping kernels without VTs, they will then have to
> > > > > > > > include a script in their upgrade process that runs
> > > > > > > > 
> > > > > > > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"nomodeset /g" /etc/default/grub  
> > > > > > > Ugh, I meant
> > > > > > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"console=ttynull /g" /etc/default/grub
> > > > > > > sorry
> > > > > > 
> > > > > > If you can modify the kernel .config for this, can you just update:
> > > > > > 
> > > > > >   CONFIG_CMDLINE_BOOL=y
> > > > > >   CONFIG_CMDLINE="console=ttynull"
> > > > > > 
> > > > > > ?
> > > > > > 
> > > > > That could work, I think. I'll have to see how that works when a different
> > > > > console= is specified on the command line from the bootloader though, I am
> > > > > thinking that if console=ttyS0 is then manually specified by a user, there will
> > > > > be two devices in /proc/consoles (ttyS0 on top of ttynull), but I admit I don't
> > > > > know if there are actual ramifications of that, or not...
> > > > 
> > > > I guess that it would register both consoles in this case.
> > > > 
> > > > > I am not sure if real distributions would want this to be the answer I guess I
> > > > > will have to see if any others are using CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE,
> > > > > although this gives me an idea..
> > > > > 
> > > > > Would something like this below be more acceptable? I didn't test it yet, but
> > > > > just the theory. I am thinking that this could have more use to allow a
> > > > > preferred to be set...
> > > > > 
> > > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > > index dddb15f48d59..c1554a789de8 100644
> > > > > --- a/kernel/printk/printk.c
> > > > > +++ b/kernel/printk/printk.c
> > > > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > > > >  	initcall_t call;
> > > > >  	initcall_entry_t *ce;
> > > > >  
> > > > > +#ifdef CONFIG_DEFAULT_CONSOLE_HINT_BOOL
> > > > > +       if (!strstr(boot_command_line, "console="))
> > > > > +               add_preferred_console(CONFIG_DEFAULT_CONSOLE_HINT, 0, NULL);
> > > > > +#endif
> > > > > +
> > > > >  	/* Setup the default TTY line discipline. */
> > > > >  	n_tty_init();
> > > > 
> > > > This is better. But it does not handle some situations. For example,
> > > > default console might also by defined by:
> > > > 
> > > >    + scpr, see acpi_parse_spcr()
> > > >    + device tree, see of_console_check()
> > > >    + netconsole=, it is hidden in init_netconsole()
> > > > 
> > > > I tried to handle this another way. The "ttynull" console was
> > > > added when /dev/console could not be opened in console_on_rootfs(),
> > > > see the commit 757055ae8dedf5333af17b ("init/console: Use ttynull
> > > > as a fallback when there is no console").
> > > > 
> > > > But it did not work well and we had to revert the change, see
> > > > the commit a91bd6223ecd46addc71ee6f ("Revert "init/console: Use
> > > > ttynull as a fallback when there is no console").
> > > > 
> > > > Another idea:
> > > > 
> > > > 1. We could use the same trick as netconsole. I mean to use:
> > > > 
> > > > 	ttynull_console.flags |= CON_ENABLED;
> > > > 
> > > >    to force register_console() to register the console even
> > > >    when it is not defined in the list of preferred consoles.
> > > > 
> > > >    It is a kind of hack. But it looks cleaner that adding
> > > >    ttynull console into the list of preferred consoles.
> > > > 
> > > > 
> > > > 2. We need to decide whether the fallback to ttynull console
> > > >    is needed as late as possible. It should be done after
> > > >    all other drivers call register_console().
> > > > 
> > > >    I would do it in late_initcall_sync().
> > > > 
> > > > 
> > > > 3. We need to detect when the fallback is needed. The check
> > > >    of /dev/console does not work, see
> > > >    the commit a91bd6223ecd46addc71ee6f ("Revert "init/console: Use
> > > >    ttynull as a fallback when there is no console").
> > > > 
> > > >    A solution might be to check if @console_list is empty.
> > > > 
> > > > 
> > > > Something like (not even compile tested):
> > > > 
> > > > diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> > > > index 6b2f7208b564..7cd7ba2ec33c 100644
> > > > --- a/drivers/tty/ttynull.c
> > > > +++ b/drivers/tty/ttynull.c
> > > > @@ -59,6 +59,16 @@ static struct console ttynull_console = {
> > > >  	.device = ttynull_device,
> > > >  };
> > > >  
> > > > +void __init register_ttynull_console_force(void)
> > > > +{
> > > > +	if (!ttynull_driver)
> > > > +		return;
> > > > +
> > > > +	/* Force registration by setting the CON_ENABLED flag. */
> > > > +	ttynull_console.flags |= CON_ENABLED;
> > > > +	register_console(&ttynull_console);
> > > > +}
> > > > +
> > > >  static int __init ttynull_init(void)
> > > >  {
> > > >  	struct tty_driver *driver;
> > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > index 054c0e7784fd..004612e6fc7f 100644
> > > > --- a/kernel/printk/printk.c
> > > > +++ b/kernel/printk/printk.c
> > > > @@ -3857,6 +3857,25 @@ static int __init printk_late_init(void)
> > > >  }
> > > >  late_initcall(printk_late_init);
> > > >  
> > > > +static int __init console_fallback(void)
> > > > +{
> > > > +	bool need_fallback = false;
> > > > +
> > > > +	console_list_lock();
> > > > +	/*
> > > > +	 * Make sure that there is a console which can be associated
> > > > +	 * with /dev/console
> > > > +	 */
> > > > +	if (hlist_empty(&console_list))
> > > > +		need_fallback = true;
> > > > +
> > > > +	console_list_unlock();
> > > > +
> > > > +	if (need_fallback)
> > > > +		register_ttynull_console_force();
> > > > +}
> > > > +late_initcall_sync(console_fallback);
> > > > +
> > > >  #if defined CONFIG_PRINTK
> > > >  /* If @con is specified, only wait for that console. Otherwise wait for all. */
> > > >  static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
> > > > 
> > > > 
> > > I got it to compile with
> > > 
> > > --- a/include/linux/console.h
> > > +++ b/include/linux/console.h
> > > @@ -513,9 +513,12 @@ extern int braille_register_console(struct console *, int index,
> > >  extern int braille_unregister_console(struct console *);
> > >  #ifdef CONFIG_TTY
> > >  extern void console_sysfs_notify(void);
> > > +extern void register_ttynull_console_force(void);
> > >  #else
> > >  static inline void console_sysfs_notify(void)
> > >  { }
> > > +static inline void register_ttynull_console_force(void)
> > > +{ }
> > >  #endif
> > >  extern bool console_suspend_enabled;
> > >  
> > > and throwing a "return 0;" in console_fallback()
> > > 
> > > Seems like at least on x86 though, when I tested (CONFIG_VT_CONSOLE disabled),
> > > the console is still ttyS0, even if I add "-serial none" to the QEMU VM.
> > > 
> > > 
> > > 
> > > I saw 757055ae8dedf5333af17b, but I feel like the intent is different, if I am
> > > understanding that correctly, which I very well could not be, to me it looks
> > > like it is using ttynull as a _last_ resort when all else fails, but x86 always
> > > seems to have /dev/ttyS0's, unless I make changes before the serial consoles
> > > are used.
> > > 
> > > My concerns are more about the distributions that have had /dev/console work
> > > no matter what because of CONFIG_VT_CONSOLE. isatty() always returns true 
> > > against /dev/console when enabled. When it is disabled, /dev/ttyS0 wins and now
> > > software like systemd that logs there is now at the mercy of how /dev/ttyS0 is
> > > physically connected or not for it to be able to log successfully.
> > 
> > I see. I have misunderstood the original problem.
> > 
> > Hmm, historically, the kernel tries to enable any available console by
> > default. It makes some sense. One would expect that when there is a
> > device than the user should be able to access it and see the messages there.
> > 
> > If I get it correctly, you suggest to do not register serial port
> > when it is not physically connected. It makes some sense.
> > 
> Hmm, now that might work, and is a good idea...
Although now that I think about it, could this cause unintended behavior on
some hardware? Or folks that might plug in the serial cable after booting for
whatever reason?

I still kind of lean to CONFIG_NULL_TTY_CONSOLE, that way if enabled, and in
theory, only distributions that had CONFIG_VT_CONSOLE turned on would turn on
this option. That could allow /dev/console will still work the same way for
user space logging, while disabling vgacon and fbcon.

And it could still be overridden by console=ttyS0, which I think is needed
anyway if you have CONFIG_VT_CONSOLE enabled
> > But I think that this should be implemented on the serial console layer.
> > It should not call register_console() when the port is not connected.
> > 
> > Plus, it would need the above patch which would register
> > ttynull_console driver as the final fallback. Otherwise, /dev/console
> > would not be backed by any device. Or we could update console_device()
> > to return the ttynull_driver as a fallback when there is no console
> > registered.
> > 
> > > One of my _other_ ideas was to in setup_arch() in arch/x86/kernel/setup.c add
> > > the "add_preferred_console("ttynull", 0, NULL);" when CONFIG_NULL_TTY_CONSOLE
> > > is enabled right above where it calls vgacon_register_screen() for this reason.
> > > 
> > > It worked, but it probably was not correct either...
> > 
> > IMHO, this is not acceptable for a generic kernel. The kernel should
> > try show the messages whenever possible. It should not ignore serial
> > consoles when they are available.
> > 
> Makes sense, on many desktop distros, the logging was not going to physical
> hardware because of CONFIG_VT_CONSOLE being enabled, but I understand there are
> many different types of embedded devices though.
> 
> Which is why my first thought was a new CONFIG_NULL_TTY_CONSOLE option that
> would be disabled by default, but when _enabled_ (Trading CONFIG_VT_CONSOLE for
> it), the behaviour could be the same on the serial ports,at least on x86, when it adds ttynull as a preferred console...
> 
> like:
> #if defined(CONFIG_NULL_TTY_CONSOLE)
> 	if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
> 		add_preferred_console("ttynull", 0, NULL);
> #endif
> 
> in arch/x86/kernel/setup.c to mimic I _think_ about where the VT console would
> have been registered, and in the same conditions...
> 
> (this would only work in x86 though...)
> > Also I am sure that the kernel is used on devices which only
> > have a serial console. Such a change would cause regression
> > there.
> > 
> > Best Regards,
> > Petr
> > 
> 
> 





