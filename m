Return-Path: <linux-kernel+bounces-170622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B98BD9D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F871F233AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A05F41741;
	Tue,  7 May 2024 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsoKDOz/"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631B91D524;
	Tue,  7 May 2024 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053487; cv=none; b=TeNYonpK0AshC2YbanjGwsR1WQgsJRlG/W4l8H0f6gE6Ad8XqV0b0dKToLBD4CJsxTKavC/iLJmJqhqR0Zrx/sMmBMhqqv6t+edQuZt1p6AR9E/jSrf8ha6sVP5j5dyttgYF12qEK+aACydIHQEeq+m8pYW3w0kTl2oI4Jon2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053487; c=relaxed/simple;
	bh=ieUFjNzpqDHfOmmcQRoniRmrDPLD1dmfQj1soqIbh6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iROQfH67bg86pB/fYueWelLqCgi4ZebQVgmDKbrtzKUsyeTEDPH24tVZEpw6X7HhraJV0ln08ICHe+05kx28oS1LT9akBYNUjd5mm9lll/Aij6wRLalGftOxuexjo7Kt9MH3xZ+16LuCqcl4bUycTdv8UrrsGZIqlaEf+O4VcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsoKDOz/; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36c9c603b1dso5247735ab.1;
        Mon, 06 May 2024 20:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715053483; x=1715658283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq708vA2oB0YY9nurqOC072nDww/+k2jN+3TSjEZ5V0=;
        b=XsoKDOz/+S9nmJuJ8FAqKUk54UYyGGk1bWtSaNRZcon+EoxsrUTELIvedO8wXXOgn/
         I8NMOyxFTIGDNpYRdw0y50JYgyVSCS8I0q1x528dBzQDS7kG06Va8v17Mx7IIuAxMf4a
         ifSfv5K17xAb4f58BGJhyCrrOKYaUAcvKoJwwIjT3LG1Q0QO41HGVSf2pTF6nQz7yYzx
         5GybYd78qZbe9Cd53C6Qne37cbzthtIGBXxOwbAuilP4XgVszpE8PF/T49tXcYwkp+28
         CAPpX0HpWvAyCjCb5PYpF+hxCV/bn/iVFWocCoZ6ErEdIK84WuuOibAVAh+mXGXl8v+s
         TjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715053483; x=1715658283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aq708vA2oB0YY9nurqOC072nDww/+k2jN+3TSjEZ5V0=;
        b=sfK0pulVkJNChxbvDZ5SSh5P42fJI43DujFfPvfxYB+epIC0ttzolSXt7x1a2O3KYV
         J6wbiR9SeZOYdXC4ZshrWeCZQlxvvVVbeipA3kv0DccDU8XBgJ4NWx9YpQERWqYXJ05D
         rM4y+OTzUwwjraPVOmc0WeAuD0d74VPnRt0rYtITYqPRKwtHlRgsi+BCJeXfXCQjmqST
         a+mo9EQmaom79ZFKhg6eRy65Wjs5RQPc/FABZsjy4FvCPgSIXmegrAhAlf9Ohbbtzk8a
         9ARsOvQORt8arYme9r3A20wfoiawIrHHHMOUSK06BNl+0lJXTn0WwhJTtwPXTGAxaWM0
         o6TA==
X-Forwarded-Encrypted: i=1; AJvYcCUrdDzGSLMS9LhqWuyS0O0F9GF1Sm34hNIlzLwROkSbW+piCUDU3OFimhrA1j+H4X4nPKEK9+weO2iKIFrI53t+XjgMTFgpdcAddUEGXnfxr20egEROOZV1NqRJ4WBQutgfZ4xSreEl
X-Gm-Message-State: AOJu0Yy+dzydMx5MJbcC+Esj90WsinKaLOm1+Q5GWtuzyZ8DC5aLjACI
	+UXAVQKJmDs3iNFTg0sJhn/FZSWot+tcwSzLBIckCrO0v7/RT1lsEooQhFKedllkRe7ewDp5Uef
	KHRtw+tpaZ84VH6kAB1iqKlefFYo=
X-Google-Smtp-Source: AGHT+IGTSKaPsE0s32h5h9WG0sD4Az7zkW4aup9q3HHDOq64n/DnPxpMWiIqndgLPGf2GCB9C5QnX97oW29YK0ore/4=
X-Received: by 2002:a05:6e02:20e8:b0:369:bdb3:4f62 with SMTP id
 q8-20020a056e0220e800b00369bdb34f62mr14881164ilv.18.1715053483469; Mon, 06
 May 2024 20:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714966502-27784-1-git-send-email-shengjiu.wang@nxp.com>
 <Zjkftwr4/6KV39sD@lizhi-Precision-Tower-5810> <CAA+D8AN9kFdgojkrR0ORUyrtOW=JOn0AfbXFTJ70RE7JxgA2pA@mail.gmail.com>
 <Zjmi4Qc3C3OYJU5n@lizhi-Precision-Tower-5810>
