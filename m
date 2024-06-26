Return-Path: <linux-kernel+bounces-230984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF5918497
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2603B1C22826
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71196185E7F;
	Wed, 26 Jun 2024 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGNMZWMC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28511822C2;
	Wed, 26 Jun 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412762; cv=none; b=b6ufcZ5B79J+0IIlkjz61LhflQYvXxy0APNagzHgKO8QrrfKRX6ftx1r/tQz4QcRLhQ+oq3yP7hL5oiB3PoUIpo0KUcULitxlMSh20lL9AbXQW1y2H7A3UB0sw0pR+EJ0CbmdJN8nv6UTQK/T8AAXwzFLdNlfcFAX5XS0N2yELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412762; c=relaxed/simple;
	bh=A7sl8CPPaVUstW1VuKH/AzdyszBx003K6aNayxGnNsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo3z5hT6RwN++GFWFYjjl8LEVpSIFBA/PY/l4FL4/Ny6Tjhu4HAGtB1RGZWJm5pCHmLtrn3Ml5SrUF22kq+7yi6jX2TgbQx54lkHEIj3s7/ulDn1qV9+M3XA323qORuxys/xTWEtx1RygsJCTWYbV8abZXnlBCaVWkMcX1lhYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGNMZWMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583B3C116B1;
	Wed, 26 Jun 2024 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719412762;
	bh=A7sl8CPPaVUstW1VuKH/AzdyszBx003K6aNayxGnNsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGNMZWMCelzit7KEq0uGy6ZHa1de205PzOdJS5GsrSsFfIt+vFkadx2GE/9tXY5sg
	 pyDvBD0BDhj+G16M1vX1b5gWLW+fiRtGZum9NSKlaIk5i/Ap3LvOdmhEM8pIPHhbzG
	 05l9yqlRNt8T1So3UwyboALbmROobKmjuL4f6iPN+bYR+g9RV/sSOMnfdlxpHmCTUR
	 n20L7H3gPlPwPJb+Tyf4w/+wkJcWa3zKxNl9eNQ6kXwh80P2psuQa38L+T8sOb3hBC
	 QUhamfxNHu+me/DCMrHScymncia/ZMY+6PMHMMDaohJPYiFXSVmnO40lD+jb2yLL1i
	 z3G+kg0X6RZWA==
Date: Wed, 26 Jun 2024 15:39:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/8] RISC-V: Check Zicclsm to set unaligned access
 speed
Message-ID: <20240626-march-abreast-83414e844250@spud>
References: <20240625005001.37901-1-jesse@rivosinc.com>
 <20240625005001.37901-5-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zHOnQ2y5n0TrwW6w"
Content-Disposition: inline
In-Reply-To: <20240625005001.37901-5-jesse@rivosinc.com>


--zHOnQ2y5n0TrwW6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 08:49:57PM -0400, Jesse Taube wrote:
> Check for Zicclsm before checking for unaligned access speed. This will
> greatly reduce the boot up time as finding the access speed is no longer
> necessary.
>=20
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V2 -> V3:
>  - New patch split from previous patch
> ---
>  arch/riscv/kernel/unaligned_access_speed.c | 26 ++++++++++++++--------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kern=
el/unaligned_access_speed.c
> index a9a6bcb02acf..329fd289b5c8 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -259,23 +259,31 @@ static int check_unaligned_access_speed_all_cpus(vo=
id)
>  	kfree(bufs);
>  	return 0;
>  }
> +#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> +static int check_unaligned_access_speed_all_cpus(void)
> +{
> +	return 0;
> +}
> +#endif
> =20
>  static int check_unaligned_access_all_cpus(void)
>  {
> -	bool all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus();
> +	bool all_cpus_emulated;
> +	int cpu;
> +
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
> +		for_each_online_cpu(cpu) {
> +			per_cpu(misaligned_access_speed, cpu) =3D RISCV_HWPROBE_MISALIGNED_FA=
ST;

- const: zicclsm
  description:
    The standard Zicclsm extension for misaligned support for all regular
    load and store instructions (including scalar and vector) but not AMOs
    or other specialized forms of memory access. Defined in the
    RISC-V RVA Profiles Specification.=20

Doesn't, unfortunately, say anywhere there that they're actually fast :(

Thanks,
Conor.

> +		}
> +		return 0;
> +	}
> +
> +	all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus();
> =20
>  	if (!all_cpus_emulated)
>  		return check_unaligned_access_speed_all_cpus();
> =20
>  	return 0;
>  }
> -#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> -static int check_unaligned_access_all_cpus(void)
> -{
> -	check_unaligned_access_emulated_all_cpus();
> -
> -	return 0;
> -}
> -#endif
> =20
>  arch_initcall(check_unaligned_access_all_cpus);
> --=20
> 2.45.2
>=20

--zHOnQ2y5n0TrwW6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnwoEgAKCRB4tDGHoIJi
0nz9AP97Mhuw65wobghk127Wwur0uFXEaFlNScYBqqh+mfmywAEAoFFB6kqgUedE
Bg3ErXmAie3wm8zEH1ifrdpajW8O5wQ=
=aDKF
-----END PGP SIGNATURE-----

--zHOnQ2y5n0TrwW6w--

