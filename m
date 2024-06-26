Return-Path: <linux-kernel+bounces-230758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7342091818B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F679281CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00AD13CFBC;
	Wed, 26 Jun 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFS5hd3C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE591113;
	Wed, 26 Jun 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406869; cv=none; b=LgHC0Fas3/q4qeLyKUen8XsCskW/Qw5+wAjCcaK7irM1akvIUG4XoQ3+EDTHZltuhQv1R3kdMGF05pBGhu5anZ6pH4tT1uWO1kPFk47tzAA2Y+piz23DYVn4duZWnGvrqcFo2PhDfbqZPo49RYqLEyIXxhIaXzic2bWx2dkO0wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406869; c=relaxed/simple;
	bh=LHeTQI/EG08BqcLmj/c6DAyrQ+SL5WbhoXdoBVZAOQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYE8XejRx6E/NBFdqaW4TgaVN6VvqsSF7IBgN3n3EcZ7ufpBYX+DtEqOLfEU57vNMfp7unhBg10J08e04yiBM99+1FY2YWOgI5GxjkAHZfrt3aor0nevuv45ZAl+CH89A8SzX/GMb39KGXJQEREoKF83O22qwPNloAzuhG7l3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFS5hd3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D1FC2BD10;
	Wed, 26 Jun 2024 13:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719406868;
	bh=LHeTQI/EG08BqcLmj/c6DAyrQ+SL5WbhoXdoBVZAOQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFS5hd3CD8DZ7yeuONQZpeaDwCO4Upy5tjkEZ4FxeP2eIgY753Z5E/Cb+tnmUztN5
	 Ox43HBMMZmxi0NozVQuAkcaCsRzBEfql9mxqtiMy8VRnkWBcMvPDKgJOMbVlXfPACT
	 +6cQQz3LarWWjHU+9lpBExowXyizZ5MF3EWPjoZt6rVVB9/f4sWEF4MX0y4GlYc9FB
	 ruZjAC8Db6D5D+dq8OQEMNHJ/Reqp/Uf/VMFsAMe27dufQovIMS9ECREc/X/1Pmigv
	 ZKbT74kXIs5BlQUFe42BmG+1RUTllnkFc+A/5P693GAqiSD3Oqi16fPMbAqticO/IH
	 wZ+TnOyV4QJfg==
Date: Wed, 26 Jun 2024 14:01:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: jesse@rivosinc.com, jrtc27@jrtc27.com, corbet@lwn.net,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	cleger@rivosinc.com, evan@rivosinc.com, conor.dooley@microchip.com,
	costa.shul@redhat.com, andy.chiu@sifive.com,
	samitolvanen@google.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v3] RISC-V: Provide the frequency of time CSR via hwprobe
Message-ID: <20240626-prolonged-overlap-91fec0188fc7@spud>
References: <20240622025514.66537-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5K1t+tDRpgMuz99f"
Content-Disposition: inline
In-Reply-To: <20240622025514.66537-1-cuiyunhui@bytedance.com>


--5K1t+tDRpgMuz99f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 10:55:14AM +0800, Yunhui Cui wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> A handful of user-visible behavior is based on the frequency of the
> time CSR.
>=20
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---

What changed between this version and the previous one? You need to
include changelogs under the --- for this purpose.

Thanks,
Conor.

>  Documentation/arch/riscv/hwprobe.rst  | 2 ++
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
>  4 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index df5045103e73..ec3c99474ed7 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -233,3 +233,5 @@ The following keys are defined:
> =20
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `time=
 CSR`.
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hw=
probe.h
> index 150a9877b0af..ef01c182af2b 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
> =20
>  #include <uapi/asm/hwprobe.h>
> =20
> -#define RISCV_HWPROBE_MAX_KEY 7
> +#define RISCV_HWPROBE_MAX_KEY 8
> =20
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 2fb8a8185e7a..5053a9b18710 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -74,6 +74,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF	7
> +#define RISCV_HWPROBE_KEY_TIME_CSR_FREQ	8
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> =20
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index e4ec9166339f..3d47edc04a3f 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -8,6 +8,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwprobe.h>
> +#include <asm/delay.h>
>  #include <asm/sbi.h>
>  #include <asm/switch_to.h>
>  #include <asm/uaccess.h>
> @@ -227,6 +228,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>  			pair->value =3D riscv_cboz_block_size;
>  		break;
> =20
> +	case RISCV_HWPROBE_KEY_TIME_CSR_FREQ:
> +		pair->value =3D riscv_timebase;
> +		break;
> +
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
>  	 * call, but get their element key set to -1 and value set to 0
> --=20
> 2.20.1
>=20
>=20

--5K1t+tDRpgMuz99f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnwRDgAKCRB4tDGHoIJi
0nTbAQCNyBtB3Liky8HfdaZbV+GDO5qG2b5gf2wYff8cvHMUxAEAroBQnv/vxmEF
db83NiP6oferELS+7/FG8X8juV26oQ0=
=LRlJ
-----END PGP SIGNATURE-----

--5K1t+tDRpgMuz99f--

