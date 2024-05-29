Return-Path: <linux-kernel+bounces-194190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1B18D3827
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0AB1C240C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB961BC43;
	Wed, 29 May 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldh1lFQN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997018EA8;
	Wed, 29 May 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990263; cv=none; b=aNs8WGrg5DLfd9UfyXWggLVwymFWUXCnBXBoZMDDRW2eRvTjyAt9ZC++1D5Mty51Irs8gvAmKMdeQv4fv4tjj4gbBXmYJgf3t6LRf2+A2h5ZoViRFSZBBPTGr0LS45RSHO2jKMQm5Ue1DoIwkT3pcSj38GuEuiAJs6lZ2OQqfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990263; c=relaxed/simple;
	bh=VQgHFgqP/4XpqkYAK/f5SZ2pHbIQPnlx3L/xfDABSkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6yu8XpyX9i5SWL3Cx3N9UyEYad5ybpw+zin4+qgyslcoxSnm0sY+YQ0g9bde85RLIRBHnliRD56J77CXdipLZqgeoE7E47jfI3Qr72B+R2gX6Kvql8sNtSCKdAS3g8FunMapSA+LfMD8PoxZM3WVlVJl5qIJIKafjdoqHiuTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ldh1lFQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7183C2BD10;
	Wed, 29 May 2024 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716990262;
	bh=VQgHFgqP/4XpqkYAK/f5SZ2pHbIQPnlx3L/xfDABSkk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ldh1lFQNlkJoGyhqSYbTknan/c+BczYYSyD6Dl3BgcEUWCOZ87MwiAWLKR4tUy+N4
	 jUA6HeGMzjStli3t6Q5eBVfzUrSLfn/xpRvEfHXb4JRxbnSwbTYCrRU1ZRauZzLNkF
	 bWJrRc2F3r3bpb5TDf2V5A5jQaZKYH9JxWdqGMghLxaDhX0qM1APNyXASJO3LMaRWa
	 /dVznUDRS7a9lQvvbB93Zg92qPDAOlHv8prYAoxsWbDCdKffDpimglaSF/sDYZzhPI
	 aJrwp/+tL0PgjuOU6tY+ISPVNZv6Pvikg5s+C2tEdihX61SC5626QlZD0vHLZWIEz2
	 /USnH1kCu+D4Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5295dada905so721262e87.1;
        Wed, 29 May 2024 06:44:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOQpy82QVKJPd9qU0UyyS2dYRS0oq/HwyJLMyWbeqsJujXLXIr9k/pi4oEMnn4L4uEQ8txxgOkh9udVBWNkyEPLCFVOrdjd7IZa4+HG8GHgUql6BYJxTG6oSm22XXLBETw7ag2qvLBig==
X-Gm-Message-State: AOJu0YxZXMxkdW08ezpwFz2ecOZIJuBptqDXKOZeXGe9euZ3Is9B9CHj
	7dpiKVYpbeMvvBjp9Bdpu79SWAbZ5j/eOWsUrgvHSqdREhbbbbqKTrglpPe7bPNghCR+2gw4DbQ
	eScOcZAsaisE4MXhltNFx9c5Uog==
X-Google-Smtp-Source: AGHT+IG0Twsuzy3G15biXOtdBIc6ZH3RX7c1OUW5xcm5mEL/8kjZupd/YmgZJOtQEJePvqdfFd0WJ/312vXzKdPlv50=
X-Received: by 2002:a05:6512:2148:b0:52b:7a62:7600 with SMTP id
 2adb3069b0e04-52b7a627762mr1520e87.16.1716990261135; Wed, 29 May 2024
 06:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528164132.2451685-1-maz@kernel.org> <CAK9=C2XNPJP0X=pg5TSrQbsuouDD3jP-gy2Sm4BXNJp0ZiWp+A@mail.gmail.com>
 <86bk4pm8j1.wl-maz@kernel.org>
