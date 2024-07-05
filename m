Return-Path: <linux-kernel+bounces-242481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0189288A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4621F24B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0EF13D243;
	Fri,  5 Jul 2024 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+v3ic4T"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510D149DE3;
	Fri,  5 Jul 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182267; cv=none; b=SZ1cX7crqpGiOVYB/Kk17bs8jwmM8+N48fld5qH6Phvgr0sDa67ZMfve6PTYHL51lB3zp/92o1kbAFXD438FfmtAniAWqxrabHcWvPfePzpOjg7MiqC9hYKgNPe9iLP28LvPtMQIFYv7wqDOTN3GlzvBClCW1fXn12mxY2T6bMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182267; c=relaxed/simple;
	bh=qyZ4pgN9ODC0BjiNwh5o1P10S3yVrnbu2zdf6ekHKXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioFLoodlQilZhOD/D4cyLdBOJIBL+3a0oTsw/8e+dxDWK/jUiM96JyM9zbt+xvvvv+7DA0mrusZyKZc/dQYikkABN5vtdRn0uiOBv6w5SCgI5UPRZWQWptTWKsF+0EOXSH8GOJJxzr+rZZGerZVYurHibD5lJOk1U/nN//HCCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+v3ic4T; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so59365866b.0;
        Fri, 05 Jul 2024 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720182264; x=1720787064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iabrIAMUEOTL61vdHDoYq/UZjIRy45Aj4kyep8lAuoI=;
        b=K+v3ic4TJYHHoOlJj2Td1pvsqSpcD0xtpsE4tjqGeoM0KjgfxqPejUaF93Z9KmUQLZ
         qk9Omrl5nvO9CbTROkkXRnto4Tg+1KXsbpvvyMO5oSLilcpi2IItdaQOt1e5k9Oe5s0I
         EQM9dbG1IMeafZh+UOoUXWLzJAoY3UPr3KKViKYdRnKdlYO3kVrBn1eSGTQXB4HCd/gl
         wOexYPpl+FcFd14J0XYqKtf9+3bD77HHy5XQ89uq4R0J7zeiz41av/LdMad2yqjUG9AT
         7E6qfB+7epTGSHhFHJcuXMSqLE7kQU+ufq7I6eXAtW+mEGuwd2RsPpC32l2j1eBOB3tM
         6Bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720182264; x=1720787064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iabrIAMUEOTL61vdHDoYq/UZjIRy45Aj4kyep8lAuoI=;
        b=X910fM1uzShga3vLKWiDw9gE74GlMpOuB0vtzQSERgbwqptOeSKXpdU4lktzsZ7QSj
         1Hl4hZl2GK7FKj5+KjdKkpOZslooG2hr19ZqpeH/OIhGzcmaTfMYj696SO1El/L3fGb5
         fdbMY8f7PSYenolzDsP+HcESre+FMd/PJ3bH28q/l2eJuy5cDqYMsQP4czkg2lDBmFi+
         8XxqhwMerqc6Wx+FwATr5PVUdeegVPWfNE6easfRrA4zdEFpp+VFlyOMBZl9XtFJiBKe
         ULPSuiGs5gmVckUzYYot5bMbnveFdk/Mlp4dm7TuHWT6+iQ0enAIi1us8oyGgzSacFFt
         aang==
X-Forwarded-Encrypted: i=1; AJvYcCXNPJoid+qBF8ivyEBSwm6ODd4tIh32qsvB0azEIgAI0elJI1m2VAXyDOx2hR2neM4ANFmWkOgMfhYd6AJYFnw+E2efg6NtIxYmfYqOpj+FaCwdAGjnI6BaL4Dq2Va7xjeiYkV7dtspeQjJHexjZG28f/atBNOeqtpbrvgs8d6dXtN+U/Iv
X-Gm-Message-State: AOJu0YxijI75g36q909W2l9OiApvsSKdu/tPrAWldKhBIwVCjhopdRzM
	RTX68/BNPIW0ukhGq19768tsTJQ/GGoofQe4TsyaU3QdT764O12r8bZ38kgWOF8p5RKs/L0ISTo
	+nePL6I+c1HvMJSAhpThHn1udBYI=
X-Google-Smtp-Source: AGHT+IEkwLYq9DV+FyUhDlmnP1mMXhabJ2ZHkHkFRFF3nDAXxGnMPurbx/i4zDvRg7nKq8uR0YUrjTeOGYI9xZwgGlU=
X-Received: by 2002:a17:906:b751:b0:a6f:4287:f196 with SMTP id
 a640c23a62f3a-a77bd99ec1bmr292931566b.2.1720182263880; Fri, 05 Jul 2024
 05:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622182200.245339-1-animeshagarwal28@gmail.com> <268a722a-c2e8-42fe-9cae-104e3f082a0a@kernel.org>
