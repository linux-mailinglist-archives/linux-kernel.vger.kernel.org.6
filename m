Return-Path: <linux-kernel+bounces-377274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623669ABC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42971F2275E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5660584FAD;
	Wed, 23 Oct 2024 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJnBtAMX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE1139E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655053; cv=none; b=k/9dwg8F7Uo+VgHfY9zkEoQGpVajtgl6+tH4QZNhrZH3DaZQBM04YcKJXY7QqKBY5RYtUblEGSjL5u4EK15NQYk7ANJyzSXzlEy7ViuW0SJ84nxvGLQCWXHavRYAZzSVk17406bBkTfgFk/c1ty13jzS8hjvJpayvGnoi4gmrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655053; c=relaxed/simple;
	bh=jNe2iCBYvBrl8u+qoQN5b6lkFtrEC+1An7aehu8mdME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhEhi1EYYB8hREpVyyJBvSznvmiJlpCwtv/3/jyfBRtMyhtkGvXy4N/aj9f/682rC2+oVI/PNg1Q607OQBVQu7mhSxpvWMyfB9rTtblASdZXKIwSEh7H5QcTDP+ssxLLMM2eKxoVNY8WyZAU8Mm346DJgZuIQS6sM5kMcbpSWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJnBtAMX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729655053; x=1761191053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jNe2iCBYvBrl8u+qoQN5b6lkFtrEC+1An7aehu8mdME=;
  b=IJnBtAMXQLuLfnq9M8VzWtzDBRwciUvqZNWWuZCbgYRnky2JnCjb2iCr
   Q0MzUypx0rfCZGarMHS9TLihCgklK76/cXtZQ8yg3nHBY+eBahEHrt+nn
   acF5TnM1t3B1fNnkSi5L5McwI9IVSOBYI8livwgPYmAn6jzfymi0jPmWJ
   Sq/PMZBpYgEZrvYFkB3iRgvLoAEUq/hLiaFcju5W4d0Y/lmX6acIy9G/Q
   K42hsRGjFGX/twXuVdeowPDGJJpqRCQel757qx2y5GdDiM8Z9/ifBDdQw
   /UbK15tQ8VU1INPCMwNRwpHA+jOXi6BQdD+6LKspj+tsO0z8PAEGAJhE4
   Q==;
X-CSE-ConnectionGUID: OwQaBMU4TCyF8ThoWZL/9A==
X-CSE-MsgGUID: E1p9DrCdQqapX6Ve54/weA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="40610974"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="40610974"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 20:44:12 -0700
X-CSE-ConnectionGUID: bkXDYOP6S4mw4Z0DZAdYmA==
X-CSE-MsgGUID: ka6NtRZZSNO1jtrXg38S4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80080766"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 20:44:11 -0700
Date: Tue, 22 Oct 2024 20:50:22 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20241023035022.GA2484@ranerica-svr.sc.intel.com>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
 <20240913083155.9783-3-ricardo.neri-calderon@linux.intel.com>
 <20241022132050.GHZxemsmJSLg8Q_7U7@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022132050.GHZxemsmJSLg8Q_7U7@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Oct 22, 2024 at 03:20:50PM +0200, Borislav Petkov wrote:
> On Fri, Sep 13, 2024 at 01:31:54AM -0700, Ricardo Neri wrote:
> > diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> > index 392d09c936d6..182cacd772b8 100644
> > --- a/arch/x86/kernel/cpu/cacheinfo.c
> > +++ b/arch/x86/kernel/cpu/cacheinfo.c
> > @@ -178,7 +178,16 @@ struct _cpuid4_info_regs {
> >  	struct amd_northbridge *nb;
> >  };
> >  
> > -static unsigned short num_cache_leaves;
> > +static inline unsigned int get_num_cache_leaves(unsigned int cpu)
> > +{
> > +	return get_cpu_cacheinfo(cpu)->num_leaves;
> > +}
> 
> There already is
> 
> #define cache_leaves(cpu)       (ci_cacheinfo(cpu)->num_leaves)
> 
> And there's also get_cpu_cacheinfo().
> 
> And now you're adding more silly wrappers. Yuck.
> 
> Can we pls use *one* of those things and work with it everywhere?

I agree. Another wrapper is not needed. I did not use cache_leaves() because
it was internal to drivers/base/cacheinfo.c I can convert it to a function
and expose it in include/linux/cacheinfo.h. I can rename it as
get_cacheinfo_leaves(unsigned int cpu).

Would that make sense?

> 
> > @@ -742,19 +753,19 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
> >  	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
> >  
> >  	if (c->cpuid_level > 3) {
> > -		static int is_initialized;
> > -
> > -		if (is_initialized == 0) {
> > -			/* Init num_cache_leaves from boot CPU */
> > -			num_cache_leaves = find_num_cache_leaves(c);
> > -			is_initialized++;
> > -		}
> > +		/*
> > +		 * There should be at least one leaf. A non-zero value means
> > +		 * that the number of leaves has been initialized.
> > +		 */
> > +		if (!get_num_cache_leaves(c->cpu_index))
> > +			set_num_cache_leaves(c->cpu_index,
> > +					     find_num_cache_leaves(c));
> 
> Ugly linebreak.

I will make it a single line.

> 
> >  
> >  		/*
> >  		 * Whenever possible use cpuid(4), deterministic cache
> >  		 * parameters cpuid leaf to find the cache details
> >  		 */
> > -		for (i = 0; i < num_cache_leaves; i++) {
> > +		for (i = 0; i < get_num_cache_leaves(c->cpu_index); i++) {
> >  			struct _cpuid4_info_regs this_leaf = {};
> >  			int retval;
> >  
> > @@ -790,14 +801,14 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
> >  	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
> >  	 * trace cache
> >  	 */
> > -	if ((num_cache_leaves == 0 || c->x86 == 15) && c->cpuid_level > 1) {
> > +	if ((!get_num_cache_leaves(c->cpu_index) || c->x86 == 15) && c->cpuid_level > 1) {
> >  		/* supports eax=2  call */
> >  		int j, n;
> >  		unsigned int regs[4];
> >  		unsigned char *dp = (unsigned char *)regs;
> >  		int only_trace = 0;
> >  
> > -		if (num_cache_leaves != 0 && c->x86 == 15)
> > +		if (get_num_cache_leaves(c->cpu_index) && c->x86 == 15)
> >  			only_trace = 1;
> >  
> >  		/* Number of times to iterate */
> > @@ -993,12 +1004,9 @@ int init_cache_level(unsigned int cpu)
> >  {
> >  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> >  
> > -	if (!num_cache_leaves)
> > -		return -ENOENT;
> 
> Why not
> 
> 	if (!cache_leaves(cpu))
> 		return -ENOENT;
> 
> ?

The only caller of init_cache_level() also checks for !cache_leaves(cpu). I
saw no need to repeat the check here.

Also, I understand that the purpose of the function is to initialize
cpu_cacheinfo::num_levels, which is not used on x86. Moreover,
cpu_cacheinfo::num_levels do not depend on num_leaves.

Having said that, I see other architectures initializing both num_levels
and num_leaves in this function.

Adding this check probably makes the x86 implementation more future-proof
in case callers change their behavior.

Thanks and BR,
Ricardo

