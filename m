Return-Path: <linux-kernel+bounces-336064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC1897EEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EDB1F2260D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A519E828;
	Mon, 23 Sep 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9w/UAck"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A89F19CC0D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107116; cv=none; b=NQ0/g2RUqn6ZC+8eFlEbcNq/IcIvVRGfdXn/zRtM2IiICwufnYRnewaTnSQY0tZiM5oTbdpwmwhd922BocxAsn5+HLIGCqjN/KeswRndz9VF9ZZT8RikKPTZaTyKiBF/jHFx2rZE3QOryXaz6Lw1rJdUrau4NFV53JWHC1u6UFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107116; c=relaxed/simple;
	bh=dB/s03J1ijWZEItzL1EbaJOmrjSCtJOL2i697tdgEgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE4tUlKmCj6AM/pkmfN7/aF7QeTlV9X67WvGKn+n0rEd4OD6EXESnhrL6bGx8113nX6wPmM3R7y+0gu9H8p99YTlM6MYttsQ7YgD9kPMQ+5E9UpJmNJPlqtpfeTZmzg/B83n66Rde3ACCUP5pL/tV8hRWKCDgcoQR6/Dc/H+q9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9w/UAck; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727107114; x=1758643114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dB/s03J1ijWZEItzL1EbaJOmrjSCtJOL2i697tdgEgA=;
  b=W9w/UAck5F4nei10BoMeamooOcSeSrXx0CbFpfo75FRA1A1zmedb4fR2
   fJNBeQtD5j6Xs1b6F7wXxOX2fTFjROy2xxjdRKUalasHtQGpQxZnrFLA6
   UW6l5ah8jTGd0ZdYQOCybpX8G2Ek2f5GhivpZohShhM2Cs867woJGrM/5
   sHsLAJ4mu3pWGEJXLSpi51qmbX12AjajJROK6MYPll8vGojetCtJRTtX7
   RhVplBnRZAi+MC/1e7mJsuJdGqtkzR4wRTikNXNQQQTymZ7TWbRurvBFV
   5GNZI7LbL/AbbQ5z5hAki/qW41ueGkOWxwADLSI+EWo51bpm0pIMAwgbR
   g==;
X-CSE-ConnectionGUID: DKuo5mP8QIejA6ozzVJpXw==
X-CSE-MsgGUID: xUuDPVkNQaOwne+1mIT/rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29785879"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="29785879"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 08:58:33 -0700
X-CSE-ConnectionGUID: pxoA7IRaQyuYaeZfnDCn0Q==
X-CSE-MsgGUID: 9SFeaq//T+eJh+7O7ro38w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="75870740"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 23 Sep 2024 08:58:31 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sslSG-000HLQ-37;
	Mon, 23 Sep 2024 15:58:28 +0000
Date: Mon, 23 Sep 2024 23:57:51 +0800
From: kernel test robot <lkp@intel.com>
To: Bruno Sobreira =?iso-8859-1?Q?Fran=E7a?= <brunofrancadevsec@gmail.com>,
	akpm@linux-foundation.org, davidgow@google.com,
	linux-kernel@vger.kernel.org, rmoar@google.com
Cc: oe-kbuild-all@lists.linux.dev, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Bruno Sobreira =?iso-8859-1?Q?Fran=E7a?= <brunofrancadevsec@gmail.com>
Subject: Re: [PATCH] lib/math: Add int_log test suite
Message-ID: <202409232338.5jngSmX9-lkp@intel.com>
References: <20240922172549.159928-1-brunofrancadevsec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922172549.159928-1-brunofrancadevsec@gmail.com>

Hi Bruno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240920]
[also build test WARNING on linus/master]
[cannot apply to akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything v6.11 v6.11-rc7 v6.11-rc6 v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bruno-Sobreira-Fran-a/lib-math-Add-int_log-test-suite/20240923-012721
base:   next-20240920
patch link:    https://lore.kernel.org/r/20240922172549.159928-1-brunofrancadevsec%40gmail.com
patch subject: [PATCH] lib/math: Add int_log test suite
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240923/202409232338.5jngSmX9-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409232338.5jngSmX9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409232338.5jngSmX9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/alpha/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/kref.h:16,
                    from include/kunit/test.h:22,
                    from lib/math/tests/int_log_kunit.c:2:
>> include/linux/limits.h:25:25: warning: conversion from 'long long unsigned int' to 'unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
      25 | #define U64_MAX         ((u64)~0ULL)
         |                         ^
   lib/math/tests/int_log_kunit.c:22:10: note: in expansion of macro 'U64_MAX'
      22 |         {U64_MAX, 536870911, "Log base 2 of MAX"},
         |          ^~~~~~~
>> include/linux/limits.h:25:25: warning: conversion from 'long long unsigned int' to 'unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
      25 | #define U64_MAX         ((u64)~0ULL)
         |                         ^
   lib/math/tests/int_log_kunit.c:33:10: note: in expansion of macro 'U64_MAX'
      33 |         {U64_MAX, 161614247, "Log base 10 of MAX"}
         |          ^~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
   Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
   Selected by [y]:
   - TI_K3_M4_REMOTEPROC [=y] && REMOTEPROC [=y] && (ARCH_K3 || COMPILE_TEST [=y])


vim +25 include/linux/limits.h

3c9d017cc283df Andy Shevchenko 2023-08-04  14  
54d50897d544c8 Masahiro Yamada 2019-03-07  15  #define U8_MAX		((u8)~0U)
54d50897d544c8 Masahiro Yamada 2019-03-07  16  #define S8_MAX		((s8)(U8_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  17  #define S8_MIN		((s8)(-S8_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  18  #define U16_MAX		((u16)~0U)
54d50897d544c8 Masahiro Yamada 2019-03-07  19  #define S16_MAX		((s16)(U16_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  20  #define S16_MIN		((s16)(-S16_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  21  #define U32_MAX		((u32)~0U)
3f50f132d8400e John Fastabend  2020-03-30  22  #define U32_MIN		((u32)0)
54d50897d544c8 Masahiro Yamada 2019-03-07  23  #define S32_MAX		((s32)(U32_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  24  #define S32_MIN		((s32)(-S32_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07 @25  #define U64_MAX		((u64)~0ULL)
54d50897d544c8 Masahiro Yamada 2019-03-07  26  #define S64_MAX		((s64)(U64_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  27  #define S64_MIN		((s64)(-S64_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  28  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

