Return-Path: <linux-kernel+bounces-358202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FCF997B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C984E28432B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870AA19258B;
	Thu, 10 Oct 2024 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CViKCxnG"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1A29CEC;
	Thu, 10 Oct 2024 03:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531463; cv=none; b=aPb5+f/ikSvGxD1VZXxJ1zKu74LRDVFWSQG65IKgKOksSmsUIt1FumNCNpvBxSZROk6UUPUZ0o6ASI1Dq1AUMHm9AOTIbaCAv31F1kdhRv0ZYFnbdKubZ1kJ6utSDr3WUabk+ipR6LEwzsY3jO5Xzthixc8XvGEmxRTy3cid/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531463; c=relaxed/simple;
	bh=4af1pEzdKs+GfcxOCbomV3ZT1+7pTPdhU2Uh6vsgE/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVRygEJRngygZKGoxHGh4TtcQAbd33fe2bhwhQ9oCE/I0CkLuO168nGVT0erV+8hjTcK9sUF3qi1utElB8o9pT/N+Tjzg70VKJlTzUwfEIwvgf1iZxpJ749PtWn7skwFzDEVJ+hO0SXJFOm0lUjFNehcBndv1krSaOxuAoerF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CViKCxnG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c46c2bf490so232041a12.3;
        Wed, 09 Oct 2024 20:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728531461; x=1729136261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtN38XN5eOVMMGj1vTLPXzLDbd70RQH/nhFI8BOxABQ=;
        b=CViKCxnGw9x0PlpIzGktxa/T6DroUPM5gHf28o45AOEmb+jPPUeYNAAvXNBOxSFg/+
         L/bEM70IMT3F4g1cBot2mYyiqVjzmAQ4zBAH4UFyXGA6yMKXEm6og22GEuO2vwxZ64Jf
         Bwh3RINQ5x2lNUe5cd3rU2wUYWB+3b/puGUCDPsaQaI1/lflrKGwZixsABCBGsQmRTll
         ts8vsXejvWZFas8Y3lQFIt0wnp92SwP064yBsDSwMsMr7OwH1aqra9Nd8lMNrBixueEG
         T9fJmQotuBjNRkFUF68P8jmS7Ol61vo2EiGvD2FC8uxVoUOYym6oTjDvca8UYss22vKN
         xVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728531461; x=1729136261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtN38XN5eOVMMGj1vTLPXzLDbd70RQH/nhFI8BOxABQ=;
        b=QzxoI7duNT7nYbe7be+sIrbwhJuNZ7YQXCZpivB6Sy+tLBwyMnHQD6qOK/ZXXcKjLE
         ICH1vLZv2tQ4NxaDQJ85KxM4GU0pMagge3A8WHUu9IHYHvJ/MSrHtNzBE9+Cp610Ue3Z
         AXF/dTunjKlKiO+L48/EZ9duDqxsxXaC/sWDlUz8P5unMCCaC614e5bMOO1AObDvNzvQ
         M9IEwSxnYp0em6IlzbBBkSrgo7Mg6t6CYcRViwU5ro53tEX5yZVEEyiHADKbwpyvbKSc
         ek4kUBxIij5hEta+JqsGnZZ4uGbnhOMK/4uctGISahDs6SG8kyidw+2NRy/NhRXwAUdz
         gDhw==
X-Forwarded-Encrypted: i=1; AJvYcCU5yoBkYGuofLnuL1VaVDJ3DXrszkOOlj1hKfjc2lz4DpvQMrXJ2coXkh2oZbygUpadqRzM0VLxqU8HMrUc@vger.kernel.org, AJvYcCX0Q7vdlKO/zoNucvXZLdajGLSoCiGMoBb1TW8dxpZPL8neOzhOlnneTdMlNzOAUapIKcp6fgVKAXQ3@vger.kernel.org
X-Gm-Message-State: AOJu0YwpoyO7yfPmbRiFXNbPTA7BFV1NU68fNpY+MBIgf63fSZkPJ3hs
	vyxqG8qrqXaC21nubuUp8xNmorOmcpaanRCK01YjwNZHbDNA+/KWX6leYFi4T9LweC8JiSREPfa
	1cHuUbS9WTapdNo+iaTra1F9m5Hc=
