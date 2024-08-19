Return-Path: <linux-kernel+bounces-292539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D154B9570A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759681F2349E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1A1779AE;
	Mon, 19 Aug 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlhV1lP4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF34154C18
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085908; cv=none; b=lUjHbEslZ9mA2kI2mhOf5MGzjywDnJODRRTHDxbJaoz4CqfTJjxKYyKpjl9NFSm4obil7pgGQV9fqnHKfqUB7LVlqC7WZi19qMOHvBA3zEquvuBTh21mjPfK3/ky/UbuDXiKRYlzUqzSCz4Mnr7LSqrRlAAXAuQQIDT7m9H7TVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085908; c=relaxed/simple;
	bh=3pNbCoAUzrDDebWTc7DBPabwhlPFOO2MZh48diZHMQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtQX1JhJnl6OLN01H5dzIdpLu6nQxXOXrPHIFJOxRIOHf5HvHHA4lPpMuWNe14nqpx4dplybgor0bjEXtCQeJaS9AlW3oMMvl1KYhmieF9ZiBmDLqYYBo6dNdbMORcfztieWTNwzkt8OuPHipwNKiBQgx3SgbmPr0mwzcblb5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlhV1lP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5ABC32782;
	Mon, 19 Aug 2024 16:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724085908;
	bh=3pNbCoAUzrDDebWTc7DBPabwhlPFOO2MZh48diZHMQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlhV1lP4ZTSNfcDcXU5mcakYDCoYfyfaQYwmIMn6qQX/CnVaHekKUL6h3abTAdv0w
	 GqGtYOUkS0XLOdEkzdCKnagtNmzVChD+ZaZ9/0CPc1izn7oGOy8LmhwBTBQCZEN+dD
	 t8w182okggKMrkkesPbm3S0OeJJDasyqHAbTa/IpDkcsvuah9fOZPatdK859i/eC6+
	 3Kwnfx9f5sBLAOI6LYMK3ldtnFH/tDbBCgFRrddfX0gz9072zbfzRrb3OWGjb2Zhuu
	 Q4Jt55wCxVbmL9OSdVW2L3iOFcNm7fbC0ZXD76jGcZLdRa3HPSwzS6rhvlZbb8lJgV
	 4zxWaMsD6Gc3A==
Date: Mon, 19 Aug 2024 17:45:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] riscv: Fix toolchain vector detection
Message-ID: <20240819-unbiased-feast-846ab1347aaf@spud>
References: <20240819001131.1738806-1-antonb@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3xY+Q/aPeQavJq/a"
Content-Disposition: inline
In-Reply-To: <20240819001131.1738806-1-antonb@tenstorrent.com>


--3xY+Q/aPeQavJq/a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 12:11:31AM +0000, Anton Blanchard wrote:
> A recent change to gcc flags rv64iv as no longer valid:
>=20
>    cc1: sorry, unimplemented: Currently the 'V' implementation
>    requires the 'M' extension
>=20
> and as a result vector support is disabled. Fix this by adding m
> to our toolchain vector detection code.
>=20
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

This one definitely needs a cc: stable, it's required as far back as
6.6, right?

> ---
>  arch/riscv/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0f3cd7c3a436..939ea7f6a228 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -552,8 +552,8 @@ config RISCV_ISA_SVPBMT
>  config TOOLCHAIN_HAS_V
>  	bool
>  	default y
> -	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64iv)
> -	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32iv)
> +	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64imv)
> +	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32imv)
>  	depends on LLD_VERSION >=3D 140000 || LD_VERSION >=3D 23800
>  	depends on AS_HAS_OPTION_ARCH
> =20
> --=20
> 2.34.1
>=20
>=20

--3xY+Q/aPeQavJq/a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsN2kAAKCRB4tDGHoIJi
0mYNAQCuFMhheZiAczWfLmrWVi1D6L7EvFHtyjcWAptZgC0zNgD/WN1HL6BnW6mG
drVFk2pz7DjaJWSGXjtmDAPRxUzhEAo=
=pkXY
-----END PGP SIGNATURE-----

--3xY+Q/aPeQavJq/a--

