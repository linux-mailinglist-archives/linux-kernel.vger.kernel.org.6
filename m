Return-Path: <linux-kernel+bounces-302411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790BD95FDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3890628343E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6A623BB;
	Tue, 27 Aug 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP/2coIq"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67C802
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724718362; cv=none; b=kYvxZ16vep8e/xCZEtTs3uPwCj0LTJbkRCupo5ZFHwdI1/lH6AwUen1kFBEufuyWyjcpoF96guE6zsqPVq/N0xnJL8tiS75WBGgH0cO7CYLF1qBcgbtzXCvRfRZWRmhuBxYZ/FtXlFt6u1B2JVhp2+QpXlhl4jJ196PO8EFVb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724718362; c=relaxed/simple;
	bh=CexjvhclleybqOFHV2y7P6X5MRUCoshZcH+bwy3uzno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTc28M2jlSEfP78x0cMb5ADCo7wFOGq++HYPsiVAgqBnVh0IDyGK1DGy3b/P9kH1Dep5mYtoYKheFn0pQV5thevbL1qy1V5xsPnzVOLir5Bt13D0supkWcszWGrgzq8HQm1Yc1aq3fv7OoIQZFymE9r1GfNAI6wnbU79ligQn4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP/2coIq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3bd8784d3so3850563a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724718360; x=1725323160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMuK4QV7muDMO7BeRVXLHq2wn2REnj0hYpjl+5UTMFw=;
        b=ZP/2coIqsRy1dVETvBQOELKoAwE1wS1itcsQcg9Yb/xeZeC9BqipFTAgW6WpXufc0d
         4GPgNoLlsTpBa0ofQtoAOx2HSM/6zkvMC+fR19go+CTT/g282gmmpDLuQU227Pz9BKvc
         g3YKGrgvxyh4T7rhnT6C3qUEI3Ztf9JbJxZ5fwA3abkEse+sCFDNxBcQSHUnpZ3MV3Dx
         pV0qwIQugwisqImVyTFViOuI60usJI5G8YcwfdXKKzGmofUP0B/ii/K7Df1m7pdCqABt
         Mt+/FAZ76t81CPuJ7c3/KTZjIn351p4Ffnvsz2Ah7xpOgqPs9ioGXruiEfDmu6jzO5aB
         +k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724718360; x=1725323160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMuK4QV7muDMO7BeRVXLHq2wn2REnj0hYpjl+5UTMFw=;
        b=QNkl+q3gSiTsHuIIuObZu4VPVdTk1T/EfkOUWRF5Y3OLqeRroYoz++qfRy9s+C2rDQ
         JbYs6XhtB53xMaP/9uiorIxnmXzub4KGmXK+qWWTUT+ojcuq2MztNncRAwyjKhkTopbA
         pdJcfosYJdnw6KNizmZ/5K7mHM8c8iDRVv0iSvS5w551wHSLNcK5dhtRhWn6dKQGmgmL
         8d95Tvgp1F9+7ZDiCogPPxR9LTVvo2fs8yNG44D3W6MRoMe9RmrY1WnKJ0seq4QgerBg
         FJm5tJJB3MbiNwp5kLhZSCJwxGB95ItpCMb38POC660wLqAutMDqAjaTayLZoJwWDyYA
         mRRg==
X-Forwarded-Encrypted: i=1; AJvYcCVzX9kPPnHy2Ff+0Lz+Zr15u7Wn+fgkn/C1CCbiOCLuY4oDGUyh3UdX2q9qBUCHUXumovFMxGNDSOsOO0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFxhent3Xk4c0mPLNzeinTb79ZTlJv5yrLyM9XfHv3G0okzXR
	n5ZJ1tddeyrWDwGvRZ8XBIpsU+A2nnHN3AGr/VgraDq8XSQXhCqqGWmt2sICarc7fwwPpO5j/Q2
	RFvbs/WeLoHxSf+fZlJKz+riy68U=
