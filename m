Return-Path: <linux-kernel+bounces-251507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFB19305AC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2669E282873
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61913210F;
	Sat, 13 Jul 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WXgmwa1o"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDB131E2D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720875523; cv=none; b=OFd/ReZ8L1/eAesB3yyGGSBajhtALNEi+9Xoy5dbm+2vq6n3ntJg1BgQ44st3Ojx4CffhWQhh25hmkwVxhTqABxizAbkYyiPI6kGnVeUWQ+xpmO0aQHQ8KRXtGNUlORSq4RACH3DPZ7hArWnVKDMn6FlM1yNnbZ/Acfhjm/mny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720875523; c=relaxed/simple;
	bh=WAquGU1sAv0NQOiFQhQCK/WB0bF5GrpFisW+DKCCuOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7OalIdMxRGFDp1Fuxw/RkPTv/cxsOOLySfgYfvBOrNIRHjUdZGoSxq5FruQfU/5xiYkmjl8sH4KxGbxTm0tbzlKHAdsuM5y/F8dIpiQ0SQAPm3YNKWeNUHiDOaxBQwBnTUrju457rOqV2k6+sKFDaNvpAFWQxzfk5XjNJlWU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WXgmwa1o; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso3650342a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720875520; x=1721480320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vmUQWDwVUQYFm+xuW2pF4/BnR+RAgeFcmOR+FIC/lg=;
        b=WXgmwa1oP4aaIFVrDwU1dm9AFmIkCCTH5qs4U0ICLnvKVecYwtpKUl6uYg2hVN/TsM
         696sQGQONuSL8kuU5ilI1GTa1m98Sb2R+Z+MU13jYHJQrasc14TrWMGU/hOJHO5lzMoQ
         3eQTR1WAuOcWT2PW0TPP7Dr3FAmZCuPGZGhul86Ad5ZnHoTn1cn8whjb6MJNoZr1cOAP
         qiNve6enVxq92gtvJjHYuVUbUnGnYtXdKCaAkb8Shv3d3dKd9aVsinBHKq9ouGWA0tbg
         nHm9zt23F87krPS/rMGM+mOU3OOiGai9kmCuxLw6PMp5Ss4Ugnjch4BKD8NBYe6LhCNJ
         6sVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720875520; x=1721480320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vmUQWDwVUQYFm+xuW2pF4/BnR+RAgeFcmOR+FIC/lg=;
        b=I+v/X/xjQKz3uAcPUCQi7qdokY+whndAyngaYCpGy0PaGrpjAC2v1TWoVPaHR9rEBk
         B+bSyOrWX5rkzIGUTMiZWQHrZdtORO4lKLVDlKuk3OufhGy9rFkWjt+VRTXXG+W4wB2N
         ygxpbyfIzEV/40gZJt3rmeQgGrHsod+DaeAdrai+we3BWoouDCVG+crDu1STFk28JM8S
         wRPgQFTLFBOTMMKZ1g0UxDhyhYI7qXBw8qdeuZ5Agnc9ixEe1wyESSHA34XMon0M1yfb
         TrU8fPGl+Lx2dgE6ZxCgOW32gcaQ3sycLChq1SEUL7/JESGdKjtDERMvwGIcg+1AHIjt
         xWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiwWEtKTNHlygthjKOUWAGjwNbG5x06wlhN6Oa/7zw2oYTpSNAKNNL+caW6+3TzRa8QwQdeJkw/V/3aD8EdJuXnNWTY0wGkVaTHQME
X-Gm-Message-State: AOJu0YyjYhd24A1UwRuu4HiazWqdAzBsPqfllfVI2uxcodRSVIxe2SoD
	XRwNwZr9Kn3atlNBEShwLwRp9YpUbTdaS+8gqW433NPWi6xiKU7Go9FEjWq7rXo=
X-Google-Smtp-Source: AGHT+IE8wLD/Rbqxem5MwJOVkSSIYdsvSdPnmm+cu+yuuQej1nhyJW0GbSd3h+h9V0sEUnfR/NKrAg==
X-Received: by 2002:a05:6402:26c6:b0:595:7640:ee79 with SMTP id 4fb4d7f45d1cf-5957640f148mr10139310a12.17.1720875517634;
        Sat, 13 Jul 2024 05:58:37 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255263ecsm740996a12.44.2024.07.13.05.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 05:58:36 -0700 (PDT)
Date: Sat, 13 Jul 2024 14:58:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Aleksandr Shubin <privatesub2@gmail.com>, Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 5/5] dt-bindings: pwm: sun20i: Add options to select a
 clock source and DIV_M
Message-ID: <e7dvk2g4ymz527tklywy2elka4ndzvftfujobnjmfdepgt3lm5@dzex45st2wya>
References: <20240531141152.327592-1-kikuchan98@gmail.com>
 <20240531141152.327592-6-kikuchan98@gmail.com>
 <851280ad-ac0e-47d1-99e2-4f3b5ea29f2f@kernel.org>
 <CAG40kxEbMQc-ni0HDVR7rtj48aFu-jz8sYUAO+fdmZSmXWrizw@mail.gmail.com>
 <da382d43-fa82-44c0-9630-086f59e6efa2@kernel.org>
 <CAG40kxHKdC=uwyWzsBo1LTAXARDQGs0N4TBdD5nE1zhos48cbg@mail.gmail.com>
 <20240603010912.44b99988@minigeek.lan>
 <CAG40kxETZBO1-UBr=rqEu0uWrfOe74k-M12qW7Rg_kX8U32UPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uowver6aitbe3emx"
