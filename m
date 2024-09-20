Return-Path: <linux-kernel+bounces-334567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1456897D8F8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED0D283269
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862A17CA0B;
	Fri, 20 Sep 2024 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsPGw4bS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86C26AF3
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852868; cv=none; b=RiIYE+DCkWkF1vItwcI7seB+kbP4v9/fgMNtmTYszQK6nChkE+8l7ZtP8m0T/MYSHKoMCy1rReMz+xMhAqNZSwWtOA4qleOtFlS4kmclxohZ3HdZNhDbGEqfeFWbqt8ao0x+376+hVyns19bv6alUsonqepmYa7wgW8sBCpCwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852868; c=relaxed/simple;
	bh=o/WQ321vGq5r6GWnXzdiK11oCOXcE9eV07SXcDtvewU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EOoyu+6+Ud70bktAeDs66LSZAA/AaWP1hcQWUMfeIaR26uhGy4zZO07ayXmI6Gu+XX3iuSBQ/i6co2ja7eveelCJjJ6fvx157Zwx5CWZ2Ta27mi3Iq0JUuvOmr2BhYqGp2fkx99qvDbMSYa5JedHnadXglOuUgGxsUYPboVrMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsPGw4bS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726852867; x=1758388867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o/WQ321vGq5r6GWnXzdiK11oCOXcE9eV07SXcDtvewU=;
  b=jsPGw4bSugGk3sWHuWL/OcbLmaGmQ9uhCAvrY9DGa14j6rGdckTxxtBF
   WuLKv/0W0sHBTwCtp0j196dp0/OVPhFYp8VNXr701Sz6I8BKyD9pKE8Et
   tST13yEPDG15MOMOdobBHYIwdXsphTrJrWskvtCBmoXbjbcacf9uy+R6A
   1O/NDnGZNlnXdeqV8XSyPJNtthbh2VIjfcDiJ3dHXC1oiGQvjOmOhAIsj
   SKNv6A6KyEJCvdMfrveIMRz5Kz2/Dzqp7N69eDCeBzEZl3uBE0HHZAx7v
   w12+O5avH/ekONhf5iYzp1wJAnqrggr7LoQdrnhB8DsKL8xg2a0M5ReaJ
   A==;
X-CSE-ConnectionGUID: n0Y9y7fZRHKhqmMwYIQM4w==
X-CSE-MsgGUID: IwklEgRNSCKQLse5jEFf4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="37243883"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="37243883"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 10:21:06 -0700
X-CSE-ConnectionGUID: /vQYSv6rRcWIVsnIzuP/2w==
X-CSE-MsgGUID: GYJzho//Q3mA5ElCx2zANw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70374302"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Sep 2024 10:21:04 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srhJV-000EiD-21;
	Fri, 20 Sep 2024 17:21:01 +0000
