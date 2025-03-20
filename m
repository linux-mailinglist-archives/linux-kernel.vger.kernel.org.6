Return-Path: <linux-kernel+bounces-569586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7040CA6A509
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1AC3B6A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1175521C183;
	Thu, 20 Mar 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TatQWkIR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E3189F36
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470397; cv=none; b=rIAuR5pNkeVWwk7qadKWKK1pYYr1os+byDM64UzaSSaj4yUlig9Mg9Q9mUtpNRTbZ75Jru2Ew/1YOURjn/dUgAk9zkhbmUYE+KW84/tA8MJmE58ZOCfaFcj5S8PRzpnAauRVj+/CyGEcGn2AGviPvmBJfv640osEF+csYCVfvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470397; c=relaxed/simple;
	bh=MTYCYXix1jFuXio6KmE5Ly+A8CfSkDUZ/oGmKYR0a6Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K55Dr7renQzDh1Rff1YkheT/Yd9dpbZsR4nkf39rCornn5OtvIAILfbjv3jG53tmX3O8T4p+Q845IMwGauaIWMFq6xKRo/99l/C53TLKPQVmNbyH//2hCq0tB9YTs4WXWN9zTnHWCrJ2Y/lcUWoFDUwhijP41sPZsgMuJlRM2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TatQWkIR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742470395; x=1774006395;
  h=date:from:to:cc:subject:message-id;
  bh=MTYCYXix1jFuXio6KmE5Ly+A8CfSkDUZ/oGmKYR0a6Q=;
  b=TatQWkIRGBEBeTawLwDmxe6//+NRFl7iUUYgx+AmepCTvNGxlRRY2hNZ
   Ipf2EkLr4VYULC/CJKezMxvNi/v3yGHM7e4c6BcxJ2l5ZnKoi0L6tkm4q
   vX44DOgdvoCw2RrZ+n28ms8Z3fx8MWUy4IPUEo8xDn5aR8EX91ViI/idD
   jkr46ZS4CjMYVSntq3W/msq+nPCXiSXvxyWSwO5DLihelAaPv0u+Tw6wY
   iA9IbSBn3gD7dZTErU/h2F1Su5/AlGCzuhG6wMbcnAFZ5Oh9rQ+dj0lPV
   omfjLc4TCR7VdiXu2gn7Yw+Sxw0MMCOe7rS2c3c4rVHSJvkLQv5mOiWEd
   Q==;
X-CSE-ConnectionGUID: w8Q31lLNRcuO5DAACi76Fg==
X-CSE-MsgGUID: G7CB5kzRQhKuSs8KNrcPSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="46452263"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="46452263"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 04:33:14 -0700
X-CSE-ConnectionGUID: XzR9SLwNSEOaKBrEcAQB8Q==
X-CSE-MsgGUID: zEp5E0opSy+z3aEnJJ9IPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="123021645"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2025 04:33:14 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvE98-0000Ox-1K;
	Thu, 20 Mar 2025 11:33:10 +0000
Date: Thu, 20 Mar 2025 19:31:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:WIP.x86/core] BUILD REGRESSION
 9262ee6499954dd387e4507e03b84512ab100706
