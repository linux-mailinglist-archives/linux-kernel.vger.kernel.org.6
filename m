Return-Path: <linux-kernel+bounces-307445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54372964DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D435B1F21F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B998A1B86CB;
	Thu, 29 Aug 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrbDnC64"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E21AE87D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956243; cv=none; b=GoXxqRwQa4LCSekKXYdfpX934z7gQ+FE1oXJgzu2UaUtXs+Xc0wo0rIJc/9z+O4DCpCoMDYgrdkwkg8VUAUZuPs5nt9d5WVcVJXRvOJhmWsmJGfcVD7QYJix4rfW0iwNFjIe2P+bOAdRt7zjTidMK/pXmv9I/ezDkm+Xmk4HTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956243; c=relaxed/simple;
	bh=E2DdKbZaYHujGdtIPDNtjoGI9tcu1F6aKGT98nII9pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYed9ALcTLJhQDf4MjNV+MnYsmqqe5xDhrANcJykn9bQXEqh2YwNjDj2cUPmHXg1oqn7A1iVot+rHPP36B9fkzEkpg9rIjixLdGHLV3WQuXXjamkGoIOIgtBKgN4bS75flq4bAig9EzQPWlteovNQIW4o3bTltAmAUDUk1IHqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrbDnC64; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7bb75419123so581233a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724956241; x=1725561041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+wVwt8XbmN/cyCeEosR2TOa4xMWRanPIykoifiVxCI=;
        b=OrbDnC64bWymtt0K47wgPGaEYl1vDh1jC3IXslM3Od610pkwPwRFRxqPz24O8aCY3C
         673b2w/qUsi28Jl5i41ueAh88W+c8zTKIrxB2J2dkggE7ZeJtc8xhSKQhJcN1gIPHEcM
         AyUcrkLIfjjD/41TPdS7mozDTwMiQWpUYwFXoyQ3BJaBCRUDtYpYApWrE47Ki5AkuVAw
         7sv6Hr+IS7rzM1g2y88FDHRnMxh+yOgSVJSrcUyf1NCMz51aVKmQctgehub9HH5IBLIG
         7z7k1nBd+PcJ6clY4bxFOeaB+U4aIriUxrGY3NB2EqC9Peyj2+YafAYZkJee4OlJlFjx
         CatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724956241; x=1725561041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+wVwt8XbmN/cyCeEosR2TOa4xMWRanPIykoifiVxCI=;
        b=CKuzd/+lR5DZvqnJpglaJqSFUolTQB7ehwVTgYgPkUrjf8lqHSjrw/B1fvYutrmqds
         A6X3gPJIDwGcnZPrJFc2qDtTke3vBLUxMK3B1GyHP4o35deBilkVMxru9lkBy2epmXSl
         y8aeYnDwtoCfKAWCu/PEvs9LrblJIJzPjyrfbjF+xUGqMNaE0Pmd89fyBftnqN4k9L5T
         njCFnZ59nBGab86XNRop6w9qqLfWxAI7CjltTjrtXUMGhbyzJmcsiKnonF+gkG+r8qfc
         GxbpDh5kdCZIDZntVxyWZBatVGPOmGQxTAFe2v3e+aS75GrQ7nxWO55uOFe8fMV7z0GR
         QuqA==
X-Forwarded-Encrypted: i=1; AJvYcCUgYbF4+Gt5dJTxvS9np89X45X1nRsAT7+4BgRW+K1dKTB2QPr1W83NREw8WkKmY4qr5NFklHallU/UXZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOkN30iVVJ69ap2O31CvXcDdR0KiGjDIytYuJqw0dsKUrxVA00
	4HKlPf+j+iJn1BekQsCBeNe2HveLSob5Es/Uj63QSawyqeoZrtxpPsEwiSPxXSCyghv2UHToOd3
	tkquzuVngGSAxK7PrbJvepR8F0H4=
