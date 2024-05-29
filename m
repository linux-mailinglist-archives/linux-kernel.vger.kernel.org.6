Return-Path: <linux-kernel+bounces-193357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96778D2AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 04:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222B4B23CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F115B0ED;
	Wed, 29 May 2024 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZDp03Qa"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15774DA08;
	Wed, 29 May 2024 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949112; cv=none; b=D3yaig8aESK3l8dx8gjA1MkTan1PDTjpE9pjQrCQitBtt6AhZYPjuZ7trDLbXdoNGx1r+5sI2z8oncYOQy4Sl0LkF3ImvBC11r3o37cgZKzGjUEfLvTXzZ+I/+k3TQQd1G8M2/riMJY/jfguy3FTCLm6PSXmNAFLLZQEAOud0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949112; c=relaxed/simple;
	bh=jcVK57FbtJeQrFT8gv4gi4N3C+tc4HJy3psQqxo2nOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7nvb4qIPvO5RHprdDOaDCkggMMMxXhaIydTPqXbx6oRU9F0cysyIC4/vCi29Z3LFxb2l6B6jk1uCt5Ox8GA8mp55QbV60mJF7vf78o5NJmQhO6vQcH8NvwQrlxCMNvEN1SGn+ph4Xb6+kayn2FZXjuP/+tjmw86L4A9BOr1JtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZDp03Qa; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e21dfbc310so60166539f.1;
        Tue, 28 May 2024 19:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716949110; x=1717553910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1zuMc6QVmp7ZjCjJt78h2VKZOxHAgfCEmVnh0EIazE=;
        b=HZDp03QavG/KudtSJTjG3YO6b/9xsnUlElYN2TPjOwmgoL4VHPaeUwyXSMkcG1frZ1
         p/QgkjseQ5J4cd3mmFzsmTVT8elYs7n6L4LrmF9yddRc0G8aRSyCycqDQrV6eF2T9LJn
         jP+isEdGJdNe0I5JTerr8fTvUIFCvxG7dz9icIWPSXnSOdEFgQU4T6khZ27BkxIZuMbL
         8OlWWAZRO+0Z5758Mp+UmlfxV9CeqbPrv2YqrYwNF1+XUeaYZuMVCjpCoeqO5oS0xKGJ
         xJCWS4beNkmu6boTpXV1dZ5bcPsxYAUBW2ndhu33VwTON5OIlmdAxGyC4CuVfr+Z5SKp
         04pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716949110; x=1717553910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1zuMc6QVmp7ZjCjJt78h2VKZOxHAgfCEmVnh0EIazE=;
        b=R23gMJfkEtodlNmlRLY99MywZKISFcnxnPcLMiuRgLBBUgtbGkqnqSwqcjf0cx0ArY
         TlzM7r5kxWdRDPqQ075rTBbR/YH1FAEKegGd4JO5oeknnIj65UjuqO1yOsb+pjJHiBEm
         s/T6Ws9jLM7RnBn/vtec4HjvVj6+q8YAgW8jJ5TuTCraaimGKRi1dtaxGTwTzlS82/oW
         /qpIpNvXDx0HyjVOel0o1HRdcxKgPjqgilMhiIJ8wPr3VmeLE8gfdegCyOXv/VWyBhMe
         3QRpczEIagFQzpPQwCtgvloJzEEVfWUW+bnYepGlHPpM7b3QaSE2Zn8qbbNKWmt+Q0h8
         uJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCX6saKWHn4IgQhlSl85MHRxQJvED3ElhokQOykv0M+vIwqiuV3RI8m90p8kPd2TMHqGxYaOEym/8ye4dhsHkKXhMMkO3DrYN7zr2YrWdzbScIzm6qo0b3x/8hpQs8qcI4ZpDS5sqXiVIP79xTEKMJqUtmEIkMDqY5jwOPvfQDv1PZJvCuv+
X-Gm-Message-State: AOJu0YzGs5XVR/cL8VLnW5SfEvk1x8TtpD2WHm8fepfVAy2K9SAUetqQ
	ZiyucDuwyL3OUKYVu5d7EnBFaiaNlkqEH95zLiXJ+3gY/46Kg0/OP1ZragLzVHe9DdE4FZYZACD
	eTFV7mkg6FELcV/KH8Gq9G9cHq6s=
