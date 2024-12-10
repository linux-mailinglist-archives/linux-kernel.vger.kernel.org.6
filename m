Return-Path: <linux-kernel+bounces-439603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DEB9EB191
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056ED287F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275DD1A76DE;
	Tue, 10 Dec 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gam0r8F7"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C91A2C27;
	Tue, 10 Dec 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835693; cv=none; b=ovh2/khS+VRduecJjBFUB4Mc/k0NqPcTcGLGQvdajaXH4U4FUrMuW6MFHgqG8T/UzAw6eilH6UcGjJ9LGi+DCMk9vuzqaOEJX8YCzPM8LLa2jxn9efbxZpbP3eFdK4mKINFsMjYKMZ22+Y6Vb7KjglMSLqrSJibukigOCvKVzPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835693; c=relaxed/simple;
	bh=+1F7aJOJ1TMYq5pyz+fERh5c1C50Hm3OQbpLRtwiZtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aauh8Gtrx+n70MHrQrGjIKAugkQK4EeUvt9wqCg7itO/H4T9mopk5kGwQKIl2fKEVBE91VqvSf88qdmFqywSTFbk9DZUHRPaDg/RHRGg+HbYA56ONDiwUH+gWTe3cSJYSxz5oSstSR3Ft/wy/pvyA8533oRhqBDxuKgmfjbKCI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gam0r8F7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so898568466b.1;
        Tue, 10 Dec 2024 05:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733835690; x=1734440490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHLLYUb5aKmiYBywLpOydX2GHG7acjnCRadd5iwWBCE=;
        b=gam0r8F7CCQRMZCqRoSuiOApBDYARPlei0qPcdfV4CdwCrUSMXlpQ+YrdrK75yMNUg
         eR1FCNZi36Mjzj0UbeL5ChMD5TJeOc0TkAPUT9ANQvzqSlN0ZDesEuH8tLuDj0+u6kaP
         DWf5acKGrGboQ2aT5z0CCFEU0qqiHqsT6fF+TdaEzOYqK4hF55pRF4dwzexbQUjr1BdQ
         xcNDoCpYACnAoaaMbWwvW3Bfzixb8TnyjdBGhrE4amu82m57KsUn5KDAo7AmHy3FpBt7
         uAKjNtnBcAXoABr92DoqFXO8anm2MvIHMD1VHqo9owtpHrY5GaGkr377Lz+dE3xBHP+s
         THfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733835690; x=1734440490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHLLYUb5aKmiYBywLpOydX2GHG7acjnCRadd5iwWBCE=;
        b=jVr2DRx2xMRo70AqCt+1OZhETnlbrEjoGb+M4VvDmO+GndEd6ynWbXDvmyF0rDuFWn
         SeXCQH75G68AHD1G6mkbMZ0RONjyOLE7WeuZ2jNd8TCiIQu9LhYdimRgv7h8D0vcj3pX
         GdvFf7A6GVmmAT8nmIpD8oVEyu6/CKSv3kyzT387GG3RV9WQH0+/p+HLHW5HiqgEMsVu
         QRyAOgZUEeSAsIPlxN+6t5yEUEYUpAzAn1SF4WaQu2/35XjftxCNn37j/O5yq3XZBf/9
         fCFqPVZ9pUYdU21kCIMjYAFBAxNflbiq5bcsv7AaFEfZZVDskP5+GsTCXJsP/iNRQPR8
         Rcng==
X-Forwarded-Encrypted: i=1; AJvYcCV4CbekqQFBx+EWphLDtSVTyd6iMmYIMLwu5A86Dmo8CE0inpED06GFz+9sFbr0VEm9mkdmwnGm6I63@vger.kernel.org, AJvYcCXU7bf1Bp7bzEyPj66SGflqhMAzMEswzPhcAMwNzI3w+xeN/6aGriHVTqR0aE67J3j+BvxUXdfLs1iPRsa8@vger.kernel.org
X-Gm-Message-State: AOJu0YyiR3snfUmrua8pa3o+pkPgfgJxGo8BgGRk5Aabh72D3GmVaowV
	FLDOXkFln4BeP3Hl+4aaLQ6N/S65ED6iejHAblmFaIeCxlk38S+xo3MNkwqY+MOZjroy9nraB1n
	+/46/YmOMGvwf/exY7WfrFAQ91lc=
X-Gm-Gg: ASbGncsGfUXpFLn9Xqt5WF1zDrc/vJDaNOh0fG6Ul2CDoKTAtjVZmviuMUobz2qzrB3
	kyaVByb3x62CpLCAue7mF42kSarYF4oFeczxtRpxEw78BYcQKEzrSbqohpNw=
X-Google-Smtp-Source: AGHT+IE+3dBsg9ycaXlihQEkFOTl6FWUvTA1IQqCmYlgGVvNU9+J2ICqAS0Ely7TDkGOnJtbTgHRvmD88oh1lqiohSs=
X-Received: by 2002:a05:6402:234f:b0:5d3:ba42:e9fa with SMTP id
 4fb4d7f45d1cf-5d41853edb2mr10277905a12.16.1733835688916; Tue, 10 Dec 2024
 05:01:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210013010.81257-1-pgwipeout@gmail.com> <20241210013010.81257-6-pgwipeout@gmail.com>
 <14451790.lVVuGzaMjS@diego>
In-Reply-To: <14451790.lVVuGzaMjS@diego>
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 10 Dec 2024 08:01:19 -0500
Message-ID: <CAMdYzYquzAnwbUidBjif3OXOcLaGD+3GdB79Op94BCno2ZtBAQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: rockchip: correct rk3328-roc regulator map
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Levin Du <djw@t-chip.com.cn>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:54=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Am Dienstag, 10. Dezember 2024, 02:30:09 CET schrieb Peter Geis:
> > The rk3328-roc-cc input power is sourced from a micro-usb port, while
> > the rk3328-roc-pc input power is sourced from a usb-c port. Both inputs
> > are 5vdc only. Remove the 12v input from the device tree.
>
> full stop. Please don't do "While we are at it" commits.
>
> > While we are at it, add missing voltages and supply to vcc_phy, missing
> > voltages to vcc_host1_5v, and standardize the order of regulator
> > properties among the fixed regulators.
>
> This second part wants to be its own commit :-) .

Thank you, you're right I was torn between doing not enough and doing
too much and ended up doing both. Thinking about it now this should be
at least three patches:
- Power input
- Drop the phy regulator (it's directly tied to vcc_io, not a separate devi=
ce)
- Cosmetic changes.

Thanks again!
Peter

>
> Thanks
> Heiko
>
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
> >
>
>
>
>

