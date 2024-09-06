Return-Path: <linux-kernel+bounces-318390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEFA96ED14
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF4B284D40
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C9515667E;
	Fri,  6 Sep 2024 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Vdvk5ahi"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920FE15530C;
	Fri,  6 Sep 2024 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609774; cv=none; b=r2lzaWSpARYdEdQfTT3t27UPPhAjhDNISDAKdWPrD5wwOBej6SxgyLbNICH1Je5V8P6WsBc9Kk3ZMVZOpiKjHdiI8XP0vxi4fbmB9DsmtezmqsYkE7TQlucVODoPeglB3+KdLaohTDYtXLp2Uq/90x1Cy0Wk2eaLfV/GBKf6gAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609774; c=relaxed/simple;
	bh=hMQ2rZUoH4pL5g+yJLRKY11177LFzP7nzO3oVgan77g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SU2AFwU3z+p6CEbkS/ZwAJo3YNemp3qvAaLAnTg0ayBObaKEMIOIavZbMWOk0HGm6t7cVIIZRQ2MhuZqcRt5otuXPuJfDkEo4mtugE/9f4VOZIwd0uadFEywnk0WQ8CQAOKbe2AOxYBQ1J3AVlo1TmCuMEEu5MGS9Gws4K3acSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Vdvk5ahi; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3309888549;
	Fri,  6 Sep 2024 10:02:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725609770;
	bh=HhQjnhCG/7IDjpcKBy9KrDyZxezrF88mmfPxvNNf6c0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vdvk5ahihlmrAP6Usa5c4g7OvU6AhHXYHK48SeLA4nc8TWYB3yXqrJ1QiSIxKjCHt
	 6+z410bbZIEx9e7Saux9owHbJA+vjErQW9ncC73ksMnWiTqjdC8BSRKm3nmtbNUsGO
	 gQXu1+cydXSqtsAPxnGgwYc/UNArRoY64QmZGZGtEMVZiIe6J080NmbpdBHRYVzb2p
	 6rXAlSGVBc5E+YH50Cfy9QUifBAXHqz4JLeMSlEkhfYBYCNUvikVnX/tU3VQGhx6GY
	 bnR/XFE9/zhKdosl8Na8UgvDH+ZWUGO3ZjZs2HTvkO9ETaUEBZHJcZEOgwAnSowlpa
	 xYuclL1OK+Ouw==
Date: Fri, 6 Sep 2024 10:02:48 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices
Message-ID: <20240906100248.39156474@wsk>
In-Reply-To: <CAOMZO5D3y1_-_TX_a7zuYPxdRKGHGN7JFwWMNe_dtS6i0Rx2jw@mail.gmail.com>
References: <20240830085441.3589713-1-lukma@denx.de>
	<20240905143645.7946fb0e@wsk>
	<CAOMZO5D3y1_-_TX_a7zuYPxdRKGHGN7JFwWMNe_dtS6i0Rx2jw@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E+e3HCdzUs.pG4iQ6Zg+oc9";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/E+e3HCdzUs.pG4iQ6Zg+oc9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Thu, Sep 5, 2024 at 9:36=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
>=20
> > Fabio, do you have more comments for this patch set? =20
>=20
> The new boards compatible strings must be documented in
> Documentation/devicetree/bindings/arm/fsl.yaml.
> Otherwise, many warnings as shown as per Rob's bot email.

As most of those bindings are "legacy" (and already upstreamed) now - it
could take some time...


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/E+e3HCdzUs.pG4iQ6Zg+oc9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbatykACgkQAR8vZIA0
zr2sJwgAxEbXlWP9vJaGuKklGU2sYpirhlz13XfQsZOya+4WAu7WdeHZX3jllac0
Rdtmyst9bEPLOiOqdMlZ+9x9eBbnsJ86R1UGj3jpyR/+v+bMZ10nzpTOaxjTbsDY
z8swK/2ZSRyBFM92+kwrmKeNNPy9bxP7bxmnQfDi2ZPpaKHlEAnOXOVqg0GPzrw/
sEvzg6HhQQIkJErAUUkBnCvWucSCjGLgtzXrkkEQczsRgb3aNehzDL0b+NHKLVMD
l8bJvaZdU8mC1hRBI/W3zO8LngIYjrv0VIUrXjxYn6C4Oxpqmk+ldkpWy4h3DAu9
O9CGyzuib3bcntIAcFVLt1ZObxXy7Q==
=gmxg
-----END PGP SIGNATURE-----

--Sig_/E+e3HCdzUs.pG4iQ6Zg+oc9--

