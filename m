Return-Path: <linux-kernel+bounces-290892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF5F955AA1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 05:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93C0281FC3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 03:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115628462;
	Sun, 18 Aug 2024 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="J0swKFXx"
Received: from sonic306-3.consmr.mail.bf2.yahoo.com (sonic306-3.consmr.mail.bf2.yahoo.com [74.6.132.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973772F4A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723950108; cv=none; b=uwxl27WVJa0KDPN5/DaItE+owpV6YU17tNcCTcvlx2Y/lSVKywc5VqV9rjag/Jm22xiK0523NsaUM2lIlpd4VvbCGWKkwBxitDfwDdxo7i6JqZHGNmhg2vzirMQ7WIWRSZ59QEd2I4kI3pSYDu5CnuaPUKfC9gOKdUiAAggHC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723950108; c=relaxed/simple;
	bh=pefWDtn/Qgu0dqvuBECjV9PIolo4DJVaV2tgAsabPgk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAe9WEb55dYPfT6QgDYZ/ewPolc+YtF7YuyXXccBGg1b8xDSn00P8FuX9xd4GmY317oJKz8ScIPIzOeUk0GpQGaeyOCHM473NdzcHpzZfxL4l/xLz2ZC/WhG+QDIpNiXZnYzjkKNHkFEO9Xsh4PA1sGREdavBoeWAhSnlomQryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=J0swKFXx; arc=none smtp.client-ip=74.6.132.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1723950104; bh=csABxt0Ml9L8oCwYoV45e724JMxOZGHrhhNFhMulxsY=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=J0swKFXxBrZq/62mg2rpe41SfzPOCIxoxR/uqRNASZqAzvy2bYD5HrIex+VcFgwDxC6C3QFuOZWTjK7npD0YXxFIt+qJtkE8HOTnsyg02RDtjsgif+LPWRg0W5UB2BNJLpBKIo23TfElrycqoese4s+vOdUsLdS+ljEg42jMe2u98uHtTX2z03pp613IWIsD3SUYpo2QKAgrTcDmNmyWDpJu3ea1SuotsQ924/XruYirULSxuXJR1a2gsl//vW9mK5J0YlMkUhVIW2+KjD5HqTBbTVCOxGkF+mVuD8t6IldedaxMlnF4ReF2ZIyHtGsnbSy+v2tQBLySaZbc9nBl7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723950104; bh=hdLcKlBdNnm2aN9/gzZKjx9/EPM0b44/ItQwESHttuh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aWeDaC9lRVik/KNK1MG2fIRp7l5AS6WegXxpzbb3oIGw/DT7j0VXT54nKzZ5aJNW3s7FfdnKmZKCcM2T+8e4/nsxkaENq37h8E37er8s6FBU6x5UT6TFZJ+YE4c1HTrYfYQ488WQkPjq8ToOW4AWbNTWFWhBVjLM6MFB3kpzukY9gxCgskPgKDEbXFt0btkWG4juqyvRMbF5eQTBpcncV3lnMNyyRvXPG7cJTZKPRNdQ5+pD3ZyPfd4cdfu2kQY7SxnK0oAV9WHRQ59OldurdhU6r977cUfmWrQmQQm22U9LNlLPmfxYEfp3yXK2CktBLRBkRUYxWQeOfSmp0vUicg==
X-YMail-OSG: dtsh1O4VM1ntZ2.yaarebRgIH50uhtWAdgtMSrtgr15Yh4a2l79C1RUrd8wga4q
 I1fwl1xUMXkocwfz.eMUElF4B1BAOy.1XGd4daNfj3B1p8daPMVjBnxywxSyCIpRjwNLs2OJL00E
 Dio3JR87cq47OmNSWWft5eIGAS7T9Wkyi81qd3lSibPOICRTkn6kCjluTtPB5xk1PJHkRDtaHBVP
 ZVUd1D5gd.tQ2g0v1YUkgsC6LexelTyAh8BpPuYMq4qFg2dPHQGzA..jgviBrJFfOv1NuAKMtfyC
 EbhVD526Iwg3BwCVVZt2Tj3bxQ_PslOoIfrybf4mkhmJz.ytJK713Hwj1aDIIVLpI6_04Ues7sn1
 Cfj615iJJ.Qb3Ze02rRKlytqiNdwpc1PgkErghESf0Lf_TZ6b5oaA6.5onCxpyGFkVPNoOFclmvP
 wt3hWCPytw8HdWS1TP4Wr34c.X11UCcYPHE7sX4tZjoU8izY2mRM0FUYqhUtlGWndjyxrvStzf7A
 5YGyVh2dKosRGSI025C5oGKpTGEFegLroKffHDEN6h0nYgXHkCHqpyL5NFIMWcKvG8UhwoCfzBIf
 Leo.IBocygUIwsb2du.1Vsc.RUe1KPhpQaY4sT6Y1lzbK_AZt7ZALc4ZR_aZSzDofQLvO0hOjSEk
 Mj1R1r1pKshEBlc4y8sjs99BFEAvcHUi_SV10pPMxmi4QxlvZyvJSctOu4Zzi5sPJ2xAUo348mVk
 VdWO4MCXbOgn1V_0LJ107zwtjNeZkkg4dzsK8kR.G4eU0CzKcwqGjsvr7XWuXZPAFzxT5vpWi6yP
 mnDAE5.FypJRtoSoMlCxGX3CrUjcO_Is2M5TR61AtxuOs4.GAxklBd5iV.LBDiRpPBARyYJMt8kW
 9PUbirbU2gFA.eBuCIl2YiDysQe8fanNhRgVeH2vsVq9U2Zw8mLLi7qVluqcb4M7j1SLIo1YwOqg
 urUYF3YRakN4oLynC_flpvZoc0aEM9whJvI7pU_rqmBUtWv6PCOn82ozAG7_Ps2DzxTX4UJv0585
 VkcdIQRH7SCo30x0X9SY1WFPsRBjmtZqq3nQcCJLrs7SGOco9QqDwwUUxL4Zb4fcSJHxOxZILl11
 7kPIbn_TRpYSie5PQxpIGANB0KV0BqRjTdpeh82V34kURrbThZpSlrZwciqjiBb8TBEvuvGm62kQ
 DFnr8jH9hQymZgct5hWUQgJYVPijQDErJeJueNKrtlSXebZ3WwC9nmeP71JOkxvkXJrH8lC_ihv1
 Nq3x.irLjNxMlwq0eCISgOxFRCyA.4Izy69zXNgoAarQBDh3HAA0m3KafyI4tTzhRBpVdBBiASmm
 G880RGKz91gvGhwTGYQ6Ml_XPRJMnbwMvgPJJgLC.GkZXZL88WNqb.1.wgJHpgE5bv3c3oc5DAQ5
 T8RF2bZTkgMlVsOPs5wNkVwVoIWT8lpeFy2z97VVz2E_DDsoi.XdvRXXz0qODXcXE9XOOpCgpkFA
 NCwPz8p10Agrs7UvToemsidy5iOUbfrslYKha9K0kCE3AYZ6_J1IYh64waLx7qKqeyyenwPI2tk_
 xGo8AnoobaEmfeziN9yl7L6SZkYknGopW1eiGCFxIlbo_v9NwZ52oonbTND74kCByG6Vqv5bkRDS
 gGi_o2TX3DJ052OEm0pbxfoZSMlnmzLJU.qfPaRYaNP9vMtwyfzP2Gj570_E8fhf.5Kyb1pym4Ud
 FO15cdVmiLZcX7_h0UXhvP_ykTBvjlg9NcG3IIbSi00tnaBfyFPhj2Nc4MY6RxqU1gNVsb61aBZg
 4MOLHfx5TUpE4OOdEcIq2IGOrYa2O9AZQKoulloucozn88LEZLodQErx_KnTMi9hBgtPXV7RmbPL
 wKpi5w4JwoqxwkxF571XZ8Vlm7XS_dXhRJd2JzQ12JMFKskrcZRPS6y3OZJq3ZpxC0P7WL6yQy5z
 9iz1.0u12BCqqgqefw7_ObGSq.N9ZnZKl_8ahVSlAwd8ihWHlaR3cVJkRzkpdSuLxwjBzuH2EPuh
 AUfuD.Yf1Ib_qPqYrQNkloSTwE.b2NmTNhDlFikR3nKNaxbt1bqH_IhckhkkuVbMywSKlDQQ9Dch
 MC2MCerqMRimoalxJ_2W5JLHcq9Y3J_wuuHLUwYsK.VchvVKTXi4HaLrn0jI8cqg_AcT1uYonDuZ
 _PnLi6IkvOmdXVYUvuyBi_Skdpr7SGnqKK78kiCA7g3gHQO_uXjPMmPfyIYHIuhc3wsQ2CTYYJ4m
 1gPQQIqjR9SWhK_xg4RrrwKm3Ahxc5b2GsVEE0hdv.BxyQzvnuDZloSpNvKotFG_FpkY_2wmzNTa
 oYAJzBg--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 8c95c488-5162-4374-a68f-777d75914cae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sun, 18 Aug 2024 03:01:44 +0000
Received: by hermes--production-bf1-774ddfff8-6qj8v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 05b06a6c732c06a93da2b1be5fd217cc;
          Sun, 18 Aug 2024 02:31:18 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
 senozhatsky@chromium.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
 tony@atomide.com, linux-kernel@vger.kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Sat, 17 Aug 2024 22:31:17 -0400
Message-ID: <4805768.rnE6jSC6OK@nerdopolis2>
In-Reply-To: <ZsFJSYI3EVjC8p5W@archie.me>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <2669238.7s5MMGUR32@nerdopolis2>
 <ZsFJSYI3EVjC8p5W@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Saturday, August 17, 2024 9:07:21 PM EDT Bagas Sanjaya wrote:
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
> > 
> > With ttynull as the console device, isatty() no longer fails on /dev/console,
> > systemd writes the log messages fine to /dev/console, and when Plymouth calls
> > TIOCCONS on its PTY, it is able to get the log messages.
> 
> Then what does /dev/ttynull do other than just to satisfy systemd? I expect
> it to be like /dev/null, though.
> 
> Confused...
> 
> 
/dev/ttynull is the fake tty device that was added in ~2019, I guess it's kind
of like /dev/null, but certain terminal related IOCTLs work against it too,
like TCGETS, which is the probe isatty() uses.

https://lore.kernel.org/all/20190403113327.3628-1-vincent.whitchurch@axis.com/
the original thread for the addition of the ttynull driver explains it better
than I can.

The issue came up here https://github.com/systemd/systemd/pull/33690 before I
knew about the existence of this driver. I was getting the nice status messages
from systemd appearing on Plymouth when the QEMU had a virtual console attached
to /dev/ttyS0, but on real hardware, I was not seeing these status messages.


The thought is that when distributions eventually decide to go VT-less they are
not going to want to change the kernel boot options in the bootloader config to
force console=ttynull, and might want this to happen automatically.




