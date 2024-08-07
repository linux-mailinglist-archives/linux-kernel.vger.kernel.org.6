Return-Path: <linux-kernel+bounces-278343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CEE94AEF1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93D71C21A7E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DCD13D29A;
	Wed,  7 Aug 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ujdgo5zX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC113C9A2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051946; cv=none; b=llI8bwwAInBVXUFJ/WolOTYBs9U/hy90I3hSKwCHOkOG+8rJtROFffGkm3TuMbdZrzhiCnePGGixD5+gokviAgcRdbIBUb/NjmUR3dmTpy+HvSI2XrvexyjzbvPdQj1TqVNupTY3O17eQaBRv58wNgXnRNvBRhk84urI9Maviog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051946; c=relaxed/simple;
	bh=1sYHixPrcIYTFR1PPKPLG9fQCGuPqk/uaaGBNPfk0QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibwnqDZxLwjhJtLTZkF79SFqBTrkE3zhGvXMAL/fAUWuZUnpUs5Di4jir8WZi9V9ALOWkLZN8CTUuLkhhvzApKMUdldjmQg4fA2mvCzf461xhqIJdcvaCsmHmJaFs2Q+/FuaKINb47ACvmrUaTuYq0VaSKMmXdMvPg0AuoA+K8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ujdgo5zX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723051944; x=1754587944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1sYHixPrcIYTFR1PPKPLG9fQCGuPqk/uaaGBNPfk0QQ=;
  b=Ujdgo5zXlpkN2HTb+1PB7AppgqEWfUg8X3iFbsVgYC8kvTzx0P77yFX+
   kJBtkZQaLzjwgwXiXMlU0Dj8NiMQ6urf/1DzK8x15Dhaq79ZhCrcHEgJ6
   IjTtj5lNECSgcqWZDjgRNRjPk2SFpSdFPf0TzcSqQVj4JqGXuuiwJG8kC
   TFv5eEzQj7qUJ6v6HaPe7b7CU9YeDNfQeoRaBekcap09FJE6OMJM3+T0K
   5U79rwNGmx5iPbusvRqA1GgitUe/tRoMLMuhcLlezcoklguRm71XWL0uy
   +yo476X4ysA+MhpmYqaIvqCCVXo9w5+Rq8x84X+hO5WY6VuyyTTDkFW7+
   A==;
X-CSE-ConnectionGUID: T2Q6OzA0QeaG4FAsjYi4jA==
X-CSE-MsgGUID: 5PeEN110RYOSk3yVfgzkvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="12905614"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="12905614"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 10:32:23 -0700
X-CSE-ConnectionGUID: tPmdtRHERJuo17M6CtE6Ag==
X-CSE-MsgGUID: hVo4n/qdRL2sVKCQf+RyLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="94500080"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Aug 2024 10:32:19 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbkWH-0005bQ-0H;
	Wed, 07 Aug 2024 17:32:17 +0000
Date: Thu, 8 Aug 2024 01:31:54 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, peterz@infradead.org
Cc: oe-kbuild-all@lists.linux.dev, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Bin Lai <laib2@chinatelecom.cn>
Subject: Re: [PATCH next] sched: make printk safe when rq lock is held
Message-ID: <202408080114.hpttUZjC-lkp@intel.com>
References: <20240806074131.36007-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806074131.36007-1-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240806]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/sched-make-printk-safe-when-rq-lock-is-held/20240806-155153
base:   next-20240806
patch link:    https://lore.kernel.org/r/20240806074131.36007-1-dongml2%40chinatelecom.cn
patch subject: [PATCH next] sched: make printk safe when rq lock is held
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240808/202408080114.hpttUZjC-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080114.hpttUZjC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080114.hpttUZjC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/core.c:88:
   kernel/sched/sched.h: In function 'rq_pin_lock':
>> kernel/sched/sched.h:1705:9: error: implicit declaration of function '__printk_safe_enter'; did you mean '__printk_deferred_enter'? [-Wimplicit-function-declaration]
    1705 |         __printk_safe_enter();
         |         ^~~~~~~~~~~~~~~~~~~
         |         __printk_deferred_enter
   kernel/sched/sched.h: In function 'rq_unpin_lock':
>> kernel/sched/sched.h:1722:9: error: implicit declaration of function '__printk_safe_exit'; did you mean '__printk_ratelimit'? [-Wimplicit-function-declaration]
    1722 |         __printk_safe_exit();
         |         ^~~~~~~~~~~~~~~~~~
         |         __printk_ratelimit


vim +1705 kernel/sched/sched.h

  1690	
  1691	/*
  1692	 * Lockdep annotation that avoids accidental unlocks; it's like a
  1693	 * sticky/continuous lockdep_assert_held().
  1694	 *
  1695	 * This avoids code that has access to 'struct rq *rq' (basically everything in
  1696	 * the scheduler) from accidentally unlocking the rq if they do not also have a
  1697	 * copy of the (on-stack) 'struct rq_flags rf'.
  1698	 *
  1699	 * Also see Documentation/locking/lockdep-design.rst.
  1700	 */
  1701	static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
  1702	{
  1703		rf->cookie = lockdep_pin_lock(__rq_lockp(rq));
  1704	
> 1705		__printk_safe_enter();
  1706	#ifdef CONFIG_SCHED_DEBUG
  1707		rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
  1708		rf->clock_update_flags = 0;
  1709	# ifdef CONFIG_SMP
  1710		SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
  1711	# endif
  1712	#endif
  1713	}
  1714	
  1715	static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
  1716	{
  1717	#ifdef CONFIG_SCHED_DEBUG
  1718		if (rq->clock_update_flags > RQCF_ACT_SKIP)
  1719			rf->clock_update_flags = RQCF_UPDATED;
  1720	#endif
  1721	
> 1722		__printk_safe_exit();
  1723		lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
  1724	}
  1725	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

