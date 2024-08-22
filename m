Return-Path: <linux-kernel+bounces-296957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB2495B124
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485591F22CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C02D15C156;
	Thu, 22 Aug 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LGKcCJpU"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F54157467
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317266; cv=none; b=OZPe0o8O7V1KfMHN5dv3RhhwyAf8MX4XBJvRE7ohSLgDI7pYXJySwGkMzvoEHaek8ugNPHNiqFew3AU69LrBJR6Mglgc9viO+Z70HRknja0taxA3+sapNuAbg7P+t9AaT/XT4CcxnSNsniPautCbD4a1KEgt8g16AEy4NxpQlB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317266; c=relaxed/simple;
	bh=dYSZHrB15aNs4HD3tmdPRvXvYZEy4vdoQ7Y8f5ur/uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhQAaXEmKa7WugfpPCtYMh1iwdZ/TIAsHARkyzrQnaL/+M08H2XS1tMHccr4vDcm2SlShcTKuqCchq4CHuFDuEXc/Ypy9SYBvMaK2UNIU4IOypP3RTWOjpv3z1RYeGEOj/0HhOW8h31rFATx3Nh1e6NUbwP65IwEI41e7C7R7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LGKcCJpU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bed83487aeso688654a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724317260; x=1724922060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uE7q2R79ra943CHmNIYAz4Se/oF9orTNMf7om9x/0w8=;
        b=LGKcCJpUUbogK2mrehfj0+++zgj5h9woFh16kXRu+dxcImt6HbbTqg/bibb+8OLM76
         tJZRWtmJXOmWW7q+eQTtY2dGSgxsPBE1ECEUz2a0TFFcvQVB7uSJg3gzITVV2sgVn9qy
         VUVtxegLe6zp5JZGwcWMisZEH9QnJIi+2Nf1iKvSW238vwcx4nmnjCd/ualQDnuv7PJR
         KUA9a/BcBhz3S+HLowrLjsMKXaVrSilfF5NhPcdTpp2gOkO2CWOdhh7kLjceo6hFuNgV
         D1L3uO7YxSBo+P0JWMMakLgPEgr8msPlH28TqR15WpmukSSFv0jURI7ibT1dlqYhhd/+
         YGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724317260; x=1724922060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE7q2R79ra943CHmNIYAz4Se/oF9orTNMf7om9x/0w8=;
        b=ICtiMkQOSSWp/6MDre8UFv01VnFBHLZjk4beM9lVCb/gfjwJYbcY0ymoP1Ae5TdknX
         UkTQsddMwbVARP4NHF5Gk5Cvfewb7V2DSoWOcVppdeNgJx+UFauZu3nvjd+iR7TQTN/i
         AFNDd8mQd7mM8o7MimO0FlhJoF+Bf6wPVf+/pllgJKT+POYZGLR/dHWazHBmCp3TgLB0
         nQo3X2rsQdUGUKa0CvVv5yDCBf4U55AhtG6fDYNcIpX9NNMKnCeEWr/lmm4IphOU/EiI
         xDNkcES2iPro4Po9XycHUeiVIeblooQ4CksjLT/6faTV8cwYNyKftjQ01lfd+5wF9YMb
         u/vw==
X-Forwarded-Encrypted: i=1; AJvYcCX4gc+hgziZs9DfNQFu2zhNIijHhJVsByJtXYDNU1Tjz+PsjmWXQ3W6EdV/K5uiIheUx9WIl+cRoxUtD9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjtTbDaet7lE9sARAUOw7uGuD9WQJ0o1wRMBILDpAz2uasNUzD
	ce/ZQfNML8JCUXdTVPtw20WpaAMIfVSKes8KuQ+LNtPKZm7GA+4i+GE5AyvUHKA=
X-Google-Smtp-Source: AGHT+IFRHcWUO3cIfl5f6DBKBpDvlWiZOWF7yzXIw1+52agalZunwjd6e1IbdV4DxmmtLRMKBbuxQA==
X-Received: by 2002:a05:6402:5251:b0:5be:fd3a:558 with SMTP id 4fb4d7f45d1cf-5bf1f0d7cd9mr3866329a12.9.1724317259593;
        Thu, 22 Aug 2024 02:00:59 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddc0fcsm647618a12.5.2024.08.22.02.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:00:59 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:00:58 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net,
	hannes@cmpxchg.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Subject: Re: [PATCH V1] mm:page_alloc: fix the NULL ac->nodemask in
 __alloc_pages_slowpath()
Message-ID: <Zsb-SplgW_JizWdE@tiehlicka>
References: <20240822083842.3167137-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822083842.3167137-1-hezhongkun.hzk@bytedance.com>

On Thu 22-08-24 16:38:42, Zhongkun He wrote:
> I found a problem in my test machine that should_reclaim_retry() do
> not get the right node if i set the cpuset.mems.
> The should_reclaim_retry() and try_to_compact_pages() are iterating
> nodes which are not allowed by cpusets and that makes the retry loop
> happening more than unnecessary.

I would update the problem description because from the above it is not
really clear what the actual problem is.

should_reclaim_retry is not ALLOC_CPUSET aware and that means that it
considers reclaimability of NUMA nodes which are outside of the cpuset.
If other nodes have a lot of reclaimable memory then should_reclaim_retry
would instruct page allocator to retry even though there is no memory
reclaimable on the cpuset nodemask. This is not really a huge problem
because the number of retries without any reclaim progress is bound but
it could be certainly improved. This is a cold path so this shouldn't
really have a measurable impact on performance on most workloads.

