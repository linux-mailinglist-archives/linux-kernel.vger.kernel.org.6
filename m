Return-Path: <linux-kernel+bounces-259569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9783C93989B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2111F220AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8355013B7A6;
	Tue, 23 Jul 2024 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDVOko3j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20E8814
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721704696; cv=none; b=Gc74qB8tRfBE0cCOqG9/HK6toqzVH0HxXIxMR0yEiENH+YieV1shJWnWNKv8IKz2eWwhvFuHZ3cSb50k6EbPPaYmlDQPYQpOQlA8AubRl5rxk37v6VV/vCMrqZqj8mkrFop9pUeTmp+Yo16k7yNRFtZmKSmPvz7nLCRDlPF2S00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721704696; c=relaxed/simple;
	bh=UZvKV/N2MmpA7QaJlPL9o52SDXf1Cg5eic8FeDJGkSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVRPKUUsuTjydoqDE84n2kYueA6/IGlaCZsR8Rup/ad/yx/01H84bwLTJAgMTo6IaSHpyaEwEfAqWNLNMKvwg9/nkUjRbADba3ibeH7VcRCHzl0iOkaeo4ZNXSxLDUK6PJm1iNjkjIdLlRk3D3c43sbMX4zk+hiWDPJBQss+Sw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDVOko3j; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721704695; x=1753240695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UZvKV/N2MmpA7QaJlPL9o52SDXf1Cg5eic8FeDJGkSE=;
  b=DDVOko3j+3O6/YhPIwlA2291qbF+ux/oEE8ZiE3n8kduMlL/xCmze+Qc
   kCc5mA4acuGvoMsw00XspsUT7GB/3wa3sVdBbAjNuN5qcKizHNYv6QMWm
   J9EnGYksZnZtm/ys8tv4ONE7r+cPuyXbdZHmsxGgjvAJ95r6gLXwMvzlB
   Ms3TBZUtKf2q8FKp5g8nwe9HRkybUlF9j6u9HYN6VaL31cnXfLYGuRRp6
   uyjJTabC4gcvxNMDwWDRWyGD6XNZ7dtf0KOfga6X6Am9jjEkYbrP/P8Vv
   vYFvSPMC+zNRfAusmF42P1vzOikI3OJ3md2qJfkamCaiSYOIOV6DdAo9B
   g==;
X-CSE-ConnectionGUID: ctguzSnWREuUmQw0Lkbqgw==
X-CSE-MsgGUID: BpzemhJVT9aHEIV15lH0lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30693863"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30693863"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 20:18:14 -0700
X-CSE-ConnectionGUID: 7O0cQ0plTaG+4IIdNJDn0A==
X-CSE-MsgGUID: Ogpr5fJoQ42xIxKBxBm2vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="82714322"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Jul 2024 20:18:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sW62T-000lbA-0A;
	Tue, 23 Jul 2024 03:18:09 +0000
Date: Tue, 23 Jul 2024 11:18:08 +0800
From: kernel test robot <lkp@intel.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 11/19] printk: nbcon: Rely on kthreads for
 normal operation
Message-ID: <202407231117.SngBfEcI-lkp@intel.com>
References: <20240722171939.3349410-12-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-12-john.ogness@linutronix.de>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on b18703ea7157f62f02eb0ceb11f6fa0138e90adc]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/printk-nbcon-Clarify-nbcon_get_default_prio-context/20240723-015154
base:   b18703ea7157f62f02eb0ceb11f6fa0138e90adc
patch link:    https://lore.kernel.org/r/20240722171939.3349410-12-john.ogness%40linutronix.de
patch subject: [PATCH printk v3 11/19] printk: nbcon: Rely on kthreads for normal operation
config: x86_64-buildonly-randconfig-002-20240723 (https://download.01.org/0day-ci/archive/20240723/202407231117.SngBfEcI-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407231117.SngBfEcI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407231117.SngBfEcI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/printk/printk.c:62:
   kernel/printk/internal.h: In function 'printk_get_console_flush_type':
   kernel/printk/internal.h:219:26: error: implicit declaration of function 'is_printk_deferred'; did you mean '_printk_deferred'? [-Werror=implicit-function-declaration]
     219 |    if (prefer_offload || is_printk_deferred())
         |                          ^~~~~~~~~~~~~~~~~~
         |                          _printk_deferred
   kernel/printk/printk.c: In function 'resume_console':
>> kernel/printk/printk.c:2706:3: error: implicit declaration of function 'nbcon_wake_kthreads'; did you mean 'irq_wake_thread'? [-Werror=implicit-function-declaration]
    2706 |   nbcon_wake_kthreads();
         |   ^~~~~~~~~~~~~~~~~~~
         |   irq_wake_thread
   cc1: some warnings being treated as errors


vim +2706 kernel/printk/printk.c

  2683	
  2684	void resume_console(void)
  2685	{
  2686		struct console_flush_type ft;
  2687		struct console *con;
  2688	
  2689		if (!console_suspend_enabled)
  2690			return;
  2691	
  2692		console_list_lock();
  2693		for_each_console(con)
  2694			console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
  2695		console_list_unlock();
  2696	
  2697		/*
  2698		 * Ensure that all SRCU list walks have completed. All printing
  2699		 * contexts must be able to see they are no longer suspended so
  2700		 * that they are guaranteed to wake up and resume printing.
  2701		 */
  2702		synchronize_srcu(&console_srcu);
  2703	
  2704		printk_get_console_flush_type(&ft, true);
  2705		if (ft.nbcon_offload)
> 2706			nbcon_wake_kthreads();
  2707	
  2708		pr_flush(1000, true);
  2709	}
  2710	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

