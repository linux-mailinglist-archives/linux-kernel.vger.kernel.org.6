Return-Path: <linux-kernel+bounces-333970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D3C97D0D4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681F42845D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC4B2C6AF;
	Fri, 20 Sep 2024 05:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gVSozvLI"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DC224FA
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726808726; cv=none; b=DlhhbO/SHMEUlhw+wY3aZzd73n+p6CjLo3Rg61gWIIEAmAY7KFFDzleIZ3Xg4bfGVHXt+RjwYg+wu4uuazX20i8Z/xRHULu5I6tQHoPNmnWFS30XNacz/p4tgp0D/LQmZ9zLHFCfpM0ZOBQ2BmOksNGlLAmMmgF2T63mtVf6q5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726808726; c=relaxed/simple;
	bh=VdQ5YiDEY8s0A+7ss3MsgTUlYp5BhNCvYFc2rnTHQbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hs3br3DL1fEQsWTSYdhC+3fq/lJSPM+3IOsrhQ9ze6S+g4ETy8rbbI3lzuEu6bqduppvaoaWIN9KQkySJ7LZtlr5mNzH5AA7VB/f4XV31ru4w0Q8mI174lWY4654mY2BnGkhmKmGnaJxr3mrKGGR+kJ9YRShQtlg/2CskhKIJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=gVSozvLI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726808719;
	bh=L7txuy2RpUW0+CVay7TizTXlbd4oklBB9HaaTNLp0ho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gVSozvLIqcb2v8T+6JCtdRgifxeejKw3DmUpZCY+OYciHmhhoDqM4Kf+YROgzQw7x
	 Zis+/qGlI2JJ5fsNyE+id7VBnY3VWIVboFPv3OvsIdL2cDm4dMX3xXn2G51rMFaUp9
	 3d1euZTNllxQ78giFBUSOiUq+FOsB/65cr1u824bUbofh4urIAZVO2+PMOZVjYv3FU
	 nnk45Rzh+hKsgayBDCX4Jq0KGJlfPh+SLu/VAiIXrDoNBkrbv3bQjc1N2oyTGCAx/r
	 +8qTP6hJeAr+wFkD0NGZDUmxkfn7xn/manNykiRxjEC6gB9QAOa7tnb1uDBQuk4r25
	 hSMkrt7TLyavw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X90gx633Yz4xPy;
	Fri, 20 Sep 2024 15:05:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
 Anjali K <anjalik@linux.ibm.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Kan Liang <kan.liang@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Naveen N Rao
 <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] powerpc/perf: Use guard(irqsave)() in eight functions
In-Reply-To: <096fc4ee-8ffe-4eb6-88f8-28dc944b079f@web.de>
References: <096fc4ee-8ffe-4eb6-88f8-28dc944b079f@web.de>
Date: Fri, 20 Sep 2024 15:05:17 +1000
Message-ID: <871q1eoqya.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Markus Elfring <Markus.Elfring@web.de> writes:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 16 Sep 2024 19:25:00 +0200
>
> Scope-based resource management became supported for some
> programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
> See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
> Introduce __cleanup() based infrastructure").
>
> * Thus replace local_irq_save() and local_irq_restore() calls by calls
>   of the macro =E2=80=9Cguard(irqsave)=E2=80=9D.
>
> * Omit the local variables =E2=80=9Cflags=E2=80=9D and =E2=80=9Cirq_flags=
=E2=80=9D.
>
> * Replace selected usage of the label =E2=80=9Cout=E2=80=9D by a few retu=
rn statements.
>
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/perf/core-book3s.c | 102 +++++++++++++-------------------
>  1 file changed, 42 insertions(+), 60 deletions(-)

These mostly look good.

I don't think the change to power_pmu_event_init() is an improvement.

I'll drop that hunk when applying, or you can send a v2 without that
change if you prefer.

cheers

