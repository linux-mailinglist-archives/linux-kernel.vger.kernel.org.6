Return-Path: <linux-kernel+bounces-325750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC94B975DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBDC1C21E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7B4185B6E;
	Wed, 11 Sep 2024 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9P9nneL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5F14F6C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726097525; cv=none; b=gH362DVbwy4UC8r6J61uIrOIJNHan+ygYLRLMQ0PgsZkROSFKFWxyhErqhONoq3ZRTSFWNVUOdB19dC7lH7IztAq3FavLASvfaVH3s9kT/EQ07tFg/UpnEDm0pGYVdbrwueS/f1ajj4qf50m6CqOOHwfZl3L7Cx1gub6qZJt/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726097525; c=relaxed/simple;
	bh=HJuN3zUbj8WBQmqvMkVa+VDFYiZQRE0Dxq60HMS2Xd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mar7MxTiRqbOnNeHocJCe4ygw7Edr+XYa/HYqkUju5xdmqpsfvNQQ3PlMysY4V3bRftLSvmwMDB56KIhydIk8Ec075ujUQeh5rb0YjLglxKaMRlhho8sQOV4c1Ab/oz5Xa+9fBilf11rZUu6lfBMOreg1zMeSxI3Pnl4o4quscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9P9nneL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726097524; x=1757633524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HJuN3zUbj8WBQmqvMkVa+VDFYiZQRE0Dxq60HMS2Xd0=;
  b=f9P9nneLwd7ePYuriqtbGGzB8Ji77V58FnUqDKdXDHaRAL0NVNV6t66n
   Pi7WDqr1jDLOwARgYLzDylqnnNU39VE319rXYVwPZfGszGpjmOLAV1pn3
   1xrVvNuyGKDyhGFn/b3yfLh56v9DqCLA9iXgYhl0mOuYj4h9NQgGpZQa/
   poDoYgPnizhN9slHjzzfCeBdGnSq8BB1lJl7PUUXBFJqC0BMUtKGbQkpi
   Y3PSj8tYSGusOwRw2iZByUwqkia30IKDX6TkwM2yYRfFsEWCa6cbJUb06
   5aHV4YOPvPYkxShiFtA1uLWhEoHKisgx1RVP8J1mmsw/y2uCycTgSyTsu
   A==;
X-CSE-ConnectionGUID: 40S5XIyNRgyqfjlIFSRp8A==
X-CSE-MsgGUID: /B/+ctRMTcCuQnpebg4rWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28814754"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="28814754"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 16:32:03 -0700
X-CSE-ConnectionGUID: GaibvmmXSBSDEfBU6VPGpw==
X-CSE-MsgGUID: 5l2h+Y75RVmTc7rUJrwxHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67455855"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 16:32:03 -0700
Date: Wed, 11 Sep 2024 16:37:46 -0700
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
Subject: Re: [PATCH v6 1/4] cacheinfo: Check for null last-level cache info
Message-ID: <20240911233746.GB7043@ranerica-svr.sc.intel.com>
References: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
 <20240905060036.5655-2-ricardo.neri-calderon@linux.intel.com>
 <20240911140509.GEZuGjlfyxj5hvSDYU@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911140509.GEZuGjlfyxj5hvSDYU@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Sep 11, 2024 at 04:05:09PM +0200, Borislav Petkov wrote:
> On Wed, Sep 04, 2024 at 11:00:33PM -0700, Ricardo Neri wrote:
> > Before determining the validity of the last-level cache info, ensure that
> > it has been allocated. Simply checking for non-zero cache_leaves() is not
> > sufficient, as some architectures (e.g., Intel processors) have non-zero
> > cache_leaves() before allocation.
> >
> > Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
> > This function iterates over all online CPUs. However, a CPU may have come
> > online recently, but its cacheinfo may not have been allocated yet.
> > 
> > Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Tested-by: Andreas Herrmann <aherrmann@suse.de>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> While at it, pls fix the formatting insanity of allocate_cache_info() into:
> 
> static inline int allocate_cache_info(int cpu)
> {
>         per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu), sizeof(struct cacheinfo), GFP_ATOMIC);
>         if (!per_cpu_cacheinfo(cpu)) {
>                 cache_leaves(cpu) = 0;
>                 return -ENOMEM;
>         }
>             
>         return 0;
> }
> 
> Thx.

Sure! I can do this. I assume this should be a separate patch.

