Return-Path: <linux-kernel+bounces-420859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0949D83BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29B328955F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC31192B90;
	Mon, 25 Nov 2024 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrC8wh1N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D518D65F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531669; cv=none; b=Npoj7pPBJdnkNZm2IFAm/r5LAaDTpVEc/db/iXz3h5uMvtY1B4AFE09GwpRQotm18O/H04Xa0yvNiNHED3pzZBxM5kp3uUf8zaY7pljTI2NFqRDrBZ+u/CqWG9nvT+1E28rcEyfFqi0ej47hK9rRpoyxDwsEwdYoNmAIEbmU8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531669; c=relaxed/simple;
	bh=VyAWP+3/dLW7IOMW6olT3uFS2P6TsvsGrrJwLD2HYq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gemDtTbuK8YVKM6pPWm1NvV5+DrqF2JiiknJLaOyv2gKu8f5x2eP22oDlSMixlyolJPTP8ZNv3/Ewo6h6VKzzqxS2rvwXewv35gb+O2LCGSm0WXiF+PlASNT++tg5zm5VvLP18QQx8vVgXN+iu17ETefRqyrulZCnucFV2vICjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrC8wh1N; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732531667; x=1764067667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VyAWP+3/dLW7IOMW6olT3uFS2P6TsvsGrrJwLD2HYq8=;
  b=VrC8wh1N9ud0GEqHrRTYrCfc6n12sHVEqSmvPXI6VZ5orAU6YL/JqSi4
   34juub8tiDo4WFgyOvnPVISBQcii70CspDVreUusG5vUc+Llf2qQy3X8/
   4sfPhtZs24x1i+/kErsCdE5IGzaAvbpLmKrBApgks2SaNw8pG9qW/SEFe
   HRhW8DBGnnrHsD+9pZWrLsl5ymktqpUwzew3LCi648C3cpV2ImaBo4KRP
   BYnxFBYjs0qun7g4R80AutweVNfX8L0VVJJ14izUIEau8QrhE9u1yI5/f
   lSF4jXRlXTlRn8I/0g/u8xI/wrwUjAoI6Db68Bj44mQdXQRmRQEjs9LPP
   Q==;
X-CSE-ConnectionGUID: z0AbdMbPTCCvy5OnKeyrHQ==
X-CSE-MsgGUID: 8RG46C1WSLunAEsARuvZoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="43289045"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43289045"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:47:46 -0800
X-CSE-ConnectionGUID: oHJwdjcKRsaUtOu4el1ZAA==
X-CSE-MsgGUID: hpUF9BkxQxudDHzTPKFEmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="96285525"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2024 02:47:45 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFWd4-0006Ar-1t;
	Mon, 25 Nov 2024 10:47:42 +0000
Date: Mon, 25 Nov 2024 18:47:00 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] objtool: Add noinstr validation for static
 branches/calls
Message-ID: <202411251822.MQI8kf80-lkp@intel.com>
References: <b5746646456eb030673cdb62c23d69ed83c2702a.1732326588.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5746646456eb030673cdb62c23d69ed83c2702a.1732326588.git.jpoimboe@kernel.org>

Hi Josh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12 next-20241125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Poimboeuf/jump_label-Add-annotations-for-validating-noinstr-usage/20241125-105905
base:   linus/master
patch link:    https://lore.kernel.org/r/b5746646456eb030673cdb62c23d69ed83c2702a.1732326588.git.jpoimboe%40kernel.org
patch subject: [PATCH 3/3] objtool: Add noinstr validation for static branches/calls
config: i386-buildonly-randconfig-001-20241125 (https://download.01.org/0day-ci/archive/20241125/202411251822.MQI8kf80-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411251822.MQI8kf80-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411251822.MQI8kf80-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/paravirt_types.h:12,
                    from arch/x86/include/asm/ptrace.h:175,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from include/linux/sched.h:13,
                    from include/linux/context_tracking.h:5,
                    from arch/x86/kernel/kvm.c:12:
   include/linux/jump_label.h:388:9: warning: data definition has no type or storage class
     388 |         ANNOTATE_NOINSTR_ALLOWED(name)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/kvm.c:48:1: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
      48 | DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jump_label.h:388:9: error: type defaults to 'int' in declaration of 'ANNOTATE_NOINSTR_ALLOWED' [-Werror=implicit-int]
     388 |         ANNOTATE_NOINSTR_ALLOWED(name)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/kvm.c:48:1: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
      48 | DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/jump_label.h:371:39: warning: parameter names (without types) in function declaration
     371 | #define STATIC_KEY_FALSE_INIT (struct static_key_false){ .key = STATIC_KEY_INIT_FALSE, }
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/jump_label.h:387:56: note: in expansion of macro 'STATIC_KEY_FALSE_INIT'
     387 |         struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT;   \
         |                                                        ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/kvm.c:48:1: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
      48 | DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/paravirt_types.h:12,
                    from arch/x86/include/asm/ptrace.h:175,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from include/linux/sched.h:13,
                    from arch/x86/kernel/tsc.c:5:
   include/linux/jump_label.h:388:9: warning: data definition has no type or storage class
     388 |         ANNOTATE_NOINSTR_ALLOWED(name)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/tsc.c:48:8: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
      48 | static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jump_label.h:388:9: error: type defaults to 'int' in declaration of 'ANNOTATE_NOINSTR_ALLOWED' [-Werror=implicit-int]
     388 |         ANNOTATE_NOINSTR_ALLOWED(name)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/tsc.c:48:8: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
      48 | static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/jump_label.h:371:39: warning: parameter names (without types) in function declaration
     371 | #define STATIC_KEY_FALSE_INIT (struct static_key_false){ .key = STATIC_KEY_INIT_FALSE, }
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/jump_label.h:387:56: note: in expansion of macro 'STATIC_KEY_FALSE_INIT'
     387 |         struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT;   \
         |                                                        ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/tsc.c:48:8: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
      48 | static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/irqflags.h:9,
                    from include/linux/irqflags.h:18,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/memblock.h:12,
                    from arch/x86/kernel/cpu/common.c:5:
   include/linux/jump_label.h:388:9: warning: data definition has no type or storage class
     388 |         ANNOTATE_NOINSTR_ALLOWED(name)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/common.c:404:8: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
     404 | static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jump_label.h:388:9: error: type defaults to 'int' in declaration of 'ANNOTATE_NOINSTR_ALLOWED' [-Werror=implicit-int]
     388 |         ANNOTATE_NOINSTR_ALLOWED(name)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/common.c:404:8: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
     404 | static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/jump_label.h:371:39: warning: parameter names (without types) in function declaration
     371 | #define STATIC_KEY_FALSE_INIT (struct static_key_false){ .key = STATIC_KEY_INIT_FALSE, }
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/jump_label.h:387:56: note: in expansion of macro 'STATIC_KEY_FALSE_INIT'
     387 |         struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT;   \
         |                                                        ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/common.c:404:8: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
     404 | static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +371 include/linux/jump_label.h

11276d5306b8e5 Peter Zijlstra 2015-07-24  369  
11276d5306b8e5 Peter Zijlstra 2015-07-24  370  #define STATIC_KEY_TRUE_INIT  (struct static_key_true) { .key = STATIC_KEY_INIT_TRUE,  }
11276d5306b8e5 Peter Zijlstra 2015-07-24 @371  #define STATIC_KEY_FALSE_INIT (struct static_key_false){ .key = STATIC_KEY_INIT_FALSE, }
11276d5306b8e5 Peter Zijlstra 2015-07-24  372  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

