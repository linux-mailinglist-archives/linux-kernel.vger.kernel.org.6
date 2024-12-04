Return-Path: <linux-kernel+bounces-431632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD929E4006
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B084BB3CC0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E55B20CCCC;
	Wed,  4 Dec 2024 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYhR5Ml8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CB20CCC0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329950; cv=none; b=Y/aEsXfgfG6pSBZr/EVNjl33HdZNeBto7fqnhbt6SDKgbZm/9ecM2DmzQXhdiSA99/v2Uc1ojnELyCBnFnYp6FpbvUtcMe+9fDHlhXMaww8cWV/KtTdJpxlEvXFFEgnCeTpfTJYBdfVSjZiJ95g65mMlygpZqjDoGp/+E4cOerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329950; c=relaxed/simple;
	bh=aQXwpasQ2dsfXqYkYw5P/3h768ftdLRz93Dv9ZD40yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgOTJ9F96pMzfsCSZUH15KwZUzAveu1OMb8RyiGZQR3j0fltaZs1Zb/yYoWrPVcR9rSMwl5lOHiRbjVQ/FmaKkOoJ/dqf8GSTxTNbVc9uO6CckqeP8HJagdb5zFh8qFn3Re4Ti7pGHfiXG64u3jOu65+/NpcuyUC1vblwAtuzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYhR5Ml8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733329948; x=1764865948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aQXwpasQ2dsfXqYkYw5P/3h768ftdLRz93Dv9ZD40yg=;
  b=bYhR5Ml8WWL5LtAQoXgwk9qrwK5mQmFKK3/fzoUfMQ52bO7YmlCq+wnC
   kBhDi+rGOVbAtdl2EuqL+3i3CFYgeNe2rNnR4FRM2c7ohg+n+NjnG4uUD
   pbrwyQ9lmkEhd3j2SaFAYFvFQpErGZ9s/hoik3RCwl/1HZFcDEHEXPfXH
   bcmBIxL2ZcPHwRCwsWbR4wAp6T4V1COKgRZ0H8eBKOACR3EXCH188w51/
   l27+77EXHIZ2rVbf2EtrvNkbBo16i4rHPEmSE1xyrS8aR0HhLfgndND5z
   KbHiOIE3lwX5RMpqokbJzsF2e8oTKBNxoFXB5eLIXYzDV3wO90E9IIsCU
   w==;
X-CSE-ConnectionGUID: WrQ34M3GQoGqJehv75XxbQ==
X-CSE-MsgGUID: yHxvEaKUTUGRdtsjxHwltQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32964995"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32964995"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 08:32:28 -0800
X-CSE-ConnectionGUID: xonPj6riRyO8kUVZXfqycg==
X-CSE-MsgGUID: cK5f1tZmR1WmFuZ/k4Hs6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98620059"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 08:32:28 -0800
Date: Wed, 4 Dec 2024 08:39:11 -0800
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
Subject: Re: [PATCH v8 2/2] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20241204163911.GA31633@ranerica-svr.sc.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>
 <20241204143206.GAZ1Bn5jsTCvI_1ci0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204143206.GAZ1Bn5jsTCvI_1ci0@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Dec 04, 2024 at 03:32:06PM +0100, Borislav Petkov wrote:
> On Wed, Nov 27, 2024 at 04:22:47PM -0800, Ricardo Neri wrote:
> >  arch/x86/kernel/cpu/cacheinfo.c | 41 +++++++++++++++------------------
> >  1 file changed, 18 insertions(+), 23 deletions(-)
> 
> Does that work too?
> 
> ---
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 95e38ab98a72..e6fa03ed9172 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -715,22 +715,23 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
>  
>  void init_amd_cacheinfo(struct cpuinfo_x86 *c)
>  {
> -
> -	unsigned int cpu = c->cpu_index;
> +	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
>  
>  	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
> -		get_cpu_cacheinfo(cpu)->num_leaves = find_num_cache_leaves(c);
> +		ci->num_leaves = find_num_cache_leaves(c);
>  	} else if (c->extended_cpuid_level >= 0x80000006) {
>  		if (cpuid_edx(0x80000006) & 0xf000)
> -			get_cpu_cacheinfo(cpu)->num_leaves = 4;
> +			ci->num_leaves = 4;
>  		else
> -			get_cpu_cacheinfo(cpu)->num_leaves = 3;
> +			ci->num_leaves = 3;
>  	}
>  }
>  
>  void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
>  {
> -	get_cpu_cacheinfo(c->cpu_index)->num_leaves = find_num_cache_leaves(c);
> +	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
> +
> +	ci->num_leaves = find_num_cache_leaves(c);
>  }
>  
>  void init_intel_cacheinfo(struct cpuinfo_x86 *c)
> @@ -740,20 +741,21 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
>  	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
>  	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
>  	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
> +	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
>  
>  	if (c->cpuid_level > 3) {
>  		/*
>  		 * There should be at least one leaf. A non-zero value means
>  		 * that the number of leaves has been initialized.
>  		 */
> -		if (!get_cpu_cacheinfo(c->cpu_index)->num_leaves)
> -			get_cpu_cacheinfo(c->cpu_index)->num_leaves = find_num_cache_leaves(c);
> +		if (!ci->num_leaves)
> +			ci->num_leaves = find_num_cache_leaves(c);
>  
>  		/*
>  		 * Whenever possible use cpuid(4), deterministic cache
>  		 * parameters cpuid leaf to find the cache details
>  		 */
> -		for (i = 0; i < get_cpu_cacheinfo(c->cpu_index)->num_leaves; i++) {
> +		for (i = 0; i < ci->num_leaves; i++) {
>  			struct _cpuid4_info_regs this_leaf = {};
>  			int retval;
>  
> @@ -789,14 +791,14 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
>  	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
>  	 * trace cache
>  	 */
> -	if ((!get_cpu_cacheinfo(c->cpu_index)->num_leaves || c->x86 == 15) && c->cpuid_level > 1) {
> +	if ((!ci->num_leaves || c->x86 == 15) && c->cpuid_level > 1) {
>  		/* supports eax=2  call */
>  		int j, n;
>  		unsigned int regs[4];
>  		unsigned char *dp = (unsigned char *)regs;
>  		int only_trace = 0;
>  
> -		if (get_cpu_cacheinfo(c->cpu_index)->num_leaves && c->x86 == 15)
> +		if (ci->num_leaves && c->x86 == 15)
>  			only_trace = 1;
>  
>  		/* Number of times to iterate */
> @@ -990,8 +992,10 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>  
>  int init_cache_level(unsigned int cpu)
>  {
> +	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
> +
>  	/* There should be at least one leaf. */
> -	if (!get_cpu_cacheinfo(cpu)->num_leaves)
> +	if (!ci->num_leaves)
>  		return -ENOENT;
>  
>  	return 0;

Yes, this looks OK to me and is an improvement.

I can post a v9 with these changes.

I think I can keep the Reviewed-by tags as they were given to Patch 1.

Thanks and BR,
Ricardo