In-Reply-To: <Zjmi4Qc3C3OYJU5n@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 7 May 2024 11:44:32 +0800
Message-ID: <CAA+D8AMC41oUEWLuHb-f=U9pEzqWYon22McvT4MucYK=ajNuFQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx: imx8mp: Add delay after power up
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:41=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, May 07, 2024 at 09:44:19AM +0800, Shengjiu Wang wrote:
> > On Tue, May 7, 2024 at 2:22=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrot=
e:
> > >
> > > On Mon, May 06, 2024 at 11:35:02AM +0800, Shengjiu Wang wrote:
> > > > According to comments in drivers/pmdomain/imx/gpcv2.c:
> > > >
> > > >       /* request the ADB400 to power up */
> > > >       if (domain->bits.hskreq) {
> > > >               regmap_update_bits(domain->regmap, domain->regs->hsk,
> > > >                                  domain->bits.hskreq, domain->bits.=
hskreq);
> > > >
> > > >               /*
> > > >                * ret =3D regmap_read_poll_timeout(domain->regmap, d=
omain->regs->hsk, reg_val,
> > > >                *                                (reg_val & domain->=
bits.hskack), 0,
> > > >                *                                USEC_PER_MSEC);
> > > >                * Technically we need the commented code to wait han=
dshake. But that needs
> > > >                * the BLK-CTL module BUS clk-en bit being set.
> > > >                *
> > > >                * There is a separate BLK-CTL module and we will hav=
e such a driver for it,
> > > >                * that driver will set the BUS clk-en bit and handsh=
ake will be triggered
> > > >                * automatically there. Just add a delay and suppose =
the handshake finish
> > > >                * after that.
> > > >                */
> > > >       }
> > > >
> > > > The BLK-CTL module needs to add delay to wait for a handshake reque=
st finished
> > > > before accessing registers, which is just after the enabling of the=
 power domain.
> > > >
> > > > Otherwise there is error:
> > > >
> > > > [    2.181035] Kernel panic - not syncing: Asynchronous SError Inte=
rrupt
> > > > [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0=
-rc5-next-20240424-00003-g21cec88845c6 #171
> > > > [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > > > [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> > > > [    2.181064] Call trace:
> > > > [...]
> > > > [    2.181142]  arm64_serror_panic+0x6c/0x78
> > > > [    2.181149]  do_serror+0x3c/0x70
> > > > [    2.181157]  el1h_64_error_handler+0x30/0x48
> > > > [    2.181164]  el1h_64_error+0x64/0x68
> > > > [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > > > [    2.181183]  __genpd_runtime_resume+0x30/0x80
> > > > [    2.181195]  genpd_runtime_resume+0x110/0x244
> > > > [    2.181205]  __rpm_callback+0x48/0x1d8
> > > > [    2.181213]  rpm_callback+0x68/0x74
> > > > [    2.181224]  rpm_resume+0x468/0x6c0
> > > > [    2.181234]  __pm_runtime_resume+0x50/0x94
> > > > [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> > > > [    2.181258]  __driver_probe_device+0x48/0x12c
> > > > [    2.181268]  driver_probe_device+0xd8/0x15c
> > > > [    2.181278]  __device_attach_driver+0xb8/0x134
> > > > [    2.181290]  bus_for_each_drv+0x84/0xe0
> > > > [    2.181302]  __device_attach+0x9c/0x188
> > > > [    2.181312]  device_initial_probe+0x14/0x20
> > > > [    2.181323]  bus_probe_device+0xac/0xb0
> > > > [    2.181334]  deferred_probe_work_func+0x88/0xc0
> > > > [    2.181344]  process_one_work+0x150/0x290
> > > > [    2.181357]  worker_thread+0x2f8/0x408
> > > > [    2.181370]  kthread+0x110/0x114
> > > > [    2.181381]  ret_from_fork+0x10/0x20
> > > > [    2.181391] SMP: stopping secondary CPUs
> > > >
> > > > Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for =
power saving")
> > > > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > Revewied-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > > changes in v2:
> > > > - reduce size of panic log in commit message
> > > >
> > > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/im=
x/clk-imx8mp-audiomix.c
> > > > index b381d6f784c8..ae2c0f254225 100644
> > > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > @@ -6,6 +6,7 @@
> > > >   */
> > > >
> > > >  #include <linux/clk-provider.h>
> > > > +#include <linux/delay.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/io.h>
> > > >  #include <linux/mod_devicetable.h>
> > > > @@ -360,6 +361,12 @@ static int clk_imx8mp_audiomix_runtime_suspend=
(struct device *dev)
> > > >
> > > >  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
> > > >  {
> > > > +     /*
> > > > +      * According to the drivers/pmdomain/imx/gpcv2.c
> > > > +      * need to wait for handshake request to propagate
> > > > +      */
> > > > +     udelay(5);
> > > > +
> > >
> > > Did you address the issue I comments at v1?
> > > It should not fix at here, I think it should be gpcv2.c to delay 5us.
> >
> > Other BLK CTRL drivers already delay 5us in its own drivers, if
> > add delay in gpcv2.c, for these drivers, it will delay 10us totally.
>
> We should go forward as correct direction. If udelay should be gpcv2.c,
> it should be there and remove other udelay in BLK CTRL drivers gradually.
>
With Peng's reply:

"No. Because BLK CTRL enable BUS_EN, before enable BUS_EN, udelay does
not help. For the audiomix, move to gpcv2 would work, but gpcv2 is
not only for i.MX8MP audiomix. For mixes, default not enable BUS_EN
after power on, the udelay must be in blk ctrl driver."

So gpcv2.c is not correct place for all BLK CTRL drivers.

Best regards
Shengjiu Wang

> If sometime found 5us is not enough, need change to 6us, we just need
> change at one place.
>
> Frank
>
> >
> > Best regards
> > Shengjiu Wang
> >
> >
> >
> > >
> > > Frank
> > >
> > > >       clk_imx8mp_audiomix_save_restore(dev, false);
> > > >
> > > >       return 0;
> > > > --
> > > > 2.34.1
> > > >

