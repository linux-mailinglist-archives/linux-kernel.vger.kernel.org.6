Return-Path: <linux-kernel+bounces-170848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA68BDCE5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C42837BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A513C8E5;
	Tue,  7 May 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ext4PjDM"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA46FE07;
	Tue,  7 May 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069068; cv=none; b=pqAXwSvmn7WxqwxDnfpDcHdM3ITtSG2K0Csl4tgqfQFxyqaNfcSqrKaWlQZ+Z6Y4Lhlg+2JPc4smvpcKkOX97XekpPueLW+Id9FzP5sNJ3EcjaZxIk0W9jBcjhswZYYFNHGNFIFvYEno9mmXgnjlFJBjc205cbGEjDmAg3nQ7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069068; c=relaxed/simple;
	bh=9tAmf27Y2lOy6+TvLqyO2ksDnAlUMD7FrLDWgl6p75E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5LPaw0mgv/uOerrc8hgVsCkjC5VuYyFAh0fcJJ9OYAWmp46x17TzOM6+t++CyLqPcHDAeJtUy2Ez2F0SsZQG1p0cY3BuIJT7OiVytU+Hv5dBmOwMAyMfxb+CrJ4FbFbloFqwwMnWlIf6BjfQ9W1qOhv1mlTelTAbBjVp+jNUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ext4PjDM; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36c791e9faaso11901515ab.1;
        Tue, 07 May 2024 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715069066; x=1715673866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K41OfxbCyNHXXhyq/i9IuSY7OGGztCynWA3y3XEm3w8=;
        b=Ext4PjDMajQMxMCSJ5ji+UTsoxCd8ykbMmHLPDAga2PSnRyhraL2eesjrwnNWF74RC
         yx/vjkgSLSjYKxSiKc7CRa3smZwWmKhhCRmAL03mmO4FPcSaTMRvIUSr1hYlMHahCf3C
         T/eRWqpXbD9whnqEgpO3inAQU9ogz4u9FAa8vWBzAijmtMYajqs2C8+3BXJz69ETljZ3
         9Amx2o2AA9uh9/kLE1ev8M5BcjbGzYplSFaC8tgvmgygSZ8X3P4/OSkoNJdqMnsQzT7F
         PeGR8AJvj9emA/Hxf1mZoTeDhiGqQGTqlxqmChTi/JvM2cs+ikYkdAP7uOdWhpFvrYT7
         5Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715069066; x=1715673866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K41OfxbCyNHXXhyq/i9IuSY7OGGztCynWA3y3XEm3w8=;
        b=qmF0bqN2PLGTawEYqvKUbW9uSBKEvfcMMQKvO+9mR0FFKMpTxIJQzgMlDQr7L3Pek/
         c+zQaOZNj1QEyfQxAZ3oAbPCfkyuMJBIJaBtAdUJ8J9JLFWbKVkVJR7t+8hIuGPAREgp
         RMDFKzhoij/zOJI3DpZ88xeibintWLyEqhBZIt30zae4sUImlOuAvjh7yZOqGY0NiT+f
         s+SFCV4qBDp9n10pyrOc8eNFGUw+sMHSwp+XL8GeLGIF89D3/CZGXcbU72k+3F9oO4iP
         vyrpkC1009rqFTobxTzTbulaj0DJUqc5m1RdMjZ26SVoTYl8GTgre9AjVBGXkzF3yL+t
         Vs/w==
X-Forwarded-Encrypted: i=1; AJvYcCWsW2u4B5n4qyzbdAhuJKNe2LIVgASH95tCVZVfgGrXcsP/SzEJj0XcnfDaOGlMOmw6wprx6y0t35KtwRgaNt5IKimRTjC7tH/aJqB7V/9WcmAaLbfQSMWyj39y+LcwRe9eTvCBBXFg
X-Gm-Message-State: AOJu0YwnaHH7xKlGwdgMQ29nmQ2ir5EtmnazLDoR+hD1AaRYZ+9Fpd65
	m5BTSVQMz4ZdDouLW1YFXqgOJzxrxhxnie1P2xSLXEQSDS5DTFPeudrDKztAWr2QpaCT+XmqkG3
	V8X4rJecEvYOr29RpY/Hcc13hUCA=
