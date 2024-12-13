Return-Path: <linux-kernel+bounces-444832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095089F0D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7971889BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA1C1E00BF;
	Fri, 13 Dec 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PwCmUpYZ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88981DF268
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095850; cv=none; b=VYKQK/fvWQeb9VaSx9fE4ZX9xhDydTnhWCJ97Ct4j8WJdyx2Vq9X5UoxnZE/ezcy0gP1PvnR7UD4u7KMSrkFOr6aeZRFtfLIGIkpu6CCUau0qjVYkUaPUzZd1VdAITFSkjzzRqgGfn5/cNsHFrqa7NKqHZbS+49J1+43GsxK5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095850; c=relaxed/simple;
	bh=jzXamyCacjql8seUWwmQyq+hh31ewDVu3Uztr4N6UDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doY/xqqwWCGW32yTG4NFdRpSoBIafEEzyeyewjEqCVnjBYgyy+uLfXU/5PanuZnWhMDRuPUCifg82WCQtbzXDHcN8hQAhN2sPGWZhdLFKphWWD4gjSIhWNymrs5hYOj36KccaFhaz4TTrKg3DgNTvLMxRkEie5UmB6fCD7+tPFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PwCmUpYZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3023c51146cso17104061fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734095846; x=1734700646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgfxhiEwi1cxcUkP5/sckSbEkt4/qnqpeXa6lzm7zoQ=;
        b=PwCmUpYZplBNRx8pdLNV/3YCd3gyb1OKfl/UBixOOGPaR5kDM/8kU4JUNNqGVSGK8J
         yfMQ6ktiik7buoVh2sD8BwT2wyOuGueTRXLegSntrMnFDqFnpyb8SLxbMwNow839cxho
         GvjWWe7v1EQDew3wT02e0p5UNj2NWBnQIojYTsQfQSYtuiCZMOOoguUiwIyr7MWUfvKL
         xSNS9vTxuZowH5H8CkrUvAVtToz2ZrRRRYonzlaRShtZaQgrD5l4EFsmV7Y9WiMJqmMy
         27x0uB3i9BYGp9WCjxke5Mou4GlLcW1c4WP/cDG76w589Jz6lP6XD1exTTDIGvwZ/GKB
         9LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095846; x=1734700646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgfxhiEwi1cxcUkP5/sckSbEkt4/qnqpeXa6lzm7zoQ=;
        b=wN42MjDnjvh2f1ooUI3rHUcEcrcSijvHPLg0FCWfZQO+4uEb443hl8vAG66GdbjKh+
         VD5+Vdb6n2Pmpcx8uLoY9r51byJqUcS5yelCh0rWalO4rGcb1OICs/EalBr9B+9rMcv2
         hzjjM86w6YTftsDxcqbaNtxNeW916+M2hPvEvfJvlsztZKrjpbIP//1BwnD7olPCq1FD
         L8Ohi4BELcXdnCdVsUuUz0n5H3aSOfswSrITTSTkO1ja7ijlVLaFMQmj0EjedP+yjigD
         34A+ToDifooftriYlP9Uf73kD7smN6l4/dTtZIbEpNxWE64ZibesLKSkLCPnaPvZvd/F
         FOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1H7LkuRRgo5XsVNV/oWOsLC7PCJmY4nLg/TiZOfXExvVe5okZO0rcIwN+EgeVYkXLUv787CWkqw9KFgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyR0+fK4ONyRfkVGDfENpCj+TwUzWLruFw/Gf5pJx88ZpFoIAy
	Vc6NVk9BX0BIYUpxsD3mk2wGnu/PHkWlHKvQW0k27oMn/8rFAREzJ8MIQQQ82Le3A7eHD5zj0PG
	XYXwK1nfoVQCoZqLQZ8b0cgDe/o/vLyfljt26Yw==
X-Gm-Gg: ASbGnctExeW7t5dZ5mSVE7B9MpJA1+J1BPmPiwGCzrJUuARzfmzmrC24Lumg7FvOjh4
	gH9Z9DYpdgkATGa5RDfaSz61+koV78CpCLniJnIffnpTocNzXYk3BEj3u4tCREKPfCdbHoQ==
X-Google-Smtp-Source: AGHT+IFD+cWs2BeD+CZKF6WLjrcPv8hv1W4g0yJ0jXtSvC4zMCMbE1iMhIopREMmzZUrLgp/+/KFKlgUS1yUXRhrU0U=
X-Received: by 2002:a2e:a99f:0:b0:300:17a3:7af9 with SMTP id
 38308e7fff4ca-302a9e8d0e3mr8398931fa.19.1734095844123; Fri, 13 Dec 2024
 05:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203164143.29852-1-brgl@bgdev.pl> <20241203164143.29852-2-brgl@bgdev.pl>
 <a21531a7-13ae-45f5-a60d-dd80b3ef9834@gmail.com> <0bf97a477f1c547b960c63607395b82d92986ef3.camel@siemens.com>
In-Reply-To: <0bf97a477f1c547b960c63607395b82d92986ef3.camel@siemens.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 13 Dec 2024 14:17:13 +0100
Message-ID: <CAMRc=Mf-2=eiwNdx=5n8a3Bm7-gKPeVRGiPzXJPsqzgxtem6yQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: omap: save two lines by using devm_clk_get_prepared()
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>, "ssantosh@kernel.org" <ssantosh@kernel.org>, 
	"khilman@kernel.org" <khilman@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, 
	"bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 1:29=E2=80=AFPM Sverdlin, Alexander
