Return-Path: <linux-kernel+bounces-444115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE719F0106
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547C116A523
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57E13B791;
	Fri, 13 Dec 2024 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3QuXXO+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6117E016
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050018; cv=none; b=pPWB1l2LdV0LoXBgPga035EK7ILeLwK1TrcLxIxJGqJOb2jIKMeRe0CO8lyVYNzQmejEDHJnXGi5puUOl6Mz5LvrwZBzpBGrx7x4Nd7L2eN0hm69XmFBP6o84p4z1CSdJy8lqB4OpgqkVi6a26eUAPdcNjEP72BJmbi0tyJKjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050018; c=relaxed/simple;
	bh=CKQ9UtJbeKP2k21wj9w6h+RqOSyDB5fSOU0DdLL11Zk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=raIMfSVwErk7Hl2N9iFkMhrfr2PiaFMoasgBn/60gFGRcim5i6nB0qPh2AE4tR06RO3nCsDa1OHLUqeUu4ai8NnvgYOcz6USqvukgMTsFniYddboWIYE6dS0100rRvb3G/2W51D5bAPWtWHRhO/lKPuglV8/y04TQ8v/x53dVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3QuXXO+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734050016; x=1765586016;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CKQ9UtJbeKP2k21wj9w6h+RqOSyDB5fSOU0DdLL11Zk=;
  b=T3QuXXO+rYKI/TjbCveb2T6XghfF+6j8Zjwx2GMWX0IxTDi5WG2iLeY7
   /s9+CvQXmFCsRKnWFWZW+3tNOocfjjVKfeTjTeox5ufbFe8uIBq5AzN75
   mWrwuM/alRiFSZU094dDWmo/BXQod1/SyDEoydm13oG4eofsuyv7qmwew
   eMS9FGp2KR8Qz/Nox8O8n6RgexuUrYljkgDnCDvcwZE8ooEp+d+uQMlcO
   Ogdy5myw0ib9ZmKjMeKDmqt9IjlKrxcUUMsrRJ2OCN1vG29slRNz9YbJs
   BFH6cElWovf63l2yGMnJv3DW1B3BsixsVus67LuuyuwCNNvobl6XlT1tf
   Q==;
X-CSE-ConnectionGUID: rSe8rzAFQqqnbGbfk3TR2w==
X-CSE-MsgGUID: cqaulDIMTpqayQGpvQzJ+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45878238"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45878238"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 16:33:35 -0800
X-CSE-ConnectionGUID: +/9xOB+sRlaY5razTN5/CQ==
X-CSE-MsgGUID: qAf7YtNTQduHq4SG+fcnrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119635778"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO [10.125.110.139]) ([10.125.110.139])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 16:33:34 -0800
Message-ID: <ddc249fc658b394f39b23e3ff0fa7dcbf2060695.camel@linux.intel.com>
Subject: Re: [PATCH 0/8] x86, sched: Dynamic ITMT core ranking support and
 some yak shaving
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>,  Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Mario Limonciello
 <mario.limonciello@amd.com>,  Meng Li <li.meng@amd.com>, Huang Rui
 <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Thu, 12 Dec 2024 16:33:33 -0800
In-Reply-To: <20241211185552.4553-1-kprateek.nayak@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 18:55 +0000, K Prateek Nayak wrote:
> The ITMT infrastructure currently assumes ITMT rankings to be static and
> is set correctly prior to enabling ITMT support which allows the CPU
> with the highest core ranking to be cached as the "asym_prefer_cpu" in
> the sched_group struct. However, with the introduction of Preferred Core
> support in amd-pstate, these rankings can change at runtime.
>=20
> This series adds support for dynamic ranking in generic scheduler layer
> without the need to rebuild the sched domain hierarchy and fixes an
> issue with x86_die_flags() on AMD systems that support Preferred Core
> ranking with some yak shaving done along the way.
>=20
> Patch 1 to 4 are independent cleanup around ITMT infrastructure, removal
> of x86_smt_flags wrapper, and moving the "sched_itmt_enabled" sysctl to
> debugfs.
>=20
> Patch 5 adds the SD_ASYM_PACKING flag to the PKG domain on all ITMT
> enabled systems. The rationale behind the addition is elaborates in the
> same. One open question remains is for Intel processors with multiple
> Tiles in a PKG which advertises itself as multiple LLCs in a PKG and
> supports ITMT - is it okay to set SD_ASYM_PACKING for PKG domain on
> these processors?

After talking to my colleagues Ricardo and Srinivas, we think that this
should be fine for Intel CPUs.

Tim

>=20
> Patch 6 and 7 are independent possible micro-optimizations discovered
> when auditing update_sg_lb_stats()
>=20
> Patch 8 uncaches the asym_prefer_cpu from the sched_group struct and
> finds it during load balancing in update_sg_lb_stats() before it is used
> to make any scheduling decisions. This is the simplest approach; an
> alternate approach would be to move the asym_prefer_cpu to
> sched_domain_shared and allow the first load balancing instance post a
> priority change to update the cached asym_prefer_cpu. On systems with
> static priorities, this would allow benefits of caching while on systems
> with dynamic priorities, it'll reduce the overhead of finding
> "asym_prefer_cpu" each time update_sg_lb_stats() is called however the
> benefits come with added code complexity which is why Patch 8 is marked
> as an RFC.
>=20
> This series is based on
>=20
>   git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core=20
>=20
> at commit 2a77e4be12cb ("sched/fair: Untangle NEXT_BUDDY and
> pick_next_task()") and is a spiritual successor to a previous attempt
> at fixing the x86_die_flags() on Preferred Core enabled system by Mario
> that can be found at
> https://lore.kernel.org/lkml/20241203201129.31957-1-mario.limonciello@amd=
.com/
>=20
> ---
> K Prateek Nayak (8):
>   x86/itmt: Convert "sysctl_sched_itmt_enabled" to boolean
>   x86/itmt: Use guard() for itmt_update_mutex
>   x86/itmt: Move the "sched_itmt_enabled" sysctl to debugfs
>   x86/topology: Remove x86_smt_flags and use cpu_smt_flags directly
>   x86/topology: Use x86_sched_itmt_flags for PKG domain unconditionally
>   sched/fair: Do not compute NUMA Balancing stats unnecessarily during
>     lb
>   sched/fair: Do not compute overloaded status unnecessarily during lb
>   sched/fair: Uncache asym_prefer_cpu and find it during
>     update_sd_lb_stats()
>=20
>  arch/x86/include/asm/topology.h |  4 +-
>  arch/x86/kernel/itmt.c          | 81 ++++++++++++++-------------------
>  arch/x86/kernel/smpboot.c       | 19 +-------
>  kernel/sched/fair.c             | 41 +++++++++++++----
>  kernel/sched/sched.h            |  1 -
>  kernel/sched/topology.c         | 15 +-----
>  6 files changed, 69 insertions(+), 92 deletions(-)
>=20
>=20
> base-commit: 2a77e4be12cb58bbf774e7c717c8bb80e128b7a4


