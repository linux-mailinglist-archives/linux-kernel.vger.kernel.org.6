Return-Path: <linux-kernel+bounces-274191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD059474B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC10FB20EBB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F13143738;
	Mon,  5 Aug 2024 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrKrdV+s"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B5639;
	Mon,  5 Aug 2024 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722836278; cv=none; b=QjZysGiRmC5aZwY3p0CR72wH9xeastKwXg4QitQAdkIxpp4ogiaFgv6BBcLI8MiOaTTa4EjflxQGrChUTZFF4pOHsaNaTSddHafxN7dNopPGifjG8lrafuaulGCOKeiX3ZraYdyKZqBkHlD/uPXEHpU4OU6RfYaH2p9pV0tp93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722836278; c=relaxed/simple;
	bh=W6icLZxwTRo/SJopei0DTuoBJuFi1POR3sdPQnWzfTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUz48cDe/qjNiMueEswaaHNef9SM2B2jOLsbjf/z9h0A7t0pLpVgyKenQvQKtuPA25/n0t7syrTW2/hxO4zWvov039ZMdQ/EjiFqQRPw0Gjugx+/Q6+LEZhVHhU4QuPZ6QyjHAsCysyIPMo8YmHRCDwMYW2iCMcalbwcWWKFAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrKrdV+s; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39b051817e0so2360675ab.0;
        Sun, 04 Aug 2024 22:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722836276; x=1723441076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6LPkoKlOEYKUBrjkr4bO02YY4lDC/XqBltvUaObBqU=;
        b=XrKrdV+sEqU2/Lbt+zLfOxrq5Ul5o0s6+ZRy5jSREYzixlIYyYKD/HRRB+osm9Mzeb
         rCgBrIv0/Mp+oz4RbXDd6Vg9mSXB93ax+KgQGwOM36Qjy9OXR3KnVgUNwRiJN2GH8W8x
         N2ZwXQqeGHDmMnDbUWSGRkwcc7hK0zRCqRSHDalVUSlE1vSbStuc1fOmbb8hpMUDnwse
         SYBgk2Ckv8Vh8296SprfwycFJynQOeMTo4I7Pabcb2GCdwXfiU2YmoM6rZaOKHywNfZZ
         zJ80B1SYKb68pAVJlwtzGizgwBF74RySAitzfOataPQzSsebtctrwLYAK9J3C3mhDrK+
         6ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722836276; x=1723441076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6LPkoKlOEYKUBrjkr4bO02YY4lDC/XqBltvUaObBqU=;
        b=NDhM9GcIuMW+IvsYDKZ+QbUZ2ou2A6CTPL3UiYAXBNgYe3+oP/szmzHly0U2DeIlWl
         5fPhn8EsLtwVF0YD6w0pMWUL6bl/rgDQXPtXOg3XZ56EDxg8Hw94SRBRR7m7YHiVVDYc
         G4V3uqOR9gWp4x0lLro1n35/Rz05PetOwWskyjYh/E/S11Xq/bB0wNwsbVm5oigCQVwS
         HPtVZ2XlPdj5ZPoNWTOZb7PTl9NnRKYNie68B5OeWFt4cQ4uQ6MbuikqgtLEKrTaYLZI
         c+kWmuspYKEqW+KkGjVtYcI+k7b+AZpRI5iljso/T8lInYwMuxUkD0sAmGcUXFB5Z6P4
         fkEw==
X-Forwarded-Encrypted: i=1; AJvYcCUWdLS3NW8Z2IvrwEjZpsnGot1eT9hIUEUgwFWhHUvOsRDd2fFHwMhP18r2tzxzf690eNkzOyUMmYRHqn1H@vger.kernel.org, AJvYcCV7OAgZKe0AZL9/NGm77QdW04Lsn+0i/q2xFST/DOIqYCBMaCoPkG45Yd8H7tZJytQ0eD0xxmnHQB/5@vger.kernel.org
X-Gm-Message-State: AOJu0YzOvQMaHnIRABVLllOL8nR9LwrD1CbbrXoHDyyjsXqSaCW0qcyx
	hE8+JzYBOHlSDsaTeSvxHQv+Od5pVdos3Hn1BsUfMR2GZLiZ9NpDW+8v/TImnQCV+nuPgt+pe9y
	5qWCx5O/1ItHyoRDq6Xvs6gjiD2OI0Jxh
X-Google-Smtp-Source: AGHT+IF198sb+5kT2eiO9NKzgM6Ilhavu7WvWLEWhaEmOkSuz261ZvEEAdm5+8XB9cazevhD1uwMxwhdqfWbhBsPuZY=
X-Received: by 2002:a05:6e02:1a49:b0:383:17f9:6223 with SMTP id
 e9e14a558f8ab-39b1fb79763mr67942385ab.2.1722836276215; Sun, 04 Aug 2024
 22:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801071946.43266-1-yschu@nuvoton.com> <20240801071946.43266-2-yschu@nuvoton.com>
 <c3ee7783-6891-4917-9935-21d46d8ac9a7@kernel.org> <202408012306316257ee23@mail.local>
