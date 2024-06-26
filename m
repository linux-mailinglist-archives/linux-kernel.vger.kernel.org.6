Return-Path: <linux-kernel+bounces-230985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C11B91849A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4211C22B12
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1667186E3C;
	Wed, 26 Jun 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSTSbTwP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FD1822C2;
	Wed, 26 Jun 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412796; cv=none; b=HqlazLdQnjJJ3X2ugRAiKvTeFL1anpmh5oaE0/hjQf6sJpHlHuYEQsGtHgJNEOI+8S/9cSKTpI6eaQlLUdHpSAE4yx92ogQLGSrTm7Kfo+FV3CP/9SpMTxrC8Oe9Z+3vX8fsV/b0/uQiBYAlBq0eqCWmY83qML67xvDILqp8f4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412796; c=relaxed/simple;
	bh=UwgeX3D1QGrQO5sAKbV1ypqL8APwiG1+96Pmy9n5yoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMUQrSx4xR1nZgab1fT2d4VRp7kC5+sIUJRC55HkGNWznImQzyffTgxpZOGBfYiMHR2LmbegJaU0uWhay7klXJr6MsAhBgu5tnyCUPoZBvKHMhPvcTCSr6TQ1ojGhFzobSG0+lrr/RtoPeB/MtwI8tLCs5B2pYP6GdAQrUnkXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSTSbTwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22572C116B1;
	Wed, 26 Jun 2024 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719412796;
	bh=UwgeX3D1QGrQO5sAKbV1ypqL8APwiG1+96Pmy9n5yoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSTSbTwPaG4oTYr+cVBxJqKkOIcA7zIwhIdHHAgKx2zUCxr4PirdTGpRu+wGTRRm6
	 2oLAi2eBUmtcdbPWk+94orDN7peq2isepz1WrKpuTiQab1p0akDkAzG+wEOgaiP9Xy
	 0dDwb6FA3NECV2SGjK9qa67yoLF9WXab8h8rEUv/+qUrn7MHhq/wQAYGtWew/GAdX1
	 LUqLw6devPONfhH7OwDci+STr1azWFgnmqqd7v89BC366WLu+4FRPTO6xTQeqztQWb
	 s7i0bsrydakYQFtTyoP86oTA2/hN7JWmr9vNSPboYzVBFjz7guguK+s8YgfG7Ptt+S
	 aBKlRDoHwEdUQ==
Date: Wed, 26 Jun 2024 15:39:48 +0100
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
Subject: Re: [PATCH v3 5/8] RISC-V: Replace RISCV_MISALIGNED with
 RISCV_SCALAR_MISALIGNED
Message-ID: <20240626-onscreen-shack-f248a88ee7e4@spud>
References: <20240625005001.37901-1-jesse@rivosinc.com>
 <20240625005001.37901-6-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TztcxSdZZ9GztBGT"
Content-Disposition: inline
In-Reply-To: <20240625005001.37901-6-jesse@rivosinc.com>


--TztcxSdZZ9GztBGT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 08:49:58PM -0400, Jesse Taube wrote:
> Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED to allow
> for the addition of RISCV_VECTOR_MISALIGNED in a later patch.
>=20
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--TztcxSdZZ9GztBGT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnwoMwAKCRB4tDGHoIJi
0oa+AQDU+Kf1NECG/0+ci6wOtGzL0lKc1YAIVfGFV5YqJ8fP0gD+OeL/3OlDykVQ
84pJQzBnrYCyh/HpSycgHh5wIR2I0QY=
=eR+u
-----END PGP SIGNATURE-----

--TztcxSdZZ9GztBGT--

