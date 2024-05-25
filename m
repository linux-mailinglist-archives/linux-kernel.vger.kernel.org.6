Return-Path: <linux-kernel+bounces-189520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C781A8CF128
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EA92818E6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51812837E;
	Sat, 25 May 2024 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="JHqGHvjU"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF469959
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716667114; cv=none; b=K7RFfHI0NipJg+pylsG4KgBjBrDbd+54IAgnZXnB3uQfm8R5uq7Lfndn6wkxgeSO1RZ4JPH/Bp+lrRZEs+6XmRCYEFhAZTJUEeif7/q/+jg7i9GKjIv54uJ7a5YwuOYT/NbkcrLZhu6dUB226TWiePT9l1L3BQLY5XWL90QN2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716667114; c=relaxed/simple;
	bh=YyktBYvkAnwaBKuCJSVUX+2IGFFXy4pY1RBykLD/eQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcGjLIRDQaUfbYY9aUD82t+dEZmEtCfFxzV5P7oMAC7bCw0fmR5oV5OZlJaYvLdZrH/7dMGKQxJYZZcWzAzOGrh5/O4KgxvqDjnSabsY0On1SINKBp08Al3uLqXrINa/0wyV9PPFrAjaTFpb7GiAqxIND8gc4Yi3XEtKveBJhCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=JHqGHvjU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so1397794366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1716667111; x=1717271911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UkScwBgCN+E8s4yRTB4uCPcQeq88yLTx0RPgq0Jips=;
        b=JHqGHvjUblGBUlK/oa6uJD86stGF3MYE2qyOT71/dxvF6pNwQgx71kBLqfpjHjmOh7
         WDhPmxVcr7AAvpssnGoLRmSOC/TshIpqJEYK2fFV8ptTBwLal6SEvy32rFcIMT7kk+y6
         sH1Dx0QIuy3oEiFlQfxWNJarc5CpzIaoOQKkj2pM21QAyfYgN+64ele9UQ8fVTWbR/NT
         OQGJUTZsxgAeUB+SB0moEk18ZcWgHhUQ02FswaxT9AziHRxRFfj8Jtd9Ww3CyzLoy/OW
         yuGXJsMDf0+QeyrGMbhsg3Cpy3j2FcaMWFiHG4ng+37bnmSzNqk/8xxuWn4NK1VPQsDl
         UVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716667111; x=1717271911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UkScwBgCN+E8s4yRTB4uCPcQeq88yLTx0RPgq0Jips=;
        b=oXPWBTgoCuuPd7zTgam2hdAaxMZg42kQMd1gR/DI+lSNGd7qFa0xHBr6fppfqDdNPh
         T0RuOULrnRn2lctyl8fRoU+dWqNCdHcYqGuhGeNxM7/xIrYPikDfPxIqlJKrbWZOnhIg
         +PqlLzQOr3+V8uYHt8QGbD/QUGHL9uz78Iq31wq+MZgo7DOxBTD/sI1xhuJpK2/ojkUs
         4hq3avC9HSXL8/J9jtycdmsG/dgmLCGJF+mmVGxL4SOcmQye9rHJbasIKo7gERCTfD+6
         MHO61uyNk8ejQFSpcCJ/37JhdsQnXb49C+XsTDjBY/OMTQLYBCfuoCoF4F3WzklyqTQ5
         RFsA==
X-Forwarded-Encrypted: i=1; AJvYcCXySd57nDLQTaSv4UyUUgaYNm8LukwByaMelioWCVlfNn43Xa1d9z1SUoHL+7jul+Q0lqxgxVYzmuhDH8FBQOQlVcYgM0b3uwBZ6uKx
X-Gm-Message-State: AOJu0YyxXxVxPg3FSNHMtYEyhjwppJRwqoWrkvY6va3mHlUG1UkDWoFi
	pcyg3ECUWLpu6dj8Sc8KflyDzvffIp5S3p+f0gOjFkGEmkmg3IVahe50QRcN6e8CtrAImVDBNVU
	F/3+g3L+BrM/VbWRSFG756jBjkWd7jYc2gvawsQ==
