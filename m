Return-Path: <linux-kernel+bounces-292470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E613956FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0411C22BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31FC16C84F;
	Mon, 19 Aug 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="JEjbd0CK"
Received: from sonic316-11.consmr.mail.bf2.yahoo.com (sonic316-11.consmr.mail.bf2.yahoo.com [74.6.130.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A313B7A6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083867; cv=none; b=PVUGFS8RWj87MxiH8NomRRh4u1Apc2qZZ/6iCJzRk68RYCX292LzfASd3IldyQ9QWtT8EvUTR1NwP3s7yZia+jPgyfBfRd0dCyMABYQnVoVFTFn6ss0wCK0uSvx1b6ApdFix3lkOoylkbEMZ/hiGEPi4cZ6OiCv8fIs0sl0a8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083867; c=relaxed/simple;
	bh=/DY40toFAIyNyal/saIXH31D2DArcM7HRNbtXTQHM8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzZtLUR7tpNDbRJPgsFQAa/mf7NBmZ/yMeh3yti3rdVcR9rIrUSH3zgVMbqDc6XhjTxna+QH66+cQif2b8WVzsS+lhFXiF+3OSZGjQxmSOQc0JAnJ+xboKXO9ZBATd1jd0gg4BNBhLM4liW5woxksh2eGyqcIYLOdwjqGgDM13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=JEjbd0CK; arc=none smtp.client-ip=74.6.130.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1724083859; bh=IMZu0AJ47ymShNMsoaZphHY0NkdGK3m/PKOv4iUVJtY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JEjbd0CKiq2RBUUYRqscJNScl2/MhEY6da+B+2EsY1K8i4CKcliagoS7rvpd0lFg19HRscQequ0RCpt5FZPSUJVkW9TNpPFOXkN2evoaFeUl9U2QEz7n/l+EQ2TqCPlAxz5GTNJ4Wq5X/fKsESFKEPMpMucNdXthsXjUpiIEiSvYaZmvwSYeZmOPKwlE51bhom0Rde+LifCxUSj6+zSa3xdfMbcVtQVOAOz7RqK+WuCgcrIoryahpCiiIzgK9QvJBAVyO90MLlOW8IohUugg14zXySCutARdl4wQGrLfFkS4wMtHvxTeycwGyrXlJxLG7czBwopLtzcovz6L2DySlA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724083859; bh=zmFKLZxqg9N9Z98+ILL8ROxSD6UPd0KEdDSRUnrZKTl=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Cu2JRIW3508Y2TAHKM3VcM90a9Zq6l+4WTLNa4B8sxVLWHF5HAO8amLpXJ4btlYb/dPFC7Qi2b2WQBPNp5VzgiN1YKmXy0NZva+yljWwtpSRj+BgPFOoepkEBb84ZyVc0Gz0feHqZrSPME2IHpgpcrinw54aG5l8qaTBNykb0we11rH5ZjTa+0k1fkG00NLibQ3TmIaR8FtvXTouzoV0EUoEDIm5k8ulzSA+TZIcFxyXgXRNprqyvuH5UbKsGyFHtvQf1bu5thkLzPPNj2sKcGTT47eliLdQbP/QSDlYYy1WkMZuo4gbZ0UtZGHhPN5wkEhmKBcP2IvKwr8RXMs6JQ==
X-YMail-OSG: 3A83i0sVM1kETrAChdm53bIWHc64g3dMa0Fl1pUviQN9Ospjldo5lO7eg4MhSFA
 i2CG6srASpBGGiUMiKGrQOiozT2gTeRV5vgq_t4UC0cKJbfZImXoufr6nPcoNgk37AklbOZQ0TV9
 R3WhL9YEL0OLzi82Nqzq3BmIpq7TJeI0TlM0ihq62eRIh.g0NK_fGHCBZg1hHaSOiKYdxkuM7bR4
 iNjxU6xjF9mSeQlOXL.dpTk2H5xlg3OWZvnrR0_achMbQyc1V4uHwwBdfP1sbzjn89gbCHzZaKgi
 rmTgHogxj7BcgLDJdB4hSLeS_xlhuDihTp6pfq.61nTSIF8oQ8bu10txIxXRKz7VTYpP6J21piuP
 ZqhocLBMbR0JIrPVQ0vMbWuIz1qfLumJDstCpn3D0IP0FXV02lo228XmcdAUQvmrUfh0YdL4QAlv
 sQtWOqa_vsLl6BcboghFZi2jLRw1e5RilXag3Y83BkFck9Va2rdaAegIRPQyduM_YgpVRVJZfqkh
 xzzNceH96omGiq1Zas56KCdmKQNW.hvuUxm2H2.7XDcVdT67x.tIqfs4QJnDplOFdgUgzKsKzui0
 TP0oqhgTdLPeF93lwtAogUnYzHXI1BhpwlssyblWcESKNkas0BH60M8MPF_B0uZBjqBU7UyZeluE
 6izxo52NfCx1N2IZ80MHzGHCE4Znr6ukc0v3fNUtsp2IiHbELzczfUGasmRnDitM6FCJ0e0rVeKz
 j_Bkte.UEYIDqDWKJLLrdNyz6dlS6iCJrhkItsHfxUQf9K5U.jctE4RltXBfeJlJKy4xrfktcMfF
 c.3J50kbJ1pwmjjc.8Ebvx2RU1WgupZE2HoLp2SyXC27HxPfs41Wgjn1DpRmN0HEWJCsexDLAJ2k
 dBzXiNtpduJqtCEO9Pm7no9ji0hYTnKnqCaW6iBaI2bJx11xgSiv1nYLLZXfSXdorTZ1EqGenI.U
 7tqA4TYM6Buubq5ii_0bUF77dkQWB46UF6xlFMYOM4WgbH.DdowjN3wt00_dn0MJJPSrWFq1uUN3
 GZ4TA8b74vGk.MFt5g.y.FsYgnPYh0ucRW0NAJmeh7kajXBCVZ0JSJ3fBILCbwkvFufSaqMOir_e
 3t515cGOJNHcUJm4tv623IHpYow8ZAYWQMKUEMofkQP0wvgw0yce8FYYuf9NYnuInlqxNZq7Gev0
 A2X7fB_CFJc4L6Q3AWL93gyYQknTnq_k_NX4JLCYpOkIbjo7erHDTTt.heIh9aNMwRtHlElyveIZ
 bMARlviC0YyKlD_fz5W528lW6KrvvpNUs4D.AxqMuiAzvDYusKJIucgoXtuTxOdPoBNEyEH7Vu2o
 L9kqBGy6iGraSTkUvJBkX6tDGukH2l48.5AtnDiHypIFNTvQzc18WxooFlKvmevnTIP4ZQUmh9HL
 hDrolUoQOl_yumWsGWi6rUQntaVakDN553ZazUTDgbrUbnuXY_31uzncudkS0G4yv4AHUyK.VKlh
 FDePoJ5VVA08TMpqB3HN9SZQ425ocvjxaqrY3UwRBH17aY04RNgEWXtWnUcYwk3g8JVzuCFRefxs
 UelU2VUUkCap8HaYMys3wWuUxBiqfAbK1ESctBQig6RxlZ.Yr443nE3jcP_9_sW0oR93e8oZaUp1
 q8z5FqRyYSKGaFjV.lPgpBhqBtb1NKhNhRLTKOAWF_e8Oh2IkkqHC7kpCSBO9e_xWcBqGir6D3fR
 HPJuCeo3SIEa8iolako6mqNbNkn89D3biMiMluW3Ydfjr9iAGc6T_qR21.uY7hovj6zWWYAyzTq3
 TOG4jHcTK6aDWIGg.cUg9JtuBNZEtaygPHHj5.BqIr12L8M9lslih6Mdc45M4IB1_foCyH_jXO1Z
 EzYIoBsYUeeUEC6kOnwyyIKacRoSHhB47ctNW1i8mlboVwpmWKqY4jVl4yT6O9Z1z61KKtNBgDIJ
 5mNTC0CuHDErmAKkV8EqunuG4dK65XP0Hz7nw5NmGZNL0ehtwfOiy.xIa0cFs8UhxoO9cPbtJFAA
 GdduuDRsw1VxZc7s6dJjoCeStZU5_oDiyhupG2E5YsYvFlPR7qcgMf7zkX2tGml7gXdyoSo8tvR3
 wmn13O_Qe3rzkeCnDkZBmdWZHaHDtcPuOmmHJadx6RiKB4_IbvCp3tH4uon.wTWFhfFXcN9lrHZE
 0tF6Z5GRkq9Y4rbUFmDgAzLUrkJyCFTUd.T_iPt9LctPD6FxsABA.E9WD_VH2buJtS2U2VRCOmA1
 hrHOAnml1LhSrjqAtZik46DVZ1JASy92y1LXDQRN5ry7claVpdneEDUsn7nlTeaxT8aRiZN5w8CF
 iLsOgXv4-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 248b080d-cd08-4e85-9936-b9e8ad514f7b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Mon, 19 Aug 2024 16:10:59 +0000
Received: by hermes--production-bf1-774ddfff8-ljmrg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa466634f5437c8e572496e3ec7ec527;
          Mon, 19 Aug 2024 15:50:40 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, pmladek@suse.com,
 john.ogness@linutronix.de, senozhatsky@chromium.org, tglx@linutronix.de,
 tony@atomide.com, linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Mon, 19 Aug 2024 11:50:39 -0400
Message-ID: <2719346.q0ZmV6gNhb@nerdopolis2>
In-Reply-To: <20240819110935.2a7c6241@gandalf.local.home>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <1947584.IobQ9Gjlxr@nerdopolis2>
 <20240819110935.2a7c6241@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Monday, August 19, 2024 11:09:35 AM EDT Steven Rostedt wrote:
> On Sun, 18 Aug 2024 10:30:22 -0400
> nerdopolis <bluescreen_avenger@verizon.net> wrote:
> 
> > On Sunday, August 18, 2024 8:33:25 AM EDT nerdopolis wrote:
> > > On Sunday, August 18, 2024 1:12:14 AM EDT Greg KH wrote:  
> > > > On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:  
> > > > > Hi
> > > > > 
> > > > > I originally brought this up on linux-serial, but I think it makes more sense
> > > > > that it's part of how printk console device selection works. Without VTs, while
> > > > > most software is able to handle the situation, some userspace programs expect
> > > > > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > > > > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > > > > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > > > > refuses to write log messages to it.
> > > > > 
> > > > > There doesn't seem to be a mailing list for printk, so I had to use
> > > > > get_maintainer.pl. Hopefully this is correct
> > > > > 
> > > > > 
> > > > > After some grepping and guessing and testing, and playing around Something like
> > > > > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > > > > index a45d423ad10f..f94a4632aab0 100644
> > > > > --- a/drivers/tty/Kconfig
> > > > > +++ b/drivers/tty/Kconfig
> > > > > @@ -384,9 +384,12 @@ config NULL_TTY
> > > > >  
> > > > >           In order to use this driver, you should redirect the console to this
> > > > >           TTY, or boot the kernel with console=ttynull.
> > > > > -
> > > > >           If unsure, say N.
> > > > >  
> > > > > +config NULL_TTY_CONSOLE
> > > > > +        bool "Supports /dev/ttynull as a console automatically"
> > > > > +        depends on NULL_TTY && !VT_CONSOLE
> > > > > +
> > > > >  config VCC
> > > > >         tristate "Sun Virtual Console Concentrator"
> > > > >         depends on SUN_LDOMS
> > > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > > index dddb15f48d59..c1554a789de8 100644
> > > > > --- a/kernel/printk/printk.c
> > > > > +++ b/kernel/printk/printk.c
> > > > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > > > >         initcall_t call;
> > > > >         initcall_entry_t *ce;
> > > > >  
> > > > > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > > > > +       if (!strstr(boot_command_line, "console="))
> > > > > +               add_preferred_console("ttynull", 0, NULL);
> > > > > +#endif
> > > > > +
> > > > >         /* Setup the default TTY line discipline. */
> > > > >         n_tty_init();
> > > > >  
> > > > > 
> > > > > 
> > > > > 
> > > > > seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> > > > > redundant, it is optional, so that it doesn't cause any changes to
> > > > > configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
> > > > > and for bootloader configs, it won't change any behavior if the kernel command
> > > > > line has a console device specified  
> > > > 
> > > > What is wrong with just setting the kernel command line for this
> > > > instead?
> > > >   
> > > When they eventually start shipping kernels without VTs, they will then have to
> > > include a script in their upgrade process that runs
> > > 
> > > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"nomodeset /g" /etc/default/grub  
> > Ugh, I meant
> > sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"console=ttynull /g" /etc/default/grub
> > sorry
> 
> If you can modify the kernel .config for this, can you just update:
> 
>   CONFIG_CMDLINE_BOOL=y
>   CONFIG_CMDLINE="console=ttynull"
> 
> ?
> 
That could work, I think. I'll have to see how that works when a different
console= is specified on the command line from the bootloader though, I am
thinking that if console=ttyS0 is then manually specified by a user, there will
be two devices in /proc/consoles (ttyS0 on top of ttynull), but I admit I don't
know if there are actual ramifications of that, or not...


I am not sure if real distributions would want this to be the answer I guess I
will have to see if any others are using CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE,
although this gives me an idea..

Would something like this below be more acceptable? I didn't test it yet, but
just the theory. I am thinking that this could have more use to allow a
preferred to be set...

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dddb15f48d59..c1554a789de8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3712,6 +3712,11 @@ void __init console_init(void)
 	initcall_t call;
 	initcall_entry_t *ce;
 
+#ifdef CONFIG_DEFAULT_CONSOLE_HINT_BOOL
+       if (!strstr(boot_command_line, "console="))
+               add_preferred_console(CONFIG_DEFAULT_CONSOLE_HINT, 0, NULL);
+#endif
+
 	/* Setup the default TTY line discipline. */
 	n_tty_init();
 

> There's also bootconfig, that allows you to append command lines to the
> kernel image. See CONFIG_BOOT_CONFIG and Documentation/admin-guide/bootconfig.rst
> 
> -- Steve
> 





