Return-Path: <linux-kernel+bounces-337386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C87984968
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D32B1C23163
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC82C1AB52B;
	Tue, 24 Sep 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuQIT8La"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D01B85D6;
	Tue, 24 Sep 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194611; cv=none; b=DZJUVzv0dQooTgeWXgA3jye08mNn6OY48XuIEbZ0/qwoPMrtf4zBqfcNx3jYup21RuMUhchX580iPWomRHmYYvfvjlQSY1FC3SDSNDVq7aZIk4tJ5y1GHGQSNiS4eHk2Ewd11o2wUM7Nl6UM0RmPq5MeelAE0rBFnfsRujZr34E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194611; c=relaxed/simple;
	bh=7vhPh7OpK9Z+/MJC8dy+JSeVzTF5FEc0QB1gsS153vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/oRhS2tpvxyVRtyEWecNk002ktPvFo2vqKqSft7KS+QiSTobvLHGi8mOv7G0MhAupPYTXljvNrH4utCP6dOyYUC+Ty7dP46ZwFS+teVaWYtYObHsP92N19NOhvd4BXCsIpfpOSqElewMDQ/eLF6/ml09ddU+atMfMT3AYbffH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuQIT8La; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4F3C4CEC4;
	Tue, 24 Sep 2024 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727194610;
	bh=7vhPh7OpK9Z+/MJC8dy+JSeVzTF5FEc0QB1gsS153vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuQIT8La3d74zIxluUc3ZcuFUwUjrpAOOMGcJN9sXH+bObpwgrGOcaTOYayQqNegn
	 iMMah43SASNRrnxcD1tLFDEYGXNQWBafGHlgthJ9KhIVQN+BVNE+MyDfEbiexzjSYr
	 gQwsoyjTcIPTe7YOBZA9/EGkbw4jbU6nUqt4d4u0pcsVdomhKZW9nPZ19EkBpfTAx1
	 oeY5oWhqEDBZbbIprJN9du2VvTjqPyDGAGAZobgrLHe1a67TBt5d3UdIXvbRyG6CzY
	 4ENR2TCbYbqx/hEaHP+FeZRNZTxJZjZ0nRUorZ3LKxZuX2xyaYaIJuoshNQBvfpTN8
	 AtKeMDq01XKaQ==
Date: Tue, 24 Sep 2024 17:16:44 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?5pu554+K54+K?= <sandie.cao@deepcomputing.io>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>, rafal@milecki.pl,
	Linus Walleij <linus.walleij@linaro.org>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dhs@frame.work, ams@frame.work,
	gregkh@linuxfoundation.org, yuning.liang@deepcomputing.io,
	huiming.qiu@deepcomputing.io
Subject: Re: [patch v2 2/3] dt-bindings: riscv: starfive: add
 deepcomputing,fm7110
Message-ID: <20240924-pacemaker-unstylish-3807c3c4f106@spud>
References: <20240924080650.1345485-3-sandie.cao@deepcomputing.io>
 <5dfa7fb9-5b0e-424e-bf53-74a9eaa25bb1@kernel.org>
 <407ce3d77416bb2522b7906b0df3d5adf02c27ee.1182851f.8778.42ba.bd71.b04cef6fccc0@feishu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GxgsP75MI66qruER"
Content-Disposition: inline
In-Reply-To: <407ce3d77416bb2522b7906b0df3d5adf02c27ee.1182851f.8778.42ba.bd71.b04cef6fccc0@feishu.cn>


--GxgsP75MI66qruER
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 06:12:02PM +0800, =E6=9B=B9=E7=8F=8A=E7=8F=8A wrote:
> On 24/09/2024 10:06, Sandie Cao wrote:
> > Add deepcomputing,fm7110 into compatible list.
>=20
> A:=C2=A0
> DeepComputing is creating a RISC-V Framework Laptop 13 Mainboard=C2=A0
> powered by a StarFive JH7110 processor.This is=C2=A0a=C2=A0developer-focu=
sed=C2=A0
> product, aimed at making tinkering with RISC-V more accessible.
> The Mainboard is under development and we'll share more on functionality,=
=C2=A0
> compatibility, and availability as the program progresses.
> For this Mainboard, the Model name in Framework is Framework FRANME0000;
> the Model name in DeepComputing is DeepComputing fm7110.
>=20
> Q: This we see from the diff. And commit subject. Describe here the hardw=
are.

Please don't use this quoting style, please figure out how to do
proper inline quoting with your mail client.

>=20
> > Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
>=20
> Best regards,
> Krzysztof
>=20

--GxgsP75MI66qruER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLl7AAKCRB4tDGHoIJi
0oR+AP0Z0zHw2BTNJ4dGmMSviMtQzA2yds6Tgzj9sEM3p2HXagD/eqlmZoKnSuxU
Qs9W9Vc+2mY0Z80iCgELR8mzzm4SoAM=
=n/4d
-----END PGP SIGNATURE-----

--GxgsP75MI66qruER--

