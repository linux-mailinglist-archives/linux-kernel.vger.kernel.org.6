Return-Path: <linux-kernel+bounces-318006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A257296E706
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F64B286A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD7A16415;
	Fri,  6 Sep 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLzwrC8c"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E411CA0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584269; cv=none; b=XIQHi3zSQ/V6j5YP0+cMfkLYdi6EFaeTgTj8OzlUHM7Z0qY5cV03C+P71NjdsQLIMAgFLcacnhDkEDp0sh/5gIvcwgTeLvk/xeWQ3xYdK7P4DjQx9lsl94gDQyVswvG7LKXS+daB9fthy9bA2Y5WR2r0UjO/2xIyyQWCDNFAUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584269; c=relaxed/simple;
	bh=Zu/XQP6m0ph5K5GMDEOpLRJ5FsogGy5vdr+CZfK92TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJeFKAxVxAV/yg4vvsFdZjXlOZkjFd1rR7w0e8U8WPo+01zFhe7HX27ZQmLyp/DHk0ZAMo3D9ieOkiWk8LbMABYkRZNUhClfXuXeLcKm5bTKAFOj6IdmweZH0qpBBmO26R5XJk0otQA5DWJkSlm0pDtPWzh3LMb0tQ78p4VI+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLzwrC8c; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so1125774a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725584267; x=1726189067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlXacWVc911/08odZj5isX+6FCo66PzJYDhU5TKMs40=;
        b=VLzwrC8caQ8X2ua8bGzrVg356UWLpK40em5tQLAZiPNMdOtg6wktVb+uIBOBn74+Xp
         tgR8mmQzUd878z2WU6jsUF+J/h8VXX9sqKCT/a1bfLcf0PIFbR03VMBgEK6YwuF2GYIo
         VFmghTOayeTTcyLStPdzYO46RYCZatnDPyzpyJ4UX+9TYIgRrEDSRPvct0MGBy/1VQ3O
         8XRdx9yy3cZq4fGPPPT8SDDWTUgjxmcak/upok/XHYT13+8yj0cxHQTcIIp1Kr2QQ12l
         7/Z5a5xrPJQrK8Pb24sZGikupM3oiVS4jCStxebAi4fobXy17BQobbeUvEJZdLyI0tVY
         CEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725584267; x=1726189067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlXacWVc911/08odZj5isX+6FCo66PzJYDhU5TKMs40=;
        b=Y6DEIBDw+71X6RDB9sOrwOVao7BXZExgMfkNV/yXbf8L5TLVMDnR6w829T78HbF2P3
         j99+gT/fJz0Q6qfYAx7vrxVEXuU0gzX6gWMOcNhdJt41tP7uwXZ0DdZvyxueEBTbQuV1
         s+1Jt2ZDIateIjB5tcYqbdCXqoLYnWnfmlbv1tZ8OltDnGUfMVHMogpbzPD1gLPBxrYd
         ZPJuM7/7yiAEMAztLJp+0li2RQjXlQ0b7U/e3LeVY4kyKg4T2WJYCtBQ8DRa4aLSFJUt
         NZRZO8GopRgpXHzQPN3iZ5As/EuHWoG6J0cKZ28ThorFIv9Mhk65Gdh3eMuiwXb8Ue4p
         9beg==
X-Forwarded-Encrypted: i=1; AJvYcCVrwUJkTfa0gpe2VwPhnb0/lp/Kl3HUfItPXfUHMFOOPw+cH+f9nA/cDnCL8NEx6KlGsH5aJd/HfKWxD7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYAiX0AjR8yk/vgmbEpGbYsiFIwvlACHV6UX4Q78gOGyBeM/2
	uTY0R+kw5eZNMw0NBOwGVhrOZyHCDh2hrDZ3FsMQOpKd8sQENgHimNRNwrSraqDxThplq0eymCn
	fNl9fVqd5sdeqQR06priPtjJnIRU=
X-Google-Smtp-Source: AGHT+IH6gnV0sVo2Vp70FLhjA/z5Pll9fH+V03yoU41fOXKIfG0c0/I4CcKlSRmtR4RvnNEA5kA/fYA0yNdvl4aFV+M=
X-Received: by 2002:a17:90a:a08e:b0:2d8:8a03:b90d with SMTP id
 98e67ed59e1d1-2dad512d6f9mr1224682a91.41.1725584267294; Thu, 05 Sep 2024
 17:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904233100.114611-1-aford173@gmail.com> <20240904233100.114611-5-aford173@gmail.com>
 <ZtpMPCHBnEgtkBWp@atmark-techno.com>
