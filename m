Return-Path: <linux-kernel+bounces-225603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF2C9132C9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 10:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8236C1C211D6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C530014B081;
	Sat, 22 Jun 2024 08:32:35 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4279DF
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719045155; cv=none; b=WNVHGEL17v8QCT/I6Q/BHI8uECziM8E2X56Py9k9SUWh3FJxSEq3zybjFu2Zbm4jrXrtyYn1mi7bya7aqKANER+PSwGD+smhV8jDBWOZPM+IDWlByVLFKgKjs4YohmORVIsyxjyrm846evwFE7hnb6n4//xINyBQBh+vHPOABP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719045155; c=relaxed/simple;
	bh=l4G+y3W1HAUP0xuNm02/3LhS83OfGS+f6WLDhkzhB9s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6hxWeQCInBgNRh3q11+115itJXwfdKtDNRTsp6rUzwfIvxuFoOV2dI0loKwJMzUug+GoqXYBfTLXjAq5dyeH+EzRuxAk44HbU04M5V1FpDBxq96SuLQVBELzPF7DpJ+3VJ6rMn+03g4WIqJtjQeXnrYapNpOqSFcQAlf01Iua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: iACEVgktQF23Wn481t7kcw==
X-CSE-MsgGUID: 3JUVXteEQ6m2j2jHTeQ3Wg==
X-IronPort-AV: E=Sophos;i="6.08,257,1712592000"; 
   d="scan'208";a="88840608"
Date: Sat, 22 Jun 2024 16:31:14 +0800
From: Lingyue <lingyue@xiaomi.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <dianders@chromium.org>,
	<swboyd@chromium.org>, <frederic@kernel.org>, <james.morse@arm.com>,
	<scott@os.amperecomputing.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <huangshaobo3@xiaomi.com>,
	<huangjun7@xiaomi.com>
Subject: Re: [PATCH] arm64: smp: do not allocate CPU IDs to invalid CPU nodes
Message-ID: <ZnaL0q4MbxSdJhAK@xiaomi.com>
References: <20240621075045.249798-1-lingyue@xiaomi.com>
 <ZnVR9sdoqfayKNrI@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnVR9sdoqfayKNrI@J2N7QTR9R3>
X-ClientProxiedBy: BJ-MBX01.mioffice.cn (10.237.8.121) To BJ-MBX13.mioffice.cn
 (10.237.8.133)

On Fri, Jun 21, 2024 at 11:12:06AM +0100, Mark Rutland wrote:
> On Fri, Jun 21, 2024 at 03:50:45PM +0800, Lingyue wrote:
> > Many modules, such as arch topology, rely on num_possible_cpus() to
> > allocate memory and then access the allocated space using CPU IDs.
> > These modules assume that there are no gaps in cpu_possible_mask.
> 
> Is there any documented requirement that cpu_possible_mask has no gaps?
> 
> It looks like other architectures can have gaps in their
> cpu_possible_mask, there's no documented requiremetns AFAICT, and there
> are a bunch of commits handling cpu_possible_mask having gaps, e.g.
> 
>   bc75e99983df1efd ("rcu: Correctly handle sparse possible cpus")
>   3da43104d3187184 ("ARC: Adjust cpuinfo for non-continuous cpu ids")
>   72917235fd5f0863 ("tracing: Fix for non-continuous cpu ids")
> 
> ... so I don't think that the topology code should assume that there are
> no gaps in cpu_possible_mask.
>
Yes, I also don't find any documented requirement about it.

> > However, in of_parse_and_init_cpus(), CPU IDs are still allocated
> > for invalid CPU nodes, leading to gaps in cpu_possible_mask and
> > resulting in out-of-bounds memory access. So it is crucial to avoid
> > allocating CPU IDs to invalid CPU nodes.
> 
> AFAICT the topology code could use 'nr_cpu_ids' instead of
> 'nr_possible_cpus()', like the tracing commit above, or it could use a
> per-cpu allocation to avoid this.
>
In this case, of course we can modify the arch topology code to solve the problem.
However, I propose that if we can ensure there are no gaps in the cpu_possible_mask,
we can solve such misuse issues once and for all, without having to dig and fix other
potential similar problems one by one.

> > This issue can be reproduced easily on QEMU with KASAN enabled, by
> > modifing reg property of a CPU node to 0xFFFFFFFF
> > 
> > [    0.197756] BUG: KASAN: slab-out-of-bounds in topology_normalize_cpu_scale.part.0+0x2cc/0x34c
> > [    0.199518] Read of size 4 at addr ffff000007ebe924 by task swapper/0/1
> > [    0.200087]
> > [    0.200739] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc4 #3
> > [    0.201647] Hardware name: linux,dummy-virt (DT)
> > [    0.203067] Call trace:
> > [    0.203404]  dump_backtrace+0x90/0xe8
> > [    0.203974]  show_stack+0x18/0x24
> > [    0.204424]  dump_stack_lvl+0x78/0x90
> > [    0.205090]  print_report+0x114/0x5cc
> > [    0.205908]  kasan_report+0xa4/0xf0
> > [    0.206488]  __asan_report_load4_noabort+0x20/0x2c
> > [    0.207427]  topology_normalize_cpu_scale.part.0+0x2cc/0x34c
> > [    0.208275]  init_cpu_topology+0x254/0x430
> > [    0.209518]  smp_prepare_cpus+0x20/0x25c
> > [    0.210824]  kernel_init_freeable+0x1dc/0x4fc
> > [    0.212047]  kernel_init+0x24/0x1ec
> > [    0.213143]  ret_from_fork+0x10/0x20
> > 
> > Signed-off-by: Lingyue <lingyue@xiaomi.com>
> > ---
> >  arch/arm64/kernel/smp.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 31c8b3094dd7..5b4178145920 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -638,12 +638,12 @@ static void __init of_parse_and_init_cpus(void)
> >  		u64 hwid = of_get_cpu_hwid(dn, 0);
> >  
> >  		if (hwid & ~MPIDR_HWID_BITMASK)
> > -			goto next;
> > +			continue;
> >  
> >  		if (is_mpidr_duplicate(cpu_count, hwid)) {
> >  			pr_err("%pOF: duplicate cpu reg properties in the DT\n",
> >  				dn);
> > -			goto next;
> > +			continue;
> >  		}
> >  
> >  		/*
> > @@ -656,7 +656,7 @@ static void __init of_parse_and_init_cpus(void)
> >  			if (bootcpu_valid) {
> >  				pr_err("%pOF: duplicate boot cpu reg property in DT\n",
> >  					dn);
> > -				goto next;
> > +				continue;
> >  			}
> >  
> 
> People get very upset when CPU numbering changes, so I'd prefer to avoid
> this if possible.
> 
> Mark.
> 
This modification will only affect CPU ID allocation if there are invalid or
duplicate CPU nodes in device tree. IMO, it is not a typical use case, but
please let me know if there are any other use case.

Many thanks for your response.

Lingyue.

> >  			bootcpu_valid = true;
> > -- 
> > 2.34.1
> > 

