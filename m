Return-Path: <linux-kernel+bounces-353626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975B9993079
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958901C22F21
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8C1D9351;
	Mon,  7 Oct 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H9N73oNT"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A31D8E12
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313371; cv=none; b=tfoo+QD+NJey+4x0brNcmJ1ni9+l9sYS3mbI/4MqUxIlMrJgozmfqDaWwCJ3yBHmce7tkFugfXohypXjp4fqg/1xBk2UScpnyYCLQnPHbXQ2NNLGLmrhkT5GMGyjiOK0+Ob24LR5HcdrDKsRkj7AZzNmRwGXKdUbSWtn32prTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313371; c=relaxed/simple;
	bh=YFgBzb5t13jGsblwPz4zuJTL9xNOUthC3CzWh+2YRRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvTDLljQjn9WVL6KCFdTTZ7a6SVeL/oj5Sd9Ug+YX55gS6OhVZlBKX9rRRriXM2Kn809VTrLXXKHdQBxWXXUsFpDy+7oz+aXDEaLSSoR7+SVGyFoAJ28f2Gjgrcbz4h1IMsL9QQ6pgWug/Lqd+v6MqmrpPl+v+09/VyvwCqHDsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=H9N73oNT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6db20e22c85so35766797b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728313369; x=1728918169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRXc+qYMpiIpv9iclqrXM3fuvSnpa1ayC+j4HSUgcBA=;
        b=H9N73oNTNPU06BDaJnnsNshXrwH+uyEuXIlUEnv35yoggdhGgmClD5zYQh5i1nkjE/
         BUgvR3w8e6Ldwq+/M2T4AJTezzJJcWHYkb/vomQwGPNw60ulw5YUABsQVEedZMGk7GgS
         lUgFwjg7e1s4kNceEWNmU8iV+3oQW8DOqRVqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313369; x=1728918169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRXc+qYMpiIpv9iclqrXM3fuvSnpa1ayC+j4HSUgcBA=;
        b=XYLM7v6KsDc28CoGqgrjF/n1K/d8jSsL+NnbeTLbnNG8yI/08LwbG5FNNJCmGYjTIN
         qsTHvQ6/kpPBinrCafoZMn1wehRQpXIRpb7Bb3lyhmWGrSPZYwwfsPy8eK1uay75R104
         uydyogH3nm6PfVLiuccZSLIcQSIE8hQimjT6phJmZcrXICsFwgx6iSu//fO+iNBtNw4a
         ga4V2VsNkrYffjP7OKBe9MJBmmYrpcR28fbafRSRmEIRvy/QpEgDTM8CCn3v43+lcQJf
         SPrNCgKEs6Un8Ik8KLfWYkc6qspyPUh8G5GBzdcMUSLFnB89dGYwzortmCaSzjXy2DH7
         igsA==
X-Gm-Message-State: AOJu0Yy5ms64R/yxV2HhwKgtQRlVl8dxcgtjHnGyp+VKUtiMreIOCJ93
	visHisLrOKe/dvo/vY60QHo6CoNFqQibdnU1HCbjk66DwI0KU7o+HOOLaFppI+JBrUTsmE9sBpq
	MSz7FkQTYbu121zchXXgNMEJmGAp+jm3fZJjSgw==
X-Google-Smtp-Source: AGHT+IFnJ2aAEnjxDoEAR+k68meuDnN2C3jBt7oao/8Qh8myzaggBhO3fqphRnV4wGyuGqlBgzoWmwVTMtQEKqFZHbA=
X-Received: by 2002:a05:690c:660b:b0:6e2:b263:1052 with SMTP id
 00721157ae682-6e2c6fdd536mr92120257b3.6.1728313368916; Mon, 07 Oct 2024
 08:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928083804.1073942-1-dario.binacchi@amarulasolutions.com>
 <20240928083804.1073942-2-dario.binacchi@amarulasolutions.com>
 <566859c1-a397-4465-987e-0682b07a703e@kernel.org> <CABGWkvqqg-PGAZTCz=MMLRx5F93jaN_=z8zJt1sDd3PHXd80PQ@mail.gmail.com>
 <6c3e6071-822f-4230-b76b-276330de07ef@kernel.org> <CABGWkvrU507BHoP94Y7fEyFr=chuuy3o=oBHtuWRvwTw3GnxXw@mail.gmail.com>
 <82db5037-bbd3-4005-bde9-02df1bf4c475@kernel.org> <CABGWkvqXZ+YAvo-AtUy+Ftdu0xxXKuhOwcSTwO5Fv6D3yzttNg@mail.gmail.com>
 <b847ccb1-1eb8-4119-8612-212804cb50d8@kernel.org>
In-Reply-To: <b847ccb1-1eb8-4119-8612-212804cb50d8@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 7 Oct 2024 17:02:37 +0200
Message-ID: <CABGWkvqkmo9O-O1taR651W4xo=yqar=p71e0LKqRte2CGZ2Z8w@mail.gmail.com>
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