X-Google-Smtp-Source: AGHT+IHFTx36BmRSF+nMKKAziYlY+T/lnDKbeG921LVPeSXj3ZND1Th4a2f6WV0n0aVPW9JCSxhnvlOS/M9HwAUWBqE=
X-Received: by 2002:a05:6e02:12ed:b0:36c:5154:8ce4 with SMTP id
 l13-20020a056e0212ed00b0036c51548ce4mr14448865iln.30.1715069065745; Tue, 07
 May 2024 01:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714966502-27784-1-git-send-email-shengjiu.wang@nxp.com>
 <Zjkftwr4/6KV39sD@lizhi-Precision-Tower-5810> <CAA+D8AN9kFdgojkrR0ORUyrtOW=JOn0AfbXFTJ70RE7JxgA2pA@mail.gmail.com>
 <Zjmi4Qc3C3OYJU5n@lizhi-Precision-Tower-5810> <CAA+D8AMC41oUEWLuHb-f=U9pEzqWYon22McvT4MucYK=ajNuFQ@mail.gmail.com>
 <Zjmn1jRW2E2kpSlI@lizhi-Precision-Tower-5810>
In-Reply-To: <Zjmn1jRW2E2kpSlI@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 7 May 2024 16:04:14 +0800
Message-ID: <CAA+D8ANuNtaC90fHtGoYiofPTLQHcyCm0p_dcsYTVgT7gsKtMg@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx: imx8mp: Add delay after power up
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 12:02=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, May 07, 2024 at 11:44:32AM +0800, Shengjiu Wang wrote:
> > On Tue, May 7, 2024 at 11:41=E2=80=AFAM Frank Li <Frank.li@nxp.com> wro=
te:
> > >
> > > On Tue, May 07, 2024 at 09:44:19AM +0800, Shengjiu Wang wrote:
> > > > On Tue, May 7, 2024 at 2:22=E2=80=AFAM Frank Li <Frank.li@nxp.com> =
wrote:
> > > > >
> > > > > On Mon, May 06, 2024 at 11:35:02AM +0800, Shengjiu Wang wrote:
> > > > > > According to comments in drivers/pmdomain/imx/gpcv2.c:
> > > > > >
> > > > > >       /* request the ADB400 to power up */
> > > > > >       if (domain->bits.hskreq) {
> > > > > >               regmap_update_bits(domain->regmap, domain->regs->=
hsk,
> > > > > >                                  domain->bits.hskreq, domain->b=
its.hskreq);
> > > > > >
> > > > > >               /*
> > > > > >                * ret =3D regmap_read_poll_timeout(domain->regma=
p, domain->regs->hsk, reg_val,
> > > > > >                *                                (reg_val & doma=
in->bits.hskack), 0,
> > > > > >                *                                USEC_PER_MSEC);
> > > > > >                * Technically we need the commented code to wait=
 handshake. But that needs
> > > > > >                * the BLK-CTL module BUS clk-en bit being set.
> > > > > >                *
> > > > > >                * There is a separate BLK-CTL module and we will=
 have such a driver for it,
> > > > > >                * that driver will set the BUS clk-en bit and ha=
ndshake will be triggered
> > > > > >                * automatically there. Just add a delay and supp=
ose the handshake finish
> > > > > >                * after that.
> > > > > >                */
> > > > > >       }
> > > > > >
> > > > > > The BLK-CTL module needs to add delay to wait for a handshake r=
equest finished
> > > > > > before accessing registers, which is just after the enabling of=
 the power domain.
