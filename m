Return-Path: <linux-kernel+bounces-308995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B44A9664F2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47B5283F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695D51B4C49;
	Fri, 30 Aug 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc0ISY5B"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A049218FC81
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030295; cv=none; b=O6KOiQ9lBRziLvPPWXH6Dg2Lqac2HZ+L2woz/hP+UvyEnAb1yq43m51onRgOPgZx3ITgsYgbNIwJAFWVXH9FHt9kWdpaeXO9qCHZBHC4WEojxxpj24xrau9134X8ftgLw5JYf2ztl6P1BD+XJEcJbrPRqT1i5L0r45J62RzXivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030295; c=relaxed/simple;
	bh=/hYLmsccyGXFbEOm4jxIhXP4niP6DVnr5Xdlmu37HFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chu40Qr+amk2cz5WYxfxAOdbtVHs5KUyjHPQqErlito5bZFcsoyDO9qZqOHLgS9S/hrmaSg+ds9Q/CfB8aqI1esflWNHphLDI8TM2Oj3wNaPbtVp6x/Dw0dd/1U+VNfZeXLWdawmTSsmDa2/IX0kWlsccGtR1RPfMEs7/fRWSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc0ISY5B; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d88690837eso228494a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725030293; x=1725635093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBk/l+T4HXvk+AVkOwAVZKFz1g5wdfRHfu9ue3giLSU=;
        b=jc0ISY5BGw+imapowQCmBcR9LBzkTuAmk8VQn35ohsqVUMuv/8bEzKcWhOfm+LxVlK
         Bd1Lkc/dDBFQFLz3IpEkW6jFl9GJk88RGkUAzYLHL6GyZO9zzXkiBBPKJoQg5QFmTRU4
         FRGkuFwjWbXMz7Vn2nERLu4Cf0pty1HdRSUkybcLNigUd7bh0zZX5uA3WUN+ieKri6pX
         ZpJQ5ci9U+rNshQDICiirU4siU+cZQcDf5zcGIWs/YuBOMg2uwJRPW+j4wLQAAvqsRBG
         2fUL52+I2D72VmrEIRATXmL3IPpkZ+VxHmc9StxX3e6/+H4et6C264uRnWX7CO3Gs/ia
         w+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725030293; x=1725635093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBk/l+T4HXvk+AVkOwAVZKFz1g5wdfRHfu9ue3giLSU=;
        b=VgzDjm3prnnYIKtq7xmFHYapbEjNOHuC8DHhmSz6k25WyK9gsjgbspD4U5RZRHAx+X
         BjC5+pDd7lM7leNCw5nxva1nO3chffR2cROgKINOZPdlrJejvsCVSwE+HJ1UkDa7QgNE
         WsBJDTO7di0+GGwP60d5bYAt+cD/685oXO8L7Q/0OnGbpzUpAPsLJyFFKYFo2U1S7lMi
         vkOHJd3V1Zi6QpOnJgDspaB4m4xEOxL4ytDfLGx9AxRH8MaUccZP+vPJia4PUNXTmTS8
         mHLf+cX9UihimsTPRkZadaW6frZneSmLIxWemlBbScgn5OLwkxVQpg87tDfMoKy88PeJ
         JYNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQf8F5f/7ocVLS+qRsV69mumX7arfrntegRIIyomMLGXMbLa1JhNQoL9d2XUh0HwnKh7+UTGhIALmozLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPSdzGLApkzoyxHiKv5GLJx0D86sc/kMRVNbHZgWBL+Zw2HTNq
	DBSed41LxlOooXpoJLUjAQ6LLL52yzKVSejydJVpnJRTJnqzpHYJy5SXEtYWf7HAK8M9MHJTHzO
	jPzBtUMhos2ICZ71/366QH1t/9+0=
X-Google-Smtp-Source: AGHT+IEYy5lTAhm3Y+CSPGGrkr7wRV6sxUsNdvFOyLCzwEm0bJOGPS7fdYdivnicdN7hfiB6bDk4FkGUuh20aRsbtZQ=
X-Received: by 2002:a17:90b:33ca:b0:2cd:2c4d:9345 with SMTP id
 98e67ed59e1d1-2d8561711d0mr6729408a91.6.1725030292426; Fri, 30 Aug 2024
 08:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830032442.226031-1-aford173@gmail.com> <20240830032442.226031-3-aford173@gmail.com>
 <ZtFfBs4HEShmJKsi@atmark-techno.com>
In-Reply-To: <ZtFfBs4HEShmJKsi@atmark-techno.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 30 Aug 2024 10:04:41 -0500
Message-ID: <CAHCN7x+xy+Y6o++Y5NdZaBJUsHV9Ru_2PwuH6G-2oz1juO=+rQ@mail.gmail.com>
Subject: Re: [RFC V3 3/3] phy: freescale: fsl-samsung-hdmi: Support dynamic integer
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com, 
	frieder.schrempf@kontron.de, aford@beaconembedded.com, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Makoto Sato <makoto.sato@atmark-techno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 12:56=E2=80=AFAM Dominique Martinet