In-Reply-To: <ZtpMPCHBnEgtkBWp@atmark-techno.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 5 Sep 2024 19:57:36 -0500
Message-ID: <CAHCN7xLo1RgkUPTdTpCtKjnT7w=gPDCfe_ZEbKj0joVvLG02Dw@mail.gmail.com>
Subject: Re: [PATCH V6 4/5] phy: freescale: fsl-samsung-hdmi: Use closest divider
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com, 
	frieder.schrempf@kontron.de, aford@beaconembedded.com, Sandor.yu@nxp.com, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 7:26=E2=80=AFPM Dominique Martinet
<dominique.martinet@atmark-techno.com> wrote:
>
>
> (sorry I meant to send this yesterday but I'm being forced to adjust my
> mail pipeline with work and gmail and it didn't go out -- trying
> again. Sorry if it actually did go through. Hopefully I didn't misfire
> anything else yesterday...)
>
> Adam Ford wrote on Wed, Sep 04, 2024 at 06:30:32PM -0500:
> > Currently, if the clock values cannot be set to the exact rate,
> > the round_rate and set_rate functions use the closest value found in
> > the look-up-table.  In preparation of removing values from the LUT
> > that can be calculated evenly with the integer calculator, it's
> > necessary to ensure to check both the look-up-table and the integer
> > divider clock values to get the closest values to the requested
> > value.  It does this by measuring the difference between the
> > requested clock value and the closest value in both integer divider
> > calucator and the fractional clock look-up-table.
> >
> > Which ever has the smallest difference between them is returned as
> > the cloesest rate.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com=
>
>
> b4 (or whatever you're using) probably picked that up from the patch I
> included in my reply to this patch, this sob should go away.
>
For each iteration, I grabbed the patches from patchwork which
contained any s-o-b messages, if present.  I didn't add anything
manually.
>
>
> > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy=
/freescale/phy-fsl-samsung-hdmi.c
> > index 4b13e386e5ba..9a21dbbf1a82 100644
> > --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > @@ -547,6 +547,16 @@ static unsigned long phy_clk_recalc_rate(struct cl=
k_hw *hw,
> >       return phy->cur_cfg->pixclk;
> >  }
> >
> > +static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
> > +                                              u32 int_div_clk, u32 fra=
c_div_clk)
> > +{
> > +     /* The int_div_clk may be greater than rate, so cast it and use A=
BS */
> > +     if (abs((long)rate - (long)int_div_clk) < (rate - frac_div_clk))
>
> I still think `rate - frac_div_clk` might not always hold in the future
> (because there is no intrinsic reason we'd pick the smaller end in case
> of inexact match and a future improvement might change this to the
> closest value as well), so I'll argue again for having both use abs(),
> but at least there's only one place to update if that changes in the
> future now so hopefully whoever does this will notice...

I can add the ABS on the fractional divider.  I left it out on purpose
since the LUT table always return a value equal or less, so the extra
ABS seemed like busy work.  However, I can see the argument for being
consistent.

>
> > +             return int_div_clk;
> > +
> > +     return frac_div_clk;
> > +}
> > +
> >  static long phy_clk_round_rate(struct clk_hw *hw,
> >                              unsigned long rate, unsigned long *parent_=
rate)
> >  {
> > @@ -563,6 +573,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
> >       for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=3D 0; i--)
> >               if (phy_pll_cfg[i].pixclk <=3D rate)
> >                       break;
> > +
>
> (unrelated)

I don't understand what you're asking here.

