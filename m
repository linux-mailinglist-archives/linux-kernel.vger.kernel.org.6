Return-Path: <linux-kernel+bounces-283361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64F94F17B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689592828A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4A1802AB;
	Mon, 12 Aug 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrx0T1UG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B39450F2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475811; cv=none; b=AH3apOMSPfcVtZqiBbrxZXgnt2nBZK9zG6KyKCFcmPigy2pkkhjR3fsiWrC0QNgiXUeCznx0q2vwuy8tTjLCW+DxqYo3IxpqtMFWlFVj7C40bSodUK9A9YnO5nmo9ryHrj7TbbXviCR/+SZQcpeTMHVYcUWL0cgcVzKvgXQ0qgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475811; c=relaxed/simple;
	bh=pD/+4um3c3Lin4UbxwH5WoHOz/QB/EzM+2JywSi/0O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYSFeZJ+222M/8gI7JvyUsaJkfMKUKuy3DNNOh1Z+zutaXwq7dWDQ+8ynb/5dfvZsHoe+5SD9nPfF/jgyMMlXSM1XN2++59kAsJRHWzSJuNqkWehV8J5Zi5Hn93v3PuDKYauKJfGOxE1NJ6+7QmNBQl+VanAhCOEcUq4LKvwkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrx0T1UG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD05C32782;
	Mon, 12 Aug 2024 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723475811;
	bh=pD/+4um3c3Lin4UbxwH5WoHOz/QB/EzM+2JywSi/0O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrx0T1UG9Gy0x2bYxreE1pQjveabFgsSd4/dkUk8Hsis0iiedw+KrCVZEUqQdVnNG
	 hY7EK+UtyXvdL5hhqvz6wMXbUp4e/ftkliw8SgsfF9Ne63owqyOlrsN4NqG/i+ji4g
	 qWLG2r2rsCQhHDoQbGrTaz7QjpZ9Zj35tJEop1rhF0zDVb6C1OxHKESk3hNNjjBFRY
	 BfVGBWM6Qd8AHkrIjxRekO3aikIhWyLfHRYPgG+6tkD0E3f+z/is6S9i82Kt5FNr/M
	 GlVY5GUIRLH9cczKo+E9Lk/KgKfyTmU9n8I1Soa/lytr2e7oekC+SxmJxzXqu6Meog
	 bIMwgUFxCyopg==
Date: Mon, 12 Aug 2024 16:16:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix out-of-bounds when accessing Andes per
 hart vendor extension array
Message-ID: <20240812-viper-handed-b5fd421c73f9@spud>
References: <20240811150229.82321-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="et7i5P6lqCWValIK"
Content-Disposition: inline
In-Reply-To: <20240811150229.82321-1-alexghiti@rivosinc.com>


--et7i5P6lqCWValIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 05:02:29PM +0200, Alexandre Ghiti wrote:
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
> This happens because we unconditionally use the cpu parameter to access
> this array. But if -1 is passed, that means we should not and we don't
> need to access this array, so simply prevent accessing the array in that =
case.
>=20
> Fixes: 23c996fc2bc1 ("riscv: Extend cpufeature.c to detect vendor extensi=
ons")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Tested-by: Conor Dooley <conor.dooley@microchip.com>

--et7i5P6lqCWValIK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZronXwAKCRB4tDGHoIJi
0lzsAPwNYLkTFWkih6zFUZ1EtUByB/vgeCagFVu8E3p4AS71owEA0kudo8htC+3f
slCc/+K8Uw9hUBE21ADtJJRt3133Cgs=
=avO9
-----END PGP SIGNATURE-----

--et7i5P6lqCWValIK--

