Return-Path: <linux-kernel+bounces-246665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE10692C4F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2621C220EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64A18562C;
	Tue,  9 Jul 2024 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgE3DPbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA3152515
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557862; cv=none; b=CQ+OmrFHBGXrV5nXCre+FrAh+q0nUZa7NcBNcAnOgMg08chXAnxKuOAd9PtJUPsp8KMJSZmbJHyAUzJFuAYdQ9H7iWkQVh6V8tQibLPt/s+nKc3oVDC+rOQVqk5XcrcqxeIp6trmM33wn1OSfLiFl3F5YLXLfXfg7fPSrdA1Y/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557862; c=relaxed/simple;
	bh=Oaa4M+sxDGqK7apUNjXSK60qxCEtSIZPmxcDfM5l0KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh8MzckFOkUFL6AD/evBXGiIFrRi5geniLpNrupbwfhroiFZGGijAT5WobMyyDIMFe5EV4+gxON6lyIla7HZaED6Samfz+enlIV9c4CfDXTtkF4/blnHfbmJVfg1iOA7/Y16uH17q29IH8hcJgkeLVTCZe6aA35zmROxtxKCcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgE3DPbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFEEC3277B;
	Tue,  9 Jul 2024 20:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720557861;
	bh=Oaa4M+sxDGqK7apUNjXSK60qxCEtSIZPmxcDfM5l0KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgE3DPbgUx9SLJ1AkIsiAsqMj9KSe9pIZDav/r1Y+iJ86r+yrUeiZwahucIcnwqq3
	 N4WIwbJ2ZqyMyNZV8IAKkXngfZPWbim0BMc2WDEAgc6TpeKA6eSeD2RGHSRhKksThm
	 8xdVV00Cy+UyfoZ09mb9HQdJ+PZZg4QLE4O9ipEpl9cv8cBSxkp/f9Cb5A8SPjsYN1
	 oTi9CnW/7vrp6sxYGZ35l11BWldtdjnaq7nMhNAyfrzd6cMQcsMIDXJ2a4xYrEGMTn
	 +RMcNXOeWxhzK0cyHrKMZwsw0GsYLIeQikydUaQfFZwJ2/CkMuu11bHvm6TMpjJUOL
	 vBPitpOJDh+lg==
Date: Tue, 9 Jul 2024 21:44:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Xiao Wang <xiao.w.wang@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, atishp@atishpatra.org,
	anup@brainfault.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: riscv: Remove redundant macro check
Message-ID: <20240709-unengaged-handgrip-56a5c7b3e1d1@spud>
References: <20240708121224.1148154-1-xiao.w.wang@intel.com>
 <20240708-wildcard-denim-12de7fae795b@spud>
 <Zo2dtuv0quQ7FwtK@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SFsSWemndNFOZrOJ"
Content-Disposition: inline
In-Reply-To: <Zo2dtuv0quQ7FwtK@ghost>


--SFsSWemndNFOZrOJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 01:29:42PM -0700, Charlie Jenkins wrote:
> On Mon, Jul 08, 2024 at 01:22:11PM +0100, Conor Dooley wrote:
> > On Mon, Jul 08, 2024 at 08:12:24PM +0800, Xiao Wang wrote:
> > > The macro CONFIG_RISCV_PMU must have been defined when riscv_pmu.c ge=
ts
> > > compiled, so this patch removes the redundant check.
> >=20
> > Did you investigate why this define was added? Why do you think that it
> > is redundant, rather than checking the incorrect config option?
>=20
> This file is only compiled with CONFIG_RISCV_PMU:

I might be ill, but I can still read. I was not disagreeing with Xiao
that the condition is redundant as written - I want to know whether they
made sure that this check was intentionally using CONFIG_RISCV_PMU in the
first place, or if another option should have been here instead.

>=20
> # drivers/perf/Makefile
> obj-$(CONFIG_RISCV_PMU) +=3D riscv_pmu.o
>=20
> So having this check does seem redundant. I am copying Alex as it looks
> like he wrote this.
>=20
> - Charlie
>=20
> >=20
> > Cheers,
> > Conor.
> >=20
> > >=20
> > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > ---
> > >  drivers/perf/riscv_pmu.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >=20
> > > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > > index 0a02e85a8951..7644147d50b4 100644
> > > --- a/drivers/perf/riscv_pmu.c
> > > +++ b/drivers/perf/riscv_pmu.c
> > > @@ -39,7 +39,6 @@ void arch_perf_update_userpage(struct perf_event *e=
vent,
> > >  	userpg->cap_user_time_short =3D 0;
> > >  	userpg->cap_user_rdpmc =3D riscv_perf_user_access(event);
> > > =20
> > > -#ifdef CONFIG_RISCV_PMU
> > >  	/*
> > >  	 * The counters are 64-bit but the priv spec doesn't mandate all the
> > >  	 * bits to be implemented: that's why, counter width can vary based=
 on
> > > @@ -47,7 +46,6 @@ void arch_perf_update_userpage(struct perf_event *e=
vent,
> > >  	 */
> > >  	if (userpg->cap_user_rdpmc)
> > >  		userpg->pmc_width =3D to_riscv_pmu(event->pmu)->ctr_get_width(even=
t->hw.idx) + 1;
> > > -#endif
> > > =20
> > >  	do {
> > >  		rd =3D sched_clock_read_begin(&seq);
> > > --=20
> > > 2.25.1
> > >=20
> > >=20
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20

--SFsSWemndNFOZrOJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo2hIQAKCRB4tDGHoIJi
0goIAP9c/Mj94icEZeVpEy3/El56Y2q44uO0nYsoF+NrkYUqYwD/WCG54d+gBssi
tgOBiToWtsXJhrh3dFDoL8SEiYrTtQQ=
=YlFZ
-----END PGP SIGNATURE-----

--SFsSWemndNFOZrOJ--

