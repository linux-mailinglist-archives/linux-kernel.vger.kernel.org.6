Return-Path: <linux-kernel+bounces-224478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEE89122E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E58C1C2210B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789A172777;
	Fri, 21 Jun 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdHuuLJk"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A574416;
	Fri, 21 Jun 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967560; cv=none; b=tCz3XwJdmdSiOALimLUp9fmViKSLt7jt2NITCSOlARuC5drv96W4WXg2LkMcECa0XwcjvaBWgg+lllFoOCaUigfL4BFht9bc0/7BkyeS2bdhm2Ixkwt1971yxI2451LUW8sQ0lKn5kSdfohpXihlX2AX2DkjsaEFvz6zBtKrUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967560; c=relaxed/simple;
	bh=G0NU6sDdHBJOF0XHyNaWWZAfT71nFNORKVooIzjHmG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9+3e4UV+R++wopL1sfTGM+wCtjZBSe+NAJXsFpDkMi69dUNv/X3kg6kBeaAhcnomr9siuqAyym8v/xHMhSKX3lwNE1xv2hr46d42olFJ1RivE5Kfb2kvRceTkoGgPTzol9fPFW/GK5nTIcwVrUpc8AWNRpdMQy/kxo759NIzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdHuuLJk; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-63bc513ade5so15793477b3.3;
        Fri, 21 Jun 2024 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718967558; x=1719572358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMG6I2fL450LAEj9ZfzRXVDeBFq9SZSX/s1+uBl/ims=;
        b=cdHuuLJkVbQzdwilWWQ71dF6q3vJijueFgkegxtlesosK1stxVGGTV4PAgifITbz/j
         v9EHirglWC7tJQRSON24mWIiiEzUK1CqGNQBYwdLJ0LQDCQMU1ZwxhE0GvUwA7qStomj
         KDckSKeDVgjxWwxb/bUnZKZkotyU95m8UOo2yB78Xg8wLYPe7+Ec2rACf4rE6p8kduQj
         3/Yia/IVD7L9mkYBJRbVBwZtjP86oBcptpPLB8f5BjKjgIJ+UJbZI2BcgvKeCIwsUFM/
         /pDYOxfpVfpJXBuVNnguEaJNjDIpANIK0Nc8n/+kUv589J6RMeAlYBRb8IYnvO7njyvx
         X3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718967558; x=1719572358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMG6I2fL450LAEj9ZfzRXVDeBFq9SZSX/s1+uBl/ims=;
        b=rdmlJbRuAiJQJGmcHklzRvXfGcLOppGVlRL+77Y7y3akwa5kxsvXprKPCSMPYh5/a3
         sQFNYSGYg9wBkwNukO18RndmRbpQBkZTh09cqwIlXpuW4XwXYDfAVatOxZtp8Ja6toQ1
         27TZkuREH0Siz2HE7cGDpre29HlfpXf0lG7SbE9aFIBxpdgfomSWfB4Y1hXmHWPMI+96
         0FGz2tnu3m8c6AuwYK7FeEhZ1MpCt9g74c7mLSQj0+9bhtMTlPezC/QI5CDYtXfVTdEZ
         b/LM6tJXXX9L8MqAW5IZ1jDGnm/1H7WQ0NcvHu34/FJDRewbDcnRC4ePTkvQZZWiwXJ6
         jkyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2qk80nEQ9OsRCAtNlDaYpd5nRqVUfOxXZ6M6o5QPalokSbCPQxKRgrowNuCKRoE1VIxO7SStEweaKK61oqZJXvlVMxoWY4TcoGw==
X-Gm-Message-State: AOJu0YwslXmqyoe9b72SzyOYXA5ab0uvrsc4gXco8zAt74OnozBqlBSO
	PA50cpwxhokAYvHQ/Z+r18z4SUrY/OaEg1ev8aQzi5/XzoUOCRhWetN9fKPlD8A7zY6hqwWJgVy
	yItwwgkUlmxyr2+55oWRBA5+lQt8=
