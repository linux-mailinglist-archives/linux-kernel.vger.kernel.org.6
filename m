Return-Path: <linux-kernel+bounces-538714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE514A49C45
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01D1174D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BC32702A2;
	Fri, 28 Feb 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyCtnUM/"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF00226FDB2;
	Fri, 28 Feb 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753686; cv=none; b=ruku0xS0a0Gzw+63WzNxDgdnGifuFdZlwOC5TchI9lfMFqV7m0Sm0U9nMwsqLK1db44W6QmYiL1PJp4VqucDerC60LGEiG3U5TFJhqlJd0kMvH1NtCzar4Lpb9RHinz5ergce6uURpC45mAc73O9E8neLrgggbtPx9S1+KzYja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753686; c=relaxed/simple;
	bh=8gR3kTA33I5I/8QsssQ51+QpIy391UMo9xZyprRhoB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfZqEIFFfnR2Q+mS9AfbCaBAMtXbrRprVDodnFVahjuhwmoczH0HQZluwQRdb4yCeaw6MyWibydO6uhLWK5B7yjPyMPUDbIO4ISaUml82F/9qOgZAMBeymbShPy+skTcpUyPUNS7tUV7PpTaJkRB80rynHlB6jdXhNA8DjOyZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyCtnUM/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390f5556579so190899f8f.1;
        Fri, 28 Feb 2025 06:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740753681; x=1741358481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXw4E4gD02U4RYbEwh1nSCOW2IsRMwqOwQpaC/IsRn8=;
        b=lyCtnUM/UD8NUZfxZ8xNy19w3rfAiaJXmjPdkynDvjpiuEzAlRsEa/InBds4r6k0cZ
         barmGPvXlQNIl64Mix+iSdXzfC0zWx14Z+85fPQkFYW6+pE727LvZNe8yvUrTcICEQ88
         JoIG0NV35FM6iSW5H4QO/q7y0iefUmaFRGdAwXDu61Br0opgKwigqs79I6N60H25YaBH
         Fbzy/Kw5yuGtP6P2Gb5QMyojjOzJW86oj73R+syLPSSFphE8sosfEdTx4CBaplvwwLz2
         fyuNY19K7KjGkTVyROXc8jBUdvKckIKvU6ijCioZxRN83O8mHof4EHPxwkz1h9OEBWS4
         owDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740753681; x=1741358481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXw4E4gD02U4RYbEwh1nSCOW2IsRMwqOwQpaC/IsRn8=;
        b=By6MiJaFQaAAZ9riuf2KzwESoSgpMChZ3XP8UssM82/SNPGiXqf4niyz7MAo6yU6rN
         xOS84zVPE+squMJWSSp+dPvhQ8fx8OLUP8ZYKizve7QjL2jF5JzBduvPmUkllOrIVKV7
         gWP+1PNjM4juBWsrS/Q+Bzmpf7KBgiPwk49MT9tg+sRgzg0fmy2Q6Vu6GVfb20uXo0fV
         MW5b1iC6t+Jh3HNG38diyu00NeFerfZK82EG2gxDG3o8tBvNpxPXZywAhXwirxPTot8W
         sHfSsJMtlEWTLg7OeVwi0sG44MFID7sdERb45+fTEouDf/hWZs86XM0U7fvnOoERSbkl
         TyJg==
X-Forwarded-Encrypted: i=1; AJvYcCVQp6uSfR4Jeh3QIVfLb8/Z5sdTEK6PbqtMRi4qm5rE/J4udqD9Yyg6hbf0M6HthQBZLfwYg22IXxHh@vger.kernel.org, AJvYcCWsz3It8LcUEFxB4wHPNvPFY+lJ787ygaE5+1U/5dK+tpNx0T6ZS7Qi0pMu8MknZhHxvC4vjj0c+Xo8Dm/+@vger.kernel.org, AJvYcCXKRMusIaIEXqcCW4DxFhtwcvIJvl1XDylDVJ5+U9CncXyWhIfwNh/NIlWMAHooYZVNBhZwxZQdMdYZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJVAZApaNZn218MwbBlGWfp/03C15omDTpasrgbeMFRdz4GsK
	lJblR8tJz44MdlyfBRjB1pI9AjPdxGUM1zwLdWYlFZEJK0Yzu+6n47XAseqG
X-Gm-Gg: ASbGncvdtviyQmpysys5+ydk8jWHFsQJZUaZZJtjo4p8KHaMV57xT9BcDFAmJR4NMup
	qNxzEPnx/VliP5jnZ/pUpRAjGiIgTqj+Arp+37+ZCk1/+httYCgjvzcoi4vTKDqPJrpUa0WJMl4
	+mHmEeFLAs1VUNHfxyCJfWHSiXlCKR5j+MABnJDWOrivzWN267yRoZnya08VdgXlNN5Mogl/oBB
	k9eh7jU5gmi6yZULBXjoyteNm8A23PTJRE0MWHdzLNYqyVzYjniXg3h7NBru9GuapKrTFrwzmrJ
	ODqWu2nIPIoABwUbg9VAGKo9s4cX2FtQW6nABkvhQTyaHUCOGDufDkO/Si4ksmWsE3GsPL9RM45
	EKg==
X-Google-Smtp-Source: AGHT+IGqKBs8okVMmjyuYLbUU0uXb0A5b1TLNrKtkaIVQgn+1KK6RacfTz9tNC1cVdu7r+BA3Z5kbw==
X-Received: by 2002:a5d:47cd:0:b0:38f:4d91:c118 with SMTP id ffacd0b85a97d-390ec7d2d52mr2995613f8f.28.1740753680772;
        Fri, 28 Feb 2025 06:41:20 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28b285sm60059125e9.33.2025.02.28.06.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:41:20 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] clk: sunxi-ng: a523: add bus clock gates
