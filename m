Return-Path: <linux-kernel+bounces-557095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A28A5D3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7779316918B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D412F44;
	Wed, 12 Mar 2025 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr9Se8UI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A820EB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738338; cv=none; b=P7lY1tqArZErZBdkkOVaN5RWPlkxwoX41pOctZ6CCFdJFLEM3Hrwl6xz5plPd9wjFx9tL1iJYbLOktwnlSRYRFeRECprV/u4KPlkqpjIiAev75oeuv7WVHXTF30vJqVGziaQ3oFsORRxElZwfqln4/s7+HaOharKsamH6oa+9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738338; c=relaxed/simple;
	bh=JYdPrXQYwvcwkvqZKxgNi+iuZvLgJnHrUW1LyNCQa10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es5FEkum2urVnc4bM5X49spGQ4aceEkKlbquyrlgZ272SCFwBvHCr+HO0i30atYHtvqQq9mFnVWHTIELsYr3whNCvYhNZh7E5Y7DmBiLgSMQYjryHdHfNE3XfPxhtaeXE8dkbQuPrq8qxurJvQ5kSVtUfpQRBdBped1Xd9hOWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr9Se8UI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007DEC4CEE9;
	Wed, 12 Mar 2025 00:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741738337;
	bh=JYdPrXQYwvcwkvqZKxgNi+iuZvLgJnHrUW1LyNCQa10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kr9Se8UIFy/Pu33HoOPKK5Ihvgw1DuCLr1Gi465ogFYmSahH+MCac5BQ+2Id/xdeZ
	 dQNZm7WIBHfSOg64vnoTtjLoiY0N4z1fBpi6hOeLnnYu8tyeqUusVLp1p4q4YQ7xPr
	 9OgsEXWDTlHJYYSglcAbtGmo+qVWCyZpAghpBTj6gTxfA06x2l3diSF07Cw0vug2Vf
	 Q7DAJLooqnDss7mOzxo3Cgbwp/QO/wAIEPd6oqmDO40Wwp6uCEKkQE6tkdMcpnMiUW
	 fpgVb1hRfS0jIpzf1eXtWcMeE5snHlAS5+K+5OQObZdemgoD62DABiGLyGLwr4i0KX
	 eXOWG6A15sEXA==
Received: by venus (Postfix, from userid 1000)
	id D8C941807CC; Wed, 12 Mar 2025 01:12:14 +0100 (CET)
Date: Wed, 12 Mar 2025 01:12:14 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] regulator: act8865-regulator: switch psy_cfg from
 of_node to fwnode
Message-ID: <clovsoj2joegkabhzsbjre5adj7qwo6vmf47urnam6xnlh3cm3@jcitrknzomvf>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-2-d5e4369936bb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a4msmditmuehlsej"
Content-Disposition: inline
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-2-d5e4369936bb@collabora.com>


--a4msmditmuehlsej
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/7] regulator: act8865-regulator: switch psy_cfg from
 of_node to fwnode
MIME-Version: 1.0

Hello Mark,

On Tue, Feb 25, 2025 at 12:21:35AM +0100, Sebastian Reichel wrote:
> In order to remove .of_node from the power_supply_config struct,
> use .fwnode instead.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Can you apply this trivial patch for 6.15, so that we don't have to
bother with an immutable branch for the remaining series in the 6.16
cycle? In case the patch itself did not reach you for some reason:

b4 am --single-message "20250225-psy-core-convert-to-fwnode-v1-2-d5e4369936=
bb@collabora.com"

Thanks,

-- Sebastian

>  drivers/regulator/act8865-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/ac=
t8865-regulator.c
> index 0457af23c55acdd97b2cdc6fd6bfd07ae0f9d11f..b2a6ddc6f56d32e8758977e25=
858b972e294bc84 100644
> --- a/drivers/regulator/act8865-regulator.c
> +++ b/drivers/regulator/act8865-regulator.c
> @@ -643,7 +643,7 @@ static int act8600_charger_probe(struct device *dev, =
struct regmap *regmap)
>  	struct power_supply *charger;
>  	struct power_supply_config cfg =3D {
>  		.drv_data =3D regmap,
> -		.of_node =3D dev->of_node,
> +		.fwnode =3D dev_fwnode(dev),
>  	};
> =20
>  	charger =3D devm_power_supply_register(dev, &act8600_charger_desc, &cfg=
);
>=20
> --=20
> 2.47.2
>=20

--a4msmditmuehlsej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfQ0VoACgkQ2O7X88g7
+prB2RAAklNzPlWVH+CYNbkZHGRWx0rZGAZ9mDbsprAEeMe5Yq1hoCYlzkZno8Ft
6j9cubQ+70tI7TIlZSW2fbYzacfs5zGmcPK4km8ypc4Oc2w3Xj24UQWuX1FlB3OV
TGxdpM1zQv49BMhDq4q4WT6SmYR8GeK63LgIYhXlfCE8YvpG4sPYxSVJoQbLc3dz
C9gQANNObW3GTv6qCDU79tAvyEE602bFtKRNEY6rtsymPKgAIS9dZh/Dsw8KdD2X
lPhgt5CfVSxq2RyGWMhffxM3DU3FbfecbBXC8JeohQaS2nXOz0UXEup5zqSEXnq8
mSMdnfWKetnB0wFhCFOBcOhyRTVITvfha9Fim8BJCeCM1f8e84IjN/+7wUGxa4Tg
mP67v8wRRQfCN/dwKS184Sw0tQ8Mngx3iqyZlUpsRUHKbC5jq6/dmthKduGk6pNo
0HG06sDYnB7Kaolz8aeJDJsGUQWhh38jJVdYPE3GSU58G6ImjSDkAQJUHNVzsd5t
GCuQhuitmKE5hX2ykQUwAv8jjsOvHtOK8AZrvKOUpWKrnXUJyalAxmPdPrO4lGnB
9a8yTbYJ6M/gwsBDU2MfvkbqUg6lzEhcuo9hWnFmkvA42V80j5Qggr3gsP7VB0t1
03TpzkRr7IXPqyG4eZG6uIknu93E1YnL9vKsMVj6y1Fp5JZLlOw=
=tJpq
-----END PGP SIGNATURE-----

--a4msmditmuehlsej--

