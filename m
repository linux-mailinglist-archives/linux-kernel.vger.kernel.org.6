Return-Path: <linux-kernel+bounces-527198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A9CA40855
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9872019C066B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954920ADCF;
	Sat, 22 Feb 2025 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpLxVcDZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE3BA53
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740227376; cv=none; b=Z9MbcMgCYpMwYS2q7CINd/w+D01RjkVF4mZPoMPtOAxJeffY15Dbad5IXW/9f5LqjAHP/ifl/z8fwNLMObpjxrChEc1rW7cWqDtRkqz6h3L2eq5nbkanfVGE9u8+qdO5vRMZj/D0xs9Lohm/L0iTsQEjiFtI/VelN2dWsrgINXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740227376; c=relaxed/simple;
	bh=SSGSmoHatyl6HQLxw8fOkh4lN56WlcFQLHj1JxpvagQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJz0Dw3ZOajNJHBCJkwJTnG3GlGuflJR+uCkCEoxx3fg/UgoWuxjQeMxRTEVUQij/JdLQlkc7uZIEpLHwrzFF3DDikBwAFKrhB6NPTQL0K+a8JBg0WxJJauisP8M/8zwGjE9+xgjlp/btrhlKFfLenLXc2ZFiIRERbRG63NGjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpLxVcDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ECBC4CED1;
	Sat, 22 Feb 2025 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740227376;
	bh=SSGSmoHatyl6HQLxw8fOkh4lN56WlcFQLHj1JxpvagQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpLxVcDZtSEnc2/4o39uLntPR3zWzkfv7KPT6J9r3JTW6sMirnbLY9YErrscDTsvO
	 DN3LRsX67sK165Sv73Y+EZpsWd0lw/GDgZJLkQh5v5htZLCOJ+7ZCEroexeXPH6nJg
	 BVZRwwaUF2fv8fe8pcIvlwMzdrmPLV6Y9EA9qyX+Kx0qFG0lLePhOqsP1w3VsnY/ce
	 I/tlSOkPc4cneQPTc5hSJdef/SK2ra0n9puV25X+c1MfeloPatxqt1vCg55Oae8WB0
	 HBd0VftTlqM//MsUx80cQUjaHewOBL/bKmj7q5LspuJx1qs+IVUU+ZBIXWytHkhXaU
	 zxO1OHtLq/LXw==
Date: Sat, 22 Feb 2025 13:29:25 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com,
	mhklinux@outlook.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v7 00/12] AMD broadcast TLB invalidation
Message-ID: <Z7nDJQanWxv5cC8d@gmail.com>
References: <20250123042447.2259648-1-riel@surriel.com>
 <93792758-bc88-4d84-bdea-f366988c2d53@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93792758-bc88-4d84-bdea-f366988c2d53@amd.com>


* Manali Shukla <manali.shukla@amd.com> wrote:

