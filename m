Return-Path: <linux-kernel+bounces-362730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D099B8BF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E37C2822E9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC8912C475;
	Sun, 13 Oct 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeHiJeWR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578EA36B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728804823; cv=none; b=tUfAMBGRnVToJrL7S6qWMKwrIVhV8dZnbXYToLsQbbT+k8OmZkNiFOXFNxyLh2mYl1lEwJRM+y6IQc7Qlx+TSfrhfw4KtnxOnsVbtvHsKJoH0SLlR5j91yyvOd09gOSpkJiy0Hxcv4HE1a20QZGunECXgQM9raelckoYvbTzT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728804823; c=relaxed/simple;
	bh=erGxWocIpXVcsIsmWRRelFF7utCB/F5sOtGw8CGQFHI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oNjK2HjddAH+E/cHdSx+o/Cr8j5iSmvtJjRSj197c9N8LTaMTnm5DOnFn2CNdZw6t0NkyTf7v2p/LVpatxrzQDQLC9mkBlF18wypc+eXUDGq8g47nhQnC58OJWBXqxcAI9ZdxdyrJ6zz8iravMd86p8JTah5j1Eb8Ic/W2TJuvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeHiJeWR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728804821; x=1760340821;
  h=date:from:to:cc:subject:message-id;
  bh=erGxWocIpXVcsIsmWRRelFF7utCB/F5sOtGw8CGQFHI=;
  b=eeHiJeWRkDWqAA/CehIcGg3s2N/qOjhDeT5HFWaaYh5Sp2yZMToyHWlf
   5HjAmlQU4PU7XZ7yKtJwiIPIkF7WUJCtSbfXVQmGuIbUdKHw6LziYTvzh
   qOHit6KmArdvoeh3zwA2tBPUoJxbL/XQMooj3g3RN4eHtVjf7Njm/mDAw
   wGNUzaavSex5TG63zmKviYZ/fgC87vNB0kBpnQyJFv8DIo9lZ5jU7MmdR
   kFlHoVXu3EspMsmDVpEVmI8OHjvRCz5HASk9mUfWiylRF+JpOpj2Wa7WR
   i0pW1hwkbSVydjxJv5xu1G4GGwWKMqlsR8iqJ94/I/wJcYPkuHvk78pmA
   w==;
X-CSE-ConnectionGUID: 2GJ4S8ZVTxezvbYAGgmkgg==
X-CSE-MsgGUID: EtWaPvDDQnq4sOBH/UQ1xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32076672"
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="32076672"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 00:33:40 -0700
X-CSE-ConnectionGUID: trIp1mpkTRukjm3bbvvyjw==
X-CSE-MsgGUID: fLEYFYnRTEOdi4gWaiz8Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82076679"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 13 Oct 2024 00:33:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szt6f-000EB1-0g;
	Sun, 13 Oct 2024 07:33:37 +0000
Date: Sun, 13 Oct 2024 15:33:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b89c62b65ebd76b06d68b324d630b36e31822cb1
Message-ID: <202410131501.1VVG4Jwl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b89c62b65ebd76b06d68b324d630b36e31822cb1  Merge branch into tip/master: 'x86/misc'

elapsed time: 2643m

