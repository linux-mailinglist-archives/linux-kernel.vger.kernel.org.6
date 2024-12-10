Return-Path: <linux-kernel+bounces-439105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB1B9EAAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B65188AEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A39230990;
	Tue, 10 Dec 2024 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gDK5NBvc"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D872309A6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820023; cv=none; b=i2IThmdl4VkVTlxVZRIR2gp7lE5hufXSXilNeB2TfdJEfaOxvJN1yH810Nc+6D+A0i01ZiskGMj/mTkXOXnlbeqVyGKy1IyGyOJqlwB4dEQ195ruWkuX7UcPrf1mE307b80Gk+vWcj5bKbxFds+AybiFLXNW9yRN2jnJvyKqA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820023; c=relaxed/simple;
	bh=qCKDfV1D9yzn4CTwd+vsnF2MOOvE4HiqMr1gmvi18NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7oUKn565gRJmDbJ8dwFzaWxWQFSkh6Mg/MBSCJujbOFEEJe3R8Y/qAZik3s0aFQKXa5JbA5+HzyRRoCOGiNiI5RyOh1QxhCyxziIJqZ/wuTHUmIy6lb/531sMAsZA5uRXgfj1TuWOAT6ZqK/lrMErivBkBYqKPcikWz0sr0XbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gDK5NBvc; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-540201cfedbso1570069e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733820019; x=1734424819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOUvJSCroFD0KCytXgmkZjSfl4sfftW4avujGnTnXVw=;
        b=gDK5NBvcpB0ocsiSWJlOuT/QoEx0n8KTAAsUuZ27cuIuB0s2PeQ1m8X10bUwUm37RT
         sTyDDZBmRABL0RtyIg6N0XlSWplqxntfhRfXd7ZyneBNzFPX1JNrfyk5Rb8c8N2mWn00
         IKc1vTX84j3LeV26k/yz++ySWKEFlPqJMs4WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820019; x=1734424819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOUvJSCroFD0KCytXgmkZjSfl4sfftW4avujGnTnXVw=;
        b=DsLARocm7xzI5eqO1MoU+kXW6m/bjAGeYpl5zFw5slBiervftZx8M7X1hLWXUGo+Wo
         vcnXgrWs0ZgQ+0XqxyWbOfTbwljaGBwv1iPjzUZtVzlbT38vLxRq2SlTGG0Jh2kKNMRd
         Efjzu1dLWnSDstFzlLH31ZljvKSM6WKeLGlqDzc/WALTIoB9Nc4Y6F5sPgty5RBoiQPU
         bOgLLCnVXNKW8XbRlcSzseB++bdKDoDUvaDWpnvEDAJSVuzPzwhjpBXEByNF01iskDNU
         Hu7EIg2LbLmHkmLGVZGx1PadYoOpcdkAxN1ru/NEDukWjqgQzIjaf50Hw+bEB8+WapHL
         UDrA==
X-Forwarded-Encrypted: i=1; AJvYcCWshI/YwJcu077gJYPXu5+bRPrvVNC+kjeMuWW7MWaBs38y9fqcelhvSpsAU+NYljneL2hKwsVJYuqvyT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwC430IT1/CDZylCt57o2l6+FwKTJC1BMPwRNv78hqKCT/xTAU
	a0RMlwN12TA0EwZu+JDfgGRFUlL3OfqhRo5xyFVaTFJjSbH0rNGpYt5+0N+Kn0a00ikPYS8rygh
	FRh8PkzQw8LxJI/hs0e8/DKJ8bhAesyyHgwGL
X-Gm-Gg: ASbGncusyMNRs1yOLw8OJfCb5ZjxdylqI7L4u/t2VxvxlMF1HcSp5NarX3J6M5pGjsv
	R3ibEaiJKgxCKZmwXV2tYpY6XhRY39jNlAMxG+TUMtKzX/N1K5uIsqxKOMk5OCW8=
X-Google-Smtp-Source: AGHT+IEcKKrV7NtntOv/HjB/G1zq4DlNB44Pf3+LGaARGt/ovezLGp7A3gf192BysZYg6DvlHdDVPiDTJwrr5ZbymyQ=
X-Received: by 2002:ac2:4f10:0:b0:53e:3a01:cf4f with SMTP id
 2adb3069b0e04-540240c0f8amr1339484e87.14.1733820019366; Tue, 10 Dec 2024
 00:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030070224.1006331-1-wenst@chromium.org> <20241030070224.1006331-2-wenst@chromium.org>
 <CAGXv+5HVy41qee6kwVUeLV_DfA0=wk2X77kv81rBKAZDGE6mww@mail.gmail.com>
 <bbaa0c8f-9702-4252-a674-e46fb51f0a2a@collabora.com> <CAGXv+5GHP1M1rKwR8j+bN8GmpxWtpkfLTnvBdkg5wOvWanc-kw@mail.gmail.com>
 <35392d9d-56a3-4db8-b500-6272d0bd275c@collabora.com>
