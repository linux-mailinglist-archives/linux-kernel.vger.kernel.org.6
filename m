Return-Path: <linux-kernel+bounces-439607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D329A9EB19E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC43028118E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3001A9B31;
	Tue, 10 Dec 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWu0Ia92"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A41A704B;
	Tue, 10 Dec 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835895; cv=none; b=k6WpLSij5kXDz+1KqHv/NACj572aCL/jF470ux0pkk5Jwv2FQQKTvh645DuD0DM17e81K6iAaMoxd0yc9opuPtLj11CUcViU+7TIN0u6jng2hzr7tLQL9dF9UVeBIyZn5JKNYlJOsyVXWS/xqIybRiFQ6Z5raxLO55AKd+Ki1FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835895; c=relaxed/simple;
	bh=8nlFARXiVAKvVIZeqdP6oquFiad6aJqyE1rn65yysQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGeyzft/UHMTzS8ohqu3wmw0KAAez9YGjF4leLacAOrsZCXwxb3On5jTQZ9uawyyiWG58cYY8sicyUcG/Vg8i6bq5gpZVXP9mza2hqrxFuJbJj7XbwZZTGH4GDajiXVardSIVjqO/2NJbW6TES1GAHwSJDI5Rya7G1nDNzt1bKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWu0Ia92; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso7919010a12.0;
        Tue, 10 Dec 2024 05:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733835892; x=1734440692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYMf51hbwh0y4SlVLJRmvMBBa3wNftbLie6alipMgHM=;
        b=SWu0Ia92inZeD3xUqAL+ggxXVdKAmVXyVojua9TNsm/41FtO6JySnT0AJ4Mygq9yDF
         vLJzM+gOP8fWQKRNnhtKlpfHma/SZ5W9Dv12+G2/ummzwKcYqAhkWYIpFu0QWiVeb6hA
         7ccv8cSkkeSedopk/k1TxCCb6/suz/jZQAvk5LprdvIbEh8hXuVcroEEOckH+ziuE+D8
         J/ymeO6w5kQH9czRCDk11tr4KmNv7nIEPDvCbI1WIR0vmyAHc6UARCVgrkfbQK6yXEau
         I3WNtXt5E5ZAJdsr6BgozPEz4RuYf7rXZLlsNFAUrSqucsVzDxco1ucSwaRXA3AvY6F6
         b37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733835892; x=1734440692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYMf51hbwh0y4SlVLJRmvMBBa3wNftbLie6alipMgHM=;
        b=bbB8rYymvXpXu1VrUK6EZwA1TbON2wMJy0xtgzVtkWT2gttHIOUatatJokT512lCbI
         iIsrwsggSQHuz4va/HZkLPjQSqUk7RP/AygzIF8PwVoUtDlR/RT/Zat+SfFs5qplmgEu
         EXFS1D6I8L/MPjwSvBcoohA5zo6nasrvWYjXRdpfQNSW5AWPoUh3fsL5wILRP4/U2qon
         pIrXcN1nJOIFv+iNlGJyqhOStTO7h840ykZzPE93RvR5DXWa6s6IHyCUEy4j5v3ylx0m
         zMwPOX2OmvwYzRQQ/8z21fysFW2Cs7m/0ggZGEx2ZM9fNX2PhMUqqUJjZTF7bxurr1SX
         ujtw==
X-Forwarded-Encrypted: i=1; AJvYcCWOktyf2PCzJttcZJmICHCnCuGgtCzYxZrVnmxqz1jsOY8lm+Qns/emFR+LezMFChc8ZU4FR1UW0tPyIJFA@vger.kernel.org, AJvYcCX0ov/DMXBOGveL+1JjATo34UFinPIhNcQX+04KwHJejz9zh0OnBvO82PEjk47THunER6giRIB0NFeE@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2vu1v26c18Z4cdKjhjl2H4WZsjjBQNgrrtbJv3aKkparmgxw
	hoFCgTI/dNlaj144X84H6B+wBTBEIjjJhDyNiskRuRfAsyBz4Pu+iFQGxJvj/cVy0JWY8j7zUWY
	wpmCoUbMf0QKSBJ9iTjtLF76uzK4=
X-Gm-Gg: ASbGncsrK9vC6F5WCw/Cnt+Y3MTsfi2X9y+YKBoRvDPXyTDkFY8WPOOUWLU1lZnRCA/
	YJbAjdxWAToaW5m2S7D6JMOYHp/xc66va+SE02Dn2jXRMPSDbofdTsCF6STA=
X-Google-Smtp-Source: AGHT+IGICcjixAzI2SIhHHtwX1o19IzdeFrNyrwuHTNzsJc3Mbcq6z2Y41yDiwu7RsNEQv44rmtawJBTP3F2DCV1BXs=
X-Received: by 2002:a05:6402:4005:b0:5d0:bdc1:75df with SMTP id
 4fb4d7f45d1cf-5d4185ff932mr5610289a12.24.1733835892180; Tue, 10 Dec 2024
 05:04:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210013010.81257-1-pgwipeout@gmail.com> <20241210013010.81257-6-pgwipeout@gmail.com>
 <D67ZJ6MOM5TH.2WBYCCU20DDJO@cknow.org>
