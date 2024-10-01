Return-Path: <linux-kernel+bounces-345676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D895298B926
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9981F23598
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B871A00ED;
	Tue,  1 Oct 2024 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E8/tjlw2"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A053209;
	Tue,  1 Oct 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777948; cv=none; b=IBoOlW0AGkbRKdeA5kH/dAOa0cOP0TMgc69NNoUgacAme32ufIog6/IMTu3PpDjRYBFp26rM232AaiD8/13Lq4CX51wmwCKAu2lRp98FhKZCfje248LD2CtZmmxSX617sRM6nDYJjiU/Z6VLqLj2v8o8Up1b4DJCG1QKMAPGmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777948; c=relaxed/simple;
	bh=l5+qlo+qTVIkXbQ2w9G88AEkkk3ZZ8Bq39i6rLpmN10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGUayvwu7rV6eSWEj1/89vXsvkBd3uDX0cJBb4si66jutluFK4z1h50o3FD+D3guA5wjaSqncgS5S10XOYeNAOFk6jfzwT9DQGkQeatsU+9MQFqem3KeAS1KeY2X/7P+OWgdPiuNb0KejoZJflw42ulY2uHOTkAPQFNsSydoXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E8/tjlw2; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57832FF803;
	Tue,  1 Oct 2024 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727777944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPwBsKHTzNqKl3xXxwOeQfCYPFQuF1OTpHnTxmYblNw=;
	b=E8/tjlw2LfRzY0mrYfErjL/eKDRXvh2EY8fyERksqfy4dWPFSkzANqStYOVS/k7UIE1wSh
	6qlAkv7pKpwNUw6rRjW21ETi4qWpEmWpWz135W2xs8PCFmN3JLYvvkKLwLrnD5QYjArKy8
	Q4qjHZtQN7otXlM7D6K7sycDL7Tem0TQvCMwgTCpREhnTVR6x06i4OYobozUh83tLHXq1n
	P3/SmA/VjMQYpSU397m24rqNbHD7VLld5o6WVf7k0MvjQg2n14k3cXgEMG4T+UERIoq6+i
	eFgpJDidnqBCc2O4DPvqEhtatq0fR84z0Qc2Nw9pZHxta0KE1uZQS7pehDG+nQ==
Date: Tue, 1 Oct 2024 12:19:02 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: mtd: nuvoton,ma35d1-nand: add new
 bindings
Message-ID: <20241001121902.658d3977@xps-13>
In-Reply-To: <20240927020749.46791-2-hpchen0nvt@gmail.com>
References: <20240927020749.46791-1-hpchen0nvt@gmail.com>
	<20240927020749.46791-2-hpchen0nvt@gmail.com>
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

Hi Hui-Ping,

hpchen0nvt@gmail.com wrote on Fri, 27 Sep 2024 02:07:48 +0000:

> Add dt-bindings for the Nuvoton MA35 SoC NAND Controller.
>=20
> Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mtd/nuvoton,ma35d1-nand.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-=
nand.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.ya=
ml b/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
> new file mode 100644
> index 000000000000..a8a549644c98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/nuvoton,ma35d1-nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 NAND Flash Interface (NFI) Controller
> +
> +maintainers:
> +  - Hui-Ping Chen <hpchen0nvt@gmail.com>
> +
> +allOf:
> +  - $ref: nand-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,ma35d1-nand-controller
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^nand@[a-f0-9]$":
> +    type: object
> +    $ref: raw-nand-chip.yaml
> +    properties:
> +      nand-ecc-step-size:
> +        enum: [512, 1024]
> +
> +      nand-ecc-strength:
> +        enum: [8, 12, 24]
> +
> +    required:
> +      - nand-ecc-step-size
> +      - nand-ecc-strength

No, they should not be required, unless there is a good reason to do
so. Optimal strength is discoverable, stop forcing it by default.

> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        nand-controller@401A0000 {
> +            compatible =3D "nuvoton,ma35d1-nand-controller";
> +            reg =3D <0x0 0x401A0000 0x0 0x1000>;
> +            interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks =3D <&clk NAND_GATE>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            nand@0 {
> +                reg =3D <0>;
> +
> +                nand-on-flash-bbt;
> +                nand-ecc-step-size =3D <512>;
> +                nand-ecc-strength =3D <8>;
> +
> +                partitions {
> +                    compatible =3D "fixed-partitions";
> +                    #address-cells =3D <1>;
> +                    #size-cells =3D <1>;
> +
> +                    uboot@0 {
> +                        label =3D "nand-uboot";
> +                        read-only;
> +                        reg =3D <0x0 0x300000>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +
> +...


Thanks,
Miqu=C3=A8l

