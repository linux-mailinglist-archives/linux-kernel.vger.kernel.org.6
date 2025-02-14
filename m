Return-Path: <linux-kernel+bounces-514441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F82A35716
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180E73ACE67
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346EC1FFC7C;
	Fri, 14 Feb 2025 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbLt3n8L"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270022071;
	Fri, 14 Feb 2025 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514579; cv=none; b=YGLdPhQ9RnojD3dJb5lCCGWKY57/VrBAG2yLNXIrsPw6mmJfuIVuoYD9Oyt0Ugd0jDJdHXVbMm79X1K7ma2gGAEsk5ytNTfx4NlDfhU52fCrtKlE0Xfd28EyUogoQbDK+cx7QOmuGe178bT98X84C45CekO0nX8hWO1vYmJWJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514579; c=relaxed/simple;
	bh=UsEB+A/XPaEDIkHx8pGbAsIhq7XByBu36IKvE9bh6Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhEPX2Ga2m17NTls98MRiKBKGIlHto9WU9u8QnGvIYkP36wkch0A19xSxh0i/SJjUy24ngRthgod+3qT8eksk6yWGJxEzzE39LvGeO9RHiP9aO0NKGs1j0jTmKpZa2HjzUZJnTYG/IAcn7JXELa51WkAySZhmzTYMqKP/RwiCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbLt3n8L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4395817a7f2so10961405e9.1;
        Thu, 13 Feb 2025 22:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739514576; x=1740119376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0DNrIkpi+rgWunP8esx8b13URNUv1qzTHQGLBvyHZQ=;
        b=cbLt3n8LXAuQmxb0dfusApdrR+FZt1tFpuAGD9114XlSylgVjdqCc7v8QRSLJFrfqm
         XK45aezwr9N8LmHX6fcKYObWy89N/etNeXimItZFi0X0rvN481ez3B8eaMfKGrymZ4Z3
         tbi1b0oxvHcMTWnU5tGS00kQkpQl9hxNiLHWpuaR+Zki/KORsezze8fX1YXon+Q1pd3R
         OqoUC9xF0E6JaZTkEsmBjAFfMdrSY8qWET2YE/1sH+rg3DKvQb1T90kUaHhKCyl01LX6
         2ctj8JUqcBFikzDcbRvEOF01W+N+SToGP3ed1aAlgDXCOpg3uXCzBG5+91yQrLwFDdnY
         S08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739514576; x=1740119376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0DNrIkpi+rgWunP8esx8b13URNUv1qzTHQGLBvyHZQ=;
        b=c6zivmkr5k4CcD+hGZH8zmxPC//yKii4Dzp7ywZPCOQid/FcEwgP6IhQnqhf3Lw6f/
         fZSG5yDqn/pDhOsojoYj+NutcfWSrY+9UdBpT2E20AghgS4Zi42s+OIR++OBIGZEMn/a
         w8zd0nM5IrHRjYZ9b2r3uvW8jcG3ljV6Pi3HdQHt7QGlEux0/3PArbKcxKwrey/wAbV8
         zoIr8zYOPYtzwOeADrEuvxOVDY80jvLKpw4Q74s73qYXLqYaduKa8k0Rb6XeKz8rJoB2
         NM7fu32ONeSK234l8OV3fY+T131sZICvotV1IrnBmf831ZNHT3Aef8LupFZ6AA+uhp/n
         JUJg==
X-Forwarded-Encrypted: i=1; AJvYcCUF/FUDV/FoiRZO6KeRzJ5L+f4m3PRE6kiAyLAsxpZel3WsGH+Orl7i3kfmwq1hufnMPKUJ7+MzfNYptNdW@vger.kernel.org, AJvYcCUVj0Ft0Lb16PBX5MEq0L+kyPgtmyiThW10A2s/FLsJuMnEw/xJiZB7ZfZLqWK9TvViwJkO3vv0tLlW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LARIyxEy2+W8LAQIpUKAUHNstkns5T5L91GKoMIBIRsiykyq
	TB5h9FokE4c7b96BbIihfIJ9E19OqvnLCxhgiEc2uQCs3bpBqcJ7LoEbnvOHIdpeiODonuXYcjd
	0cHB4d4WZZKtNz9mwfj4WmCGLLP0=
X-Gm-Gg: ASbGncuO5T3X53vjijtjqtuSHnV+/AP1ARvhlXUSWElMxHzbHYevXpK2tnGuFSbhHpc
	uAWQtScSsNmHgCScpt3zS7as709zgoW6RcM7zTp1khmOYHfmUnd1Oly/d4F7zspLVngKH4Cnh6Q
	==