Date: Fri, 28 Feb 2025 15:41:19 +0100
Message-ID: <1995552.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20250228140458.2e86fd03@donnerap.manchester.arm.com>
References:
 <20250214125359.5204-1-andre.przywara@arm.com>
 <869956354.0ifERbkFSE@jernej-laptop>
 <20250228140458.2e86fd03@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 28. februar 2025 ob 15:04:58 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> On Tue, 18 Feb 2025 21:12:33 +0100
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi,
>=20
> > Dne petek, 14. februar 2025 ob 13:53:56 Srednjeevropski standardni =C4=
=8Das je Andre Przywara napisal(a):
> > > Add the various bus clock gates that control access to the devices'
> > > register interface.
> > > These clocks are each just one bit, typically the lower bits in some =
"BGR"
> > > (Bus Gate / Reset) registers, for each device group: one for all UART=
s,
> > > one for all SPI interfaces, and so on.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 295 +++++++++++++++++++++++=
+-
> > >  1 file changed, 294 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sun=
xi-ng/ccu-sun55i-a523.c
> > > index 6a4340f1fd041..fbed9b2b3b2f9 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > > @@ -350,6 +350,8 @@ static SUNXI_CCU_M_DATA_WITH_MUX(ahb_clk, "ahb", =
ahb_apb0_parents, 0x510,
> > >  				 0, 5,		/* M */
> > >  				 24, 2,		/* mux */
> > >  				 0);
> > > +static const struct clk_hw *ahb_hws[] =3D { &ahb_clk.common.hw };
> > > +
> > >  static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ahb_apb0_parents,=
 0x520,
> > >  				 0, 5,		/* M */
> > >  				 24, 2,	/* mux */
> > > @@ -367,10 +369,11 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb=
1", apb1_parents, 0x524,
> > >  				 0, 5,		/* M */
> > >  				 24, 3,		/* mux */
> > >  				 0);
> > > +static const struct clk_hw *apb1_hws[] =3D { &apb1_clk.common.hw };
> > > =20
> > > =20
> > >  /*******************************************************************=
*******
> > > - *                          mod clocks                              =
      *
> > > + *                          mod clocks with gates                   =
      *
> > >   *******************************************************************=
*******/
> > > =20
> > >  static const struct clk_hw *de_parents[] =3D {
> > > @@ -386,6 +389,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(de_clk, "de",=
 de_parents, 0x600,
> > >  				    BIT(31),	/* gate */
> > >  				    CLK_SET_RATE_PARENT);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_de_clk, "bus-de", ahb_hws, 0x60c, BIT(=
0), 0);
> > > +
> > >  static const struct clk_hw *di_parents[] =3D {
> > >  	&pll_periph0_300M_clk.hw,
> > >  	&pll_periph0_400M_clk.hw,
> > > @@ -399,6 +404,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(di_clk, "di",=
 di_parents, 0x620,
> > >  				    BIT(31),	/* gate */
> > >  				    CLK_SET_RATE_PARENT);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_di_clk, "bus-di", ahb_hws, 0x62c, BIT(=
0), 0);
> > > +
> > >  static const struct clk_hw *g2d_parents[] =3D {
> > >  	&pll_periph0_400M_clk.hw,
> > >  	&pll_periph0_300M_clk.hw,
> > > @@ -412,6 +419,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(g2d_clk, "g2d=
", g2d_parents, 0x630,
> > >  				    BIT(31),	/* gate */
> > >  				    0);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_g2d_clk, "bus-g2d", ahb_hws, 0x63c, BI=
T(0), 0);
> > > +
> > >  static const struct clk_hw *gpu_parents[] =3D {
> > >  	&pll_gpu_clk.common.hw,
> > >  	&pll_periph0_800M_clk.common.hw,
> > > @@ -427,6 +436,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(gpu_clk, "gpu=
", gpu_parents, 0x670,
> > >  				    BIT(31),	/* gate */
> > >  				    0);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_gpu_clk, "bus-gpu", ahb_hws, 0x67c, BI=
T(0), 0);
> > > +
> > >  static const struct clk_parent_data ce_parents[] =3D {
> > >  	{ .fw_name =3D "hosc" },
> > >  	{ .hw =3D &pll_periph0_480M_clk.common.hw },
> > > @@ -439,6 +450,10 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ce_clk, "c=
e", ce_parents, 0x680,
> > >  				       BIT(31),	/* gate */
> > >  				       0);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_ce_clk, "bus-ce", ahb_hws, 0x68c, BIT(=
0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_ce_sys_clk, "bus-ce-sys", ahb_hws, 0x6=
8c,
> > > +			  BIT(1), 0);
> > > +
> > >  static const struct clk_hw *ve_parents[] =3D {
> > >  	&pll_ve_clk.common.hw,
> > >  	&pll_periph0_480M_clk.common.hw,
> > > @@ -451,6 +466,16 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve"=
, ve_parents, 0x690,
> > >  				    BIT(31),	/* gate */
> > >  				    CLK_SET_RATE_PARENT);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_ve_clk, "bus-ve", ahb_hws, 0x69c, BIT(=
0), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_dma_clk, "bus-dma", ahb_hws, 0x70c, BI=
T(0), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_msgbox_clk, "bus-msgbox", ahb_hws, 0x7=
1c,
> > > +			  BIT(0), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_spinlock_clk, "bus-spinlock", ahb_hws,=
 0x72c,
> > > +			  BIT(0), 0); =20
> >=20
> > msgbox and spinlock probably needs to be marked as critical? Crust need=
s that
> > for communication with TF-A.
>=20
> Do they? I don't see this being done on any of the other SoCs that use
> crust?
> I would like to leave it like this for now, we can fix this later (and
> backport to stable) if we need so, I think?

Sure, it can be changed later.

