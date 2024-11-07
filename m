Return-Path: <linux-kernel+bounces-399873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C449C05AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8459F283DBF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20A20ADF9;
	Thu,  7 Nov 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXcVzkxG"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED2E1F4739;
	Thu,  7 Nov 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982237; cv=none; b=g4odc737pj47XViWMo7sF6RZMDNQXFW393PfLcXXcgGIQH9YxVlBpAfVvv9nyroY3Q9Vl8ectksr6aa9X03oPY1lEoI0TrUGGow3hKpozR5/ThGqcD2MiWDqtt8C3DR3oQnk4bg0COCAnuouvU0stb2M0cZmO/pTiLgwDYBPeiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982237; c=relaxed/simple;
	bh=lOvVeVs6/OioTgLwwdvhBos+jrtm8bl9raVO7S2lDYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXas5ceq7nqiFDJuddCfxAR99Rp9Q83Ol9bnpQjygFfXHAXbDhxnJW9LZV6ATfHX3wLRLcn2bxRkpyytjoRzTOAGiMHHEA8GWq7q5bYuDKraxyFbDB4AimUHX/ht4SFoLweexYSIff5odBChEDGcD+/8FLy6ednhycfGg5lzRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXcVzkxG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c913aso1433117e87.1;
        Thu, 07 Nov 2024 04:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730982234; x=1731587034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5mEBnJVQCgTXAayGd8aqvDjLlsqmRz+483jS2oi5/Q=;
        b=XXcVzkxGz++EDMv3Tc6NjGcv1+n0y8Ybr2/VmOmJF1/36rEQSopwso7eMf7WEjKjyx
         DL35Pmy11LtIrPT4MNeDtew08d8ShRpUrxyVOyeLHELEUBIgnUgSyPZ+0lNXQgX7L+a5
         7KcsCr8O7kjHUjYgojMHrP8L2x4WQTDX4sD9v6vndhPVcSKJ/MH8rMS6OhrKf/ZIgdcK
         iHrB4dBZnAwY88Vompa2ogNZUWyi65RpbC4rvx95J05JEfpnEtchVdRYsFbfy39ysalJ
         aHiM6pZY5GYrMEVmEeNXFiLQzWmGBBF0UOU1O08+BsqpnAg+mHIJAirdy1EsrXu+az0I
         mBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982234; x=1731587034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5mEBnJVQCgTXAayGd8aqvDjLlsqmRz+483jS2oi5/Q=;
        b=OOBBAJogSrq+jd3wf/IJ3VTEuqQGML6/TiqHWgWgNtub3DGvcHsX27xk9O+rSSisKn
         pE70zRG3HtZdBGKKvA0bGU2Uxt9Z2atTy6XuZPqAgA0Nb0JlEswa0C0sdhxFPTpe4Brc
         WUN1NEbB5CjR7+W7wyuco4ocjxQT7t3DLycb633g2aEExmiNHvI8y/qcw1zCjqaPc6JS
         StpzABAItUpu64l4WNFlyvbaOD+ruWfMkdzXihtpt29fltaM9d/65Hp/cwYpKJbNnTVc
         cNswKs5LTyp2Hg+VQZCIkuk9VjQZVtkcqDPoTVRzsruOCKTC7cgtgUqGqAGFCmdGS560
         jtLg==
X-Forwarded-Encrypted: i=1; AJvYcCVCu9xga/hTIi3qPhMzuB8c8jjFZ7HgeWY6/FK7n1I3/JkHNFKkU58k2vDK+ZDDAJSiEV3qaLBlkyyUXUZr@vger.kernel.org, AJvYcCVHMKPDCMlv6XtghPY566GdhN2ohCrGkv7EbsjIC3/XM9TV0O0XMI/FDDKGUisL5rFbzf9nHdRHGadL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9y9kAvsLNYXlgjdm4pCTr2wXLR1siB5kAexyqMBOSse/RouDj
	9OJsLCi8MfjZscAM53H1Xyg1eCLl1sVot0ktBAHtmfDzCKSgRuKF
X-Google-Smtp-Source: AGHT+IE5NOF+MyMOh9t0PoQGFx/p+V9qIGMTb9aDtyWJG88Z0H59EDALHldmpa4vGm3Ty1CexYNlxw==
X-Received: by 2002:a05:6512:3c90:b0:539:ea54:8d22 with SMTP id 2adb3069b0e04-53b348d2696mr22712509e87.18.1730982233632;
        Thu, 07 Nov 2024 04:23:53 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826aec00sm193887e87.240.2024.11.07.04.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:23:52 -0800 (PST)
