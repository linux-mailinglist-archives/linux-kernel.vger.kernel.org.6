Return-Path: <linux-kernel+bounces-175446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA168C1FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC6C1C20CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFADC79945;
	Fri, 10 May 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOnJNe+0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427714C8E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330154; cv=none; b=jqzxAfgC76Higu5lNNqFQDoF8s5jhuFohxaltqLGo2ie5Wa9iJcdQCfryqLi3IXzXSJ8jMG+o36G9V3fnfd73/ul2mFgsOUySGA/apadLqmPYURUv1SlUQpmJs7dYBpnTWglq+a2fN938CGZKkSgY9yAE8ibZJLqLnaCqQ80Z6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330154; c=relaxed/simple;
	bh=CQ60Q4+NgXsh8F6HlVj6l58HkFtjQQJ5uRtYcKoUhLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTyb0adDiWg0/ZtxxBGKqqIHx/PdLj4h27kNvDTJCll5wUvxLVNg28QANvaHhgK9kOaud7PxFJJG7I5Y4viMnj0shCxr9BIm8uggazvJhTesMO+9qn53WqsSwNLHoSzDQNXObUxFHfraEPQj8FB9dVStkOTRV4dzqkTt6G5v9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOnJNe+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4180DC113CC;
	Fri, 10 May 2024 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715330153;
	bh=CQ60Q4+NgXsh8F6HlVj6l58HkFtjQQJ5uRtYcKoUhLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOnJNe+0a9PC2UHNB65Y0lB8bnNYsAJrSTeqU3X/gv4dNDkuw4BralKeV4WeuapPD
	 wDrX716S4bEjeRTUxz4FYYAtNu8IUgmsDc5zcBpr5bBy2mEYgzuILg12LZJKz1JMWV
	 wOF7V0VUaAfBsWKazgbRFEXf88llJY05OOXNGRATfoSBSbyb8LkNh08PG8J2pnmcaN
	 nAXbmSCgrZR/fKk12n7pbA23w3xiNuxwNvGi13QhDUvh/0GTATIpXhtVxmRgnLSNAU
	 9tvC7WE2lg2XmD2hIOPOlUmnYGqb5HY2AN94Fiv+IemOXFThs1Sy4wR5OjayIEaSxo
	 OixRso8w9lBrQ==
Date: Fri, 10 May 2024 09:35:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Song Liu <song@kernel.org>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] riscv: Support compiling the kernel with more
 extensions
Message-ID: <20240510-pesky-tackling-1b715c4bce35@spud>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240509-uptown-aging-5bdec4730d70@spud>
 <Zj09IUE5k1EJL08X@ghost>
 <20240509-google-passing-3e7577235c44@spud>
 <Zj1UUIY8RYV1kJLM@ghost>
 <20240510-okay-trade-8826cb134979@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ai3o+TcwKEPcPexK"
Content-Disposition: inline
In-Reply-To: <20240510-okay-trade-8826cb134979@spud>


--ai3o+TcwKEPcPexK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 09:25:37AM +0100, Conor Dooley wrote:

> > > see why this particular optimisation was worth maintaining 3 code pat=
hs
> >=20
> > I interpreted the "3 code paths" as with Zbb + 64 bit, with Zbb + 32
> > bit, and without Zbb. I directly responded to that by saying that we
> > could eliminate all of the code paths that are not Zbb + 64 bit could be
> > eliminated.

Argh, forgot to say that that was what I meant by the 3 paths, but I
didn't take
| We could just say we don't care about performance if you are running
| 32-bit linux or don't have Zbb, but we would be making that decision
| because we don't feel like maintaining the code. The code was written,
| tested, reviewed, and it provided large performance gains. I fail to
| understand why this is a burden to maintain.
as seriously suggesting that we should remove anything, it read like a
defence of the current code!

--ai3o+TcwKEPcPexK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj3cZQAKCRB4tDGHoIJi
0uIxAP9yoDBxvfeCk961aMZIxkvg+qNdxvB+OMYZaxr8gJAuZQEAravVoFAZw7S5
NSUTstQ+I3BTHjimBeFNG+4vsE+A5wg=
=+hIz
-----END PGP SIGNATURE-----

--ai3o+TcwKEPcPexK--

