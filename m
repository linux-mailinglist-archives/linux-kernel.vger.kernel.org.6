Return-Path: <linux-kernel+bounces-393916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F13D9BA768
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4A6281DCA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBF0142659;
	Sun,  3 Nov 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAcaZgrw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416770817
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730658580; cv=none; b=MKhs8Tp6zIKuT3aE5HSv8zJ3g04BL5dFnDnzvIEqCvkSBJtUNvAdcKfqfClmrxxBFkQlJsoWsj6zlxihcEOjUaFy7sA6zCzBLuWtQ8/nU1ZoS6xZ34szfTeEKWYGd3F3feeJkg4ew54TgHzFJOPrg6IRT4zdelNnqlibgmPpme4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730658580; c=relaxed/simple;
	bh=024YN53BVGRcpWt7epqkdxX28al6UoUCCiKDxtIM13w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z9Z3zJmV+r7wbrkX8JVHELnk+JX2kbiPnSEpzHhpjoAUNgOhaUkNjD6VaCgp4YvvXA7G4H8ffuRG8xya3u3Ikr0hwic+IF+BIZ0fQc0VPAbqk4rv2lDIm3JhiSjpIYHFaVCdrNiyaPdy8jfCzrbql1p6Rmaw1nXjB41xydiwKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAcaZgrw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730658579; x=1762194579;
  h=date:from:to:cc:subject:message-id;
  bh=024YN53BVGRcpWt7epqkdxX28al6UoUCCiKDxtIM13w=;
  b=RAcaZgrwC9JfxsfDXCrmmx7aB/OPfgt7UTXS1G14tvI2IxK1PJBqQwzF
   04+C0Se2vV32WmjnRCESJvtRlLX8gtcbpzyJaV0Iv/Yo+y1VtfYgxIMBk
   w1AuEcpTM/Vb8uX3yl4gTH7LYGfxlQdR0WHJjU99glxBvctChoKnx43Ax
   C+0REY21I2UmNzHsVfNj7HvhBK0Lm5QrAHo+Jm1rjLcIi97W7So0XpmQD
   KdOuAoRYtzgbbyDbqjJoduu4AOXaJmnkMXuKFkofQxZi+qaRHtBkQqvMq
   kDhcnK1PkhJXwzqd1kmd8f7JP3904YdA2a1pWFHZPgXQH6Q/KUlHUPlTv
   Q==;
X-CSE-ConnectionGUID: hBUU9w9iS06XkuqM3R1Ydw==
X-CSE-MsgGUID: B9LgXcITToKwWoyVBmVr3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30515606"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30515606"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 10:29:38 -0800
X-CSE-ConnectionGUID: 5V475YG2TiGs4dcPquAEFQ==
X-CSE-MsgGUID: 57z1OMDqRwOopWHOHUE9mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,255,1725346800"; 
   d="scan'208";a="88594432"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Nov 2024 10:29:37 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7fLz-000k85-0J;
	Sun, 03 Nov 2024 18:29:35 +0000
Date: Mon, 04 Nov 2024 02:29:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4b9984799820b5b32b0ae1f3d8074886895a44e1
Message-ID: <202411040247.S86dBSMy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4b9984799820b5b32b0ae1f3d8074886895a44e1  Merge branch into tip/master: 'x86/sev'

elapsed time: 753m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    clang-20
arc                              alldefconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-20
arc                   randconfig-001-20241103    gcc-14.1.0
arc                   randconfig-002-20241103    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.1.0
arm                          pxa3xx_defconfig    gcc-14.1.0
arm                   randconfig-001-20241103    gcc-14.1.0
arm                   randconfig-002-20241103    gcc-14.1.0
arm                   randconfig-003-20241103    gcc-14.1.0
arm                   randconfig-004-20241103    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241103    gcc-14.1.0
arm64                 randconfig-002-20241103    gcc-14.1.0
arm64                 randconfig-003-20241103    gcc-14.1.0
arm64                 randconfig-004-20241103    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241103    gcc-14.1.0
csky                  randconfig-002-20241103    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241103    gcc-14.1.0
hexagon               randconfig-002-20241103    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241103    clang-19
i386        buildonly-randconfig-002-20241103    clang-19
i386        buildonly-randconfig-003-20241103    clang-19
i386        buildonly-randconfig-004-20241103    clang-19
i386        buildonly-randconfig-005-20241103    clang-19
i386        buildonly-randconfig-006-20241103    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241103    clang-19
i386                  randconfig-002-20241103    clang-19
i386                  randconfig-003-20241103    clang-19
i386                  randconfig-004-20241103    clang-19
i386                  randconfig-005-20241103    clang-19
i386                  randconfig-006-20241103    clang-19
i386                  randconfig-011-20241103    clang-19
i386                  randconfig-012-20241103    clang-19
i386                  randconfig-013-20241103    clang-19
i386                  randconfig-014-20241103    clang-19
i386                  randconfig-015-20241103    clang-19
i386                  randconfig-016-20241103    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241103    gcc-14.1.0
loongarch             randconfig-002-20241103    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ip32_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241103    gcc-14.1.0
nios2                 randconfig-002-20241103    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241103    gcc-14.1.0
parisc                randconfig-002-20241103    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    amigaone_defconfig    gcc-14.1.0
powerpc                       maple_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241103    gcc-14.1.0
powerpc               randconfig-002-20241103    gcc-14.1.0
powerpc               randconfig-003-20241103    gcc-14.1.0
powerpc64             randconfig-001-20241103    gcc-14.1.0
powerpc64             randconfig-002-20241103    gcc-14.1.0
powerpc64             randconfig-003-20241103    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241103    gcc-14.1.0
riscv                 randconfig-002-20241103    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241103    gcc-14.1.0
s390                  randconfig-002-20241103    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-14.1.0
sh                 kfr2r09-romimage_defconfig    gcc-14.1.0
sh                    randconfig-001-20241103    gcc-14.1.0
sh                    randconfig-002-20241103    gcc-14.1.0
sh                          rsk7264_defconfig    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                           se7343_defconfig    gcc-14.1.0
sh                           se7722_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241103    gcc-14.1.0
sparc64               randconfig-002-20241103    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241103    gcc-14.1.0
um                    randconfig-002-20241103    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241103    gcc-14.1.0
xtensa                randconfig-002-20241103    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

