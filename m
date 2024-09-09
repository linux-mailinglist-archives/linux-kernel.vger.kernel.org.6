Return-Path: <linux-kernel+bounces-322142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1EE9724A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0519284545
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46918C357;
	Mon,  9 Sep 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="bBtrozIK"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D4513AA47
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725918383; cv=none; b=jHruRycpaAdzx8KhvNMlSYr1yJ8iZu+4SqacFQkbvRVvg5VfevvQ2sSyHdHRQC5ydWMzwpVSMwua297NpRmP40KtfMDzv/LK11HKZFy3u7dYcr6gWkIS5X2GYVxXNIIYtD+ytt/Y3de/z95y21UPOUhY5bYxaUn+E6DOifeZxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725918383; c=relaxed/simple;
	bh=nM6fWCoX1di+0MQViZg543ykFf2oNkQIUsf5k3wnNXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpH2h7mxytZ+TDBpnFJfxt1DJyTWtQ3vZ5dEnf6BV9AqhlWvVuyTQ9h+sA7RDn3nsbqJNzO5i8V9BU+CeX1SEdvgB9CtqTVmzddBcJN7DMqhchvo9nelgUMG+d7MK1w87awTQN4nV/b8qGlQrnXQit/gJM0uMs6wNaGQbxjJEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=bBtrozIK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f761461150so34171911fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 14:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1725918380; x=1726523180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h58eAOOyutx8X4vwncmQ+slvyq67BTtOg7qW508aZBY=;
        b=bBtrozIKG/zpr9FLqtF5yRSwz2o//dopLgc2bfRRhZwGx2Ye52RE8ROXqGm1cAyDRl
         3Zs5lTWMzZJuCMZaj2rV8RdFQp9SackHCxIKou0edxTbrn1CdSJESX2CT2G/8VSFS5CN
         WQsoSTSPbh/vv6sSQD6WhhpS2mjQn8/riD477HgtHsK9PUDX9OAEy6qIl5zoOlsNFJGB
         cY4T2MaGfY4gSgaOSg+3n34GMa5/nUdU342KsP8YuLrR2hZDxytAkqHjSmYM/6iUIJVY
         sGtVdwtMDbGLwspvM9a4WzqSt1NAbn4KV/XPuQhEz1NNo6bIqxwFGqDjF/VMs4Wwk3Ny
         EoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725918380; x=1726523180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h58eAOOyutx8X4vwncmQ+slvyq67BTtOg7qW508aZBY=;
        b=g5gn5BxQWxGSco4u43g8JB3G5CxhByUmd1O3U+Y3kP5YutswArxe5145HwxfYDfe1V
         hZb79FIve5XNCyEEz6OFMAtPpibweAxGtuvd6tg/PIj6T8aKvfnIxShswAanc44EQ64M
         RzZQa/lNElBLeCVeWs7pFbfwIt4KpMRHUzWlE+XfMu7w6EvxFtEra1n8f6arcW3ji+ZQ
         IGpfzp4CDEw/z+qLIerAozTWEmUZP/Z6TPgYPOB6oXD9UtieMwbJWFmfOeBdwPdS5ZyQ
         CkJsOI5zkkCwqwTbl2cKXBjhwaAD6lxFqOa0/FV2l2NGVs2TJy7Yd5QNAW5OEsspeVCm
         7HWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIFXN7QHSvARUqv2KeWCcXuKKrjP3LcL1CUs/Ccmn/oIE0qnxpox8fSREvrAa5PDwe0VqAs3rPbwjqLe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74cnW3PWrHOeylJ7X4efGWb3hwd5p9/e3evYHvSFdRnWjjeY5
	hMtwosG2fSQ/eHiRn+da1X5WGgPNyAzqzcKzuS2hW8/34tZqEzVAXIhJWympcunPCbvlhR2vFKh
	umrQzxDiWScfp/epqpD9ueeRluwqir3+Mhp+kWg==
X-Google-Smtp-Source: AGHT+IEjH3/u/TXEjoWXe2Q1DAHyvUARMeL74z3Q9298y4A1ALPxZ2Iw4jLoIipvASJ4nbuMM/siJdKogiXxoONctHU=
X-Received: by 2002:a2e:be9e:0:b0:2f3:c384:71ee with SMTP id
 38308e7fff4ca-2f75aa07bd2mr89494941fa.33.1725918378875; Mon, 09 Sep 2024
 14:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905183107.517244-1-tharvey@gateworks.com> <PAXPR04MB8459CD40E8A0925EE3396F2D889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459CD40E8A0925EE3396F2D889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 9 Sep 2024 14:46:07 -0700
Message-ID: <CAJ+vNU1UH5UNb3rEGtJ_HpsJvCAsgtqAwSfvTS9s1yM6JVad-g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8m*-venice-gw75xx: add Accelerometer device
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:14=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH] arm64: dts: imx8m*-venice-gw75xx: add
> > Accelerometer device
> >
> > The GW79xx has a LIS2DE12TR 3-axis accelerometer on the I2C bus
> > with an interrupt pin. Add it to the device-tree.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  .../boot/dts/freescale/imx8mm-venice-gw75xx.dtsi | 16
> > ++++++++++++++++  .../boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
> > | 16 ++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
> > index 5eb92005195c..417c19774b17 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
> > @@ -116,6 +116,16 @@ &i2c2 {
> >       pinctrl-0 =3D <&pinctrl_i2c2>;
> >       status =3D "okay";
> >
> > +     accelerometer@19 {
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_accel>;
> > +             compatible =3D "st,lis2de12";
> > +             reg =3D <0x19>;
>
> Nitpick:
> compatible, reg should be top.
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

Hi Peng,

Thanks, I will submit a v2

Tim