> > > > > >
> > > > > > Otherwise there is error:
> > > > > >
> > > > > > [    2.181035] Kernel panic - not syncing: Asynchronous SError =
Interrupt
> > > > > > [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6=
9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> > > > > > [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > > > > > [    2.181050] Workqueue: events_unbound deferred_probe_work_fu=
nc
> > > > > > [    2.181064] Call trace:
> > > > > > [...]
> > > > > > [    2.181142]  arm64_serror_panic+0x6c/0x78
> > > > > > [    2.181149]  do_serror+0x3c/0x70
> > > > > > [    2.181157]  el1h_64_error_handler+0x30/0x48
> > > > > > [    2.181164]  el1h_64_error+0x64/0x68
> > > > > > [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > > > > > [    2.181183]  __genpd_runtime_resume+0x30/0x80
> > > > > > [    2.181195]  genpd_runtime_resume+0x110/0x244
> > > > > > [    2.181205]  __rpm_callback+0x48/0x1d8
> > > > > > [    2.181213]  rpm_callback+0x68/0x74
> > > > > > [    2.181224]  rpm_resume+0x468/0x6c0
> > > > > > [    2.181234]  __pm_runtime_resume+0x50/0x94
> > > > > > [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> > > > > > [    2.181258]  __driver_probe_device+0x48/0x12c
> > > > > > [    2.181268]  driver_probe_device+0xd8/0x15c
> > > > > > [    2.181278]  __device_attach_driver+0xb8/0x134
> > > > > > [    2.181290]  bus_for_each_drv+0x84/0xe0
> > > > > > [    2.181302]  __device_attach+0x9c/0x188
> > > > > > [    2.181312]  device_initial_probe+0x14/0x20
> > > > > > [    2.181323]  bus_probe_device+0xac/0xb0
> > > > > > [    2.181334]  deferred_probe_work_func+0x88/0xc0
> > > > > > [    2.181344]  process_one_work+0x150/0x290
> > > > > > [    2.181357]  worker_thread+0x2f8/0x408
> > > > > > [    2.181370]  kthread+0x110/0x114
> > > > > > [    2.181381]  ret_from_fork+0x10/0x20
> > > > > > [    2.181391] SMP: stopping secondary CPUs
> > > > > >
> > > > > > Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support =
for power saving")
> > > > > > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> > > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > > Revewied-by: Peng Fan <peng.fan@nxp.com>
> > > > > > ---
> > > > > > changes in v2:
> > > > > > - reduce size of panic log in commit message
> > > > > >
> > > > > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/cl=
k/imx/clk-imx8mp-audiomix.c
> > > > > > index b381d6f784c8..ae2c0f254225 100644
> > > > > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > > @@ -6,6 +6,7 @@
> > > > > >   */
> > > > > >
> > > > > >  #include <linux/clk-provider.h>
> > > > > > +#include <linux/delay.h>
> > > > > >  #include <linux/device.h>
> > > > > >  #include <linux/io.h>
> > > > > >  #include <linux/mod_devicetable.h>
> > > > > > @@ -360,6 +361,12 @@ static int clk_imx8mp_audiomix_runtime_sus=
pend(struct device *dev)
> > > > > >
> > > > > >  static int clk_imx8mp_audiomix_runtime_resume(struct device *d=
ev)
> > > > > >  {
> > > > > > +     /*
> > > > > > +      * According to the drivers/pmdomain/imx/gpcv2.c
> > > > > > +      * need to wait for handshake request to propagate
> > > > > > +      */
> > > > > > +     udelay(5);
> > > > > > +
> > > > >
> > > > > Did you address the issue I comments at v1?
> > > > > It should not fix at here, I think it should be gpcv2.c to delay =
5us.
> > > >
> > > > Other BLK CTRL drivers already delay 5us in its own drivers, if
> > > > add delay in gpcv2.c, for these drivers, it will delay 10us totally=
.
> > >
> > > We should go forward as correct direction. If udelay should be gpcv2.=
c,
> > > it should be there and remove other udelay in BLK CTRL drivers gradua=
lly.
> > >
> > With Peng's reply:
> >
> > "No. Because BLK CTRL enable BUS_EN, before enable BUS_EN, udelay does
> > not help. For the audiomix, move to gpcv2 would work, but gpcv2 is
> > not only for i.MX8MP audiomix. For mixes, default not enable BUS_EN
> > after power on, the udelay must be in blk ctrl driver."
> >
> > So gpcv2.c is not correct place for all BLK CTRL drivers.
>
> where BLK-CTRL driver source code?

drivers/pmdomain/imx/imx8m-blk-ctrl.c
drivers/pmdomain/imx/imx8mp-blk-ctrl.c
drivers/pmdomain/imx/imx93-blk-ctrl.c

Best regards
Shengjiu Wang
>
> even if put clk_imx8mp_audiomix_runtime_resume(), it need read any
> register before udelay. all regiser read and write is strong ordered.
> when get value from a register, all previous write must be done.
>
> all udelay (5) in gpcv2 may not delay 5us at all.
>
> Frank
> >
> > Best regards
> > Shengjiu Wang
> >
> > > If sometime found 5us is not enough, need change to 6us, we just need
> > > change at one place.
> > >
> > > Frank
> > >
> > > >
> > > > Best regards
> > > > Shengjiu Wang
> > > >
> > > >
> > > >
> > > > >
> > > > > Frank
> > > > >
> > > > > >       clk_imx8mp_audiomix_save_restore(dev, false);
> > > > > >
> > > > > >       return 0;
> > > > > > --
> > > > > > 2.34.1
> > > > > >

