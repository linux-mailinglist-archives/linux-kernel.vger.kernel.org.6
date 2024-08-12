Return-Path: <linux-kernel+bounces-282541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7071A94E58C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC0A1C2146A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3404513D53E;
	Mon, 12 Aug 2024 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIBon2QT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974E136348
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723433177; cv=none; b=c3b/2d47+G0s/mwKrLXocuwY2psW3x9md1mmuKWIjIY7iRPmJl9W9KzhDkxnYV4Y2YLMF6k3ZIGlQ1/OXwWF1d4sKKHHzTmH3h0hZ23evsE/fn8N8/nDdmpQT56no+7In2L/vRedDWJxBC/1b/a4ALx9YNwXtIYQSpXbclvfMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723433177; c=relaxed/simple;
	bh=nmid4nLVb1hwZ/HBR6tAE1jHKXc+U1oX+uoB/R5ifY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCK8Wqoik0JE7tM56Z2Ija9EUP5apn0JfZ8IeY0EHZHdd/RkZK0ZdA67rB6O85uop1d+O+O2/iXTJVWR/GFBTpY5ygv6aU3eSL2jKNs5nwH3npH7vPfaXVIXx1OgqpIaxhVk7HsVMjw01d+nskDm6gfIlcmOuC2WO1JogJdjJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIBon2QT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723433176; x=1754969176;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=nmid4nLVb1hwZ/HBR6tAE1jHKXc+U1oX+uoB/R5ifY4=;
  b=bIBon2QTgRgxVHhrRTJT8Ecve+kyMZYZxm1AVGkLYWwC/zb1C2QflC9x
   YITPpY3rk71iPgWSPi8UwavDSFo/Hk1PBNPUWCMaQVE88VI3jjlkj59QK
   RrsahjG6+y9B41wvOduJthL/M4OX/ntGhWasghgz9meXUbbD+Wu29m0DB
   9gl1ktKNXcBONkmY5EjDmChlVt5d1m6i60BpnM4bVFGgz5vTzvtebUw8P
   ONpGC5IDTXpmg557BuLf1V+IsmeQ61cRdO11sXRP/HgkOyaFY9yQMWzEw
   CNdzP0D1JS4j723gDKp97464OWvH919utqI7lpLOX1zw1Zx++8MuKvU5j
   Q==;
X-CSE-ConnectionGUID: jHFfaKjMT8mtPvnrHPtKxg==
X-CSE-MsgGUID: B1mkODzRQou9HyepRVBShQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="39036159"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="asc'?scan'208";a="39036159"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 20:26:15 -0700
X-CSE-ConnectionGUID: qRbdczIXQp6l2m7gZgT7vg==
X-CSE-MsgGUID: 0jhMzAz1Q7ig1ETXb7i9HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="asc'?scan'208";a="57779931"
Received: from debian-skl.sh.intel.com (HELO debian-skl) ([10.239.160.45])
  by fmviesa007.fm.intel.com with ESMTP; 11 Aug 2024 20:26:11 -0700
Date: Mon, 12 Aug 2024 11:27:44 +0800
From: Zhenyu Wang <zhenyuw@linux.intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 3/4] perf/x86/intel: Support hybrid PMU with multiple
 atom uarchs
Message-ID: <ZrmBMMSdvLPGlgEI@debian-scheme>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
 <20240808140210.1666783-4-dapeng1.mi@linux.intel.com>
 <20240810215539.GG11646@noisy.programming.kicks-ass.net>
 <08671266-6daa-4bab-bea8-2a9fa6f0fdc3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OJthkRKUcbdYULVa"
Content-Disposition: inline
In-Reply-To: <08671266-6daa-4bab-bea8-2a9fa6f0fdc3@linux.intel.com>


--OJthkRKUcbdYULVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024.08.12 11:18:34 +0800, Mi, Dapeng wrote:
>=20
> On 8/11/2024 5:55 AM, Peter Zijlstra wrote:
> > On Thu, Aug 08, 2024 at 02:02:09PM +0000, Dapeng Mi wrote:
> >>  arch/x86/events/intel/core.c | 24 +++++++++++++++++-------
> >>  arch/x86/events/perf_event.h | 18 +++++++++++++++++-
> >>  2 files changed, 34 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core=
=2Ec
> >> index 0c9c2706d4ec..b6429bc009c0 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -6218,6 +6227,7 @@ static inline int intel_pmu_v6_addr_offset(int i=
ndex, bool eventsel)
> >>  static const struct { enum hybrid_pmu_type id; char *name; } intel_hy=
brid_pmu_type_map[] __initconst =3D {
> >>  	{ hybrid_small, "cpu_atom" },
> >>  	{ hybrid_big, "cpu_core" },
> >> +	{ hybrid_small2, "cpu_atom2" },
> > This is awfully uninspired and quite terrible. How is one supposed to
> > know which is which? A possibly better naming might be: hybrid_tiny,
> > "cpu_lowpower" or whatever.
>=20
> We have lots of discussion internally about the naming, but unfortunately
> we can't come to a conclusion. The reason that we select "cpu_atom2" is
> that it's generic enough and won't expose too much model specific
> information, we can reuse it if there are similar platforms in the future.
> But of course I admit the name is indeed uninspired and easy to cause
> confusion.
>=20
> The other names which I ever discussed are "cpu_lp_soc", "cpu_soc" and
> "cpu_atom_soc", but this name would expose some model specific architectu=
re
> information more or less, not sure which one is better. How is your opini=
on
> on this?
>

Now I don't like to put 'soc' in name as it's specific for platform design
e.g ARL-H, but pmu actually only cares about cpu type. Maybe "cpu_atom_lp"
is good enough.

>=20
> >
> >>  };
> >> =20
> >>  static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type=
 pmus)
