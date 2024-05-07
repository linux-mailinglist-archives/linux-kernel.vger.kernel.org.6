Return-Path: <linux-kernel+bounces-170567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B28BD92B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899061F237B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597FE4688;
	Tue,  7 May 2024 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT5PSfIF"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6021FA5;
	Tue,  7 May 2024 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046273; cv=none; b=ZOPqWunBXV2z+X7oBcPtgRXzw5EPMOAKiNUbIFv45XpecND6Vc30jLs+TLsHKfelpAm8QMkJn+iy0LAtnvY5zTvr5QKoOWnnrTnxhdYUWDv/P2ywmt+Osin+8L35Ef7hQahB1p1EQRgBj8D8NRF+GGWgeJ99ubym+OOZ74o3ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046273; c=relaxed/simple;
	bh=GOGHL38ffib/o7LaVGYCmdwvUjQDOC/zJ9wOAixz0iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vxnls9k2AtuWhAvqsG8m5jJ/q1dZzAJm9jENGF4yUnX+9O2BR9enx/kgMEtZMHAvQwfljmCzRHsTTmr0DDBY1NZRH0GyBpPTqv+xRBX4lWd+3sZ1BmGGjuSVDV8czKFCi0FMcRIUrVilbVqQqisNFdxth33MacXYzjTq4/nOoFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT5PSfIF; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7e180e2b288so14570439f.3;
        Mon, 06 May 2024 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715046271; x=1715651071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky75HWr31501QQG1ye0i+4CoK8ksVSqE+DxrjhamMLE=;
        b=GT5PSfIFar1VXHYiXGZVjDpJB+yAtYjdwWQ1sxNZlhqcX2XEd6H5BX1dMOfhxJYiCU
         WtSSZamMbLA2kvXFl6hiPHiQo6PD60gXQ+Mhserfl8emZwNj0ZtxZ8WVn9CqVVJbZsyK
         GEBw442jCHEynd1BTqS8X2rWUFbxfPwW9aPBeTK/OKjmEWscT6tH8TYUh2XNY5AiZySe
         dW0SmYIqY8QgEt5YeImko3QRRAVFDRZpNFckTQA7y/onwMB+t4lxSYS/H4I6UTzlseb6
         UjE9CmLr3nXAR1ENUZzZnJmcbe1gP1y97miQ/WDZ9G//CaMZ8yyWoeicg9F3UpYMLEaq
         bS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046271; x=1715651071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky75HWr31501QQG1ye0i+4CoK8ksVSqE+DxrjhamMLE=;
        b=cu+wR+xaLZkqFlwakSghX+N7s5LuVqaFYSy7bEdswJ3cNW3IzX8B8ttL7f0gB24Zfb
         /2A/XEMSuXN++DrZtgXGjAg7e2uE/ud6TXCfLnuXy1nDeF4IgT574lx2C6OuCCXABtlP
         O5rXdA7zOkbvyVXeDOVWDq+NzhgCO03gD3CGg3pH052U1M/tEmtXch2MN/4gYpVLL99Q
         xi8KVJjhkiXvY6p2WBv9RtLj9YaQV/qYXONsd8XIuatO2yMnw9E/4AGBwM+Cs9Gt2SmD
         GTaY4z4xzWkljGdfgXhm5N2PfQx1XBvXiAZ7K4XdXTjL/ccxG6JPEYcMzBVfoWTGnWvT
         R0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdjPyY4GNnn0h4vHzZtOqqBakKJaufmtNj/PmPtPLucitpjKKOGDtvrKVO5R/dYt3SNaAqYwwrqZVP9ZHXKfObaq1nu/4yAVF34v/gGENCzuCiOMUAu2GuUjBC4Uw6ecrfis9g1cbb
X-Gm-Message-State: AOJu0YyvKs6etM+UOd1iQRQfkt91ZZTdeD0MApu8NWJzvhLcDr8cPGYN
	i6EBlIZhbq7QK2Vb5V4bs2fmLCqqNXnFpvDUcA6VM3R5ywlOccKsPNEa/SxJmprrkppBcRXqDaf
	+0j65FCP+ou+JH+mb81B3W6GOj1k=
X-Google-Smtp-Source: AGHT+IEd2Ds7p6zFIeJ3Zt2IcQyXeyogm3Bmd77Yt9ncqHDjhYK2lyKYF9xAdHbacWf9YqJ8IlHhk23dNqUYyqjZohs=
X-Received: by 2002:a05:6e02:1541:b0:36a:199f:345e with SMTP id
 j1-20020a056e02154100b0036a199f345emr14054732ilu.7.1715046270846; Mon, 06 May
 2024 18:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714966502-27784-1-git-send-email-shengjiu.wang@nxp.com> <Zjkftwr4/6KV39sD@lizhi-Precision-Tower-5810>
