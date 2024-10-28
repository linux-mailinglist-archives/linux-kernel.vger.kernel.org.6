Return-Path: <linux-kernel+bounces-384984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2686B9B310F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577D11C21A19
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D431DAC9B;
	Mon, 28 Oct 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cr5xaZRw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748601D6DAA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119925; cv=none; b=LVhGbwKj6lyCg5FrLanfRHe7IZvnoGeNXN/BvOPqYk6/Pvuvl7bWBT4lEdkckw+w+8QrORX2OGgPxdlv2vFkohg2z86WC1ym/RibONzFC081qSRKppgmdZAghzALj+p+c2XSiwdgbQAiBL5aO7pqu6u7tJXDvLkVGOw9RNQ8aao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119925; c=relaxed/simple;
	bh=lHtLE0bBixwRmL7ku67G8EDLRbN6VpOH8UXj8eQIdog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiZciaW/GPgKFleWy9vvzfgExYggpF2UpnCmiX8KJytaBVlprchjHSZNYl8nQYPtR9Zauk+pxMSXxjLHZWSUTLrrzul3V5tl90lguLmh23783yqceDcMJG3d4d/5ngKDOrdcsc7Hyd66VNLo3nB4B23niWVhHMlolhCUAi2rf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cr5xaZRw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730119923; x=1761655923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lHtLE0bBixwRmL7ku67G8EDLRbN6VpOH8UXj8eQIdog=;
  b=cr5xaZRwlwGkLV6mDuC5h71agAUMC313XXpKl4DGCEKBK1RH1AIsFIF5
   AD1pBUnNXe5rJ5EyaxTD3NS9hfdo/8BOZfnxWO7lxtaCjg4vQWiO5teG9
   NjKxFd3Ufn5K+4Kf1GYEV+6fb6K5OKfc1pk2viRl690g1Vwc04sr2MrNW
   iCQgo6Qbm9gO7NPDhN6qvb+We/etpj27HxzDj4gMmgOlanLWXUx7zbWj1
   wqUg/+yY2zjyqZPYlJdunRHm4GGNJrwxTJqh90hKsu+4yhnyKOf+afMqr
   Cpdq+10MbIay99OhresaxTsyr9r3s6DgpKdkpIgSzB6+c0Uf5UaEY5+20
   Q==;
X-CSE-ConnectionGUID: 2Br91YAfQSmgSS4oSXSRkQ==
X-CSE-MsgGUID: +ptvCaKZQh6CePeLfML+HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29616442"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29616442"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 05:52:03 -0700
X-CSE-ConnectionGUID: 1XpDT2XYR4eLn68FxudjqQ==
X-CSE-MsgGUID: AP86cmEWTi2wtLhcXhCHkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112442431"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Oct 2024 05:52:00 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5PDy-000cRk-1j;
	Mon, 28 Oct 2024 12:51:58 +0000
Date: Mon, 28 Oct 2024 20:51:21 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Nam Cao <namcao@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/31] sched: Switch to use hrtimer_setup()
Message-ID: <202410282033.n74LbYyl-lkp@intel.com>
References: <f83c7ad9954fce1f84eaec94bb7b58f5f6974fc4.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83c7ad9954fce1f84eaec94bb7b58f5f6974fc4.1729864823.git.namcao@linutronix.de>

Hi Nam,

kernel test robot noticed the following build errors:

[auto build test ERROR on kvm/queue]
[also build test ERROR on tip/sched/core perf-tools-next/perf-tools-next tip/perf/core perf-tools/perf-tools tip/timers/core axboe-block/for-next]
[cannot apply to linus/master kvm/linux-next acme/perf/core v6.12-rc5 next-20241028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/KVM-MIPS-Switch-to-use-hrtimer_setup/20241028-154142
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/f83c7ad9954fce1f84eaec94bb7b58f5f6974fc4.1729864823.git.namcao%40linutronix.de
patch subject: [PATCH 13/31] sched: Switch to use hrtimer_setup()
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20241028/202410282033.n74LbYyl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241028/202410282033.n74LbYyl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410282033.n74LbYyl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:52:
   kernel/sched/rt.c: In function 'init_rt_bandwidth':
>> kernel/sched/rt.c:130:9: error: implicit declaration of function 'hrtimer_setup'; did you mean 'timer_setup'? [-Werror=implicit-function-declaration]
     130 |         hrtimer_setup(&rt_b->rt_period_timer, sched_rt_period_timer, CLOCK_MONOTONIC,
         |         ^~~~~~~~~~~~~
         |         timer_setup
   cc1: some warnings being treated as errors


vim +130 kernel/sched/rt.c

   122	
   123	void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime)
   124	{
   125		rt_b->rt_period = ns_to_ktime(period);
   126		rt_b->rt_runtime = runtime;
   127	
   128		raw_spin_lock_init(&rt_b->rt_runtime_lock);
   129	
 > 130		hrtimer_setup(&rt_b->rt_period_timer, sched_rt_period_timer, CLOCK_MONOTONIC,
   131			      HRTIMER_MODE_REL_HARD);
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

