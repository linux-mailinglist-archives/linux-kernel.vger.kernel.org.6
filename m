Return-Path: <linux-kernel+bounces-290381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BFD95531E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155FB1F21BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7931448E7;
	Fri, 16 Aug 2024 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4hyAwpx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4413D882;
	Fri, 16 Aug 2024 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846185; cv=none; b=lY4zAUNm3GU7LBn9awae+NZaPI0Sjm8vp8vsnPHuobOiK7GhsWuhEn2suoOjwzmIsvXwpD3wyW4xBIZswDG3i1FIbIYB7KdciIzu8wyxu09CnuiDSHdX4WrzGDDHnNjr6SJ6mMLaPe8UJTtoM/9Bpp29JFbub/zBaJkwp3dWzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846185; c=relaxed/simple;
	bh=AAwJuH2zGYNfTnM3FYX+VEPhE2wO6i0zHqPriORw44Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhGh0JSSddS0uctQ2je2ZJY4IZqKMhnV2zBGN0mLoNzNeb70BxhQuaLLfnQ5QddIrxJwMo9pcRSfqKETNAbPcrf04xddW/qcUbCVgZQsPK7wUGvZdNl5D5wMWyar/Dwct8J0rllfa0qfXE7r2QTnyWJj++CU/TAOuE2wwFQDZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4hyAwpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8543FC32782;
	Fri, 16 Aug 2024 22:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723846184;
	bh=AAwJuH2zGYNfTnM3FYX+VEPhE2wO6i0zHqPriORw44Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o4hyAwpxT8yfbwGtJv3/Rs4NNhVZ3W/62bPZ/QNJDG5sQWuM5r2V8q3VvIl8GVNGg
	 6sW2jVaLZNvNZT6AKxrxB676FEmWrgeQ7EllztclTMQ3BdlusaKtstef+6zPfil2nr
	 s7ou5QPaUTXZhJljldP7oXxdfjlMQeRZnGhrnRRTNi9tgzHoM4DDfxcmxPmKgwHXlg
	 R2Zb17+1Tp6O7ZXkiUdSN62TJFvd9ENyxCGddWPlo5zREQvBvdCqYCikZjd5iPqlxp
	 nWviO8fUOXJ7Zs/X7e/woOwX8hK7bj50C9W2H1S5immxxYy/w6Hbg692ZLfiVR2FhO
	 GAl5EPSEai0sg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so3564687e87.1;
        Fri, 16 Aug 2024 15:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURzsIlEjaAU5VDx6cO673VGQD22mUemTP5x0Fzy/5uQuyerFaIbRUrBmJtVIn5/VnMxjaCaeQZKX6sYFGdQAhyJTZdn+PdQSsVT+e+Zcv1bOyIIAEJtURjXc5t7Io1Zqvfq3/tJ+7cMQ==
X-Gm-Message-State: AOJu0Yzjv2D2+YpRmJ8B8GdvSuqD+BuSZ6J3z9BYJVfkN0y3B/wfUYj3
	Rl5cBwKINW3eSinINFqe2pnkSIDa4b7wGXdfcvRkWsyRdXFQ3en7Imu/iYTaHv0UDu7aIxV/QqW
	LonCK4US9oQ6AWUYR6B3hHM88Tw==
X-Google-Smtp-Source: AGHT+IFH4jJKFlf/Q6eSSXTf+hWX9Mm+b1e8wZlJP+6Uj/y2F3qM66W8hO2upIFDnXbESsrTaARWhYAzt5mGmsmBL40=
X-Received: by 2002:a05:6512:3b20:b0:52c:caa6:13b4 with SMTP id
 2adb3069b0e04-5331c690049mr2904141e87.3.1723846182806; Fri, 16 Aug 2024
 15:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813163638.3889778-1-Frank.Li@nxp.com> <20240816212741.GA2225734-robh@kernel.org>
 <Zr/M4bSqaqCft/Y5@lizhi-Precision-Tower-5810>
