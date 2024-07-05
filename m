Return-Path: <linux-kernel+bounces-241917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44C992812F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786FF285AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9961FF0;
	Fri,  5 Jul 2024 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtbwNWY4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342672B9A4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720152831; cv=none; b=rssABKmFmxtTT6z4I9z97anYaMTaPUCx7T1l7jiP6iob4pN8AtcJysGFFw45E8ViStXAgTdP3s/N3s4Xe9WAB434MzoLDTO7Gn6gzvw5Pu7icv3GSJsep8FA7vDpXRltJ+iwz98jfvyFUKdUSKmsZH8w552mIDE7eXi/S2ZP2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720152831; c=relaxed/simple;
	bh=DgJOfUyOSxVhQfMvmhTpdQIhTot3ud+pCunclUi06xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHFdolMf4Q7ZyQPYUfOYhUBQPT37eXeMhkMOdKsEfkGenWmKbi3ZgHUmxNMnj63iBdN7BELx2OUltGjnsjbmLthZG13/Tae/mMH3jWGOxt4zqlOaO0xoi6HhfFw/E2h4huqRy9tYK/LgjSpouYq5icSQWI8W3D7Kf/dwPQ/7AGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtbwNWY4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720152830; x=1751688830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DgJOfUyOSxVhQfMvmhTpdQIhTot3ud+pCunclUi06xE=;
  b=PtbwNWY4EaAJx61UdRgse02mRMgOTmFf1tsqXRanT5w2np0mge6W/wnt
   /WvGaLEO3I2YDrf75ZN6TzwqHqIfRdESd2wgcgbx5mZXTrmTIWl+AIOxd
   YvLi8XjI5t5UEmWXTGSBWyV1dvnjUfvCT/bQ8fN29AvTA2f/TTscazB5s
   qgpIIkKNPL9McLesj4BaBCCGwIK4zNrWcnHLLm+xtQxBhrzm/0ArHWVHt
   DaTI8UImY9XA7OuY957FAsTW4058RsQt2dBYAy96+jwe3UI6Ls3PWhS0q
   XigIVSoDM0/NjPwJ1suL7GJjIcEqcf2CIKhvnBKIJwbKA6LTwgd5gy7RW
   A==;
X-CSE-ConnectionGUID: f5OJGjs1R++k6DmW8q0YBA==
X-CSE-MsgGUID: jGCooDwcTIq+XiQkkVkwBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17542349"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17542349"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 21:13:49 -0700
X-CSE-ConnectionGUID: h6gQyRWgSs6tkoY6PEIYgw==
X-CSE-MsgGUID: 1toK6P7UQbKpG292BlGNQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47196195"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Jul 2024 21:13:47 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPaKO-000RtI-28;
	Fri, 05 Jul 2024 04:13:44 +0000
Date: Fri, 5 Jul 2024 12:13:30 +0800
From: kernel test robot <lkp@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] riscv: uaccess: use 'asm goto output' for get_user
Message-ID: <202407051159.ArkAPA6L-lkp@intel.com>
References: <20240625040500.1788-5-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625040500.1788-5-jszhang@kernel.org>

