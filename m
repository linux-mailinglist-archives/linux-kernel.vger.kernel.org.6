Return-Path: <linux-kernel+bounces-188342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC97A8CE0C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8143C1F214D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DEB127E06;
	Fri, 24 May 2024 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQUq88SS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B91272D6
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530073; cv=none; b=ScXE1jBdAdTsQTjpF2EfKsRfGaGu//TnBgcCl0v205D7+WZ6rDVsG/zKMtu15rj/LrnM6E2zt5ixBB7gqz+1fzadUzIKghACbhkZJUDSx9r4poevjmiL+5Lk31Xvuum42deDcKTaJdqJStKBihivoXp6hPaFESJt9txsF4gy2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530073; c=relaxed/simple;
	bh=wR8rUQACo/Q4pIO6BcwJTj40/z8mHALtyajLOOSORS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wt+LoZTDZDcyDzF96axezDMezZpuY+PXUaLAglpAnHiGSTuZ/QMngVlXziBB6B7Jo6vyXriwGCCZjLCMDrDFlFHoeFU9Xs1TRJ98YfmEJXOZMxSyA81JJGXxiNaSmK8K8lRqxdaeamXe7qPt6cSKuzqFRC8MaVHi6Yo9UQkLciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQUq88SS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716530072; x=1748066072;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wR8rUQACo/Q4pIO6BcwJTj40/z8mHALtyajLOOSORS8=;
  b=mQUq88SSrxtcQ9/dfaAJhdKkWKa0iyAfrkRMOsntiMAkc5qeBUpMwaYk
   c7K14ozWwmqCxOh8zAspLhOlYEjv+YapNsT4FMyBVhgPTVC6VPV2w/ULI
   VJ0DkQV8JNy/rA3/Tzii/BjSvQnOLi2WG845Zr7G78OaI4aLz7CXl2m3Q
   t9YwQR/8DPf2L6mtF2KVjSyb1T4AV3lbLIPBxHBBUrPTDevsfk0+O7MdT
   rAr51nJfpx8FKTUNm2LbOHqk++uZjMkLv+6LQiPgElB4KkPDjLR06R8w3
   feebhGlpV7BcgeATW/E25Uy4iPOCulXEsYHDEO2leIXzspbiAgdzNX7mA
   w==;
X-CSE-ConnectionGUID: NuJL7HRcQXyBNtg/tm5vRA==
X-CSE-MsgGUID: Z5E1M1TvS4eIjucLaonzAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="13079015"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="13079015"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 22:54:32 -0700
X-CSE-ConnectionGUID: lXZLfJuYSUWYrD/CVMvlAA==
X-CSE-MsgGUID: J8lFF2VeRnmMBbSpa8FSPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="38481817"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 23 May 2024 22:54:30 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sANsp-0003w5-25;
	Fri, 24 May 2024 05:54:27 +0000
Date: Fri, 24 May 2024 13:53:35 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: arch/s390/kernel/ipl.c:1973 sys_vmcmd_on_reboot_store() warn:
 unsigned 'len' is never less than zero.
Message-ID: <202405241351.CnSo0Sim-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d69b6c12fce479fde7bc06f686212451688a102
commit: 247576bf624a200b9d4dba6126e760af0d5ebe0e s390/ipl: Do not accept z/VM CP diag X'008' cmds longer than max length
date:   9 days ago
config: s390-randconfig-r081-20240524 (https://download.01.org/0day-ci/archive/20240524/202405241351.CnSo0Sim-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405241351.CnSo0Sim-lkp@intel.com/

smatch warnings:
arch/s390/kernel/ipl.c:1973 sys_vmcmd_on_reboot_store() warn: unsigned 'len' is never less than zero.
arch/s390/kernel/ipl.c:1974 sys_vmcmd_on_panic_store() warn: unsigned 'len' is never less than zero.
arch/s390/kernel/ipl.c:1975 sys_vmcmd_on_halt_store() warn: unsigned 'len' is never less than zero.
arch/s390/kernel/ipl.c:1976 sys_vmcmd_on_poff_store() warn: unsigned 'len' is never less than zero.
arch/s390/kernel/ipl.c:1977 sys_vmcmd_on_restart_store() warn: unsigned 'len' is never less than zero.

vim +/len +1973 arch/s390/kernel/ipl.c

99ca4e582d4a40 Michael Holzheu 2008-01-26  1972  
99ca4e582d4a40 Michael Holzheu 2008-01-26 @1973  DEFINE_IPL_ATTR_STR_RW(vmcmd, on_reboot, "%s\n", "%s\n", vmcmd_on_reboot);
99ca4e582d4a40 Michael Holzheu 2008-01-26 @1974  DEFINE_IPL_ATTR_STR_RW(vmcmd, on_panic, "%s\n", "%s\n", vmcmd_on_panic);
99ca4e582d4a40 Michael Holzheu 2008-01-26 @1975  DEFINE_IPL_ATTR_STR_RW(vmcmd, on_halt, "%s\n", "%s\n", vmcmd_on_halt);
99ca4e582d4a40 Michael Holzheu 2008-01-26 @1976  DEFINE_IPL_ATTR_STR_RW(vmcmd, on_poff, "%s\n", "%s\n", vmcmd_on_poff);
7dd6b3343fdc19 Michael Holzheu 2011-08-03 @1977  DEFINE_IPL_ATTR_STR_RW(vmcmd, on_restart, "%s\n", "%s\n", vmcmd_on_restart);
99ca4e582d4a40 Michael Holzheu 2008-01-26  1978  

:::::: The code at line 1973 was first introduced by commit
:::::: 99ca4e582d4a4088969681efff97be44d98421a1 [S390] kernel: Shutdown Actions Interface

:::::: TO: Michael Holzheu <holzheu@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

