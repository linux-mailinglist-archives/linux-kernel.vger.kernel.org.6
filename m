Return-Path: <linux-kernel+bounces-315249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBBC96BFCB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F411F262CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4581DB927;
	Wed,  4 Sep 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HabLD+pt"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968D1DAC4A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459262; cv=none; b=bmUr5j/qgNvh2Dg1zwd/BEHKu1+iQB9vl4jSv228jhZ8HSia/UTBxNWF40fhXewWIlTPki8UBPH3TLgajZ/7laJNUT9iYKlUdPrTm2hacLtUeUl0yLPQ1zSWk5s0UhSQCjH1zKbZp7cCoiLEGy8C1iUHUaYFvzhRnGyk63j49W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459262; c=relaxed/simple;
	bh=DVAI4bApsYbFcX0Y7Jq+ByzW9Sm8y6Nj1TpaqYK9tJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otkiLOj+0c4v0nwZLto6CO6Dzr+D9QSOk+q/vmrdZkR3ElEyWb6hMhQKjLywowbnVFyDK0vPd7syA8xhreSAcToC3QksYZ31IpbyR8gn5CwG6w+EQDWx9/lTdjK9oXv1g/89ZZ1e/Nypt/t7j+i0exxubJDtTL3jRCDghPJgWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HabLD+pt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d885019558so3477532a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725459260; x=1726064060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PgzHsAnrUrunDZZJ+AslrQQgJfxVSx824fdQ3QxD7o=;
        b=HabLD+ptstsWAnTLgxta7ZcM/47Iy4RwZJDM4/JslcsUR7dpCpRMmZlrBBoPvHmdo4
         HI9wZmD+IrXYc/elWhQvhvGx+ODadi4S0NFoIpRo6g/O6PxLfzr/nMjDP029Jxvc7k2D
         fWwsxWLbWqHR1JRR21q5k7b3YNVcHing0fOYn1Dw4ap63JmzyQnT6rHo1pyKe73YjR7H
         jGyBdrBX3BzmZWBEzTX1aFlLE+i69bC7VbcuJHagnwQQKoj0XAJMiDey9nAcEQwtUtZF
         Hx/iXXKgbTHklp74SyyY+eXtzWwxL4VLLQtPUSLhtHL6RMSo6K9dbaTxb+WG5/pGvpIK
         YTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459260; x=1726064060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PgzHsAnrUrunDZZJ+AslrQQgJfxVSx824fdQ3QxD7o=;
        b=fsUNsBmKXOmLTwR5Jp952pVayJb/sLGZqYQnJ666nMRUD64M8xnS4yPnZG4fAa1/0l
         mA2wQUss8LleukFEMjq3FO6CRJ/WsZS9xD8bc20s6eHTFXS+zqNEFATbqIzJxFVn/3zc
         3F3uQ1yS7G4Sa7wV2eWwDk9UvriaLItYcYoHcds4xLeiZiUAmEr8o1JNh3Mq9RhPSSNf
         Cipk+xbmUMVlqHTkdS42OLNsEjJG9DCVcYPS0D2ByLFCfNYxAPWe8Y0Y5O1rzXoZV8SQ
         NVsn/MMpwFk8Jom+3IPkpf5J7c0sHSoIeluoiqgkJ4u0t2wS+xIg09g3nFt6EVZb6/mT
         jfqg==
X-Forwarded-Encrypted: i=1; AJvYcCVpbOYBzX0HHlo5wQK0avHB/5oAywXoQZ3SAhVpFzNoaB8dsQ/xnJMCUpXCCsb2/iVkDfthioMZfC63GgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5HJvDrO/7LJHct9TWSWeyVsiDE+uxXCCyblfxvVlHzk8HJmm
	kFmbI3si5OqytOIXAfUo+GhD0JFguZ6dLnlfuSX7aWcVr6+cNb0DOneB/3YSm7VZ0CIxWYAFMYe
	2IIjgwGiz0MEQcZhb8u3BWrZJfmo=