Message-ID: <202503201933.rOH3M8q5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/core
branch HEAD: 9262ee6499954dd387e4507e03b84512ab100706  compiler/gcc: Make asm() templates asm __inline__() by default

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503192004.mvMWNurt-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202503192036.1r0auJUZ-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202503192048.nhPLafD5-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202503200011.p3NCuhkb-lkp@intel.com

    arch/arm/include/asm/percpu.h:10:24: error: register name not specified for 'current_stack_pointer'
    arch/arm/include/asm/percpu.h:10:46: error: meaningless 'inline' on asm outside function
    arch/arm64/include/asm/atomic_lse.h:289:11: warning: unused variable 'n' [-Wunused-variable]
    arch/arm64/include/asm/atomic_lse.h:310:1: error: meaningless 'inline' on asm outside function
    arch/hexagon/include/asm/thread_info.h:73:52: error: meaningless 'inline' on asm outside function
    arch/powerpc/include/asm/current.h:33:38: error: meaningless 'inline' on asm outside function
    arch/powerpc/include/asm/epapr_hcalls.h:469:28: error: meaningless 'inline' on asm outside function
    arch/powerpc/include/asm/paca.h:36:41: error: meaningless 'inline' on asm outside function
    arch/powerpc/include/asm/reg.h:1445:46: error: meaningless 'inline' on asm outside function
    arch/powerpc/include/asm/vdso/gettimeofday.h:30:19: error: meaningless 'inline' on asm outside function
    arch/riscv/include/asm/vdso/gettimeofday.h:24:43: error: meaningless 'inline' on asm outside function
    arch/s390/include/asm/syscall.h:146:1: error: meaningless 'inline' on asm outside function
    arch/sh/include/asm/thread_info.h:63:24: error: register name not specified for 'current_stack_pointer'
    arch/sparc/include/asm/percpu_64.h:8:24: error: register name not specified for '__local_per_cpu_offset'
    arch/x86/kernel/alternative.c:1078:1: error: meaningless 'inline' on asm outside function
    include/linux/arm-smccc.h:510:13: warning: unused variable '__a1' [-Wunused-variable]
    include/linux/arm-smccc.h:511:13: warning: unused variable '__a2' [-Wunused-variable]
    include/linux/arm-smccc.h:512:13: warning: unused variable '__a3' [-Wunused-variable]
    include/linux/arm-smccc.h:520:13: warning: unused variable '__a4' [-Wunused-variable]
    include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- alpha-allyesconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- alpha-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arc-allmodconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arc-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arc-allyesconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arc-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arc-hsdk_defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arc-randconfig-001-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arc-randconfig-002-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arc-randconfig-r121-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arm-allmodconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arm-allnoconfig
