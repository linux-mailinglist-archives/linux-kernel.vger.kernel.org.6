Return-Path: <linux-kernel+bounces-436907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A99E8C70
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384E816301C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC5521505E;
	Mon,  9 Dec 2024 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="inHsnQYf"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62E15575F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730122; cv=none; b=oPAkOJvZR1r+S9QpHnXcaAIEuWGnxl2y/cdgYcFxRzJO6MoAxI/Z+aVzx/d2rUYdwkfqj5aEQ4/T9OjmqZ4uFtY7L34QaiXkuGPpw6LDSiqm5H9tVk18lR2UH+rtzoeNqpocOU+6WA6SYBEBiGqqcHuDEOuHVOHXJf3ntj3g340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730122; c=relaxed/simple;
	bh=rapGzakJibp04i5NC4/8LsOno52rB3ZlGimGhoi2qLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ul1XUHJONHFPOOesY23TXqy7qSqwEcBghrXBZOOmgh5MvzkIuDmwB+htpqY8z7/ZcFpKo9F56PYzzWiOBcgZR2VqHZMun1Lhi6bkAV0LENLqhvH8NN9NP4B8sRqMP8bOejZNZAe/ACHXus7h4tFSOKqA8HSXPZMOq+8ku0Oeg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=inHsnQYf; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id F1BDF240105
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:41:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1733730110; bh=rapGzakJibp04i5NC4/8LsOno52rB3ZlGimGhoi2qLM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=inHsnQYfwTPgydM1fSqQJ+U3+LSw5UCgRLInTbd1KNxCwoBv0ZZ1DglHk/DvokW0O
	 QpLomSfcNUi/fI8eb5Vc+xJahQOgbroswPpM4KaZ7hHb9gAX0zhlpWYKiUO1zKBaeR
	 efn4p0GeCoP/UV+RjIaPXLZ+JEYdJtBTCFkRzL4zHfRGwnvogdPhDUIw8Sg85zP8m5
	 jjCbqvlLcSkQO8n5XpJHnfHskLIOukyit0KOCbWZNtGx96zHW92b5vPKaE4iS37eg5
	 7qx5XB5IqT1LjDK0h3VWoZRkCaoFugcsrJy02njUpy4K9BjIpPGzpAH8YivMD06DEd
	 03I9sP5OVQu9Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Y6DMW6R48z9rxB;
	Mon,  9 Dec 2024 08:41:43 +0100 (CET)
Message-ID: <384913986510d3bb5ca198962dd5a124b9282853.camel@posteo.de>
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
From: Martin Kepplinger <martink@posteo.de>
To: Nikolaus Voss <nv@vosn.de>, Liu Ying <victor.liu@oss.nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, Liu Ying
 <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Fabio
 Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nikolaus.voss@haag-streit.com, miquel.raynal@bootlin.com
Date: Mon, 09 Dec 2024 07:41:43 +0000
In-Reply-To: <000b34cdd1591c82265ce1f9848828d1@vosn.de>
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
	 <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
	 <000b34cdd1591c82265ce1f9848828d1@vosn.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Montag, dem 02.12.2024 um 11:13 +0100 schrieb Nikolaus Voss:
