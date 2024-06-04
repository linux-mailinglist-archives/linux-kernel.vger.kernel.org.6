Return-Path: <linux-kernel+bounces-200049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAF98FA9D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F42271F25270
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EFD13E3ED;
	Tue,  4 Jun 2024 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMX24+bz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837A2F30;
	Tue,  4 Jun 2024 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717478122; cv=none; b=dBceCGwEv92BxLPItgBXf9KNW0sQfQ6dl/rhMUl97pDZuOGLs+7xkgte7+g5K6GG5H+zB3TWKEGR4FmnceP6jMUv8fsYFGW0Cg1JPhED9gVeyVXm8xs/yHSfzGKi40aHRtk4FYc+6vF6TerUd6Kppxc0nSZdebhaGaGTs3S7oZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717478122; c=relaxed/simple;
	bh=lUmoE2h7on96Ze4BJEmx9oqYgA+3okzfnG7hd7pvlEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH/BwPjhLC2CNYFVlEKnJkztBYKxN7ZUeiNPzRFZ/sX9MlkAKPoghbmM1hjkGgPWZ2KVLPZ4s1p9VLCnR5xmIz1xrl3C9kQ094L7SVECOOqWuJQN2jkrJm+wAlGhyQQJ5yUP7fplAQ9atsFg8qclD2SjjG5JQBBLlngT/3zYWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMX24+bz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717478119; x=1749014119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lUmoE2h7on96Ze4BJEmx9oqYgA+3okzfnG7hd7pvlEo=;
  b=OMX24+bzD5t1FG9TYd5tpcNitSZ5V0i7Wc3z1NwNohB8BY2w454bi2Q1
   TiGvWet0WnIIQ0RfFHIGCuyRH32v5KujXVpvll7ICbX7e86cIWODaVv9O
   5kxxASA7LMXpJbmvRsnVPH8yVLzduJAag9mCVZUAVtsMAy67BLKtj3RGZ
   10chY8m2D7QJ3rTp6slXC13LOZ+2pP1ZzGhI4s/QLQh0W7znFmHp3R/1J
   AlrRu2/Va4wlVTGD8xDHaEN6jW8EPzyyjrlFs/h8pDGeBciaK00dVTlwO
   3HlCxkoTm+NFCVV6Yr08FpWhefZ1DxKcyDjPZWp0vJYBJAbB93gBd5PO5
   w==;
X-CSE-ConnectionGUID: ASQ7DeiwSr6TMtC0aSW3AA==
X-CSE-MsgGUID: xxgdSHOXRLqb+dvHCoPjCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="16936935"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="16936935"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 22:15:19 -0700
X-CSE-ConnectionGUID: 1ts3JVyVRJm6LjGspCaPNw==
X-CSE-MsgGUID: XKQy4maXTESA/roqU8kpEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37172721"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 03 Jun 2024 22:15:17 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEMVu-000MbD-0B;
	Tue, 04 Jun 2024 05:15:14 +0000
Date: Tue, 4 Jun 2024 13:14:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Luke D. Jones" <luke@ljones.dev>, hdegoede@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: Re: [PATCH 3/9] platform/x86: asus-wmi: add macros and expose
 min/max sysfs for ppt tunables
Message-ID: <202406041330.25g44UcT-lkp@intel.com>
References: <20240528013626.14066-4-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528013626.14066-4-luke@ljones.dev>

Hi Luke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10-rc2 next-20240603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luke-D-Jones/platform-x86-asus-wmi-add-debug-print-in-more-key-places/20240528-094139
base:   linus/master
patch link:    https://lore.kernel.org/r/20240528013626.14066-4-luke%40ljones.dev
patch subject: [PATCH 3/9] platform/x86: asus-wmi: add macros and expose min/max sysfs for ppt tunables
config: x86_64-randconfig-006-20240604 (https://download.01.org/0day-ci/archive/20240604/202406041330.25g44UcT-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406041330.25g44UcT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406041330.25g44UcT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/x86/asus-wmi.c: In function 'init_rog_tunables':
>> drivers/platform/x86/asus-wmi.c:4508:13: warning: argument 1 null where non-null expected [-Wnonnull]
    4508 |         if (strstr(product, "GA402R")) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/platform/x86/asus-wmi.c:16:
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4510:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4510 |         } else if (strstr(product, "13QY")) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4512:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4512 |         } else if (strstr(product, "X13")) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4515:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4515 |         } else if (strstr(product, "RC71")) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4518:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4518 |         } else if (strstr(product, "G814")
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4519:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4519 |                 || strstr(product, "G614")
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4520:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4520 |                 || strstr(product, "G834")
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4521:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4521 |                 || strstr(product, "G634")) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4523:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4523 |         } else if (strstr(product, "GA402X")
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4524:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4524 |                 || strstr(product, "GA403")
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4525:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4525 |                 || strstr(product, "FA507N")
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4526:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4526 |                 || strstr(product, "FA507X")
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4527:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4527 |                 || strstr(product, "FA707N")
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4528:20: warning: argument 1 null where non-null expected [-Wnonnull]
    4528 |                 || strstr(product, "FA707X")) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~
   drivers/platform/x86/asus-wmi.c:4532:13: warning: argument 1 null where non-null expected [-Wnonnull]
    4532 |         if (strstr(product, "GZ301ZE"))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:190:15: note: in a call to function 'strstr' declared 'nonnull'
     190 | extern char * strstr(const char *, const char *);
         |               ^~~~~~


vim +4508 drivers/platform/x86/asus-wmi.c

  4491	
  4492	/* Set up the min/max and defaults for ROG tunables */
  4493	static void init_rog_tunables(struct asus_wmi *asus)
  4494	{
  4495		const char *product;
  4496		u32 max_boost = NVIDIA_BOOST_MAX;
  4497		u32 cpu_default = PPT_CPU_LIMIT_DEFAULT;
  4498		u32 cpu_max = PPT_CPU_LIMIT_MAX;
  4499		u32 platform_default = PPT_PLATFORM_DEFAULT;
  4500		u32 platform_max = PPT_PLATFORM_MAX;
  4501	
  4502		/*
  4503		 * ASUS product_name contains everything required, e.g,
  4504		 * "ROG Flow X16 GV601VV_GV601VV_00185149B"
  4505		 */
  4506		product = dmi_get_system_info(DMI_PRODUCT_NAME);
  4507	
> 4508		if (strstr(product, "GA402R")) {
  4509			cpu_default = 125;
  4510		} else if (strstr(product, "13QY")) {
  4511			cpu_max = 250;
  4512		} else if (strstr(product, "X13")) {
  4513			cpu_max = 75;
  4514			cpu_default = 50;
  4515		} else if (strstr(product, "RC71")) {
  4516			cpu_max = 50;
  4517			cpu_default = 30;
  4518		} else if (strstr(product, "G814")
  4519			|| strstr(product, "G614")
  4520			|| strstr(product, "G834")
  4521			|| strstr(product, "G634")) {
  4522			cpu_max = 175;
  4523		} else if (strstr(product, "GA402X")
  4524			|| strstr(product, "GA403")
  4525			|| strstr(product, "FA507N")
  4526			|| strstr(product, "FA507X")
  4527			|| strstr(product, "FA707N")
  4528			|| strstr(product, "FA707X")) {
  4529			cpu_max = 90;
  4530		}
  4531	
  4532		if (strstr(product, "GZ301ZE"))
  4533			max_boost = 5;
  4534		else if (strstr(product, "FX507ZC4"))
  4535			max_boost = 15;
  4536		else if (strstr(product, "GU605"))
  4537			max_boost = 20;
  4538	
  4539		/* ensure defaults for tunables */
  4540		asus->rog_tunables.cpu_default = cpu_default;
  4541		asus->rog_tunables.cpu_max = cpu_max;
  4542	
  4543		asus->rog_tunables.platform_default = platform_default;
  4544		asus->rog_tunables.platform_max = platform_max;
  4545	
  4546		asus->rog_tunables.ppt_pl1_spl = cpu_default;
  4547		asus->rog_tunables.ppt_pl2_sppt = cpu_default;
  4548		asus->rog_tunables.ppt_apu_sppt = cpu_default;
  4549	
  4550		asus->rog_tunables.ppt_platform_sppt = platform_default;
  4551		asus->rog_tunables.ppt_fppt = platform_default;
  4552	
  4553		asus->rog_tunables.nv_boost_default = NVIDIA_BOOST_MAX;
  4554		asus->rog_tunables.nv_boost_max = max_boost;
  4555		asus->rog_tunables.nv_dynamic_boost = NVIDIA_BOOST_MIN;
  4556	
  4557		asus->rog_tunables.nv_temp_default = NVIDIA_TEMP_MAX;
  4558		asus->rog_tunables.nv_temp_max = NVIDIA_TEMP_MAX;
  4559		asus->rog_tunables.nv_temp_target = NVIDIA_TEMP_MIN;
  4560	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