|   `-- arch-arm-include-asm-percpu.h:error:meaningless-inline-on-asm-outside-function
|-- arm-allyesconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arm-aspeed_g5_defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arm-defconfig
|   `-- arch-arm-include-asm-percpu.h:error:meaningless-inline-on-asm-outside-function
|-- arm-imxrt_defconfig
|   `-- arch-arm-include-asm-percpu.h:error:meaningless-inline-on-asm-outside-function
|-- arm-mxs_defconfig
|   `-- arch-arm-include-asm-percpu.h:error:meaningless-inline-on-asm-outside-function
|-- arm-randconfig-001-20250319
|   `-- arch-arm-include-asm-percpu.h:error:meaningless-inline-on-asm-outside-function
|-- arm-randconfig-001-20250320
|   `-- arch-arm-include-asm-percpu.h:error:meaningless-inline-on-asm-outside-function
|-- arm-randconfig-002-20250320
|   `-- arch-arm-include-asm-percpu.h:error:meaningless-inline-on-asm-outside-function
|-- arm-randconfig-003-20250320
|   |-- arch-arm-include-asm-percpu.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arm-randconfig-004-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arm-randconfig-r064-20250320
|   `-- arch-arm-include-asm-percpu.h:error:meaningless-inline-on-asm-outside-function
|-- arm-sunxi_defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arm-tegra_defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arm64-allmodconfig
|   `-- arch-arm64-include-asm-atomic_lse.h:error:meaningless-inline-on-asm-outside-function
|-- arm64-allnoconfig
|   |-- include-linux-arm-smccc.h:warning:unused-variable-__a1
|   |-- include-linux-arm-smccc.h:warning:unused-variable-__a2
|   |-- include-linux-arm-smccc.h:warning:unused-variable-__a3
|   |-- include-linux-arm-smccc.h:warning:unused-variable-__a4
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arm64-defconfig
|   |-- arch-arm64-include-asm-atomic_lse.h:warning:unused-variable-n
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- arm64-randconfig-001-20250319
|   |-- include-linux-arm-smccc.h:warning:unused-variable-__a1
|   |-- include-linux-arm-smccc.h:warning:unused-variable-__a2
|   |-- include-linux-arm-smccc.h:warning:unused-variable-__a3
|   `-- include-linux-arm-smccc.h:warning:unused-variable-__a4
|-- arm64-randconfig-001-20250320
|   `-- arch-arm64-include-asm-atomic_lse.h:error:meaningless-inline-on-asm-outside-function
|-- arm64-randconfig-002-20250319
|   `-- arch-arm64-include-asm-atomic_lse.h:warning:unused-variable-n
|-- arm64-randconfig-002-20250320
|   `-- arch-arm64-include-asm-atomic_lse.h:error:meaningless-inline-on-asm-outside-function
|-- arm64-randconfig-003-20250320
|   `-- arch-arm64-include-asm-atomic_lse.h:error:meaningless-inline-on-asm-outside-function
|-- arm64-randconfig-004-20250320
|   |-- arch-arm64-include-asm-atomic_lse.h:warning:unused-variable-n
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- hexagon-allmodconfig
|   `-- arch-hexagon-include-asm-thread_info.h:error:meaningless-inline-on-asm-outside-function
|-- hexagon-allnoconfig
|   `-- arch-hexagon-include-asm-thread_info.h:error:meaningless-inline-on-asm-outside-function
|-- hexagon-allyesconfig
|   `-- arch-hexagon-include-asm-thread_info.h:error:meaningless-inline-on-asm-outside-function
|-- hexagon-defconfig
|   `-- arch-hexagon-include-asm-thread_info.h:error:meaningless-inline-on-asm-outside-function
|-- hexagon-randconfig-001-20250319
|   `-- arch-hexagon-include-asm-thread_info.h:error:meaningless-inline-on-asm-outside-function
|-- hexagon-randconfig-001-20250320
|   `-- arch-hexagon-include-asm-thread_info.h:error:meaningless-inline-on-asm-outside-function
|-- hexagon-randconfig-002-20250320
|   `-- arch-hexagon-include-asm-thread_info.h:error:meaningless-inline-on-asm-outside-function
|-- i386-allmodconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-001-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-002-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-006-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-011-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-012-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-013-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-014-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-015-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-016-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-017-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- i386-randconfig-141-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- loongarch-allmodconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- loongarch-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- loongarch-allyesconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- loongarch-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- loongarch-loongson3_defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- loongarch-randconfig-001-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- loongarch-randconfig-002-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- loongarch-randconfig-r071-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- m68k-allmodconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- m68k-allyesconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- m68k-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- microblaze-allmodconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- microblaze-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- microblaze-allyesconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- microblaze-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- mips-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- nios2-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- nios2-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- nios2-randconfig-002-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- openrisc-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- openrisc-allyesconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- openrisc-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- openrisc-randconfig-r061-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- parisc-allmodconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- parisc-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- parisc-allyesconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- parisc-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- parisc-randconfig-001-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- parisc-randconfig-002-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- parisc-randconfig-r054-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- parisc64-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- powerpc-allmodconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- powerpc-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- powerpc-allyesconfig
|   |-- arch-powerpc-include-asm-epapr_hcalls.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-paca.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-reg.h:error:meaningless-inline-on-asm-outside-function
|   `-- arch-powerpc-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- powerpc-arches_defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- powerpc-bamboo_defconfig
|   |-- arch-powerpc-include-asm-current.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-reg.h:error:meaningless-inline-on-asm-outside-function
|   `-- arch-powerpc-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- powerpc-motionpro_defconfig
|   |-- arch-powerpc-include-asm-current.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-reg.h:error:meaningless-inline-on-asm-outside-function
|   `-- arch-powerpc-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- powerpc-mpc8313_rdb_defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- powerpc-randconfig-002-20250319
|   |-- arch-powerpc-include-asm-current.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-epapr_hcalls.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-reg.h:error:meaningless-inline-on-asm-outside-function
|   `-- arch-powerpc-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- powerpc-randconfig-002-20250320
|   |-- arch-powerpc-include-asm-current.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-epapr_hcalls.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-reg.h:error:meaningless-inline-on-asm-outside-function
|   `-- arch-powerpc-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- powerpc-randconfig-003-20250320
|   |-- arch-powerpc-include-asm-current.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-epapr_hcalls.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-reg.h:error:meaningless-inline-on-asm-outside-function
|   `-- arch-powerpc-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- powerpc64-randconfig-001-20250319
|   `-- arch-powerpc-include-asm-paca.h:error:meaningless-inline-on-asm-outside-function
|-- powerpc64-randconfig-001-20250320
|   |-- arch-powerpc-include-asm-epapr_hcalls.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-paca.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-reg.h:error:meaningless-inline-on-asm-outside-function
|   `-- arch-powerpc-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- powerpc64-randconfig-002-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- powerpc64-randconfig-003-20250320
|   |-- arch-powerpc-include-asm-epapr_hcalls.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-paca.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-reg.h:error:meaningless-inline-on-asm-outside-function
|   `-- arch-powerpc-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- powerpc64-randconfig-r053-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- powerpc64-randconfig-r063-20250320
|   |-- arch-powerpc-include-asm-epapr_hcalls.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-paca.h:error:meaningless-inline-on-asm-outside-function
|   |-- arch-powerpc-include-asm-reg.h:error:meaningless-inline-on-asm-outside-function
|   `-- arch-powerpc-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- riscv-allmodconfig
|   `-- arch-riscv-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- riscv-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- riscv-allyesconfig
|   `-- arch-riscv-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- riscv-defconfig
|   `-- arch-riscv-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- riscv-randconfig-001-20250319
|   `-- arch-riscv-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- riscv-randconfig-r073-20250320
|   `-- arch-riscv-include-asm-vdso-gettimeofday.h:error:meaningless-inline-on-asm-outside-function
|-- s390-allmodconfig
|   `-- arch-s390-include-asm-syscall.h:error:meaningless-inline-on-asm-outside-function
|-- s390-allnoconfig
|   `-- arch-s390-include-asm-syscall.h:error:meaningless-inline-on-asm-outside-function
|-- s390-allyesconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- s390-debug_defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- s390-defconfig
|   `-- arch-s390-include-asm-syscall.h:error:meaningless-inline-on-asm-outside-function
|-- sh-allmodconfig
|   |-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sh-allnoconfig
|   |-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sh-allyesconfig
|   |-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sh-defconfig
|   |-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sh-dreamcast_defconfig
|   |-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sh-j2_defconfig
|   |-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sh-migor_defconfig
|   |-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sh-randconfig-001-20250319
|   `-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|-- sh-randconfig-r072-20250320
|   |-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sh-sdk7780_defconfig
|   |-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sh-sh7785lcr_defconfig
|   |-- arch-sh-include-asm-thread_info.h:error:register-name-not-specified-for-current_stack_pointer
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sparc-allmodconfig
|   |-- arch-sparc-include-asm-percpu_64.h:error:register-name-not-specified-for-__local_per_cpu_offset
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sparc-allnoconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sparc-allyesconfig
|   `-- arch-sparc-include-asm-percpu_64.h:error:register-name-not-specified-for-__local_per_cpu_offset
|-- sparc-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sparc64-defconfig
|   |-- arch-sparc-include-asm-percpu_64.h:error:register-name-not-specified-for-__local_per_cpu_offset
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- sparc64-randconfig-001-20250319
|   `-- arch-sparc-include-asm-percpu_64.h:error:register-name-not-specified-for-__local_per_cpu_offset
|-- sparc64-randconfig-r062-20250320
|   |-- arch-sparc-include-asm-percpu_64.h:error:register-name-not-specified-for-__local_per_cpu_offset
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-alldefconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-allyesconfig
|   `-- arch-x86-kernel-alternative.c:error:meaningless-inline-on-asm-outside-function
|-- x86_64-buildonly-randconfig-002-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-buildonly-randconfig-006-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-defconfig
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-randconfig-005-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-randconfig-006-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-randconfig-008-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-randconfig-072-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-randconfig-075-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-randconfig-078-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-randconfig-161-20250320
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-rhel-9.4
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-rhel-9.4-func
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
|-- x86_64-rhel-9.4-kselftests
|   `-- include-linux-compiler_types.h:error:expected-(-before-__inline
`-- xtensa-allnoconfig
    `-- include-linux-compiler_types.h:error:expected-(-before-__inline

elapsed time: 1457m

configs tested: 247
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-6.5.0
alpha                            allyesconfig    gcc-9.3.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-8.5.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    clang-15
arc                   randconfig-001-20250319    gcc-14.2.0
arc                   randconfig-001-20250320    gcc-7.5.0
arc                   randconfig-002-20250319    gcc-14.2.0
arc                   randconfig-002-20250320    gcc-7.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-6.5.0
arm                       aspeed_g5_defconfig    clang-15
arm                                 defconfig    gcc-14.2.0
arm                           imxrt_defconfig    clang-21
arm                             mxs_defconfig    clang-15
arm                   randconfig-001-20250319    clang-18
arm                   randconfig-001-20250320    gcc-7.5.0
arm                   randconfig-002-20250319    clang-21
arm                   randconfig-002-20250320    gcc-7.5.0
arm                   randconfig-003-20250319    clang-20
arm                   randconfig-003-20250320    gcc-7.5.0
arm                   randconfig-004-20250319    clang-16
arm                   randconfig-004-20250320    gcc-7.5.0
arm                           sunxi_defconfig    gcc-14.2.0
arm                           tegra_defconfig    clang-15
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-8.5.0
arm64                               defconfig    clang-15
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250319    gcc-7.5.0
arm64                 randconfig-001-20250320    gcc-7.5.0
arm64                 randconfig-002-20250319    gcc-7.5.0
arm64                 randconfig-002-20250320    gcc-7.5.0
arm64                 randconfig-003-20250319    gcc-7.5.0
arm64                 randconfig-003-20250320    gcc-7.5.0
arm64                 randconfig-004-20250319    gcc-7.5.0
arm64                 randconfig-004-20250320    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                              allnoconfig    gcc-9.3.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250319    gcc-9.3.0
csky                  randconfig-001-20250320    gcc-12.4.0
csky                  randconfig-002-20250319    gcc-14.2.0
csky                  randconfig-002-20250320    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250319    clang-21
hexagon               randconfig-001-20250320    gcc-12.4.0
hexagon               randconfig-002-20250319    clang-16
hexagon               randconfig-002-20250320    gcc-12.4.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250319    gcc-12
i386        buildonly-randconfig-002-20250319    gcc-12
i386        buildonly-randconfig-003-20250319    gcc-12
i386        buildonly-randconfig-004-20250319    clang-20
i386        buildonly-randconfig-005-20250319    gcc-12
i386        buildonly-randconfig-006-20250319    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250320    clang-20
i386                  randconfig-002-20250320    clang-20
i386                  randconfig-003-20250320    clang-20
i386                  randconfig-004-20250320    clang-20
i386                  randconfig-005-20250320    clang-20
i386                  randconfig-006-20250320    clang-20
i386                  randconfig-007-20250320    clang-20
i386                  randconfig-011-20250320    gcc-12
i386                  randconfig-012-20250320    gcc-12
i386                  randconfig-013-20250320    gcc-12
i386                  randconfig-014-20250320    gcc-12
i386                  randconfig-015-20250320    gcc-12
i386                  randconfig-016-20250320    gcc-12
i386                  randconfig-017-20250320    gcc-12
loongarch                        allmodconfig    gcc-12.4.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-13.3.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    clang-15
loongarch             randconfig-001-20250319    gcc-14.2.0
loongarch             randconfig-001-20250320    gcc-12.4.0
loongarch             randconfig-002-20250319    gcc-14.2.0
loongarch             randconfig-002-20250320    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-5.5.0
m68k                             allyesconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-6.5.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-9.3.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-10.5.0
mips                          ath25_defconfig    clang-15
mips                         rt305x_defconfig    clang-15
nios2                             allnoconfig    gcc-8.5.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250319    gcc-11.5.0
nios2                 randconfig-001-20250320    gcc-12.4.0
nios2                 randconfig-002-20250319    gcc-5.5.0
nios2                 randconfig-002-20250320    gcc-12.4.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-10.5.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250319    gcc-10.5.0
parisc                randconfig-001-20250320    gcc-12.4.0
parisc                randconfig-002-20250319    gcc-10.5.0
parisc                randconfig-002-20250320    gcc-12.4.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    clang-15
powerpc                      bamboo_defconfig    clang-15
powerpc                   motionpro_defconfig    clang-15
powerpc                 mpc8313_rdb_defconfig    clang-15
powerpc               randconfig-001-20250319    gcc-9.3.0
powerpc               randconfig-001-20250320    gcc-12.4.0
powerpc               randconfig-002-20250319    clang-21
powerpc               randconfig-002-20250320    gcc-12.4.0
powerpc               randconfig-003-20250319    clang-21
powerpc               randconfig-003-20250320    gcc-12.4.0
powerpc64             randconfig-001-20250319    clang-20
powerpc64             randconfig-001-20250320    gcc-12.4.0
powerpc64             randconfig-002-20250319    gcc-5.5.0
powerpc64             randconfig-002-20250320    gcc-12.4.0
powerpc64             randconfig-003-20250319    clang-21
powerpc64             randconfig-003-20250320    gcc-12.4.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250319    clang-20
riscv                 randconfig-002-20250319    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                             allyesconfig    gcc-8.5.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250319    gcc-6.5.0
s390                  randconfig-002-20250319    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-10.5.0
sh                               allyesconfig    gcc-14.2.0
sh                               allyesconfig    gcc-7.5.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    clang-15
sh                               j2_defconfig    gcc-14.2.0
sh                            migor_defconfig    clang-15
sh                    randconfig-001-20250319    gcc-11.5.0
sh                    randconfig-002-20250319    gcc-5.5.0
sh                          sdk7780_defconfig    clang-15
sh                        sh7785lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-6.5.0
sparc                 randconfig-001-20250319    gcc-6.5.0
sparc                 randconfig-002-20250319    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250319    gcc-8.5.0
sparc64               randconfig-002-20250319    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-15
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250319    gcc-12
um                    randconfig-002-20250319    gcc-11
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250319    clang-20
x86_64      buildonly-randconfig-001-20250320    clang-20
x86_64      buildonly-randconfig-002-20250319    clang-20
x86_64      buildonly-randconfig-002-20250320    clang-20
x86_64      buildonly-randconfig-003-20250319    gcc-12
x86_64      buildonly-randconfig-003-20250320    clang-20
x86_64      buildonly-randconfig-004-20250319    gcc-11
x86_64      buildonly-randconfig-004-20250320    clang-20
x86_64      buildonly-randconfig-005-20250319    clang-20
x86_64      buildonly-randconfig-005-20250320    clang-20
x86_64      buildonly-randconfig-006-20250319    clang-20
x86_64      buildonly-randconfig-006-20250320    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250320    clang-20
x86_64                randconfig-002-20250320    clang-20
x86_64                randconfig-003-20250320    clang-20
x86_64                randconfig-004-20250320    clang-20
x86_64                randconfig-005-20250320    clang-20
x86_64                randconfig-006-20250320    clang-20
x86_64                randconfig-007-20250320    clang-20
x86_64                randconfig-008-20250320    clang-20
x86_64                randconfig-071-20250320    gcc-12
x86_64                randconfig-072-20250320    gcc-12
x86_64                randconfig-073-20250320    gcc-12
x86_64                randconfig-074-20250320    gcc-12
x86_64                randconfig-075-20250320    gcc-12
x86_64                randconfig-076-20250320    gcc-12
x86_64                randconfig-077-20250320    gcc-12
x86_64                randconfig-078-20250320    gcc-12
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-15
xtensa                randconfig-001-20250319    gcc-10.5.0
xtensa                randconfig-002-20250319    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

