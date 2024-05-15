Return-Path: <linux-kernel+bounces-180210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854858C6B78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5A3283CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D71B3EA7B;
	Wed, 15 May 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2zfY/kt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B928680
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794240; cv=none; b=tDyK9dMrkt7zsWiVedIqPvsQ+qrlosAGxaLMNP3+Ua9LbAL/t0K5laRr6Iq0UIR6RuxHdX0tnEs6BaPs2tla8zkPvZ28Pz2i+HJTp61yVDiIM4fpynItgkeh5+UrOw/CXRBme/yc7CNJg3/ZngBC9IG6XDxfDrcm9Xtz79sKhEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794240; c=relaxed/simple;
	bh=OJG4bpEGGrZGuwGChGXNvkTrT4xr+O2uNSKaalzsRVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N91asIOvgVVaeZI5suvrulnYF5eU46ftkB2+IPHAz91FaNo+q2n/fT/nJdxSBLOUooIz+BDGr0ZAmuLvQcfCwJdthtAhIz83dK8gKZeROGMcpshp8vQf6rlhzCsBta5s9bRhBNNpi99Qc0Ci864QwSj6NVpagw+LM6VRHL8EVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2zfY/kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FACC116B1;
	Wed, 15 May 2024 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715794239;
	bh=OJG4bpEGGrZGuwGChGXNvkTrT4xr+O2uNSKaalzsRVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2zfY/ktqA30sWx3dEOarfDm+D3W5drrb2PnLQ0orVlbsqD7LXdOivxf2ZxVjGoDJ
	 AG7WPJcfjjBPxSmPeUTWegrilWmNoRtR1wPPjQJPyOsK67+UKsuXA3FSdcsrabMI99
	 vxGraPNlo9AAShAs9xKpZUxfugtcqdKr4aeZ92cUukidF6N7Nd7iWfZXlRg9d+6lsn
	 uzCZdhrF5a1yIqwrMS/XIeJ3/aGrsKSI4nruvzrj4MBGO4c9s9p7F/HPPy3eTxToHm
	 TLaBTMUDXr+DfSZnjen3z8tazbUPkdli23xcKfFR0fHg4HVgxfLlwnuQV8rZNB+PKV
	 RLF6cPJ390D/A==
Date: Wed, 15 May 2024 18:30:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: fix Andes errata build issues
Message-ID: <20240515-bootie-patriarch-769c0ebff4b1@spud>
References: <20240515-comic-sketch-3b40e6676f55@spud>
 <ZkTnlEnoFFrQdXi2@ghost>
 <20240515-slander-stranger-683758537aee@spud>
 <ZkTuc4fxXcS/g7hC@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NRZexXjAe9f94SYv"
Content-Disposition: inline
In-Reply-To: <ZkTuc4fxXcS/g7hC@ghost>


--NRZexXjAe9f94SYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:18:43AM -0700, Charlie Jenkins wrote:
> On Wed, May 15, 2024 at 05:56:30PM +0100, Conor Dooley wrote:
> > On Wed, May 15, 2024 at 09:49:24AM -0700, Charlie Jenkins wrote:
> > > On Wed, May 15, 2024 at 05:09:34PM +0100, Conor Dooley wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > >=20
> > > > Commit e47c37c24024 ("riscv: Introduce vendor variants of extension
> > > > helpers") added includes for the new vendor_extensions.h header in
> > > > the T-Head and SiFive errata handling code but didn't do so for And=
es,
> > > > resulting in allmodconfig build issues when commit 589e2fc85850
> > > > ("riscv: Convert xandespmu to use the vendor extension framework")
> > > > added a user of a macro defined there.
> > > >=20
> > > > Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor ex=
tension framework")
> > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > >=20
> > > I was going to fix this in my next version but was waiting for the
> > > reviews on the thead stuff. I wasn't anticipating these patches to be
> > > able to jump the queue :)
> >=20
> > Yah, the reason for that is I asked him to take the non-vector parts of
> > the series as 6.10 material so that we'd have less stuff movin' around
> > in cpufeatures.c so that Clement's Zc* + validation changes wouldn't run
> > into a bunch of conflicts etc. Same reason that I pushed for getting
> > Andy's vector subset stuff merged today, but that mighta been before you
> > hopped in.
> >=20
> > Cheers,
> > Conor.
>=20
> Yes I was a couple minutes late to the meeting, whoops.


It's prob at like 0600 for you, so w/e.

> The subset of
> patches that was pulled into for-next is odd to me because there is some
> of the thead enablement code as part of the vendor extension enablement
> so that there was a user for it. Since the subset on Palmer's for-next
> does not have the rest of the thead code there is only a
> half-implementation of the thead code, it allows the kernel to probe for
> xtheadvector but it doesn't probe anywhere.

I dunno, I think that reporting that the extension is there constitutes a
user, it's not gonna be dead code. There's plenty of extensions for
which all we do is detect them and nothing more.

> In my opinion, a better solution would be for me to get rid of the thead
> code entirely from those patches. So that there is still a user, I can
> replace the thead code with the andes versions.

The Andes stuff is in the subset he applied though, so...
>=20
> Since Palmer already pulled in those changes maybe it's too late. There
> is not a critical problem here, but it seems like it's bad practice to
> introduce code without a user.

=2E..there is actually a "real" user in xandespmu. I did miss that
"riscv: Extend cpufeature.c to detect vendor extensions" actually
contained the xtheadvector detection though, rather than just the
infrastructure. I think it is probably harmless to have it, but
shouldn't be too hard to quickly drop the thead bits either I suppose
if you're worried about it.

Cheers,
Conor.

--NRZexXjAe9f94SYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTxOwAKCRB4tDGHoIJi
0n57AP4/XQPuVo3AOMDuWOhQHlozouIYfM94T+VqEClRrVRYygEA/NOrcaa74Uan
t1niincoErkoqmkJa33oAK4rZzugGw0=
=ZNQ4
-----END PGP SIGNATURE-----

--NRZexXjAe9f94SYv--

