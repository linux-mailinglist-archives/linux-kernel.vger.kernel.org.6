Return-Path: <linux-kernel+bounces-383107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F19B1766
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D07283A2D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14BE1D3566;
	Sat, 26 Oct 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0BGqrzX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B001D1F76
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941726; cv=none; b=NwWhxrIRF6tcs8rcMT9JSSuCyNz+3aWErgPKzYoYE6fkErpG1ZUpvWGTBdDGCBJxLKHlMxIjcLpPI9VIVqYQnGcZNMh9eD96K2KPmAj11vQl0f9SvDlrXkku9aVjU8lIEUGezrCsI9L1ypPhFx9IU389NGjdX8QfPkJFx0sNw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941726; c=relaxed/simple;
	bh=k7p3CTvlWWd4S35n05JPBcvVtNohKaXVeyShApaSYq0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AaHSULR5fOs2fXyrlDYJf7/4s1+/VRS9CF3JPvF4YzaNTFL8E/Ze4PmeOlKQvkovlwu1e1uJ0VZHgrzauUmqygn3Lh8Nhkhph1dGz0y/aydHr87XPmqO2kxfDKZA0H0FPwr1evtK7H/bgV4A8AF4FX2s+SRGz3SXvazkHGSSgsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0BGqrzX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729941720; x=1761477720;
  h=date:from:to:cc:subject:message-id;
  bh=k7p3CTvlWWd4S35n05JPBcvVtNohKaXVeyShApaSYq0=;
  b=k0BGqrzXyN3KnJe9H3rdilSFxsvB0CYC81QIGUIGfriJqtmxHpvYwk6p
   3XIU39zlV9kDai/8Dad+9Hf+3JmHFp8wKv7vHkU/r9paiuBJ7ox4PSuGE
   gU8UgtJYSM6gNRxr7jmj+RirpLL7GYx0H30ZMwhgog7ZOTclLr/RQTKFg
   OT6Bzjr733LrsGZ3V5NzSML3bxNxSMzzgqwmv8H6mYCnbA04fHhEXD8/N
   0M5bAtBo2EfpwfXRpTOgDfc8k4Z50q1QUV74jg07FdlxezAw64Zoo5TRC
   adEegww3k3WqzItQHjYKq/BqeCie2i2ye4IzHGrQ9MU3fX/iq4FEepflS
   w==;
X-CSE-ConnectionGUID: sGMbqGB1Q8GLNyhLBP8edg==
X-CSE-MsgGUID: Rzn3DT/pTd249EfXxDG39Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40224069"
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="40224069"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 04:21:59 -0700
X-CSE-ConnectionGUID: HNDtTgiCSf+z0UUcocx9UQ==
X-CSE-MsgGUID: Vho3mV+CS8Sg10E0SMezJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="85773107"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Oct 2024 04:21:58 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4erk-000ZYy-0d;
	Sat, 26 Oct 2024 11:21:56 +0000
