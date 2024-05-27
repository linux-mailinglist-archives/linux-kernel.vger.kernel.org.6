Return-Path: <linux-kernel+bounces-191258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8758D08E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61082B271E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC69B155C96;
	Mon, 27 May 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9oIi2qg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727673460;
	Mon, 27 May 2024 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827965; cv=none; b=GIVZgdD4DV1xmBiaIBKAcmk6fxZwcQTT8yJAM//jLxyctXGw0c+UEEd4WENAwFNz/0AezTBsfX5UxmtNuVIxAuDHWvDvCXCl0H6NszAIrxYEUA8FalawVK4bOpI0zIw7/GcM6ctr/I2mnHp0o2DIH/F43mHKxNJ6yEK7nhMpj5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827965; c=relaxed/simple;
	bh=1TXFRO5AfBwTHoHEFlxxuQUmCZrVsLs15FvJqcvK7/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcFH9y48QwTKi1iaLG8+ZLjrA5ZESJ7DZGJzz86N5iN0kNBTMMEW6F2HMJpMswugaeCC/zUbBKlLJ79eRJeDVTN4u89lDmNPFtjKb9Yo6ZDM90vGpjFpxqwX9Fn2btRLJLWlJUQMbckvtoRmFgcbw063P7LxZlM5+byaqD/5Md0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9oIi2qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70707C2BBFC;
	Mon, 27 May 2024 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716827964;
	bh=1TXFRO5AfBwTHoHEFlxxuQUmCZrVsLs15FvJqcvK7/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9oIi2qgfnpDWTQaCgrs88Bd6CtrrO01tIv8/4lH6J4UeUqSCaFmEzgdCjl9puZ/q
	 TiB258i1HP3lsATzEvhmw4dWAF5LSpvaxMaxxeKSl86uUfSbI8yxOCRku/NyXqHxAv
	 1/V5oquZI9ADqUcuqGDQbTssLwcLqaCO7fl4AdNRqsNESw9sWcR3hvt+KKUyORjLG7
	 3WiAHEOuQuT1Njzras6m4PhN2Rsp9ahpVZ3KSnao5c5144NRUW/ECc3xahMU2bMJpG
	 07sUlra9Z6dQoHJdwvB3oprzMnQii7Ph55/CfKNMtGYeqAQRcoKcq/0Kx2UiM92EX7
	 UdTREyrpKkBSg==
Date: Mon, 27 May 2024 17:39:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller: Add SOPHGO SG2002
 plic
Message-ID: <20240527-keg-strategic-a3b89051f8c2@spud>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-1-1b6cb38ce8f4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l9Jwkp5MR9utH8tD"
Content-Disposition: inline
In-Reply-To: <20240527-sg2002-v1-1-1b6cb38ce8f4@bootlin.com>


--l9Jwkp5MR9utH8tD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 12:28:17PM +0200, Thomas Bonnefille wrote:
> Add compatible string for SOPHGO SG2002 Platform-Level Interruter
> Controller.
>=20
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--l9Jwkp5MR9utH8tD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlS3NwAKCRB4tDGHoIJi
0iGJAQDY5vSSo75AlJcaoesp4zpch97rFPlydyalwIu+HOUlSgEAo3vZQcVsaKk9
CFKqzrtt6LNiZ35A9X7soSx7/XLIEwg=
=u+Dj
-----END PGP SIGNATURE-----

--l9Jwkp5MR9utH8tD--

