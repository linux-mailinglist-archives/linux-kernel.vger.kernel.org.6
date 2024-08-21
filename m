Return-Path: <linux-kernel+bounces-294824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16801959316
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8936A1F26265
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0CC15854C;
	Wed, 21 Aug 2024 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC/i4eJB"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6625158528
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208557; cv=none; b=KOCrjbPrK4rwIqzvEaEfH8F87GMCzUzDj9KHWwlBayUWMBMfbTre/XRW7g65dJJcivrRW6CKlb6wBO8Dkf2kvUKeqpl5EIoMmVtiC1Be5Z53JO7Tny9DH5wqbv2t8tDHfRXhLHGm1Ek8FURy+1Gb8g/asdF7Cpe4XQ2f4S9O4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208557; c=relaxed/simple;
	bh=GFt0PnOafubQxxxeYCxJn/DertFNP+5EP8EXt7f/a24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXygtNX2WNyqed0uuvP78Pcbc/zHF1K6th3DigJq+RXqz1XRRXspTAT0aJs3im5oeFbs6r3cnddKJ/ISbflqlOT/axWIG1Rv7rpoMpGR9kWZCCDRtXzZJ6hLpkpw0V+xw6wR1+53aUB5S+7pYSP9TD1jTaBSbEJ/SVKkvmf1kug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC/i4eJB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso4600788a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724208555; x=1724813355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE92xTzpyc1kzcm5lmkLo7kV0Lo7mv/gXSiJrqevpAQ=;
        b=QC/i4eJBVIh+rs/i86CeD6N2DML9exodNxFrUH3vro42Gz2g5wJptXt2REM/+A1avC
         ercobjvJMeGMcya1pX25bY9vMFGL3WDC4KLiLOUrEf2Nkw1uyq/nQuOU9+GOng/Igi68
         MlvOG0/nJI0B4EkQXMghq8LEcUBaVhHXS70B8oYjVBH8H6a+kzwQ/icNs/FJtlKSjzML
         M6HEUTUshpi4oFFSNDvIX8TBmuQF8uCgH9zEKwVBJDaQLZOfNwxw8Ns98onFFdHmki2y
         jWwQfmZAGmRw+31STgftjhdsIpx8NVWirtEiqfIo6n+bLCxQOzbeNpKT+sPRP+Zh5QYw
         EDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724208555; x=1724813355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE92xTzpyc1kzcm5lmkLo7kV0Lo7mv/gXSiJrqevpAQ=;
        b=fvbmROHZUmJtv76GkROaDkxXJ19n3HtJvTj4VNqxWEkob0vxJljlOPD1mF7Df0auxR
         g63eSnza8tMsZcA+nknjV8MG2uUbrsglVgUUeS7xQJtIQOo9LnqfCWtBek9nSzGRvAZP
         L70HF+GR2EDYG88mGgP+VnpRz6WsyVctjQTV4GBKUkiFK/pCVCo8BmAW0gQIOsNcs277
         +lgFCRgUrIkZlrggBG6KwqZrqnuD2LFrKBjfU4TRIHDqwUtCcFCr/Pn01++AvVALWYJM
         cE8VYWPpQ2mD9qysZ6cOldY/UArCqLHCAWbBozb6Kb6P8SGedd4TrsvEH5YWoQDSCqgl
         evDA==
X-Forwarded-Encrypted: i=1; AJvYcCUtJ6habUccRqTKOrLc37uPx09eqKqAgOxfpcrOwqiTQoQDDI0+d6Co0uAWy1GxO+D4J1PRPmpFJOq40NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmlw9j/Ct0fNwf1toG+vFpO9mRFYUD9kEMjEeq/XJnq2FsdgXb
	ME+t+ybUZSCLK6KiFpG35rB1NkPLKuF5ECcJf5Z4ABwk0S1Ah0zjiHXjtncJnLloA6bLs5oVynS
	E4DXnvItpTlCpD+J4sIyzVPw0t1I=
