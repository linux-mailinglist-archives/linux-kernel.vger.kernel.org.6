Return-Path: <linux-kernel+bounces-180108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4728C6A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F102812F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDC415624B;
	Wed, 15 May 2024 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/DKxUTj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C715623D
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789179; cv=none; b=HghsY4nRBjYA5Z2ba1of3MwbtJyKzfhd35cqK9GMaVkAP6AXrdBo2VG/dwr+X5UWJ6dlr1zExgYdA5dJ6qF/+pVS8jHOV9+1WViirFxdwezBqbo/n5mroxTOFWSLc26iWgNGgOnrAU7SoTwX5u+eqaE8B4IePWT3uRXJKwfr0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789179; c=relaxed/simple;
	bh=FVFAYxSz1OkRMYh28r8zsQNRYiUe+v6bzZjbGukXwFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6DRBYU9uGvlECrcRywLRnefvqhq/o6b5i9v5k9K14TfUzkEjzmfygN0f8yGum6ZHJ8nmA447gpm+fPV3bQQCTbhfd95sBm2XXnHGiKi0qODuI6fxixdRS50Mt0IXRJUP/87rag7RCjHrcWMFovtx0c45n9Hs0GLFuOpt2aaTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/DKxUTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09665C116B1;
	Wed, 15 May 2024 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715789178;
	bh=FVFAYxSz1OkRMYh28r8zsQNRYiUe+v6bzZjbGukXwFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/DKxUTjDl9pXY58GoyNPDYosoEaoJP1PSw/3V5uG+PF/3CiGpqn0qul3RKw/kRHA
	 nhmo5V1CFbqBh7fyp18Pr9m385imgdDqSVusBXYprh3fPUbFVCuNB6WZMyueod4Eno
	 65YRqqUsBHEcH23XpuiQOtDIIHJ8vwFywBzaGSW4aMT0/7Q8ZLqijc84CgI4+avtH7
	 hGZJessBR8wyKMF50z5gXE01sFQTW9W1UvtTrQlnfAJ2PERDk8VKO+nIilbv2fDJhH
	 ytFD+8Si+6dzyeNcdHp4zPNQ5O+3FUv5ZdJ07RR+jeELxo5YtznsbVBHS8BmVn3DTh
	 DS6AuVnG0MwDA==
Date: Wed, 15 May 2024 17:06:14 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: fix Andes errata build issues
Message-ID: <20240515-bobsled-corridor-a3f295972e98@spud>
References: <20240515-shimmer-retake-37033de08096@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u8jT4CtR+31zyd66"
Content-Disposition: inline
In-Reply-To: <20240515-shimmer-retake-37033de08096@spud>


--u8jT4CtR+31zyd66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 05:02:28PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> Commit Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor
> extension framework") added includes for the new vendor_extensions.h

This commit message is actually inaccurate, I'll spin out an immediate
v2..

> header in the T-Head and SiFive errata handling code but didn't do so
> for Andes, resulting in allmodconfig build issues.
>=20
> Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor extensio=
n framework")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Charlie Jenkins <charlie@rivosinc.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/errata/andes/errata.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/e=
rrata.c
> index a5d96a7a4682..fc1a34faa5f3 100644
> --- a/arch/riscv/errata/andes/errata.c
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -17,6 +17,7 @@
>  #include <asm/processor.h>
>  #include <asm/sbi.h>
>  #include <asm/vendorid_list.h>
> +#include <asm/vendor_extensions.h>
> =20
>  #define ANDES_AX45MP_MARCHID		0x8000000000008a45UL
>  #define ANDES_AX45MP_MIMPID		0x500UL
> --=20
> 2.43.0
>=20

--u8jT4CtR+31zyd66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTddgAKCRB4tDGHoIJi
0tagAP4quEfVezaSy0cvTJHJIIALZZzUPi+usFdsUiF6/NhBxwD/e2/+gbQRWRnq
lrfOh9ipPvQ5CficGRd6P3fGzTxcGwU=
=vIlF
-----END PGP SIGNATURE-----

--u8jT4CtR+31zyd66--

