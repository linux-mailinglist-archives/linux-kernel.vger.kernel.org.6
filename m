Return-Path: <linux-kernel+bounces-295524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0B959C48
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6A2283075
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B67192D90;
	Wed, 21 Aug 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0KdwTK0"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339C195FD1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244372; cv=none; b=O9Y06XZdN7ZqFm5lT96w8zawa12HvpQJO+blw2BlF+P/mO9lrv+fWab3dRSJ0ZmtZ0rdx1S04Hxr+HE6KOMOkRXIrgjgKCiQGFKbRS/1iHpmIpOnmGqkrF/jIlc81Y7oNNGf5Ij4fSW7Levct/4DyYyBFje/elu2nVUoKnSZDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244372; c=relaxed/simple;
	bh=1VMHZbP4ivk20cCh90xnlB6VA8Klg4oaIg0UuXE8jRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiHJfEQagcQN7JVXWf8OIBTM+lvRolLp/NjFGhPpP2NM/bz6YGnp0yDDBiBxBmpQv1+tduvJUXOWD4tsUOUkwmZnqBtJ6m0SU/CYDELVVCCiNBUJ9A0xTRPoZtLOh0pwNI86/IhyCbW8SuzMLKpFx3BDnjk1HJ/t6jiDhmqjc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0KdwTK0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cd8c8b07fbso227487a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244371; x=1724849171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrQlo1ZtzHZaU3Kc2gC/GsCtOWVGIzkRZAXPXF1JDAc=;
        b=k0KdwTK0CfHdCH9dTN+NJNCyXOpXpDEYCf6m+dvuZ22mkFkoyZGETN8R9of4LnV3Yp
         CmbL2BBln4dJCAX0w21CEh8yHsvQvvcGwAeGX0PHvMRG5J9mkRr4eNOHeMC35i/03SO+
         P5mJalTdkEFdKOdB3sR//8l84eewmzgGJXPuIX0Wmn9XmKX5O/FfEyEkK7KEXgqiJ8Z0
         YxEd2NVJ+d2DQhh3e38ENTDbw147KaY9c0QcvTSCz/RvyAmFoQa+tSofFdDXAgqSOfri
         eeJT58yiQXRdw7G5P1o2aPt4vGZfiI328Q6457CJA3xDhbrPd3pFT9GDJU/DAdR5p4pG
         +R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244371; x=1724849171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrQlo1ZtzHZaU3Kc2gC/GsCtOWVGIzkRZAXPXF1JDAc=;
        b=aX+a7eg3qW2HiIRWCLazhHaSI/rl9vLwJm7s4Xw41Bfhv2WK8eFhuZ0Yg4JF9CD+qT
         8vL4dJESmrTmkBk8BBBj2KoC6XInImkZYbjNzKuJ91mKcjJ9L0bTZluzQkl5B93P+GQz
         4PL/7wM9Io+Ho2EqoVjw/xcfUHpo3JlJGSnQNohyiNKtj8mz+T30wiVcB80x1QGI5Z7c
         IbfCOKeggiCovHEhvsPSG4OsitsIX0WvuBFXVSKitFBAGvvWHMtwcb4Y4Nk/O8fYVevP
         Z9u6D6TxIlMoh8PitErAxmEyXoWJSQV8seZW2Ra3OWn1hGA/OUn0PDLQS0Qjc82w9VCN
         e7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUW71hm9shRESviqaEdzOkW0uNJ0o70n1SO/ynH12EMIdqSR+YYDhu52Gp6HIHaUQI2MTe0pDQ6O2LP4PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvcThETuaaCZaZZcMIW3RJ3VW3eY4yaGs5ARBQV7RN5xam1TB
	CmEpOV5b2oUvom1pi4sGNydc454wTFacxWPLFHX/0Zse87NwgYBmVMukMuPo1WouKJvv5JMcAC8
	8PTq/PnhMoVBr09bwfJq4LEOBLeY=
X-Google-Smtp-Source: AGHT+IHKfU539ztIPvH6FNOLr/tKtolhQJBELB1tBOi+TgcP0/C3jIsojq1Lyrzv/S9i+Tdl/qwVHeal4WeR8hByttU=
X-Received: by 2002:a05:6a21:9214:b0:1c6:fa4b:3648 with SMTP id
 adf61e73a8af0-1cad7f962b8mr3248581637.22.1724244370398; Wed, 21 Aug 2024
 05:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-11-aford173@gmail.com>
 <Zm_UzO4Jmm7Aykcm@atmark-techno.com> <22a3f5266260dd3915269ae3eec7724f7537eb55.camel@pengutronix.de>
 <cd03ecb1-100e-4699-95ed-d837a2802dc7@kontron.de> <CAHCN7x+bh_ka250hOCenO3Et6re4EJ=5TG8=kpG1hs-PV0dQxQ@mail.gmail.com>
 <ZsVluV50NvuGGHFX@atmark-techno.com>
