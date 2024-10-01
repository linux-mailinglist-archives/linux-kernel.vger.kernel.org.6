Return-Path: <linux-kernel+bounces-345492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DBE98B6EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A1B281266
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB73199FD0;
	Tue,  1 Oct 2024 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjWGJaV7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2674219ABCB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771411; cv=none; b=LpoEv9Vms6tcRjK4fZ2s3SnzeSmXkPZ9TlcGUKK6nFpsH12uhyfk53e3sbzAhddXed8DhF3eOZt+pCBMyyrohriOXSGtM8qBi4um/5plKhxaUdBO9+lsEIU3ZUcZIdO+HuR+4ux8zdqa2D1GSRHelyqiQceowda/Gm9dOSPl0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771411; c=relaxed/simple;
	bh=KXNVLF/BhjIxqfVUEdpaGwCm1H8r2uTjtulLZMtQxVs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T7nhPLc9jWelsfUBBlYIZg+O70WeY5gCzemGiJFZIbSiNMOpMTU71VHgkp96JfKkmO15KRLj1/5Oeux6QWYxa6PGaNNTAmTszPzTtGVugbDxIrXPdXgLBuMy0ODjDqGAIjdnCiHWhPC5sZP51a309R8Vl1nwCcSlZ/n3tfbXQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjWGJaV7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727771411; x=1759307411;
  h=date:from:to:cc:subject:message-id;
  bh=KXNVLF/BhjIxqfVUEdpaGwCm1H8r2uTjtulLZMtQxVs=;
  b=bjWGJaV725JvZy/K87pRzZNBYofN9pmBM7mUIm2LoaiQjsN8zvq64rOC
   42MiTL901mfopPQ9McEEfzq+evxTBn6QboXevJ7YzMc4m+23WnTu53yjj
   r+JTFkeD/8+3pzSu0fp3PVqL0fu35tYZrqXbxXhu0E8oY63cyYFe5s/Pr
   XaIOIuKkMyPtA+32Vzjzaej8RtAz23bzK8BhjW3h0y1dFYW/P1lE9jdBx
   6QL3831uigc8suvKJiySB/FVBTjRmgeL2N2njg/mEU9bvLQxq7oe0SbSf
   x4Zeuk8Y/co3gCvtSIsWdGby22Sp/c/rgf4DgPKLwFoF7RKhyc3j2p/qD
   A==;
X-CSE-ConnectionGUID: kjuNIEmoQ56Y9rVnvpyjww==
X-CSE-MsgGUID: Q+kfbM6YSzqOa3VNlQ0vXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37450808"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37450808"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 01:30:06 -0700
X-CSE-ConnectionGUID: S+tyXRyASCa+Pu3jtM+FjQ==
X-CSE-MsgGUID: 7KPowE7UTO6E51Mm+d720A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73911942"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 Oct 2024 01:30:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svYGd-000QRF-2L;
	Tue, 01 Oct 2024 08:29:59 +0000
Date: Tue, 01 Oct 2024 16:29:50 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 86e39b94cd71a4987f9b98dd2a7d6c826e1c5c98
Message-ID: <202410011642.LVyByJde-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 86e39b94cd71a4987f9b98dd2a7d6c826e1c5c98  x86/bugs: Correct RSB terminology in Kconfig

elapsed time: 878m

configs tested: 77
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                          axs103_defconfig    gcc-14.1.0
arm                               allnoconfig    gcc-14.1.0
arm                          collie_defconfig    gcc-14.1.0
arm                     davinci_all_defconfig    gcc-14.1.0
arm                         lpc18xx_defconfig    gcc-14.1.0
arm                       versatile_defconfig    gcc-14.1.0
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241001    clang-18
i386        buildonly-randconfig-002-20241001    gcc-12
i386        buildonly-randconfig-003-20241001    clang-18
i386        buildonly-randconfig-004-20241001    gcc-12
i386        buildonly-randconfig-005-20241001    clang-18
i386        buildonly-randconfig-006-20241001    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241001    gcc-12
i386                  randconfig-002-20241001    clang-18
i386                  randconfig-003-20241001    clang-18
i386                  randconfig-004-20241001    gcc-12
i386                  randconfig-005-20241001    clang-18
i386                  randconfig-006-20241001    clang-18
i386                  randconfig-011-20241001    gcc-12
i386                  randconfig-012-20241001    gcc-12
i386                  randconfig-013-20241001    gcc-12
i386                  randconfig-014-20241001    gcc-11
i386                  randconfig-015-20241001    gcc-12
i386                  randconfig-016-20241001    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                         db1xxx_defconfig    gcc-14.1.0
mips                           rs90_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                  or1klitex_defconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
powerpc                           allnoconfig    clang-20
powerpc                 canyonlands_defconfig    gcc-14.1.0
powerpc                        cell_defconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                         wii_defconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
s390                              allnoconfig    clang-20
sh                               alldefconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                            titan_defconfig    gcc-14.1.0
sh                              ul2_defconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

