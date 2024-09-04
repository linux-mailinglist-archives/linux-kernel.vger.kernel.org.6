Return-Path: <linux-kernel+bounces-315195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA9396BF15
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D8428BD3B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6F21D9D6A;
	Wed,  4 Sep 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui2Ufc8B"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A731D58B9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457987; cv=none; b=HL2lxs3AwtbvOhS4eK7Op9vdlzO3NT0NiSR8QQ7PbEGS51xBW2TL+y0fXsvDpMdRRpeVhWIb5SPfR1J+/UyX99gxjt4/aYgOTEKxLrdYLntYeFALTaI23nF/V75oXuDHRWKs2j/K7roElAPXqNBiBSAJLdOEQDtPwn96DVxzcng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457987; c=relaxed/simple;
	bh=9MLVb0ol/bNSK3nQlDhr1DFPS4VYuZy2g5x2XjWkP/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ez3NRuKRknxD59YQy9EvAS19d0MtfXIC2t/1dk+tnLF2Z+uKB5rKLkm+PTOitJxM+gkPYLG9po4s8+Yqd/QLA73rSvAxbSh8VN0T2PcXhTajCtXnL9LTFjBiLBRsyvlxZYgmpUiLjf5+gJ5DwTk/0qUVCvHFHS7MfVIMnDSwGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui2Ufc8B; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2da55ea8163so1643626a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725457984; x=1726062784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZntCKAB5sQ3BAt4fIJTMZ8RahlX4phC65t95D6JfQa0=;
        b=Ui2Ufc8B+wJQeJtruvaY3Jfu5pUfj6AJdPDbgest8m1uaGXfIoucJHhi/1TMm3q3IH
         0fpTqBnvdtizFiH87J/+qb0Ezzl0zuzL/ehLrS5Pe/4F5pIREZBUM2VzQx9vIDc7ploB
         x04f8mem//AI8LvTYIg+ANVno8u3wTo7vJSd4jsskpiSwb4CoVeyNZUR2CWdJyjCFGbi
         ERofZVBC1bcW87l6vVM3mZBAQBw/44YSDP9+cc+JtHU3yoOt9ayqtIyuP/6O0NQHMzZV
         5pQ3dqm6YGTPjHoWqQmJWrAdvK6v8kGUdxTLX+emzOgZn3Ji7/zoXdboaFKA1RvR6L3z
         QCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457984; x=1726062784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZntCKAB5sQ3BAt4fIJTMZ8RahlX4phC65t95D6JfQa0=;
        b=KkLyQ1poZkFHj//fWGweWNAkAg9SsL+Jld3AGzplUXOICE/Sicrn87QvOGShGuyxPm
         uCqZPBo28P7Fy2Uc9GeEcFuoieErzX37PaGTfn23X+shNR1Tjj9LkL4O1ec0B6A9y2Cy
         2We9GLFU+Y2prjpVIp0RLmizq1NeYCDlE5aMY3XaUK7QpuqrgHYRp96e1/M1gq8pWB4G
         Yi0zOgMkwn07XjZIe5f+IWgtg59YsTJywLUuVZoyNQatDEaM5Gpisok9mx0yw026yy/I
         K0azxlToNyHUXxpPSh5YSIU5hgdl25Z84leBKobEUhneoF+uQK7zlF/RWMgt1eXYr6B1
         eM7w==
X-Forwarded-Encrypted: i=1; AJvYcCXLnAZ6nJIc5xf8dxbsqJtgfNgFqsBf5qYtmMWW/CN5i6ET/OXGIYM4rTA3AvMHFBqpN9R4XzEsQBc+R0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYWsuFuCM1hl32bPIHPAh/3i4vE60DJGKn16MVbw6Q1PdD2oK
	eDUqTdQcznzKYUOQBghWJ+TN8b+qAeSGN7CPFUJNzsVUns5T0h5JWPtedJbLbgIwY0uzZnrBMbI
	bQLdtfbc8pvIKwxYANwTwRKl/yzA=