In-Reply-To: <D67ZJ6MOM5TH.2WBYCCU20DDJO@cknow.org>
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 10 Dec 2024 08:04:42 -0500
Message-ID: <CAMdYzYorTNiAybGhPu0u_YPj2J7qxCO72KBU1ozTde+2zK9Hxg@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: rockchip: correct rk3328-roc regulator map
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, 
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Levin Du <djw@t-chip.com.cn>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:31=E2=80=AFAM Diederik de Haas <didi.debian@cknow=
.org> wrote:
>
> Hi Peter,
>
> Thanks for this series, I already saw some familiar error msgs
> mentioned, so will try this series out soon (tm).
>
> On Tue Dec 10, 2024 at 2:30 AM CET, Peter Geis wrote:
> > The rk3328-roc-cc input power is sourced from a micro-usb port, while
> > the rk3328-roc-pc input power is sourced from a usb-c port. Both inputs
> > are 5vdc only. Remove the 12v input from the device tree.
> >
> > While we are at it, add missing voltages and supply to vcc_phy, missing
> > voltages to vcc_host1_5v, and standardize the order of regulator
> > properties among the fixed regulators.
>
> Big fan of standardization :-) ...
>
> >
> > Fixes: 2171f4fdac06 ("arm64: dts: rockchip: add roc-rk3328-cc board")
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >
> >  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 23 +++++++++++++-------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/=
boot/dts/rockchip/rk3328-roc.dtsi
> > index f782c8220dd3..6984387ff8b3 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > @@ -24,22 +24,23 @@ gmac_clkin: external-gmac-clock {
> >               #clock-cells =3D <0>;
> >       };
> >
> > -     dc_12v: regulator-dc-12v {
> > +     /* fed from passive usb input connector */
> > +     dc_5v: regulator-dc-5v {
> >               compatible =3D "regulator-fixed";
> > -             regulator-name =3D "dc_12v";
> > +             regulator-name =3D "dc_5v";
> >               regulator-always-on;
> >               regulator-boot-on;
> > -             regulator-min-microvolt =3D <12000000>;
> > -             regulator-max-microvolt =3D <12000000>;
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> >       };
> >
> >       vcc_sd: regulator-sdmmc {
> >               compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vcc_sd";
> >               gpio =3D <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
> >               pinctrl-names =3D "default";
> >               pinctrl-0 =3D <&sdmmc0m1_pin>;
> >               regulator-boot-on;
> > -             regulator-name =3D "vcc_sd";
> >               regulator-min-microvolt =3D <3300000>;
> >               regulator-max-microvolt =3D <3300000>;
> >               vin-supply =3D <&vcc_io>;
>
> ... but why not put regulator-name as the first of the regulator
> properties as is done in the rk3328-rock64.dts ...
>
> > @@ -50,22 +51,25 @@ vcc_sdio: regulator-sdmmcio {
> >               states =3D <1800000 0x1>, <3300000 0x0>;
> >               regulator-name =3D "vcc_sdio";
> >               regulator-type =3D "voltage";
> > +             regulator-always-on;
> >               regulator-min-microvolt =3D <1800000>;
> >               regulator-max-microvolt =3D <3300000>;
> > -             regulator-always-on;
> >               vin-supply =3D <&vcc_sys>;
> >       };
> >
> >       vcc_host1_5v: vcc_otg_5v: regulator-vcc-host1-5v {
> >               compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vcc_host1_5v";
> >               enable-active-high;
> >               pinctrl-names =3D "default";
> >               pinctrl-0 =3D <&usb20_host_drv>;
> > -             regulator-name =3D "vcc_host1_5v";
> >               regulator-always-on;
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> >               vin-supply =3D <&vcc_sys>;
> >       };
>
> ... and was the case here?

That's fair, thank you. I like the alphabetical approach, I'll go that
way when I split this out.

>
> Cheers,
>   Diederik
>
> >
> > +     /* sourced from usb input through 3A fuse */
> >       vcc_sys: regulator-vcc-sys {
> >               compatible =3D "regulator-fixed";
> >               regulator-name =3D "vcc_sys";
> > @@ -73,7 +77,7 @@ vcc_sys: regulator-vcc-sys {
> >               regulator-boot-on;
> >               regulator-min-microvolt =3D <5000000>;
> >               regulator-max-microvolt =3D <5000000>;
> > -             vin-supply =3D <&dc_12v>;
> > +             vin-supply =3D <&dc_5v>;
> >       };
> >
> >       vcc_phy: regulator-vcc-phy {
> > @@ -81,6 +85,9 @@ vcc_phy: regulator-vcc-phy {
> >               regulator-name =3D "vcc_phy";
> >               regulator-always-on;
> >               regulator-boot-on;
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             vin-supply =3D <&vcc_io>;
> >       };
> >
> >       leds {
>

