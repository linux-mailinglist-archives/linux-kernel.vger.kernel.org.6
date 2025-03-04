Return-Path: <linux-kernel+bounces-545683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A330A4F01B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A943A390F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C051FDA89;
	Tue,  4 Mar 2025 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V289Cvml"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936273597E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126962; cv=none; b=qswGUUIIQLl4KgimoRUM66kQvTNVAjipDgyx7FDPpygcCZystjSwY+jhXVxA0L+xjoEtj/Uhl1dd4gbastI2Fk4QqUEEKtQz2Ahm0MaErEtDFr8bS4ethxkH2nMr8ITvfAX3MLnHruoOH+URw4d+93huzPt6nv/Y2k7PfkW8M34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126962; c=relaxed/simple;
	bh=CH50hngFXruecHpARlqTZLlHe/osf/Sh5ryXHssfkXc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ichGmxv7Ay0RtmJhINFJUXDdJuqoEeqs8qCajhUZadIol5ru4aiYpVr0lC/2slb8UHIKcUEHUgAtdmRuOixdnHA0wnjmuLnICjkl6ZQ1ECI1t3Yd+kw/JEJMKj7zgwptH+dj9zWYFENcX+tN5SiHgpd24wt7XvxljZArBC/AaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V289Cvml; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741126961; x=1772662961;
  h=date:from:to:cc:subject:message-id;
  bh=CH50hngFXruecHpARlqTZLlHe/osf/Sh5ryXHssfkXc=;
  b=V289CvmltZ9ebofRdR6T/+z+u4M8qOWuGprbF94CH3ha6dThhYdGN2kc
   DuE/HNm1fTx/D0st6gT20sQHIBFjUU9c/P09doGPVNEKK8KGciVRMp22k
   rHFvlPpBNmYa92eTxoK73Z+/yVO9QWNl+cDDeTBhYJdkLn+NQncvQAsbu
   JgyFBP2wf2rIUIdcEurGYkZ5dI/YZvNSYx5eUPz3cVxQEK1BXJy6heJaR
   GtIArqIQwR5shgmbpxoQW8RzFNDH5B3EBX5HwuEAWLF8HKpH3PJxbpUnD
   xhkTog0Q55Iin+bAnMQlVAH7PW38mosDf/Qf3YNKD3Ebc8O0VUBDTKoQ/
   w==;
X-CSE-ConnectionGUID: PFtNy1FPQx2bLqsc1jSBcA==
X-CSE-MsgGUID: gQnk4Vb+S3Gteu4BaYjaew==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42198934"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="42198934"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 14:22:40 -0800
X-CSE-ConnectionGUID: 0zIhViTPSEinPIRr9GiFBg==
X-CSE-MsgGUID: sCDJXQy3SGmd1Bq3qsBXzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="119186142"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 04 Mar 2025 14:22:39 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpaeq-000KJi-2l;
	Tue, 04 Mar 2025 22:22:36 +0000
Date: Wed, 05 Mar 2025 06:21:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 01499ae673dc66cf5e98589648848b520f6fdfe9
Message-ID: <202503050634.KiZg4SN4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 01499ae673dc66cf5e98589648848b520f6fdfe9  genirq/msi: Expose MSI message data in debugfs

elapsed time: 1454m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-13.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250304    gcc-13.2.0
arc                   randconfig-002-20250304    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-15
arm                          pxa3xx_defconfig    clang-21
arm                   randconfig-001-20250304    clang-21
arm                   randconfig-002-20250304    gcc-14.2.0
arm                   randconfig-003-20250304    clang-21
arm                   randconfig-004-20250304    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250304    clang-21
arm64                 randconfig-002-20250304    gcc-14.2.0
arm64                 randconfig-003-20250304    gcc-14.2.0
arm64                 randconfig-004-20250304    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250304    gcc-14.2.0
csky                  randconfig-002-20250304    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250304    clang-21
hexagon               randconfig-002-20250304    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250304    clang-19
i386        buildonly-randconfig-002-20250304    clang-19
i386        buildonly-randconfig-003-20250304    gcc-12
i386        buildonly-randconfig-004-20250304    gcc-11
i386        buildonly-randconfig-005-20250304    gcc-11
i386        buildonly-randconfig-006-20250304    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250304    gcc-14.2.0
loongarch             randconfig-002-20250304    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250304    gcc-14.2.0
nios2                 randconfig-002-20250304    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250304    gcc-14.2.0
parisc                randconfig-002-20250304    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250304    gcc-14.2.0
powerpc               randconfig-002-20250304    gcc-14.2.0
powerpc               randconfig-003-20250304    clang-21
powerpc64             randconfig-001-20250304    gcc-14.2.0
powerpc64             randconfig-002-20250304    gcc-14.2.0
powerpc64             randconfig-003-20250304    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250304    gcc-14.2.0
riscv                 randconfig-002-20250304    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250304    clang-15
s390                  randconfig-002-20250304    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250304    gcc-14.2.0
sh                    randconfig-002-20250304    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250304    gcc-14.2.0
sparc                 randconfig-002-20250304    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250304    gcc-14.2.0
sparc64               randconfig-002-20250304    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250304    gcc-12
um                    randconfig-002-20250304    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250304    clang-19
x86_64      buildonly-randconfig-002-20250304    gcc-12
x86_64      buildonly-randconfig-003-20250304    gcc-12
x86_64      buildonly-randconfig-004-20250304    gcc-12
x86_64      buildonly-randconfig-005-20250304    gcc-12
x86_64      buildonly-randconfig-006-20250304    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250304    gcc-14.2.0
xtensa                randconfig-002-20250304    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

