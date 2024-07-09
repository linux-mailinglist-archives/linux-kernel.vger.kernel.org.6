Return-Path: <linux-kernel+bounces-246678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73D92C51F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4800282826
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E0185607;
	Tue,  9 Jul 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWiYrgEs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C97180046
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559100; cv=none; b=TlU1TwDW9WQuvdD9Kw+wvy214gIzkUkh4eLnBH/pBZu/+kdQgSWLqTcwkseyETHyatySHhwhnLbLqtKZ5D5sfebNNUufZ1fVXDsKnLHLTdWsHY0mQWjvxZKmK3jK6D1ZVgRHfCJQF6uuYb8SEw/x8tgPyczhgqoR2GSiFhOVtXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559100; c=relaxed/simple;
	bh=oKW7jVLQw1Mx3QcWZjh8kQiqVbV3Wyz4nG0qMVcpG2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsN0maN4Vq6L4wxzL/8WE9GUSRo+6j62vV2hduYRw0RpCxOtMO5SBRF2Z76h8UKW6N/Fz5pmqekekV4ZcAKHkYJSe9Cx4IXOUsWR6H6txIdnoJsG8uWdC1qjykW++nU5u3U9KxuNQuHjA7CJcVaVW6oLGTEWjTByD/41ZjqJdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWiYrgEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19620C3277B;
	Tue,  9 Jul 2024 21:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720559100;
	bh=oKW7jVLQw1Mx3QcWZjh8kQiqVbV3Wyz4nG0qMVcpG2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWiYrgEscpQ/B3iJKc+gf31dfy+NhJlE2m4kBlHXVCu+AaWT/oQq7sDGqWf0wyqd4
	 7uWNGpufMG/yRORpvf6jaXZ8o5tu4J0wXdxjN9rTz5OBlLrAxfMpDxHf2BGgobqsXg
	 2pDJM7AnqbDA/iEp7hz2g4Pz0axMG8bCMgbqC0MOGF/bm4xTt6nK90VkOY8epPwU7I
	 WD+f0VmgIDKeTbtJQ4tI/co+OMsbQ3Sn3x1boWQrmBA1Zv9kdHc10JMbqGqXu0Lx0C
	 Sy3KZBI10/F0HDDUhDN7AOc7HQKPKliMmPjdwQaYSkaFR/Daeg54tNEHCRuyM/CCk0
	 SvfEgBKT8dN3w==
Date: Tue, 9 Jul 2024 22:04:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Xiao Wang <xiao.w.wang@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, atishp@atishpatra.org,
	anup@brainfault.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: riscv: Remove redundant macro check
Message-ID: <20240709-fame-uptown-c936014cd66a@spud>
References: <20240708121224.1148154-1-xiao.w.wang@intel.com>
 <20240708-wildcard-denim-12de7fae795b@spud>
 <Zo2dtuv0quQ7FwtK@ghost>
 <20240709-unengaged-handgrip-56a5c7b3e1d1@spud>
 <Zo2kSxsJkdkBdBEW@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aWsjKJVk6Ifn6ykO"
Content-Disposition: inline
In-Reply-To: <Zo2kSxsJkdkBdBEW@ghost>


--aWsjKJVk6Ifn6ykO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 01:57:47PM -0700, Charlie Jenkins wrote:
> On Tue, Jul 09, 2024 at 09:44:17PM +0100, Conor Dooley wrote:
> > On Tue, Jul 09, 2024 at 01:29:42PM -0700, Charlie Jenkins wrote:
> > > On Mon, Jul 08, 2024 at 01:22:11PM +0100, Conor Dooley wrote:
> > > > On Mon, Jul 08, 2024 at 08:12:24PM +0800, Xiao Wang wrote:
> > > > > The macro CONFIG_RISCV_PMU must have been defined when riscv_pmu.=
c gets
> > > > > compiled, so this patch removes the redundant check.
> > > >=20
> > > > Did you investigate why this define was added? Why do you think tha=
t it
> > > > is redundant, rather than checking the incorrect config option?
> > >=20
> > > This file is only compiled with CONFIG_RISCV_PMU:
> >=20
> > I might be ill, but I can still read. I was not disagreeing with Xiao
> > that the condition is redundant as written - I want to know whether they
> > made sure that this check was intentionally using CONFIG_RISCV_PMU in t=
he
> > first place, or if another option should have been here instead.
>=20
> Makes sense! Looking through the lists I see this RFC from Atish where
> he introduced a different config option for this
> "CONFIG_RISCV_PMU_COMMON"[1]. I wonder if something got confused in the
> development of these two patches.

Perhaps.. What I was worried about was the wrong option being here
(maybe that it should have been RISCV_PMU_SBI or similar) and depending
on how the kernel is configured, userspace would get the wrong info
here. But maybe it is innocuous your theory would suggest, and there's
nothing to worry about. But that's for someone with a functioning brain
to figure out ;)

Cheers,
Conor.

>=20
> Link:
> https://lore.kernel.org/lkml/20240217005738.3744121-12-atishp@rivosinc.co=
m/
> [1]
>=20
> > > # drivers/perf/Makefile
> > > obj-$(CONFIG_RISCV_PMU) +=3D riscv_pmu.o
> > >=20
> > > So having this check does seem redundant. I am copying Alex as it loo=
ks
> > > like he wrote this.
> > >=20
> > > > >=20
> > > > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > > > ---
> > > > >  drivers/perf/riscv_pmu.c | 2 --
> > > > >  1 file changed, 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > > > > index 0a02e85a8951..7644147d50b4 100644
> > > > > --- a/drivers/perf/riscv_pmu.c
> > > > > +++ b/drivers/perf/riscv_pmu.c
> > > > > @@ -39,7 +39,6 @@ void arch_perf_update_userpage(struct perf_even=
t *event,
> > > > >  	userpg->cap_user_time_short =3D 0;
> > > > >  	userpg->cap_user_rdpmc =3D riscv_perf_user_access(event);
> > > > > =20
> > > > > -#ifdef CONFIG_RISCV_PMU
> > > > >  	/*
> > > > >  	 * The counters are 64-bit but the priv spec doesn't mandate al=
l the
> > > > >  	 * bits to be implemented: that's why, counter width can vary b=
ased on
> > > > > @@ -47,7 +46,6 @@ void arch_perf_update_userpage(struct perf_even=
t *event,
> > > > >  	 */
> > > > >  	if (userpg->cap_user_rdpmc)
> > > > >  		userpg->pmc_width =3D to_riscv_pmu(event->pmu)->ctr_get_width(=
event->hw.idx) + 1;
> > > > > -#endif
> > > > > =20
> > > > >  	do {
> > > > >  		rd =3D sched_clock_read_begin(&seq);
> > > > > --=20
> > > > > 2.25.1
> > > > >=20
> > > > >=20
> > > > > _______________________________________________
> > > > > linux-riscv mailing list
> > > > > linux-riscv@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >=20
>=20
>=20

--aWsjKJVk6Ifn6ykO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo2l9wAKCRB4tDGHoIJi
0gSWAP9oGcirJgLpENEcorthZsiWOHCqqBbqHc6wSFLTEchW2QD8DJ/ZX+McRfqK
23R5kJYKiGo/e1DBdk8hkPKMMfcZEgM=
=t8ej
-----END PGP SIGNATURE-----

--aWsjKJVk6Ifn6ykO--

