Return-Path: <linux-kernel+bounces-400138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC299C096B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA3284E74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94427212EFB;
	Thu,  7 Nov 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fxTJo6Mq"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1D8212EE3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991454; cv=none; b=sw1ngz9mHcvEElwLP3rvCg7mUJgK0er5t2ikllbOTgq1RY62i6u3Tht8thwamWaiYnk1AcQmmrmfVgGhw/KfM5Yglo32f47KJwTO15JaTK/nLzYKDI6V6n/xFJT0nY3NYtMKZ8+xGBP7PwsnLErl14fL5SCzhU1VhAeBkS57zek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991454; c=relaxed/simple;
	bh=qZ8izUSaHahLbAO7uWeGh/Gz8E/GX1hkiRPzbJN9tMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMBiO3ycjow/YJKIjuWNqSKt7oHlrg6tq8yEjAJqs0PHZu76Kl/qa9XmnCJkdljgMqDeaKZTexpXw+FuSiyPaP2DAWrj/jd4z62F2QeKdyDpNHRigfYmI3eYKfmTEIo4gAxZHd8Ar0iOfayCpDi+Y9DT9gpu9GU9uedaU0JLRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=fxTJo6Mq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e9f8dec3daso8645257b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 06:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730991452; x=1731596252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiuuQGCaJR6L9rbp4LJqZfhMxwW+RQ/d7RNS/+rBXDw=;
        b=fxTJo6MqgGoAfhP31zROnAQv2iNF3dLcyRvO3hNcsz1HIeKD6T/E1eZAwAejVhK6iL
         iN1uYUkLFrW84u2SD4lJ5fco7UUu7XbWZTBiFwuLTn3WH+MDNDaEQ5RLoZR1HcMJnqOz
         IATQBn0zm+Iw/VQmLu9ee7VHOwGjfdDJD1Zu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730991452; x=1731596252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiuuQGCaJR6L9rbp4LJqZfhMxwW+RQ/d7RNS/+rBXDw=;
        b=GJXmBWdYAKSFArBHfm6CC2Jm1hxyOfRTbuOVJlC9rQxCxEFifR/FZhrYdL2Ss+oyRd
         0JQz6OnO6jVWqsQ7whXj1qT5XqoJzuZgE73/Q26cK3tmg1NhVIxpRP4Rnjm3TB+5Di0m
         Tr7YZat/POmP/I3dmrazKE+DXe0u1SOvxM2wGXdwiPtHV60JE8KDjOZcr4o3WcY4+lQk
         yT6C9TKVygWvxnlG03qExWlffvkoIpwbC2+gRs5fnOTBny+UKwYR7J2hmcfOp6lVhoCm
         Engw57LLke56mU+NejjbZUXitSeJq8bELeGOqOKLZDRHiN05P2D8EwQfFqoGZk7d/I2d
         II6w==
X-Gm-Message-State: AOJu0YziWV/NdeX/bKXoMZQh5rNR0r3XWxA6XTdb1xr3QEO9vpPAjEl3
	5JDt1S/TOUfEidpDH8tRAl3ujSPQJc00XdB64Rccvw/cdk2mMDNPb+vXdQAukoY7bXmPoDYlorl
	+MoWeTiFV1nSJkRvv30x5q3kmCME78AH3tpbx3A==
X-Google-Smtp-Source: AGHT+IF8agBg7laXxANgHAvwKG8a08ww2rsq+nqLU8LlqFlymOUM9EIrlz0DftKlezAxcI5XDK1DcyZtsOZ0bmNH4oE=
X-Received: by 2002:a05:690c:4b09:b0:6e3:b6c:d114 with SMTP id
 00721157ae682-6e9d8ad309bmr466023927b3.38.1730991452024; Thu, 07 Nov 2024
 06:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
 <20241106090549.3684963-2-dario.binacchi@amarulasolutions.com>
 <4bix7me5vaoyhcuffyp4btajmhy7no6ltczoesopaz2fqupyaw@fensx4nn472u> <b7c1499b-8337-421c-9734-6e518d678ff8@kernel.org>
