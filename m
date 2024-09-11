Return-Path: <linux-kernel+bounces-325747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE12A975DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728942855A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AFF1B373A;
	Wed, 11 Sep 2024 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIvfIZpK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98314149002
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726097310; cv=none; b=mVvWAOwj0AQS5ouKWjR7EQL8VNWxoLbndy5twTUyz1yZIp/1ceY3k3r0LxCzckr9wz7vaELuFb90w8Fokfa5+mmLeUTgtX8oZhOSD6Oy028J50qgkEnb8CZ341+deEi0aLJMfB80LtFpwSRbPOOSmVALXIhhJrwRz/vL9KFHQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726097310; c=relaxed/simple;
	bh=Xavp+uvKp5iySBdVS0P1MPRUHvVMZeQmjjbpevDIKV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK+JRCZDR1Bw0Xa94rCfKl3HaYLd8KMgBjiqgrNiD+BFundNK5leC8aIIqxjncYTsIWxUR1YHbam2E39UYU+nUqzthf9i1cgnWJXe0KaIXYzykflh9Z647jTO3H9Ht2bZT/fgLQsqA3scmYSeZTAjF+IfmoE1GSpY7wIqmxhpCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIvfIZpK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726097309; x=1757633309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xavp+uvKp5iySBdVS0P1MPRUHvVMZeQmjjbpevDIKV4=;
  b=IIvfIZpK3+xbG7Zrk2WJRhBpswN+q2wYxyL7mXIyEoCaOP1cxKRElxp9
   uJG8cau9ZrNcGHueTfni4AFgS54pwQi4/sLe67Jz8q5WY3fKCRYy/7UBH
   Zx2Ua5fGjZpHUkc+N6M604ahIXDUoPCnAl6aeIrMz9VZ1Lv34UZMgLbZK
   /V6dMApBx1daNWfMQyjcQzRIh0cl3FuIbY9xff1tPaVqRf7DxznUoJywI
   3bNBtGtGUTWPAVfxq81WAet6gFYmJx9Q/s4zldLLBrCQGbq/CIVBge/FQ
   nfbVUvuaTPa/QmCAjMpxwJTwwX0pm5lsYBflFz6q19AuNgo6OzaRbBXSv
   Q==;
X-CSE-ConnectionGUID: xkKam6m+Si2UO4I1C9SIsg==
X-CSE-MsgGUID: fWA4HOQ2TtiiK5MFrF4ozw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28814546"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="28814546"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 16:28:28 -0700
X-CSE-ConnectionGUID: Yz+afc+ZTs2xlM/aXHRFgA==
X-CSE-MsgGUID: pgIP8HO8S/mRS3v6AzCAkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67454522"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 16:28:28 -0700
Date: Wed, 11 Sep 2024 16:34:10 -0700
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
Subject: Re: [PATCH v6 2/4] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20240911233410.GA7043@ranerica-svr.sc.intel.com>
References: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
 <20240905060036.5655-3-ricardo.neri-calderon@linux.intel.com>
 <20240911140844.GFZuGkbHQ_E-K5LW1q@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911140844.GFZuGkbHQ_E-K5LW1q@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Sep 11, 2024 at 04:08:44PM +0200, Borislav Petkov wrote:
> On Wed, Sep 04, 2024 at 11:00:34PM -0700, Ricardo Neri wrote:
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
> 
> Why is this a separate patch?
> 
> It sounds like it should be merged with the first one as both address a CPU
> hotplug issue AFAICT.

Thank you for your review Borislav!

Yes, both patches address issues during CPU hotplug (both NULL-pointer
dereference). However, IHMO, they are separate issues. Patch 1/4 fixes
a missing allocation check. Patch 2/4 causes the allocation to happen in
case early allocation is not used.

If I did not convince you, I am happy to merge together patches 1 and 2.

Thanks and BR,
Ricardo


