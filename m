Return-Path: <linux-kernel+bounces-191264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6B8D08EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA451F22C75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C2155CA7;
	Mon, 27 May 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXWfL9vn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C117E906;
	Mon, 27 May 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828231; cv=none; b=j+8erwnF/6k+bOE0twj04N/+DzCmEJdYEnJ61Sy3db7OOByadnRGPAxK/6eN0qIkg9+cEifW0v4F7ySFk++kFnh0XJdqgpWtgpqBqVCOypyJsyX5gVdEVpxBUaRgjquLlBiHTgY1SaDrOPlU/dN7C5uiqGaaiL7xQ0idc2hCT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828231; c=relaxed/simple;
	bh=4dvkOf1CENcyz9mYEJmPvOqP9GJwkrOwMz2AdlNtPgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvvHV380wytItXTG6g67OorE83GOeuaeppi31FIN4Xk5slpgXCKJOW33AwmMRBRlQ9lsKSsdWo1H7RTLOdLeCPp/E2pwb0RqPTto0cfE2Jp4WP9IhsSi5H4i5qFXNZ1uO6cBah0Gy5Tp+bLyuv1cUVzC/M7Non75oHPUEj65K3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXWfL9vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E166DC2BBFC;
	Mon, 27 May 2024 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716828231;
	bh=4dvkOf1CENcyz9mYEJmPvOqP9GJwkrOwMz2AdlNtPgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXWfL9vn+y1y9ceVUMv3HdCyy/fYMV/mL51WccnbrUe1T/QpXcUk7xwP+2bGRCIDy
	 AXR36x92MZHHicdhvyGuvydaOdhRQ6aNK88ICRr1jfwCVbVW8jtbIE1XLssSLOsFzS
	 CixBRZhm23I6u9WoWepxzlIlKSB0q6aeJoAXmt9UNqsHAINLh87d0j635hnQw89N4O
	 TZBOVy3PBtiDzuZsNxb1sQjwbR3yFxU7x2oeYTT2oahvG0wgsGnOBKPObQF3MW68KX
	 2xLg0SmkN07xBF7r0ftOgLV3Il4hpdZJm9CcELcIaXLcF4PzPwZ0v3Q903weqjL+Pc
	 0c4HF5DXzgRrA==
Date: Mon, 27 May 2024 17:43:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: fsl,irqsteer:
 Add imx8mp/imx8qxp support
Message-ID: <20240527-baritone-rubbing-3adca364a249@spud>
References: <20240527083402.30895-1-alexander.stein@ew.tq-group.com>
 <20240527083402.30895-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mNr8ZlAANkA3yQp4"
Content-Disposition: inline
In-Reply-To: <20240527083402.30895-2-alexander.stein@ew.tq-group.com>


--mNr8ZlAANkA3yQp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 10:34:01AM +0200, Alexander Stein wrote:
> Some SoC like i.MX8MP or i.MX8QXP use a power-domain for this IP. Add
> SoC-specific compatibles, which also requires a power-domain.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

With the indentation fixed
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--mNr8ZlAANkA3yQp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlS4QgAKCRB4tDGHoIJi
0tmiAP48qu9QL4EFuYSq0hRRDGKbueI5B7QNRepOaJRjHSJVbgEAqb5MwT5Jj7Ph
byZMrMDdpfWCPNYs5zjxARLjcDmC7wU=
=gjJm
-----END PGP SIGNATURE-----

--mNr8ZlAANkA3yQp4--