In-Reply-To: <35392d9d-56a3-4db8-b500-6272d0bd275c@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 10 Dec 2024 16:40:08 +0800
Message-ID: <CAGXv+5H_=He4+vBcaoVbtO05c6hPWV46OTRfR+S8XVuvk_EaYg@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Drop
 pp3300_panel voltage settings
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 04/11/24 14:47, Chen-Yu Tsai ha scritto:
> > On Mon, Nov 4, 2024 at 9:19=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 04/11/24 14:00, Chen-Yu Tsai ha scritto:
> >>> On Wed, Oct 30, 2024 at 3:02=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.=
org> wrote:
> >>>>
> >>>> The pp3300_panel fixed regulator is just a load switch. It does not =
have
> >>>> any regulating capabilities. Thus having voltage constraints on it i=
s
> >>>> wrong.
> >>>>
> >>>> Remove the voltage constraints.
> >>>>
> >>>> Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu boa=
rd")
> >>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>>
> >>> I see that the other three patches were merged and included in the pu=
ll
> >>> request, but not this one. Were there any concerns?
> >>>
> >>
> >> Sorry I forgot to actually provide an explanation for that - yes, I do=
 have some
> >> comment about this one.
> >>
> >> Despite this being a load switch, it's still switching power from regu=
lator A to
> >> target device X, so this is technically still providing 3.3V to device=
 X.
> >>
> >> Think about how a "regular" full-fledged regulator works: you can (som=
etimes) set
> >> a voltage, and then you can ENABLE the VOUT for said regulator (/rail)=
: this kind
> >> of "load switch" does exactly the same as the ENABLE switch for a full=
-fledged
> >> regulator.
> >
> > But it does not provide regulation. One cannot "set" the voltage on a l=
oad
> > switch; one can only set it on its upstream supply, if that supply prov=
ides
> > regulation.
> >
> > IIRC Mark said some years ago that if a regulator doesn't regulate the
> > voltage, then the voltage constraints should not be given. The constrai=
nts
> > are then derived from its upstream supply.
> >
> > That's the guideline I've followed for all the regulator related change=
s
> > I've done over the years. Does that work for you?
> >
>
> Ok, let's go with that then.
>
> There's only one problem - patches 2 to 4 don't apply for whatever reason=
, is there
> any dependency?

I believe they were already applied in the previous cycle? At least
they were dropped from my branch automatically after a recent rebase.

ChenYu

> Cheers,
> Angelo
>
> >> So, this is switching on and off a power rail that is derived from a s=
ource rail,
> >> practically creating... well, a "new" rail, with...
> >>
> >>    VIN=3Dsomewhere-3.3v,
> >>    VOUT=3Dsomewhere-still-3.3v
> >>
> >> Any objections/doubts/etc? :-)
> >
> > I agree with most of it, except the part that I laid out above about th=
e
> > load switch not providing regulation.
> >
> >> P.S.: I'm writing fast, sorry if anything appears unclear, feel free t=
o shoot more
> >>         questions in case :-)
> >
> > No, it's pretty clear, and I believe one of the common interpretations
> > I see. Thank you for the quick response.
> >
> >
> > Thanks
> > ChenYu
> >
> >> Cheers,
> >> Angelo
> >>
> >>>
> >>> ChenYu
> >>>
> >>>> ---
> >>>>    arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
> >>>>    1 file changed, 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi =
b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> >>>> index 783c333107bc..7bbafe926558 100644
> >>>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> >>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> >>>> @@ -35,8 +35,6 @@ pp1800_mipibrdg: pp1800-mipibrdg {
> >>>>           pp3300_panel: pp3300-panel {
> >>>>                   compatible =3D "regulator-fixed";
> >>>>                   regulator-name =3D "pp3300_panel";
> >>>> -               regulator-min-microvolt =3D <3300000>;
> >>>> -               regulator-max-microvolt =3D <3300000>;
> >>>>                   pinctrl-names =3D "default";
> >>>>                   pinctrl-0 =3D <&pp3300_panel_pins>;
> >>>>
> >>>> --
> >>>> 2.47.0.163.g1226f6d8fa-goog
> >>>>
> >>
>
>

