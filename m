Return-Path: <linux-kernel+bounces-187720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC6D8CD724
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723C61C2161F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37466168C7;
	Thu, 23 May 2024 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FRI1bwmt"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430113AF9
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478458; cv=none; b=oE2LStIyLzuTBZ4+cuFBwBoKGFEIpAHYNI/nPHCOz3C6JwsJkeDY6EzAD3RWqfIsFBcxaVl5GHz/OpavbNOECOnHgMEOa5PXvgwT0lM+w8TplTJcUSL37w74RJeJyRs7YisK+qP0BWr9UJ9iHxe6XKGf8SvNG7Yp6bx6pqMEgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478458; c=relaxed/simple;
	bh=IXvAeHORzB9N47O6Gcio6TB3UnH3uZXgM7JC1Q6ZjAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqXO7mAJ3gc2Syd18XyjJWS/5JfFKgHr8GV5v7DsiCWlrdgGqmV9jPU4Pj+Ml4rHQcGUlsjwtKQRUSMj80UrPHmpTlfjCaU96hqySoLJl+2SVdQHcbg+CctGiI/MnLLFg8iiqlFo7/rOfImrmafR6boXWrl66nQBdfCxGzusMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FRI1bwmt; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shakeel.butt@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716478454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIHvhELzd5UhchILcKZOt4tYNK+q26kPzDIOyxA1o+U=;
	b=FRI1bwmtkW4sTlSM6pNJyAhv33dAfkqpZaEmcdX7J5Hgq98BxUlxtIf4uvR8gTtSjvq6ZI
	/80Hp73IEwCcfZZksUGHrZYQ/9VNnNbo7vlU7RJTWi7YlV1zUuPaHKo6Kopn4/prSlXczu
	sCKy15pxcS62iwkjBdUNZnEEHmow8ZU=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: fengwei.yin@intel.com
X-Envelope-To: oliver.sang@intel.com
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 23 May 2024 08:34:09 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com, oliver.sang@intel.com,
	kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: rearrage fields of mem_cgroup_per_node
Message-ID: <Zk9h8YFiYhqEWq1A@P9FQF9L96D.corp.robot.car>
References: <20240523034824.1255719-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523034824.1255719-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, May 22, 2024 at 08:48:24PM -0700, Shakeel Butt wrote:
> Kernel test robot reported [1] performance regression for will-it-scale
> test suite's page_fault2 test case for the commit 70a64b7919cb ("memcg:
> dynamically allocate lruvec_stats"). After inspection it seems like the
> commit has unintentionally introduced false cache sharing.
> 
> After the commit the fields of mem_cgroup_per_node which get read on the
> performance critical path share the cacheline with the fields which
> get updated often on LRU page allocations or deallocations. This has
> caused contention on that cacheline and the workloads which manipulates
> a lot of LRU pages are regressed as reported by the test report.
> 
> The solution is to rearrange the fields of mem_cgroup_per_node such that
> the false sharing is eliminated. Let's move all the read only pointers
> at the start of the struct, followed by memcg-v1 only fields and at the
> end fields which get updated often.
> 
> Experiment setup: Ran fallocate1, fallocate2, page_fault1, page_fault2
> and page_fault3 from the will-it-scale test suite inside a three level
> memcg with /tmp mounted as tmpfs on two different machines, one a single
> numa node and the other one, two node machine.
> 
>  $ ./[testcase]_processes -t $NR_CPUS -s 50
> 
> Results for single node, 52 CPU machine:
> 
> Testcase        base        with-patch
> 
> fallocate1      1031081     1431291  (38.80 %)
> fallocate2      1029993     1421421  (38.00 %)
> page_fault1     2269440     3405788  (50.07 %)
> page_fault2     2375799     3572868  (50.30 %)
> page_fault3     28641143    28673950 ( 0.11 %)
> 
> Results for dual node, 80 CPU machine:
> 
> Testcase        base        with-patch
> 
> fallocate1      2976288     3641185  (22.33 %)
> fallocate2      2979366     3638181  (22.11 %)
> page_fault1     6221790     7748245  (24.53 %)
> page_fault2     6482854     7847698  (21.05 %)
> page_fault3     28804324    28991870 ( 0.65 %)
> 
> Fixes: 70a64b7919cb ("memcg: dynamically allocate lruvec_stats")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202405171353.b56b845-oliver.sang@intel.com
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

