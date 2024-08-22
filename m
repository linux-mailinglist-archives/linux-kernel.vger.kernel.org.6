Return-Path: <linux-kernel+bounces-296416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D0095AAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260F01F23485
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0EE134C4;
	Thu, 22 Aug 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIXx4Zx2"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852079C2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291959; cv=none; b=Gsgm7TlPwjiZ+GR0htlwH0EZb6yM2DZ9fkGSX0J7IJluk74dPveXD1SwMZsGqVwGUQZkiACq8nNQCQzpIBxl0O6+DpVQPs8PFjF3IeOAfl3P138Vzmum7hw/cGMoGINdYePWK7JZHecUsYGOlGrvwWNnixeVSyZpIIrkXwKUZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291959; c=relaxed/simple;
	bh=eaczjHz+dJJ/tSBUKip+3HvnPtJhbykxgxeJwqW7ixE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRf5OFjFQSgL2TAbtRUkZlUhExgZdqlJWWTucX7CJ0MtiN+DB4uz5rke/WQSUHgAl33diwHCH2NPPzA4s0TabkD+X2AWpruSmqJLZxFNKmT9VDkOfWdLFVtRYNV9iaXKRT4neT6FrOfF2ppp2GKO17aMeKwYoom6jiy35+1sKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIXx4Zx2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3d7a1e45fso193150a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724291957; x=1724896757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFO2kWCGjNOD3FeA4OtRgD3pdjDivL5vvXpR1ohJQTE=;
        b=HIXx4Zx2l4QfOupGw4vU0xjipPpMS3VUB3lHhFNfCt3LJKeAta1Rjn5nKp6I0rRA1k
         qA+S+DnUK4z2mcVl36eUH1ThPYlCZ/Caoh4t6NKW1i3hukLbuMgzVGWAuMdZwFLITFo9
         DNOimWysjKIVTyrQ7ptAuQ2NEUh+qk4yjaPmbPzNQ9N9Xq2izJUwW/YIRNny+vN09u1Y
         RXQoybzKlA4W0rowJN9fRYvJagAx39kBEFq/GCbb8g/h8xsetcDR9ExjwwjlwOxU7GKc
         eArzTrItM4leK0xh/prl3BRxT74/L3iFM+L+qKrAre90jNl9AoKmPu9NPxoPdQe6qRGu
         HIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724291957; x=1724896757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFO2kWCGjNOD3FeA4OtRgD3pdjDivL5vvXpR1ohJQTE=;
        b=r05EB45iKPJLCmvFHBsSlr6dStBX4o1tswva/XBUV+Kx5iGWciuwYOSf8ivjOlozcz
         vC+ZyMas2E/7josZM72AqF/wktTRXm5NZX8tGBxQrdGrIdvVYC6LKgUFCr5pNXe5X1HN
         Ikrdqa9rokOQ/S0nZfJJpyxOU5SnJ+nbd1LmjDmtsjD8loA9yRBCFnKEdBLnFqJ92qoi
         NHCF8CWX3j2drtQVur4fTZoj+QgcrRNsma6IBS6Y6sTMJNyCOLUF5ND9iOh4Cbx4KeRh
         x82Bysfi5Uh1QP6nWSYjWFt8uDppb6FdfG1hFdeOXndkTq1ALdh9KLzm9g4W0asDl9m/
         HcBw==
X-Forwarded-Encrypted: i=1; AJvYcCVtRqllsIIA4j31mjSTv0/GtS6Yb2d8pzJrolRngq6v63oqPR8goxCRRQJk/37IbDWB8S6DcnZZg34Dup8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSXUiaRNaY5TQvyZYa/OZW4Ne5AhxoVyurl6muLL9R4aQ/X/ba
	sVzxU5zllArmaRv6VE9ohcdJ9phuRojDXxv/dWNMql9jAumTVKu5MKyUALWDOHHECeycafUO/pd
	UCO5u8udlCuJ+rcDOwlr39B6xW2A=
X-Google-Smtp-Source: AGHT+IHo1XypQ2DhBU9dvxFb47f1VVfuO5TlGuhS61QXHHxtYiys4WJVmwOODJ9pBcwZtDtC4hQnUAZDYgMqTdynFSo=
X-Received: by 2002:a17:90a:4d83:b0:2c9:58dd:e01d with SMTP id
 98e67ed59e1d1-2d5e9a09e2bmr4589896a91.14.1724291957272; Wed, 21 Aug 2024
 18:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-11-aford173@gmail.com>
 <Zm_UzO4Jmm7Aykcm@atmark-techno.com> <22a3f5266260dd3915269ae3eec7724f7537eb55.camel@pengutronix.de>
 <cd03ecb1-100e-4699-95ed-d837a2802dc7@kontron.de> <CAHCN7x+bh_ka250hOCenO3Et6re4EJ=5TG8=kpG1hs-PV0dQxQ@mail.gmail.com>
 <ZsVluV50NvuGGHFX@atmark-techno.com> <CAHCN7xJnjfjr7HfKF+4pwbENP+p2=vvMXWW1AQShNy87vfQ=-A@mail.gmail.com>
