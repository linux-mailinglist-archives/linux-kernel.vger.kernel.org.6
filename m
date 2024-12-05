Return-Path: <linux-kernel+bounces-433840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BBC9E5DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E779516D29C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA6225786;
	Thu,  5 Dec 2024 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Orlrb+El"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D5218E98;
	Thu,  5 Dec 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421510; cv=none; b=kepVfB979kOc1izUpI+1McnZaTsPa/U/9MacohL5DaxtCAyO+/apGWVYrDceURaKNsXUQ4j1B2q4xMqqtzGcs4gvCggkHQPM8ovuAHsmmfA/gVB/PSvJiWZgKZJ6gdctTR71ERWigb3tJ9uvHabiDJND5KtEmB/rsqJiN455oJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421510; c=relaxed/simple;
	bh=73xQjGFD4kv0bIyMOBquAjnNM1xCWQ7ChvbHtBBk+Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2XLcw7qK6pjDnjIhXvILxsAG2v/c7gKRZ1rAd3B/Kg5yOUPTFhXh9LZFJx59JnRm9vOFUOjSC7XxYeCx+u9HNxqSs+/0SUb1+O9rB4WHA4hLeg/LhOP5Iik5RBAkYguUOFxDEE9KNrCB6ES3KkNkwrn+mlsOC5+hN74smbA9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Orlrb+El; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF0AC4CED1;
	Thu,  5 Dec 2024 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733421510;
	bh=73xQjGFD4kv0bIyMOBquAjnNM1xCWQ7ChvbHtBBk+Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Orlrb+ElrHdizDwlaDZTRLYCgXbBCQ7lTewAAGkzKjsd2qydeM+XKlwzkgmHmNakO
	 /Tg1HkdP0dmYfuhOwdRfv/iqU0R5Che9ad6MPbCSkOjUQ4o3huwLs9e42to2S/Plbi
	 fLUrVrT2+wROyeUOu7V/5B8hFgFlrDNnU4JsuV5RqE1x2iXZpSpQBG2PO/JfXWp2/4
	 r3tCBU9HrWPHnBgmDharqVj374h+kKmfJx981ZFl4g0jypdF+Z6wwkrSeE/7RwwZWP
	 48hqgipspHnjAN5w8ooFd1fs+ag48MQvzPj72b8DvOKVT5EKZoqapsgIc4dlwVmnnb
	 OQ1s9bINGxWYA==
Date: Thu, 5 Dec 2024 17:58:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] regulator: dt-bindings: pca9450: Add pca9452 support
Message-ID: <20241205-cornfield-stoplight-664ad32353de@spud>
References: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
 <20241205-pca9450-v1-3-aab448b74e78@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MyZ5EmMb99Zgg/w4"
Content-Disposition: inline
In-Reply-To: <20241205-pca9450-v1-3-aab448b74e78@nxp.com>


--MyZ5EmMb99Zgg/w4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 11:51:11AM -0500, Frank Li wrote:
> From: Joy Zou <joy.zou@nxp.com>
>=20
> Add compatible string 'nxp,pca9452'. pca9452 add 'ldo3' compared with
> pca9451a.
>=20
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--MyZ5EmMb99Zgg/w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1HpwAAKCRB4tDGHoIJi
0vSkAP0e4ibG2OMWjU9zkkepAuDnmh7gZrt/mo0r917YnFvyvQEA1mACkRWBygEy
s2e5cq6G63ISm+PTrFg9VWDwjfPXngs=
=9/jl
-----END PGP SIGNATURE-----

--MyZ5EmMb99Zgg/w4--