X-Google-Smtp-Source: AGHT+IGY5xLuVN8j9KsxRf6bcc1+me7BVeaaH17aSLDBupkE+g+TY2Q6JdeoAWh5pe090nZSLG814Kwqa2FtZu049v4=
X-Received: by 2002:a05:600c:870a:b0:439:42c6:f11f with SMTP id
 5b1f17b1804b1-43960169268mr80052915e9.4.1739514575486; Thu, 13 Feb 2025
 22:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213135605.157650-1-clamor95@gmail.com> <20250213135605.157650-2-clamor95@gmail.com>
 <20250213-pumice-overcrowd-6c22b0d5d66c@spud>
In-Reply-To: <20250213-pumice-overcrowd-6c22b0d5d66c@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 14 Feb 2025 08:29:22 +0200
X-Gm-Features: AWEUYZn67J7NbLVEkrwrIx99cgEMyRnxO5YdBiYvqEdfxjG1cBd7qt5e9I3cnEU
Message-ID: <CAPVz0n1CpoAFvwwvoTOFQu4mgg57jCwS5W4GXCiUZ3eLEAdwZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: Document Solomon SSD2825
To: Conor Dooley <conor@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 13 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 22:34 Cono=
r Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Feb 13, 2025 at 03:56:04PM +0200, Svyatoslav Ryhel wrote:
> > Add bindings for Solomon SSD2825 MIPI master bridge chip that connects =
an
> > application processor with traditional parallel LCD interface and an LC=
D
> > driver with MIPI slave interface. The SSD2825 supports both parallel RG=
B
> > interface and serial SPI interface.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../display/bridge/solomon,ssd2825.yaml       | 140 ++++++++++++++++++
> >  1 file changed, 140 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/so=
lomon,ssd2825.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/solomon,s=
sd2825.yaml b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2=
825.yaml
> > new file mode 100644
> > index 000000000000..cd7ff971495c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.=
yaml
> > @@ -0,0 +1,140 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/solomon,ssd2825.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Solomon SSD2825 RGB to MIPI-DSI bridge
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: solomon,ssd2825
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reset-gpios: true
> > +
> > +  dvdd-supply:
> > +    description: Regulator for 1.2V digital power supply.
> > +
> > +  avdd-supply:
> > +    description: Regulator for 1.2V analog power supply.
> > +
> > +  vddio-supply:
> > +    description: Regulator for 1.8V IO power supply.
> > +
> > +  spi-max-frequency:
> > +    maximum: 1000000
> > +
> > +  spi-cpha: true
> > +  spi-cpol: true
>
> Should these be required? Supplies should really be required too, since
> the device probably cannot function without them?
>

No, since spi-* define mode in which device works. If both are present
it is mode 3, if none it is mode 0.

About supplies, device cannot work without power supply obviously, but
often exact supplies are not known and I would like to not enforce
someone to add random regulators just because they are mandatory.

> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: tx_clk
>
> Drop the _clk, since this cannot be anything else! clock-names isn't
> really useful when you have just one, so I'd be inclined to say remove
> it entirely...
>

TX_CLK is the name which datasheet refers to hence I have included
clock name solely to have clear link between datasheet clock
references and clock used here.

> > +  solomon,hs-zero-delay-ns:
> > +    description:
> > +      HS zero delay period
> > +    default: 133
> > +
> > +  solomon,hs-prep-delay-ns:
> > +    description:
> > +      HS prep delay period
> > +    default: 40
>
> Do these two have limits? Use maximum/minimum to set them if so.
> Cheers,
> Conor.
>

Datasheet does not specify limits actually, only defaults. I will try
to calculate boundaries.

> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description:
> > +          Video port for RGB input
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              bus-width:
> > +                enum: [ 16, 18, 24 ]
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Video port for DSI output (panel or connector)
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        dsi@2 {
> > +            compatible =3D "solomon,ssd2825";
> > +            reg =3D <2>;
> > +
> > +            spi-max-frequency =3D <1000000>;
> > +
> > +            spi-cpha;
> > +            spi-cpol;
> > +
> > +            reset-gpios =3D <&gpio 114 GPIO_ACTIVE_LOW>;
> > +
> > +            dvdd-supply =3D <&vdd_1v2>;
> > +            avdd-supply =3D <&vdd_1v2>;
> > +            vddio-supply =3D <&vdd_1v8_io>;
> > +
> > +            solomon,hs-zero-delay-ns =3D <300>;
> > +            solomon,hs-prep-delay-ns =3D <65>;
> > +
> > +            clocks =3D <&ssd2825_tx_clk>;
> > +            clock-names =3D "tx_clk";
> > +
> > +            ports {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                port@0 {
> > +                    reg =3D <0>;
> > +
> > +                    bridge_input: endpoint {
> > +                        remote-endpoint =3D <&dpi_output>;
> > +                        bus-width =3D <24>;
> > +                    };
> > +                };
> > +
> > +                port@1 {
> > +                    reg =3D <1>;
> > +
> > +                    bridge_output: endpoint {
> > +                        remote-endpoint =3D <&panel_input>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > --
> > 2.43.0
> >