> 
> 1.Test step and the machines.
> ------------
> root@vm:/sys/fs/cgroup/test# numactl -H | grep size
> node 0 size: 9477 MB
> node 1 size: 10079 MB
> node 2 size: 10079 MB
> node 3 size: 10078 MB
> 
> root@vm:/sys/fs/cgroup/test# cat cpuset.mems
>     2
> 
> root@vm:/sys/fs/cgroup/test# stress --vm 1 --vm-bytes 12g  --vm-keep
> stress: info: [33430] dispatching hogs: 0 cpu, 0 io, 1 vm, 0 hdd
> stress: FAIL: [33430] (425) <-- worker 33431 got signal 9
> stress: WARN: [33430] (427) now reaping child worker processes
> stress: FAIL: [33430] (461) failed run completed in 2s
> 
> 2. reclaim_retry_zone info:
> 
> We can only alloc pages from node=2, but the reclaim_retry_zone is
> node=0 and return true.
> 
> root@vm:/sys/kernel/debug/tracing# cat trace
> stress-33431   [001] ..... 13223.617311: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=1 wmark_check=1
> stress-33431   [001] ..... 13223.617682: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=2 wmark_check=1
> stress-33431   [001] ..... 13223.618103: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=3 wmark_check=1
> stress-33431   [001] ..... 13223.618454: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=4 wmark_check=1
> stress-33431   [001] ..... 13223.618770: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=5 wmark_check=1
> stress-33431   [001] ..... 13223.619150: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=6 wmark_check=1
> stress-33431   [001] ..... 13223.619510: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=7 wmark_check=1
> stress-33431   [001] ..... 13223.619850: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=8 wmark_check=1
> stress-33431   [001] ..... 13223.620171: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=9 wmark_check=1
> stress-33431   [001] ..... 13223.620533: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=10 wmark_check=1
> stress-33431   [001] ..... 13223.620894: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=11 wmark_check=1
> stress-33431   [001] ..... 13223.621224: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=12 wmark_check=1
> stress-33431   [001] ..... 13223.621551: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=13 wmark_check=1
> stress-33431   [001] ..... 13223.621847: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=14 wmark_check=1
> stress-33431   [001] ..... 13223.622200: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=15 wmark_check=1
> stress-33431   [001] ..... 13223.622580: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=16 wmark_check=1
> 

You can drop the following

> 3. Root cause:
> Nodemask usually comes from mempolicy in policy_nodemask(), which
> is always NULL unless the memory policy is bind or prefer_many.
> 
> nodemask = NULL
> __alloc_pages_noprof()
> 	prepare_alloc_pages
> 		ac->nodemask = &cpuset_current_mems_allowed;
> 
> 	get_page_from_freelist()
> 
> 	ac.nodemask = nodemask;  /*set  NULL*/
> 
> 	__alloc_pages_slowpath() {
> 		f (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
> 			ac->nodemask = NULL;
> 			ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
> 					ac->highest_zoneidx, ac->nodemask);
> 
> 		/* so ac.nodemask = NULL */
> 	}
> 
> According to the function flow above, we do not have the memory limit to
> follow cpuset.mems, so we need to add it.
> 
> Test result:
> Try 3 times with different cpuset.mems and alloc large memorys than that numa size.
> echo 1 > cpuset.mems
> stress --vm 1 --vm-bytes 12g --vm-hang 0
> ---------------
> echo 2 > cpuset.mems
> stress --vm 1 --vm-bytes 12g --vm-hang 0
> ---------------
> echo 3 > cpuset.mems
> stress --vm 1 --vm-bytes 12g --vm-hang 0
> 
> The retry trace look like:
> stress-2139    [003] .....   666.934104: reclaim_retry_zone: node=1 zone=Normal   order=0 reclaimable=7 available=7355 min_wmark=8598 no_progress_loops=1 wmark_check=0
> stress-2204    [010] .....   695.447393: reclaim_retry_zone: node=2 zone=Normal   order=0 reclaimable=2 available=6916 min_wmark=8598 no_progress_loops=1 wmark_check=0
> stress-2271    [008] .....   725.683058: reclaim_retry_zone: node=3 zone=Normal   order=0 reclaimable=17 available=8079 min_wmark=8597 no_progress_loops=1 wmark_check=0
> 

And only keep this

> With this patch, we can check the right node and get less retry in __alloc_pages_slowpath()
> because there is nothing to do.
> 
> V1:
> Do the same with the page allocator using __cpuset_zone_allowed().
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>

With those changes you can add
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/compaction.c | 6 ++++++
>  mm/page_alloc.c | 5 +++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index d1041fbce679..a2b16b08cbbf 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -23,6 +23,7 @@
>  #include <linux/freezer.h>
>  #include <linux/page_owner.h>
>  #include <linux/psi.h>
> +#include <linux/cpuset.h>
>  #include "internal.h"
>  
>  #ifdef CONFIG_COMPACTION
> @@ -2822,6 +2823,11 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
>  					ac->highest_zoneidx, ac->nodemask) {
>  		enum compact_result status;
>  
> +		if (cpusets_enabled() &&
> +			(alloc_flags & ALLOC_CPUSET) &&
> +			!__cpuset_zone_allowed(zone, gfp_mask))
> +				continue;
> +
>  		if (prio > MIN_COMPACT_PRIORITY
>  					&& compaction_deferred(zone, order)) {
>  			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 29608ca294cf..8a67d760b71a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4128,6 +4128,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  		unsigned long min_wmark = min_wmark_pages(zone);
>  		bool wmark;
>  
> +		if (cpusets_enabled() &&
> +			(alloc_flags & ALLOC_CPUSET) &&
> +			!__cpuset_zone_allowed(zone, gfp_mask))
> +				continue;
> +
>  		available = reclaimable = zone_reclaimable_pages(zone);
>  		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
>  
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs

