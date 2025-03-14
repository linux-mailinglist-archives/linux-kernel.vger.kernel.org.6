Return-Path: <linux-kernel+bounces-561713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5EDA61523
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7DD3B98DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E01FFC46;
	Fri, 14 Mar 2025 15:38:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE4200105
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966729; cv=none; b=Yv5dy0V0DlhU+ZK8E8kdA09/yuaZOzzckv4c3EGRANtjYj4er1iiiv9RjNoocUaqgMJybcZ7DViZEMg7mtAd+4mqCaglKLyBE0+PQAYCEUocTo2OzGfxleldE/t1hE25eZqnQXEgJhpucOkiLW/d007KDvn65a3Vuj3iejOUszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966729; c=relaxed/simple;
	bh=GTXW4pLBtTu/I1R+dtcOXjzhMUBYaIfqcwnPTzhE9SU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HH8abR8iqWwJHe08174UdVWOEU6aIInPTljv+xAurOYf/1cC/bPlCkSU5E/H8FYyoCiW5ENI0X+X6b7odPLCbU+vKB8UXt+3rlRkZl6y5s4F8qL1curKYZUOHmLvXZSiTJxz2QSQN/JwEyyadhU5u/G8oPGf4fCkrOJMj7I0Z5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDpNN5T8Mz6D91K;
	Fri, 14 Mar 2025 23:35:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 21D9E14039F;
	Fri, 14 Mar 2025 23:38:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 16:38:42 +0100
Date: Fri, 14 Mar 2025 15:38:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Bharata B Rao <bharata@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <dave.hansen@intel.com>,
	<david@redhat.com>, <feng.tang@intel.com>, <gourry@gourry.net>,
	<hannes@cmpxchg.org>, <honggyu.kim@sk.com>, <hughd@google.com>,
	<jhubbard@nvidia.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<raghavendra.kt@amd.com>, <riel@surriel.com>, <rientjes@google.com>,
	<rppt@kernel.org>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>, <yuanchu@google.com>, <hyeonggon.yoo@sk.com>
Subject: Re: [RFC PATCH 3/4] x86: ibs: In-kernel IBS driver for memory
 access profiling
Message-ID: <20250314153841.00006978@huawei.com>
In-Reply-To: <20250306054532.221138-4-bharata@amd.com>
References: <20250306054532.221138-1-bharata@amd.com>
	<20250306054532.221138-4-bharata@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 6 Mar 2025 11:15:31 +0530
Bharata B Rao <bharata@amd.com> wrote:

> Use IBS (Instruction Based Sampling) feature present
> in AMD processors for memory access tracking. The access
> information obtained from IBS via NMI is fed to kpromoted
> daemon for futher action.
> 
> In addition to many other information related to the memory
> access, IBS provides physical (and virtual) address of the access
> and indicates if the access came from slower tier. Only memory
> accesses originating from slower tiers are further acted upon
> by this driver.
> 
> The samples are initially accumulated in percpu buffers which
> are flushed to kpromoted using irq_work.
> 
> About IBS
> ---------
> IBS can be programmed to provide data about instruction
> execution periodically. This is done by programming a desired
> sample count (number of ops) in a control register. When the
> programmed number of ops are dispatched, a micro-op gets tagged,
> various information about the tagged micro-op's execution is
> populated in IBS execution MSRs and an interrupt is raised.
> While IBS provides a lot of data for each sample, for the
> purpose of  memory access profiling, we are interested in
> linear and physical address of the memory access that reached
> DRAM. Recent AMD processors provide further filtering where
> it is possible to limit the sampling to those ops that had
> an L3 miss which greately reduces the non-useful samples.
> 
> While IBS provides capability to sample instruction fetch
> and execution, only IBS execution sampling is used here
> to collect data about memory accesses that occur during
> the instruction execution.
> 
> More information about IBS is available in Sec 13.3 of
> AMD64 Architecture Programmer's Manual, Volume 2:System
> Programming which is present at:
> https://bugzilla.kernel.org/attachment.cgi?id=288923
> 
> Information about MSRs used for programming IBS can be
> found in Sec 2.1.14.4 of PPR Vol 1 for AMD Family 19h
> Model 11h B1 which is currently present at:
> https://www.amd.com/system/files/TechDocs/55901_0.25.zip
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---

