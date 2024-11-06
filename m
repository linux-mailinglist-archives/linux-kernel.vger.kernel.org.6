Return-Path: <linux-kernel+bounces-398973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD49BF8BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8489B283E4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73B1D9323;
	Wed,  6 Nov 2024 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvJ8i+Gu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670E18FDA5;
	Wed,  6 Nov 2024 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929992; cv=none; b=gDCpbSI+vCAUe6RvYn+FAYvfm3Kwxpx30B65kj2k56bCmFzVng9jwtzRH9G9k1wrFu3xMv+rkonPyFPiQHhE6aei1PH17PjWlnSd3eAGG5KwrE3o/6LyO6I1zF+X4VdcwDx2pgw4FKDXQpBlJx7NrbFEh2kRTUEf1mYS039EzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929992; c=relaxed/simple;
	bh=vBUNYW41X8j9KVkVJ9SID98oI09XWTwBRYeK0M5j0TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpFB2rqEraUAfcDrPrA2YcgglXf2dF8JcpBp4DugfDZdB3DoacIOXJndPNKnyhVTct29sogob8O9jw1tE1qGd74/qtscyB/VWDCPrlsz6naGAf//oj/WNtV/VpncXHeMoWMKqUvPoQvuXByKF7g9PGytVE3f1WkGWpiVbou+og8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvJ8i+Gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4B2C4CED0;
	Wed,  6 Nov 2024 21:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730929992;
	bh=vBUNYW41X8j9KVkVJ9SID98oI09XWTwBRYeK0M5j0TQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XvJ8i+GuO0FBfeWdP1EP8PFsB3mhJ1SkIwubJeAPaHNg0Gxx1bFvGcBs6g7gEktgg
	 Nc9JVIlBMyyzwrKz0FCiLZ7d35xt8z15/YtTxzeCGrV6nQh+zARjhMg1MZF8abfqDK
	 kxpJ6iZSCIVgsk5+l2BbrFfKdvwI0Sd7eCue9CosGF+wB0kru5ZBM3i9DrHVHMjVWQ
	 JR9WSTgBlB6VYTVtlIzhczXIz1SVE6kbU8irfZ0sVjOSOtAvvXoJelj2Ai/mpG7DiW
	 huEKCFtpJ4vNbJbogwfAEPPuYlIC+fpWVfPc4UTknMNnOn98UFZTq0tBI6/sU9xqls
	 QeHijuDF3pbHg==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so267153276.3;
        Wed, 06 Nov 2024 13:53:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4c38QU8OANM7lWwweFgST9SGzVKLfr2bKh7xmqUZzq3X0sLQSmpEzvifekWufHPJY2yNzKwZUr/96@vger.kernel.org, AJvYcCVyj2HL7cYPhMoTEznGLDmIgzEMsT3qR7nON6FnjXlw4PSmDdpLIENEQR8k6xWkSv+4q3upv1aD9pjkVJcB@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiG3lB5qXlxp/7R9a31SiLAJ3/87fi5WbVdUaeBe9Oj3XGi+9
	CLZNcBbSEg6SLjEzZmYLfcc/vwVeE93iganHTe4zYYKLweB+3nJI6Tw2dBODq/EXfeucpbXnq4v
	R4n2xNVC0v0APdZipW39B7egDWg==
X-Google-Smtp-Source: AGHT+IFGsz0bjZks3SaX+0VdpO9QyxD6TF9jMNKPDx0ikEy137YNiUqssnlxpQt2OV0tyDlj1GpHTCW3MDe2kVYzq1g=
X-Received: by 2002:a05:6902:1142:b0:e2b:b9bf:fe5b with SMTP id
 3f1490d57ef6-e30e5a0226emr23814007276.8.1730929991130; Wed, 06 Nov 2024
 13:53:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014193528.1896905-2-robh@kernel.org> <87r07p8x12.fsf@BLaptop.bootlin.com>
 <0A5AFF77-D888-4151-9C15-15A408709857@fw-web.de> <CAL_JsqKfpVVVh6L0PLmieBO3qMFpcDfWFwd+5=qzH_MbeZt31Q@mail.gmail.com>
 <4aa7f13e12646722d859ead240177eab@fw-web.de>
