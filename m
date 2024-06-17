Return-Path: <linux-kernel+bounces-218119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA490B982
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD9B1C243EA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12F51991AC;
	Mon, 17 Jun 2024 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzmsWrFj"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE11991B3;
	Mon, 17 Jun 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648105; cv=none; b=d4aXuw5kBYUYkGzmOWyZZ8/kHGen1iWujR30sZDT1VKRjHQ8EWTEOBDnkVhg4yhNlu5WFgZA8zO8aNg2kWxHkk86tr7VMG260NVNUYSkPqObdHYr+XXYY74SVD5JZvjTvpjQc8c3xmBG4sbgNapnOhbP7h2eUT8kFgJmnEyFVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648105; c=relaxed/simple;
	bh=WlGaxijLEkwQOs5XPQPJpCSIwrKVGx4PH+00815r0KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpbPfvUa8pBQ1Po8O8zqBy7PIXzuLOK62LKTvyt35BLjOIBOhJQRJtscCrf3yj1z2hi3ZiENrD/KhcDbnp+OlvVfHBDuRRyK2Xv7iXXVcGoiduVLD0Dc2SvzGZa24vCssOkasozUaj44okvlkmATSqL/kgxUhdCHhXMUinhpgHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzmsWrFj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-707040e3018so1219617a12.1;
        Mon, 17 Jun 2024 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648103; x=1719252903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M974AISyUszw6KdNIV1RmKUL/HdSEb00BoNkc7VhsBc=;
        b=IzmsWrFj0I2Kl/s5/Rl2kO9BJtpyAEbytsPhFtEp5pKogx+HMmp17PEfxYLoNADvbE
         RCdEduTR0savqCqvE+2YXKD6APQ0oixim2Ykj/i2/FjaiIzTHlBibyCKUYJ/TF6qvHVu
         VBfJPFZWwm9xfuSEMtBvHAH6t0nuVqPRLIWFwKVFQ5syY1MsbZ/vXiMuAWTAlpbnoeXr
         R4q6S22UDClg195tGOg6O3gLLChoyBmrXGXS6EQ/N6TIHi/TMJ0hdkeaillUGByUHZiw
         2U8triVKG59+OSz25/ZiLC48fO7jSG08K0o5e6ZBTY5ShDPGvp+zsSvKq9Xc5HjXozPl
         Koeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648103; x=1719252903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M974AISyUszw6KdNIV1RmKUL/HdSEb00BoNkc7VhsBc=;
        b=LNIchl/+Ghk9+bl6q1U00rA1vDAKGcJzE1tHXJLEZHq53DESrbQfu0uN4i4pdMAIV2
         tSvh+86z4SeSVByaE04T7kpO9oMS4jhSJGBb4xjhO1mkIZ5YrMhwhrph9Jqua68NI5eV
         oaVXOQ6jHJ1TwW76XCihuRKdqBrppAQNUTM7jEGjVjgjdNvpcd4tjcQAmBZTT3RU6C4o
         TcKVFzMMO8yc66q5OoAORkVH1oLhkvhqWdw4g0uyPaJvOTys4o0P05RpkrYyRTLPyKfj
         ad11aDs8dKk6PxsV6Wy3i+olcpDL5+6yTfNjWDpfyp1VTOVos3J7p573XW52XikFIHZK
         qKhg==
X-Forwarded-Encrypted: i=1; AJvYcCVs9+78YNA5nu+5DuOpCtGMgSGngX2L84ti+5quGkQ61ykCTEiUYj6/XIoem/0bhFR0AmdJVFx/sD5tne1GbyNk3c3RGqkrwetQPXsYYHYukdCIRV8VBvPupU2Yz05u+IONlAt2ioNwAA==
X-Gm-Message-State: AOJu0YzygIxMT92r8aks8HCWPWf175cORWvPKPICToE2GjQlX39i/na2
	GIasW5tG/aAG2MKImks9uTONKTX0fjqgVcz8viio/dZXpPNTLZ1neWzeHCMtAknbf/Xz2bp0Ock
	CMfN1pHAsmfj7oHGhUJ0zty3hfLA=
X-Google-Smtp-Source: AGHT+IHpOuUM0L3BTbS1HfBI1VIZPv5eoLvdmVxiN/0e5Oe64mve/QeTY1xhV69RJoQVC6c6pivweM3JaT15w45jUO0=
X-Received: by 2002:a17:90a:608:b0:2c2:dfc3:10b6 with SMTP id
 98e67ed59e1d1-2c4db44b84emr10119160a91.24.1718648102615; Mon, 17 Jun 2024
 11:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617085341.34332-2-shresthprasad7@gmail.com> <f691c7f9-cd81-4bdf-a794-95118cb26686@kernel.org>
In-Reply-To: <f691c7f9-cd81-4bdf-a794-95118cb26686@kernel.org>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Mon, 17 Jun 2024 23:44:50 +0530
Message-ID: <CAE8VWiLqBUq=-PzT2XVKB_C9nvEERM0x-maWU5qt0+aK1Rd-kg@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, sebastian.reichel@collabora.com, 
	andy.yan@rock-chips.com, s.hauer@pengutronix.de, jbx6244@yandex.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 9:29=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 17/06/2024 10:53, Shresth Prasad wrote:
