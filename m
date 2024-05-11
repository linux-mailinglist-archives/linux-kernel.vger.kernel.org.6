Return-Path: <linux-kernel+bounces-176402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3CB8C2F38
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 05:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D014FB22D16
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 03:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C8924B4A;
	Sat, 11 May 2024 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2H2/E7/"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C021345;
	Sat, 11 May 2024 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715396988; cv=none; b=bZReWEv5gZS17o3VZQ/IyLPA5lnZM8b7KDq8fV/bsqEHGNss2YmlgFItieE6tvGkPKwZFGHgR9gAb3Fg3qKTDWuyMcRjG/53oaPmwUUqRQXxjezz22HuGwpHpaUQWDds/EN39nbvFCcLXweU2HYQCVZwY2I95+l7kkStoVUBI5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715396988; c=relaxed/simple;
	bh=6foHhr0TW03dqZnZz4QwEWuvDSFW4bvHJil6jrBMqYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TineHVPCYoMoxIIprZjugbGQVUEjctaUosZv1Y5VXyVaqR8bqANeb5K3BAWgSDSEJjOTqsOWBaAuOqszPGs3+HZLfWH9H6YT+OI9GCwqT2kOuIqHdZB/yANoW/SieCn3j2WrqLilWybGT8VSUx+jxL9LEPtGasJBUcSXA8Lqbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2H2/E7/; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36c90b7f4c8so12425395ab.2;
        Fri, 10 May 2024 20:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715396986; x=1716001786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBy4V17h0PUaZteQlrBkOjrENzi/JrQGSd8HxxR/cEs=;
        b=D2H2/E7/LCdNVOBodwzjI/AkP7QllTo2OKqin73FLXrzdaZ1MWxN5ochqtIJLiELC5
         No9UvtPAd8vaJG6RHN4hI/97yxfi7Pk89yaZbKd/e6HrLpML2R9aMDKzVr5ovJOO8ALU
         9RyXf2RRwzUyIQdoNNu4b9kgG+8wlvkW/QFm2+3eNPNT1nCnFEvDSLzC+1QWfxCAKyvP
         FIwkm3lRWFC1G1+bTXp5xcGmqBGgIMty8wqlsMrHsQb+JQflYnBnjO4JTB/yND3jpZfW
         SWJ8muPGf+XxKAm/MDHPMnx09V3au+n9SsKg1bJF03FBKB/CIPJC8WBiDhLxqG8XyroD
         W2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715396986; x=1716001786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBy4V17h0PUaZteQlrBkOjrENzi/JrQGSd8HxxR/cEs=;
        b=f8lHPyFVAIWcaQiHmUIsdbbr53P9VZitOBVmFESNpvglFuFSOn9g5SwwMaA1cR6rmE
         u3Erq80sxzBAQoLB7vE3dCwkKZ/4Xh9NxCLSA3Lqx6uIAHJWouQq/rRGmxUqvfT9F9vT
         CSqExOl4gBMKD/5Zaxv1G0LSTRI70+hbngjBBC/wqv0kfYI9varwaynd8jUflRyFvXqL
         mPLs+GY1ty2gAajdI98UhDK416tVnSe+cih8vrzELBD1nXujpZVgqGzLiCGjBbf6u6YD
         0xZJyM5MKVUjG7kGnu7ftx3JtMAZ1BkdW13b435h8nAWk6DUS+yDR/nS29+x2ne77jut
         MKqA==
X-Forwarded-Encrypted: i=1; AJvYcCWDMJ8LbcXDIE8FC/32ZxyXefZc1qIGQ6rYdo+qHN1Nzh1XAyK+GrHFPyM4wLv5OfUVBoJ1efWsTlHne4aYshZkP/C7h/6zPwxONEWl3+DiyJWQL2ziL5W5b9nokGNYZPhKNnIie8uq
X-Gm-Message-State: AOJu0Yx6eVGNkxZY0wucP5qmJYDqQ2RRm0V2bTGR0se3gSlgXi8fRp7v
	B0PUEh5CscIyAchB5HgJy64ie2twIY2i69UDT6lLPK1zKx6BIrc7sfqZMIeXIH6oIbtD0Mf60W1
	08MXDQRVBnswQT/bA5VyMYqs3HrHpXXkL
X-Google-Smtp-Source: AGHT+IFAl8Imeh2Cw6mt8rj29u6mx+HsiO9rMvuNvGJtkcayPcGmWUCclun7KpkAcN/gXqB1rbwV1dvJxtod4qYA7Yw=
X-Received: by 2002:a05:6e02:1aa7:b0:369:bdb3:4f62 with SMTP id
 e9e14a558f8ab-36cc1465e31mr55488195ab.18.1715396985801; Fri, 10 May 2024
 20:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714966502-27784-1-git-send-email-shengjiu.wang@nxp.com>
 <Zjkftwr4/6KV39sD@lizhi-Precision-Tower-5810> <CAA+D8AN9kFdgojkrR0ORUyrtOW=JOn0AfbXFTJ70RE7JxgA2pA@mail.gmail.com>
 <Zjmi4Qc3C3OYJU5n@lizhi-Precision-Tower-5810> <CAA+D8AMC41oUEWLuHb-f=U9pEzqWYon22McvT4MucYK=ajNuFQ@mail.gmail.com>
 <Zjmn1jRW2E2kpSlI@lizhi-Precision-Tower-5810> <CAA+D8ANuNtaC90fHtGoYiofPTLQHcyCm0p_dcsYTVgT7gsKtMg@mail.gmail.com>
 <Zj5psV6ZIFZ/OPth@lizhi-Precision-Tower-5810>
