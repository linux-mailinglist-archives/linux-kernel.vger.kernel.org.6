Return-Path: <linux-kernel+bounces-426751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAEF9DF748
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 23:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E04281774
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DECA1D90B6;
	Sun,  1 Dec 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2GrDAQA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED21D86F1
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733092358; cv=none; b=WMESBa/KNRzNDGcskVv5UGJ+XVQMlRp6v6JBB15WSp6u5j4xciO3FgXKgD0dJzFJHJkM2nN5Po1tq1lIZaF/DhP4/QxtF7M3+a0Ik021HMep8LNKFqbnRWunrFYHbRI3RmEGzS7oYRj1KL7HpL+9yWnuhQbueyZQNptecdO+fkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733092358; c=relaxed/simple;
	bh=I+2uCJdx7tOqPWPR+lcT/i2MyevZPIgQHllL6FkysVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KA9N4DRLauA2LI1sD+zR35VwiBt9g6l1WjTq4GpQTou1p1h0uy5dhLbwrsJHslq69DiDEOo7JeZ5SjB4IzPh0V4odS2I1G7QbHER76sdtXbVy3GmzB9kobHqjZec69Qw58TrlyZqabzHfr4WJhM+2UtWRlOi6I2WO900prla+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2GrDAQA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733092357; x=1764628357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I+2uCJdx7tOqPWPR+lcT/i2MyevZPIgQHllL6FkysVc=;
  b=L2GrDAQAAOm+sC/44T5OFni5yb5rjAgV1fdIMBP55N9OTsxqR6ahAXUl
   ylk2n9Ol5edgMiYYBHvvRRi193zkW8ZaOUVJRSFtPviKuCgkkiEjFCfft
   iTBfVh7m6Lj1T5WrgX7kuTnbj+ONbrHX3W3cAvuHPDXTMSFqtScMZ8Z04
   ni8B1IWl4xdZyFnMb6s9mx+GI7X9C8AbuhtY6sroXRI+ayf3rJF7WIuQN
   4VLTXRJCqJrf4fBFH9++4HjzKOr0oWdqno3kaw6qDPAKSTCwPHijSZeJW
   pM/6M3eP1qHkseJCcNB191t/bzlW75eC75uuNmi+j5TNizieJdyB6KPhP
   A==;
X-CSE-ConnectionGUID: vcwvCUmvRhiH0wFFGD3bkg==
X-CSE-MsgGUID: 503ZFPY7StukoJRh/Ds5gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="33399934"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="33399934"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 14:32:36 -0800
X-CSE-ConnectionGUID: ScfAQ3TsRYuuu22mKszPPA==
X-CSE-MsgGUID: 9PdYWVWiRkmPT202Acq+sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="97712712"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 14:32:36 -0800
Date: Sun, 1 Dec 2024 14:39:21 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Radu Rendec <rrendec@redhat.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20241201223920.GA32487@ranerica-svr.sc.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
 <de1201930a55aa3b13f413b9bee986d85e2b4283.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de1201930a55aa3b13f413b9bee986d85e2b4283.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Nov 29, 2024 at 11:12:52AM -0500, Radu Rendec wrote:
