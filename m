Return-Path: <linux-kernel+bounces-343144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF66989736
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6141C20B49
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA207DA88;
	Sun, 29 Sep 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nZT54Qu6"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A92A4207A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727640041; cv=none; b=C4igd4prixLVkyRaWrbRtzzxLkMIg5X5FWj7x1CTg0DTJ1QOlvC2KM0u5CN4vyVJ9vuN/OyFhTyNRfE1pB5zEMGmlyVJ0SyHFHPHZd/Dyr1kCaHO1dy4RRuHorDUrxBdpDp1quqYrUq8gS+gcKuVgw/1BrUZGvaG8wmilqphar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727640041; c=relaxed/simple;
	bh=C+HE48UOVNh3S8JegzOeS1KV251zvl3uafKiq4ay2XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBKHZ4u9uSlYn5fxioyHeBCLUW7RL94XB7B1RtewYcSbX5UjlwNXzsirQHVhrq8u+ZPv4ttLUrfknhgaIiGLpBz+0B7evNB4gxZsKdrgPpVOToGsRcZzAOJEpl5qbOtsTqLCm/4Mz7RVxOpwt92vi5SumJ2aw28PPcS1TOGLt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=nZT54Qu6; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e22f10cc11so29219757b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727640038; x=1728244838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THVSoogwNns4Otfo36VQb2ocrUo2155C0xuop1kKVhc=;
        b=nZT54Qu6xaErcF99YP+U9KayN5bVBE45YeMalKC0Hb/cxsUC8k7majIS86BSpwv1Tg
         3hW7X0xB/JXn8Wzg2iF2IGvaBzUoreCUq6UAka6nifxlR0yJgCik1vrLIUi/O7kmdYJh
         fvKDPRY5VNqHmsCcjdysoMDLDEYXpq/edrZSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727640038; x=1728244838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THVSoogwNns4Otfo36VQb2ocrUo2155C0xuop1kKVhc=;
        b=Tq/3XukwmDPleiM7zyE4SVDhuWx7BiKuSke3H2pTLpKJyXBP1jerL9iLhiejrbSUnN
         fc9GQBTyfVuFaKlAGeft2wq+9mkUhvJEmq+0mVkugge9hDoF9CfsgfeWR6SUFRjUS7ZI
         Db6FZAKhwd1GC+ednvoodCbQECwyw9QN27DbypqZrmUGRGDZXtA2GGxIHBm6QHFnjDOn
         v2OQf58rR2ZsmZJIPNUjNLzwoi55ajWcl1JF5xpjf76MWHgchay07Yx807iyYTjPkrIV
         U4Aslax7XkUkik4jCJ2cgHSXUn7d/sZ1Mljb13nwqRThespaARxN97BHnPkChFrpO2Vf
         KdKA==
X-Gm-Message-State: AOJu0Yz/2y1f9BpSjqujWtjis0g8iWDpXVM65EVIurUSbsxjjyPfd9iK
	QTOyL+mnNYy+5U4PaA3qn3PK+SK/3Ax3kSWnPMg/pc2CHDE+08Vxz9+kcozyyXQOGY5fSI9J0OW
	GBibFhIMiVxMGiT8Qcgu3yh11lxQ+QmvpUcdo9A==
X-Google-Smtp-Source: AGHT+IHIOE3+c2mX/UsbrIe1XO7FQZ+whU+SXEoKWNXBu9Vk5hhOQ7qtm4cjBU4dpR9jmUzCwLswFX+y7Pi2oOlEcv8=
X-Received: by 2002:a05:690c:4488:b0:6db:2604:ea6b with SMTP id
 00721157ae682-6e24759414bmr55679827b3.25.1727640038489; Sun, 29 Sep 2024
 13:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928083804.1073942-1-dario.binacchi@amarulasolutions.com>
 <20240928083804.1073942-2-dario.binacchi@amarulasolutions.com> <566859c1-a397-4465-987e-0682b07a703e@kernel.org>
In-Reply-To: <566859c1-a397-4465-987e-0682b07a703e@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sun, 29 Sep 2024 22:00:27 +0200
Message-ID: <CABGWkvqqg-PGAZTCz=MMLRx5F93jaN_=z8zJt1sDd3PHXd80PQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: clock: imx8m-anatop: support spread
 spectrum clocking
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 2:09=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 28/09/2024 10:37, Dario Binacchi wrote:
> > The patch adds the DT bindings for enabling and tuning spread spectrum
> > clocking generation.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> >  .../bindings/clock/fsl,imx8m-anatop.yaml      | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.y=
aml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> > index bbd22e95b319..c91eb4229ed3 100644
> > --- a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> > +++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> > @@ -32,6 +32,47 @@ properties:
> >
> >    '#clock-cells':
> >      const: 1
> > +if:
>
> This should be allOf: and placed after required: block, like in example
> schema.
>
>
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - fsl,imx8mm-anatop
> > +
> > +then:
> > +  properties:
> > +    fsl,ssc-clocks:
>
> Nope. Properties must be defined in top-level.
>
> > +      $ref: /schemas/types.yaml#/definitions/phandle-array
> > +      description:
> > +        The phandles to the PLLs with spread spectrum clock generation
> > +        hardware capability.
>
> These should be clocks.

Sorry, but I can't understand what you're asking me.
Could you kindly explain it to me in more detail?

>
> > +      maxItems: 4
> > +
> > +    fsl,ssc-modfreq-hz:
> > +      $ref: /schemas/types.yaml#/definitions/uint32-array
>
> This should fail. I don't think you tested this patch.

I executed the command

make dt_binding_check DT_SCHEMA_FILES=3Dfsl,imx8m-anatop.yaml

and it did not raise any errors.

Thanks and regards,
Dario

>
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pr=
operty-units.yaml
>
> > +      description:
> > +        The values of modulation frequency (Hz unit) of spread spectru=
m
> > +        clocking for each PLL.
> > +      maxItems: 4
> > +
> > +    fsl,ssc-modrate-percent:
>
> Same problems
>
>
>
> Best regards,
> Krzysztof
>


--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

