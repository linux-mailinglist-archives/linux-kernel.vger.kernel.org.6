Return-Path: <linux-kernel+bounces-345549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC58898B762
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026091C22754
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EAE1BF337;
	Tue,  1 Oct 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mgrDGWIc"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B61BE255;
	Tue,  1 Oct 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772153; cv=none; b=sLfsSgRSnrPUEldcFtZMcVdL6lRXZ1mcFWdjoQzykIEMoTD3YaXrGJC2goJG1XQs05NDj/+spzGlMGWjBM4Pq90ASpAIIRYk6clVMfV3W3RHGNPnfR7Pll8UFPQpG68x22X3dT5TtxvewVMIffiadlc0V6N8pC0DCShDfNY+8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772153; c=relaxed/simple;
	bh=wDTKO48JYe7iRFJhqh8UOTpQZAPfkh1BnCmCT5n+Tws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5LrlZFl8qcyKy7J5zngzBw1NRZ5VGSmvId6o1igYqqoTIJuRmg+eEfYRL6NsfcwfMJqDC/WKJFLkcv71XxiUjHwqh733JWMRNaL6V+/fHgEbOTodqNelxDtMdURvvP06OvJ2GOGphGTFPZalDtpBkf/smqbmyuYT4CAX1EyPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mgrDGWIc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6444B1C0002;
	Tue,  1 Oct 2024 08:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727772148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1R1dMOvuL4Ri4qQaHDNu0JbucOFEv2D27z7Q/IBbvc=;
	b=mgrDGWIcxSC1KFWVav45SYE3a8AVHKXL9bbK0YrZ1zT2P78tqxxwThyvUMc+myQrIehHPO
	fa82C0RytasroVk6oyrzgb8IyfOHddpBKhNOvVFLYiyZu49azoBTXm9KOf76665dTSpscN
	GMvM82ZutgItUAD+WlEROKYJjB0ai1n5xKNV1X5TAONNNmjaYX1/6SI5jkBTjGiewO99wQ
	GCu3Sx/ynnm17g3qDJbKLoCdpkSBQYFnJGKlfb2pigvXFv+JCNvzeZ46g+ifa/qBH0HhjV
	5ZykiIQVrya7eqTcvSBAb8Jna6vkg2YOKIIoa5IIbrdHIMrGYNgy3eXcyd9rTQ==
Date: Tue, 1 Oct 2024 10:42:25 +0200
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
Message-ID: <20241001104225.67483dab@xps-13>
In-Reply-To: <66fa7915.050a0220.1da288.aeca@mx.google.com>
References: <20240925101422.8373-1-ansuelsmth@gmail.com>
	<20240925101422.8373-3-ansuelsmth@gmail.com>
	<20240925133003.619c40c4@xps-13>
	<66f3f58e.5d0a0220.5d655.b48a@mx.google.com>
	<20240925135256.32d3a0f7@xps-13>
	<66f3fcb7.5d0a0220.3ca4c2.ba83@mx.google.com>
	<20240930114819.609f9341@xps-13>
	<66fa7915.050a0220.1da288.aeca@mx.google.com>
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

ansuelsmth@gmail.com wrote on Mon, 30 Sep 2024 12:10:21 +0200:

> On Mon, Sep 30, 2024 at 11:48:19AM +0200, Miquel Raynal wrote:
> > Hi Christian,
> >=20
> > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 14:06:11 +0200:
> >  =20
> > > On Wed, Sep 25, 2024 at 01:52:56PM +0200, Miquel Raynal wrote: =20
> > > > Hi Christian,
> > > >=20
> > > > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 13:35:38 +0200:
> > > >    =20
> > > > > On Wed, Sep 25, 2024 at 01:30:03PM +0200, Miquel Raynal wrote:   =
=20
> > > > > > Hi Christian,
> > > > > >=20
> > > > > > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 12:13:58 +0200:
> > > > > >      =20
> > > > > > > Add Documentation for Airoha fixed-partitions compatibles.
> > > > > > >=20
> > > > > > > Airoha based SoC declare a dedicated partition at the end of =
the flash to
> > > > > > > store calibration and device specific data, in addition to fi=
xed
> > > > > > > partitions.
> > > > > > >=20
> > > > > > > The offset of this special partition is not well defined as a=
 custom bad
