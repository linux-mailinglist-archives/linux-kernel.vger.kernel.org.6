Return-Path: <linux-kernel+bounces-402557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362C69C2901
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE3EB21EA0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1E017C9B;
	Sat,  9 Nov 2024 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKZ3S9LO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A921C27;
	Sat,  9 Nov 2024 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731113830; cv=none; b=TFeF8f+aval6pUhq0DIIqTKkQul9el6CcRQNLxSId3QOz2Ih7eHdcLjcSij9UU7WOfrU9hMLa5nWVqhbvfHvINee2rAt7dL+lORWLOvZEsGSkw952HBd1ZkFFEr6nVbWIl6Heolgrd89gITqg6O63woR2DRMdhS/t5r0N8ZUDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731113830; c=relaxed/simple;
	bh=AAgh7H7XwsgjOcj3IfUCIIRu75IjtNvx9dP2aHyYSfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvALFZYzPgY3Pyt/QKoe31yL1yj9d919FI6IWGtm9aGqYY/CT7oa85cvGTJfuAEzkFkQYrU2iBwU+DwBrZOTuHOVOscrdG7Xl9MwiR2LL15OG7QjTDcYlsx+4xLsSipLuOzQtnCxUP2Rk5B6nGCL1p3Y82Fgpyppuwl1eMtC/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKZ3S9LO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720d01caa66so2658853b3a.2;
        Fri, 08 Nov 2024 16:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731113828; x=1731718628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giiL/kmBTCVF3U8QV+/xjUjiPzMAGE0/2NFlz+o4GC8=;
        b=WKZ3S9LOc2wns0cJEwRxuizFuuSv130zpRqDVmLBJbWIXmSiFWnxN85jVfXWzFAuH6
         aaOUHuPqEzZ6ZXV31G03tX9/gP8wea8ABwX7XxqHgf4E8Et7pAoGXF+d60tzOCrZK4dJ
         8FpiANtS/HKetKtAfIJbjX4ANoD1ryPsX7/S6mh5qpf0Pe4hNc4yZBvvpIkefCnhAR+m
         CdNFP+L6hRoHTnMX/uFpd+Et/7AR64JOPAX74nK3wsIzk3xyjJ/nJTYJrT0c/K/TW9dh
         ny6s9ccrdZfz8fNuM801gAueWN6ZYCj5IM7rGg7L9PAdi+YNEaC/qQuRUJfmtqy7ZlwA
         IcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731113828; x=1731718628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giiL/kmBTCVF3U8QV+/xjUjiPzMAGE0/2NFlz+o4GC8=;
        b=XOEpA7HdIAX8BbXjvsiWUgPiT1zl9uzDDeZfJdsOetl0hUjYij80WtMmFoJiBzpO+k
         7WW0VfHpwTeJ1Swvuh2gFml11odeweitSaq390EHGIDA3TccTYWip+7HaF2yuhs8HdZt
         du/KV7WcAlw5gY9CmaGIkI2/NGdvLLHLct7eQGok+7vJ1TbcI/mDr5LpKE83M0YcR0II
         PNJes7apw6BMRB60h1bpoYkgr4QpAt7Rvp/F07NwFxYQcUWXHrR5F2MeahyCOAldmlSZ
         uFht/OE3ITlr17EDUgyyUlEfDUVbAabTdF1zV6Qe/gYFp9h8Iph6rI60vAqVlWVbFSMG
         iO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7R7RsFUwghqdUdSzuRWjtrK4Rup5Wcc5qiDNfdoeIzO1ZUdDXnDHZ0HLvpQaoccoS2Lg7HHo3rkqL@vger.kernel.org, AJvYcCVQELl7QqgowEL8L0neM4HY5Ct9lzyAVuenLjUxZ9CLXYajGZZ3m8MGxZ8JXylwwJUCgYNv+LLbgOuJ@vger.kernel.org, AJvYcCWp2Wp59rb/7MrZ32hinaDNaFncZ49ptJKgNPVLApAqrGpdVZrl3Tbe4XCc5wENPsTyfi9VfWPt/nTBFWmV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5pp2z7U54NdJQGGRFOHHSCMke+zZ1YGEwpwj50LFKOxVQTGuF
	xFRhy0hFxDYodiFKqSwprsnFkXQ5vfqxzMyxVlrR2lxb+rffFydEe6y7732w1WiLRgLJSS5Qlvl
	9q65w7p+PuRQQJfNdFIEF9LzFXxQ=
X-Google-Smtp-Source: AGHT+IFCBsAPm88J58jQ3X5q6NhHTLb+ZI6Xoq5Upa8IQqpPBawMNUt3VLvT52CoHD2XFc2ek2esFaO+L1peVd03Wc8=
X-Received: by 2002:aa7:888c:0:b0:71e:634e:fe0d with SMTP id
 d2e1a72fcca58-724132c4b0dmr6649906b3a.12.1731113828160; Fri, 08 Nov 2024
 16:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
 <20241106090549.3684963-2-dario.binacchi@amarulasolutions.com>
 <4bix7me5vaoyhcuffyp4btajmhy7no6ltczoesopaz2fqupyaw@fensx4nn472u>
 <b7c1499b-8337-421c-9734-6e518d678ff8@kernel.org> <CABGWkvrYJL9=zrPSFuEAgKO+9gDHD6RmCJM6Br6Le_eh578ETQ@mail.gmail.com>
 <54dd6ae6-b992-451e-b1c6-8a1968955f4a@kernel.org> <PAXPR04MB8459BE3474EFD4FCC28E0E82885D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <8c310eca-d695-418c-82cb-a89351d83887@kernel.org> <PAXPR04MB8459B6F8D5C623D19CCF6B39885E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459B6F8D5C623D19CCF6B39885E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 8 Nov 2024 18:56:56 -0600
