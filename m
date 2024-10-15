Return-Path: <linux-kernel+bounces-366680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8D99F896
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86DF2818BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9652E1FBF57;
	Tue, 15 Oct 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="mcRfG5qa"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244EA1CBE8A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026294; cv=none; b=EUxR0B8At3tIShuBxXPpMXueAcoGcKfhRpJTSLKL2Yi98yu+HAxDEHhiHfkqVV4+RBEQF1oX29whoTz53MhD4TbQktHGhM4q3cmuD+lujCPSa/9Ewa087qkXBji92e02IscwAR1JC+CyxITxtyl+vIkBytGL83sQ9hlUjngMhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026294; c=relaxed/simple;
	bh=zT0nCGbUs6GQL3x+J3RS9+mj4BSonnPhxWcD75B+TrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I40H5N1wsaM8xt0wk+6yTJylrSVP4o1ALSxk3eE8Alo+pdwYtN1zr1YBkDzIwMQDMT5EkgFfQM8ExtAhWY4yu8e8I9I77lQYfJfu26R1ffCCgxjmH6umPwGKnr0d527Q9XYcwfF7LdR9G9TRw16fHwV5PXgsa4M1kDz68+XOAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=mcRfG5qa; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so3922816276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1729026292; x=1729631092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToZPK88KWBXsHpBzgS7HGSIabqX2813JKy9iAtzVQYQ=;
        b=mcRfG5qaqEDSdJW8OBy2M7yGcldzlfEK3sEmJ+VyqOCO8NH3fwdLlbRImjXYamTUVg
         UoiNP6nfQiiCYxFLK1Dd7hdLbESzgYyIcrq/ngvKowVzQhlcA6N4t/tC/jiZf6RuZXBx
         8fO6tnoy1tnS5Qgo+Nj/cR8tbPSZmqTOxxsi0sDQhSvW23ljuKfRc0p/O391UmV8+Mlt
         eDGUXa4Ur520/ieoMXMHsDmkNuDp0tzFow0BUlAbLWKlAOmdOYnJgtCAnigDJmOj+sV9
         y4qZB7vvd3LvQauVOBimFX8QfidXrcgexegFFYaRK8NWPRiQFlltdmTbnm5L3zVMHHmN
         /UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026292; x=1729631092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToZPK88KWBXsHpBzgS7HGSIabqX2813JKy9iAtzVQYQ=;
        b=sBJigJ0yqvZQi9SqYvXZw/sP2RzGRdF0Kdjbslp8aQ3S9cI1jix8fazWEmw8I23Z8/
         OufehZ1SDhgIlYgufBgiGnimptPtg0NcM8df2E+3RAPshC0e9au9Odi0EoOQuU2yONk3
         s38OsjDhtYqQ6ANDz+T6nvPlKX62rD+JwfsgQ6EkNpw6kDTjN4C3FGPFc0fcmLcJXAHM
         oxUy0lC9QfYSrEKSKR2rlxmV9dI3KByHBOuSUdGrZdA4Uz6KDqtgv8zb0zv05A83z4jn
         6ZyfUsWxTU5w2LG4ELH8861L0nq/owGBebrLaAXNH528uUogeiZFH6zdPdrixxY8qPJW
         7paw==
X-Forwarded-Encrypted: i=1; AJvYcCWSwkM5qtY9B5I8iMotLPWM/N4usPKuDTKjnkoCL8pQtmeEDM7LspNvUqmKmA8PrIeK+LWU4HoygIfNyyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQifvnJJqf5FjqcJAok5yIBs5InnGC+5p5t0N9gPNhKcb/oKd
	sSmhh2AXCOAvg8zi33bfiMnIZNr8UZk1FA+MeuZTwYAV3tJS05hvFuqtmNOWU7z5wXr1Kbu8k4b
	XmIZ0L9JluFcMsZlsij0sy7ZwjyUuOSG8CXQz0w==
X-Google-Smtp-Source: AGHT+IFfuqTbgppzNExdeMLg6EEca8KoCbP9TBNY3PTiaiEc2Vyiet9kqiI/+PLRD056KzMrBN/GBjlHYa6fKvwqvUM=
X-Received: by 2002:a05:6902:160f:b0:e1d:9b03:8812 with SMTP id
 3f1490d57ef6-e2931ddc566mr8554841276.57.1729026291971; Tue, 15 Oct 2024
 14:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007174211.3511506-1-tharvey@gateworks.com> <ZwQqokf15iMEIrAf@pengutronix.de>