In-Reply-To: <CAHCN7xJnjfjr7HfKF+4pwbENP+p2=vvMXWW1AQShNy87vfQ=-A@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 21 Aug 2024 20:59:05 -0500
Message-ID: <CAHCN7xKgpqfRf_2p1z5NyKiOYubbcDA7YE5ML8G56pVmcV+1xA@mail.gmail.com>
Subject: Re: drm/bridge/imx8mp-hdmi-tx: Allow inexact pixel clock frequencies
 (Was: [PATCH V8 10/12] drm/bridge: imx: add bridge wrapper driver for i.MX8MP
 DWC HDMI)
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, Lucas Stach <l.stach@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, marex@denx.de, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	Makoto Sato <makoto.sato@atmark-techno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 7:45=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Tue, Aug 20, 2024 at 10:58=E2=80=AFPM Dominique MARTINET
> <dominique.martinet@atmark-techno.com> wrote:
> >
> > Adam Ford wrote on Tue, Aug 20, 2024 at 09:49:03PM -0500:
> > > > > However, this check is a bit overcautious in that it only allows =
exact
> > > > > rate matches. IIRC HDMI allows a rate mismatch of +- 0.5%, so thi=
s
> > > > > check could be relaxed quite a bit to allow for that.
> > > >
> > > > I checked with a 1080p display that reports 23 possible modes via E=
DID.
> > > > Out of these 15 are accepted by the driver with the strict check.
> > > >
> > > > Two more would be accepted with a relaxed check that allows a 0.5% =
margin.
> > > >
> > > > For the remaining six modes, the pixel clock would deviate up to ~5=
%
> > > > from what the display expects. Still, if I remove the check altoget=
her,
> > > > all 23 modes seem to work just fine.
> >
> > I can confirm the displays I tested also seem pretty tolerant in
> > practice (up to ~3-4% at least), but I agree with Lucas that this isn't
> > something we can rely on for a general purpose driver as having example=
s
> > of things being tolerant doesn't mean all hardware will be as flexible.=
.
> >
> > > > I'd really like to be able to add more PHY PLL setpoints for displa=
ys
> > > > that use non-CEA-861 modes. Unfortunately I didn't manage to figure=
 out
> > > > the fractional-n PLL parameter calculation so far.
> > > >
> > > > The i.MX8MP Reference Manual provides formulas to calculate the
> > > > parameters based on the register values and I tried to make sense o=
f it
> > > > using the existing register values in the driver. But somehow it do=
esn't
> > > > add up for me.
> > > >
> > > > Lucas, did you already work with the PLL parameters? By any chance,=
 do
> > > > you now how the math behind them works?
> > >
> > > I spent a little time trying to understand it a bit.  I created a PMS
> > > calculator similar to the one used on the DSI controller,
> >
> > Great! I'll admit this also flies over my head and I don't have the
> > time to study this, so this is much appreciated.
> >
> > > except that
> > > the M seems to be fixed at a value of 62 per the data sheet, so it's
> > > more of a PS calculator.
> >
> > Hmm... PHY_REG2 in the datasheet only lists '0011_1110b - 62' as
> > example(?) values, but it doesn't say other values are reserved either,
> > I'm not sure what to make of it.
> > In the current driver PHY_REG_02 (driver macro) is assigned the first
> > field of .pll_div_regs, which goes anywhere from 0x4b to 0x7b -- pretty
> > far from 62(0x3e)...
>
> OK.  I will experiment with increasing the range of M from being fixed
> at 3e to a range of 3b to 7b to see if my PMS integer calculator can
> get more accurate.
>
> >
> > Since other frequencies have been adjusting this main diviser ratio we
> > actually tried copying neighboring values and adjusting only that reg 2
> > (so the M if I get this right?), but the end result ended up not
> > synchronizing properly every time... We didn't have time to check with =
a
> > scope if the generated signal was ugly or if it just didn't lock
> > properly, but the display worked when we just re-used the neighboring
> > values without changing anything despite being ~3-4% off, so we took th=
e
> > easy way out here and didn't dig much further.
> >
> > > Anyway, When I run my P-S calculator to generate the 'best rate' I ge=
t
> > > a value that's usually 0.2% variance from nominal, but I only verifie=
d
> > > a handful of values:
> > >
> > > Several which were +0.2%
> > > 297600000 vs 297000000 (4k@30)
> > > 148800000 vs 148500000 (1080p60)
> > > 74400 vs 74200
> > >
> > > One value was -0.16%
> > > 24800000 vs 25200000
> > >
> > > If the M value was a bit more flexible, we might be able to reduce
> > > that variance more.
> >
> > Yes, I think the M value could be more flexible, but that'd require
> > checking if it actually works, whereas having slightly off frequencies
> > will most likely be OK so I don't think it's worth the effort -- happy
> > to stick to what the datasheet describes.
> >
> > > If / when I get some time, I might play with trying to disable the
> > > fractional mode and just use the PMS calculator for simplicity despit=
e
> > > the inaccuracy.  Maybe we could fall back to using the PMS calculator
> > > if the desired frequency isn't in the look-up-table.
> >
> > That'd be greatly appreciated, I don't have any strong opinion on
> > whether that should completely replace the table, or only be used if
> > there is no exact match in the table as these are values we know will
> > work; but we can definitely test any patch you can throw at us here.
>
> I can't promise it'll be quick.  I am not fully certain I understand
> how the whole thing works, but as a rule, I don't generally like look
> up tables if they can be calculated dynamically.

I updated my PMS calculator, and I randomly selected 5 resolutions and
they all returned an exact clock match, so I'll attempt to use the PMS
integer clock instead of the fractional one.

It'll be a little while longer before I can do anything with it.

adam
>
> adam
> >
> >
> > Cheers,
> > --
> > Dominique
> >
> >

