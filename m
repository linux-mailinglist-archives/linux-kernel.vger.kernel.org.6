Return-Path: <linux-kernel+bounces-334295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0224B97D542
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C9128607C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E0414A636;
	Fri, 20 Sep 2024 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSnZPB/B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2D13B2B0
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726834189; cv=none; b=D3W6Glf5WWEBszR7+azesGGx9vI2nouScuc6+iChngdXdVL5O7mMTNfDr/qRF4ZyuxhvVgyXOKsQcM3ltR+LC2wV95B5+sVkBt4+6cYvVGYYxCsyNBiK62k8n8kboo0wKlF8gj9huX7XLrbZs/yg08EwqNncWw4sp+NvZikG63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726834189; c=relaxed/simple;
	bh=HZ2U0be74BeQDttiRXoCxaaVQTjZg6EV4xm22ubuqhY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=raA9N+3jm1cWg94oyfaUN4/4eHVgt0gUPBBsWn1cfpIWeWYtqqpvowMmUnh+tI9nW+JpD8+LE8eLZ7JDmGd62biTbuqslclCyVXUDO8VUR5LFUxkrJB/CVp4NLfcEV7Xx7BBwLuJAMy62XS266Z5k8GR7QXGBGpZVjiyqrT6KVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSnZPB/B; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726834188; x=1758370188;
  h=date:from:to:cc:subject:message-id;
  bh=HZ2U0be74BeQDttiRXoCxaaVQTjZg6EV4xm22ubuqhY=;
  b=WSnZPB/B75JwC8Spo4hhEmMM2bseGLlLigaF1ssfldEtO2FAJsNNVXyP
   wYnKyUTt5O2AOyzwugIYvvsxNfzrC3gHmso1kjXO7091xTx3vta0pPyDy
   RDjzjFyuXE0mOaGlUVF1CEZmxQ4yHde5HrGiuK1KWBaZO+dAMsdVzTRFU
   HhwuM5OkRT3LdF6BSUV0h4RQTCHWO/ZHHo8k4j/PnHM/z/IF5nXmEY7/6
   vqL+HzMp/a63fjVD4ojfh1IuWObrTNa3SoodFhljmiMFYKbK8reRyLiNK
   i7P3G0mMXmTkui8I+6v1aZYE9yasaZ1Vk+tODalFK4TBAcm6/XyvLLp+P
   A==;
X-CSE-ConnectionGUID: 5pbZBWfwQ1CWZabDrEmICA==
X-CSE-MsgGUID: ifQ5vxDzR5+ZPn985WNYmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25932275"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25932275"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 05:09:47 -0700
X-CSE-ConnectionGUID: qBXVbfIaTRKFdm/sVai6fg==
X-CSE-MsgGUID: 5i0j8XKbRdepGAbqQXCTPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75234130"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Sep 2024 05:09:47 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srcSG-000EM9-1a;
	Fri, 20 Sep 2024 12:09:44 +0000
Date: Fri, 20 Sep 2024 20:09:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6d3e8e28e20d250d2f3ebb3f5afb63848a2aebf9
Message-ID: <202409202036.KFPQWeCE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 6d3e8e28e20d250d2f3ebb3f5afb63848a2aebf9  Merge branch into tip/master: 'x86/splitlock'

elapsed time: 1613m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                     davinci_all_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                           allnoconfig    gcc-14.1.0
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20240920    gcc-12
i386        buildonly-randconfig-002-20240920    gcc-12
i386        buildonly-randconfig-003-20240920    gcc-12
i386        buildonly-randconfig-004-20240920    gcc-12
i386        buildonly-randconfig-005-20240920    gcc-12
i386        buildonly-randconfig-006-20240920    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240920    gcc-12
i386                  randconfig-002-20240920    gcc-12
i386                  randconfig-003-20240920    gcc-12
i386                  randconfig-004-20240920    gcc-12
i386                  randconfig-005-20240920    gcc-12
i386                  randconfig-006-20240920    gcc-12
i386                  randconfig-011-20240920    gcc-12
i386                  randconfig-012-20240920    gcc-12
i386                  randconfig-013-20240920    gcc-12
i386                  randconfig-014-20240920    gcc-12
i386                  randconfig-015-20240920    gcc-12
i386                  randconfig-016-20240920    gcc-12
loongarch                        alldefconfig    gcc-14.1.0
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                         db1xxx_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      katmai_defconfig    gcc-14.1.0
powerpc                       maple_defconfig    gcc-14.1.0
powerpc                   microwatt_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    gcc-14.1.0
sh                          rsk7201_defconfig    gcc-14.1.0
sh                          rsk7269_defconfig    gcc-14.1.0
sh                     sh7710voipgw_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                                allnoconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240920    gcc-12
x86_64      buildonly-randconfig-002-20240920    gcc-12
x86_64      buildonly-randconfig-003-20240920    gcc-12
x86_64      buildonly-randconfig-004-20240920    gcc-12
x86_64      buildonly-randconfig-005-20240920    gcc-12
x86_64      buildonly-randconfig-006-20240920    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240920    gcc-12
x86_64                randconfig-002-20240920    gcc-12
x86_64                randconfig-003-20240920    gcc-12
x86_64                randconfig-004-20240920    gcc-12
x86_64                randconfig-005-20240920    gcc-12
x86_64                randconfig-006-20240920    gcc-12
x86_64                randconfig-011-20240920    gcc-12
x86_64                randconfig-012-20240920    gcc-12
x86_64                randconfig-013-20240920    gcc-12
x86_64                randconfig-014-20240920    gcc-12
x86_64                randconfig-015-20240920    gcc-12
x86_64                randconfig-016-20240920    gcc-12
x86_64                randconfig-071-20240920    gcc-12
x86_64                randconfig-072-20240920    gcc-12
x86_64                randconfig-073-20240920    gcc-12
x86_64                randconfig-074-20240920    gcc-12
x86_64                randconfig-075-20240920    gcc-12
x86_64                randconfig-076-20240920    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                          iss_defconfig    gcc-14.1.0
xtensa                  nommu_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

