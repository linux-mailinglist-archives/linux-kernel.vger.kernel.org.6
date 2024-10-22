Return-Path: <linux-kernel+bounces-375540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C029A9724
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0C5B21072
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B221386C9;
	Tue, 22 Oct 2024 03:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQHSm0Mo"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9FD3D994;
	Tue, 22 Oct 2024 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568010; cv=none; b=At5Q14P74tZYcTaNwCDx7QOIzLTiaGtyY5cecSzlM2MYi4VAv450zQ2iRwtbF0CyC4KgN45pY30MBB93H02q+IgVHbH6YRm5hsoq3/aALvuOa+pGYB+bZblZbPI0dqFWa7tQbeRkL8M/YxRGYMjGuvyNHp3jmx1nM3j0LBSQNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568010; c=relaxed/simple;
	bh=f8FMcW3kTHdsQ2sq/Ks5ajlsuYD3nHAtdrvmezSokMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFG7pYau3uy86iaqh/wCAyYQ7IrKM0Yl4dXk5usZzgsRC5FovpC8F1WCPRkmUZ/l+9D4qL1oTUk/Z2l3UhsHgRPwCXxVQ+f8KsVUfVAv6x9LBWG5KsbxVvSvL1BRaMBBmfF5/szcXbonqRyoZdl3u2GoXXncGwY+v1iXGgzX6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQHSm0Mo; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a39cabb9faso17730215ab.3;
        Mon, 21 Oct 2024 20:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729568007; x=1730172807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBrWx3A/TWm61QqJ+8jwCHgCv5s+0t006y+qWiK1s4Q=;
        b=MQHSm0MoW8h3Wjq+hEb/oduSB8Zx9SK4KgGMlcNfJ1zqY4ktwKt3lLyTtBC6Khl+/j
         Lwo90V2wwWBiN4xW81xJyRP/dB6Ysq1d+YpKh/yMvwi7JPDpINKeTekn2GkxTASZ9w6U
         E5uX+BYtSxANndWXn4ikrTLbdsAb4JISeKsfUB3+v8CEQqvnrZy+bLXWHo3blNcbXNsz
         +i0ry6gAPbZvTYQgNsoIdLyQ4bR5oh2EDg0OiuEyg6i6zeVgoPwoXog1YMs81+hGtUHi
         csJXL4Pi5sjMtMWSWYSOhNo9B7mFUcuG/DAhbC5799AGJRT6FYBVqrNQ6xDHcYz5JKzp
         9+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729568007; x=1730172807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBrWx3A/TWm61QqJ+8jwCHgCv5s+0t006y+qWiK1s4Q=;
        b=VJJtgH6IrR/AXTPDLQTax3XcoGWyjKAtiW/GW4o0BTFi6rKY/ERld64dG3Sy1d6I5m
         pFEn84CvCc7izqki2kPh2jLLqQ7+YQSkqiV/lYMg2Asp8+Oj8H/oNk//0/2cY/UowIr6
         FCJha0+WW4ypmxsECTk2kl6XSu0EktDx7k/VZKJmXRPqNyAvyQVmu8bNM1iMmhyhZfUI
         i/oAK2nKNGQST6uPeoOkeXr0aoNT61hvaC6SoKIjt46UVMeQa/1CQqAx4+ScWyldOymr
         wcFQOVsMO1dPb/sipPvixuJ046NkNmZYuDV8g6TAuVvZCK1mPFZ8w1XkPmQnn+CiiE8I
         80UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS41hG9LbaLcS5e8NuX3DmTz/IpmVcz/96hbB8Qbdo2/LmgTRv5WjzV0ZP0NX3La5Z/Ei3306QJQJ4@vger.kernel.org, AJvYcCWkkpBi22fkWQUu88Lr1kh1Rut00MqF0aH5nDTjgdqvaSSJB8jyyj/RFx8vsbvLLJYsh7vk4oVqr7PltjpL@vger.kernel.org
X-Gm-Message-State: AOJu0YxeOJ4NcEywUha6wiZ/ywLc5KDYsjmvfUHUrFdqlUKokyWurEwN
	fr60rjFb7lGPui46Ck9EQ3S6Ki7blXvyzLLeMEunvlvNHinLo4KRXwBld2+WFKnNGRjQbToTyjs
	5TKy6cMMUm6eOf6dVmj9GX88SnEI=
X-Google-Smtp-Source: AGHT+IG44EfLn1wIhKNAqADigwS1jE02vdGb8GZZ4g/bQybQy8disKUIwcfTQzDzvhC3K+Xx+H/WepaJwiYsmMcIGhA=
X-Received: by 2002:a05:6e02:19ca:b0:3a2:f7b1:2f89 with SMTP id
 e9e14a558f8ab-3a4cd7eb5b3mr11747205ab.18.1729568007442; Mon, 21 Oct 2024
 20:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729072591-10439-1-git-send-email-shengjiu.wang@nxp.com>
 <1729072591-10439-2-git-send-email-shengjiu.wang@nxp.com> <ZxcZeC8cZqG2rIxB@dragon>
