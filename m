Return-Path: <linux-kernel+bounces-217567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059890B19C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015FA1C211F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFC0199E97;
	Mon, 17 Jun 2024 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQl2mChG"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9A199E8B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630952; cv=none; b=tjP4qK5nnn6krLYOmo4afd8bxcDo1Yp5WFe8Ar6khrJH215sEH89FyjOoUvH57D4HmJYWLpp0HtUgsZVwDX/qaqMcFzfB9Y4uNHPAPjUc9PtAIi1lmk15zU/vJqt/nIKj47VUYpqfAtzUNCMPWjILrDkCNfD5ZkqqtZtXeOxWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630952; c=relaxed/simple;
	bh=Yc0EuuuvuIobJasWUoS+pkdhx8hRPcrDkQa+cROqMhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qklcpDfsqGEwHHoL3pSu2TH9Dg8tES0I5VRwlYbXiZAkfDfroZUTieSr3xPw7cKj2yCn+GG/TBsM47+M7aDoo9OhzPuiyc8X2EVxerxs/Wz430C29a3/6V/tuy7jM4YXsiwrxXDsb+gAG7cMWAT8PktnzTPMqKTC0AoXTjMAYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQl2mChG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c4af25f7d7so3725275a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718630950; x=1719235750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9q+Z4GD9MpvcYkpXfGOgXbR7/P8MYbKwiRSUUKubKM=;
        b=mQl2mChGD3t9dy/X0AWYDPyTH+dPHGLsInNUo7fL13AZeQQv6OoN/A5X616J/cQMbb
         pxOOuStunQNi8cLre3FzH1ZRx55WF93vfq0OneNS0Q/A8RUcYbousSNeAzbmIFvh7U5F
         AUn3uzfSCHIUVUb2N0ur5CDZ1nCodFKLMFdkqeCQ+Cs8t964I3Efx3detM//oqXCKX5u
         SRoaNvAT/H1eYgpQTzedEizTXf3nqA0blF2W8F3awLoDSyOiSXxA1a+NRXaMnPnJ3LGk
         UAWYjZw+pimOfajHmyH7QdcuZ8z6A5WO4c5HAzU/mhRXODk+rq8PEDhH99qTYSCt+kGJ
         4mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630950; x=1719235750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9q+Z4GD9MpvcYkpXfGOgXbR7/P8MYbKwiRSUUKubKM=;
        b=jSEtfPKPwsv1HEL3K7g/GXDHkjPxipUUh+xf5LGECVk0cSMwOl0mZUstRmUA89tiLp
         zVwmtlofy+wi8G54D3ujU+awqR3tUU0NuQRVx7UseWjKf2KKCNSyhQU++dcBaNQtDDPB
         pX5OMrOrP+T40/zIQ/J7POHxVxNtvb5liN3js6M2kAFR5TrR6/A7RqewpivnRJq39jW4
         w/rPvsE0A4pmOEn99VExI/MebR2eoGq0YoQZ84NaXj0KvAMcUw9frYEGwbnHbWzJ/UR7
         TP6fYubRktyGF6NqMvYZZ5YxctSYagicbJC2mtt2FNdcq3vFPwhvrjWSPWQFS9x8H+qr
         c9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWnohkPHhISOLAsqOE1h69omfEYylYU3GkxeesGFT6+rEGANJABT0ZUKpX9NMuy0dvYDG13BC3cIXclTZ1KK1LU8JRfWHUC4ELY6CU7
X-Gm-Message-State: AOJu0YyRBmtWqRv5aAkUg/H7r2bMee0wiS4X5qMJIBYL4grl5OyabvnR
	DGk7g172FjeSgKWl03AHbH3uwv8bUsw+/yOg9WHHGTgOjbL8/bEw/s0PtDZrZkguWCvt/Hn0nba
	NT/2EyZqk2EX2IM5vs0MRyrIsQEI=
X-Google-Smtp-Source: AGHT+IFHNQnVqTbXey7rmOHY9zC5Gl6630C23KaIy8xKqNcUDOtRiu3TC30yfGx+t6zBKRWmGgrhzjL5YAGs06H5CPg=
X-Received: by 2002:a17:90a:2dc6:b0:2bd:f4cb:bd87 with SMTP id
 98e67ed59e1d1-2c4db24e973mr9926240a91.14.1718630949878; Mon, 17 Jun 2024
 06:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-11-aford173@gmail.com>
 <Zm_UzO4Jmm7Aykcm@atmark-techno.com>
In-Reply-To: <Zm_UzO4Jmm7Aykcm@atmark-techno.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 17 Jun 2024 08:28:58 -0500
Message-ID: <CAHCN7xJt+1WGFYeBii1jUDEg9OU176f0AA+rMkXCqNQrfq=XWg@mail.gmail.com>
Subject: Re: drm/bridge/imx8mp-hdmi-tx: Allow inexact pixel clock frequencies
 (Was: [PATCH V8 10/12] drm/bridge: imx: add bridge wrapper driver for i.MX8MP
 DWC HDMI)
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
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

