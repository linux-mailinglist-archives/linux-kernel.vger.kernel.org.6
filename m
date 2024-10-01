Return-Path: <linux-kernel+bounces-345164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E1C98B297
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A99AB26DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FAB78B4E;
	Tue,  1 Oct 2024 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNs3XmJ3"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2F3F9EC
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727751070; cv=none; b=E6T6z5oD34t/tcY/UEVamGoLxAiW7nqB5vUDeYrZ8QHFpKTuxsFDFwImtjH5GNlOsr+hXwATo8ZiVDM1bmzqYpYCV6Fc2gfB+TDrLDAF6xJ1o35Lopq6lr5YVjMSQYw7ExNPkzB8CuuG6Veda55El24TKTN44Os+QDWcSEKzGNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727751070; c=relaxed/simple;
	bh=21feO5ASMrbHPTE8t6IaMLzP3I+HTER+pHbTEeBY/GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvEg8ypJo4rIT6rBT6SP2JHvQjvn7UZfDIJBWOXc/SIHd9k1dOT1AE3I9hhJQFhVbLhzZ4U+ZtIjKEd4GMbuB8BL/5axW7o5RRmnbfwcKv2pZvQ/JQKl2pwa0juI6VkCrdoR9I3skadtZ8QE3hFpashtYizqI2pMqsl4JV2SD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNs3XmJ3; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6dbc5db8a31so38985807b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727751067; x=1728355867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw9bjEOH7sJi84d8amI0HlgnwlcLtdrC8YTmlPpTOEM=;
        b=hNs3XmJ3lWEPLmlWPCQDfiE/XJ3j2VKIO+VjSR0oIqIalkOitvdbrHIljFHGv093PC
         OMNxha8vBgIDDQM8y9Gbp6+YO8LC2nhijTjw7yxYqUJR5WxfjfgUq3X6JW7OLuUrKfVe
         qU1brwxHtMKRPQ3ODTbIKiWi+hABFzzdCRYvc3tQm7tuOTt9yTDXEmeBQTxcgOSvxA0J
         OyQ6lpFab4dHbuNN6aLfbRqNx+P1UFEk0VnQnEZraqCphKlmuOCNuZHmusXsKWejTBla
         iKxf6bIDttmshQDqt9UCjtgIQ2qr/naEr8/iBv910stsQ036Gz9ycR+pwuj6G7Hq8wyF
         ekXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727751067; x=1728355867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kw9bjEOH7sJi84d8amI0HlgnwlcLtdrC8YTmlPpTOEM=;
        b=DyCZyfBMB/TE6PS7Zsw4m6bi3gWMknubTdClB3F/NwF+qP7qpgXnX9L8fDq+iSgQHz
         dH9y/N/695Uh4qL+pefLO+aYiIlUePvU0IHtaTHUzUYn/5X6gcgFvXbXAIPltlfjsDCO
         us3v/JG3eumkh4aENu//nAHDFtTC82shZQzoMYJ5M1rbLKnN7dSBp0rOEczfe33Lpy5E
         QB1JvLYADKxxLtqS1QZr7ioXleoZneC5OHiwOxleOt0F4yd76NyZRRyHWtvS3yrkKPAP
         hsqd+L2vMcsVmESwDLi8WVO2ExiEaJtasmaJ1TlTHR4ma+HY23/JcslEYkNLtRsQBuNU
         ohUg==
X-Forwarded-Encrypted: i=1; AJvYcCVGTFr+F9+Uq9QQ8gqIxq2akLhtd5IzzKWF3Rm4lo3lkaQHwg39QC9HKDYW+BvDdL+98/ZFPQ6dMPCdJRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybEY5x5VrObu5Ta4WPTINBkxPrSWtAx3qPG7o4Wzog/biDPQGG
	frXK/rrmy35vFIIcJDOoG3Dawv5dwo6TAQ0QTMKglxDbfI6xwvC95dtdHg+u8yUbBDWOYpMZnYy
	BtZRsnhePleuqp3wh9y0C6DQdoS0=
X-Google-Smtp-Source: AGHT+IGQINgk6UFRmYO8tunNkTiP270bh8X4zMWuNZL3LkkgBCDhQvD0PPhdvlOM615bdaVtI6XZxFr066qhAEmfszQ=
X-Received: by 2002:a05:690c:6703:b0:6db:e1e0:bf6a with SMTP id
 00721157ae682-6e290dce418mr17591927b3.7.1727751067387; Mon, 30 Sep 2024
 19:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930215934.349238-1-rosenp@gmail.com> <e729da5b-3964-4cdc-bdf4-2352be5b093e@lunn.ch>
In-Reply-To: <e729da5b-3964-4cdc-bdf4-2352be5b093e@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Sep 2024 19:50:56 -0700
Message-ID: <CAKxU2N9sBOnTGDhtxGVvyrSw=_WuJH29tgZXfmK-RD2RRY=ZSQ@mail.gmail.com>
Subject: Re: [PATCH] arch: arm: kirkwood: support nvmem mac address
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:53=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Sep 30, 2024 at 02:59:34PM -0700, Rosen Penev wrote:
> > of_get_ethdev_address gets called too early for nvmem. If EPROBE_DEFER
> > gets called, skip so that the ethernet driver can adjust the MAC addres=
s
> > through nvmem.
>
> Is this from code analysis or do you have a board with real issues? Do
> we want to add a Fixed: so it gets back ported in stable?
Working with a guy that does. This device has not been upstreamed, so
not quite valid.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  arch/arm/mach-mvebu/kirkwood.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkw=
ood.c
> > index 73b2a86d6489..da347f66900b 100644
> > --- a/arch/arm/mach-mvebu/kirkwood.c
> > +++ b/arch/arm/mach-mvebu/kirkwood.c
> > @@ -86,13 +86,18 @@ static void __init kirkwood_dt_eth_fixup(void)
> >               void __iomem *io;
> >               u8 *macaddr;
> >               u32 reg;
> > +             int err;
> >
> >               if (!pnp)
> >                       continue;
> >
> > -             /* skip disabled nodes or nodes with valid MAC address*/
> > -             if (!of_device_is_available(pnp) ||
> > -                 !of_get_mac_address(np, tmpmac))
> > +             /* skip disabled nodes */
> > +             if (!of_device_is_available(pnp))
> > +                     goto eth_fixup_skip;
> > +
> > +             /* skip nodes with valid MAC address*/
> > +             err =3D of_get_mac_address(np, tmpmac);
> > +             if (err =3D=3D -EPROBE_DEFER || !err)
> >                       goto eth_fixup_skip;
>
> I'm wondering about ordering here. What exactly does EPROBE_DEFER
> mean? Does it mean we know there is a MAC address in nvmem, but the
> nvmem has not probed yet? Or can it mean, the nvmem has not probed
> yet, and maybe there is a MAC address in it, maybe not?
It only means NVMEM has not loaded. NVMEM loads after MTD, meaning quite la=
te.
>
> In the maybe not case, we should still be trying to read the MAC from
> the hardware and storing it way safe for later use.
Not sure how to go about that. OTOH it's not very common to have
CONFIG_NVMEM where not needed.

Actually I have no idea what this whole function even does. For these
devices, uboot usually reads the ethaddr variable and passes it to the
kernel. Something like that can be handled entirely by nvmem.
>
>         Andrew

