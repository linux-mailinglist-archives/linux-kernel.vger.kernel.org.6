Return-Path: <linux-kernel+bounces-511372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CA6A32A13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B9167C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34230254B14;
	Wed, 12 Feb 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="K4nxbrMf"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C5212FB2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374212; cv=none; b=LKJBvFYZSrttEl50oIxruVSuzgOWGk9CFwKFfjSKnvSdX8sGCdnT5QlShg7jLwNnf9x1Q5gqO5Dmq6Jdv80VpU8F4x1jtXDjT0VKebUF0gPojbrRBHAT5FsE6ASHK7XQfc5Vafp0J/ZCHeGi1DydxpoE8KR4iDtp9Qumh+uwML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374212; c=relaxed/simple;
	bh=7z/x3nrHx13b23QGvrVV/m59su6RSqWFgqr6BQDjpvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJg0KWT0pP06mel5vKZ/+OtAOfSjRS1sY8AiCAmzGPpvh6NZbeHQrL91f16l0PyZ1WTwSCkR9S8bLrMyj/Nnvqqq15jigMw/R5GS01jyTDM9Cgh5dV0kebIt7HbqlnTot1MA6j9+iuP29OfJx7WmkurbAbe3/l/6sBWHK+Go0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=K4nxbrMf; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso5022714276.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1739374208; x=1739979008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTOTPGSXVq2qgpJeXCjqv2Ft7/R2pLQdaC/aHf11ROc=;
        b=K4nxbrMf/x/2VyDCbGOTwDvM+PPqW6ZQ3052ocq/JsEMLSoYgHZEZhgsS0tfVqvWY5
         QgeDduMkjrt5BRkGvk6DyU/kyf7atnDzTMSGoj5INJzcjjI1f+SF0PbJBBTYJNBiPY6e
         TmF+OZU00/I7Y/QESJbbtOmbFzC7tTf3q7om3+ATIs4XC158avXxnreal8PtsO8QHIG7
         +WoC/Db7KhUFQ+8Ivv/Cj9F0uphtrDE4QoCDGEwycp3IQZ6R4ARsN0y3uP1tMWNtxPdD
         37bP7Yb+2PcOp2Q1KoCD7hErYSLd20QuEDrEHJH/XaN35F2JJPublBWTGDcRkLZ86WsT
         yShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374208; x=1739979008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTOTPGSXVq2qgpJeXCjqv2Ft7/R2pLQdaC/aHf11ROc=;
        b=nWq5Q56ExqHST1iZJ+XRRvvsycgAJHKnYC7Y6kVf4QPxpHhB3yOsg68LV4nZVr+77b
         hOYX3XW7uV6YlPStUBpL7DklS4jF68+hkwCFltUcVppJX3n7UgAN/qXQSd6RWrds4fSS
         U3oevSWcOKrVSDa70A2pO4xRcESq19YSq9LQU+RIoCTeXbvzLtpWfPBTeVCU5nHcXndg
         mWwe5edH1hQef94fsChPhGeUUIp3Oj7b5ncmKLcPNZ4HhrjM0li6eXbo5oLnzMDpf2fr
         x8dyaijP0X569mc3pnRT+8Yo6e4LYhQ17OEDq9TgSt9rPL11QCMMfFWUUIKmfMhuZoN/
         shhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYOB1ZaAqTtDF/3GHN8iBUrkNrrFMGHfnNqNKbmHRE9jEsxGdvkI/CGat4PN08DsSovbF4KGoHpbbwnEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjtT7amnHpfmUUU/LgBLXgFZS34Rqnjey+CHJqzcZtonCP8aX
	K6p5YBSiR1UCSA0ry6MsQ8onb+OHO4mGo8lCkVMbVwL49BoqqJq3CZ6P6nVnVKjFaHutRr3o0S+
	Z78n9c2e181yuxnynnwP1iMvLw0SStFuyohVr8Q==
X-Gm-Gg: ASbGncspMnup4WVvP9Jfvmr+/QaQdZMyiMDKu+DTpz4RTLnrkv0CAPu2iPSkoZh4Cma
	A2r4kpXPkTbukbvOaX/2IRxEraUZVOLVXEbs8XEarBTUqrPmPr88dGVq/NUlYLOvJxuVL7SGCwj
	R+WU4Swc+Y8ex9jGWIEgi2Ku2Fr46d