>=20
> >=20
> > > +
> > >  static const struct clk_parent_data hstimer_parents[] =3D {
> > >  	{ .fw_name =3D "hosc" },
> > >  	{ .fw_name =3D "iosc" },
> > > @@ -510,6 +535,15 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer5_=
clk, "hstimer5",
> > >  				       BIT(31),	/* gate */
> > >  				       CLK_SET_RATE_PARENT);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_hstimer_clk, "bus-hstimer", ahb_hws, 0=
x74c,
> > > +			  BIT(0), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_dbg_clk, "bus-dbg", ahb_hws, 0x78c,
> > > +			  BIT(0), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_pwm0_clk, "bus-pwm0", apb1_hws, 0x7ac,=
 BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_pwm1_clk, "bus-pwm1", apb1_hws, 0x7ac,=
 BIT(1), 0);
> > > +
> > >  static const struct clk_parent_data iommu_parents[] =3D {
> > >  	{ .hw =3D &pll_periph0_600M_clk.hw },
> > >  	{ .hw =3D &pll_ddr0_clk.common.hw },
> > > @@ -525,6 +559,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(iommu_clk, =
"iommu", iommu_parents, 0x7b0,
> > >  				      BIT(31),	/* gate */
> > >  				      CLK_SET_RATE_PARENT);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_iommu_clk, "bus-iommu", apb0_hws, 0x7b=
c,
> > > +			  BIT(0), 0);
> > > +
> > >  static const struct clk_hw *dram_parents[] =3D {
> > >  	&pll_ddr0_clk.common.hw,
> > >  	&pll_periph0_600M_clk.hw,
> > > @@ -541,6 +578,22 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(dram_clk, "d=
ram", dram_parents, 0x800,
> > >  static CLK_FIXED_FACTOR_HW(mbus_clk, "mbus",
> > >  			   &dram_clk.common.hw, 4, 1, 0);
> > > =20
> > > +static SUNXI_CCU_GATE_HW(mbus_dma_clk, "mbus-dma", &mbus_clk.hw,
> > > +			 0x804, BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HW(mbus_ve_clk, "mbus-ve", &mbus_clk.hw,
> > > +			 0x804, BIT(1), 0);
> > > +static SUNXI_CCU_GATE_HW(mbus_ce_clk, "mbus-ce", &mbus_clk.hw,
> > > +			 0x804, BIT(2), 0);
> > > +static SUNXI_CCU_GATE_HW(mbus_nand_clk, "mbus-nand", &mbus_clk.hw,
> > > +			 0x804, BIT(5), 0);
> > > +static SUNXI_CCU_GATE_HW(mbus_usb3_clk, "mbus-usb3", &mbus_clk.hw,
> > > +			 0x804, BIT(6), 0);
> > > +static SUNXI_CCU_GATE_HW(mbus_csi_clk, "mbus-csi", &mbus_clk.hw,
> > > +			 0x804, BIT(8), 0); =20
> >=20
> > Missing several MBUS gates. Check T527 manual.
>=20
> Right, I added isp and gmac1. I did not model the bits in the upper half,
> I don't understand what they are for, really, and they are enabled on
> reset.

Ok. BSP actually switches them, but they can be coupled together, if needed.

Best regards,
Jernej

>=20
> >=20
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_dram_clk, "bus-dram", ahb_hws, 0x80c,
> > > +			  BIT(0), CLK_IS_CRITICAL);
> > > +
> > >  static const struct clk_parent_data nand_mmc_parents[] =3D {
> > >  	{ .fw_name =3D "hosc" },
> > >  	{ .hw =3D &pll_periph0_400M_clk.hw },
> > > @@ -563,6 +616,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand1_clk, =
"nand1", nand_mmc_parents,
> > >  				    BIT(31),	/* gate */
> > >  				    0);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_nand_clk, "bus-nand", ahb_hws, 0x82c,
> > > +			  BIT(0), 0);
> > > +
> > >  static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc0_clk, "mmc0", nand_mmc=
_parents,
> > >  					   0x830,
> > >  					   0, 5,	/* M */
> > > @@ -598,6 +654,39 @@ static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc2_c=
lk, "mmc2", mmc2_parents,
> > >  					   2,		/* post div */
> > >  					   0, CCU_FEATURE_DUAL_DIV);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_mmc0_clk, "bus-mmc0", ahb_hws, 0x84c, =
BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_mmc1_clk, "bus-mmc1", ahb_hws, 0x84c, =
BIT(1), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_mmc2_clk, "bus-mmc2", ahb_hws, 0x84c, =
BIT(2), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_sysdap_clk, "bus-sysdap", apb1_hws, 0x=
88c,
> > > +			  BIT(0), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_uart0_clk, "bus-uart0", apb1_hws, 0x90=
c,
> > > +			  BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_uart1_clk, "bus-uart1", apb1_hws, 0x90=
c,
> > > +			  BIT(1), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_uart2_clk, "bus-uart2", apb1_hws, 0x90=
c,
> > > +			  BIT(2), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_uart3_clk, "bus-uart3", apb1_hws, 0x90=
c,
> > > +			  BIT(3), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_uart4_clk, "bus-uart4", apb1_hws, 0x90=
c,
> > > +			  BIT(4), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_uart5_clk, "bus-uart5", apb1_hws, 0x90=
c,
> > > +			  BIT(5), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_uart6_clk, "bus-uart6", apb1_hws, 0x90=
c,
> > > +			  BIT(6), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_uart7_clk, "bus-uart7", apb1_hws, 0x90=
c,
> > > +			  BIT(7), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_i2c0_clk, "bus-i2c0", apb1_hws, 0x91c,=
 BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_i2c1_clk, "bus-i2c1", apb1_hws, 0x91c,=
 BIT(1), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_i2c2_clk, "bus-i2c2", apb1_hws, 0x91c,=
 BIT(2), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_i2c3_clk, "bus-i2c3", apb1_hws, 0x91c,=
 BIT(3), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_i2c4_clk, "bus-i2c4", apb1_hws, 0x91c,=
 BIT(4), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_i2c5_clk, "bus-i2c5", apb1_hws, 0x91c,=
 BIT(5), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_can_clk, "bus-can", apb1_hws, 0x92c, B=
