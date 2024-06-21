Return-Path: <linux-kernel+bounces-224540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE1F9123C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D841F23E90
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFDA172799;
	Fri, 21 Jun 2024 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UnuqdNdb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5687CEBE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969764; cv=none; b=Iv7CgumeCLotK+H9CjWI4b2CwOGWv9lyv+oKD6QqryXc9wpN7xgDy6nb3wwhu4fZ29OlOnazfOYyKvM6AxwlyZykRCZaJ8XKTOMq/8qH977pCu6dSsKIT1OKgG1sKynDEJA863rS33bnKp1DPtdJ3MniwWunZVq5d96LUMA2R5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969764; c=relaxed/simple;
	bh=QIWBbFACcBOpo4A8JYgVDKy+AX6VxHZmp6Y6Np4d9gk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=golqqrtB50heHJm1cvcjSFh/i9UkHMHAwTRl0e2ltu+rFhsquytPHI1Mhr6eNIQF54Bkute9GlN6/cqyOXqvjg8+jzssAi9SvL+wujY4Nr1U0fd5z7skBbZ54WKhUo6TlkbtCQ12b9/gCbvcoDQZAOTVGc0dehisKmceUD4rVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UnuqdNdb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718969762; x=1750505762;
  h=date:from:to:cc:subject:message-id;
  bh=QIWBbFACcBOpo4A8JYgVDKy+AX6VxHZmp6Y6Np4d9gk=;
  b=UnuqdNdbsPE6ZBbCOKJ70WHSmEsO8ez1AVDNtn5SRWjuS2eli9gYUD+1
   xLeKvpPcW5+vNCD7B5ShssDeT1tNiptU6BkUMqdN6tBgnBCXKk5ez5Lmq
   a3wsjinIlyJZ4g02j7WNrVi1MXsY7H/wVn/GVBMapmLP9nEN/5VLEyGP2
   CgFizSb5EEub2BV0ngzQ3/TO0v4V+0gOE9QQMKxAmk6SIKfrVT7SPkECF
   o+urNpXlm8zOCnZy9YTy0aPhkJuPSNNl7i37fP/VFRFBYxPRIQjQs5NUR
   4Uedf/THnJd/WDw6WrVdy7GGY48mTb/O8HeXPhZby1mw+umt0P6OdARi4
   g==;
X-CSE-ConnectionGUID: 9HPunzCPSAmLJq3lVzjPpw==
X-CSE-MsgGUID: LP7QNpWqSb+XhlV7eReiQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15754907"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="15754907"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 04:36:02 -0700
X-CSE-ConnectionGUID: gNdiJfbmT7CYlnMt/TW3RA==
X-CSE-MsgGUID: 9XPO57TRTZaWUtYbee1+1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="73312012"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Jun 2024 04:36:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKcYg-0008VI-1Z;
	Fri, 21 Jun 2024 11:35:58 +0000
Date: Fri, 21 Jun 2024 19:35:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 739c9765793e5794578a64aab293c58607f1826a
Message-ID: <202406211937.nbtXjAe8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 739c9765793e5794578a64aab293c58607f1826a  x86/resctrl: Don't try to free nonexistent RMIDs

elapsed time: 2975m

