Return-Path: <linux-kernel+bounces-191257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE7D8D08D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765DC1F21C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D2D155C93;
	Mon, 27 May 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riMOUc4N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906773460;
	Mon, 27 May 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827946; cv=none; b=dJDxiDQ8ziRAsJgMLd8gVhkfvt5hB0wtkVi69seuH+N/zpmtPsG+ebxQQB6h+hNCrwAQB3rsMv0MYBqG9nU/VcFdRiK0S+rSc5cTaumh5zLZ2shmAdlQZt/I/FhepUCi1Fpp0MI9pu2x4kedeox8QW+V4q70K+fHGrDrvCBsayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827946; c=relaxed/simple;
	bh=nZai3wSxMfczIOwG1N88zrdt0uoepTu3YmE3rL46WOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLoZWMXDtz6bVJBA2ZYD9Z3hghPdeOaTmL0oPxxMwGfix/5mlSDA6PsXaQF7rF0SCpQA+rCxbfzKXGDfdummoAxc8BLDAuo5tSNR02STqQt031EE3JP/2MFS7tjFocRwg8dtiD248qIE/nHOA7YPJHqRWz7dmfERApLg35Ld3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riMOUc4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC76EC2BBFC;
	Mon, 27 May 2024 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716827946;
	bh=nZai3wSxMfczIOwG1N88zrdt0uoepTu3YmE3rL46WOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riMOUc4NVSfS0ecagO6O0oeM3MuZde99/wOVQLfVD1Rw+o1uNkZ2OJUcFWRztAUGn
	 1UyERoNxFQnIy6XetRWZ08rZlAvfXpRR8EB8sz5/K+pykZNl2nrAQO6WVljwBDBpF1
	 n70AOzQtJx4DWiVQXoscukA2nKEADRrwoZ431uNA+CzFtQ2J9v2Ga7guDqru5J0IPf
	 ghSiEEJmo9RsHGWryP9QnEHzAowOuTwOID9NdCv3orVYDSTAMrZAWTfeFcxLhQmtK+
	 +blgvpRq0RzZlRPJx8RCWPwTbykccmZutO7Oyqn7MsH1zGBf/URh4o1yi/I8/Cy49C
	 WEjOYvw2fmm6w==
Date: Mon, 27 May 2024 17:39:00 +0100
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
Subject: Re: [PATCH 2/5] dt-bindings: timer: Add SOPHGO SG2002 clint
Message-ID: <20240527-gem-perceive-b3b33cb8b2f9@spud>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-2-1b6cb38ce8f4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/0iu3V337FLgXjyV"
Content-Disposition: inline
In-Reply-To: <20240527-sg2002-v1-2-1b6cb38ce8f4@bootlin.com>


--/0iu3V337FLgXjyV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 12:28:18PM +0200, Thomas Bonnefille wrote:
> Add compatible string for SOPHGO SG2002 Core-Local Interrupt Controller.
>=20
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/0iu3V337FLgXjyV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlS3JAAKCRB4tDGHoIJi
0kiaAP9spLCvPOWUuuMl+xxQ/ZlirHHi7Fr8SWxQ95LtWYyC1gD/V8c/NyHHIjMs
L70GsY3xpX5Zb5FnWWEJro/UzARXyAU=
=816W
-----END PGP SIGNATURE-----

--/0iu3V337FLgXjyV--

