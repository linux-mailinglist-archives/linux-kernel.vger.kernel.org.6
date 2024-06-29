Return-Path: <linux-kernel+bounces-234860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6293491CBA8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65F81F2278D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE639FC6;
	Sat, 29 Jun 2024 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4lPAW1j"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8523307B;
	Sat, 29 Jun 2024 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719649630; cv=none; b=embsXH/6pPRiZJsL945q6Tq/WpHagdK+L6jn5p1xBZYQRBGWiHWsBNmmBW8adisYP4IEWUldm+6MQ+tR1NSAaAiKaonviXlVmZ3UHjSh85DtbLV8KIS+GcRUUIhOMuEfjXfSB5OqG7LGipp1b0cd309Uwq45xnUbEw3A00nFFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719649630; c=relaxed/simple;
	bh=rcef8iIzGURe7pXw1mQCZTzP2eKL/Z3lfN2RM1HkMS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKSVZ9N7LXwTF62gW4Zz2VbRLdkrQhHrmd36osGE15k/IeEhEoTJoyEQirAC3x02bAUYRuA7rZHHD/iE2MlkAnGgB9mJAhVG6Gbd82SFJzED5nKi9k81TIGoT4B6D4457Y4SiFql6eA9ITcMJN5qkRl2cfNXUNxOk4TnuSoUKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4lPAW1j; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-63f7d53bd88so14084427b3.2;
        Sat, 29 Jun 2024 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719649627; x=1720254427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkIrYflEOoy6jtTabWktMcFcPY7E3RXh56B/EgJcCTQ=;
        b=J4lPAW1jbhWZc0rW6p6lKTf3bwYH5JykCQPUPL6ooGSvbpiIrskWWU0yGjp1uHxqcY
         J/wp+WBoHcFMQgAPUK5bkCcN+l3gsxM2FnAI4lZuSO5J/68PMfL4QtEI9PeVsR2CueXc
         xklfKEmk2tXrRLBU+b+kVopXbPY7MOH9EN9vMrlpcLI3twhXQ0TWkuVwNmbXKyIUgnwA
         /ftqYeaDcjnOCb9aso67AozLjfTL0JcIIho5s01RgkxohpNcVbNsuUSPMiI95XhdS+/w
         8mqOfEmsVlmTYJvlT0LbTw+pBW7+hoxlS4d1uajaXfO+yv5FuuuQZh+cEzMkB7To8u2M
         zbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719649627; x=1720254427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkIrYflEOoy6jtTabWktMcFcPY7E3RXh56B/EgJcCTQ=;
        b=rzYSfBefIgkH9YCAin8/cfLvlMaKM7roVN8rxEP23etX4aw4BTxbzjCjc8vyn6H82V
         qksk/tpILzj0FfoW1xuRI5Z/WkPsNacvRxU1lE6yqwm7gKikwKOb1BBPYqJwTvvuxuDb
         +QGbreVuQ+arDMyO0adxvAT9LNc8gMWzVnLU83snHjrcUjoFiyprSsmigh1EeDwnb10N
         UBfzoRrEFR2BERViXBoi9RbOqa/mA2FHGmZoz7o+lO7l3qbCKN5Rgvx2JO3UrR6fENLH
         OC3UQ9Cg016azsBaXNUA57ez08uGdk9MHjlEQHILqaVTxOjwNWnCCFrX7G4KJaLyuPph
         Q9cw==
X-Forwarded-Encrypted: i=1; AJvYcCU+YYbCZ4vW2cUKr8o7O2U5OYR1C+SJj3auYmML3DgdlG0qotYbdBD8qmlspmP7Iekix19CR8x/7VPl6quLnOPVK2yIHQvLod3VCQ==
X-Gm-Message-State: AOJu0Yyed3wM23QbQtsW2SlV2N4zEUqlkKkpwf7DDli7MlBVrAmHi2Hk
	0lXehKAnMJyzPe2r6o4X7+TtehDqHzsvE4f/wLx01F/Xo+OG0NgxCTpbTsyiXTU2U4sdhqjbr3j
	SsW5l1gdUw4TXcvV8CLRtqbGOZXE=
X-Google-Smtp-Source: AGHT+IHIWwG40xdoyk9zXVmAxYMSBaZ/ND6gAS8dOzZl1jedjTZmN5V7ueba1+HzrCC+PVHsS+xTVD4BocQqM7rYpBQ=
X-Received: by 2002:a0d:e612:0:b0:64a:3d7c:2782 with SMTP id
 00721157ae682-64c73606e65mr4798507b3.41.1719649627349; Sat, 29 Jun 2024
 01:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628051019.975172-1-kikuchan98@gmail.com> <20240628051019.975172-2-kikuchan98@gmail.com>
 <20240628-splashy-slug-1d74e3fd9fe6@spud>
In-Reply-To: <20240628-splashy-slug-1d74e3fd9fe6@spud>
From: Hironori KIKUCHI <kikuchan98@gmail.com>
Date: Sat, 29 Jun 2024 17:26:56 +0900
Message-ID: <CAG40kxERY2r2cj58kjVMMg1JVOChRKraKYFo_K5C5fnx0g80Qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: st7701: Add Anbernic RG28XX panel
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Conor,

Thank you for your reply.

