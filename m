Return-Path: <linux-kernel+bounces-362754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF499B902
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B6D281F70
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2699A13C670;
	Sun, 13 Oct 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikUsBYN7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B212C54D
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728813350; cv=none; b=OH+Eea1PBo2h8KLgpluEU4GaC/B3U8Q85mNg7fLvKsr7t1ZAHFK8J92jRwucCD9Ma+kWU6jzd8P/cN/57Z9yTni+lL2EK8AJ6Q7b1dCyiCl2hxo6vVjsmQJsGIcDHA7my6Y3DwFxBvmnbjOqh/GpTk/Z1zOyINBTmP/an5JGPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728813350; c=relaxed/simple;
	bh=YHPZ9HiYk7Nmr2TKI3svodLUHbz2SvWcrN7V2Xi/ln8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjkDUDVQ+THH6f3KLJZPvV286LOQKqFMYHExyhLQkYFFvXl9zNTSo1h13nLA1F0SpRY4YACbPX6YH4nVU9hmgVMU4Yq/VPX6JqEhE440+AdbM5g3SMeF/+aBjQeGshFcR74qREERhUxbkp9Lfxvu+dyiYDY+rfGOk3iLpLkistg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikUsBYN7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728813349; x=1760349349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YHPZ9HiYk7Nmr2TKI3svodLUHbz2SvWcrN7V2Xi/ln8=;
  b=ikUsBYN7fjDc5gt6+ZbEWE0rbqQk7Hd+7JRPoL00Nj58bbNgULKTGrxz
   hBcLhSjsR48r7kCoLha8xjqbVWmas0tOb8VgWtQYSk+cbWS9vrwfB9hsR
   XFHGXRnK6a+jS0NydA55D7ji0yu40SrL0O0Ik9WONoHoAtXrwL+wpZKEG
   JfFB0P0NwgZQ2Pxr3rPTExF3AltGbLfLMdh9nRGj/zECNsxmquziKWH+x
   EUL9TPE9p0l2lv/kI3AFcJysOg72A9uvQZ70kFrSShuUfRh8vZCQ9+FcF
   VhPTzZ5J7Rase9q+F5EQXSP0EoUG3JrDAPwHh+99Zld00eocGeXi6XiFO
   g==;
X-CSE-ConnectionGUID: p6yMxEfmQv+OFA9VlWFMIw==
X-CSE-MsgGUID: okX6Q+1LS6aA/0v2Y5s7kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45646581"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45646581"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 02:55:47 -0700
X-CSE-ConnectionGUID: 5QuhQ/mXQVaASKUyPZhk6Q==
X-CSE-MsgGUID: lRhOdtMGSBKWB5HRI+PRKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="108051969"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Oct 2024 02:55:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szvK8-000EGp-1L;
	Sun, 13 Oct 2024 09:55:40 +0000
Date: Sun, 13 Oct 2024 17:54:43 +0800
From: kernel test robot <lkp@intel.com>
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
	mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 1/7] sched: warn for high latency with
 TIF_NEED_RESCHED_LAZY
Message-ID: <202410131726.Gi9qvUP8-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241013/202410131726.Gi9qvUP8-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410131726.Gi9qvUP8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410131726.Gi9qvUP8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/core.c:5528:27: error: call to undeclared function 'tif_need_resched_lazy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    5528 |         if ((!need_resched() && !tif_need_resched_lazy()) || !latency_warn_ms)
         |                                  ^
   kernel/sched/core.c:5528:27: note: did you mean 'tif_need_resched'?
   include/linux/thread_info.h:182:29: note: 'tif_need_resched' declared here
     182 | static __always_inline bool tif_need_resched(void)
         |                             ^
   1 error generated.


vim +/tif_need_resched_lazy +5528 kernel/sched/core.c

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