X-Google-Smtp-Source: AGHT+IFNIGuETLCk//Rdm5KBbSRMEujOoe7cshb/eDNTqBYe3z4TXdLoL26tBh1MLc5b2oFrvWYlVgUxYamBFY1lKPE=
X-Received: by 2002:a0d:eb01:0:b0:631:4e00:2c06 with SMTP id
 00721157ae682-63a8d82c7efmr83531317b3.2.1718967557858; Fri, 21 Jun 2024
 03:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618081515.1215552-1-kikuchan98@gmail.com>
 <20240618081515.1215552-2-kikuchan98@gmail.com> <0455975b-837b-4a1c-8ea3-e9a504db53d0@kernel.org>
In-Reply-To: <0455975b-837b-4a1c-8ea3-e9a504db53d0@kernel.org>
From: Hironori KIKUCHI <kikuchan98@gmail.com>
Date: Fri, 21 Jun 2024 19:59:06 +0900
Message-ID: <CAG40kxHaAwGowQ0dRoEkGSiAUJA5SyKw3SSECUmBApKaAjcHKw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: display: st7701: Add Anbernic RG28XX panel
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

Thank you for your reply!

On Tue, Jun 18, 2024 at 6:17=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 18/06/2024 10:15, Hironori KIKUCHI wrote:
> > The RG28XX panel is a panel specific to the Anbernic RG28XX.
> > It is 2.8 inches in size (diagonally) with a resolution of 480x640.
> >
> > Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> > ---
> >  .../display/panel/sitronix,st7701.yaml        | 36 +++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
>
> Nothing explains in the commit msg why rg28xx is actually st7701.
> Changing interface to SPI suggests it is not.

Thanks, I'll explain like this;
---
dt-bindings: display: st7701: Add Anbernic RG28XX panel

The RG28XX panel is a panel specific to the Anbernic RG28XX
handheld device. It is 2.8 inches in size (diagonally) with a
resolution of 480x640.

This panel is driven by a variant of ST7701 driver IC internally,
confirmed by dumping and analyzing its BSP initialization sequence
by using a logic analyzer. It is very similar to the existing
densitron,dmt028vghmcmi-1a panel, but differs in some unknown
register values, so add a new entry for the panel to distinguish them.

Additionally, it is connected over SPI, instead of MIPI DSI. So
add and modify for SPI as well.
---

>
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,s=
t7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st770=
1.yaml
> > index b348f5bf0a9..04f6751ccca 100644
> > --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.y=
aml
> > +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.y=
aml
> > @@ -22,19 +22,21 @@ description: |
> >
> >  allOf:
> >    - $ref: panel-common.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >
> >  properties:
> >    compatible:
> >      items:
> >        - enum:
> >            - anbernic,rg-arc-panel
> > +          - anbernic,rg28xx-panel
>
> What is xx? Wildcards are not allowed, in general.
>
> Can it be anything else than panel? If not, then drop "-panel".

It's supprising but it actually is a product name of the handheld device...
The panel comes with the device, and part# is completely unknown.

>
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
> > @@ -43,6 +45,13 @@ properties:
> >    IOVCC-supply:
> >      description: I/O system regulator
> >
> > +  dc-gpios:
> > +    maxItems: 1
> > +    description: |
>
> Do not need '|' unless you need to preserve formatting.

Thanks, I'll remove it.

>
> > +      Controller data/command selection (D/CX) in 4-line SPI mode.
> > +      If not set, the controller is in 3-line SPI mode.
> > +      No effect for DSI.
>
> Which devices can be connected over SPI? It seems not all, so this
> should be disallowed (": false" in allOf:if:then:; move the allOf to
> bottom like in example-schema) for them.

Hmm... That's a difficult question...

There are 3 types of connection that trying to support:
DSI, SPI with D/CX pin, and SPI without D/CX pin.

The dc-gpios is required for SPI with D/CX pin, but not for others.

DSI:
- anbernic,rg-arc-panel
- densitron,dmt028vghmcmi-1a
- elida,kd50t048a
- techstar,ts8550b

SPI without D/CX pin:
- anbernic,rg28xx-panel

But, there are no panels with D/CX pin so far.
How should I deal with this? just disallow all, perhaps?


BTW, does panel's compatible string consider to include it's interface?
ie, what if two panels use the exact same commands and timings, but
over different interface,
... are they "compatible" or not?

>
> Best regards,
> Krzysztof
>

Best regards,
kikuchan.