X-Google-Smtp-Source: AGHT+IHPIeU+XeIHnRDwOc8ghN5MtcSzCEjHZtvnpI0kCMC3xi6zc1BgiVyooCk3wuq0/oAVIZyRNBgW98ToLF19jq4=
X-Received: by 2002:a17:90b:3889:b0:2cd:2992:e8dc with SMTP id
 98e67ed59e1d1-2d5e99fb6demr1065257a91.5.1724208554836; Tue, 20 Aug 2024
 19:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-11-aford173@gmail.com>
 <Zm_UzO4Jmm7Aykcm@atmark-techno.com> <22a3f5266260dd3915269ae3eec7724f7537eb55.camel@pengutronix.de>
 <cd03ecb1-100e-4699-95ed-d837a2802dc7@kontron.de>
In-Reply-To: <cd03ecb1-100e-4699-95ed-d837a2802dc7@kontron.de>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 20 Aug 2024 21:49:03 -0500
Message-ID: <CAHCN7x+bh_ka250hOCenO3Et6re4EJ=5TG8=kpG1hs-PV0dQxQ@mail.gmail.com>
Subject: Re: drm/bridge/imx8mp-hdmi-tx: Allow inexact pixel clock frequencies
 (Was: [PATCH V8 10/12] drm/bridge: imx: add bridge wrapper driver for i.MX8MP
 DWC HDMI)
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Lucas Stach <l.stach@pengutronix.de>, 
	Dominique MARTINET <dominique.martinet@atmark-techno.com>, linux-arm-kernel@lists.infradead.org, 
	marex@denx.de, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
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

On Thu, Aug 15, 2024 at 3:19=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Dominique, hi Lucas,
>
> On 17.06.24 6:32 PM, Lucas Stach wrote:
> > Hi Dominique,
> >
> > Am Montag, dem 17.06.2024 um 15:16 +0900 schrieb Dominique MARTINET:
> >> Adam Ford wrote on Sat, Feb 03, 2024 at 10:52:50AM -0600:
> >>> From: Lucas Stach <l.stach@pengutronix.de>
> >>>
> >>> Add a simple wrapper driver for the DWC HDMI bridge driver that
> >>> implements the few bits that are necessary to abstract the i.MX8MP
> >>> SoC integration.
> >>
> >> Hi Lucas, Adam,
> >> (trimmed ccs a bit)
> >>
> >> First, thank you for the effort of upstreaming all of this!! It's real=
ly
> >> appreciated, and with display working I'll really be wanting to upstre=
am
> >> our DTS as well as soon as I have time (which is going to be a while,
> >> but better late than never ?)
> >>
> >> Until then, it's been a few months but I've got a question on this bit=
:
> >>
> >>> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c b/drivers/gp=
u/drm/bridge/imx/imx8mp-hdmi-tx.c
> >>> new file mode 100644
> >>> index 000000000000..89fc432ac611
> >>> --- /dev/null
> >>> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> >>> +static enum drm_mode_status
> >>> +imx8mp_hdmi_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
> >>> +                  const struct drm_display_info *info,
> >>> +                  const struct drm_display_mode *mode)
> >>> +{
> >>> +   struct imx8mp_hdmi *hdmi =3D (struct imx8mp_hdmi *)data;
> >>> +
> >>> +   if (mode->clock < 13500)
> >>> +           return MODE_CLOCK_LOW;
> >>> +
> >>> +   if (mode->clock > 297000)
> >>> +           return MODE_CLOCK_HIGH;
> >>> +
> >>> +   if (clk_round_rate(hdmi->pixclk, mode->clock * 1000) !=3D
> >>> +       mode->clock * 1000)
> >>> +           return MODE_CLOCK_RANGE;
> >>
> >> Do you know why such a check is here?
> >
> > Sending a HDMI signal with a different rate than what the display
> > expects rarely ends well, so this check avoids that.
> >
> > However, this check is a bit overcautious in that it only allows exact
> > rate matches. IIRC HDMI allows a rate mismatch of +- 0.5%, so this
> > check could be relaxed quite a bit to allow for that.
>
> I checked with a 1080p display that reports 23 possible modes via EDID.
> Out of these 15 are accepted by the driver with the strict check.
>
> Two more would be accepted with a relaxed check that allows a 0.5% margin=
.
>
> For the remaining six modes, the pixel clock would deviate up to ~5%
> from what the display expects. Still, if I remove the check altogether,
> all 23 modes seem to work just fine.
>
> >>
> >> When plugging in a screen with no frequency identically supported in i=
ts
> >> EDID this check causes the screen to stay black, and we've been tellin=
g
> >> customers to override the EDID but it's a huge pain.
> >>
> >> Commit 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY") already
> >> "fixed" the samsung hdmi phy driver to return the next frequency if an
> >> exact match hasn't been found (NXP tree's match frequencies exactly, b=
ut
> >> this gets the first clock with pixclk <=3D rate), so if this check is =
also
> >> relaxed our displays would work out of the box.
> >>
> >> I also don't see any other bridge doing this kind of check.
> >> drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c has a similar check with a
> >> 0.5% leeway, and all the other drivers don't check anything.
> >> If you want to add some level of safety, I think we could make this wo=
rk
> >> with a 5% margin easily... Printing a warning in dmesg could work if
> >> you're worried about artifacts, but litteraly anything is better than =
a
> >> black screen with no error message in my opinion.
> >>
> >>
> >> In practice the screen I'm looking at has an EDID which only supports
> >> 51.2MHz and the closest frequency supported by the Samsung HDMI phy is
> >> 50.4MHz, so that's a ~1.5% difference and it'd be great if it could wo=
rk
> >> out of the box.
> >
> > For rate mismatches larger than the 0.5% allowed by the HDMI spec it
> > would be better to actually add PHY PLL parameters matching those
> > rates.
>
> I'd really like to be able to add more PHY PLL setpoints for displays
> that use non-CEA-861 modes. Unfortunately I didn't manage to figure out
> the fractional-n PLL parameter calculation so far.
>
> The i.MX8MP Reference Manual provides formulas to calculate the
> parameters based on the register values and I tried to make sense of it
> using the existing register values in the driver. But somehow it doesn't
> add up for me.
>
> Lucas, did you already work with the PLL parameters? By any chance, do
> you now how the math behind them works?

