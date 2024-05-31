Return-Path: <linux-kernel+bounces-196078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ECC8D56ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5CB286ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327428F0;
	Fri, 31 May 2024 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bejbmjxW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D3139E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115308; cv=none; b=aexxmCEPqUbKF0V+ep8A8elreioAp7Sb4drUMjKZcBhjAFqaVRu3F4GO+s65tt1YMAy5wrre8Wh2bzFjUA4FaABvHdFi6b8zzcXUJeXJSZBZ81qRiek/s5kaON61sF0ck1x5gQBiBfIo9A2OXGZFDVODxkIzA/V+bH/1fE7k/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115308; c=relaxed/simple;
	bh=ed4Jpucv0SyK9RYrWVa8iEpWUZbW+UIPQj2RL5LdfHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0NrX27+mmdOAj2pGqQ2CAAFxr+tSnOeZCmQwLHmnNOPpebxHnCrSNSlgKa6LLEYNrr/27AMmrZAJlacD0B1LJWxiDB/4CuyZJawOKyVa+GxHo0k9MMghjYXGECj6/8VNv1243zaLjEmE+l3fg7MWcZLNpQmioFAtO3tPRqdSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bejbmjxW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717115306; x=1748651306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ed4Jpucv0SyK9RYrWVa8iEpWUZbW+UIPQj2RL5LdfHs=;
  b=bejbmjxWTPGtlYWfqbVq21K4NEU/EVsIVad801ayGzaxjGx09klJuXEp
   m0tsxqpCHlSnne7i6YuT5X7qCfzmIKeVPac92jRBR7ZJk8fXRf9QIVFOx
   dP4e4wSknnawH+rBHfxxnofCk6AN0RELvnNRKpFykJv4jsSWS5Na5JxdC
   3L4RcrugNegBVTYlY+4++Q244nOfPuScrbqArGC0zvu95/73obE0kFiKX
   UXsol494zgrg0uIWSNUrlMtVBrqIMLD+4sMkZr6VR17cMdBbw9p7PNIJl
   NDdRIjo+uY7vmJgQJkw12f8UKsC6lxFoPaHDnnqPW/R5WNORRfj2A7ij3
   A==;
X-CSE-ConnectionGUID: uHPZWG7qRqqb0QH54mg6Wg==
X-CSE-MsgGUID: IGlRC8dWRvunma8uIXhb9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31174573"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31174573"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 17:28:25 -0700
X-CSE-ConnectionGUID: WF8e6GNVSjuElKXSRK+MiQ==
X-CSE-MsgGUID: JlzRA6JwQ5a6fgbBAyUHSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="73477419"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2024 17:28:23 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCq85-000GH7-0C;
	Fri, 31 May 2024 00:28:21 +0000
Date: Fri, 31 May 2024 08:28:14 +0800
From: kernel test robot <lkp@intel.com>
To: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick: shift tick_nohz_switch_to_nohz() from
 tick_check_oneshot_change() to hrtimer_run_queues()
Message-ID: <202405310818.JPmNHEjC-lkp@intel.com>
References: <20240530124203.GA26990@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530124203.GA26990@redhat.com>

Hi Oleg,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linus/master v6.10-rc1 next-20240529]
[cannot apply to tip/timers/nohz]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleg-Nesterov/tick-shift-tick_nohz_switch_to_nohz-from-tick_check_oneshot_change-to-hrtimer_run_queues/20240530-204940
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20240530124203.GA26990%40redhat.com
patch subject: [PATCH] tick: shift tick_nohz_switch_to_nohz() from tick_check_oneshot_change() to hrtimer_run_queues()
config: i386-randconfig-001-20240531 (https://download.01.org/0day-ci/archive/20240531/202405310818.JPmNHEjC-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405310818.JPmNHEjC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405310818.JPmNHEjC-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/time/hrtimer.o: in function `hrtimer_run_queues':
>> kernel/time/hrtimer.c:1898:(.text+0x1e71): undefined reference to `tick_nohz_switch_to_nohz'


vim +1898 kernel/time/hrtimer.c

  1874	
  1875	/*
  1876	 * Called from run_local_timers in hardirq context every jiffy
  1877	 */
  1878	void hrtimer_run_queues(void)
  1879	{
  1880		struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
  1881		unsigned long flags;
  1882		ktime_t now;
  1883	
  1884		if (hrtimer_hres_active(cpu_base))
  1885			return;
  1886	
  1887		/*
  1888		 * This _is_ ugly: We have to check periodically, whether we
  1889		 * can switch to highres and / or nohz mode. The clocksource
  1890		 * switch happens with xtime_lock held. Notification from
  1891		 * there only sets the check bit in the tick_oneshot code,
  1892		 * otherwise we might deadlock vs. xtime_lock.
  1893		 */
  1894		if (tick_check_oneshot_change()) {
  1895			if (hrtimer_is_hres_enabled())
  1896				hrtimer_switch_to_hres();
  1897			else
> 1898				tick_nohz_switch_to_nohz();
  1899			return;
  1900		}
  1901	
  1902		raw_spin_lock_irqsave(&cpu_base->lock, flags);
  1903		now = hrtimer_update_base(cpu_base);
  1904	
  1905		if (!ktime_before(now, cpu_base->softirq_expires_next)) {
  1906			cpu_base->softirq_expires_next = KTIME_MAX;
  1907			cpu_base->softirq_activated = 1;
  1908			raise_softirq_irqoff(HRTIMER_SOFTIRQ);
  1909		}
  1910	
  1911		__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
  1912		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
  1913	}
  1914	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

