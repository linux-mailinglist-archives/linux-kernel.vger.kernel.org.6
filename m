Return-Path: <linux-kernel+bounces-180174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4248C6B10
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C002C1F23ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B44358A7;
	Wed, 15 May 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z85sj6io"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F912B6C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792194; cv=none; b=KRpmQER+Ha0YVBGKziNfI0cuNUMk6lH/uD2BRzgtFSTcbSe3kcjeQecA1LdLquJR+VvvwsMi4qAbS1ih/oGGGIR2NKCaXw4aCZCrpq3AcFXYd/J+qsUUF8FAqTPSff7ClOmTchwf5o2mf0qEuPLi2QgAtyM8XgGyJaggKBSN4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792194; c=relaxed/simple;
	bh=Vc3UgsyCKJ4NlKCBb8Zg9oPYMZOJ5N00h4qjUnYkSiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUP6gi+W6Kq4o+EczP+Kpbv7vE0WmxOzXUi+Vpe0KTFkUqIONcq8XB0o1NdKgkKAgKU4GEpG1dUr9jLN4+x+o8dJvH8Mfl/LBamNSwIeX0q+1jUElab2aoSZFuhaQDzw0T3GL+jzW628iE683MBDR/JEY+L/ArlirQ9pq7H7sIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z85sj6io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4041C116B1;
	Wed, 15 May 2024 16:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715792194;
	bh=Vc3UgsyCKJ4NlKCBb8Zg9oPYMZOJ5N00h4qjUnYkSiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z85sj6ioU31bj8SUZwrJbHqazoJD2vBx5+ch1dJKqKBm0Z6cvXxmEASXGCJr8I6Jr
	 7JSsovXepWMtpi+SPtNSjFjSJH8jQQ9J8nYiahl/Yjqah4QW4XoUbQH3+2wAz0ZM28
	 oCBbYA0j0onTffnFOZEQpfKHqVSwOES3Rq6X4UWNtn2trcG4gRkCRq7QqJ4waTooSZ
	 qNPV85rpN/PLTfQ53xaQinGar22x8CaB0u8WGtQbQmReZGbm3I1B4Y3wG+aHlAiGhZ
	 UgR4awLb/g0Q4Jf71QS8gueK4RQpzJgPH4N1p5IVClFzCQcx2hqayHoWky60cG5Anx
	 z/K5wbbcgmvkA==
Date: Wed, 15 May 2024 17:56:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: fix Andes errata build issues
Message-ID: <20240515-slander-stranger-683758537aee@spud>
References: <20240515-comic-sketch-3b40e6676f55@spud>
 <ZkTnlEnoFFrQdXi2@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UK+D9MXCwBQBpFDQ"
Content-Disposition: inline
In-Reply-To: <ZkTnlEnoFFrQdXi2@ghost>


--UK+D9MXCwBQBpFDQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 09:49:24AM -0700, Charlie Jenkins wrote:
> On Wed, May 15, 2024 at 05:09:34PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Commit e47c37c24024 ("riscv: Introduce vendor variants of extension
> > helpers") added includes for the new vendor_extensions.h header in
> > the T-Head and SiFive errata handling code but didn't do so for Andes,
> > resulting in allmodconfig build issues when commit 589e2fc85850
> > ("riscv: Convert xandespmu to use the vendor extension framework")
> > added a user of a macro defined there.
> >=20
> > Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor extens=
ion framework")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> I was going to fix this in my next version but was waiting for the
> reviews on the thead stuff. I wasn't anticipating these patches to be
> able to jump the queue :)

Yah, the reason for that is I asked him to take the non-vector parts of
the series as 6.10 material so that we'd have less stuff movin' around
in cpufeatures.c so that Clement's Zc* + validation changes wouldn't run
into a bunch of conflicts etc. Same reason that I pushed for getting
Andy's vector subset stuff merged today, but that mighta been before you
hopped in.

Cheers,
Conor.

--UK+D9MXCwBQBpFDQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTpPgAKCRB4tDGHoIJi
0sSJAQCfVevJgU8rQ4m6T39juTOULgq+RetJE+zsp3P2MQd4BgEA/T2OiRexNN3w
g0d2C05XlOyLLThFSyWR5vfKNZ2+WQI=
=MIIp
-----END PGP SIGNATURE-----

--UK+D9MXCwBQBpFDQ--