> > > > > > > block management driver is used that reserve space at the end=
 of the flash.
> > > > > > >=20
> > > > > > > This binding allows defining all fixed partitions and marking=
 the last one
> > > > > > > to detect the correct offset.
> > > > > > >=20
> > > > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > > ---
> > > > > > >  .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++=
++++++++++
> > > > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > > > >  2 files changed, 81 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/par=
titions/airoha,fixed-partitions.yaml
> > > > > > >=20
> > > > > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions=
/airoha,fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/parti=
tions/airoha,fixed-partitions.yaml
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..a45df51065af
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/airoha=
,fixed-partitions.yaml
> > > > > > > @@ -0,0 +1,80 @@
> > > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/mtd/partitions/airoha,fix=
ed-partitions.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Airoha SoC partitioning
> > > > > > > +
> > > > > > > +description: |
> > > > > > > +  Airoha based SoC declare a dedicated partition at the end =
of the flash to
> > > > > > > +  store calibration and device specific data, in addition to=
 fixed partitions.
> > > > > > > +
> > > > > > > +  The offset of this special partition is not well defined a=
s a custom bad block
> > > > > > > +  management driver is used that reserve space at the end of=
 the flash.
> > > > > > > +
> > > > > > > +  This binding allows defining all fixed partitions and mark=
ing the last one to
> > > > > > > +  detect the correct offset from the new end of the flash.
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > > > > +
> > > > > > > +select: false
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    const: airoha,fixed-partitions
> > > > > > > +
> > > > > > > +  "#address-cells":
> > > > > > > +    enum: [ 1, 2 ]
> > > > > > > +
> > > > > > > +  "#size-cells":
> > > > > > > +    enum: [ 1, 2 ]
> > > > > > > +
> > > > > > > +patternProperties:
> > > > > > > +  "^partition@[0-9a-f]+$":
> > > > > > > +    $ref: partition.yaml#
> > > > > > > +    properties:
> > > > > > > +      compatible:
> > > > > > > +        const: airoha,dynamic-art
> > > > > > > +    unevaluatedProperties: false
> > > > > > > +
> > > > > > > +required:
> > > > > > > +  - "#address-cells"
> > > > > > > +  - "#size-cells"
> > > > > > > +
> > > > > > > +additionalProperties: false
> > > > > > > +
> > > > > > > +examples:
> > > > > > > +  - |
> > > > > > > +    partitions {
> > > > > > > +        compatible =3D "airoha,fixed-partitions";
> > > > > > > +        #address-cells =3D <1>;
> > > > > > > +        #size-cells =3D <1>;
> > > > > > > +
> > > > > > > +        partition@0 {
> > > > > > > +          label =3D "bootloader";
> > > > > > > +          reg =3D <0x00000000 0x00080000>;
> > > > > > > +        };
> > > > > > > +
> > > > > > > +        partition@80000 {
> > > > > > > +          label =3D "tclinux";
> > > > > > > +          reg =3D <0x00080000 0x02800000>;
> > > > > > > +        };
> > > > > > > +
> > > > > > > +        partition@2880000 {
> > > > > > > +          label =3D "tclinux_slave";
> > > > > > > +          reg =3D <0x02880000 0x02800000>;
> > > > > > > +        };
> > > > > > > +
> > > > > > > +        partition@5080000 {
> > > > > > > +          label =3D "rootfs_data";
> > > > > > > +          reg =3D <0x5080000 0x00800000>;
> > > > > > > +        };
> > > > > > > +
> > > > > > > +        partition@ffffffff {
> > > > > > > +          compatible =3D "airoha,dynamic-art";
> > > > > > > +          label =3D "art";
> > > > > > > +          reg =3D <0xffffffff 0x00300000>;     =20
> > > > > >=20
> > > > > > I'm a little bit puzzled by this kind of information which is k=
nown to
> > > > > > be wrong. As the partition offset and size must be dynamically
> > > > > > calculated, this reg property (as well as the size parameter of=
 the
> > > > > > previous one) are notably wrong. I guess we are not fully const=
rained
> > > > > > by the fixed-partitions schema here, so could we avoid the reg =
property
> > > > > > in the airoha,dynamic-art partition? Maybe we also need a #defi=
ne for a
> > > > > > specific placeholder in the penultimate reg property too (for t=
he size).
> > > > > >     =20
> > > > >=20
> > > > > Maybe instead of reg we can use a property like size?
> > > > >=20
> > > > > Can you better elaborate the suggestion about the #define?
> > > > >=20
> > > > > Do you mean for case where the last partition might overlap
> > > > > with the penultimate? Honestly in such case I would error hard, t=
hat
> > > > > case happen when too much space is reserved and that is a
> > > > > misconfiguration of the system (developer error)   =20
> > > >=20
> > > > That's not what I mean.
> > > >=20
> > > > In the above case you say partition "partition@5080000" is 0x800000
> > > > bytes long. This is obviously wrong otherwise you would know where =
the
> > > > art partition starts. And right after you're saying partition
> > > > "partition@ffffffff" starts at 0xffffffff and is 0x300000 bytes lon=
g.
> > > > This is also wrong because 0xffffffff is not a valid start address =
and
> > > > IIUC 0x300000 is also unknown and dynamically derived.
> > > >=20
> > > > So for the art partition my advise if you know nothing about the
> > > > start/length is to just skip the reg property. For the previous
> > > > partition I'd maybe use a definition (whose name is to discuss) ins=
tead
> > > > of the wrong size argument (the start offset being correct on his s=
ide).
> > > >   =20
> > >=20
> > > Ok probably the description isn't clear enough. The missing info that
> > > require this parser is the flash end.
> > >=20
> > > Following the example we know the size of rootfs_data and start offset
> > > AND we know the size of the ART partition.
> > >=20
> > > There might be a space in the middle unused between the rootfs_data
> > > partition and the art partition. What is derived is the starting offs=
et
> > > of the art partition that is flash end - art partition size.
> > > (where flash end change and is not always the same due to how the spe=
cial
> > > bad block managament table reserved space is handled)
> > >=20
> > > This is why 0xffffffff, used as a dummy offset to signal it will be p=
arsed at
> > > runtime. On second tought tho maybe using this dummy offset is wrong =
and
> > > I should just have something like
> > >=20
> > > length =3D <0x300000>;
> > >=20
> > > Is it clear now? Sorry for any confusion. =20
> >=20
> > I'm sorry but not really. You know the end of the physical device and
> > the size of the ART partition, so you must know its start as well?
> > =20
>=20
> Before the system boot we know:
> - size of the ART partition
> - real size of the physical device (512mb... 1G... 64mb...)
>=20
> When the physical device is probed (nand) a special driver is loaded
> (before mtd parsing logic) that change the physical size of the device
> (mtd->size) as at the end of the nand some space is reserved for bad
> block management and other metadata info.

Here you are explaining what you intend Linux to do, right? I would
like to understand what you are trying to solve. I dont understand why
you need the size change, I don't understand why you don't know the
start of the ART partition, I don't understand what the data you are
hiding contains and who uses it :-) I'm sorry, this is too unclear yet.

Quoting your cover letter:

	"This require dynamic calculation of the offset as some
	dedicated driver for bad block management might be used that
	reserve some space at the end of the flash for bad block
	accounting. This special driver change the end offset of the
	flash hence a dynamic parser is needed."

I don't know what this "dedicated driver" is, I don't understand why it
is needed.

> So on the mtd parsing logic we know:
> - size of the ART partitiomn
> - new size of the physical device (512-reserved space...)
>=20
> And we calculate the start offset of the ART partition.
>=20
> It's very difficult to know what is the new size of the physical device
> after the driver change it as it might change based on the internal
> configuration of the driver itself.

Thanks,
Miqu=C3=A8l