IT(0), 0);
> > > +
> > >  static const struct clk_parent_data spi_parents[] =3D {
> > >  	{ .fw_name =3D "hosc" },
> > >  	{ .hw =3D &pll_periph0_300M_clk.hw },
> > > @@ -630,6 +719,11 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spifc_clk=
, "spifc", nand_mmc_parents,
> > >  				       24, 3,	/* mux */
> > >  				       BIT(31),	/* gate */
> > >  				       0);
> > > +static SUNXI_CCU_GATE_HWS(bus_spi0_clk, "bus-spi0", ahb_hws, 0x96c, =
BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_spi1_clk, "bus-spi1", ahb_hws, 0x96c, =
BIT(1), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_spi2_clk, "bus-spi2", ahb_hws, 0x96c, =
BIT(2), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_spifc_clk, "bus-spifc", ahb_hws, 0x96c,
> > > +			  BIT(3), 0);
> > > =20
> > >  static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac0_25M_clk, "emac0-25M",
> > >  				      pll_periph0_150M_hws,
> > > @@ -637,6 +731,10 @@ static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac0_25M_=
clk, "emac0-25M",
> > >  static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac1_25M_clk, "emac1-25M",
> > >  				      pll_periph0_150M_hws,
> > >  				      0x974, BIT(31) | BIT(30), 6, 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_emac0_clk, "bus-emac0", ahb_hws, 0x97c,
> > > +			  BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_emac1_clk, "bus-emac1", ahb_hws, 0x98c,
> > > +			  BIT(0), 0);
> > > =20
> > >  static const struct clk_parent_data ir_rx_parents[] =3D {
> > >  	{ .fw_name =3D "losc" },
> > > @@ -648,6 +746,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ir_rx_clk, =
"ir-rx", ir_rx_parents, 0x990,
> > >  				      24, 1,	/* mux */
> > >  				      BIT(31),	/* gate */
> > >  				      0);
> > > +static SUNXI_CCU_GATE_HWS(bus_ir_rx_clk, "bus-ir-rx", apb0_hws, 0x99=
c,
> > > +			  BIT(0), 0);
> > > +
> > >  static const struct clk_parent_data ir_tx_ledc_parents[] =3D {
> > >  	{ .fw_name =3D "hosc" },
> > >  	{ .hw =3D &pll_periph1_600M_clk.hw },
> > > @@ -658,6 +759,8 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ir_tx_clk, =
"ir-tx", ir_tx_ledc_parents,
> > >  				      24, 1,	/* mux */
> > >  				      BIT(31),	/* gate */
> > >  				      0);
> > > +static SUNXI_CCU_GATE_HWS(bus_ir_tx_clk, "bus-ir-tx", apb0_hws, 0x9c=
c,
> > > +			  BIT(0), 0);
> > > =20
> > >  static SUNXI_CCU_M_WITH_GATE(gpadc0_clk, "gpadc0", "hosc", 0x9e0,
> > >  				 0, 5,		/* M */
> > > @@ -667,6 +770,12 @@ static SUNXI_CCU_M_WITH_GATE(gpadc1_clk, "gpadc1=
", "hosc", 0x9e4,
> > >  				 0, 5,		/* M */
> > >  				 BIT(31),	/* gate */
> > >  				 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_gpadc0_clk, "bus-gpadc0", ahb_hws, 0x9=
ec,
> > > +			  BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_gpadc1_clk, "bus-gpadc1", ahb_hws, 0x9=
ec,
> > > +			  BIT(1), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_ths_clk, "bus-ths", apb0_hws, 0x9fc, B=
IT(0), 0);
> > > =20
> > >  /*
> > >   * The first parent is a 48 MHz input clock divided by 4. That 48 MH=
z clock is
> > > @@ -720,6 +829,18 @@ static struct ccu_mux usb_ohci1_clk =3D {
> > >  	},
> > >  };
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_ohci0_clk, "bus-ohci0", ahb_hws, 0xa8c,
> > > +			  BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_ohci1_clk, "bus-ohci1", ahb_hws, 0xa8c,
> > > +			  BIT(1), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_ehci0_clk, "bus-ehci0", ahb_hws, 0xa8c,
> > > +			  BIT(4), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_ehci1_clk, "bus-ehci1", ahb_hws, 0xa8c,
> > > +			  BIT(5), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_otg_clk, "bus-otg", ahb_hws, 0xa8c, BI=
T(8), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_lradc_clk, "bus-lradc", apb0_hws, 0xa9=
c,
> > > +			  BIT(0), 0);
> > > =20
> > >  static const struct clk_parent_data losc_hosc_parents[] =3D {
> > >  	{ .fw_name =3D "hosc" },
> > > @@ -733,6 +854,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(pcie_aux_cl=
k, "pcie-aux",
> > >  				      BIT(31),	/* gate */
> > >  				      0);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_dpss_top_clk, "bus-dpss-top", ahb_hws,=
 0xabc,
> > > +			  BIT(0), 0);
> > > +
> > >  static SUNXI_CCU_GATE_DATA(hdmi_24M_clk, "hdmi-24M", osc24M, 0xb04, =
BIT(31), 0);
> > > =20
> > >  /* TODO: add mux between 32kOSC and PERIPH0/18750 */
> > > @@ -750,6 +874,8 @@ static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_cec_clk,=
 "hdmi-cec", hdmi_cec_parents,
