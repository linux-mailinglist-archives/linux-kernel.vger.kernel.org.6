Return-Path: <linux-kernel+bounces-374791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17B9A700E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E23B20D65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F211EABA9;
	Mon, 21 Oct 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg9AormP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CAF1E906E;
	Mon, 21 Oct 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529309; cv=none; b=UGetsx5sq+PW2TxPr9K/hHF6NrsBCAITmbCWLsg06yDaTrziWK5VDpqH1h64PHkETqJl9CpBbI+xFqvEsy7940s3YQJzUQwliP52Dgcc5sy26FJk+7T+x8vtRyDBKfxzEYcEG6Vknea/dGLlG9h1+6bQxaeEm91qNzDNfdcxBr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529309; c=relaxed/simple;
	bh=y88CpT+n2HdoRrfctihIvqBAw/nq7qai6p50KHNi9PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGhCX1QpprnRrk6l+hSL165sU6ymX2Byj0RuyxSEsJ3Ft5DIhpgJ8QSAcAGV2PjGmhguypi70oYwvR6moEyvd0amXM4WHM2+kh4eww/xBV9BVECQnQx/9VvBtL3inaPEV++4p0d3dmj2U4duOfA2Xh6OaTs9zNMYGTu9VbiGKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg9AormP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FBBC4CEC3;
	Mon, 21 Oct 2024 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729529309;
	bh=y88CpT+n2HdoRrfctihIvqBAw/nq7qai6p50KHNi9PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tg9AormP7oj96Nxs3Hyh2cbZX/WEiqqxEmm+RWJB8AzCWl7pwu7FKZAJ9YUiBY6Eb
	 O5qRi6WYvMfb15NkUuyCjBItfUyi6LHK7tdujb5j6GnK6UpmsHZKq9fGfHl9JmMEXj
	 7yxEwxfNiBvb77sZYvY9oIwdzMtfoELesLuwvXbdQccqJgu/nAHpW230oDq+To01+m
	 5TMGNCrlyeXRT7nKObiVEhbU/mnXai4GaQLyC5pOQvtduRLrQgJY5K1PHGFAIwjicX
	 YIQzR/+OqxkMjXvL7C8hfrN2m+jmJlPHkzddAOMtLEkAhokoODjGCEhF2/YNrc1RBz
	 Ij944FdRnuh4g==
Date: Mon, 21 Oct 2024 17:48:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
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
	Huiming Qiu <huiming.qiu@deepcomputing.io>, linux@frame.work,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] riscv: dts: starfive: add DeepComputing FML13V01
 board device tree
Message-ID: <20241021-crimson-translate-291eaba4e640@spud>
References: <20241020134959.519462-1-guodong@riscstar.com>
 <20241020134959.519462-4-guodong@riscstar.com>
 <ae5gels34ozgzrcrwz53wj22hoy5cq3crn3dmkhitxlffmnavt@6lbmrcpjmqyd>
 <20241021-unroll-empower-3ab903615d6d@spud>
 <c048d270-7a07-4807-b816-0f4e0aeb67f7@kernel.org>
 <2b449955-6596-4c9a-9799-f15d186e260f@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HM8xtjn6x2CDD6Fw"
Content-Disposition: inline
In-Reply-To: <2b449955-6596-4c9a-9799-f15d186e260f@riscstar.com>


--HM8xtjn6x2CDD6Fw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 08:44:16AM -0500, Alex Elder wrote:
> On 10/21/24 7:47 AM, Krzysztof Kozlowski wrote:
> > On 21/10/2024 13:16, Conor Dooley wrote:
> > > On Mon, Oct 21, 2024 at 09:17:59AM +0200, Krzysztof Kozlowski wrote:
> > > > On Sun, Oct 20, 2024 at 09:49:59PM +0800, Guodong Xu wrote:
> > > > > From: Sandie Cao <sandie.cao@deepcomputing.io>
> > > > > +&camss {
> > > > > +	status =3D "disabled";
> > > > > +};
> > > > > +
> > > > > +&csi2rx {
> > > > > +	status =3D "disabled";
> > > > > +};
> > >=20
> > > You can drop these two, I marked them disabled in the common file
> > > earlier this week.
> > > 1
> > > > > +
> > > > > +&gmac0 {
> > > > > +	status =3D "disabled";
> > > > > +};
> > > > > +
> > > > > +&i2c0 {
> > > > > +	status =3D "disabled";
> > > > > +};
> > > > > +
> > > > > +&pwm {
> > > > > +	status =3D "disabled";
> > > > > +};
> > > > > +
> > > > > +&pwmdac {
> > > > > +	status =3D "disabled";
> > > > > +};
> > > > > +
> > > > > +&spi0 {
> > > > > +	status =3D "disabled";
> > > >=20
> > > > If your board has to disable all these, then they should not have b=
een
> > > > enabled in DTSI in the first place. Only blocks present and working=
 in
> > > > the SoC (without amny external needs) should be enabled.
> > > >=20
> > > > I suggest to fix that aspect first.
> > >=20
> > > Eh, I don't think I agree. Having 5 disables here is a lesser evil th=
an
> > > reproducing 90% of jh7110-common.dtsi or shunting a bunch of stuff
> > > around. Emil?
> >=20
> > Why reproducing 90%? Only enable would be here, no? Or you want to say
> > the common DTSI has things which do not exist?
>=20
> For what it's worth, I agree with Krzysztof.  In the (long) cover
> page we pointed this out, and offered to do it in a followup patch.
> But if requested we can do it now.
>=20
> So in v6, a new patch would be inserted before the other three,
> and it would:
> - Remove the status =3D "okay" lines for those nodes that are not enabled
>   in this new platform, in "jh7110-common.dtsi"
> - Add nodes where appropriate in:
>     jh7110-milkv-mars.dts
>     jh7110-pine64-star64.dts
>     jh7110-starfive-visionfive-2.dtsi
>   They'll look like this, to enable the ones disabled above, e.g.:
>     &gmac0 {
>         status =3D "okay";
>     };
>=20
>     &i2c0 {
>         status =3D "okay";
>     };
>=20
> You guys should come to agreement, but I do think what Krzysztof says
> is the right approach.  And unless convinced otherwise, this will be
> what shows up in the next version of this series.

Ultimately, it is up to Emil how he wants these laid out.

--HM8xtjn6x2CDD6Fw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxaF1gAKCRB4tDGHoIJi
0n25AP9w+mgLPG37PWo0lketQlmgfBvb0mnm/q/uq+DyENNPiwEA0d6noRdXHH1D
VAVdOopja8BtMCTOjnpc/8inYN+MbQQ=
=T8RS
-----END PGP SIGNATURE-----

--HM8xtjn6x2CDD6Fw--