In-Reply-To: <Zr/M4bSqaqCft/Y5@lizhi-Precision-Tower-5810>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Aug 2024 16:09:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfxkzNGXcy0gytsF7LFTDF9zmpfLent98uQmeBQvx0QQ@mail.gmail.com>
Message-ID: <CAL_JsqLfxkzNGXcy0gytsF7LFTDF9zmpfLent98uQmeBQvx0QQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: board: convert fsl-board.txt to yaml
To: Frank Li <Frank.li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 4:04=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Aug 16, 2024 at 03:27:41PM -0600, Rob Herring wrote:
> > On Tue, Aug 13, 2024 at 12:36:29PM -0400, Frank Li wrote:
> > > Convert binding doc fsl-board.txt to yaml format. split to 3 part
> > > fsl,bcsr.yaml, fsl,fpga-qixis.yaml, fsl,fpga-qixis-i2c.yaml
> > >
> > > Additional change for fsl,fpga-qixis.yaml
> > > - Add childnode mdio-mux-emi*
> > > - Add compatible string fsl,ls1043aqds-fpga, fsl,ls1043ardb-fpga,
> > > fsl,ls1046aqds-fpga, fsl,ls1046ardb-fpga, fsl,ls208xaqds-fpga,
> > > fsl,ls1043ardb-cpld, fsl,ls1046ardb-cpld, fsl,ls1088aqds-fpga,
> > > fsl,ls1088ardb-fpga, fsl,ls2080aqds-fpga, fsl,ls2080ardb-fpga.
> > > - Change address to 32bit in example.
> > >
> > > Additional change for fsl,fpga-qixis-i2c.yaml
> > > - Add mux-controller
> > > - Add compatible string fsl,ls1028aqds-fpga, fsl,lx2160aqds-fpga
> > >
> > > Fix below warning:
> > >
> > > arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/i2c@2000000/f=
pga@66: failed to match any schema with compatible: ['fsl,ls1028aqds-fpga',=
 'fsl,fpga-qixis-i2c', 'simple-mfd']
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change from v1 to v2
> > > - drop description in fsl,bcsr.yaml
> > > - bsc9132qds is too old, their dts have not simple-mfd.
> > > - split qixis-i2c compatible to two group, one with simple-mfd and th=
e
> > > other one without simple-mfd.
> > > - Add new full example for ls1028
> > > - Remove [0-9], keep @ for mdio-mux-emi. Dts need be update to avoid
> > > warning
> > > - fix typo dt-binding in subject
> > > ---
> > >  .../devicetree/bindings/board/fsl,bcsr.yaml   | 32 ++++++++
> > >  .../bindings/board/fsl,fpga-qixis-i2c.yaml    | 70 ++++++++++++++++
> > >  .../bindings/board/fsl,fpga-qixis.yaml        | 81 +++++++++++++++++=
++
> > >  .../devicetree/bindings/board/fsl-board.txt   | 81 -----------------=
--
> > >  .../boot/dts/freescale/fsl-ls1043a-qds.dts    |  2 +-

Add this part to your clean-up patch.