X-Google-Smtp-Source: AGHT+IHqlO6861kWFPHQ/5iMknd7zcCtaopyROaGQtDRSZMvGPIAeFAy5LiZmahCgfj64wqJf6+ar36fnRfgBaIu3T8=
X-Received: by 2002:a17:90a:dc13:b0:2da:936c:e5ad with SMTP id
 98e67ed59e1d1-2da936cef76mr1876045a91.33.1725459259885; Wed, 04 Sep 2024
 07:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904023310.163371-1-aford173@gmail.com> <20240904023310.163371-5-aford173@gmail.com>
 <0a860fc7-14df-40c6-a92a-868568ae7a24@kontron.de> <92f51c96-9386-43e4-bd19-422dcd8462b9@kontron.de>
In-Reply-To: <92f51c96-9386-43e4-bd19-422dcd8462b9@kontron.de>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 4 Sep 2024 09:14:08 -0500
Message-ID: <CAHCN7xJn4K5VDpnvH2oqEuiLo08p4gvsQCrobDVOvh4JHspazg@mail.gmail.com>
Subject: Re: [PATCH V5 4/5] phy: freescale: fsl-samsung-hdmi: Use closest divider
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-phy@lists.infradead.org, dominique.martinet@atmark-techno.com, 
	linux-imx@nxp.com, festevam@gmail.com, aford@beaconembedded.com, 
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:54=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 04.09.24 3:40 PM, Frieder Schrempf wrote:
> > On 04.09.24 4:32 AM, Adam Ford wrote:
> >> Currently, if the clock values cannot be set to the exact rate,
> >> the round_rate and set_rate functions use the closest value found in
> >> the look-up-table.  In preparation of removing values from the LUT
> >> that can be calculated evenly with the integer calculator, it's
> >> necessary to ensure to check both the look-up-table and the integer
> >> divider clock values to get the closest values to the requested
> >> value.  It does this by measuring the difference between the
> >> requested clock value and the closest value in both integer divider
> >> calucator and the fractional clock look-up-table.
> >>
> >> Which ever has the smallest difference between them is returned as
> >> the cloesest rate.
> >>
> >> Signed-off-by: Adam Ford <aford173@gmail.com>
> >> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.co=
m>
> >> ---
> >> V5:  No Change
> >> V4:  New to series
> >> ---
> >>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 40 +++++++++++++++----=
-
> >>  1 file changed, 31 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/ph=
y/freescale/phy-fsl-samsung-hdmi.c
> >> index 8f2c0082aa12..56b08e684179 100644
> >> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> >> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> >> @@ -550,7 +550,7 @@ static unsigned long phy_clk_recalc_rate(struct cl=
k_hw *hw,
> >>  static long phy_clk_round_rate(struct clk_hw *hw,
> >>                             unsigned long rate, unsigned long *parent_=
rate)
> >>  {
> >> -    u32 int_div_clk;
> >> +    u32 int_div_clk, delta_int, delta_frac;
> >>      int i;
> >>      u16 m;
> >>      u8 p, s;
> >> @@ -563,6 +563,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
> >>      for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=3D 0; i--)
> >>              if (phy_pll_cfg[i].pixclk <=3D rate)
> >>                      break;
> >> +
> >>      /* If the rate is an exact match, return it now */
> >>      if (rate =3D=3D phy_pll_cfg[i].pixclk)
> >>              return phy_pll_cfg[i].pixclk;
> >> @@ -579,15 +580,21 @@ static long phy_clk_round_rate(struct clk_hw *hw=
,
> >>      if (int_div_clk =3D=3D rate)
> >>              return int_div_clk;
> >>
> >> -    /* Fall back to the closest value in the LUT */
> >> -    return phy_pll_cfg[i].pixclk;
> >> +    /* Calculate the differences and use the closest one */
> >> +    delta_frac =3D (rate - phy_pll_cfg[i].pixclk);
> >> +    delta_int =3D (rate - int_div_clk);
> >> +
> >> +    if (delta_int < delta_frac)
> >> +            return int_div_clk;
> >> +    else
> >> +            return phy_pll_cfg[i].pixclk;
>
> I would also prefer to use a helper for calculating the closest rate.
> Something like:
>
> static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
>                                                  u32 int_div_clk,
>                                                  u32 frac_div_clk)
> {
>         if ((rate - int_div_clk) < (rate - frac_div_clk))
>                 return int_div_clk;
>
>         return frac_div_clk;
> }

I like this idea.  As Dominique noted, the int_div_clk might be
greater than rate, so I'll add abs() here when I simplify this.
>
> This can be used above:
>
> return fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
> phy_pll_cfg[i].pixclk);
>
> And also below in phy_clk_set_rate():
>
> if (fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
> phy_pll_cfg[i].pixclk) =3D=3D int_div_clk)
>                 phy->cur_cfg =3D &calculated_phy_pll_cfg;
>         else
>                 phy->cur_cfg =3D &phy_pll_cfg[i];
>

