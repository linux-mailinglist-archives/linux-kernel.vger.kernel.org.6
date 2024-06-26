Return-Path: <linux-kernel+bounces-230991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE59184A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2881F28261
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BDD187578;
	Wed, 26 Jun 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1lrybRH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBACB188CA6;
	Wed, 26 Jun 2024 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412887; cv=none; b=QwbPKdYXFYSonE9/iKpsqu2KsMVakr/e2SB+7Jr3WpWA+t4vPAIwCVZSYCx8kuXNpan7FCULYemxTHHTZqKgmPILEQIdJSdjpOARKzkHdBwqsIatkAVYw9VlOuyd/F9hzb9b+O3O3EUcVgWiic4ya8lfryFbgtiTzvGzeFyB3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412887; c=relaxed/simple;
	bh=DdsxNLQKRGbMo+BK9eJ/11fHvZ4crlKuZneEQ72JFSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R65qjFoZfXYQnYY7yc0hMQpX4EM/bqUbs179099PKa01qbiOCSdZKeLDYqQ3c1C7TU3bWJPoaadGM3Hbr/zo+egyrecfqga6fDsR9TwVB7/Z2wwvIoQ3QjwTooEO6OhhNBl7QXy9SSgem4aVlV96WVxy0LdsreM1FFktsZEgCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1lrybRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE53C116B1;
	Wed, 26 Jun 2024 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719412887;
	bh=DdsxNLQKRGbMo+BK9eJ/11fHvZ4crlKuZneEQ72JFSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1lrybRHJEGWIbD9jqx+TlApdp5WVct9H9M1JazxDXaICF0VgrMbG4xCrjGT3ymPK
	 Qs9/Qq+fU07VCrtuOyzIv2iCFYGnTpWMHwAVbIvLAMg1BtXshJ1dkibGg1HJPR1YHq
	 Wc7edLjxbTcliD0G37tzEZH34XWT3xI//1Ip9Gk1S6HLMij1LdL9lqeD9mr+N0BYHq
	 e7ugvqtXtu85psytVJBUg+IcmbxjDHx+CcsQ7dSoTRBCRa5zSuQ+h1f7SQ+3+/gmSx
	 xOeLY3bUiuvjsZfTtTtZjbh5YCLrx8O2Xwn4GOCVjOTdthR9m8UAmxn1OerJI6N6+H
	 hXdR9hj1Vo/7w==
Date: Wed, 26 Jun 2024 15:41:19 +0100
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/8] RISC-V: Add Zicclsm to cpufeature and hwprobe
Message-ID: <20240626-yearling-amplify-42aafd44becd@spud>
References: <20240625005001.37901-1-jesse@rivosinc.com>
 <20240625005001.37901-2-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FZt9HnGxypnqYZGJ"
Content-Disposition: inline
In-Reply-To: <20240625005001.37901-2-jesse@rivosinc.com>


--FZt9HnGxypnqYZGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 08:49:54PM -0400, Jesse Taube wrote:
> > Zicclsm Misaligned loads and stores to main memory regions with both
> > the cacheability and coherence PMAs must be supported.
> > Note:
> > This introduces a new extension name for this feature.
> > This requires misaligned support for all regular load and store
> > instructions (including scalar and vector) but not AMOs or other
> > specialized forms of memory access. Even though mandated, misaligned
> > loads and stores might execute extremely slowly. Standard software
> > distributions should assume their existence only for correctness,
> > not for performance.
>=20
> Detecing zicclsm allows the kernel to report if the
> hardware supports misaligned accesses even if support wasn't probed.
>=20
> This is useful for usermode to know if vector misaligned accesses are
> supported.
>=20
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
> ---
> V1 -> V2:
>  - Add documentation for Zicclsm
>  - Move Zicclsm to correct location
> V2 -> V3:
>  - No changes
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 3 +++
>  arch/riscv/include/asm/hwcap.h        | 1 +
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/cpufeature.c        | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 1 +
>  5 files changed, 7 insertions(+)
>=20
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index df5045103e73..7085a694b801 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -207,6 +207,9 @@ The following keys are defined:
>    * :c:macro:`RISCV_HWPROBE_EXT_ZVE64D`: The Vector sub-extension Zve64d=
 is
>      supported, as defined by version 1.0 of the RISC-V Vector extension =
manual.
> =20
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICCLSM`: The Zicclsm extension is suppo=
rted as
> +       defined in the RISC-V RVA Profiles Specification.

I'd rather that you regurgitated the definition here, these keys/values
cannot change their meaning, but RISC-V specs are not stable.

Cheers,
Conor.

--FZt9HnGxypnqYZGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnwojwAKCRB4tDGHoIJi
0nv7AP9qWTSBhnLB0HwuyJuPlCmA1yIrABF3M4dcOfL8wyw9MAEAuiQxdKsCJyDS
mEFcXYCJYEI0JxIBBx/Ea88NEfrvAAM=
=etVt
-----END PGP SIGNATURE-----

--FZt9HnGxypnqYZGJ--

