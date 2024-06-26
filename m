Return-Path: <linux-kernel+bounces-230983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46193918492
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD931F2B173
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632418A925;
	Wed, 26 Jun 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4V4QX43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BE1822C2;
	Wed, 26 Jun 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412653; cv=none; b=OALZrS0QsQPgY41FLpXeNcfztSkenrP8x8ptiDGUBBx/GVvoMPxW3ElmCaJeQI6sck5mIW9/R2fne9jrgPsAu/rT8U2310XHwtIRw0sLQvCvw7EgOvG6LG0za5ZWoPKMsp/k0U5qP/xHYPO+2Amg2INfaGLReiZFswR1eczHPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412653; c=relaxed/simple;
	bh=PYkxYTf3qacON7qTPkUSIFqgLFAzCd9sm81fWI0HDGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ+8UBB5V9jmpezwO4Yn+vrbFzBaZkO0ciYFPxHKK5tOdV0a6RJKjj/WThZcIYbUY7sPqNKWTRJ62eisZOC5lcKanBDMivUDqXrSt0LSjMY5TOEaUGtFXcnfGUsY76auI3tiEJHbA3SD0Be2ab3eh5KPNcBfBqwZAfOxVPwV3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4V4QX43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F249C116B1;
	Wed, 26 Jun 2024 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719412653;
	bh=PYkxYTf3qacON7qTPkUSIFqgLFAzCd9sm81fWI0HDGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4V4QX43NnWfSBzTFkjcNxMw8ssJEe+sYmCUOzGlwf/z/K2Xq3TuZabVIFpj72x6S
	 op9t9m5KORwZSIl2pUmH4GQRtBzgt3jFodc7+dUz6BFTYpC7j4VWxB0hBs5K21JKBy
	 eUcmBsae3DSfrvQZo+PocNWXjBcD/a+zUbJ9AEiiLUUQqK+23+NvHfrHJ2720Z1zJ4
	 qJiQgZzbmm9E5rbKTys/3Y75PhZL8CfnmcZs3eW7txxy2bc8vITXZMkWjUDObqEHVI
	 Oc8MIRcztmkcRHYxp4nal9LcZxVVm5W6y0bRL5A+Rb/r8eADEtCSDCfUl9F1cfd6UM
	 fot1HmhAZ9h+g==
Date: Wed, 26 Jun 2024 15:37:25 +0100
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
Subject: Re: [PATCH v3 8/8] RISC-V: hwprobe: Document unaligned vector perf
 key
Message-ID: <20240626-cost-agenda-32aa8b68eed7@spud>
References: <20240625005001.37901-1-jesse@rivosinc.com>
 <20240625005001.37901-9-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N6mg3s0wYBE+WDSI"
Content-Disposition: inline
In-Reply-To: <20240625005001.37901-9-jesse@rivosinc.com>


--N6mg3s0wYBE+WDSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 08:50:01PM -0400, Jesse Taube wrote:
> Document key for reporting the speed of unaligned vector accesses.
> The descriptions are the same as the scalar equivalent values.
>=20
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V1 -> V2:
>   - New patch
> V2 -> V3:
>  - Specify access width
> ---
>  Documentation/arch/riscv/hwprobe.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index 7085a694b801..d102b4a16d55 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -236,3 +236,19 @@ The following keys are defined:
> =20
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF`: An enum value descri=
bing the
> +  performance of misaligned vector accesses on the selected set of proce=
ssors.
> +
> +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN`: The performance of =
misaligned
> +    accesses is unknown.
> +
> +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_SLOW`: 32bit misaligned acces=
ses are slower

s/32bit/32-bit/

Thanks,
Conor.

> +    than equivalent byte accesses.  Misaligned accesses may be supported
> +    directly in hardware, or trapped and emulated by software.
> +
> +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_FAST`: 32bit misaligned acces=
ses are faster
> +    than equivalent byte accesses.
> +
> +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED`: Misaligned acce=
sses are
> +    not supported at all and will generate a misaligned address fault.
> --=20
> 2.45.2
>=20

--N6mg3s0wYBE+WDSI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnwnpQAKCRB4tDGHoIJi
0kAdAP9dobN6gthH8CDv02wpvxrbh1f/0uKnZEb0OUliog5EuAEAn5VK1pvU+xp9
v3XNf378UlI8mArax8VWdHbpzZXYKQY=
=5BAx
-----END PGP SIGNATURE-----

--N6mg3s0wYBE+WDSI--

