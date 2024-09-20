Return-Path: <linux-kernel+bounces-334188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C1597D3AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168A6286D86
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0F13A26F;
	Fri, 20 Sep 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQudKUx8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F233981
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824823; cv=none; b=S/NBz4fNs9xuB2seBYaHqtFebFxVgJ0Iiwm370VYuvC5dMw1oWnt4We2v/yHA1DP35Z3g2+NApoc0Bqj2DOjJvUraOwL2PlKV3gbSvuN5T8zmtplUbiOg4WO2qoKwAKQU/dbIIXylFCvpOZB6Oqaf754vqTNpMN+O3M5HA3bAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824823; c=relaxed/simple;
	bh=M8xtpxZtx2GFbURHc0l4RiSTe5jknvfBktm6aEiClUk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dgpj9mJzXPatH9oF5CfhHPC6MHf5Nisizazg3oeu0UwAlzQ83uc17dhaY7ZXDej46VnxkItBU8myTiyHZvLNwLVbhjCrymNMr5RUuQiSZWoeS/kng7qq2ejGivvTjFLFhtZMQoNWPgQwTsEgHkRRkPlKQeKfFtBdZ+SSphQRhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQudKUx8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726824821; x=1758360821;
  h=date:from:to:cc:subject:message-id;
  bh=M8xtpxZtx2GFbURHc0l4RiSTe5jknvfBktm6aEiClUk=;
  b=jQudKUx8TyIFaX3LEc5yixQ4WYepZZA+mEAP6cZTBkBiOV1rt7TDy9FV
   65s4DTRPd29+IQJaFqyeFQOchP6GFVHDOD1OQE/Y1ZftAL9KbJjIv+ize
   yfYrhf8ebISrjy8WsXgPg5nThxBT1wdRPuvBZMLGNerdbgdRp46UcTkCB
   Mb0j/jBjobML0Ov8DYumVjSXdT9O2p6XLKl289/vc1mtrMlVKUZOOEK2d
   V8aHZup48smb0TE7rN2LLn5nD14YtXlFgtAlPBZs3pO9kiloSyOHF/16n
   s6bOGdU3jwzPV8k8FdK6c4wb8GMVQUBakiYFHnuHX5wazsrC7KbYM+a7Q
   A==;
X-CSE-ConnectionGUID: Bs9YT5RVQJiYImam5j00Yw==
X-CSE-MsgGUID: DId94ygpR9acid9NYupldg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25973289"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25973289"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 02:33:39 -0700
X-CSE-ConnectionGUID: Zjh4m86MQbipI1+HNX4CTg==
X-CSE-MsgGUID: 70JSYFyORKSShS5d1MyBsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="69829376"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Sep 2024 02:33:38 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sra19-000EEj-2w;
	Fri, 20 Sep 2024 09:33:35 +0000
Date: Fri, 20 Sep 2024 17:33:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:core/merge] BUILD SUCCESS
 adf04642e6250ed9504aa9877c7c31baec506005
Message-ID: <202409201721.2WmwUoPJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/merge
branch HEAD: adf04642e6250ed9504aa9877c7c31baec506005  Merge branch 'linus' into core/merge, to resolve conflicts

elapsed time: 2740m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20240920    gcc-13.2.0
arc                   randconfig-002-20240920    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                       aspeed_g5_defconfig    gcc-14.1.0
arm                   milbeaut_m10v_defconfig    clang-16
arm                             mxs_defconfig    clang-20
arm                   randconfig-001-20240920    gcc-14.1.0
arm                   randconfig-002-20240920    gcc-14.1.0
arm                   randconfig-003-20240920    gcc-14.1.0
arm                   randconfig-004-20240920    gcc-14.1.0
arm                             rpc_defconfig    clang-20
arm                           sama7_defconfig    clang-20
arm                          sp7021_defconfig    gcc-14.1.0
arm                       versatile_defconfig    gcc-14.1.0
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240920    gcc-14.1.0
arm64                 randconfig-002-20240920    clang-20
arm64                 randconfig-003-20240920    clang-20
arm64                 randconfig-004-20240920    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240920    gcc-14.1.0
csky                  randconfig-002-20240920    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20240920    clang-20
hexagon               randconfig-002-20240920    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240920    clang-18
i386        buildonly-randconfig-002-20240920    clang-18
i386        buildonly-randconfig-003-20240920    clang-18
i386        buildonly-randconfig-004-20240920    clang-18
i386        buildonly-randconfig-005-20240920    gcc-12
i386        buildonly-randconfig-006-20240920    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240920    gcc-12
i386                  randconfig-002-20240920    gcc-11
i386                  randconfig-003-20240920    clang-18
i386                  randconfig-004-20240920    gcc-12
i386                  randconfig-005-20240920    gcc-12
i386                  randconfig-006-20240920    clang-18
i386                  randconfig-011-20240920    clang-18
i386                  randconfig-012-20240920    clang-18
i386                  randconfig-013-20240920    clang-18
i386                  randconfig-014-20240920    clang-18
i386                  randconfig-015-20240920    gcc-12
i386                  randconfig-016-20240920    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240920    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                     cu1000-neo_defconfig    gcc-13.2.0
mips                     cu1830-neo_defconfig    gcc-13.2.0
mips                           ip27_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                           rhel-8.3-bpf    gcc-12
x86_64                         rhel-8.3-kunit    gcc-12
x86_64                           rhel-8.3-ltp    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

