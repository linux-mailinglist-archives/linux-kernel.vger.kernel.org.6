Return-Path: <linux-kernel+bounces-238897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A89252F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515D91F2233C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC74383B1;
	Wed,  3 Jul 2024 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmKLrNxz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F5621
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 05:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984643; cv=none; b=UXn+xC8+xTU3cX9sa2OhOgeg7J31DzriuVuKIti3avKyMDtKaFecOeBkbHiuKb3q5bvLR9YlcmxBJ6a9eQeV2hp1E7mW9xYXeFSsBWPAT5vdju8H3nZMTQ4ZKLGAE08LqJO8uivLxDVgaS8+TuIvThAqrNRyAgcSU8bBQazryTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984643; c=relaxed/simple;
	bh=Oe7dtG7Wch4wib4uF9zEAYhSwiJWyadvkQnsTHejGow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W1YX59SGalg8rUbfXNqqMj9easxCcWNQtbMJWVN/swGPyes9CRnA/0fTYorfNNsgo5DgBSTqi6QjDXFq4evp99iV75iMTpQYjF59J/bOqqd5sx4ThI8qojq2OVYfQ89JODRlH2OAcwjEIKtJ50IX4Q38XzRokintMfCe0XSDOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmKLrNxz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719984638; x=1751520638;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Oe7dtG7Wch4wib4uF9zEAYhSwiJWyadvkQnsTHejGow=;
  b=RmKLrNxzwmJQJa4mqaDp1fnFGpqfyJSQYJTUhGjWRC+SnpMflns9/0LD
   CvmtZmWix2hAm9k+YCJ3wTnz1gLVzxbPiexuQLGtJ+Y/fD4+LnmsHvP+K
   9nDDQOk2M/1tojuWbNIu8Jt8Ke0rl3ziT+OXowIAOPDgCt2XgoSLgTrXr
   Fpz+zMlWaDAYa/3Fp1HlVbfnauDQGay+3pXsJSfeiXYJw1d0F+kBVB/UB
   LhyqFbX6M0g2FCj1h8vr/Ty72zObS8wfw15frXX6V79aXwLEC75HeckQu
   CE6+3a8vqm9ljyIIxTxEdMtbaep6cia0h+l5QvzVY3fQBGOJBBJYrPOBu
   A==;
X-CSE-ConnectionGUID: UbGQsd7BRIeINamA+CZ+ow==
X-CSE-MsgGUID: WJE+I4jwRu+PhgWZQPiIEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28586547"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28586547"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:30:37 -0700
X-CSE-ConnectionGUID: zd83bQHSTBCjC+l7UrE8Pg==
X-CSE-MsgGUID: 4hxORyeRTSCRLYu9LeC6EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46112632"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:30:33 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kernel-dev@igalia.com,  Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,  Mel
 Gorman <mgorman@suse.de>,  Peter Zijlstra <peterz@infradead.org>,  Ingo
 Molnar <mingo@redhat.com>,  Rik van Riel <riel@surriel.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Dave Hansen <dave.hansen@intel.com>,  Andi Kleen
 <ak@linux.intel.com>,  Michal Hocko <mhocko@suse.com>,  David Rientjes
 <rientjes@google.com>
Subject: Re: [PATCH v2] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
In-Reply-To: <20240702150006.35206-1-tursulin@igalia.com> (Tvrtko Ursulin's
	message of "Tue, 2 Jul 2024 16:00:06 +0100")
References: <20240702150006.35206-1-tursulin@igalia.com>
Date: Wed, 03 Jul 2024 13:28:42 +0800
Message-ID: <87o77fkprp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Tvrtko Ursulin <tursulin@igalia.com> writes:

> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Since balancing mode was added in
> bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes"),
> it was possible to set this mode but it wouldn't be shown in
> /proc/<pid>/numa_maps since there was no support for it in the
> mpol_to_str() helper.
>
> Furthermore, because the balancing mode sets the MPOL_F_MORON flag, it
> would be displayed as 'default' due a workaround introduced a few years
> earlier in
> 8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps").
>
> To tidy this up we implement two changes:
>
> First we introduce a new internal flag MPOL_F_KERNEL and with it mark the
> kernel's internal default and fallback policies (for tasks and/or VMAs
> with no explicit policy set). By doing this we generalise the current
> special casing and replace the incorrect 'default' with the correct
> 'bind'.
>
> Secondly, we add a string representation and corresponding handling for
> MPOL_F_NUMA_BALANCING. We do this by adding a sparse mapping array of
> flags to names. With the sparseness being the downside, but with the
> advantage of generalising and removing the "policy" from flags display.

Please split these 2 changes into 2 patches.  Because we will need to
back port the first one to -stable kernel.