Message-ID: <CAHCN7xLSw7sBywVJ0ZcoOy4ao8x8GxpVwg8=4h-HoOxEsz565w@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock: support spread
 spectrum clocking
To: Peng Fan <peng.fan@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>, Abel Vesa <abelvesa@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 6:37=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock: support
> > spread spectrum clocking
> >
> > On 08/11/2024 13:50, Peng Fan wrote:
> > >> Subject: Re: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock:
> > support
> > >> spread spectrum clocking
> > >>
> > >> On 07/11/2024 15:57, Dario Binacchi wrote:
> > >>>     clocks =3D <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
> > >>>                   <&clk_ext3>, <&clk_ext4>;
> > >>>     clock-names =3D "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
> > >>>                              "clk_ext3", "clk_ext4";
> > >>>     assigned-clocks =3D <&clk IMX8MN_CLK_A53_SRC>,
> > >>>                                   <&clk IMX8MN_CLK_A53_CORE>,
> > >>>                                   <&clk IMX8MN_CLK_NOC>,
> > >>>                                   <&clk IMX8MN_CLK_AUDIO_AHB>,
> > >>>                                   <&clk IMX8MN_CLK_IPG_AUDIO_ROOT>,
> > >>>                                   <&clk IMX8MN_SYS_PLL3>,
> > >>>                                   <&clk IMX8MN_AUDIO_PLL1>,
> > >>>                                   <&clk IMX8MN_AUDIO_PLL2>;
> > >>>     assigned-clock-parents =3D <&clk IMX8MN_SYS_PLL1_800M>,
> > >>>                                              <&clk IMX8MN_ARM_PLL_O=
UT>,
> > >>>                                              <&clk IMX8MN_SYS_PLL3_=
OUT>,
> > >>>                                              <&clk IMX8MN_SYS_PLL1_=
800M>;
> > >>>     assigned-clock-rates =3D <0>, <0>, <0>,
> > >>>                                          <400000000>,
> > >>>                                          <400000000>,
> > >>>                                          <600000000>,
> > >>>                                          <393216000>,
> > >>>                                          <361267200>; };
> > >>>
> > >>> The spread spectrum is not configurable on these clocks or, more
> > >>> generally, may not be configurable (only 4 PLLs have this
> > capability).
> > >>> Therefore, I need the "fsl,ssc-clocks"
> > >>
> > >> No. That's not true. You do not need it.
> > >>
> > >
> > > i.MX8M clock hardware is similar as:
> > >
> > > OSC->ANATOP->CCM
> > >
> > > ANATOP will produce PLLs.
> > > CCM use PLLs as input source.
> > >
> > > Currently there is no dedicated ANATOP driver in linux.
> > > The CCM linux driver will parse the ANATOP node and register clk_hw
> > > for the PLLs.
> >
> > I do not know what is CCM and how does it fit here. What's more, I
> > don't get driver context here. We talk about bindings.
>
>
> CCM: Clock Control Module, it accepts PLL from anatop as inputs,
> and outputs clocks to various modules, I2C, CAN, NET, SAI and ...
>
> >
> >
> > >
> > >
> > >> First, the clock inputs for this device are listed in clocks *only*.
> > >> What is no there, is not an input to the device. Including also Linu=
x
> > >> aspect (missing devlinks etc). Therefore how can you configure
> > spread
> > >> spectrum on clocks which are not connected to this device?
> > >
> > > I not understand this well, you mean
> > > add clocks =3D <xx CLK_IMX8MM_VIDEO_PLL> in the ccm dtb node?
> >
> > Yes. Let me re-iterate and please respond to this exactly comment
> > instead of ignoring it.
> >
> > How a device can care about spread spectrum of a clock which is not
> > supplied to this device?
>
> I hope we are on same page of what spread spectrum means.
> spread spectrum of a clock is the clock could produce freq in a range,
> saying [500MHz - 100KHz, 500MHz + 100KHz]. software only need
> to configure the middle frequency and choose the up/down border
> range(100KHz here) and enable spread spectrum.
>
> device: I suppose you mean the Clock Control Module(CCM) here.
> CCM does not care, it just accepts the PLL as input, and output
> divided clock to various IPs(Video here). The video IPs care about
> the spread spectrum of the clock.
>
> The clock hardware path is as below:
>
> OSC(24M) --> Anatop(produce PLL with spread spectrum) ->
> Clock Control Module(output clock to modules) -> Video IP
>
> From hardware perspective, Clock Control Module does not
> care spread spectrum. Video IP cares spread spectrum.
>
>
> >
> > Why would you care about spread spectrum of some clock which is not
> > coming to this device?
>
> device, I suppose you mean clock control module(CCM).
>
> There is no 'clocks =3D <&ccm CLK_IMX8M_VIDEO_PLL>' under ccm node.
> Because in current design, ccm is taken as producer of
> CLK_IMX8M_VIDEO_PLL, not consumer.
>
> >
> > Please address these precisely because we talk about this for weeks in
> > multiple places.
>
> Sorry for coming into this feature in late stage.
>
> Dario, thanks for working on such feature, good to see. Spread Spectrum
> is indeed good feature what makes clock quality high.

I am also excited to see the spread-spectum clocks enabled.  We've
struggled with EMC testing in the past, and I want to reevaluate at
least one board with the spread-spectrum enabled to see how it
compares.
Thank you for working on this.

adam
>
> Thanks,
> Peng.
>
> I finish with this patchset if you do not provide such
> > context.
> >
> > Best regards,
> > Krzysztof
>