> > >  				    BIT(31),	/* gate */
> > >  				    0);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_hdmi_clk, "bus-hdmi", ahb_hws, 0xb1c, =
BIT(0), 0);
> > > +
> > >  static const struct clk_parent_data mipi_dsi_parents[] =3D {
> > >  	{ .fw_name =3D "hosc" },
> > >  	{ .hw =3D &pll_periph0_200M_clk.hw },
> > > @@ -769,6 +895,12 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(mipi_dsi1_=
clk, "mipi-dsi1",
> > >  				      BIT(31),	/* gate */
> > >  				      CLK_SET_RATE_PARENT);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_mipi_dsi0_clk, "bus-mipi-dsi0", ahb_hw=
s, 0xb4c,
> > > +			  BIT(0), 0);
> > > +
> > > +static SUNXI_CCU_GATE_HWS(bus_mipi_dsi1_clk, "bus-mipi-dsi1", ahb_hw=
s, 0xb4c,
> > > +			  BIT(1), 0);
> > > +
> > >  static const struct clk_hw *tcon_parents[] =3D {
> > >  	&pll_video0_4x_clk.common.hw,
> > >  	&pll_video1_4x_clk.common.hw,
> > > @@ -806,6 +938,11 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(combophy_dsi=
1_clk, "combophy-dsi1",
> > >  				    BIT(31),	/* gate */
> > >  				    CLK_SET_RATE_PARENT);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_tcon_lcd0_clk, "bus-tcon-lcd0", ahb_hw=
s, 0xb7c,
> > > +			  BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_tcon_lcd1_clk, "bus-tcon-lcd1", ahb_hw=
s, 0xb7c,
> > > +			  BIT(1), 0); =20
> >=20
> > Missing gate for bus-tcon-lcd2.
>=20
> Right, added now.
>=20
> >=20
> > > +
> > >  static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_tv0_clk, "tcon-tv0", tcon_p=
arents,
> > >  				    0xb80,
> > >  				    0, 4,	/* M */
> > > @@ -820,6 +957,11 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_tv1_clk=
, "tcon-tv1", tcon_parents,
> > >  				    BIT(31),	/* gate */
> > >  				    CLK_SET_RATE_PARENT);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_tcon_tv0_clk, "bus-tcon-tv0", ahb_hws,=
 0xb9c,
> > > +			  BIT(0), 0);
> > > +static SUNXI_CCU_GATE_HWS(bus_tcon_tv1_clk, "bus-tcon-tv1", ahb_hws,=
 0xb9c,
> > > +			  BIT(1), 0);
> > > +
> > >  static const struct clk_hw *edp_parents[] =3D {
> > >  	&pll_video0_4x_clk.common.hw,
> > >  	&pll_video1_4x_clk.common.hw,
> > > @@ -833,6 +975,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_clk, "edp=
", edp_parents, 0xbb0,
> > >  				    BIT(31),	/* gate */
> > >  				    0);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_edp_clk, "bus-edp", ahb_hws, 0xbbc, BI=
T(0), 0);
> > > +
> > >  static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ir_tx_ledc_p=
arents,
> > >  				      0xbf0,
> > >  				      0, 4,	/* M */
> > > @@ -840,6 +984,8 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "=
ledc", ir_tx_ledc_parents,
> > >  				      BIT(31),	/* gate */
> > >  				      0);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_ledc_clk, "bus-ledc", apb0_hws, 0xbfc,=
 BIT(0), 0);