> >> @@ -6250,7 +6260,7 @@ static __always_inline int intel_pmu_init_hybrid=
(enum hybrid_pmu_type pmus)
> >>  							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
> >> =20
> >>  		pmu->intel_cap.capabilities =3D x86_pmu.intel_cap.capabilities;
> >> -		if (pmu->pmu_type & hybrid_small) {
> >> +		if (pmu->pmu_type & hybrid_small_all) {
> >>  			pmu->intel_cap.perf_metrics =3D 0;
> >>  			pmu->intel_cap.pebs_output_pt_available =3D 1;
> >>  			pmu->mid_ack =3D true;
> >> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event=
=2Eh
> >> index 5d1677844e04..f7b55c909eff 100644
> >> --- a/arch/x86/events/perf_event.h
> >> +++ b/arch/x86/events/perf_event.h
> >> @@ -668,6 +668,13 @@ enum {
> >>  #define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
> >>  #define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX=
 - 1)
> >> =20
> >> +
> >> +/*
> >> + * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
> >> + * of the core. Bits 31-24 indicates its core type (Core or Atom)
> >> + * and Bits [23:0] indicates the native model ID of the core.
> >> + * Core type and native model ID are defined in below enumerations.
> >> + */
> >>  enum hybrid_cpu_type {
> >>  	HYBRID_INTEL_NONE,
> >>  	HYBRID_INTEL_ATOM	=3D 0x20,
> >> @@ -676,12 +683,21 @@ enum hybrid_cpu_type {
> >> =20
> >>  #define X86_HYBRID_PMU_ATOM_IDX		0
> >>  #define X86_HYBRID_PMU_CORE_IDX		1
> >> +#define X86_HYBRID_PMU_ATOM2_IDX	2
> >>  enum hybrid_pmu_type {
> >>  	not_hybrid,
> >>  	hybrid_small		=3D BIT(X86_HYBRID_PMU_ATOM_IDX),
> >>  	hybrid_big		=3D BIT(X86_HYBRID_PMU_CORE_IDX),
> >> +	hybrid_small2		=3D BIT(X86_HYBRID_PMU_ATOM2_IDX),
> >> +	/* The belows are only used for matching */
> >> +	hybrid_big_small	=3D hybrid_big | hybrid_small,
> >> +	hybrid_small_all	=3D hybrid_small | hybrid_small2,
> >> +	hybrid_big_small_arl_h	=3D hybrid_big | hybrid_small_all,
> > Same complaint, how about:
> >
> > +	hybrid_tiny		=3D BIT(X86_HYBRID_PMU_TINY_IDX),
> > 	hybrid_big_small	=3D hybrid_big | hybrid_small,
> > +	hybrid_small_tiny	=3D hybrid_small | hybrid_tiny,
> > +	hybrid_big_small_tiny	=3D hybrid_big_small | hybrid_tiny,
>=20
> Sure. I would adjust the macro name base on the above discussed final nam=
e.
> Thanks.
>=20
>=20
> >
> >
> >> +};
> >> =20
> >> -	hybrid_big_small	=3D hybrid_big | hybrid_small, /* only used for mat=
ching */
> >> +enum atom_native_id {
> >> +	cmt_native_id           =3D 0x2,  /* Crestmont */
> >> +	skt_native_id           =3D 0x3,  /* Skymont */
> >>  };
> >> =20
> >>  struct x86_hybrid_pmu {
> >> --=20
> >> 2.40.1
> >>

--OJthkRKUcbdYULVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCZrmBKgAKCRCxBBozTXgY
J7K4AJ4jqFfCUdAoLfj+EDk3g8K33HDGjgCfcUbPUY0iYiwht4GCmTxoj03PX0w=
=j1Ti
-----END PGP SIGNATURE-----

--OJthkRKUcbdYULVa--

