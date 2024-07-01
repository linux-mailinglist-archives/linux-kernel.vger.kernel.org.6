Return-Path: <linux-kernel+bounces-236749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9556E91E6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D208283950
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAEA16E872;
	Mon,  1 Jul 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/yDFJI2"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD816EB60;
	Mon,  1 Jul 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854921; cv=none; b=XATtu/PxXaI830VTmkWYkuGiNDSodP7zfdw90D5CjwV/GMw+GZ20Eo6hZCinxq1qcBlo6VyfwunKTj++bf2fhDOQS6BeuBkv5xVLL5zEo5AiMqjn/KBa6c1hm0tin01DtLyRuiHl50QSjeMvsnJvvmzo7jxhHvNiVVB4wuY9Apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854921; c=relaxed/simple;
	bh=7utA9sGI7P2xtwGJsTsUUV9wq0oTKVY7mZ0NZ/K4h14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGVqWcEcXcGHfcwUXYKrIcVE69UN0l/2uhD8u9rUdomnXgumn1M/dFmg2+MCHDcVWD7CQbou8tn6exvbWhi4bYI0wmM8YHFRky+XkOEXxtbXWU8LCb1FmNCCtzgLZSCMguRHfmJJk0ibRnlep34dxpvDNarTosOi4ccm5ppQV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/yDFJI2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64f4f96bbf9so6251597b3.2;
        Mon, 01 Jul 2024 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719854919; x=1720459719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSFG//zBVdEwBNZor3bRFSZ1DAICKTEQMxvdGgDsDzg=;
        b=U/yDFJI2YP6/GuxjUlvMh1uRp/Z/6uFAKrpA5MKBXNC5kuCvk2oootNHJWeeXj3tNW
         Kr+s7pfo33wD7NatXmMkooB/17M7wXRJRksC/fhhw3X2676GeL+cgidqTFTcH9NxD9E5
         sqKVAH4aNYiakddkqVVYWSk7Rgbqk+Nc+8lUspl+pl4MXJDkNuRxOlsgLVRVp9aqexrr
         NAGYj5Ldpy4kfLHGqx7GHLhV8VqDHFGCeEHMd4k64xWgrVTUeBdZ1HpXVSfK1ymTVXqQ
         LOu2UOdL8YMxz7QyLrV+ntAiOYLe3jjEo0GhWqqlIKuTruap9AaHWzLUzytEJgeEXX7H
         N1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719854919; x=1720459719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSFG//zBVdEwBNZor3bRFSZ1DAICKTEQMxvdGgDsDzg=;
        b=oYF85jsD7UbZymCZZBU0Edkcs1SfNLmQnuBLAzYovHCjJIR8zjFUTf7aK0p58JTMdr
         Ce1jjHzkVBacWR8S1kOsbYOEhff7ZZEw9NoKomYQxxjAaU7nbN21jnnMHuJ/vM0KSHyi
         CoczPa+MBnqe/CCLKJwfNuXgJ0x4/Ot3FK3SujVXKzvhRtQzx5JcWOIys4eY77WeIejL
         muYRP6yao99oxr8vMIEMe7o27aTmfiFhyi/IvXVJ3kSQCafi679dxZ8sOPhtv0MOXZlx
         Rip4Q5lveLv7xqRLd43qPBo7Xy9eCy6pLz8QcWAxag4E0wEtnUa6ESfU8teUapC7gbsJ
         Eriw==
X-Forwarded-Encrypted: i=1; AJvYcCU4UyGdrBcTMM4vDXu7fWAzi7sXW8BKMJe6L43bJMKO2onJVIDgkYsZSgCof3A0NgNxK4t45rUZQnRuwxmhK3JtinijS5Gb5ulsNw==
X-Gm-Message-State: AOJu0YxC9VRaAOSrZNz9LEHixeAkKDH3ZgjhABv95ZnDuRKl4TEsoX6U
	4zdxj3shaEtvKDomPVbKEeRam3mMB7WcW08D2wcFNarV9NAVXODh+7GKR8or/QPy01VwzRZ8adN
	7tVY59YqtXJKkvDgJd8UqMLDxdbU=
