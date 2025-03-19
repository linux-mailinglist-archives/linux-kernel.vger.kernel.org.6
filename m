Return-Path: <linux-kernel+bounces-568038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E6A68D49
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94554163571
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE4B2561DC;
	Wed, 19 Mar 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQ60k+1H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233D25522E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389089; cv=none; b=pcxK0YjRhzo4nJgWpT/VG9HAT8fVHmm/BUbEJ6xL5lLzoVJ7KWhZEzJTLojAqASDXRK4Km4StMO6+1vpfWJkGzM4l/k0ZIpvZmd7NTVPrzlntM4Dw/xJ0AIemlAjbF2jkCGmO6ZitclvZCYZjeP/9IGNYVU6OYqb8bdpQjP/6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389089; c=relaxed/simple;
	bh=pv67RfOBOzE89SY2UB2GgqcKkeSwOPJnekyn9RTynZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fRJg7J12/mxZWV0nwrzfPMukknTmD694+IfAhKKOHNbcry4oks+94OA8uuEJ/SuQOsTfuoWcINsa/dqpOekX0rtQx05tyrytDQ6dYc41TSyY0CcVyICFbdcFgwqlymNY7HzPWpfnPuU9T28tSXuOxvWoEMvd8HwQ7VDSD+DkoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQ60k+1H; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742389086; x=1773925086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pv67RfOBOzE89SY2UB2GgqcKkeSwOPJnekyn9RTynZ8=;
  b=aQ60k+1HZJwV47F536CLHnubg1wOiPpUWcoWb0oBpY9qsUEA/UuMLZ4M
   vfYrx/ybPtzn4tRl6JzQKma/QnhSioYi7VwCu65yUyHjYWYGsKrC5a6DP
   t4qUgq3ziVSI/gePp1NeNwZjIareumQLqo/getzp7gF2Ipu5Kb8UOCCQw
   3QWQoasPAFuhasAgzSSsj1bwqHHlkVggq1HzeTrLJby9ZJJ8vA4Ff+cXy
   FEXYLFHrei8+ir8ZKWyeg45lxWQQPMx410RoRZ0MYg40hetsyuhZQtKLs
   aFFGH5lyUfqnpfCSPaaNPLxtrFUVb7c0SunK2naW0Vt7C8pi6K7lqQsS3
   Q==;
X-CSE-ConnectionGUID: IxWIf7N8Ti2qFaeAh7TuIA==
X-CSE-MsgGUID: 5n+oEZUVRuuTicsc+EQHmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="61104361"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="61104361"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:58:06 -0700
X-CSE-ConnectionGUID: fqFXQDzURlCKlqaNIu06lw==
X-CSE-MsgGUID: O7E3Ab5FSryn0a0j8S81Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="126820700"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 19 Mar 2025 05:58:04 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuszh-000EgS-0k;
	Wed, 19 Mar 2025 12:58:01 +0000
Date: Wed, 19 Mar 2025 20:57:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:WIP.x86/core 1/1] include/linux/arm-smccc.h:512:13: warning:
 unused variable '__a3'