X-Google-Smtp-Source: AGHT+IFqxqadthrOQ4NsyQ+izqUPWveKo+Hil93rCSTgTTkoWsmpk/l+FzkM8j54bz2Ond0r8GGJqH2XV1B3q3PoGMw=
X-Received: by 2002:a17:90b:19d2:b0:2d3:d09a:630e with SMTP id
 98e67ed59e1d1-2d893285d01mr12375124a91.1.1725457983705; Wed, 04 Sep 2024
 06:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904023310.163371-1-aford173@gmail.com> <20240904023310.163371-4-aford173@gmail.com>
 <c882eed1-9f36-4382-89fe-f56dd457a45f@kontron.de>
In-Reply-To: <c882eed1-9f36-4382-89fe-f56dd457a45f@kontron.de>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 4 Sep 2024 08:52:52 -0500
Message-ID: <CAHCN7xL4WikbY+k+QdBS64-Kt2oHTQU1i_G44PGJDZZKkRaymw@mail.gmail.com>
Subject: Re: [PATCH V5 3/5] phy: freescale: fsl-samsung-hdmi: Support dynamic integer
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-phy@lists.infradead.org, dominique.martinet@atmark-techno.com, 
	linux-imx@nxp.com, festevam@gmail.com, aford@beaconembedded.com, 
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, 
	Lucas Stach <l.stach@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:35=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 04.09.24 4:32 AM, Adam Ford wrote:
> > There is currently a look-up table for a variety of resolutions.
> > Since the phy has the ability to dynamically calculate the values
> > necessary to use the intger divider which should allow more
>
>                        ^ integer
>
> > resolutions without having to update the look-up-table.
> >
> > If the lookup table cannot find an exact match, fall back to the
> > dynamic calculator of the integer divider.
>
> Nitpick: You have thre different versions of how to spell "lookup table"
> in the paragraphs above. Maybe you can decide on one... ;)
>
> >
> > Previously, the value of P was hard-coded to 1, this required an
> > update to the phy_pll_cfg table to add in the extra value into the
> > table, so if the value of P is calculated to be something else
> > by the PMS calculator, the calculated_phy_pll_cfg structure
> > can be used instead without having to keep track of which method
> > was used.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> The comments I have are only nitpicks and the patch seems to work fine
> for me. So feel free to add:
>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> > ---
> > V5:  No Change
> > V4:  No Change
> > V3:  Change size of pll_div_regs to include PHY_REG01 (P)
> >      Create calculated_phy_pll_cfg to containe the values
> >      Eliminate the PMS calculation from fsl_samsung_hdmi_phy_configure
> >      Make the LUT primary and fall back to integer calculator in
> >      phy_clk_round_rate.
> >      Check the range right away to ensure it's reaonsable rather than
> >      trying to find a clock only to learn it's outside the range.
> >      Overall added notes and comments where stuff may not be intuitive.
> >
> > V2:  Update phy_clk_round_rate and phy_clk_set_rate to both support
> >      the integer clock PMS calculator.
> > ---
> >  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 341 +++++++++++++------
> >  1 file changed, 235 insertions(+), 106 deletions(-)
> >
> > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy=
/freescale/phy-fsl-samsung-hdmi.c
> > index 4f6874226f9a..8f2c0082aa12 100644
> > --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > @@ -16,6 +16,8 @@
> >
> >  #define PHY_REG(reg)         (reg * 4)
> >
> > +#define REG01_PMS_P_MASK     GENMASK(3, 0)
> > +#define REG03_PMS_S_MASK     GENMASK(7, 4)
> >  #define REG12_CK_DIV_MASK    GENMASK(5, 4)
> >
> >  #define REG13_TG_CODE_LOW_MASK       GENMASK(7, 0)
> > @@ -38,281 +40,296 @@
> >  #define REG34_PLL_LOCK               BIT(6)
> >  #define REG34_PHY_CLK_READY  BIT(5)
> >
> > -#define PHY_PLL_DIV_REGS_NUM 6
> > +#ifndef MHZ
> > +#define MHZ  (1000UL * 1000UL)
> > +#endif
> > +
> > +#define PHY_PLL_DIV_REGS_NUM 7
> >
> >  struct phy_config {
> >       u32     pixclk;
> >       u8      pll_div_regs[PHY_PLL_DIV_REGS_NUM];
> >  };
> >
> > +/*
> > + * The calculated_phy_pll_cfg only handles integer divider for PMS onl=
y,
>
> Nitpick: Remove duplicate 'only'
>
> > + * meaning the last four entries will be fixed, but the first three wi=
ll
> > + * be calculated by the PMS calculator
>
> Nitpick: Period at the end of the sentence


Good catch.  I ran these through checkpatch, but I need to tell myself
not do work on this stuff at night when I am tired.
Sorry about that.  My grammar isn't normally this bad.  :-)

adam
>
> > + */
> > +static struct phy_config calculated_phy_pll_cfg =3D {
> > +     .pixclk =3D 0,
> > +     .pll_div_regs =3D { 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00 },
> > +};
> > +
> > +/* The lookup table contains values for which the fractional divder is=
 used */
