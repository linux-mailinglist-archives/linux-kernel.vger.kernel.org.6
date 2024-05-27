Return-Path: <linux-kernel+bounces-191259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AA88D08DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A971C21CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4C0155CA5;
	Mon, 27 May 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruHCRjHt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95A73460;
	Mon, 27 May 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828021; cv=none; b=Cf+hk+PEDJTyZJQ1xtuxMKjwThBLQtJroWXajDbtgfd13/E49kcjqsfppIi5PO6kcf0zCUDTgjsNZGI7UQ095xKODEkXLfeAXOG+Jf1XT59/ukwqpADurvYgPIfRMuSPnf1Ct2DLZ5OyjXUQk+js+1qUYsaQ5i0cD+h+7J4uiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828021; c=relaxed/simple;
	bh=7iZ9vDuxB849murmlJ92FXc4F0iO2D4qSBeHgvVAro4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG/D2sLlxF6kuGGLZhoYYC53TY5dsf5QUsUMoNSkdlAISXokRYGw4jQz+QxtwvoGRwmQqqhysck6qQAn0PnCHy1o4/bQmK+ji0vyK5/qFiO+OkYqI4Sc/ftS54eLFvnUzRnRKd6PHCG5D0CGZvLtmYiryET6Os6M9xDGu5B6HTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruHCRjHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22A8C2BBFC;
	Mon, 27 May 2024 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716828021;
	bh=7iZ9vDuxB849murmlJ92FXc4F0iO2D4qSBeHgvVAro4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruHCRjHtggFppAV5loUV9K5CgSe2B/hiJz8/R6e0ejS9kaOgpgMDne44EVGyBnl2o
	 qosTJeJ47+2Tm42o2MqoQkGxcJ9GgcK7+wDX5X80Ey63+6EW7pQVoiM6qQ/OSuqEKU
	 CfsiM+Pt86y1ikiji+KSP0/R2UAxDS8TxELSDq9SXjR++f43TFfd3a6ulzhYp2XeR4
	 ivgFcnCGvoVW8QZPcLIt0o8sdnE/LgxZ41owCg4E7AXpPcuIpyLhXYXEcYR9Y/tcBV
	 CitzQdZmZxQkClGioo663FgDUq3t/gHCGx9DW2g3PpMB881uL12pO2TWErljb3KsuR
	 Dk414q1kOrRzQ==
Date: Mon, 27 May 2024 17:40:15 +0100
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
Subject: Re: [PATCH 3/5] dt-bindings: riscv: Add Sipeed LicheeRV Nano board
 compatibles
Message-ID: <20240527-backspin-sacrifice-7df47c7378e4@spud>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-3-1b6cb38ce8f4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A/6qWgFT6Jr3Mu1d"
Content-Disposition: inline
In-Reply-To: <20240527-sg2002-v1-3-1b6cb38ce8f4@bootlin.com>


--A/6qWgFT6Jr3Mu1d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 12:28:19PM +0200, Thomas Bonnefille wrote:
> Document the compatible strings for the Sipeed LicheeRV Nano board which
> uses the SOPHGO SG2002 SoC.
>=20
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--A/6qWgFT6Jr3Mu1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlS3bwAKCRB4tDGHoIJi
0lcCAQCUgoKLVC/COJkYlJlldDCP/R4Q0iLUk2+4Cs21V7FVCQD/cyBEclg2lqzt
mxBEHKb9q3erNPFWJAGWNWj1KKQ7hwA=
=NreR
-----END PGP SIGNATURE-----

--A/6qWgFT6Jr3Mu1d--

