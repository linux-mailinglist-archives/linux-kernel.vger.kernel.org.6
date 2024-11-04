Return-Path: <linux-kernel+bounces-394808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7579BB430
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C122810D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096F1B5336;
	Mon,  4 Nov 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npXjDaGG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1065418DF85;
	Mon,  4 Nov 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722076; cv=none; b=fT6HXfnB1Y4u7Mt5HL1056wA744M24TOH0lHwmfmNE3uyKoTVYVtcDWLoKLVtsrJmPOJxTvzJWhzjH7sCsboJlDCfICo1Zqi7UiVCrwVkH0/WtroYxv5EYWdor8tlyfwEG5uB373esFc8DDGF//T1/8w+vFx00Xxj5l1/ld5ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722076; c=relaxed/simple;
	bh=vsi/33NO427ZAndINphaIY00QOvDA9ey0no25IMNd9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mc5++0RyXAxDRHiBJNhPl43yVFYk37RbUn4Mej/Pq5sm12rtvFDnsoJQqL1fSioxBNd72HSau6l1cOChAGGA/BiLYx8BK9+9DAeKGMOmjYD+pK58QIQJyfD1R0/Sve2UI2Be8QH/E7wG0gtspWgwJHVq9CGDLjxjuxCUwkhuXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npXjDaGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F5DC4CED1;
	Mon,  4 Nov 2024 12:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730722075;
	bh=vsi/33NO427ZAndINphaIY00QOvDA9ey0no25IMNd9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npXjDaGGZ80pU4vZ5j/r8KHDcCtmUDdEQC/2TlGdDWGbkKhfeTBrNjRXVd7bo7N3M
	 Zf0PhHihION3wOtFDRHym/jLTMhd5BgFjLC4dZKe6ZCBsX0EeKJptLeGOyPMvZ+RCR
	 TP3nYhIziZ8vdu67APyeHjs8ItLBeVBhP94zT/nGgHUxxed+aSSJPGroRnOH5EIZY9
	 QdocH/QeuOfA7dVrUer1mBV7sQj4EE5HN2j+T3C00hfXWDr1d4xGqUc/9PjK/JWDQo
	 HMekwVt4NgTs/4OzDZYcc+ITCiSr5ojkNf6AH8bhqb14UkMNzb/M5FIIAoKwRX0RhE
	 T6rnPFfharIUQ==
Date: Mon, 4 Nov 2024 12:07:49 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andybnac@gmail.com>, Xiao Wang <xiao.w.wang@intel.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 2/3] riscv: add ISA extension parsing for bfloat16 ISA
 extension
Message-ID: <20241104-number-recall-85e044c9b72d@spud>
References: <20241103074959.1135240-1-inochiama@gmail.com>
 <20241103074959.1135240-3-inochiama@gmail.com>
 <2e775421-0c3e-48ef-8a8c-6734f7fcf298@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vFZn2GDfm8gUnKj9"
Content-Disposition: inline
In-Reply-To: <2e775421-0c3e-48ef-8a8c-6734f7fcf298@rivosinc.com>


--vFZn2GDfm8gUnKj9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 10:15:56AM +0100, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 03/11/2024 08:49, Inochi Amaoto wrote:
> > Add parsing for Zfbmin, Zvfbfmin, Zvfbfwma ISA extension which
> > were ratified in 4dc23d62 ("Added Chapter title to BF16") of
> > the riscv-isa-manual.
> >=20
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 3 +++
> >  arch/riscv/kernel/cpufeature.c | 3 +++
> >  2 files changed, 6 insertions(+)
> >=20
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index 46d9de54179e..97657fb63af6 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -93,6 +93,9 @@
> >  #define RISCV_ISA_EXT_ZCMOP		84
> >  #define RISCV_ISA_EXT_ZAWRS		85
> >  #define RISCV_ISA_EXT_SVVPTC		86
> > +#define RISCV_ISA_EXT_ZFBFMIN		87
> > +#define RISCV_ISA_EXT_ZVFBFMIN		88
> > +#define RISCV_ISA_EXT_ZVFBFWMA		89
> > =20
> >  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> > =20
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 3a8eeaa9310c..1b286f5bc591 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -325,6 +325,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >  	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
> >  	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
> >  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
> > +	__RISCV_ISA_EXT_DATA(zfbfmin, RISCV_ISA_EXT_ZFBFMIN),
> >  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
> >  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> >  	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
> > @@ -357,6 +358,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >  	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_e=
xts),
> >  	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_e=
xts),
> >  	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_e=
xts),
> > +	__RISCV_ISA_EXT_DATA(zvfbfmin, RISCV_ISA_EXT_ZVFBFMIN),
> > +	__RISCV_ISA_EXT_DATA(zvfbfwma, RISCV_ISA_EXT_ZVFBFWMA),
>=20
> @Conor,
>=20
> Should we wait for your V/F validation support to be merged before this
> one ?

Uh, I don't really see a reason to hold this up on my account. I can
easily rebase on top when I get the motivation to do more work on that
series.

--vFZn2GDfm8gUnKj9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyi5FQAKCRB4tDGHoIJi
0nLvAP9dZnNwlwpdYASHbLLL4ZVIYfSR0JyUNfivFOkfosM0aQEAhemaFYVfqvPL
YewSufLQLOeK2QCh4rruU59GZSdYwAQ=
=uyWh
-----END PGP SIGNATURE-----

--vFZn2GDfm8gUnKj9--

