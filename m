Return-Path: <linux-kernel+bounces-412303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E39D074A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD58B21571
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 00:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6052A8C07;
	Mon, 18 Nov 2024 00:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lb4A/ulF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8677464
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731890380; cv=none; b=dcufLaChJutfNT6j2PV+KWWY9ABFI6SjklXi+sGTVweriJmpkpYR+VNzxfAZhogOp4sRqg8Bs42v3QwM5pvWIdIOIaRFSuFL+Bf68fR1ZCOQ+RcguYQlvvnBKHFa9DbxF9GsqqFtCeOYBpJqjCtkLujT82PARvX2MZVe2a/8sjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731890380; c=relaxed/simple;
	bh=25Tj53r+qJlyFZW1NArnoTNcs2qjWPG2PZbq/ZE1tLY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HjG7hmZJ5TcqqW24TTbMVNl6NWtqj9UbUbeidUj5GPPpr+KEOKPyA4YlI5xCCNzuGL5xsEoFvLoo+GkIkDnzQgDGy9qHGyYp6JHT8egWwKoe/BACdhCd6IcGeHhmoNWCnymasedpr/GtAF2SF5c0UjeNuOtFswkSKSe8pbleMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lb4A/ulF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731890379; x=1763426379;
  h=date:from:to:cc:subject:message-id;
  bh=25Tj53r+qJlyFZW1NArnoTNcs2qjWPG2PZbq/ZE1tLY=;
  b=Lb4A/ulFYEaC3nCXviFBncf95eYoQfZj+06hZBZDTgEX4Vfi3qK2e2dQ
   Uv4ET/BOqXUXwUBLpeh8pM8LbQQlmqDiv5gHK+j/TxhZauOI4a/SK1ayj
   fPoGQZLj7b77PtDd7lzM8/HGpYLq6TfyYS/Oq/eBqtmbacxoFbt1TdN3z
   rhupGqEqusCSetQ1OVPDWXeCRHqI/udP89hSgc4OLeMJmfqTp5iZhMW9H
   /2H/TW0eaf6zzE1IysQZz/WI2+AtaDaregauNPCenID/yqPcvZDRHtMEb
   DrTyxbl5bQEmDchYlmAmJ75mksL86flwhHKlNRMgqi3gUUmfGy9GOMu2u
   A==;
X-CSE-ConnectionGUID: ej+Otg6fS8CCB4YGvl3Txg==
X-CSE-MsgGUID: aWUqZdGtQxaZ4LLfrxSDFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="35747802"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="35747802"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 16:39:38 -0800
X-CSE-ConnectionGUID: 7DVGomYWQ4G5jEBa0xpnTw==
X-CSE-MsgGUID: +nFjLVbFQlyaycTYyXjSJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="93151026"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Nov 2024 16:39:37 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCpni-00029z-37;
	Mon, 18 Nov 2024 00:39:34 +0000
Date: Mon, 18 Nov 2024 08:39:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 468fbe038f2fc42547db8ba47c9e552e76f52eeb
Message-ID: <202411180856.o2UeImx7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 468fbe038f2fc42547db8ba47c9e552e76f52eeb  Merge branch into tip/master: 'x86/urgent'

elapsed time: 732m

configs tested: 96
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                        nsimosci_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                       aspeed_g5_defconfig    clang-20
arm                         axm55xx_defconfig    clang-20
arm                          ep93xx_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241118    gcc-12
i386        buildonly-randconfig-002-20241118    gcc-12
i386        buildonly-randconfig-003-20241118    gcc-12
i386        buildonly-randconfig-004-20241118    gcc-12
i386        buildonly-randconfig-005-20241118    gcc-12
i386        buildonly-randconfig-006-20241118    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241118    gcc-12
i386                  randconfig-002-20241118    gcc-12
i386                  randconfig-003-20241118    gcc-12
i386                  randconfig-004-20241118    gcc-12
i386                  randconfig-005-20241118    gcc-12
i386                  randconfig-006-20241118    gcc-12
i386                  randconfig-011-20241118    gcc-12
i386                  randconfig-012-20241118    gcc-12
i386                  randconfig-013-20241118    gcc-12
i386                  randconfig-014-20241118    gcc-12
i386                  randconfig-015-20241118    gcc-12
i386                  randconfig-016-20241118    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    clang-20
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-20
mips                           ip27_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
parisc                            allnoconfig    clang-20
powerpc                           allnoconfig    clang-20
powerpc                     ep8248e_defconfig    clang-20
powerpc                    gamecube_defconfig    clang-20
powerpc                    sam440ep_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    clang-20
powerpc64                        alldefconfig    clang-20
riscv                             allnoconfig    clang-20
s390                              allnoconfig    clang-20
sh                                allnoconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    clang-20
sh                           se7750_defconfig    clang-20
sh                   sh7770_generic_defconfig    clang-20
sh                            shmin_defconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241118    gcc-12
x86_64      buildonly-randconfig-002-20241118    gcc-12
x86_64      buildonly-randconfig-003-20241118    gcc-12
x86_64      buildonly-randconfig-004-20241118    gcc-12
x86_64      buildonly-randconfig-005-20241118    gcc-12
x86_64      buildonly-randconfig-006-20241118    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241118    gcc-12
x86_64                randconfig-002-20241118    gcc-12
x86_64                randconfig-003-20241118    gcc-12
x86_64                randconfig-004-20241118    gcc-12
x86_64                randconfig-005-20241118    gcc-12
x86_64                randconfig-006-20241118    gcc-12
x86_64                randconfig-011-20241118    gcc-12
x86_64                randconfig-012-20241118    gcc-12
x86_64                randconfig-013-20241118    gcc-12
x86_64                randconfig-014-20241118    gcc-12
x86_64                randconfig-015-20241118    gcc-12
x86_64                randconfig-016-20241118    gcc-12
x86_64                randconfig-071-20241118    gcc-12
x86_64                randconfig-072-20241118    gcc-12
x86_64                randconfig-073-20241118    gcc-12
x86_64                randconfig-074-20241118    gcc-12
x86_64                randconfig-075-20241118    gcc-12
x86_64                randconfig-076-20241118    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