I like this too.

adam
>
> >>  }
> >>
> >>  static int phy_clk_set_rate(struct clk_hw *hw,
> >>                          unsigned long rate, unsigned long parent_rate=
)
> >>  {
> >>      struct fsl_samsung_hdmi_phy *phy =3D to_fsl_samsung_hdmi_phy(hw);
> >> -    u32 int_div_clk;
> >> +    u32 int_div_clk, delta_int, delta_frac;
> >>      int i;
> >>      u16 m;
> >>      u8 p, s;
> >> @@ -602,19 +609,34 @@ static int phy_clk_set_rate(struct clk_hw *hw,
> >>              calculated_phy_pll_cfg.pll_div_regs[2] =3D FIELD_PREP(REG=
03_PMS_S_MASK, s-1);
> >>              /* pll_div_regs 3-6 are fixed and pre-defined already */
> >>              phy->cur_cfg  =3D &calculated_phy_pll_cfg;
> >
> >                              ^ unneeded whitespace (comment belongs to
> > patch 3/5)
> >
> >> +            goto done;
> >>      } else {
> >>              /* Otherwise, search the LUT */
> >> -            dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional=
 divider\n");
> >> -            for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=3D 0; i--)
> >> -                    if (phy_pll_cfg[i].pixclk <=3D rate)
> >> +            for (i =3D ARRAY_SIZE(phy_pll_cfg) - 1; i >=3D 0; i--) {
> >> +                    if (phy_pll_cfg[i].pixclk =3D=3D rate) {
> >> +                            dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: =
using fractional divider\n");
> >> +                            phy->cur_cfg =3D &phy_pll_cfg[i];
> >> +                            goto done;
> >> +                    }
> >> +
> >> +                    if (phy_pll_cfg[i].pixclk < rate)
> >>                              break;
> >> +            }
> >>
> >>              if (i < 0)
> >>                      return -EINVAL;
> >> -
> >> -            phy->cur_cfg =3D &phy_pll_cfg[i];
> >>      }
> >>
> >> +    /* Calculate the differences for each clock against the requested=
 value */
> >> +    delta_frac =3D (rate - phy_pll_cfg[i].pixclk);
> >> +    delta_int =3D (rate - int_div_clk);
> >> +
> >> +    /* Use the value closest to the desired */
> >> +    if (delta_int < delta_frac)
> >> +            phy->cur_cfg  =3D &calculated_phy_pll_cfg;
> >
> >                              ^ unneeded whitespace
> >
> > Are you sure that this is correct? The calculated_phy_pll_cfg is only
> > set above if there is an exact match for the integer divider. I don't
> > think it contains the data you expect here, or am I missing something?
> >
> >> +    else
> >> +            phy->cur_cfg =3D &phy_pll_cfg[i];
> >> +done:
> >>      return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
> >>  }
> >>