> > > +
> > >  static const struct clk_hw *csi_top_parents[] =3D {
> > >  	&pll_periph0_300M_clk.hw,
> > >  	&pll_periph0_400M_clk.hw,
> > > @@ -893,6 +1039,8 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk3=
_clk, "csi-mclk3",
> > >  				       BIT(31),	/* gate */
> > >  				       0);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_csi_clk, "bus-csi", ahb_hws, 0xc1c, BI=
T(0), 0);
> > > +
> > >  static const struct clk_hw *isp_parents[] =3D {
> > >  	&pll_periph0_300M_clk.hw,
> > >  	&pll_periph0_400M_clk.hw,
> > > @@ -918,6 +1066,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(dsp_clk, "=
dsp", dsp_parents, 0xc70,
> > >  				      BIT(31),	/* gate */
> > >  				      0);
> > > =20
> > > +static SUNXI_CCU_GATE_HWS(bus_dsp_cfg_clk, "bus-dsp-cfg", ahb_hws, 0=
xc7c,
> > > +			  BIT(1), 0); =20
> >=20
> > I don't see 0xc7c register.
>=20
> Mmh, good point, I thought I saw this in some BSP drop, this "cfg" suffix
> hints at this also. But poking it in U-Boot again indeed reveals it's not
> implemented, the whole register is WI/RAZ.
> Removed that.
>=20
> Thanks!
> Andre
>=20
> > > +
> > >  static SUNXI_CCU_GATE_DATA(fanout_24M_clk, "fanout-24M", osc24M,
> > >  			   0xf30, BIT(0), 0);
> > >  static SUNXI_CCU_GATE_DATA_WITH_PREDIV(fanout_12M_clk, "fanout-12M",=
 osc24M,
> > > @@ -1011,55 +1162,128 @@ static struct ccu_common *sun55i_a523_ccu_cl=
ks[] =3D {
> > >  	&apb0_clk.common,
> > >  	&apb1_clk.common,
> > >  	&de_clk.common,
> > > +	&bus_de_clk.common,
> > >  	&di_clk.common,
> > > +	&bus_di_clk.common,
> > >  	&g2d_clk.common,
> > > +	&bus_g2d_clk.common,
> > >  	&gpu_clk.common,
> > > +	&bus_gpu_clk.common,
> > >  	&ce_clk.common,
> > > +	&bus_ce_clk.common,
> > > +	&bus_ce_sys_clk.common,
> > >  	&ve_clk.common,
> > > +	&bus_ve_clk.common,
> > > +	&bus_dma_clk.common,
> > > +	&bus_msgbox_clk.common,
> > > +	&bus_spinlock_clk.common,
> > >  	&hstimer0_clk.common,
> > >  	&hstimer1_clk.common,
> > >  	&hstimer2_clk.common,
> > >  	&hstimer3_clk.common,
> > >  	&hstimer4_clk.common,
> > >  	&hstimer5_clk.common,
> > > +	&bus_hstimer_clk.common,
> > > +	&bus_dbg_clk.common,
> > > +	&bus_pwm0_clk.common,
> > > +	&bus_pwm1_clk.common,
> > >  	&iommu_clk.common,
> > > +	&bus_iommu_clk.common,
> > >  	&dram_clk.common,
> > > +	&mbus_dma_clk.common,
> > > +	&mbus_ve_clk.common,
> > > +	&mbus_ce_clk.common,
> > > +	&mbus_nand_clk.common,
> > > +	&mbus_usb3_clk.common,
> > > +	&mbus_csi_clk.common,
> > > +	&bus_dram_clk.common,
> > >  	&nand0_clk.common,
> > >  	&nand1_clk.common,
> > > +	&bus_nand_clk.common,
> > >  	&mmc0_clk.common,
> > >  	&mmc1_clk.common,
> > >  	&mmc2_clk.common,
> > > +	&bus_sysdap_clk.common,
> > > +	&bus_mmc0_clk.common,
> > > +	&bus_mmc1_clk.common,
> > > +	&bus_mmc2_clk.common,
> > > +	&bus_uart0_clk.common,
> > > +	&bus_uart1_clk.common,
> > > +	&bus_uart2_clk.common,
> > > +	&bus_uart3_clk.common,
> > > +	&bus_uart4_clk.common,
> > > +	&bus_uart5_clk.common,
> > > +	&bus_uart6_clk.common,
> > > +	&bus_uart7_clk.common,
> > > +	&bus_i2c0_clk.common,
> > > +	&bus_i2c1_clk.common,
> > > +	&bus_i2c2_clk.common,
> > > +	&bus_i2c3_clk.common,
> > > +	&bus_i2c4_clk.common,
> > > +	&bus_i2c5_clk.common,
> > > +	&bus_can_clk.common,
> > >  	&spi0_clk.common,
> > >  	&spi1_clk.common,
> > >  	&spi2_clk.common,
> > >  	&spifc_clk.common,
> > > +	&bus_spi0_clk.common,
> > > +	&bus_spi1_clk.common,
> > > +	&bus_spi2_clk.common,
> > > +	&bus_spifc_clk.common,
> > >  	&emac0_25M_clk.common,
> > >  	&emac1_25M_clk.common,
> > > +	&bus_emac0_clk.common,
> > > +	&bus_emac1_clk.common,
> > >  	&ir_rx_clk.common,
> > > +	&bus_ir_rx_clk.common,
> > >  	&ir_tx_clk.common,
> > > +	&bus_ir_tx_clk.common,
> > >  	&gpadc0_clk.common,
> > >  	&gpadc1_clk.common,
> > > +	&bus_gpadc0_clk.common,
> > > +	&bus_gpadc1_clk.common,
> > > +	&bus_ths_clk.common,
> > >  	&usb_ohci0_clk.common,
> > >  	&usb_ohci1_clk.common,
> > > +	&bus_ohci0_clk.common,
> > > +	&bus_ohci1_clk.common,
> > > +	&bus_ehci0_clk.common,
> > > +	&bus_ehci1_clk.common,
> > > +	&bus_otg_clk.common,
> > > +	&bus_lradc_clk.common,
> > >  	&pcie_aux_clk.common,
> > > +	&bus_dpss_top_clk.common,
> > >  	&hdmi_24M_clk.common,
> > >  	&hdmi_cec_32k_clk.common,
> > >  	&hdmi_cec_clk.common,
> > > +	&bus_hdmi_clk.common,
> > >  	&mipi_dsi0_clk.common,
> > >  	&mipi_dsi1_clk.common,
> > > +	&bus_mipi_dsi0_clk.common,
> > > +	&bus_mipi_dsi1_clk.common,
> > >  	&tcon_lcd0_clk.common,
> > >  	&tcon_lcd1_clk.common,
> > > +	&combophy_dsi0_clk.common,
> > > +	&combophy_dsi1_clk.common,
> > > +	&bus_tcon_lcd0_clk.common,
> > > +	&bus_tcon_lcd1_clk.common,
> > >  	&tcon_tv0_clk.common,
> > >  	&tcon_tv1_clk.common,
> > > +	&bus_tcon_tv0_clk.common,
> > > +	&bus_tcon_tv1_clk.common,
> > >  	&edp_clk.common,
> > > +	&bus_edp_clk.common,
> > >  	&ledc_clk.common,
> > > +	&bus_ledc_clk.common,
> > >  	&csi_top_clk.common,
> > >  	&csi_mclk0_clk.common,
> > >  	&csi_mclk1_clk.common,
> > >  	&csi_mclk2_clk.common,
> > >  	&csi_mclk3_clk.common,
> > > +	&bus_csi_clk.common,
> > >  	&isp_clk.common,
> > >  	&dsp_clk.common,
> > > +	&bus_dsp_cfg_clk.common,
> > >  	&fanout_24M_clk.common,
> > >  	&fanout_12M_clk.common,
> > >  	&fanout_16M_clk.common,
> > > @@ -1119,57 +1343,126 @@ static struct clk_hw_onecell_data sun55i_a52=
3_hw_clks =3D {
> > >  		[CLK_APB1]		=3D &apb1_clk.common.hw,
> > >  		[CLK_MBUS]		=3D &mbus_clk.hw,
> > >  		[CLK_DE]		=3D &de_clk.common.hw,
> > > +		[CLK_BUS_DE]		=3D &bus_de_clk.common.hw,
> > >  		[CLK_DI]		=3D &di_clk.common.hw,
> > > +		[CLK_BUS_DI]		=3D &bus_di_clk.common.hw,
> > >  		[CLK_G2D]		=3D &g2d_clk.common.hw,
> > > +		[CLK_BUS_G2D]		=3D &bus_g2d_clk.common.hw,
> > >  		[CLK_GPU]		=3D &gpu_clk.common.hw,
> > > +		[CLK_BUS_GPU]		=3D &bus_gpu_clk.common.hw,
> > >  		[CLK_CE]		=3D &ce_clk.common.hw,
> > > +		[CLK_BUS_CE]		=3D &bus_ce_clk.common.hw,
> > > +		[CLK_BUS_CE_SYS]	=3D &bus_ce_sys_clk.common.hw,
> > >  		[CLK_VE]		=3D &ve_clk.common.hw,
> > > +		[CLK_BUS_VE]		=3D &bus_ve_clk.common.hw,
> > > +		[CLK_BUS_DMA]		=3D &bus_dma_clk.common.hw,
> > > +		[CLK_BUS_MSGBOX]	=3D &bus_msgbox_clk.common.hw,
> > > +		[CLK_BUS_SPINLOCK]	=3D &bus_spinlock_clk.common.hw,
> > >  		[CLK_HSTIMER0]		=3D &hstimer0_clk.common.hw,
> > >  		[CLK_HSTIMER1]		=3D &hstimer1_clk.common.hw,
> > >  		[CLK_HSTIMER2]		=3D &hstimer2_clk.common.hw,
> > >  		[CLK_HSTIMER3]		=3D &hstimer3_clk.common.hw,
> > >  		[CLK_HSTIMER4]		=3D &hstimer4_clk.common.hw,
> > >  		[CLK_HSTIMER5]		=3D &hstimer5_clk.common.hw,
> > > +		[CLK_BUS_HSTIMER]	=3D &bus_hstimer_clk.common.hw,
> > > +		[CLK_BUS_DBG]		=3D &bus_dbg_clk.common.hw,
> > > +		[CLK_BUS_PWM0]		=3D &bus_pwm0_clk.common.hw,
> > > +		[CLK_BUS_PWM1]		=3D &bus_pwm1_clk.common.hw,
> > >  		[CLK_IOMMU]		=3D &iommu_clk.common.hw,
> > > +		[CLK_BUS_IOMMU]		=3D &bus_iommu_clk.common.hw,
> > >  		[CLK_DRAM]		=3D &dram_clk.common.hw,
> > > +		[CLK_MBUS_DMA]		=3D &mbus_dma_clk.common.hw,
> > > +		[CLK_MBUS_VE]		=3D &mbus_ve_clk.common.hw,
> > > +		[CLK_MBUS_CE]		=3D &mbus_ce_clk.common.hw,
> > > +		[CLK_MBUS_CSI]		=3D &mbus_csi_clk.common.hw,
> > > +		[CLK_BUS_DRAM]		=3D &bus_dram_clk.common.hw,
> > >  		[CLK_NAND0]		=3D &nand0_clk.common.hw,
> > >  		[CLK_NAND1]		=3D &nand1_clk.common.hw,
> > > +		[CLK_BUS_NAND]		=3D &bus_nand_clk.common.hw,
> > >  		[CLK_MMC0]		=3D &mmc0_clk.common.hw,
> > >  		[CLK_MMC1]		=3D &mmc1_clk.common.hw,
> > >  		[CLK_MMC2]		=3D &mmc2_clk.common.hw,
> > > +		[CLK_BUS_SYSDAP]	=3D &bus_sysdap_clk.common.hw,
> > > +		[CLK_BUS_MMC0]		=3D &bus_mmc0_clk.common.hw,
> > > +		[CLK_BUS_MMC1]		=3D &bus_mmc1_clk.common.hw,
> > > +		[CLK_BUS_MMC2]		=3D &bus_mmc2_clk.common.hw,
> > > +		[CLK_BUS_UART0]		=3D &bus_uart0_clk.common.hw,
> > > +		[CLK_BUS_UART1]		=3D &bus_uart1_clk.common.hw,
> > > +		[CLK_BUS_UART2]		=3D &bus_uart2_clk.common.hw,
> > > +		[CLK_BUS_UART3]		=3D &bus_uart3_clk.common.hw,
> > > +		[CLK_BUS_UART4]		=3D &bus_uart4_clk.common.hw,
> > > +		[CLK_BUS_UART5]		=3D &bus_uart5_clk.common.hw,
> > > +		[CLK_BUS_UART6]		=3D &bus_uart6_clk.common.hw,
> > > +		[CLK_BUS_UART7]		=3D &bus_uart7_clk.common.hw,
> > > +		[CLK_BUS_I2C0]		=3D &bus_i2c0_clk.common.hw,
> > > +		[CLK_BUS_I2C1]		=3D &bus_i2c1_clk.common.hw,
> > > +		[CLK_BUS_I2C2]		=3D &bus_i2c2_clk.common.hw,
> > > +		[CLK_BUS_I2C3]		=3D &bus_i2c3_clk.common.hw,
> > > +		[CLK_BUS_I2C4]		=3D &bus_i2c4_clk.common.hw,
> > > +		[CLK_BUS_I2C5]		=3D &bus_i2c5_clk.common.hw,
> > > +		[CLK_BUS_CAN]		=3D &bus_can_clk.common.hw,
> > >  		[CLK_SPI0]		=3D &spi0_clk.common.hw,
> > >  		[CLK_SPI1]		=3D &spi1_clk.common.hw,
> > >  		[CLK_SPI2]		=3D &spi2_clk.common.hw,
> > >  		[CLK_SPIFC]		=3D &spifc_clk.common.hw,
> > > +		[CLK_BUS_SPI0]		=3D &bus_spi0_clk.common.hw,
> > > +		[CLK_BUS_SPI1]		=3D &bus_spi1_clk.common.hw,
> > > +		[CLK_BUS_SPI2]		=3D &bus_spi2_clk.common.hw,
> > > +		[CLK_BUS_SPIFC]		=3D &bus_spifc_clk.common.hw,
> > >  		[CLK_EMAC0_25M]		=3D &emac0_25M_clk.common.hw,
> > >  		[CLK_EMAC1_25M]		=3D &emac1_25M_clk.common.hw,
> > > +		[CLK_BUS_EMAC0]		=3D &bus_emac0_clk.common.hw,
> > > +		[CLK_BUS_EMAC1]		=3D &bus_emac1_clk.common.hw,
> > >  		[CLK_IR_RX]		=3D &ir_rx_clk.common.hw,
> > > +		[CLK_BUS_IR_RX]		=3D &bus_ir_rx_clk.common.hw,
> > >  		[CLK_IR_TX]		=3D &ir_tx_clk.common.hw,
> > > +		[CLK_BUS_IR_TX]		=3D &bus_ir_tx_clk.common.hw,
> > >  		[CLK_GPADC0]		=3D &gpadc0_clk.common.hw,
> > >  		[CLK_GPADC1]		=3D &gpadc1_clk.common.hw,
> > > +		[CLK_BUS_GPADC0]	=3D &bus_gpadc0_clk.common.hw,
> > > +		[CLK_BUS_GPADC1]	=3D &bus_gpadc1_clk.common.hw,
> > > +		[CLK_BUS_THS]		=3D &bus_ths_clk.common.hw,
> > >  		[CLK_USB_OHCI0]		=3D &usb_ohci0_clk.common.hw,
> > >  		[CLK_USB_OHCI1]		=3D &usb_ohci1_clk.common.hw,
> > > +		[CLK_BUS_OHCI0]		=3D &bus_ohci0_clk.common.hw,
> > > +		[CLK_BUS_OHCI1]		=3D &bus_ohci1_clk.common.hw,
> > > +		[CLK_BUS_EHCI0]		=3D &bus_ehci0_clk.common.hw,
> > > +		[CLK_BUS_EHCI1]		=3D &bus_ehci1_clk.common.hw,
> > > +		[CLK_BUS_OTG]		=3D &bus_otg_clk.common.hw,
> > > +		[CLK_BUS_LRADC]		=3D &bus_lradc_clk.common.hw,
> > >  		[CLK_PCIE_AUX]		=3D &pcie_aux_clk.common.hw,
> > > +		[CLK_BUS_DPSS_TOP]	=3D &bus_dpss_top_clk.common.hw,
> > >  		[CLK_HDMI_24M]		=3D &hdmi_24M_clk.common.hw,
> > >  		[CLK_HDMI_CEC_32K]	=3D &hdmi_cec_32k_clk.common.hw,
> > >  		[CLK_HDMI_CEC]		=3D &hdmi_cec_clk.common.hw,
> > > +		[CLK_BUS_HDMI]		=3D &bus_hdmi_clk.common.hw,
> > >  		[CLK_MIPI_DSI0]		=3D &mipi_dsi0_clk.common.hw,
> > >  		[CLK_MIPI_DSI1]		=3D &mipi_dsi1_clk.common.hw,
> > > +		[CLK_BUS_MIPI_DSI0]	=3D &bus_mipi_dsi0_clk.common.hw,
> > > +		[CLK_BUS_MIPI_DSI1]	=3D &bus_mipi_dsi1_clk.common.hw,
> > >  		[CLK_TCON_LCD0]		=3D &tcon_lcd0_clk.common.hw,
> > >  		[CLK_TCON_LCD1]		=3D &tcon_lcd1_clk.common.hw,
> > >  		[CLK_COMBOPHY_DSI0]	=3D &combophy_dsi0_clk.common.hw,
> > >  		[CLK_COMBOPHY_DSI1]	=3D &combophy_dsi1_clk.common.hw,
> > > +		[CLK_BUS_TCON_LCD0]	=3D &bus_tcon_lcd0_clk.common.hw,
> > > +		[CLK_BUS_TCON_LCD1]	=3D &bus_tcon_lcd1_clk.common.hw,
> > >  		[CLK_TCON_TV0]		=3D &tcon_tv0_clk.common.hw,
> > >  		[CLK_TCON_TV1]		=3D &tcon_tv1_clk.common.hw,
> > > +		[CLK_BUS_TCON_TV0]	=3D &bus_tcon_tv0_clk.common.hw,
> > > +		[CLK_BUS_TCON_TV1]	=3D &bus_tcon_tv1_clk.common.hw,
> > >  		[CLK_EDP]		=3D &edp_clk.common.hw,
> > > +		[CLK_BUS_EDP]		=3D &bus_edp_clk.common.hw,
> > >  		[CLK_LEDC]		=3D &ledc_clk.common.hw,
> > > +		[CLK_BUS_LEDC]		=3D &bus_ledc_clk.common.hw,
> > >  		[CLK_CSI_TOP]		=3D &csi_top_clk.common.hw,
> > >  		[CLK_CSI_MCLK0]		=3D &csi_mclk0_clk.common.hw,
> > >  		[CLK_CSI_MCLK1]		=3D &csi_mclk1_clk.common.hw,
> > >  		[CLK_CSI_MCLK2]		=3D &csi_mclk2_clk.common.hw,
> > >  		[CLK_CSI_MCLK3]		=3D &csi_mclk3_clk.common.hw,
> > > +		[CLK_BUS_CSI]		=3D &bus_csi_clk.common.hw,
> > >  		[CLK_ISP]		=3D &isp_clk.common.hw,
> > >  		[CLK_DSP]		=3D &dsp_clk.common.hw,
> > > +		[CLK_BUS_DSP_CFG]	=3D &bus_dsp_cfg_clk.common.hw,
> > >  		[CLK_FANOUT_24M]	=3D &fanout_24M_clk.common.hw,
> > >  		[CLK_FANOUT_12M]	=3D &fanout_12M_clk.common.hw,
> > >  		[CLK_FANOUT_16M]	=3D &fanout_16M_clk.common.hw,
> > >  =20
> >=20
> >=20
> >=20
> >=20
>=20
>=20