In-Reply-To: <ZwQqokf15iMEIrAf@pengutronix.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 15 Oct 2024 14:04:41 -0700
Message-ID: <CAJ+vNU0BGaLco2g9mTf4eDyY4-u9P0HWeK-TUzsb8JPsZs3Ymg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: phy: disable eee due to errata on various KSZ switches
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:38=E2=80=AFAM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> On Mon, Oct 07, 2024 at 10:42:11AM -0700, Tim Harvey wrote:
> > The well-known errata regarding EEE not being functional on various KSZ
> > switches has been refactored a few times. Recently the refactoring has
> > excluded several switches that the errata should also apply to.
> >
> > Disable EEE for additional switches with this errata.
> >
> > The original workaround for the errata was applied with a register
> > write to manually disable the EEE feature in MMD 7:60 which was being
> > applied for KSZ9477/KSZ9897/KSZ9567 switch ID's.
> >
> > Then came commit ("26dd2974c5b5 net: phy: micrel: Move KSZ9477 errata
> > fixes to PHY driver") and commit ("6068e6d7ba50 net: dsa: microchip:
> > remove KSZ9477 PHY errata handling") which moved the errata from the
> > switch driver to the PHY driver but only for PHY_ID_KSZ9477 (PHY ID)
> > however that PHY code was dead code because an entry was never added
> > for PHY_ID_KSZ9477 via MODULE_DEVICE_TABLE.
> >
> > This was apparently realized much later and commit ("54a4e5c16382 net:
> > phy: micrel: add Microchip KSZ 9477 to the device table") added the
> > PHY_ID_KSZ9477 to the PHY driver but as the errata was only being
> > applied to PHY_ID_KSZ9477 it's not completely clear what switches
> > that relates to.
> >
> > Later commit ("6149db4997f5 net: phy: micrel: fix KSZ9477 PHY issues
> > after suspend/resume") breaks this again for all but KSZ9897 by only
> > applying the errata for that PHY ID.
> >
> > The most recent time this was affected was with commit ("08c6d8bae48c
> > net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)") which
> > removes the blatant register write to MMD 7:60 and replaces it by
> > setting phydev->eee_broken_modes =3D -1 so that the generic phy-c45 cod=
e
> > disables EEE but this is only done for the KSZ9477_CHIP_ID (Switch ID).
> >
> > Fixes: 08c6d8bae48c ("net: phy: Provide Module 4 KSZ9477 errata (DS8000=
0754C)")
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v3: added missing fixes tag
> > v2: added fixes tag and history of issue
> > ---
> >  drivers/net/dsa/microchip/ksz_common.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/m=
icrochip/ksz_common.c
> > index b074b4bb0629..d2bd82a1067c 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -2578,11 +2578,19 @@ static u32 ksz_get_phy_flags(struct dsa_switch =
*ds, int port)
> >               if (!port)
> >                       return MICREL_KSZ8_P1_ERRATA;
> >               break;
> > +     case KSZ8795_CHIP_ID:
> > +     case KSZ8794_CHIP_ID:
> > +     case KSZ8765_CHIP_ID:
> > +             /* KSZ87xx DS80000687C Module 2 */
> > +     case KSZ9896_CHIP_ID:
> > +             /* KSZ9896 Errata DS80000757A Module 2 */
> > +     case KSZ9897_CHIP_ID:
> > +             /* KSZ9897 Errata DS00002394C Module 4 */
> > +     case KSZ9567_CHIP_ID:
> > +             /* KSZ9567 Errata DS80000756A Module 4 */
> >       case KSZ9477_CHIP_ID:
> > -             /* KSZ9477 Errata DS80000754C
> > -              *
> > -              * Module 4: Energy Efficient Ethernet (EEE) feature sele=
ct must
> > -              * be manually disabled
> > +             /* KSZ9477 Errata DS80000754C Module 4 */
> > +             /* Energy Efficient Ethernet (EEE) feature select must be=
 manually disabled
> >                *   The EEE feature is enabled by default, but it is not=
 fully
> >                *   operational. It must be manually disabled through re=
gister
> >                *   controls. If not disabled, the PHY ports can auto-ne=
gotiate
> > --
>
> Similar fix is already present in net:
> 0411f73c13afc ("net: dsa: microchip: disable EEE for KSZ8567/KSZ9567/KSZ9=
896/KSZ9897.")
>
> But your patch provides some quirks for KSZ87xx  and some extra comments
> which are nice to have too. Can you please rebase your patch on top of
> latest net.
>

Hi Oleksij,

Yes, I can submit an update.

Best Regards,

Tim

