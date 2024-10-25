Return-Path: <linux-kernel+bounces-382167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0699B0A54
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2211C21ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C331F8199;
	Fri, 25 Oct 2024 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyOcdprT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4A6F099;
	Fri, 25 Oct 2024 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875154; cv=none; b=cX32zQ8kCoEdqLn8RG/c6BaKskx8cHco6eer5jseNW3LlwWaKlAQuezmxbxubz/vPmTJOAaAcicHWgpyJ6aGxVzj9n7G5O/W46U5wukjpqMirCTQppXffIQjFXhxSC5hUK1N4ltiKzYJY+bY/4Wkc2WNog1WMghWis0Mvk77g2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875154; c=relaxed/simple;
	bh=a7pcHGKkFVmFhrleGAGaukGyxvAok9EA+JP8hsdU0I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lya36IDp8wJYr+I5wjexKd4SCAs416yWPqp3h6GsyIdlorlv/qh01zfj2BFnaJ8raVTeZL4cXcaGNB8tjTha2jhgxzlgQNIH9SJY7rv9jzY26eJ0qvensa2GHJfMSUWl2/XG8j8YYxl+8MYbI0EzgZTdxIbfIvlyKvqOCexXcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyOcdprT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6B8C4CEE4;
	Fri, 25 Oct 2024 16:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729875154;
	bh=a7pcHGKkFVmFhrleGAGaukGyxvAok9EA+JP8hsdU0I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyOcdprTl94d2sMV8FyIj1UDHCbpmi4nAdBaCYvKLGpF+DCUSg0U3X4A3OWJw2TWu
	 hvTSpfoMTo4h7PtwWRMNuTGHKZgOaLKGE5sWPm19CqasTHnbO6u1xVQx9VJpVVKzwR
	 ridJfn67K3NNZu/Nneht0zYAaRiSkA51hk/tHzor3oitwllwXWLM+EixjVjrF5iJUd
	 AEgNLhEi4Ng14xoSPolgBulpJf7hLJMNx3t57Fi/xXS9dqP5vw9tQBQOCoa0KBc8mo
	 gtthw70aFBoJqwGi0ZFVTqvGJvfAJIAHaQaeydfKgGiOdIFk5ga+EGCEzi3rxRTKQU
	 7JjtOkUOQS9dA==
Date: Fri, 25 Oct 2024 17:52:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] RISC-V: add vector crypto extension validation
 checks
Message-ID: <20241025-angler-lyricism-83eacdadb776@spud>
References: <20241024-fanning-enrage-bcc39f8ed47d@spud>
 <20241024-bunny-unexposed-196d8da36e7a@spud>
 <20241025020810.GA1781@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="whY1gTwyYGrb9ong"
Content-Disposition: inline
In-Reply-To: <20241025020810.GA1781@sol.localdomain>


--whY1gTwyYGrb9ong
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 07:08:10PM -0700, Eric Biggers wrote:
>=20
> On Thu, Oct 24, 2024 at 01:34:29PM +0100, Conor Dooley wrote:
> > @@ -308,12 +354,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =
=3D {
> >  	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
> >  	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
> >  	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
> > -	__RISCV_ISA_EXT_SUPERSET(v, RISCV_ISA_EXT_v, riscv_v_exts),
> > +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_v, riscv_v_exts, r=
iscv_ext_vector_float_validate),
>=20
> This patch adds validation for not just the vector crypto extensions but =
also v,
> zve32f, zve32x, zve64d, zve64f, and zve64x.  I think that should be split=
 into a
> separate patch or at least called out explicitly in the commit message.

Sure. I think I even had it like that originally and must have
waywardly squashed it. I actually checked before sending this to make
sure that I hadn't do so by accident between v1 and v2 and I had not.

> > +	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zk, riscv_zk_bundled_exts, riscv_ext_=
vector_crypto_validate),
> > +	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zkn, riscv_zkn_bundled_exts, riscv_ex=
t_vector_crypto_validate),
> >  	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> >  	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> >  	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> >  	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> > -	__RISCV_ISA_EXT_BUNDLE(zks, riscv_zks_bundled_exts),
> > +	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zks, riscv_zks_bundled_exts, riscv_ex=
t_vector_crypto_validate),
>=20
> zk* are the scalar crypto extensions, which don't require vector.

> Thanks for working on this!

Thanks for taking a look. I'm surprised I didn't make more mistakes tbh.

--whY1gTwyYGrb9ong
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxvMzQAKCRB4tDGHoIJi
0v8NAP40+2Sulb7rcAUIarG4dUUbSTIhaG9lZ2cRwwUTnBj4vwEAwbw8Is8Uhfv1
2WRlRpAI2/KCgmr020FXcOspR6SEHwI=
=xZat
-----END PGP SIGNATURE-----

--whY1gTwyYGrb9ong--