> > Convert txt bindings of Rockchip EMMC PHY to dtschema to allow
> > for validation.
> >
> > Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> > ---
>
>
> ...
>
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: emmcclk
> > +
> > +  clocks:
> > +    maxItems: 1
>
> Keep order from DTS coding style, so clocks then clock-names.
>
> > +
> > +  drive-impedance-ohm:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Specifies the drive impedance in Ohm.
> > +    enum: [33, 40, 50, 66, 100]
> > +    default: 50
> > +
> > +  rockchip,enable-strobe-pulldown:
> > +    type: boolean
> > +    description: |
> > +      Enable internal pull-down for the strobe
> > +      line.  If not set, pull-down is not used.
> > +
> > +  rockchip,output-tapdelay-select:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Specifies the phyctrl_otapdlysec register.
> > +    default: 0x4
> > +    maximum: 0xf
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#phy-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    grf: syscon@ff770000 {
>
> Drop label... actually entire node looks not needed.

From what I understand, this `phy` node should be a sub-node of a `grf`
node which is why it is part of the example.

>
> > +      compatible =3D "rockchip,rk3399-grf", "syscon", "simple-mfd";
>
> Drop
>
> > +      reg =3D <0xff770000 0x10000>;
>
> Drop

Removing `reg` causes the following warning:
Warning (unit_address_vs_reg): /example-0/syscon@ff770000: node has a
unit name, but no reg or ranges property

Please let me know what the prefered solution would be here.

>
>
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
> > +
> > +      emmcphy: phy@f780 {
>
> Drop label
>
> > +        compatible =3D "rockchip,rk3399-emmc-phy";
> > +        reg =3D <0xf780 0x20>;
> > +        clocks =3D <&sdhci>;
> > +        clock-names =3D "emmcclk";
> > +        drive-impedance-ohm =3D <50>;
> > +        #phy-cells =3D <0>;
> > +      };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.tx=
t b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> > deleted file mode 100644
> > index 57d28c0d5696..000000000000
> > --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> > +++ /dev/null
> > @@ -1,43 +0,0 @@
> > -Rockchip EMMC PHY
> > ------------------------
> > -
> > -Required properties:
> > - - compatible: rockchip,rk3399-emmc-phy
> > - - #phy-cells: must be 0
> > - - reg: PHY register address offset and length in "general
> > -   register files"
> > -
> > -Optional properties:
> > - - clock-names: Should contain "emmcclk".  Although this is listed as =
optional
> > -             (because most boards can get basic functionality without =
having
> > -             access to it), it is strongly suggested.
> > -             See ../clock/clock-bindings.txt for details.
> > - - clocks: Should have a phandle to the card clock exported by the SDH=
CI driver.
> > - - drive-impedance-ohm: Specifies the drive impedance in Ohm.
> > -                        Possible values are 33, 40, 50, 66 and 100.
> > -                        If not set, the default value of 50 will be ap=
plied.
> > - - rockchip,enable-strobe-pulldown: Enable internal pull-down for the =
strobe
> > -                                    line.  If not set, pull-down is no=
t used.
> > - - rockchip,output-tapdelay-select: Specifies the phyctrl_otapdlysec r=
egister.
> > -                                    If not set, the register defaults =
to 0x4.
> > -                                    Maximum value 0xf.
> > -
> > -Example:
> > -
> > -
> > -grf: syscon@ff770000 {
> > -     compatible =3D "rockchip,rk3399-grf", "syscon", "simple-mfd";
> > -     #address-cells =3D <1>;
> > -     #size-cells =3D <1>;
> > -
> > -...
> > -
> > -     emmcphy: phy@f780 {
> > -             compatible =3D "rockchip,rk3399-emmc-phy";
> > -             reg =3D <0xf780 0x20>;
> > -             clocks =3D <&sdhci>;
> > -             clock-names =3D "emmcclk";
> > -             drive-impedance-ohm =3D <50>;
> > -             #phy-cells =3D <0>;
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/=
Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > index 79798c747476..6e1b1cdea680 100644
> > --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > @@ -176,9 +176,12 @@ allOf:
> >              Documentation/devicetree/bindings/phy/rockchip-pcie-phy.tx=
t
> >
> >        patternProperties:
> > -        "phy@[0-9a-f]+$":
> > -          description:
> > -            Documentation/devicetree/bindings/phy/rockchip-emmc-phy.tx=
t
> > +        "^phy@[0-9a-f]+$":
> > +          type: object
> > +
>
> Drop blank line
>
> > +          $ref: /schemas/phy/rockchip,rk3399-emmc-phy.yaml#
> > +
>
> Drop blank line

The rest of the document also has these blank lines, which is why I've
also kept them here. Are you sure I should remove them?

>
> > +          unevaluatedProperties: false
> >
> >    - if:
> >        properties:
>
> Nothing in example? Isn't the example for 3399?
>
> We want only one complete example of such multi-children devices, so the
> example can be moved and included in existing one here.

The example in this file is actually for `rockchip,rk3399-usb2phy` and
not `rockchip,rk3399-emmc-phy` which is why I haven't touched it.

Should I add to the example in `grf.yaml` ?

>
>
> Best regards,
> Krzysztof
>

Please let me know if I've misunderstood anything or if there are any
other changes I should make.

Regards,
Shresth

