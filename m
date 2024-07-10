Return-Path: <linux-kernel+bounces-247949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3792D695
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDC11C2152A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80964198A16;
	Wed, 10 Jul 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEUYGOBr"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952F19885B;
	Wed, 10 Jul 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629057; cv=none; b=Ichq2mvcQiDebp1wHafSsDb0mbHlE9/Y9xijnBIf+Fkre1PGlnvbTS4SiZFYmdVgO34WOZU8veo49ko/532dEZL/fkXJxe+MHLH4J/FwyC0fGBJ5cUW3Rr2bjjMmmlE9cGR3TtU7vTSA+YKp/lEGj8cAa/RW5W9YFNtlZlwAvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629057; c=relaxed/simple;
	bh=cGb7tInK4vAhQvQt2d4EfXOhpah5Z8GsPat+yNVyA4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjPQSbiAszjGpy5OgIu6ezirxZnyTAhd8n6MKW8mKRkv9Z1Bup0BF2XZ8tbnD7F6XIJHjMaCs0ZDMkSaVCATx/94YN2rVnYMc1WoBIvkgxd/bFu2uD8CoaCfWw6Nrpbn1Hyao/PcvRNWBGl55FvkMdk7YeSTEWigzvpKLHENkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEUYGOBr; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5caad707f74so2459eaf.1;
        Wed, 10 Jul 2024 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720629055; x=1721233855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3of+HDJjh5kl7ec4aH1qHWgLGXlG5vPNgwyZbImeHQ=;
        b=CEUYGOBrDD/NT1Jn1S3HS69p5xZ2sTrNB4atAjnLSnaC5rL2HjDuGxDinCDxYBlehy
         dmEVrOuh7rYZE69wlzOZZCVKQvsJRMXsgkWnrEk/wEcD1KHSGGImEedUTTg95YSlcSWv
         qyk2sI3I39cYilMpe6/JyyjrZlKkMs4RXVov15snmVaRaglp9nCl8R7mg32iiBRyaNd8
         dnf1bNG3jxZYCWS14Bu5j1kQryiQKUwEx81qLUAJqz4guI/Xjkqmzq9YFmJZH8wt3Uh1
         kyO7F/zYkEbPOKpzDC93SjMNfHzp/kXdWbJ6cSp1Lure0rUCf0zd+TJZZDO42CtMBAn7
         QTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720629055; x=1721233855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3of+HDJjh5kl7ec4aH1qHWgLGXlG5vPNgwyZbImeHQ=;
        b=HUjzHAB2KSXRqjdeHOfXWKgoeDytgx086koS82UJOxqu/DH1/UIDeXQgQAusvv9i21
         7p1qhqYSK35mF92AohP/yr5pxZmDp9c0+zHKcHiFetfpFJ3uGJkhj68kVQ3WsfRJy7St
         uryJ3ntuSH0qGPBuRcUvBn2N7CHv7utbNasf1NCkqP6pq0oegyfSyidgYuIaA55C9RBz
         wxBPlSI6ppOhl7f96SCk7Y1I9qhmoZ6WG2aUNJA7DR8PrdyQwMQs6k4haOefoCvnhGX+
         wv6pa/CF/9NwEUtPX3iuPYXApw3r9nWgeH2pOjbUEoBbvVOC9QjpU+I2lkpnBXRwKk5C
         62Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUTW3/eU3ZFjizfq4n00Zd3vIQekAdjd+aLM7ZCVnYuR7xezA4mY6iDpOKXuWS0IV1OCPiPboonssXeCynGc31aVqLxCdFwoCmak65PaOTSxthJpvMd3dCReRwgb1rTRMSdTRoEW7/+PA==
X-Gm-Message-State: AOJu0YwVXm6EMO/lgBM0tq3XH0k/hQnxJlFzDnQI+e7MykLMKnC2uJNU
	IZYkKGUcPBSKYRrrVx38wWAJd+BfjcNmAKRq9wpebO0XmLfcL+MAA94p4nwNdryBN7bAopBAp5/
	Yok9yMUkg/WH1v88Yyhj5PR1LgLY=
