Return-Path: <linux-kernel+bounces-308843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C400F96628B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741B1287A37
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4B71AF4F6;
	Fri, 30 Aug 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe4tVhyl"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383581B1D73
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023151; cv=none; b=Y8N+wGAywvJ4D8V21kyn0jYxMM941nwn6gYR9zGrIp418owWAq1vqf6GYT15z1Ny1PvUNGv/OdQ7qu4l0kmAkyVeasGxL5aTJqcp/T7k4YzTLzdwQljJWJMGX/tR2YQIy0PV9zF2Pj0lEI3vgVMEzDkhM94uWi2B0Ki1D+jE/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023151; c=relaxed/simple;
	bh=5H9xTh2WGW9t0qScz5XSko441kB8yD/i1PWMAMe39p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZ26z5hqHsrA3PKdEhk37gJUm3q9cv86VDND4aH+Amp2BBjVXpFpy7VFLtJ894IIoM02/Ovj7eQx1NUXJL/nBZ51uGxBSkXehpDV6Je7yB7l/zaKeKzSXZKUybbIpvOh2IzzKUhBMIM2uc9HOg567IdCUsCvkKuDPHaWdGcWim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe4tVhyl; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso1191477a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725023149; x=1725627949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2/OAejnsiuYcRBFc3w40uVreuCzsZZuIbGLYT8lLiA=;
        b=Oe4tVhylfT64WBXgtijoKDkY4sGAM/pEmGzvIkLlSEA7TLGjf9NTaBNtrKUFFIX8FX
         g7xNFZPSNGeQKeRYzszdCXogDMUG8LHOzaWzcKo67rI0mCCFL06hGb3tI3wmTEJF3DJN
         0btB7bhz0WXRbStRBm8I3G7KaIWsw9c8XGhDJ27vjla+Sx+7fflsJ/S/amiBm5dm4eoX
         5fNs2M+E7Pt773lqbHXAizdwVZEOy1H8LWALUvaNzn/+w9fniY1WDjvYv/ykbyEW9qpy
         l4xw9BHJMCCAWm2fwtcuHuUi0EIea3nB/+j531NRuSH7TWbSFAOdCKYbvMH7BV/AHkgI
         0FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725023149; x=1725627949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2/OAejnsiuYcRBFc3w40uVreuCzsZZuIbGLYT8lLiA=;
        b=Ipv5noSGTCiQZYGQWy2PwuOpFo4dA+0jAat8Kbq+BSGnAjjg6PdbqfFVOImMToTdmK
         8kjXoPIRvkI8PwrBByUsBDiDK0TaDILRdp89Z0nV1hfuLjbCxxdzDD3FdraEra3gZa8k
         BImQRgyrAzV/dQnFi67x6w0mDWpKIKvA3yRFQ0x+mjXXzfd3dHg1h1lLBc4EohwlEtdV
         K/zX5Egh9eEkO8Ew2gEGGv0xqnM0krHGacK2HRBq50mZaiSNy2l8qbZSkThhjM7JIk5/
         hVt95FY4gsCK7WDECyMtYcj32RJidIkA7T/K4FdabhUBiUMqTaizBBUgUN+oZKGsFXQm
         xKKw==
X-Forwarded-Encrypted: i=1; AJvYcCUOtOEjO/oL/xDUxBuBdN1ZMQBj73ABww8V+STdjUNnc2lKrt86fajY6Y6RM7JYxm7Ce4osjEJvs9L4Uhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gtxtTWSi8x4b+VzWz9vkNkqxmyG0Q61tm7rquIXaS056KRlU
	gkR2rPgnpGm7jwaRxYzwFfO7Oe5nrDt7sNBuIy44eRy/O6G/e5q0BA9jmpRDSlqSKwvzcJ+2lvM
	mCBJKgU4oMxK6SwOIFcPx9XZuDXU=
X-Google-Smtp-Source: AGHT+IGC+zn8BVsMs+l2GLH+s2gVQrfg2TWIeMQxR2Tdy2T9MoeJugkdwFdKqV3sDjE8Ceij5Mm7/cJpeOdB0yQ/KIw=
X-Received: by 2002:a17:90a:f281:b0:2d8:8509:85d1 with SMTP id
 98e67ed59e1d1-2d8850989c0mr500196a91.38.1725023149115; Fri, 30 Aug 2024
 06:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829021256.787615-1-aford173@gmail.com> <20240829021256.787615-2-aford173@gmail.com>
 <ZtC2LhYAAdPdSRpz@vaman> <CAHCN7xKW=zxips+J73913eEfS+p_e3dN9BWU08=poj599JbUxA@mail.gmail.com>
 <ZtF69NSHFtAwDupq@vaman>