Message-ID: <202503192036.1r0auJUZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ingo,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/core
head:   9262ee6499954dd387e4507e03b84512ab100706
commit: 9262ee6499954dd387e4507e03b84512ab100706 [1/1] compiler/gcc: Make asm() templates asm __inline__() by default
config: arm64-randconfig-001-20250319 (https://download.01.org/0day-ci/archive/20250319/202503192036.1r0auJUZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192036.1r0auJUZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503192036.1r0auJUZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:516:27: note: in expansion of macro 'asm'
     register typeof(a2) arg2 asm("r2") = __a2;   \
                              ^~~
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_hvc(...) __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:4: note: in expansion of macro 'arm_smccc_1_1_hvc'
       arm_smccc_1_1_hvc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:517:27: note: in expansion of macro 'asm'
     register typeof(a3) arg3 asm("r3") = __a3
                              ^~~
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_hvc(...) __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:4: note: in expansion of macro 'arm_smccc_1_1_hvc'
       arm_smccc_1_1_hvc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:522:27: note: in expansion of macro 'asm'
     register typeof(a4) arg4 asm("r4") = __a4
                              ^~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_hvc(...) __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:4: note: in expansion of macro 'arm_smccc_1_1_hvc'
       arm_smccc_1_1_hvc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/include/asm/rsi_cmds.h:9:0,
                    from arch/arm64/include/asm/rsi.h:11,
                    from arch/arm64/include/asm/pgtable-prot.h:70,
                    from arch/arm64/include/asm/sparsemem.h:8,
                    from include/linux/page-flags-layout.h:30,
                    from include/linux/mmzone.h:20,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
>> include/linux/arm-smccc.h:512:13: warning: unused variable '__a3' [-Wunused-variable]
     typeof(a3) __a3 = a3;      \
                ^
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_hvc(...) __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:4: note: in expansion of macro 'arm_smccc_1_1_hvc'
       arm_smccc_1_1_hvc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:511:13: warning: unused variable '__a2' [-Wunused-variable]
     typeof(a2) __a2 = a2;      \
                ^
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_hvc(...) __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:4: note: in expansion of macro 'arm_smccc_1_1_hvc'
       arm_smccc_1_1_hvc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:510:13: warning: unused variable '__a1' [-Wunused-variable]
     typeof(a1) __a1 = a1;      \
                ^
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_hvc(...) __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:4: note: in expansion of macro 'arm_smccc_1_1_hvc'
       arm_smccc_1_1_hvc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:520:13: warning: unused variable '__a4' [-Wunused-variable]
     typeof(a4) __a4 = a4;      \
                ^
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_hvc(...) __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:4: note: in expansion of macro 'arm_smccc_1_1_hvc'
       arm_smccc_1_1_hvc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:546:29: note: in expansion of macro 'asm'
      register unsigned long r0 asm("r0");   \
                                ^~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:547:29: note: in expansion of macro 'asm'
      register unsigned long r1 asm("r1");   \
                                ^~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:548:29: note: in expansion of macro 'asm'
      register unsigned long r2 asm("r2");   \
                                ^~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:549:29: note: in expansion of macro 'asm'
      register unsigned long r3 asm("r3");    \
                                ^~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:514:30: note: in expansion of macro 'asm'
--
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:516:27: note: in expansion of macro 'asm'
     register typeof(a2) arg2 asm("r2") = __a2;   \
                              ^~~
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:517:27: note: in expansion of macro 'asm'
     register typeof(a3) arg3 asm("r3") = __a3
                              ^~~
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:522:27: note: in expansion of macro 'asm'
     register typeof(a4) arg4 asm("r4") = __a4
                              ^~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/include/asm/rsi_cmds.h:9:0,
                    from arch/arm64/include/asm/rsi.h:11,
                    from arch/arm64/include/asm/pgtable-prot.h:70,
                    from arch/arm64/include/asm/sparsemem.h:8,
                    from include/linux/page-flags-layout.h:30,
                    from include/linux/mmzone.h:20,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
>> include/linux/arm-smccc.h:512:13: warning: unused variable '__a3' [-Wunused-variable]
     typeof(a3) __a3 = a3;      \
                ^
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:511:13: warning: unused variable '__a2' [-Wunused-variable]
     typeof(a2) __a2 = a2;      \
                ^
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:510:13: warning: unused variable '__a1' [-Wunused-variable]
     typeof(a1) __a1 = a1;      \
                ^
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:520:13: warning: unused variable '__a4' [-Wunused-variable]
     typeof(a4) __a4 = a4;      \
                ^
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:550:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:575:32: note: in expansion of macro '__arm_smccc_1_1'
    #define arm_smccc_1_1_smc(...) __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                   ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:4: note: in expansion of macro 'arm_smccc_1_1_smc'
       arm_smccc_1_1_smc(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:514:30: note: in expansion of macro 'asm'
     register unsigned long arg0 asm("r0") = (u32)a0;   \
                                 ^~~
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:600:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:635:4: note: in expansion of macro '__fail_smccc_1_1'
       __fail_smccc_1_1(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:515:27: note: in expansion of macro 'asm'
     register typeof(a1) arg1 asm("r1") = __a1;   \
                              ^~~
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:600:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:635:4: note: in expansion of macro '__fail_smccc_1_1'
       __fail_smccc_1_1(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:516:27: note: in expansion of macro 'asm'
     register typeof(a2) arg2 asm("r2") = __a2;   \
                              ^~~
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:600:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:635:4: note: in expansion of macro '__fail_smccc_1_1'
       __fail_smccc_1_1(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:517:27: note: in expansion of macro 'asm'
     register typeof(a3) arg3 asm("r3") = __a3
                              ^~~
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:600:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:635:4: note: in expansion of macro '__fail_smccc_1_1'
       __fail_smccc_1_1(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   include/linux/arm-smccc.h:522:27: note: in expansion of macro 'asm'
     register typeof(a4) arg4 asm("r4") = __a4
                              ^~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:600:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:635:4: note: in expansion of macro '__fail_smccc_1_1'
       __fail_smccc_1_1(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/include/asm/rsi_cmds.h:9:0,
                    from arch/arm64/include/asm/rsi.h:11,
                    from arch/arm64/include/asm/pgtable-prot.h:70,
                    from arch/arm64/include/asm/sparsemem.h:8,
                    from include/linux/page-flags-layout.h:30,
                    from include/linux/mmzone.h:20,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
>> include/linux/arm-smccc.h:512:13: warning: unused variable '__a3' [-Wunused-variable]
     typeof(a3) __a3 = a3;      \
                ^
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:600:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:635:4: note: in expansion of macro '__fail_smccc_1_1'
       __fail_smccc_1_1(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:511:13: warning: unused variable '__a2' [-Wunused-variable]
     typeof(a2) __a2 = a2;      \
                ^
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:600:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:635:4: note: in expansion of macro '__fail_smccc_1_1'
       __fail_smccc_1_1(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:510:13: warning: unused variable '__a1' [-Wunused-variable]
     typeof(a1) __a1 = a1;      \
                ^
   include/linux/arm-smccc.h:521:2: note: in expansion of macro '__declare_arg_5'
     __declare_arg_5(a0, a1, a2, a3, res);    \
     ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:600:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:635:4: note: in expansion of macro '__fail_smccc_1_1'
       __fail_smccc_1_1(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:520:13: warning: unused variable '__a4' [-Wunused-variable]
     typeof(a4) __a4 = a4;      \
                ^
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_6'
    #define __CONCAT(a, b) a ## b
                           ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
    #define CONCATENATE(a, b) __CONCAT(a, b)
                              ^~~~~~~~
   include/linux/arm-smccc.h:600:3: note: in expansion of macro 'CONCATENATE'
      CONCATENATE(__declare_arg_,    \
      ^~~~~~~~~~~
   include/linux/arm-smccc.h:635:4: note: in expansion of macro '__fail_smccc_1_1'
       __fail_smccc_1_1(__VA_ARGS__);   \
       ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/rsi_cmds.h:152:2: note: in expansion of macro 'arm_smccc_1_1_invoke'
     arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
     ^~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: arch/arm64/kernel/asm-offsets.s] Error 1 shuffle=670308932
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1269: prepare0] Error 2 shuffle=670308932
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=670308932
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=670308932
   make: Target 'prepare' not remade because of errors.


vim +/__a3 +512 include/linux/arm-smccc.h

f2d3b2e8759a58 Marc Zyngier    2018-02-06  490  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  491  #define __declare_arg_2(a0, res)					\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  492  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull    2020-09-15  493  	register unsigned long arg0 asm("r0") = (u32)a0
f2d3b2e8759a58 Marc Zyngier    2018-02-06  494  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  495  #define __declare_arg_3(a0, a1, res)					\
755a8bf5579d22 Marc Zyngier    2018-08-24  496  	typeof(a1) __a1 = a1;						\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  497  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull    2020-09-15  498  	register unsigned long arg0 asm("r0") = (u32)a0;			\
0794a974d74dc7 Andrew Scull    2020-09-15  499  	register typeof(a1) arg1 asm("r1") = __a1
f2d3b2e8759a58 Marc Zyngier    2018-02-06  500  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  501  #define __declare_arg_4(a0, a1, a2, res)				\
755a8bf5579d22 Marc Zyngier    2018-08-24  502  	typeof(a1) __a1 = a1;						\
755a8bf5579d22 Marc Zyngier    2018-08-24  503  	typeof(a2) __a2 = a2;						\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  504  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull    2020-09-15  505  	register unsigned long arg0 asm("r0") = (u32)a0;			\
0794a974d74dc7 Andrew Scull    2020-09-15  506  	register typeof(a1) arg1 asm("r1") = __a1;			\
0794a974d74dc7 Andrew Scull    2020-09-15  507  	register typeof(a2) arg2 asm("r2") = __a2
f2d3b2e8759a58 Marc Zyngier    2018-02-06  508  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  509  #define __declare_arg_5(a0, a1, a2, a3, res)				\
755a8bf5579d22 Marc Zyngier    2018-08-24 @510  	typeof(a1) __a1 = a1;						\
755a8bf5579d22 Marc Zyngier    2018-08-24 @511  	typeof(a2) __a2 = a2;						\
755a8bf5579d22 Marc Zyngier    2018-08-24 @512  	typeof(a3) __a3 = a3;						\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  513  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull    2020-09-15  514  	register unsigned long arg0 asm("r0") = (u32)a0;			\
0794a974d74dc7 Andrew Scull    2020-09-15  515  	register typeof(a1) arg1 asm("r1") = __a1;			\
0794a974d74dc7 Andrew Scull    2020-09-15  516  	register typeof(a2) arg2 asm("r2") = __a2;			\
0794a974d74dc7 Andrew Scull    2020-09-15  517  	register typeof(a3) arg3 asm("r3") = __a3
f2d3b2e8759a58 Marc Zyngier    2018-02-06  518  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  519  #define __declare_arg_6(a0, a1, a2, a3, a4, res)			\
755a8bf5579d22 Marc Zyngier    2018-08-24 @520  	typeof(a4) __a4 = a4;						\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  521  	__declare_arg_5(a0, a1, a2, a3, res);				\
0794a974d74dc7 Andrew Scull    2020-09-15  522  	register typeof(a4) arg4 asm("r4") = __a4
f2d3b2e8759a58 Marc Zyngier    2018-02-06  523  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  524  #define __declare_arg_7(a0, a1, a2, a3, a4, a5, res)			\
755a8bf5579d22 Marc Zyngier    2018-08-24  525  	typeof(a5) __a5 = a5;						\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  526  	__declare_arg_6(a0, a1, a2, a3, a4, res);			\
0794a974d74dc7 Andrew Scull    2020-09-15  527  	register typeof(a5) arg5 asm("r5") = __a5
f2d3b2e8759a58 Marc Zyngier    2018-02-06  528  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  529  #define __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res)		\
755a8bf5579d22 Marc Zyngier    2018-08-24  530  	typeof(a6) __a6 = a6;						\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  531  	__declare_arg_7(a0, a1, a2, a3, a4, a5, res);			\
0794a974d74dc7 Andrew Scull    2020-09-15  532  	register typeof(a6) arg6 asm("r6") = __a6
f2d3b2e8759a58 Marc Zyngier    2018-02-06  533  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  534  #define __declare_arg_9(a0, a1, a2, a3, a4, a5, a6, a7, res)		\
755a8bf5579d22 Marc Zyngier    2018-08-24  535  	typeof(a7) __a7 = a7;						\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  536  	__declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);		\
0794a974d74dc7 Andrew Scull    2020-09-15  537  	register typeof(a7) arg7 asm("r7") = __a7
f2d3b2e8759a58 Marc Zyngier    2018-02-06  538  
f2d3b2e8759a58 Marc Zyngier    2018-02-06  539  /*
f2d3b2e8759a58 Marc Zyngier    2018-02-06  540   * We have an output list that is not necessarily used, and GCC feels
f2d3b2e8759a58 Marc Zyngier    2018-02-06  541   * entitled to optimise the whole sequence away. "volatile" is what
f2d3b2e8759a58 Marc Zyngier    2018-02-06  542   * makes it stick.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  543   */
f2d3b2e8759a58 Marc Zyngier    2018-02-06  544  #define __arm_smccc_1_1(inst, ...)					\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  545  	do {								\
0794a974d74dc7 Andrew Scull    2020-09-15  546  		register unsigned long r0 asm("r0");			\
0794a974d74dc7 Andrew Scull    2020-09-15  547  		register unsigned long r1 asm("r1");			\
0794a974d74dc7 Andrew Scull    2020-09-15  548  		register unsigned long r2 asm("r2");			\
0794a974d74dc7 Andrew Scull    2020-09-15  549  		register unsigned long r3 asm("r3"); 			\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  550  		CONCATENATE(__declare_arg_,				\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  551  			    COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__);	\
8c462d56487e3a Mark Rutland    2024-11-06  552  		asm volatile(inst "\n" :				\
0794a974d74dc7 Andrew Scull    2020-09-15  553  			     "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)	\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  554  			     : CONCATENATE(__constraint_read_,		\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  555  					   COUNT_ARGS(__VA_ARGS__))	\
8c462d56487e3a Mark Rutland    2024-11-06  556  			     : "memory");				\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  557  		if (___res)						\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  558  			*___res = (typeof(*___res)){r0, r1, r2, r3};	\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  559  	} while (0)
f2d3b2e8759a58 Marc Zyngier    2018-02-06  560  
f2d3b2e8759a58 Marc Zyngier    2018-02-06  561  /*
f2d3b2e8759a58 Marc Zyngier    2018-02-06  562   * arm_smccc_1_1_smc() - make an SMCCC v1.1 compliant SMC call
f2d3b2e8759a58 Marc Zyngier    2018-02-06  563   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  564   * This is a variadic macro taking one to eight source arguments, and
f2d3b2e8759a58 Marc Zyngier    2018-02-06  565   * an optional return structure.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  566   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  567   * @a0-a7: arguments passed in registers 0 to 7
f2d3b2e8759a58 Marc Zyngier    2018-02-06  568   * @res: result values from registers 0 to 3
f2d3b2e8759a58 Marc Zyngier    2018-02-06  569   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  570   * This macro is used to make SMC calls following SMC Calling Convention v1.1.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  571   * The content of the supplied param are copied to registers 0 to 7 prior
f2d3b2e8759a58 Marc Zyngier    2018-02-06  572   * to the SMC instruction. The return values are updated with the content
f2d3b2e8759a58 Marc Zyngier    2018-02-06  573   * from register 0 to 3 on return from the SMC instruction if not NULL.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  574   */
f2d3b2e8759a58 Marc Zyngier    2018-02-06  575  #define arm_smccc_1_1_smc(...)	__arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
f2d3b2e8759a58 Marc Zyngier    2018-02-06  576  
f2d3b2e8759a58 Marc Zyngier    2018-02-06  577  /*
f2d3b2e8759a58 Marc Zyngier    2018-02-06  578   * arm_smccc_1_1_hvc() - make an SMCCC v1.1 compliant HVC call
f2d3b2e8759a58 Marc Zyngier    2018-02-06  579   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  580   * This is a variadic macro taking one to eight source arguments, and
f2d3b2e8759a58 Marc Zyngier    2018-02-06  581   * an optional return structure.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  582   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  583   * @a0-a7: arguments passed in registers 0 to 7
f2d3b2e8759a58 Marc Zyngier    2018-02-06  584   * @res: result values from registers 0 to 3
f2d3b2e8759a58 Marc Zyngier    2018-02-06  585   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  586   * This macro is used to make HVC calls following SMC Calling Convention v1.1.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  587   * The content of the supplied param are copied to registers 0 to 7 prior
f2d3b2e8759a58 Marc Zyngier    2018-02-06  588   * to the HVC instruction. The return values are updated with the content
f2d3b2e8759a58 Marc Zyngier    2018-02-06  589   * from register 0 to 3 on return from the HVC instruction if not NULL.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  590   */
f2d3b2e8759a58 Marc Zyngier    2018-02-06 @591  #define arm_smccc_1_1_hvc(...)	__arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
f2d3b2e8759a58 Marc Zyngier    2018-02-06  592  

:::::: The code at line 512 was first introduced by commit
:::::: 755a8bf5579d22eb5636685c516d8dede799e27b arm/arm64: smccc-1.1: Handle function result as parameters

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

