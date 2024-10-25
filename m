Return-Path: <linux-kernel+bounces-381489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A080D9AFFD7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D6D285BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0DB1D968F;
	Fri, 25 Oct 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDZ/l9lQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68263192587
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851409; cv=none; b=HI8IxUBS+uf0LyPbCf+wSpOyc1ZE2IUE/Y8Xmqzdw7LQgwEtC9wn8sxdpC4QxDbZJ6OnZiLt6wAWypKTPDkdHwEMhgnZ1Jw9bfpi+PRV0KNa4cz0G7TfKh172OxNVh9K69v3n7L/SSQfBEbI6QZghZw4YivL0G3hrJrQAQxT/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851409; c=relaxed/simple;
	bh=xStiJAdN8rfXWCBPUd6wymS0l7sauhqKPVL1Cgv/UwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm0gJRtq+BUUCUim7JNPXSuGcHXGD4e3jQoXyXGzgupo05MWL+AbIxcg6Fx60rA2dHyp7ah2vDbDIhoQCdoIz7uAsx41jhXTIDXLLIzgLAAI7zqRPIYXmrLDR4iY/K3MQkPiLEMPkmgLyLuHXKlYckobzbd5dcluaGMeiqWSeIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDZ/l9lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97AEC4CEC3;
	Fri, 25 Oct 2024 10:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729851409;
	bh=xStiJAdN8rfXWCBPUd6wymS0l7sauhqKPVL1Cgv/UwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDZ/l9lQCIPkIukCi5/+TAmXDxGXZbo4bwe6RMTmoWnxuuXvCN6oyFuK8FlC1m4Fi
	 Y8yLu8VP8CMtbulfsc5I7xfEj3bQk+ONke99O/78bVDsn4msAA53SPKQ63aPXkwqGh
	 rpqEnZ6LRO0AcHz0aNHyQhagy1NnsdPhr72RPErUYVnAj0fUf048ouaYp3esq8Nceb
	 OEBJYCYfgqWw2w2mngPJECrjr97U1hWMWGI+lgVepEdyllTFU7CKsxEfgafHX2ybPq
	 ClC7skBKRjBkci102pKHVZKRqQuEBGlU13CcxDCifqighQ5hKV3yFPh3sQSVHE00kv
	 iaCgmCGTm6jnA==
Date: Fri, 25 Oct 2024 11:16:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, cleger@rivosinc.com,
	charlie@rivosinc.com, evan@rivosinc.com, samuel.holland@sifive.com,
	andybnac@gmail.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Enable Zicbom in usermode
Message-ID: <20241025-puritan-sank-b8a828ef5872@spud>
References: <20241025091527.57825-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SBeakcOA7OyGXVKZ"
Content-Disposition: inline
In-Reply-To: <20241025091527.57825-1-cuiyunhui@bytedance.com>


--SBeakcOA7OyGXVKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 05:15:27PM +0800, Yunhui Cui wrote:
> Like Zicboz, by enabling the corresponding bits of senvcfg,
> the instructions cbo.clean, cbo.flush, and cbo.inval can be
> executed normally in user mode.
>=20
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 1992ea64786e..bc850518ab41 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -924,7 +924,7 @@ unsigned long riscv_get_elf_hwcap(void)
>  void __init riscv_user_isa_enable(void)
>  {
>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
> -		current->thread.envcfg |=3D ENVCFG_CBZE;
> +		current->thread.envcfg |=3D ENVCFG_CBIE | ENVCFG_CBCFE | ENVCFG_CBZE;

I believe we previously decided that userspace should not be allowed to
use zicbom, but that not withstanding - this is wrong. It should be
checking for Zicbom, not Zicboz.

--SBeakcOA7OyGXVKZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxtv5QAKCRB4tDGHoIJi
0oIvAP9+IsFienMh6mqsPaedEUf2DVR2QelZNeZ9CXxoT3YO3gD5AXLACu6fHwjt
HNlKMCdrYfzWWT0BWbVU7LBFHKE1LAU=
=54iy
-----END PGP SIGNATURE-----

--SBeakcOA7OyGXVKZ--