Date: Thu, 7 Nov 2024 13:23:49 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <ZyyxVQww6PcYWFJU@gmail.com>
References: <20241107-ondie-v6-0-f70905dc12bf@gmail.com>
 <20241107-ondie-v6-2-f70905dc12bf@gmail.com>
 <5r6j26qwcxyppxicdqih6tskb2qxkb5phzjtwqv47iqb4qupkp@zxujctq7ot6k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GpFM4aHg++qMfh0c"
Content-Disposition: inline
In-Reply-To: <5r6j26qwcxyppxicdqih6tskb2qxkb5phzjtwqv47iqb4qupkp@zxujctq7ot6k>


--GpFM4aHg++qMfh0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 11:17:14AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Nov 07, 2024 at 10:19:54AM +0100, Marcus Folkesson wrote:
> > Convert the bindings to yaml format.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -------------=
--
> >  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 134 +++++++++++++=
++++++++
> >  2 files changed, 134 insertions(+), 94 deletions(-)
>=20
> ...
>=20
> > +allOf:
> > +  - $ref: nand-controller.yaml
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,davinci-nand
> > +      - ti,keystone-nand
> > +
> > +  reg:
> > +    items:
> > +      - description:
> > +          Access window.
>=20
> Merge two lines. See other files how they do it.

Ok

>=20
> > +      - description:
> > +          AEMIF control registers
>=20
> Merge two lines

Ok

>=20
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
>=20
> These two properties are not needed, drop. I don't understand why did
> they appear here. Changelog also does no explain it.

Ok, I drop those.

[...]

> > +examples:
> > +  - |
> > +    bus {
> > +      #address-cells =3D <2>;
> > +      #size-cells =3D <1>;
> > +
> > +      nand-controller@2000000,0 {
> > +        compatible =3D "ti,davinci-nand";
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +        reg =3D <0 0x02000000 0x02000000
> > +        1 0x00000000 0x00008000>;
>=20
> Two items must be encoded as two items, so two <> <>
> Also messed alignment. See DTS coding style.

Ok

>=20
> > +
> > +        ti,davinci-chipselect =3D <1>;
> > +        ti,davinci-mask-ale =3D <0>;
> > +        ti,davinci-mask-cle =3D <0>;
> > +        ti,davinci-mask-chipsel =3D <0>;
> > +
> > +        ti,davinci-nand-buswidth =3D <16>;
> > +        ti,davinci-ecc-mode =3D "hw";
> > +        ti,davinci-ecc-bits =3D <4>;
> > +        ti,davinci-nand-use-bbt;
> > +
> > +        partitions {
>=20
> Where are the partitions documented? In which binding? Don't you miss
> mtd.yaml? I think this binding misses some references, but I am not sure
> which ones.

I thought this covered it?

+  partitions:
+    $ref: /schemas/mtd/partitions/partitions.yaml

>=20
> Best regards,
> Krzysztof
>=20

Thanks,
Marcus Folkesson

--GpFM4aHg++qMfh0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmcsr3IACgkQiIBOb1ld
UjLyKxAAuaB0k58jrWRz6TcX8Bmicff94QbzPurIsl+uRngj83sqmSHvSHqZl0g0
nv+48TxVVK0ZowVop2xs/gR2dUESfOKUz0iuuDmlUYV1ovv3tRDTNxWKgKc7PPEJ
ZvTPBoOyq3VycCkdM49+DHkQFrfkMA26nhS1mEkCwfx1vgSIH0/4YTyw8MX2RfG+
F14bhPCCbtiX2hX+1vS3wxWS48+0RGXEEJp8dps+kHWjdpWS/FPSbnM6pS3nP4EG
2FMuzXeGYLN6hR8l8Zr2pG4v/11UUvSEn6x2/iw2NwFRprSpiOY9nnqo6moQwD3e
2a+ayjLiBXxbXUZ03n95vtgrvhmjoTY7FtKHHeiIVgYzpAoiY8WAk68Z+71ja47g
AhzDyLBTmNqGcc1lRzRfOTeQa9+2MAT1ok3fdDowukOjVq02uBnNgUshaRuxVVY2
39+bJBKi88w6e1I+bVFe2wMqlEDc3znzVe+gHuuy4wIpOkVFRBD0zUwLJkBRt0xV
5/czo53tj7Gzt2+J84PmeSaM5DcIrGwYwK4GJKbvD9cnGUmsDc4stra6fTsVA8Hj
ABQ2KWAnIZkc9w5MdefpGz0CBIfO8uiXhNFL9YqfAvJyXuTjx5Q1VW5m8k5EImA3
oxQj4ZU3I1CnwzzPsfiZihIvkbeMsk4mGL3JBFdh6m91W1iyv1E=
=rTaQ
-----END PGP SIGNATURE-----

--GpFM4aHg++qMfh0c--

