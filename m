Return-Path: <linux-kernel+bounces-312431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C6C96968D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF679B222CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9264201244;
	Tue,  3 Sep 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nELPphkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8B1D61AB;
	Tue,  3 Sep 2024 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350949; cv=none; b=U2EKKdzYX6yA9ZaNRCzgeCAvrfv9AlmJECXI2ddlBfugUZchMnOF4ge33+n1fBFDLBGou7CwMWtoHCi1L54WYF9yHKYW/xUeS7JD+zrxU3F+OKiatvLlzizoHvhc6Zv+JLRpixwNvRZpGZ2eJA6/8luWAZUPT7M3GdcDKrRmhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350949; c=relaxed/simple;
	bh=TbqJLpMF0XWfw9iBgitkWAPhHwKfcmKdJuvN+p4cqg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVKtbNU+JiY3kGwepQGdN+XrclyS57m6NJaYm3X0zuWGF9Dyp3IjZWrM+k0AYH0sEDJH2ia3dUnnV5MAH0PuWk428O2zI6dvnb5hfVlOZ2MjMj1qExkD59Sy5DWYZ1oF6x5fNZqNBaJlSGnF9zDPpVIwO5YyeaHRzPEEVufxwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nELPphkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C52C4CEC5;
	Tue,  3 Sep 2024 08:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725350948;
	bh=TbqJLpMF0XWfw9iBgitkWAPhHwKfcmKdJuvN+p4cqg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nELPphkKRLsS5HSNEQ5yWbd92Ozfba9oki8Y9Vry2iUrRdtIUXpiHE7lT6Nb4WQY0
	 Galwr+I/rUVcJKYVgUM4/hjz7GkauaAHPodvUTFZQzglnIk3ykzZ7zQCQstK7C1Y6x
	 rTIHZFODSgVUM+LolPAoWcAjpVgq3X7cksMRyx3xcvMWdwCKftcv9Ew3My4r0LbkyS
	 fBHozh+TGAjCQKDu4/L1XcgRkTfub/BRj8buGxB/jHx9u5OQdNXw7ueQY54Aj/8Ni0
	 HlGGgrZitu0YKXsHkb3SXwWhuW/NJ/V0CuZfrXz7oCrmhnZRl0DPdpJxcoMhFRXTU5
	 kH60m5Fu0EUsQ==
Date: Tue, 3 Sep 2024 10:09:06 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>, 
	Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH v4 2/4] drm/bridge: synopsys: Add DW HDMI QP TX
 Controller support library
Message-ID: <20240903-archetypal-soft-wildebeest-b5ea68@houat>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <20240819-b4-rk3588-bridge-upstream-v4-2-6417c72a2749@collabora.com>
 <20240827-armored-magnificent-badger-ffb025@houat>
 <34422b7a-ce70-445d-a574-60ac36322119@collabora.com>
 <20240902-turtle-of-major-glory-efb4e8@houat>
 <6e20410a-a24d-4454-8577-2cff65319a2a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="u6nfncdlj65oeoqx"
Content-Disposition: inline
In-Reply-To: <6e20410a-a24d-4454-8577-2cff65319a2a@collabora.com>


--u6nfncdlj65oeoqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024 at 12:12:02AM GMT, Cristian Ciocaltea wrote:
> On 9/2/24 10:36 AM, Maxime Ripard wrote:
> > On Sat, Aug 31, 2024 at 01:21:48AM GMT, Cristian Ciocaltea wrote:
> >> On 8/27/24 11:58 AM, Maxime Ripard wrote:
> >>> On Mon, Aug 19, 2024 at 01:29:29AM GMT, Cristian Ciocaltea wrote:
> >>>> +static irqreturn_t dw_hdmi_qp_main_hardirq(int irq, void *dev_id)
> >>>> +{
> >>>> +	struct dw_hdmi_qp *hdmi =3D dev_id;
> >>>> +	struct dw_hdmi_qp_i2c *i2c =3D hdmi->i2c;
> >>>> +	u32 stat;
> >>>> +
> >>>> +	stat =3D dw_hdmi_qp_read(hdmi, MAINUNIT_1_INT_STATUS);
> >>>> +
> >>>> +	i2c->stat =3D stat & (I2CM_OP_DONE_IRQ | I2CM_READ_REQUEST_IRQ |
> >>>> +			    I2CM_NACK_RCVD_IRQ);
> >>>> +
> >>>> +	if (i2c->stat) {
> >>>> +		dw_hdmi_qp_write(hdmi, i2c->stat, MAINUNIT_1_INT_CLEAR);
> >>>> +		complete(&i2c->cmp);
> >>>> +	}
> >>>> +
> >>>> +	if (stat)
> >>>> +		return IRQ_HANDLED;
> >>>> +
> >>>> +	return IRQ_NONE;
> >>>> +}
> >>>
> >>> If the scrambler is enabled, you need to deal with hotplug. On hotplu=
g,
> >>> the monitor will drop its TMDS ratio and scrambling status, but the
> >>> driver will keep assuming it's been programmed.
> >>>
> >>> If you don't have a way to deal with hotplug yet, then I'd suggest to
> >>> just drop the scrambler setup for now.
> >>
> >> Thanks for the heads up!
> >>
> >> HPD is partially handled by the RK platform driver, which makes use of
> >> drm_helper_hpd_irq_event(). Since the bridge sets DRM_BRIDGE_OP_DETECT
> >> flag, the dw_hdmi_qp_bridge_detect() callback gets executed, which in =
turn
> >> verifies the PHY status via ->read_hpd() implemented as
> >> dw_hdmi_qp_rk3588_read_hpd() in the platform driver.
> >=20
> > It's not only about hotplug detection, it's also about what happens
> > after you've detected a disconnection / reconnection.
> >=20
> > The framework expects to keep the current mode as is, despite the
> > monitor not being setup to use the scrambler anymore, and the display
> > remains black.
>=20
> AFAICS, the ->atomic_enable() callback is always invoked upon
> reconnection, hence the scrambler gets properly (re)enabled via
> dw_hdmi_qp_setup().

No, it's not.

> >> During my testing so far it worked reliably when switching displays wi=
th
> >> different capabilities.  I don't have a 4K@60Hz display at the moment,=
 but
> >> used the HDMI RX port on the Rock 5B board in a loopback connection to
> >> verify this mode, which triggered the high TMDS clock ratio and scramb=
ling
> >> setup as well.
> >=20
> > How did you test exactly?
>=20
> I initially tested with Sway/wlroots having an app running
> (eglgears_wayland) while unplugging/replugging the HDMI connectors in
> every possible sequence I could think of (e.g. several times per
> display, switching to a different one, repeating, switching again, etc).
>=20
> I've just retested the whole stuff with Weston and confirm it works as
> expected, i.e. no black screen (or bad capture stream for the 4K@60Hz
> case) after any of the reconnections.

Then I guess both sway and weston handle uevent and will change the
connector mode on reconnection.

It's not mandatory, and others will just not bother and still expect the
output to work.

I guess the easier you can test this with is modetest.

Maxime

--u6nfncdlj65oeoqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZtbEHAAKCRAnX84Zoj2+
dub0AYD0Bik1Z1shXpdUCtIQQK7qy/5wlAsZL3p3sO9HNoDd5B/N9090NF138Duw
JWODhtABgJVad/VI2n0akz4qsN+7f3oCFehQNCxGLwAVW4o6i+6mdm0zoZl5IBuz
Wwu/9lx0cw==
=RMT3
-----END PGP SIGNATURE-----

--u6nfncdlj65oeoqx--