> Hi Liu,
>=20
> On 02.12.2024 07:32, Liu Ying wrote:
> > On 11/27/2024, Nikolaus Voss wrote:
> > > LDB clock has to be a fixed multiple of the pixel clock.
> > > As LDB and pixel clock are derived from different clock sources
> > > (at least on imx8mp), this constraint cannot be satisfied for
> > > any pixel clock, which leads to flickering and incomplete
> > > lines on the attached display.
> > >=20
> > > To overcome this, check this condition in mode_fixup() and
> > > adapt the pixel clock accordingly.
> > >=20
> > > Cc: <stable@vger.kernel.org>
> >=20
> > It looks like stable is not effectively Cc'ed.
> > Need a Fixes tag?
>=20
> I will include
> Fixes: 463db5c2ed4a ("drm: bridge: ldb: Implement simple Freescale=20
> i.MX8MP LDB bridge")
> in v2.
>=20
> >=20
> > >=20
> > > Signed-off-by: Nikolaus Voss <nv@vosn.de>
> > > ---
> > > =C2=A0drivers/gpu/drm/bridge/fsl-ldb.c | 40=20
> > > ++++++++++++++++++++++++++++----
> > > =C2=A01 file changed, 36 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c=20
> > > b/drivers/gpu/drm/bridge/fsl-ldb.c
> > > index 0e4bac7dd04ff..e341341b8c600 100644
> > > --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> > > +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> > > @@ -104,12 +104,14 @@ static inline struct fsl_ldb
> > > *to_fsl_ldb(struct=20
> > > drm_bridge *bridge)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return container_of(b=
ridge, struct fsl_ldb, bridge);
> > > =C2=A0}
> > >=20
> > > +static unsigned int fsl_ldb_link_freq_factor(const struct
> > > fsl_ldb=20
> > > *fsl_ldb)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return fsl_ldb_is_dual(fsl=
_ldb) ? 3500 : 7000;
> > > +}
> > > +
> > > =C2=A0static unsigned long fsl_ldb_link_frequency(struct fsl_ldb
> > > *fsl_ldb,=20
> > > int clock)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fsl_ldb_is_dual(fsl_ld=
b))
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return clock * 3500;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return clock * 7000;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return clock * fsl_ldb_lin=
k_freq_factor(fsl_ldb);
> > > =C2=A0}
> > >=20
> > > =C2=A0static int fsl_ldb_attach(struct drm_bridge *bridge,
> > > @@ -121,6 +123,35 @@ static int fsl_ldb_attach(struct drm_bridge=20
> > > *bridge,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bridge, flags);
> > > =C2=A0}
> > >=20
> > > +static bool fsl_ldb_mode_fixup(struct drm_bridge *bridge,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct drm_display_mode
> > > *mode,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct drm_display_mode
> > > *adjusted_mode)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct fsl_ldb *fsl_=
ldb =3D to_fsl_ldb(bridge);
> >=20
> > Why const?
> > If no const, then ...
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long requested_li=
nk_freq =3D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0mode->clock * fsl_ldb_link_freq_factor(fsl_ldb);
> >=20
> > ... this could be
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long requested_link=
_freq =3D
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsl_ldb_link_frequency(fsl_ldb,=
=20
> > mode->clock);
>=20
> I used fsl_ldb_link_freq_factor(fsl_ldb) to point out the symmetry to
> recalculate
> pclk =3D freq / fsl_ldb_link_freq_factor(fsl_ldb) below:
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long freq =3D clk=
_round_rate(fsl_ldb->clk,=20
> > > requested_link_freq);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (freq !=3D requested_li=
nk_freq) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * this will lead to flicker and incomplete lines
> > > on
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * the attached display, adjust the CRTC clock
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * accordingly.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0int pclk =3D freq /
> > > fsl_ldb_link_freq_factor(fsl_ldb);
> >=20
> > I doubt that pixel clock tree cannot find appropriate division
> > ratios
> > for some pixel clock rates, especially for dual-link LVDS on
> > i.MX8MP
> > and i.MX93 platforms, because PLL clock rate should be 7x faster
> > than
> > pixel clock rate and 2x faster than "ldb" clock rate so that the
> > 3.5
> > folder between "ldb" clock and pixel clock can be met. That means
> > the
> > PLL clock rate needs to be explicitly set first for this case.
> >=20
> > Can you assign the PLL clock rate in DT to satisfy the "ldb" and
> > pixel
> > clock rates like the below commit does, if you use a LVDS panel?
> >=20
> > 4fbb73416b10 ("arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1
> > frequency to 506.8 MHz")
>=20
> I probably could. The point of my patch is you don't have to know in
> advance which LVDS panel is connected, and you don't have to
> calculate
> the base PLL clock by hand and store it in the device tree.
>=20
> In my test system, I have three different LVDS panels with EDID
> EEPROM,
> none of which worked with the stock driver, but all work with this=20
> patch.
> With slightly adapted pixel clocks though.
>=20
> The driver already warns if LDB and PCLK don't match, because this is
> a
> hardware constraint and violating this will lead to no image or image
> distortion. With the patch the driver tries to fix that.
>=20
> I don't know if it works for all or at least most panels, but for my=20
> panels
> it does. And if the clocks match, by chance or by refconfiguring the
> PLL=20
> base
> clock, the patch does nothing.

just as a data point, I'm very happy with this patch as it make my 51,2
MHz lvds panel just work without doing anything else. I'll happily
carry it along for v6.12 if it's not going into stable :)

                                  martin


