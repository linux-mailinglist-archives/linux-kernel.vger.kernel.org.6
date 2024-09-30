Return-Path: <linux-kernel+bounces-343719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B4989EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A67028104F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38F18A6B1;
	Mon, 30 Sep 2024 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="INJTnXIH"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB12188737;
	Mon, 30 Sep 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689706; cv=none; b=dbqFXGFl1ALmwpraC/+CBqQnIO/Irxx3y7X4BXjdrdj09H6qz/mJZ0UqhoBF3Z4X5AzlDcB+jSlrp/jvdf7v6WwiUCSdVkpirsK5+I7/6QmCiIJbJg4VOj0nWd7B6jC8yULExg2Rj8HmW5xcLKKQ2uoIs3oW7Eg0xIx+qdfxXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689706; c=relaxed/simple;
	bh=+oYLK29pBCnI7HpCUD7fyHuSbzvZen8E+ynRa1oCOhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyF/LENKlWu/WE+Fb6VrIkpYE/lfdD57/Tia+pxxZ6vA1g4yZP+6Bs4V/iOlLRXPRD8Q38Nk0liKMhrjl3aZT02x2xJvH3ApdKpBsbb5W1Uk5aP1ewXRUtCyx+y+DQxbwm0ks74pY60Pig0chFLdaY70h6OOee3pjnerHW1kQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=INJTnXIH; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14981E0004;
	Mon, 30 Sep 2024 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727689702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n215SOelrjAQex8JGT1YZxPlT2jrnGIMcR78iRv4FBo=;
	b=INJTnXIHPoIHO/C/cAuduanCkWCV4FP6w9ATPH+SGu4Yk4gDqiDzbTLgsOTsaJL5z29Lne
	yl/H/M3NuEmpPXMjeY1el1ldlHVGC8S0qOgrZLfXjR9LSBhb8C886tcP6QJXzMDKIDJ2Q9
	BLrOc1QArgYT6bG08uxpzuODfIbdLW41LuqO6J05n8VEPkblYtXf9gVPvkUI4faJwJ+BrZ
	/vrTADDKxVU9TdrqVJRO6xgxO3/4E8t615Z5j08zd2h8rrxDe5lcDRDe3traVb3UCUJ763
	ivCg7YIh7xZjPse3xq+A6tsOgbmg5YEd+H3+AqojP9tbtX/SzVoeEB6kx6ZL1Q==
Date: Mon, 30 Sep 2024 11:48:19 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Saravana Kannan
 <saravanak@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Bianconi
 <lorenzo@kernel.org>, upstream@airoha.com
Subject: Re: [PATCH 2/3] dt-bindings: mtd: Add Documentation for Airoha
 fixed-partitions
Message-ID: <20240930114819.609f9341@xps-13>
In-Reply-To: <66f3fcb7.5d0a0220.3ca4c2.ba83@mx.google.com>
References: <20240925101422.8373-1-ansuelsmth@gmail.com>
	<20240925101422.8373-3-ansuelsmth@gmail.com>
	<20240925133003.619c40c4@xps-13>
	<66f3f58e.5d0a0220.5d655.b48a@mx.google.com>
	<20240925135256.32d3a0f7@xps-13>
	<66f3fcb7.5d0a0220.3ca4c2.ba83@mx.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Christian,

ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 14:06:11 +0200:

> On Wed, Sep 25, 2024 at 01:52:56PM +0200, Miquel Raynal wrote:
> > Hi Christian,
> >=20
> > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 13:35:38 +0200:
> >  =20
> > > On Wed, Sep 25, 2024 at 01:30:03PM +0200, Miquel Raynal wrote: =20
> > > > Hi Christian,
> > > >=20
> > > > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 12:13:58 +0200:
> > > >    =20
> > > > > Add Documentation for Airoha fixed-partitions compatibles.
> > > > >=20
> > > > > Airoha based SoC declare a dedicated partition at the end of the =
flash to
> > > > > store calibration and device specific data, in addition to fixed
> > > > > partitions.
> > > > >=20
> > > > > The offset of this special partition is not well defined as a cus=
tom bad
> > > > > block management driver is used that reserve space at the end of =
the flash.
> > > > >=20
> > > > > This binding allows defining all fixed partitions and marking the=
 last one
> > > > > to detect the correct offset.
> > > > >=20
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > ---
> > > > >  .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++=
++++++
> > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > >  2 files changed, 81 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/partiti=
ons/airoha,fixed-partitions.yaml
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/air=
oha,fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partition=
s/airoha,fixed-partitions.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..a45df51065af
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/airoha,fix=
ed-partitions.yaml
> > > > > @@ -0,0 +1,80 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/mtd/partitions/airoha,fixed-p=
artitions.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Airoha SoC partitioning
> > > > > +
> > > > > +description: |
> > > > > +  Airoha based SoC declare a dedicated partition at the end of t=
he flash to
> > > > > +  store calibration and device specific data, in addition to fix=
ed partitions.
> > > > > +
> > > > > +  The offset of this special partition is not well defined as a =
custom bad block
> > > > > +  management driver is used that reserve space at the end of the=
 flash.
