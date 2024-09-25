Return-Path: <linux-kernel+bounces-338438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A6D9857FC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88B01F217A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F1156F23;
	Wed, 25 Sep 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TveXuEvU"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954914600D;
	Wed, 25 Sep 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727263810; cv=none; b=elQKyKVaeLqq62/aM8fwlY7TsfRBOX2uhu8lgrYFONBvVlrWZGYp9pJDiTjU9HOBYOKJGNXfg+FLTfc54V0msqpB7HgAdD7XsF+k6KxSO541ztMVMdv7LWJSmaWVNU73seo3uFA8KUlcymdFMVjPI/G9ngLweIgl8YjMrJe5DDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727263810; c=relaxed/simple;
	bh=yCae2etCCByRezUjvhNLLzMdTdCTpqMJWGwExuZu75M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uim0dUoUiehB9FOoj2hOtntKYQNKXXAA1gjGWD7/+bPIB1xkcwlZJ1SWPltai0pxhpQsLbfJK52xcB+dPTWNOPht+S6CUe2KccDWa6jeWT8IFMqOatUAtgvNzA/4Nx5jkoVJaIfFq9Nd6nNB3kvW5NOgc8Mpuq5d00cyYxZFTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TveXuEvU; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 835F6E0005;
	Wed, 25 Sep 2024 11:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727263805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oOFsbLYbgAjnw+DJoaE3t1B0TAykxqlrbUIk6yDMe4=;
	b=TveXuEvUwy7B7onF9Bh6GCdUGuJ1x56bn+JOKfsxXRGMPbU3neItQfPpaIAOHuiPamBaL1
	lSHCM2AjlKCPfZ1tyiBdBo1tSMqwNfIXlo47jm2xLWrkdvp6DJMK48Bs8hDZUfVdGvYvst
	rvN/kJDcqi6LmkpUH06JY+r20WwvIywVe98+qz15jVQiAeGMkEWD+2xlmAV1Qm5252qoXv
	iHomUPiSCD66E+JayIxtbxTh53v/1AOoDcCSt/D3xC0MCEMfkq7C9yK3wzW9qiGHZbZqj9
	GbNEN+DDP/DcdqoloAigwMHsxYuXsxT9qJio4ObttWeVXZymfCCqfJmynW82fw==
Date: Wed, 25 Sep 2024 13:30:03 +0200
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
Message-ID: <20240925133003.619c40c4@xps-13>
In-Reply-To: <20240925101422.8373-3-ansuelsmth@gmail.com>
References: <20240925101422.8373-1-ansuelsmth@gmail.com>
	<20240925101422.8373-3-ansuelsmth@gmail.com>
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

ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 12:13:58 +0200:

> Add Documentation for Airoha fixed-partitions compatibles.
>=20
> Airoha based SoC declare a dedicated partition at the end of the flash to
> store calibration and device specific data, in addition to fixed
> partitions.
>=20
> The offset of this special partition is not well defined as a custom bad
> block management driver is used that reserve space at the end of the flas=
h.
>=20
> This binding allows defining all fixed partitions and marking the last one
> to detect the correct offset.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
>  .../bindings/mtd/partitions/partitions.yaml   |  1 +
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airo=
ha,fixed-partitions.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/airoha,fixe=
d-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/airoha=
,fixed-partitions.yaml
> new file mode 100644
> index 000000000000..a45df51065af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-parti=
tions.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/airoha,fixed-partition=
s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha SoC partitioning
> +
> +description: |
> +  Airoha based SoC declare a dedicated partition at the end of the flash=
 to
> +  store calibration and device specific data, in addition to fixed parti=
tions.
> +
> +  The offset of this special partition is not well defined as a custom b=
ad block
> +  management driver is used that reserve space at the end of the flash.
> +
> +  This binding allows defining all fixed partitions and marking the last=
 one to
> +  detect the correct offset from the new end of the flash.
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +select: false
> +
> +properties:
> +  compatible:
> +    const: airoha,fixed-partitions
> +
> +  "#address-cells":
> +    enum: [ 1, 2 ]
> +
> +  "#size-cells":
> +    enum: [ 1, 2 ]
> +
> +patternProperties:
> +  "^partition@[0-9a-f]+$":
> +    $ref: partition.yaml#
> +    properties:
> +      compatible:
> +        const: airoha,dynamic-art
> +    unevaluatedProperties: false
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible =3D "airoha,fixed-partitions";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +
> +        partition@0 {
> +          label =3D "bootloader";
> +          reg =3D <0x00000000 0x00080000>;
> +        };
> +
> +        partition@80000 {
> +          label =3D "tclinux";
> +          reg =3D <0x00080000 0x02800000>;
> +        };
> +
> +        partition@2880000 {
> +          label =3D "tclinux_slave";
> +          reg =3D <0x02880000 0x02800000>;
> +        };
> +
> +        partition@5080000 {
> +          label =3D "rootfs_data";
> +          reg =3D <0x5080000 0x00800000>;
> +        };
> +
> +        partition@ffffffff {
> +          compatible =3D "airoha,dynamic-art";
> +          label =3D "art";
> +          reg =3D <0xffffffff 0x00300000>;

I'm a little bit puzzled by this kind of information which is known to
be wrong. As the partition offset and size must be dynamically
calculated, this reg property (as well as the size parameter of the
previous one) are notably wrong. I guess we are not fully constrained
by the fixed-partitions schema here, so could we avoid the reg property
in the airoha,dynamic-art partition? Maybe we also need a #define for a
specific placeholder in the penultimate reg property too (for the size).

Thanks,
Miqu=C3=A8l

