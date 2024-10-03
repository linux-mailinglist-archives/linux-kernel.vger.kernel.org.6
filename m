Return-Path: <linux-kernel+bounces-348914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0387B98ED93
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1BA1F228F5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C701537D4;
	Thu,  3 Oct 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn8FIOvZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9C14431B;
	Thu,  3 Oct 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953534; cv=none; b=br/izNFbnaICPs4kN9gg0XpT316iYpPPaIPeZ0YrfXTMEDbJkZwiPQhX6Lf1VmGM4diKHul+QqHipVJ6BeR3SsvRLlZxQN3jk0PCiXBSXN9/pYMgVZ1VceqIMBJ/4ODsTLO6ALXsG8FPjmkDg+0AxEJk/xh7XtNSzi8Slz47KXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953534; c=relaxed/simple;
	bh=IRPu9PkUbz+dFzJ4rkLXyM9DGV9j0tNNK6BigQdP7XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiSvCdZH3YRh+UQHiTonbR6/gAZvm2lErCnSP1Xk75YOpxNQEVbiSqQ0Ua7zoovtPYOqJZDoXtRDBi2p7t8/8dr9xmYqlsURUDXeRMjzvR2Wx49SU1Ir2jZekylUUEP0+aZ/Jq46mS6EQs8LFMxlmvBObdiw6wuOzQJXx76irlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn8FIOvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85564C4CEC5;
	Thu,  3 Oct 2024 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727953534;
	bh=IRPu9PkUbz+dFzJ4rkLXyM9DGV9j0tNNK6BigQdP7XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qn8FIOvZ/VuTBe462XN7OHux1pUzHPFrIp1skj0zosXIeARv8hAj3E/ySCKtzxjxp
	 09JkmE7ONJxgKMWEVhorjFc37C6cU+y9gN2o5LY5zBBw8Mc/LBdWwR46kfL2JMmIVi
	 KE63zbkEwAsQmESM1I2BSaIKprnLlUlkpbHh2WxZi8YLdzT4MYSORfqhdShEOwY7bC
	 o4mYZ4MUuymqwFJWEYs4ymOMSSFksDWk+tR5pX68/fMznfefLZlgdEMB2wDrSd6U4h
	 tAMJT2KgB+dsipVTq7tiJ4EMXgYkodmosq/KheaGTa/BRq0O+rjNehlJfUWcZytdjj
	 PKRjfVrmumBkw==
Date: Thu, 3 Oct 2024 12:05:30 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Andy Chiu <andybnac@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 5/5] dt-bindings: riscv: document vector crypto
 requirements
Message-ID: <20241003-variable-quirk-9a13fe040e4a@spud>
References: <20241002-defeat-pavestone-73d712895f0b@spud>
 <20241002-sincerity-urgent-acdb0e8d8a66@spud>
 <0fa7461f-5c7c-4f18-ac02-66d37e2c559c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HroZ+uV00yIqexpw"
Content-Disposition: inline
In-Reply-To: <0fa7461f-5c7c-4f18-ac02-66d37e2c559c@rivosinc.com>


--HroZ+uV00yIqexpw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 09:59:38AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 02/10/2024 18:10, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Section 35.2. Extensions Overview of [1] says:
> > | The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the co=
mposite extensions Zvkn and
> > | Zvks-- (sic) require a Zve64x base, or application ("V") base Vector =
Extension.
> > | All of the other Vector Crypto Extensions can be built on any embedde=
d (Zve*) or application ("V") base
> > | Vector Extension
> >=20
> > Apply these rules in the binding, so that invalid combinations can be
> > avoided.
> >=20
> > Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-=
release-698e64a-2024-09-09 [1]
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../devicetree/bindings/riscv/extensions.yaml | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > index abf2579171c5b..02b822bbf341d 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -651,6 +651,38 @@ properties:
> >              - contains:
> >                  const: zve64f
> > =20
> > +      - if:
> > +          contains:
> > +            anyOf:
> > +              - const: zvbc
> > +              - const: zvkn
> > +              - const: zvknhb
> > +              - const: zvks
>=20
> Shouldn't zvksed and zvksh be part odf this list ? My understanding of
> the spec might be wrong but "Zvks--" seems like a poor-man's wildcard
> for Zvks* extensions ?

I don't think so, there's a corresponding -- on the first line of the
quote. I think it is some really odd styling that should be replaced by
commas.


--HroZ+uV00yIqexpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZv56egAKCRB4tDGHoIJi
0q+XAP4ja16VtZOTGXq9vok9Co1HNrwbljm0CPOR0Z0+0jPpEgD/TH4OjHN89AB3
JmxtsmtuTZlulCNrokTF5ObEBZ8MSAw=
=nnno
-----END PGP SIGNATURE-----

--HroZ+uV00yIqexpw--

