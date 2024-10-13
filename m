Return-Path: <linux-kernel+bounces-362750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F999B8FA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161461C20C70
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666F13B588;
	Sun, 13 Oct 2024 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPA/PJ9U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706936B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728812689; cv=none; b=haZ8MJJ27nx1pgqU7vXMJw7A/+tTBiWllAY+UHrMC93HaaGqBqrK15omDrzIZ4wdyVad2rHBf3h7AKZ1D5NtJ9BwQEJLFYPT1ECW+PEaeySG9A/19Sb1BTnO8SZiRArxnkhnIOJVkzY/4xSgUBgkOV2CF3iaL2GHBfkF5DXYy6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728812689; c=relaxed/simple;
	bh=uBh92F6JFgErLzEACrOrk1aa/hShSBYHX/+Zn8wCgPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMrQ/XenACjKoapVvBfeWTS6mW0tHkc4mnUWvJ7+v2Vb19KNtDv5yhs54a+wvz0RE+6y0dNr4a5riJRgDsfP0b5XcPwPTrgyeretvVZQ3wJZtkZ5EOLXE5Tw+BYzUBghGD88YibAxGQCDXhi0Ogtqbh473TSCi4ST/FPyemM/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPA/PJ9U; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728812687; x=1760348687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uBh92F6JFgErLzEACrOrk1aa/hShSBYHX/+Zn8wCgPQ=;
  b=VPA/PJ9UPP3qWdZdS21MJFGip7X9lNlHWuZ/+MpVBV2eA4LRQvhb7ywv
   Vycco08igcmH2ZbLe5Qpoqa2PBfNS3+dYddJsrFapBcVXI2tLWFHkzRxh
   I7nHnXKLrxMYEjgmrJRKYb9/TaPWBWSR+0iWdLhtOfVapWv8MMbYlVPvS
   t+Q/SuyIRKUpXjoC00YaDeobVsqYFkJd/5SabNwVsoH3iHsLRcAeoFpB+
   s7jSe6UXQImxvKE8BMyXNBzWvvNZLUJhs8FjxjVkIRLUmBvKznBj6PUOX
   ikvuDYYfKs7fVuIlkxcUF/JudQMAZhnvqjtmtZPR0nQ3CIy9W/zOH9RyO
   A==;
X-CSE-ConnectionGUID: tc62fzFRR629/gtgAYX5uA==
X-CSE-MsgGUID: obNcA1hMRx6ZRcgiLjo+Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28256608"
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="28256608"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 02:44:47 -0700
X-CSE-ConnectionGUID: GdDPtMZiRtybfBx8A0/+vg==
X-CSE-MsgGUID: gt+o3uyTQeuG3HZxrC9BQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="114757632"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Oct 2024 02:44:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szv9U-000EGR-0n;
	Sun, 13 Oct 2024 09:44:40 +0000
Date: Sun, 13 Oct 2024 17:44:24 +0800
From: kernel test robot <lkp@intel.com>
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	ankur.a.arora@oracle.com, efault@gmx.de
Subject: Re: [PATCH 1/7] sched: warn for high latency with
 TIF_NEED_RESCHED_LAZY
Message-ID: <202410131715.HYC3WK5i-lkp@intel.com>
References: <20241009165411.3426937-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009165411.3426937-2-ankur.a.arora@oracle.com>

Hi Ankur,

kernel test robot noticed the following build errors:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on powerpc/next powerpc/fixes tip/sched/core linus/master v6.12-rc2 next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankur-Arora/sched-warn-for-high-latency-with-TIF_NEED_RESCHED_LAZY/20241010-005819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
patch link:    https://lore.kernel.org/r/20241009165411.3426937-2-ankur.a.arora%40oracle.com
patch subject: [PATCH 1/7] sched: warn for high latency with TIF_NEED_RESCHED_LAZY
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241013/202410131715.HYC3WK5i-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410131715.HYC3WK5i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410131715.HYC3WK5i-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/core.c: In function 'cpu_resched_latency':
>> kernel/sched/core.c:5528:34: error: implicit declaration of function 'tif_need_resched_lazy'; did you mean 'tif_need_resched'? [-Werror=implicit-function-declaration]
    5528 |         if ((!need_resched() && !tif_need_resched_lazy()) || !latency_warn_ms)
         |                                  ^~~~~~~~~~~~~~~~~~~~~
         |                                  tif_need_resched
   cc1: some warnings being treated as errors


vim +5528 kernel/sched/core.c

  5517	
  5518	#ifdef CONFIG_SCHED_DEBUG
  5519	static u64 cpu_resched_latency(struct rq *rq)
  5520	{
  5521		int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
  5522		u64 resched_latency, now = rq_clock(rq);
  5523		static bool warned_once;
  5524	
  5525		if (sysctl_resched_latency_warn_once && warned_once)
  5526			return 0;
  5527	
> 5528		if ((!need_resched() && !tif_need_resched_lazy()) || !latency_warn_ms)
  5529			return 0;
  5530	
  5531		if (system_state == SYSTEM_BOOTING)
  5532			return 0;
  5533	
  5534		if (!rq->last_seen_need_resched_ns) {
  5535			rq->last_seen_need_resched_ns = now;
  5536			rq->ticks_without_resched = 0;
  5537			return 0;
  5538		}
  5539	
  5540		rq->ticks_without_resched++;
  5541		resched_latency = now - rq->last_seen_need_resched_ns;
  5542		if (resched_latency <= latency_warn_ms * NSEC_PER_MSEC)
  5543			return 0;
  5544	
  5545		warned_once = true;
  5546	
  5547		return resched_latency;
  5548	}
  5549	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

