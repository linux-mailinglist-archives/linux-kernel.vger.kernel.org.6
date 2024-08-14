Return-Path: <linux-kernel+bounces-287265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C8A9525A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E266E2814CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118D149C69;
	Wed, 14 Aug 2024 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAXAWXzu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E302250269
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674395; cv=none; b=Zshviz2JJZfOReUvIdIcBskCQYakNlRcL1b7euTJEBcpU/CqllgbmTNMgcK4oa0oLQSQJLe1oVu0tqEHlszXVWacDntPK8LM9L+GH6x8qy+b837pq+3h4Nu8SKRgtxTzEf8egdB2H3E7ScZ4aHdByU7y+awBg+++3Tg7+ljv1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674395; c=relaxed/simple;
	bh=/ev7QCuOLeF1lnYSvn4BubTgvgqIJVaNow7skyZz3x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTHVSLlX5NWbj9ugtFh24pCwyL/+GXYtHUzMh1Vi1RDZuLspJu3Nonfu0qPXUyVeBtb5JbTHPhdUJzFc7u0HvVZOm6S0KN12vc6SX9vZw6AEy9DVyVA6xHkRduvv5elf0qhaYtf/ia9ORmgSaguALyZGChMBoQCTT9CoGwEl5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAXAWXzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C963C116B1;
	Wed, 14 Aug 2024 22:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723674394;
	bh=/ev7QCuOLeF1lnYSvn4BubTgvgqIJVaNow7skyZz3x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAXAWXzun1RciKPEGpCpDV2IGY85v1I6a+F4jKCwSSmc67gWUyXzZsu+A3wiJ1U5e
	 RNBEppKXsP86JKxVA5LxwCgF5j1blUH/rx5o4qPzORqjm8JoxOlO6/zR4EhyD/kPjn
	 jVt6FTgZ9k4jfHCzv6in46SJFd3vUiPl+3S9RYmT1CqwpxLjyFoqAZAIN7vd+T9KMY
	 +pHZcCBqYdutf4nb4poolDQYht/tjtdYgZXjMunqm468TNeuNVP7YpGjgZ/XsuYvts
	 66PCQIlF5j1LbpPtoczK675DGJium5W9xG97xRTxa2wg3Bq67hUdOVLTARqBvhCtr0
	 t0ZCKrF0a7iKw==
Date: Wed, 14 Aug 2024 23:26:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes v2] riscv: Fix out-of-bounds when accessing Andes
 per hart vendor extension array
Message-ID: <20240814-overexert-baffling-1abf9a80c7b0@spud>
References: <20240814192619.276794-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2WckljnaeUer3GVg"
Content-Disposition: inline
In-Reply-To: <20240814192619.276794-1-alexghiti@rivosinc.com>


--2WckljnaeUer3GVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 09:26:19PM +0200, Alexandre Ghiti wrote:
> The out-of-bounds access is reported by UBSAN:
>=20
> [    0.000000] UBSAN: array-index-out-of-bounds in ../arch/riscv/kernel/v=
endor_extensions.c:41:66
> [    0.000000] index -1 is out of range for type 'riscv_isavendorinfo [32=
]'
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2u=
buntu-defconfig #2
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] Call Trace:
> [    0.000000] [<ffffffff94e078ba>] dump_backtrace+0x32/0x40
> [    0.000000] [<ffffffff95c83c1a>] show_stack+0x38/0x44
> [    0.000000] [<ffffffff95c94614>] dump_stack_lvl+0x70/0x9c
> [    0.000000] [<ffffffff95c94658>] dump_stack+0x18/0x20
> [    0.000000] [<ffffffff95c8bbb2>] ubsan_epilogue+0x10/0x46
> [    0.000000] [<ffffffff95485a82>] __ubsan_handle_out_of_bounds+0x94/0x9c
> [    0.000000] [<ffffffff94e09442>] __riscv_isa_vendor_extension_availabl=
e+0x90/0x92
> [    0.000000] [<ffffffff94e043b6>] riscv_cpufeature_patch_func+0xc4/0x148
> [    0.000000] [<ffffffff94e035f8>] _apply_alternatives+0x42/0x50
> [    0.000000] [<ffffffff95e04196>] apply_boot_alternatives+0x3c/0x100
> [    0.000000] [<ffffffff95e05b52>] setup_arch+0x85a/0x8bc
> [    0.000000] [<ffffffff95e00ca0>] start_kernel+0xa4/0xfb6
>=20
> The dereferencing using cpu should actually not happen, so remove it.
>=20
> Fixes: 23c996fc2bc1 ("riscv: Extend cpufeature.c to detect vendor extensi=
ons")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---

You're missing a changelog here, which is doubly important when you drop
tags provided to you on an earlier version.

>  arch/riscv/kernel/vendor_extensions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/ve=
ndor_extensions.c
> index b6c1e7b5d34b..a8126d118341 100644
> --- a/arch/riscv/kernel/vendor_extensions.c
> +++ b/arch/riscv/kernel/vendor_extensions.c
> @@ -38,7 +38,7 @@ bool __riscv_isa_vendor_extension_available(int cpu, un=
signed long vendor, unsig
>  	#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
>  	case ANDES_VENDOR_ID:
>  		bmap =3D &riscv_isa_vendor_ext_list_andes.all_harts_isa_bitmap;
> -		cpu_bmap =3D &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap[cpu];
> +		cpu_bmap =3D riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap;
>  		break;
>  	#endif
>  	default:
> --=20
> 2.39.2
>=20
>=20

--2WckljnaeUer3GVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr0vFgAKCRB4tDGHoIJi
0mB+AQCcii4hZUx8zB75c5EsWMRUDn1M+ZGtmR1DLapyGuhBGQD8CbsaIrgPi1zP
2msCLpBPps1IC1HoBJ8XLXf7PspTWww=
=b/13
-----END PGP SIGNATURE-----

--2WckljnaeUer3GVg--

