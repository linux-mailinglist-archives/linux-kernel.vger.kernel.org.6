Return-Path: <linux-kernel+bounces-291030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C753C955C6E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4215EB21051
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781001CA8D;
	Sun, 18 Aug 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="DpWEcVG3"
Received: from sonic306-1.consmr.mail.bf2.yahoo.com (sonic306-1.consmr.mail.bf2.yahoo.com [74.6.132.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F8FC02
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985025; cv=none; b=lVBJd+KcLaDZXp6EyHjycc+q9YkGaASaDNbDalieoLDQd6RE/yIEGH+4VrRI/9xMAdmyNvw+2TZL93C5tlIuReobWFHbxaiAouy7LVD+SQzAaxpw4MXNk+WYf62p7QsC5EA7NWSZh6HlWfIK1ulamT3RmG7NPBN7tfduMpPIvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985025; c=relaxed/simple;
	bh=YvjX9h13MSFn6y67PCCzReqB1YNcwi9+U5cpFFy0Fy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXRJPK+Wt2wl9c3TNCaG9xliULHbT3i1F6K4IE1XPSTJI6u4YWDEfish8/M/EU/6ZD0fKRzlUoTuZ0gmcqifWCu22X1b52tQBR8JYP1w6JFGs3yFJBuXqYpynwf8EgUC5Ez1KyRGtLitkrlFLb9rSwDsBJCsXIHsjpjEXWOVdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=DpWEcVG3; arc=none smtp.client-ip=74.6.132.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1723985016; bh=Q+YWy2pEieJ6Gl11C2xixxmUVq/tjsBdr9nGrVeZXoY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DpWEcVG34SfxfndDsuhojA/cEQa4nOdrmppIOez4hKztA+JDHItSayIv5lY8iUdTmtvN5WO2AQ9zo3FisRIYsrtfeg3yiJ/nGw6RBB6+hn3qVcmCgjHYsDkqAAzhMsKuQAJGMovgbwUUTHnrL00mBCrPVEUIm6lB7qZt9SAL7E8gPb4+b8jM96vCqOzv0xglfcIj5wD9cxh6N+kOTsCOytA2dqWsAX9W//zYV7S8R/vrDrTeimV2KndRPAhv6Pc5wzDrRw+0lWi+eEBkT5VV1ZRf5F5isEJgUVzMbpY4vDnp/W2o/fSAH6VO2eE/vYKjIwTvojU7rMbJ+rKsDGQwlQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723985016; bh=piV0czS32Vm4kMJxCW8xlg7MhAcPaIKHCOEv2F3utRB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UaMxLU1bsv9JuYcgTTdXEvCNDz2uq8nNkN4sTiFZol35WYV02K1yaeEKIJGVw6sNt4WMumXRSBSfIwTx0ID6MuiRYT/0pRejxiss5D1H7uTHm7kEZYBC4VUGb4mY7WLumz+PjoA5OXytztyBp2fWWqq+9AvwPMfXdSveXbnB+K+ml7VINZKpf4pvWdYvC0Gy5KC+1ZAPZJs7rlsZsFAwoc+hpdGCFgOhgq13MY5Kemz556hgwEVlbL07cH/hybvUTSxopXqISdCJLmsLTmz3otcU0aREkVLAqmsn5ivj7j1Qo672LMxyMfhjL1SEqUSxKEq12SEx5qaxwA1YQ3NExA==
X-YMail-OSG: HNMtB4cVM1n83BZN8OUSU.OIxkmntJsxi2oAeXL2Kmr3lqJ3ITEMFZE49JVJBln
 JDolhC19eraXnxPx24kyrDYmJNYxc9tXMDlXV1wKG_Bgqhh3L28ErkozpO042fVTfnscMWrSb_hq
 LaZ0BE8X_yRYzR0N9oGF0GQt0FIdmuXiXadkVRhpvj8DHt9_M4ToFMyIju7hwLqH6MF6eqQIfPT8
 pNmz0Jb2v6jzpEdf3jQjQfrHXlEIqAsSjz90vHSVM7vmaqMs_8vE86MdeVQLfvBT2fs88NwTWgXH
 yjAjeO5PUoWSaT8EjYKF91I_nb1XYlJjHhg3aWHKLp_jIPmiWbzs4jnxr90aZj8y_P.gb5HjNN4S
 .lptKq9Ixsh1Q.9Dp2gu6BouNv6UsRZDg8EjqJhFwf3VlA8Insd.rlj51bQjf6BBacRjw8VGinpo
 L3Ex4iZS2OYszflRf3m.ucaeO5tKR4EwrAy2wk1RQqtmh0nvkHZn7SuX3Yp7eAEJXSHlQC7HczHq
 SBVYCAOlMZvr1v.ok8o_daxnlV.ByE1Fw70.zc3meZtisA89KIWxJphNxhWq3ec7ECYukkLdP3BM
 XoCnulZ2s.1rOkLpl98j1Sx1BF_Id8tuHEs8z6ZHatIxRXe2c3EWCM5vKVwctNR5QKzTLLn7CY_a
 wAWsx._l9y_Ybti3geY3fqfSG3kQUsa9EJhSPyoUYPYEtsnxbVUXF3r3wO2oRSede.cqLaejWNc6
 ay6OyCJE4LyRm30A5b2QfKpIte6hkgbBEtfUu9Y3B4TVa0DEyQIQ9ZSp1du6CABMKPSjcZAYSKFR
 mFLe8hnhLKIFBV86nB.ekzEvAcZ0YrjTW0PGwr9LArKtQJuS4JDBUA7U.ADFHFX3faOXXwI6TXSK
 r9AieuBwBWNxDlsmqx_Du2e0A40gcck9o7YpYxlX8_b5qaod1HFoDBw2jH9.fcP5w7YretnNMCXN
 __BgEVG8XsyUOcwckBcyJk2NQPSOsnT6h1oA9HxZljfJw5zoh91I5cPgzbmA9WgRC1VE76dtUEPr
 z6LcRGcZ8gex3KradDQw15_0ZjGo9oiIb5ltfKsoEvxHLR0_ci2T3JbEKqHpzufLlyiw.nNhQS3M
 U8er_7Ka37o5a7Yaslue7kZpDe6MIrUekjAuu2NzZvfk.Nm1kFuhF9Fo9Q4FBGlCn6JgRsqQwy9w
 jCA5nZJZHVzb3IpYRoJiYoNa0LC.P.gSBhG4yX8vyGSupkbmJdZaqaitXxTlqEdoNGztjCP7hJ0A
 TWCL8IApcu9eomub_IkOkO12gAkWsnEHkPC0U5WOMbzOSsEW39l3l6ON.23rk5uyzvEuWI3Qb_iy
 YGvEHYAhca1DyEhiig_oM4KAXY3nGPxucivhGQtIhvF9l2mY.XTlW7.zInTDsUGkj.n6S2cyFoUD
 FxbpkJqzD8CO5sLkJ85E_o2vuOSdMI7BP23z.pUKFc4bjs.NBaXWpeMnTZOwVy3nH8ium70ZOT_X
 IqJjmdw1t0ldQOgep_yf5Zt9j1qaH7WHMkBH8_2rM46Tr16xtVDpA4tUhRinQ8gGwkTkm7H_k.F3
 POHrk9eWnUrS8sjuXNDvplijk37O0uC2nIB04NF1dCZQ_S8f_8r4liqqffnJYensKB2qvTpecNk0
 0s1M6kOFN63fvYx1WAxdHr3WsvqIdVWObZ5UTHjvurBFQRtav4tIfiwTOyrl387tPQz6FhrWOR8d
 j9BlYEBG6g4C8Bhkc3iZGPjHuMgvzXmHSMw6rBAA_iOv.TmRWuACiEkMX2XOL7UOtunHx3zzmwry
 DDc6Vmf.LEPmQcDfwxcbb8qq9Q9iUZm9hS0S6Kn4o_IAoC6wKmu6lN7mrr2LcuwJN5yrYYU_hzAA
 AZqMCpI0tZz6AabUFPWMZerjgfNAY6BJ5hVorseckzf_yEGFyDM7Y1Ll1I73iVuYqmqkY5_zzgsR
 JnTGw1Qya7_zUiYuZ5SOO8l0kcYOhiIDXlED32ls.3_Qbj_GUhzswQw2zM6UXLK6a4wNzqWTpFZl
 QFLg8Un_AFgbkTb4VDldqhNgarsd40G6RBPynj3SFy2VeUtIMdtOrM1mhuavN5eiKkY2tqBXp_SV
 p7Y2bdTCe.R0V_hGybUS8IN4BDZoNs08LxUAvwZGRAlmjHOjYsVhzA1pvnO.43QkY1m69NL4UqAc
 EEqozhylk1ZeR2KiAsCn0Nm0gkIVbHz7uUUXkfGqD2ima4qFYh8ZhugppeTKDEkQRLsWkKsxGdPc
 Ug9hd9WSI7_n1aVT9cQfU7MDhvPGXrqhmnnMEC2cS9t14LdmlBP6dnfMw.BOa8Wpcobw0eNKAqo_
 aYMQ-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 9ba7bfd7-29c2-42ed-bd18-5c7fb4404d52
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sun, 18 Aug 2024 12:43:36 +0000
Received: by hermes--production-bf1-774ddfff8-fbg4f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1a89d488c5bb3c00bce097f72ac87ca7;
          Sun, 18 Aug 2024 12:33:25 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
 senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
 linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Sun, 18 Aug 2024 08:33:25 -0400
Message-ID: <3669532.hdfAi7Kttb@nerdopolis2>
In-Reply-To: <2024081824-leggings-omission-562a@gregkh>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <2669238.7s5MMGUR32@nerdopolis2>
 <2024081824-leggings-omission-562a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Sunday, August 18, 2024 1:12:14 AM EDT Greg KH wrote:
> On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:
> > Hi
> > 
> > I originally brought this up on linux-serial, but I think it makes more sense
> > that it's part of how printk console device selection works. Without VTs, while
> > most software is able to handle the situation, some userspace programs expect
> > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > refuses to write log messages to it.
> > 
> > There doesn't seem to be a mailing list for printk, so I had to use
> > get_maintainer.pl. Hopefully this is correct
> > 
> > 
> > After some grepping and guessing and testing, and playing around Something like
> > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > index a45d423ad10f..f94a4632aab0 100644
> > --- a/drivers/tty/Kconfig
> > +++ b/drivers/tty/Kconfig
> > @@ -384,9 +384,12 @@ config NULL_TTY
> >  
> >           In order to use this driver, you should redirect the console to this
> >           TTY, or boot the kernel with console=ttynull.
> > -
> >           If unsure, say N.
> >  
> > +config NULL_TTY_CONSOLE
> > +        bool "Supports /dev/ttynull as a console automatically"
> > +        depends on NULL_TTY && !VT_CONSOLE
> > +
> >  config VCC
> >         tristate "Sun Virtual Console Concentrator"
> >         depends on SUN_LDOMS
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index dddb15f48d59..c1554a789de8 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> >         initcall_t call;
> >         initcall_entry_t *ce;
> >  
> > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > +       if (!strstr(boot_command_line, "console="))
> > +               add_preferred_console("ttynull", 0, NULL);
> > +#endif
> > +
> >         /* Setup the default TTY line discipline. */
> >         n_tty_init();
> >  
> > 
> > 
> > 
> > seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> > redundant, it is optional, so that it doesn't cause any changes to
> > configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
> > and for bootloader configs, it won't change any behavior if the kernel command
> > line has a console device specified
> 
> What is wrong with just setting the kernel command line for this
> instead?
> 
When they eventually start shipping kernels without VTs, they will then have to
include a script in their upgrade process that runs

sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"nomodeset /g" /etc/default/grub

(Assuming they are using Grub)
> thanks,
> 
> greg k-h
> 