configs tested: 155
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                   randconfig-001-20241013    gcc-14.1.0
arc                   randconfig-002-20241013    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                          exynos_defconfig    clang-20
arm                      footbridge_defconfig    clang-20
arm                        mvebu_v5_defconfig    clang-20
arm                   randconfig-001-20241013    gcc-14.1.0
arm                   randconfig-002-20241013    gcc-14.1.0
arm                   randconfig-003-20241013    gcc-14.1.0
arm                   randconfig-004-20241013    gcc-14.1.0
arm                        realview_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241013    gcc-14.1.0
arm64                 randconfig-002-20241013    gcc-14.1.0
arm64                 randconfig-003-20241013    gcc-14.1.0
arm64                 randconfig-004-20241013    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241013    gcc-14.1.0
csky                  randconfig-002-20241013    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241013    gcc-14.1.0
hexagon               randconfig-002-20241013    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241013    clang-18
i386        buildonly-randconfig-002-20241013    gcc-12
i386        buildonly-randconfig-003-20241013    clang-18
i386        buildonly-randconfig-004-20241013    gcc-12
i386        buildonly-randconfig-005-20241013    clang-18
i386        buildonly-randconfig-006-20241013    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241013    clang-18
i386                  randconfig-002-20241013    gcc-12
i386                  randconfig-003-20241013    gcc-12
i386                  randconfig-004-20241013    gcc-11
i386                  randconfig-005-20241013    clang-18
i386                  randconfig-006-20241013    clang-18
i386                  randconfig-011-20241013    clang-18
i386                  randconfig-012-20241013    gcc-12
i386                  randconfig-013-20241013    clang-18
i386                  randconfig-014-20241013    gcc-12
i386                  randconfig-015-20241013    clang-18
i386                  randconfig-016-20241013    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241013    gcc-14.1.0
loongarch             randconfig-002-20241013    gcc-14.1.0
m68k                             alldefconfig    clang-20
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                        mvme147_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           gcw0_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241013    gcc-14.1.0
nios2                 randconfig-002-20241013    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241013    gcc-14.1.0
parisc                randconfig-002-20241013    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                 mpc8315_rdb_defconfig    clang-20
powerpc               mpc834x_itxgp_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-20
powerpc               randconfig-001-20241013    gcc-14.1.0
powerpc               randconfig-002-20241013    gcc-14.1.0
powerpc               randconfig-003-20241013    gcc-14.1.0
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm5200_defconfig    clang-20
powerpc                     tqm8540_defconfig    clang-20
powerpc                      tqm8xx_defconfig    clang-20
powerpc64             randconfig-001-20241013    gcc-14.1.0
powerpc64             randconfig-002-20241013    gcc-14.1.0
powerpc64             randconfig-003-20241013    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241013    gcc-14.1.0
riscv                 randconfig-002-20241013    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241013    gcc-14.1.0
s390                  randconfig-002-20241013    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    clang-20
sh                    randconfig-001-20241013    gcc-14.1.0
sh                    randconfig-002-20241013    gcc-14.1.0
sh                     sh7710voipgw_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241013    gcc-14.1.0
sparc64               randconfig-002-20241013    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241013    gcc-14.1.0
um                    randconfig-002-20241013    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241013    clang-18
x86_64      buildonly-randconfig-002-20241013    clang-18
x86_64      buildonly-randconfig-003-20241013    clang-18
x86_64      buildonly-randconfig-004-20241013    clang-18
x86_64      buildonly-randconfig-005-20241013    clang-18
x86_64      buildonly-randconfig-006-20241013    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20241013    clang-18
x86_64                randconfig-002-20241013    clang-18
x86_64                randconfig-003-20241013    clang-18
x86_64                randconfig-004-20241013    clang-18
x86_64                randconfig-005-20241013    clang-18
x86_64                randconfig-006-20241013    clang-18
x86_64                randconfig-011-20241013    clang-18
x86_64                randconfig-012-20241013    clang-18
x86_64                randconfig-013-20241013    clang-18
x86_64                randconfig-014-20241013    clang-18
x86_64                randconfig-015-20241013    clang-18
x86_64                randconfig-016-20241013    clang-18
x86_64                randconfig-071-20241013    clang-18
x86_64                randconfig-072-20241013    clang-18
x86_64                randconfig-073-20241013    clang-18
x86_64                randconfig-074-20241013    clang-18
x86_64                randconfig-075-20241013    clang-18
x86_64                randconfig-076-20241013    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241013    gcc-14.1.0
xtensa                randconfig-002-20241013    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