> @@ -1996,7 +1980,7 @@ static bool is_event_blacklisted(u64 ev)
>  static int power_pmu_event_init(struct perf_event *event)
>  {
>  	u64 ev;
> -	unsigned long flags, irq_flags;
> +	unsigned long flags;
>  	struct perf_event *ctrs[MAX_HWEVENTS];
>  	u64 events[MAX_HWEVENTS];
>  	unsigned int cflags[MAX_HWEVENTS];
> @@ -2115,43 +2099,41 @@ static int power_pmu_event_init(struct perf_event=
 *event)
>  	if (check_excludes(ctrs, cflags, n, 1))
>  		return -EINVAL;
>
> -	local_irq_save(irq_flags);
> -	cpuhw =3D this_cpu_ptr(&cpu_hw_events);
> +	{
> +		guard(irqsave)();
> +		cpuhw =3D this_cpu_ptr(&cpu_hw_events);
>
> -	err =3D power_check_constraints(cpuhw, events, cflags, n + 1, ctrs);
> +		err =3D power_check_constraints(cpuhw, events, cflags, n + 1, ctrs);
>
> -	if (has_branch_stack(event)) {
> -		u64 bhrb_filter =3D -1;
> +		if (has_branch_stack(event)) {
> +			u64 bhrb_filter =3D -1;
>
> -		/*
> -		 * Currently no PMU supports having multiple branch filters
> -		 * at the same time. Branch filters are set via MMCRA IFM[32:33]
> -		 * bits for Power8 and above. Return EOPNOTSUPP when multiple
> -		 * branch filters are requested in the event attr.
> -		 *
> -		 * When opening event via perf_event_open(), branch_sample_type
> -		 * gets adjusted in perf_copy_attr(). Kernel will automatically
> -		 * adjust the branch_sample_type based on the event modifier
> -		 * settings to include PERF_SAMPLE_BRANCH_PLM_ALL. Hence drop
> -		 * the check for PERF_SAMPLE_BRANCH_PLM_ALL.
> -		 */
> -		if (hweight64(event->attr.branch_sample_type & ~PERF_SAMPLE_BRANCH_PLM=
_ALL) > 1) {
> -			local_irq_restore(irq_flags);
> -			return -EOPNOTSUPP;
> -		}
> +			/*
> +			 * Currently no PMU supports having multiple branch filters
> +			 * at the same time. Branch filters are set via MMCRA IFM[32:33]
> +			 * bits for Power8 and above. Return EOPNOTSUPP when multiple
> +			 * branch filters are requested in the event attr.
> +			 *
> +			 * When opening event via perf_event_open(), branch_sample_type
> +			 * gets adjusted in perf_copy_attr(). Kernel will automatically
> +			 * adjust the branch_sample_type based on the event modifier
> +			 * settings to include PERF_SAMPLE_BRANCH_PLM_ALL. Hence drop
> +			 * the check for PERF_SAMPLE_BRANCH_PLM_ALL.
> +			 */
> +			if (hweight64(event->attr.branch_sample_type & ~PERF_SAMPLE_BRANCH_PL=
M_ALL)
> +			    > 1)
> +				return -EOPNOTSUPP;
>
> -		if (ppmu->bhrb_filter_map)
> -			bhrb_filter =3D ppmu->bhrb_filter_map(
> -					event->attr.branch_sample_type);
> +			if (ppmu->bhrb_filter_map)
> +				bhrb_filter =3D ppmu->bhrb_filter_map(event->attr.branch_sample_type=
);
>
> -		if (bhrb_filter =3D=3D -1) {
> -			local_irq_restore(irq_flags);
> -			return -EOPNOTSUPP;
> +			if (bhrb_filter =3D=3D -1)
> +				return -EOPNOTSUPP;
> +
> +			cpuhw->bhrb_filter =3D bhrb_filter;
>  		}
> -		cpuhw->bhrb_filter =3D bhrb_filter;
>  	}
>
> -	local_irq_restore(irq_flags);
>  	if (err)
>  		return -EINVAL;
>
> --
> 2.46.0

