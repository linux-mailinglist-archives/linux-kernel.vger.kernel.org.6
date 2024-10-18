Return-Path: <linux-kernel+bounces-371323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53599A399F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580B41F27B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0433A19048F;
	Fri, 18 Oct 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMgmeiRO"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E516188CC6;
	Fri, 18 Oct 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242765; cv=none; b=NcIqymvvjEd3tFq4CSz37rGo7aLFUUNzSuWpkdW7lKYFUEpmlIpbTZ2t4nR8pAUxuq8c6S3E+aXP32Hr+XEN1IQHNm7cl7fooeusSrR61pe/pi1swc87BuN8Rj40IafXGEGx/O4DAERmfd6wMKU4b44/yn8/6+qD7jx728jX5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242765; c=relaxed/simple;
	bh=Vmt/tLCKPp05m/LExD5dAuzin4PuAy8xz8gx/rMI53w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTURZLsH8Olm9ygRB7rm8BsMmg5p9BmwAY1yhZQjr6PUtIOz1+D+tUr0nylaievf3Kr4U9mxDCuHN/ddn+vq36rte16WQSPoNPoZ1vO9524ESgNctt62RQOpklSIxcUZUVma3qlCmFzPc9fjJmAa9Kvq99pWEnsW8e+NUQB1xMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMgmeiRO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f2b95775so2371548e87.1;
        Fri, 18 Oct 2024 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729242761; x=1729847561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ym2XxYPta4PmjeInIbnDM1RgCbJY0OW1VeC9meShLg=;
        b=UMgmeiROcNxdPzLeuiIFt7caLzklIUP+Iwz4v0euX17Kcaxvt2Qrpp8FGPrkCY6LbR
         jyq24sDC6tdulyDPZPaWKygX66tU80t+fTptyKon3iqun49SJUBbAwe2ZBaFaZNc+bza
         gbzWOOokAZZPpuw5VdnMmi1MAyRGnR9IJVwd6IJoK1Ow5MHedjtlKGyrWbdRf6OeEgQS
         nY1iSQWj57Lni+RjmLWr5l5mZcxi0vcfYoMbYeF7Bf/PqP/wU3jrDv/awOaHm3xIntma
         n/+X/c1CbIv92pUDxPhQ3cyppknH3hP5L9FVHlrJog2sMC496gjsfEXiIVilOfQxznz2
         D0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242761; x=1729847561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ym2XxYPta4PmjeInIbnDM1RgCbJY0OW1VeC9meShLg=;
        b=d/X6B12CZ4jF/5VvHlfXOiykGAniuBSiXMdrAq2SCDyFhCG0uWSrIf/4Qy+Fx6TVit
         OXlREMuXRJZhZMdrioP7oAGxSCrPftzVd54V3TysS/tZYEeV0SmTWNFElGQqe8ajcjVl
         WNezESCd6rr3w72Rq78QHWKleTb11XA8wUEni3fc3Wk0OZhIuwLQ/aQNXkFKL+UPg56H
         yauGD5BJz4q0Ikw0Mk6WMSezb7DfxZV1X1t3EUOYS5MmDqtVNOH4v4KsVr/JMwTvmdHa
         Jf2vkP9BO6r2fOXZAAG5mFmMAdt05HREBPW8IbMdN+STBUl5v9KfSnAnxsbfLxt/o2Ol
         /Q3g==
X-Forwarded-Encrypted: i=1; AJvYcCV/K9tXJwimu+5I4uPMVknzMhlLd3ljWr3XUMtcTw26eNTN/16luzRFGFvRqV0bG8zjnehZqIct1CU3R9lc@vger.kernel.org, AJvYcCVHgXWpXThlEfQoj4yrJrmt6PYhQPWtChQDbAHgIEjgdLITuL9VVT7wH3HkN0tu/UkAPZjDgTfOdf5j@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVUOsH0MQPVnWgahFaxGmSx/nx2ZEzihgtgbvfUr46+JXvOp2
	1pwpmV4+ohfrtYrjtaytk9HFIcKz/vBQobdsBj/rvQILBHyrwIj4
X-Google-Smtp-Source: AGHT+IEe4fpKcbTP0utZlfCeaG4i5zdJ6KSnB2whgWOsH0NR8KjxDlESNwpYCR60GxyfPHM05do4vw==
X-Received: by 2002:a05:6512:4009:b0:530:b773:b4ce with SMTP id 2adb3069b0e04-53a15494e40mr1635748e87.33.1729242761221;
        Fri, 18 Oct 2024 02:12:41 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15211a3esm166190e87.272.2024.10.18.02.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:12:40 -0700 (PDT)
Date: Fri, 18 Oct 2024 11:12:38 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <ZxImhhPhOWuYqSfK@gmail.com>
References: <20241008-ondie-v5-0-041ca4ccc5ee@gmail.com>
 <20241008-ondie-v5-2-041ca4ccc5ee@gmail.com>
 <4u5iv24enpz46funfvbo2aggx6yiqxy7beaa3ldt5ai5wf65kl@bnlm4eyuwkui>
 <Zw0Ixx9Qu9tgGXGP@gmail.com>
 <10a0efab-83a8-4168-993a-c4482a568c96@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0wxXT3JH117vcORs"
Content-Disposition: inline
In-Reply-To: <10a0efab-83a8-4168-993a-c4482a568c96@kernel.org>


--0wxXT3JH117vcORs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Kryzstof,

On Mon, Oct 14, 2024 at 08:08:15PM +0200, Krzysztof Kozlowski wrote:
> On 14/10/2024 14:04, Marcus Folkesson wrote:

[...]