X-Google-Smtp-Source: AGHT+IFllFzBSLtYIygpzYXOS1tTlREEsgiErb3y8wRUZPYiDBvsVSVWStLRJgoIkFCG6rS9/YbWpW1kWqBlgQ6VSSw=
X-Received: by 2002:a05:6870:f723:b0:254:c08d:cb55 with SMTP id
 586e51a60fabf-25eae755dd6mr4955639fac.5.1720629055139; Wed, 10 Jul 2024
 09:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710142001.7234-1-linux.amoon@gmail.com> <2356091.ECZNHGQPT7@diego>
In-Reply-To: <2356091.ECZNHGQPT7@diego>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 10 Jul 2024 22:00:37 +0530
Message-ID: <CANAwSgTRW1zQcZBb+8Yzu2hgqPxVopG+8c4Ng+QNrcGjBXOC8g@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

Thanks for your review comments.

On Wed, 10 Jul 2024 at 20:24, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Mittwoch, 10. Juli 2024, 16:19:56 CEST schrieb Anand Moon:
> > Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> > signals. Rename node from 'pcie3' to 'pcie30x4' to align with schematic
> > nomenclature.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 20 +++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm=
64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index 2e7512676b7e..a9b55b7996cf 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -301,7 +301,7 @@ &pcie30phy {
> >
> >  &pcie3x4 {
> >       pinctrl-names =3D "default";
> > -     pinctrl-0 =3D <&pcie3_rst>;
> > +     pinctrl-0 =3D <&pcie30x4_perstn_m1 &pcie30x4_clkreqn_m1 &pcie30x4=
_waken_m1>;
> >       reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> >       vpcie3v3-supply =3D <&vcc3v3_pcie30>;
> >       status =3D "okay";
> > @@ -340,14 +340,22 @@ pcie2_2_rst: pcie2-2-rst {
> >               };
> >       };
> >
> > -     pcie3 {
> > -             pcie3_rst: pcie3-rst {
> > -                     rockchip,pins =3D <4 RK_PB6 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> > -             };
> > -
> > +     pcie30x4 {
> >               pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> >                       rockchip,pins =3D <1 RK_PA4 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> >               };
> > +
> > +             pcie30x4_clkreqn_m1: pcie30x4-clkreqn-m1 {
> > +                     rockchip,pins =3D <4 RK_PB4 RK_FUNC_GPIO &pcfg_pu=
ll_up>;
> > +             };
> > +
> > +             pcie30x4_waken_m1: pcie30x4-waken-m1 {
> > +                     rockchip,pins =3D <4 RK_PB5 RK_FUNC_GPIO &pcfg_pu=
ll_down>;
> > +             };
> > +
> > +             pcie30x4_perstn_m1: pcie30x4-perstn-m1 {
> > +                     rockchip,pins =3D <4 RK_PB6 RK_FUNC_GPIO &pcfg_pu=
ll_down>;
> > +             };
>
> I'm not sure what you're going for here, but defining them as gpio makes
> them essentially unused? Shouldn't they go to the pcie controller?
>

Ok, Each component of PCIe communication to have the following
control signals #PERST # WAKE and CLKREQ from root complex to endpoint.

> From what I found for example
> The PERST# signal is used to indicate when the power supply is within its=
 specified voltage tolerance and is stable.
>

PERST is referred to as a fundamental reset. PERST should be held low
until all the power rails
in the system and the reference clock are stable. A transition from
low to high in this signal usually
indicates the beginning of link initialization.

> At least you'll need to explain more in the commit message.
>
Ok,
WAKE and CLKREQ signals are used to transition to and from low-power states=
.
WAKE signal is an active-low signal that is used to return the PCIe
interface to an active state
when in a low-power state.
CLKREQ signal is also an active-low signal and is used to request the
reference clock.
>
I will work on and update in the next version.
>
> Heiko

Thanks
-Anand

