Return-Path: <linux-kernel+bounces-211935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A01905918
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D03AB25F78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC8181BA6;
	Wed, 12 Jun 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M90jOke5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B3180A9C;
	Wed, 12 Jun 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210778; cv=none; b=GTVmN/Iobo6npbECXIXqB26NrS2aFsWP4UhXjAa0YhCwRbUDuP6fccDubrczwaEFD6BiuVsFHMvM/5jmuPVbG4ukT+2XD7C6WdAr8TNg+uk77NrXbke+/oC309EI0FEMtADVc7ym7R8X35A2FD3t4qJJv34SXNM7hAbLD0emQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210778; c=relaxed/simple;
	bh=WQco/TtFmwtPptSfLGLzBaCcF7qBrspOVsH29Yreg+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpAZaRLocmNmg4qPD2ghn5dNu2supqnKyS2zs2kbOr7VFDlPe4CwnUTFVjH5/aExEQu9xa2y6Au9oC9E0xmC/vD2Rli53VCJDWrzUTnA7J3evQ6QbJUpsnXHQF8zZd87/ZA0FiDRDjZITQTiQeus9RLKL08jfobbRdbs1cMmBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M90jOke5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BC5C116B1;
	Wed, 12 Jun 2024 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718210778;
	bh=WQco/TtFmwtPptSfLGLzBaCcF7qBrspOVsH29Yreg+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M90jOke58UGSrPUEK2wo6P9/a6tGuxg2hhnL/SsVkI1PqjtFRL4vinUkC3YuTjiuy
	 ZxlxoUVqS2D2iyiEDlcdWFSbygIbV9v1RNR/yYnu/Lk2Le0RTqh6UJBwoYJHYokwl1
	 wa2ygWPoancIWjgK+dPjIEVztey5Ef5AA5IykbVsa5//xyWDOJQ7iMWPmQVBQR2U8V
	 d5Rt68RnFzQBeJk5pUL+idT2Up3/sB9D2RA/tzdwJrUC4tQLX1FxZvm0SB0BfDyK1i
	 U2p/uLGG8dw7dviNeScmSXebfGhs1BkBHhg58cz/5+10xWBvtNZ+9QcVVWaR0IhMVX
	 ZyIqdrLJYi6yw==
Date: Wed, 12 Jun 2024 17:46:12 +0100
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
Subject: Re: [PATCH v2 4/6] dt-bindings: riscv: Add Sipeed LicheeRV Nano
 board compatibles
Message-ID: <20240612-marlin-nineteen-f7c348b12a2b@spud>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-4-19a585af6846@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tq2aSu6KUZzbmE/o"
Content-Disposition: inline
In-Reply-To: <20240612-sg2002-v2-4-19a585af6846@bootlin.com>


--Tq2aSu6KUZzbmE/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 10:02:34AM +0200, Thomas Bonnefille wrote:
> Document the compatible strings for the Sipeed LicheeRV Nano B board which
> uses the SOPHGO SG2002 SoC.
>=20
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Tq2aSu6KUZzbmE/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnQ1AAKCRB4tDGHoIJi
0mRUAQDZ7AXfOi+XqbOn03XGi2ywetfbxT+USN+QzfRX/RgX0wD+OF3Y1v1+Ge7s
BNIghg0wrRtnoFIBsHAEaYdtbhh4wgY=
=85Ho
-----END PGP SIGNATURE-----

--Tq2aSu6KUZzbmE/o--