> >=20
> >   reg:
> >     items:
> >       - description: |
> >         Contains 2 offset/length values:
> >         - offset and length for the access window.
> >         - offset and length for accessing the AEMIF
> >         control registers.
>=20
> You need to list two items, so two times "- description:"
> (and drop redundant parts like "offset and length" because this cannot
> be anything else)
>=20
> and this should be pointed out by testing, so open the example and try
> to explain why it is so different than expected.
>=20
>=20
> Unless, it is supposed to be one item... but how do I know? You are
> looking at the device and its driver, not  me.

Ok, thank you.

I will go for:

  reg:
    items:
      - description:
          Access window
      - description:
          AEMIF control registers



[...]

> >=20
> > But I'm getting the following errors:
> >=20
> > ```
> > .../ti,davinci-nand.example.dtb: nand-controller@2000000,0: #size-cells=
: 0 was expected
> >         from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-n=
and.yaml#
> > .../ti,davinci-nand.example.dtb: nand-controller@2000000,0: reg: [[0, 3=
3554432], [33554432, 1], [0, 32768]] is too long
> >         from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-n=
and.yaml#
> > .../ti,davinci-nand.example.dtb: nand-controller@2000000,0: Unevaluated=
 properties are not allowed ('reg' was unexpected)
> >         from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-n=
and.yaml#
> > ```
>=20
> Well, obviously. That's the point of the schema. The example part is
> embedded in node with some address/size cells, which might fit your case
> or might not.
>=20
> >=20
> > The resuling 'ti,davinci-nand.example.dts' contains the following:
> >=20
> > ```
> >     example-0 {
> >         #address-cells =3D <1>;
> >         #size-cells =3D <1>;
> >=20
> >         nand-controller@2000000,0 {
> >           compatible =3D "ti,davinci-nand";
> >           #address-cells =3D <1>;
> >           #size-cells =3D <1>;
> >           reg =3D <0 0x02000000 0x02000000
> >           1 0x00000000 0x00008000>;
> > ```
> >        =20
> >=20
> > How do I set #address-cells in example-0 to 2?
> > I guess that is the problem.
>=20
>=20
>=20
> You just set it... There are dozens/hundreds of schemas doing it, what
> is exactly a problem here?

I think I will solve the problem by including the parent nodes.
What do you think about this?

examples:
  - |
    aemif: aemif@68000000 {
      compatible =3D "ti,da850-aemif";
      #address-cells =3D <2>;
      #size-cells =3D <1>;

      reg =3D <0x68000000 0x00008000>;
      ranges =3D <0 0 0x60000000 0x08000000
      1 0 0x68000000 0x00008000>;
      clocks =3D <&psc0 3>;
      clock-names =3D "aemif";
      clock-ranges;

      cs3 {
        #address-cells =3D <2>;
        #size-cells =3D <1>;
        clock-ranges;
        ranges;

        ti,cs-chipselect =3D <3>;

        nand-controller@2000000,0 {
          compatible =3D "ti,davinci-nand";
          #address-cells =3D <1>;
          #size-cells =3D <0>;
          reg =3D <0 0x02000000 0x02000000
          1 0x00000000 0x00008000>;

          ti,davinci-chipselect =3D <1>;
          ti,davinci-mask-ale =3D <0>;
          ti,davinci-mask-cle =3D <0>;
          ti,davinci-mask-chipsel =3D <0>;

          ti,davinci-nand-buswidth =3D <16>;
          ti,davinci-ecc-mode =3D "hw";
          ti,davinci-ecc-bits =3D <4>;
          ti,davinci-nand-use-bbt;

          partitions {
            compatible =3D "fixed-partitions";
            #address-cells =3D <1>;
            #size-cells =3D <1>;

            partition@0 {
              label =3D "u-boot env";
              reg =3D <0 0x020000>;
            };
          };
        };
      };
    };


>=20
> Best regards,
> Krzysztof
>=20

Best regards,
Marcus Folkesson

--0wxXT3JH117vcORs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmcSJoEACgkQiIBOb1ld
UjJZTQ//bDKxPptc8++o//upFWgxG9oOifAmrLAXKb3+6XFdoefvQ4WiMycu0tV1
ggCzxO0JNudz0TUzmTEC3Z09NEM1uyeUhhjo81EPOxye7xhO6MOw5UhOy8SKNNQF
1gQ5lsfva6YMnAL4TFPlSkCST2y/GpXnzUQs+l/enkVWqUcSCMx1VS/kJugCkYcQ
yZxDmjF1dUJZuf0vSlp7VydlL/hR/ahGmFQh+nx1cuHcnXaX421Ds0WwlfyZOjAW
tr4Kdp2rJfnWsas9iG5HuQna1WHAAKGtCeoFXffGfUmm5x/bs8FL1s8AfizHUsTu
r2vR7J8A+AbkbfHEnhweI/Py1SwgfnPxpeHxl05TpWA5ii90pDMZdUzwVPmauwrT
jE9skZ9lp+PNmgWeuszBdpdk6/yYalq8nahFeQvjoGCouybpE4PjoqIP9Xzpybs9
iQ3b/WtiItlT4vIUVaPUB+0TLhvgbNnWWZGuTZI+F7TD04A0OdX7MdOPPUMoFJKc
3enTiSra1+YW0QKOE+JA5vNafTFUqgsUQ7a3n6g/hgaS1LMbHnnzUA+NxWOQhIBA
aJJLVOo1791oefpglKaCTVkah7bTcY+VTZ+lnosj7EYcDNYshkl+OXajSSUPxZZQ
L3Rg28GK1ctGb0CiAV2BkQs68MteVD0vypim24htHs1umEbPgkU=
=sofE
-----END PGP SIGNATURE-----

--0wxXT3JH117vcORs--

