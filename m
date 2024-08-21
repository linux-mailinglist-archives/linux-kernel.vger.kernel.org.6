Return-Path: <linux-kernel+bounces-295493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E510D959BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9555E28497E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BC316B3B7;
	Wed, 21 Aug 2024 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3D9gUb4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C21D1303;
	Wed, 21 Aug 2024 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243314; cv=none; b=BTFmrCL1Wq9dH5fcQx8M0czgVpkVEdnoQt/4z4JvN5ksIV6TpjR44UeCD4Au7aglyTpEcVZ0CG6ZRB7kxRl5Z+67eqFTLFzsOtGT1Vhg3Aijzt1DY3CF5RC8x0dfOwQq018gGyxh+Fgcqev+dVH944Mufb8dBTumS1dTz1UT1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243314; c=relaxed/simple;
	bh=NnoJ4qFOrxmlo0aB7R44FT9bZ5SZQaWEJ6peEjE3zZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW3Khb7/Y5C3ChONojGJAQK5BH6BTNCudbU1I3c/vPeJx8sCGfD0XLrXNBP0R8QKKJPFjF3WOmzQc02Pkbl30QrkpxSTdylDS0bBFikq3ht0cmit4MuvhEtuU9SZC3wB2GURXcWpcb/ZyhSXEStiVhTjIrxccsqqIm+yltSW/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3D9gUb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDE6C32782;
	Wed, 21 Aug 2024 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724243313;
	bh=NnoJ4qFOrxmlo0aB7R44FT9bZ5SZQaWEJ6peEjE3zZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3D9gUb4B/GUKB3QWBW1JB559Sq93PNeppTYu3VmOASkkCKChnf6IPAfkMLkSiiyy
	 f9ylMtMjtQqmzjIUffkPJHWLC1zhXrtGoAZRDmCuGWDqIyoNAAwmc4gpCL+K++jA4N
	 Zw1oGxNmXsN4NP049XdRR5hN0r0heueyPOpbxHk9bRdxxPnnT8ZJBCnMQQU+tH3g0E
	 Xob5sf7o5JrAqRfg34C+PxKtN1GSsGFNP3a2jFLYekuAMXvmPv2C1IReuf8a5I7uKK
	 GJoCI/bHY9haMVIReHdKh0fDR8DfzHjYLrEBs72sHQ2qew4ntWiPTGg+rD/jMFGJOd
	 AUEqp1CEvkvzg==
Date: Wed, 21 Aug 2024 13:28:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Neal Liu <neal_liu@aspeedtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bin Liu <b-liu@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: [PATCH 4/5] usb: mpfs: Use devm_clk_get_enabled() helpers
Message-ID: <20240821-velocity-tribune-726bb3546ba8@spud>
References: <20240821121048.31566-1-liulei.rjpt@vivo.com>
 <20240821121048.31566-5-liulei.rjpt@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bcJo4N/CZuvGrFHi"
Content-Disposition: inline
In-Reply-To: <20240821121048.31566-5-liulei.rjpt@vivo.com>


--bcJo4N/CZuvGrFHi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 08:10:42PM +0800, Lei Liu wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
>=20
> This simplifies the code and avoids calls to clk_disable_unprepare().
>=20
> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--bcJo4N/CZuvGrFHi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsXdbAAKCRB4tDGHoIJi
0vQXAPsFPWs5/bU//KkusZ+fex1LjVZZPj1iKD46J4gSjA3/IgEAmb8f82SYq0M7
5hCZmy+8jLkn5UKZOkLGj2pA+UNHXw0=
=TKQo
-----END PGP SIGNATURE-----

--bcJo4N/CZuvGrFHi--