> > >  5 files changed, 184 insertions(+), 82 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/board/fsl,bcsr.=
yaml
> > >  create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-=
qixis-i2c.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-=
qixis.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/board/fsl-board=
.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/board/fsl,bcsr.yaml b/=
Documentation/devicetree/bindings/board/fsl,bcsr.yaml
> > > new file mode 100644
> > > index 0000000000000..df3dd8399671f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/board/fsl,bcsr.yaml
> > > @@ -0,0 +1,32 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/board/fsl,bcsr.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Board Control and Status
> > > +
> > > +maintainers:
> > > +  - Frank Li <Frank.Li@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,mpc8360mds-bcsr
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    board@f8000000 {
> > > +        compatible =3D "fsl,mpc8360mds-bcsr";
> > > +        reg =3D <0xf8000000 0x8000>;
> > > +    };
> > > +
> > > diff --git a/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i=
2c.yaml b/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
> > > new file mode 100644
> > > index 0000000000000..28b37772fb656
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
> > > @@ -0,0 +1,70 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/board/fsl,fpga-qixis-i2c.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Freescale on-board FPGA connected on I2C bus
> > > +
> > > +maintainers:
> > > +  - Frank Li <Frank.Li@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,bsc9132qds-fpga
> > > +          - const: fsl,fpga-qixis-i2c
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,ls1028aqds-fpga
> > > +              - fsl,lx2160aqds-fpga
> > > +          - const: fsl,fpga-qixis-i2c
> > > +          - const: simple-mfd
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  mux-controller:
> > > +    $ref: /schemas/mux/reg-mux.yaml
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        board-control@66 {
> > > +            compatible =3D "fsl,bsc9132qds-fpga", "fsl,fpga-qixis-i2=
c";
> > > +            reg =3D <0x66>;
> > > +        };
> > > +    };
> > > +
> > > +  - |
> > > +    i2c {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        board-control@66 {
> > > +            compatible =3D "fsl,ls1028aqds-fpga", "fsl,fpga-qixis-i2=
c",
> > > +                         "simple-mfd";
> > > +            reg =3D <0x66>;
> > > +
> > > +            mux-controller {
> > > +                compatible =3D "reg-mux";
> > > +                #mux-control-cells =3D <1>;
> > > +                mux-reg-masks =3D <0x54 0xf0>; /* 0: reg 0x54, bits =
7:4 */
> > > +            };
> > > +        };
> > > +    };
> > > +
> > > diff --git a/Documentation/devicetree/bindings/board/fsl,fpga-qixis.y=
aml b/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
> > > new file mode 100644
> > > index 0000000000000..4d4eb45ce64cd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
> > > @@ -0,0 +1,81 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/board/fsl,fpga-qixis.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Freescale on-board FPGA/CPLD
> > > +
> > > +maintainers:
> > > +  - Frank Li <Frank.Li@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - const: fsl,p1022ds-fpga
> > > +          - const: fsl,fpga-ngpixis
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,ls1088aqds-fpga
> > > +              - fsl,ls1088ardb-fpga
> > > +              - fsl,ls2080aqds-fpga
> > > +              - fsl,ls2080ardb-fpga
> > > +          - const: fsl,fpga-qixis
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,ls1043aqds-fpga
> > > +              - fsl,ls1043ardb-fpga
> > > +              - fsl,ls1046aqds-fpga
> > > +              - fsl,ls1046ardb-fpga
> > > +              - fsl,ls208xaqds-fpga
> > > +          - const: fsl,fpga-qixis
> > > +          - const: simple-mfd
> > > +      - enum:
> > > +          - fsl,ls1043ardb-cpld
> > > +          - fsl,ls1046ardb-cpld
> > > +          - fsl,t1040rdb-cpld
> > > +          - fsl,t1042rdb-cpld
> > > +          - fsl,t1042rdb_pi-cpld
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 1
> > > +
> > > +  ranges:
> > > +    maxItems: 1
> > > +
> > > +patternProperties:
> > > +  '^mdio-mux-emi@[a-f0-9]+$':
> >
> > If we're going to update the dts file, this should be 'mdio-mux@'. I'll
> > fix this when applying. The rest looks good.
>
> Thanks, I will fix dts in v2 3nrd clean up patchset.
>
> Frank
>
> >
> > Note that p5040ds.dts has 2 nodes at the same reg address, but differen=
t
> > bit offsets. The way we handle that is adding the register starting bit
> > offset to the unit-address like this:
> >
> > mdio-mux@9,1 (mux-mask 0x6)
> > mdio-mux@9,3 (mux-mask 0x78)
> >
> > Rob
>