> On 1/23/2025 9:53 AM, Rik van Riel wrote:
> > Add support for broadcast TLB invalidation using AMD's INVLPGB instruction.
> > 
> > This allows the kernel to invalidate TLB entries on remote CPUs without
> > needing to send IPIs, without having to wait for remote CPUs to handle
> > those interrupts, and with less interruption to what was running on
> > those CPUs.
> > 
> > Because x86 PCID space is limited, and there are some very large
> > systems out there, broadcast TLB invalidation is only used for
> > processes that are active on 3 or more CPUs, with the threshold
> > being gradually increased the more the PCID space gets exhausted.
> > 
> > Combined with the removal of unnecessary lru_add_drain calls
> > (see https://lkml.org/lkml/2024/12/19/1388) this results in a
> > nice performance boost for the will-it-scale tlb_flush2_threads
> > test on an AMD Milan system with 36 cores:
> > 
> > - vanilla kernel:           527k loops/second
> > - lru_add_drain removal:    731k loops/second
> > - only INVLPGB:             527k loops/second
> > - lru_add_drain + INVLPGB: 1157k loops/second
> > 
> > Profiling with only the INVLPGB changes showed while
> > TLB invalidation went down from 40% of the total CPU
> > time to only around 4% of CPU time, the contention
> > simply moved to the LRU lock.
> > 
> > Fixing both at the same time about doubles the
> > number of iterations per second from this case.
> > 
> > Some numbers closer to real world performance
> > can be found at Phoronix, thanks to Michael:
> > 
> > https://www.phoronix.com/news/AMD-INVLPGB-Linux-Benefits
> > 
> > My current plan is to implement support for Intel's RAR
> > (Remote Action Request) TLB flushing in a follow-up series,
> > after this thing has been merged into -tip. Making things
> > any larger would just be unwieldy for reviewers.
> > 
> > v7:
> >  - a few small code cleanups (Nadav)
> >  - fix spurious VM_WARN_ON_ONCE in mm_global_asid
> >  - code simplifications & better barriers (Peter & Dave)
> > v6:
> >  - fix info->end check in flush_tlb_kernel_range (Michael)
> >  - disable broadcast TLB flushing on 32 bit x86
> > v5:
> >  - use byte assembly for compatibility with older toolchains (Borislav, Michael)
> >  - ensure a panic on an invalid number of extra pages (Dave, Tom)
> >  - add cant_migrate() assertion to tlbsync (Jann)
> >  - a bunch more cleanups (Nadav)
> >  - key TCE enabling off X86_FEATURE_TCE (Andrew)
> >  - fix a race between reclaim and ASID transition (Jann)
> > v4:
> >  - Use only bitmaps to track free global ASIDs (Nadav)
> >  - Improved AMD initialization (Borislav & Tom)
> >  - Various naming and documentation improvements (Peter, Nadav, Tom, Dave)
> >  - Fixes for subtle race conditions (Jann)
> > v3:
> >  - Remove paravirt tlb_remove_table call (thank you Qi Zheng)
> >  - More suggested cleanups and changelog fixes by Peter and Nadav
> > v2:
> >  - Apply suggestions by Peter and Borislav (thank you!)
> >  - Fix bug in arch_tlbbatch_flush, where we need to do both
> >    the TLBSYNC, and flush the CPUs that are in the cpumask.
> >  - Some updates to comments and changelogs based on questions.
> > 
> > 
> 
> I have collected performance data using the will-it-scale
> tlb_flush2_threads benchmark on my AMD Milan, Genoa, and Turin systems.
> 
> As expected, I don't see any discrepancies in the data.
> (Performance Testing is done based on 6.13.0-rc7).
> 
> ------------------------------------------------------------------------------------------------------------------------------------------------
> | ./tlb_flush2_threads -s 5 -t 128 | Milan 1P (NPS1) | Milan 1P (NPS2) | Genoa 1P (NPS1) | Genoa 1P (NPS2) | Turin 2P (NPS1) | Turin 2P (NPS2) |
> ------------------------------------------------------------------------------------------------------------------------------------------------
> | Vanila                           |      357647     |      419631     |     319885      |      311069     |      380559     |      379286     |
> ------------------------------------------------------------------------------------------------------------------------------------------------
> | LRU drain removal                |      784734     |      796056     |     540862      |      530472     |      549168     |      482683     |
> ------------------------------------------------------------------------------------------------------------------------------------------------
> | INVLPGB                          |      581069     |      950848     |     501033      |      553987     |      528660     |      536535     |
> ------------------------------------------------------------------------------------------------------------------------------------------------
> | LRU drain removal + INVLPGB      |     1094941     |     1086826     |     980293      |      979005     |      1228823    |      1238440    |
> ------------------------------------------------------------------------------------------------------------------------------------------------
> | LRU drain vs. Vanila             |      54.42%     |     47.29%      |     40.86%      |      41.36%     |      30.70%     |      21.42%     |
> ------------------------------------------------------------------------------------------------------------------------------------------------
> | INVLPGB vs. Vanila               |      38.45%     |     55.87%      |     55.87%      |      43.85%     |      28.01%     |      29.31%     |
> ------------------------------------------------------------------------------------------------------------------------------------------------
> | (LRU drain + INVLPGB) vs. Vanila |      67.34%     |     61.39%      |     67.37%      |      68.23%     |      69.03%     |      69.37%     |
> ------------------------------------------------------------------------------------------------------------------------------------------------
> 
> Feel free to add:
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>

Great data!

Could we please add all the scalability testing results to patch #9 or 
so, so that it's preserved in the kernel Git history and provides a 
background as to why we want this feature?

Thanks,

	Ingo

