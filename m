Return-Path: <linux-kernel+bounces-428692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCBC9E122A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64BC282DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C595148FED;
	Tue,  3 Dec 2024 04:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ho+QS0iN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047C7FBA2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198583; cv=none; b=kll28kxjv3QMQDIjUrEOC0K/nUzqD79z0Y3PU3IvasYBqRI1O6eLODkuBscokBnZIU0m5l4w/kUlwU0Vvy/i5+0nz7mA1RRYttiqJ1YpHRaPSNflzVKyk/a9vxZR5h+BmsF+xm76oCuCAV3BlVDYbO97v0YNHTDdwJpnAJ2HZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198583; c=relaxed/simple;
	bh=8KfStcvuAS2+h8njLKnxPyxNxuqoGXBXEh9WCn6FPss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2Rz6fJwVRkAefVZDG/lESfIwEQkgvAscaNe6i3oHG3OPpfJL9Th3RvjWMKlGsmLcfduXvVailf4Oz7T+FZUD4mUnqOlGajr7KYXh9iVYHBS2adI/OgeIBitQaOPXjGRvsIKqeXIgAviAgIyyQZSGgvQm6eCz8/SOLzkD2gaS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ho+QS0iN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733198581; x=1764734581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8KfStcvuAS2+h8njLKnxPyxNxuqoGXBXEh9WCn6FPss=;
  b=Ho+QS0iNdoGirnaL+bnSMhRRNqtkjMvVsiBCIX00ZMSIOrAAZ9pPcp0X
   5QeHEKQAo38XAxYBDVxqrq62+cQYAJe/XN48rc+noDvBzPTyE4B0BKs6/
   eq+zyy8AaDsRZ5LHMGdr26Cd4mnBnpZdaK7azv0VtRLcNrfNDMlhHThw7
   wRxvZkWdejx5CnPephA4T3B1qtQa6PmsscPUUkRH8bBh2K0WVu15Yl0Sw
   38WXmiTuv3RIFFfdtRl80QVJmm5WFdwdW2pZLUDyxq3zCzDVuDTK/fdvQ
   aLaXRAaqJ8pgxY9E647F9ghEiL8ZAUdo3ZJ2FLblflwRsgFubvQndbsi3
   A==;
X-CSE-ConnectionGUID: mYSMq172S+iKK4V1WPzQIg==
X-CSE-MsgGUID: d6h+G2uwRAWu6S3EocZmuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="37170948"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="37170948"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:03:01 -0800
X-CSE-ConnectionGUID: tGvhB0BmS+y4hNJDn+rfuQ==
X-CSE-MsgGUID: 5Ist2Y8OTeWCmwynCExoTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93219287"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:03:01 -0800
Date: Mon, 2 Dec 2024 20:09:45 -0800
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
Subject: Re: [PATCH v8 1/2] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20241203040945.GC29168@ranerica-svr.sc.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
 <f9753978-6505-43ad-a224-a78ab5141f45@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9753978-6505-43ad-a224-a78ab5141f45@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Dec 02, 2024 at 08:53:44AM +0200, Nikolay Borisov wrote:
> 
> 
> On 28.11.24 г. 2:22 ч., Ricardo Neri wrote:
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
> >       BUG: kernel NULL pointer dereference, address: 0000000000000100
> >       #PF: supervisor read access in kernel mode
> >       #PF: error_code(0x0000) - not present page
> >       PGD 0 P4D 0
> >       Oops: 0000 [#1] PREEPMT SMP NOPTI
> >       CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
> >       RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
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
> 
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Thank you!

