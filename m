Return-Path: <linux-kernel+bounces-310746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 026139680C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EFA6B2173C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7CE176FD2;
	Mon,  2 Sep 2024 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms99ThQw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EF83C00;
	Mon,  2 Sep 2024 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262613; cv=none; b=dcpR2tIt2wjDhFeMtUWcTsTJzg8P9cMwsq2C3CYyqhPlMldmWA/CryvizK+W6lVI9YES5EMbad5r8LHlvMEck+sgY8ASSEPeX9oLjiF6n48K/63/xRkZWNfdgfX75ueWv87ulwwDvmnQCGP6p801E49LZwOY8nOc5xnDQyir73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262613; c=relaxed/simple;
	bh=THObozqjtraO221EbGm1VZ5bqgAUOHDBtFWxw964ETo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ooz2p/9oXSSiZ7kLbn3EhLmi9/V0V/lKkpX13Yys+5H8Way4NvRbbUKcQU5huZeyddY/A5bo6DRUkISITiRzr3jYZgGVjK/yG2DvHhoFSar1ISgc1AQbNWMXiJxmGUK3Dxrzbe3K+ugh+0Tkzy+BL3XC3JmJ5R0nPQAVvUryW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms99ThQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B646C4CEC2;
	Mon,  2 Sep 2024 07:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725262612;
	bh=THObozqjtraO221EbGm1VZ5bqgAUOHDBtFWxw964ETo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ms99ThQwnMZoRjOgfAnyWEE52KNTc1+M+c76I0B1LSKuZ2Bc0SFidbfQ62CWjSVDa
	 kr74Hmgs6y/Nmr3IjQAEBHXIM2marZv51TpvILNCTOh83efOlZKtr/v0GP/uC5OQe3
	 HtYCbEFCb2lO4L3lx+iRdnp4XHf08fAl+tT4rMQHE0G5zR/yseSbUlvTlcQYu8k5/e
	 zmk1aOOenjiGeSBPLn5K/riC7naV4nOF/tzXzbo2WPcs3TTO1zqW6AWYU1GzZwPYjE
	 acUM3+4hbm/W1lvXur9m68O7n2NLIrdoXW7bV/sLdjbPq2NYtIloEq1OSopc0TQ4UT
	 8rMQD0ddYX2jg==
Date: Mon, 2 Sep 2024 09:36:50 +0200
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
Message-ID: <20240902-turtle-of-major-glory-efb4e8@houat>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <20240819-b4-rk3588-bridge-upstream-v4-2-6417c72a2749@collabora.com>
 <20240827-armored-magnificent-badger-ffb025@houat>
 <34422b7a-ce70-445d-a574-60ac36322119@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="wrzxqzphrlcany36"
Content-Disposition: inline
In-Reply-To: <34422b7a-ce70-445d-a574-60ac36322119@collabora.com>


--wrzxqzphrlcany36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 01:21:48AM GMT, Cristian Ciocaltea wrote:
> On 8/27/24 11:58 AM, Maxime Ripard wrote:
> > On Mon, Aug 19, 2024 at 01:29:29AM GMT, Cristian Ciocaltea wrote:
> >> +static irqreturn_t dw_hdmi_qp_main_hardirq(int irq, void *dev_id)
> >> +{
> >> +	struct dw_hdmi_qp *hdmi =3D dev_id;
> >> +	struct dw_hdmi_qp_i2c *i2c =3D hdmi->i2c;
> >> +	u32 stat;
> >> +
> >> +	stat =3D dw_hdmi_qp_read(hdmi, MAINUNIT_1_INT_STATUS);
> >> +
> >> +	i2c->stat =3D stat & (I2CM_OP_DONE_IRQ | I2CM_READ_REQUEST_IRQ |
> >> +			    I2CM_NACK_RCVD_IRQ);
> >> +
> >> +	if (i2c->stat) {
> >> +		dw_hdmi_qp_write(hdmi, i2c->stat, MAINUNIT_1_INT_CLEAR);
> >> +		complete(&i2c->cmp);
> >> +	}
> >> +
> >> +	if (stat)
> >> +		return IRQ_HANDLED;
> >> +
> >> +	return IRQ_NONE;
> >> +}
> >=20
> > If the scrambler is enabled, you need to deal with hotplug. On hotplug,
> > the monitor will drop its TMDS ratio and scrambling status, but the
> > driver will keep assuming it's been programmed.
> >=20
> > If you don't have a way to deal with hotplug yet, then I'd suggest to
> > just drop the scrambler setup for now.
>=20
> Thanks for the heads up!
>=20
> HPD is partially handled by the RK platform driver, which makes use of
> drm_helper_hpd_irq_event(). Since the bridge sets DRM_BRIDGE_OP_DETECT
> flag, the dw_hdmi_qp_bridge_detect() callback gets executed, which in turn
> verifies the PHY status via ->read_hpd() implemented as
> dw_hdmi_qp_rk3588_read_hpd() in the platform driver.

It's not only about hotplug detection, it's also about what happens
after you've detected a disconnection / reconnection.

The framework expects to keep the current mode as is, despite the
monitor not being setup to use the scrambler anymore, and the display
remains black.

> During my testing so far it worked reliably when switching displays with
> different capabilities.  I don't have a 4K@60Hz display at the moment, but
> used the HDMI RX port on the Rock 5B board in a loopback connection to
> verify this mode, which triggered the high TMDS clock ratio and scrambling
> setup as well.

How did you test exactly?

Maxime

--wrzxqzphrlcany36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZtVrDQAKCRAnX84Zoj2+
diimAYCLSBf4aL43PYdfrLmm+dcjJ3Ntv61sabKRj+I99ElR2CzjU5X15XDJRhy4
7DlHP7QBgJDvJLEChcXiPKKmoMdbojebpow32S+1IQz8IIJ1A/mVwiVMhhX/9dGS
l6pDQRfQtw==
=s4gD
-----END PGP SIGNATURE-----

--wrzxqzphrlcany36--