<dominique.martinet@atmark-techno.com> wrote:
>
> Adam Ford wrote on Thu, Aug 29, 2024 at 10:24:27PM -0500:
> > There is currently a look-up table for a variety of resolutions.
> > Since the phy has the ability to dynamically calculate the values
> > necessary to use the intger divider which should allow more
> > resolutions without having to update the look-up-table.
> >
> > If the lookup table cannot find an exact match, fall back to the
> > dynamic calculator of the integer divider.
> >
> > Previously, the value of P was hard-coded to 1, this required an
> > update to the phy_pll_cfg table to add in the extra value into the
> > table, so if the value of P is calculated to be something else
> > by the PMS calculator, the calculated_phy_pll_cfg structure
> > can be used instead without having to keep track of which method
> > was used.
>
> Thank you!
>
> I've updated to v3 and we must have missed something fiddling with v1
> but our 31.5MHz-only screen turns on with this!
>
> Unfortunately among the other odd devices we support, there's one
> whose native resolution only supports 83.5MHz, and that doesn't come out
> right with the integer divider (that function returns 83.2MHz, which is
> 0.4%off)
> If we force the round/set rate functions to prefer the calculated value
> and allow that in imx8mp_hdmi_check_clk_rate (dw_hdmi-imx.c) then it
> also works, so I don't think we actually need to affine the model...
> Coming back to what Lucas replied to my initial mail HDMI would also a
> rate mismatch of =C2=B10.5%, so the integer calculator works for all the
> frequencies we've currently added manually if we fix the check to allow
> that as well:
> 32000000: found 32000000 (100.0% match): p 1 / m 80 / s 12
> 51200000: found 51200000 (100.0% match): p 1 / m 64 / s 6
> 65000000: found 64800000 (99.6% match): p 1 / m 54 / s 4
> 71000000: found 70800000 (99.7% match): p 1 / m 59 / s 4
> 83500000: found 83200000 (99.6% match): p 1 / m 104 / s 6
>
> (only actually tested 51.2 and 83.5 here, we don't have all the hardware
> available; I'll try to play with normal monitors that support more modes
> once the patch gets further finalized)
>
>
> So, as far as I'm concerned I'd be happy to move forward with that and
> will backport this to our tree/remove our kludged values, would "just"
> need to properly pick the closest value if no exact match instead of
> always falling back to the table (or just remove the table altogether if
> we can test a few monitors?)

I took that step on my local build machine to remove the integer
divider stuff from the LUT since it can be found automatically.  I
haven't committed them yet, but I'll likely add it to the series once
submit it without the RFC.

I am also likely to update the rounding function to look at the delta
between the closest LUT clock value and the closest integer clock
value and use whichever is closest to the desired value.


>
> A couple of style nitpicks below
>
> > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy=
/freescale/phy-fsl-samsung-hdmi.c
> > index a700a300dc6f..3fab40cde40d 100644
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
> > @@ -29,281 +31,296 @@
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
> > + * meaning the last four entries will be fixed, but the first three wi=
ll
> > + * be calculated by the PMS calculator
> > + */
> > +static struct phy_config calculated_phy_pll_cfg =3D {
>
> I'd change cur_cfg from pointer to the struct itself like this (partial
> patch that probably won't even apply on your branch:)
> ----
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/f=
reescale/phy-fsl-samsung-hdmi.c
> index 9048cdc760c2..d7124604819c 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -402,7 +402,7 @@ struct fsl_samsung_hdmi_phy {
>
>         /* clk provider */
>         struct clk_hw hw;
> -       const struct phy_config *cur_cfg;
> +       struct phy_config cur_cfg;
>  };
>
>  static inline struct fsl_samsung_hdmi_phy *
> @@ -562,9 +562,9 @@ static int phy_clk_set_rate(struct clk_hw *hw,
>         if (i < 0)
>                 return -EINVAL;
>
> -       phy->cur_cfg =3D &phy_pll_cfg[i];
> +       phy->cur_cfg =3D phy_pll_cfg[i];
>
> -       return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
> +       return fsl_samsung_hdmi_phy_configure(phy, &phy->cur_cfg);
>  }
>
>  static const struct clk_ops phy_clk_ops =3D {
> ----
>
> Then you can just set it directly for calculated values.
> But conceptually it's the same, just one less indirection.

I was thinking about that, but I wasn't sure the impact of
un-const-ing would have on the LUT.

Using the extra indirection minimizes the impact of changes to the LUT
and how its handled by the compiler.

adam
>
> > @@ -406,6 +424,76 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct=
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
> > +     /* The ref manual states the values of 'P' rannge from 1 to 11 */
>
> typo: range
>
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
> > @@ -419,13 +507,13 @@ static int fsl_samsung_hdmi_phy_configure(struct =
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
> > @@ -453,29 +541,70 @@ static unsigned long phy_clk_recalc_rate(struct c=
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
>
> I'd move that comment and both multiplication and division inside
> fsl_samsung_hdmi_phy_find_pms, since it's a property of the computation
> (not having the comment made me ask last time, with the comment it's
> fine -- thanks for adding these comments, very helpful.)
>
> --
> Dominique
>
>

