Return-Path: <linux-kernel+bounces-255120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11A7933C57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5802F282DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE017F393;
	Wed, 17 Jul 2024 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPC9kDzi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216DA12E48
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215946; cv=none; b=fQI8XImZdA7Y1cEiJtFa1cGedA7G1x3gUZXykjiQ88OUdiVrCLyjxsf1zUa/ykJ2ajDx36TTbjRxReB8JlQDNUka+CwFwbxl3Z2FQMGE8m4Di4ilRVMuhjIodoQ1EYBC0dUYeGvK2SjhcLFkON3aGxKq/FM8SzmQc52wvlWCSC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215946; c=relaxed/simple;
	bh=flHhtXPXSXPa/MuixsU//ACv+ux6XIZuEc3LtB5sTfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoEx0OQrvvU9B8Zmc8tUDfYntUBsBQLACcry1YtCJtmiR1BxjSFSKbg7K1JcVAoab5WlkfUv8v+RBeQ1ZMdf38U+C1WfjKcYbVzc0KPsc8tqdb26VGySQ+Yat8+elVSYb24R3+xJ45D4Z20s+UyKnYj8/puxTVYBsfIQQwgzLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPC9kDzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7CCC32782;
	Wed, 17 Jul 2024 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721215945;
	bh=flHhtXPXSXPa/MuixsU//ACv+ux6XIZuEc3LtB5sTfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPC9kDzix/T6vvU8OcpTXLcWC1NotvFforrkq+dybb+9xzZLcv5dktrzJIxioMbuh
	 x7tBq00XgDovdFjN8DGMtHDG0zJahSycdTXDdmrqv8UXy89XJlv6BXHuFMH7m6io37
	 BXo0mH4UrvyGdV0is3r8ZdoznUAeZIXY+apbl2ubV5EgqE3Vr7gacrKXLpZ6MjQK4e
	 NFbd+RqVXh5ISZjyqmZz23uPsNZaAYSw7i40S/qXAc8skD5KCQdNBrX6/nsGhd4VJI
	 BB9Q0aSS4nW5bCn3HtgasUMFIkm1YP+qqCwmN/Gc0LWUGQxbmK011tRhinaQbOAV7d
	 BaSo6CNbjPPUw==
Date: Wed, 17 Jul 2024 12:32:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH RFC] riscv: Allow to build only with LLVM >= 17.0.0
Message-ID: <20240717-synapse-decade-a0d41bd7afce@spud>
References: <20240717111716.157149-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TF/YrikB1RktwJDs"
Content-Disposition: inline
In-Reply-To: <20240717111716.157149-1-alexghiti@rivosinc.com>


--TF/YrikB1RktwJDs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 01:17:16PM +0200, Alexandre Ghiti wrote:
> The following build failure happens when using LLVM < 17.0.0:
>=20
> kernel/sched/core.c:11873:7: error: cannot jump from this asm goto statem=
ent to one of its possible targets
>=20
> This is a known issue [1] so let's upgrade the minimal requirement for
> LLVM to the version 17.0.0, which is the first version to contain the
> fix.

I think doing this unilaterally is kinda insane, LLVM 17 isn't even a
year old. Debian testing doesn't have anything later than 16. Why does
it need to be done unilaterally rather than just when the qspinlock
stuff is built?
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomment-1=
645979992 [1]
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407041157.odTZAYZ6-lkp@i=
ntel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

If Nathan wrote the patch, you need to set him as the author of the
patch :)

> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>=20
> This patch was done by Nathan, I'm just sending it as an RFC to get quick=
er
> feedbacks.
>=20
> I tested it successfully.
>=20
> Note that the build failure happens on the not-yet merged qspinlock
> patchset.
>=20
>  scripts/min-tool-version.sh | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 91c91201212c..e81eb7ed257d 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -28,6 +28,8 @@ llvm)
>  		echo 15.0.0
>  	elif [ "$SRCARCH" =3D loongarch ]; then
>  		echo 18.0.0
> +	elif [ "$SRCARCH" =3D riscv ]; then
> +		echo 17.0.0
>  	else
>  		echo 13.0.1
>  	fi
> --=20
> 2.39.2
>=20
>=20

--TF/YrikB1RktwJDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZperxQAKCRB4tDGHoIJi
0gdEAP9qtuD78DbyTCIpoH5rcVAZnR0Q3JTpPVcwNFbIh+LTQAEAo+7SP8L4lcz0
B2xFk3t/Af8fu8ktYXwz/L+plR/tmww=
=BgLp
-----END PGP SIGNATURE-----

--TF/YrikB1RktwJDs--

