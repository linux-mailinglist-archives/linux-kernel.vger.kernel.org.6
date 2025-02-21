Return-Path: <linux-kernel+bounces-526429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC8BA3FEA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4411692EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18F2512D7;
	Fri, 21 Feb 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VilNrHNH"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F406250BFE;
	Fri, 21 Feb 2025 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162026; cv=none; b=iy02PbHAtNlvKB/+B1QEEAgy5wzMLZGEhVc2UJFr5t7UFGklnMTK0+i7qoeawJ7MxzAUJD8UZxQlfMtYt9jHl+dbPJ7mH0IX+cWJFUNA6UPx39Pc2+mUIHvNlq1uBPZWXuycUywjPu26U312irFW3AD1rZ/bwyAEgOa6QPDDbJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162026; c=relaxed/simple;
	bh=FlMFiPqoPoOO8nzB7qRWFAsrP98gJ9Y3C8ZL+zevz6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPovT6ZBAfiTeqoW/imBspMY6asXwcvvE94SlhaUunodVx3rhVhQ1JLzSVrLvkpptxWYHb9DcoNVL8VDgRlS2dKxZKlzRR0bBF3EIcdexcy6oyaz5LmruOCUMWpfrfyMf7HwkhgO3xKm7KJfZqTglUj2QULg4zy/0bJNCKIM67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VilNrHNH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439a2780b44so15910295e9.1;
        Fri, 21 Feb 2025 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740162023; x=1740766823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veHeZGAsIMfeo9MJB9NRykJz3c6tbQQyeQEGIEl/Nmc=;
        b=VilNrHNHJ+9s3QUdc6kWrDTA9DdPTd94+w7U3M5WT+74lP23Y9jsq9t9ie1v50QUws
         B/dOd/kPTo1OQhGByKIYvAC30ooH3ykDqoJ9x+nRpATWqWPmaZe7HekfbQZLqDCOD8q8
         xh7yLtx/ArFZ/V0A4rITVFYTsL3cgn7Zc1oYGzARG8l68FcOAtl+Ze/6yjRiE90CH+sc
         0f2cZ8OazIP5OxUKT85r8yZYUZKR0jJIGYGVk7rJiPsOIloLqrJQA4fi20kiRw8RzWgU
         As64Aaw2Gy7urBcNsShiNypkSN0QQnrI1OLS0ZRBNyux6S4KQxCO0IsI6zb6/m9MqqEW
         U6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162023; x=1740766823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veHeZGAsIMfeo9MJB9NRykJz3c6tbQQyeQEGIEl/Nmc=;
        b=SA/xBwUyiK3ZmEW3hMnYVTrCJzXWVasWw/sYkbFJDQ5dUhoMX4NIhHJbsgT8oiICVs
         bvTwJyPL65wgEJqaMHOVocdQSuAvtWlClH0mwNDywFVNhIW5ASQYLDfUziHseGNl7eIC
         s0teSH+p2Yey/4BtnceYaRtCdbM7VcvI7JoqeEkiVqLMsp8aAjA6CNT6TyQOLt+iKJLK
         vJi74QcZU2mtRCu+SDLKpjms5j03guCBJVwlV8ZWy1DlP6kIVoWxBstRRfR2e3Shwx+B
         0mPvAW7uHcCf6xWM14dyZR6rybBlQkMH0ibO5Kxst0Bst2Y7qDAjs/gOx7Jh+Yhn40z9
         tZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Rnjqq+bv8AD93eqEmjJc9o43pbA6fijK0zi+I15qyHf8rsmkxUh+rVsax93zX50+Rq6xJAI/PuIp@vger.kernel.org, AJvYcCWCXRPIECsSDn0GXyl2pT5wyLWTfMZgWPIajZWhaM+Ly4kGMkQMdf3x07KdWorgECJGMxD3PwIdCdrqTlp2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wGuCytf2AjEl039QMobKOUuFiBmZE12MpJ+YTCK9eeSPaWk+
	Pg4A7y4tHlGUDhd5nPKMD7/fFDnYSfMmL0pOAPA+F6xqP8z1R7BI
X-Gm-Gg: ASbGnctCP6fu/b2Qiu8ZkXCfOl3YGC/uWmoLAYSMvzed8BN4vL2BWCH1lPMWFxZ/gXS
	DiotnidehZ61N/c28DU3LERFNZ4sdHO7Un69TKFYqWpouAWbB2AH/ompYQdRWhnK2B1kAl9XOot
	8sM6AoKl7JqEMnH+6wwWDEPGDJqVfH5aUOWC+HEtDUOX/sW9ahTWIJiPgOo5xvhn8Lcevy+Acfh
	/HAEU6+4YaOso6hOEQ5EhF2xMYfzH3dGIGl9CluRDBCmWYQTEwv5ptJoxRTD/Va+wp1yxO3wwXa
	9ta179dPfq3+PTp4pi8FMcyzcD6hKIDnmTNBim0ACA+URw5oJ+VdY+njwMTrZDr8cQol9vth5a4
	+Nw==