On Sat, Jun 29, 2024 at 1:27=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Jun 28, 2024 at 02:10:15PM +0900, Hironori KIKUCHI wrote:
> > The RG28XX panel is a display panel of the Anbernic RG28XX, a handheld
> > gaming device from Anbernic. It is 2.8 inches in size (diagonally) with
> > a resolution of 480x640.
> >
> > This panel is driven by a variant of the ST7701 driver IC internally,
> > confirmed by dumping and analyzing its BSP initialization sequence
> > by using a logic analyzer. It is very similar to the existing
> > densitron,dmt028vghmcmi-1a panel, but differs in some unknown
> > register values, so add a new entry for the panel to distinguish them.
> >
> > Additionally, the panel is connected via SPI instead of MIPI DSI.
> > So add and modify for SPI as well.
> >
> > Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> > ---
> >  .../display/panel/sitronix,st7701.yaml        | 69 +++++++++++++++++--
> >  1 file changed, 64 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,s=
t7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st770=
1.yaml
> > index b348f5bf0a9..835ea436531 100644
> > --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.y=
aml
> > +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.y=
aml
> > @@ -20,21 +20,19 @@ description: |
> >    Densitron DMT028VGHMCMI-1A is 480x640, 2-lane MIPI DSI LCD panel
> >    which has built-in ST7701 chip.
> >
> > -allOf:
> > -  - $ref: panel-common.yaml#
> > -
> >  properties:
> >    compatible:
> >      items:
> >        - enum:
> >            - anbernic,rg-arc-panel
> > +          - anbernic,rg28xx-panel
>
> Please no wildcards in compatibles - what is the actual model of this
> panel? I don't really want to see the model of the handheld here if
> possible.

Well, the "RG28XX" is the actual product name of the device...
Besides, there is no vendor name or model name on the panel; there is
no information at all.
Since the panel cannot be disassembled from the housing of the device,
I named it like this.

>
> >            - densitron,dmt028vghmcmi-1a
> >            - elida,kd50t048a
> >            - techstar,ts8550b
> >        - const: sitronix,st7701
> >
> >    reg:
> > -    description: DSI virtual channel used by that screen
> > +    description: DSI / SPI channel used by that screen
> >      maxItems: 1
> >
> >    VCC-supply:
> > @@ -43,6 +41,13 @@ properties:
> >    IOVCC-supply:
> >      description: I/O system regulator
> >
> > +  dc-gpios:
> > +    maxItems: 1
> > +    description:
> > +      Controller data/command selection (D/CX) in 4-line SPI mode.
> > +      If not set, the controller is in 3-line SPI mode.
> > +      Disallowed for DSI.
> > +
> >    port: true
> >    reset-gpios: true
> >    rotation: true
> > @@ -57,7 +62,38 @@ required:
> >    - port
> >    - reset-gpios
> >
> > -additionalProperties: false
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            # SPI connected panels
> > +            enum:
> > +              - anbernic,rg28xx-panel
> > +    then:
> > +      $ref: /schemas/spi/spi-peripheral-props.yaml
>
> I'm not really keen on this. I'd rather see a different binding for the
> SPI version compared to the MIPI ones. Is doing things like this common
> for panels? If it is, I'll turn a blind eye..

This might be the first case that a driver supports both DSI and SPI
for a panel.
The panel can be either a DSI device or an SPI device.
I'm not sure if this is the right way to represent it in the documentation.=
..

>
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          not:
> > +            contains:
> > +              # DSI or SPI without D/CX pin
> > +              enum:
> > +                - anbernic,rg-arc-panel
> > +                - anbernic,rg28xx-panel
> > +                - densitron,dmt028vghmcmi-1a
> > +                - elida,kd50t048a
> > +                - techstar,ts8550b
>
> This is all the compatibles in the file, so nothing is allowed to use
> dc-gpios? Why bother adding it?

There are 3 types of connections that the driver supports: DSI, SPI
with D/CX pin, and SPI without D/CX pin.
Although most SPI panels don't have a D/CX pin, theoretically "SPI
with D/CX pin" exists.
So, it's just prepared for that.

IMHO, once it's found, the list should be negated. List panels for SPI
with D/CX pin, instead.

>
> Confused,
> Conor.
>
> > +    then:
> > +      required:
> > +        - dc-gpios
> > +    else:
> > +      properties:
> > +        dc-gpios: false
> > +
> > +unevaluatedProperties: false
> >
> >  examples:
> >    - |
> > @@ -82,3 +118,26 @@ examples:
> >              };
> >          };
> >      };
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        panel@0 {
> > +            compatible =3D "anbernic,rg28xx-panel", "sitronix,st7701";
> > +            reg =3D <0>;
> > +            spi-max-frequency =3D <3125000>;
> > +            VCC-supply =3D <&reg_lcd>;
> > +            IOVCC-supply =3D <&reg_lcd>;
> > +            reset-gpios =3D <&pio 8 14 GPIO_ACTIVE_HIGH>; /* LCD-RST: =
PI14 */
> > +            backlight =3D <&backlight>;
> > +
> > +            port {
> > +                panel_in_rgb: endpoint {
> > +                    remote-endpoint =3D <&tcon_lcd0_out_lcd>;
> > +                };
> > +            };
> > +        };
> > +    };
> > --
> > 2.45.2
> >

Best regards,
kikuchan.