X-Google-Smtp-Source: AGHT+IElkx9e+9SmNKKpZqYLKl/8Op+trxRQwLoWcfOfV3aJ3GEVQeLtlKvkGD3+5XCP5ZKvVf9vFhbChNllOzfakV0=
X-Received: by 2002:a81:91ce:0:b0:62f:aa7b:7075 with SMTP id
 00721157ae682-64c72b5410dmr68732147b3.25.1719854919100; Mon, 01 Jul 2024
 10:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628051019.975172-1-kikuchan98@gmail.com> <20240628051019.975172-2-kikuchan98@gmail.com>
 <20240628-splashy-slug-1d74e3fd9fe6@spud> <CAG40kxERY2r2cj58kjVMMg1JVOChRKraKYFo_K5C5fnx0g80Qw@mail.gmail.com>
 <20240630-babied-grill-13c840abb70a@spud>
In-Reply-To: <20240630-babied-grill-13c840abb70a@spud>
From: Hironori KIKUCHI <kikuchan98@gmail.com>
Date: Tue, 2 Jul 2024 02:28:27 +0900
Message-ID: <CAG40kxHxnSNp1_4fX0fOWypLunPm-NnH1UEKZNQgM0g-Z1u1DQ@mail.gmail.com>
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

Hi Conor,

On Sun, Jun 30, 2024 at 11:17=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sat, Jun 29, 2024 at 05:26:56PM +0900, Hironori KIKUCHI wrote:
> > Hello Conor,
> >
> > Thank you for your reply.
> >
> > On Sat, Jun 29, 2024 at 1:27=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Fri, Jun 28, 2024 at 02:10:15PM +0900, Hironori KIKUCHI wrote:
> > > > The RG28XX panel is a display panel of the Anbernic RG28XX, a handh=
eld
> > > > gaming device from Anbernic. It is 2.8 inches in size (diagonally) =
with
> > > > a resolution of 480x640.
> > > >
> > > > This panel is driven by a variant of the ST7701 driver IC internall=
y,
> > > > confirmed by dumping and analyzing its BSP initialization sequence
> > > > by using a logic analyzer. It is very similar to the existing
> > > > densitron,dmt028vghmcmi-1a panel, but differs in some unknown
> > > > register values, so add a new entry for the panel to distinguish th=
em.
> > > >
> > > > Additionally, the panel is connected via SPI instead of MIPI DSI.
> > > > So add and modify for SPI as well.
> > > >
> > > > Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> > > > ---
> > > >  .../display/panel/sitronix,st7701.yaml        | 69 +++++++++++++++=
++--
> > > >  1 file changed, 64 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/panel/sitron=
ix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,s=
t7701.yaml
> > > > index b348f5bf0a9..835ea436531 100644
> > > > --- a/Documentation/devicetree/bindings/display/panel/sitronix,st77=
01.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st77=
01.yaml
> > > > @@ -20,21 +20,19 @@ description: |
> > > >    Densitron DMT028VGHMCMI-1A is 480x640, 2-lane MIPI DSI LCD panel
> > > >    which has built-in ST7701 chip.
> > > >
> > > > -allOf:
> > > > -  - $ref: panel-common.yaml#
> > > > -
> > > >  properties:
> > > >    compatible:
> > > >      items:
> > > >        - enum:
> > > >            - anbernic,rg-arc-panel
> > > > +          - anbernic,rg28xx-panel
> > >
> > > Please no wildcards in compatibles - what is the actual model of this
> > > panel? I don't really want to see the model of the handheld here if
> > > possible.
> >
> > Well, the "RG28XX" is the actual product name of the device...
>
> Ah, I see. I didn't realise that.
>
> > Besides, there is no vendor name or model name on the panel; there is
> > no information at all.
> > Since the panel cannot be disassembled from the housing of the device,
> > I named it like this.
> >
> > >
> > > >            - densitron,dmt028vghmcmi-1a
> > > >            - elida,kd50t048a
> > > >            - techstar,ts8550b
> > > >        - const: sitronix,st7701
> > > >
> > > >    reg:
> > > > -    description: DSI virtual channel used by that screen
> > > > +    description: DSI / SPI channel used by that screen
> > > >      maxItems: 1
> > > >
> > > >    VCC-supply:
> > > > @@ -43,6 +41,13 @@ properties:
> > > >    IOVCC-supply:
> > > >      description: I/O system regulator
> > > >
> > > > +  dc-gpios:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      Controller data/command selection (D/CX) in 4-line SPI mode.
> > > > +      If not set, the controller is in 3-line SPI mode.
> > > > +      Disallowed for DSI.
> > > > +
> > > >    port: true
> > > >    reset-gpios: true
> > > >    rotation: true
> > > > @@ -57,7 +62,38 @@ required:
> > > >    - port
> > > >    - reset-gpios
> > > >
> > > > -additionalProperties: false
> > > > +allOf:
> > > > +  - $ref: panel-common.yaml#
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            # SPI connected panels
> > > > +            enum:
> > > > +              - anbernic,rg28xx-panel
> > > > +    then:
> > > > +      $ref: /schemas/spi/spi-peripheral-props.yaml
> > >
> > > I'm not really keen on this. I'd rather see a different binding for t=
he
> > > SPI version compared to the MIPI ones. Is doing things like this comm=
on
> > > for panels? If it is, I'll turn a blind eye..
> >
> > This might be the first case that a driver supports both DSI and SPI
> > for a panel.
> > The panel can be either a DSI device or an SPI device.
>
> The commit message sounded like the panel was capable of doing SPI
> instead of DSI, is that not the case and the panel is actually capable
> of doing both, just happens to be connected as SPI in this particular
> device?

