Return-Path: <linux-kernel+bounces-348904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6173C98ED73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A09F283AD1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6C91531C0;
	Thu,  3 Oct 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1nOdzJ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6E15099D;
	Thu,  3 Oct 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953032; cv=none; b=pE52ReXJWulqvXODFpFAUANeYCsk/qfY9OdmMqPFrkeYT84ePRnk+9OBvWluRBKc4MQAPIl0OFRbA9nSq5rt3/QZq0uDXB6RGI6641frk00F7MZ/0Gk0B+87RcthdjaLpljimaSNS6L6QxO1HGHtggQ88zd2EBRCNUTN0CKxIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953032; c=relaxed/simple;
	bh=lW5/aA3G67iZr2w6iM+wouTZ9PieLhmJS7salj68Teo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3oiVbRZLpTOKpzBNpOGSusxJ1lng+ukfZDDVN1TRAdmJZI7rmgsaFzQCpqZWWmbV1IsDHmxCoovTcZV/aIghWs5XVw7OtwgTakjFDpd9ZRbWtItM1LSSXuwngc9Q2yJblpNiIxPlr0k14VUu/VLkNDe26+JhpI3u/MqYOiITW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1nOdzJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6414BC4CEC5;
	Thu,  3 Oct 2024 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727953032;
	bh=lW5/aA3G67iZr2w6iM+wouTZ9PieLhmJS7salj68Teo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1nOdzJ67ejd17CGrPzr70Q3qDMFfZmk2fH1J86zpfGDFdM2LZ1rm0zYMz2tESZOz
	 i3aLk3z2ICzgP9siSD76TpY4Z0QnKiPIgbQu4HfEHPmWyk4+pa+HVA8E7B58E+Ywu2
	 nmssgtX37oKcQGPBrrGnl3RM7LJ1RLLARkOOJec1+6HjCFrL0bMVDdXwtPaPKCddpX
	 MchD7fKFtxIg3QLnA43C/g9yKjXZTrLE8XLoQJDL5b75sy0jgxcsMIVuGi/9CRG2SY
	 Ieww/7NLZli6/f60Jd/v/ugOwpEsdpu51LMEmN1C39/+UAnvoEGdG+oQC/19DJOHpA
	 p3kg6qkHLqvpw==
Date: Thu, 3 Oct 2024 11:57:08 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Andy Chiu <andybnac@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 2/5] RISC-V: add f & d extension validation checks
Message-ID: <20241003-flagship-agreeably-5df992b50618@spud>
References: <20241002-defeat-pavestone-73d712895f0b@spud>
 <20241002-stuffed-trance-1323386dd80b@spud>
 <6b735be2-93d2-4cc2-b690-438f6e71cf0b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uBRiSkFYYfARJUOC"
Content-Disposition: inline
In-Reply-To: <6b735be2-93d2-4cc2-b690-438f6e71cf0b@rivosinc.com>


--uBRiSkFYYfARJUOC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 09:49:51AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 02/10/2024 18:10, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Using Clement's new validation callbacks, support checking that
> > dependencies have been satisfied for the floating point extensions.
> >=20
> > The check for "d" might be slightly confusingly shorter than that of "f=
",
> > despite "d" depending on "f". This is because the requirement that a
> > hart supporting double precision must also support single precision,
> > should be validated by dt-bindings etc, not the kernel but lack of
> > support for single precision only is a limitation of the kernel.
> >=20
> > Since vector will now be disabled proactively, there's no need to clear
> > the bit in elf_hwcap in riscv_fill_hwcap() any longer.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/kernel/cpufeature.c | 36 +++++++++++++++++++++++-----------
> >  1 file changed, 25 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 84a2ad2581cb0..b8a22ee76c2ef 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -101,6 +101,29 @@ static int riscv_ext_zicboz_validate(const struct =
riscv_isa_ext_data *data,
> >  	return 0;
> >  }
> > =20
> > +static int riscv_ext_f_validate(const struct riscv_isa_ext_data *data,
> > +				const unsigned long *isa_bitmap)
> > +{
> > +	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d)) {
> > +		pr_warn_once("This kernel does not support systems with F but not D\=
n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (IS_ENABLED(CONFIG_FPU))
> > +		return -EINVAL;
>=20
> Shouldn't this be !IS_ENABLED(CONFIG_FPU)) ? I mean, if the f extension
> is enabled but not CONFIG_FPU, then disable it.

Of course. I wonder how my userspace didn't blow up.

--uBRiSkFYYfARJUOC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZv54hAAKCRB4tDGHoIJi
0urMAP9vnpPnNEIzZU6g+gTkhAI3tiTM4cxcg8onIB2X4bm7PAEAwH+RtvErh42o
oyWpKScFE/nYaxMZCoJlcxn+ZVfsVwI=
=HwoX
-----END PGP SIGNATURE-----

--uBRiSkFYYfARJUOC--