In-Reply-To: <Zj5psV6ZIFZ/OPth@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sat, 11 May 2024 11:09:34 +0800
Message-ID: <CAA+D8ANgev0o0Z9HkmOnNuw5hACU7FgCDHFF6sbvXLd6Vd2T3w@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx: imx8mp: Add delay after power up
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 2:38=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, May 07, 2024 at 04:04:14PM +0800, Shengjiu Wang wrote:
> > On Tue, May 7, 2024 at 12:02=E2=80=AFPM Frank Li <Frank.li@nxp.com> wro=
te:
> > >
> > > On Tue, May 07, 2024 at 11:44:32AM +0800, Shengjiu Wang wrote:
> > > > On Tue, May 7, 2024 at 11:41=E2=80=AFAM Frank Li <Frank.li@nxp.com>=
 wrote:
> > > > >
> > > > > On Tue, May 07, 2024 at 09:44:19AM +0800, Shengjiu Wang wrote:
> > > > > > On Tue, May 7, 2024 at 2:22=E2=80=AFAM Frank Li <Frank.li@nxp.c=
om> wrote:
> > > > > > >
> > > > > > > On Mon, May 06, 2024 at 11:35:02AM +0800, Shengjiu Wang wrote=
:
> > > > > > > > According to comments in drivers/pmdomain/imx/gpcv2.c:
> > > > > > > >
> > > > > > > >       /* request the ADB400 to power up */
> > > > > > > >       if (domain->bits.hskreq) {
> > > > > > > >               regmap_update_bits(domain->regmap, domain->re=
gs->hsk,
> > > > > > > >                                  domain->bits.hskreq, domai=
n->bits.hskreq);
> > > > > > > >
> > > > > > > >               /*
> > > > > > > >                * ret =3D regmap_read_poll_timeout(domain->r=
egmap, domain->regs->hsk, reg_val,
> > > > > > > >                *                                (reg_val & =
domain->bits.hskack), 0,
> > > > > > > >                *                                USEC_PER_MS=
EC);
> > > > > > > >                * Technically we need the commented code to =
wait handshake. But that needs
> > > > > > > >                * the BLK-CTL module BUS clk-en bit being se=
t.
> > > > > > > >                *
> > > > > > > >                * There is a separate BLK-CTL module and we =
will have such a driver for it,
> > > > > > > >                * that driver will set the BUS clk-en bit an=
d handshake will be triggered
> > > > > > > >                * automatically there. Just add a delay and =
suppose the handshake finish
> > > > > > > >                * after that.
> > > > > > > >                */
> > > > > > > >       }
> > > > > > > >
> > > > > > > > The BLK-CTL module needs to add delay to wait for a handsha=
ke request finished
> > > > > > > > before accessing registers, which is just after the enablin=
g of the power domain.
> > > > > > > >
> > > > > > > > Otherwise there is error:
> > > > > > > >
> > > > > > > > [    2.181035] Kernel panic - not syncing: Asynchronous SEr=
ror Interrupt
> > > > > > > > [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not taint=
ed 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> > > > > > > > [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > > > > > > > [    2.181050] Workqueue: events_unbound deferred_probe_wor=
k_func
> > > > > > > > [    2.181064] Call trace:
> > > > > > > > [...]
> > > > > > > > [    2.181142]  arm64_serror_panic+0x6c/0x78
> > > > > > > > [    2.181149]  do_serror+0x3c/0x70
> > > > > > > > [    2.181157]  el1h_64_error_handler+0x30/0x48
> > > > > > > > [    2.181164]  el1h_64_error+0x64/0x68
> > > > > > > > [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x4=
4
> > > > > > > > [    2.181183]  __genpd_runtime_resume+0x30/0x80
> > > > > > > > [    2.181195]  genpd_runtime_resume+0x110/0x244
> > > > > > > > [    2.181205]  __rpm_callback+0x48/0x1d8
> > > > > > > > [    2.181213]  rpm_callback+0x68/0x74
> > > > > > > > [    2.181224]  rpm_resume+0x468/0x6c0
> > > > > > > > [    2.181234]  __pm_runtime_resume+0x50/0x94
> > > > > > > > [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> > > > > > > > [    2.181258]  __driver_probe_device+0x48/0x12c
> > > > > > > > [    2.181268]  driver_probe_device+0xd8/0x15c
> > > > > > > > [    2.181278]  __device_attach_driver+0xb8/0x134
> > > > > > > > [    2.181290]  bus_for_each_drv+0x84/0xe0
> > > > > > > > [    2.181302]  __device_attach+0x9c/0x188
> > > > > > > > [    2.181312]  device_initial_probe+0x14/0x20
> > > > > > > > [    2.181323]  bus_probe_device+0xac/0xb0
> > > > > > > > [    2.181334]  deferred_probe_work_func+0x88/0xc0
> > > > > > > > [    2.181344]  process_one_work+0x150/0x290
> > > > > > > > [    2.181357]  worker_thread+0x2f8/0x408
> > > > > > > > [    2.181370]  kthread+0x110/0x114
> > > > > > > > [    2.181381]  ret_from_fork+0x10/0x20
> > > > > > > > [    2.181391] SMP: stopping secondary CPUs
> > > > > > > >
> > > > > > > > Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime supp=
ort for power saving")
> > > > > > > > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> > > > > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > > > > Revewied-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > > ---
> > > > > > > > changes in v2:
> > > > > > > > - reduce size of panic log in commit message
> > > > > > > >
> > > > > > > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
> > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/driver=
s/clk/imx/clk-imx8mp-audiomix.c
> > > > > > > > index b381d6f784c8..ae2c0f254225 100644
> > > > > > > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > > > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > > > > @@ -6,6 +6,7 @@
> > > > > > > >   */
> > > > > > > >
> > > > > > > >  #include <linux/clk-provider.h>
> > > > > > > > +#include <linux/delay.h>
> > > > > > > >  #include <linux/device.h>
> > > > > > > >  #include <linux/io.h>
> > > > > > > >  #include <linux/mod_devicetable.h>
> > > > > > > > @@ -360,6 +361,12 @@ static int clk_imx8mp_audiomix_runtime=
_suspend(struct device *dev)
> > > > > > > >
> > > > > > > >  static int clk_imx8mp_audiomix_runtime_resume(struct devic=
e *dev)
> > > > > > > >  {
> > > > > > > > +     /*
> > > > > > > > +      * According to the drivers/pmdomain/imx/gpcv2.c
> > > > > > > > +      * need to wait for handshake request to propagate
> > > > > > > > +      */
> > > > > > > > +     udelay(5);
> > > > > > > > +
> > > > > > >
> > > > > > > Did you address the issue I comments at v1?
> > > > > > > It should not fix at here, I think it should be gpcv2.c to de=
lay 5us.
> > > > > >
> > > > > > Other BLK CTRL drivers already delay 5us in its own drivers, if
> > > > > > add delay in gpcv2.c, for these drivers, it will delay 10us tot=
ally.
> > > > >
> > > > > We should go forward as correct direction. If udelay should be gp=
cv2.c,
> > > > > it should be there and remove other udelay in BLK CTRL drivers gr=
adually.
> > > > >
> > > > With Peng's reply:
> > > >
> > > > "No. Because BLK CTRL enable BUS_EN, before enable BUS_EN, udelay d=
oes
> > > > not help. For the audiomix, move to gpcv2 would work, but gpcv2 is
> > > > not only for i.MX8MP audiomix. For mixes, default not enable BUS_EN
> > > > after power on, the udelay must be in blk ctrl driver."
> > > >
> > > > So gpcv2.c is not correct place for all BLK CTRL drivers.
> > >
> > > where BLK-CTRL driver source code?
> >
> > drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> > drivers/pmdomain/imx/imx93-blk-ctrl.c
>
> I still think it should put in gpcv2.c. Call power_on/off happen at very
> low frequency. Even there are additional 5us delay for other BLK-CTRL
> drivers, it will tiny impact to system performance. It is not worth to ad=
d
> additonal software check to disingiush these two cases.
>
> But correct power on is more important.
>
> So readl() follow a udelay(5) is more important then additional 5us delay
> for other BLK-CTRL driver since there are many 5us delay already in gpcv2=
.
>

I will send another v3 to gpcv2.c.  Let more people to review.

best regards
Shengjiu Wang
> Frank
>
> >
> > Best regards
> > Shengjiu Wang
> > >
> > > even if put clk_imx8mp_audiomix_runtime_resume(), it need read any
> > > register before udelay. all regiser read and write is strong ordered.
> > > when get value from a register, all previous write must be done.
> > >
> > > all udelay (5) in gpcv2 may not delay 5us at all.
> > >
> > > Frank
> > > >
> > > > Best regards
> > > > Shengjiu Wang
> > > >
> > > > > If sometime found 5us is not enough, need change to 6us, we just =
need
> > > > > change at one place.
> > > > >
> > > > > Frank
> > > > >
> > > > > >
> > > > > > Best regards
> > > > > > Shengjiu Wang
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Frank
> > > > > > >
> > > > > > > >       clk_imx8mp_audiomix_save_restore(dev, false);
> > > > > > > >
> > > > > > > >       return 0;
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > >

