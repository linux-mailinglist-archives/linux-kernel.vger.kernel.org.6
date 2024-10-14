Return-Path: <linux-kernel+bounces-364001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7F199C9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5361C2889BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227FD19F410;
	Mon, 14 Oct 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtdfJ1i2"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73237156F3F;
	Mon, 14 Oct 2024 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907470; cv=none; b=AtuXrbTBvVDigzhVn+aFQijzu+kajwmRZVZ4WeOwllJjxECDWaIPc+4yoyE3Bm/OB8uMqHwxw7yKOF7nrVskvr6reTKIOgcEroCEn06p8MuSG16eNpPEj3uNtPXtVSIE2yqrg9+UiPN5H2x8tNAZSPOZB3eVHEfNfJy5thtzgzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907470; c=relaxed/simple;
	bh=m65bwQBzBs6jiScEhJWWmGVNumyDIywRlIH4SEAIzDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaFC1PqY5wCSDQOp+JNP96B4LDnUwsl78hffOgNtiiZuwHNoN0cfOhQWmR/fKBGAALGi94FaAv4/2FUvxIQhB9s7HemJ9lNtNzzeXKKqxq5iNc9XlTAhsZAaIZ+81+8Wjwb39Vi8EN+umapz+C8o7GYnvXILHUlnrFrp5/e+qKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtdfJ1i2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so370709e87.2;
        Mon, 14 Oct 2024 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728907466; x=1729512266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAhKE9vd5VoPEDERdDcAkweB+/fuBqaQlx8ZWt7jHoE=;
        b=XtdfJ1i2HW9voLB0sc9lo3zUFU8efqLR9Mc3Bfg/5iJpZqe+pV48ekjU1XpzFI7guY
         psSQTB004WugYAsTI4lfby0KXKcBYFRxWaqyqwf8vtmUHAi0kldq/ZDwWK8it86SgjDN
         /cECNJLeOFyj72d5kJvzpiyW7UK3n/eLb2EDYNB3qiQ/f+Ow6RDZytquN9rTKvhlXgLI
         osax32hK6B3hDz4OoOARlTiO41HY3FYp8Fhg2RVD2TYJVbgXpNCVL/xdEz09331TdD5/
         B+7GYSChd+k8uafXDeyGuFiZQlm4WFJfTa4j2IFasfQIQyCiaA/54rlwtncqGD8+TSGv
         cJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728907466; x=1729512266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAhKE9vd5VoPEDERdDcAkweB+/fuBqaQlx8ZWt7jHoE=;
        b=SJBKrXhKmQu5qxpgaUu2w4IK2JcG0ORRo+A+Ehfywr9S5osPNJNaZ8TrG0cUNE3gra
         vbbUTeW/9x0zXLMxA9Ywm2p3RnqHYs0RrshXU2YIrlQXL8JYSKVXjjzd3RDlQWm91793
         xoPk/g1WP/cjJ5HMFxtnKOgZGvKVyoL61mwUIYwT71C+NOK3emtburv2EAV9tASYiMfS
         gJRyet0BswCLGEUpVL5AIqTrTnUe9BOd2vfuxIxe1vyhM30V6+gOl3Lr/HEEDZoQpqtS
         +gxokDstxiI6yKvg5t69aqfKBiqrrcQBxtq1rju/jmnRC1uuikxJYljuCIkFsjAbVJN2
         2npA==
X-Forwarded-Encrypted: i=1; AJvYcCXNnVG67F+2QyCN5ubN8ykCcrViJI2vfHeXs+Wb0qvPm7ekwTiRhw6HkapwfBzFrxPQcGK/Zf0VBqqrQvar@vger.kernel.org, AJvYcCXiukG4H3SDy/sgHoqeOYe7Ni9JODbdnZCJ59gxTkjWFL7/vy2ztf+Mp+aWcTmFY07038TFMXA7sB45@vger.kernel.org
X-Gm-Message-State: AOJu0YyNO2KdiSyu6ovbXrIH3ECoqXeR4q8wyKYPoI68vJyOvoAHKmYf
	WqD0rvWw8ffi6yZepE1c6ckDqngxSckxJPSfqqg84Sdl68r05r2w
X-Google-Smtp-Source: AGHT+IGstZmxwNsompie+aLTNH6Adpdfi+FGz/MmaD5OGfP/FGHcH7YFWNRG3hj+N8YDPneCt2WGoA==
X-Received: by 2002:a05:6512:1105:b0:539:fc42:e5ee with SMTP id 2adb3069b0e04-539fc42e6femr776977e87.29.1728907466071;
        Mon, 14 Oct 2024 05:04:26 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e2c4a137sm1111628e87.243.2024.10.14.05.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 05:04:25 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:04:23 +0200
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
Message-ID: <Zw0Ixx9Qu9tgGXGP@gmail.com>
References: <20241008-ondie-v5-0-041ca4ccc5ee@gmail.com>
 <20241008-ondie-v5-2-041ca4ccc5ee@gmail.com>
 <4u5iv24enpz46funfvbo2aggx6yiqxy7beaa3ldt5ai5wf65kl@bnlm4eyuwkui>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D0LLp9JK1EE8uudv"
Content-Disposition: inline
In-Reply-To: <4u5iv24enpz46funfvbo2aggx6yiqxy7beaa3ldt5ai5wf65kl@bnlm4eyuwkui>


--D0LLp9JK1EE8uudv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Krzysztof,

I'm sorry for all these iterations, it wouldn't have been necessary if I had
done my homework better. I'm not too familiar with writing these and I do
often find the descriptions unclear and not obvious.
Anyway, thank you for your patience, reviews and help.


On Tue, Oct 08, 2024 at 03:28:33PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Oct 08, 2024 at 09:02:45AM +0200, Marcus Folkesson wrote:
> > Convert the bindings to yaml format.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -------------=
----
> >  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 115 +++++++++++++=
++++++++
> >  2 files changed, 115 insertions(+), 94 deletions(-)
> >=20
>=20
>=20
> > diff --git a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml=
 b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1263616593532e8483d556b=
4242b004a16620ddf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> > @@ -0,0 +1,115 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI DaVinci NAND controller
> > +
> > +maintainers:
> > +  - Marcus Folkesson <marcus.folkesson@gmail.com>
> > +
> > +allOf:
> > +  - $ref: nand-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,davinci-nand
> > +      - ti,keystone-nand
> > +
> > +  reg:
> > +    maxItems: 1
>=20
> This was different in original binding and commit msg does not explain
> changes.  Be sure any change from pure conversion is explained in the
> commit msg.

Hm. Another misinterpretation from my side.
Should I use items instead? E.g.

  reg:
    items:
      - description: |
        Contains 2 offset/length values:
        - offset and length for the access window.
        - offset and length for accessing the AEMIF
        control registers.

>=20
> > +
> > +  partitions:
> > +    $ref: /schemas/mtd/partitions/partitions.yaml
> > +
> > +  ti,davinci-chipselect:
> > +    description:
> > +      Number of chipselect. Indicate on the davinci_nand driver which
> > +      chipselect is used for accessing the nand.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3]
> > +
> > +  ti,davinci-mask-ale:
> > +    description:
> > +      Mask for ALE. Needed for executing address phase. These offset w=
ill be
> > +      added to the base address for the chip select space the NAND Fla=
sh
> > +      device is connected to.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0x08
> > +
> > +  ti,davinci-mask-cle:
> > +    description:
> > +      Mask for CLE. Needed for executing command phase. These offset w=
ill be
> > +      added to the base address for the chip select space the NAND Fla=
sh device
> > +      is connected to.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0x10
> > +
> > +  ti,davinci-mask-chipsel:
> > +    description:
> > +      Mask for chipselect address. Needed to mask addresses for given
> > +      chipselect.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0
> > +
> > +  ti,davinci-ecc-bits:
> > +    description: Used ECC bits.
> > +    enum: [1, 4]
> > +
> > +  ti,davinci-ecc-mode:
> > +    description: Operation mode of the NAND ECC mode.
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [none, soft, hw, on-die]
> > +    deprecated: true
> > +
> > +  ti,davinci-nand-buswidth:
> > +    description: Bus width to the NAND chip
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [8, 16]
> > +    default: 8
> > +    deprecated: true
> > +
> > +  ti,davinci-nand-use-bbt:
> > +    type: boolean
> > +    description:
> > +      Use flash based bad block table support. OOB identifier is saved=
 in OOB
> > +      area.
> > +    deprecated: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - ti,davinci-chipselect
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    nand-controller@2000000 {
> > +      compatible =3D "ti,davinci-nand";
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
>=20
> I did not notice it last time.... but what is this? How could you have
> no sizes?
>=20
> > +
> > +      reg =3D <0 0x02000000>;
>=20
> This is odd. Address is not 0... and size should be 0.
>=20
> I don't get how it even works. For sure it is not correct.

Outch. It slipped through when I was laborating.

This was the example I wanted to get working:


```
examples:
  - |
    nand-controller@2000000,0 {
      compatible =3D "ti,davinci-nand";
      #address-cells =3D <1>;
      #size-cells =3D <1>;
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
```


But I'm getting the following errors:

```
=2E../ti,davinci-nand.example.dtb: nand-controller@2000000,0: #size-cells: =
0 was expected
        from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.=
yaml#
=2E../ti,davinci-nand.example.dtb: nand-controller@2000000,0: reg: [[0, 335=
54432], [33554432, 1], [0, 32768]] is too long
        from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.=
yaml#
=2E../ti,davinci-nand.example.dtb: nand-controller@2000000,0: Unevaluated p=
roperties are not allowed ('reg' was unexpected)
        from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.=
yaml#
```

The resuling 'ti,davinci-nand.example.dts' contains the following:

```
    example-0 {
        #address-cells =3D <1>;
        #size-cells =3D <1>;

        nand-controller@2000000,0 {
          compatible =3D "ti,davinci-nand";
          #address-cells =3D <1>;
          #size-cells =3D <1>;
          reg =3D <0 0x02000000 0x02000000
          1 0x00000000 0x00008000>;
```
       =20

How do I set #address-cells in example-0 to 2?
I guess that is the problem.
>=20
> Best regards,
> Krzysztof

Thanks,
Marcus

--D0LLp9JK1EE8uudv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmcNCMEACgkQiIBOb1ld
UjItAxAApvXS5J63yVeffC/7GhIWALzNCxsP8G8svrNF+6jz0b6j/FkvhWVYsTxQ
FpPEkVM8KBOY9ZBYEHeNVlJNciDJMV9SNNiWbiPTTLFofBED14eXEbCN5yorUCjY
PFDcYYPDJYdwkHsdyMkH7XrSNVl0y8mT5hM1FsTR0zm0CO7SDvN4riQ+1Bdbh2Xh
3s7bdcnfOE8YY+UQYf6c85SfGQWmw5WX3voQzuBlo1rh7G2rLkg7UM4vQ4+A5Bsp
Ht1pAy0RieodHZziuTnYWGvHhMCS8gIRO/NiLUEL1GUjye2tY6JJ4vptLdH1lvmQ
+8fW0RKnTnuvwaxpYVDQl1NVF3388U1hRlLTID3etPZ34ig1NB/JfAg/W6VbrLOk
R4myKdRvnfNC6Ets/K8KsPvu+vUbJ/HMcAeI09dCXni3m+NScoZQx8iOcdBSMxL+
SGznacfKhW+d4R1cqv9sgcmwCDApYDOnWfg7bB/bGSEKYSAWvgkX/1j6A9b6IpNw
ZV++pw07YcrAW3Ex2n/2GyozuiWl5tjua8VXX2xbwkkk2mpUfq5Kg++yipDSPtet
F74nk3kgheUZvNqhuHiEyG6LhBeNfP2WLlDn1vg70R8TpyPJazdVjH100ZI/cbbG
PfqOeAiUVfOaoKCOvHUOYq3U3Xk0vF5y9gnCtPXtSNi3anvN3w0=
=2XDV
-----END PGP SIGNATURE-----

--D0LLp9JK1EE8uudv--