In-Reply-To: <b7c1499b-8337-421c-9734-6e518d678ff8@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 7 Nov 2024 15:57:21 +0100
Message-ID: <CABGWkvrYJL9=zrPSFuEAgKO+9gDHD6RmCJM6Br6Le_eh578ETQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock: support spread
 spectrum clocking
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On Wed, Nov 6, 2024 at 3:13=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 06/11/2024 15:10, Krzysztof Kozlowski wrote:
> > On Wed, Nov 06, 2024 at 09:57:57AM +0100, Dario Binacchi wrote:
> >> The patch adds the DT bindings for enabling and tuning spread spectrum
> >> clocking generation.
> >
> > We had long talks about this but nothing of it got reflected in commit
> > msg. Sorry, I don't remember what I was talking in some particular patc=
h
> > month ago, so you will get the same questions over and over...
> >
> >>
> >> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >>
> >> ---
> >>
> >> Changes in v3:
> >> - Added in v3
> >> - The dt-bindings have been moved from fsl,imx8m-anatop.yaml to
> >>   imx8m-clock.yaml. The anatop device (fsl,imx8m-anatop.yaml) is
> >>   indeed more or less a syscon, so it represents a memory area
> >>   accessible by ccm (imx8m-clock.yaml) to setup the PLLs.
> >>
> >>  .../bindings/clock/imx8m-clock.yaml           | 46 ++++++++++++++++++=
+
> >>  1 file changed, 46 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml =
b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> >> index c643d4a81478..7920393e518e 100644
> >> --- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> >> +++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> >> @@ -43,6 +43,40 @@ properties:
> >>        ID in its "clocks" phandle cell. See include/dt-bindings/clock/=
imx8m-clock.h
> >>        for the full list of i.MX8M clock IDs.
> >>
> >> +  fsl,ssc-clocks:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >> +    description:
> >> +      Phandles of the PLL with spread spectrum generation hardware ca=
pability.
> >> +    minItems: 1
> >> +    maxItems: 4
> >
> > 1. How is it possible that you change spread spectrum of some clocks fr=
om
> > main Clock Controller, while this device is not a consumer of them?
> > Basically this means that this device does not have these clocks but ye=
t
> > you claim that it needs to configure spread for them! It's contradictor=
y
> > to me and nohing got explained in commit msg about it. I am pretty sure
> > I asked about this alrady.
>
> I digged my previous answer and it was pretty clear here:
>
> 18:44 <krzk> You can, but I still have the same concerns. How this
> device - which does not take any clock input, has no clocks at all - can
> depend on spread spectrum of some PLLs? Thsi device does not have clocks.
> 18:50 <krzk> device has no clocks, I checked now third time
> 18:50 <krzk> If device has clocks, it must have clocks property
>

The device where the spread spectrum properties are to be set already
contains "clocks" properties:

clk: clock-controller@30380000 {
    compatible =3D "fsl,imx8mn-ccm";
    reg =3D <0x30380000 0x10000>;
    interrupts =3D <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
                       <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
    #clock-cells =3D <1>;
    clocks =3D <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
                  <&clk_ext3>, <&clk_ext4>;
    clock-names =3D "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
                             "clk_ext3", "clk_ext4";
    assigned-clocks =3D <&clk IMX8MN_CLK_A53_SRC>,
                                  <&clk IMX8MN_CLK_A53_CORE>,
                                  <&clk IMX8MN_CLK_NOC>,
                                  <&clk IMX8MN_CLK_AUDIO_AHB>,
                                  <&clk IMX8MN_CLK_IPG_AUDIO_ROOT>,
                                  <&clk IMX8MN_SYS_PLL3>,
                                  <&clk IMX8MN_AUDIO_PLL1>,
                                  <&clk IMX8MN_AUDIO_PLL2>;
    assigned-clock-parents =3D <&clk IMX8MN_SYS_PLL1_800M>,
                                             <&clk IMX8MN_ARM_PLL_OUT>,
                                             <&clk IMX8MN_SYS_PLL3_OUT>,
                                             <&clk IMX8MN_SYS_PLL1_800M>;
    assigned-clock-rates =3D <0>, <0>, <0>,
                                         <400000000>,
                                         <400000000>,
                                         <600000000>,
                                         <393216000>,
                                         <361267200>;
};

The spread spectrum is not configurable on these clocks or, more
generally, may not be
configurable (only 4 PLLs have this capability). Therefore, I need the
"fsl,ssc-clocks"
property to list the PLLs on which I want to enable and configure
spread spectrum.

Furthermore, spread spectrum cannot be considered a new device but
rather a property
available only for some of the clocks managed by the clock controller
manager (CCM).

Thanks and regards,
Dario

> So again, you do not need this property at all. I repeated it multiple
> times - you are supposed to use clocks property.
>
> >
> > 2. Why is this array flexible in size?
> >
> > Best regards,
> > Krzysztof
> >
>
> Best regards,
> Krzysztof
>


--

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