In-Reply-To: <Zjkftwr4/6KV39sD@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 7 May 2024 09:44:19 +0800
Message-ID: <CAA+D8AN9kFdgojkrR0ORUyrtOW=JOn0AfbXFTJ70RE7JxgA2pA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx: imx8mp: Add delay after power up
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:22=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, May 06, 2024 at 11:35:02AM +0800, Shengjiu Wang wrote:
> > According to comments in drivers/pmdomain/imx/gpcv2.c:
> >
> >       /* request the ADB400 to power up */
> >       if (domain->bits.hskreq) {
> >               regmap_update_bits(domain->regmap, domain->regs->hsk,
> >                                  domain->bits.hskreq, domain->bits.hskr=
eq);
> >
> >               /*
> >                * ret =3D regmap_read_poll_timeout(domain->regmap, domai=
n->regs->hsk, reg_val,
> >                *                                (reg_val & domain->bits=
hskack), 0,
> >                *                                USEC_PER_MSEC);
> >                * Technically we need the commented code to wait handsha=
ke. But that needs
> >                * the BLK-CTL module BUS clk-en bit being set.
> >                *
> >                * There is a separate BLK-CTL module and we will have su=
ch a driver for it,
> >                * that driver will set the BUS clk-en bit and handshake =
will be triggered
> >                * automatically there. Just add a delay and suppose the =
handshake finish
> >                * after that.
> >                */
> >       }
> >
> > The BLK-CTL module needs to add delay to wait for a handshake request f=
inished
> > before accessing registers, which is just after the enabling of the pow=
er domain.
> >
> > Otherwise there is error:
> >
> > [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrup=
t
> > [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5=
-next-20240424-00003-g21cec88845c6 #171
> > [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> > [    2.181064] Call trace:
> > [...]
> > [    2.181142]  arm64_serror_panic+0x6c/0x78
> > [    2.181149]  do_serror+0x3c/0x70
> > [    2.181157]  el1h_64_error_handler+0x30/0x48
> > [    2.181164]  el1h_64_error+0x64/0x68
> > [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > [    2.181183]  __genpd_runtime_resume+0x30/0x80
> > [    2.181195]  genpd_runtime_resume+0x110/0x244
> > [    2.181205]  __rpm_callback+0x48/0x1d8
> > [    2.181213]  rpm_callback+0x68/0x74
> > [    2.181224]  rpm_resume+0x468/0x6c0
> > [    2.181234]  __pm_runtime_resume+0x50/0x94
> > [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> > [    2.181258]  __driver_probe_device+0x48/0x12c
> > [    2.181268]  driver_probe_device+0xd8/0x15c
> > [    2.181278]  __device_attach_driver+0xb8/0x134
> > [    2.181290]  bus_for_each_drv+0x84/0xe0
> > [    2.181302]  __device_attach+0x9c/0x188
> > [    2.181312]  device_initial_probe+0x14/0x20
> > [    2.181323]  bus_probe_device+0xac/0xb0
> > [    2.181334]  deferred_probe_work_func+0x88/0xc0
> > [    2.181344]  process_one_work+0x150/0x290
> > [    2.181357]  worker_thread+0x2f8/0x408
> > [    2.181370]  kthread+0x110/0x114
> > [    2.181381]  ret_from_fork+0x10/0x20
> > [    2.181391] SMP: stopping secondary CPUs
> >
> > Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for powe=
r saving")
> > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Revewied-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > changes in v2:
> > - reduce size of panic log in commit message
> >
> >  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/cl=
k-imx8mp-audiomix.c
> > index b381d6f784c8..ae2c0f254225 100644
> > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > @@ -6,6 +6,7 @@
> >   */
> >
> >  #include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> >  #include <linux/mod_devicetable.h>
> > @@ -360,6 +361,12 @@ static int clk_imx8mp_audiomix_runtime_suspend(str=
uct device *dev)
> >
> >  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
> >  {
> > +     /*
> > +      * According to the drivers/pmdomain/imx/gpcv2.c
> > +      * need to wait for handshake request to propagate
> > +      */
> > +     udelay(5);
> > +
>
> Did you address the issue I comments at v1?
> It should not fix at here, I think it should be gpcv2.c to delay 5us.

Other BLK CTRL drivers already delay 5us in its own drivers, if
add delay in gpcv2.c, for these drivers, it will delay 10us totally.

Best regards
Shengjiu Wang



>
> Frank
>
> >       clk_imx8mp_audiomix_save_restore(dev, false);
> >
> >       return 0;
> > --
> > 2.34.1
> >

