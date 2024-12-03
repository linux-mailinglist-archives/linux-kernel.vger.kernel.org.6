Return-Path: <linux-kernel+bounces-428689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE81C9E1226
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E71B22124
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41061148FED;
	Tue,  3 Dec 2024 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzgVA2HB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2985224F0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198533; cv=none; b=fBpwhVPgdk+thVFwrnborR5sEU51dB9IT90TSPOSrqZ/5mqZVQpNkXMQlcPEK/7wyNPGuw0FCYFx17BygEy97dJRqmeyWqND7BOFI5C1eQ89TEcB5vOpF1xDz2f4pVdY9VYMOs/bTRuR66HqKCbYOpKw1nGWwtXnx4gjD5x+d3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198533; c=relaxed/simple;
	bh=NaZQw9eZX3YfYI4ftpt3lpgGjkEwQDxIJfPwokHoiwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrWMzfjZVwtk42q5yKrzFb/3E/DtJWBRjj9AHkcfMtUt+QCs6Zx+i5IQynSB/vV5JaDQYVkQ/+ft0+SgE6FToMXlarsKQmlWsBcXkphbqoiJlXmaw1AQnMN56SydIOPa+Qfko3udhed4VRwVHi0AmNBJ4g0fRi/RgHXS+g1582I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzgVA2HB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733198533; x=1764734533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NaZQw9eZX3YfYI4ftpt3lpgGjkEwQDxIJfPwokHoiwo=;
  b=lzgVA2HBOcZl5znHBcBPK3jgYshqdm8kP3CC947rxus4alQYLzhspUxY
   0/0jLUV8J9t2uN89lEhg6CBzkr+HOQ1Jyx+nkB97J0a5TFndHmouz3XQl
   yFvh2C+i40dyeMIHYWPWW7X5Bo0dGz+XZSXRisoAVsc9DYSZboZzOfdn1
   GYWyD+rVU5Ip5DmSMRn28JrZwTxHazZPs6dvAxieQnHYUV+WhAE6sTPbh
   0duzxFjnxJ8zQQuakO37s/AVHrBqsjtw70u5HYR80cms5xLLiJsN1nPHa
   YcfDSX9v6rX/NNsd4owS/vRtGdGWYb3aIwQMoEOUbIRpambAxVhhGBgrN
   g==;
X-CSE-ConnectionGUID: haL4rjwySpu/cXA/YIhneA==
X-CSE-MsgGUID: 7EQYD8APTt6/NFh+Ygatsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33528664"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33528664"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:02:12 -0800
X-CSE-ConnectionGUID: BNYgkhJuQOW234ty1ZFj3w==
X-CSE-MsgGUID: Nh/rW/nyRme6LWOIumFpDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98324035"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:02:11 -0800
Date: Mon, 2 Dec 2024 20:08:55 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20241203040855.GA29168@ranerica-svr.sc.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
 <Z02UFUQCwEVAnY7C@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z02UFUQCwEVAnY7C@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Dec 02, 2024 at 11:03:49AM +0000, Sudeep Holla wrote:
> On Wed, Nov 27, 2024 at 04:22:46PM -0800, Ricardo Neri wrote:
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
> >      BUG: kernel NULL pointer dereference, address: 0000000000000100
> >      #PF: supervisor read access in kernel mode
> >      #PF: error_code(0x0000) - not present page
> >      PGD 0 P4D 0
> >      Oops: 0000 [#1] PREEPMT SMP NOPTI
> >      CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
> >      RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
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
> 
> In case old tags are deemed null 😄,
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thank you!

