Return-Path: <linux-kernel+bounces-428691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91629E1229
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABAA0160EAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1815573A;
	Tue,  3 Dec 2024 04:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hI+thyqB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CAC224F0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 04:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198558; cv=none; b=R33KKWQqWFskxA2mHCNB4emHXo5XeuiLFr/0VVJqYRxK+Qk42t3j+JQwXZxllQg0ogUiOxTo9jtme8TAzpm6jKIY47a2YSDAaPD8CUEAw5DqJXOPUPYpJAiU/CtKunh33AhcXhop1Dkhb69PZyC2WvkxC0bZF2FAAGUjSFWf39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198558; c=relaxed/simple;
	bh=2QJvh/hUY6H0FtheL/6mSGkR0pnf2VxMmdpf4hYIrfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN90dk+CnQh2ReKN7eyCgNZpnoYcndBfh+cWuk6a6ER7RclYy/zGWx3f+IXpH7pXUQn46W6XZ8tphLKrCxcR9rJDOYGvVojtdEVFfq1NqxycX6GRTHsv7y+sI7pN7nCZ+J1J2LlmA33/V3/5b87GcoNWkGeSR1b6QNKiMsL6OGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hI+thyqB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733198557; x=1764734557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2QJvh/hUY6H0FtheL/6mSGkR0pnf2VxMmdpf4hYIrfo=;
  b=hI+thyqBxN16aUEwM4b6+Kyq256RShQQ833Xro30cOMF1QorPzA1IM38
   SMiwN5Pspo3r3M5N7ToVl7gJqhzEF+2bN34dwjxq8UeXmOvz0IoDc3h5q
   F5wMVYedfEOQSZk4E3RB0l56YKaKXzNlYqI0OPyb1Qx7qDi99bcmYW+M0
   gGQjXj73wChRmjtOSbNpNKWFLmL1xTQ6Fw+VEyRQWmCy/BvGKXPEftAnV
   qZ5qCWWjZ3X6I6V9oCKxPiaRCHYr7h4tkR48xoJ5wmWevGiWP4Tgwh4/M
   tdyIH8SbphQpdLroTN3h+UPAZnL+EbPFoNnluPuyvKL8SkG3VRsNlpJly
   A==;
X-CSE-ConnectionGUID: GWK1SeVzRYu2J3ncaU/pTg==
X-CSE-MsgGUID: dAQQhgLWQXKAesE/9tJuwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33528750"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33528750"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:02:37 -0800
X-CSE-ConnectionGUID: Wbso61p+RIWpdbqTgU7w9Q==
X-CSE-MsgGUID: JgfIWcgYQfub2UO8nsZBMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98324121"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:02:36 -0800
Date: Mon, 2 Dec 2024 20:09:19 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Andreas Herrmann <aherrmann@suse.de>
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
Subject: Re: [PATCH v8 1/2] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20241203040919.GB29168@ranerica-svr.sc.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
 <20241202080203.GC4089@alberich>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202080203.GC4089@alberich>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Dec 02, 2024 at 09:02:03AM +0100, Andreas Herrmann wrote:
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
> > Tested-by: Andreas Herrmann <aherrmann@suse.de>
> > Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> 
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

Thank you!