X-Google-Smtp-Source: AGHT+IFcF3TNc9ogUWcYtJiiuSJm+fWo3KnUCeZ2Iq6PTOrYl3WLncVJ7quYftqH5wIdf7b86ARTJGK34c1ksQ3R+ik=
X-Received: by 2002:a92:ca0e:0:b0:374:593f:914a with SMTP id
 e9e14a558f8ab-374593f9523mr79683085ab.4.1716949110033; Tue, 28 May 2024
 19:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716286416-17621-1-git-send-email-shengjiu.wang@nxp.com>
 <1716286416-17621-2-git-send-email-shengjiu.wang@nxp.com> <20240528151536.GA275498-robh@kernel.org>
In-Reply-To: <20240528151536.GA275498-robh@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 29 May 2024 10:18:18 +0800
Message-ID: <CAA+D8AMyf9jEHapNkRdEguhi8T+WVQXhxcF_tESmgbrffvdTxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: fsl,xcvr: Add compatible string
 for i.MX95
To: Rob Herring <robh@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:15=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, May 21, 2024 at 06:13:35PM +0800, Shengjiu Wang wrote:
> > Add compatible string "fsl,imx95-xcvr" for i.MX95 platform.
> >
> > The difference between each platform is in below table.
> >
> > +---------+--------+----------+--------+
> > |  SOC          |  PHY   | eARC/ARC | SPDIF  |
> > +---------+--------+----------+--------+
> > | i.MX8MP |  V1    |  Yes     |  Yes   |
> > +---------+--------+----------+--------+
> > | i.MX93  |  N/A   |  N/A     |  Yes   |
> > +---------+--------+----------+--------+
> > | i.MX95  |  V2    |  N/A     |  Yes   |
> > +---------+--------+----------+--------+
> >
> > On i.MX95, there are two PLL clock sources, they are the parent
> > clocks of the XCVR root clock. one is for 8kHz series rates, named
> > as 'pll8k', another one is for 11kHz series rates, named as 'pll11k'.
> > They are optional clocks, if there are such clocks, then the driver
> > can switch between them to support more accurate sample rates.
> >
> > As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4' for
> > clocks and clock-names properties.
> >
> > On i.MX95, the 'interrupts' configuration has the same constraint
> > as i.MX93.
> >
> > Only on i.MX8MP, the 'resets' is required, but for i.MX95 and i.MX93
> > there is no such hardware setting.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,xcvr.yaml   | 37 ++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Do=
cumentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > index 0eb0c1ba8710..d1dcc27655eb 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > @@ -22,6 +22,7 @@ properties:
> >      enum:
> >        - fsl,imx8mp-xcvr
> >        - fsl,imx93-xcvr
> > +      - fsl,imx95-xcvr
> >
> >    reg:
> >      items:
> > @@ -49,6 +50,9 @@ properties:
> >        - description: PHY clock
> >        - description: SPBA clock
> >        - description: PLL clock
> > +      - description: PLL clock source for 8kHz series
> > +      - description: PLL clock source for 11kHz series
> > +    minItems: 4
> >
> >    clock-names:
> >      items:
> > @@ -56,6 +60,9 @@ properties:
> >        - const: phy
> >        - const: spba
> >        - const: pll_ipg
> > +      - const: pll8k
> > +      - const: pll11k
> > +    minItems: 4
> >
> >    dmas:
> >      items:
> > @@ -79,15 +86,24 @@ required:
> >    - clock-names
> >    - dmas
> >    - dma-names
> > -  - resets
> >
> >  allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx8mp-xcvr
> > +    then:
> > +      required:
> > +        - resets
> > +
> >    - if:
> >        properties:
> >          compatible:
> >            contains:
> >              enum:
> >                - fsl,imx93-xcvr
> > +              - fsl,imx95-xcvr
> >      then:
> >        properties:
> >          interrupts:
> > @@ -98,6 +114,25 @@ allOf:
> >          interrupts:
> >            maxItems: 1
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx95-xcvr
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 6
> > +        clock-names:
> > +          maxItems: 6
>
> 6 is already the max. Drop these and add a 'not' into the if schema (or
> list out the other compatibles).

Ok, will update it.

best regards
Shengjiu Wang
>
> > +    else:
> > +      properties:
> > +        clocks:
> > +          maxItems: 4
> > +        clock-names:
> > +          maxItems: 4
> > +
> >  additionalProperties: false
> >
> >  examples:
> > --
> > 2.34.1
> >

