Return-Path: <linux-kernel+bounces-189014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD88CE9EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A791C23206
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC513E462;
	Fri, 24 May 2024 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlox4iNq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BC83399B;
	Fri, 24 May 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575489; cv=none; b=kU/eqwlcfqjUdVlT95C8AjA7JtVAdA0gR8i1pvnq6IWORVNkLo2udss/nAJDzMpMGh+ELm2KZdQUU98cBvwMQpCma7icrHRp1XjWsG7/bB4BhefjAhgJEJkFud2lV1uUGM+/ZARTDF3quCgJOYClEWVDtFvOpZkMeBl1uyH2DnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575489; c=relaxed/simple;
	bh=/ztmUaN+Csn+xIOOn+zVsdPvX0qFx5ZWesnKa3+2u4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihyxCsYemufg7Xt4iEbQznBVuzoI5Fi3h2+ShUc2bOChGizsvt/Gs1mWtOv++4GHPoIOzyX2PoXFr9FKyxOtguFx5zDVvxHKs83GB0CG+DeWQ7Do30yopAeDKsZUbMyauL3cx3cfPYknwNhqq6Skim8iXMkJ3Fd3ThGz33/c40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlox4iNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6E0C2BBFC;
	Fri, 24 May 2024 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716575489;
	bh=/ztmUaN+Csn+xIOOn+zVsdPvX0qFx5ZWesnKa3+2u4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlox4iNqmDPOjH4JRYBda8MvOcY+AoZDtCUyI65smRCljA+e8fgiRc/xLx8VpsKny
	 UQzZr3+aYaRJ0Pbn7yrZNarCdTccjKvL4a3VapoRcVL2LBxlr4lwNmrLa6aSb2x70a
	 l6qswPdJFpmWT059xtUA/+hjTkRzKKcFE4XG+MfShm+xsVpXmmYPwJPWOjVpqcAJWs
	 M4ULilRuiR5r5xwfhzmxw4WwH0EkLMbRq2Alm2uqozs7SrKCQ47vp8KIP160dhiuBM
	 Oiqqie/BGma2h2oroJctlzAr7pcAmPyqeaPghpK/ia0CuNrPAA4NGfnOzEEIUfZakc
	 QJxCWnuOsZQqg==
Date: Fri, 24 May 2024 19:31:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: usb: gpio-sbu-mux: Make
 'enable-gpios' optional
Message-ID: <20240524-boxer-grab-820cc815e55a@spud>
References: <20240524071034.4441-1-francesco@dolcini.it>
 <20240524071034.4441-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O2o6xvA5DJkzSTPJ"
Content-Disposition: inline
In-Reply-To: <20240524071034.4441-2-francesco@dolcini.it>


--O2o6xvA5DJkzSTPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 09:10:33AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> The enable gpio is not required when the SBU mux is used only for
> orientation, make enable-gpios required only for alternate mode
> switch use case.
>=20
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--O2o6xvA5DJkzSTPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDc/AAKCRB4tDGHoIJi
0kKTAP46H5UKUeCFhR0V6Md/njZpnW/9w0OktOevN6t6RCH8EAD+KYPvjbobJ9UC
TQGD0lFTB3bPp1NBXgIa2UoHJrf4Hgw=
=zDnb
-----END PGP SIGNATURE-----

--O2o6xvA5DJkzSTPJ--

