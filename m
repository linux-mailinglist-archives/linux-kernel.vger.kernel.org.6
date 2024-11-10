Return-Path: <linux-kernel+bounces-403098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C59C3102
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 07:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39086281C92
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 06:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB2614D29B;
	Sun, 10 Nov 2024 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFAKpkcy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9802E149C55
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731218739; cv=none; b=MSvULhuSMMsDKSakB69UGxPMMq5QVQWGY/5OAg1GjKYBYoi5YvcBpypjAS8DKkHehuX0lzKyc0VjJNnb7pbDK72coy+klU/W9NFD0p/2zRsiAB+FUncWVv7Ce3wHJNLUQfNdWmQL48jasBKYHMMS6675GB8ndZZlStyuJMCkvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731218739; c=relaxed/simple;
	bh=8xEa9vh8QniMbj2Z+VbMPP6wAMvCze4XRhDKcL6O4Dk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oYRzk/9kwNPGIfxv1b20IKQ4dwou5d33S3iLaLsSviOaH9Tc++oWF4i1l/a/7wSJIP5iYtDUFl4uLNl7sC55fRZmMmjv9qGqNqH3C3hLnPLh9bbaRwHoU66KZBABX+YHee9mk2KEl0KCu6XsC9qhuTTFKgRUOr+p230jgyuFgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFAKpkcy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731218737; x=1762754737;
  h=date:from:to:cc:subject:message-id;
  bh=8xEa9vh8QniMbj2Z+VbMPP6wAMvCze4XRhDKcL6O4Dk=;
  b=cFAKpkcyq74D2nbAEefV1awOFRtc0yKyxquO/J33V37Tp4RbS74cekUi
   D29xX39KX5queHy8fqq91OFP8pno2mU2V2Nxitxpq9opoSQlcD4lDEe7p
   CE7lvKvqLk8yHWLmbpykMbvgdtjc81gHuuxyzkK7UoevsSKHfOyj389FY
   Askti42nQ7KLimQQSs3kxQcHSoj/QKCqJQxxBaY2wACCf3at18+GqrX+t
   MkCQluFm9X6L2GIYCvx9yPmt9PSakiIhkHLAqpNLqDPyYTWYwlh9LHtOP
   Ljr9KL0Xsl6r/1vPwblstuuapJ9MVqLMkLh7b9fxg4o2+PGoUYoeFcj81
   Q==;
X-CSE-ConnectionGUID: 5AGrwzE6QYeoybd7MvshnQ==
X-CSE-MsgGUID: 75W7vHExQXK0zrzvTekkMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11251"; a="48570099"
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="48570099"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 22:05:33 -0800
X-CSE-ConnectionGUID: qVMS5KlmQp+gZ8QiwA05mQ==
X-CSE-MsgGUID: MFYOUvpGTymbAZmvHuOGGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="85969116"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Nov 2024 22:05:32 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tA14j-000tEG-2i;
	Sun, 10 Nov 2024 06:05:29 +0000
Date: Sun, 10 Nov 2024 14:05:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.11.08a] BUILD SUCCESS
 8e4ea75508099694510ddcfbbe3e766158ae2fd9
Message-ID: <202411101410.kqcSDTh9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.11.08a
branch HEAD: 8e4ea75508099694510ddcfbbe3e766158ae2fd9  squash! rcutorture: Collect CPU ID for decoration after changing reader type

elapsed time: 723m