X-Google-Smtp-Source: AGHT+IHD89CrHG0FRbex+zG/Lugb6k0OUdwiUWFVYsqCfisjuvEIqIrdFKutUWWCkN8xImpnkoCcinXt8/ZXGezMkf4=
X-Received: by 2002:a17:90a:4481:b0:2d3:db91:ee82 with SMTP id
 98e67ed59e1d1-2d856503a10mr3357743a91.40.1724956240541; Thu, 29 Aug 2024
 11:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829021256.787615-1-aford173@gmail.com> <20240829021256.787615-2-aford173@gmail.com>
 <ZtC2LhYAAdPdSRpz@vaman>
In-Reply-To: <ZtC2LhYAAdPdSRpz@vaman>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 29 Aug 2024 13:30:29 -0500
Message-ID: <CAHCN7xKW=zxips+J73913eEfS+p_e3dN9BWU08=poj599JbUxA@mail.gmail.com>
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

On Thu, Aug 29, 2024 at 12:56=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrot=
e:
>
> On 28-08-24, 21:12, Adam Ford wrote:
> > There is currently a look-up table for a variety of resolutions.
> > Since the phy has the ability to dynamically calculate the values
> > necessary to use the intger divider which should allow more
> > resolutions without having to update the look-up-table.  If the
> > integer calculator cannot get an exact frequency, it falls back
> > to the look-up-table.  Because the LUT algorithm does some
> > rounding, I did not remove integer entries from the LUT.
>
> Any reason why this is RFC?

Someone was asking for functionality, but I'm not 100% sure this is
the right approach or it would even work.  I am waiting for feedback
from Dominique to determine if this helps solve the display for that
particular display.

>
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy=
/freescale/phy-fsl-samsung-hdmi.c
> > index bc5d3625ece6..76e0899c6006 100644
> > --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > @@ -16,6 +16,8 @@
> >
> >  #define PHY_REG(reg)         (reg * 4)
> >
> > +#define REG01_PMS_P_MASK     GENMASK(3, 0)
> > +#define REG03_PMS_S_MASK     GENMASK(7, 4)
> >  #define REG12_CK_DIV_MASK    GENMASK(5, 4)
> >  #define REG13_TG_CODE_LOW_MASK       GENMASK(7, 0)
> >  #define REG14_TOL_MASK               GENMASK(7, 4)
> > @@ -31,11 +33,17 @@
> >
> >  #define PHY_PLL_DIV_REGS_NUM 6
> >
> > +#ifndef MHZ
> > +#define MHZ  (1000UL * 1000UL)
> > +#endif
> > +
> >  struct phy_config {
> >       u32     pixclk;
> >       u8      pll_div_regs[PHY_PLL_DIV_REGS_NUM];
> >  };
> >
> > +static struct phy_config custom_phy_pll_cfg;
> > +
> >  static const struct phy_config phy_pll_cfg[] =3D {
> >       {
> >               .pixclk =3D 22250000,
> > @@ -440,10 +448,83 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struc=
t fsl_samsung_hdmi_phy *phy,
> >              phy->regs + PHY_REG(14));
> >  }
> >
> > +static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout,=
 u8 *p, u16 *m, u8 *s)
