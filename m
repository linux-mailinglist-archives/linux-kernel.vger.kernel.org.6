Return-Path: <linux-kernel+bounces-306111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45AE963958
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3971F236E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A42E8287D;
	Thu, 29 Aug 2024 04:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdgEvOoB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AE23BF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905667; cv=none; b=WqeNQJdHWz/4AHWIrx5jv29zGwjSRy0CxY4I83+G02z28/qm3AcFP3GX7o4+QzfOPvLn97JO78ia8WL1YQFiBa2+48dIxAL+73GXI3ORdkKsKrr/XcgjE7CdKUtOV8i56H6OaMT3sIuE57q+or6dwV8guuI572tePBjCqvfLXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905667; c=relaxed/simple;
	bh=u803n/ZjYG4TMiaHJPFp5z+USsSXR/AT5aAIyPKBizw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izYUftagTgqEAgCn86R6q/IT0bt6znDNGNULVV7lgwIimAZRoLpDLO0Ig/v8Ze8T2ZJQ2oDEWXCIFNl2YjMk7sbEmx4218l0X+33nMqqH+0Mh8gaw6IX6LP9HESG+5dPCsjtl+xUd2H5XxJ1Sa+oITXrisCnYusoTC92rV27iJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdgEvOoB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724905666; x=1756441666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=u803n/ZjYG4TMiaHJPFp5z+USsSXR/AT5aAIyPKBizw=;
  b=OdgEvOoBZfqI8+xjAdsJ+kzwxEku7qLq1Wz9n9Halyq1hVeFQTqFS6ft
   NsNxQybySYG8NO0EHaT0Ib8aqBxbUD4LTy9upyVd6KjWVt3U1eeDVxPPd
   LYJYfI+A3TtH1ylyFbume2WVTeEX8EQxQfFM+dso/xXKiSFVj0MkfsaCs
   HxfEluDpNasAp0PwctW0k+TcYwDwrCzMEWiebs7nV+4KjxZi7XOOV/qz3
   ucr5vfLXDLnDRprt1iqYbQ6cF2k4p0958cDZo3FEnYWqiv7bmKFa+kmIY
   H2TIXxnBmSd75vROyTOyFam/2JsXHjkAaos5qN54ei12GgI1dRQB2IYLg
   A==;
X-CSE-ConnectionGUID: z9S4WGqoQ66exPW/R1onUA==
X-CSE-MsgGUID: j1pIpWKKSvyfxPqYS+eDMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="48858297"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="48858297"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 21:27:45 -0700
X-CSE-ConnectionGUID: ogjeiJw4QDuofw0FDPbpsA==
X-CSE-MsgGUID: 6+32bXxETCCx3y2udC399w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="67811487"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 21:27:45 -0700
Date: Wed, 28 Aug 2024 21:33:35 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20240829043335.GA4229@ranerica-svr.sc.intel.com>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-4-ricardo.neri-calderon@linux.intel.com>
 <f300d558-9798-40a1-9d11-ec6b6020a1b3@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f300d558-9798-40a1-9d11-ec6b6020a1b3@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Aug 28, 2024 at 03:57:05PM +0300, Nikolay Borisov wrote:
> 
> 
> On 27.08.24 г. 8:16 ч., Ricardo Neri wrote:
> > Linux remembers cpu_cachinfo::num_leaves per CPU, but x86 initializes all
> > CPUs from the same global "num_cache_leaves".
> > 
> > This is erroneous on systems such as Meteor Lake, where each CPU has a
> > distinct num_leaves value. Delete the global "num_cache_leaves" and
> > initialize num_leaves on each CPU.
> > 
> > Reviewed-by: Len Brown <len.brown@intel.com>
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
> > Cc: stable@vger.kernel.org # 6.3+
> > ---
> > After this change, all CPUs will traverse CPUID leaf 0x4 when booted for
> > the first time. On systems with symmetric cache topologies this is
> > useless work.
> > 
> > Creating a list of processor models that have asymmetric cache topologies
> > was considered. The burden of maintaining such list would outweigh the
> > performance benefit of skipping this extra step.
> > ---
> > Changes since v4:
> >   * None
> > 
> > Changes since v3:
> >   * Rebased on v6.7-rc5.
> > 
> > Changes since v2:
> >   * None
> > 
> > Changes since v1:
> >   * Do not make num_cache_leaves a per-CPU variable. Instead, reuse the
> >     existing per-CPU ci_cpu_cacheinfo variable. (Dave Hansen)
> > ---
> 
> 
> Overall LGTM, one minor nit below which is not a deal breaker.
> 
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Thank you!

> 
> >   arch/x86/kernel/cpu/cacheinfo.c | 44 +++++++++++++++++++--------------
> >   1 file changed, 26 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> > index 392d09c936d6..b5e216677a46 100644
> > --- a/arch/x86/kernel/cpu/cacheinfo.c
> > +++ b/arch/x86/kernel/cpu/cacheinfo.c
> > @@ -178,7 +178,16 @@ struct _cpuid4_info_regs {
> >   	struct amd_northbridge *nb;
> >   };
> > -static unsigned short num_cache_leaves;
> > +static inline unsigned int get_num_cache_leaves(unsigned int cpu)
> > +{
> > +	return get_cpu_cacheinfo(cpu)->num_leaves;
> > +}
> > +
> > +static inline void
> > +set_num_cache_leaves(unsigned int nr_leaves, unsigned int cpu)
> > +{
> 
> nit: I think it's more natural to have the cpu parameter come first.

Sure! I will wait a few days for more feedback. Then I will post an
updated version with this change.

Best,
Ricardo