On Sun, Oct 6, 2024 at 3:13=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 05/10/2024 10:57, Dario Binacchi wrote:
> > On Thu, Oct 3, 2024 at 12:46=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 01/10/2024 08:29, Dario Binacchi wrote:
> >>> On Mon, Sep 30, 2024 at 8:45=E2=80=AFAM Krzysztof Kozlowski <krzk@ker=
nel.org> wrote:
> >>>>
> >>>> On 29/09/2024 22:00, Dario Binacchi wrote:
> >>>>>>
> >>>>>>
> >>>>>>> +  properties:
> >>>>>>> +    compatible:
> >>>>>>> +      contains:
> >>>>>>> +        enum:
> >>>>>>> +          - fsl,imx8mm-anatop
> >>>>>>> +
> >>>>>>> +then:
> >>>>>>> +  properties:
> >>>>>>> +    fsl,ssc-clocks:
> >>>>>>
> >>>>>> Nope. Properties must be defined in top-level.
> >>>>>>
> >>>>>>> +      $ref: /schemas/types.yaml#/definitions/phandle-array
> >>>>>>> +      description:
> >>>>>>> +        The phandles to the PLLs with spread spectrum clock gene=
ration
> >>>>>>> +        hardware capability.
> >>>>>>
> >>>>>> These should be clocks.
> >>>>>
> >>>>> Sorry, but I can't understand what you're asking me.
> >>>>> Could you kindly explain it to me in more detail?
> >>>>
> >>>> You added new property instead of using existing one for this purpos=
e:
> >>>> 'clocks'.
> >>>
> >>>>
> >>>>
> >>>>
> >>>> Best regards,
> >>>> Krzysztof
> >>>>
> >>>
> >>> I added this new property specifically for managing spread-spectrum.
> >>> Indeed, not all clocks/PLLs
> >>> managed by the node/peripheral support spread-spectrum, and the added
> >>> properties specify
> >>> parameters for enabling and tuning SSC for each individual PLL based
> >>> on the index of each list.
> >>> If I were to use the 'clocks' property and add a clock to this list
> >>> that does not support SSC, IMHO
> >>> the pairings would be less clear.
> >>
> >> You duplicate property with argument "pairings shall match". Well, I a=
m
> >> not happy with the duplication. Clocks have specific order, thus it is
> >> explicit which one needs tuning. Your other properties can match them =
as
> >> well, just index from clocks is offset...
> >
> > Just to check if I understood correctly what you are suggesting before
> > submitting version 3 of the patch.
> > Something, for example, like:
> >
> > clocks =3D <&clk, IMX8MP_AUDIO_PLL1>,  <&clk, IMX8MP_AUDIO_PLL2>, <&clk
> > IMX8MP_VIDEO_PLL1>;
> > fsl,ssc-modfreq-hz =3D <0, 3517>, <2, 6818>;
>
> Hm, what is 0? If clock index, then no, it's redundant. The first item
> in cannot point to other clock.
>
> Also, what exactly are you setting here

I am enabling and configuring the spread spectrum.

Normal clock: Without spread spectrum, the clock signal has a fixed and
repetitive frequency (e.g., 100 MHz). This frequency generates an
electromagnetic
signal concentrated on a single frequency, and if strong enough, it can dis=
turb
other devices.

Spread spectrum:  With spread spectrum, the clock frequency is
slightly "modulated,"
meaning it oscillates around a central value. For example, if the base
frequency is 100 MHz,
the clock might vary between 99.5 MHz and 100.5 MHz in a cyclic manner. Thi=
s
small variation spreads the energy over a wider range of frequencies
(from 99.5 to 100.5 MHz),
reducing the intensity of the signal at any one frequency.

> and why assigned-clock-rates are
> not working?

The traditional clock properties, such as clocks,
assigned-clocks-rates, etc retain their usual
meaning even when spread spectrum is applied. However, to implement
the spread spectrum
mechanism in a circuit with a PLL (Phase-Locked Loop), additional
specific parameters are
introduced to properly configure the frequency modulation:

 - Modulation frequency: i. e. fsl,ssc-modfreq-hz
 - Modulation rate: i.e.  fsl,ssc-modrate-percent
 - Modulation type:  i. e. fsl,ssc-modmethod (center-spread, down-spread)

Additionally, it should be noted that not all anatop PLLs are equipped
with circuitry for spread
spectrum, but only a small subset of them. This is the reason why I
introduced the property
"fsl, ssc-clocks".

This is another commit [1] on enabling spread spectrum that I
implemented some time ago for
the am335x. The most evident difference is that in that case the node
was a clock node and not
a clock controller, as in the case of anatop. The parameters are also
not exactly the same, but
that depends on the platform.

[1] 4a8bc2644ef0cbf8e ("dt-bindings: ti: dpll: add spread spectrum support"=
)

Thanks and regards,
Dario

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