> > +{
> > +     unsigned long best_freq =3D 0;
> > +     u32 min_delta =3D 0xffffffff;
>
> > +     u8 _p, best_p;
> > +     u16 _m, best_m;
> > +     u8 _s, best_s;
> > +
> > +     for (_p =3D 1; _p <=3D 11; ++_p) {
>
> starts with 1 to 11.. why?

According to Rev 2 of the 8MP Reference Manual, the Previder range is
between 1 and 11.

>
> > +             for (_s =3D 1; _s <=3D 16; ++_s) {
> > +                     u64 tmp;
> > +                     u32 delta;
> > +
> > +                     /* s must be even */
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
> > +                      */
> > +                     tmp =3D (u64)_m * 24 * MHZ;
> > +                     do_div(tmp, _p);
> > +                     if (tmp < 750 * MHZ ||
> > +                         tmp > 3000 * MHZ)
> > +                             continue;
> > +
> > +                     tmp =3D (u64)_m * 24 * MHZ;
> > +                     do_div(tmp, _p * _s);
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
> > +     u32 desired_clock =3D cfg->pixclk * 5;
> > +     u32 close_freq;
> >       int i, ret;
> > +     u16 m;
> > +     u8 p, s;
> >       u8 val;
> >
> >       /* HDMI PHY init */
> > @@ -453,11 +534,38 @@ static int fsl_samsung_hdmi_phy_configure(struct =
fsl_samsung_hdmi_phy *phy,
> >       for (i =3D 0; i < ARRAY_SIZE(common_phy_cfg); i++)
> >               writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[=
i].reg);
> >
> > -     /* set individual PLL registers PHY_REG2 ... PHY_REG7 */
> > -     for (i =3D 0; i < PHY_PLL_DIV_REGS_NUM; i++)
> > -             writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i *=
 4);
> > +     /* Using the PMS calculator alone, determine if can use integer d=
ivider */
> > +     close_freq =3D fsl_samsung_hdmi_phy_find_pms(desired_clock, &p, &=
m, &s);
> > +
> > +     /* If the clock cannot be configured with integer divder, use the=
 fractional divider */
> > +     if (close_freq !=3D desired_clock) {
> > +             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: use fractional d=
ivider\n");
> > +             /* set individual PLL registers PHY_REG2 ... PHY_REG7 */
> > +             for (i =3D 0; i < PHY_PLL_DIV_REGS_NUM; i++)
> > +                     writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(=
2) + i * 4);
> > +             fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
> > +     } else {
> > +             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: use integer divi=
der\n");
> > +             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: P =3D %d\n", p);
> > +             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: M =3D %d\n", m);
> > +             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: S =3D %d\n", s);
> > +             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: frequency =3D %u=
\n", close_freq);
> > +
> > +             /* Write integer divder values for PMS */
> > +             writeb(FIELD_PREP(REG01_PMS_P_MASK, p), phy->regs + PHY_R=
EG(1));
> > +             writeb(m, phy->regs + PHY_REG(2));
> > +             writeb(FIELD_PREP(REG03_PMS_S_MASK, s-1), phy->regs + PHY=
_REG(3));
> > +
> > +             /* Configure PHY to disable fractional divider */
> > +             writeb(0x00, phy->regs + PHY_REG(4));
> > +             writeb(0x00, phy->regs + PHY_REG(5));
> > +             writeb(0x80, phy->regs + PHY_REG(6));
> > +             writeb(0x00, phy->regs + PHY_REG(7));
> > +
> > +             writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,=
 s-1),
> > +                    phy->regs + PHY_REG(21));
> > +     }
> >
> > -     fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
> >       fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
> >
> >       writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33=
));
> > @@ -484,8 +592,17 @@ static unsigned long phy_clk_recalc_rate(struct cl=
k_hw *hw,
> >  static long phy_clk_round_rate(struct clk_hw *hw,
> >                              unsigned long rate, unsigned long *parent_=
rate)
> >  {
> > +     u32 int_div_clk;
> >       int i;
> > +     u16 m;
> > +     u8 p, s;
> > +
> > +     /* If the integer divider works, just use it */
> > +     int_div_clk =3D fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &=
s) / 5;
> > +     if (int_div_clk =3D=3D rate)
> > +             return int_div_clk;
> >
> > +     /* Otherwise, fall back to the LUT */
> >       for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=3D 0; i--)
> >               if (phy_pll_cfg[i].pixclk <=3D rate)
> >                       return phy_pll_cfg[i].pixclk;
> > @@ -497,16 +614,28 @@ static int phy_clk_set_rate(struct clk_hw *hw,
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
> > +             /* Just set the pixclk rate, the rest will be calculated =
*/
> > +             custom_phy_pll_cfg.pixclk =3D int_div_clk;
> > +             phy->cur_cfg  =3D &custom_phy_pll_cfg;
> > +     } else {
> > +             /* Otherwise, search the LUT */
> > +             for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=3D 0; i--)
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
> > --
> > 2.43.0
>
> --
> ~Vinod

