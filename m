Return-Path: <linux-kernel+bounces-556698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D2A5CDA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543FE3BB6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431792638B6;
	Tue, 11 Mar 2025 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a78aZzCJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32226389C;
	Tue, 11 Mar 2025 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716900; cv=none; b=eVfJyrX9aSywyPJaxgEVVflMgudchyApFms8b+9ltpAIHENlqb0F5k8ru+ToX0br/HJQFYLTM4tedfvuZFZvN9dB20m4lcn8ZdTew6vwtSlx8Xj6qCLaspwNm0FAHZRvjHArflpTP5pQziBGTGn8NIwPyieR570lnZGk5m/hUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716900; c=relaxed/simple;
	bh=qKC9xsxTullwYiRAcFeKtLDDwqjv7fFwHbm/txds7og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZas/wuvZWqlRShmQEcYWSbEU2xY5wU1Yt0LzUoiRIt2xysEDG9nGVGjYvo1MmClFf78z1UZzxSJ2Mt7oNgY4XlpKJWliNcXej5i1jjAw2V2TfTv3ZEEmkS0+5ygLkEI5UJ2AqoTGfmUbTKNu7uQ3USvlZOD+szrqJv9TIAXdps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a78aZzCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BEDC4CEF1;
	Tue, 11 Mar 2025 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741716900;
	bh=qKC9xsxTullwYiRAcFeKtLDDwqjv7fFwHbm/txds7og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a78aZzCJtVPS47kMKaz+ebwHuaS9mFA8vMhn8ALHLlquew2QCtmomYFfe1PbUuhE5
	 wEzIlk1N2DEQwJOUeioLPweuxGPAAq8e9xLZKuAZL5SMlApnTp0fVWWii45x7SLWOj
	 ggeEtO+c1qQSioX2uixE21ruN8hyRsdsBLXwktbSD6pS+yFs4OaC7RE4HuZ5ZE48Aa
	 8QlVEQnDF91m9GHrclBPPFwY6dIBBR4jddZ7yWcXaDgflUmnxSUxZphjkqIJTdAN6q
	 40XTQZ/VD2Tuu+wyN/NMxoxD1cyqtR47LpzxzCJ4KS6/vL9ZBJn7cHUQHZI8UohfR1
	 5gHZNrWZXcBAQ==
Date: Tue, 11 Mar 2025 18:14:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl, Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] riscv: Add Kconfig option for ESWIN platforms
Message-ID: <20250311-cache-trance-c47cf760b587@spud>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-3-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gTWFNBVZUIgcSRSc"
Content-Disposition: inline
In-Reply-To: <20250311073432.4068512-3-pinkesh.vaghela@einfochips.com>


--gTWFNBVZUIgcSRSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 01:04:24PM +0530, Pinkesh Vaghela wrote:
> Create a config option to build ESWIN SoC specific resources
>=20
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  arch/riscv/Kconfig.socs | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 1916cf7ba450..35594e365ca6 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -1,5 +1,11 @@
>  menu "SoC selection"
> =20
> +config ARCH_ESWIN
> +	bool "ESWIN SoCs"
> +	help
> +	  This enables support for ESWIN SoC platform hardware,
> +	  including the ESWIN EIC7700 SoC.
> +
>  config ARCH_MICROCHIP_POLARFIRE
>  	def_bool ARCH_MICROCHIP
> =20
> --=20
> 2.25.1
>=20

--gTWFNBVZUIgcSRSc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9B9nQAKCRB4tDGHoIJi
0piOAQDBEp6shZBbErVBsFvqooF6qHFZVJBgt99fCviN3m0tJwD/TPRPqGdZYreb
d8Thviu+G4uckrxwOoQuXDLeFCE0Bg8=
=Xehl
-----END PGP SIGNATURE-----

--gTWFNBVZUIgcSRSc--

