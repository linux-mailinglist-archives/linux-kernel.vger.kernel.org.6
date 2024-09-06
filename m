Return-Path: <linux-kernel+bounces-319045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D096F6F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2526D1C242FB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10061D2F4E;
	Fri,  6 Sep 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oeodf737"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D91D2F48
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633268; cv=none; b=CqOUJfDGOJ5InwFSgsyQJmTz363SWg+Sk3DHwMtK4Fd5gBPjAtmMLQt1tjzmANQG1cagZJmMuO4d1jnb1SIneH2njUDsazDPITaTC6APkm6i2kJcIj6R0b0prv7pVeMqYIiGmzKXkLi+bMMd/XAEaQrXuUSGW/om03JE6UtBGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633268; c=relaxed/simple;
	bh=GJhdh1KL6sQuQwMV3OtKllaFyTdDwk8Rn9pISls1GlQ=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=NIELwi9g129WirVj+/tiBfh2dDywM66kJ9oDsqI7lwRVW3S2s6/cOs1TVlaEsTPAElFis6wB9napMrFmUvVKN1lJtmlTL5kyPHW+0NLM0RJyx9eTzEccmIC0HQB47OC7/64Jj5Q2kJedayVgNDkHvyQur/7ByhDyikB0RMRyauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oeodf737; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48836C4CECB;
	Fri,  6 Sep 2024 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725633267;
	bh=GJhdh1KL6sQuQwMV3OtKllaFyTdDwk8Rn9pISls1GlQ=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=Oeodf737b6AFFx4Kr6GnO9BnmgcUssKIwZ8gGfjzhQP1O55srkqsQQfstsM5EEn0O
	 2ZZXS4n6Cdw/xQlH9EtlcuhlHktS1nkTpHONG6XeEYcyWth+4jQHIwxUgZtbSoylsj
	 wZ11yX2W0pJ9kUiQlBq0MWEUpjbssT+k26gveVgOts2HgiGjQXfNe3axfNAJ/hSDK4
	 1hgpkQzCc5BolbX5xQoDa3P0ptOMKBWGvnyOK7vbghZ2c7RILpbidDSzjrwC+Z7Kh8
	 dUDoWHlRMweBEbae6rkOrHIf/v83537Ushy91usqBZ+D2eB+3UgfgHC1STX5ITeKFl
	 m4+dSUdMxZPhw==
Content-Type: multipart/signed;
 boundary=e8ad010c817a911994476ecdfdd40bb8fa6aeac4a7fb87b11405e936193a;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 06 Sep 2024 16:34:23 +0200
Message-Id: <D3Z9XTBHSUEN.2GW0UCIPLR6HY@kernel.org>
To: "Daniel Semkowicz" <dse@thaumatec.com>
Subject: Re: [PATCH 09/20] drm/bridge: tc358775: remove complex vsdelay
 calculation
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Chun-Kuang
 Hu" <chunkuang.hu@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Sam Ravnborg"
 <sam@ravnborg.org>, "Vinay Simha BN" <simhavcs@gmail.com>, "Tony Lindgren"
 <tony@atomide.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
 <20240506-tc358775-fix-powerup-v1-9-545dcf00b8dd@kernel.org>
 <CAHgnY3=KCD4gyJ4nL6nN1tvWcsiRQL+Oz11RNOniDdyMoEPcSg@mail.gmail.com>
In-Reply-To: <CAHgnY3=KCD4gyJ4nL6nN1tvWcsiRQL+Oz11RNOniDdyMoEPcSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--e8ad010c817a911994476ecdfdd40bb8fa6aeac4a7fb87b11405e936193a
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Daniel,

> > To cite the datasheet on VSDELAY:
> >   During DSI link speed is slower than that of LVDS link=E2=80=99s, dat=
a needs
> >   to be buffer within 775XBG before outputting to prevent data from
> >   underflow. Register field VPCTRL[VSDELAY] is used to for this purpose
> >
> > This driver assumes that the DSI link speed is the pixel clock (as does
> > every DSI bridge driver), after all the LVDS clock is derived from the
> > DSI clock. Thus we know for a fact, that the DSI link is not slower tha=
n
> > the LVDS side. Just use the (sane) default value of the bridge and drop
> > the complicated calculation here.
>
> I am not convinced this is a good idea to revert to a default
> VSdelay value. I tested your patch series with RK3399 platform
> and default value (5) was not enough there. There was small data
> underflow visible, resulting in display offset. Removing this patch
> and using the original calculation formula fixed the problem.
> The calculated VSDELAY value seems to be a lot bigger than required,
> but keeps us on the safe side.

Did you use just parts of this series or did you port the "lp11
notify" mechanism to the rk3399 platform? Please keep in mind, that
this bridge doesn't really work if the reset isn't deasserted during
lp-11 mode and lots of odd things happen.

Also, do you know if you have an EEPROM attached to the bridge or
does any firmware part initialize that bridge?

> It looks that hback-porch value for panel is used also on DSI link,
> effectively delaying hactive data delivered to TC358775 bridge.
> I suspect this causes the requirement for higher VSDELAY.

It was ages ago since I've worked on this bridge and extensively
tested and even measured and decoded the DSI link and the LVDS
stream. But IIRC this delay was only to compensate the difference
between the DSI clock and the LVDS clock, that is, if you push the
pixel stream slower into the bridge than the bridge is pushing it
out to the LVDS panel.

So the back porch should be irrelevant here (?!).

-michael

--e8ad010c817a911994476ecdfdd40bb8fa6aeac4a7fb87b11405e936193a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZtsS8BIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jrSQF/dh0L7uqo4iFgWteWoYgl5oebRy9RWFyV
GIMN9nOpNVjk4Qk35Rw5AMwTJ2loI9hGAX9gKMZj5wZtErKpKvkIAqbL0vCimlYi
c9LSAvT6UG+2c6Fu/Fb0C0Cu0idGKpxaoCU=
=Ydxr
-----END PGP SIGNATURE-----

--e8ad010c817a911994476ecdfdd40bb8fa6aeac4a7fb87b11405e936193a--