In-Reply-To: <ZtF69NSHFtAwDupq@vaman>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 30 Aug 2024 08:05:37 -0500
Message-ID: <CAHCN7xKsH4Rau23t_pmsjTsNS7Hz32Xb+GBydjLFDpgtni7w2A@mail.gmail.com>
Subject: Re: [RFC V2 2/2] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer divider
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-phy@lists.infradead.org, dominique.martinet@atmark-techno.com, 
	linux-imx@nxp.com, festevam@gmail.com, frieder.schrempf@kontron.de, 
	aford@beaconembedded.com, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 2:55=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 29-08-24, 13:30, Adam Ford wrote:
> > On Thu, Aug 29, 2024 at 12:56=E2=80=AFPM Vinod Koul <vkoul@kernel.org> =
wrote:
> > >
> > > On 28-08-24, 21:12, Adam Ford wrote:
> > > > There is currently a look-up table for a variety of resolutions.
> > > > Since the phy has the ability to dynamically calculate the values
> > > > necessary to use the intger divider which should allow more
> > > > resolutions without having to update the look-up-table.  If the
> > > > integer calculator cannot get an exact frequency, it falls back
> > > > to the look-up-table.  Because the LUT algorithm does some
> > > > rounding, I did not remove integer entries from the LUT.
> > >
> > > Any reason why this is RFC?
> >
> > Someone was asking for functionality, but I'm not 100% sure this is
> > the right approach or it would even work.  I am waiting for feedback
> > from Dominique to determine if this helps solve the display for that
> > particular display.
> >
> > >
> > > >
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > >
> > > > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers=
/phy/freescale/phy-fsl-samsung-hdmi.c
> > > > index bc5d3625ece6..76e0899c6006 100644
> > > > --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > > > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > > > @@ -16,6 +16,8 @@
> > > >
> > > >  #define PHY_REG(reg)         (reg * 4)
> > > >
> > > > +#define REG01_PMS_P_MASK     GENMASK(3, 0)
> > > > +#define REG03_PMS_S_MASK     GENMASK(7, 4)
> > > >  #define REG12_CK_DIV_MASK    GENMASK(5, 4)
> > > >  #define REG13_TG_CODE_LOW_MASK       GENMASK(7, 0)
> > > >  #define REG14_TOL_MASK               GENMASK(7, 4)
> > > > @@ -31,11 +33,17 @@
> > > >
> > > >  #define PHY_PLL_DIV_REGS_NUM 6
> > > >
> > > > +#ifndef MHZ
> > > > +#define MHZ  (1000UL * 1000UL)
> > > > +#endif
> > > > +
> > > >  struct phy_config {
> > > >       u32     pixclk;
> > > >       u8      pll_div_regs[PHY_PLL_DIV_REGS_NUM];
> > > >  };
> > > >
> > > > +static struct phy_config custom_phy_pll_cfg;
> > > > +
> > > >  static const struct phy_config phy_pll_cfg[] =3D {
> > > >       {
> > > >               .pixclk =3D 22250000,
> > > > @@ -440,10 +448,83 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(s=
truct fsl_samsung_hdmi_phy *phy,
> > > >              phy->regs + PHY_REG(14));
> > > >  }
> > > >
> > > > +static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long f=
out, u8 *p, u16 *m, u8 *s)
> > > > +{
> > > > +     unsigned long best_freq =3D 0;
> > > > +     u32 min_delta =3D 0xffffffff;
> > >
> > > > +     u8 _p, best_p;
> > > > +     u16 _m, best_m;
> > > > +     u8 _s, best_s;
> > > > +
> > > > +     for (_p =3D 1; _p <=3D 11; ++_p) {
> > >
> > > starts with 1 to 11.. why?
> >
> > According to Rev 2 of the 8MP Reference Manual, the Previder range is
> > between 1 and 11.
>
> Would be better to document these assumptions, am sure if someone asks
> you this next year, it would be hard to recall :-)

I updated the note n V3.

Dominique confirmed V3 appears to be working, so I'll investigate his
suggestions, and submit a patch based on my V3 without the RFC.

adam
>
> --
> ~Vinod

