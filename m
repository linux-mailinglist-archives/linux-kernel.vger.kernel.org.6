Return-Path: <linux-kernel+bounces-314797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E5696B8AB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBF42872CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347A1CF5F3;
	Wed,  4 Sep 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHOAHHhI"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CA126C01
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446233; cv=none; b=dAZOSo7KVXPpwObyNykcY5vfbEc2hdhpeTsfPWo2Lvy8T7ekRWW5ctm28XkpavwYpJEfE3Z7aHqE5vlc02RbZIYVzLkdAtOCpW7qTDFOWAvq5BCIQA3u6my26cUGXF+a91XQe4z/1zpOEWs8iLVuTLi3DBY4xTpFrww+4QIjCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446233; c=relaxed/simple;
	bh=fRQ9oCyzehCnorfhlXB9yaAyHWrto7yX7Zv/ODIPLjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIqZvPdF+mDHxKGPAYuUPZlgGHIovqZmOngdLUQdaFB+uRrjtA3ds8pv5CiYr2CfHPn/2ehZuGcCC+TfSQT6aDG49j2LPEgCb+3yLtzyb4gkEWmOS/Y8Mf8Dsb16yEyb6qKoYnj+Z+6qfDZ7yTd8+ERvCqJsWl7Zy7MZqD9Mf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHOAHHhI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso462736a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725446231; x=1726051031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbu/icIc7/hyFZ/DdTfsPV3H3VognL1oCqHfvJ4X8DU=;
        b=NHOAHHhIEVr5Dwub2S+/bboqD05lo/lf9UkbW8xtpTgOy/3F6re6LfdGnWMR4+ZRk6
         wSx5GDhGpmhHNhJ9C4Zx276ppKOAx8WlFAuiQDN4crN5hizu18T3gbOkCVP9qwrAqx57
         RYDqJIGz/x5fRG8D1wij9yqcoG2C4C93s3avbzmBfAVUKVnZM4T5w39llmc3CjDy9/X2
         6imzx/Hcb6BuWhpTE1RHiNC1AflzrhoSNGaVSyZuoazbT04gUGxvXCsdCIenYRlWd5DB
         ayjtxOodtjTDgTfxW/4GfyVOqJyiZXaZ5hoM6VXzGAI/0snCwjEMOM2gX1SzBznH1jxm
         Xm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725446231; x=1726051031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pbu/icIc7/hyFZ/DdTfsPV3H3VognL1oCqHfvJ4X8DU=;
        b=eunGJBeK33fLIlEv5FLMptHdAFRSuzYmQtAHRNIMFsBk1UQdNUaoLsBEB9NdseMBMT
         HqQ0f3onMSjcpQyFbI+yOCBDnnN9jsRmNHXlelzBPdRSPrvpWjxznuVkepUTRtwssAwd
         CKK3CEnlTR0uV+UU0xmTYDgLhxpXGkO4TWXNb6n4izHowQs5/Vzl7nCfTayPdrIiGHuf
         EUHNLOOd1JwqUHiOYZ2xrBayrZZ21xRDsCZYlV3WnZvQzzaQ0QU3gtV3enNVS8GuX9Ue
         Bg5TfYA1gEVnEEoS5ViUUMBsSk1IpL/suq/PHSVDOZN0F7Kx0eRP96JCdyAOYzAoTUJR
         JrEg==
X-Forwarded-Encrypted: i=1; AJvYcCXox4xAsJclvLvmZ2uMHLzsiOAe8hjqhcuN0a6uQnIdau9RCmLRCIvDrnJYyv7ibd1AI4EFVZaAUHt79F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIHb7KjPO1zzOoRZXYyGdLJz1nZGjGKBSpGA6jv1AE8vy5PqI
	yxqPp5v3QYWC/YBlPTmewWQ/O4quREngnI9QOHkotDRktzV/mDqf4VT/p7xwOyfB+OeDwBRwuyi
	5SUCqmyeE16hNtz+MuYNvSXl8GYsHGA==
X-Google-Smtp-Source: AGHT+IEqnCHpM71TxcCzxlh5HmS53l5IAtHeNDxP7q4z8YV/B7I7l4DlGy62WOJiAHqcnCLGZfdviQfJoLhOumsdlDs=
X-Received: by 2002:a17:90b:4b45:b0:2d8:b923:b56a with SMTP id
 98e67ed59e1d1-2d8b923b62emr10140827a91.41.1725446231190; Wed, 04 Sep 2024
 03:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903013113.139698-1-aford173@gmail.com> <20240903013113.139698-4-aford173@gmail.com>
 <ZtgaOlHi93b_py7T@atmark-techno.com>
In-Reply-To: <ZtgaOlHi93b_py7T@atmark-techno.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 4 Sep 2024 05:37:00 -0500
Message-ID: <CAHCN7xJs1AefLJ1=0FfOs=A2B-gE5sC_VSVS6aGVhnSPOKDuxg@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] phy: freescale: fsl-samsung-hdmi: Support dynamic integer
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com, 
	frieder.schrempf@kontron.de, aford@beaconembedded.com, Sandor.yu@nxp.com, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:28=E2=80=AFAM Dominique Martinet
<dominique.martinet@atmark-techno.com> wrote:
>
> Adam Ford wrote on Mon, Sep 02, 2024 at 08:30:45PM -0500:
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
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> I've rechecked this series with abs() added in the later patch and this

Oh shoot, I totally missed your request for the abs patch.
Sorry about that.  Do you want me to do a V6?

adam

> looks fine; all modes I tried properly synced up with my monitor.
> (except one but I don't see set_rate() being called for it so it's
> something else)
>
> (On a semi-unrelated note on my backport I get a "PLL failed to lock"
> message for the first sync only, but everything seems to work regardless
> even if there is no further set_rate(), so I'll pretend I didn't see
> that... the old code just has a 20ms wait without any check so it's not
> like it was any better... anyway that's unrelated to this serie)
>
> I'm also confident enough set_rate() won't be called in parallel with
> different rates for my device so I'm fine with the new global, letting
> others complain if that's a problem for them.
>
>
> So, feel free to add this to all 5 patches:
> Test-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
>
> Just one style nitpick:
>
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
> I still think it makes more sense to move the * 5, / 5 and comment
> inside fsl_samsung_hdmi_phy_find_pms -- the other caller doesn't have
> such the comment so it might look odd depending on where one started
> looking.
>
> --
> Dominique