Date: Sat, 21 Sep 2024 01:20:57 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: arch/riscv/kernel/signal.c:129:15: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202409210356.qCeOh9PA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   baeb9a7d8b60b021d907127509c44507539c15e5
commit: 3aff0c459e77ac0fb1c4d6884433467f797f7357 RISC-V: Drop invalid test from CONFIG_AS_HAS_OPTION_ARCH
date:   7 months ago
config: riscv-randconfig-r113-20240920 (https://download.01.org/0day-ci/archive/20240921/202409210356.qCeOh9PA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce: (https://download.01.org/0day-ci/archive/20240921/202409210356.qCeOh9PA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409210356.qCeOh9PA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/signal.c:129:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *datap @@     got void * @@
   arch/riscv/kernel/signal.c:129:15: sparse:     expected void [noderef] __user *datap
   arch/riscv/kernel/signal.c:129:15: sparse:     got void *
>> arch/riscv/kernel/signal.c:129:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *datap @@     got void * @@
   arch/riscv/kernel/signal.c:129:15: sparse:     expected void [noderef] __user *datap
   arch/riscv/kernel/signal.c:129:15: sparse:     got void *
>> arch/riscv/kernel/signal.c:129:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *datap @@     got void * @@
   arch/riscv/kernel/signal.c:129:15: sparse:     expected void [noderef] __user *datap
   arch/riscv/kernel/signal.c:129:15: sparse:     got void *
>> arch/riscv/kernel/signal.c:129:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *datap @@     got void * @@
   arch/riscv/kernel/signal.c:129:15: sparse:     expected void [noderef] __user *datap
   arch/riscv/kernel/signal.c:129:15: sparse:     got void *

vim +129 arch/riscv/kernel/signal.c

8ee0b41898fa26 Greentime Hu 2023-06-05  110  
8ee0b41898fa26 Greentime Hu 2023-06-05  111  /*
8ee0b41898fa26 Greentime Hu 2023-06-05  112   * Restore Vector extension context from the user's signal frame. This function
8ee0b41898fa26 Greentime Hu 2023-06-05  113   * assumes a valid extension header. So magic and size checking must be done by
8ee0b41898fa26 Greentime Hu 2023-06-05  114   * the caller.
8ee0b41898fa26 Greentime Hu 2023-06-05  115   */
8ee0b41898fa26 Greentime Hu 2023-06-05  116  static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
8ee0b41898fa26 Greentime Hu 2023-06-05  117  {
8ee0b41898fa26 Greentime Hu 2023-06-05  118  	long err;
8ee0b41898fa26 Greentime Hu 2023-06-05  119  	struct __sc_riscv_v_state __user *state = sc_vec;
8ee0b41898fa26 Greentime Hu 2023-06-05  120  	void __user *datap;
8ee0b41898fa26 Greentime Hu 2023-06-05  121  
8ee0b41898fa26 Greentime Hu 2023-06-05  122  	/* Copy everything of __sc_riscv_v_state except datap. */
8ee0b41898fa26 Greentime Hu 2023-06-05  123  	err = __copy_from_user(&current->thread.vstate, &state->v_state,
8ee0b41898fa26 Greentime Hu 2023-06-05  124  			       offsetof(struct __riscv_v_ext_state, datap));
8ee0b41898fa26 Greentime Hu 2023-06-05  125  	if (unlikely(err))
8ee0b41898fa26 Greentime Hu 2023-06-05  126  		return err;
8ee0b41898fa26 Greentime Hu 2023-06-05  127  
8ee0b41898fa26 Greentime Hu 2023-06-05  128  	/* Copy the pointer datap itself. */
8ee0b41898fa26 Greentime Hu 2023-06-05 @129  	err = __get_user(datap, &state->v_state.datap);
8ee0b41898fa26 Greentime Hu 2023-06-05  130  	if (unlikely(err))
8ee0b41898fa26 Greentime Hu 2023-06-05  131  		return err;
8ee0b41898fa26 Greentime Hu 2023-06-05  132  	/*
8ee0b41898fa26 Greentime Hu 2023-06-05  133  	 * Copy the whole vector content from user space datap. Use
8ee0b41898fa26 Greentime Hu 2023-06-05  134  	 * copy_from_user to prevent information leak.
8ee0b41898fa26 Greentime Hu 2023-06-05  135  	 */
8ee0b41898fa26 Greentime Hu 2023-06-05  136  	err = copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsize);
8ee0b41898fa26 Greentime Hu 2023-06-05  137  	if (unlikely(err))
8ee0b41898fa26 Greentime Hu 2023-06-05  138  		return err;
8ee0b41898fa26 Greentime Hu 2023-06-05  139  
7df56cbc27e423 Andy Chiu    2024-01-15  140  	riscv_v_vstate_set_restore(current, regs);
8ee0b41898fa26 Greentime Hu 2023-06-05  141  
8ee0b41898fa26 Greentime Hu 2023-06-05  142  	return err;
8ee0b41898fa26 Greentime Hu 2023-06-05  143  }
8ee0b41898fa26 Greentime Hu 2023-06-05  144  #else
8ee0b41898fa26 Greentime Hu 2023-06-05  145  #define save_v_state(task, regs) (0)
8ee0b41898fa26 Greentime Hu 2023-06-05  146  #define __restore_v_state(task, regs) (0)
8ee0b41898fa26 Greentime Hu 2023-06-05  147  #endif
8ee0b41898fa26 Greentime Hu 2023-06-05  148  

:::::: The code at line 129 was first introduced by commit
:::::: 8ee0b41898fa26f66e32237f179b6989c65600d6 riscv: signal: Add sigcontext save/restore for vector

:::::: TO: Greentime Hu <greentime.hu@sifive.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

