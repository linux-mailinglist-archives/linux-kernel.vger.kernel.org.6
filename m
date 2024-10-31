Return-Path: <linux-kernel+bounces-390512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A679B7AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8DA1F22C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3C19CCF9;
	Thu, 31 Oct 2024 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRSn412O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4E19D07E;
	Thu, 31 Oct 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378297; cv=none; b=rwrxpI5qdQOD8LH9mcryY0jG4mmSU3xKr7phI99plFnr6xuK0O7as1eDIlWuTOmtAScdo4JdAt+gDPVOI2YGDooSI8Xqgs7ht7k9rPNyl0MwQNtiBrqLEFbNUYfH383oZtW3VixzEbgwBTRPG2Grh5aCoVJJSSNKxuETp7kNhxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378297; c=relaxed/simple;
	bh=6zINfUhcq11skpHNYXg2rHHDLkTZ5uPjWErNSLSYvfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6FKevVgoipiI4dPV8ZesAhzAfN0ul3geOtCBZGIh+dQMUZo1Z9oOMRQvBSrwL1Ur7XOoG5rO4k1ESOMI0g3yxxYrju/CjytkKjsvalSMwNUHPHqycvmra9wGRTyxzgbuKBp1Dw0mZXZQ4uYTFvDLZG4L/0ITLfnf8YTL+hirmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRSn412O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB11C4CED1;
	Thu, 31 Oct 2024 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730378296;
	bh=6zINfUhcq11skpHNYXg2rHHDLkTZ5uPjWErNSLSYvfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRSn412O09IxxRHRbjZCA85hxExQTsyRkLKhBlg7kn2tMf+s3si5Wtz/R7t+1CEaF
	 AhQtCH+9h6ZjixbmrtmudnlAakAA5RCI37MtRDWHznNgymxCYByKvnFCCZBZK8MJvA
	 np0SsqnTBTMdWV3auWHlSdVy8Y48n2Y4g9IAhdHFn4r351RIVia+phwNrMnLXn9ImV
	 1aatHUw13d5gFgXm85kUnKwwwT5uP2bxsuWLDbHfPmn1+Jlp3IX2HOTiwcBZO3l8nr
	 sMEa0V5iGxC8UnWGdeH3lc6sXZuAVzxSdx2RoMDgZV/tNGpbohHe8XxlIpn3/WiV8M
	 9B1BcKQp2kvaw==
Date: Thu, 31 Oct 2024 12:38:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Anup Patel <apatel@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Sophgo
 SG2044 ACLINT SSWI
Message-ID: <20241031-armored-marbled-36cfb6d599e3@spud>
References: <20241031060859.722258-1-inochiama@gmail.com>
 <20241031060859.722258-2-inochiama@gmail.com>
 <esuteqvz37blehx6wa5cj5ixlglcbullhuls3rcvjtuiviqqpb@ojho3arlnwst>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QH+DklLw2VTXfWnH"
Content-Disposition: inline
In-Reply-To: <esuteqvz37blehx6wa5cj5ixlglcbullhuls3rcvjtuiviqqpb@ojho3arlnwst>


--QH+DklLw2VTXfWnH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 02:14:40PM +0800, Inochi Amaoto wrote:
> On Thu, Oct 31, 2024 at 02:08:57PM +0800, Inochi Amaoto wrote:
> > Sophgo SG2044 has a new version of T-HEAD C920, which implement
> > a fully featured T-HEAD ACLINT device. This ACLINT device contains
> > a SSWI device to support fast S-mode IPI.
> >=20
> > Add necessary compatible string for the T-HEAD ACLINT sswi device.
> >=20
> > Link: https://www.xrvm.com/product/xuantie/C920
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>=20
> Hi, Conor,
>=20
> Could you review it again? I have updated the description of
> the binding and mark the device is T-HEAD specific.

Only thing I would say is that
title: Sophgo sg2044 ACLINT Supervisor-level Software Interrupt Device
should probably be
title: T-Head c900 ACLINT Supervisor-level Software Interrupt Device
or similar, since this isn't Sophgo's IP.

w/ that,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
(dunno if Thomas is willing to change that on application)

--QH+DklLw2VTXfWnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyN6MgAKCRB4tDGHoIJi
0iNMAQC8918qceXht4v+i90x6glN4L4mOHgWG7iUzkRIq6wpuwD+PUBMu/Kdjoxt
jsgV7kPADBYAj4UKKBuMWJ1JrevOjAY=
=40NK
-----END PGP SIGNATURE-----

--QH+DklLw2VTXfWnH--