In-Reply-To: <4aa7f13e12646722d859ead240177eab@fw-web.de>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Nov 2024 15:52:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJbYW3mpcjHb5YazUviVOmJEgjaWrbK0XYjR7xVQEb2+Q@mail.gmail.com>
Message-ID: <CAL_JsqJbYW3mpcjHb5YazUviVOmJEgjaWrbK0XYjR7xVQEb2+Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: Drop undocumented SATA phy names
To: "Frank Wunderlich (linux)" <linux@fw-web.de>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, frank-w@public-files.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:17=E2=80=AFPM Frank Wunderlich (linux) <linux@fw-w=
eb.de> wrote:
>
> Am 2024-11-06 19:39, schrieb Rob Herring:
> > On Wed, Nov 6, 2024 at 12:34=E2=80=AFPM Frank Wunderlich <linux@fw-web.=
de>
> > wrote:
> >>
> >> Am 5. November 2024 17:28:57 MEZ schrieb Gregory CLEMENT
> >> <gregory.clement@bootlin.com>:
> >> >"Rob Herring (Arm)" <robh@kernel.org> writes:
> >> >
> >> >> While "phy-names" is allowed for sata-port nodes, the names used ar=
en't
> >> >> documented and are incorrect ("sata-phy" is what's documented). The=
 name
> >> >> for a single entry is fairly useless, so just drop the property.
> >> >>
> >> >> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >> >
> >> >Applied on mvebu/dt64
> >> >
> >> >Thanks,
> >> >
> >> >Gregory
> >> >> ---
> >> >> Cc: Frank Wunderlich <linux@fw-web.de>
> >> >>
> >> >> There's also this 2 year old patch fixing other SATA errors[1] whic=
h
> >> >> was never picked up. :(
> >> >>
> >> >> [1] https://lore.kernel.org/linux-arm-kernel/20220311210357.222830-=
3-linux@fw-web.de/
> >>
> >> Hi
> >>
> >> How to deal with my patch pointed by rob?
> >
> > I believe it will conflict with mine. Can you rebase on top of
> > mvebu/dt64 and resend it.
> >
> > Rob
>
> i have rebased my patch [1], but it seems there are much more errors
> there (which i tried to fix there too).
>
> To be honest marvell is confusing to me finding the right file to patch
> because of many dtsi files included by each other mixed with some
> macros.
>
> at least some properties have to be documented in yaml:
>
> arch/arm64/boot/dts/marvell/armada-8040-db.dtb: sata@540000: Unevaluated
> properties are not allowed ('#address-cells', '#size-cells',
> 'dma-coherent', 'iommus' were unexpected)

iommus should be added to ahci-platform.yaml.

I think the others are just a side effect because sata-common.yaml
fails due to phy-names. When phy-names is fixed, they should
disappear.

> sata-node itself seems to be defined in
> arch/arm64/boot/dts/marvell/armada-cp11x.dtsi (adress/size-cells and
> dma-coherent are defined here)
>
> iommus seems to be added with
> 83a3545d9c37 2020-07-15 arm64: dts: marvell: add SMMU support Marcin
> Wojtas  (tag: mvebu-dt64-5.9-1)
> which seems not be documented in txt before i converted the binding.
>
> so something like adding this to the binding:
>
>    '#address-cells':
>      const: 1
>
>    '#size-cells':
>      const: 0
>
>    dma-coherent: true
>
>    iommus:
>      maxItems: 1
>
> dma-coherent was there in my version and seem to be broken with
>
> 6f997d4bb98b 2022-09-09 dt-bindings: ata: ahci-platform: Move
> dma-coherent to sata-common.yaml Serge Semin
>
> but maybe i only get the error for it because of my call with my yaml
> only
>
> ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make dtbs_check
> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/ata/ahci-platform.yam=
l
>
> adress/size-cells is strange to me, i'm sure i tested the yaml against
> the example which also contains them...i guess it was defined somewhere
> else.
>
> and this one:
>
> arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: sata@540000:
> sata-port@0:phy-names:0: 'sata-phy' was expected
>         from schema $id: http://devicetree.org/schemas/ata/ahci-platform.=
yaml#
>
> i guess it is taken from here:
> Documentation/devicetree/bindings/ata/ahci-common.yaml:107:
> const: sata-phy
>
> if i understand it the right way then if phy-names is defined in
> sata-subnode it has to be value "sata-phy"...so basicly somewhere in the
> chains of dtsi's a phy-name is defined to another value..am i right?
>
> it looks like it is in
> arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi...if i drop the
> phy-names for the other sata-ports (below cp1_sata0)
>
> seems dropping them were missing from your patch as you remove another
> one in same file (&cp0_sata0)

Humm, not sure how I missed that. I was probably looking at warning
counts and the others registered higher.

Rob

