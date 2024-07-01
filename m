Return-Path: <linux-kernel+bounces-236363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D891E122
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13EB1C229F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874915E5D3;
	Mon,  1 Jul 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kai1E2eP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E88C14B942
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841717; cv=none; b=Hwc/eGaJvhTZhmuq3+ahGA24/1Dodksq+w7CSulICZKa6gko2nbKBR3dAPKkTCpGtgRKiHnHmRaXkQ9HvqmFIQ5AYKEvfMU0boVdJ72Z78lte+5/27l2NHBWGC6TWxIC3VQl2SbnjbU/AaCKjCEWI5NHS3tCql14IyVC6NItGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841717; c=relaxed/simple;
	bh=iYgcRJbh9kbgs01c4b/3FKSTJAO9p8DfTRRlJ2iGuL0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iXh12Ntu29RKafS2mKrvjguVbOg2LHOo+6+HD69brE5M7uJd6NjOmQ9oEDqQPnYQIc98mTARdi/fo6Ro+YLSRVw74uWQfOGJ75XeM49A3AYrr0QsK0ZeXbb8xrntUoJ5ux5An57TearKnlmtEHaLuAEadIaC6MMX5/d7iraJHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kai1E2eP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719841716; x=1751377716;
  h=date:from:to:cc:subject:message-id;
  bh=iYgcRJbh9kbgs01c4b/3FKSTJAO9p8DfTRRlJ2iGuL0=;
  b=kai1E2ePvgE7gP4693ttqfMYLrWJ1rdEmENVX0IfCye6PXSXEUlBvu1I
   3jnkOV1kQBC3XmF6kWkO5LyK8HQSPRZ5DM0xSSNfhphpwx+Vi1CVjjCjA
   bj/R8w/iAJVZCOscIhlkV0xzv/Y9JoGuMYwkNjBi0fwAGjye4Q3pUeKpz
   OkBNm9zSVfRmwLhP+8kbtglR0dwbMSP2hDwhvbz43J7n0+8WXmDBx2JHi
   5g9MBLmW6O/a9MciegnedxGeOyysk62WfdWUbU+Db16GHCqMa5lJxvRpX
   3VmlQG1GHhhSvdLm/LtZywC7MvXnACM0H6RVjtsxO8qAB1LHdfrd7gWNP
   w==;
X-CSE-ConnectionGUID: lEFwl6U6SS6RrrhDGh1ClQ==
X-CSE-MsgGUID: sK+a2FVbQNu/O+aPFb6saA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17106329"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17106329"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 06:48:35 -0700
X-CSE-ConnectionGUID: 3yEZiC6GTWaekxGVsO8m0g==
X-CSE-MsgGUID: qG6baUAbR8aKOJCgqbKT8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="50732815"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Jul 2024 06:48:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOHOS-000MsY-0A;
	Mon, 01 Jul 2024 13:48:32 +0000
Date: Mon, 01 Jul 2024 21:48:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 bb781d27138b9ac018a1f2ecc9204fd0102282b5
Message-ID: <202407012102.J0cIjkVC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: bb781d27138b9ac018a1f2ecc9204fd0102282b5  Merge branch 'x86/cpu' into x86/merge, to resolve conflicts and to ease integration testing

elapsed time: 14475m

configs tested: 44
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240622   gcc-13
i386         buildonly-randconfig-004-20240622   gcc-13
i386         buildonly-randconfig-005-20240622   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240622   gcc-10
i386                  randconfig-003-20240622   gcc-13
i386                  randconfig-004-20240622   gcc-13
i386                  randconfig-006-20240622   gcc-13
i386                  randconfig-011-20240622   gcc-9
i386                  randconfig-012-20240622   gcc-7
loongarch                        allmodconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
riscv                            allmodconfig   clang-19
riscv                            allyesconfig   clang-19
s390                             allmodconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allyesconfig   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

