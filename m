Return-Path: <linux-kernel+bounces-318377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D7896EC90
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F841F250E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D49914AD3A;
	Fri,  6 Sep 2024 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji6a+zWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05112EBDB;
	Fri,  6 Sep 2024 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609104; cv=none; b=SB1KFUg39NtZU/74Qlk9d4C6z873d5nx5H7x4RFIoIpSl8M/TLZ7/Yd/qDitu2Gt7J9R1d0QbmM1Ufzjcn34El+uJ/HTOJU6Miur9VNUn0ib+JJOLMuwFFpFsNS6CCbkYB4nfiqvTtQTZFXixH/bczQTXwVxvjb8MANgf68/v4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609104; c=relaxed/simple;
	bh=4Q6QBPQx0Q3Hsvug/TgTFRvcIUp3b3WiTX1Mnyr8qBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqVZUmuJRlzFXbX02mvZu/m3jqSjTCGkSufbg/58r7zjgtISo9hOK8O865ngNzQYAnafVJtsxKnAJnmb8tfFmUGYkwccHhYjneaRlVO/5WgMd9HcQtPevjm7g0zaNJfcYKW2EVpTxVMBjCpOCq5aYb1dofcDM7yFGJ8uQagvnSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji6a+zWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C84C4CEC4;
	Fri,  6 Sep 2024 07:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725609104;
	bh=4Q6QBPQx0Q3Hsvug/TgTFRvcIUp3b3WiTX1Mnyr8qBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ji6a+zWiL9JTLas91YgLsCxxIqj2cN/GecYl72V+r40HHNcJsHL/xeioVwrSOt1LY
	 A6mNFmNqSxCdXE1oiGpqPjYunpCg89upZAH77wad3kbLV3JAJwwgtah53asWHRHg6O
	 JJL78UGtHDMTTGjI2RMOkTjL4JWDC3sKDNGSr7/hXEBVXlYL2gLZOdLhu5a2Q1Xl5k
	 f7aY3an9ijVUpBhNNhkSrCa1sBIw6uljUM23wxX0hC+3E8wicnDMph1UpI6AMpAaRu
	 tvcWeFjGYaArmuR/K9Gr1/4WTSnsdD2GPva9Clkb+FOiOeMdKYBRPsL8mtFox9HuyH
	 NACu5UrNSJZkA==
Date: Fri, 6 Sep 2024 09:51:41 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Adam Ford <aford173@gmail.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: imx8mp-hdmi-tx: allow 0.5% margin with
 selected clock
Message-ID: <20240906-strange-spiffy-nautilus-330add@houat>
References: <20240904083103.1257480-1-dominique.martinet@atmark-techno.com>
 <CAHCN7xLmZYZcHyPh3gy20vFKP7aTDKvWu+a_mbG6LN2gdEifTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ejxvdrh7pzfeccnj"
Content-Disposition: inline
In-Reply-To: <CAHCN7xLmZYZcHyPh3gy20vFKP7aTDKvWu+a_mbG6LN2gdEifTA@mail.gmail.com>


--ejxvdrh7pzfeccnj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 08:23:51PM GMT, Adam Ford wrote:
> On Wed, Sep 4, 2024 at 3:31=E2=80=AFAM Dominique Martinet
> <dominique.martinet@atmark-techno.com> wrote:
> >
> > This allows the hdmi driver to pick e.g. 64.8MHz instead of 65Mhz when =
we
> > cannot output the exact frequency, enabling the imx8mp HDMI output to
> > support more modes
> >
> I went from 19 options on Modetest with my AOC 4K monitor to 31.  Of
> those 31, three did not appear to sync, but not all the frequencies in
> the LUT sync for me either, so I have no objection to moving forward
> with this, but I wonder if we should have a note in there about why we
> have a 5% tolerance.

Yeah, I agree, it's something you want a comment for.

Maxime

--ejxvdrh7pzfeccnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZtq0iAAKCRAnX84Zoj2+
dkeCAXwPeLKzxqgBG+rta8SfG1sXvEd6pNwz9VSiFA47y7aJ9OD7j+7lQJW5Hp9A
f8lglUYBgKqiDZpM9XRPFEvccSnysACDM8/y9q+NAxU4Y9HqgSK9gBnnPQl+OJqX
ls8XD7B2aw==
=SnQ0
-----END PGP SIGNATURE-----

--ejxvdrh7pzfeccnj--

