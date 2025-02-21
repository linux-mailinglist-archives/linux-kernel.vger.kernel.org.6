Return-Path: <linux-kernel+bounces-525541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FA4A3F10B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61A63B366D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB9C2046A1;
	Fri, 21 Feb 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkOPN4BG"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307B1EB18D;
	Fri, 21 Feb 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131684; cv=none; b=tOP2U9NobcaTT2lu/8ewwzSbzJ27YvfYlqNQIb/uVMWrgiuZBm21WuvaXBmB7ELK2nG+u7M8onwsdq2o8gSE4/o5vtsXlVGSV0sv5fm1BxHpu2tfyfXNgTLWiDFOYZcwRffRr3koz0N37ngxZminnV8H4vm9LYlCGkHxHyOlTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131684; c=relaxed/simple;
	bh=ro3d+iKXGoqGnuNHlS/fgeOaWF0UBAOH6kPyVBHtOvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAnqCJEQkLWEfoZt5u3SaDK1uH5x28E2hYHsL+tMTF1JVfC7LDwvyjyYkf+xe1ww99ZixBGYHK+5E/+fjWgdbnOst9iLlv3JtlwqwbwBeZw2qEnf+a5pfvgzBHTmV9n+e5fhBAG6tO39hAsggQoiUULtOOIW9HDqehW1Aj/9z2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkOPN4BG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so3481380a12.0;
        Fri, 21 Feb 2025 01:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740131681; x=1740736481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCWLQJXIRaGa+NaKBUA5lVma2HK+tvmrsuX2eAKzx3I=;
        b=NkOPN4BG9MXg0QTCk4CxCM1p6P9kITIMSVAnU0qs3YGkIrR0iGXBLES+tmz9rTKQZc
         7kBzhG3tCWhd5WY0wA4g20bcqsm52KLaFNWCHAv1H6YMY04t4bVbSmUslgp9BXTR6Mny
         QYckUIXRAcULhYpAPf36sH7QnMGF19TIl1vhKwUjAR9/PAp70nmFKi4PEJrrucZHXzm9
         2L1BR36dW8ZMreumuWk18uGZiMW7idv5QjfSy/WzHx9igo436HWvJ6+/BwWyOLBsiyr7
         dSpxbMw4bPRU8vso96gSPkKLsbxQoakBP4teON3nGQkuMqvKnfkqgx/qzc9+qUSvgm8f
         8BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740131681; x=1740736481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCWLQJXIRaGa+NaKBUA5lVma2HK+tvmrsuX2eAKzx3I=;
        b=p1RRB6ApKl0ehiWwMJAswYv/ZWXihj5EMxHYIMYtP3kR9X6NRqUTgJq200LcUntOyB
         XPaKBm3VUOS5mAsRFn3DCQy8T9Ueyp6M4BnHp37SvCPAmfx8Q0WFaSegiSO+k3z45yJc
         UCsIU9AZas+iYgdINVsbl2Au5lNJqxQR09t4gm64Nq4HBhBBGvQbxYBaCD+VoM9CjU6U
         OIg7X/0M7chDAym28/rbqivok9J/BQOidvxPJMrYVgrmjOdOzuqRBY7xclEnv9KroOr8
         9k3UlvJKL4bEQdjph9Fx9Avhw1hYhejYEGGiHJKJVW8bqyWt0VDFusY6UAQYgsDeqAax
         qQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCWBkrAu3RNzEpNxxwQcRwPaxBQskKcbjjMJOW2GGqmFDp36FYD9kNMx0AyOApleIQbknAmGmWsKI/IX@vger.kernel.org, AJvYcCXmHi5XXn1iia/4YFPZRR6l11wLKtZwErhcJl+inih4324IOIADolLYXtcCVH8WhFJZHMk8mT6RK7wBPruH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DS5tJWn/aLOOXHVJlFWIZgGN/a4yVZfwq1fKHhr55tsMXK6L
	I4wsHSelenikf3/CkNyLjN59oCnuEw7T/1dYFoY3u4IJ6QGWTxXvMW3N2gY5OgALURlB6ExM1z1
	96PdRoEYCpotW9WlVRH+n51IvKUc=
