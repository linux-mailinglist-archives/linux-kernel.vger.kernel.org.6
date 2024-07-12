Return-Path: <linux-kernel+bounces-250757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CF292FC59
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DCC1C22193
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB5B171655;
	Fri, 12 Jul 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQAL5MpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99B12B71;
	Fri, 12 Jul 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793757; cv=none; b=I7iAS/odP2GBNKvVfJcuPpQEkQr/LCm33gzQ1QI/dae8a1v9O1mGIa8Aw9LrDgrpDcxp9ug+4wY+LfQ38ErYjSvWMW+rGXhIv8aCqvg+1qL1anqfQUAzLjIkzKnLIY/oI99bKwGZfwD2mIo0iegd6puRTue13h7HOLYLGWokGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793757; c=relaxed/simple;
	bh=ch41kibjRBBxFx9iHDsW9CuCoAzUjhiU43ELAHGZ/mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM5qygytkvjsUP++MOg8RW9/qQPTXzZkNkUJrOPwt3y0i3vZ/Y983NhtP6To5i8dvzrChXtw3TVMTQ0z3ciZVzA+x+Xx7ltnASZqESpaF2vrmVz5qujwxdoqG4YiEAuAIfXlrwEj7CYLovJm/7jjRdC2O8VOlsvajicKAt/xNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQAL5MpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3241C32782;
	Fri, 12 Jul 2024 14:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720793757;
	bh=ch41kibjRBBxFx9iHDsW9CuCoAzUjhiU43ELAHGZ/mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQAL5MpMNxeToJCFz2+47nR4IjzfKHkoPikemcBAazqHYXnpQSTMornQcaEkUsZJI
	 14UnLevgUT/w1k4RXbOcsRMIJKnGlltMjYhhpLX0U7niNzpsdy9Bki77OlJV5ARgax
	 MTmOu3SCDNqju94lQ4ND7JJkaIEOT7yno56R7GJgS2pareSm8w/m3sWaRVPynI3+EM
	 MataYf9L49yGTf6D+sgqKL6JYKL28KXNndO457a5vK728mnqYauceBhDq1gSYIe9rF
	 6bx2K3wqY4XDSpNZu50SHAwhc8qlK+2otsI2upoiwBqjfsk6otwDMzVXn7FyCbzbxN
	 svhCFavOJvMjg==
Date: Fri, 12 Jul 2024 15:15:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/4] Add board support for Sipeed LicheeRV Nano
Message-ID: <20240712-bacon-untruth-5230df76fdad@spud>
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
 <MA0P287MB2822C4E2EEFB67F82458C390FEA62@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iogMxGxzPj5XhGQB"
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822C4E2EEFB67F82458C390FEA62@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>


--iogMxGxzPj5XhGQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 09:33:46AM +0800, Chen Wang wrote:
> >   .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
> >   .../devicetree/bindings/riscv/sophgo.yaml          |  5 ++
> >   arch/riscv/boot/dts/sophgo/Makefile                |  1 +
> >   .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 54 +++++++++++++=
+++++++++
> >   arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 32 +++++++++++++
> >   5 files changed, 93 insertions(+)
>=20
> How about letting me PR all the four patches in this patchset? Because th=
ey
> are all related to sophgo, it would be better to PR them together to avoid
> confusion.
> Especially about the change of sifive,plic-1.0.0.yaml, my original
> understanding was that it should be handled by you.

No, stuff like the plic should really be handled by Thomas as he is the
interrupt controller maintainer, not by me. Usually though, neither the
timer or interrupt controller maintainers seem to care about these sorts
of binding patches which is why they ended up going with the dts.
Ideally the plic patch would go through the tip tree, but I think
there's unlikely to be sleep lost over a trivial binding change going
with the dts user.

--iogMxGxzPj5XhGQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpE6lwAKCRB4tDGHoIJi
0sJKAP9dpbfYKJDSQ60Qo1ABlLHqnJectYBdLgu/6h0FFvPyAwEA5NHbfYT1fqvM
Mx6qCDcDOXh78ASp8DNIOkfIFfrWfwk=
=nLo1
-----END PGP SIGNATURE-----

--iogMxGxzPj5XhGQB--

