Return-Path: <linux-kernel+bounces-374178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631D9A6668
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24D8281ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF11E47AD;
	Mon, 21 Oct 2024 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfom7GnG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E11E47BC;
	Mon, 21 Oct 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509409; cv=none; b=ukQvf+JA1lfGkKD2vBWDfmpofOfsGzixc6RfK9zohf04t/8ND1oK6G/SmFdSS4nBKxLqUaxvJ+e41polr5AQrWViQ13JQfrOic/lNLSdq9YEtDwM/6KxX/I1AwFTBVkML1YbDeiAjNG2oKUHqqDTC9ah2qwH8GBdcbEt36xl2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509409; c=relaxed/simple;
	bh=2f93h3fB4LLkd11DyIv9Y0/XNE6yLB6WyRy24xVgmlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugwpER9j0W+sbFR6s8Sxt2gqf6mv1hdaugvWKXu2qcX0TmjWlCd5lwBFyirHLWC8ODyE1il8AfJ1g3JlHzc/US2TW+OVO7Tam5iYgPz8CpuYJG+Dl/Rp7SDUT5N6rWuFx9zpe7QaMKTwgAOMwlCeZIlvjcLY+VAXn3U57iAYn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfom7GnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8717C4CEC3;
	Mon, 21 Oct 2024 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729509409;
	bh=2f93h3fB4LLkd11DyIv9Y0/XNE6yLB6WyRy24xVgmlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfom7GnGD1cB5+8lbtj2U35qRULIN35Q5wNvCT+cPuje4/lsjyjdKydoruv6X3gCH
	 ZcVTe9YBem9ZKJCeyW6hUp7vMJW32WabUtneH8/ngK3Jv4uYXdeJQbyQghsgoQ80LL
	 mVcpPd46XYpRna5Cf4m0cDaOwUcJgQSNzeB7Sb94uhQneT1ROzlG8kQz4vRyfqlSJY
	 ZtHndxS2qpOYQeg4JVXYgzcIHSmvw6f+7AbkVxK45e1rIwFbHulH9v27bPyde8BXly
	 6uF/mf+dOfSW+mkXepO77BHYxPaQdmcsYmfT6mqUeua4LJLmKeGaayRay9Ee5YkkSd
	 jN+AErlxgfjDw==
Date: Mon, 21 Oct 2024 12:16:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>, linux@frame.work,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] riscv: dts: starfive: add DeepComputing FML13V01
 board device tree
Message-ID: <20241021-unroll-empower-3ab903615d6d@spud>
References: <20241020134959.519462-1-guodong@riscstar.com>
 <20241020134959.519462-4-guodong@riscstar.com>
 <ae5gels34ozgzrcrwz53wj22hoy5cq3crn3dmkhitxlffmnavt@6lbmrcpjmqyd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VVnw05SnzZXMvGzA"
Content-Disposition: inline
In-Reply-To: <ae5gels34ozgzrcrwz53wj22hoy5cq3crn3dmkhitxlffmnavt@6lbmrcpjmqyd>


--VVnw05SnzZXMvGzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 09:17:59AM +0200, Krzysztof Kozlowski wrote:
> On Sun, Oct 20, 2024 at 09:49:59PM +0800, Guodong Xu wrote:
> > From: Sandie Cao <sandie.cao@deepcomputing.io>
> > +&camss {
> > +	status =3D "disabled";
> > +};
> > +
> > +&csi2rx {
> > +	status =3D "disabled";
> > +};

You can drop these two, I marked them disabled in the common file
earlier this week.
1
> > +
> > +&gmac0 {
> > +	status =3D "disabled";
> > +};
> > +
> > +&i2c0 {
> > +	status =3D "disabled";
> > +};
> > +
> > +&pwm {
> > +	status =3D "disabled";
> > +};
> > +
> > +&pwmdac {
> > +	status =3D "disabled";
> > +};
> > +
> > +&spi0 {
> > +	status =3D "disabled";
>=20
> If your board has to disable all these, then they should not have been
> enabled in DTSI in the first place. Only blocks present and working in
> the SoC (without amny external needs) should be enabled.
>=20
> I suggest to fix that aspect first.

Eh, I don't think I agree. Having 5 disables here is a lesser evil than
reproducing 90% of jh7110-common.dtsi or shunting a bunch of stuff
around. Emil?

--VVnw05SnzZXMvGzA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxY4GgAKCRB4tDGHoIJi
0ryMAQDylSPIecFs5rj5VL8jUi+nAFss0Y7ZYLW2+cgjnnNluQD/VG1+cJIt0h8u
syL+09/AjgZAeUOS6/+AmUIafMx6oQg=
=JCPq
-----END PGP SIGNATURE-----

--VVnw05SnzZXMvGzA--

