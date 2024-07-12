Return-Path: <linux-kernel+bounces-250236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AE992F58D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF9F1F2261E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB93D13D518;
	Fri, 12 Jul 2024 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F85v0U4r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6813D502
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765795; cv=none; b=ACec9zklE1z+mHx4sCZL8+3gjVdi2SjH+xEdmvShRszxw8VnXp5ldKo1Ve1mDHBUIrcMh5YDjEzFL83HLQk2v6Ml/ZFLxYiMzhozY9cj1zR/Qi0dZmT0VMFs/uHNVAxDq6hYpSdq65uQ7gZzwJbzu5zSLzA8CqIPF/VJ4SikgmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765795; c=relaxed/simple;
	bh=mftHE/QeNr6HnahxP6N5M6hsdpF/qFxGbp6B0PMSRsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z7Nnd36dvMsM2DWEaetWZffN4JuSZRf3hGciOg/FyksPo2xRr/Wa8Rv+Ll+ZR+Hic9vaqpSPkXsUcLVKPYY8F6aKb/ODsW121uht4RtVZQzp1qkpmnpPzvvm2hjk7scyCmSOGoLkXl6YRU5xMunh98LZjzcOFYnmZPmc4TM+SBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F85v0U4r; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720765793; x=1752301793;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mftHE/QeNr6HnahxP6N5M6hsdpF/qFxGbp6B0PMSRsE=;
  b=F85v0U4rmrngD65N+UaCBxKbyQMeFIXimjYPDbV/DWiwtKh2Vjqs43/F
   h/KSpwmIVuKAJ91aaI5NLdNNB4bsvRbBWM5fC+JYOe3TOLNWnDbZxuhTP
   UTzGtGOekr6b+SAYjxq9g6Y5Y4B6Kjbgn76m7qSOSc01yJe3v1qIO8yDs
   BRL2CY6i4fHe8E+Q995P9YrRVY3P8vXotMFCd0gssyfuHdbcjddR081fT
   IptHbW086ERONn94o9dVRrFe/tXHj0g7YRB/cYNn8rUxa15OwKZYntRts
   JvjJ8lK/nkZHE0YQXRDutKVaXvRTi0WGdh/wPSCcNYT8o2s7JYqsJ7Jh/
   Q==;
X-CSE-ConnectionGUID: uMu6HtWHSImRbtjLG4GzGA==
X-CSE-MsgGUID: jjuZeLyCTi6A7Po/FOjF+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29343126"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="29343126"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 23:29:53 -0700
X-CSE-ConnectionGUID: mOhgefi9SASqp2u152Obig==
X-CSE-MsgGUID: 9uswyLFpQfWQZuvGnx8xHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="86315535"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 23:29:50 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <zi.yan@sent.com>
Cc: David Hildenbrand <david@redhat.com>,  linux-mm@kvack.org,  Zi Yan
 <ziy@nvidia.com>,  Andrew Morton <akpm@linux-foundation.org>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] memory tiering: introduce folio_has_cpupid() check
In-Reply-To: <20240712024455.163543-3-zi.yan@sent.com> (Zi Yan's message of
	"Thu, 11 Jul 2024 22:44:54 -0400")
References: <20240712024455.163543-1-zi.yan@sent.com>
	<20240712024455.163543-3-zi.yan@sent.com>
Date: Fri, 12 Jul 2024 14:27:59 +0800
Message-ID: <878qy786q8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <zi.yan@sent.com> writes:

> From: Zi Yan <ziy@nvidia.com>
>
> Instead of open coded check for if memory tiering mode is on and a folio
> is in the top tier memory, use a function to encapsulate the check.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM, Thanks!  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in your future versions.

> ---
>  include/linux/memory-tiers.h |  8 ++++++++
>  kernel/sched/fair.c          |  3 +--
>  mm/huge_memory.c             |  6 ++----
>  mm/memory-tiers.c            | 17 +++++++++++++++++
>  mm/memory.c                  |  3 +--
>  mm/mprotect.c                |  3 +--
>  6 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 0dc0cf2863e2..10c127d461c4 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -73,6 +73,10 @@ static inline bool node_is_toptier(int node)
>  }
>  #endif
>  
> +
> +bool folio_has_cpupid(struct folio *folio);
> +
> +
>  #else
>  
>  #define numa_demotion_enabled	false
> @@ -151,5 +155,9 @@ static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
>  static inline void mt_put_memory_types(struct list_head *memory_types)
>  {
>  }
> +static inline bool folio_has_cpupid(struct folio *folio)
> +{
> +	return true;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..03de808cb3cc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1840,8 +1840,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  	 * The pages in slow memory node should be migrated according
>  	 * to hot/cold instead of private/shared.
>  	 */
> -	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> -	    !node_is_toptier(src_nid)) {
> +	if (!folio_has_cpupid(folio)) {
>  		struct pglist_data *pgdat;
>  		unsigned long rate_limit;
>  		unsigned int latency, th, def_th;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 07d9dde4ca33..8c11d6da4b36 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1705,8 +1705,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	 * For memory tiering mode, cpupid of slow memory page is used
>  	 * to record page access time.  So use default value.
>  	 */
> -	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> -	    node_is_toptier(nid))
> +	if (folio_has_cpupid(folio))
>  		last_cpupid = folio_last_cpupid(folio);
>  	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>  	if (target_nid == NUMA_NO_NODE)
> @@ -2059,8 +2058,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		    toptier)
>  			goto unlock;
>  
> -		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> -		    !toptier)
> +		if (!folio_has_cpupid(folio))
>  			folio_xchg_access_time(folio,
>  					       jiffies_to_msecs(jiffies));
>  	}
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 4775b3a3dabe..7f0360d4e3a0 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -6,6 +6,7 @@
>  #include <linux/memory.h>
>  #include <linux/memory-tiers.h>
>  #include <linux/notifier.h>
> +#include <linux/sched/sysctl.h>
>  
>  #include "internal.h"
>  
> @@ -50,6 +51,22 @@ static const struct bus_type memory_tier_subsys = {
>  	.dev_name = "memory_tier",
>  };
>  
> +/**
> + * folio_has_cpupid - check if a folio has cpupid information
> + * @folio: folio to check
> + *
> + * folio's _last_cpupid field is repurposed by memory tiering. In memory
> + * tiering mode, cpupid of slow memory folio (not toptier memory) is used to
> + * record page access time.
> + *
> + * Return: the folio _last_cpupid is used as cpupid
> + */
> +bool folio_has_cpupid(struct folio *folio)
> +{
> +	return !(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> +	       node_is_toptier(folio_nid(folio));
> +}
> +
>  #ifdef CONFIG_MIGRATION
>  static int top_tier_adistance;
>  /*
> diff --git a/mm/memory.c b/mm/memory.c
> index dceb62f3fa34..96c2f5b3d796 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5344,8 +5344,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	 * For memory tiering mode, cpupid of slow memory page is used
>  	 * to record page access time.  So use default value.
>  	 */
> -	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
> -	    !node_is_toptier(nid))
> +	if (!folio_has_cpupid(folio))
>  		last_cpupid = (-1 & LAST_CPUPID_MASK);
>  	else
>  		last_cpupid = folio_last_cpupid(folio);
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 222ab434da54..787c3c2bf1b6 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -161,8 +161,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>  				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
>  				    toptier)
>  					continue;
> -				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> -				    !toptier)
> +				if (!folio_has_cpupid(folio))
>  					folio_xchg_access_time(folio,
>  						jiffies_to_msecs(jiffies));
>  			}