Sorry for the confusion.
I think it depends on what the "panel" refers to...
Although the "panel driver IC" (ST7701 variant) is capable of doing
both, the "panel assy" (including its cable) of the RG28XX only has an
SPI interface in its pinout.
If the compatible string "rg28xx-panel" represents the assy, then I
could say the "panel" only supports SPI, and the other panels only
support DSI.
But if it only represents a specific LCD panel and its driver IC with
control parameters, then it theoretically supports both, and it might
be sufficient to just include spi-peripheral-props, as in v1.
v1: https://lore.kernel.org/linux-kernel/20240618081515.1215552-2-kikuchan9=
8@gmail.com/

>
> > I'm not sure if this is the right way to represent it in the documentat=
ion...
> >
> > >
> > > > +
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          not:
> > > > +            contains:
> > > > +              # DSI or SPI without D/CX pin
> > > > +              enum:
> > > > +                - anbernic,rg-arc-panel
> > > > +                - anbernic,rg28xx-panel
> > > > +                - densitron,dmt028vghmcmi-1a
> > > > +                - elida,kd50t048a
> > > > +                - techstar,ts8550b
> > >
> > > This is all the compatibles in the file, so nothing is allowed to use
> > > dc-gpios? Why bother adding it?
> >
> > There are 3 types of connections that the driver supports: DSI, SPI
> > with D/CX pin, and SPI without D/CX pin.
> > Although most SPI panels don't have a D/CX pin, theoretically "SPI
> > with D/CX pin" exists.
> > So, it's just prepared for that.
> >
> > IMHO, once it's found, the list should be negated. List panels for SPI
> > with D/CX pin, instead.
>
> To be honest, I'd just delete this complication until something arrives
> that actually uses that pin.
>
> Cheers,
> Conor.

Best regards,
kikuchan.