X-Google-Smtp-Source: AGHT+IG5DSiVWK86jS+eT9SXqpVSAsqf+fVk2fzSBX+ycmlA1PLgE8RCGQ9E1+kLqZ2oPVb+Mg5AIg==
X-Received: by 2002:a5d:5f83:0:b0:38f:4e6e:22 with SMTP id ffacd0b85a97d-38f6f0d1c7emr4036180f8f.48.1740162021124;
        Fri, 21 Feb 2025 10:20:21 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm24489778f8f.64.2025.02.21.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:20:20 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] arm64: dts: allwinner: h700: Enable USB OTG
Date: Fri, 21 Feb 2025 19:20:19 +0100
Message-ID: <8490202.T7Z3S40VBb@jernej-laptop>
In-Reply-To:
 <CADomA4_yMUS_S-YDrQdSKmZrDMwPeakkJBix-r08UFQejTYYcw@mail.gmail.com>
References:
 <20250118102207.9339-1-simons.philippe@gmail.com>
 <3229934.fEcJ0Lxnt5@jernej-laptop>
 <CADomA4_yMUS_S-YDrQdSKmZrDMwPeakkJBix-r08UFQejTYYcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 21. februar 2025 ob 10:54:27 Srednjeevropski standardni =C4=8Das=
 je Philippe Simons napisal(a):
> On Thu, Feb 20, 2025 at 9:38=E2=80=AFPM Jernej =C5=A0krabec <jernej.skrab=
ec@gmail.com> wrote:
> >
> > Dne sobota, 18. januar 2025 ob 11:22:06 Srednjeevropski standardni =C4=
=8Das je Philippe Simons napisal(a):
> > > RG35XX have a GPIO controlled regulator for phy0 vbus, add it.
> > > Enable HCI0s controllers and otg for dr_mode.
> > > Add phy0 properties to descrive id_det, external vbus, and internal v=
bus
> > >
> > > Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> >
> > This could work without previous two patches, right?
>=20
> While this correctly describes the board, it currently doesn't works
> as expected.
> HCIs will enable the 5v on PHY and will never disable it.
> Resulting in a blown regulator on the board if plugged with another host.
> I managed to get this working by removing the PHY ref from the HCI,
> but this is wrong.

Ok, so this patch shouldn't be merged until USB patches are in.

Best regards,
Jernej

>=20
> >
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >
> > Best regards,
> > Jernej
> >
> > > ---
> > >  .../sun50i-h700-anbernic-rg35xx-2024.dts      | 25 +++++++++++++++++=
=2D-
> > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35x=
x-2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024=
=2Edts
> > > index 80ccab7b5..5a6ae42de 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.=
dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.=
dts
> > > @@ -175,6 +175,16 @@ reg_vcc5v: regulator-vcc5v { /* USB-C power inpu=
t */
> > >               regulator-min-microvolt =3D <5000000>;
> > >               regulator-max-microvolt =3D <5000000>;
> > >       };
> > > +
> > > +     reg_usb0_vbus: regulator-usb0-vbus {
> > > +             compatible =3D "regulator-fixed";
> > > +             enable-active-high;
> > > +             gpio =3D <&pio 8 16 GPIO_ACTIVE_HIGH>; /* PI16 */
> > > +             regulator-min-microvolt =3D <5000000>;
> > > +             regulator-max-microvolt =3D <5000000>;
> > > +             regulator-name =3D "usb0-vbus";
> > > +             vin-supply =3D <&reg_boost>;
> > > +     };
> > >  };
> > >
> > >  &cpu0 {
> > > @@ -337,12 +347,23 @@ &uart0 {
> > >       status =3D "okay";
> > >  };
> > >
> > > -/* the AXP717 has USB type-C role switch functionality, not yet desc=
ribed by the binding */
> > > +/* the AXP717 has USB type-C role switch functionality */
> > >  &usbotg {
> > > -     dr_mode =3D "peripheral";   /* USB type-C receptable */
> > > +     dr_mode =3D "otg";   /* USB type-C receptable */
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&ehci0 {
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&ohci0 {
> > >       status =3D "okay";
> > >  };
> > >
> > >  &usbphy {
> > > +     usb0_id_det-gpios =3D <&pio 8 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP=
)>; /* PI4 */
> > > +     usb0_vbus_power-supply =3D <&usb_power>;
> > > +     usb0_vbus-supply =3D <&reg_usb0_vbus>;
> > >       status =3D "okay";
> > >  };
> > >
> >
> >
> >
> >
>=20