Content-Disposition: inline
In-Reply-To: <CAG40kxETZBO1-UBr=rqEu0uWrfOe74k-M12qW7Rg_kX8U32UPg@mail.gmail.com>


--uowver6aitbe3emx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 03, 2024 at 05:42:08PM +0900, Hironori KIKUCHI wrote:
> 2024=E5=B9=B46=E6=9C=883=E6=97=A5(=E6=9C=88) 9:10 Andre Przywara <andre.p=
rzywara@arm.com>:
> >
> > On Sun, 2 Jun 2024 15:15:13 +0900
> > Hironori KIKUCHI <kikuchan98@gmail.com> wrote:
> >
> > > > On 31/05/2024 19:57, Hironori KIKUCHI wrote:
> > > > >>> ---
> > > > >>>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 19 +++++++++++=
++++++++
> > > > >>>  1 file changed, 19 insertions(+)
> > > > >>>
> > > > >>> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,su=
n20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.=
yaml
> > > > >>> index b9b6d7e7c87..436a1d344ab 100644
> > > > >>> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pw=
m.yaml
> > > > >>> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pw=
m.yaml
> > > > >>> @@ -45,6 +45,25 @@ properties:
> > > > >>>      description: The number of PWM channels configured for thi=
s instance
> > > > >>>      enum: [6, 9]
> > > > >>>
> > > > >>> +  allwinner,pwm-pair-clock-sources:
> > > > >>> +    description: The clock source names for each PWM pair
> > > > >>> +    items:
> > > > >>> +      enum: [hosc, apb]
> > > > >>> +    minItems: 1
> > > > >>> +    maxItems: 8
> > > > >>
> > > > >> Missing type... and add 8 of such items to your example to make =
it complete.
> > > > >
> > > > > Thank you. I'll fix it.
> > > > >
> > > > >>
> > > > >>> +
> > > > >>> +  allwinner,pwm-pair-clock-prescales:
> > > > >>> +    description: The prescale (DIV_M register) values for each=
 PWM pair
> > > > >>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > > >>> +    items:
> > > > >>> +      items:
> > > > >>> +        minimum: 0
> > > > >>> +        maximum: 8
> > > > >>> +      minItems: 1
> > > > >>> +      maxItems: 1
> > > > >>> +    minItems: 1
> > > > >>> +    maxItems: 8
> > > > >>
> > > > >> This does not look like matrix but array.
> > > > >
> > > > > I wanted to specify values like this:
> > > > >
> > > > >     allwinner,pwm-pair-clock-prescales =3D <0>, <1>, <3>;
> > > > >     allwinner,pwm-pair-clock-sources =3D "hosc", "apb", "hosc":
> > > > >
> > > > > These should correspond to each PWM pair.
> > > > > This way, I thought we might be able to visually understand the r=
elationship
> > > > > between prescalers and sources, like clock-names and clocks.
> > > > >
> > > > > Is this notation uncommon, perhaps?
> > > >
> > > > It's still an array.
> > >
> > > Oh I understood and clear. Thank you.

For clocks there is already a binding to assign a working configuration.
assigned-clocks, assigned-clock-rates and assigned-clock-parents are the
relevant properties. If you create a clk from the parent clock selector
and mdiv, you can stick to the existing bindings.

> > > [...]
> >
> > So I understand the problem, but I don't think expressing this in the
> > devicetree is the right solution. It seems like a tempting pragmatical
> > approach, but it sounds like the wrong way: this is not a hardware
> > *description* of any kind, but rather a way to describe a certain user
> > intention or a configuration. So this looks like a rather embedded
> > approach to me, where you have a certain fixed register setup in mind,
> > and want to somehow force this to the hardware.
> > Another problem with this approach is that it doesn't really cover the
> > sysfs interface, which is very dynamic by nature.
>=20
> ... Indeed. You're right.
> Now I've realized it was a bad idea.
> It should be done in sysfs or sysctl perhaps.

I don't think a driver specific knob somewhere is a practical solution.

Best regards
Uwe

--uowver6aitbe3emx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaSefgACgkQj4D7WH0S
/k4PpQf+JL1igIDXxEuQOrrhdPtcCKOdnbzUcXc+5O9UEjZtnLuPHQl7QQwJlQlE
hdaGoTu19JrWCqs6c2NBp7Bfvudj9NxreEMVkZoWwneCx8FlpJ4Ize5UPUSJKM/S
UQsh2krG6bGultPD95aHLU0y1xAlgosDgBt1LNnBEADuXFsoQDJwalzjsV6pCiNI
YBk0rdnq2CA1F6821F1qDQxo/0HwaYD8li3/88pPJwk0chy1GghP+rQs14lanT0c
p5aPUo5lgT9FX0kamw2LKClegbbmGiXVqzdquxyEvZXGVCOs03RMfp87X9TqSYvd
X6oU4c5oER1lPKnzIbBMXuhAjzFr/Q==
=09cS
-----END PGP SIGNATURE-----

--uowver6aitbe3emx--