>
> Nitpick: It seems this comment would rather belong into patch 5/5.

I put it here because I wanted to distinguish between the table below
and the variable above which are both of the same structure type to
explain why we needed both.
>
> >  static const struct phy_config phy_pll_cfg[] =3D {
> >       {
> >               .pixclk =3D 22250000,
> > -             .pll_div_regs =3D { 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 23750000,
> > -             .pll_div_regs =3D { 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x50, 0xf1, 0x86, 0x85, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 24000000,
> > -             .pll_div_regs =3D { 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x50, 0xf0, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 24024000,
> > -             .pll_div_regs =3D { 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x50, 0xf1, 0x99, 0x02, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 25175000,
> > -             .pll_div_regs =3D { 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x54, 0xfc, 0xcc, 0x91, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 25200000,
> > -             .pll_div_regs =3D { 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x54, 0xf0, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 26750000,
> > -             .pll_div_regs =3D { 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0xf2, 0x89, 0x88, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 27000000,
> > -             .pll_div_regs =3D { 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0xf0, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 27027000,
> > -             .pll_div_regs =3D { 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 29500000,
> > -             .pll_div_regs =3D { 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x62, 0xf4, 0x95, 0x08, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 30750000,
> > -             .pll_div_regs =3D { 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
> > +             .pll_div_regs =3D { 0xd1, 0x66, 0xf4, 0x82, 0x01, 0x88, 0=
x45 },
> >       }, {
> >               .pixclk =3D 30888000,
> > -             .pll_div_regs =3D { 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
> > +             .pll_div_regs =3D { 0xd1, 0x66, 0xf4, 0x99, 0x18, 0x88, 0=
x45 },
> >       }, {
> >               .pixclk =3D 33750000,
> > -             .pll_div_regs =3D { 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x70, 0xf4, 0x82, 0x01, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 35000000,
> > -             .pll_div_regs =3D { 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x58, 0xb8, 0x8b, 0x88, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 36000000,
> > -             .pll_div_regs =3D { 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0xb0, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 36036000,
> > -             .pll_div_regs =3D { 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 40000000,
> > -             .pll_div_regs =3D { 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x64, 0xb0, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 43200000,
> > -             .pll_div_regs =3D { 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x90, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 43243200,
> > -             .pll_div_regs =3D { 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 44500000,
> > -             .pll_div_regs =3D { 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
> > +             .pll_div_regs =3D { 0xd1, 0x5c, 0x92, 0x98, 0x11, 0x84, 0=
x41 },
> >       }, {
> >               .pixclk =3D 47000000,
> > -             .pll_div_regs =3D { 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x62, 0x94, 0x95, 0x82, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 47500000,
> > -             .pll_div_regs =3D { 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x63, 0x96, 0xa1, 0x82, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 50349650,
> > -             .pll_div_regs =3D { 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 50400000,
> > -             .pll_div_regs =3D { 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x54, 0x70, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 53250000,
> > -             .pll_div_regs =3D { 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
> > +             .pll_div_regs =3D { 0xd1, 0x58, 0x72, 0x84, 0x03, 0x82, 0=
x41 },
> >       }, {
> >               .pixclk =3D 53500000,
> > -             .pll_div_regs =3D { 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x72, 0x89, 0x88, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 54000000,
> > -             .pll_div_regs =3D { 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x70, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 54054000,
> > -             .pll_div_regs =3D { 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 59000000,
> > -             .pll_div_regs =3D { 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x62, 0x74, 0x95, 0x08, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 59340659,
> > -             .pll_div_regs =3D { 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
> > +             .pll_div_regs =3D { 0xd1, 0x62, 0x74, 0xdb, 0x52, 0x88, 0=
x47 },
> >       }, {
> >               .pixclk =3D 59400000,
> > -             .pll_div_regs =3D { 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x63, 0x70, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 61500000,
> > -             .pll_div_regs =3D { 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
> > +             .pll_div_regs =3D { 0xd1, 0x66, 0x74, 0x82, 0x01, 0x88, 0=
x45 },
> >       }, {
> >               .pixclk =3D 63500000,
> > -             .pll_div_regs =3D { 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x69, 0x74, 0x89, 0x08, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 67500000,
> > -             .pll_div_regs =3D { 0x54, 0x52, 0x87, 0x03, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x54, 0x52, 0x87, 0x03, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 70000000,
> > -             .pll_div_regs =3D { 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x58, 0x58, 0x8b, 0x88, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 72000000,
> > -             .pll_div_regs =3D { 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x50, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 72072000,
> > -             .pll_div_regs =3D { 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 74176000,
> > -             .pll_div_regs =3D { 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
> > +             .pll_div_regs =3D { 0xd1, 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0=
x41 },
> >       }, {
> >               .pixclk =3D 74250000,
> > -             .pll_div_regs =3D { 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
> > +             .pll_div_regs =3D { 0xd1, 0x5c, 0x52, 0x90, 0x0d, 0x84, 0=
x41 },
> >       }, {
> >               .pixclk =3D 78500000,
> > -             .pll_div_regs =3D { 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x62, 0x54, 0x87, 0x01, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 80000000,
> > -             .pll_div_regs =3D { 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x64, 0x50, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 82000000,
> > -             .pll_div_regs =3D { 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
> > +             .pll_div_regs =3D { 0xd1, 0x66, 0x54, 0x82, 0x01, 0x88, 0=
x45 },
> >       }, {
> >               .pixclk =3D 82500000,
> > -             .pll_div_regs =3D { 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
> > +             .pll_div_regs =3D { 0xd1, 0x67, 0x54, 0x88, 0x01, 0x90, 0=
x49 },
> >       }, {
> >               .pixclk =3D 89000000,
> > -             .pll_div_regs =3D { 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x70, 0x54, 0x84, 0x83, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 90000000,
> > -             .pll_div_regs =3D { 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x70, 0x54, 0x82, 0x01, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 94000000,
> > -             .pll_div_regs =3D { 0x4e, 0x32, 0xa7, 0x10, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x4e, 0x32, 0xa7, 0x10, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 95000000,
> > -             .pll_div_regs =3D { 0x50, 0x31, 0x86, 0x85, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x50, 0x31, 0x86, 0x85, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 98901099,
> > -             .pll_div_regs =3D { 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0x47 },
> > +             .pll_div_regs =3D { 0xd1, 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0=
x47 },
> >       }, {
> >               .pixclk =3D 99000000,
> > -             .pll_div_regs =3D { 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
> > +             .pll_div_regs =3D { 0xd1, 0x52, 0x32, 0x82, 0x01, 0x88, 0=
x47 },
> >       }, {
> >               .pixclk =3D 100699300,
> > -             .pll_div_regs =3D { 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 100800000,
> > -             .pll_div_regs =3D { 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x54, 0x30, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 102500000,
> > -             .pll_div_regs =3D { 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
> > +             .pll_div_regs =3D { 0xd1, 0x55, 0x32, 0x8c, 0x05, 0x90, 0=
x4b },
> >       }, {
> >               .pixclk =3D 104750000,
> > -             .pll_div_regs =3D { 0x57, 0x32, 0x98, 0x07, 0x90, 0x49 },
> > +             .pll_div_regs =3D { 0xd1, 0x57, 0x32, 0x98, 0x07, 0x90, 0=
x49 },
> >       }, {
> >               .pixclk =3D 106500000,
> > -             .pll_div_regs =3D { 0x58, 0x32, 0x84, 0x03, 0x82, 0x41 },
> > +             .pll_div_regs =3D { 0xd1, 0x58, 0x32, 0x84, 0x03, 0x82, 0=
x41 },
> >       }, {
> >               .pixclk =3D 107000000,
> > -             .pll_div_regs =3D { 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x32, 0x89, 0x88, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 108000000,
> > -             .pll_div_regs =3D { 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x30, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 108108000,
> > -             .pll_div_regs =3D { 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 118000000,
> > -             .pll_div_regs =3D { 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x62, 0x34, 0x95, 0x08, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 118800000,
> > -             .pll_div_regs =3D { 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x63, 0x30, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 123000000,
> > -             .pll_div_regs =3D { 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
> > +             .pll_div_regs =3D { 0xd1, 0x66, 0x34, 0x82, 0x01, 0x88, 0=
x45 },
> >       }, {
> >               .pixclk =3D 127000000,
> > -             .pll_div_regs =3D { 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x69, 0x34, 0x89, 0x08, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 135000000,
> > -             .pll_div_regs =3D { 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x70, 0x34, 0x82, 0x01, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 135580000,
> > -             .pll_div_regs =3D { 0x71, 0x39, 0xe9, 0x82, 0x9c, 0x5b },
> > +             .pll_div_regs =3D { 0xd1, 0x71, 0x39, 0xe9, 0x82, 0x9c, 0=
x5b },
> >       }, {
> >               .pixclk =3D 137520000,
> > -             .pll_div_regs =3D { 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
> > +             .pll_div_regs =3D { 0xd1, 0x72, 0x38, 0x99, 0x10, 0x85, 0=
x41 },
> >       }, {
> >               .pixclk =3D 138750000,
> > -             .pll_div_regs =3D { 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
> > +             .pll_div_regs =3D { 0xd1, 0x73, 0x35, 0x88, 0x05, 0x90, 0=
x4d },
> >       }, {
> >               .pixclk =3D 140000000,
> > -             .pll_div_regs =3D { 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x75, 0x36, 0xa7, 0x90, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 144000000,
> > -             .pll_div_regs =3D { 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x78, 0x30, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 148352000,
> > -             .pll_div_regs =3D { 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
> > +             .pll_div_regs =3D { 0xd1, 0x7b, 0x35, 0xdb, 0x39, 0x90, 0=
x45 },
> >       }, {
> >               .pixclk =3D 148500000,
> > -             .pll_div_regs =3D { 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
> > +             .pll_div_regs =3D { 0xd1, 0x7b, 0x35, 0x84, 0x03, 0x90, 0=
x45 },
> >       }, {
> >               .pixclk =3D 154000000,
> > -             .pll_div_regs =3D { 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x40, 0x18, 0x83, 0x01, 0x00, 0=
x40 },
> >       }, {
> >               .pixclk =3D 157000000,
> > -             .pll_div_regs =3D { 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x41, 0x11, 0xa7, 0x14, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 160000000,
> > -             .pll_div_regs =3D { 0x42, 0x12, 0xa1, 0x20, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x42, 0x12, 0xa1, 0x20, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 162000000,
> > -             .pll_div_regs =3D { 0x43, 0x18, 0x8b, 0x08, 0x96, 0x55 },
> > +             .pll_div_regs =3D { 0xd1, 0x43, 0x18, 0x8b, 0x08, 0x96, 0=
x55 },
> >       }, {
> >               .pixclk =3D 164000000,
> > -             .pll_div_regs =3D { 0x45, 0x11, 0x83, 0x82, 0x90, 0x4b },
> > +             .pll_div_regs =3D { 0xd1, 0x45, 0x11, 0x83, 0x82, 0x90, 0=
x4b },
> >       }, {
> >               .pixclk =3D 165000000,
> > -             .pll_div_regs =3D { 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
> > +             .pll_div_regs =3D { 0xd1, 0x45, 0x11, 0x84, 0x81, 0x90, 0=
x4b },
> >       }, {
> >               .pixclk =3D 180000000,
> > -             .pll_div_regs =3D { 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x4b, 0x10, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 185625000,
> > -             .pll_div_regs =3D { 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x4e, 0x12, 0x9a, 0x95, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 188000000,
> > -             .pll_div_regs =3D { 0x4e, 0x12, 0xa7, 0x10, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x4e, 0x12, 0xa7, 0x10, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 198000000,
> > -             .pll_div_regs =3D { 0x52, 0x12, 0x82, 0x01, 0x88, 0x47 },
> > +             .pll_div_regs =3D { 0xd1, 0x52, 0x12, 0x82, 0x01, 0x88, 0=
x47 },
> >       }, {
> >               .pixclk =3D 205000000,
> > -             .pll_div_regs =3D { 0x55, 0x12, 0x8c, 0x05, 0x90, 0x4b },
> > +             .pll_div_regs =3D { 0xd1, 0x55, 0x12, 0x8c, 0x05, 0x90, 0=
x4b },
> >       }, {
> >               .pixclk =3D 209500000,
> > -             .pll_div_regs =3D { 0x57, 0x12, 0x98, 0x07, 0x90, 0x49 },
> > +             .pll_div_regs =3D { 0xd1, 0x57, 0x12, 0x98, 0x07, 0x90, 0=
x49 },
> >       }, {
> >               .pixclk =3D 213000000,
> > -             .pll_div_regs =3D { 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
> > +             .pll_div_regs =3D { 0xd1, 0x58, 0x12, 0x84, 0x03, 0x82, 0=
x41 },
> >       }, {
> >               .pixclk =3D 216000000,
> > -             .pll_div_regs =3D { 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x10, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 216216000,
> > -             .pll_div_regs =3D { 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 237600000,
> > -             .pll_div_regs =3D { 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x63, 0x10, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 254000000,
> > -             .pll_div_regs =3D { 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
> > +             .pll_div_regs =3D { 0xd1, 0x69, 0x14, 0x89, 0x08, 0x80, 0=
x40 },
> >       }, {
> >               .pixclk =3D 277500000,
> > -             .pll_div_regs =3D { 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
> > +             .pll_div_regs =3D { 0xd1, 0x73, 0x15, 0x88, 0x05, 0x90, 0=
x4d },
> >       }, {
> >               .pixclk =3D 288000000,
> > -             .pll_div_regs =3D { 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
> > +             .pll_div_regs =3D { 0xd1, 0x78, 0x10, 0x00, 0x00, 0x80, 0=
x00 },
> >       }, {
> >               .pixclk =3D 297000000,
> > -             .pll_div_regs =3D { 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
> > +             .pll_div_regs =3D { 0xd1, 0x7b, 0x15, 0x84, 0x03, 0x90, 0=
x45 },
> >       },
> >  };
> >
> > @@ -322,7 +339,8 @@ struct reg_settings {
> >  };
> >
> >  static const struct reg_settings common_phy_cfg[] =3D {
> > -     { PHY_REG(0), 0x00 }, { PHY_REG(1), 0xd1 },
> > +     { PHY_REG(0), 0x00 },
> > +     /* PHY_REG(1-7) pix clk specific */
> >       { PHY_REG(8), 0x4f }, { PHY_REG(9), 0x30 },
> >       { PHY_REG(10), 0x33 }, { PHY_REG(11), 0x65 },
> >       /* REG12 pixclk specific */
> > @@ -415,6 +433,76 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct=
 fsl_samsung_hdmi_phy *phy,
> >              phy->regs + PHY_REG(14));
> >  }
> >
> > +static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout,=
 u8 *p, u16 *m, u8 *s)
> > +{
> > +     unsigned long best_freq =3D 0;
> > +     u32 min_delta =3D 0xffffffff;
> > +     u8 _p, best_p;
> > +     u16 _m, best_m;
> > +     u8 _s, best_s;
> > +
> > +     /* The ref manual states the values of 'P' range from 1 to 11 */
> > +     for (_p =3D 1; _p <=3D 11; ++_p) {
> > +             for (_s =3D 1; _s <=3D 16; ++_s) {
> > +                     u64 tmp;
> > +                     u32 delta;
> > +
> > +                     /* s must be one or even */
> > +                     if (_s > 1 && (_s & 0x01) =3D=3D 1)
> > +                             _s++;
> > +
> > +                     /* _s cannot be 14 per the TRM */
> > +                     if (_s =3D=3D 14)
> > +                             continue;
> > +
> > +                     /*
> > +                      * TODO: Ref Manual doesn't state the range of _m
> > +                      * so this should be further refined if possible.
> > +                      * This range was set based on the original value=
s
> > +                      * in the look-up table
> > +                      */
>
> There is the strange note "Div by -Div by 255" in the RM. I think it's
> supposed to define the range, but is missing the number for the lower
> bound. The upper bound is probably 255!?
>
> But we might also leave it like it is here and extend it later after
> further testing.

I was confused by that too.  I am not sure how a negative division
would work in this context.

>
> > +                     tmp =3D (u64)fout * (_p * _s);
> > +                     do_div(tmp, 24 * MHZ);
> > +                     _m =3D tmp;
> > +                     if (_m < 0x30 || _m > 0x7b)
> > +                             continue;
> > +
> > +                     /*
> > +                      * Rev 2 of the Ref Manual states the
> > +                      * VCO can range between 750MHz and
> > +                      * 3GHz.  The VCO is assumed to be _m x
> > +                      * the reference frequency of 24MHz divided
> > +                      * by the prescaler, _p
>
> Maybe better: "The VSO is assumed to be (M * f_ref) / P"

I can reword this for better readability.

>
> > +                      */
> > +                     tmp =3D (u64)_m * 24 * MHZ;
> > +                     do_div(tmp, _p);
> > +                     if (tmp < 750 * MHZ ||
> > +                         tmp > 3000 * MHZ)
> > +                             continue;
> > +
> > +                     tmp =3D (u64)_m * 24 * MHZ;
> > +                     do_div(tmp, _p * _s);
>
> tmp already contains (_m * f_ref) / _p, so we sould be able to reuse
> that value here and simply do do_div(tmp, _s) without recalculating tmp, =
no?
>
> > +
> > +                     delta =3D abs(fout - tmp);
> > +                     if (delta < min_delta) {
> > +                             best_p =3D _p;
> > +                             best_s =3D _s;
> > +                             best_m =3D _m;
> > +                             min_delta =3D delta;
> > +                             best_freq =3D tmp;
> > +                     }
> > +             }
> > +     }
> > +
> > +     if (best_freq) {
> > +             *p =3D best_p;
> > +             *m =3D best_m;
> > +             *s =3D best_s;
> > +     }
> > +
> > +     return best_freq;
> > +}
> > +
> >  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy =
*phy,
> >                                         const struct phy_config *cfg)
> >  {
> > @@ -428,13 +516,13 @@ static int fsl_samsung_hdmi_phy_configure(struct =
fsl_samsung_hdmi_phy *phy,
> >       for (i =3D 0; i < ARRAY_SIZE(common_phy_cfg); i++)
> >               writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[=
i].reg);
> >
> > -     /* set individual PLL registers PHY_REG2 ... PHY_REG7 */
> > +     /* set individual PLL registers PHY_REG1 ... PHY_REG7 */
> >       for (i =3D 0; i < PHY_PLL_DIV_REGS_NUM; i++)
> > -             writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i *=
 4);
> > +             writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(1) + i *=
 4);
> >
> > -     /* High nibble of pll_div_regs[1] contains S which also gets writ=
ten to REG21 */
> > +     /* High nibble of PHY_REG3 and low nibble of PHY_REG21 both conta=
in 'S' */
> >       writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
> > -            cfg->pll_div_regs[1] >> 4), phy->regs + PHY_REG(21));
> > +            cfg->pll_div_regs[2] >> 4), phy->regs + PHY_REG(21));
> >
> >       fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
> >
> > @@ -462,29 +550,70 @@ static unsigned long phy_clk_recalc_rate(struct c=
lk_hw *hw,
> >  static long phy_clk_round_rate(struct clk_hw *hw,
> >                              unsigned long rate, unsigned long *parent_=
rate)
> >  {
> > +     u32 int_div_clk;
> >       int i;
> > +     u16 m;
> > +     u8 p, s;
> > +
> > +     /* If the clock is out of range return error instead of searching=
 */
> > +     if (rate > 297000000 || rate < 22250000)
> > +             return -EINVAL;
> >
> > +     /* Check the look-up table */
> >       for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=3D 0; i--)
> >               if (phy_pll_cfg[i].pixclk <=3D rate)
> > -                     return phy_pll_cfg[i].pixclk;
> > +                     break;
> > +     /* If the rate is an exact match, return it now */
> > +     if (rate =3D=3D phy_pll_cfg[i].pixclk)
> > +             return phy_pll_cfg[i].pixclk;
> > +
> > +     /*
> > +      * The math on the lookup table shows the PMS math yields a
> > +      * frequency 5 x pixclk.
> > +      * When we check the integer divider against the desired rate,
> > +      * multiply the rate x 5 and then divide the outcome by 5.
> > +      */
> > +     int_div_clk =3D fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &=
s) / 5;
> >
> > -     return -EINVAL;
> > +     /* If the rate is an exact match, return it now */
> > +     if (int_div_clk =3D=3D rate)
> > +             return int_div_clk;
> > +
> > +     /* Fall back to the closest value in the LUT */
> > +     return phy_pll_cfg[i].pixclk;
> >  }
> >
> >  static int phy_clk_set_rate(struct clk_hw *hw,
> >                           unsigned long rate, unsigned long parent_rate=
)
> >  {
> >       struct fsl_samsung_hdmi_phy *phy =3D to_fsl_samsung_hdmi_phy(hw);
> > +     u32 int_div_clk;
> >       int i;
> > -
> > -     for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=3D 0; i--)
> > -             if (phy_pll_cfg[i].pixclk <=3D rate)
> > -                     break;
> > -
> > -     if (i < 0)
> > -             return -EINVAL;
> > -
> > -     phy->cur_cfg =3D &phy_pll_cfg[i];
> > +     u16 m;
> > +     u8 p, s;
> > +
> > +     /* If the integer divider works, just use it */
> > +     int_div_clk =3D fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &=
s) / 5;
> > +     if (int_div_clk =3D=3D rate) {
> > +             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using integer di=
vider\n");
> > +             calculated_phy_pll_cfg.pixclk =3D int_div_clk;
> > +             calculated_phy_pll_cfg.pll_div_regs[0] =3D FIELD_PREP(REG=
01_PMS_P_MASK, p);
> > +             calculated_phy_pll_cfg.pll_div_regs[1] =3D m;
> > +             calculated_phy_pll_cfg.pll_div_regs[2] =3D FIELD_PREP(REG=
03_PMS_S_MASK, s-1);
> > +             /* pll_div_regs 3-6 are fixed and pre-defined already */
> > +             phy->cur_cfg  =3D &calculated_phy_pll_cfg;
> > +     } else {
> > +             /* Otherwise, search the LUT */
> > +             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional=
 divider\n");> +               for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=
=3D 0; i--)
> > +                     if (phy_pll_cfg[i].pixclk <=3D rate)
> > +                             break;
> > +
> > +             if (i < 0)
> > +                     return -EINVAL;
> > +
> > +             phy->cur_cfg =3D &phy_pll_cfg[i];
> > +     }
> >
> >       return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
> >  }