X-Google-Smtp-Source: AGHT+IF9ukgQuMvAr/GjcVBuxn1oYZRmrYIyg5G2T1pM3qcAaFAE5umL+maJA4tmjtlrYSAjwgQ9CQ+7oxLU/YQYR/k=
X-Received: by 2002:a17:90b:3804:b0:2c8:53be:fa21 with SMTP id
 98e67ed59e1d1-2d646d382b4mr14410300a91.34.1724718360295; Mon, 26 Aug 2024
 17:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-11-aford173@gmail.com>
 <Zm_UzO4Jmm7Aykcm@atmark-techno.com> <22a3f5266260dd3915269ae3eec7724f7537eb55.camel@pengutronix.de>
 <cd03ecb1-100e-4699-95ed-d837a2802dc7@kontron.de> <CAHCN7x+bh_ka250hOCenO3Et6re4EJ=5TG8=kpG1hs-PV0dQxQ@mail.gmail.com>
 <ZsVluV50NvuGGHFX@atmark-techno.com> <CAHCN7xJnjfjr7HfKF+4pwbENP+p2=vvMXWW1AQShNy87vfQ=-A@mail.gmail.com>
 <CAHCN7xKgpqfRf_2p1z5NyKiOYubbcDA7YE5ML8G56pVmcV+1xA@mail.gmail.com>
In-Reply-To: <CAHCN7xKgpqfRf_2p1z5NyKiOYubbcDA7YE5ML8G56pVmcV+1xA@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 26 Aug 2024 19:25:48 -0500
Message-ID: <CAHCN7x+HgasGG_v-PdtmRszhJn5odHzfV6ddeeT10_1yCOS+DQ@mail.gmail.com>
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

On Wed, Aug 21, 2024 at 8:59=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Wed, Aug 21, 2024 at 7:45=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > On Tue, Aug 20, 2024 at 10:58=E2=80=AFPM Dominique MARTINET
> > <dominique.martinet@atmark-techno.com> wrote:
> > >
> > > Adam Ford wrote on Tue, Aug 20, 2024 at 09:49:03PM -0500:
> > > > > > However, this check is a bit overcautious in that it only allow=
s exact
> > > > > > rate matches. IIRC HDMI allows a rate mismatch of +- 0.5%, so t=
his
> > > > > > check could be relaxed quite a bit to allow for that.
> > > > >
> > > > > I checked with a 1080p display that reports 23 possible modes via=
 EDID.
> > > > > Out of these 15 are accepted by the driver with the strict check.
> > > > >
> > > > > Two more would be accepted with a relaxed check that allows a 0.5=
% margin.
> > > > >
> > > > > For the remaining six modes, the pixel clock would deviate up to =
~5%
> > > > > from what the display expects. Still, if I remove the check altog=
ether,
> > > > > all 23 modes seem to work just fine.
> > >
> > > I can confirm the displays I tested also seem pretty tolerant in
> > > practice (up to ~3-4% at least), but I agree with Lucas that this isn=
't
> > > something we can rely on for a general purpose driver as having examp=
les
> > > of things being tolerant doesn't mean all hardware will be as flexibl=
e..
> > >
> > > > > I'd really like to be able to add more PHY PLL setpoints for disp=
lays
> > > > > that use non-CEA-861 modes. Unfortunately I didn't manage to figu=
re out
> > > > > the fractional-n PLL parameter calculation so far.
> > > > >
> > > > > The i.MX8MP Reference Manual provides formulas to calculate the
> > > > > parameters based on the register values and I tried to make sense=
 of it