In-Reply-To: <ZxcZeC8cZqG2rIxB@dragon>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 22 Oct 2024 11:33:16 +0800
Message-ID: <CAA+D8APrXsXAvUm5=W9s72qAi8XFSnR-rbOoaQBJYo87sFzeFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: imx8ulp: Add audio device nodes
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:19=E2=80=AFAM Shawn Guo <shawnguo2@yeah.net> wro=
te:
>
> On Wed, Oct 16, 2024 at 05:56:29PM +0800, Shengjiu Wang wrote:
> > Add edma1, sai4, sai5 device nodes bus of in per_bridge3.
> > Add edma2, sai6, sai7, spdif device nodes in bus of
> > per_bridge5.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 214 +++++++++++++++++++++
> >  1 file changed, 214 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/bo=
ot/dts/freescale/imx8ulp.dtsi
> > index e32d5afcf4a9..3223f1ac2051 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > @@ -212,6 +212,71 @@ per_bridge3: bus@29000000 {
> >                       #size-cells =3D <1>;
> >                       ranges;
> >
> > +                     edma1: dma-controller@29010000 {
> > +                             compatible =3D "fsl,imx8ulp-edma";
> > +                             reg =3D <0x29010000 0x210000>;
> > +                             #dma-cells =3D <3>;
> > +                             dma-channels =3D <32>;
> > +                             interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_=
HIGH>,
> > +                                          <GIC_SPI 1 IRQ_TYPE_LEVEL_HI=
GH>,
> > +                                          <GIC_SPI 2 IRQ_TYPE_LEVEL_HI=
GH>,
> > +                                          <GIC_SPI 3 IRQ_TYPE_LEVEL_HI=
GH>,
> > +                                          <GIC_SPI 4 IRQ_TYPE_LEVEL_HI=
GH>,
> > +                                          <GIC_SPI 5 IRQ_TYPE_LEVEL_HI=
GH>,
> > +                                          <GIC_SPI 6 IRQ_TYPE_LEVEL_HI=
GH>,
> > +                                          <GIC_SPI 7 IRQ_TYPE_LEVEL_HI=
GH>,
> > +                                          <GIC_SPI 8 IRQ_TYPE_LEVEL_HI=
GH>,
> > +                                          <GIC_SPI 9 IRQ_TYPE_LEVEL_HI=
GH>,
> > +                                          <GIC_SPI 10 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 11 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 12 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 13 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 14 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 15 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 16 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 17 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 18 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 19 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 20 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 21 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 22 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 23 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 24 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 25 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 26 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 27 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 28 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 29 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 30 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 31 IRQ_TYPE_LEVEL_H=
IGH>;
> > +                             clocks =3D <&pcc3 IMX8ULP_CLK_DMA1_MP>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH0>, <&p=
cc3 IMX8ULP_CLK_DMA1_CH1>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH2>, <&p=
cc3 IMX8ULP_CLK_DMA1_CH3>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH4>, <&p=
cc3 IMX8ULP_CLK_DMA1_CH5>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH6>, <&p=
cc3 IMX8ULP_CLK_DMA1_CH7>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH8>, <&p=
cc3 IMX8ULP_CLK_DMA1_CH9>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH10>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH11>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH12>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH13>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH14>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH15>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH16>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH17>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH18>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH19>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH20>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH21>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH22>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH23>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH24>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH25>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH26>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH27>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH28>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH29>,
> > +                                     <&pcc3 IMX8ULP_CLK_DMA1_CH30>, <&=
pcc3 IMX8ULP_CLK_DMA1_CH31>;
> > +                             clock-names =3D "dma", "ch00","ch01", "ch=
02", "ch03",
> > +                                             "ch04", "ch05", "ch06", "=
ch07",
> > +                                             "ch08", "ch09", "ch10", "=
ch11",
> > +                                             "ch12", "ch13", "ch14", "=
ch15",
> > +                                             "ch16", "ch17", "ch18", "=
ch19",
> > +                                             "ch20", "ch21", "ch22", "=
ch23",
> > +                                             "ch24", "ch25", "ch26", "=
ch27",
> > +                                             "ch28", "ch29", "ch30", "=
ch31";
> > +                             status =3D "okay";
> > +                     };
> > +
> >                       mu: mailbox@29220000 {
> >                               compatible =3D "fsl,imx8ulp-mu";
> >                               reg =3D <0x29220000 0x10000>;
> > @@ -442,6 +507,36 @@ lpuart7: serial@29870000 {
> >                               status =3D "disabled";
> >                       };
> >
> > +                     sai4: sai@29880000 {
> > +                             compatible =3D "fsl,imx8ulp-sai";
> > +                             reg =3D <0x29880000 0x10000>;
> > +                             interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             clocks =3D <&pcc4 IMX8ULP_CLK_SAI4>, <&cg=
c1 IMX8ULP_CLK_DUMMY>,
> > +                                      <&cgc1 IMX8ULP_CLK_SAI4_SEL>, <&=
cgc1 IMX8ULP_CLK_DUMMY>,
> > +                                      <&cgc1 IMX8ULP_CLK_DUMMY>;
> > +                             clock-names =3D "bus", "mclk0", "mclk1", =
"mclk2", "mclk3";
> > +                             dmas =3D <&edma1 67 0 1>, <&edma1 68 0 0>=
;
> > +                             dma-names =3D "rx", "tx";
> > +                             #sound-dai-cells =3D <0>;
> > +                             fsl,dataline =3D <0 0x03 0x03>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     sai5: sai@29890000 {
> > +                             compatible =3D "fsl,imx8ulp-sai";
> > +                             reg =3D <0x29890000 0x10000>;
> > +                             interrupts =3D <GIC_SPI 109 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             clocks =3D <&pcc4 IMX8ULP_CLK_SAI5>, <&cg=
c1 IMX8ULP_CLK_DUMMY>,
> > +                                      <&cgc1 IMX8ULP_CLK_SAI5_SEL>, <&=
cgc1 IMX8ULP_CLK_DUMMY>,
> > +                                      <&cgc1 IMX8ULP_CLK_DUMMY>;
> > +                             clock-names =3D "bus", "mclk0", "mclk1", =
"mclk2", "mclk3";
> > +                             dmas =3D <&edma1 69 0 1>, <&edma1 70 0 0>=
;
> > +                             dma-names =3D "rx", "tx";
> > +                             #sound-dai-cells =3D <0>;
> > +                             fsl,dataline =3D <0 0x0f 0x0f>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> >                       iomuxc1: pinctrl@298c0000 {
> >                               compatible =3D "fsl,imx8ulp-iomuxc1";
> >                               reg =3D <0x298c0000 0x10000>;
> > @@ -614,6 +709,71 @@ per_bridge5: bus@2d800000 {
> >                       #size-cells =3D <1>;
> >                       ranges;
> >
> > +                     edma2: dma-controller@2d800000 {
> > +                             compatible =3D "fsl,imx8ulp-edma";
> > +                             reg =3D <0x2d800000 0x210000>;
> > +                             #dma-cells =3D <3>;
> > +                             dma-channels =3D <32>;
> > +                             interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL=
_HIGH>,
> > +                                          <GIC_SPI 33 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 34 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 35 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 36 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 37 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 38 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 39 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 40 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 41 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 42 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 43 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 44 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 45 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 46 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 47 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 48 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 49 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 50 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 51 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 52 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 53 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 54 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 55 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 56 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 57 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 58 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 59 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 60 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 61 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 62 IRQ_TYPE_LEVEL_H=
IGH>,
> > +                                          <GIC_SPI 63 IRQ_TYPE_LEVEL_H=
IGH>;
> > +                             clocks =3D <&pcc5 IMX8ULP_CLK_DMA2_MP>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH0>, <&p=
cc5 IMX8ULP_CLK_DMA2_CH1>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH2>, <&p=
cc5 IMX8ULP_CLK_DMA2_CH3>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH4>, <&p=
cc5 IMX8ULP_CLK_DMA2_CH5>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH6>, <&p=
cc5 IMX8ULP_CLK_DMA2_CH7>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH8>, <&p=
cc5 IMX8ULP_CLK_DMA2_CH9>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH10>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH11>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH12>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH13>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH14>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH15>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH16>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH17>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH18>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH19>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH20>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH21>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH22>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH23>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH24>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH25>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH26>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH27>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH28>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH29>,
> > +                                     <&pcc5 IMX8ULP_CLK_DMA2_CH30>, <&=
pcc5 IMX8ULP_CLK_DMA2_CH31>;
> > +                             clock-names =3D "dma", "ch00","ch01", "ch=
02", "ch03",
> > +                                             "ch04", "ch05", "ch06", "=
ch07",
> > +                                             "ch08", "ch09", "ch10", "=
ch11",
> > +                                             "ch12", "ch13", "ch14", "=
ch15",
> > +                                             "ch16", "ch17", "ch18", "=
ch19",
> > +                                             "ch20", "ch21", "ch22", "=
ch23",
> > +                                             "ch24", "ch25", "ch26", "=
ch27",
> > +                                             "ch28", "ch29", "ch30", "=
ch31";
> > +                             status =3D "okay";
>
> The "okay" status is usually used to flip "disabled".  It doesn't seem
> really needed here?
>
Ok, will remove it.

Best regards
Shengjiu Wang

> Shawn
>
> > +                     };
> > +
> >                       cgc2: clock-controller@2da60000 {
> >                               compatible =3D "fsl,imx8ulp-cgc2";
> >                               reg =3D <0x2da60000 0x10000>;
> > @@ -626,6 +786,60 @@ pcc5: clock-controller@2da70000 {
> >                               #clock-cells =3D <1>;
> >                               #reset-cells =3D <1>;
> >                       };
> > +
> > +                     sai6: sai@2da90000 {
> > +                             compatible =3D "fsl,imx8ulp-sai";
> > +                             reg =3D <0x2da90000 0x10000>;
> > +                             interrupts =3D <GIC_SPI 110 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             clocks =3D <&pcc5 IMX8ULP_CLK_SAI6>, <&cg=
c1 IMX8ULP_CLK_DUMMY>,
> > +                                      <&cgc2 IMX8ULP_CLK_SAI6_SEL>, <&=
cgc1 IMX8ULP_CLK_DUMMY>,
> > +                                      <&cgc1 IMX8ULP_CLK_DUMMY>;
> > +                             clock-names =3D "bus", "mclk0", "mclk1", =
"mclk2", "mclk3";
> > +                             dmas =3D <&edma2 71 0 1>, <&edma2 72 0 0>=
;
> > +                             dma-names =3D "rx", "tx";
> > +                             #sound-dai-cells =3D <0>;
> > +                             fsl,dataline =3D <0 0x0f 0x0f>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     sai7: sai@2daa0000 {
> > +                             compatible =3D "fsl,imx8ulp-sai";
> > +                             reg =3D <0x2daa0000 0x10000>;
> > +                             interrupts =3D <GIC_SPI 111 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             clocks =3D <&pcc5 IMX8ULP_CLK_SAI7>, <&cg=
c1 IMX8ULP_CLK_DUMMY>,
> > +                                      <&cgc2 IMX8ULP_CLK_SAI7_SEL>, <&=
cgc1 IMX8ULP_CLK_DUMMY>,
> > +                                      <&cgc1 IMX8ULP_CLK_DUMMY>;
> > +                             clock-names =3D "bus", "mclk0", "mclk1", =
"mclk2", "mclk3";
> > +                             dmas =3D <&edma2 73 0 1>, <&edma2 74 0 0>=
;
> > +                             dma-names =3D "rx", "tx";
> > +                             #sound-dai-cells =3D <0>;
> > +                             fsl,dataline =3D <0 0x0f 0x0f>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     spdif: spdif@2dab0000 {
> > +                             compatible =3D "fsl,imx8ulp-spdif";
> > +                             reg =3D <0x2dab0000 0x10000>;
> > +                             interrupts =3D <GIC_SPI 112 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             clocks =3D <&pcc5 IMX8ULP_CLK_SPDIF>, /* =
core */
> > +                                      <&sosc>, /* 0, extal */
> > +                                      <&cgc2 IMX8ULP_CLK_SPDIF_SEL>, /=
* 1, tx */
> > +                                      <&cgc1 IMX8ULP_CLK_DUMMY>, /* 2,=
 tx1 */
> > +                                      <&cgc1 IMX8ULP_CLK_DUMMY>, /* 3,=
 tx2 */
> > +                                      <&cgc1 IMX8ULP_CLK_DUMMY>, /* 4,=
 tx3 */
> > +                                      <&pcc5 IMX8ULP_CLK_SPDIF>, /* 5,=
 sys */
> > +                                      <&cgc1 IMX8ULP_CLK_DUMMY>, /* 6,=
 tx4 */
> > +                                      <&cgc1 IMX8ULP_CLK_DUMMY>, /* 7,=
 tx5 */
> > +                                      <&cgc1 IMX8ULP_CLK_DUMMY>; /* sp=
ba */
> > +                             clock-names =3D "core", "rxtx0",
> > +                                           "rxtx1", "rxtx2",
> > +                                           "rxtx3", "rxtx4",
> > +                                           "rxtx5", "rxtx6",
> > +                                           "rxtx7", "spba";
> > +                             dmas =3D <&edma2 75 0 5>, <&edma2 76 0 4>=
;
> > +                             dma-names =3D "rx", "tx";
> > +                             status =3D "disabled";
> > +                     };
> >               };
> >
> >               gpiod: gpio@2e200000 {
> > --
> > 2.34.1
> >
>