> > > > > +
> > > > > +  This binding allows defining all fixed partitions and marking =
the last one to
> > > > > +  detect the correct offset from the new end of the flash.
> > > > > +
> > > > > +maintainers:
> > > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > > +
> > > > > +select: false
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: airoha,fixed-partitions
> > > > > +
> > > > > +  "#address-cells":
> > > > > +    enum: [ 1, 2 ]
> > > > > +
> > > > > +  "#size-cells":
> > > > > +    enum: [ 1, 2 ]
> > > > > +
> > > > > +patternProperties:
> > > > > +  "^partition@[0-9a-f]+$":
> > > > > +    $ref: partition.yaml#
> > > > > +    properties:
> > > > > +      compatible:
> > > > > +        const: airoha,dynamic-art
> > > > > +    unevaluatedProperties: false
> > > > > +
> > > > > +required:
> > > > > +  - "#address-cells"
> > > > > +  - "#size-cells"
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    partitions {
> > > > > +        compatible =3D "airoha,fixed-partitions";
> > > > > +        #address-cells =3D <1>;
> > > > > +        #size-cells =3D <1>;
> > > > > +
> > > > > +        partition@0 {
> > > > > +          label =3D "bootloader";
> > > > > +          reg =3D <0x00000000 0x00080000>;
> > > > > +        };
> > > > > +
> > > > > +        partition@80000 {
> > > > > +          label =3D "tclinux";
> > > > > +          reg =3D <0x00080000 0x02800000>;
> > > > > +        };
> > > > > +
> > > > > +        partition@2880000 {
> > > > > +          label =3D "tclinux_slave";
> > > > > +          reg =3D <0x02880000 0x02800000>;
> > > > > +        };
> > > > > +
> > > > > +        partition@5080000 {
> > > > > +          label =3D "rootfs_data";
> > > > > +          reg =3D <0x5080000 0x00800000>;
> > > > > +        };
> > > > > +
> > > > > +        partition@ffffffff {
> > > > > +          compatible =3D "airoha,dynamic-art";
> > > > > +          label =3D "art";
> > > > > +          reg =3D <0xffffffff 0x00300000>;   =20
> > > >=20
> > > > I'm a little bit puzzled by this kind of information which is known=
 to
> > > > be wrong. As the partition offset and size must be dynamically
> > > > calculated, this reg property (as well as the size parameter of the
> > > > previous one) are notably wrong. I guess we are not fully constrain=
ed
> > > > by the fixed-partitions schema here, so could we avoid the reg prop=
erty
> > > > in the airoha,dynamic-art partition? Maybe we also need a #define f=
or a
> > > > specific placeholder in the penultimate reg property too (for the s=
ize).
> > > >   =20
> > >=20
> > > Maybe instead of reg we can use a property like size?
> > >=20
> > > Can you better elaborate the suggestion about the #define?
> > >=20
> > > Do you mean for case where the last partition might overlap
> > > with the penultimate? Honestly in such case I would error hard, that
> > > case happen when too much space is reserved and that is a
> > > misconfiguration of the system (developer error) =20
> >=20
> > That's not what I mean.
> >=20
> > In the above case you say partition "partition@5080000" is 0x800000
> > bytes long. This is obviously wrong otherwise you would know where the
> > art partition starts. And right after you're saying partition
> > "partition@ffffffff" starts at 0xffffffff and is 0x300000 bytes long.
> > This is also wrong because 0xffffffff is not a valid start address and
> > IIUC 0x300000 is also unknown and dynamically derived.
> >=20
> > So for the art partition my advise if you know nothing about the
> > start/length is to just skip the reg property. For the previous
> > partition I'd maybe use a definition (whose name is to discuss) instead
> > of the wrong size argument (the start offset being correct on his side).
> > =20
>=20
> Ok probably the description isn't clear enough. The missing info that
> require this parser is the flash end.
>=20
> Following the example we know the size of rootfs_data and start offset
> AND we know the size of the ART partition.
>=20
> There might be a space in the middle unused between the rootfs_data
> partition and the art partition. What is derived is the starting offset
> of the art partition that is flash end - art partition size.
> (where flash end change and is not always the same due to how the special
> bad block managament table reserved space is handled)
>=20
> This is why 0xffffffff, used as a dummy offset to signal it will be parse=
d at
> runtime. On second tought tho maybe using this dummy offset is wrong and
> I should just have something like
>=20
> length =3D <0x300000>;
>=20
> Is it clear now? Sorry for any confusion.

I'm sorry but not really. You know the end of the physical device and
the size of the ART partition, so you must know its start as well?

Thanks,
Miqu=C3=A8l