Date: Sat, 26 Oct 2024 19:21:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 92b043fd995a63a57aae29ff85a39b6f30cd440c
Message-ID: <202410261919.jhCHc0cC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 92b043fd995a63a57aae29ff85a39b6f30cd440c  time: Fix references to _msecs_to_jiffies() handling of values

Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-allnoconfig
    `-- Warning:drivers-regulator-core.c-references-a-file-that-doesn-t-exist:Documentation-timers-timers-howto.rst

elapsed time: 987m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-14.1.0
alpha                  allyesconfig    clang-20
alpha                     defconfig    gcc-14.1.0
arc                    allmodconfig    clang-20
arc                     allnoconfig    gcc-14.1.0
arc                    allyesconfig    clang-20
arc                       defconfig    gcc-14.1.0
arc         randconfig-001-20241026    gcc-14.1.0
arc         randconfig-002-20241026    gcc-14.1.0
arm                    allmodconfig    clang-20
arm                     allnoconfig    gcc-14.1.0
arm                    allyesconfig    clang-20
arm             aspeed_g5_defconfig    clang-20
arm               axm55xx_defconfig    clang-20
arm                       defconfig    gcc-14.1.0
arm                gemini_defconfig    clang-20
arm                 h3600_defconfig    clang-20
arm                  mps2_defconfig    clang-20
arm                pxa168_defconfig    clang-20
arm         randconfig-001-20241026    gcc-14.1.0
arm         randconfig-002-20241026    gcc-14.1.0
arm         randconfig-003-20241026    gcc-14.1.0
arm         randconfig-004-20241026    gcc-14.1.0
arm64                  allmodconfig    clang-20
arm64                   allnoconfig    gcc-14.1.0
arm64                     defconfig    gcc-14.1.0
arm64       randconfig-001-20241026    gcc-14.1.0
arm64       randconfig-002-20241026    gcc-14.1.0
arm64       randconfig-003-20241026    gcc-14.1.0
arm64       randconfig-004-20241026    gcc-14.1.0
csky                    allnoconfig    gcc-14.1.0
csky                      defconfig    gcc-14.1.0
csky        randconfig-001-20241026    gcc-14.1.0
csky        randconfig-002-20241026    gcc-14.1.0
hexagon                allmodconfig    clang-20
hexagon                 allnoconfig    gcc-14.1.0
hexagon                allyesconfig    clang-20
hexagon                   defconfig    gcc-14.1.0
hexagon     randconfig-001-20241026    gcc-14.1.0
hexagon     randconfig-002-20241026    gcc-14.1.0
i386                   allmodconfig    clang-19
i386                    allnoconfig    clang-19
i386                   allyesconfig    clang-19
i386                      defconfig    clang-19
loongarch              allmodconfig    gcc-14.1.0
loongarch               allnoconfig    gcc-14.1.0
loongarch                 defconfig    gcc-14.1.0
loongarch   randconfig-001-20241026    gcc-14.1.0
loongarch   randconfig-002-20241026    gcc-14.1.0
m68k                   allmodconfig    gcc-14.1.0
m68k                    allnoconfig    gcc-14.1.0
m68k                   allyesconfig    gcc-14.1.0
m68k                      defconfig    gcc-14.1.0
microblaze             allmodconfig    gcc-14.1.0
microblaze              allnoconfig    gcc-14.1.0
microblaze             allyesconfig    gcc-14.1.0
microblaze                defconfig    gcc-14.1.0
mips                    allnoconfig    gcc-14.1.0
mips               db1xxx_defconfig    clang-20
nios2                   allnoconfig    gcc-14.1.0
nios2                     defconfig    gcc-14.1.0
nios2       randconfig-001-20241026    gcc-14.1.0
nios2       randconfig-002-20241026    gcc-14.1.0
openrisc                allnoconfig    clang-20
openrisc               allyesconfig    gcc-14.1.0
openrisc                  defconfig    gcc-12
parisc                 allmodconfig    gcc-14.1.0
parisc                  allnoconfig    clang-20
parisc                 allyesconfig    gcc-14.1.0
parisc                    defconfig    gcc-12
parisc      randconfig-001-20241026    gcc-14.1.0
parisc      randconfig-002-20241026    gcc-14.1.0
parisc64                  defconfig    gcc-14.1.0
powerpc                allmodconfig    gcc-14.1.0
powerpc                 allnoconfig    clang-20
powerpc                allyesconfig    gcc-14.1.0
powerpc             holly_defconfig    clang-20
powerpc            katmai_defconfig    clang-20
powerpc       mpc832x_rdb_defconfig    clang-20
powerpc        mpc866_ads_defconfig    clang-20
powerpc               ps3_defconfig    clang-20
powerpc     randconfig-001-20241026    gcc-14.1.0
powerpc     randconfig-002-20241026    gcc-14.1.0
powerpc     randconfig-003-20241026    gcc-14.1.0
powerpc          sam440ep_defconfig    clang-20
powerpc64   randconfig-001-20241026    gcc-14.1.0
powerpc64   randconfig-002-20241026    gcc-14.1.0
powerpc64   randconfig-003-20241026    gcc-14.1.0
riscv                  allmodconfig    gcc-14.1.0
riscv                   allnoconfig    clang-20
riscv                  allyesconfig    gcc-14.1.0
riscv                     defconfig    clang-20
riscv                     defconfig    gcc-12
riscv       randconfig-001-20241026    gcc-14.1.0
riscv       randconfig-002-20241026    gcc-14.1.0
s390                   allmodconfig    gcc-14.1.0
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.1.0
s390                      defconfig    gcc-12
s390        randconfig-001-20241026    gcc-14.1.0
s390        randconfig-002-20241026    gcc-14.1.0
sh                     allmodconfig    gcc-14.1.0
sh                      allnoconfig    gcc-14.1.0
sh                     allyesconfig    gcc-14.1.0
sh               apsh4a3a_defconfig    clang-20
sh                        defconfig    gcc-12
sh          randconfig-001-20241026    gcc-14.1.0
sh          randconfig-002-20241026    gcc-14.1.0
sparc                  alldefconfig    clang-20
sparc                  allmodconfig    gcc-14.1.0
sparc64                   defconfig    gcc-12
sparc64     randconfig-001-20241026    gcc-14.1.0
sparc64     randconfig-002-20241026    gcc-14.1.0
um                     allmodconfig    clang-20
um                      allnoconfig    clang-20
um                     allyesconfig    clang-20
um                        defconfig    gcc-12
um                   i386_defconfig    gcc-12
um          randconfig-001-20241026    gcc-14.1.0
um          randconfig-002-20241026    gcc-14.1.0
um                 x86_64_defconfig    gcc-12
x86_64                  allnoconfig    clang-19
x86_64                 allyesconfig    clang-19
x86_64                    defconfig    clang-19
x86_64                        kexec    clang-19
x86_64                     rhel-8.3    gcc-12
x86_64                 rhel-8.3-bpf    clang-19
x86_64               rhel-8.3-kunit    clang-19
x86_64                 rhel-8.3-ltp    clang-19
x86_64                rhel-8.3-rust    clang-19
xtensa                  allnoconfig    gcc-14.1.0
xtensa      randconfig-001-20241026    gcc-14.1.0
xtensa      randconfig-002-20241026    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