I spent a little time trying to understand it a bit.  I created a PMS
calculator similar to the one used on the DSI controller, except that
the M seems to be fixed at a value of 62 per the data sheet, so it's
more of a PS calculator.

Anyway, When I run my P-S calculator to generate the 'best rate' I get
a value that's usually 0.2% variance from nominal, but I only verified
a handful of values:

Several which were +0.2%
297600000 vs 297000000 (4k@30)
148800000 vs 148500000 (1080p60)
74400 vs 74200

One value was -0.16%
24800000 vs 25200000

If the M value was a bit more flexible, we might be able to reduce
that variance more.

If / when I get some time, I might play with trying to disable the
fractional mode and just use the PMS calculator for simplicity despite
the inaccuracy.  Maybe we could fall back to using the PMS calculator
if the desired frequency isn't in the look-up-table.

adam

>
> >
> > We could potentially add some more leeway for displays like yours that
> > aren't actually HDMI (as it doesn't seem to have a standard HDMI
> > resolution). But that's more of a last resort option, as it may
> > introduce other problems for displays that aren't as tolerant with
> > their input rates. Remember the mode_valid call is used to filter modes
> > that aren't compatible with the source, so for a display with multiple
> > modes allowing too much leeway may lead to incompatible modes not
> > getting tossed, in turn allowing userspace to set a mode that the
> > display may not like due to too much rate deviation, instead of only
> > presenting a list of valid modes. This again would present the user
> > with a black-screen without warning situation.
>
> What about adding some option to relax or remove the check for debugging
> purposes? Maybe combined with printing a warning message?
>
> I agree that we should prevent incompatible modes from passing the
> filter, but it would be really helpful if people had an easy way to
> relax/remove the check to see whether their display could potentially
> work without them needing to modify and recompile the kernel.
>
> Thanks
> Frieder