In-Reply-To: <268a722a-c2e8-42fe-9cae-104e3f082a0a@kernel.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 5 Jul 2024 15:24:10 +0300
Message-ID: <CAEnQRZBXTkQCwAyy6i1k_hb5ts99p4Cd8bihLu7bz+4TfJm9wA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,imx-audio-sgtl5000: Convert to dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 10:08=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 22/06/2024 20:21, Animesh Agarwal wrote:
> > Convert the imx-audio-sgtl bindings to DT schema. Make bindings complet=
e
> > by adding audio-cpu property.
>
> On what basis? Who needs or uses audio-cpu? Driver? DTS? Both? If only
> DTS, then is it needed? Maybe not?
>
> >
> > Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../sound/fsl,imx-audio-sgtl5000.yaml         | 108 ++++++++++++++++++
> >  .../bindings/sound/imx-audio-sgtl5000.txt     |  56 ---------
> >  2 files changed, 108 insertions(+), 56 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-aud=
io-sgtl5000.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-s=
gtl5000.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl=
5000.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl5000.=
yaml
> > new file mode 100644
> > index 000000000000..906dcecb73b7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl5000.ya=
ml
> > @@ -0,0 +1,108 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,imx-audio-sgtl5000.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale i.MX audio complex with SGTL5000 codec
> > +
> > +maintainers:
> > +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,imx25-pdk-sgtl5000
> > +              - fsl,imx51-babbage-sgtl5000
> > +              - fsl,imx53-m53evk-sgtl5000
> > +              - tq,imx53-mba53-sgtl5000
> > +              - fsl,imx53-cpuvo-sgtl5000
> > +              - fsl,imx53-qsb-sgtl5000
> > +              - karo,tx53-audio-sgtl5000
>
> Keep list ordered alphabetically.
>
> > +              - fsl,imx53-voipac-sgtl5000
> > +              - fsl,imx6q-ba16-sgtl5000
> > +              - fsl,imx6q-ventana-sgtl5000
> > +              - fsl,imx-sgtl5000
> > +              - fsl,imx6-armadeus-sgtl5000
> > +              - fsl,imx6dl-nit6xlite-sgtl5000
> > +              - fsl,imx6q-nitrogen6_max-sgtl5000
> > +              - fsl,imx6q-nitrogen6_som2-sgtl5000
> > +              - fsl,imx6q-nitrogen6x-sgtl5000
> > +              - fsl,imx6-rex-sgtl5000
> > +              - fsl,imx6q-sabrelite-sgtl5000
> > +              - fsl,imx6-wandboard-sgtl5000
>
> None of these were in the old binding and commit msg mentions only
> audio-cpu. From where do you get these?
>
>
> > +          - const: fsl,imx-audio-sgtl5000
> > +      - const: fsl,imx-audio-sgtl5000
> > +
> > +  model:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: The user-visible name of this sound complex.
> > +
> > +  audio-cpu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of an CPU DAI controller
> > +
> > +  ssi-controller:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of the i.MX SSI controller.
> > +
> > +  audio-codec:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of the SGTL5000 audio codec.
> > +
> > +  audio-routing:
> > +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> > +    description: |
> > +      A list of the connections between audio components. Each entry i=
s a pair
> > +      of strings, the first being the connection's sink, the second be=
ing the
> > +      connection's source. Valid names could be:
> > +
> > +      Power supplies:
> > +        * Mic Bias
> > +
> > +      SGTL5000 pins:
> > +        * MIC_IN
> > +        * LINE_IN
> > +        * HP_OUT
> > +        * LINE_OUT
> > +
> > +      Board connectors:
> > +        * Mic Jack
> > +        * Line In Jack
> > +        * Headphone Jack
> > +        * Line Out Jack
> > +        * Ext Spk
> > +
> > +  mux-int-port:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: The internal port of the i.MX audio muxer (AUDMUX).
> > +    enum: [1, 2]
>
> default:
>
> > +
> > +  mux-ext-port:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: The external port of the i.MX audio muxer.
> > +    enum: [3, 4, 5, 6]
>
> defaukt:
>
> > +
> > +required:
> > +  - compatible
> > +  - model
>
> Several other properties were required. Why changing this? Please
> explain in commit msg all changes done to the binding comparing to pure
> conversion.

I wonder how should we handle the case where 1 compatible string is
found in 2 drivers.

e.g

soc/fsl/fsl-asoc-card.c:        { .compatible =3D "fsl,imx-audio-sgtl5000",=
 },
soc/fsl/imx-sgtl5000.c: { .compatible =3D "fsl,imx-audio-sgtl5000", },


Take for example audio-cpu propertyssi-controller which was only added
in the newer soc/fsl/fsl-asoc-card.c driver. So this is required in
the new driver unless
the old binding "ssi-controller" is not present.

Given the fact that there are already 10 years since this commit:

commit 708b4351f08c08ea93f773fb9197bdd3f3b08273
Author: Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Wed Jul 30 19:27:38 2014 +0800

    ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support

The driver is also compatible with the old Device Tree bindings of WM8962 a=
nd
    SGTL5000. So we may consider to remove those two drivers after
this driver is
    totally enabled. (It needs to be added into defconfig)

I think we should send a patch to remove soc/fsl/imx-sgtl5000.c
because I assume that by this point it's functionality
was fully implemented in soc/fsl/fsl-asoc-card.c

Thanks,
Daniel.