X-Google-Smtp-Source: AGHT+IHjdoGb1QNG7hOHecOiOCVCv0cr5SN1oN8qOrEEgf1SrGPim535YuGCCWmUYyGOSh1O/RqX++UW1OCVMBsPfFI=
X-Received: by 2002:a05:6402:13d4:b0:5c8:39e2:507b with SMTP id
 4fb4d7f45d1cf-5c91d64cec5mr5548518a12.29.1728531460336; Wed, 09 Oct 2024
 20:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009215046.1449389-1-CFSworks@gmail.com> <20241009215046.1449389-2-CFSworks@gmail.com>
 <20241010023844.GA968160-robh@kernel.org>
In-Reply-To: <20241010023844.GA968160-robh@kernel.org>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 9 Oct 2024 20:37:29 -0700
Message-ID: <CAH5Ym4iASexWJat4zhOpAFhwmWWFpZeioFACjY86KA7D3FB5=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mtd: Relax BCM4908 partition schema
To: Rob Herring <robh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	William Zhang <william.zhang@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 7:38=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Oct 09, 2024 at 02:50:44PM -0700, Sam Edwards wrote:
> > The BCM4908 partition "parser" is really just a fixed partitions table,
> > with a special partition compatible (`brcm,bcm4908-firmware`) that
> > automatically labels the partition as "firmware" or "backup" depending
> > on what CFE is communicating as the selected active partition.
> >
> > The bcm4908-partitions schema is currently too restrictive, requiring
> > that all child nodes use this special compatible or none at all. This
> > not only contracits what is allowed by the "parser" but also causes
> > warnings for an existing file ("bcm4908-asus-gt-ac5300.dts").
> >
> > Modify the schema to be strict only for child partitions that use the
> > -firmware compatible. Also update the child name regex to agree with
> > fixed-partitions, so that these differences apply consistently.
> >
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  .../mtd/partitions/brcm,bcm4908-partitions.yaml | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4=
908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm=
,bcm4908-partitions.yaml
> > index 94f0742b375c..aed37922a5fc 100644
> > --- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-par=
titions.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-par=
titions.yaml
> > @@ -30,12 +30,17 @@ properties:
> >      enum: [ 1, 2 ]
> >
> >  patternProperties:
> > -  "^partition@[0-9a-f]+$":
> > -    $ref: partition.yaml#
> > -    properties:
> > -      compatible:
> > -        const: brcm,bcm4908-firmware
> > -    unevaluatedProperties: false
> > +  "^partition(-.+|@[0-9a-f]+)$":
> > +    type: object
> > +    if:
> > +      properties:
> > +        compatible:
> > +          const: brcm,bcm4908-firmware

Hi Rob,

Thanks for your attention on this one! This is an odd case where I'm
not sure what else could be done, and I'm a newbie to modifying DT
schemata, so I'm glad to be receiving your feedback. :)

> What schema applies to the node if this is not true? That needs to be
> addressed. You should be able to use oneOf here rather than if/then
> schema.

The schema that should apply "in general" is partition.yaml, though
moving the '$ref:' outside of 'then:' made the 'unevaluatedProperties:
false' disallow everything. The if block here is just trying to
memorialize bcm4908-firmware as a valid compatible at this level, and
(ideally) disallow unevaluated properties if so.

Could that be done with a oneOf? I would think if one of the arms of
the oneOf was "unmodified $partition.yaml, unevaluated allowed" it
would always match, rendering the "unevaluated disallowed when
compatible=3Dbcm4908-firmware" arm unused.

Best,
Sam

>
> > +    then:
> > +      $ref: partition.yaml#
> > +      properties:
> > +        compatible: true
> > +      unevaluatedProperties: false
> >
> >  required:
> >    - "#address-cells"
> > --
> > 2.44.2
> >