> On Wed, 2024-11-27 at 16:22 -0800, Ricardo Neri wrote:
> > Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> > adds functionality that architectures can use to optionally allocate and
> > build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> > arch specific early level initializer") lets secondary CPUs correct (and
> > reallocate memory) cacheinfo data if needed.
> > 
> > If the early build functionality is not used and cacheinfo does not need
> > correction, memory for cacheinfo is never allocated. x86 does not use the
> > early build functionality. Consequently, during the cacheinfo CPU hotplug
> > callback, last_level_cache_is_valid() attempts to dereference a NULL
> > pointer:
> > 
> >      BUG: kernel NULL pointer dereference, address: 0000000000000100
> >      #PF: supervisor read access in kernel mode
> >      #PF: error_code(0x0000) - not present page
> >      PGD 0 P4D 0
> >      Oops: 0000 [#1] PREEPMT SMP NOPTI
> >      CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
> >      RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> > 
> > Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> > not done earlier.
> > 
> > Moreover, before determining the validity of the last-level cache info,
> > ensure that it has been allocated. Simply checking for non-zero
> > cache_leaves() is not sufficient, as some architectures (e.g., Intel
> > processors) have non-zero cache_leaves() before allocation.
> > 
> > Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
> > This function iterates over all online CPUs. However, a CPU may have come
> > online recently, but its cacheinfo may not have been allocated yet.
> > 
> > While here, remove an unnecessary indentation in allocate_cache_info().
> > 
> > Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
> > Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> > Reviewed-by: Radu Rendec <rrendec@redhat.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Tested-by: Andreas Herrmann <aherrmann@suse.de>
> > Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Cc: Andreas Herrmann <aherrmann@suse.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Chen Yu <yu.c.chen@intel.com>
> > Cc: Huang Ying <ying.huang@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Nikolay Borisov <nik.borisov@suse.com>
> > Cc: Radu Rendec <rrendec@redhat.com>
> > Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> > Cc: Pu Wen <puwen@hygon.cn>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: stable@vger.kernel.org # 6.3+
> > ---
> > Change since v7:
> >  * None
> > 
> > Changes since v6:
> >  * Merged patches 1 and 2 of v6 into one. (Borislav)
> >  * Merged the history of patches 1 and 2ino this patch.
> >  * Kept the Reviewed-by and Tested-by tags from the two merged patches.
> >  * Fixed a formatting issue in allocate_cache_info(). (Borislav)
> > 
> > Changes since v5:
> >  * Fixed nonsensical subject (Nikolay).
> >  * Added Reviewed-by and Tested-by tags from Andreas. Thanks!
> >  * Added Reviewed-by tag from Nikolay. Thanks!
> > 
> > Changes since v4:
> >  * Combined checks for per_cpu_cacheinfo() and cache_leaves() in a single
> >    line. (Sudeep)
> >  * Added Reviewed-by tag from Sudeep. Thanks!
> > 
> > Changes since v3:
> >  * Added Reviewed-by tag from Radu and Sudeep. Thanks!
> > 
> > Changes since v2:
> >  * Introduced this patch.
> > 
> > Changes since v1:
> >  * N/A
> > 
> > ---
> > The motivation for commit 5944ce092b97 was to prevent a BUG splat in
> > PREEMPT_RT kernels during memory allocation. This splat is not observed on
> > x86 because the memory allocation for cacheinfo happens in
> > detect_cache_attributes() from the cacheinfo CPU hotplug callback.
> > 
> > The dereference of a NULL cacheinfo is not observed today because
> > cache_leaves(cpu) is zero until after init_cache_level() is called
> > (during the CPU hotplug callback). A subsequent changeset will set
> > the number of cache leaves earlier and the NULL-pointer dereference
> > will be observed.
> > ---
> >  drivers/base/cacheinfo.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> > index 7a7609298e18..a1afc478e0e8 100644
> > --- a/drivers/base/cacheinfo.c
> > +++ b/drivers/base/cacheinfo.c
> > @@ -58,7 +58,7 @@ bool last_level_cache_is_valid(unsigned int cpu)
> >  {
> >  	struct cacheinfo *llc;
> >  
> > -	if (!cache_leaves(cpu))
> > +	if (!cache_leaves(cpu) || !per_cpu_cacheinfo(cpu))
> >  		return false;
> >  
> >  	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
> > @@ -466,8 +466,7 @@ int __weak populate_cache_leaves(unsigned int cpu)
> >  static inline
> >  int allocate_cache_info(int cpu)
> >  {
> > -	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu),
> > -					 sizeof(struct cacheinfo), GFP_ATOMIC);
> > +	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu), sizeof(struct cacheinfo), GFP_ATOMIC);
> >  	if (!per_cpu_cacheinfo(cpu)) {
> >  		cache_leaves(cpu) = 0;
> >  		return -ENOMEM;
> > @@ -539,7 +538,11 @@ static inline int init_level_allocate_ci(unsigned int cpu)
> >  	 */
> >  	ci_cacheinfo(cpu)->early_ci_levels = false;
> >  
> > -	if (cache_leaves(cpu) <= early_leaves)
> > +	/*
> > +	 * Some architectures (e.g., x86) do not use early initialization.
> > +	 * Allocate memory now in such case.
> > +	 */
> > +	if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
> >  		return 0;
> >  
> >  	kfree(per_cpu_cacheinfo(cpu));
> 
> Since Borislav explicitly said you were not supposed to keep the tags,
> I reviewed it again, and I'm OK to keep mine. Thanks!
> 
> Reviewed-by: Radu Rendec <rrendec@redhat.com>

Thank you!