Hi Jisheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/riscv-implement-user_access_begin-and-families/20240626-005352
base:   linus/master
patch link:    https://lore.kernel.org/r/20240625040500.1788-5-jszhang%40kernel.org
patch subject: [PATCH 4/4] riscv: uaccess: use 'asm goto output' for get_user
config: riscv-randconfig-r121-20240705 (https://download.01.org/0day-ci/archive/20240705/202407051159.ArkAPA6L-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240705/202407051159.ArkAPA6L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407051159.ArkAPA6L-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:174,
                    from <command-line>:
   net/rfkill/core.c: In function 'rfkill_fop_ioctl':
>> arch/riscv/include/asm/uaccess.h:104:26: error: '__lo' undeclared (first use in this function)
     104 |                 : "=&r" (__lo), "=r" (__hi)                     \
         |                          ^~~~
   include/linux/compiler-gcc.h:84:32: note: in definition of macro 'asm_goto_output'
      84 |         do { asm volatile goto(x); asm (""); } while (0)
         |                                ^
   arch/riscv/include/asm/uaccess.h:148:17: note: in expansion of macro '__get_user_8'
     148 |                 __get_user_8((x), __gu_ptr, label);             \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:159:9: note: in expansion of macro '__get_user_nocheck'
     159 |         __get_user_nocheck(x, ptr, __gu_failed);                        \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:9: note: in expansion of macro '__get_user_error'
     196 |         __get_user_error(__gu_val, __gu_ptr, __gu_err);         \
         |         ^~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:226:17: note: in expansion of macro '__get_user'
     226 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   net/rfkill/core.c:1373:21: note: in expansion of macro 'get_user'
    1373 |                 if (get_user(size, (__u32 __user *)arg)) {
         |                     ^~~~~~~~
   arch/riscv/include/asm/uaccess.h:104:26: note: each undeclared identifier is reported only once for each function it appears in
     104 |                 : "=&r" (__lo), "=r" (__hi)                     \
         |                          ^~~~
   include/linux/compiler-gcc.h:84:32: note: in definition of macro 'asm_goto_output'
      84 |         do { asm volatile goto(x); asm (""); } while (0)
         |                                ^
   arch/riscv/include/asm/uaccess.h:148:17: note: in expansion of macro '__get_user_8'
     148 |                 __get_user_8((x), __gu_ptr, label);             \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:159:9: note: in expansion of macro '__get_user_nocheck'
     159 |         __get_user_nocheck(x, ptr, __gu_failed);                        \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:9: note: in expansion of macro '__get_user_error'
     196 |         __get_user_error(__gu_val, __gu_ptr, __gu_err);         \
         |         ^~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:226:17: note: in expansion of macro '__get_user'
     226 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   net/rfkill/core.c:1373:21: note: in expansion of macro 'get_user'
    1373 |                 if (get_user(size, (__u32 __user *)arg)) {
         |                     ^~~~~~~~
>> arch/riscv/include/asm/uaccess.h:104:39: error: '__hi' undeclared (first use in this function)
     104 |                 : "=&r" (__lo), "=r" (__hi)                     \
         |                                       ^~~~
   include/linux/compiler-gcc.h:84:32: note: in definition of macro 'asm_goto_output'
      84 |         do { asm volatile goto(x); asm (""); } while (0)
         |                                ^
   arch/riscv/include/asm/uaccess.h:148:17: note: in expansion of macro '__get_user_8'
     148 |                 __get_user_8((x), __gu_ptr, label);             \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:159:9: note: in expansion of macro '__get_user_nocheck'
     159 |         __get_user_nocheck(x, ptr, __gu_failed);                        \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:9: note: in expansion of macro '__get_user_error'
     196 |         __get_user_error(__gu_val, __gu_ptr, __gu_err);         \
         |         ^~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:226:17: note: in expansion of macro '__get_user'
     226 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   net/rfkill/core.c:1373:21: note: in expansion of macro 'get_user'
    1373 |                 if (get_user(size, (__u32 __user *)arg)) {
         |                     ^~~~~~~~
>> arch/riscv/include/asm/uaccess.h:105:24: error: '__ptr' undeclared (first use in this function); did you mean '__p'?
     105 |                 : "m" (__ptr[__LSW]), "m" (__ptr[__MSW])        \
         |                        ^~~~~
   include/linux/compiler-gcc.h:84:32: note: in definition of macro 'asm_goto_output'
      84 |         do { asm volatile goto(x); asm (""); } while (0)
         |                                ^
   arch/riscv/include/asm/uaccess.h:148:17: note: in expansion of macro '__get_user_8'
     148 |                 __get_user_8((x), __gu_ptr, label);             \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:159:9: note: in expansion of macro '__get_user_nocheck'
     159 |         __get_user_nocheck(x, ptr, __gu_failed);                        \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:9: note: in expansion of macro '__get_user_error'
     196 |         __get_user_error(__gu_val, __gu_ptr, __gu_err);         \
         |         ^~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:226:17: note: in expansion of macro '__get_user'
     226 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   net/rfkill/core.c:1373:21: note: in expansion of macro 'get_user'
    1373 |                 if (get_user(size, (__u32 __user *)arg)) {
         |                     ^~~~~~~~


vim +/__lo +104 arch/riscv/include/asm/uaccess.h

    94	
    95	#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
    96	#define __get_user_8(x, ptr, label)				\
    97		asm_goto_output(					\
    98			"1:\n"						\
    99			"	lw %0, %2\n"				\
   100			"2:\n"						\
   101			"	lw %1, %3\n"				\
   102			_ASM_EXTABLE_UACCESS_ERR(1b, %l4, %0)		\
   103			_ASM_EXTABLE_UACCESS_ERR(2b, %l4, %0)		\
 > 104			: "=&r" (__lo), "=r" (__hi)			\
 > 105			: "m" (__ptr[__LSW]), "m" (__ptr[__MSW])	\
   106			: : label)
   107	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