X-Google-Smtp-Source: AGHT+IFUb4n11X1/VcN5iFZGdf4HHxlpQCoy65XYiTGAuIoCG6TjlthfZgl+P4Z0rbVGRXLADkV617rUgazdBwsWIr4=
X-Received: by 2002:a05:6902:c0f:b0:e5b:3af0:d4b6 with SMTP id
 3f1490d57ef6-e5d9f177b0dmr3316437276.39.1739374208065; Wed, 12 Feb 2025
 07:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-media-rpi-hevc-dec-v2-0-69353c8805b2@raspberrypi.com>
 <20250206-media-rpi-hevc-dec-v2-3-69353c8805b2@raspberrypi.com> <20250211222050.GA1285038-robh@kernel.org>
In-Reply-To: <20250211222050.GA1285038-robh@kernel.org>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 12 Feb 2025 15:29:50 +0000
X-Gm-Features: AWEUYZmslfR01LxrPJ1PLnJuhBuZI5WK77fvcWU4nKbcXM4bWkAo5JbzUXEm5FY
Message-ID: <CAPY8ntD3Frq5HzV06OrS1051QfjJFzvqs9H4mUkVnd4QKqiMhg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] media: dt-bindings: media: Add binding for the
 Raspberry Pi HEVC decoder
To: Rob Herring <robh@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, John Cox <john.cox@raspberrypi.com>, 
	Dom Cobley <dom@raspberrypi.com>, review list <kernel-list@raspberrypi.com>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, John Cox <jc@kynesim.co.uk>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob

On Tue, 11 Feb 2025 at 22:20, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 06, 2025 at 06:02:36PM +0000, Dave Stevenson wrote:
> > Adds a binding for the HEVC decoder found on the BCM2711 / Raspberry Pi 4,
> > and BCM2712 / Raspberry Pi 5.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > ---
> >  .../bindings/media/raspberrypi,hevc-dec.yaml       | 67 ++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/raspberrypi,hevc-dec.yaml b/Documentation/devicetree/bindings/media/raspberrypi,hevc-dec.yaml
> > new file mode 100644
> > index 000000000000..06db7004c765
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/raspberrypi,hevc-dec.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/raspberrypi,hevc-dec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Raspberry Pi HEVC Decoder
> > +
> > +maintainers:
> > +  - John Cox <john.cox@raspberrypi.com>
> > +  - Dom Cobley <dom@raspberrypi.com>
> > +  - Dave Stevenson <dave.stevenson@raspberrypi.com>
> > +  - Raspberry Pi internal review list <kernel-list@raspberrypi.com>
> > +
> > +description:
> > +  The Raspberry Pi HEVC decoder is a hardware video decode accelerator block
> > +  found in the BCM2711 and BCM2712 processors used on Raspberry Pi 4 and 5
> > +  boards respectively.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - raspberrypi,hevc-dec
>
> SoC specific compatible please. If they are 'the same' then 2712 can
> fallback to 2711.

Can I just make sure I understand your request before I respin?
This is a Raspberry Pi IP block that has been added to the Broadcom
SoCs. It's the same situation as for PiSP Backend which is documented
in bindings/media/raspberrypi,pisbe.yaml

Based on that I'm interpreting your comment as wanting:

properties:
  compatible:
    items:
      - enum:
          - brcm,bcm2711-hevc-dec
          - brcm,bcm2712-hevc-dec
      - const: raspberrypi,hevc-dec

Is that right?

Thanks
  Dave

> > +
> > +  reg:
> > +    items:
> > +      - description: The HEVC main register region
> > +      - description: The Interrupt control register region
> > +
> > +  reg-names:
> > +    items:
> > +      - const: hevc
> > +      - const: intc
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: The HEVC block clock
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    video-codec@7eb10000 {
> > +        compatible = "raspberrypi,hevc-dec";
> > +        reg = <0x7eb00000 0x10000>, /* HEVC */
> > +              <0x7eb10000 0x1000>;  /* INTC */
> > +        reg-names = "hevc",
> > +                    "intc";
> > +
> > +        interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +        clocks = <&clk 0>;
> > +    };
> > +
> > +...
> >
> > --
> > 2.34.1
> >

