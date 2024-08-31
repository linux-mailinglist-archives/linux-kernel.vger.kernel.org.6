Return-Path: <linux-kernel+bounces-309746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F3966FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082C82847D1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B8016EBE6;
	Sat, 31 Aug 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSwXl+bH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E616EB7C
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087894; cv=none; b=HwtV9foM9RkhoZAcsVG+M5wjYCiLQlR9S0nfri2PVUs6YsFUa+nyS6QqAHB45JcEWM9C8l82Mi9RHebvEAJ+ZxC8HwDL/lw2Qi2OURw46l+ZZMXe9d9+qcIxsSu8whS9UkuTyKhaSMPvnuXvrIJ2gJBC9XiG8P2FczrXAUtu0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087894; c=relaxed/simple;
	bh=fwMdMbVs3xWVXCibYnDgqCXntz3zNkHDn0/8xaVKBo8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oyUgkMvUqF5/3cmyoc8krhgp+7mI4NTeyH+X+Xrt278i98XvX5qQ8MnpOAGhnVV1r3n5evZVpEbAyyBC7tbrAv0y76SRkX78SSMb+68eXzNm36MZWKAVidhQ/Nzcqmid3f79IiBRD6TGPRY8YPuEuMQ3UaHm4Clf7dh1B+iM96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSwXl+bH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725087892; x=1756623892;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fwMdMbVs3xWVXCibYnDgqCXntz3zNkHDn0/8xaVKBo8=;
  b=JSwXl+bH387uAdBQZtuRyZzxjRh9iJ8hurmKY1hFKUZIXzrDquvqdPAa
   R5tdX8leI0iFbJKgmIoxX0p3KoQG/0eIEnjqN4df3+SG06sC7uQK4GlB7
   NVbyu0dUopuoF2p0wTXVujM9RGBP4xaMqJO5qZnYdetzQEpzXpd3+/eNf
   Vqr7qe5SntmHBokdvKM9SqIn1tXssPNDpj6o/0VSLwVUSF/e71YLQ9AB7
   2z8YiWXCHMTme6DhBOIE8PUCUrntI5+LOXWG1IYrXZ6r4lkLlIIJsKSJV
   6ZqN10/xiRhzKYaNrWeh8mA+Su9uV3YkEYx6CDH0N5Y0qu/nseizxR4Sd
   w==;
X-CSE-ConnectionGUID: UMFPbBCbQCWNaFu9Yjmsrw==
X-CSE-MsgGUID: oYwhPVTlSzyho22Wvu2Z5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13308909"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="13308909"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 00:04:52 -0700
X-CSE-ConnectionGUID: WAUuO70SS1WIl5cd075NFA==
X-CSE-MsgGUID: TTqS330XSe6xY4e+9zL6zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="64467303"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 31 Aug 2024 00:04:50 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skIAC-0002Pq-06;
	Sat, 31 Aug 2024 07:04:48 +0000
Date: Sat, 31 Aug 2024 15:04:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.08.30a 28/33] include/linux/srcu.h:274:37:
 error: 'SRCU_READ_FLAVOR_LITE' undeclared
Message-ID: <202408311559.fzAoy2aD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.08.30a
head:   05416eb79213ad6a9770faa795059fdd00adb6e0
commit: 23265e8fd7b05be03428c2e7632440d8573e5e7e [28/33] srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
config: m68k-randconfig-r072-20240831 (https://download.01.org/0day-ci/archive/20240831/202408311559.fzAoy2aD-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311559.fzAoy2aD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311559.fzAoy2aD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/notifier.h:16,
                    from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:1432,
                    from include/linux/topology.h:33,
                    from include/linux/irq.h:19,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:8,
                    from arch/m68k/kernel/asm-offsets.c:16:
   include/linux/srcu.h: In function 'srcu_read_lock':
   include/linux/srcu.h:248:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     248 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h:248:37: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/srcu.h: In function 'srcu_read_lock_lite':
>> include/linux/srcu.h:274:37: error: 'SRCU_READ_FLAVOR_LITE' undeclared (first use in this function)
     274 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
         |                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_lock_nmisafe':
   include/linux/srcu.h:295:37: error: 'SRCU_READ_FLAVOR_NMI' undeclared (first use in this function)
     295 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
         |                                     ^~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_lock_notrace':
   include/linux/srcu.h:307:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     307 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_down_read':
   include/linux/srcu.h:336:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     336 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_unlock':
   include/linux/srcu.h:351:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     351 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_unlock_lite':
   include/linux/srcu.h:367:37: error: 'SRCU_READ_FLAVOR_LITE' undeclared (first use in this function)
     367 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
         |                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_unlock_nmisafe':
   include/linux/srcu.h:383:37: error: 'SRCU_READ_FLAVOR_NMI' undeclared (first use in this function)
     383 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
         |                                     ^~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_unlock_notrace':
   include/linux/srcu.h:392:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     392 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_up_read':
   include/linux/srcu.h:409:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     409 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:117: arch/m68k/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1193: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/SRCU_READ_FLAVOR_LITE +274 include/linux/srcu.h

   253	
   254	/**
   255	 * srcu_read_lock_lite - register a new reader for an SRCU-protected structure.
   256	 * @ssp: srcu_struct in which to register the new reader.
   257	 *
   258	 * Enter an SRCU read-side critical section, but for a light-weight
   259	 * smp_mb()-free reader.  See srcu_read_lock() for more information.
   260	 *
   261	 * If srcu_read_lock_lite() is ever used on an srcu_struct structure,
   262	 * then none of the other flavors may be used, whether before, during,
   263	 * or after.  Note that grace-period auto-expediting is disabled for _lite
   264	 * srcu_struct structures because auto-expedited grace periods invoke
   265	 * synchronize_rcu_expedited(), IPIs and all.
   266	 *
   267	 * Note that srcu_read_lock_lite() can be invoked only from those contexts
   268	 * where RCU is watching.  Otherwise, lockdep will complain.
   269	 */
   270	static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
   271	{
   272		int retval;
   273	
 > 274		srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
   275		retval = __srcu_read_lock_lite(ssp);
   276		rcu_try_lock_acquire(&ssp->dep_map);
   277		return retval;
   278	}
   279	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