>
> >       /* If the rate is an exact match, return it now */
> >       if (rate =3D=3D phy_pll_cfg[i].pixclk)
> >               return phy_pll_cfg[i].pixclk;
> > @@ -579,8 +590,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
> >       if (int_div_clk =3D=3D rate)
> >               return int_div_clk;
> >
> > -     /* Fall back to the closest value in the LUT */
> > -     return phy_pll_cfg[i].pixclk;
> > +     return fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk, p=
hy_pll_cfg[i].pixclk);
> >  }
> >
> >  static int phy_clk_set_rate(struct clk_hw *hw,
> > @@ -594,27 +604,37 @@ static int phy_clk_set_rate(struct clk_hw *hw,
> >
> >       /* If the integer divider works, just use it */
>
> I found this comment a bit confusing given the current flow as of this
> patch. Might make more sense immediately before the if?
>

This code evolved with each iteration, but I didn't necessarily
reorganize the comments.  I can rearrange them.
>
> >       int_div_clk =3D fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &=
s) / 5;
> > +     calculated_phy_pll_cfg.pixclk =3D int_div_clk;
> > +     calculated_phy_pll_cfg.pll_div_regs[0] =3D FIELD_PREP(REG01_PMS_P=
_MASK, p);
> > +     calculated_phy_pll_cfg.pll_div_regs[1] =3D m;
> > +     calculated_phy_pll_cfg.pll_div_regs[2] =3D FIELD_PREP(REG03_PMS_S=
_MASK, s-1);
> > +     phy->cur_cfg =3D &calculated_phy_pll_cfg;
> >       if (int_div_clk =3D=3D rate) {
> >               dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using integer di=
vider\n");
> > -             calculated_phy_pll_cfg.pixclk =3D int_div_clk;
> > -             calculated_phy_pll_cfg.pll_div_regs[0] =3D FIELD_PREP(REG=
01_PMS_P_MASK, p);
> > -             calculated_phy_pll_cfg.pll_div_regs[1] =3D m;
> > -             calculated_phy_pll_cfg.pll_div_regs[2] =3D FIELD_PREP(REG=
03_PMS_S_MASK, s-1);
> > -             /* pll_div_regs 3-6 are fixed and pre-defined already */
>
> nitpick: might want to keep the above comment?

ok.
>
> > -             phy->cur_cfg  =3D &calculated_phy_pll_cfg;
> > +             goto done;
> >       } else {
> >               /* Otherwise, search the LUT */
> > -             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional=
 divider\n");
> > -             for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=3D 0; i--)
> > -                     if (phy_pll_cfg[i].pixclk <=3D rate)
> > +             for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=3D 0; i--) {
> > +                     if (phy_pll_cfg[i].pixclk =3D=3D rate) {
> > +                             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: =
using fractional divider\n");
>
> nitpick: might make sense to print what was picked in case of inexact
> match as well, but these are dbg warning so probably fine either way.

I can add the actual values returned.

>
>
> overall I find the flow of this function hard to read; it's a bit ugly
> flow-wise but jumping in the clock comparison 'if' might help trim this?
> (and if we're going out of our way to factor out the diff, maybe the lut
> lookup could be as well)
>
> But I'm probably just being overcritical here, it's fine as is if you
> pefer your version, just writing down this as an illustration of what I
> meant with the above sentence as I'm not sure I was clear -- I'll be
> just as happy to consider this series done so we can do more interesting
> things :P

Now I am a bit more confused, because above I got the impression you
were withdrawing your s-o-b, but now it sounds like you want to move
it forward.

It sounded like Frieder was making some progress on understanding a
little more about the fractional divider.

>
> {
>     u32 int_div_clk, frac_div_clk;
>     int i;
>     u16 m;
>     u8 p, s;
>
>     // (I haven't given up on that *5 to move inside this function...)

I wanted to keep the PMS calculator returning the real clock value
since the calculations are based on equation in the ref manual, Fpll =3D
Fref * M / (P*S)
This way, the calling function can determine if it needs to be
multiplied by 5.  I haven't fully determined how the fractional
calculator determines what frequency it wants for a target frequency,
and using the values for P, M and S from the fractional divider
doesn't seem to always yield 5x like they did for the table entries
using the integer divider.

I am hoping someone from NXP can elaborate, or give us some clues on
how to get better fractional divider values.

>     int_div_clk =3D fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
>     if (int_div_clk =3D=3D rate)
>         goto use_int_clk;
>
>     frac_div_clk =3D fsl_samsung_hdmi_phy_find_lut(rate, &i);
>     // (not convinced that check actually brings much, but it's not like
>     // it hurts either)
>     if (frac_div_clk =3D=3D rate)
>         goto use_frac_clk;
>
>     if (fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
>                                               frac_div_clk) =3D=3D int_di=
v_clk) {
> use_int_clk:
>         dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using integer divider\n"=
);
>         calculated_phy_pll_cfg.pixclk =3D int_div_clk;
>         calculated_phy_pll_cfg.pll_div_regs[0] =3D FIELD_PREP(REG01_PMS_P=
_MASK, p);
>         calculated_phy_pll_cfg.pll_div_regs[1] =3D m;
>         calculated_phy_pll_cfg.pll_div_regs[2] =3D FIELD_PREP(REG03_PMS_S=
_MASK, s-1);
>         /* pll_div_regs 3-6 are fixed and pre-defined already */
>         phy->cur_cfg  =3D &calculated_phy_pll_cfg;
>     } else {
> use_frac_clk:
>         dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider=
\n");
>         phy->cur_cfg =3D &phy_pll_cfg[i];
>     }
>     return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
> }
>
> --
> Dominique