X-Google-Smtp-Source: AGHT+IHmcUbw6PneWW81LNhoVdjfmvJD2KPXgw1NohVR46fYTKEQJ3xUFOcbylon09NqVhutwrjC7k1lIl8wFWY6ViM=
X-Received: by 2002:a17:906:131b:b0:a59:9fc8:38bf with SMTP id
 a640c23a62f3a-a62646cd6ddmr353575366b.24.1716667110587; Sat, 25 May 2024
 12:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522215043.3747651-1-tharvey@gateworks.com>
 <07250029-7cea-4a82-9e70-22e0e6f7fb37@linaro.org> <20240523-vividly-sequester-d85ac7bccbbd@spud>
 <CAJ+vNU3fQt=6t3a_QFU_3jb5mTVLGJiptPnGEmWvvXZYGEPOFQ@mail.gmail.com>
 <20240524-cavalier-outthink-51805f49c8fb@spud> <8007abef-38bb-4d7d-a453-00bb5e6bede5@linaro.org>
In-Reply-To: <8007abef-38bb-4d7d-a453-00bb5e6bede5@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Sat, 25 May 2024 12:58:18 -0700
Message-ID: <CAJ+vNU3Rh6f-HrFbBLxNXVP1PwsGh8OyGmmGJBv6+GRwZaTXgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 11:34=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/05/2024 20:40, Conor Dooley wrote:
> > On Thu, May 23, 2024 at 04:04:50PM -0700, Tim Harvey wrote:
> >> On Thu, May 23, 2024 at 7:47=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> >>>
> >>> On Thu, May 23, 2024 at 09:02:46AM +0200, Krzysztof Kozlowski wrote:
> >>>> On 22/05/2024 23:50, Tim Harvey wrote:
> >>>>> The GW7905 was renamed to GW7500 before production release.
> >>>>>
> >>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
> >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Docum=
entation/devicetree/bindings/arm/fsl.yaml
> >>>>> index 0027201e19f8..d8bc295079e3 100644
> >>>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> >>>>> @@ -920,8 +920,8 @@ properties:
> >>>>>                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
> >>>>>                - fsl,imx8mm-evk            # i.MX8MM EVK Board
> >>>>>                - fsl,imx8mm-evkb           # i.MX8MM EVKB Board
> >>>>> +              - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gateworks Boa=
rd
> >>>>
> >>>> That's not even equivalent. You 7500 !=3D 75xx.
> >>>>
> >>>
> >>>>>                - gateworks,imx8mm-gw7904
> >>>>> -              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks Boa=
rd
> >>>>
> >>>> Compatibles do not change. It's just a string. Fixed string.
> >>>
> >>> I think there's justification here for removing it, per the commit
> >>> message, the rename happened before the device was available to
> >>> customers.
> >>> Additionally, I think we can give people that upstream things before =
they're
> >>> publicly available a bit of slack, otherwise we're just discouraging
> >>> people from upstreaming early.
> >>
> >> Hi Conor,
> >>
> >> Thanks for understanding - that's exactly what happened. I'm in the
> >> habit of submitting patches early and often and it's no fun when
> >> something like a silly product name gets changed and breaks all the
> >> hard work.
> >>
> >> The board model number is stored in an EEPROM at manufacturing time
> >> and that EEPROM model is used to build a dt name. So instead of GW7905
> >> which would be a one-off custom design it was decided to change the
> >> product to a GW75xx. The difference between GW7500 and GW75xx is
> >> because we subload components on boards between GW7500/GW7501/GW7502
> >> etc but the dt is the same.
> >>
> >> If there is resistance to a patch that renames it then I guess I'll
> >> have to submit a patch that removes the obsolete board, then adds back
> >> the same board under a different name. Shall I do that?
> >
> > I think this patch is fine - other than the inconsistency that Krzyszto=
f
> > pointed out between the "renamed to gw7500" and the "gw75xx" in the new
> > compatible.
>
> I am not a fan of renaming compatibles because of marketing change,
> because compatible does not have to reflect the marketing name, but
> there was already precedent from Qualcomm which I did not nak, so fine
> here as well. Double wildcard 75xx is however a bit worrying.
>

Hi Krzysztof,

Thanks for understanding. The double-wildcard is again a marketing
tool. All GW75** use the same device-tree by design. The boot firmware
that chooses the device-tree understands this and for a GW7521 for
example would look for gw7521 first, gw752x next, gw75xx last.

Best Regards,

Tim