In-Reply-To: <86bk4pm8j1.wl-maz@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 29 May 2024 08:44:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKOxYeNh026wmYH2JDYbR-FGjc=9gv-taB09pC4fyXKCA@mail.gmail.com>
Message-ID: <CAL_JsqKOxYeNh026wmYH2JDYbR-FGjc=9gv-taB09pC4fyXKCA@mail.gmail.com>
Subject: Re: [PATCH] of: property: Fix fw_devlink handling of interrupt-map
To: Marc Zyngier <maz@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 1:33=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Wed, 29 May 2024 06:15:52 +0100,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Tue, May 28, 2024 at 10:11=E2=80=AFPM Marc Zyngier <maz@kernel.org> =
wrote:
> > >
> > > Commit d976c6f4b32c ("of: property: Add fw_devlink support for
> > > interrupt-map property") tried to do what it says on the tin,
> > > but failed on a couple of points:
> > >
> > > - it confuses bytes and cells. Not a huge deal, except when it
> > >   comes to pointer arithmetic
> > >
> > > - it doesn't really handle anything but interrupt-maps that have
> > >   their parent #address-cells set to 0
> > >
> > > The combinations of the two leads to some serious fun on my M1
> > > box, with plenty of WARN-ON() firing all over the shop, and
> > > amusing values being generated for interrupt specifiers.
> > >
> > > Address both issues so that I can boot my machines again.
> > >
> > > Fixes: d976c6f4b32c ("of: property: Add fw_devlink support for interr=
upt-map property")
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Cc: Anup Patel <apatel@ventanamicro.com>
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Cc: Rob Herring (Arm) <robh@kernel.org>
> >
> > Thanks for the fix patch but unfortunately it breaks for RISC-V.
> >
> > > ---
> > >  drivers/of/property.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 1c83e68f805b..9adebc63bea9 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1322,7 +1322,13 @@ static struct device_node *parse_interrupt_map=
(struct device_node *np,
> > >         addrcells =3D of_bus_n_addr_cells(np);
> > >
> > >         imap =3D of_get_property(np, "interrupt-map", &imaplen);
> > > -       if (!imap || imaplen <=3D (addrcells + intcells))
> > > +       imaplen /=3D sizeof(*imap);
> > > +
> > > +       /*
> > > +        * Check that we have enough runway for the child unit interr=
upt
> > > +        * specifier and a phandle. That's the bare minimum we can ex=
pect.
> > > +        */
> > > +       if (!imap || imaplen <=3D (addrcells + intcells + 1))
> > >                 return NULL;
> > >         imap_end =3D imap + imaplen;
> > >
> > > @@ -1346,8 +1352,14 @@ static struct device_node *parse_interrupt_map=
(struct device_node *np,
> > >                 if (!index)
> > >                         return sup_args.np;
> > >
> > > -               of_node_put(sup_args.np);
> > > +               /*
> > > +                * Account for the full parent unit interrupt specifi=
er
> > > +                * (address cells, interrupt cells, and phandle).
> > > +                */
> > > +               imap +=3D of_bus_n_addr_cells(sup_args.np);
> >
> > This breaks for RISC-V because we don't have "#address-cells"
> > property in interrupt controller DT node and of_bus_n_addr_cells()
> > retrieves "#address-cells" from the parent of interrupt controller.
>
> That's a feature, not a bug. #address-cells, AFAICT, applies to all
> child nodes until you set it otherwise.

That may be supported in some places, but only because of buggy DTs
(we're talking 2000 era). Current dtc should warn if an interrupt
controller node doesn't have #address-cells AND is referred to by
interrupt-map.

There's also the notion of default root values, but that's broken as
well. dtc and the kernel don't even agree on the default for some
arches. Fortunately, that's been a dtc warning longer than I've worked
on DT.


> > The of_irq_parse_raw() looks for "#address-cells" property
> > in the interrupt controller DT node only so we should do a
> > similar thing here as well.
>
> This looks more like a of_irq_parse_raw() bug than anything else.

Nope.

Rob