Trivial comments inline. I'd love to find a clean way to steal stuff
perf is using though.

>  arch/x86/events/amd/ibs.c        |  11 ++
>  arch/x86/include/asm/ibs.h       |   7 +
>  arch/x86/include/asm/msr-index.h |  16 ++
>  arch/x86/mm/Makefile             |   3 +-
>  arch/x86/mm/ibs.c                | 312 +++++++++++++++++++++++++++++++
>  include/linux/vm_event_item.h    |  17 ++
>  mm/vmstat.c                      |  17 ++
>  7 files changed, 382 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/include/asm/ibs.h
>  create mode 100644 arch/x86/mm/ibs.c
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index e7a8b8758e08..35497e8c0846 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -13,8 +13,10 @@
>  #include <linux/ptrace.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/sched/clock.h>
> +#include <linux/kpromoted.h>
>  
>  #include <asm/apic.h>
> +#include <asm/ibs.h>
>  
>  #include "../perf_event.h"
>  
> @@ -1539,6 +1541,15 @@ static __init int amd_ibs_init(void)
>  {
>  	u32 caps;
>  
> +	/*
> +	 * TODO: Find a clean way to disable perf IBS so that IBS
> +	 * can be used for memory access profiling.

Yeah.  That bit us in a number of similar cases.  Does anyone
have a good solution for this?  For my hammer (CXL HMU) the
perf case is probably the niche one so I'm less worried, but for
SPE, IBS, PEBS etc we need to figure out how to elegantly back off
on promotion if a user wants to use tracing.

> +	 */
> +	if (arch_hw_access_profiling) {
> +		pr_info("IBS isn't available for perf use\n");
> +		return 0;
> +	}
> +
>  	caps = __get_ibs_caps();
>  	if (!caps)
>  		return -ENODEV;	/* ibs not supported by the cpu */


> +
> +static void clear_APIC_ibs(void)
> +{
> +	int offset;
> +
> +	offset = get_ibs_lvt_offset();

Trivial but I'd flip condition and deal with the error
out of line.  Ah I see this is cut and paste from existing
code I'll stop pointing this stuff out!

	if (offset < 0)
		return;

	setup_APIC_eivt();

> +	if (offset >= 0)
> +		setup_APIC_eilvt(offset, 0, APIC_EILVT_MSG_FIX, 1);
> +}

> +
> +static int __init ibs_access_profiling_init(void)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_IBS)) {
> +		pr_info("IBS capability is unavailable for access profiling\n");

Probably worth saying that is because the chip doesn't have it!
This reads to similar to the perf case above where we just pinched it
for other usecases.

> +		return 0;
> +	}
> +
> +	ibs_s = alloc_percpu_gfp(struct ibs_sample_pcpu, __GFP_ZERO);
> +	if (!ibs_s)
> +		return 0;
> +
> +	INIT_WORK(&ibs_work, ibs_work_handler);
> +	init_irq_work(&ibs_irq_work, ibs_irq_handler);
> +
> +	/* Uses IBS Op sampling */
> +	ibs_config = IBS_OP_CNT_CTL | IBS_OP_ENABLE;
> +	ibs_caps = cpuid_eax(IBS_CPUID_FEATURES);
> +	if (ibs_caps & IBS_CAPS_ZEN4)
> +		ibs_config |= IBS_OP_L3MISSONLY;
> +
> +	register_nmi_handler(NMI_LOCAL, ibs_overflow_handler, 0, "ibs");
> +
> +	cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
> +			  "x86/amd/ibs_access_profile:starting",
> +			  x86_amd_ibs_access_profile_startup,
> +			  x86_amd_ibs_access_profile_teardown);
> +
> +	pr_info("IBS setup for memory access profiling\n");
> +	return 0;
> +}
> +
> +arch_initcall(ibs_access_profiling_init);