<alexander.sverdlin@siemens.com> wrote:
>
> Hey Matti, how are you?
>
> On Fri, 2024-12-13 at 14:16 +0200, Matti Vaittinen wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > We can drop the else branch if we get the clock already prepared usin=
g
> > > the relevant helper.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> >
> > Booting a beaglebone black with the linux-next from Today fails
> > (next-20241213). Enabling earlycon + debug yields below splat to be
> > printed to the console:
> >
> > [    2.628019] ------------[ cut here ]------------
> > [    2.632793] WARNING: CPU: 0 PID: 34 at drivers/clk/clk.c:1254
> > clk_core_enable+0xb4/0x1b0
> > [    2.641156] Enabling unprepared l4-wkup-clkctrl:0008:18
> > [    2.646530] Modules linked in:
> > [    2.649688] CPU: 0 UID: 0 PID: 34 Comm: kworker/u4:3 Not tainted
> > 6.13.0-rc2-next-20241213-00002-gf2d4b29c8330 #15
> > [    2.660256] Hardware name: Generic AM33XX (Flattened Device Tree)
> > [    2.666531] Workqueue: events_unbound deferred_probe_work_func
> > [    2.672553] Call trace:
> > [    2.672570]  unwind_backtrace from show_stack+0x10/0x14
> > [    2.680578]  show_stack from dump_stack_lvl+0x50/0x64
> > [  7 2.685788]  dump_stack_lvl from __warn+0xc0/0x130
> > [    2.690734]  __warn from warn_slowpath_fmt+0x80/0x1a0
> > [    2.695944]  warn_slowpath_fmt from clk_core_enable+0xb4/0x1b0
> > [    2.701963]  clk_core_enable from clk_core_enable_lock+0x18/0x2c
> > [    2.708159]  clk_core_enable_lock from
> > sysc_enable_opt_clocks.part.9+0x28/0x84
> > [    2.715611]  sysc_enable_opt_clocks.part.9 from
> > sysc_enable_module+0x254/0x2dc
> > [    2.723052]  sysc_enable_module from sysc_runtime_resume+0x17c/0x1c0
> > [    2.729599]  sysc_runtime_resume from __rpm_callback+0x4c/0x130
> > [    2.735709]  __rpm_callback from rpm_callback+0x50/0x54
> > [    2.741096]  rpm_callback from rpm_resume+0x614/0x660
> > [    2.746304]  rpm_resume from __pm_runtime_resume+0x4c/0x64
> > [    2.751960]  __pm_runtime_resume from __device_attach+0xd0/0x188
> > [    2.758155]  __device_attach from bus_probe_device+0x88/0x8c
> > or_thread from kthread+0x188/0x24c
> > [    2.789476]  kthread from ret_from_fork+0x14/0x20
> > [    2.794327] Exception stack(0xe0091fb0 to 0xe0091ff8)
> > [    2.799528] 1fa0:                                     00000000
> > 00000000 00000000 00000000
> > [    2.807947] 1fc0: 00000000 00000000 00000000 00000000 00000000
> > 00000000 00000000 00000000
> > [    2.816365] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000
> > [    2.823173] ---[ end trace 0000000000000000 ]---
> > [    2.828070] ti-sysc 44e07000.target-module: Optional clocks failed
> > for enable: -108
> > [    2.835998] ------------[ cut here ]------------
> >
> > reverting
> > b7bbaff8c1bc ("gpio: omap: save two lines by using devm_clk_get_prepare=
d()")
> >
> > fixes the boot for me.
> >
> >
> > >    drivers/gpio/gpio-omap.c | 4 +---
> > >    1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > > index 54c4bfdccf568..57d299d5d0b16 100644
> > > --- a/drivers/gpio/gpio-omap.c
> > > +++ b/drivers/gpio/gpio-omap.c
> > > @@ -1449,13 +1449,11 @@ static int omap_gpio_probe(struct platform_de=
vice *pdev)
> > >     }
> > >
> > >     if (bank->dbck_flag) {
> > > -           bank->dbck =3D devm_clk_get(dev, "dbclk");
> > > +           bank->dbck =3D devm_clk_get_prepared(dev, "dbclk");
> > >             if (IS_ERR(bank->dbck)) {
> > >                     dev_err(dev,
> > >                             "Could not get gpio dbck. Disable debounc=
e\n");
> > >                     bank->dbck_flag =3D false;
> > > -           } else {
> > > -                   clk_prepare(bank->dbck);
> > >             }
> > >     }
> > >
> >
> > I can only spot a minor functional change. The code prior this commit
> > does not check the result of clk_prepare(), and does neither set
> > bank->dbck_flag =3D false; nor call clk_put();
> >
> > Other than that, timing is likely to be changed. Not sure what is the
> > thing here.
>
> The new code looks more correct, with the return code check from clk_prep=
are().
> Could it be that two problems eliminated themselves in your case before? =
;-)
> Would it be possible for you to provide the logs with "initcall_debug" wi=
th
> and without the patch in question?
>
> --
> Alexander Sverdlin
> Siemens AG
> www.siemens.com

This commit was the tip of my for-next branch so I just dropped it to
fix next. Thanks for the heads-up.

Bart

