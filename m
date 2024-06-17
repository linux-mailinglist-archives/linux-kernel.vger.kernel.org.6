Return-Path: <linux-kernel+bounces-217859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5346490B61F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE00B2BEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6FE73467;
	Mon, 17 Jun 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq5T+6Ci"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE71BF38;
	Mon, 17 Jun 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638384; cv=none; b=nWk8I0yCb8uM12kR/MLkMrWkfUwq09hO0rHmNCrQ3gNtqo0y1xc6XIZe/s1qkXy9vxULyflJv5bGU6gP4nq3fCKmZRGHjXxZvXXeXYP0pp2eN6ny2TeAfbvO0XX4wx1kFf+cwbfOxBEg88oPThYEroDBmOmMXI/1cxvReNWUx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638384; c=relaxed/simple;
	bh=HxCgZ9RRehmuaY6O4D/DkqsCxzUh2/Ih2ogkzpYGqys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBvXYy0eqK/doFzPpBxLmWkrvsJsSaK8GejFB4BUpHn4l3pPdYJ0AitIQ8ex2XMkxFSvNCcJOStPbQfX1YbU6Jx/+ibmib1MqPZUrPIJyl265vSVDuMpgOqfL9r0Dr9Upi6Seee2Iys3UDeCRVeT6TMEEDh/dza+BuvF9tphv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq5T+6Ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F8FC4AF1C;
	Mon, 17 Jun 2024 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718638384;
	bh=HxCgZ9RRehmuaY6O4D/DkqsCxzUh2/Ih2ogkzpYGqys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cq5T+6Ci5gl+/lsjeByOrNUYs1W4yi2O0xOuvt3SOBaQpxoiuXxIozmJ9BktASDdb
	 IiegacTovdT5OMiyAfbHHRzCj40MJJWSlgbI+mkP0McRnkIvtbu0aLBShEVreEABgU
	 WZoyO+ShWJKDCgXfYoDB4Z3Pg/DhgJWsQkeRhyXxjkTBkvNXyFczzUQQSiUXC2C6t7
	 zdRv5nuvylPllepQjfdauJMZjzLn9Z66qDwNpfaQL6u8gLq38HTURc58lVN/qXoVgn
	 kumsZhxSvo0yLZe0FSWn2xAxJt93rlpLEiQqtWQvRb2QLhwjamvBelDSOyTYUk2J3p
	 jAgEr4evAWABw==
Date: Mon, 17 Jun 2024 16:32:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Yixun Lan <dlan@gentoo.org>, Yangyu Chen <cyy@cyyself.name>,
	linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jesse Taube <jesse@rivosinc.com>
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
Message-ID: <20240617-synapse-carmaker-0a59c7c6edb7@spud>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
 <20240616224811.GC3983622@ofsar>
 <ZnBEBQjTQtFs-fXt@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AaEPeEN+LnYVG4mh"
Content-Disposition: inline
In-Reply-To: <ZnBEBQjTQtFs-fXt@xhacker>


--AaEPeEN+LnYVG4mh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 10:11:17PM +0800, Jisheng Zhang wrote:
> On Sun, Jun 16, 2024 at 10:48:11PM +0000, Yixun Lan wrote:
> > Hi Conor
> >  Thanks for bringing this up
> >=20
> > On 19:35 Sun 16 Jun     , Conor Dooley wrote:
> > > On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:
> > >=20
> > > No MAINTAINERS update, so I figure that means you don't want to maint=
ain
> > > it going forwards? If there's someone out that that does care about t=
he
> > > spacemit k1 (Jesse maybe?), then I'd be more than happy to have them
> > > look after it.
> > Yangyu kind of has limited time, too many stuff for him..
> >=20
> > I'd volunteered to help on this if it can fill the gap
> > Also I'd be more than happy if anyone willing step forward to co-mainta=
in..
>=20
> Does maintainership work like this? Is willing to do enough?
> FWICT, maintainership involves active patch contributing, reviewing and
> maintaining the whole SoC. It is better to take over the maintainership
> after showing enough patch contributions and understanding of the SoC.

I was going to reply to your other patch about providing more complete
"basic" support for the SoC, but I guess I'll reply here and address
both points. After the k230 and th1520, which were both merged with very
basic support and have made very little progress towards being a useful
platform, I'm pretty reluctant to merge another platform in a super
basic state. I was going to make this point before you brought it up,
but it's good to know I am not the only one with that view. To be clear,
I'm not pointing blame for those platforms, I'd just like to avoid a
repeat. If Yangyu doesn't have time to do any development work on the
platform, I'd like to see someone else (and as I mentioned Jesse is
interested) take on getting some of the basic driver patches written and
merge only when those are accepted. Having no in-tree clock and pinctrl
drivers is definitely a hindrance to other people doing parallel
development of drivers and I'd like to avoid that.

Getting back to your point in this mail, whoever gets the platform to
that state is well suited to looking after it going forwards. Some other
interested parties could also join as reviewers. I don't want to see
people joining as maintainers that are not going to have an interest
in the platform going forward, as that'll just end up with me as the
defacto maintainer.

Thanks,
Conor.

--AaEPeEN+LnYVG4mh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBXKgAKCRB4tDGHoIJi
0v20AQCpR2ZQ2v2NRkN0DYxAd/yPPIfKqlUlrmJB2U/evik29gD9FRxjtuXoD1XB
QPAeBrDfwe+kvuWdHG1CeRwlLMpItAA=
=xn4V
-----END PGP SIGNATURE-----

--AaEPeEN+LnYVG4mh--