X-Gm-Gg: ASbGncsTRsKp4xz/2jxsq9o8cVjGVpQFhVxTlwqwuljdYMwBpSlA9PAjEhNclySOVFr
	+atKi39ujUiIbP4ytAOjAxWpEnLeicD+n2RgQqSXNqgryNBbOBi/UzZWaTgXtOTJHtrQPLXRfMp
	5iAlnmhuA=
X-Google-Smtp-Source: AGHT+IERzieE0HXpOGPr2oPq6V5HcGC9rINMOoagVFBANbqyTomsPjFp0m4XiausshWj0LORrEm4V/CktVu+ZQyj1Kw=
X-Received: by 2002:a05:6402:90b:b0:5e0:6e6c:e2b5 with SMTP id
 4fb4d7f45d1cf-5e0a1261230mr6369087a12.9.1740131680329; Fri, 21 Feb 2025
 01:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118102207.9339-1-simons.philippe@gmail.com>
 <20250118102207.9339-3-simons.philippe@gmail.com> <3229934.fEcJ0Lxnt5@jernej-laptop>
In-Reply-To: <3229934.fEcJ0Lxnt5@jernej-laptop>
From: Philippe Simons <simons.philippe@gmail.com>
Date: Fri, 21 Feb 2025 10:54:27 +0100
X-Gm-Features: AWEUYZlqXqdJfwgEwnpCfDSpt4wrYNSKsocDQVRpSu4fjABOQ7YP3MhnhFElf50
Message-ID: <CADomA4_yMUS_S-YDrQdSKmZrDMwPeakkJBix-r08UFQejTYYcw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] arm64: dts: allwinner: h700: Enable USB OTG
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:38=E2=80=AFPM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Dne sobota, 18. januar 2025 ob 11:22:06 Srednjeevropski standardni =C4=8D=
as je Philippe Simons napisal(a):
> > RG35XX have a GPIO controlled regulator for phy0 vbus, add it.
> > Enable HCI0s controllers and otg for dr_mode.
> > Add phy0 properties to descrive id_det, external vbus, and internal vbu=
s
> >
> > Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
>
> This could work without previous two patches, right?

While this correctly describes the board, it currently doesn't works
as expected.
HCIs will enable the 5v on PHY and will never disable it.
Resulting in a blown regulator on the board if plugged with another host.
I managed to get this working by removing the PHY ref from the HCI,
but this is wrong.

>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> Best regards,
> Jernej
>
> > ---
> >  .../sun50i-h700-anbernic-rg35xx-2024.dts      | 25 +++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-=
2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.d=
ts
> > index 80ccab7b5..5a6ae42de 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dt=
s
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dt=
s
> > @@ -175,6 +175,16 @@ reg_vcc5v: regulator-vcc5v { /* USB-C power input =
*/
> >               regulator-min-microvolt =3D <5000000>;
> >               regulator-max-microvolt =3D <5000000>;
> >       };
> > +
> > +     reg_usb0_vbus: regulator-usb0-vbus {
> > +             compatible =3D "regulator-fixed";
> > +             enable-active-high;
> > +             gpio =3D <&pio 8 16 GPIO_ACTIVE_HIGH>; /* PI16 */
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             regulator-name =3D "usb0-vbus";
> > +             vin-supply =3D <&reg_boost>;
> > +     };
> >  };
> >
> >  &cpu0 {
> > @@ -337,12 +347,23 @@ &uart0 {
> >       status =3D "okay";
> >  };
> >
> > -/* the AXP717 has USB type-C role switch functionality, not yet descri=
bed by the binding */
> > +/* the AXP717 has USB type-C role switch functionality */
> >  &usbotg {
> > -     dr_mode =3D "peripheral";   /* USB type-C receptable */
> > +     dr_mode =3D "otg";   /* USB type-C receptable */
> > +     status =3D "okay";
> > +};
> > +
> > +&ehci0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ohci0 {
> >       status =3D "okay";
> >  };
> >
> >  &usbphy {
> > +     usb0_id_det-gpios =3D <&pio 8 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>=
; /* PI4 */
> > +     usb0_vbus_power-supply =3D <&usb_power>;
> > +     usb0_vbus-supply =3D <&reg_usb0_vbus>;
> >       status =3D "okay";
> >  };
> >
>
>
>
>

