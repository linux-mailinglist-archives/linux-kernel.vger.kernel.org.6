Return-Path: <linux-kernel+bounces-230331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39153917B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4AA6B22EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5B7166310;
	Wed, 26 Jun 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvpsOpwm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83815F41F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391825; cv=none; b=H5NLKBysfVBm0+z2a0wdTh7uo6wXPwQ8WtU/7JbqvIahgYSMOAp8Rwdft1yBJEQAUMGeOZAECLjK1aJ2iJS47kL5xfii3xADM2nabhxpFv/CU+IlrpbUgLHW4h3cf3YgsuKj91j//AAAZR5XUNsRMDu5K87n2k9/vcyqx9qYnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391825; c=relaxed/simple;
	bh=hbgIrvLNG3JVyk+XOg/DvdfZjiWKR0LtGTMHMqm6PJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=egI+D4/mRbvnSpu1gfV0QICLQyiQdncoczGL+28BPSTLS4vk4rCvkzbSaMMjvKAGV0m0HGVAAWFcv5wcK/bAz3Q8SjSnx7ks55R5vUbaihD2mn0cj7b6vHIEeQyDivhBPiryKLu4cwo80LaatSjWluy7hpkWrCtaOrIQotA4yxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvpsOpwm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719391823; x=1750927823;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hbgIrvLNG3JVyk+XOg/DvdfZjiWKR0LtGTMHMqm6PJM=;
  b=IvpsOpwmMQY1dK68wAOOvwaH9JOArx+VzrYJxz1YULSUfFBPONb72Scq
   xTvkSXwLBlO4AoytdfuvZTckYMVXtRsJ2i5xqLFb/rGCRchQ+Stz7wEvq
   TtVKkaHidwnwnbxTnm5g8OvTBYzhR9pQFe46j4bAiyflKkaWyR7HCTB11
   19ys8/20lKAeNYtkPE0l3JIT48ZChhuSQ/iHdeZJN0IYWw1fk/9fCWjNF
   ZnmKM0/DTC3RpTrX6kC3EWk8116AvNH7aHdJwux4ZdKUKcWoPHikB0TYK
   mwdiBagoD/kwWN0iAoI2QfSvv0ji7WOcM50eFLy6cM6A0J5eki4QmXYFI
   Q==;
X-CSE-ConnectionGUID: ktDN+RrPTI6AYwMJUMfgLg==
X-CSE-MsgGUID: q5s7YauoTTSBO8iut8Honw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="33983960"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="33983960"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 01:50:22 -0700
X-CSE-ConnectionGUID: 5HnKgUo+S8Kzqy/b6pxSmQ==
X-CSE-MsgGUID: vNboYoUMT2id2AEudTcF3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44038581"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 01:50:19 -0700
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
Subject: Re: [PATCH] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
In-Reply-To: <20240625132605.38428-1-tursulin@igalia.com> (Tvrtko Ursulin's
	message of "Tue, 25 Jun 2024 14:26:05 +0100")
References: <20240625132605.38428-1-tursulin@igalia.com>
Date: Wed, 26 Jun 2024 16:48:27 +0800
Message-ID: <87r0ckozs4.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> If a task has had MPOL_F_NUMA_BALANCING set it is useful to show that in

IIUC, MPOL_F_NUMA_BALANCING works for VMA area via mbind() too.

> procfs. Teach the mpol_to_str helper about its existance and while at it
> update the comment to account for "weighted interleave" when suggesting
> a recommended buffer size.

Otherwise LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> References: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
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
>  mm/mempolicy.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index aec756ae5637..d147287c4505 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3293,8 +3293,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
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
> @@ -3331,12 +3332,15 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  		p += snprintf(p, buffer + maxlen - p, "=");
>  
>  		/*
> -		 * Currently, the only defined flags are mutually exclusive
> +		 * The below two flags are mutually exclusive:
>  		 */
>  		if (flags & MPOL_F_STATIC_NODES)
>  			p += snprintf(p, buffer + maxlen - p, "static");
>  		else if (flags & MPOL_F_RELATIVE_NODES)
>  			p += snprintf(p, buffer + maxlen - p, "relative");
> +
> +		if (flags & MPOL_F_NUMA_BALANCING)
> +			p += snprintf(p, buffer + maxlen - p, "balancing");
>  	}
>  
>  	if (!nodes_empty(nodes))