configs tested: 115
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20240620   gcc-13.2.0
arc                   randconfig-002-20240620   gcc-13.2.0
arm                              alldefconfig   gcc-13.2.0
arm                           omap1_defconfig   gcc-13.2.0
arm                   randconfig-001-20240620   gcc-13.2.0
arm                   randconfig-002-20240620   clang-19
arm                   randconfig-003-20240620   gcc-13.2.0
arm                   randconfig-004-20240620   gcc-13.2.0
arm                           spitz_defconfig   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240620   gcc-13.2.0
arm64                 randconfig-002-20240620   gcc-13.2.0
arm64                 randconfig-003-20240620   gcc-13.2.0
arm64                 randconfig-004-20240620   clang-19
csky                  randconfig-001-20240620   gcc-13.2.0
csky                  randconfig-002-20240620   gcc-13.2.0
hexagon               randconfig-001-20240620   clang-19
hexagon               randconfig-002-20240620   clang-19
i386         buildonly-randconfig-001-20240620   gcc-13
i386         buildonly-randconfig-002-20240620   clang-18
i386         buildonly-randconfig-003-20240620   gcc-13
i386         buildonly-randconfig-004-20240620   gcc-10
i386         buildonly-randconfig-005-20240620   gcc-13
i386         buildonly-randconfig-006-20240620   clang-18
i386                  randconfig-001-20240620   clang-18
i386                  randconfig-002-20240620   clang-18
i386                  randconfig-003-20240620   gcc-13
i386                  randconfig-004-20240620   gcc-10
i386                  randconfig-005-20240620   clang-18
i386                  randconfig-006-20240620   gcc-10
i386                  randconfig-011-20240620   gcc-7
i386                  randconfig-012-20240620   clang-18
i386                  randconfig-013-20240620   clang-18
i386                  randconfig-014-20240620   gcc-7
i386                  randconfig-015-20240620   clang-18
i386                  randconfig-016-20240620   clang-18
loongarch             randconfig-001-20240620   gcc-13.2.0
loongarch             randconfig-002-20240620   gcc-13.2.0
m68k                           virt_defconfig   gcc-13.2.0
mips                         bigsur_defconfig   gcc-13.2.0
nios2                 randconfig-001-20240620   gcc-13.2.0
nios2                 randconfig-002-20240620   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240620   gcc-13.2.0
parisc                randconfig-002-20240620   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240620   gcc-13.2.0
powerpc               randconfig-002-20240620   gcc-13.2.0
powerpc               randconfig-003-20240620   clang-17
powerpc                  storcenter_defconfig   gcc-13.2.0
powerpc                      tqm8xx_defconfig   clang-19
powerpc64             randconfig-001-20240620   gcc-13.2.0
powerpc64             randconfig-002-20240620   gcc-13.2.0
powerpc64             randconfig-003-20240620   clang-17
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240620   clang-19
riscv                 randconfig-002-20240620   clang-14
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240620   gcc-13.2.0
s390                  randconfig-002-20240620   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                ecovec24-romimage_defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240620   gcc-13.2.0
sh                    randconfig-002-20240620   gcc-13.2.0
sh                           se7750_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240620   gcc-13.2.0
sparc64               randconfig-002-20240620   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240620   clang-19
um                    randconfig-002-20240620   gcc-13
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240620   clang-18
x86_64       buildonly-randconfig-002-20240620   gcc-10
x86_64       buildonly-randconfig-003-20240620   clang-18
x86_64       buildonly-randconfig-004-20240620   gcc-13
x86_64       buildonly-randconfig-005-20240620   clang-18
x86_64       buildonly-randconfig-006-20240620   gcc-13
x86_64                randconfig-001-20240620   clang-18
x86_64                randconfig-002-20240620   gcc-13
x86_64                randconfig-003-20240620   clang-18
x86_64                randconfig-004-20240620   clang-18
x86_64                randconfig-005-20240620   gcc-11
x86_64                randconfig-006-20240620   clang-18
x86_64                randconfig-011-20240620   gcc-13
x86_64                randconfig-012-20240620   gcc-13
x86_64                randconfig-013-20240620   gcc-13
x86_64                randconfig-014-20240620   gcc-13
x86_64                randconfig-015-20240620   clang-18
x86_64                randconfig-016-20240620   clang-18
x86_64                randconfig-071-20240620   gcc-13
x86_64                randconfig-072-20240620   gcc-13
x86_64                randconfig-073-20240620   gcc-13
x86_64                randconfig-074-20240620   clang-18
x86_64                randconfig-075-20240620   clang-18
x86_64                randconfig-076-20240620   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240620   gcc-13.2.0
xtensa                randconfig-002-20240620   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

