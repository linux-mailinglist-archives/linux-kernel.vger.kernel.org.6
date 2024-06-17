Return-Path: <linux-kernel+bounces-217935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 187CC90B673
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEB1C23130
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830515EFDD;
	Mon, 17 Jun 2024 16:33:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C8179BD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642001; cv=none; b=uQMKeTyj+8sbZnn3Q0i9b23qu25k7GdUNh/kDXu7IgFLe8nViWNQQQ/1fcII29Tf08wY2uW7MvB1bBcjizIKvdkJtTBmweQSyX3iRdSeYbsfrEVYtlJO+G7oPXG6pHm5Fct9A6KDlIB0s0N5To17UAdKf0bO8wOamZYygt/AV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642001; c=relaxed/simple;
	bh=FxolhKuiPZ0Ipe7HDPour/ToBxXhG0cmgUyj62U0+Uk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r7QIL+bVq6x3t9goUxk6HeiaxNv4dOlTCtfLXVLH9s5GeyijXvdiE79Iispq8udIZpIBYg5wqg1mV8+s5sUxW8bWZn87wiFDfhZ592OqO1a8H0DHTQXIpTfaRhP99hFx5e2QmmgSf2Y5Js0QDUCisYyYjyEAxwgR22XjEOj08k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sJFHk-00033H-3A; Mon, 17 Jun 2024 18:32:48 +0200
Message-ID: <22a3f5266260dd3915269ae3eec7724f7537eb55.camel@pengutronix.de>
Subject: Re: drm/bridge/imx8mp-hdmi-tx: Allow inexact pixel clock
 frequencies (Was: [PATCH V8 10/12] drm/bridge: imx: add bridge wrapper
 driver for i.MX8MP DWC HDMI)
From: Lucas Stach <l.stach@pengutronix.de>
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>, Adam Ford
	 <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,  Jernej
 Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team
 <linux-imx@nxp.com>,  Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Liu Ying <victor.liu@nxp.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Makoto Sato <makoto.sato@atmark-techno.com>
Date: Mon, 17 Jun 2024 18:32:45 +0200
In-Reply-To: <Zm_UzO4Jmm7Aykcm@atmark-techno.com>
References: <20240203165307.7806-1-aford173@gmail.com>
	 <20240203165307.7806-11-aford173@gmail.com>
	 <Zm_UzO4Jmm7Aykcm@atmark-techno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Dominique,

Am Montag, dem 17.06.2024 um 15:16 +0900 schrieb Dominique MARTINET:
> Adam Ford wrote on Sat, Feb 03, 2024 at 10:52:50AM -0600:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >=20
> > Add a simple wrapper driver for the DWC HDMI bridge driver that
> > implements the few bits that are necessary to abstract the i.MX8MP
> > SoC integration.
>=20
> Hi Lucas, Adam,
> (trimmed ccs a bit)
>=20
> First, thank you for the effort of upstreaming all of this!! It's really
> appreciated, and with display working I'll really be wanting to upstream
> our DTS as well as soon as I have time (which is going to be a while,
> but better late than never ?)
>=20
> Until then, it's been a few months but I've got a question on this bit:
>=20
> > diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c b/drivers/gpu/=
drm/bridge/imx/imx8mp-hdmi-tx.c
> > new file mode 100644
> > index 000000000000..89fc432ac611
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > +static enum drm_mode_status
> > +imx8mp_hdmi_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
> > +		       const struct drm_display_info *info,
> > +		       const struct drm_display_mode *mode)
> > +{
> > +	struct imx8mp_hdmi *hdmi =3D (struct imx8mp_hdmi *)data;
> > +
> > +	if (mode->clock < 13500)
> > +		return MODE_CLOCK_LOW;
> > +
> > +	if (mode->clock > 297000)
> > +		return MODE_CLOCK_HIGH;
> > +
> > +	if (clk_round_rate(hdmi->pixclk, mode->clock * 1000) !=3D
> > +	    mode->clock * 1000)
> > +		return MODE_CLOCK_RANGE;
>=20
> Do you know why such a check is here?

Sending a HDMI signal with a different rate than what the display
expects rarely ends well, so this check avoids that.

However, this check is a bit overcautious in that it only allows exact
rate matches. IIRC HDMI allows a rate mismatch of +- 0.5%, so this
check could be relaxed quite a bit to allow for that.
>=20
> When plugging in a screen with no frequency identically supported in its
> EDID this check causes the screen to stay black, and we've been telling
> customers to override the EDID but it's a huge pain.
>=20
> Commit 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY") already
> "fixed" the samsung hdmi phy driver to return the next frequency if an
> exact match hasn't been found (NXP tree's match frequencies exactly, but
> this gets the first clock with pixclk <=3D rate), so if this check is als=
o
> relaxed our displays would work out of the box.
>=20
> I also don't see any other bridge doing this kind of check.
> drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c has a similar check with a
> 0.5% leeway, and all the other drivers don't check anything.
> If you want to add some level of safety, I think we could make this work
> with a 5% margin easily... Printing a warning in dmesg could work if
> you're worried about artifacts, but litteraly anything is better than a
> black screen with no error message in my opinion.
>=20
>=20
> In practice the screen I'm looking at has an EDID which only supports
> 51.2MHz and the closest frequency supported by the Samsung HDMI phy is
> 50.4MHz, so that's a ~1.5% difference and it'd be great if it could work
> out of the box.

For rate mismatches larger than the 0.5% allowed by the HDMI spec it
would be better to actually add PHY PLL parameters matching those
rates.

We could potentially add some more leeway for displays like yours that
aren't actually HDMI (as it doesn't seem to have a standard HDMI
resolution). But that's more of a last resort option, as it may
introduce other problems for displays that aren't as tolerant with
their input rates. Remember the mode_valid call is used to filter modes
that aren't compatible with the source, so for a display with multiple
modes allowing too much leeway may lead to incompatible modes not
getting tossed, in turn allowing userspace to set a mode that the
display may not like due to too much rate deviation, instead of only
presenting a list of valid modes. This again would present the user
with a black-screen without warning situation.

Regards,
Lucas

>=20
> For reference, the output of edid-decode is as follow:
> ---
> edid-decode /sys/devices/platform/display-subsystem/drm/car
> d1/card1-HDMI-A-1/edid
> edid-decode (hex):
>=20
> 00 ff ff ff ff ff ff 00 3a 49 03 00 01 00 00 00
> 20 1e 01 03 80 10 09 00 0a 00 00 00 00 00 00 00
> 00 00 00 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 00 14 00 40 41 58 23 20 a0 20
> c8 00 9a 56 00 00 00 18 00 00 00 10 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 9a
>=20
> ----------------
>=20
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
>=20
>=20
> Thanks,


