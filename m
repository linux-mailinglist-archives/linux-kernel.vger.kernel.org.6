Return-Path: <linux-kernel+bounces-335558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF06897E76B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13E5281709
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AD319341D;
	Mon, 23 Sep 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeYVMNc/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72B6F2EB;
	Mon, 23 Sep 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079590; cv=none; b=S/MB5YycTgH2zVRoUC/y74/136Y0ZH+82I7m4GLCz8bdtqSWC9qVru9qXoFj8S+PxRWcdOq/PN9g0LkGENKgCkIa38IrZrwYXgKKNY0zXKQMky0Wp48tVPELKR/8AQ3mUK2to6oynJ1TsR1JD0ls6nrzRkhbu5P6ReS/QAPzjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079590; c=relaxed/simple;
	bh=gQ1xXXNFSQ0hMp/hqA4GAQ7kD/mpS6i/zp2Gmw3vPRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2pi1cxRPiHMQpefEVMvFXojwvCQRywqKWoTHrq68faLrSFg8fI+YWai8I5se7YFJl/eAIf/cg2eU3lpHBLT6X01fvhnYNzoiI9ydRxEpOJfVt3dstQp/aLEPsjwo/9iS5joblMe64QoQULSS0TEMKpij9hDLV8S7cGP4Cpp3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeYVMNc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEB1C4CEC4;
	Mon, 23 Sep 2024 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727079589;
	bh=gQ1xXXNFSQ0hMp/hqA4GAQ7kD/mpS6i/zp2Gmw3vPRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeYVMNc/c1PpcDq/PGTNH8EeH683lhQ22/Ye7Wa4pPsxVuDDsLY7Q9JyzQS1As9ys
	 1FxD65e/lBiV5VktoD0dv2pZ7FLgoeIFKJEwS9agXwshH7aqAKWq63ZP+UjytmPKLu
	 yAIQUsTNGCMG1aQpwo4+9E1W77uhKT3AXbPHR4683BNeokwEgHhRfR2eHDuZoIv+nH
	 WB483aJV+y58kgAC0/JTULv4RpA1WkJEg+q+q2T6+pLYIygf3JBmgW7xmVAplusijv
	 wrTGbbhIB55EzaYYVnuIWO5abH1Uweoc6XHXEdDjVa2BsDSfs8pb/9aWkxwrnz6+mn
	 A7DeNA4vO15LA==
Date: Mon, 23 Sep 2024 10:19:46 +0200
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
Subject: Re: [PATCH v6 1/3] drm/bridge: synopsys: Add DW HDMI QP TX
 Controller support library
Message-ID: <20240923-spirited-wealthy-pelican-4e15dc@penduick>
References: <20240906-b4-rk3588-bridge-upstream-v6-0-a3128fb103eb@collabora.com>
 <20240906-b4-rk3588-bridge-upstream-v6-1-a3128fb103eb@collabora.com>
 <20240909-horned-congenial-curassow-ebc5fa@houat>
 <f8b17995-ce53-45ab-8e68-c7087dbc9786@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bjmxjjuhmv2zdjhq"
Content-Disposition: inline
In-Reply-To: <f8b17995-ce53-45ab-8e68-c7087dbc9786@collabora.com>


--bjmxjjuhmv2zdjhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 10:12:29PM GMT, Cristian Ciocaltea wrote:
> Hi Maxime,
>=20
> On 9/9/24 6:13 PM, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Fri, Sep 06, 2024 at 04:17:40AM GMT, Cristian Ciocaltea wrote:
> >> +static enum drm_connector_status
> >> +dw_hdmi_qp_bridge_detect(struct drm_bridge *bridge)
> >> +{
> >> +	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> >> +	enum drm_connector_status status;
> >> +
> >> +	status =3D hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> >> +
> >> +	dev_dbg(hdmi->dev, "%s conn=3D%d scramb=3D%d\n", __func__,
> >> +		status =3D=3D connector_status_connected, hdmi->scramb_enabled);
> >> +
> >> +	if (hdmi->scramb_enabled) {
> >> +		cancel_delayed_work_sync(&hdmi->scramb_work);
> >> +
> >> +		if (status =3D=3D connector_status_connected)
> >> +			dw_hdmi_qp_check_and_set_scramb(hdmi);
> >> +	}
> >> +
> >> +	return status;
> >> +}
> >=20
> > Unfortunately, that won't work. The HDMI Spec has (HDMI 2.0, Section
> > 6.1.3.1 - Scrambling Control):
> >=20
> > The minimum time period between the write to the Scrambling_Enable bit,
> > and the transmission of a scrambled video signal is not specified;
> > however the Source shall not begin transmission of a scrambled video
> > signal before writing a 1 to the Scrambling_Enable bit. The maximum time
> > period between the write to the Scrambling_Enable bit and the
> > transmission of a scrambled video signal shall be 100 ms.
> >=20
> > So you need to disable the output and enable it again.
> >=20
> > vc4 does just that, you can have a look here:
> > https://elixir.bootlin.com/linux/v6.10.9/source/drivers/gpu/drm/vc4/vc4=
_hdmi.c#L410
>=20
> Thanks for all the details and references!
>=20
> Unfortunately I had to drop the scrambling setup for now [1], as I
> encountered some issues while attempting to get this implemented as
> suggested.  Will get back to this and submit it separately when done.

Yeah, I think that's the best way forward for now :)

Maxime
--bjmxjjuhmv2zdjhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZvEkmgAKCRAnX84Zoj2+
dtqIAYCEGRZltZdX05vOCUhg+bOJmCXtzlvHsgM0R0lqKkF47Ts4/UIXsS4SIBrh
GzywXicBfA+E1AnqXzojQFvunTAvhnbNDmkORCYsD6W+6g1tpbLD2aeqkSlYNen/
ghfb0s5gfA==
=WJBj
-----END PGP SIGNATURE-----

--bjmxjjuhmv2zdjhq--