> > > > > using the existing register values in the driver. But somehow it =
doesn't
> > > > > add up for me.
> > > > >
> > > > > Lucas, did you already work with the PLL parameters? By any chanc=
e, do
> > > > > you now how the math behind them works?
> > > >
> > > > I spent a little time trying to understand it a bit.  I created a P=
MS
> > > > calculator similar to the one used on the DSI controller,
> > >
> > > Great! I'll admit this also flies over my head and I don't have the
> > > time to study this, so this is much appreciated.
> > >
> > > > except that
> > > > the M seems to be fixed at a value of 62 per the data sheet, so it'=
s
> > > > more of a PS calculator.
> > >
> > > Hmm... PHY_REG2 in the datasheet only lists '0011_1110b - 62' as
> > > example(?) values, but it doesn't say other values are reserved eithe=
r,
> > > I'm not sure what to make of it.
> > > In the current driver PHY_REG_02 (driver macro) is assigned the first
> > > field of .pll_div_regs, which goes anywhere from 0x4b to 0x7b -- pret=
ty
> > > far from 62(0x3e)...
> >
> > OK.  I will experiment with increasing the range of M from being fixed
> > at 3e to a range of 3b to 7b to see if my PMS integer calculator can
> > get more accurate.
> >
> > >
> > > Since other frequencies have been adjusting this main diviser ratio w=
e
> > > actually tried copying neighboring values and adjusting only that reg=
 2
> > > (so the M if I get this right?), but the end result ended up not
> > > synchronizing properly every time... We didn't have time to check wit=
h a
> > > scope if the generated signal was ugly or if it just didn't lock
> > > properly, but the display worked when we just re-used the neighboring
> > > values without changing anything despite being ~3-4% off, so we took =
the
> > > easy way out here and didn't dig much further.
> > >
> > > > Anyway, When I run my P-S calculator to generate the 'best rate' I =
get
> > > > a value that's usually 0.2% variance from nominal, but I only verif=
ied
> > > > a handful of values:
> > > >
> > > > Several which were +0.2%
> > > > 297600000 vs 297000000 (4k@30)
> > > > 148800000 vs 148500000 (1080p60)
> > > > 74400 vs 74200
> > > >
> > > > One value was -0.16%
> > > > 24800000 vs 25200000
> > > >
> > > > If the M value was a bit more flexible, we might be able to reduce
> > > > that variance more.
> > >
> > > Yes, I think the M value could be more flexible, but that'd require
> > > checking if it actually works, whereas having slightly off frequencie=
s
> > > will most likely be OK so I don't think it's worth the effort -- happ=
y
> > > to stick to what the datasheet describes.
> > >
> > > > If / when I get some time, I might play with trying to disable the
> > > > fractional mode and just use the PMS calculator for simplicity desp=
ite
> > > > the inaccuracy.  Maybe we could fall back to using the PMS calculat=
or
> > > > if the desired frequency isn't in the look-up-table.
> > >
> > > That'd be greatly appreciated, I don't have any strong opinion on
> > > whether that should completely replace the table, or only be used if
> > > there is no exact match in the table as these are values we know will
> > > work; but we can definitely test any patch you can throw at us here.
> >
> > I can't promise it'll be quick.  I am not fully certain I understand
> > how the whole thing works, but as a rule, I don't generally like look
> > up tables if they can be calculated dynamically.
>
> I updated my PMS calculator, and I randomly selected 5 resolutions and
> they all returned an exact clock match, so I'll attempt to use the PMS
> integer clock instead of the fractional one.
>
> It'll be a little while longer before I can do anything with it.

Frieder,

Using my PMS calculator and Rev 2 of the Tech Ref Manual, I think I
can generate you a table entry for 51.2MHz.  I don't have the ability
to test it.  I am still working on figuring out an algorithm to
calculate the fractional divider, but 51.2MHz x 5 does not' appear to
need the fractional clock divider, so I think I can just get away with
the standard PMS calculations.

My algorithm showed:
HDMI PHY Best P =3D 1
HDMI PHY Best M =3D 64
HDMI PHY Best S =3D 6
HDMI PHY Best freq =3D 256000000

I'll try to generate a patch to get these values into the table if
you're willing to test it.

All,

I still think it's a good idea to fall back to the PMS calculator if
the fractional stuff isn't found.  We could then determine which clock
frequency is closer between the nearest table entry or the PMS
calculator until someone can come up with an algorithm for it.


adam


>
> adam
> >
> > adam
> > >
> > >
> > > Cheers,
> > > --
> > > Dominique
> > >
> > >