> End result:
>
> $ numactl -b -m 0-1,3 cat /proc/self/numa_maps
> 555559580000 bind=balancing:0-1,3 file=/usr/bin/cat mapped=3 active=0 N0=3 kernelpagesize_kB=16
> ...
>
> v2:
>  * Fully fix by introducing MPOL_F_KERNEL.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
> References: 8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps")
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> ---
>  include/uapi/linux/mempolicy.h |  1 +
>  mm/mempolicy.c                 | 44 ++++++++++++++++++++++++----------
>  2 files changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index 1f9bb10d1a47..bcf56ce9603b 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -64,6 +64,7 @@ enum {
>  #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
>  #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
>  #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
> +#define MPOL_F_KERNEL   (1 << 5) /* Kernel's internal policy */
>  
>  /*
>   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index aec756ae5637..8ecc6d9f100a 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -134,6 +134,7 @@ enum zone_type policy_zone = 0;
>  static struct mempolicy default_policy = {
>  	.refcnt = ATOMIC_INIT(1), /* never free it */
>  	.mode = MPOL_LOCAL,
> +	.flags = MPOL_F_KERNEL,
>  };
>  
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
> @@ -3095,7 +3096,7 @@ void __init numa_policy_init(void)
>  		preferred_node_policy[nid] = (struct mempolicy) {
>  			.refcnt = ATOMIC_INIT(1),
>  			.mode = MPOL_PREFERRED,
> -			.flags = MPOL_F_MOF | MPOL_F_MORON,
> +			.flags = MPOL_F_MOF | MPOL_F_MORON | MPOL_F_KERNEL,
>  			.nodes = nodemask_of_node(nid),
>  		};
>  	}
> @@ -3150,6 +3151,12 @@ static const char * const policy_modes[] =
>  	[MPOL_PREFERRED_MANY]  = "prefer (many)",
>  };
>  
> +static const char * const policy_flags[] = {
> +	[ilog2(MPOL_F_STATIC_NODES)] = "static",
> +	[ilog2(MPOL_F_RELATIVE_NODES)] = "relative",
> +	[ilog2(MPOL_F_NUMA_BALANCING)] = "balancing",
> +};
> +
>  #ifdef CONFIG_TMPFS
>  /**
>   * mpol_parse_str - parse string to mempolicy, for tmpfs mpol mount option.
> @@ -3293,17 +3300,18 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
>   * @pol:  pointer to mempolicy to be formatted
>   *
>   * Convert @pol into a string.  If @buffer is too short, truncate the string.
> - * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
> - * longest flag, "relative", and to display at least a few node ids.
> + * Recommend a @maxlen of at least 42 for the longest mode, "weighted
> + * interleave", the longest flag, "balancing", and to display at least a few
> + * node ids.
>   */
>  void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  {
>  	char *p = buffer;
>  	nodemask_t nodes = NODE_MASK_NONE;
>  	unsigned short mode = MPOL_DEFAULT;
> -	unsigned short flags = 0;
> +	unsigned long flags = 0;
>  
> -	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MORON)) {
> +	if (!(pol->flags & MPOL_F_KERNEL)) {

Can we avoid to introduce a new flag?  Whether the following code work?

        if (pol && pol != &default_policy && !(pol->mode !=
            MPOL_PREFERRED) && !(pol->flags & MPOL_F_MORON))

But I think that this is kind of fragile.  A flag is better.  But
personally, I don't think MPOL_F_KERNEL is a good name, maybe
MPOL_F_DEFAULT?

>  		mode = pol->mode;
>  		flags = pol->flags;
>  	}
> @@ -3328,15 +3336,25 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  	p += snprintf(p, maxlen, "%s", policy_modes[mode]);
>  
>  	if (flags & MPOL_MODE_FLAGS) {
> -		p += snprintf(p, buffer + maxlen - p, "=");
> +		unsigned int bit, cnt = 0;
>  
> -		/*
> -		 * Currently, the only defined flags are mutually exclusive
> -		 */
> -		if (flags & MPOL_F_STATIC_NODES)
> -			p += snprintf(p, buffer + maxlen - p, "static");
> -		else if (flags & MPOL_F_RELATIVE_NODES)
> -			p += snprintf(p, buffer + maxlen - p, "relative");
> +		for_each_set_bit(bit, &flags, ARRAY_SIZE(policy_flags)) {
> +			if (bit <= ilog2(MPOL_F_KERNEL))
> +				continue;
> +
> +			if (cnt == 0)
> +				p += snprintf(p, buffer + maxlen - p, "=");
> +			else
> +				p += snprintf(p, buffer + maxlen - p, ",");
> +
> +			if (WARN_ON_ONCE(!policy_flags[bit]))
> +				p += snprintf(p, buffer + maxlen - p, "bit%u",
> +					      bit);
> +			else
> +				p += snprintf(p, buffer + maxlen - p,
> +					      policy_flags[bit]);
> +			cnt++;
> +		}

Please refer to commit 2291990ab36b ("mempolicy: clean-up mpol-to-str()
mempolicy formatting") for the original format.

>  	}
>  
>  	if (!nodes_empty(nodes))

--
Best Regards,
Huang, Ying