On Mon, Jun 17, 2024 at 1:17=E2=80=AFAM Dominique MARTINET
<dominique.martinet@atmark-techno.com> wrote:
>
> Adam Ford wrote on Sat, Feb 03, 2024 at 10:52:50AM -0600:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > Add a simple wrapper driver for the DWC HDMI bridge driver that
> > implements the few bits that are necessary to abstract the i.MX8MP
> > SoC integration.
>
> Hi Lucas, Adam,
> (trimmed ccs a bit)
>
> First, thank you for the effort of upstreaming all of this!! It's really
> appreciated, and with display working I'll really be wanting to upstream
> our DTS as well as soon as I have time (which is going to be a while,
> but better late than never ?)
>
> Until then, it's been a few months but I've got a question on this bit:
>
> > diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c b/drivers/gpu/=
drm/bridge/imx/imx8mp-hdmi-tx.c
> > new file mode 100644
> > index 000000000000..89fc432ac611
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > +static enum drm_mode_status
> > +imx8mp_hdmi_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
> > +                    const struct drm_display_info *info,
> > +                    const struct drm_display_mode *mode)
> > +{
> > +     struct imx8mp_hdmi *hdmi =3D (struct imx8mp_hdmi *)data;
> > +
> > +     if (mode->clock < 13500)
> > +             return MODE_CLOCK_LOW;
> > +
> > +     if (mode->clock > 297000)
> > +             return MODE_CLOCK_HIGH;
> > +
> > +     if (clk_round_rate(hdmi->pixclk, mode->clock * 1000) !=3D
> > +         mode->clock * 1000)
> > +             return MODE_CLOCK_RANGE;
>
> Do you know why such a check is here?

I didn't write the original code, so I'll defer to Lucas here.  I just
tried to edit/fix issues as they were identified to get it pushed
upstream.

>
> When plugging in a screen with no frequency identically supported in its
> EDID this check causes the screen to stay black, and we've been telling
> customers to override the EDID but it's a huge pain.
>
> Commit 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY") already
> "fixed" the samsung hdmi phy driver to return the next frequency if an
> exact match hasn't been found (NXP tree's match frequencies exactly, but
> this gets the first clock with pixclk <=3D rate), so if this check is als=
o
> relaxed our displays would work out of the box.

Are you proposing to replace 'return MODE_CLOCK_RANGE' with a printed warni=
ng?

>
> I also don't see any other bridge doing this kind of check.
> drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c has a similar check with a
> 0.5% leeway, and all the other drivers don't check anything.
> If you want to add some level of safety, I think we could make this work
> with a 5% margin easily... Printing a warning in dmesg could work if
> you're worried about artifacts, but litteraly anything is better than a
> black screen with no error message in my opinion.
>
>
> In practice the screen I'm looking at has an EDID which only supports
> 51.2MHz and the closest frequency supported by the Samsung HDMI phy is
> 50.4MHz, so that's a ~1.5% difference and it'd be great if it could work
> out of the box.

I wonder if the HDMI PHY could be improved to better dynamically
calculate values instead of the look tables.

adam
>
> For reference, the output of edid-decode is as follow:
> ---
> edid-decode /sys/devices/platform/display-subsystem/drm/car
> d1/card1-HDMI-A-1/edid
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 3a 49 03 00 01 00 00 00
> 20 1e 01 03 80 10 09 00 0a 00 00 00 00 00 00 00
> 00 00 00 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 00 14 00 40 41 58 23 20 a0 20
> c8 00 9a 56 00 00 00 18 00 00 00 10 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 9a
>
> ----------------
>
> Block 0, Base EDID:
>   EDID Structure Version & Revision: 1.3
>   Vendor & Product Identification:
>     Manufacturer: NRI
>     Model: 3
>     Serial Number: 1
>     Made in: week 32 of 2020
>   Basic Display Parameters & Features:
>     Digital display
>     Maximum image size: 16 cm x 9 cm
>     Gamma: 1.00
>     RGB color display
>     First detailed timing is the preferred timing
>   Color Characteristics:
>     Red  : 0.0000, 0.0000
>     Green: 0.0000, 0.0000
>     Blue : 0.0000, 0.0000
>     White: 0.0000, 0.0000
>   Established Timings I & II: none
>   Standard Timings: none
>   Detailed Timing Descriptors:
>     DTD 1:  1024x600    59.993 Hz 128:75   38.095 kHz  51.200 MHz (154 mm=
 x 86 m
> m)
>                  Hfront  160 Hsync  32 Hback 128 Hpol N
>                  Vfront   12 Vsync   8 Vback  15 Vpol N
>     Dummy Descriptor:
>     Dummy Descriptor:
>     Dummy Descriptor:
> Checksum: 0x9a
> ---
>
>
> Thanks,
> --
> Dominique Martinet
>
>
>
> --
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

