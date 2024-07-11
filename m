Return-Path: <linux-kernel+bounces-248708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D301A92E0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5D81F20F91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B67148FFC;
	Thu, 11 Jul 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="OkQ/mKZK";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="ZDf29vfv";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="dTnD9rKT"
Received: from e2i411.smtp2go.com (e2i411.smtp2go.com [103.2.141.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AF3130A47
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683193; cv=none; b=Sw57AEEmKjit9KD6mQrVvdwgnAA1kDwfghQQ6OAnh1No/v/KvCg8nScryN8pHtCFCVxSQVxsE2291BCiDOUsCh09Syy6Csoho+AV/AX0ht/5o+ut6Zd7mKUL5qu0FsDsw+cEBk6pY2IMBSoLJo7/sYf3WYQkqSqBx08n9oTYR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683193; c=relaxed/simple;
	bh=tmLvCWTAKrNvC+hTqcmobUhdkjTB6x/wWsoTeFLiEa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRctiac9JjSksjAyjL6ifC8f+xVX8+LdtzCqHNHMjO//M5Psx0s93pm8N0Zg0pQIL9Mj9ixVafGFtAl8fUzb+YjPYBVvDdoaHHqm1Oxqa7ZxHbYw+Uo9NSnFUd6JZDposuDZEC5tpGgvvYFVuPX5VQrdvQ6Nua/kYR0jdqEGWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=OkQ/mKZK reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=ZDf29vfv; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=dTnD9rKT; arc=none smtp.client-ip=103.2.141.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1720684081; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=LhhC1XDkDuM3AReiatmP9njXLuykYg2VbD9+n1H5eAE=; b=OkQ/mKZKtz5iDpT3L7fRUg0V7j
	pbLjB13QxOwlcXO+aljLNoNyHvAwZVoob6E0BMz4uDwUra80PFliDoqZsHvJP34DYO6hfa1gcT4nQ
	pXzd7UJjlPQI4caDXg1FMhSqnp8F4Rqm0F3cL+ssYuJM1x+kY7aMXCj0HANcAQsJyOIX0/gOv7Gbq
	u1bYtCHQjEwJsferq0FXM8Qexp3B21l8m173B00sab3uPtG2r9habMHhv5zy0eticeymBBocShQOp
	83pCb/g6SrrRCpOI0kKTGjkJvQ9WD7GgOcCxiJwlQ8ZQoLqfO2iFvlJi5JmCFTy79Ra9sZOutK906
	CC6m61rg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1720683181; h=from : subject :
 to : message-id : date;
 bh=LhhC1XDkDuM3AReiatmP9njXLuykYg2VbD9+n1H5eAE=;
 b=ZDf29vfvjWaHCqO8Ptk3Rer8O3fxFg0ZZ8xV5NCnChQ1Kc2kOn953BJqM6fWsxc4g60Gj
 GOCdHPlo473VDufnYpi7PmRFqB50uBDUOU056gKlrtEW6M8Rx2DFBlizRlrJ+cF5gIzoa1G
 WoDxrgw1TVf1WhVVNgrNvq65SmyhKvRPD+BMDQ8bZrZqxVhynQTsYqdogwi8LHJsamlgC9v
 akx1o23W+42OkN/MapBeh6cV1+M+egIDf0Sre2KNTq3k4BjN3sBoMFuvxqTnDNXaH8VTC4b
 5OV6LSFSBAetjof2kuJE3pzQmR2sE+CIWQmAvlcU4R9jG/fbHthb+Ri4RRaA==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sRoHy-TRjx74-2c; Thu, 11 Jul 2024 07:32:26 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sRoHx-4o5NDgrgPEw-mkkl; Thu, 11 Jul 2024 07:32:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1720683144; bh=tmLvCWTAKrNvC+hTqcmobUhdkjTB6x/wWsoTeFLiEa0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dTnD9rKTeX0q63zhPwi/SPZEvF3+zHJ7MUg0YD55cxD70lCgK+fVIGWbDVUm1XOP/
 UmeOyJeCCNyGw6MUZfmbtkh1sQg5ksOBAB8i9dmdQnyDXIm2iZkSdCokeV0Y981TP/
 6MXmDa6pr1xybtzr7HwoqUGnA6YjYDm6ny1XpyPM=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id CEAD73E8F7; Thu, 11 Jul 2024 09:32:23 +0200 (CEST)
Date: Thu, 11 Jul 2024 09:32:23 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v4] kbuild: add script and target to generate pacman
 package
Message-ID: <Zo-Khw3jf-hSdD2S@fjasle.eu>
References: <20240710-kbuild-pacman-pkg-v4-1-507bb5b79b2a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lZCcCeLzBRWDqdbM"
Content-Disposition: inline
In-Reply-To: <20240710-kbuild-pacman-pkg-v4-1-507bb5b79b2a@weissschuh.net>
X-Smtpcorp-Track: Gackt8EGT7Cw.5SnQHwss6gV6.n34Lsw7Wakr
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286soGnZe9LlT
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>


--lZCcCeLzBRWDqdbM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry, I sent my last mail to quickly.  Three things below:

On Wed, Jul 10, 2024 at 09:32:28PM +0200 Thomas Wei=DFschuh wrote:
> pacman is the package manager used by Arch Linux and its derivates.
> Creating native packages from the kernel tree has multiple advantages:
>=20
> * The package triggers the correct hooks for initramfs generation and
>   bootloader configuration
> * Uninstallation is complete and also invokes the relevant hooks
> * New UAPI headers can be installed without any manual bookkeeping
>=20
> The PKGBUILD file is a simplified version of the one used for the
> downstream Arch Linux "linux" package.

The package is actually called "linux-upstream", right?

> Extra steps that should not be necessary for a development kernel have
> been removed and an UAPI header package has been added.
>=20
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
> Changes in v4:
> - Update MRPROPER_FILES
> - Unify shell variable syntax
> - Link to v3: https://lore.kernel.org/r/20240708-kbuild-pacman-pkg-v3-1-8=
85df3cbc740@weissschuh.net
>=20
> Changes in v3:
> - Enforce matching architectures for installation
> - Add Reviewed-by and Tested-by from Nathan
> - Link to v2: https://lore.kernel.org/r/20240706-kbuild-pacman-pkg-v2-1-6=
13422a03a7a@weissschuh.net
>=20
> Changes in v2:
> - Replace ${MAKE} with $MAKE for consistency with other variables
> - Use $MAKE for "-s image_name"
> - Avoid permission warnings from build directory
> - Clarify reason for /build symlink removal
> - Install System.map and config
> - Install dtbs where available
> - Allow cross-build through arch=3Dany
> - Sort Contributor/Maintainer chronologically
> - Disable some unneeded makepkg options
> - Use DEPMOD=3Dtrue for consistency with rpm-package
> - Link to v1: https://lore.kernel.org/r/20240704-kbuild-pacman-pkg-v1-1-a=
c2f63f5fa7b@weissschuh.net
> ---
>  .gitignore               |  6 ++++
>  Makefile                 |  2 +-
>  scripts/Makefile.package | 16 ++++++++++
>  scripts/package/PKGBUILD | 83 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 106 insertions(+), 1 deletion(-)
>=20
> diff --git a/.gitignore b/.gitignore
> index c59dc60ba62e..7902adf4f7f1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -92,6 +92,12 @@ modules.order
>  #
>  /tar-install/
> =20
> +#
> +# pacman files (make pacman-pkg)
> +#
> +/PKGBUILD
> +/pacman/
> +
>  #
>  # We don't want to ignore the following even if they are dot-files
>  #
> diff --git a/Makefile b/Makefile
> index b25b5b44af10..79e8dcec6be9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1497,7 +1497,7 @@ CLEAN_FILES +=3D vmlinux.symvers modules-only.symve=
rs \
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_FILES +=3D include/config include/generated          \
>  		  arch/$(SRCARCH)/include/generated .objdiff \
> -		  debian snap tar-install \
> +		  debian snap tar-install PKGBUILD pacman \

(thanks!)

>  		  .config .config.old .version \
>  		  Module.symvers \
>  		  certs/signing_key.pem \
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index bf016af8bf8a..a5b5b899d90c 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -141,6 +141,21 @@ snap-pkg:
>  	cd $(objtree)/snap && \
>  	snapcraft --target-arch=3D$(UTS_MACHINE)
> =20
> +# pacman-pkg
> +# ----------------------------------------------------------------------=
-----
> +
> +PHONY +=3D pacman-pkg
> +pacman-pkg:
> +	@ln -srf $(srctree)/scripts/package/PKGBUILD $(objtree)/PKGBUILD
> +	cd $(objtree) && \

Please prefix this line with a '+' to allow make job-server delegation to
sub-make called via makepkg.  This will prevent the make warning

    make[3]: warning: jobserver unavailable: using -j1.  Add '+' to parent =
make rule.


> +		srctree=3D"$(realpath $(srctree))" \
> +		objtree=3D"$(realpath $(objtree))" \
> +		BUILDDIR=3D"$(realpath $(objtree))/pacman" \
> +		CARCH=3D"$(UTS_MACHINE)" \
> +		KBUILD_MAKEFLAGS=3D"$(MAKEFLAGS)" \
> +		KBUILD_REVISION=3D"$(shell $(srctree)/init/build-version)" \

Just a note: In Masahiro's current kbuild tree 'build-version' has been mov=
ed
to scripts/build-version.  But I don't know on which base this patch will
possibly be applied to.

> +		makepkg
> +
>  # dir-pkg tar*-pkg - tarball targets
>  # ----------------------------------------------------------------------=
-----
> =20
> @@ -221,6 +236,7 @@ help:
>  	@echo '  bindeb-pkg          - Build only the binary kernel deb package'
>  	@echo '  snap-pkg            - Build only the binary kernel snap packag=
e'
>  	@echo '                        (will connect to external hosts)'
> +	@echo '  pacman-pkg          - Build only the binary kernel pacman pack=
age'
>  	@echo '  dir-pkg             - Build the kernel as a plain directory st=
ructure'
>  	@echo '  tar-pkg             - Build the kernel as an uncompressed tarb=
all'
>  	@echo '  targz-pkg           - Build the kernel as a gzip compressed ta=
rball'
> diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
> new file mode 100644
> index 000000000000..b0b133ac28eb
> --- /dev/null
> +++ b/scripts/package/PKGBUILD
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Maintainer: Thomas Wei=DFschuh <linux@weissschuh.net>
> +# Contributor: Jan Alexander Steffens (heftig) <heftig@archlinux.org>

I am not familiar enough with makepkg/PKGBUILD: Does it make sense to put
'set -e' here, as we (will) do in other kbuild scripts?  ('set -u' breaks
'makepkg'.)  Without 'set -e', shellcheck asks for error handling around 'c=
d'
commands.

> +
> +pkgbase=3Dlinux-upstream
> +pkgname=3D("$pkgbase" "$pkgbase-headers" "$pkgbase-api-headers")
> +pkgver=3D"${KERNELRELEASE//-/_}"
> +pkgrel=3D"$KBUILD_REVISION"
> +pkgdesc=3D'Linux'
> +url=3D'https://www.kernel.org/'
> +arch=3D($CARCH)
> +options=3D(!debug !strip !buildflags !makeflags)
> +license=3D(GPL-2.0-only)
> +
> +build() {
> +  export MAKEFLAGS=3D"$KBUILD_MAKEFLAGS"
> +  cd "$objtree"
> +
> +  # makepkg does a "chmod a-srw", triggering warnings during kbuild
> +  chmod 0755 "$pkgdirbase" || true
> +
> +  $MAKE -f "$srctree/Makefile"
> +}
> +
> +package_linux-upstream() {
> +  pkgdesc=3D"The $pkgdesc kernel and modules"
> +
> +  export MAKEFLAGS=3D"$KBUILD_MAKEFLAGS"
> +  cd "$objtree"
> +  local modulesdir=3D"$pkgdir/usr/$MODLIB"
> +
> +  echo "Installing boot image..."
> +  # systemd expects to find the kernel here to allow hibernation
> +  # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab812=
8dcf99161d2344
> +  install -Dm644 "$($MAKE -s image_name)" "$modulesdir/vmlinuz"
> +
> +  # Used by mkinitcpio to name the kernel
> +  echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

This looks funny, I think I'd just use echo "$pkgbase" >"$modulesdir/pkgbas=
e",
but this is probably just bike-shedding.

So, all in all it looks good to me, thanks!

With the jobserver-'+'-prefix added:
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Kind regards,
Nicolas

--lZCcCeLzBRWDqdbM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmaPioAACgkQB1IKcBYm
EmnGsRAAxhgsF3AzBnBDvQL2N6EJeUfKubcnL/F+b8btfLtJRLuGZJm/lLIf/tfK
Hm+rFqRonyC2tNml0C8H1f8T6Aln6KbZtKGM4Z3PjCTux6PQyOfSbfABfbuwHy3M
JUWFqz8Yd+dTJ3aDmh0RAgt5ugEj+FVgqnDuMeSJknn6jDuLsEeExwz99XbDuSN0
93k74xVezM8oEJwyXIlcYGcy6foZPSWUcU91yym0g63a8z0RNGdI1E6yXQWZRsYb
um1u0DSfErvVJ92gzBkBAuhXYswMoCFduvnZJ+ZxA9yGXrM8F8e5UYKzKHieadd0
Dg38LwdbXQ1kpAYYd4GUMHDECEzcyNRpwpxpNYpa0s60Qe5NogeHwBcf2rP+c4tI
oTVq4CHOBk4CpY92XCWlCKIH0wrkP5mYL6BxiPiFSwviQ9FYV+JAN5I9uAQZqWW0
NYLelFNJPI2yXGVnAyCawYlErnfP5vpygNIKAePNF9qI/xvMoJEU2oT8Vn79NEwx
9xSDHLzIFSRZvnX5xH2KTkLldiUv5KUZgyUTZDt4csSJM1wxwHOKw9V/TXXgWxdO
OAqXI4weabHi2m63iqJirH4jrjnYXa0h7A652SXSrXsDnrqGIz6OLzKCuH2K/iwI
Y7/50QpU/Q+jRRGYlT720aI0lo/705ddrlBqJx2E3trdE0Pzl9I=
=fxKc
-----END PGP SIGNATURE-----

--lZCcCeLzBRWDqdbM--

