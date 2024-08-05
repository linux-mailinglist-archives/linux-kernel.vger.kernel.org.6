Return-Path: <linux-kernel+bounces-274207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD842947508
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3F21C20C51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C7C1422BD;
	Mon,  5 Aug 2024 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYMnCp+P"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66862219EA;
	Mon,  5 Aug 2024 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722837914; cv=none; b=PZcgFQKFOHv7RAF65Jv/4jPn7vi8diy8uUxeyifu4OENlN/5rHIvBLziGsyHrzD8xF+lDJFsxFHcfJULY7BqjRdjTM0zF9GEf/FlbHE/g5i3HB/2X3PC9S5AfYCh8AUOfdcV0o9xVlY1RoG83hIlMxaipgekLWpc/0pkYBIXKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722837914; c=relaxed/simple;
	bh=Tu9q/rMUlouSC+lnfs0Ua3fWx71bXT5xpVm3yKKqijM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE3j/KaXFewGDmkiI9cDXZd3UnaFnng6S8jd6xm33k7kwXA++g+oJBugfyaygO3S7p0qzDTMACaIrmW34JRivlBHQRFz7wFZlVPe/7SWhVWgpeBmV66Lfyn2MKLCfhjOIBcpThTzZacR0iKS+l6y5aFM9d+WtX7ETNFWny0rBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYMnCp+P; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-81fdcd41e4cso6849239f.0;
        Sun, 04 Aug 2024 23:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722837911; x=1723442711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCOiHWZGaBYKEYIV5AXaKQnaZb+4wbF/Gdd5+BsrrYY=;
        b=KYMnCp+PTlO67ZuhxIZN9xiFvwY4oMTZe4BhAUsd3r0rZi9AUphVE7PaCHvuBDoV+B
         cYRICp7/6B3TEIuGOLKaDLaX4Gu9TVZ/l069oCG3inomJCnXw6W0bXNhxX1+e0M8O4p7
         4YAeQPzb0X2A+5WP8yQQxjbU7SDekOdjStpbCP48myE/unbKsmnjTaZQyK0wC2zGAS9v
         FQzNYeH8LiC7uN2x31T1yvdDQy2JzSesmf1WaoSKsFGuLrh8tpV/DPxrGbc4+kmjZop/
         ga6Tw9Pdu/Kdd/PChJH1se3kuA3tuNFfZP5a4HCGIHni2hMwczKLzWouuCGp2w153pDl
         hwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722837911; x=1723442711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCOiHWZGaBYKEYIV5AXaKQnaZb+4wbF/Gdd5+BsrrYY=;
        b=OOuwTRNNO0huZyG2Xdms3Kart9XXDQiaSZCRiqDNBZ6I7I5Y5Fk9AKE2cx9+p3gF/g
         /jqZiikmtLxuV7ebdXYcu/xHbkzcVTcmwXHojIqOQCu2tI3nwykU6fmmkFt98qcsvut+
         d+ErIOBvdq7EYUsqZcyHTJGMBRDcCYzsiLOYdwp833179eyvj9xz/nJVstCK3paLU/hn
         kvbKARgRUntPYThDuvFNZTfYPwa8WMnvouDwtax6dL93RkdWcZ/GL3DimTLY2kpeek+S
         Sc4Ia7w3qOA/2KjlGr3ZJgutjSWtsoHxyGl4VU3hF8zvsSb/pjC6VxRVqFU84n5UOu5O
         qEOA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Yxxxm/3tbqovv0p2C/vPqYKssG73ycyLgyRYBcU2yZCVyvIXFlI7q3I3nUq4RBPDQZay4mWdK/9j@vger.kernel.org, AJvYcCW4s8R26HFcNrHCqSLWCNEbgEZSUV4FijqR/yCD6kXqgRxnHEQ/lPa8FgF+b9jLVMtaYg6N7HAbGqBakHlA@vger.kernel.org
X-Gm-Message-State: AOJu0YyLPka1zZVNUC6tkJaPWG6HzeGjYySJSNd/znFe354HEInlvi28
	XogkighJdLqGkUYGWB60DnmX8nV/5xgFyMcKFnnR7j/e3JomswcoF5m5H9x6jLtvhT9OJUy1eTI
	KFsQSjaxa2EkhMQE/CATktwoUxKQ=
X-Google-Smtp-Source: AGHT+IEvB+oJugvBIutbGfuLyBjvlxjtlFSMweNO8CJuOYGPFKoKfHINvEaiH0X+jIsoGFK0sfrFHX3i+otIJAv9g2E=
X-Received: by 2002:a05:6e02:1c21:b0:383:297a:bdfb with SMTP id
 e9e14a558f8ab-39b1fb736eemr80408035ab.2.1722837911347; Sun, 04 Aug 2024
 23:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801071946.43266-1-yschu@nuvoton.com> <20240801071946.43266-2-yschu@nuvoton.com>
 <c3ee7783-6891-4917-9935-21d46d8ac9a7@kernel.org>
In-Reply-To: <c3ee7783-6891-4917-9935-21d46d8ac9a7@kernel.org>
From: Stanley Chu <stanley.chuys@gmail.com>
Date: Mon, 5 Aug 2024 14:04:59 +0800
Message-ID: <CAPwEoQMyUMn0Fp9G68Axk3guYB_+DT9f3AkPJiBCXVin=Dck=A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: i3c: Add NPCM845 i3c controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org, 
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com, 
	cpchiang1@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2024=E5=B9=B48=E6=9C=881=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:53=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 01/08/2024 09:19, Stanley Chu wrote:
> > The npcm845 i3c devicetree binding follows the basic i3c bindings
> > and add the properties for allowing to adjust the SDA/SCL timing
> > to meet different requirements.
> >
> > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > Signed-off-by: James Chiang <cpchiang1@nuvoton.com>
> > ---
> >  .../bindings/i3c/nuvoton,i3c-master.yaml      | 123 ++++++++++++++++++
>
> Use compatible as filename. Anyway word "master" was dropped.
>
> >  1 file changed, 123 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i3c/nuvoton,i3c-m=
aster.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.y=
aml b/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml
> > new file mode 100644
> > index 000000000000..a40b37b16872
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml
> > @@ -0,0 +1,123 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/i3c/nuvoton,i3c-master.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NPCM845 I3C master
>
> Use new terminology. Since 2021 there was a change... three years ago.
>

Hi Krzysztof,
Thanks for the review.
I will fix it in v2.

> > +
> > +maintainers:
> > +  - Stanley Chu <yschu@nuvoton.com>
> > +  - James Chiang <cpchiang1@nuvoton.com>
> > +
> > +allOf:
> > +  - $ref: i3c.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: nuvoton,npcm845-i3c
> > +
> > +  reg:
> > +    items:
> > +      - description: I3C registers
> > +      - description: GDMA registers
> > +      - description: GDMA request control register
> > +
> > +  reg-names:
> > +    items:
> > +      - const: i3c
> > +      - const: dma
> > +      - const: dma_ctl
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: system clock
> > +      - description: bus clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pclk
> > +      - const: fast_clk
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  i3c-pp-scl-hi-period-ns:
> > +    description: |
>
> Do not need '|' unless you need to preserve formatting.
>
> > +      If need to configure SCL with required duty cycle, specify the c=
lock high/low period directly.
> > +      i3c-pp-scl-hi-perios-ns specifies the high period ns of the SCL =
clock cycle in push pull mode
> > +      When i3c-pp-scl-hi-period-ns and i3c-pp-scl-lo-period-ns are spe=
cified, the i3c pp frequency is
> > +      decided by these two properties.
>
> Wrap according to Linux Coding Style (and read coding style to figure
> the proper wrapping...).
>

I wiill revise the description and properties in v2.

> > +
> > +  i3c-pp-scl-lo-period-ns:
> > +    description: |
> > +      The low period ns of the SCL clock cycle in push pull mode. i3c-=
pp-scl-lo-period-ns should not
> > +      be less than i3c-pp-scl-hi-period-ns and the maximal value is i3=
c-pp-scl-hi-period-ns + 150.
>
> Everywhere: defaults, constraints.
>
> > +
> > +  i3c-pp-sda-rd-skew:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The number of MCLK clock periods to delay the SDA transition fro=
m the SCL clock edge at push
> > +      pull operation when transfers i3c private read.
> > +    maximum: 7
> > +    default: 0
> > +
> > +  i3c-pp-sda-wr-skew:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The number of MCLK clock periods to delay the SDA transition fro=
m the SCL clock edge at push
> > +      pull operation when transfers i3c private write.
> > +    maximum: 7
> > +    default: 0
> > +
> > +  i3c-od-scl-hi-period-ns:
> > +    description: |
> > +      The i3c open drain frequency is 1MHz by default.
> > +      If need to use different frequency, specify the clock high/low p=
eriod directly.
> > +      i3c-od-scl-hi-perios-ns specifies the high period ns of the SCL =
clock cycle in open drain mode.
> > +      When i3c-od-scl-hi-period-ns and i3c-od-scl-lo-period-ns are spe=
cified, the i3c od frequency is
> > +      decided by these two properties.
> > +      i3c-od-scl-hi-period-ns should be equal to i3c-pp-scl-hi-period-=
ns or i3c-od-scl-lo-period-ns.
> > +
> > +  i3c-od-scl-lo-period-ns:
> > +    description: |
> > +      The low period ns of the SCL clock cycle in open drain mode. i3c=
-od-scl-lo-period-ns should be
> > +      multiple of i3c-pp-scl-hi-period-ns.
> > +
> > +  enable-hj:
> > +    type: boolean
> > +    description: |
> > +      Enable SLVSTART interrupt for receiving hot-join request.
>
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.
>
> > +
> > +  use-dma:
> > +    type: boolean
> > +    description: |
> > +      Enable the i3c private transfers using DMA.
>
> Why wouldn't you enable it always? Where are dma properties for this?
>

I plan to implement a separate dma driver later, this property will be remo=
ved.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clock-names
> > +  - clocks
> > +
> > +additionalProperties: true
>
> Nope, it cannot be true. Look how other bindings are doing this. Why
> implementing something entirely different?
>
> > +
> > +examples:
> > +  - |
> > +    i3c@fff10000 {
> > +        compatible =3D "nuvoton,npcm845-i3c";
> > +        clocks =3D <&clk 4>, <&clk 26>;
> > +        clock-names =3D "pclk", "fast_clk";
> > +        interrupts =3D <0 224 4>;
> > +        reg =3D <0xfff10000 0x1000>,
> > +              <0xf0850000 0x1000>,
> > +              <0xf0800300 0x4>;
>
> Order properties as in DTS coding style.
>
> > +        reg-names =3D "i3c", "dma", "dma_ctl";
> > +        resets =3D <&rstc 0x74 8>;
> > +        #address-cells =3D <3>;
> > +        #size-cells =3D <0>;
>
> Make your bindings complete - you skipped many properties. Why defining
> them if you are not using them and they do not have defaults?
>

Will fix it in v2.

> > +    };
>
> Best regards,
> Krzysztof
>