configs tested: 213
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-20
arm                           h3600_defconfig    clang-15
arm                            hisi_defconfig    clang-15
arm                           imxrt_defconfig    clang-20
arm                          pxa910_defconfig    clang-20
arm                           sama5_defconfig    clang-20
arm                           sama7_defconfig    clang-15
arm                           spitz_defconfig    clang-15
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
i386                             alldefconfig    gcc-12
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241110    gcc-11
i386        buildonly-randconfig-002-20241110    gcc-11
i386        buildonly-randconfig-002-20241110    gcc-12
i386        buildonly-randconfig-003-20241110    clang-19
i386        buildonly-randconfig-003-20241110    gcc-11
i386        buildonly-randconfig-004-20241110    gcc-11
i386        buildonly-randconfig-005-20241110    gcc-11
i386        buildonly-randconfig-005-20241110    gcc-12
i386        buildonly-randconfig-006-20241110    gcc-11
i386        buildonly-randconfig-006-20241110    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241110    gcc-11
i386                  randconfig-001-20241110    gcc-12
i386                  randconfig-002-20241110    clang-19
i386                  randconfig-002-20241110    gcc-11
i386                  randconfig-003-20241110    gcc-11
i386                  randconfig-003-20241110    gcc-12
i386                  randconfig-004-20241110    clang-19
i386                  randconfig-004-20241110    gcc-11
i386                  randconfig-005-20241110    gcc-11
i386                  randconfig-005-20241110    gcc-12
i386                  randconfig-006-20241110    gcc-11
i386                  randconfig-006-20241110    gcc-12
i386                  randconfig-011-20241110    clang-19
i386                  randconfig-011-20241110    gcc-11
i386                  randconfig-012-20241110    gcc-11
i386                  randconfig-012-20241110    gcc-12
i386                  randconfig-013-20241110    gcc-11
i386                  randconfig-013-20241110    gcc-12
i386                  randconfig-014-20241110    gcc-11
i386                  randconfig-014-20241110    gcc-12
i386                  randconfig-015-20241110    gcc-11
i386                  randconfig-015-20241110    gcc-12
i386                  randconfig-016-20241110    clang-19
i386                  randconfig-016-20241110    gcc-11
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    clang-15
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                           sun3_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-15
mips                         db1xxx_defconfig    clang-15
mips                           ip22_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    clang-20
mips                          rb532_defconfig    clang-20
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.2.0
openrisc                       virt_defconfig    clang-20
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-20
powerpc                       ebony_defconfig    clang-15
powerpc                       eiger_defconfig    clang-15
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    clang-15
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                   lite5200b_defconfig    clang-15
powerpc                    mvme5100_defconfig    clang-15
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     taishan_defconfig    clang-20
powerpc                     tqm8555_defconfig    clang-15
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
riscv                            alldefconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    clang-20
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    clang-15
sh                          rsk7201_defconfig    clang-15
sh                          rsk7264_defconfig    clang-20
sh                          rsk7264_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                              ul2_defconfig    clang-15
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241110    clang-19
x86_64      buildonly-randconfig-001-20241110    gcc-12
x86_64      buildonly-randconfig-002-20241110    gcc-12
x86_64      buildonly-randconfig-003-20241110    clang-19
x86_64      buildonly-randconfig-003-20241110    gcc-12
x86_64      buildonly-randconfig-004-20241110    gcc-12
x86_64      buildonly-randconfig-005-20241110    gcc-12
x86_64      buildonly-randconfig-006-20241110    clang-19
x86_64      buildonly-randconfig-006-20241110    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241110    gcc-12
x86_64                randconfig-002-20241110    clang-19
x86_64                randconfig-002-20241110    gcc-12
x86_64                randconfig-003-20241110    gcc-12
x86_64                randconfig-004-20241110    gcc-12
x86_64                randconfig-005-20241110    clang-19
x86_64                randconfig-005-20241110    gcc-12
x86_64                randconfig-006-20241110    clang-19
x86_64                randconfig-006-20241110    gcc-12
x86_64                randconfig-011-20241110    gcc-12
x86_64                randconfig-012-20241110    gcc-12
x86_64                randconfig-013-20241110    gcc-12
x86_64                randconfig-014-20241110    clang-19
x86_64                randconfig-014-20241110    gcc-12
x86_64                randconfig-015-20241110    gcc-12
x86_64                randconfig-016-20241110    gcc-12
x86_64                randconfig-071-20241110    clang-19
x86_64                randconfig-071-20241110    gcc-12
x86_64                randconfig-072-20241110    gcc-12
x86_64                randconfig-073-20241110    gcc-12
x86_64                randconfig-074-20241110    gcc-12
x86_64                randconfig-075-20241110    gcc-11
x86_64                randconfig-075-20241110    gcc-12
x86_64                randconfig-076-20241110    clang-19
x86_64                randconfig-076-20241110    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    clang-20
xtensa                          iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