In-Reply-To: <ZsVluV50NvuGGHFX@atmark-techno.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 21 Aug 2024 07:45:58 -0500
Message-ID: <CAHCN7xJnjfjr7HfKF+4pwbENP+p2=vvMXWW1AQShNy87vfQ=-A@mail.gmail.com>
Subject: Re: drm/bridge/imx8mp-hdmi-tx: Allow inexact pixel clock frequencies
 (Was: [PATCH V8 10/12] drm/bridge: imx: add bridge wrapper driver for i.MX8MP
 DWC HDMI)
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, Lucas Stach <l.stach@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, marex@denx.de, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	Makoto Sato <makoto.sato@atmark-techno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 10:58=E2=80=AFPM Dominique MARTINET
<dominique.martinet@atmark-techno.com> wrote:
>
> Adam Ford wrote on Tue, Aug 20, 2024 at 09:49:03PM -0500:
> > > > However, this check is a bit overcautious in that it only allows ex=
act
> > > > rate matches. IIRC HDMI allows a rate mismatch of +- 0.5%, so this
> > > > check could be relaxed quite a bit to allow for that.
> > >
> > > I checked with a 1080p display that reports 23 possible modes via EDI=
D.
> > > Out of these 15 are accepted by the driver with the strict check.
> > >
> > > Two more would be accepted with a relaxed check that allows a 0.5% ma=
rgin.
> > >
> > > For the remaining six modes, the pixel clock would deviate up to ~5%
> > > from what the display expects. Still, if I remove the check altogethe=
r,
> > > all 23 modes seem to work just fine.
>
> I can confirm the displays I tested also seem pretty tolerant in
> practice (up to ~3-4% at least), but I agree with Lucas that this isn't
> something we can rely on for a general purpose driver as having examples
> of things being tolerant doesn't mean all hardware will be as flexible..
>
> > > I'd really like to be able to add more PHY PLL setpoints for displays
> > > that use non-CEA-861 modes. Unfortunately I didn't manage to figure o=
ut
> > > the fractional-n PLL parameter calculation so far.
> > >
> > > The i.MX8MP Reference Manual provides formulas to calculate the
> > > parameters based on the register values and I tried to make sense of =
it
> > > using the existing register values in the driver. But somehow it does=
n't
> > > add up for me.
> > >
> > > Lucas, did you already work with the PLL parameters? By any chance, d=
o
> > > you now how the math behind them works?
> >
> > I spent a little time trying to understand it a bit.  I created a PMS
> > calculator similar to the one used on the DSI controller,
>
> Great! I'll admit this also flies over my head and I don't have the
> time to study this, so this is much appreciated.
>
> > except that
> > the M seems to be fixed at a value of 62 per the data sheet, so it's
> > more of a PS calculator.
>
> Hmm... PHY_REG2 in the datasheet only lists '0011_1110b - 62' as
> example(?) values, but it doesn't say other values are reserved either,
> I'm not sure what to make of it.
> In the current driver PHY_REG_02 (driver macro) is assigned the first
> field of .pll_div_regs, which goes anywhere from 0x4b to 0x7b -- pretty
> far from 62(0x3e)...

OK.  I will experiment with increasing the range of M from being fixed
at 3e to a range of 3b to 7b to see if my PMS integer calculator can
get more accurate.

>
> Since other frequencies have been adjusting this main diviser ratio we
> actually tried copying neighboring values and adjusting only that reg 2
> (so the M if I get this right?), but the end result ended up not
> synchronizing properly every time... We didn't have time to check with a
> scope if the generated signal was ugly or if it just didn't lock
> properly, but the display worked when we just re-used the neighboring
> values without changing anything despite being ~3-4% off, so we took the
> easy way out here and didn't dig much further.
>
> > Anyway, When I run my P-S calculator to generate the 'best rate' I get
> > a value that's usually 0.2% variance from nominal, but I only verified
> > a handful of values:
> >
> > Several which were +0.2%
> > 297600000 vs 297000000 (4k@30)
> > 148800000 vs 148500000 (1080p60)
> > 74400 vs 74200
> >
> > One value was -0.16%
> > 24800000 vs 25200000
> >
> > If the M value was a bit more flexible, we might be able to reduce
> > that variance more.
>
> Yes, I think the M value could be more flexible, but that'd require
> checking if it actually works, whereas having slightly off frequencies
> will most likely be OK so I don't think it's worth the effort -- happy
> to stick to what the datasheet describes.
>
> > If / when I get some time, I might play with trying to disable the
> > fractional mode and just use the PMS calculator for simplicity despite
> > the inaccuracy.  Maybe we could fall back to using the PMS calculator
> > if the desired frequency isn't in the look-up-table.
>
> That'd be greatly appreciated, I don't have any strong opinion on
> whether that should completely replace the table, or only be used if
> there is no exact match in the table as these are values we know will
> work; but we can definitely test any patch you can throw at us here.

I can't promise it'll be quick.  I am not fully certain I understand
how the whole thing works, but as a rule, I don't generally like look
up tables if they can be calculated dynamically.

adam
>
>
> Cheers,
> --
> Dominique
>
>

