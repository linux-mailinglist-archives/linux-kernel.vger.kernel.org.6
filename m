Return-Path: <linux-kernel+bounces-425131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A49DBDB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67983163E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27D01C4A2B;
	Thu, 28 Nov 2024 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWr23lqS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7381C460D;
	Thu, 28 Nov 2024 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732834257; cv=none; b=s0MY/AJ+oARMM7JEgcLZrjfG3kSHrspVN62XkaV7cwJNSYjVXXcNZUAYqc4AAClhlyc5UvKA2fc1x9h6aQDFtTmO1XMWdPoTQO3wAZ01DDwBlTZmp9OuMACR8WkhEUbXsaFhf+S9DFEMQNCQfjtpJiJJeq0LbEMiyOf19j9S1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732834257; c=relaxed/simple;
	bh=JOS69uGNLVpH/BajOYW6TKf29XQWgQbq6B8dgGzoYDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4AoqNNrCQSEqTWXgYVpOlL1Ybp1+ZlKTC+Rx5cSWScM/uN5ioVHoT8WD6qMIX3pPd1lUsoBDwm0BgTkPEFPdGmX85d9DYMSPPZHWJFO3FBybh6I+cr5e4+M9Ni8oRKvQJ76DFYm9uoPRITR0krwy0awTcGAekohoxL/SpVIWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWr23lqS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732834255; x=1764370255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JOS69uGNLVpH/BajOYW6TKf29XQWgQbq6B8dgGzoYDM=;
  b=aWr23lqS8HMXa//ZdurtyIV0OwOjYE5eL/ZH4tRuEFWqxpLt2AgAZXEm
   fWKcrLio+Dtz2moJ6kOFr93dLBTitFAwDzushE4OVlKkvf43VxYDLl4y6
   ifKLdtUT4uS584+jEuqeCYpaN9qK8Ni/r98Ii8JVmYS6brEpTAM8Uotbc
   9Db23NQ9I5GJtC2xQbedUh8B8Co89FtRPWlYan0U5lPbbZzTkZEGROamx
   GYdv1J+3z3NFK8cyHurg+Ci2vh0Qm/NDGNkyZY7IrfL3OUDZmkq8SrRQr
   SJotYlmPXb8jiF1Gs2Wtj+J920OLJqb9kZI2JNpzOUgsKIpb/ZZQnpOOz
   Q==;
X-CSE-ConnectionGUID: xJCJbCiJR+yRr5YGP59UjQ==
X-CSE-MsgGUID: n0R1yBpbQhO/X8pBAUVfSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="32435531"
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="32435531"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 14:50:48 -0800
X-CSE-ConnectionGUID: s4aDQT6kRgmK5zYlsPbnww==
X-CSE-MsgGUID: uw0BfONeTFGw5l84jiVlOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="96420623"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Nov 2024 14:50:40 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGnLJ-000A7P-1X;
	Thu, 28 Nov 2024 22:50:37 +0000
Date: Fri, 29 Nov 2024 06:50:24 +0800
From: kernel test robot <lkp@intel.com>
To: Armin Wolf <W_Armin@gmx.de>, jlee@suse.com, farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] platform/x86: acer-wmi: Implement proper hwmon
 support
Message-ID: <202411290611.AQz0KQ2z-lkp@intel.com>
References: <20241128145104.13538-5-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128145104.13538-5-W_Armin@gmx.de>

Hi Armin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Armin-Wolf/platform-x86-acer-wmi-Add-support-for-Acer-PH14-51/20241128-225534
base:   linus/master
patch link:    https://lore.kernel.org/r/20241128145104.13538-5-W_Armin%40gmx.de
patch subject: [PATCH v2 4/5] platform/x86: acer-wmi: Implement proper hwmon support
config: i386-buildonly-randconfig-004-20241129 (https://download.01.org/0day-ci/archive/20241129/202411290611.AQz0KQ2z-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411290611.AQz0KQ2z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411290611.AQz0KQ2z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/platform/x86/acer-wmi.c:19:
   In file included from include/linux/backlight.h:13:
   In file included from include/linux/fb.h:5:
   In file included from include/uapi/linux/fb.h:6:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   include/linux/bitfield.h:156:30: note: expanded from macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
>> drivers/platform/x86/acer-wmi.c:2786:32: warning: shift count is negative [-Wshift-count-negative]
    2786 |         supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
         |                             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/acer-wmi.c:77:53: note: expanded from macro 'ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK'
      77 | #define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
         |                                                     ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   include/linux/bitfield.h:156:50: note: expanded from macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                                       ~~~~~~~~~^~~~~~
   include/linux/bitfield.h:45:38: note: expanded from macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   12 warnings generated.


vim +2786 drivers/platform/x86/acer-wmi.c

  2773	
  2774	static int acer_wmi_hwmon_init(void)
  2775	{
  2776		struct device *dev = &acer_platform_device->dev;
  2777		struct device *hwmon;
  2778		u64 result;
  2779		int ret;
  2780	
  2781		ret = WMID_gaming_get_sys_info(ACER_WMID_CMD_GET_PREDATOR_V4_SUPPORTED_SENSORS, &result);
  2782		if (ret < 0)
  2783			return ret;
  2784	
  2785		/* Return early if no sensors are available */
> 2786		supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
  2787		if (!supported_sensors)
  2788			return 0;
  2789	
  2790		hwmon = devm_hwmon_device_register_with_info(dev, "acer",
  2791							     &supported_sensors,
  2792							     &acer_wmi_hwmon_chip_info,
  2793							     NULL);
  2794	
  2795		if (IS_ERR(hwmon)) {
  2796			dev_err(dev, "Could not register acer hwmon device\n");
  2797			return PTR_ERR(hwmon);
  2798		}
  2799	
  2800		return 0;
  2801	}
  2802	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