In-Reply-To: <202408012306316257ee23@mail.local>
From: Stanley Chu <stanley.chuys@gmail.com>
Date: Mon, 5 Aug 2024 13:37:45 +0800
Message-ID: <CAPwEoQP=++bopg2V2_fqogvM0J1oXX9179CTLA=ZHf3Paegu0g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: i3c: Add NPCM845 i3c controller
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, krzk+dt@kernel.org, 
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com, 
	cpchiang1@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexandre Belloni <alexandre.belloni@bootlin.com> =E6=96=BC 2024=E5=B9=B48=
=E6=9C=882=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=887:07=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On 01/08/2024 16:53:52+0200, Krzysztof Kozlowski wrote:
> > On 01/08/2024 09:19, Stanley Chu wrote:
> > > The npcm845 i3c devicetree binding follows the basic i3c bindings
> > > and add the properties for allowing to adjust the SDA/SCL timing
> > > to meet different requirements.
> > >
> > > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > > Signed-off-by: James Chiang <cpchiang1@nuvoton.com>
> > > ---
> > >  .../bindings/i3c/nuvoton,i3c-master.yaml      | 123 ++++++++++++++++=
++
> >
> > Use compatible as filename. Anyway word "master" was dropped.
> >
> > >  1 file changed, 123 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/i3c/nuvoton,i3c=
-master.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master=
.yaml b/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml
> > > new file mode 100644
> > > index 000000000000..a40b37b16872
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml
> > > @@ -0,0 +1,123 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/i3c/nuvoton,i3c-master.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Nuvoton NPCM845 I3C master
> >
> > Use new terminology. Since 2021 there was a change... three years ago.
> >
> > > +
> > > +maintainers:
> > > +  - Stanley Chu <yschu@nuvoton.com>
> > > +  - James Chiang <cpchiang1@nuvoton.com>
> > > +
> > > +allOf:
> > > +  - $ref: i3c.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: nuvoton,npcm845-i3c
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: I3C registers
> > > +      - description: GDMA registers
> > > +      - description: GDMA request control register
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: i3c
> > > +      - const: dma
> > > +      - const: dma_ctl
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: system clock
> > > +      - description: bus clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: pclk
> > > +      - const: fast_clk
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  i3c-pp-scl-hi-period-ns:
> > > +    description: |
> >
> > Do not need '|' unless you need to preserve formatting.
> >
> > > +      If need to configure SCL with required duty cycle, specify the=
 clock high/low period directly.
> > > +      i3c-pp-scl-hi-perios-ns specifies the high period ns of the SC=
L clock cycle in push pull mode
> > > +      When i3c-pp-scl-hi-period-ns and i3c-pp-scl-lo-period-ns are s=
pecified, the i3c pp frequency is
> > > +      decided by these two properties.
> >
> > Wrap according to Linux Coding Style (and read coding style to figure
> > the proper wrapping...).
> >
> > > +
> > > +  i3c-pp-scl-lo-period-ns:
> > > +    description: |
> > > +      The low period ns of the SCL clock cycle in push pull mode. i3=
c-pp-scl-lo-period-ns should not
> > > +      be less than i3c-pp-scl-hi-period-ns and the maximal value is =
i3c-pp-scl-hi-period-ns + 150.
> >
> > Everywhere: defaults, constraints.
> >
> > > +
> > > +  i3c-pp-sda-rd-skew:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      The number of MCLK clock periods to delay the SDA transition f=
rom the SCL clock edge at push
> > > +      pull operation when transfers i3c private read.
> > > +    maximum: 7
> > > +    default: 0
> > > +
> > > +  i3c-pp-sda-wr-skew:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      The number of MCLK clock periods to delay the SDA transition f=
rom the SCL clock edge at push
> > > +      pull operation when transfers i3c private write.
> > > +    maximum: 7
> > > +    default: 0
> > > +
> > > +  i3c-od-scl-hi-period-ns:
> > > +    description: |
> > > +      The i3c open drain frequency is 1MHz by default.
> > > +      If need to use different frequency, specify the clock high/low=
 period directly.
> > > +      i3c-od-scl-hi-perios-ns specifies the high period ns of the SC=
L clock cycle in open drain mode.
> > > +      When i3c-od-scl-hi-period-ns and i3c-od-scl-lo-period-ns are s=
pecified, the i3c od frequency is
> > > +      decided by these two properties.
> > > +      i3c-od-scl-hi-period-ns should be equal to i3c-pp-scl-hi-perio=
d-ns or i3c-od-scl-lo-period-ns.
> > > +
> > > +  i3c-od-scl-lo-period-ns:
> > > +    description: |
> > > +      The low period ns of the SCL clock cycle in open drain mode. i=
3c-od-scl-lo-period-ns should be
> > > +      multiple of i3c-pp-scl-hi-period-ns.
> > > +
> > > +  enable-hj:
> > > +    type: boolean
> > > +    description: |
> > > +      Enable SLVSTART interrupt for receiving hot-join request.
> >
> > You described the desired Linux feature or behavior, not the actual
> > hardware. The bindings are about the latter, so instead you need to
> > rephrase the property and its description to match actual hardware
> > capabilities/features/configuration etc.
> >
>
> This has to be runtime configurable, see hotjoin in
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-i3c
>
Hi Alexandre,
Thanks for the review.
I will remove this property and follow the sysfs method.

>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

